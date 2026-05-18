$fn=200;
inner=61;
bottom_outer=71;

difference(){

  union() {
    difference() {
      cylinder(h=10, d=83);
      translate([0, 0, -1])
      cylinder(h=6, d=80);
    }

    cylinder(h=5, d=bottom_outer);

    for (a = [0: 22.5: 360]) {
      rotate([0, 0, a])
      translate([0, 0, 5])
      cube([5, 82, 2], center=true);
    }
  }

  translate([0, 0, -1])
  cylinder(h=14, d=inner);

  for (a = [0: 45: 360]) {
    rotate([0, 0, a])
    translate([(bottom_outer-inner)/4+inner/2, 0, -0.5])
    cylinder(h=3, d=3.4);
  }

  translate([0, 0, 10-3])
  cylinder(h=10, d=bottom_outer);
}

translate([70, 0, 0])
cylinder(h=25, d=10);

translate([56, 0, 5])
cube([30, 6, 10], center=true);