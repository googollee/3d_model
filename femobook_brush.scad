$fn=50;

difference() {
  translate([1.25, 0, 0])
  cube([36.5, 5.8, 6], center=true);

  translate([0, 0, -1.5])
  linear_extrude(height=5, scale=[1.05, 1])
  square([13.5, 7], center=true);

  translate([-11, 0, 2.25])
  cylinder(h=2.5, d=3.5, center=true);

  translate([10.5, 0, 2.25])
  cylinder(h=2.5, d=3.5, center=true);

  translate([18, 0, 3.4])
  rotate([0, 17, 0])
  cube([10, 7, 3.5], center=true);

  translate([16.5, -1, 2])
  rotate([0, 0, -3])
  cube([5, 1, 7], center=true);

  translate([18, 1, -1])
  cube([7, 1, 3], center=true);

  translate([-16, 0, 0])
  cube([5, 1, 4], center=true);
}