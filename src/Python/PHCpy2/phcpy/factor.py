"""
Given a witness set representation of a pure dimensional solution set,
the functions in this module separate the generic points in the witness set
according to the irreducible components of the solution set.
"""

def standard_decomposition(deg):
    """
    Returns the decomposition as a list of labels of witness points
    on the components, computed in standard double precision.
    """
    from phcpy.phcpy2c2 import py2c_factor_number_of_standard_components
    from phcpy.phcpy2c2 import py2c_factor_witness_points_of_standard_component
    from phcpy.phcpy2c2 import py2c_factor_standard_trace_sum_difference as stf
    nbcmp = py2c_factor_number_of_standard_components()
    result = []
    for i in range(1, nbcmp+1):
        compnt = py2c_factor_witness_points_of_standard_component(deg, i)
        tsd = stf(deg, i, len(compnt), compnt)
        result.append((eval(compnt), tsd))
    return result

def dobldobl_decomposition(deg):
    """
    Returns the decomposition as a list of labels of witness points
    on the components, computed in double double precision.
    """
    from phcpy.phcpy2c2 import py2c_factor_number_of_dobldobl_components
    from phcpy.phcpy2c2 import py2c_factor_witness_points_of_dobldobl_component
    from phcpy.phcpy2c2 import py2c_factor_dobldobl_trace_sum_difference as dtf
    nbcmp = py2c_factor_number_of_dobldobl_components()
    result = []
    for i in range(1, nbcmp+1):
        compnt = py2c_factor_witness_points_of_dobldobl_component(deg, i)
        tsd = dtf(deg, i, len(compnt), compnt)
        result.append((eval(compnt), tsd))
    return result

def quaddobl_decomposition(deg):
    """
    Returns the decomposition as a list of labels of witness points
    on the components, computed in quad double precision.
    """
    from phcpy.phcpy2c2 import py2c_factor_number_of_quaddobl_components
    from phcpy.phcpy2c2 import py2c_factor_witness_points_of_quaddobl_component
    from phcpy.phcpy2c2 import py2c_factor_quaddobl_trace_sum_difference as qtf
    nbcmp = py2c_factor_number_of_quaddobl_components()
    result = []
    for i in range(1, nbcmp+1):
        compnt = py2c_factor_witness_points_of_quaddobl_component(deg, i)
        tsd = qtf(deg, i, len(compnt), compnt)
        result.append((eval(compnt), tsd))
    return result

def decomposition(deg, precision='d'):
    """
    Returns the decomposition as a list of labels of witness points
    on the components, computed in precision 'd', 'dd', or 'qd',
    respectively for double, double double, or quad double.
    """
    if(precision == 'd'):
        return standard_decomposition(deg)
    elif(precision == 'dd'):
        return dobldobl_decomposition(deg)
    elif(precision == 'qd'):
        return quaddobl_decomposition(deg)
    else:
        print 'wrong level of precision'
        return None

