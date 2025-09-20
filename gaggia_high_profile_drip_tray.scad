$fn=100;

module main_body(thickness) {
  rotate([90, 0, 0])
  linear_extrude(height=thickness, center=true)
  hull() {
    translate([125/2-10, 45-10])
    circle(r=10);
      
    polygon([[130/2, 0], [-130/2, 0], [-130/2, 45]]);
  }
}

module out() {
  difference() {
    main_body(190);

    translate([0, 0, -0.5])
    scale([0.95, 0.96, 0.95])
    main_body(190);

    translate([0, 0, -1])
    scale([0.8, 1.1, 0.8])
    main_body(190);

    translate([57, 0, 0])
    rotate([0, -23.47, 0])
    translate([0, 0, 5])
    cube([10, 192, 52], center=true);
  }

  translate([0, 30, 0])
  main_body(3);

  translate([0, -30, 0])
  main_body(3);
}

module column() {
  translate([0, 0, 5])
  difference() {
    linear_extrude(height=40)
    hull() {
      translate([15, 0, 0])
      circle(d=10);
      circle(d=10);
    }

    translate([0, 0, -0.1])
    linear_extrude(height=4.1)
    circle(d=5);
    
    translate([15, 0, -0.1])
    linear_extrude(height=4.1)
    circle(d=5);
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

    translate([48, 90, 0])
    column();
    translate([55.5, 80, 25])
    cube([5, 10, 40], center=true);

    translate([48, -90, 0])
    column();
    translate([55.5, -80, 25])
    cube([5, 10, 40], center=true);

    tank_body();

    translate([63, 0, 40])
    cube([122, 190, 5.1], center=true);
  }
    
  translate([2.8, 0, 2])
  scale([0.95, 0.97, 1])
  tank_body();
}

  
translate([69.2, 90, 2.4])
cube([112, 20, 4.8], center=true);

translate([69.2, -90, 2.4])
cube([112, 20, 4.8], center=true);

