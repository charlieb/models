linear_extrude(height=1.0)
difference() {
  circle(r=10);
  circle(r=5);
  for (a=[0:360/16:360]) {
    rotate([0,0,a]) translate([7.5,0,0]) circle(r=1);
    }
  }