def standard_monodromy_breakup(embsys, esols, dim, \
    islaurent=0, verbose=True, nbloops=0):
    r"""
    Applies the monodromy breakup algorithm in standard double precision
    to factor the d-dimensional algebraic set represented by the
    embedded system *embsys* and its solutions *esols*.
    If the embedded polynomial system is a Laurent system,
    then islaurent must equal one, the default is zero.
    If *verbose* is False, then no output is written.
    If *nbloops* equals zero, then the user is prompted to give
    the maximum number of loops.
    """
    from phcpy.phcpy2c2 import py2c_factor_set_standard_to_mute
    from phcpy.phcpy2c2 import py2c_factor_set_standard_to_verbose
    from phcpy.phcpy2c2 import py2c_factor_standard_assign_labels
    from phcpy.phcpy2c2 import py2c_factor_initialize_standard_monodromy
    from phcpy.phcpy2c2 import py2c_factor_initialize_standard_sampler
    from phcpy.phcpy2c2 import py2c_factor_initialize_standard_Laurent_sampler
    from phcpy.phcpy2c2 import py2c_factor_standard_trace_grid_diagnostics
    from phcpy.phcpy2c2 import py2c_factor_set_standard_trace_slice
    from phcpy.phcpy2c2 import py2c_factor_store_standard_gammas
    from phcpy.phcpy2c2 import py2c_factor_standard_track_paths
    from phcpy.phcpy2c2 import py2c_factor_store_standard_solutions
    from phcpy.phcpy2c2 import py2c_factor_restore_standard_solutions
    from phcpy.phcpy2c2 import py2c_factor_new_standard_slices
    from phcpy.phcpy2c2 import py2c_factor_swap_standard_slices
    from phcpy.phcpy2c2 import py2c_factor_permutation_after_standard_loop
    from phcpy.phcpy2c2 import py2c_factor_number_of_standard_components
    from phcpy.phcpy2c2 import py2c_factor_update_standard_decomposition
    from phcpy.phcpy2c2 import py2c_solcon_write_standard_solutions
    from phcpy.phcpy2c2 import py2c_solcon_clear_standard_solutions
    from phcpy.interface import store_standard_witness_set
    from phcpy.interface import store_standard_laurent_witness_set
    if(verbose):
        print '... applying monodromy factorization with standard doubles ...'
        py2c_factor_set_standard_to_verbose()
    else:
        py2c_factor_set_standard_to_mute()
    deg = len(esols)
    nvar = len(embsys)
    if(verbose):
        print 'dim =', dim
    if(islaurent == 1):
        store_standard_laurent_witness_set(nvar, dim, embsys, esols)
        py2c_factor_standard_assign_labels(nvar, deg)
        py2c_factor_initialize_standard_Laurent_sampler(dim)
    else:
        store_standard_witness_set(nvar, dim, embsys, esols)
        py2c_factor_standard_assign_labels(nvar, deg)
        py2c_factor_initialize_standard_sampler(dim)
    if(verbose):
        py2c_solcon_write_standard_solutions()
    if(nbloops == 0):
        strnbloops = raw_input('give the maximum number of loops : ')
        nbloops = int(strnbloops)
    py2c_factor_initialize_standard_monodromy(nbloops, deg, dim)
    py2c_factor_store_standard_solutions()
    if(verbose):
        print '... initializing the grid in standard double precision ...'
    for i in range(1, 3):
        py2c_factor_set_standard_trace_slice(i)
        py2c_factor_store_standard_gammas(nvar)
        py2c_factor_standard_track_paths(islaurent)
        py2c_factor_store_standard_solutions()
        py2c_factor_restore_standard_solutions()
        py2c_factor_swap_standard_slices()
    (err, dis) = py2c_factor_standard_trace_grid_diagnostics()
    print 'The diagnostics of the trace grid :'
    print '  largest error on the samples :', err
    print '  smallest distance between the samples :', dis
    for i in range(1, nbloops+1):
        if(verbose):
            print '... starting loop %d ...' % i
        py2c_factor_new_standard_slices(dim, nvar)
        py2c_factor_store_standard_gammas(nvar)
        py2c_factor_standard_track_paths(islaurent)
        py2c_solcon_clear_standard_solutions()
        py2c_factor_store_standard_gammas(nvar)
        py2c_factor_standard_track_paths(islaurent)
        py2c_factor_store_standard_solutions()
        sprm = py2c_factor_permutation_after_standard_loop(deg)
        if(verbose):
            perm = eval(sprm)
            print 'the permutation :', perm
        nb0 = py2c_factor_number_of_standard_components()
        done = py2c_factor_update_standard_decomposition(deg, len(sprm), sprm)
        nb1 = py2c_factor_number_of_standard_components()
        if(verbose):
            print 'number of factors : %d -> %d' % (nb0, nb1)
            deco = decomposition(deg)
            print 'decomposition :', deco
        if(done == 1):
            break
        py2c_factor_restore_standard_solutions()

