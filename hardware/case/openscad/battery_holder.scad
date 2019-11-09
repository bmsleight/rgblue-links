use <Thread_Library.scad>
include <sizes.scad>
use <roundedBoxSimple.scad>



module tube()
{
    translate([0,0,2-7/2])  difference()
    {
        union() {
            // translate([0,0,-1.5])  cylinder(h=1, d=7., center=true);
            translate([0,0,-1.75-0.8])   tubeSocket();
            // Chamfer
 // #          translate([0,0,-1.5+3])  cylinder(h=1, d1=7.+2, d2=7., center=true);
        }
        // Tube hole for wires
        cylinder(h=30, d=2.5, center=true);    
        // Hole for wires to edge fo box
        translate([0,7.5,0]) cube([2,15,30], center=true);
        // Hole for top tab of lid
        translate([0,5,-0.75]) cube([4.1,6,6], center=true);
        // make tube socket chamfer
        translate([0,0,0.3])  union() 
        {
            difference()
            {
                cylinder(h=4, d=20, center=true);    
                cylinder(h=4, d1=13, d2=6, center=true);    
            }
        }
    }
}          


module batteryBoxSub()
{
    difference()
    {
        // Make normal length
        translate([0,0,0])  roundedBoxSimple(x=box_x,y=box_y,z=box_z,d=curve_d);
        // cut off side door/lid
        translate([0,0-box_y+1,0])  cube([box_x*2,box_y,box_z*2],center=true);
        // cut out middle of box
        translate([0,-inner_space_y/2,0]) cube([inner_space_x,inner_space_y*2,inner_space_z], center=true);
        // Tube hole for wires
        translate([0,0,15])  cylinder(h=30, d=2.5, center=true);   
        // Hole for top tab of lid
        translate([0,-7.5,15]) cube([2,15,30], center=true);
        // Easier to print
//    #    translate([0,0,0.2]) cube([inner_space_x,7.,inner_space_z], center=true);
        
        
        translate([0,0,box_z/2+0.1-0.5])  cylinder(h=2, d=7, center=true);

        
*        union()
        {
            difference()
            {
                translate([0,0,box_z/2+0.1])  cylinder(h=2, d=13, center=true);
            }
        }

      translate([0,0,box_z/2])    cylinder(h=box_z-2, d=6, center=true);    

    }
//#        translate([0,-0.,0]) cube([box_x,box_y,box_z], center=true);
}

module batteryBox(printSupports=false, printBetter=false)
{
    difference()
    {
        union()
        {
            translate([0,0,-5]) batteryBoxSub();
            translate([0,0,3.5-1+0.2]) rotate([0,0,180]) tube();
        }
        // Print better
        if (printBetter)
            {
                translate([0,0,-5+0.2]) cube([inner_space_x,7.,inner_space_z], center=true);
                translate([0.,0,-5+0.4]) cube([6.75,7,inner_space_z], center=true);
            }
    }
    if (printSupports)
    {
        printSupports();
    }
}

module tubeThread()
{
    rotate([0,0,-45/2]) trapezoidThread( 
        length=2,
        pitch= 1,
        // Change from 2.75 to 2mm
        pitchRadius=2.5,
        clearance=0.2,
        backlash=0.3,
        stepsPerTurn = 60
    );
}

module tubeSocket() {
    difference()
    {
        cylinder(h=4, d=13., centre=true);
        translate([0,0,-5]) 
            trapezoidThreadNegativeSpace(
                length=10,
                pitch= 1,
                // Change from 2.75 to 2mm
                pitchRadius=3,
                stepsPerTurn = 60
        
            );
    }
    
}

module printSupports()
{
    difference()
    {
        union()
        {
        //    scale([2,1,1]) translate([0,-6,-5])  rotate([-55,0,0]) cylinder(h=14, d=2, center=true);
            translate([0,-7,-5.])  rotate([-45,0,0]) cube([3,0.75,20], center=true);
            translate([0,-12.5,-9.])  cylinder(h=2, d=4, center=true);
            translate([0,-9.75,-5.])  rotate([-30,0,0]) cube([3,1,20], center=true);
        }
        translate([0,-0.,-20-9.5])  cube([40,40,40], center=true);
        translate([0,-0.,+20-1.5])  cube([40,40,40], center=true);
    }
}


// Printed with 3mm brim, no raft. 
// Meshmaxer supports
batteryBox(printSupports=true, printBetter=true);
