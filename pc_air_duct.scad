width = 130;
depth_pc = 125;
depth_air_duct = 50;
height = 30;
wall = 2;
column = 20;
round_r = 10;

total_width = width + wall*2;
total_depth = depth_pc + depth_air_duct + wall;

difference() {
cube([total_width, total_depth, height], center=true);

translate([0, wall/2+0.1, 0])
cube([total_width-column*2-wall*2, total_depth-wall+0.2, height-wall*2], center=true);

translate([0, -depth_air_duct/2+wall/2, height/2-wall-0.1])
linear_extrude(height=wall+0.2)
minkowski() {
square([width-round_r*2, depth_pc-round_r*2], center=true);
circle(r=round_r);
}
}

column_x = (total_width/2-column)/2;
translate([0, depth_pc/2+wall/2, 0])
cube([wall, depth_air_duct, height], center=true);
translate([column_x, depth_pc/2+wall/2, 0])
cube([wall, depth_air_duct, height], center=true);
translate([-column_x, depth_pc/2+wall/2, 0])
cube([wall, depth_air_duct, height], center=true);