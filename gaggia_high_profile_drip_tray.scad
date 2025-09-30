$fn=100;

module main_body(thickness) {
  rotate([90, 0, 0])
  linear_extrude(height=thickness, center=true)
  hull() {
    translate([128/2-6-10, 45-10])
    circle(r=10);
      
    polygon([[128/2, 0], [-128/2, 0], [-128/2, 45]]);
  }
}

module out() {
  difference() {
    main_body(190);

    translate([-6.55, 0, 18])
    cube([108.5, 186, 39], center=true);

    translate([62, 0, 0])
    rotate([0, 69, 0])
    translate([-20, 0, -10])
    cube([40, 186, 20], center=true);

    translate([61.2, 0, -0.1])
    rotate([90, 0, 0])
    linear_extrude(height=200, center=true)
    polygon([[0, 0], [-122, 0], [-122, 7], [-2, 7]]);
  }

  translate([0, 30, 0])
  main_body(3);

  translate([0, -30, 0])
  main_body(3);
}

module column() {
  translate([0, 0, 5])
  difference() {
    union() {
      linear_extrude(height=40)
      circle(d=10);

      translate([15, 0, 0])
      linear_extrude(height=40)
      circle(d=10);

      translate([0, 0, 1])
      linear_extrude(height=39)
      hull() {
        circle(d=10);

        translate([15, 0, 0])
        circle(d=10);
      }
    }

    linear_extrude(height=3.3)
    circle(d=5.4);

    translate([15, 0, 0])
    linear_extrude(height=3.3)
    circle(d=5.4);
  }
}

module tank_body() {
  translate([57, 0, 41])
  minkowski() {
    cube([100, 170, 6], center=true);
    cylinder(h=1, r=2, center=true);
  }
  
  translate([57, 0, 19.5])
  minkowski() {
    cube([72, 137, 38], center=true);
    cylinder(h=1, r=10, center=true);
  }
}


difference() {
  union() {
    translate([64, 0, 0])
    out();

    translate([48.5, 90, 0])
    column();
    translate([55.5, 80, 26])
    cube([5, 10, 38], center=true);

    translate([48.5, -90, 0])
    column();
    translate([55.5, -80, 26])
    cube([5, 10, 38], center=true);

    tank_body();
  }
    
  translate([2.8, 0, 2])
  scale([0.95, 0.97, 1])
  tank_body();

  translate([125, 0, 0])
  rotate([0, 90, 0])
  cylinder(h=10, r=15, center=true);
}

module support() {
  for (r = [0:30:360]) {
    rotate([0, 0, r])
    translate([2.5, -0.8, 0])
    cube([4, 1.6, 4.8]);
  }
}

translate([48.5, 90, 0])
support();
translate([48.5+15, 90, 0])
support();

translate([48.5, -90, 0])
support();
translate([48.5+15, -90, 0])
support();