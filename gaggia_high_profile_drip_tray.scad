$fn=100;

module main_body() {
  rotate([90, 0, 0])
  linear_extrude(height=192, center=true)
  hull() {
    translate([125/2-10, 45-10])
    circle(r=10);
      
    polygon([[130/2, 0], [-130/2, 0], [-130/2, 45]]);
  }
}

module out() {
  difference() {
    main_body();

    translate([0, 0, -0.5])
    scale([0.96, 0.97, 0.96])
    main_body();

    translate([0, 0, -1])
    scale([0.92, 1.1, 0.92])
    main_body();

    translate([57, 0, 0])
    rotate([0, -20, 0])
    translate([0, 0, 5])
    cube([10, 192, 20], center=true);
  }
}

module column() {
  translate([0, 0, 5])
  difference() {
    linear_extrude(height=40)
    hull() {
      translate([15, 0, 0])
      circle(r=6);
      circle(r=6);
    }

    translate([0, 0, -0.1])
    linear_extrude(height=4.1)
    circle(r=5);
    
    translate([15, 0, -0.1])
    linear_extrude(height=4.1)
    circle(r=5);
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
    translate([65, 0, 0])
    out();

    translate([44, 90, 0])
    column();
    translate([44, -90, 0])
    column();

    tank_body();
  }
    
  translate([2.8, 0, 2])
  scale([0.95, 0.97, 1])
  tank_body();
}