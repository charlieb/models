use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>

function drop(t) = 100 * 0.5 * (1 - cos(180 * t)) * sin(180 * t) + 1;
function path(t) = [0, 0, 80 + 80 * cos(180 * t)];
function rotate(t) = 180 * pow((1 - t), 3);

$fn=12;
step = 0.01;

/////////////// NECK ///////////////////
function neck(t) = 
  translation([0,0,5*t]) *
  rotation([0,0,t*250]) *
  translation([1+2*t,0,0]) *
  rotation([90,0,0]) *
  scaling([1+t*2,1+t,1]);

path_transforms_neck = [for (t=[0:step:1-step]) neck(t)];

///////////////// HORN ///////////////////
function horn(t) = 
  translation([0,t*3,0]) *
  rotation([90,0,0]) *
  scaling([pow(3,t),pow(3,t),1]);

path_transforms_horn = [for (t=[0:step:1]) horn(t)];
function innerize(t,tr) =
  tr * scaling([0.75+t*0.20*step, 0.75+t*0.20*step, 0.75+t*0.20*step]);
echo(1.0/step);
echo([for (t=[0:1.0:0.999999999/step]) t]);
echo([for (t=[0:step:1]) t]);

path_transforms_horn_inner2 = [for (t=[0:1:1/step]) innerize(t, path_transforms_horn[t])];
//echo(path_transforms_horn_inner2);
translate([20,0,0]) sweep(circle(1), path_transforms_horn_inner2);

function horn_inner(t) = 
  translation([0,t*3,0]) *
  rotation([90,0,0]) *
  scaling([pow(3,t),pow(3,t),1]) *
  scaling([0.75+t*0.20, 0.75+t*0.20, 0.75+t*0.20]);

path_transforms_horn_inner = [for (t=[0:step:1]) horn_inner(t)];


///////////////// MOUTHPIECE ///////////////////
function mouth(t) = 
  rotation([t*90, 0,0]) *
  translation([0,0,1]) *
  rotation([90,0,0]) *
  scaling([1-(t*0.7),1,1])
  ;

path_transforms_mouth = [for (t=[0:step:1-step]) mouth(t)];

union() {
  difference() {
    sweep(circle(1), path_transforms_neck);
    sweep(circle(0.75), path_transforms_neck);
    };

  multmatrix(neck(1-2*step)) {
  rotate([-90,0,0])
  difference() {
      sweep(circle(1), path_transforms_horn);
      sweep(circle(1), path_transforms_horn_inner);
    };
  };
//  multmatrix(neck(0)) {
//  rotate([-90,0,0])
//  translate([0,0,-1])
//  difference() {
//      sweep(circle(1), path_transforms_mouth);
//      sweep(circle(0.75), path_transforms_mouth);
//    };
//  };
};
