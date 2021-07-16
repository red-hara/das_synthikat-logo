function solve_t(p, r, q, s) = cross(q-p, s) / cross(r, s);
function do_intersect(p, r, q, s) = p + r*solve_t(p, r, q, s);
function intersect(a, b, c, d) = do_intersect(a, b-a, c, d-c);
function angle(a, b) = atan2(b[1]-a[1], b[0]-a[0]) - 90;
function distance(a, b) = sqrt(
    pow(a[0] - b[0], 2) +
    pow(a[1] - b[1], 2)
);

radius = 120;
width = 10;

vertices_0 = [
    1.5*radius*[cos(0), sin(0)],
    0.75*radius*[cos(150), sin(150)],
    radius*[cos(-150), sin(-150)],
];

vertices_1 = [
    1.5*radius*[cos(120), sin(120)],
    0.75*radius*[cos(120 + 150), sin(120 + 150)],
    radius*[cos(120 - 150), sin(120 - 150)]
];

vertices_2 = [
    1.5*radius*[cos(-120), sin(-120)],
    0.75*radius*[cos(-120 + 150), sin(-120 + 150)],
    radius*[cos(-120 - 150), sin(-120 - 150)]
];

module triangle(v_0, v_1, v_2) {
    difference() {
        union() {
            translate(v_0[0]) circle(d=width);
            translate(v_0[1]) circle(d=width);
            translate(v_0[2]) circle(d=width);
            translate(v_0[0]) rotate(angle(v_0[0], v_0[1])) translate([-width/2, 0]) square([width, distance(v_0[0], v_0[1])]);
            translate(v_0[1]) rotate(angle(v_0[1], v_0[2])) translate([-width/2, 0]) square([width, distance(v_0[1], v_0[2])]);
            translate(v_0[2]) rotate(angle(v_0[2], v_0[0])) translate([-width/2, 0]) square([width, distance(v_0[2], v_0[0])]);
        }
        translate(intersect(v_0[0], v_0[1], v_2[0], v_2[1])) rotate(angle(v_2[0], v_2[1])) square(width*[2, 3], center=true);
        translate(intersect(v_0[0], v_0[1], v_2[0], v_2[2])) rotate(angle(v_2[0], v_2[2])) square(width*[2, 3], center=true);
        translate(intersect(v_0[0], v_0[2], v_2[0], v_2[2])) rotate(angle(v_2[0], v_2[2])) square(width*[2, 3], center=true);
        translate(intersect(v_0[0], v_0[2], v_2[0], v_2[1])) rotate(angle(v_2[0], v_2[1])) square(width*[2, 6], center=true);
    }
}

union() {
    triangle(vertices_0, vertices_1, vertices_2);
    triangle(vertices_1, vertices_2, vertices_0);
    triangle(vertices_2, vertices_0, vertices_1);
}
