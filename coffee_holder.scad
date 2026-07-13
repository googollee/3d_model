$fn=50;

translate([-38, 43, 0])
linear_extrude(height = 10)
difference() {
  circle(d=69, $fn=200);
  circle(d=60, $fn=200);
}

translate([-5, 45, 0])
cube([14, 5, 10]);

translate([39, 41, 0])
linear_extrude(height = 10)
difference() {
  circle(d=69, $fn=200);
  circle(d=60, $fn=200);
  
  for (i=[45:90:360]) {
    rotate([0, 0, i])
    translate([32, 0, 0])
    circle(d=3, $fn=200);
  }
}

translate([0, -60, 0])
union() {
  linear_extrude(height = 5)
  difference() {
    circle(d=69, $fn=200);
    circle(d=60, $fn=200);
  }

  for (i=[45:90:360]) {
    rotate([0, 0, i])
    translate([32, 0, 1])
    linear_extrude(height = 5)
    circle(d=2.5, $fn=200);
  }
}

translate([35, 0, 0])
union() {
  difference() {
    union() {
      translate([0, 2, 0])
      linear_extrude(height = 30)
      square([169, 17], center=true);
      
      translate([-43, 0, 0])
      cube([17, 50, 30]);
    }

    translate([45, 0, -0.5])
    linear_extrude(height = 31, scale=[0.7,1])
    square([60, 3], center=true);

    translate([-35, 2, -0.5])
    linear_extrude(height = 31, scale=[0.7,1])
    square([60, 10], center=true);
  }
}

translate([83.5, 60, 0])
difference() {
  union() {
    linear_extrude(height=45)
    difference() {
      circle(d=35);
      circle(d=25);
    }

    translate([0, 0, 44.99])
    difference() {
      linear_extrude(height=15)
      circle(d=35);

      translate([0, 0, 7.5])
      cylinder(h=15, d1=25, d2=4, center=true);
    }
  }

  rotate(v=[0,0,1], a=90)
  translate([0, -2.5, 0])
  cube([25, 5, 60]);

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

translate([69.5, 5.5, 0])
union() {
  difference() {
    cube([50, 40, 25]);
    translate([5, 5, 0])
    cube([40, 30, 26]);
    translate([40, 20, 0])
    cube([10, 15, 26]);
  }

  translate([0, 0, 20])
  cube([50, 20, 5]);
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
