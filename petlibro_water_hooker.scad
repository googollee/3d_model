$fn=50;

difference() {
    minkowski() {
        cube([20, 22, 1], center=true);

        rotate(a=90, v=[0, 1, 0])
        cylinder(r=2,h=1,center=true);
    }

    translate([0, 0, 5-0.5])
    cube([16, 30, 10], center=true);

    translate([0, 8, 0])
    cube([16, 10, 10], center=true);
}

translate([0, 10, 0.4])
rotate(a=90, v=[0, 1, 0])
cylinder(r=1.1, h=20, center=true);

translate([0, -10.5, 5])
difference() {
    minkowski() {
        cube([20, 1, 11], center=true);
        
        rotate(a=90, v=[0, 1, 0])
        cylinder(r=2,h=1,center=true);
    }
    
    translate([0, 5, -5])
    cube([16, 10, 11], center=true);
}

translate([0, -8.5, 7])
minkowski() {
    cube([12, 1, 0.01], center=true);
    sphere(r=1);
}