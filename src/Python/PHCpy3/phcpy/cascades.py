"""
A cascade homotopy removes one hyperplane from an embedded system,
taking the solutions with nonzero slack variables to solutions on
lower dimensional components of the solution set of the original system.
"""

def standard_double_cascade_step(dim, embsys, esols, tasks=0):
    r"""
    Given in *embsys* an embedded polynomial system and
    solutions with nonzero slack variables in *esols*, does one step 
    in the homotopy cascade, with standard double precision arithmetic.
    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    from phcpy.phcpy2c3 import py2c_copy_standard_container_to_start_system
    from phcpy.phcpy2c3 import py2c_copy_standard_container_to_start_solutions
    from phcpy.phcpy2c3 import py2c_standard_cascade_homotopy
    from phcpy.phcpy2c3 import py2c_solve_by_standard_homotopy_continuation
    from phcpy.phcpy2c3 import py2c_solcon_clear_standard_solutions
    from phcpy.phcpy2c3 import py2c_copy_standard_target_solutions_to_container
    from phcpy.interface import store_standard_witness_set
    from phcpy.interface import load_standard_solutions
    store_standard_witness_set(len(embsys), dim, embsys, esols)
    py2c_copy_standard_container_to_start_system()
    py2c_copy_standard_container_to_start_solutions()
    py2c_standard_cascade_homotopy()
    py2c_solve_by_standard_homotopy_continuation(tasks)
    py2c_solcon_clear_standard_solutions()
    py2c_copy_standard_target_solutions_to_container()
    return load_standard_solutions()

def double_double_cascade_step(dim, embsys, esols, tasks=0):
    r"""
    Given in *embsys* an embedded polynomial system and
    solutions with nonzero slack variables in *esols*, does one step 
    in the homotopy cascade, with double double precision arithmetic.
    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    from phcpy.phcpy2c3 import py2c_copy_dobldobl_container_to_start_system
    from phcpy.phcpy2c3 import py2c_copy_dobldobl_container_to_start_solutions
    from phcpy.phcpy2c3 import py2c_dobldobl_cascade_homotopy
    from phcpy.phcpy2c3 import py2c_solve_by_dobldobl_homotopy_continuation
    from phcpy.phcpy2c3 import py2c_solcon_clear_dobldobl_solutions
    from phcpy.phcpy2c3 import py2c_copy_dobldobl_target_solutions_to_container
    from phcpy.interface import store_dobldobl_witness_set
    from phcpy.interface import load_dobldobl_solutions
    store_dobldobl_witness_set(len(embsys), dim, embsys, esols)
    py2c_copy_dobldobl_container_to_start_system()
    py2c_copy_dobldobl_container_to_start_solutions()
    py2c_dobldobl_cascade_homotopy()
    py2c_solve_by_dobldobl_homotopy_continuation(tasks)
    py2c_solcon_clear_dobldobl_solutions()
    py2c_copy_dobldobl_target_solutions_to_container()
    return load_dobldobl_solutions()

def quad_double_cascade_step(dim, embsys, esols, tasks=0):
    r"""
    Given in *embsys* an embedded polynomial system and
    solutions with nonzero slack variables in *esols*, does one step 
    in the homotopy cascade, with quad double precision arithmetic.
    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    from phcpy.phcpy2c3 import py2c_copy_quaddobl_container_to_start_system
    from phcpy.phcpy2c3 import py2c_copy_quaddobl_container_to_start_solutions
    from phcpy.phcpy2c3 import py2c_quaddobl_cascade_homotopy
    from phcpy.phcpy2c3 import py2c_solve_by_quaddobl_homotopy_continuation
    from phcpy.phcpy2c3 import py2c_solcon_clear_quaddobl_solutions
    from phcpy.phcpy2c3 import py2c_copy_quaddobl_target_solutions_to_container
    from phcpy.interface import store_quaddobl_witness_set
    from phcpy.interface import load_quaddobl_solutions
    store_quaddobl_witness_set(len(embsys), dim, embsys, esols)
    py2c_copy_quaddobl_container_to_start_system()
    py2c_copy_quaddobl_container_to_start_solutions()
    py2c_quaddobl_cascade_homotopy()
    py2c_solve_by_quaddobl_homotopy_continuation(tasks)
    py2c_solcon_clear_quaddobl_solutions()
    py2c_copy_quaddobl_target_solutions_to_container()
    return load_quaddobl_solutions()

def cascade_step(dim, embsys, esols, precision='d', tasks=0):
    r"""
    Given in *embsys* an embedded polynomial system and
    solutions with nonzero slack variables in *esols*,
    does one step in the homotopy cascade, with *precision*

    *d*: standard double precision (1.1e-15 or 2^(-53)),

    *dd*: double double precision (4.9e-32 or 2^(-104)),

    *qd*: quad double precision (1.2e-63 or 2^(-209)).

    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    if(precision == 'd'):
        return standard_double_cascade_step(dim, embsys, esols, tasks)
    elif(precision == 'dd'):
        return double_double_cascade_step(dim, embsys, esols, tasks)
    elif(precision == 'qd'):
        return quad_double_cascade_step(dim, embsys, esols, tasks)
    else:
        print('wrong argument for precision')
        return None

