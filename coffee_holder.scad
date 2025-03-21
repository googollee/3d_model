$fn=50;

translate([-38, 43, 0])
linear_extrude(height = 10)
difference() {
  circle(d=69, $fn=200);
  circle(d=60, $fn=200);
}

translate([-5, 45, 0])
cube([14, 5, 10]);

translate([39, 41, -3])
linear_extrude(height = 13)
difference() {
  circle(d=69, $fn=200);
  circle(d=60, $fn=200);
}

translate([35, 0, 0])
union() {
  difference() {
    translate([0, 2, 0])
    linear_extrude(height = 20)
    square([160, 17], center=true);

    translate([45, 0, -0.5])
    linear_extrude(height = 21, scale=[0.85,1])
    square([60, 3], center=true);
  }
}

translate([83, 55, 0])
difference() {
  union() {
    linear_extrude(height=45)
    difference() {
      circle(d=25);
      circle(d=15);
    }

    translate([0, 0, 44.99])
    difference() {
      linear_extrude(height=15)
      circle(d=25);

      translate([0, 0, 5])
      cylinder(h=20, r1=10, r2=4, center=true);
    }
  }

  rotate(v=[0,0,1], a=90)
  translate([0, -2.5, 0])
  cube([25, 5, 35]);

  rotate(v=[0,0,1], a=90)
  translate([0, -5, 10])
  cube([25, 10, 35]);

  rotate(v=[0,0,1], a=0)
  translate([0, -5, 10])
  cube([25, 10, 35]);

  rotate(v=[0,0,1], a=180)
  translate([0, -5, 10])
  cube([25, 10, 35]);

  rotate(v=[0,0,1], a=270)
  translate([0, -5, 10])
  cube([25, 10, 35]);
}

translate([97, 26, 15])
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

include <./ikea_skadis_hookup.scad.fn>
translate([15, -8, 0])
hooker();

translate([-25, -8, 0])
hooker();

translate([55, -8, 0])
hooker();

translate([95, -8, 0])
hooker();
