// Matter 配对二维码 + 手动配对码 测试模型
// 在底面（贴热床的那一面）凹刻 QR 码，QR 下方凹刻 11 位配对码。
// 从底部往上看时图案是正读的（内部已做 X 镜像）。
//
// 用法：修改文件末尾的 passcode / discriminator 等参数即可。
//   passcode      Matter setup passcode（"password"），1 ~ 99999998
//   discriminator Matter 12 位 discriminator（0 ~ 4095）

$fn = 32;

/* ---------- 测试模型 ---------- */
// 使用 Matter 官方示例值：passcode 20202021，discriminator 3840
// 手动配对码应为 3497-011-2332
matter_label_plate(passcode = 20202021, discriminator = 3840,
                   vid = 65521, pid = 32768);

echo(payload = matter_qr_payload(20202021, 3840, 65521, 32768));
echo(manual_code = matter_manual_code(20202021, 3840));

/* ---------- 通用位运算工具（OpenSCAD 没有位运算符） ---------- */

function sum(v) = v * [for (x = v) 1];
function concat_all(v) = [for (a = v) for (b = a) b];
function zeros(n) = [for (i = [0 : 151]) if (i < n) 0];
function bits_lsb(n, len) = [for (i = [0 : len - 1]) floor(n / pow(2, i)) % 2];
function bits_msb(n, len) = [for (i = [len - 1 : -1 : 0]) floor(n / pow(2, i)) % 2];
function xor_n(a, b, n) =
  [for (i = [0 : n - 1]) (floor(a / pow(2, i)) + floor(b / pow(2, i))) % 2]
  * [for (i = [0 : n - 1]) pow(2, i)];
function join(l, i = 0) = i >= len(l) ? "" : str(l[i], join(l, i + 1));
function pad_zero(n, w) = let(s = str(n)) len(s) >= w ? s : str(join([for (i = [1 : w - len(s)]) "0"]), s);

/* ---------- Matter：QR payload（Base38）与手动配对码 ---------- */

B38 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-.";

// 88 bit payload，字段按 LSB 在前拼接
function matter_payload_bits(passcode, disc, vid, pid, flow, rendezvous) =
  concat_all([
    bits_lsb(0, 3),          // version
    bits_lsb(vid, 16),
    bits_lsb(pid, 16),
    bits_lsb(flow, 2),       // commissioning flow
    bits_lsb(rendezvous, 8), // 发现方式：1=SoftAP 2=BLE 4=OnNetwork
    bits_lsb(disc, 12),
    bits_lsb(passcode, 27),
    bits_lsb(0, 4)           // padding
  ]);

function matter_payload_bytes(passcode, disc, vid, pid, flow, rendezvous) =
  let(b = matter_payload_bits(passcode, disc, vid, pid, flow, rendezvous))
  [for (k = [0 : 10]) [for (i = [0 : 7]) b[8 * k + i]] * [1, 2, 4, 8, 16, 32, 64, 128]];

// 把 v 编成 n 个 Base38 字符，低位在前
function b38_chunk(v, n) = join([for (i = [0 : n - 1]) B38[floor(v / pow(38, i)) % 38]]);

function matter_qr_payload(passcode, discriminator, vid = 0, pid = 0, flow = 0, rendezvous = 2) =
  assert(passcode >= 1 && passcode <= 99999998, "passcode 必须在 1 ~ 99999998")
  assert(discriminator >= 0 && discriminator <= 4095, "discriminator 必须在 0 ~ 4095")
  let(b = matter_payload_bytes(passcode, discriminator, vid, pid, flow, rendezvous))
  str("MT:",
      join([for (g = [0 : 2]) b38_chunk(b[3 * g] + b[3 * g + 1] * 256 + b[3 * g + 2] * 65536, 5)]),
      b38_chunk(b[9] + b[10] * 256, 4));

// Verhoeff 校验
VD = [[0,1,2,3,4,5,6,7,8,9],[1,2,3,4,0,6,7,8,9,5],[2,3,4,0,1,7,8,9,5,6],
      [3,4,0,1,2,8,9,5,6,7],[4,0,1,2,3,9,5,6,7,8],[5,9,8,7,6,0,4,3,2,1],
      [6,5,9,8,7,1,0,4,3,2],[7,6,5,9,8,2,1,0,4,3],[8,7,6,5,9,3,2,1,0,4],
      [9,8,7,6,5,4,3,2,1,0]];
