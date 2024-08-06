rotate(90, [1,0,0])
difference(){
    
linear_extrude(height=20, center=true)
difference() {
    square([40, 20], center=true);
    translate([0, 5]) square([30,20], center=true);
};

translate([0,0,15])
rotate(-10, [1,0,0])
linear_extrude(height=20, center=true)
square([50,30], center=true);

translate([0,0,-15])
rotate(10, [1,0,0])
linear_extrude(height=20, center=true)
square([50,30], center=true);
}