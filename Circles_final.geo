// Gmsh project created on Tue Nov  3 23:06:23 2020
SetFactory("OpenCASCADE");
// Create Border 
//Domain: Width - 30 Height - 65

w = 30;
h = 65;

mesh2 = 1.0; //Mesh size outside of the bow ties 

Point(17) = {-w/2, -h/2, 0, mesh2}; // Bottom left corner 
Point(18) = {w/2, -h/2, 0, mesh2}; // Bottom right corner 
Point(19) = {w/2, h/2, 0, mesh2}; // Top right corner 
Point(20) = {-w/2, h/2, 0, mesh2}; // Top left corner 

//Make border lines 
Line(13) = {17,18}; // Bottom line 
Line(14) = {18, 19}; // Right line 
Line(15) = {19, 20}; // Top line 
Line(16) = {17,20}; // Left Line 

Curve Loop(1) = {13, 14, 15, 16};
Plane Surface(1) = {1};
Physical Surface(1) = {1};

// Parameters
r1a = 2;        // Characteristic dimensions
r1b = 5;
mesh = .50; //mesh size inside circles

Point(1) = {0, 0, 0, mesh};
Point(2) = {r1a*Cos(Pi/6), r1a*Sin(Pi/6), 0, mesh};
Point(3) =  {-r1a*Cos(Pi/6), r1a*Sin(Pi/6), 0, mesh};
Point(4) = {0, -r1a, 0, mesh};

// All arcs of the circle
Circle(1) = {2, 1, 3};      // Top arc
Circle(2) = {3, 1, 4};     // LH bottom arc
Circle(3) = {4, 1, 2};     // RH bottom arc

// Curve Loop replaced Line Loop in GMSH 4.0
Curve Loop(10) = {1,2,3};    // Creating circle

Plane Surface(5) = {10};   // Make the surface, this can translated, rotated

//Randomly move circles
//Code can be revised to be shorter 
//radius = 2

L[] = {-1.427694890861602, 0.7292227853614399, -7.974051744846378, -27.126470995045644, -10.936961015100543, 23.27938824323295, 9.978977412782982, -1.8360630563197162, 6.770978278624774, 22.397298341132384};

Translate {L[2], L[1], 0} {Duplicata{Surface{5};}} //x and y need to be switched for some reason 
Translate {L[4], L[3], 0} {Duplicata{Surface{5};}}
Translate {L[6], L[5], 0} {Duplicata{Surface{5};}}
Translate {L[8], L[7], 0} {Duplicata{Surface{5};}}
Translate {L[10], L[9], 0} {Duplicata{Surface{5};}}

Physical Surface (2) = {5};
Physical Surface (3) = {6};
Physical Surface (4) = {7};
Physical Surface (5) = {8};
Physical Surface (6) = {9};
Physical Surface (7) = {10};
Physical Surface (8) = {11};
