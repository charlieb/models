module oval(d, length) {
hull() {
  circle(d=d);
  translate([length,0,0]) circle(d=d);
  }
};

body_d = 15;
arm_d = 7;
screw_d = 5;
screw_head_d=7;
screw_h=2;

difference() {
  linear_extrude(height=5) {
    oval(body_d, length=10);
    translate([12,0,0]) oval(arm_d, length=10);
  }
  translate([-8,0,-2])
  scale([1,1,2.5])
  rotate([0,90,0])
  linear_extrude(height=15) {
    circle(d=8, $fn=3);
    }
}

translate([22,0,-5]) cylinder(d=arm_d, h=9);