def dobldobl_monodromy_breakup(embsys, esols, dim, \
    islaurent=0, verbose=True, nbloops=0):
    r"""
    Applies the monodromy breakup algorithm in double double precision
    to factor the d-dimensional algebraic set represented by the embedded
    system *embsys* and its solutions *esols*.
    If the embedded polynomial system is a Laurent system,
    then islaurent must equal one, the default is zero.
    If *verbose* is False, then no output is written.
    If *nbloops* equals zero, then the user is prompted to give
    the maximum number of loops.
    """
    from phcpy.phcpy2c2 import py2c_factor_set_dobldobl_to_mute
    from phcpy.phcpy2c2 import py2c_factor_set_dobldobl_to_verbose
    from phcpy.phcpy2c2 import py2c_factor_dobldobl_assign_labels
    from phcpy.phcpy2c2 import py2c_factor_initialize_dobldobl_monodromy
    from phcpy.phcpy2c2 import py2c_factor_initialize_dobldobl_sampler
    from phcpy.phcpy2c2 import py2c_factor_initialize_dobldobl_Laurent_sampler
    from phcpy.phcpy2c2 import py2c_factor_dobldobl_trace_grid_diagnostics
    from phcpy.phcpy2c2 import py2c_factor_set_dobldobl_trace_slice
    from phcpy.phcpy2c2 import py2c_factor_store_dobldobl_gammas
    from phcpy.phcpy2c2 import py2c_factor_dobldobl_track_paths
    from phcpy.phcpy2c2 import py2c_factor_store_dobldobl_solutions
    from phcpy.phcpy2c2 import py2c_factor_restore_dobldobl_solutions
    from phcpy.phcpy2c2 import py2c_factor_new_dobldobl_slices
    from phcpy.phcpy2c2 import py2c_factor_swap_dobldobl_slices
    from phcpy.phcpy2c2 import py2c_factor_permutation_after_dobldobl_loop
    from phcpy.phcpy2c2 import py2c_factor_number_of_dobldobl_components
    from phcpy.phcpy2c2 import py2c_factor_update_dobldobl_decomposition
    from phcpy.phcpy2c2 import py2c_solcon_write_dobldobl_solutions
    from phcpy.phcpy2c2 import py2c_solcon_clear_dobldobl_solutions
    from phcpy.interface import store_dobldobl_witness_set
    from phcpy.interface import store_dobldobl_laurent_witness_set
    if(verbose):
        print '... applying monodromy factorization with double doubles ...'
        py2c_factor_set_dobldobl_to_verbose()
    else:
        py2c_factor_set_dobldobl_to_mute()
    deg = len(esols)
    nvar = len(embsys)
    if(verbose):
        print 'nvar =', nvar, 'dim =', dim, 'deg =', deg
    if(islaurent == 1):
        store_dobldobl_laurent_witness_set(nvar, dim, embsys, esols)
        py2c_factor_dobldobl_assign_labels(nvar, deg)
        py2c_factor_initialize_dobldobl_Laurent_sampler(dim)
    else:
        store_dobldobl_witness_set(nvar, dim, embsys, esols)
        py2c_factor_dobldobl_assign_labels(nvar, deg)
        py2c_factor_initialize_dobldobl_sampler(dim)
    if(verbose):
        py2c_solcon_write_dobldobl_solutions()
    if(nbloops == 0):
        strnbloops = raw_input('give the maximum number of loops : ')
        nbloops = int(strnbloops)
    py2c_factor_initialize_dobldobl_monodromy(nbloops, deg, dim)
    py2c_factor_store_dobldobl_solutions()
    if(verbose):
        print '... initializing the grid ...'
    for i in range(1, 3):
        py2c_factor_set_dobldobl_trace_slice(i)
        py2c_factor_store_dobldobl_gammas(nvar)
        py2c_factor_dobldobl_track_paths(islaurent)
        py2c_factor_store_dobldobl_solutions()
        py2c_factor_restore_dobldobl_solutions()
        py2c_factor_swap_dobldobl_slices()
    (err, dis) = py2c_factor_dobldobl_trace_grid_diagnostics()
    print 'The diagnostics of the trace grid :'
    print '  largest error on the samples :', err
    print '  smallest distance between the samples :', dis
    for i in range(1, nbloops+1):
        if(verbose):
            print '... starting loop %d ...' % i
        py2c_factor_new_dobldobl_slices(dim, nvar)
        py2c_factor_store_dobldobl_gammas(nvar)
        py2c_factor_dobldobl_track_paths(islaurent)
        py2c_solcon_clear_dobldobl_solutions()
        py2c_factor_store_dobldobl_gammas(nvar)
        py2c_factor_dobldobl_track_paths(islaurent)
        py2c_factor_store_dobldobl_solutions()
        sprm = py2c_factor_permutation_after_dobldobl_loop(deg)
        if(verbose):
            perm = eval(sprm)
            print 'the permutation :', perm
        nb0 = py2c_factor_number_of_dobldobl_components()
        done = py2c_factor_update_dobldobl_decomposition(deg, len(sprm), sprm)
        nb1 = py2c_factor_number_of_dobldobl_components()
        if(verbose):
            print 'number of factors : %d -> %d' % (nb0, nb1)
            deco = decomposition(deg, 'dd')
            print 'decomposition :', deco
        if(done == 1):
            break
        py2c_factor_restore_dobldobl_solutions()

