$fn=50;

include <./ikea_skadis_hookup.scad.fn>

translate([0, 5, 15])
cube([70, 10, 30], center = true);

translate([30, 9.999, 5])
branch(10, 70, 25);

translate([-30, 9.999, 5])
branch(10, 70, 25);

module branch(x, y, z) {
  translate([0, 0, 5])
  difference() {
    linear_extrude(height=z-5, scale=[1, 0])
    square([x, 2*y], center=true);

    translate([0, -y/2-1, z/2])
    cube([x+1, y+1, z+1], center=true);
  };

  translate([0, y/2, 2.501])
  cube([x, y, 5.001], center=true);

  translate([0, y-2.5, -2.499])
  cube([x, 5, 5], center=true);
};

translate([20, -1.8, 0])
hooker();

translate([-20, -1.8, 0])
hooker();