VP = [[0,1,2,3,4,5,6,7,8,9],[1,5,7,6,2,8,3,0,9,4],[5,8,0,3,7,9,6,1,4,2],
      [8,9,1,6,0,4,3,5,2,7],[9,4,5,3,1,2,6,8,7,0],[4,2,8,6,5,7,3,9,0,1],
      [2,7,9,3,8,0,6,4,1,5],[7,0,4,6,9,1,3,2,5,8]];
VINV = [0,4,3,2,1,5,6,7,8,9];

function verhoeff_c(ds, i = 0, c = 0) =
  i >= len(ds) ? c
  : verhoeff_c(ds, i + 1, VD[c][VP[(i + 1) % 8][ds[len(ds) - 1 - i]]]);
function verhoeff_check(s) =
  VINV[verhoeff_c([for (i = [0 : len(s) - 1]) search(s[i], "0123456789")[0]])];

// 11 位手动配对码（标准流程，不含 VID/PID），返回不带分隔符的字符串
function matter_manual_code(passcode, discriminator) =
  let(sd = floor(discriminator / 256),                 // 4 位 short discriminator
      digits = str(floor(sd / 4),
                   pad_zero((sd % 4) * 16384 + passcode % 16384, 5),
                   pad_zero(floor(passcode / 16384), 4)))
  str(digits, verhoeff_check(digits));

// 4-3-4 分组，便于阅读
function matter_manual_code_pretty(code) =
  str(substr(code, 0, 4), "-", substr(code, 4, 3), "-", substr(code, 7, 4));
function substr(s, start, n) = join([for (i = [start : start + n - 1]) s[i]]);

/* ---------- QR 编码：固定 Version 1 (21x21)、纠错等级 L、字母数字模式 ---------- */
// Matter payload 共 22 个字符（MT: + 19 位 Base38），Version 1-L 最多容纳 25 个。

QN = 21;
AN_TABLE = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:";

// GF(256) 表（本原多项式 0x11D）
function gf_exp_build(i, e, acc) =
  i >= 255 ? acc
  : gf_exp_build(i + 1, e * 2 >= 256 ? xor_n(e * 2, 285, 9) : e * 2, concat(acc, [e]));
GF_EXP = gf_exp_build(0, 1, []);
GF_LOG = [for (v = [0 : 255]) v == 0 ? 0 : search(v, GF_EXP)[0]];
function gf_mul(a, b) = (a == 0 || b == 0) ? 0 : GF_EXP[(GF_LOG[a] + GF_LOG[b]) % 255];

// 7 个纠错码字的生成多项式系数
RS_GEN = [127, 122, 154, 164, 11, 68, 117];
function rs_step(rem, d) =
  let(f = xor_n(d, rem[0], 8))
  [for (i = [0 : 6]) xor_n(i < 6 ? rem[i + 1] : 0, gf_mul(RS_GEN[i], f), 8)];
function rs_rem(data, i = 0, rem = [0, 0, 0, 0, 0, 0, 0]) =
  i >= len(data) ? rem : rs_rem(data, i + 1, rs_step(rem, data[i]));

function an_val(c) = search(c, AN_TABLE)[0];
function an_bits(s) = concat_all([
  for (i = [0 : 2 : len(s) - 1])
    i + 1 < len(s) ? bits_msb(45 * an_val(s[i]) + an_val(s[i + 1]), 11)
                   : bits_msb(an_val(s[i]), 6)
]);

// 19 个数据码字
function qr_data_cw(s) =
  let(b0 = concat_all([[0, 0, 1, 0], bits_msb(len(s), 9), an_bits(s)]))
  assert(len(b0) <= 152, "文本太长，Version 1-L 放不下")
  let(b1 = concat(b0, zeros(min(4, 152 - len(b0)))),
      b2 = concat(b1, zeros((8 - len(b1) % 8) % 8)),
      bytes = [for (k = [0 : len(b2) / 8 - 1])
                 [for (i = [0 : 7]) b2[8 * k + i]] * [128, 64, 32, 16, 8, 4, 2, 1]])
  concat(bytes, [for (i = [0 : 18]) if (i >= len(bytes)) (i - len(bytes)) % 2 == 0 ? 236 : 17]);

function qr_codeword_bits(s) =
  let(d = qr_data_cw(s))
  concat_all([for (c = concat(d, rs_rem(d))) bits_msb(c, 8)]);

// 功能图形区域（定位图形+分隔符+格式信息、定时线）
function is_func(r, c) =
  (r < 9 && c < 9) || (r < 9 && c >= 13) || (r >= 13 && c < 9) || r == 6 || c == 6;

// 数据模块的蛇形填充顺序，值为 r*QN + c
DATA_ORDER = [
  for (j = [0 : 9])
    let(cr = j < 7 ? 20 - 2 * j : 19 - 2 * j)
    for (t = [0 : 20]) for (dc = [0 : 1])
      let(r = j % 2 == 0 ? 20 - t : t, c = cr - dc)
      if (!is_func(r, c)) r * QN + c
];

