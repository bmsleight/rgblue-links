use <battery_holder.scad>;
include <sizes.scad>


module point()
{
    translate([0,0,-7.5*2-3.2])  difference()
    {
        union()
        {
            translate([0,0,+7.5*2+3.2]) tube();
            cylinder(h=7.5, d1=0, d2=7.5);
            translate([0,0,7.5]) cylinder(h=7.5, d=7.5);
        }
       translate([0,3.5*2-1,+7.5*2+3.2-4.5-1.2+5+0.5]) cube([3.5,3.5*4,20], center=true);
       translate([0,3/2,+7.5*2+3.2-4.5-1.2+5]) cube([3.5,3,20], center=true);    }
}

rotate([-90,180,0]) point();
