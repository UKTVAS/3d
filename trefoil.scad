// reference: https://twitter.com/estelliaslair/status/1107808592927678464

module pie_slice(r, $fa=$fa) {
   intersection() {
       circle(r=r, $fa=$fa);
       translate([-r, 0]) square([2*r, r]);
       rotate(-120) translate([-r, 0]) square([2*r, r]);
   }
}

module trefoil(r) {
    union() {
        difference() {
            union() {
                pie_slice(r, $fa=5);
                rotate(120) pie_slice(r);
                rotate(-120) pie_slice(r);
            }
            circle(r=r*0.3);
        }
        circle(r=r*0.2);
    }
}

module trans(r) {
    difference() {
        circle(r=r*0.3);
        circle(r=r*0.2);
    }
    rotate(-90) translate([r*0.25, -r*0.05]) square([r*0.65, r*0.1]);
    rotate(30) translate([r*0.25, -r*0.05]) square([r*0.6, r*0.1]);
    rotate(150) translate([r*0.25, -r*0.05]) square([r*0.6, r*0.1]);
    translate([0, -r*0.65]) square([r*0.5, r*0.1], center=true);
    rotate(-15) translate([r*0.30, r*0.30]) difference() {
        square(r*0.35);
        translate([-r*0.1, -r*0.1]) square(r*0.35);
    }
    rotate(-15+120) translate([r*0.35, r*0.35]) difference() {
        square(r*0.3);
        translate([-r*0.1, -r*0.1]) square(r*0.3);
    }
    rotate(60) translate([0, r*0.5]) square([r*0.35, r*0.1], center=true);
}

module model() {
    linear_extrude(1) difference() {
    circle(50, center=true);
        difference() {
            trefoil(r=30);
            trans(r=30);
        }
    }
}

model();