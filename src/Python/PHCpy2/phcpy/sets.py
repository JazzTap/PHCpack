"""
This module exports routines of PHCpack to manipulate
positive dimensional solution sets of polynomial systems.
"""

def standard_embed(nvar, topdim, pols):
    r"""
    Given in *pols* a list of strings representing polynomials in *nvar*
    variables, with coefficients in standard double precision,
    this function returns an embedding of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    """
    from phcpy.phcpy2c2 import py2c_embed_standard_system
    from phcpy.interface import store_standard_system, load_standard_system
    store_standard_system(pols, nbvar=nvar)
    py2c_embed_standard_system(topdim)
    return load_standard_system()

def dobldobl_embed(nvar, topdim, pols):
    r"""
    Given in *pols* a list of strings that represent polynomials in *nvar*
    variables, with coefficients in double double precision,
    this function returns an embedding of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    """
    from phcpy.phcpy2c2 import py2c_embed_dobldobl_system
    from phcpy.interface import store_dobldobl_system, load_dobldobl_system
    store_dobldobl_system(pols, nbvar=nvar)
    py2c_embed_dobldobl_system(topdim)
    return load_dobldobl_system()

def quaddobl_embed(nvar, topdim, pols):
    r"""
    Given in *pols* a list of strings that represent polynomials in n*var*
    variables, with coefficients in quad double precision,
    this function returns an embedding of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    """
    from phcpy.phcpy2c2 import py2c_embed_quaddobl_system
    from phcpy.interface import store_quaddobl_system, load_quaddobl_system
    store_quaddobl_system(pols, nbvar=nvar)
    py2c_embed_quaddobl_system(topdim)
    return load_quaddobl_system()

def standard_laurent_embed(nvar, topdim, pols):
    r"""
    Given in *pols* a list of strings representing Laurent polynomials
    in *nvar* variables, with coefficients in standard double precision,
    this function returns an embedding of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    """
    from phcpy.phcpy2c2 import py2c_embed_standard_Laurent_system
    from phcpy.interface import store_standard_laurent_system
    from phcpy.interface import load_standard_laurent_system
    store_standard_laurent_system(pols, nbvar=nvar)
    py2c_embed_standard_Laurent_system(topdim)
    return load_standard_laurent_system()

def dobldobl_laurent_embed(nvar, topdim, pols):
    r"""
    Given in *pols* a list of strings that represent Laurent polynomials
    in *nvar* variables, with coefficients in double double precision,
    this function returns an embedding of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    """
    from phcpy.phcpy2c2 import py2c_embed_dobldobl_Laurent_system
    from phcpy.interface import store_dobldobl_laurent_system
    from phcpy.interface import load_dobldobl_laurent_system
    store_dobldobl_laurent_system(pols, nbvar=nvar)
    py2c_embed_dobldobl_Laurent_system(topdim)
    return load_dobldobl_laurent_system()

def quaddobl_laurent_embed(nvar, topdim, pols):
    r"""
    Given in *pols* a list of strings that represent Laurent polynomials
    in n*var* variables, with coefficients in quad double precision,
    this function returns an embedding of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    """
    from phcpy.phcpy2c2 import py2c_embed_quaddobl_Laurent_system
    from phcpy.interface import store_quaddobl_laurent_system
    from phcpy.interface import load_quaddobl_laurent_system
    store_quaddobl_laurent_system(pols, nbvar=nvar)
    py2c_embed_quaddobl_Laurent_system(topdim)
    return load_quaddobl_laurent_system()

def embed(nvar, topdim, pols, precision='d'):
    r"""
    Given in *pols* a list of strings that represent polynomials in *nvar*
    variables, this function returns an embedding 
    of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    The default precision of the coefficients is 'd', for standard double
    precision.  For double double and quad double precision, set the value
    of precision to 'dd' or 'qd' respectively.
    """
    if(precision == 'd'):
        return standard_embed(nvar, topdim, pols)
    elif(precision == 'dd'):
        return dobldobl_embed(nvar, topdim, pols)
    elif(precision == 'qd'):
        return quaddobl_embed(nvar, topdim, pols)
    else:
        print 'wrong argument for precision'
        return None

def laurent_embed(nvar, topdim, pols, precision='d'):
    r"""
    Given in *pols* a list of strings that represent Laurent polynomials
    in *nvar* variables, this function returns an embedding 
    of *pols* of dimension *topdim*.
    The *topdim* is the top dimension which equals the expected highest
    dimension of a component of the solution set of the system of polynomials.
    The default precision of the coefficients is 'd', for standard double
    precision.  For double double and quad double precision, set the value
    of precision to 'dd' or 'qd' respectively.
    """
    if(precision == 'd'):
        return standard_laurent_embed(nvar, topdim, pols)
    elif(precision == 'dd'):
        return dobldobl_laurent_embed(nvar, topdim, pols)
    elif(precision == 'qd'):
        return quaddobl_laurent_embed(nvar, topdim, pols)
    else:
        print 'wrong argument for precision'
        return None

def witness_set_of_hypersurface(nvar, hpol, precision='d'):
    r"""
    Given in *hpol* the string representation of a polynomial
    in *nvar* variables (ending with a semicolon),
    on return is an embedded system and its solutions
    which represents a witness set for *hpol*.
    The number of solutions on return should equal
    the degree of the polynomial in *hpol*.
    Three different precisions are supported, by default double ('d'),
    or otherwise double double ('dd') or quad double ('qd').
    """
    if(precision == 'd'):
        from phcpy.phcpy2c2 import py2c_standard_witset_of_hypersurface
        from phcpy.interface import load_standard_system
        from phcpy.interface import load_standard_solutions
        py2c_standard_witset_of_hypersurface(nvar, len(hpol), hpol)
        return (load_standard_system(), load_standard_solutions())
    elif(precision == 'dd'):
        from phcpy.phcpy2c2 import py2c_dobldobl_witset_of_hypersurface
        from phcpy.interface import load_dobldobl_system
        from phcpy.interface import load_dobldobl_solutions
        py2c_dobldobl_witset_of_hypersurface(nvar, len(hpol), hpol)
        return (load_dobldobl_system(), load_dobldobl_solutions())
    elif(precision == 'qd'):
        from phcpy.phcpy2c2 import py2c_quaddobl_witset_of_hypersurface
        from phcpy.interface import load_quaddobl_system
        from phcpy.interface import load_quaddobl_solutions
        py2c_quaddobl_witset_of_hypersurface(nvar, len(hpol), hpol)
        return (load_quaddobl_system(), load_quaddobl_solutions())
    else:
        print 'wrong argument for precision'
        return None

