$fn=50;

difference() {
  translate([2, 0, 0])
  cube([34, 5, 7], center=true);

  translate([0, 0, -2])
  linear_extrude(height=6, scale=[1.1, 1])
  square([14, 6], center=true);

  translate([-10, 0, 2.25])
  cylinder(h=2.5, d=3.4, center=true);

  translate([11, 0, 2.25])
  cylinder(h=2.5, d=3.4, center=true);

  translate([18, 0, 3.4])
  rotate([0, 20, 0])
  cube([10, 6, 3], center=true);

  translate([17, 0, 1])
  cube([5, 1, 7], center=true);

  translate([-15, 0, 0])
  cube([5, 1, 4], center=true);
}