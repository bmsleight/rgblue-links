use <Thread_Library.scad>
include <sizes.scad>
use <roundedBoxSimple.scad>



module tube()
{
    translate([0,0,2-7/2])  difference()
    {
        union() {
            // translate([0,0,-1.5])  cylinder(h=1, d=7.5, center=true);
            translate([0,0,-1.7])   tubeThread();
        }
        cylinder(h=30, d=2., center=true);    
        translate([0,7.5,0]) cube([2,15,30], center=true);
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
        translate([0,0,15])  cylinder(h=30, d=2., center=true);   
        translate([0,-7.5,15]) cube([2,15,30], center=true);
        // Easier to print
        translate([0,0,0.2]) cube([inner_space_x,3.5,inner_space_z], center=true);
    }
//#        translate([0,-0.,0]) cube([box_x,box_y,box_z], center=true);
}

module batteryBox()
{
    translate([0,0,-5]) batteryBoxSub();
    translate([0,0,3.5-1+0.2]) rotate([0,0,180]) tube();
}

module tubeThread()
{
    trapezoidThread( 
        length=5,
        pitch= 1,
        pitchRadius=2.75,
        clearance=0.2,
        backlash=0.3
    );
}



// Printed with 3mm brim, no raft. 
// Meshmaxer supports
rotate([-90,0,0]) batteryBox();