use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>

$fn=22;
R = 10;
step = 0.15;
wavelength=2;

function theta(t) = acos(1-t/R);
spiral = [for (t=[0:step:2*R/wavelength])
  rotation([t*360,0,0]) *
  translation([R-wavelength*t,R*sin(theta(wavelength*t)),0])
  ];

echo(spiral);

//sweep(circle(1), spiral);
difference() {
  rotate([0,90,0]) sphere(R);
  sphere(R*0.9);
  for (tr = spiral) {
    multmatrix(scaling([0.9,0.9,0.9])*tr) {
      sphere(R*0.15);
    };
  };
  };
