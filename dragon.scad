rotate([90,0,0]) {
linear_extrude(height=4) import("dragon_tail.dxf");
translate([0,0,0]) linear_extrude(height=4) import("dragon_body.dxf");
color("green") translate([-20,0,5]) linear_extrude(height=4) import("dragon_back_leg.dxf");
color("green") translate([90,0,5]) linear_extrude(height=4) import("dragon_front_leg.dxf");
color("green") translate([90,0,5]) rotate([0,90,0]) linear_extrude(height=4) import("dragon_wings.dxf");
}
