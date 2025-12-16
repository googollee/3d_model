length = 135;
height = 18;
thickness = 3;
wide = 18;

difference() {
  cube([length+thickness*2, height+thickness*2, wide], center=true);
  
  cube([length, height, wide*thickness*2], center=true);
  translate([height/20, thickness*2, 0])
  cube([length-height/10, height, wide*thickness*2], center=true);
}

translate([(length+thickness)/2, (3*height)/2, 0])
cube([thickness, 3*height, wide], center=true);