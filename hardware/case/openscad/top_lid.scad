include <sizes.scad>
use <roundedBoxSimple.scad>


module topLid()
{
    difference()
    {
        union()
        {
            translate([0,0,-0.5])   roundedBoxSimple(x=box_x,y=box_y,z=2,d=curve_d);
            translate([0,0,1]) roundedcube_simple([inner_space_x+0.1,inner_space_y+0.2 , 2.5], center=true, radius = 1); 
        }
//        translate([0,0,3.5]) cube([inner_space_x-2,inner_space_y-2,6], center=true);
#        translate([0,0,1.9]) cube([inner_space_x-2,inner_space_y-2,6], center=true);
//#        cylinder(h=30, d=3.5, center=true);    

    }
}



// Printed with 3mm brim, no raft. 
rotate([0,0,0]) topLid();
