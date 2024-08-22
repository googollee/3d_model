union() {
  translate([11, 0, 0.5])
  cube([10, 40, 6], center=true);

  translate([3, 0, 0])
  Hook(20, 2.5);
}

union() {
  translate([-45, 0, 0])
  cube([90, 90, 5], center=true);

  translate([3, 0, 0])
  Bump(40.4, 20.4, 2.5);
}

module Hook(width, r) {
  difference() {
    union() {
      translate([r/2+1, 0, 0])
      cube([r+2, width, r*2], center=true);

      rotate(v=[1,0,0], a=90)
      cylinder(h=width, r=r, center=true, $fn=50);
    }

    translate([0, width/2, 0])
    sphere(r=r/2 + 0.1, $fn=50);

    translate([0, -width/2, 0])
    sphere(r=r/2 + 0.1, $fn=50);
  }
}

module Bump(y_out, y_inner, r) {
  union() {
    translate([-r/2-1, 0, 0])
    difference() {
      cube([r+2, y_out, r*2], center = true);
      cube([r+3, y_inner, r*2+1], center = true);
    }

    translate([0, (y_out+y_inner)/4, 0])
    rotate(v=[1,0,0], a=90)
    cylinder(h=(y_out-y_inner)/2, r=r, center=true, $fn=50);

    translate([0, -(y_out+y_inner)/4, 0])
    rotate(v=[1,0,0], a=90)
    cylinder(h=(y_out-y_inner)/2, r=r, center=true, $fn=50);

    translate([0, y_inner/2, 0])
    sphere(r=r/2 - 0.1, $fn=50);

    translate([0, -y_inner/2, 0])
    sphere(r=r/2 - 0.1, $fn=50);
  }
}