def drop_variable_from_polynomials(pols, svar):
    r"""
    Removes the variable with symbol in the string *svar*
    from the list *pols* of strings that represented
    polynomials in several variables.
    Note that the system in *pols* must be square.
    """
    from phcpy.phcpy2c2 import py2c_syscon_standard_drop_variable_by_name
    from phcpy.phcpy2c2 import py2c_syscon_remove_symbol_name
    from phcpy.interface import store_standard_system, load_standard_system
    store_standard_system(pols)
    py2c_syscon_standard_drop_variable_by_name(len(svar), svar)
    py2c_syscon_remove_symbol_name(len(svar), svar)
    return load_standard_system()

def drop_coordinate_from_solutions(sols, nbvar, svar):
    r"""
    Removes the variable with symbol in the string *svar*
    from the list *sols* of strings that represent solutions
    in *nbvar* variables.
    """
    from phcpy.phcpy2c2 import py2c_syscon_clear_symbol_table
    from phcpy.phcpy2c2 import py2c_solcon_standard_drop_coordinate_by_name
    from phcpy.phcpy2c2 import py2c_syscon_remove_symbol_name
    from phcpy.interface import store_standard_solutions
    from phcpy.interface import load_standard_solutions
    py2c_syscon_clear_symbol_table()
    store_standard_solutions(nbvar, sols)
    py2c_solcon_standard_drop_coordinate_by_name(len(svar), svar)
    py2c_syscon_remove_symbol_name(len(svar), svar)
    return load_standard_solutions()

def standard_membertest(wsys, gpts, dim, point, \
    evatol=1.0e-6, memtol=1.0e-6, verbose=True):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding polynomial
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True.
    Calculations happen in standard double precision.
    The default values for the evaluation (*evatol*) and the membership
    (*memtol*) allow for singular values at the end points of the paths
    in the homotopy membership test.
    """
    from phcpy.interface import store_standard_system as storesys
    from phcpy.interface import store_standard_solutions as storesols
    from phcpy.phcpy2c2 import py2c_witset_standard_membertest as membtest
    storesys(wsys)
    storesols(len(wsys), gpts)
    nvr = len(point)/2
    strpt = str(point)
    nbc = len(strpt)
    result = membtest(int(verbose), nvr, dim, nbc, evatol, memtol, strpt)
    return (result[2] == 1)

def dobldobl_membertest(wsys, gpts, dim, point, \
    evatol=1.0e-6, memtol=1.0e-6, verbose=True):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding polynomial
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True.
    Calculations happen in double double precision.
    The default values for the evaluation (*evatol*) and the membership
    (*memtol*) allow for singular values at the end points of the paths
    in the homotopy membership test.
    """
    from phcpy.interface import store_dobldobl_system as storesys
    from phcpy.interface import store_dobldobl_solutions as storesols
    from phcpy.phcpy2c2 import py2c_witset_dobldobl_membertest as membtest
    storesys(wsys)
    storesols(len(wsys), gpts)
    nvr = len(point)/4
    strpt = str(point)
    nbc = len(strpt)
    result = membtest(int(verbose), nvr, dim, nbc, evatol, memtol, strpt)
    return (result[2] == 1)

def quaddobl_membertest(wsys, gpts, dim, point, \
    evatol=1.0e-6, memtol=1.0e-6, verbose=True):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding polynomial
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True.
    Calculations happen in quad double precision.
    The default values for the evaluation (*evatol*) and the membership
    (*memtol*) allow for singular values at the end points of the paths
    in the homotopy membership test.
    """
    from phcpy.interface import store_quaddobl_system as storesys
    from phcpy.interface import store_quaddobl_solutions as storesols
    from phcpy.phcpy2c2 import py2c_witset_quaddobl_membertest as membtest
    storesys(wsys)
    storesols(len(wsys), gpts)
    nvr = len(point)/8
    strpt = str(point)
    nbc = len(strpt)
    result = membtest(int(verbose), nvr, dim, nbc, evatol, memtol, strpt)
    return (result[2] == 1)

def standard_laurent_membertest(wsys, gpts, dim, point, \
    evatol=1.0e-6, memtol=1.0e-6, verbose=True):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding Laurent
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True.
    Calculations happen in standard double precision.
    The default values for the evaluation (*evatol*) and the membership
    (*memtol*) allow for singular values at the end points of the paths
    in the homotopy membership test.
    """
    from phcpy.interface import store_standard_laurent_system as storesys
    from phcpy.interface import store_standard_solutions as storesols
    from phcpy.phcpy2c2 \
    import py2c_witset_standard_Laurent_membertest as membtest
    storesys(wsys)
    storesols(len(wsys), gpts)
    nvr = len(point)/2
    strpt = str(point)
    nbc = len(strpt)
    result = membtest(int(verbose), nvr, dim, nbc, evatol, memtol, strpt)
    return (result[2] == 1)

