import random 
import math 
# n = random.randint(0,22)
def coordinates():
    """Return GMSH coordinates for n objects"""
    width = 30
    height = 65

    a = -width/2 + 2.5
    b = width/2 - 2.5
    c = -height/2 + 2.5
    d = height/2 - 2.5 
    
    circle1 = []
    circle2 = []
    circle3 = []
    circle4 = []
    circle5 = []
    total_circle = []
    #append coordiantes to circle #goal: circle = [x1, y1]
    circle1.append(random.uniform(a,b))
    circle2.append(random.uniform(a,b))
    circle3.append(random.uniform(a,b))
    circle4.append(random.uniform(a,b))
    circle5.append(random.uniform(a,b))
    
    circle1.append(random.uniform(c,d))
    circle2.append(random.uniform(c,d))
    circle3.append(random.uniform(c,d))
    circle4.append(random.uniform(c,d))
    circle5.append(random.uniform(c,d))
      
    def change_coordinates(circle):
        circle.insert(0, random.uniform(a,b))
        circle.insert(1, random.uniform(c,d))
        return circle 
    
    zoo = overlap(circle1, circle2)
    if zoo:
        #print ("Circle 1:")
        #print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle1))
        #print ("Circle 2:")
        print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle2))
    else:
        i = 1
        print("Redo")
        while i < 100:
            a = change_coordinates(circle2)
            check_again = overlap(circle1, a)
            if check_again:
                #print ("Circle 1:")
                #print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle1))
                #print ("Circle 2:")
                print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle2))
            i += 1
            #print ('i incremented')
    total_circle += circle1
    total_circle += circle2
    
    def check3():
        nonlocal total_circle
        zoo2 = overlap(circle1, circle3)
        zoo3 = overlap(circle2, circle3)
        if zoo2 and zoo3:
            #print ("Circle 3:")
            print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle3))
        else:
            i = 1
            print("Redo")
            while i < 100:
                a = change_coordinates(circle3)
                check_again = overlap(circle1, a)
                check_again_again = overlap(circle2, a)
                if check_again and check_again_again:
                    #print ("Circle 3:")
                    print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle3))
                i += 1
                #print ('i incremented')
    total_circle += circle3
    def check4():
        nonlocal total_circle
        zoo2 = overlap(circle1, circle4)
        zoo3 = overlap(circle2, circle4)
        zoo4 = overlap(circle3, circle4)
        if zoo2 and zoo3 and zoo4:
            #print ("Circle 4:")
            print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle4))
        else:
            i = 1
            print("Redo")
            while i < 100:
                a = change_coordinates(circle4)
                check_again = overlap(circle1, a)
                check_again_again = overlap(circle2, a)
                check_again_again_again = overlap(circle3, a)
                if check_again and check_again_again and check_again_again_again:
                    #print ("Circle 4:")
                    print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle4))
                i += 1
                #print ('i incremented')
    total_circle += circle4
    def check5():
        nonlocal total_circle
        zoo2 = overlap(circle1, circle5)
        zoo3 = overlap(circle2, circle5)
        zoo4 = overlap(circle3, circle5)
        zoo5 = overlap(circle4, circle5)
        if zoo2 and zoo3 and zoo4 and zoo5:
            #print ("Circle 5:")
            print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle5))
        else:
            i = 1
            print("Redo")
            while i < 100:
                a = change_coordinates(circle5)
                check_again = overlap(circle1, a)
                check_again_again = overlap(circle2, a)
                check_again_again_again = overlap(circle3, a)
                check_again_tired = overlap(circle4, a)
                if check_again and check_again_again and check_again_again_again and check_again_tired:
                    #print ("Circle 5:")
                    print ( "Translate({0}, 0) (Symmetry (0, 1, 0, 0)(Duplicate(Surface(5);)))".format(circle5))
                i += 1
    total_circle += circle5

    check3()
    check4()
    check5()
    print(total_circle)
            
#   return overlap(random.uniform(a,b), random.uniform(a,b), random.uniform(c,d), random.uniform(c,d))
    
def overlap(lst1, lst2):
    r1, r2 = 10,10
    x1 = lst1[0]
    x2 = lst2[0]
    y1 = lst1[1]
    y2 = lst2[1]
    
    if (abs(r1 - r2)) <= ((((x1 - x2)**2) + ((y1 - y2)**2)))**0.5:
        if ((((x1 - x2)**2) + ((y1 - y2)**2)))**0.5 <= (r1 + r2):
            print("Circles Intersect")
            return False
        else:
            #print("Circles dont Intersect")
            return True 
    else:
        #print("Circles dont Intersect")
        return True 

coordinates()
        