// 纠错等级 L 的 15 位格式信息，下标为掩码编号
FMT_L = [30660, 29427, 32170, 30877, 26159, 25368, 27713, 26998];

function fmt_idx(r, c) =
  c == 8 && r <= 5 ? r
  : c == 8 && r == 7 ? 6
  : r == 8 && c == 8 ? 7
  : r == 8 && c == 7 ? 8
  : r == 8 && c <= 5 ? 14 - c
  : r == 8 && c >= 13 ? 20 - c
  : c == 8 && r >= 14 ? r - 6
  : -1;

function finder_dark(r, c) =
  r == 0 || r == 6 || c == 0 || c == 6 || (r >= 2 && r <= 4 && c >= 2 && c <= 4);

function mask_flip(m, r, c) =
  (m == 0 ? (r + c) % 2
 : m == 1 ? r % 2
 : m == 2 ? c % 3
 : m == 3 ? (r + c) % 3
 : m == 4 ? (floor(r / 2) + floor(c / 3)) % 2
 : m == 5 ? (r * c) % 2 + (r * c) % 3
 : m == 6 ? ((r * c) % 2 + (r * c) % 3) % 2
 :          ((r + c) % 2 + (r * c) % 3) % 2) == 0;

function qr_dark(bits, mask, r, c) =
  !is_func(r, c) ? (bits[search(r * QN + c, DATA_ORDER)[0]] == 1) != mask_flip(mask, r, c)
  : (r < 7 && c < 7) ? finder_dark(r, c)
  : (r < 7 && c >= 14) ? finder_dark(r, c - 14)
  : (r >= 14 && c < 7) ? finder_dark(r - 14, c)
  : fmt_idx(r, c) >= 0 ? floor(FMT_L[mask] / pow(2, fmt_idx(r, c))) % 2 == 1
  : (r == 13 && c == 8) ? true
  : (r == 6 && c >= 8 && c <= 12) ? c % 2 == 0
  : (c == 6 && r >= 8 && r <= 12) ? r % 2 == 0
  : false;

// 返回 21x21 的 0/1 矩阵，matrix[行][列]，行 0 在最上
// mask 为掩码编号（0~7，任意一个都是合法的 QR 码）
function qr_matrix(text, mask = 0) =
  let(bits = qr_codeword_bits(text))
  [for (r = [0 : QN - 1]) [for (c = [0 : QN - 1]) qr_dark(bits, mask, r, c) ? 1 : 0]];

/* ---------- 几何 ---------- */

// 2D：深色模块，左下角为原点，m 为模块边长
module qr_2d(matrix, m = 1) {
  n = len(matrix);
  for (r = [0 : n - 1]) for (c = [0 : n - 1])
    if (matrix[r][c] == 1)
      translate([c * m, (n - 1 - r) * m]) square(m + 0.01);
}

// 七段数码管风格的数字，自己用矩形拼，不依赖系统字体。
// 左下角为原点，w×h 为字符框，t 为笔画宽度。段顺序 a b c d e f g：
//   a 上横  b 右上竖  c 右下竖  d 下横  e 左下竖  f 左上竖  g 中横
SEG7 = [[1,1,1,1,1,1,0], [0,1,1,0,0,0,0], [1,1,0,1,1,0,1], [1,1,1,1,0,0,1],
        [0,1,1,0,0,1,1], [1,0,1,1,0,1,1], [1,0,1,1,1,1,1], [1,1,1,0,0,0,0],
        [1,1,1,1,1,1,1], [1,1,1,1,0,1,1]];

module seg7_digit(d, w, h, t) {
  s = SEG7[d];
  half = (h + t) / 2;   // 单侧竖笔的高度，上下两段在中横处重叠
  if (s[0]) translate([0, h - t]) square([w, t]);
  if (s[1]) translate([w - t, (h - t) / 2]) square([t, half]);
  if (s[2]) translate([w - t, 0]) square([t, half]);
  if (s[3]) square([w, t]);
  if (s[4]) square([t, half]);
  if (s[5]) translate([0, (h - t) / 2]) square([t, half]);
  if (s[6]) translate([0, (h - t) / 2]) square([w, t]);
}

// 每个字符的前进距离：数字 w + sp，分隔符 "-" 用 dl + sp
function seg7_adv(c, w, dl, sp) = c == "-" ? dl + sp : w + sp;
function seg7_x(code, i, w, dl, sp) =
  i == 0 ? 0 : sum([for (j = [0 : i - 1]) seg7_adv(code[j], w, dl, sp)]);