def dobldobl_laurent_membertest(wsys, gpts, dim, point, \
    evatol=1.0e-6, memtol=1.0e-6, verbose=True):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding Laurent
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True.
    Calculations happen in double double precision.
    The default values for the evaluation (*evatol*) and the membership
    (*memtol*) allow for singular values at the end points of the paths
    in the homotopy membership test.
    """
    from phcpy.interface import store_dobldobl_laurent_system as storesys
    from phcpy.interface import store_dobldobl_solutions as storesols
    from phcpy.phcpy2c2 \
    import py2c_witset_dobldobl_Laurent_membertest as membtest
    storesys(wsys)
    storesols(len(wsys), gpts)
    nvr = len(point)/4
    strpt = str(point)
    nbc = len(strpt)
    result = membtest(int(verbose), nvr, dim, nbc, evatol, memtol, strpt)
    return (result[2] == 1)

def quaddobl_laurent_membertest(wsys, gpts, dim, point, \
    evatol=1.0e-6, memtol=1.0e-6, verbose=True):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding Laurent
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True.
    Calculations happen in quad double precision.
    The default values for the evaluation (*evatol*) and the membership
    (*memtol*) allow for singular values at the end points of the paths
    in the homotopy membership test.
    """
    from phcpy.interface import store_quaddobl_laurent_system as storesys
    from phcpy.interface import store_quaddobl_solutions as storesols
    from phcpy.phcpy2c2 \
    import py2c_witset_quaddobl_Laurent_membertest as membtest
    storesys(wsys)
    storesols(len(wsys), gpts)
    nvr = len(point)/8
    strpt = str(point)
    nbc = len(strpt)
    result = membtest(int(verbose), nvr, dim, nbc, evatol, memtol, strpt)
    return (result[2] == 1)

