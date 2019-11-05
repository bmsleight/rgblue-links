use <Thread_Library.scad>
include <sizes.scad>
use <roundedBoxSimple.scad>



module tube()
{
    translate([0,0,2-7/2])  difference()
    {
        union() {
            translate([0,0,-1.5])  cylinder(h=1, d=7., center=true);
            translate([0,0,-1])   tubeThread();
            // Chamfer
            translate([0,0,-1.5])  cylinder(h=1, d1=7.+2, d2=7., center=true);
        }
        // Change from 3.5 to 3mm
        cylinder(h=30, d=2.5, center=true);    
        translate([0,7.5,0]) cube([2,15,30], center=true);
        translate([0,7.5,0]) cube([2,15,30], center=true);
        translate([0,5,-1.25]) cube([4.1,5.75,1], center=true);
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
        translate([0,-inner_space_y/2,0]) cube([inner_space_x,inner_space_y*2,inner_space_z], center=true);
        translate([0,0,15])  cylinder(h=30, d=2.5, center=true);   
        translate([0,-7.5,15]) cube([2,15,30], center=true);
        // Easier to print
        translate([0,0.25,0.2]) cube([inner_space_x,2.,inner_space_z], center=true);
    }
//#        translate([0,-0.,0]) cube([box_x,box_y,box_z], center=true);
}

module batteryBox(printSupports=true)
{
    translate([0,0,-5]) batteryBoxSub();
    translate([0,0,3.5-1+0.2]) rotate([0,0,180]) tube();
    if (printSupports)
    {
        printSupports();
    }
}

module tubeThread()
{
    trapezoidThread( 
        length=5,
        pitch= 1,
        // Change from 2.75 to 2mm
        pitchRadius=2.5,
        clearance=0.2,
        backlash=0.3,
        stepsPerTurn = 60
    );
}

module printSupports()
{
    difference()
    {
        union()
        {
        //    scale([2,1,1]) translate([0,-6,-5])  rotate([-55,0,0]) cylinder(h=14, d=2, center=true);
            translate([0,-6.,-5.])  rotate([-55,0,0]) cube([3,0.75,20], center=true);
            translate([0,-12.5,-9.])  cylinder(h=2, d=4, center=true);
            translate([0,-9.75,-5.])  rotate([-30,0,0]) cube([3,1,20], center=true);
        }
        translate([0,-0.,-20-9.5])  cube([40,40,40], center=true);
        translate([0,-0.,+20-1.5])  cube([40,40,40], center=true);
    }
}


// Printed with 3mm brim, no raft. 
// Meshmaxer supports
batteryBox();