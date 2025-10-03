$fn=100;

module main_body(width, depth, height, diff, r) {
  rotate([90, 0, 0])
  linear_extrude(height=width, center=true)
  hull() {
    translate([depth/2-diff-r, height-r])
    circle(r=r);
      
    polygon([[depth/2, 0], [-depth/2, 0], [-depth/2, height]]);
  }
}

module out() {
  difference() {
    main_body(192, 128, 45, 4, 10);

    translate([0, 0, -0.001])
    main_body(186, 122, 37, 8, 0.01);

    translate([0, 0, -0.001])
    rotate([90, 0, 0])
    linear_extrude(height=200, center=true)
    polygon([[122/2-2, 7], [122/2, 0], [-122/2+4, 0], [-122/2+4, 7]]);
  }

  translate([-2, 80, 36])
  cube([120, 3, 3], center=true);
  translate([-2, -80, 36])
  cube([120, 3, 3], center=true);
  translate([-2, 30, 36])
  cube([120, 3, 3], center=true);
  translate([-2, -30, 36])
  cube([120, 3, 3], center=true);
}

module column() {
  translate([0, 0, 4.5])
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

    linear_extrude(height=3.8)
    circle(d=5.4);

    translate([15, 0, 0])
    linear_extrude(height=3.8)
    circle(d=5.4);
  }
}

module tank_body() {
  translate([57, 0, 41])
  minkowski() {
    cube([102, 172, 7], center=true);
    cylinder(h=1, r=2, center=true);
  }
  
  translate([57, 0, 20])
  minkowski() {
    cube([88, 158, 39], center=true);
    cylinder(h=1, r=5, center=true);
  }
}


difference() {
  union() {
    translate([64, 0, 0])
    out();

    translate([48.5, 90, 0])
    column();
    translate([55.5, 81, 26])
    cube([5, 10, 38], center=true);

    translate([48.5, -90, 0])
    column();
    translate([55.5, -81, 26])
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
    translate([2, -0.7, 0])
    cube([3.5, 1.4, 4.4]);
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
