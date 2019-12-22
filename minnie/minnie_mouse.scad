
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
translate([20,5,plate_z]) linear_extrude(height=relief_z) import("daisy_plain.svg");
linear_extrude(height=plate_z) square(size = [130,170], center = false);

//translate([0,0,plate_z]) linear_extrude(height=relief_z) import("minnie_bow_spots_test.svg");
//linear_extrude(height=plate_z) square(size = [130,170], center = false);
}

