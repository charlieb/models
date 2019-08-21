shelf_w = 250;
shelf_d = 75; //depth
shelf_h = 25;
wall_w = 5;


// toothbrush holder
toothb_d = 35;
toothb_h = 45;

module toothbrush_holder_vol(d,h) {
  rotate([0,50,0])
  cylinder(d=d+wall_w * 2, h=h);
};

module toothbrush_holder(d,h) {
  rotate([0,50,0])
    difference() {
      cylinder(d=d+wall_w * 2, h=h);
      translate([0,0,wall_w]) cylinder(d=d, h=h);
    }
};

translate([shelf_w/2 - toothb_d / 2  -wall_w, shelf_d / 2, -toothb_h/2])
  toothbrush_holder(toothb_d, toothb_h);
translate([shelf_w/2 - toothb_d / 2  -wall_w, -3 , -toothb_h/2])
  toothbrush_holder(toothb_d, toothb_h);

//shelf
difference() {
  cube([shelf_w, shelf_d, shelf_h], center=true);
  translate([0,0,wall_w]) cube([shelf_w - wall_w * 2, shelf_d - wall_w * 2, shelf_h], center=true);
  translate([shelf_w/2 - toothb_d / 2  -wall_w, shelf_d / 2, -toothb_h/2])
    toothbrush_holder_vol(toothb_d, toothb_h);
  translate([shelf_w/2 - toothb_d / 2  -wall_w, -3, -toothb_h/2])
    toothbrush_holder_vol(toothb_d, toothb_h);
};
