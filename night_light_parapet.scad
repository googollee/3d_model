rotate(90, [1,0,0])
minkowski(){
    difference(){    
    linear_extrude(height=25, center=true)
    difference() {
        square([65, 25], center=true);
        translate([0, 5]) square([55,25], center=true);
    };

    translate([0,0,15])
    rotate(-30, [1,0,0])
    linear_extrude(height=20, center=true)
    square([70,50], center=true);

    translate([0,0,-20])
    rotate(10, [1,0,0])
    linear_extrude(height=20, center=true)
    square([70, 50], center=true);
    };

    sphere(0.8);
}