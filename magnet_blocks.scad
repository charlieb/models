
module block(r=2, size=[1,1,1]) {
  hull() {
    translate([0+r,		0+r,		0+r])		sphere(r=r, $fn=50);
    translate([0+r,		0+r,		size[2]-r]) 	sphere(r=r, $fn=50);
    translate([0+r,		size[1]-r,	0+r])		sphere(r=r, $fn=50);
    translate([0+r,		size[1]-r,	size[2]-r])	sphere(r=r, $fn=50);
    translate([size[0]-r,	0+r,		0+r])		sphere(r=r, $fn=50);
    translate([size[0]-r,	0+r,		size[2]-r])	sphere(r=r, $fn=50);
    translate([size[0]-r,	size[1]-r,	0+r]) 		sphere(r=r, $fn=50);
    translate([size[0]-r,	size[1]-r,	size[2]-r]) 	sphere(r=r, $fn=50);
  }
}

magnet_h = 3;
magnet_d = 6;
hole_margin = 0.4;
module magnet(center=false) {
  cylinder(h=magnet_h + hole_margin, d=magnet_d + hole_margin, $fn=50, center=center);
}

//difference() {
//  block(r=2, size=[60,30,7]);
//  translate([15,15,3.5]) magnet(center=true);
//  translate([60-15,15,3.5]) magnet(center=true);
//}

difference() {
  block(r=2, size=[30,30,30]);
  translate([15,15,30-(magnet_h + hole_margin + 1.0)]) magnet();
  translate([15,15,0.6]) magnet();
  //translate([0,0,29.40]) cube(size=40,40,40);
}
