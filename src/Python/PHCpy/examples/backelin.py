"""
Backelin's Lemma states that the cyclic n-roots problem has an m-dimensional
solution set for n = L*m^2, where L is no multiple of k^2, m >= 2.
This script provides an exact representation of the solution set,
following the tropical formulation with m-1 free parameters.
The tropical version of Backelin's Lemma appeared in the proceedings of
Computer Algebra in Scientific Computing, 15th International Workshop, 
CASC 2013, Berlin, Germany, edited by Vladimir P.  Gerdt, Wolfram Koepf, 
Ernst W. Mayr, and Evgenii V. Vorozhtsov;
Lecture Notes in Computer Science, Volume 8136, pages 10-29, 2013;
in the paper Polyhedral Methods for Space Curves Exploiting Symmetry 
Applied to the Cyclic n-roots Problem, by Danko Adrovic and Jan Verschelde.
"""

def randcmplx():
    """
    Returns a random complex number on the unit circle.
    """
    from random import uniform
    from math import cos, sin, pi
    angle = uniform(0, 2*pi)
    return complex(cos(angle), sin(angle))

def strcmplx(nbr, imagunit, mulsym=''):
    """
    Returns the string representation of a complex number,
    where imagunit contains the string to use for the
    imaginary unit, and mulsym is the symbol for multiplication
    with the imaginary unit.
    """
    nre = '%.16e' % nbr.real
    nim = '%+.16e' % nbr.imag
    return '(' + nre + nim + mulsym + imagunit + ')'

def constants(m, L):
    """
    Returns the tuple of constants u and gamma
    for n = m*L**2.
    """
    from cmath import exp, pi
    alpha = m*(m*L - 1)
    beta = alpha % 2
    i = complex(0, 1)
    u = exp(i*2*pi/(m*L))
    gamma = exp(i*pi*beta/(m*L))
    return (u, gamma)

def component(m, L, u, gamma):
    """
    Returns a list of strings, where the k-th string
    stores the representation of the k-th coordinate.
    The m-1 parameters are t0, t1, .., tm-2.
    """
    result = []
    ustr = '(%.16e %+.16ej)' % (u.real, u.imag)
    gstr = '(%.16e %+.16ej)' % (gamma.real, gamma.imag)
    for k in range(L*m):
        s = '+' + ustr + '**' + str(k)
        for i in range(m-1):
            s = s + '*t' + str(i)
            result.append(s)
        s = '+' + gstr + '*' + ustr + '**' + str(k)
        for i in range(m-1):
            e = -m + 1 + i
            s = s + '*t' + str(i) + '**(' + str(e) + ')'
        result.append(s)
    return result

def sample(m, roots):
    """
    Generates m-1 random complex numbers as parameters
    and evaluates the representation for the roots.
    """
    d = globals()
    for k in range(m-1):
        var = 't' + str(k)
        d[var] = randcmplx()
    result = []
    for r in roots:
        result.append(eval(r))
    return result

def evaluate(point):
    """
    Evaluates the point in the cyclic n-roots problem,
    where n = len(point).
    """
    from phcpy.families import cyclic
    n = len(point)
    f = cyclic(n)
    d = globals()
    for k in range(n):
        var = 'x' + str(k)
        d[var] = point[k]
    for k in range(n):
        var = 'x' + str(k)
        print var, '=', d[var]
    result = []
    for r in f:
        result.append(eval(r[0:-1]))
    return result

def embedpol(nbslk, pol):
    """
    Given in pol the string representation of a polynomial
    in several variables, the string pol is returned,
    augmented with a random linear sum of as many slack
    variables as the value of nbslk.
    """
    hyp = ""
    for k in range(1, nbslk+1):
        nbr = randcmplx()
        cff = strcmplx(nbr, 'i', '*')
        hyp = hyp + ' + ' + cff + '*zz' + str(k)
    result = pol[0:-1] + hyp + ';'
    return result

def embedsys(nbslk, sys, addslack=True):
    """
    Given on input in sys a list of string representations
    for polynomials, on return is the list of strings
    representing the embedding with as many slack variables
    as the value of nbslk, provided addslack equals True.
    Otherwise, the system on return is just a copy of sys.
    """
    result = []
    if addslack:
        for pol in sys:
            result.append(embedpol(nbslk, pol))
    else:
        for pol in sys:
            result.append(pol)
    return result

