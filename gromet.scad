linear_extrude(height=1.0)
difference() {
  circle(r=5);
  circle(r=2);
  for (a=[0:360/16:360]) {
    rotate([0,0,a]) translate([3.5,0,0]) circle(r=0.25);
    }
  }



