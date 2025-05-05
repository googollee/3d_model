$fn=60;

module half() {
polygon(
    [[0, 15-3.5], [7.6, 15], [15, 15], [14, 13], [27, 15-1.5], [27, 15], [35, 15], 
     [35, 0], [0, 0], [0, 4], [21, 4], [25, 12], [17, 11.7], [14, 8.5], [8, 8.5], [0, 10]]);
}

difference() {

union() {

rotate([0, 60, 0])
union() {
translate([-54.9, 0, 1.4])
linear_extrude(height=6.5)
union() {
    half();     
    mirror([0,1,0]) half();
}

translate([-10, 0, 0])
linear_extrude(height=10)
square([20, 42], center=true);
}

translate([30, 0, 0])
linear_extrude(height=10)
difference() {
    union() {
        circle(d=42);
        
        translate([-15, 0])
        square([30, 42], center=true);
    }

    circle(d=37.7);
}

}

translate([-15, 0, 25])
cube([60, 1, 60], center=true);
}