bar_thickness = 4.8;
bar_height = 33;
barrel_diameter = 28;
barrel_height = 45.6;
barrel_extra = 11.1;
jaws_0mm = 18.5;
jaws_10mm = 19.3;
jaws_20mm = 21;
down_tube = 32.5/2;
angle_guess = 9;
seat_tube_angle_guess = 30;
top_clearance = 4;

clip_thickness = 3;
clip_angle = 110;

clip_width = 20;

module circle_outer(radius,fn) {
  fudge = 1/cos(180/fn);
  circle(r=radius*fudge,$fn=fn);
}

module half_circle(r) difference() {
  circle(r = r);
  translate([-r, -r]) square([2*r, r]);
}

module arc(r, a = 270) {
    if (a == 180) {
        half_circle(r);
    } else if (a < 180) {
        difference() {
            half_circle(r);
            rotate(-180 + a) translate([-r, -r]) square([2*r, r]);
        }
    } else {
        union() {
            half_circle(r);
            rotate(a - 180) half_circle(r);
        }
    }
}

module clip_shape(a=250) union() {
    difference() {
        arc(down_tube + clip_thickness, a);
        circle_outer(down_tube, 40);
    }
    translate([down_tube + clip_thickness/2, 0]) circle(r = clip_thickness/2, $fn=20);
    rotate(a) translate([down_tube + clip_thickness/2, 0]) circle(r = clip_thickness/2, $fn=20);
}

module holder_shape()
translate([-bar_thickness - top_clearance - 2.5*clip_thickness, 0]) union() {
    square([clip_thickness, bar_height/2 + clip_thickness/2]);
    translate([clip_thickness/2, bar_height/2 + clip_thickness/2]) circle(r=clip_thickness/2, $fn=20);
    translate([clip_thickness/2, 0]) circle(r=clip_thickness/2, $fn=20);
    translate([clip_thickness/2, -clip_thickness/2]) square([bar_thickness + top_clearance+ 2*clip_thickness, clip_thickness]);
    translate([clip_thickness + bar_thickness, -clip_thickness/2]) square([clip_thickness, bar_height/4 + clip_thickness]);
    translate([clip_thickness*1.5 + bar_thickness, bar_height/4 + clip_thickness/2]) circle(r=clip_thickness/2, $fn=20);
}

module full_clip(a=250) {
    clip_shape(a);
    rotate(a/2 - 90) {
        translate([-down_tube, 0]) holder_shape(a);
        translate([down_tube, 0]) mirror() holder_shape(a);
    }
    
    rotate(a/2) translate([0, down_tube + top_clearance + 2*clip_thickness + bar_thickness]) rotate(180 - asin(down_tube / (down_tube + top_clearance + 1.5*clip_thickness + bar_thickness))) translate([-clip_thickness/2, 0]) square([clip_thickness, sin(a/2-90)*(down_tube + top_clearance + 3*clip_thickness + bar_thickness)]);
    
     rotate(a/2 + 180) translate([0, down_tube + top_clearance + 2*clip_thickness + bar_thickness]) rotate(180 + asin(down_tube / (down_tube + top_clearance + 1.5*clip_thickness + bar_thickness))) translate([-clip_thickness/2, 0]) square([clip_thickness, sin(a/2-90)*(down_tube + top_clearance + 3*clip_thickness + bar_thickness)]);
}

difference() {
linear_extrude(clip_width) full_clip(360 - clip_angle);

    for (x = [-1 : 1 : 1]) {
        translate([0, 0, clip_width/2]) rotate([90, 0, 90 + (360-clip_angle)/2 + 45*x] ) cylinder(h = 10 + down_tube, r = 12/2);
    }

}