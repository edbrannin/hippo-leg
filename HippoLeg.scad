thickness = 10;
top_radius = 20;
leg_height = 40;
bottom_radius=10;
foot_radius=10;
left_leg = false;

joint_radius = 10;
joint_end_radius = 11;
joint_depth = 5;
joint_end_depth = 2;
slice_width = 2;

color("brown");


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
    translate([0, thickness * 5, thickness]) {
        rotate([180, 0, 0]) {
            leg_body();
        }
    }
    
    // Connection
    translate([0, thickness * 5, thickness]) {
        leg_joint();
    }
}



module leg_body() {
    hull() {
        cylinder(thickness, r=top_radius, center = false);
        translate([leg_height, 0, 0]) {
            cylinder(thickness, r=bottom_radius, center = false);
        }
    }
    // Foot
    translate([leg_height + foot_radius/4, 0, 0]) {
        difference() {
            rotate([0, 0, 90]) {
                hull() {
                    cylinder(thickness, r=foot_radius, center = false);
                    translate([foot_radius, 0, 0]) {
                        cylinder(thickness, r=foot_radius/2, center = false);
                    }
                }
            };
            translate([0, -foot_radius, 0]) {
                cube([foot_radius, foot_radius * 2.5 + 1, thickness + 1]);
            }
        }
    }
}


module leg_joint() {
    color("brown");

    difference() {
        union() {
            cylinder(joint_depth, r=joint_radius, center=false);
            translate([0, 0, joint_depth]) {
                cylinder(joint_end_depth, r=joint_end_radius, center=false);
            }
        };
        union() {
            translate([-joint_end_radius, -slice_width/2, -0.5]) {
                cube([joint_end_radius*2, slice_width, joint_depth + joint_end_depth + 1], center=false);
            }
            translate([0, 0, -0.5]) {
                cylinder(joint_end_depth+joint_depth + 1, r=joint_radius*0.9, center=false);
            }
        }
    }    
}

leg_joint(joint_depth, joint_radius, joint_end_radius, slice_width);