def quaddobl_monodromy_breakup(embsys, esols, dim, \
    islaurent=0, verbose=True, nbloops=0):
    r"""
    Applies the monodromy breakup algorithm in quad double precision
    to factor the d-dimensional algebraic set represented by the embedded
    system *embsys* and its solutions *esols*.
    If the embedded polynomial system is a Laurent system,
    then islaurent must equal one, the default is zero.
    If *verbose* is False, then no output is written.
    If *nbloops* equals zero, then the user is prompted to give
    the maximum number of loops.
    """
    from phcpy.phcpy2c2 import py2c_factor_set_quaddobl_to_mute
    from phcpy.phcpy2c2 import py2c_factor_set_quaddobl_to_verbose
    from phcpy.phcpy2c2 import py2c_factor_quaddobl_assign_labels
    from phcpy.phcpy2c2 import py2c_factor_initialize_quaddobl_monodromy
    from phcpy.phcpy2c2 import py2c_factor_initialize_quaddobl_sampler
    from phcpy.phcpy2c2 import py2c_factor_initialize_quaddobl_Laurent_sampler
    from phcpy.phcpy2c2 import py2c_factor_quaddobl_trace_grid_diagnostics
    from phcpy.phcpy2c2 import py2c_factor_set_quaddobl_trace_slice
    from phcpy.phcpy2c2 import py2c_factor_store_quaddobl_gammas
    from phcpy.phcpy2c2 import py2c_factor_quaddobl_track_paths
    from phcpy.phcpy2c2 import py2c_factor_store_quaddobl_solutions
    from phcpy.phcpy2c2 import py2c_factor_restore_quaddobl_solutions
    from phcpy.phcpy2c2 import py2c_factor_new_quaddobl_slices
    from phcpy.phcpy2c2 import py2c_factor_swap_quaddobl_slices
    from phcpy.phcpy2c2 import py2c_factor_permutation_after_quaddobl_loop
    from phcpy.phcpy2c2 import py2c_factor_number_of_quaddobl_components
    from phcpy.phcpy2c2 import py2c_factor_update_quaddobl_decomposition
    from phcpy.phcpy2c2 import py2c_solcon_write_quaddobl_solutions
    from phcpy.phcpy2c2 import py2c_solcon_clear_quaddobl_solutions
    from phcpy.interface import store_quaddobl_witness_set
    from phcpy.interface import store_quaddobl_laurent_witness_set
    if(verbose):
        print '... applying monodromy factorization with quad doubles ...'
        py2c_factor_set_quaddobl_to_verbose()
    else:
        py2c_factor_set_quaddobl_to_mute()
    deg = len(esols)
    nvar = len(embsys)
    if(verbose):
        print 'dim =', dim
    if(islaurent == 1):
        store_quaddobl_laurent_witness_set(nvar, dim, embsys, esols)
        py2c_factor_quaddobl_assign_labels(nvar, deg)
        py2c_factor_initialize_quaddobl_Laurent_sampler(dim)
    else:
        store_quaddobl_witness_set(nvar, dim, embsys, esols)
        py2c_factor_quaddobl_assign_labels(nvar, deg)
        py2c_factor_initialize_quaddobl_sampler(dim)
    if(verbose):
        py2c_solcon_write_quaddobl_solutions()
    if(nbloops == 0):
        strnbloops = raw_input('give the maximum number of loops : ')
        nbloops = int(strnbloops)
    py2c_factor_initialize_quaddobl_monodromy(nbloops, deg, dim)
    py2c_factor_store_quaddobl_solutions()
    if(verbose):
        print '... initializing the grid ...'
    for i in range(1, 3):
        py2c_factor_set_quaddobl_trace_slice(i)
        py2c_factor_store_quaddobl_gammas(nvar)
        py2c_factor_quaddobl_track_paths(islarent)
        py2c_factor_store_quaddobl_solutions()
        py2c_factor_restore_quaddobl_solutions()
        py2c_factor_swap_quaddobl_slices()
    (err, dis) = py2c_factor_quaddobl_trace_grid_diagnostics()
    print 'The diagnostics of the trace grid :'
    print '  largest error on the samples :', err
    print '  smallest distance between the samples :', dis
    for i in range(1, nbloops+1):
        if(verbose):
            print '... starting loop %d ...' % i
        py2c_factor_new_quaddobl_slices(dim, nvar)
        py2c_factor_store_quaddobl_gammas(nvar)
        py2c_factor_quaddobl_track_paths(islaurent)
        py2c_solcon_clear_quaddobl_solutions()
        py2c_factor_store_quaddobl_gammas(nvar)
        py2c_factor_quaddobl_track_paths(islaurent)
        py2c_factor_store_quaddobl_solutions()
        sprm = py2c_factor_permutation_after_quaddobl_loop(deg)
        if(verbose):
            perm = eval(sprm)
            print 'the permutation :', perm
        nb0 = py2c_factor_number_of_quaddobl_components()
        done = py2c_factor_update_quaddobl_decomposition(deg, len(sprm), sprm)
        nb1 = py2c_factor_number_of_quaddobl_components()
        if(verbose):
            print 'number of factors : %d -> %d' % (nb0, nb1)
            deco = decomposition(deg, 'qd')
            print 'decomposition :', deco
        if(done == 1):
            break
        py2c_factor_restore_quaddobl_solutions()

