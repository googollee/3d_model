module half() {
polygon(
    [[0, 15-3.5], [7.6, 15], [15, 15], [14, 13], [27, 15-1.5], [27, 15], [35, 15], 
     [35, 0], [0, 0], [0, 4], [21, 4], [25, 12], [17, 11.7], [14, 8.5], [8, 8.5], [0, 10]]);
}

difference() {

union() {
linear_extrude(height=6)
union() {
    half();     
    mirror([0,1,0]) half();
}

translate([35, 0, 0])
rotate([0, -30, 0])
linear_extrude(height=6)
translate([37.5/2+10, 0, 0])
difference() {

union() {
    translate([-37.5/2, 0, 0])
    square([20, 30], center=true);
    circle(d=37.5);
}

circle(d=37.5 - 2);
}

}

translate([24, 0, 7])
cube([50, 0.2, 15], center=true);
}