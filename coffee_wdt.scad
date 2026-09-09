$fn=100;
outter = 78;
inner = 60;
coffee_filter_basket = 58.5;

difference() {
  outter=inner+5;
  inner=coffee_filter_basket-1;
  thick=(outter-inner)/2;

  linear_extrude(height=5)
  difference() {
    circle(d=outter);
    circle(d=inner);
  }
  
  for (i=[0:120:360]) {
    rotate([0, 0, i+60])
    translate([inner/2+thick/2, 0, 1.49])
    cylinder(d=2, h=3, center=true);
  }
}

linear_extrude(height=13)
difference() {
  outter=coffee_filter_basket-0.5;
  inner=coffee_filter_basket-1;

  circle(d=outter);
  circle(d=inner);
}

difference() {
  width=2;
  height=3;

  for (i=[0:120:360]) {
    rotate([0, 0, i])
    translate([coffee_filter_basket/4, 0, width/1.414])
    union() {
      rotate([45, 0, 0])
      cube([coffee_filter_basket/2, width, width], center=true);

      translate([0, 0, height/2])
      cube([coffee_filter_basket/2, width*1.414, height], center=true);
    }
  }

  for (i=[0:1:9]) {
    rotate([0, 0, i*120])
    translate([i*coffee_filter_basket/19+2, 0, height])
    cylinder(d=0.9, h=height, center=true);
  }
}
