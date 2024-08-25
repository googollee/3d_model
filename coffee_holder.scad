$fn=50;

translate([0, 37, 0])
linear_extrude(height = 10)
difference() {
  circle(d=69, $fn=200);
  circle(d=59, $fn=200);
}

translate([-4, 0, 0])
union() {
  difference() {
    linear_extrude(height = 20)
    square([70, 13], center=true);

    translate([0, 0, -0.5])
    linear_extrude(height = 21, scale=[0.85,1])
    square([60, 3], center=true);
  }
}

translate([-35, 14, 0])
difference() {
  union() {
    linear_extrude(height=50)
    difference() {
      circle(d=20);
      circle(d=10);
    }

    translate([0, 0, 50])
    difference() {
      linear_extrude(height=10)
      circle(d=20);

      translate([0, 0, 5])
      cylinder(h=12, r1=5.35, r2=0.8, center=true);
    }
  }

  rotate(v=[0,0,1], a=90)
  translate([0, -1.3, -1])
  cube([25, 2.6, 70]);
}

translate([43, 42, 0])
difference() {
  union() {
    linear_extrude(height=50)
    difference() {
      circle(d=25);
      circle(d=15);
    }

    translate([0, 0, 50])
    difference() {
      linear_extrude(height=10)
      circle(d=25);

      translate([0, 0, 5])
      cylinder(h=15, r1=8.7, r2=1.2, center=true);
    }
  }

  rotate(v=[0,0,1], a=90)
  translate([0, -2.5, -1])
  cube([25, 5, 70]);
}

translate([55, 13.5, 15])
union() {
  difference() {
    cube([50, 40, 30], center=true);
    cube([40, 30, 35], center=true);
    translate([23, 7.5, 0])
    cube([10, 15, 35], center=true);
  }

  translate([0, -10, 12.5])
  cube([50, 20, 5], center=true);
}

translate([20, -8, 0])
hooker();

translate([-20, -8, 0])
hooker();

translate([60, -8, 0])
hooker();

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
}