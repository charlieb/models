
module block(r=2) {
  hull() {
    translate([0+r,0+r,0+r]) sphere(r=r, $fn=50);
    translate([0+r,0+r,7-r]) sphere(r=r, $fn=50);
    translate([0+r,30-r,0+r]) sphere(r=r, $fn=50);
    translate([0+r,30-r,7-r]) sphere(r=r, $fn=50);
    translate([60-r,0+r,0+r]) sphere(r=r, $fn=50);
    translate([60-r,0+r,7-r]) sphere(r=r, $fn=50);
    translate([60-r,30-r,0+r]) sphere(r=r, $fn=50);
    translate([60-r,30-r,7-r]) sphere(r=r, $fn=50);
  }
}

module magnet() {
  cylinder(h=3.4, d=6.4, $fn=50, center=true);
}

difference() {
  block();
  translate([15,15,3.5]) magnet();
  translate([60-15,15,3.5]) magnet();
}
