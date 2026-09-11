$fn=100;
dosing_cup_outter = 60;
filter_basket_inner = 58.5;
thickness = 10;

translate([dosing_cup_outter+thickness+2, 0, 0])
union() {
  outter=dosing_cup_outter+thickness;
  inner=filter_basket_inner-1;
  thick=(outter-inner)/2;

  linear_extrude(height=5)
  difference() {
    circle(d=outter);
    circle(d=inner);
  }
  
  for (i=[0:120:360]) {
    rotate([0, 0, i+60])
    translate([inner/2+thick/2, 0, 6])
    cylinder(d=2.6, h=3, center=true);
  }
}

difference() {
  outter=dosing_cup_outter+thickness;
  inner=filter_basket_inner-1;
  thick=(outter-inner)/2;

  linear_extrude(height=5)
  difference() {
    circle(d=outter);
    circle(d=inner);
  }
  
  for (i=[0:120:360]) {
    rotate([0, 0, i+60])
    translate([inner/2+thick/2, 0, 1.49])
    cylinder(d=3, h=3, center=true);
  }
}

linear_extrude(height=13)
difference() {
  outter=filter_basket_inner;
  inner=filter_basket_inner-1;

  circle(d=outter);
  circle(d=inner);
}

difference() {
  width=2;
  height=3;

  for (i=[0:120:360]) {
    rotate([0, 0, i])
    translate([filter_basket_inner/4, 0, width/1.414])
    union() {
      rotate([45, 0, 0])
      cube([filter_basket_inner/2, width, width], center=true);

      translate([0, 0, height/2])
      cube([filter_basket_inner/2, width*1.414, height], center=true);
    }
  }

  for (i=[0:1:9]) {
    rotate([0, 0, i*120])
    translate([i*filter_basket_inner/19+2, 0, height])
    cylinder(d=1.2, h=height, center=true);
  }
}
