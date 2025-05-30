$fn=50;
hole_d = 6;
distance = 40;
height = 5;
thickness = 1;

cube([distance*1.5, hole_d*2, thickness], center=true);

translate([distance/2, 0, height/2+thickness/2-0.1])
cylinder(h=height, d=hole_d, center=true);

translate([-distance/2, 0, height/2+thickness/2-0.1])
cylinder(h=height, d=hole_d, center=true);