
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
    translate([-0.0,-6.5,-10]) scale([1.0,2.5,1]) rotate([0,0,45]) cube(size=[2,2,20]);

    translate([0,-5,7]) rotate([45,0,0]) cube(size=[10,10,10], center=true);
    translate([0,-4.5,7]) rotate([60,0,0]) cube(size=[10,10,10], center=true);
    translate([0,-4.5,-2]) rotate([30,0,0]) cube(size=[10,10,10], center=true);
    translate([0,-6.2,0]) cube(size=[10,10,10], center=true);
  };
};

track_gauge = marble_d - 2;
module wire_track_section() {
  scale([1,2,1])
  difference() {
    cylinder(d=track_gauge/2,h=3);
    translate([0,0,-0.05]) cylinder(d=track_gauge/2-2,h=3.1);
    translate([0, -track_gauge/2, -1]) cube([track_gauge, track_gauge, 5]);
  }

  difference() {
    union() {
      translate([2,track_gauge/2-1,-0]) wire_snap(50);
      translate([2,-track_gauge/2+1,-0]) wire_snap(130);
    };
    translate([3.75,-track_gauge,-0.05]) cube(size=[10, track_gauge*2,5.1]);
    
  };
};

//translate([12,7,0]) rotate([0,0,0]) wire_track_section();
//translate([10,2,0]) rotate([0,0,90]) rotate_extrude(angle=90) translate([5,0,0]) square([5,5]);
//wire_snap(0);
//translate([0,-6,5]) rotate([-45,0,0]) cube(size=[10,10,10], center=true);

pipe_d = 33.2;
pipe_hs = [16.7, 17.1, 15.1, 15.7, 12.8,15.3, 15.0, 15.3, 16.7, 16.7];
pipe_wall = 3.8;
pipe_inner_d = 25.8;
margin = 0.4;
cradle_top = -pipe_d/2 + 15.3;
cradle_wall = 3;
cradle_d = pipe_d + cradle_wall*2;
cradle_thickness = peg_d - 1;

module pipe_holder() {
  difference() {
    cylinder(d=pipe_d + cradle_wall*2 + margin, h = cradle_thickness);
    translate([0,0,-0.05]) cylinder(d=pipe_d + margin, h = cradle_thickness + 0.1);
    translate([cradle_top, -pipe_d,-0.1]) cube(size=[100,100,100]);
  }
  translate([cradle_top - 1, -cradle_d/2,0]) rotate([0,0,-10]) cube(size=[2,7, cradle_thickness]);
  translate([cradle_top - 1, cradle_d/2,cradle_thickness]) rotate([180,0,10]) cube(size=[2,7, cradle_thickness]);
  // Pipe connector
  translate([-4.3, -cradle_d/2 - margin, 0])
  difference() {
    scale([1,2,1]) cylinder(d=cradle_d , h=cradle_thickness);
    translate([-00, -50, -0.1]) cube(size=[100,100,100]);
    translate([-50, -105, -0.01]) cube(size=[100,100,100]);
    translate([-50, cradle_d/2 + 10, -0.01]) cube(size=[100,100,100]);
    translate([4.0, cradle_d/2 ,-0.05]) cylinder(d=pipe_d + margin, h = cradle_thickness + 0.1);
  }
}

translate([0,0,02.5]) peg();
translate([30,25,0]) pipe_holder();

