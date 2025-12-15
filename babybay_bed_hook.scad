length = 132;
height = 17;
thickness =3;
wide = 18;

difference() {
  cube([length+thickness*2+0.2, height+thickness*2+0.2, wide], center=true);
  
  cube([length+0.2, height+0.2, wide*thickness*2], center=true);
  translate([height/6, thickness*2, 0])
  cube([length+0.2-height/3, height, wide*thickness*2], center=true);
}

translate([(length+thickness+0.2)/2, (3*height)/2, 0])
cube([thickness, 3*height, wide], center=true);