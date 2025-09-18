width = 134;
depth_pc = 129;
depth_air_duct = 50;
height = 30;
wall = 20;

translate([0, depth_air_duct/2+depth_pc/4, 1])
cube([width, depth_pc/2+depth_air_duct, 2], center=true);

translate([width/2-wall/2, (depth_pc+depth_air_duct)/2, height/2])
cube([wall, depth_air_duct, height], center=true);

translate([-(width/2-wall/2), (depth_pc+depth_air_duct)/2, height/2])
cube([wall, depth_air_duct, height], center=true);

translate([25, (depth_pc+depth_air_duct)/2, height/2])
cube([2, depth_air_duct, height], center=true);
translate([0, (depth_pc+depth_air_duct)/2, height/2])
cube([2, depth_air_duct, height], center=true);
translate([-25, (depth_pc+depth_air_duct)/2, height/2])
cube([2, depth_air_duct, height], center=true);

translate([0, (depth_pc+depth_air_duct)/2, height-1])
cube([130, depth_air_duct, 2], center=true);


difference() {
  union() {
    linear_extrude(height=height)
    minkowski() {
      square([width-20, depth_pc-20], center=true);
      circle(r=10);
    }

    translate([0, depth_pc/4, height/2])
    cube([width, depth_pc/2, height], center=true);
  }

  translate([0, 1, (height+10)/2+2])
  cube([width-40, depth_pc-2, height+10], center=true);

  translate([0, 0, (height+10)/2+2])
  cube([width-40, depth_pc-40, height+10], center=true);
  
  translate([0, 0, height-2])
  linear_extrude(height=2)
  minkowski() {
    square([width-4-20, depth_pc-4-20], center=true);
    circle(r=10);
  }
}