// plug
py = 6.4;
px = 12.6;
pz = 17.7;
pr = 1;

// cell
cx = 75.8;
cy = 11.8;
ca = 15;
ch = 220; // guess
back = 20;
lip = 4;

wall = 3;
width = 20;

// plug narrow part
pnz = 12.5;
pnx = 6.6;

// base
base = pz/2;

module plug_outline() translate([pr, pr]) minkowski() {
    square([px - 2*pr, py - 2*pr]);
    circle(r=pr, center=true, $fn=20);
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
        translate([0, wall]) square([base, cy]);
        square([back + base, wall]);
    }
    #translate([-px/2, wall + cy/2 - py/2, -pz - pnz + 1]) plug();
}