def standard_double_laurent_cascade_step(dim, embsys, esols, tasks=0):
    r"""
    Given in *embsys* an embedded Laurent polynomial system and
    solutions with nonzero slack variables in *esols*, does one step
    in the homotopy cascade, with standard double precision arithmetic.
    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    from phcpy.phcpy2c3 \
    import py2c_copy_standard_Laurent_container_to_start_system
    from phcpy.phcpy2c3 import py2c_copy_standard_container_to_start_solutions
    from phcpy.phcpy2c3 import py2c_standard_Laurent_cascade_homotopy
    from phcpy.phcpy2c3 \
    import py2c_solve_by_standard_Laurent_homotopy_continuation
    from phcpy.phcpy2c3 import py2c_solcon_clear_standard_solutions
    from phcpy.phcpy2c3 import py2c_copy_standard_target_solutions_to_container
    from phcpy.interface import store_standard_laurent_witness_set
    from phcpy.interface import load_standard_solutions
    store_standard_laurent_witness_set(len(embsys), dim, embsys, esols)
    py2c_copy_standard_Laurent_container_to_start_system()
    py2c_copy_standard_container_to_start_solutions()
    py2c_standard_Laurent_cascade_homotopy()
    py2c_solve_by_standard_Laurent_homotopy_continuation(tasks)
    py2c_solcon_clear_standard_solutions()
    py2c_copy_standard_target_solutions_to_container()
    return load_standard_solutions()

def double_double_laurent_cascade_step(dim, embsys, esols, tasks=0):
    r"""
    Given in *embsys* an embedded Laurent polynomial system and
    solutions with nonzero slack variables in *esols*, does one step
    in the homotopy cascade, with double double precision arithmetic.
    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    from phcpy.phcpy2c3 \
    import py2c_copy_dobldobl_Laurent_container_to_start_system
    from phcpy.phcpy2c3 import py2c_copy_dobldobl_container_to_start_solutions
    from phcpy.phcpy2c3 import py2c_dobldobl_Laurent_cascade_homotopy
    from phcpy.phcpy2c3 \
    import py2c_solve_by_dobldobl_Laurent_homotopy_continuation
    from phcpy.phcpy2c3 import py2c_solcon_clear_dobldobl_solutions
    from phcpy.phcpy2c3 import py2c_copy_dobldobl_target_solutions_to_container
    from phcpy.interface import store_dobldobl_laurent_witness_set
    from phcpy.interface import load_dobldobl_solutions
    store_dobldobl_laurent_witness_set(len(embsys), dim, embsys, esols)
    py2c_copy_dobldobl_Laurent_container_to_start_system()
    py2c_copy_dobldobl_container_to_start_solutions()
    py2c_dobldobl_Laurent_cascade_homotopy()
    py2c_solve_by_dobldobl_Laurent_homotopy_continuation(tasks)
    py2c_solcon_clear_dobldobl_solutions()
    py2c_copy_dobldobl_target_solutions_to_container()
    return load_dobldobl_solutions()

