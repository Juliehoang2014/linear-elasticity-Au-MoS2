// Gmsh project created on Mon Oct 05 23:36:22 2020
SetFactory("OpenCASCADE");

// Parameters
r1a = 2;        // Characteristic dimensions
r1b = 5;
mesh = 0.4; //mesh size inside the bow ties 0.5 --> 1.5

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

Translate {0,-10,0} {Surface{1};} // Make triangle below origin 
Translate {0,0,0} {Symmetry {0,1,0,0}{Duplicata{Surface{1};}}}

// Create Border 
//Domain: Width - 30 Height - 65

w = 80;
h = 180;

mesh2 = 1.0; //Mesh size outside of the bow ties 1.5 --> 5

Point(17) = {-w/2, -h/2, 0, mesh2}; // Bottom left corner 
Point(18) = {w/2, -h/2, 0, mesh2}; // Bottom right corner 
Point(19) = {w/2, h/2, 0, mesh2}; // Top right corner 
Point(20) = {-w/2, h/2, 0, mesh2}; // Top left corner 

//Make border lines 
Line(13) = {17,18}; // Bottom line 
Line(14) = {18, 19}; // Right line 
Line(15) = {19, 20}; // Top line 
Line(16) = {17,20}; // Left Line 

Curve Loop(12) = {15, 16, 13, 14};
Curve Loop(13) = {10, 11, 12, 7, 8, 9};
Curve Loop(14) = {1, 2, 3, 4, 5, 6};

Plane Surface(3) = {12, 13, 14}; //Create plane surface 
Plane Surface(4) = {13};
Plane Surface(5) = {14};

//Make fine mesh between bow ties 

mesh3 = 0.7; //Mesh around the center line .08 --> 1.2

Point(22) = {-r1a/2, 0, 0, mesh3}; //Horizontal
Point(24) = {r1a/2, 0, 0, mesh3};

Point(25) = {0, -r1b/2, 0, mesh3}; //Vertical
Point(26) = {0, r1b/2, 0, mesh3};

Line(17) = {22, 24}; //Horizontal center line
Line(18) = {25, 26}; //Vertical center line

Line{17} In Surface{3}; //Makes the horizontal line a part of the surface 
Line{18} In Surface{3}; //Makes the vertical line a part of the surface 


//Hide the line in the center 
//Hide {Line(17)}

Physical Surface(1) = {3};
Physical Surface(2) = {4};
Physical Surface(3) = {5};


//Change color of mesh 
//Color DarkGrey{Surface{3};}
//Color Blue{Surface{1};}
//Color Yellow{Surface{2};}