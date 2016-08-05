"""
This scripts sets up the equations to design a 4-bar mechanism,
using python 3 and sympy.
The system appears in a paper by A.P. Morgan and C.W. Wampler on
Solving a Planar Four-Bar Design Using Continuation, published in
the Journal of Mechanical Design, volume 112, pages 544-550, 1990.
"""
from sympy import var
from sympy.matrices import Matrix
import matplotlib.pyplot as plt

def polynomials(d0, d1, d2, d3, d4, a):
    """
    Given in d0, d1, d2, d3, d4 are the coordinates of
    the precision points, given as Matrix objects.
    Also the coordinates of the pivot in a are stored in a Matrix.
    Returns the system of polynomials to design the 4-bar
    mechanism with a coupler passing through the precision points.
    """
    # the four rotation matrices
    c1, s1, c2, s2 = var('c1, s1, c2, s2')
    c3, s3, c4, s4 = var('c3, s3, c4, s4')
    R1 = Matrix([[c1, -s1], [s1, c1]])
    R2 = Matrix([[c2, -s2], [s2, c2]])
    R3 = Matrix([[c3, -s3], [s3, c3]])
    R4 = Matrix([[c4, -s4], [s4, c4]])
    # the first four equations reflecting cos^2(t) + sin^(t) = 1
    p1, p2 = 'c1^2 + s1^2 - 1;', 'c2^2 + s2^2 - 1;'
    p3, p4 = 'c3^2 + s3^2 - 1;', 'c4^2 + s4^2 - 1;'
    # the second four equations on X
    x1, x2 = var('x1, x2')
    X = Matrix([[x1], [x2]])
    c1x = 0.5*(d1.transpose()*d1 - d0.transpose()*d0)
    c2x = 0.5*(d2.transpose()*d2 - d0.transpose()*d0)
    c3x = 0.5*(d3.transpose()*d3 - d0.transpose()*d0)
    c4x = 0.5*(d4.transpose()*d4 - d0.transpose()*d0)
    e1x = (d1.transpose()*R1 - d0.transpose())*X + c1x
    e2x = (d2.transpose()*R2 - d0.transpose())*X + c2x
    e3x = (d3.transpose()*R3 - d0.transpose())*X + c3x
    e4x = (d4.transpose()*R4 - d0.transpose())*X + c4x
    s1, s2 = str(e1x[0]) + ';', str(e2x[0]) + ';'
    s3, s4 = str(e3x[0]) + ';', str(e4x[0]) + ';'
    # the third group of equations on Y
    y1, y2 = var('y1, y2')
    Y = Matrix([[y1], [y2]])
    c1y = c1x - a.transpose()*(d1 - d0)
    c2y = c2x - a.transpose()*(d2 - d0)
    c3y = c3x - a.transpose()*(d3 - d0)
    c4y = c4x - a.transpose()*(d4 - d0)
    e1y = ((d1.transpose() - a.transpose())*R1 \
         - (d0.transpose() - a.transpose()))*Y + c1y
    e2y = ((d2.transpose() - a.transpose())*R2 \
         - (d0.transpose() - a.transpose()))*Y + c2y
    e3y = ((d3.transpose() - a.transpose())*R3 \
         - (d0.transpose() - a.transpose()))*Y + c3y
    e4y = ((d4.transpose() - a.transpose())*R4 \
         - (d0.transpose() - a.transpose()))*Y + c4y
    s5, s6 = str(e1y[0]) + ';', str(e2y[0]) + ';'
    s7, s8 = str(e3y[0]) + ';', str(e4y[0]) + ';'
    return [p1, p2, p3, p4, s1, s2, s3, s4, s5, s6, s7, s8]

