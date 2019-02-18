use <Thread_Library.scad>
include <sizes.scad>
use <roundedBoxSimple.scad>


module tube()
{
    difference()
    {
        union() {
            translate([0,0,-7.5])  cylinder(h=19, d=7.5, center=true);
            translate([0,0,2])  tubeSocket();
        }
        cylinder(h=50, d=3.5, center=true);    
    }
}

module bottomCase(full=true)
{
    difference()
    {
        if (full==true)
        {
            roundedBoxSimple(x=box_x,y=box_y,z=box_z-2,d=curve_d); //# -2 for lid
        }
        else
        {
            translate([0,0,4.5]) cube([box_x,box_z,1], center=true);
        }
        translate([0,0,-2]) cube([inner_space_x,inner_space_y,inner_space_z+2], center=true);
        translate([0,0,15])  cylinder(h=30, d=3.5, center=true);   
        // Easier to print
        translate([0,0,-0.8]) cube([inner_space_x,3.5,inner_space_z], center=true);
    }
}


module tubeSocket() {
    difference()
    {
        cylinder(h=5, d=7.5, centre=true);
        translate([0,0,-5]) 
            trapezoidThreadNegativeSpace(
                length=10,
                pitch= 1,
                pitchRadius=2.75
            );
    }
    
}

module middle()
{
    translate([0,0,-5]) bottomCase();  
    translate([0,0,12.5+2+0.2]) tube();
}



// Print with brim 
rotate([0,0,0]) middle();