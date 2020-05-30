module outline(r) {
  difference() {
    minkowski() {
      children();
      circle(r=r);
    }
    children();
  }
}

scale([0.50,0.50,1])
union() {
  linear_extrude(height=7)  import("firetruck.svg");
  linear_extrude(height=1) minkowski() { import("firetruck.svg"); circle(r=2); }
  //linear_extrude(height=5.5) import("toothless_detail.svg");
  //linear_extrude(height=1) minkowski() { import("toothless_detail.svg"); circle(r=2); }

  //translate([55,0,0]) cube([10,80,1]);
  //translate([10,20,0]) cube([100,15,1]);
}