def membertest(wsys, gpts, dim, point, evatol=1.0e-6, memtol=1.0e-6, \
    verbose=True, precision='d'):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding polynomial
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True, and the
    working precision is double 'd'.  Other levels of precision are
    double double precision 'dd' and quad double precision 'qd'.
    There are two tolerances: *evatol* is the tolerance on the residual
    of the evaluation of the polynomial equations at the test point.
    If the residual of the evalution is not less than *evatol*,
    then the membertest returns False.  Otherwise, the homotopy
    membership test is called and the *memtol* is used to compare
    the coordinates of the point with the newly computed generic points.
    If there is a match between the coordinates within the given
    tolerance *memtol*, then True is returned.
    """
    if(precision == 'd'):
        return standard_membertest(wsys, gpts, dim, point, \
                                   evatol, memtol, verbose)
    elif(precision == 'dd'):
        return dobldobl_membertest(wsys, gpts, dim, point, \
                                   evatol, memtol, verbose)
    elif(precision == 'qd'):
        return quaddobl_membertest(wsys, gpts, dim, point, \
                                   evatol, memtol, verbose)
    else:
        print 'wrong argument for precision'
        return None

def laurent_membertest(wsys, gpts, dim, point, \
    evatol=1.0e-6, memtol=1.0e-6, verbose=True, precision='d'):
    r"""
    Applies the homotopy membership test for a *point* to belong to
    a witness set of dimension *dim*, given by an embedding Laurent
    system in *wsys*, with corresponding generic points in *gpts*.
    The coordinates of the test point are given in the list *point*,
    as a list of doubles, with the real and imaginary part of each
    coordinate of the point.  By default, *verbose* is True, and the
    working precision is double 'd'.  Other levels of precision are
    double double precision 'dd' and quad double precision 'qd'.
    There are two tolerances: *evatol* is the tolerance on the residual
    of the evaluation of the Laurent system at the test point.
    If the residual of the evalution is not less than *evatol*,
    then the membertest returns False.  Otherwise, the homotopy
    membership test is called and the *memtol* is used to compare
    the coordinates of the point with the newly computed generic points.
    If there is a match between the coordinates within the given
    tolerance *memtol*, then True is returned.
    """
    if(precision == 'd'):
        return standard_laurent_membertest\
                   (wsys, gpts, dim, point, evatol, memtol, verbose)
    elif(precision == 'dd'):
        return dobldobl_laurent_membertest\
                   (wsys, gpts, dim, point, evatol, memtol, verbose)
    elif(precision == 'qd'):
        return quaddobl_laurent_membertest\
                   (wsys, gpts, dim, point, evatol, memtol, verbose)
    else:
        print 'wrong argument for precision'
        return None

def is_slackvar(var):
    r"""
    Given in *var* is a string with a variable name.
    Returns True if the variable name starts with 'zz',
    followed by a number.  Returns False otherwise.
    """
    if len(var) <= 2: # too short to be a slack variable
        return False
    elif var[:2] != 'zz': # a slack variable starts with zz
        return False
    else:
        rest = var[2:]
        return rest.isdigit()

def is_signed(pol):
    r"""
    Given in *pol* is the string representation of a polynomial.
    Returns True if the first nonspace character in the string *pol*
    is either '+' or '-'.  Returns False otherwise.
    """
    wrk = pol.lstrip()
    if len(wrk) == 0: # all characters in pol are spaces
        return False
    else:
        return (wrk[0] == '+' or wrk[0] == '-')

def is_member(wsys, gpts, dim, solpt, evatol=1.0e-6, memtol=1.0e-6, \
    verbose=True, precision='d'):
    r"""
    This function wraps the membertest where the point is a solution,
    given in *solpt*.  All other parameters have the same meaning as
    in the function membertest.
    """
    from phcpy.solutions import strsol2dict, variables
    from phcpy.solver import names_of_variables
    soldc = strsol2dict(solpt)
    svars = variables(soldc)
    pvars = names_of_variables(wsys)
    if verbose:
        print 'variables in solution :', svars
        print 'variables in system   :', pvars
    (ordvar, solval) = ('', [])
    for var in svars:
        if not is_slackvar(var): # skip the slack variables
            if var not in pvars:
                print 'Error: mismatch of variables names.'
                return None
            ordvar = ordvar + '+' + var + '-' + var
            solval.append(soldc[var].real)
            if precision == 'dd':
                solval.append(0.0)
            elif precision == 'qd':
                solval.append(0.0)
                solval.append(0.0)
                solval.append(0.0)
            solval.append(soldc[var].imag)
            if precision == 'dd':
                solval.append(0.0)
            elif precision == 'qd':
                solval.append(0.0)
                solval.append(0.0)
                solval.append(0.0)
    if verbose:
        print 'order of the variables :', ordvar
        print 'values in the point :', solval
    wpol0 = wsys[0]
    if is_signed(wpol0):
        newpol0 = ordvar + wpol0
    else:
        newpol0 = ordvar + '+' + wpol0
    newsys = [newpol0] + wsys[1:]
    return membertest(newsys, gpts, dim, solval, evatol, memtol, \
                      verbose, precision)

def test_member(prc='d'):
    """
    To test the membership, we take the twisted cubic.
    """
    twisted = ['x^2 - y;', 'x^3 - z;']
    twiste1 = embed(3, 1, twisted)
    twiste1[0] = 'x + y + z - x - y - z + ' + twiste1[0]
    from phcpy.solver import solve
    twtsols = solve(twiste1, precision=prc)
    for sol in twtsols:
        print sol
    if(prc == 'd'):
        inpoint = [1, 0, 1, 0, 1, 0]
        outpoint = [1, 0, 1, 0, 2, 0]
    elif(prc == 'dd'):
        inpoint = [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
        outpoint = [1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0]
    elif(prc == 'qd'):
        inpoint = [1, 0, 0, 0, 0, 0, 0, 0, \
                   1, 0, 0, 0, 0, 0, 0, 0, \
                   1, 0, 0, 0, 0, 0, 0, 0]
        outpoint = [1, 0, 0, 0, 0, 0, 0, 0, \
                    1, 0, 0, 0, 0, 0, 0, 0, \
                    2, 0, 0, 0, 0, 0, 0, 0, ]
    print membertest(twiste1, twtsols, 1, inpoint, precision=prc)
    print membertest(twiste1, twtsols, 1, outpoint, precision=prc)

def test_ismember(prc='d'):
    """
    To test the membertest wrapper, we take the twisted cubic again.
    """
    from phcpy.solver import solve
    from phcpy.solutions import make_solution
    twisted = ['x^2 - y;', 'x^3 - z;']
    twiste1 = embed(3, 1, twisted)
    twtsols = solve(twiste1, precision=prc)
    for sol in twtsols:
        print sol
    print(is_member(twiste1, twtsols, 1, twtsols[0], precision=prc))
    outsol = make_solution(['x', 'y', 'z'], [1, 2, 3])
    print(is_member(twiste1, twtsols, 1, outsol, precision=prc))

def top_diagonal_dimension(kdm, dim1, dim2):
    r"""
    Returns the number of slack variables at the top in the cascade of
    diagonal homotopies to intersect two sets of dimension *dim1* and *dim2*,
    where *dim1* >= *dim2* and *kdm* is the dimension before the embedding.
    Typically, *kdm* is the number of equations in the first witness set
    minus *dim1*.
    """
    if dim1 + dim2 < kdm:
        return dim2
    else:
        return kdm - dim1

def standard_diagonal_homotopy(dim1, sys1, esols1, dim2, sys2, esols2):
    r"""
    Defines a diagonal homotopy to intersect the witness sets defined
    by (*sys1*, *esols1*) and (*sys2*, *esols2*), respectively of dimensions
    *dim1* and *dim2*.  The systems *sys1* and *sys2* are assumed to be square
    and with as many slack variables as the dimension of the solution sets.
    The data is stored in standard double precision.
    """
    from phcpy.interface import store_standard_system as storesys
    from phcpy.interface import store_standard_solutions as storesols
    from phcpy.phcpy2c2 import py2c_copy_standard_container_to_target_system
    from phcpy.phcpy2c2 import py2c_copy_standard_container_to_target_solutions
    from phcpy.phcpy2c2 import py2c_copy_standard_container_to_start_system
    from phcpy.phcpy2c2 import py2c_copy_standard_container_to_start_solutions
    from phcpy.phcpy2c2 import py2c_standard_diagonal_homotopy
    from phcpy.phcpy2c2 import py2c_syscon_number_of_symbols
    from phcpy.phcpy2c2 import py2c_syscon_string_of_symbols
    from phcpy.phcpy2c2 import py2c_diagonal_symbols_doubler
    storesys(sys1)
    symbols = py2c_syscon_string_of_symbols()
    nbsymbs = py2c_syscon_number_of_symbols()
    print 'number of symbols :', nbsymbs
    print 'names of variables :', symbols
    storesols(len(sys1), esols1)
    if(dim1 >= dim2):
        py2c_copy_standard_container_to_target_system()
        py2c_copy_standard_container_to_target_solutions()
    else:
        py2c_copy_standard_container_to_start_system()
        py2c_copy_standard_container_to_start_solutions()
    storesys(sys2)
    storesols(len(sys2), esols2)
    if(dim1 >= dim2):
        py2c_copy_standard_container_to_start_system()
        py2c_copy_standard_container_to_start_solutions()
    else:
        py2c_copy_standard_container_to_target_system()
        py2c_copy_standard_container_to_target_solutions()
    if(dim1 >= dim2):
        py2c_standard_diagonal_homotopy(dim1, dim2)
    else:
        py2c_standard_diagonal_homotopy(dim2, dim1)
    py2c_diagonal_symbols_doubler(nbsymbs-dim1, dim1, len(symbols), symbols)

def dobldobl_diagonal_homotopy(dim1, sys1, esols1, dim2, sys2, esols2):
    r"""
    Defines a diagonal homotopy to intersect the witness sets defined
    by (*sys1*, *esols1*) and (*sys2*, *esols2*), respectively of dimensions
    *dim1* and *dim2*.  The systems *sys1* and *sys2* are assumed to be square
    and with as many slack variables as the dimension of the solution sets.
    The data is stored in double double precision.
    """
    from phcpy.interface import store_dobldobl_system as storesys
    from phcpy.interface import store_dobldobl_solutions as storesols
    from phcpy.phcpy2c2 import py2c_copy_dobldobl_container_to_target_system
    from phcpy.phcpy2c2 import py2c_copy_dobldobl_container_to_target_solutions
    from phcpy.phcpy2c2 import py2c_copy_dobldobl_container_to_start_system
    from phcpy.phcpy2c2 import py2c_copy_dobldobl_container_to_start_solutions
    from phcpy.phcpy2c2 import py2c_dobldobl_diagonal_homotopy
    from phcpy.phcpy2c2 import py2c_syscon_number_of_symbols
    from phcpy.phcpy2c2 import py2c_syscon_string_of_symbols
    from phcpy.phcpy2c2 import py2c_diagonal_symbols_doubler
    storesys(sys1)
    symbols = py2c_syscon_string_of_symbols()
    nbsymbs = py2c_syscon_number_of_symbols()
    print 'number of symbols :', nbsymbs
    print 'names of variables :', symbols
    storesols(len(sys1), esols1)
    if(dim1 >= dim2):
        py2c_copy_dobldobl_container_to_target_system()
        py2c_copy_dobldobl_container_to_target_solutions()
    else:
        py2c_copy_dobldobl_container_to_start_system()
        py2c_copy_dobldobl_container_to_start_solutions()
    storesys(sys2)
    storesols(len(sys2), esols2)
    if(dim1 >= dim2):
        py2c_copy_dobldobl_container_to_start_system()
        py2c_copy_dobldobl_container_to_start_solutions()
    else:
        py2c_copy_dobldobl_container_to_target_system()
        py2c_copy_dobldobl_container_to_target_solutions()
    if(dim1 >= dim2):
        py2c_dobldobl_diagonal_homotopy(dim1, dim2)
    else:
        py2c_dobldobl_diagonal_homotopy(dim2, dim1)
    py2c_diagonal_symbols_doubler(nbsymbs-dim1, dim1, len(symbols), symbols)

def quaddobl_diagonal_homotopy(dim1, sys1, esols1, dim2, sys2, esols2):
    r"""
    Defines a diagonal homotopy to intersect the witness sets defined
    by (*sys1*, *esols1*) and (*sys2*, *esols2*), respectively of dimensions
    *dim1* and *dim2*.  The systems *sys1* and *sys2* are assumed to be square
    and with as many slack variables as the dimension of the solution sets.
    The data is stored in quad double precision.
    """
    from phcpy.interface import store_quaddobl_system as storesys
    from phcpy.interface import store_quaddobl_solutions as storesols
    from phcpy.phcpy2c2 import py2c_copy_quaddobl_container_to_target_system
    from phcpy.phcpy2c2 import py2c_copy_quaddobl_container_to_target_solutions
    from phcpy.phcpy2c2 import py2c_copy_quaddobl_container_to_start_system
    from phcpy.phcpy2c2 import py2c_copy_quaddobl_container_to_start_solutions
    from phcpy.phcpy2c2 import py2c_quaddobl_diagonal_homotopy
    from phcpy.phcpy2c2 import py2c_syscon_number_of_symbols
    from phcpy.phcpy2c2 import py2c_syscon_string_of_symbols
    from phcpy.phcpy2c2 import py2c_diagonal_symbols_doubler
    storesys(sys1)
    symbols = py2c_syscon_string_of_symbols()
    nbsymbs = py2c_syscon_number_of_symbols()
    print 'number of symbols :', nbsymbs
    print 'names of variables :', symbols
    storesols(len(sys1), esols1)
    if(dim1 >= dim2):
        py2c_copy_quaddobl_container_to_target_system()
        py2c_copy_quaddobl_container_to_target_solutions()
    else:
        py2c_copy_quaddobl_container_to_start_system()
        py2c_copy_quaddobl_container_to_start_solutions()
    storesys(sys2)
    storesols(len(sys2), esols2)
    if(dim1 >= dim2):
        py2c_copy_quaddobl_container_to_start_system()
        py2c_copy_quaddobl_container_to_start_solutions()
    else:
        py2c_copy_quaddobl_container_to_target_system()
        py2c_copy_quaddobl_container_to_target_solutions()
    if(dim1 >= dim2):
        py2c_quaddobl_diagonal_homotopy(dim1, dim2)
    else:
        py2c_quaddobl_diagonal_homotopy(dim2, dim1)
    py2c_diagonal_symbols_doubler(nbsymbs-dim1, dim1, len(symbols), symbols)

def standard_diagonal_cascade_solutions(dim1, dim2):
    r"""
    Defines the start solutions in the cascade to start the diagonal
    homotopy to intersect a set of dimension *dim1* with another set
    of dimension *dim2*, in standard double precision.  For this to work,
    standard_diagonal_homotopy must have been executed successfully.
    """
    from phcpy.phcpy2c2 import py2c_standard_diagonal_cascade_solutions
    if(dim1 >= dim2):
        py2c_standard_diagonal_cascade_solutions(dim1, dim2)
    else:
        py2c_standard_diagonal_cascade_solutions(dim2, dim1)

def dobldobl_diagonal_cascade_solutions(dim1, dim2):
    r"""
    Defines the start solutions in the cascade to start the diagonal
    homotopy to intersect a set of dimension *dim1* with another set
    of dimension *dim2*, in double double precision.  For this to work,
    dobldobl_diagonal_homotopy must have been executed successfully.
    """
    from phcpy.phcpy2c2 import py2c_dobldobl_diagonal_cascade_solutions
    if(dim1 >= dim2):
        py2c_dobldobl_diagonal_cascade_solutions(dim1, dim2)
    else:
        py2c_dobldobl_diagonal_cascade_solutions(dim2, dim1)

def quaddobl_diagonal_cascade_solutions(dim1, dim2):
    """
    Defines the start solutions in the cascade to start the diagonal
    homotopy to intersect a set of dimension *dim1* with another set
    of dimension *dim2*, in quad double precision.  For this to work,
    quaddobl_diagonal_homotopy must have been executed successfully.
    """
    from phcpy.phcpy2c2 import py2c_quaddobl_diagonal_cascade_solutions
    if(dim1 >= dim2):
        py2c_quaddobl_diagonal_cascade_solutions(dim1, dim2)
    else:
        py2c_quaddobl_diagonal_cascade_solutions(dim2, dim1)

def standard_start_diagonal_cascade(gamma=0, tasks=0):
    r"""
    Does the path tracking to start a diagonal cascade in standard double
    precision.  For this to work, the functions standard_diagonal_homotopy
    and standard_diagonal_cascade_solutions must be executed successfully.
    If *gamma* equals 0 on input, then a random gamma constant is generated,
    otherwise, the given complex *gamma* will be used in the homotopy.
    Multitasking is available, and activated by the *tasks* parameter.
    Returns the target (system and its corresponding) solutions.
    """
    from phcpy.phcpy2c2 import py2c_create_standard_homotopy
    from phcpy.phcpy2c2 import py2c_create_standard_homotopy_with_gamma
    from phcpy.phcpy2c2 import py2c_solve_by_standard_homotopy_continuation
    from phcpy.phcpy2c2 import py2c_solcon_clear_standard_solutions
    from phcpy.phcpy2c2 import py2c_syscon_clear_standard_system
    from phcpy.phcpy2c2 import py2c_copy_standard_target_solutions_to_container
    from phcpy.phcpy2c2 import py2c_copy_standard_target_system_to_container
    from phcpy.interface import load_standard_solutions
    from phcpy.interface import load_standard_system
    if(gamma == 0):
        py2c_create_standard_homotopy()
    else:
        py2c_create_standard_homotopy_with_gamma(gamma.real, gamma.imag)
    py2c_solve_by_standard_homotopy_continuation(tasks)
    py2c_solcon_clear_standard_solutions()
    py2c_syscon_clear_standard_system()
    py2c_copy_standard_target_solutions_to_container()
    # from phcpy.phcpy2c2 import py2c_write_standard_target_system
    # print 'the standard target system :'
    # py2c_write_standard_target_system()
    py2c_copy_standard_target_system_to_container()
    tsys = load_standard_system()
    sols = load_standard_solutions()
    return (tsys, sols)

def dobldobl_start_diagonal_cascade(gamma=0, tasks=0):
    r"""
    Does the path tracking to start a diagonal cascade in double double
    precision.  For this to work, the functions dobldobl_diagonal_homotopy
    and dobldobl_diagonal_cascade_solutions must be executed successfully.
    If *gamma* equals 0 on input, then a random *gamma* constant is generated,
    otherwise, the given complex *gamma* will be used in the homotopy.
    Multitasking is available, and activated by the *tasks* parameter.
    Returns the target (system and its corresponding) solutions.
    """
    from phcpy.phcpy2c2 import py2c_create_dobldobl_homotopy
    from phcpy.phcpy2c2 import py2c_create_dobldobl_homotopy_with_gamma
    from phcpy.phcpy2c2 import py2c_solve_by_dobldobl_homotopy_continuation
    from phcpy.phcpy2c2 import py2c_solcon_clear_dobldobl_solutions
    from phcpy.phcpy2c2 import py2c_syscon_clear_dobldobl_system
    from phcpy.phcpy2c2 import py2c_copy_dobldobl_target_solutions_to_container
    from phcpy.phcpy2c2 import py2c_copy_dobldobl_target_system_to_container
    from phcpy.interface import load_dobldobl_solutions
    from phcpy.interface import load_dobldobl_system
    if(gamma == 0):
        py2c_create_dobldobl_homotopy()
    else:
        py2c_create_dobldobl_homotopy_with_gamma(gamma.real, gamma.imag)
    py2c_solve_by_dobldobl_homotopy_continuation(tasks)
    py2c_solcon_clear_dobldobl_solutions()
    py2c_syscon_clear_dobldobl_system()
    py2c_copy_dobldobl_target_solutions_to_container()
    # from phcpy.phcpy2c2 import py2c_write_dobldobl_target_system
    # print 'the dobldobl target system :'
    # py2c_write_dobldobl_target_system()
    py2c_copy_dobldobl_target_system_to_container()
    tsys = load_dobldobl_system()
    sols = load_dobldobl_solutions()
    return (tsys, sols)

def quaddobl_start_diagonal_cascade(gamma=0, tasks=0):
    r"""
    Does the path tracking to start a diagonal cascade in quad double
    precision.  For this to work, the functions quaddobl_diagonal_homotopy
    and quaddobl_diagonal_cascade_solutions must be executed successfully.
    If *gamma* equals 0 on input, then a random *gamma* constant is generated,
    otherwise, the given complex *gamma* will be used in the homotopy.
    Multitasking is available, and is activated by the *tasks* parameter.
    Returns the target (system and its corresponding) solutions.
    """
    from phcpy.phcpy2c2 import py2c_create_quaddobl_homotopy
    from phcpy.phcpy2c2 import py2c_create_quaddobl_homotopy_with_gamma
    from phcpy.phcpy2c2 import py2c_solve_by_quaddobl_homotopy_continuation
    from phcpy.phcpy2c2 import py2c_solcon_clear_quaddobl_solutions
    from phcpy.phcpy2c2 import py2c_syscon_clear_quaddobl_system
    from phcpy.phcpy2c2 import py2c_copy_quaddobl_target_solutions_to_container
    from phcpy.phcpy2c2 import py2c_copy_quaddobl_target_system_to_container
    from phcpy.interface import load_quaddobl_solutions
    from phcpy.interface import load_quaddobl_system
    if(gamma == 0):
        py2c_create_quaddobl_homotopy()
    else:
        py2c_create_quaddobl_homotopy_with_gamma(gamma.real, gamma.imag)
    py2c_solve_by_quaddobl_homotopy_continuation(tasks)
    py2c_solcon_clear_quaddobl_solutions()
    py2c_syscon_clear_quaddobl_system()
    py2c_copy_quaddobl_target_solutions_to_container()
    # from phcpy.phcpy2c2 import py2c_write_quaddobl_target_system
    # print 'the quaddobl target system :'
    # py2c_write_quaddobl_target_system()
    py2c_copy_quaddobl_target_system_to_container()
    tsys = load_quaddobl_system()
    sols = load_quaddobl_solutions()
    return (tsys, sols)

def standard_diagonal_solver(dim, dm1, sys1, sols1, dm2, sys2, sols2, \
    tasks=0, verbose=True):
    r"""
    Runs the diagonal homotopies in standard double precision
    to intersect two witness sets stored in (*sys1*, *sols1*) and
    (*sys2*, *sols2*), of respective dimensions *dm1* and *dm2*.
    The ambient dimension equals *dim*.
    Multitasking is available, and is activated by the *tasks* parameter.
    Returns the last system in the cascade and its solutions.
    If *verbose*, then the solver runs in interactive mode, printing
    intermediate results to screen and prompting the user to continue.
    """
    from phcpy.phcpy2c2 import py2c_standard_collapse_diagonal
    from phcpy.interface import store_standard_solutions as storesols
    from phcpy.interface import load_standard_solutions as loadsols
    from phcpy.interface import load_standard_system as loadsys
    from phcpy.phcpy2c2 import py2c_extrinsic_top_diagonal_dimension
    from phcpy.solutions import filter_vanishing
    topdim = py2c_extrinsic_top_diagonal_dimension(dim+dm1, dim+dm2, dm1, dm2)
    kdm = len(sys1) - dm1
    topdiagdim = top_diagonal_dimension(kdm, dm1, dm2)
    if verbose:
        print 'the top dimension :', topdim, 'dim :', dim
        print 'number of slack variables at the top :', topdiagdim 
    standard_diagonal_homotopy(dm1, sys1, sols1, dm2, sys2, sols2)
    if verbose:
        print 'defining the start solutions'
    standard_diagonal_cascade_solutions(dm1, dm2)
    if verbose:
        print 'starting the diagonal cascade'
    (topsys, startsols) = standard_start_diagonal_cascade()
    if verbose:
        print 'the system solved in the start of the cascade :'
        for pol in topsys:
            print pol
        print 'the solutions after starting the diagonal cascade :'
        for sol in startsols:
            print sol
        raw_input('hit enter to continue')
    for k in range(topdiagdim, 0, -1):
        endsols = standard_double_cascade_step(topsys, startsols)
        if verbose:
            print 'after running cascade step %d :' % k
            for sol in endsols:
                print sol
        endsolsf1 = filter_vanishing(endsols, 1.0e-8)
        if verbose:
            print 'computed', len(endsolsf1), 'solutions'
            raw_input('hit enter to continue')
        slack = 'zz' + str(k)
        nbvar = len(topsys)
        endsolsf2 = drop_coordinate_from_solutions(endsolsf1, nbvar, slack)
        if verbose:
            print 'after dropping the slack coordinate from the solutions :'
            for sol in endsolsf2:
                print sol
            raw_input('hit enter to continue')
        nextsys = drop_variable_from_polynomials(topsys, slack)
        if verbose:
            print 'after dropping the variable', slack, 'from the system :'
            for pol in nextsys:
                print pol
        (topsys, startsols) = (nextsys[:-1], endsolsf2)
    storesols(len(topsys), startsols)
    # py2c_standard_collapse_diagonal(topdim - 2*dim, 0)
    py2c_standard_collapse_diagonal(0, 0)
    result = (loadsys(), loadsols())
    return result

def dobldobl_diagonal_solver(dim, dm1, sys1, sols1, dm2, sys2, sols2, \
    tasks=0, verbose=True):
    r"""
    Runs the diagonal homotopies in double double precision
    to intersect two witness sets stored in (*sys1*, *sols1*) and
    (*sys2*, *sols2*), of respective dimensions *dm1* and *dm2*.
    The ambient dimension equals *dim*.
    Multitasking is available, and is activated by the *tasks* parameter.
    Returns the last system in the cascade and its solutions.
    If *verbose*, then the solver runs in interactive mode, printing
    intermediate results to screen and prompting the user to continue.
    """
    from phcpy.phcpy2c2 import py2c_dobldobl_collapse_diagonal
    from phcpy.interface import store_dobldobl_solutions as storesols
    from phcpy.interface import load_dobldobl_solutions as loadsols
    from phcpy.interface import load_dobldobl_system as loadsys
    from phcpy.phcpy2c2 import py2c_extrinsic_top_diagonal_dimension
    from phcpy.solutions import filter_vanishing
    topdim = py2c_extrinsic_top_diagonal_dimension(dim+dm1, dim+dm2, dm1, dm2)
    kdm = len(sys1) - dm1
    topdiagdim = top_diagonal_dimension(kdm, dm1, dm2)
    if verbose:
        print 'the top dimension :', topdim, 'dim :', dim
        print 'number of slack variables at the top :', topdiagdim 
    dobldobl_diagonal_homotopy(dm1, sys1, sols1, dm2, sys2, sols2)
    if verbose:
        print 'defining the start solutions'
    dobldobl_diagonal_cascade_solutions(dm1, dm2)
    if verbose:
        print 'starting the diagonal cascade'
    (topsys, startsols) = dobldobl_start_diagonal_cascade()
    if verbose:
        print 'the system solved in the start of the cascade :'
        for pol in topsys:
            print pol
        print 'the solutions after starting the diagonal cascade :'
        for sol in startsols:
            print sol
        raw_input('hit enter to continue')
    for k in range(topdiagdim, 0, -1):
        endsols = double_double_cascade_step(topsys, startsols)
        if verbose:
            print 'after running cascade step %d :' % k
            for sol in endsols:
                print sol
        endsolsf1 = filter_vanishing(endsols, 1.0e-8)
        if verbose:
            print 'computed', len(endsolsf1), 'solutions'
            raw_input('hit enter to continue')
        slack = 'zz' + str(k)
        nbvar = len(topsys)
        endsolsf2 = drop_coordinate_from_solutions(endsolsf1, nbvar, slack)
        if verbose:
            print 'after dropping the slack coordinate from the solutions :'
            for sol in endsolsf2:
                print sol
            raw_input('hit enter to continue')
        nextsys = drop_variable_from_polynomials(topsys, slack)
        if verbose:
            print 'after dropping the variable', slack, 'from the system :'
            for pol in nextsys:
                print pol
        (topsys, startsols) = (nextsys[:-1], endsolsf2)
    storesols(len(topsys), startsols)
    # py2c_dobldobl_collapse_diagonal(topdim - 2*dim, 0)
    py2c_dobldobl_collapse_diagonal(0, 0)
    result = (loadsys(), loadsols())
    return result

def quaddobl_diagonal_solver(dim, dm1, sys1, sols1, dm2, sys2, sols2, \
    tasks=0, verbose=True):
    r"""
    Runs the diagonal homotopies in quad double precision
    to intersect two witness sets stored in (*sys1*, *sols1*) and
    (*sys2*, *sols2*), of respective dimensions *dm1* and *dm2*.
    The ambient dimension equals *dim*.
    Multitasking is available, and is activated by the *tasks* parameter.
    Returns the last system in the cascade and its solutions.
    If *verbose*, then the solver runs in interactive mode, printing
    intermediate results to screen and prompting the user to continue.
    """
    from phcpy.phcpy2c2 import py2c_quaddobl_collapse_diagonal
    from phcpy.interface import store_quaddobl_solutions as storesols
    from phcpy.interface import load_quaddobl_solutions as loadsols
    from phcpy.interface import load_quaddobl_system as loadsys
    from phcpy.phcpy2c2 import py2c_extrinsic_top_diagonal_dimension
    from phcpy.solutions import filter_vanishing
    topdim = py2c_extrinsic_top_diagonal_dimension(dim+dm1, dim+dm2, dm1, dm2)
    kdm = len(sys1) - dm1
    topdiagdim = top_diagonal_dimension(kdm, dm1, dm2)
    if verbose:
        print 'the top dimension :', topdim, 'dim :', dim
        print 'number of slack variables at the top :', topdiagdim 
    quaddobl_diagonal_homotopy(dm1, sys1, sols1, dm2, sys2, sols2)
    if verbose:
        print 'defining the start solutions'
    quaddobl_diagonal_cascade_solutions(dm1, dm2)
    if verbose:
        print 'starting the diagonal cascade'
    (topsys, startsols) = quaddobl_start_diagonal_cascade()
    if verbose:
        print 'the system solved in the start of the cascade :'
        for pol in topsys:
            print pol
        print 'the solutions after starting the diagonal cascade :'
        for sol in startsols:
            print sol
        raw_input('hit enter to continue')
    for k in range(topdiagdim, 0, -1):
        endsols = quad_double_cascade_step(topsys, startsols)
        if verbose:
            print 'after running cascade step %d :' % k
            for sol in endsols:
                print sol
        endsolsf1 = filter_vanishing(endsols, 1.0e-8)
        if verbose:
            print 'computed', len(endsolsf1), 'solutions'
            raw_input('hit enter to continue')
        slack = 'zz' + str(k)
        nbvar = len(topsys)
        endsolsf2 = drop_coordinate_from_solutions(endsolsf1, nbvar, slack)
        if verbose:
            print 'after dropping the slack coordinate from the solutions :'
            for sol in endsolsf2:
                print sol
            raw_input('hit enter to continue')
        nextsys = drop_variable_from_polynomials(topsys, slack)
        if verbose:
            print 'after dropping the variable', slack, 'from the system :'
            for pol in nextsys:
                print pol
        (topsys, startsols) = (nextsys[:-1], endsolsf2)
    storesols(len(topsys), startsols)
    # py2c_quaddobl_collapse_diagonal(topdim - 2*dim, 0)
    py2c_quaddobl_collapse_diagonal(0, 0)
    result = (loadsys(), loadsols())
    return result

def diagonal_solver(dim, dm1, sys1, sols1, dm2, sys2, sols2, tasks=0, \
    prc='d', verbose=True):
    r"""
    Runs the diagonal homotopies to intersect two witness sets stored in
    (*sys1*, *sols1*) and (*sys2*, *sols2*),
    of respective dimensions *dim1* and *dim2*.
    The ambient dimension equals *dim*.
    Multitasking is available, and is activated by the *tasks* parameter.
    The precision is set by the parameter *prc*, which takes the default
    value 'd' for standard double, 'dd' for double double, or 'qd' for
    quad double precision.
    Returns the last system in the cascade and its solutions.
    """
    if(prc == 'd'):
        return standard_diagonal_solver\
                   (dim, dm1, sys1, sols1, dm2, sys2, sols2, tasks, verbose)
    elif(prc == 'dd'):
        return dobldobl_diagonal_solver\
                   (dim, dm1, sys1, sols1, dm2, sys2, sols2, tasks, verbose)
    elif(prc == 'qd'):
        return quaddobl_diagonal_solver\
                   (dim, dm1, sys1, sols1, dm2, sys2, sols2, tasks, verbose)
    else:
        print 'wrong argument for precision'
        return None

def test_diaghom(precision='d'):
    """
    Test on the diagonal homotopy.
    """
    hyp1 = 'x1*x2;'
    hyp2 = 'x1 - x2;'
    (w1sys, w1sols) = witness_set_of_hypersurface(2, hyp1, precision)
    print 'the witness sets for', hyp1
    for pol in w1sys:
        print pol
    for sol in w1sols:
        print sol
    (w2sys, w2sols) = witness_set_of_hypersurface(2, hyp2, precision)
    print 'the witness sets for', hyp2
    for pol in w2sys:
        print pol
    for sol in w2sols:
        print sol
    (sys, sols) = diagonal_solver\
        (2, 1, w1sys, w1sols, 1, w2sys, w2sols, 0, precision)
    print 'the end system :'
    for pol in sys:
        print pol
    print 'the solutions of the diagonal solver :'
    for sol in sols:
        print sol

def test():
    """
    Runs a test on algebraic sets.
    """
    from phcpy.phcpy2c2 import py2c_set_seed
    py2c_set_seed(234798272)
    # test_monodromy()
    test_diaghom('d')

if __name__ == "__main__":
    test()
