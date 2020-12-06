// Gmsh project created on Wed Nov  4 19:49:54 2020
SetFactory("OpenCASCADE");

// Parameters
r1a = 1;        // Characteristic dimensions
r1b = 2.5;
mesh = 0.4; //mesh size inside the bow ties 1--> 0.4 

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
Physical Surface(100) = {1};
//Rotate {{0, 0, 1}, {0, 0, 0}, Pi/4} {Surface{1};} //Rotate triangles 

L[] = {5.276988127405577, 2.558336976986105, 1.089822603321963, -23.59163789394554, -10.068057836737601, -8.693854927196853, -6.57526072088869, 8.234977595935035, 4.925163566892351, -15.764611977495802};

//Change distance between triangles --> Translate {0, y, 0}
Translate {L[0],L[1],0} {Surface{1};} // Make triangle below origin 
Translate {L[2],L[3],0} {Duplicata{Surface{1};}}
//Physical Surface(101) = {2};

// Create Border 
//Domain: Width - 30 Height - 65

w = 80;
h = 180;

mesh2 = 1; //Mesh size outside of the bow ties 1.5 -- > 1 

Point(17) = {-w/2, -h/2, 0, mesh2}; // Bottom left corner 
Point(18) = {w/2, -h/2, 0, mesh2}; // Bottom right corner 
Point(19) = {w/2, h/2, 0, mesh2}; // Top right corner 
Point(20) = {-w/2, h/2, 0, mesh2}; // Top left corner 

//Make border lines 
Line(13) = {17,18}; // Bottom line 
Line(14) = {18,19}; // Right line 
Line(15) = {19,20}; // Top line 
Line(16) = {17,20}; // Left Line 

Curve Loop(12) = {15, 16, 13, 14};
Curve Loop(13) = {10, 11, 12, 7, 8, 9};
Curve Loop(14) = {1, 2, 3, 4, 5, 6};

Translate {L[4],L[5],0} {Duplicata{Surface{1};}}
Translate {L[6],L[7],0} {Duplicata{Surface{1};}}
Translate {L[8],L[9],0} {Duplicata{Surface{1};}}

Plane Surface(90) = {12, 13, 14, 15, 16, 17}; //Create plane surface 

Physical Surface(1) = {90};
Physical Surface(300) = {2};
Physical Surface(400) = {3};
Physical Surface(500) = {4};
Physical Surface(600) = {5};