def solve_general():
    """
    Defines the pivot and generates random coordinates,
    uniformly distributed in [-1, +1], for the five points
    through which the coupler must pass.
    Calls the blackbox solver to solve the system.
    """
    from random import uniform as u
    pt0 = Matrix(2, 1, lambda i,j: u(-1,+1))
    pt1 = Matrix(2, 1, lambda i,j: u(-1,+1))
    pt2 = Matrix(2, 1, lambda i,j: u(-1,+1))
    pt3 = Matrix(2, 1, lambda i,j: u(-1,+1))
    pt4 = Matrix(2, 1, lambda i,j: u(-1,+1))
    # the pivot is a
    piv = Matrix([[1], [0]])
    equ = polynomials(pt0,pt1,pt2,pt3,pt4,piv)
    print('the polynomial system :')
    for pol in equ:
        print(pol)
    from phcpy.solver import solve
    sols = solve(equ)
    print('the solutions :')
    for sol in sols:
        print(sol)
    print('computed', len(sols), 'solutions')

def angle(csa, sna):
    """
    Given in csa and sna are the cosine and sine of an angle a,
    that is: csa = cos(a) and sna = sin(a).
    On return is the angle a, with the proper orientation.
    """
    from math import acos, pi
    agl = acos(csa)
    if sna >= 0:
        return agl
    else:
        dlt = pi - agl
        return pi + dlt

def angles(soldic):
    """
    Given a solution dictionary, extracts the angles from
    the four cosines and sines of the angles.
    Returns None if the angles are not ordered increasingly.
    Otherwise, returns the sequence of ordered angles.
    """
    from math import acos, asin
    c1v, s1v = soldic['c1'].real, soldic['s1'].real
    c2v, s2v = soldic['c2'].real, soldic['s2'].real
    c3v, s3v = soldic['c3'].real, soldic['s3'].real
    c4v, s4v = soldic['c4'].real, soldic['s4'].real
    ag1 = angle(c1v, s1v)
    ag2 = angle(c2v, s2v)
    ag3 = angle(c3v, s3v)
    ag4 = angle(c4v, s4v)
    ordered = (ag1 > ag2) and (ag2 > ag3) and (ag3 > ag4)
    if ordered:
        print(ag1, ag2, ag3, ag4, 'ordered angles')
        return (ag1, ag2, ag3, ag4)
    return None

def straight_line(verbose=True):
    """
    This function solves an instance where the five precision
    points lie on a line.  The coordinates are taken from Problem 7
    of the paper by A.P. Morgan and C.W. Wampler.
    Returns a list of solution dictionaries for the real solutions.
    """
    from phcpy.solutions import strsol2dict, is_real
    pt0 = Matrix([[ 0.50], [ 1.06]])
    pt1 = Matrix([[-0.83], [-0.27]])
    pt2 = Matrix([[-0.34], [ 0.22]])
    pt3 = Matrix([[-0.13], [ 0.43]])
    pt4 = Matrix([[ 0.22], [ 0.78]])
    piv = Matrix([[1], [0]])
    equ = polynomials(pt0,pt1,pt2,pt3,pt4,piv)
    if verbose:
        print('the polynomial system :')
        for pol in equ:
            print(pol)
    from phcpy.solver import solve
    sols = solve(equ)
    if verbose:
        print('the solutions :')
        for sol in sols:
            print(sol)
        print('computed', len(sols), 'solutions')
    result = []
    for sol in sols:
        if is_real(sol, 1.0e-8):
            soldic = strsol2dict(sol)
            result.append(soldic)
    return result

def plotpoints(points):
    """
    Plots the precision points and the pivots.
    """
    xpt = [a for (a, b) in points]
    ypt = [b for (a, b) in points]
    plt.plot(xpt, ypt, 'ro')
    plt.text(xpt[0] - 0.01, ypt[0] + 0.08, "0")
    plt.text(xpt[1] - 0.01, ypt[1] + 0.08, "1")
    plt.text(xpt[2] - 0.01, ypt[2] + 0.08, "2")
    plt.text(xpt[3] - 0.01, ypt[3] + 0.08, "3")
    plt.text(xpt[4] - 0.01, ypt[4] + 0.08, "4")
    plt.plot([0, 1], [0, 0], 'w^') # pivots marked by white triangles
    plt.axis([-1.0, 1.5, -1.0, 1.5])

