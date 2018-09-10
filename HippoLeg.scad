thickness = 7.5;
top_radius = 22/2;
bottom_radius=12/6;
foot_radius=15/2;
leg_height = 40 - foot_radius*2;
left_leg = false;

joint_radius = 9.9/2;
joint_end_radius = joint_radius + 0.5;
joint_depth = 8.4;
joint_end_depth = 2.9;
slice_width = 2.2;

$fs = 0.5;
$fa = 6;

//projection()
both_legs();

// Original leg size
%cube(size=[40, 25, thickness], center=false);
// TODO Fit inside bounding box
// TODO thicker leg below the joint? (10mm)

module both_legs() {
    translate([top_radius, top_radius, 0])
    color("SaddleBrown") {
        union() {

            // Leg
            leg_body();

            // Connection
            translate([0, 0, thickness]) {
                leg_joint();
            }
        }

        union() {
            // Leg
            translate([0, top_radius * 3, thickness]) {
                rotate([180, 0, 0]) {
                    leg_body();
                }
            }

            // Connection
            translate([0, top_radius * 3, thickness]) {
                leg_joint();
            }
        }
    }
}


module leg_body() {
    union() {
        //Leg
        hull() {
            cylinder(thickness, r=top_radius, center = false);
            translate([leg_height, 0, 0]) {
                cylinder(thickness, r=bottom_radius, center = false);
            }
        }
        // Foot
        translate([leg_height - foot_radius/2, 0, 0]) {
            rotate([0, 0, 90]) {
                hull() {
                    cylinder(thickness, r=foot_radius, center = false);
                    translate([foot_radius, -foot_radius/2, 0]) {
                        cylinder(thickness, r=foot_radius/2, center = false);
                    }
                }
            }
        }
    }
}



module leg_joint() {
    color("brown");

    difference() {
        union() {
            cylinder(joint_depth, r=joint_radius, center=false, $fn=8);
            translate([0, 0, joint_depth]) {
                cylinder(joint_end_depth/2, r=joint_end_radius, center=false);
            }
            
            translate([0, 0, joint_depth + joint_end_depth/2])
            cylinder(joint_end_depth/2, r1=joint_end_radius, r2=joint_radius, center=false);
        };
        union() {
            translate([-joint_end_radius, -slice_width/2, 1]) {
                cube([joint_end_radius*2, slice_width, joint_depth + joint_end_depth + 1], center=false);
            }
            translate([0, 0, 1]) {
                cylinder(joint_end_depth+joint_depth + 1, joint_radius*0.7, joint_radius*0.9, center=false);
            }
        }
    }    
}
