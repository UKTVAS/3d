tube = 29/2;
cable = 5/2;
width = 3.8;
breadth = 7;

module circle_outer(radius,fn) {
  fudge = 1/cos(180/fn);
  circle(r=radius*fudge,$fn=fn);
}

linear_extrude(height=breadth) {
    difference() {
        union() {
            circle(r=(tube + width));
            rotate(45) translate([0, cable + tube]) circle(r=(cable + width));
        }
        circle_outer(tube, 60);
        square(tube+width);
        rotate(45) translate([0, cable + tube]) circle_outer(cable, 40);
        rotate(45) translate([0, tube - cable]) union() {
            translate([-cable/cos(180/20), 0]) square(2*cable/cos(180/20));
        }
    }

    translate([0, (tube+0.5*width)]) circle(width/2, $fn=10);
    translate([(tube+0.5*width), 0]) circle(width/2, $fn=10);
}