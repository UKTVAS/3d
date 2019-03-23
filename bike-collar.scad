r = 37.5/2;
thickness = 2;

module outline() difference() {
    circle(r=r+thickness);
    circle(r=r/cos(180/40), $fn=40);
    square(2*r);
}

linear_extrude(15) outline();