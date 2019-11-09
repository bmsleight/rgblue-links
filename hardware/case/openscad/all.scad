use <battery_holder.scad>;
use <lid.scad>;
use <middle.scad>;
use <top_lid.scad>;


include <sizes.scad>

difference()
{
    union()
    {
        batteryBox();
        translate([0,-box_y/2+0.5,-box_z/2-0.5]) rotate([90,0,180]) lid();
        translate([0,0,12.35]) rotate([180,0,0]) middle();
        translate([0,0,20.9+0.45]) rotate([180,0,0]) topLid();
    }
//    translate([50,-50,0]) cube([100,100,100], center=true);
}