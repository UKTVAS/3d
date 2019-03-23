radius = 74.8/2;
offset = 0.1;
hole = 7/2;
cable = 5;
inset = 4;
lip = 3;

clip_depth = 7;
top_depth = 1;

r = radius - offset;

module hole() translate([0, -r]) {
    translate([0, inset]) circle(hole, $fn=40);
    translate([-cable/2, -80]) square([cable, inset + 80]);
}

difference() {
    union() {
        difference() {
            linear_extrude(clip_depth) difference() {
                circle(r+lip, $fn=40);
                for (a = [ 0 : 30 : 360 ]) {
                    rotate(a) hole();
                }
            }
            difference() {
                translate([0, 0, top_depth]) cylinder(r=r+lip+5, h=clip_depth);
                cylinder(r=r, h=clip_depth, $fn=40);
            }
            translate([0, 0, top_depth]) cylinder(h=clip_depth-top_depth + 2, r = r - top_depth);
        }

        for (a = [ 0 : 30 : 360]) {

          rotate(a + 30/2) translate([-top_depth/2, -r+0.5, top_depth]) cube([top_depth, r*2-1, clip_depth/2]);
        }
      
        inner = r - inset - hole;
        translate([0, 0, top_depth]) cylinder(r=inner, h=clip_depth/2);
    }
    cylinder(r = r - inset - hole - top_depth, h=clip_depth);
}