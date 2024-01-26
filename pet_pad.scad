module surface() {
    polygon([
        [0,0], [260,0],
        [260,60], [260-10,76], [260-10,217], [213,266],
        [0,266], [0,155], [10,145], [10,130], [0,120]
    ]);
}

module box() {
    difference() {
        linear_extrude(height=10) surface();
        translate([0,0,3]) linear_extrude(height=15) offset(delta=-3) surface();
    }
}

module spike() {
    linear_extrude(height=6, scale=0.5) square(8, center=true);
}

module spikes() {
    xstep = 21; xoffset1=10; xoffset2=xoffset1+xstep/2;
    ystep = 11; yoffset=12;
    for (x = [xoffset1+xstep:xstep:260]) {
        translate([x,yoffset+ystep*0,3]) spike();
    }
    for (x = [xoffset2:xstep:260]) {
        translate([x,yoffset+ystep*1,3]) spike();
    }
    for (x = [xoffset1:xstep:260]) {
        translate([x,yoffset+ystep*2,3]) spike();
    }
    for (x = [xoffset2:xstep:260]) {
        translate([x,yoffset+ystep*3,3]) spike();
    }
    for (x = [xoffset1:xstep:260]) {
        translate([x,yoffset+ystep*4,3]) spike();
    }
    for (x = [xoffset2:xstep:250]) {
        translate([x,yoffset+ystep*5,3]) spike();
    }
    for (x = [xoffset1:xstep:250]) {
        translate([x,yoffset+ystep*6,3]) spike();
    }
    for (x = [xoffset2:xstep:250]) {
        translate([x,yoffset+ystep*7,3]) spike();
    }
    for (x = [xoffset1:xstep:250]) {
        translate([x,yoffset+ystep*8,3]) spike();
    }
    for (x = [xoffset2:xstep:250]) {
        translate([x,yoffset+ystep*9,3]) spike();
    }
    for (x = [xoffset1+xstep:xstep:250]) {
        translate([x,yoffset+ystep*10,3]) spike();
    }
    for (x = [xoffset2:xstep:250]) {
        translate([x,yoffset+ystep*11,3]) spike();
    }
    for (x = [xoffset1+xstep:xstep:250]) {
        translate([x,yoffset+ystep*12,3]) spike();
    }
    for (x = [xoffset2:xstep:250]) {
        translate([x,yoffset+ystep*13,3]) spike();
    }
    for (x = [xoffset1:xstep:250]) {
        translate([x,yoffset+ystep*14,3]) spike();
    }
    for (x = [xoffset2:xstep:250]) {
        translate([x,yoffset+ystep*15,3]) spike();
    }
    for (x = [xoffset1:xstep:250]) {
        translate([x,yoffset+ystep*16,3]) spike();
    }
    for (x = [xoffset2:xstep:250]) {
        translate([x,yoffset+ystep*17,3]) spike();
    }
    for (x = [xoffset1:xstep:250]) {
        translate([x,yoffset+ystep*18,3]) spike();
    }
    for (x = [xoffset2:xstep:220]) {
        translate([x,yoffset+ystep*19,3]) spike();
    }
    for (x = [xoffset1:xstep:210]) {
        translate([x,yoffset+ystep*20,3]) spike();
    }
    for (x = [xoffset2:xstep:200]) {
        translate([x,yoffset+ystep*21,3]) spike();
    }
    for (x = [xoffset1:xstep:200]) {
        translate([x,yoffset+ystep*22,3]) spike();
    }
}


box();
spikes();

linear_extrude(height=14) translate([2,25,0]) rotate([0,0,-45]) square([33,3]);
linear_extrude(height=14) translate([207,242,0]) rotate([0,0,-45]) square([33,3]);