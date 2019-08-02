use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <obiscad/obiscad/vector.scad>

// star module from https://gist.github.com/anoved/9622826
// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
module star(points, outer, inner) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

			assign(	x_outer = x(outer, increment * p),
					y_outer = y(outer, increment * p),
					x_inner = x(inner, (increment * p) + (increment/2)),
					y_inner = y(inner, (increment * p) + (increment/2)),
					x_next  = x(outer, increment * (p+1)),
					y_next  = y(outer, increment * (p+1))) {
				polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}
		}
	}
}

$fn=32;
R = 50;
step = 0.25;
depth = 5;
star_r = 2.5;

function theta(t) = acos(1-t/R);
function spiral(t,turns) =
  rotation([t*19*turns,0,0]) *
  translation([R-t,R*sin(theta(t)),0])
  ;

//sweep(circle(0.5), [for (t=[0:step:2*R]) normal_spiral(t,2)]);

difference() {
  rotate([0,90,0]) sphere(R);
  //sphere(R*0.9);
	for (t=[0:step:2*R]) {
    m = spiral(t, 10);
    v = [for(i=[0:2]) (m*[0,0,0,1])[i]];
    translate(v*(1-depth/R))
      orientate(v) {
        //cylinder(r=0.5, h=4); };
        linear_extrude(height=R) star(5,star_r,star_r/2);
        //sphere(R*0.15);
      };
  };
};

//for (t=[0:step:2*R]) {
//  m = spiral(t, 10);
//  v = [for(i=[0:2]) (m*[0,0,0,1])[i]];
//  translate(v*0.9) 
//    orientate(v) {
//        linear_extrude(height=3) star(5,1,0.5);
//       // cylinder(r=0.5, h=4);
//        };
//};
//for (t=[0:step*3:2*R]) {
//    multmatrix(normal_spiral(t, 2.5)) {
//			star(5,1,0.5);
//      //cylinder(r1=R*0.1, r2=0, h=5);
//      //circle(1);
//    };
//};
//

echo(translation([1,2,3]));
echo(translation([2,3,5])*[0,0,0,1]);

