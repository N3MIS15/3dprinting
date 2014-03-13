// Prusa I3 E3D-v5 Auto Levelling Carriage
// Created by David "N3MIS15" Gray 2014

heatsink_outer		= 16;		// Outside of nozzle mounting groove
heatsink_inner		= 12;		// Inside of nozzle mounting groove
bowden_hotend		= true;		// If you have Bowden version or not ("false" requires carriage to be tapped)
heatsink_bolt		= 4;		// Bolt size to hold heatsink (3 or 4mm)
heatsink_nut		= 7.66;		// Nut size from point to point (M3=6.01, M4=7.66)
bowden_thread		= 11;		// Hole size for bowden mount (8.8 if using 1/8" BSP tap)
heatsink_side_fan	= true;		// Add fan on heatsink side
servo_side_fan		= true;		// Add fan on servo side
heatsink_fan		= false;	// Add fan to cool heatsink
servo_hole			= 7.11;		// Servo hole on servo arm
hole_padding		= 0.7;		// Extra allowance on holes (3mm hole becomes 3mm+padding)




// Heatsink bolt offsets
hsb_x_offset = (heatsink_inner/2)+(heatsink_bolt/2);
hsb_z_offset = -7+(5.75+(heatsink_bolt/2));

module fan() {
	difference(){
		translate([-3, 0, 0]) cube([56,40,4], center=true);
		cylinder(h=5, r=19, center=true, $fn=30);
		translate([-16, -16, 0]) cylinder(h=5, r=1.5+(hole_padding/2), center=true, $fn=30);
		translate([-16, 16, 0]) cylinder(h=5, r=1.5+(hole_padding/2), center=true, $fn=30);
		translate([8, 0, 0]) cube([40,41,5], center=true);
	}
}

module servo_box() {
	difference(){
		if(bowden_hotend == true) {
			translate([-28.75, -5, 13]) cube([19.5,50,40], center=true);
		}
		else {
			translate([-28.75, -5, 10]) cube([19.5,50,46], center=true);
		}
		translate([-29.25, -3.5, 13.5]) cube([13,47,39], center=true);
		translate([-29.25, -5, 13]) cube([13,50,23.5], center=true);
		translate([-29.25,0,-1]) rotate([90,0,0]) cylinder(h=65, r=1.5+(hole_padding/2), center=true, $fn=15);
		translate([-29.25,0,27]) rotate([90,0,0]) cylinder(h=65, r=1.5+(hole_padding/2), center=true, $fn=15);
		translate([-37, 7, 35]) rotate([90,0,90]) cylinder(h=10, r=35, center=true, $fn=6);
		translate([-21, 7, 15]) rotate([90,0,90]) cylinder(h=10, r=8, center=true, $fn=8);
	}
}

