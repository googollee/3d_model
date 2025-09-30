$fn=100;

module column() {
  translate([0, 0, 4.5])
  difference() {
    union() {
      linear_extrude(height=5)
      circle(d=10);

      translate([15, 0, 0])
      linear_extrude(height=5)
      circle(d=10);

      translate([0, 0, 1])
      linear_extrude(height=4)
      hull() {
        circle(d=10);

        translate([15, 0, 0])
        circle(d=10);
      }
    }

    linear_extrude(height=3.8)
    circle(d=5.4);

    translate([15, 0, 0])
    linear_extrude(height=3.8)
    circle(d=5.4);
  }
}

column();

module support() {
  for (r = [0:30:360]) {
    rotate([0, 0, r])
    translate([2.5, -0.8, 0])
    cube([3, 1.6, 4.3]);
  }
}

support();
translate([15, 0, 0])
support();