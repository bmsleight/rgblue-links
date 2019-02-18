module roundedBoxSimple(x=1,y=1,z=1,d=1)
{
    hull()
    {
              translate([x/2-d/2,y/2-d/2,0]) cylinder(d=d, h=z, center=true);
              translate([x/2-d/2,-y/2+d/2,0]) cylinder(d=d, h=z, center=true);
              translate([-x/2+d/2,y/2-d/2,0]) cylinder(d=d, h=z, center=true);
              translate([-x/2+d/2,-y/2+d/2,0]) cylinder(d=d, h=z, center=true);
    }
}

// https://gist.github.com/groovenectar/292db1688b79efd6ce11
module roundedcube_simple(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}