module main_body() {
	difference(){
		union() {
			if(bowden_hotend == true) {
				cube([40,40,14], center=true);
				translate([21, 0, 13]) cube([4,40,40], center=true);
			}
			else {
				translate([0, 0, -3]) cube([40,40,20], center=true);
				translate([21, 0, 10]) cube([4,40,46], center=true);
			}

			// Fan mount (heatsink)
			if(heatsink_fan == true) {	
				translate([0, -22, 26]) rotate([90,270,0]) fan();

				if(bowden_hotend == true) {
					translate([0, -22, 0]) cube([40,4,14], center=true);
					translate([21.5, -22, 3.5]) cube([3,4,21], center=true);
				}
				else {
					translate([0, -22, -3]) cube([40,4,20], center=true);
					translate([21.5, -22, 0.5]) cube([3,4,27], center=true);
				}

				// Heatsink bolt dimples
				translate([-hsb_x_offset,-24.5,hsb_z_offset]) rotate([90,0,180]) cylinder(h=1, r1=(heatsink_bolt*1.75)/2, r2=(heatsink_bolt*2.25)/2, center=true, $fn=30);
				translate([hsb_x_offset,-24.5,hsb_z_offset]) rotate([90,0,180]) cylinder(h=1, r1=(heatsink_bolt*1.75)/2, r2=(heatsink_bolt*2.25)/2, center=true, $fn=30);
			}
			else {
				// Heatsink bolt dimples
				translate([-hsb_x_offset,-20.5,hsb_z_offset]) rotate([90,0,180]) cylinder(h=1, r1=(heatsink_bolt*1.75)/2, r2=(heatsink_bolt*2.25)/2, center=true, $fn=30);
				translate([hsb_x_offset,-20.5,hsb_z_offset]) rotate([90,0,180]) cylinder(h=1, r1=(heatsink_bolt*1.75)/2, r2=(heatsink_bolt*2.25)/2, center=true, $fn=30);
			}

			// Fan mount (heatsink side)
			if(heatsink_side_fan == true) {
				translate([38.8, 0, 50]) rotate([0,-45,0]) fan();
			}

			// Fan mount (servo side)
			if(servo_side_fan == true) {
				translate([-38.8, 0, 50]) rotate([0,-45,180]) fan();
			}

			// Back wall
			translate([0, 17.5, 20]) cube([38,5,26], center=true);
		}

		// CUTOUTS
		// Bowden thread
		translate([0,-5,]) cylinder(h=30, r=bowden_thread/2, center=true, $fn=30);

		// Heatsink Hole
		translate([0,-5,1]) cylinder(h=12, r=(heatsink_outer/2)+(hole_padding/2), center=true, $fn=60);

		// Carriage mount holes
		translate([-15,0,0]) rotate([90,0,0]) cylinder(h=60, r=1.5+(hole_padding/2), center=true, $fn=30);
		translate([-15,-15,0]) rotate([90,0,0]) cylinder(h=40, r=3+(hole_padding/2), center=true, $fn=30);
		translate([15,0,0]) rotate([90,0,0]) cylinder(h=60, r=1.5+(hole_padding/2), center=true, $fn=30);
		translate([15,-15,0]) rotate([90,0,0]) cylinder(h=40, r=3+(hole_padding/2), center=true, $fn=30);

		// Heatsink bolts
		translate([-hsb_x_offset,0,hsb_z_offset]) rotate([90,0,0]) cylinder(h=60, r=(heatsink_bolt/2)+(hole_padding/2), center=true, $fn=30);
		translate([hsb_x_offset,0,hsb_z_offset]) rotate([90,0,0]) cylinder(h=60, r=(heatsink_bolt/2)+(hole_padding/2), center=true, $fn=30);

		// Heatsink nuts
		translate([-hsb_x_offset,16.1,hsb_z_offset]) rotate([90,90,0]) cylinder(h=8, r=(heatsink_nut/2)+(hole_padding/2), center=true, $fn=6);
		translate([hsb_x_offset,16.1,hsb_z_offset]) rotate([90,90,0]) cylinder(h=8, r=(heatsink_nut/2)+(hole_padding/2), center=true, $fn=6);

		// Back wall
		translate([0, -2.5, 21]) cube([38,36,28], center=true);
		translate([0, -2.5, 33]) rotate([90,0,0]) cylinder(h=60, r=19, center=true, $fn=6);
	}
	servo_box();
}

module servo_arm() {
	difference(){
		union() {
			cylinder(h=4.5, r=5.5, center=true, $fn=30);
			translate([0, -19.5, 0]) cube([11,39,4.5], center=true);
			translate([0, -42, 0]) cube([20,8,4.5], center=true);
		}

		// CUTOUTS
		// Servo hole
		cylinder(h=4.5, r=(servo_hole/2)+(hole_padding/2), center=true, $fn=30);

		translate([0, 0, 1.5]) {
			hull() {
				cylinder(h=1.5, r=3+(hole_padding/2), center=true, $fn=30);
				translate([0, -16.5, 0]) cylinder(h=1.5, r=2+(hole_padding/2), center=true, $fn=30);
			}
		}

		// Endstop holes
		translate([0, -42, 0]) {
			translate([5, 0, 0]) cylinder(h=4.5, r=1.5+(hole_padding/2), center=true, $fn=30);
			translate([-5, 0, 0]) cylinder(h=4.5, r=1.5+(hole_padding/2), center=true, $fn=30);
		}
	}
}

main_body();
//servo_arm();