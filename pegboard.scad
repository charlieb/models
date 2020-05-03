
peg_d = 5.9;
peg_spacing = 25.7;
board_thickness = 4.5;
$fn = 30;

//rotate([90,0,0])
difference() {
  union() {
    cylinder(d=peg_d, h=board_thickness+5);
    
    translate([10+peg_spacing,0,0])
    rotate([90,0,180])
    rotate_extrude(angle=80)
    translate([10, 0, 0])
    circle(d=peg_d-0.5);
    
    translate([0,0,-2])
    hull() {
      cylinder(d=peg_d, h=2);
      translate([peg_spacing,0,0])
      cylinder(d=peg_d, h=2);
    }
  }

  translate([-5,peg_d/2-0.5,-25]) cube(size=[50,10,50]);
  translate([-5,-10-peg_d/2+0.5,-25]) cube(size=[50,10,50]);
}



