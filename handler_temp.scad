difference() {
  cube([35, 30, 3], center=true);
  cube([25, 20, 4], center=true);
}

translate([15, 0, 3])
cube([5, 30, 3], center=true);

translate([-15, 0, 3])
cube([5, 30, 3], center=true);

translate([0, 0, 3])
cube([35, 5, 3], center=true);