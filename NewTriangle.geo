// Gmsh project created on Mon Oct 05 23:36:22 2020
SetFactory("OpenCASCADE");

// Parameters
r1a = 2;        // Characteristic dimensions
r1b = 5;
mesh = 1; //mesh size inside the bow ties 

Point(1) = {0, 0, 0, mesh};
Point(2) = {r1a*Cos(Pi/6), r1a*Sin(Pi/6), 0, mesh};
Point(3) =  {-r1a*Cos(Pi/6), r1a*Sin(Pi/6), 0, mesh};
Point(4) = {0, -r1a, 0, mesh};

// All arcs of the circle
Circle(1) = {2, 1, 3};      // Top arc
Circle(2) = {3, 1, 4};     // LH bottom arc
Circle(3) = {4, 1, 2};     // RH bottom arc

// Now move them - this makes new Points, 5-10
Translate {0, r1b, 0} { Curve{1}; }  // Move Top arc
Translate {-r1b*Cos(Pi/6), -r1b*Sin(Pi/6), 0} { Curve{2}; }  // Move LH bottom arc
Translate {+r1b*Cos(Pi/6), -r1b*Sin(Pi/6), 0} { Curve{3}; } // Move RH bottom arc

// Connect the sides of the triangle 
Line(4) = {10, 5}; // RH 
Line(5) = {6, 7}; // LH
Line(6) = {8, 9}; // Bottom 

// Curve Loop replaced Line Loop in GMSH 4.0
Curve Loop(10) = {1, 5, 2, 6, 3, 4};    // Domain border 

Plane Surface(1) = {10};   // Make the surface, this can translated, rotated





