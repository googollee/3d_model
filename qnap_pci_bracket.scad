module main() {
    difference() {
        square([20, 90], center=true);
        translate([-7, -40]) square([6.5,12], center=true);
        translate([8, -40]) square([5,12], center=true);
        translate([20/2-11, 90/2-3]) circle(1.3);
        polygon(points=[[20/2-6.5,90/2+0.1], [20/2+0.1, 90/2-10.5], [20/2+0.1,90/2+0.1]]);
    }
}

linear_extrude(height=1.5) main();

module hook() {
    translate([-20/2+1.5,10]) square([3,50], center=true);
}

linear_extrude(height=15) hook();