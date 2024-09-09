module hooker() {
  minkowski() {
    union() {
      translate([0, 0, 2])
      linear_extrude(height=3)
      square([0.001, 10], center=true);

      translate([0, -4, 2])
      linear_extrude(height=9)
      square([0.001, 8], center=true);
    }

    rotate(v=[1,0,0], a=90)
    cylinder(r=2, h=0.001);
  }

  translate([0, -11, 0.2])
  cube([5, 5, 0.4], center=true);

  translate([0, -8, 0.1])
  cube([1, 5, 0.2], center=true);
}

// hooker();