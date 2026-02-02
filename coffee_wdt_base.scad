$fn=200;

difference(){

union() {

difference() {
cylinder(h=13, d=81);
cylinder(h=4, d=79);
}

cylinder(h=4, d=71);
}

cylinder(h=13, d=59);

for (a = [0: 60: 360]) {
    rotate([0, 0, a])
    translate([66/2, 0, 0])
    cylinder(h=2.5, d=3.5);
}

translate([0, 0, 13-4])
cylinder(h=4, d=71);

}

translate([70, 0, 0])
cylinder(h=20, d=10);

translate([55, 0, 5])
cube([30, 6, 10], center=true);