// Gmsh project created on Thu Oct  8 00:07:14 2020
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

W1 = w/2 - 3;
H1 = h/2 - 3;

// randomizes each rand() based on computer time
//srand(time(NULL)); 

X1 = Rand(-W1);
X2 = Rand(-W1);
X3 = Rand(-W1);
X4 = Rand(W1);
X5 = Rand(-W1);
X6 = Rand(W1);

Y1 = Rand(-H1);
Y2 = Rand(H1);
Y3 = Rand(-H1);
Y4 = Rand(-H1);
Y5 = Rand(H1);
Y6 = Rand(H1);

//C1 and C2
distSq1 = (X1 - X2)*(X1 - X2) + (Y1-Y2)*(Y1-Y2);

if (distSq1 > 17)
Translate {X1, Y1, 0} {Duplicata{Surface{5};}};
Translate {X2, Y2, 0} {Duplicata{Surface{5};}}
else
    X2 = Rand(-W1) + 1 ; // 1 is a random int to move the second Rand
    Y2 = Rand(H1) + 1;
    Translate {X2, Y2, 0} {Duplicata{Surface{5};}}
Endif

//C3

distSq2 = (X1 - X3)*(X1 - X3) + (Y1-Y3)*(Y1-Y3);
distSq3 = (X2 - X3)*(X2 - X3) + (Y2-Y3)*(Y2-Y3);

if (distSq2 > 17) 
    if (distSq3 > 17)
        Translate {X3, Y3, 0} {Duplicata{Surface{5};}}
    Endif
else
    X3 = Rand(-W1) -2;
    Y3 = Rand(-H1) + 2;
    Translate {X3, Y3, 0} {Duplicata{Surface{5};}}
Endif

//C4
distSq4 = (X1 - X4)*(X1 - X4) + (Y1-Y4)*(Y1-Y4);
distSq5 = (X2 - X4)*(X2 - X4) + (Y2-Y4)*(Y2-Y4);
distSq6 = (X3 - X4)*(X3 - X4) + (Y3-Y4)*(Y3-Y4);

if (distSq4 > 17)
    if (distSq5 > 17)
        if (distSq6 > 17)
            Translate {(X4), (Y4), 0} {Duplicata{Surface{5};}}
        Endif
    Endif 
else
    X4 = Rand(W1) - 2 ;
    Y4 = Rand(-H1) + 3;
    Translate {X4, Y4, 0} {Duplicata{Surface{5};}}
Endif

//C5 
distSq7 = (X1 - X5)*(X1 - X5) + (Y1-Y5)*(Y1-Y5);
distSq8 = (X2 - X5)*(X2 - X5) + (Y2-Y5)*(Y2-Y5);
distSq9 = (X3 - X5)*(X3 - X5) + (Y3-Y5)*(Y3-Y5);
distSq10 = (X4 - X5)*(X4 - X5) + (Y4-Y5)*(Y4-Y5);

if (distSq7 > 17)
    if (distSq8 > 17)
        if (distSq9 > 17)
            if (distSq10 > 17)
                Translate {(X5), (Y5), 0} {Duplicata{Surface{5};}}
            Endif
        Endif
    Endif 
else
    X4 = Rand(W1) - 2;
    Y4 = Rand(-H1) + 2;
    Translate {X5, Y5, 0} {Duplicata{Surface{5};}}
Endif


Physical Surface (2) = {5};
Physical Surface (3) = {6};
Physical Surface (4) = {7};
Physical Surface (5) = {8};
Physical Surface (6) = {9};
Physical Surface (7) = {10};
Physical Surface (8) = {11};
