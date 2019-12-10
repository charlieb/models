
module outline(dxf,r) {
  difference() {
    minkowski() {
      import(dxf);
      circle(r=r);
    }
    import(dxf);//, layer=layer);
  }
}

plate_z = 1; //3;
relief_z = 0.6;

union() {
translate([0,0,plate_z]) linear_extrude(height=relief_z) import("daisy_plain.svg");
linear_extrude(height=plate_z) square(size = [100,160], center = false);

//translate([0,0,plate_z]) linear_extrude(height=relief_z) import("minnie_bow_spots_test.svg");
linear_extrude(height=plate_z) square(size = [120,170], center = false);
}

