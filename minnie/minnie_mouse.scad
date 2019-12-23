
module outline(dxf,r) {
  difference() {
    minkowski() {
      import(dxf);
      circle(r=r);
    }
    import(dxf);//, layer=layer);
  }
}

plate_z = 2; //3;
relief_z = 0.7;

union() {
// Minnie gets an error when she's unioned with the plate so export the two
// separately and combine them in the slicer.
//translate([5,2,plate_z]) linear_extrude(height=relief_z + plate_z) import("minnie_plain.svg");

//The others need one import and the plate
//translate([20,5,plate_z]) linear_extrude(height=relief_z) import("daisy_plain.svg");
translate([20,5,plate_z]) linear_extrude(height=relief_z) scale([0.95,0.95]) import("clarabel_plain.svg");

// The plate
linear_extrude(height=plate_z) square(size = [130,170], center = false);
}

