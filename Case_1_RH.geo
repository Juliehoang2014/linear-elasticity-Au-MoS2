// Rounded rectangles in Au-MoS2 geometry 
//  This is for the base case in Eric's paper draft

// Will this create issues with meshio?
SetFactory("OpenCASCADE");

// Variable and parameters
// 
// Au islands of width W and length L are spaced by a gap G. 
// For the base case simulations, L = 63.8 nm, W = 13.2 nm, and G = 11.4 nm. 
// The sharpness of the island corners is defined by a radius R, 
//     which is set to either W/2 or 1 nm or in the continuum simulations. 
// Will use a and b for the width and height of the domain 
// 66 x 115 nm is what Eric used 

a = 66.0;                  // Width of simulation domain
b = 115.0;                 // Height of simulation domain
L = 7.0;                  // Length of islands, Eric's base L = 63.8 nm
W = 4.0;                  // Width of islands, Eric's base W = 13.2 nm,     
G = 7.0;                  // Gap between the islands, Eric's base G = 11.4 nm
RH = W/2*0.9;              // For Eric's RH case, gave an error if the radiis overlapped
R1 = 1.0;                  // For Eric's R1 case, islands have a corner radius = 1
R  = RH;                   // Choose the case here
Printf("Radius R1 = %g ", R1);
Printf("Radius RH = %g ", RH);
Printf("Here use %g ", R);


// For scaling the mesh
mesh = 2;

// Domain 
Point(1) = {-a/2, -b/2, 0, mesh};
Point(2) = {+a/2, -b/2, 0, mesh};
Point(3) = {+a/2, +b/2, 0, mesh};
Point(4) = {-a/2, +b/2, 0, mesh};


// Lines around the domain border
Line(1) = {1,2};  
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};

// For the domain, use the lines
Line Loop(1) = {1,2,3,4};

// These make surfaces directly 
// Lower LH corner xyz, width and height
// R has to be smaller than W/2
Rectangle(5) = {-G/2-W, -L/2, 0, W, L, R};
Rectangle(6) = {G/2, -L/2, 0, W, L, R};

// Make Line Loops this way from the lines made by the rectangle command
Line Loop(10) = {5,6,7,8,9,10,11,12};
Line Loop(11) = {13,14,15,16,17,18,19,20};

// Need to figure out how to make a Plane Surface with holes defined by existing surfaces
// Make Plane Surfaces from the loops, use additional arguments to make holes

Plane Surface(1) = {1};
Plane Surface(2) = {10};  
Plane Surface(3) = {11};
//Plane Surface(20) = {6};
//Plane Surface(3) = {1,5,6};

// The first list represents the object; the second represents the tool.
// Subtract the tool from the object
// Stuggling with the nomenclature

//BooleanDifference(11)= {Surface{5}}{Surface{1}};

// Attempt Physical surfaces from the plane surfaces 
Physical Surface("Island 1") = {5};
Physical Surface("Island 2") = {6};
Physical Surface("Bulk") = {1};
Physical Surface("Trying This") = {2};
Rotate {{0, 0, 1}, {0, 0, 0}, Pi/4} {Surface{5};}

//Modified Changes 
L[] = {-8.530360249445472, -15.488523491174115, 3.413927264798364, -24.6418185149755, 1.318139927292913, 16.43691313777093, 12.322389834262648, 20.32871130722767, -0.17221882157333646, -9.904486437311991};

Translate {L[0], L[1], 0} {Surface{2};}
Translate {L[2], L[3], 0} {Duplicata{Surface{2};}}
Translate {L[4], L[5], 0} {Duplicata{Surface{2};}}
Translate {L[6], L[7], 0} {Duplicata{Surface{2};}}
Translate {L[8], L[9], 0} {Duplicata{Surface{2};}}

Physical Surface(11) = {7};
Physical Surface(12) = {8};
Physical Surface(13) = {9};
Physical Surface(14) = {10};
Physical Surface(15) = {11};

//Remove line below if no rotation
Rotate {{0, 0, 1}, {0, 0, 0}, Pi/4} {Surface{7,8,9,10,11};}

//End of Modified Changes

// Read this somewhere - but it doesn't do anything
// MeshAlgorithm Surface {5, 6} = 0.1;

// Try this, aim for about 10k elements. Here I have about 5k 
lcar1 = 3.5;   // Coarse for the bulk
lcar2 = 1.5;   // Finer for the islands
lcar3 = 0.1;   // Super fine
eps = 1e-3;

// Try this
// Assign a mesh size to all the points of all the volumes:
Characteristic Length{ PointsOf{ Surface{1}; } } = lcar1;
Characteristic Length{ PointsOf{ Surface{5,6}; } } = lcar2;

