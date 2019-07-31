$fn = 25;

module gripper(r, thickness, opening_angle, height) {

d = r*2;

x_offset = (d + thickness*2) * cos(opening_angle);
y_offset = (d + thickness*2) * sin(opening_angle);


union() {
  difference() {
    cylinder(d = d + thickness*2, h = 10);
    cylinder(d = d, h = 30, center=true);
    linear_extrude(height = 30, center=true)
      polygon(points = [[0,0], [x_offset, y_offset], [x_offset, -y_offset]]);
  }

  end_extra_d = d/6;
  end_x = (d + thickness + end_extra_d)/2 * cos(opening_angle);
  end_y = (d + thickness + end_extra_d)/2 * sin(opening_angle);
  translate([end_x, end_y, 0]) cylinder(d = thickness + end_extra_d, h = 10);
  translate([end_x, -end_y, 0]) cylinder(d = thickness + end_extra_d, h = 10);
  }
}

main_shaft_d = 12.9; // 12.5 measured + radius 0.2 margin 
left_branch_d = 4.9;
right_branch_d = 3.9;

gripper(r=main_shaft_d / 2, thickness=3, opening_angle=45, height=10);
translate([-main_shaft_d/2 - 3 - 3, -5, 0]) cube([5,10,20]);
translate([-main_shaft_d/2 - 3 - 3, -20, 15]) cube([5,40,5]);

translate([-main_shaft_d/2 - left_branch_d/2 +5 +5, -10,18])
  rotate([90,0,0])
  union() {
    gripper(r=left_branch_d/2, thickness=3, opening_angle=45, height=5);
    translate([-left_branch_d*2+1,-3,0]) cube([5,5,10]);
  }

translate([-main_shaft_d/2 - right_branch_d/2 +5 +5, 20,17])
  rotate([90,0,0])
  union() {
  gripper(r=right_branch_d/2, thickness=3, opening_angle=45, height=5);
    translate([-right_branch_d*2-5,-2,0]) cube([10,5,10]);
    }
