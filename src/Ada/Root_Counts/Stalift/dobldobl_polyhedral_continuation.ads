with text_io;                            use text_io;
with Standard_Integer_Vectors;
with Standard_Floating_Vectors;
with DoblDobl_Complex_VecVecs;
with DoblDobl_Complex_Laur_Systems;      use DoblDobl_Complex_Laur_Systems;
with DoblDobl_Complex_Laur_SysFun;       use DoblDobl_Complex_Laur_SysFun;
with DoblDobl_Complex_Laur_Jacomats;     use DoblDobl_Complex_Laur_Jacomats;
with Exponent_Vectors;                   use Exponent_Vectors;
with Arrays_of_Floating_Vector_Lists;    use Arrays_of_Floating_Vector_Lists;
with DoblDobl_Complex_Solutions;         use DoblDobl_Complex_Solutions;
with Floating_Mixed_Subdivisions;        use Floating_Mixed_Subdivisions;

package DoblDobl_Polyhedral_Continuation is

-- DESCRIPTION :
--   This package implements polyhedral homotopy continuation methods,
--   based on mixed subdivision induced by floating-point lifting.
--   The continuation is organized in three layers:
--     1. inner normal, tracking of paths for one poly
--     2. mixed cell, recursion is needed when the cell is not fine;
--     3. mixed subdivision, for all cells in the subdivision.
--   Each layer has two versions: a silent and a reporting version.
--   The coefficients of the homotopies are complex double doubles.

-- FIRST LAYER : polyhedral continuation for one transformation.

  procedure Mixed_Continuation
                ( mix : in Standard_Integer_Vectors.Vector;
                  lifted : in Array_of_Lists; h : in Eval_Coeff_Laur_Sys;
                  c : in DoblDobl_Complex_VecVecs.VecVec;
                  e : in Exponent_Vectors_Array;
                  j : in Eval_Coeff_Jaco_Mat; m : in Mult_Factors;
                  normal : in Standard_Floating_Vectors.Vector;
                  sols : in out Solution_List );

  procedure Mixed_Continuation
                ( file : in file_type;
                  mix : in Standard_Integer_Vectors.Vector;
                  lifted : in Array_of_Lists; h : in Eval_Coeff_Laur_Sys;
                  c : in DoblDobl_Complex_VecVecs.VecVec;
                  e : in Exponent_Vectors_Array;
                  j : in Eval_Coeff_Jaco_Mat; m : in Mult_Factors;
                  normal : in Standard_Floating_Vectors.Vector;
                  sols : in out Solution_List );

  -- DESCRIPTION : polyhedral continuation with coefficient homotopy.

  -- ON ENTRY :
  --   file       file to write intermediate results on;
  --   mix        type of mixture;
  --   lifted     lifted supports of polynomial system, in original order;
  --   h          coefficient homotopy;
  --   c          coefficients of homotopy;
  --   e          the exponent vectors of the unlifted system;
  --   j          coefficient Jacobian matrix;
  --   m          multiplication factors in coefficient Jacobian matrix;
  --   normal     normal to a mixed cell;
  --   sols       start solutions of the subsystem which corresponds
  --              with the mixed cell with given inner normal.

  -- ON RETURN :
  --   sols       the solutions of p, which correspond to one mixed cell.

-- SECOND LAYER : polyhedral continuaton for one mixed cell.

  procedure Mixed_Solve
                ( p : in Laur_Sys; lifted : in Array_of_Lists;
                  h : in Eval_Coeff_Laur_Sys;
                  c : in DoblDobl_Complex_VecVecs.VecVec;
                  e : in Exponent_Vectors_Array;
                  j : in Eval_Coeff_Jaco_Mat; m : in Mult_Factors;
                  mix : in Standard_Integer_Vectors.Vector;
                  mic : in Mixed_Cell;
                  sols,sols_last : in out Solution_List;
                  multprec_hermite : in boolean := false );

  procedure Mixed_Solve
                ( file : in file_type;
                  p : in Laur_Sys; lifted : in Array_of_Lists;
                  h : in Eval_Coeff_Laur_Sys;
                  c : in DoblDobl_Complex_VecVecs.VecVec;
                  e : in Exponent_Vectors_Array;
                  j : in Eval_Coeff_Jaco_Mat; m : in Mult_Factors;
                  mix : in Standard_Integer_Vectors.Vector;
                  mic : in Mixed_Cell;
                  sols,sols_last : in out Solution_List;
                  multprec_hermite : in boolean := false );

  -- DESCRIPTION :
  --   Polyhedral coefficient-homotopy continuation for one mixed cell.

  -- REQUIRED : polynomials in p must be ordered according to mix.

  -- ON ENTRY :
  --   file       a file to write intermediate results on;
  --   p          non-lifted Laurent polynomial system;
  --   lifted     lifted supports, with original order of points;
  --   h          coefficient homotopy;
  --   c          coefficients of homotopy;
  --   e          the exponent vectors of the unlifted system;
  --   j          coefficient Jacobian matrix;
  --   m          multiplication factors in coefficient Jacobian matrix;
  --   mix        type of mixture;
  --   mic        a mixed cell;
  --   multprec_hermite indicates whether multiprecision arithmetic
  --              will be used for the Hermite normal form in the
  --              solution of the binomial initial form systems.

  -- ON RETURN :
  --   sols       the solution list of p;
  --   sols_last  pointer to last element of the list sols.

-- THIRD LAYER : polyhedral continuation for a mixed subdivision.

  procedure Mixed_Solve
                ( p : in Laur_Sys; lifted : in Array_of_Lists;
                  h : in Eval_Coeff_Laur_Sys;
                  c : in DoblDobl_Complex_VecVecs.VecVec;
                  e : in Exponent_Vectors_Array;
                  j : in Eval_Coeff_Jaco_Mat; m : in Mult_Factors;
                  mix : in Standard_Integer_Vectors.Vector;
                  mixsub : in Mixed_Subdivision;
                  sols : in out Solution_List;
                  multprec_hermite : in boolean := false );

  procedure Mixed_Solve
                ( file : in file_type;
                  p : in Laur_Sys; lifted : in Array_of_Lists;
                  h : in Eval_Coeff_Laur_Sys;
                  c : in DoblDobl_Complex_VecVecs.VecVec;
                  e : in Exponent_Vectors_Array;
                  j : in Eval_Coeff_Jaco_Mat; m : in Mult_Factors;
                  mix : in Standard_Integer_Vectors.Vector;
                  mixsub : in Mixed_Subdivision;
                  sols : in out Solution_List;
                  multprec_hermite : in boolean := false );

  -- DESCRIPTION :
  --   Polyhedral coefficient-homotopy continuation for a mixed subdivision.

  -- REQUIRED : polynomials in p must be ordered according to mix.

  -- ON ENTRY :
  --   file       a file to write intermediate results on;
  --   p          non-lifted Laurent polynomial system;
  --   lifted     lifted supports, in original order;
  --   h          coefficient homotopy;
  --   c          coefficients of homotopy;
  --   e          the exponent vectors of the unlifted system;
  --   j          coefficient Jacobian matrix;
  --   m          multiplication factors in coefficient Jacobian matrix;
  --   mix        type of mixture;
  --   mixsub     a collection of mixed cells;
  --   multprec_hermite indicates whether multiprecision arithmetic
  --              will be used for the Hermite normal form in the
  --              solution of the binomial initial form systems.

  -- ON RETURN :
  --   sols       the solution list of p.

end DoblDobl_Polyhedral_Continuation;
