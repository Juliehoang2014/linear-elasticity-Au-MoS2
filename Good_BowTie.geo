// Gmsh project created on Wed Nov  4 19:49:54 2020
SetFactory("OpenCASCADE");
//RANDOM 
// Parameters
r1a = 1;        // Characteristic dimensions
r1b = 2.5;
mesh = .50; //mesh size inside the bow ties 

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

//Change distance between triangles --> Translate {0, y, 0}
//Translate {0,-20,0} {Surface{1};} // Make triangle below origin 
//Translate {0,0,0} {Symmetry {0,1,0,0} {Duplicata{Surface{1};}}}
//Rotate {{1, 0, 0}, {0, 0, 0}, Pi/10} {Surface{1};}
//Rotate {{0, 0, 0}, {0, 0, 0}, Pi/2} {Duplicata{Surface{1};}}

// Create Border 
//Domain: Width - 30 Height - 65

w = 30;
h = 65;

mesh2 = 1.5; //Mesh size outside of the bow ties 

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
//Curve Loop(13) = {10, 11, 12, 7, 8, 9};
//Curve Loop(14) = {1, 2, 3, 4, 5, 6};

//Plane Surface(3) = {12, 13, 14}; //Create plane surface 
//Plane Surface(4) = {13};
//Plane Surface(5) = {14};

//Make fine mesh between bow ties 

mesh3 = .08; //Mesh around the center line 


Physical Surface(1) = {3};
Physical Surface(2) = {4};
Physical Surface(3) = {5};
Physical Surface(4) = {6};
Physical Surface(5) = {7};

L[] = {-1.427694890861602, 0.7292227853614399, -7.974051744846378, -27.126470995045644, -10.936961015100543, 23.27938824323295, 9.978977412782982, -1.8360630563197162, 6.770978278624774, 22.397298341132384};

Translate {L[0], L[1], 0} {Surface{1};} 
Translate {L[2], L[3], 0} {Duplicata{Surface{1};}}
Translate {L[4], L[5], 0} {Duplicata{Surface{1};}}
Translate {L[6], L[7], 0} {Duplicata{Surface{1};}}
Translate {L[8], L[9], 0} {Duplicata{Surface{1};}}

Physical Surface(6) = {8};
Physical Surface(7) = {9};
Physical Surface(8) = {10};
Physical Surface(9) = {11};

