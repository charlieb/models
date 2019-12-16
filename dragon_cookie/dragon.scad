module outline(r) {
  difference() {
    minkowski() {
      children();
      circle(r=1.2);
    }
    children();
  }

  difference() {
  minkowski() {
    children();
    circle(r=-5);
    }
    children();
    }
}

cookie_thickness = 10;

rotate([90,0,0]) {
  translate([0,0,-5]) {
    linear_extrude(height=cookie_thickness) outline()  import("dragon_tail.dxf");
    translate([10,40,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    translate([10,10,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    }
   // }
translate([0,0,0]) {
    linear_extrude(height=cookie_thickness) outline() import("dragon_body.dxf");
    translate([10,40,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    translate([10,10,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    translate([120,40,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    translate([90,48,0]) difference() { cube(size=[cookie_thickness+2,40,cookie_thickness]);
                                        translate([0.5,0.5,0]) cube(size=[cookie_thickness+1,40,cookie_thickness]);};
    }
color("green") translate([-20,0,5]) {
    linear_extrude(height=cookie_thickness) outline() import("dragon_back_leg.dxf");
    translate([30,40,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    translate([30,10,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    }

color("green") translate([90,0,5]) {
    linear_extrude(height=cookie_thickness) outline() import("dragon_front_leg.dxf");
    translate([30,40,0]) difference() { cylinder(d=4, h=cookie_thickness); cylinder(d=3.5, h=cookie_thickness); };
    }

color("green") translate([90,0,5]) rotate([0,90,0]) linear_extrude(height=cookie_thickness) outline() import("dragon_wings.dxf");
}