def quad_double_laurent_cascade_step(dim, embsys, esols, tasks=0):
    r"""
    Given in *embsys* an embedded Laurent polynomial system and
    solutions with nonzero slack variables in *esols*, does one step
    in the homotopy cascade, with quad double precision arithmetic.
    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    from phcpy.phcpy2c3 \
    import py2c_copy_quaddobl_Laurent_container_to_start_system
    from phcpy.phcpy2c3 import py2c_copy_quaddobl_container_to_start_solutions
    from phcpy.phcpy2c3 import py2c_quaddobl_Laurent_cascade_homotopy
    from phcpy.phcpy2c3 \
    import py2c_solve_by_quaddobl_Laurent_homotopy_continuation
    from phcpy.phcpy2c3 import py2c_solcon_clear_quaddobl_solutions
    from phcpy.phcpy2c3 import py2c_copy_quaddobl_target_solutions_to_container
    from phcpy.interface import store_quaddobl_laurent_system
    from phcpy.interface import store_quaddobl_solutions
    from phcpy.interface import load_quaddobl_solutions
    store_quaddobl_laurent_witness_set(len(embsys), dim, embsys, esols)
    py2c_copy_quaddobl_Laurent_container_to_start_system()
    py2c_copy_quaddobl_container_to_start_solutions()
    py2c_quaddobl_Laurent_cascade_homotopy()
    py2c_solve_by_quaddobl_Laurent_homotopy_continuation(tasks)
    py2c_solcon_clear_quaddobl_solutions()
    py2c_copy_quaddobl_target_solutions_to_container()
    return load_quaddobl_solutions()

def laurent_cascade_step(dim, embsys, esols, precision='d', tasks=0):
    r"""
    Given in *embsys* an embedded Laurent polynomial system and
    solutions with nonzero slack variables in *esols*,
    does one step in the homotopy cascade, with precision

    *d*: standard double precision (1.1e-15 or 2^(-53)),

    *dd*: double double precision (4.9e-32 or 2^(-104)),

    *qd*: quad double precision (1.2e-63 or 2^(-209)).

    The dimension of the solution set represented by *embsys*
    and *esols* is the value of *dim*.
    The number of tasks in multithreaded path tracking is given by *tasks*.
    The default zero value of *tasks* indicates no multithreading.
    The list on return contains witness points on
    lower dimensional solution components.
    """
    if(precision == 'd'):
        return standard_double_laurent_cascade_step(dim, embsys, esols, tasks)
    elif(precision == 'dd'):
        return double_double_laurent_cascade_step(dim, embsys, esols, tasks)
    elif(precision == 'qd'):
        return quad_double_laurent_cascade_step(dim, embsys, esols, tasks)
    else:
        print('wrong argument for precision')
        return None

def split_filter(sols, dim, tol, verbose=True):
    r"""
    Given in *sols* is a list of solutions of dimension *dim*,
    which contain a variable with name 'zz' + str(*dim*),
    which is the name of the last slack variable.
    The tolerance *tol* is used to split the list of solution in two.
    On return is a tuple of two lists of solutions (possibly empty).
    The first list of solutions has the last slack variable equal
    to zero (with respect to the tolerance *tol) and the last slack
    variable of each solution in the second list has a magnitude
    larger than *tol*.
    If *verbose*, then the length of each solution list is printed.
    """
    from phcpy.solutions import filter_zero_coordinates as filter
    lastslack = 'zz' + str(dim)
    zerosols = filter(sols, lastslack, tol, 'select')
    nonzsols = filter(sols, lastslack, tol, 'remove')
    if verbose:
        print('number of candidate generic points :', len(zerosols))
        print('number of nonsolutions :', len(nonzsols))
    return (zerosols, nonzsols)

def test_cascade():
    """
    Does one cascade step on simple example.
    In the top embedding we first find the 2-dimensional
    solution set x = 1.  In the cascade step we compute
    the three witness points on the twisted cubic.
    """
    from phcpy.solver import solve
    from phcpy.sets import embed
    from phcpy.sets import drop_variable_from_standard_polynomials
    from phcpy.sets import drop_coordinate_from_standard_solutions
    pols = ['(x - 1)*(y-x^2);', \
            '(x - 1)*(z-x^3);', \
            '(x^2 - 1)*(y-x^2);' ]
    print(pols)
    embpols = embed(3, 2, pols)
    print('the embedded system :')
    print(embpols)
    input('hit enter to continue...')
    sols = solve(embpols, silent=True)
    for sol in sols:
        print(sol)
    print('number of solutions :', len(sols))
    input('hit enter to continue...')
    (sols0, sols1) = split_filter(sols, 1, 1.0e-8)
    input('hit enter to continue...')
    print('solutions with zero slack variables :')
    for sol in sols0:
        print(sol)
    print('solutions with nonzero slack variables :')
    for sol in sols1:
        print(sol)
    print(len(sols), '=' , len(sols0), '+', len(sols1))
    from phcpy.solutions import filter_zero_coordinates, filter_regular
    rs1 = filter_regular(sols1, 1.0e-8, 'select')
    print('number of nonsolutions :', len(rs1))
    input('hit enter to continue...')
    print('... running cascade step ...')
    s2c = cascade_step(2, embpols, rs1, precision='d')
    print('... after running the cascade ...')
    for sol in s2c:
        print(sol)
    wp1 = drop_variable_from_standard_polynomials(embpols, 'zz2')
    print('the 1-dimensional embedding :')
    for pol in wp1:
        print(pol)
    ws1 = drop_coordinate_from_standard_solutions(s2c, len(embpols), 'zz2')
    ws1f1 = filter_zero_coordinates(ws1, 'zz1', 1.0e-8, 'select')
    ws1f2 = filter_regular(ws1f1, 1.0e-8, 'select')
    print('the witness points :')
    for sol in ws1f2:
        print(sol)

def test():
    """
    Fixes a seed for the random number generators
    before running the test on the cascade homotopies.
    """
    from phcpy.phcpy2c3 import py2c_set_seed
    py2c_set_seed(234798272)
    test_cascade()

if __name__ == "__main__":
    test()
