$fn=30;

barrel_diameter = 28 / cos(180/$fn);
barrel_height = 45.6;
barrel_extra = 11.1;
barrel_extra_diameter = barrel_diameter - (3*2); // guess

down_tube_radius = 32.5/2 / cos(180/$fn);
seat_tube_radius = 29/2/ cos(180/$fn);
seat_tube_angle = 60;

wall = 4;

difference() {

translate([-20, -29, 1]) cube([100, 58, 110]);

union() {
translate([0, 0, 0]) union() {
	translate([0, 0, -30]) cylinder(h=200, r=seat_tube_radius);
	rotate([0, seat_tube_angle, 0]) translate([0, 0, -30]) cylinder(h=200, r=down_tube_radius);
}

rotate([0, seat_tube_angle, 0]) translate([-down_tube_radius - barrel_diameter/2 - wall, 0, 56]) union() {
  cylinder(r=barrel_diameter/2, h=barrel_height);
  translate([0, 0, -barrel_extra+1]) cylinder(r=barrel_extra_diameter/2, h=barrel_extra);
}

rotate([0, seat_tube_angle, 0]) translate([8, -30, 0]) cube([60, 60, 200]);

// top
rotate([0, 15, 0]) translate([-40, -30, 80]) cube([200, 60, 60]);

// right
translate([0, down_tube_radius + wall, 0]) cube([200, 60, 120]);

// left
translate([0, -down_tube_radius - wall -60, 0]) cube([200, 60, 120]);

// front
translate([-59, -30, 0]) cube([60, 60, 120]);

//below
translate([0, -60, 0]) cube([200, 120, 40]);

//strap
translate([15, -40, 50]) cube([5, 80, 20]);

//translate([23, 0, 0]) cylinder(h=120, r=7);

translate([-10, 20, 78]) rotate([45, 15, 0]) translate([0, 0, -5]) cube([120, 20, 20]);
translate([-10, -20, 78]) rotate([45, 15, 0]) translate([0, -5, 0]) cube([120, 20, 20]);
}
}

