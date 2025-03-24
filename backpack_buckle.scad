$fn=60;

module half() {
translate([-35, 0, 0])
polygon(
    [[0, 15-3.5], [7.6, 15], [15, 15], [14, 13], [27, 15-1.5], [27, 15], [35, 15], 
     [35, 0], [0, 0], [0, 4], [21, 4], [25, 11.5], [17, 11.2], [14, 8.5], [8, 8.5], [0, 10]]);

square([30, 5]);
translate([20, 0, 0])
square([10, 20]);
translate([5, 15, 0])
square([25, 10]);
}

linear_extrude(height=6)
union(){
half();

mirror([0, 1, 0])
half();
}