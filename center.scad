// Units are in mm
$fn=20;

height = 10;
bevel = 7.5;
holder_height_ratio = 2/3;
screw_hole_width = 3.34;
screw_head_width = 8;

edge_length = 40;
center_width = sqrt(pow(edge_length / 2, 2) + pow(bevel, 2));

module edge_indent() {
    indent_width = (sqrt(2) / 2) * edge_length - bevel;
    indent_height = 2 * height * holder_height_ratio + 1;
    rotate([0, 0, 45]) {
        translate([-indent_width / 2, -indent_width / 2, -1]) {
            cube([indent_width, indent_width, indent_height / 2]);
        }
    }
}

module screw_hole() {
    union() {
        // Screw hole
        translate([0, 0, -1]) cylinder(h=height + 2, d=screw_hole_width);
        translate([0, 0, height / 2]) cylinder(h=height / 2 + 2, d=screw_head_width);
        translate([0, 0, height / 2 - 1.9]) cylinder(h=2, d1=screw_hole_width, d2 = screw_head_width, center = false);
    }
}

rotate([0, 0, 0]) {
    edge_offset = edge_length / 2;
    difference() {
        cube([edge_length, edge_length, height], true);
        rotate([0, 0, 0]) translate([0, edge_length / 2, - height / 2]) edge_indent();
        rotate([0, 0, 90]) translate([0, edge_length / 2, - height / 2]) edge_indent();
        rotate([0, 0, 180]) translate([0, edge_length / 2, - height / 2]) edge_indent();
        rotate([0, 0, 270]) translate([0, edge_length / 2, - height / 2]) edge_indent();
        translate([0, 0, -height / 2]) screw_hole();
    }
}
