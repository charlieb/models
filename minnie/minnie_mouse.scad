
module outline(dxf,r) {
  difference() {
    minkowski() {
      import(dxf);
      circle(r=r);
    }
    import(dxf);//, layer=layer);
  }
}

plate_z = 3;
relief_z = 0.6;

union() {
  linear_extrude(height=plate_z + relief_z) outline("minnie_outline.dxf", 1.4);
  //linear_extrude(height=plate_z + relief_z) outline("minnie_bow_spots.dxf", 1.4);
  //linear_extrude(height=plate_z + relief_z) outline("minnie_bow_spots_test.svg", 1.4);
  }
  linear_extrude(height=plate_z + relief_z) import("minnie_bow_spots_test.svg");
