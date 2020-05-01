
module block(r=2) {
  hull() {
    translate([0+r/2,0+r/2,0+r/2]) sphere(r=r, $fn=50);
    translate([0+r/2,0+r/2,7-r/2]) sphere(r=r, $fn=50);
    translate([0+r/2,30-r/2,0+r/2]) sphere(r=r, $fn=50);
    translate([0+r/2,30-r/2,7-r/2]) sphere(r=r, $fn=50);
    translate([60-r/2,0+r/2,0+r/2]) sphere(r=r, $fn=50);
    translate([60-r/2,0+r/2,7-r/2]) sphere(r=r, $fn=50);
    translate([60-r/2,30-r/2,0+r/2]) sphere(r=r, $fn=50);
    translate([60-r/2,30-r/2,7-r/2]) sphere(r=r, $fn=50);
  }
}

module magnet() {
  cylinder(h=3.4, d=3.4, $fn=50, center=true);
}

difference() {
  block();
  translate([15,15,3.5]) magnet();
  translate([60-15,15,3.5]) magnet();
}
