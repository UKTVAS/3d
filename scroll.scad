function reverse(a) = [ for (i = [len(a) - 1 : -1 : 0]) a[i] ];

function rotations(count, r=1) =
  [r * (cos(count*360) + (count*PI*2)*sin(count*360)), r * (sin(count*360) - (count*PI*2)*cos(count*360))];

r = 1;
$fa = 40;

function spiral(r=1, rotations=3) =
  let (ts = [ for (t = [60 : 360/$fa : rotations * 360 ]) t ])
  [for (t = ts) [r * (cos(t) + (t*PI/180)*sin(t)), r * (sin(t) - (t*PI/180)*cos(t))]]; 

rotation = [[0, -1], [1, 0]];

function offset_one(amount, first, second, third) = amount*rotation*(third - first)/norm(third-first) + second;

function offset(points, amount = 1) =
  [ for (i = [0 : len(points) - 1])
      offset_one(amount, 
  points[i > 0 ? i - 1 : len(points) - 1],
  points[i],
  points[i < len(points) - 1 ? i + 1 : 0])];

module stroke(points, amount = 1) {
   polygon(offset(concat(points, reverse(points)), amount/2));
}

spin = PI - 1 - 0.1;

module ring() {
    linear_extrude(1.1) difference() {
        circle(r=spin+0.5, $fn=20);
        circle(r=spin-0.5, $fn=20);
    }
}

union() {
    union() {
       color("violet") linear_extrude(20) stroke(spiral(r=r,rotations=3.1));

       translate([0, 0, 0.5]) difference() {
            linear_extrude(2) difference() {
                circle(r=2*3*PI+(PI), $fn=40);
                translate([-1, 0]) circle(r=r*2, $fn=20);
                translate(-rotations(2.55)) circle(r=r*2, $fn=20);
            };
            translate([0, 2*2*PI, 1]) ring();
            translate([0, -2*2.5*PI, 1]) ring();
            translate([2*1.75*PI, 0, 1]) ring();
            translate([-2*2.25*PI, 0, 1]) ring();
        }
        
        color("red") translate(rotations(3.08)) rotate(3.08*360) linear_extrude(20) square([1, 2*r*PI]);
    }

   translate([0, -2*2*4*PI , 20]) rotate([180, 0, 0])
    //translate([0, 0, 3])
    union() {
       color("mediumorchid") linear_extrude(20) rotate(180) stroke(spiral(r=r, rotations=2.5));
        
        translate([0, 0, -0.9]) union() {
            translate([0, 2*2*PI - 0.1]) cylinder(r=0.45, h=20-0.9, $fn=20);
            translate([0, -2*2.5*PI + 0.1]) cylinder(r=0.45, h=20-0.9, $fn=20);
            translate([-2*2.25*PI + 0.1, 0]) cylinder(r=0.45, h=20-0.9, $fn=20);
            translate([2*1.75*PI - 0.1, 0]) cylinder(r=0.45, h=20-0.9, $fn=20);
        }

        translate([0, 0, 17.5]) linear_extrude(2) circle(r=2*3*PI+(PI), $fn=40);
    }
    
    translate([0, 0, 0.6]) linear_extrude(0.8) translate([0, -50]) square([1, 30]);
}
