include <sizes.scad>
use <roundedBoxSimple.scad>

$fn=100;


module lid()
{
    difference()
    {
        union()
        {
        translate([0,0,box_y/2-0.5])  difference()
            {
              translate([0,0,0])  rotate([90,0,0]) roundedBoxSimple(x=box_x,y=box_y, z=box_z,d=curve_d);
              translate([0,0,1])  rotate([90,0,0]) cube([box_x*2,box_y, box_z*2],center=true);

            }
//            cube([box_x,box_z,1], center=true);
             translate([0,3.5,2.5]) cube([1.5,3,6], center=true);
             translate([0,5.,3.75]) cube([4,1,8.5], center=true);
            difference()
            {
                // Some trial and error reduction for snap fit
               translate([0,0,1])  roundedcube_simple([inner_space_x-0.2,inner_space_z-0.4, 2.5], center=true, radius = 1);
               translate([0,0,-1.5]) cube([box_x,box_z,4], center=true);
            }

        }
        translate([0,0,3.5]) cube([inner_space_x-2,inner_space_z-2,6], center=true);
        translate([0,0,8.5]) rotate([90,0,0]) cylinder(h=20, d=7.5+0.1, center=true);
    }
}




// Print brim and supports
rotate([90,180,45]) lid();
