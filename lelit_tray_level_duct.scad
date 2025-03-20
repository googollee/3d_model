// Work with https://www.thingiverse.com/thing:5220231/files
$fn=60;

linear_extrude(height=10)
difference() {
    circle(d=7.6);
    circle(d=6.8);
}

linear_extrude(height=0.8)
difference() {
    circle(d=11.7);
    circle(d=7);
}