function seg7_width(code, w, dl, sp) = seg7_x(code, len(code), w, dl, sp) - sp;

// 以原点为水平中心、垂直中心绘制一串数字（含 "-"）
module seg7_text(code, h, t, sp = 0.45) {
  w = 0.55 * h;       // 字符宽度
  dl = 0.4 * w;       // 分隔符长度
  total = seg7_width(code, w, dl, sp);
  translate([-total / 2, -h / 2])
    for (i = [0 : len(code) - 1]) {
      c = code[i];
      translate([seg7_x(code, i, w, dl, sp), 0])
        if (c == "-") translate([0, (h - t) / 2]) square([dl, t]);
        else seg7_digit(search(c, "0123456789")[0], w, h, t);
    }
}

// 2D：QR 居中于原点上方，配对码在其下方。可直接用于凹刻
// text_size 为数字高度，seg_t 为笔画宽度（建议 ≥ 0.7，即 2 条挤出线）
module matter_label_2d(passcode, discriminator, vid = 0, pid = 0, flow = 0,
                       rendezvous = 2, m = 1.2, text_size = 4, gap = 3, mask = 0,
                       seg_t = 0.7) {
  qr = qr_matrix(matter_qr_payload(passcode, discriminator, vid, pid, flow, rendezvous), mask);
  code = matter_manual_code_pretty(matter_manual_code(passcode, discriminator));
  w = len(qr) * m;

  translate([-w / 2, 0]) qr_2d(qr, m);
  translate([0, -gap - text_size / 2])
    seg7_text(code, text_size, seg_t);
}

// 3D：一块平板，图案凹刻在 z=0 的底面，从底部看是正读的。
// 单色打印机用换色实现黑白：按颜色拆成互不重叠的几块
//   z = 0 ~ depth                  白色整层，深色模块位置镂空（凹槽）
//   z = depth ~ depth + dark_t     黑色"岛"（只覆盖二维码区域）
//                                  + 白色外圈（外壳侧壁），两者之间留 iso_gap 的空隙
//   z = depth + dark_t ~ thickness 白色整层，盖住空隙
// 黑色岛与白色外圈在该层里是互相分离的两块，切片后黑色部分在 G-code 里是
// 一段连续的打印，只需在它前后各插入一次 M600（层高 0.2mm 时就是第 3 层）：
//   白色外圈 → M600 换黑 → 黑色岛 → M600 换白 → 下一层。
// 空隙在内部被上下白层封住，外面看不到；侧壁全程是白色，没有黑线。
// 打印面积会比二维码区域大 2 * (iso_gap + wall)，二维码和文字大小不变。
module matter_label_plate(passcode, discriminator, vid = 0, pid = 0, flow = 0,
                          rendezvous = 2, m = 1.5, text_size = 4, gap = 1,
                          mask = 0, thickness = 2, depth = 0.4, dark_t = 0.2,
                          margin = 3, iso_gap = 1.2, wall = 1.6) {
  assert(thickness > depth + dark_t, "thickness 必须大于 depth + dark_t");
  qr_w = QN * m;
  plate_w = qr_w + 2 * margin;
  plate_h = qr_w + gap + text_size + 2 * margin;
  ext = iso_gap + wall;   // 外壳比黑色岛每边多出的宽度
  // 内容 y 范围：[-gap-text_size, qr_w]；e 为相对黑色岛每边外扩的距离
  module slab(z0, z1, e = 0)
    translate([-plate_w / 2 - e, -gap - text_size - margin - e, z0])
      cube([plate_w + 2 * e, plate_h + 2 * e, z1 - z0]);

  echo(str("黑色层 z=", depth, "~", depth + dark_t, "mm：白色外圈打完后 M600 换黑打黑色岛，",
           "岛打完后 M600 换回白"));
  echo(str("外壳尺寸 ", plate_w + 2 * ext, " x ", plate_h + 2 * ext, " mm"));

  color("white") difference() {
    slab(0, depth, ext);
    translate([0, 0, -0.01])
      linear_extrude(depth + 0.02)
        mirror([1, 0, 0])   // 底面朝外，镜像后从下往上看才是正的
          matter_label_2d(passcode, discriminator, vid, pid, flow, rendezvous,
                          m, text_size, gap, mask);
  }
  color("black") slab(depth, depth + dark_t);
  color("white") difference() {
    slab(depth, depth + dark_t, ext);
    slab(depth - 0.01, depth + dark_t + 0.01, iso_gap);
  }
  color("white") slab(depth + dark_t, thickness, ext);
}
