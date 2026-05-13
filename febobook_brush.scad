$fn=50;

rotate([90, 0, 0])
difference() {
  translate([2, 0, 0])
  cube([34, 5, 6], center=true);

  translate([0, 0, -1])
  linear_extrude(height=5, scale=[1.1, 1])
  square([14, 6], center=true);

  translate([-10, 0, 3])
  cylinder(h=3, d=3, center=true);

  translate([11, 0, 3])
  cylinder(h=3, d=3, center=true);

  translate([19, 0, 2.75])
  rotate([0, 20, 0])
  cube([10, 6, 3], center=true);
}

max=1.6;
space=1;

translate([30, 0, 0])
cube([5, 6, 5], center=true);
for (diff=[-max:space:max]) {
  for (y=[-0.6:space:2.8]) {
    translate([21, y, diff])
    cube([15, 0.2, 0.2], center=true);
  }
}

translate([-30, 0, 0])
cube([5, 6, 5], center=true);
for (diff=[-max:space:max]) {
  for (y=[-2.8:space:2.8]) {
    translate([-21, y, diff])
    cube([15, 0.2, 0.2], center=true);
  }
}

translate([16.5, -10, 0])
cube([4.5, 6, 5], center=true);
for (diff=[-max:space:max]) {
  for (y=[14.6:space:18.8]) {
    translate([y, -4, diff])
    cube([0.2, 10, 0.2], center=true);
  }
}