def plotbar(fig, points, idx, x, y):
    """
    Plots a 4-bar with coordinates given in x and y,
    and the five precision points in the list points.
    The index idx is the position with respect to a point in points.
    """
    if idx < 0:
        fig.add_subplot(231, aspect='equal')
    if idx == 0:
        fig.add_subplot(232, aspect='equal')
    elif idx == 1:
        fig.add_subplot(233, aspect='equal')
    elif idx == 2:
        fig.add_subplot(234, aspect='equal')
    elif idx == 3:
        fig.add_subplot(235, aspect='equal')
    elif idx == 4:
        fig.add_subplot(236, aspect='equal')
    plotpoints(points)
    if idx >= 0:
        xpt = [a for (a, b) in points]
        ypt = [b for (a, b) in points]
        (xp0, xp1) = (x[0] + xpt[idx], x[1] + ypt[idx])
        (yp0, yp1) = (y[0] + xpt[idx], y[1] + ypt[idx])
        plt.plot([xp0, yp0], [xp1, yp1], 'go')
        plt.plot([xp0, yp0], [xp1, yp1], 'g')
        plt.text(xp0 - 0.04, xp1 - 0.22, "x")
        plt.text(yp0 - 0.04, yp1 - 0.22, "y")
        plt.plot([0, xp0], [0, xp1], 'g')
        plt.plot([yp0, 1], [yp1, 0], 'g')
        plt.plot([xp0, xpt[idx]], [xp1, ypt[idx]], 'b')
        plt.plot([yp0, xpt[idx]], [yp1, ypt[idx]], 'b')

def rotate(x, y, a):
    """
    Applies a planar rotation defined by the angle a
    to the points x and y.
    """
    from sympy.matrices import Matrix
    from math import cos, sin
    rot = Matrix([[cos(a), -sin(a)], [sin(a), cos(a)]])
    xmt = Matrix([[x[0]], [x[1]]])
    ymt = Matrix([[y[0]], [y[1]]])
    rxm = rot*xmt
    rym = rot*ymt
    rox = (rxm[0], rxm[1])
    roy = (rym[0], rym[1])
    return (rox, roy)

def show4bar():
    """
    Plots a 4-bar design, for the five precision points
    on a straight line, with coordinates taken from Problem 7
    of the Morgan-Wampler paper.
    """
    pt0 = ( 0.50,  1.06)
    pt1 = (-0.83, -0.27)
    pt2 = (-0.34,  0.22)
    pt3 = (-0.13,  0.43)
    pt4 = ( 0.22,  0.78)
    points = [pt0, pt1, pt2, pt3, pt4]
    ags = [1.44734213756, 0.928413708131, 0.751699211109, 0.387116282208]
    x =  (-0.0877960434509, -0.851386907516)
    y =  (0.235837391307, -1.41899202704)
    fig = plt.figure()
    plotbar(fig,points, -1, x, y)
    plotbar(fig,points, 0, x, y)
    rx1, ry1 = rotate(x, y, ags[0])
    plotbar(fig,points, 1, rx1, ry1)
    rx2, ry2 = rotate(x, y, ags[1])
    plotbar(fig,points, 2, rx2, ry2)
    rx3, ry3 = rotate(x, y, ags[2])
    plotbar(fig,points, 3, rx3, ry3)
    rx4, ry4 = rotate(x, y, ags[3])
    plotbar(fig,points, 4, rx4, ry4)
    fig.show()
    input('hit enter to exit')

def main():
    """
    Solves a general instance of the design problem first,
    for randomly generated coordinates of the precision points.
    """
    solve_general()
    sols = straight_line()
    print('the real solutions :')
    for sol in sols:
        (x1v, x2v) = (sol['x1'].real, sol['x2'].real)
        (y1v, y2v) = (sol['y1'].real, sol['y2'].real)
        print('x = ', x1v, x2v)
        print('y = ', y1v, y2v)
    print('computed', len(sols), 'real solutions')
    for sol in sols:
        agl = angles(sol)
        if agl != None:
            (x1v, x2v) = (sol['x1'].real, sol['x2'].real)
            (y1v, y2v) = (sol['y1'].real, sol['y2'].real)
            print('x = ', x1v, x2v)
            print('y = ', y1v, y2v)
    show4bar()

if __name__ == "__main__":
    main()
