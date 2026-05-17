$fn=200;

difference(){

  union() {
    difference() {
      cylinder(h=10, d=83);
      cylinder(h=3, d=80);
    }

    cylinder(h=3, d=71);

    for (a = [0: 20: 360]) {
      rotate([0, 0, a])
      translate([0, 0, 3])
      cube([5, 82, 2], center=true);
    }
  }

  cylinder(h=13, d=59);

  for (a = [0: 45: 360]) {
    rotate([0, 0, a])
    translate([66/2, 0, 0])
    cylinder(h=2.5, d=3.3);
  }

  translate([0, 0, 10-3])
  cylinder(h=5, d=71);
}

translate([70, 0, 0])
cylinder(h=25, d=10);

translate([56, 0, 5])
cube([30, 6, 10], center=true);