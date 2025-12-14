length = 132;
height = 17;
thickness =3;
wide = 18;

difference() {
  cube([length+thickness*2, height+thickness*2, wide], center=true);
  
  cube([length, height, wide*thickness*2], center=true);
  translate([wide/2, thickness*2, 0])
  cube([length-wide, height, wide*thickness*2], center=true);
}