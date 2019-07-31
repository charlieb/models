$fn=50;

shaft_d=6.6; // measured 6.2 + 0.2*2 for double margin/shrinkage;
knob_d=20;
insert_max_width=3;
knob_flatten_factor=0.75;
cord_hole_d = 4;

difference() {
  union() {
    translate([0,0, knob_d*knob_flatten_factor/2-1.5]) scale([1,1,knob_flatten_factor]) sphere(d=knob_d);
    cylinder(d=shaft_d+insert_max_width*2+4, h = 10, center=false);
  }
  translate([0,0,-0.25]) cylinder(d2=shaft_d, d1=shaft_d+insert_max_width*2, h=knob_d*knob_flatten_factor+0.25, center=false);
  translate([0,0,-5]) cube([20,20,10], center=true);
  translate([0, 6.0,0]) rotate([12, 0,0]) cylinder(d=5, h=knob_d*2, center=true);
}

translate([knob_d, 0, 0])
difference() {
  union() {
    cylinder(d2=shaft_d, d1=shaft_d+insert_max_width*2, h=knob_d*knob_flatten_factor, center=false);
    translate([0,0,0]) cylinder(d=shaft_d+insert_max_width*2+insert_max_width, h=2);
  }
  cylinder(d=shaft_d, h=100, center=true);
  translate([0,0,13+5]) cube([20,20,10], center=true);
  translate([-1.5,2,-1]) cube([3,7,20], center=false);
}

