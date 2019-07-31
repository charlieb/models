color([0,0,1.]) translate([0,0,3])
  linear_extrude(height = 3, center = true, convexity = 10)
  import("sylas.dxf");

color([0,0,0]) translate([-2.5,-2,0]) cube([200,50,3]);