def hyperplane(dim, point, addslack=True):
    """
    Returns a random linear equation in len(point) + dim
    variables through the point.
    The first len(point) variables have name 'x' followed by
    an index which starts its count at zero.
    The dim slack variables have name 'zz' and their index
    count starts at one, provided addslack is True.
    The constant term of the hyperplane is computed so that
    the point evaluates to zero at the hyperplane.
    """
    nvr = len(point)
    hyp = ""    # to return in PHCpack format
    evahyp = "" # in Python format for evaluation
    for k in range(nvr):
        nbr = randcmplx()
        cff = strcmplx(nbr, 'i', '*')
        evacff = strcmplx(nbr, 'j')
        hyp = hyp + ' + ' + cff + '*x' + str(k)
        evahyp = evahyp + ' + ' + evacff + '*x' + str(k)
    if addslack:
        for k in range(1, dim+1):
            nbr = randcmplx()
            cff = strcmplx(nbr, 'i', '*')
            evacff = strcmplx(nbr, 'j')
            hyp = hyp + ' + ' + cff + '*zz' + str(k)
            evahyp = evahyp + ' + ' + evacff + '*zz' + str(k)
    d = globals()
    for k in range(nvr):
        var = 'x' + str(k)
        d[var] = point[k]
    if addslack:
        for k in range(1, dim+1):
            var = 'zz' + str(k)
            d[var] = 0.0
    cst = eval(evahyp)
    result = hyp + ' + (%.16e %+.16e*i)' % (-cst.real, -cst.imag) + ';'
    return result

def embedpoint(dim, point, addslack=True):
    """
    Embeds the point in a witness set representation
    for a cyclic n-roots solution set of dimension dim.
    If addslack, then slack variables will be added
    to square the embedded system.
    """
    from phcpy.families import cyclic
    nvr = len(point)
    sys = cyclic(nvr)
    emb = embedsys(dim, sys, addslack)
    for p in point:
        print p
    for k in range(dim):
        hyp = hyperplane(dim, point, addslack)
        emb.append(hyp)
    return emb

def embedtofile(embsys, point, addslack=True):
    """
    Prompts the user for a file name and writes the
    embedded system in embsys and the point to file.
    If addslack, then slack variables will be used
    to square the system.
    """
    name = raw_input('Give a file name : ')
    file = open(name, 'w')
    if addslack:
        file.write(str(len(embsys)) + '\n')
    else:
        file.write(str(len(embsys)) + ' ' + str(len(point))+ '\n')
    for pol in embsys:
        file.write(pol + '\n')
    from phcpy.solutions import make_solution
    vars = []  # symbols for the variables
    vals = []  # values for the variables
    for k in range(len(point)):
        vars.append('x' + str(k))
        vals.append(point[k])
    dim = len(embsys) - len(point)
    if addslack:
        for k in range(1, dim+1):
            vars.append('zz' + str(k))
            vals.append(complex(0))
    print 'vars = \n', vars
    print 'vals = \n', vals
    sol = make_solution(vars, vals)
    n = len(point)
    file.write('\nTITLE : sample of tropical Backelin cyclic %d-roots\n' % n)
    file.write('\nTHE SOLUTIONS :\n')
    file.write('1 ' + str(len(vars)) + '\n')
    file.write('====================================================\n')
    file.write('solution 1 :\n')
    file.write(sol + '\n')

def main():
    """
    Prompts the user for the parameters m and L.
    """
    m = input("Give the m in n = m**2*L : ")
    L = input("Give the L in n = m**2*L : ")
    n = m**2*L
    print 'The dimension n = %d**2*%d = %d.' % (m, L, n)
    u, gamma = constants(m, L)
    print 'u =', u
    print 'gamma =', gamma
    coords = component(m, L, u, gamma)
    print 'coordinates of a cyclic %d-roots component :' % n
    for c in coords:
        print c
    point = sample(m, coords)
    print 'a random point:'
    for p in point:
        print '%.16e %+.16ej)' % (p.real, p.imag)
    residual = evaluate(point)
    print 'the residual :'
    for r in residual:
        print r
    print 'the sum :', sum([abs(r) for r in residual])
    ans = raw_input('embed sample point in witness set ? (y/n) ')
    if(ans == 'y'):
        ans = raw_input('use slack variables to square the system ? (y/n) ')
        addslack = (ans == 'y')
        emb = embedpoint(m-1, point, addslack)
        print 'the embedded system :\n', emb
        ans = raw_input('write the witness set to file ? (y/n) ')
        if(ans == 'y'):
            embedtofile(emb, point, addslack)

main()
