// Making islands of different shapes on MoS2
//  This is for Julia Hoang's project 
//  Goal is to draw circles, rounded triangle, and rounded rectangles 
//  It will be convenient to define positions with parameters

// Use of OpenCASCADE makes geometry and mesh construction much easier
//  Note that when you make the .msh file you have to ask for an old
//    file format with -format msh2 for the current version of meshio-convert to work
SetFactory("OpenCASCADE");
Mesh.CharacteristicLengthMin = 0.5;
Mesh.CharacteristicLengthMax = 4.0;


// Variable and parameters
//  a and b set width and height of domain 
//  width will be 2*a and height will be 2*b
//  Nominal units of nm

a = 75.0; b = 75.0;         // Width and Height of simulation domain
mesh = 1.0;                  // For hand-drawn objects
                  
x1 = -50.0;  y1 = +40.0;    // Center of first object
x2 = +00.0;  y2 = +00.0;    // Center of second object
x3 = -40.0;  y3 = -60.0;    // Center of third object
x4 = +35.0;  y4 = -65.0;    // Center of fourth object

// Characteristic sizes
//  Disks have just one, the radius
//  Triangles there are two: height and corner radius
//  For rectangles there are three: width, height, and corner radius
r1a =  6.0;                        // For the circles
r2a =  8.0; r2b = 2.0;             // For the triangles
r3a = 11.0; r3b = 5.0;             // For a square   
r4a = 14.0; r4b = 20; r4c = 4.0;   // For rectangle

Printf("Domain is %g by %g", 2*a, 2*b);
Printf("Object 1 at = (%g, %g) size %g", x1, y1, r1a);
Printf("Object 2 at = (%g, %g) size %g, %g", x2, y2, r2a, r2b);

// Try to draw the triangle first
//  Doing it later was throwing errors

// Make the center and 3 points on a circle, spaced by 120 degreees
Point(1) = {x2, y2, 0, mesh};
Point(2) = {x2 + r2b*Cos(Pi/6), y2 + r2b*Sin(Pi/6), 0, mesh};
Point(3) =  {x2 -r2b*Cos(Pi/6), y2 + r2b*Sin(Pi/6), 0, mesh};
Point(4) = {x2, y2 - r2b, 0, mesh};

// Three arcs of the circle
Circle(1) = {2, 1, 3};      // Top arc
Circle(2) = {3, 1, 4};     // LH bottom arc
Circle(3) = {4, 1, 2};     // LH bottom arc

// Now move them - this makes new Points, 5-10
Translate {0, r2a, 0} { Curve{1}; }   
Translate {-r2a*Cos(Pi/6), -r2a*Sin(Pi/6), 0} { Curve{2}; }  
Translate {+r2a*Cos(Pi/6), -r2a*Sin(Pi/6), 0} { Curve{3}; }  

// Connect the sides of the triangle 
Line(4) = {10, 5};
Line(5) = {6, 7};
Line(6) = {8, 9};

// Draw the triangle - its sides and its rounded corngers
Curve Loop(10) = {1, 5, 2, 6, 3, 4};    // Curve Loop replaced Line Loop in GMSH 4.0 
Plane Surface(10) = {10};   // Make the surface, this can translated, rotated, meshed

// Now Rotate, Duplicate, and Translate the triangle
//  For Rotate, first argument is the axis, z in this case
//  Second axis is rotation 
Rotate {{0, 0, 1}, {x2, y2, 0}, Pi/2} { Surface{10}; }
Translate {+14.0, 0, 0} { Duplicata{Surface{10};} }      // This makes surface 11
Rotate {{0, 0, 1}, {x2, y2, 0}, Pi} { Surface{10}; }
Translate {-14.0, 0, 0} { Surface{10}; } 

// Use OpenCASCADE to create more Surfaces

// Make the domain first
Rectangle(1) = {-a,-b, 0, 2*a, 2*b};        // The domain - Surface 1

// Now make a circle 
Disk(2) = {x1, y1, 0, r1a, r1a};              // Circular island - Surface 2

// Now make a square and a rectangle - so at this point there are 4 surfaces plus the two triangles
Rectangle(3) = {x3, y4, 0, 2*r3a, 2*r3a, r3b};
Rectangle(4) = {x4, y4, 0, 2*r4a, 2*r4b, r4c};

// Demonstrate some more Surface modification commands
Dilate {{x4, y4, 0}, {0.75, 0.85, 0}} { Surface{4}; }    // Make the rectangle smaller

// Now, subtract the islands from Surface 1
// This will delete overlapping regions and make a new Surface
// You can decide which of the Surfaces to subtract (2, 3, 4, 10, 11) in this example 
// You need to check with the GUI to get the new number - it is 12 for this exampe
BooleanFragments{ Surface{1, 10, 11, 2}; Delete; }{}   // Arguments are "object" and "tool" (empty here)

// Now specify the Physical Surfaces
//   Only Physical Surfaces will be meshed (GUI is misleading in this sense)
//   If you leave out a surface which was subtracted you can make a hole
Physical Surface(1) = {12};        // Bulk MoS2
Physical Surface(2) = {10};        // One of the triangles
Physical Surface(3) = {11};        // The other triangle
Physical Surface(4) = {2};         // The disk

