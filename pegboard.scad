
peg_d = 5.9;
peg_spacing = 25.7;
board_thickness = 4.5;
$fn = 30;

module peg() {
  rotate([90,0,0])
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
}

wire_d = 2.0; // 1.3
marble_d = 15.5;

module wire_snap(a=0) {
  rotate([0,0,a])
  difference() {
    cylinder(d=wire_d + 4.0, h=5);
    translate([0,0,-0.05]) cylinder(d=wire_d, h=5.1);
    translate([-0.0,-6.5,-10]) scale([3.0,2.5,1]) rotate([0,0,45]) cube(size=[2,2,20]);
    translate([-0,-10,-1]) cube(size=[10,10,10]);
  };
};

module track_section() {
  track_guage = marble_d - 2;
  cube(size=[track_guage,2,5]);
  translate([1,-1,-0]) wire_snap(20);
  translate([track_guage-1,-1,-0]) wire_snap(-50);
};

//translate([0,0,02.5]) peg();
translate([12,7,0]) rotate([0,0,90]) track_section();
//translate([10,2,0]) rotate([0,0,90]) rotate_extrude(angle=90) translate([5,0,0]) square([5,5]);
wire_snap(0);


