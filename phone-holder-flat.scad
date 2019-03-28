// cell
cx = 75.8;
cy = 11.8;
ca = 22.5;
ch = 130; // guess

overhang = 30;
minimum_depth = 4;
stand_depth = 15;

base = minimum_depth + overhang + 0.5*ch*sin(ca);

$fn=100;

translate([0, 0, 0]) difference() {
    intersection() {
        translate([0, 0, 0]) cube([cx/2, base, stand_depth]);

        translate([cx/4,  base/2, 0]) scale([1, 1.2, 1.2*2*stand_depth/base]) sphere(r=base * 0.5);
    }
    color("pink") translate([-cx/4, cy + minimum_depth, minimum_depth]) rotate([-ca, 0, 0]) translate([0, -cy, 0]) cube([cx, cy, ch]);
}
