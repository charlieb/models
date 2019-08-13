use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <obiscad/obiscad/vector.scad>

function inverse4x4(a) =
    let(
     s0 = a[0][0] * a[1][1] - a[1][0] * a[0][1],
     s1 = a[0][0] * a[1][2] - a[1][0] * a[0][2],
     s2 = a[0][0] * a[1][3] - a[1][0] * a[0][3],
     s3 = a[0][1] * a[1][2] - a[1][1] * a[0][2],
     s4 = a[0][1] * a[1][3] - a[1][1] * a[0][3],
     s5 = a[0][2] * a[1][3] - a[1][2] * a[0][3],

     c5 = a[2][2] * a[3][3] - a[3][2] * a[2][3],
     c4 = a[2][1] * a[3][3] - a[3][1] * a[2][3],
     c3 = a[2][1] * a[3][2] - a[3][1] * a[2][2],
     c2 = a[2][0] * a[3][3] - a[3][0] * a[2][3],
     c1 = a[2][0] * a[3][2] - a[3][0] * a[2][2],
     c0 = a[2][0] * a[3][1] - a[3][0] * a[2][1],

    // Should check for 0 determinant
    invdet = 1.0 / (s0 * c5 - s1 * c4 + s2 * c3 + s3 * c2 - s4 * c1 + s5 * c0),

    b00 = ( a[1][1] * c5 - a[1][2] * c4 + a[1][3] * c3) * invdet,
    b01 = (-a[0][1] * c5 + a[0][2] * c4 - a[0][3] * c3) * invdet,
    b02 = ( a[3][1] * s5 - a[3][2] * s4 + a[3][3] * s3) * invdet,
    b03 = (-a[2][1] * s5 + a[2][2] * s4 - a[2][3] * s3) * invdet,

    b10 = (-a[1][0] * c5 + a[1][2] * c2 - a[1][3] * c1) * invdet,
    b11 = ( a[0][0] * c5 - a[0][2] * c2 + a[0][3] * c1) * invdet,
    b12 = (-a[3][0] * s5 + a[3][2] * s2 - a[3][3] * s1) * invdet,
    b13 = ( a[2][0] * s5 - a[2][2] * s2 + a[2][3] * s1) * invdet,

    b20 = ( a[1][0] * c4 - a[1][1] * c2 + a[1][3] * c0) * invdet,
    b21 = (-a[0][0] * c4 + a[0][1] * c2 - a[0][3] * c0) * invdet,
    b22 = ( a[3][0] * s4 - a[3][1] * s2 + a[3][3] * s0) * invdet,
    b23 = (-a[2][0] * s4 + a[2][1] * s2 - a[2][3] * s0) * invdet,

    b30 = (-a[1][0] * c3 + a[1][1] * c1 - a[1][2] * c0) * invdet,
    b31 = ( a[0][0] * c3 - a[0][1] * c1 + a[0][2] * c0) * invdet,
    b32 = (-a[3][0] * s3 + a[3][1] * s1 - a[3][2] * s0) * invdet,
    b33 = ( a[2][0] * s3 - a[2][1] * s1 + a[2][2] * s0) * invdet)
    
    [
    [b00, b01, b02, b03],
    [b10, b11, b12, b13],
    [b20, b21, b22, b23],
    [b30, b31, b32, b33]
    ];

function transpose4x4(m) = 
	[
	[m[0][0],m[1][0],m[2][0],m[3][0]],
	[m[0][1],m[1][1],m[2][1],m[3][1]],
	[m[0][2],m[1][2],m[2][2],m[3][2]],
	[m[0][3],m[1][3],m[2][3],m[3][3]]
	];

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
depth = 2;
star_r = 6.0;

function theta(t) = acos(1-t/R);
function spiral(t,turns) =
  rotation([t*19*turns,0,0]) *
  translation([R-t,R*sin(theta(t)),0])
  ;

//sweep(circle(0.5), [for (t=[0:step:2*R]) normal_spiral(t,2)]);

scl = [2.5,1,1];
scale([1.75,1.75,1.75])
translate([0,0,-201])

difference() {
rotate([0,90,0])
difference() {
  scale(scl) rotate([0,90,0]) sphere(R);
  //scale(scl*0.95) rotate([0,90,0]) sphere(R);
  for (t=[0:step:2*R]) {
    m = spiral(t, 10);
    tr = scaling(scl);
    trit = transpose4x4(inverse4x4(tr));
    v = [for(i=[0:2]) (trit*m*[0,0,0,1])[i]];
    p = [for(i=[0:2]) (tr*m*[0,0,0,1])[i]];
    translate(p*(1-depth/R))
      orientate(v) {
        //cylinder(r=0.5, h=4); };
        linear_extrude(height=R) star(5,star_r,star_r/2);
        //sphere(R*0.15);
      };
  };
};

translate([0,0,-100]) cube(size=200, center=true);
translate([0,0,200]) cube(size=200, center=true);
};

//for (t=[0:step:2*R]) {
//  m = spiral(t, 10);
//  tr = scaling(scl);
//  trit = transpose4x4(inverse4x4(tr));
//  v = [for(i=[0:2]) (trit*m*[0,0,0,1])[i]];
//  p = [for(i=[0:2]) (tr*m*[0,0,0,1])[i]];
//  translate(p*0.9) 
//    orientate(v) {
//        linear_extrude(height=30) star(5,1,0.5);
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

