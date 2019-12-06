hole_width_measured=24.2;//mm
margin=0.2;
hole_width=hole_width_measured;//-margin;//mm

insertion_height=7;
wall_width=3;
opening_width=29;

$fn=50;

// Body
module plug_body(w1, w2) {
  union() {
    cylinder(d=w1, h=insertion_height);
    translate([0,0,insertion_height]) cylinder(d1=w1, d2=w2, h=insertion_height);
    translate([0,0,insertion_height*2]) cylinder(d=w2, h=3);
  }
}

module plug() {
difference() {
  plug_body(hole_width, opening_width);
  plug_body(hole_width-wall_width*2, opening_width-wall_width*2);
}

translate([0,0,insertion_height*2+1])
  union() {
    difference() {
      cylinder(d=opening_width, h=2);
      translate([-opening_width/2, 2,0]) cube(size=[opening_width, opening_width, 2]);
    }
    cylinder(d=opening_width/2, h=2);
  }
}

// Top
cap_thickness=1;

module cap() {
  d=opening_width+wall_width*2 + margin*2;
  d_inner=opening_width+margin*2;
  // Cap plate
  difference() {
    cylinder(d=d, h=cap_thickness);
    translate([-opening_width, 2,0]) cube(size=[opening_width*2, opening_width, 2]);
  }

  // Body
  body_h=3+margin+cap_thickness+0.4;
  difference() {
    cylinder(d=d, h=body_h);
    cylinder(d=d_inner, h=body_h);
  }

  // Snap holder
  translate([0,0,cap_thickness+3+margin])
    difference() {
      cylinder(d=d, h=2);
      cylinder(d1=d_inner-1, d2=d_inner, h=2);
    }
}

r=opening_width/2+wall_width;
translate([0,opening_width+wall_width+4,0]) 
  union() {
    cap();
    for(a=[0:18:360]) {
      translate([r*cos(a), r*sin(a),0]) rotate([0,0,a]) scale([1,1.4,1]) cylinder(d=5,h=cap_thickness+3+margin);
    }
  }
translate([0,0, insertion_height*2+3]) rotate([180,0,0]) plug();