def monodromy_breakup(embsys, esols, dim, \
    islaurent=0, verbose=True, nbloops=0, prec='d'):
    r"""
    Applies the monodromy breakup algorithm to factor the d-dimensional
    set represented by the embedded system *embsys* and its solutions *esols*.
    If the embedded polynomial system is a Laurent system,
    then islaurent must equal one, the default is zero.
    If *verbose* is False, then no output is written.
    If *nbloops* equals zero, then the user is prompted to give
    the maximum number of loops.
    Three different levels of precision are supported: double precision 'd'
    (for the value for prec) is the default, the two other precisions are
    double double precision 'dd' and quad double precision 'qd'.
    """
    if(prec == 'd'):
        standard_monodromy_breakup\
            (embsys, esols, dim, islaurent, verbose, nbloops)
    elif(prec == 'dd'):
        dobldobl_monodromy_breakup\
            (embsys, esols, dim, islaurent, verbose, nbloops)
    elif(prec == 'qd'):
        quaddobl_monodromy_breakup\
            (embsys, esols, dim, islaurent, verbose, nbloops)
    else:
        print 'wrong argument for precision'

def factor(dim, witsys, witsols, \
    islaurent=0, verbose=True, nbloops=20, precision='d'):
    r"""
    Applies monodromy to factor an equidimensional algebraic set,
    given as a witness sets, with the embedded polynomials in *witsys*,
    and corresponding generic points in *witsols*.
    If the embedded polynomial system is a Laurent system,
    then islaurent must equal one, the default is zero.
    The dimension of the algebraic set is given in *dim*.
    The default precision is double 'd'.  Other valid values for precision
    are 'dd' for double double, or 'qd' for quad double.
    """
    if(precision == 'd'):
        standard_monodromy_breakup\
            (witsys, witsols, dim, islaurent, verbose, nbloops)
        return decomposition(len(witsols))
    elif(precision == 'dd'):
        dobldobl_monodromy_breakup\
            (witsys, witsols, dim, islaurent, verbose, nbloops)
        return decomposition(len(witsols), 'dd')
    elif(precision == 'dd'):
        quaddobl_monodromy_breakup\
            (witsys, witsols, dim, islaurent, verbose, nbloops)
        return decomposition(len(witsols), 'qd')
    else:
        print 'wrong level of precision'
        return None

def test_monodromy(prc='d'):
    """
    Runs a test on applying monodromy loops
    to factor a curve into irreducible components.
    """
    from phcpy.solver import solve
    from phcpy.sets import embed
    pols = ['(x^2 - y)*(x-y);', 'x^3 - z;']
    embsys = embed(3, 1, pols, prc)
    # patch : make sure zz1 is last symbol!
    embsys[0] = 'x - x + y - y + z - z + ' + embsys[0]
    print embsys
    sols = solve(embsys, silent=True, precision=prc)
    # for sol in sols: print sol
    print 'the degree is', len(sols)
    monodromy_breakup(embsys, sols, 1, \
        islaurent=0, verbose=True, nbloops=0, prec=prc)

def test_factor():
    """
    Simple test on the factor method.
    """
    hyp = '(x+1)*(x^2 + y^2 + 1);'
    (wsys, wsols) = witness_set_of_hypersurface(2, hyp)
    fac = factor(1, wsys, wsols)
    print fac

def test():
    """
    Sets the seed for the random number generators
    to a fixed number and then runs a test.
    """
    from phcpy.phcpy2c2 import py2c_set_seed
    py2c_set_seed(234798272)
    test_monodromy()

if __name__ == "__main__":
    test()
