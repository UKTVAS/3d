// plug
py = 6.8;
px = 13.0;
pz = 17.7;
pr = 1.8;

// plug narrow part
pnz = 12.5;
pnx = 6.6;

// cell
cx = 75.8;
cy = 11.8;
ca = 35;
ch = 130; // guess
back = 20;
lip = 4;

// WALL
wall = 4;// + rands(-1, 5, 1)[0];
width = 60;
upright = pz + pnz + 10;
legs = 8;// + rands(-3, 8, 1)[0];

// base
base = pz/2;

bottom = (upright+0.75*ch)*sin(ca);

module plug_outline() translate([pr, pr]) minkowski() {
    square([px - 2*pr, py - 2*pr]);
    circle(r=pr, center=true, $fn=40);
}

module narrow_inset() {
    w = (px-pnx)/2;
    h = sqrt(pow(pnz, 2) + pow((px - pnx)/2, 2));
    a = atan((px - pnx)/2/pnz);
    translate([0, 0, pnz]) rotate([0, -a, 0]) translate([-w, -1, -h]) cube([w, py+2, h]);
}

module plug() difference() {
    linear_extrude(pz + pnz) plug_outline();
    narrow_inset();
    translate([px, 0, 0]) mirror() narrow_inset();
}

//plug();

rotate([ca, 0, 0]) difference() {

     translate([width/2, 0, -base]) rotate([0, -90, 0]) linear_extrude(width) union() {
        // platform
       translate([0, -0.1]) difference() {
                translate([-cy/2, wall]) square([base + cy/2, cy]);
                minkowski() {
                  translate([-cy/2-cy/4, wall+cy/4]) square([cy/2, cy]);
                  circle(r=cy/4, $fn=20);
                }
        }
        // upright
        translate([-upright, 0]) square([back + base + upright, wall]);
        // hinge
        translate([-upright, -wall]) difference() {
            circle(r=wall*2);
            circle(r=wall);
            translate([0, -2*wall]) square([2*wall, 4*wall]);
            rotate(ca) translate([-2*wall, -2*wall]) square([4*wall, 2*wall]);
        }
        // bottom
        translate([-upright, -wall]) rotate(ca) translate([-2*wall, -bottom+0.1]) square([wall, bottom]);
    }
    // center circle hole
    translate([0, 1, -width/2 + legs - pz/2 - cy/4]) rotate([90, 0, 0]) cylinder(h = 2*wall, r=width/2-legs, center=true);
    // center square hole
    rotate([180, 0, 0]) translate([-width/2+legs, -wall-1, width/2 - legs + pz/2 + cy/4]) cube([width-2*legs, 3*wall, upright]);
    // bottom square hole
    translate([0, -wall, -upright-base]) rotate([-ca, 0, 0]) translate([-width/2+legs, -bottom+0.1+legs, -2*wall-0.1]) cube([width - 2*legs, bottom, wall+0.2]);

    translate([-px/2, wall + cy/2 - py/2, -pz - pnz + 1]) plug();
}

// study
//rotate([ca, 0, 0]) difference() {
//    translate([-base/2-cy/2, 0, -pz/2]) cube([base+cy, cy, pz/2]);
//    #translate([-px/2, cy/2 - py/2, -pz - pnz + 1]) plug();
//}