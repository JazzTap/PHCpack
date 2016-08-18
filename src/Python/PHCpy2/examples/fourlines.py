"""
Given four lines in general position,
there are two lines which meet all four given lines.
With Pieri homotopies we can solve this Schubert problem.
For the verification of the intersection conditions, numpy is used.
"""
from numpy import zeros, array, concatenate, matrix

def indices(name):
    """
    For the string name in the format xij
    return (i, j) as two integer indices.
    """
    return (int(name[1]), int(name[2]))

def solution_plane(rows, cols, sol):
    """
    Returns a sympy matrix with as many rows
    as the value of rows and with as many columns
    as the value of columns, using the string
    represention of a solution in sol.
    """
    from phcpy.solutions import coordinates
    result = zeros((rows, cols), dtype=complex)
    for k in range(cols):
        result[k][k] = 1
    (vars, vals) = coordinates(sol)
    for (name, value) in zip(vars, vals):
        i, j = indices(name)
        result[i-1][j-1] = value
    return result

def verify_determinants(inps, sols):
    """
    Verifies the intersection conditions with determinants,
    concatenating the planes in inps with those in the sols.
    Both inps and sols are lists of numpy arrays.
    """
    from numpy.linalg import det
    for sol in sols:
        for plane in inps:
            cat = concatenate([plane, sol], axis=-1)
            mat = matrix(cat)
            dcm = det(mat)
            print 'the determinant :', dcm

def solve_general(mdim, pdim, qdeg):
    """
    Solves a general instance of Pieri problem, computing the
    p-plane producing curves of degree qdeg which meet a number
    of general m-planes at general interpolation points,
    where p = pdim and m = mdim on input.
    For the problem of computing the two lines which meet
    four general lines, mdim = 2, pdim = 2, and qdeg = 0.
    Returns the number of solutions computed.
    """
    from phcpy.schubert import random_complex_matrix
    from phcpy.schubert import run_pieri_homotopies
    dim = mdim*pdim + qdeg*(mdim+pdim)
    ranplanes = [random_complex_matrix(mdim+pdim, mdim) for _ in range(0, dim)]
    (pols, sols) = run_pieri_homotopies(mdim, pdim, qdeg, ranplanes)
    inplanes = [array(plane) for plane in ranplanes]
    outplanes = [solution_plane(mdim+pdim, pdim, sol) for sol in sols]
    return (inplanes, outplanes)

def main():
    """
    We start with the formalism of the root count,
    solve a general configuration and then a special problem.
    """
    from phcpy.schubert import pieri_root_count
    (mdim, pdim, deg) = (2, 2, 0)
    pcnt = pieri_root_count(mdim, pdim, deg, False)
    print 'The Pieri root count :', pcnt
    (inp, otp) = solve_general(mdim, pdim, deg)
    print('The input planes :')
    for plane in inp:
        print(plane)
    print('The solution planes :')
    for plane in otp:
        print(plane)
    verify_determinants(inp, otp)

if __name__ == "__main__":
    main()
