use <Thread_Library.scad>
include <sizes.scad>
use <roundedBoxSimple.scad>


$fn=100;


module tube()
{
    difference()
    {
        union() {
            translate([0,0,-11])  cylinder(h=12, d=6.5, center=true);
            translate([0,0,2-10+3.])  tubeThread();
            
            translate([0,0,-7.5-(19/2)+1.75])
            {
//                cylinder(h=2, d1=6.5+4, d2=6.5, center=true);
            }

        }
        // Change from 3.5 to 3mm
        cylinder(h=50, d=2.5, center=true);    
    }
}

module bottomCase(full=true)
{
    difference()
    {
        if (full==true)
        {
            //cube([box_x,box_y,box_z-1], center=true); 
            roundedBoxSimple(x=box_x,y=box_y,z=box_z-2,d=curve_d); //# -2 for lid
        }
        else
        {
            translate([0,0,4.5]) cube([box_x,box_z,1], center=true);
        }
        translate([0,0,-2]) cube([inner_space_x,inner_space_y,inner_space_z+2], center=true);
        // Easier to print         // Change from 3.5 to 3mm
        translate([0,0,15])  cylinder(h=30, d=2.5, center=true);   
    }
}


module tubeSocket() {
    difference()
    {
        cylinder(h=5, d=7., centre=true);
        translate([0,0,-5]) 
            trapezoidThreadNegativeSpace(
                length=10,
                pitch= 1,
                // Change from 2.75 to 2mm
                pitchRadius=2.5,
                stepsPerTurn = 60
        
            );
    }
    
}

module tubeThread()
{
    rotate([0,0,45/2-45/2]) trapezoidThread( 
        length=4,
        pitch= 1,
        // Change from 2.75 to 2mm
        pitchRadius=3.,
        clearance=0.1,
        backlash=0.3,
        stepsPerTurn = 60
    );
}


module middle(printBetter=false)
{
    difference()
    {
        union()
        {
            translate([0,0,-5]) bottomCase();
            translate([0,0,12.5+2+0.2]) tube();
        }
        if (printBetter)
            {
                // Easier to print         // Change from 3.5 to 3mm
  #              translate([0,0,-6.0 + 0.2]) cube([inner_space_x,2.5,inner_space_z], center=true);
  #              translate([0,0,-6.0 + 0.4]) cube([2.5,2.5,inner_space_z], center=true);
            }
    }   
}



// Print with brim 
rotate([0,0,0]) middle(printBetter=true);