use <scad-utils/morphology.scad>

$fn = 25;

pole_d = 6.8; // 6.6 measured + 0.2 shrink 
extend_length = 20;
pole_depth = 15;
wall_width = 2;

rotate([180,0,0])
union() {
  cylinder(d=pole_d, h=pole_depth);
  translate([0,0,pole_depth])
    difference() {
      cylinder(d=pole_d + 2*wall_width, h=extend_length + pole_depth);
      translate([0,0, extend_length])
        union() {
          cylinder(d=pole_d, h=pole_depth+1);
          rotate([180,0,0]) cylinder(d1=pole_d, d2=0, h=4);
        }
    }

}

