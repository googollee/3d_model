$fn=50;

difference() {
    minkowski() {
        cube([20, 22, 1], center=true);
        rotate(a=90, v=[0, 1, 0])
        cylinder(r=2,h=1,center=true);
    }

    translate([0, 0, 5-0.5])
    cube([16, 30, 10], center=true);

    translate([0, 10, 0])
    cube([16, 6, 10], center=true);
}

translate([0, 10, 0.4])
rotate(a=90, v=[0, 1, 0])
cylinder(r=1.1, h=20, center=true);