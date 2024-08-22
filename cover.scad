difference() {
  union() {
    translate([10, 10, 2.5])
    rotate(v=[1, 0, 0], a=90)
    linear_extrude(height = 20)
    circle(r=2.5, $fn=50);

    translate([13, 0, 0])
    linear_extrude(height=5)
    square([6, 20], center=true);
    
    translate([15.2, 15, 2.5])
    rotate(v=[1, 0, 0], a=90)
    linear_extrude(height=5.4)
    circle(r=2.5, $fn=50);

    translate([15.2, -9.6, 2.5])
    rotate(v=[1, 0, 0], a=90)
    linear_extrude(height=5.4)
    circle(r=2.5, $fn=50);

    translate([20, 0, 0])
    linear_extrude(height=5)
    square([10, 30], center=true);
  }

  translate([10, 10.4, 2.5])
  sphere(r=1.4, $fn=50);
  translate([10, -10.4, 2.5])
  sphere(r=1.4, $fn=50);
}

union() {
  translate([-45, 0, 0])
  linear_extrude(height = 5)
  square([90, 90], center=true);

  difference() {
    translate([4, 0, 0])
    linear_extrude(height = 5)
    square([12, 30.4], center=true);

    translate([8, 0, -1])
    linear_extrude(height = 7)
    circle(r=10.4, $fn=50);
  }

  translate([10, 15.2, 2.5])
  rotate(v=[1, 0, 0], a=90)
  linear_extrude(height = 4.9)
  circle(r=2.5, $fn=50);

  translate([10, -10.3, 2.5])
  rotate(v=[1, 0, 0], a=90)
  linear_extrude(height = 4.9)
  circle(r=2.5, $fn=50);

  translate([10, 10.3, 2.5])
  sphere(r=1.2, $fn=50);

  translate([10, -10.3, 2.5])
  sphere(r=1.2, $fn=50);
}
