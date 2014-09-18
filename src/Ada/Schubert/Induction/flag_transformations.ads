with Standard_Integer_Numbers;           use Standard_Integer_NUmbers;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Complex_Vectors;
with Standard_Complex_Matrices;

package Flag_Transformations is

-- DESCRIPTION :
--   This package exports linear algebra operations to transform
--   pairs of flags, in standard complex arithmetic.
--   A flag in n-space is represented by an n-by-n matrix:
--   consecutive columns span linear spaces of increasing dimensions.
--   The statement of the general problem goes as follows:
--   Given two pairs of generic flags (F1, F2) and (G1, G2) in n-space,
--   compute the matrix A, upper triangular matrices T1 and T2
--   so that A*F1 = G1*T1 and A*F2 = G2*T2.
--   The specific application has the following problem statement:
--   For two pairs of flags (M, I) and (I, F) in n-space
--   where M is the moved flags, I the identity matrix,
--   and F some random n-dimensional matrix,
--   compute the matrix A, upper triangular matrices T1 and T2
--   so that A*F1 = G1*T1 and A*F2 = G2*T2.

-- DEFINING A LINEAR SYSTEM :

  function Coefficient_Matrix
             ( n : integer32;
               f1,f2,g1,g2 : Standard_Complex_Matrices.Matrix )
             return Standard_Complex_Matrices.Matrix;

  -- DESCRIPTION :
  --   Returns the coefficient matrix to compute the matrix A
  --   and the upper triangular matrices T1 and T2 in the transformation
  --   defined by A*f1 = g1*T1, A*f2 = g2*T2.
  --   The square matrix on return has dimension 2*n^2.

  -- ON ENTRY :
  --   n       ambient dimension;
  --   f1      the first flag of the first pair of flags;
  --   f2      the second flag of the first pair of flags;
  --   g1      the first flag of the second pair of flags;
  --   g2      the second flag of the second pair of flags.

  -- ON RETURN :
  --   The coefficient matrix of the linear system that defines the
  --   matrix A and the transformation matrices T1 and T2.

  function Right_Hand_Side
             ( n : integer32; g : Standard_Complex_Matrices.Matrix )
             return Standard_Complex_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns the right hand side vector in the linear system to
  --   compute a transformation between two flags.

-- PROCESSING THE SOLUTION :

  procedure Extract_Matrices
              ( n : in integer32; sol : in Standard_Complex_Vectors.Vector;
                A,T1,T2 : out Standard_Complex_Matrices.Matrix );

  -- DESCRIPTION :
  --   Given a vector sol of size 2*n*n, extracts three n-dimensional 
  --   matrices: A, T1, and T2, where T1 and T2 are upper triangular
  --   and T1 has ones on its diagonal.

-- THE MAIN TRANSFORMATION :

  procedure Transform
              ( n : in integer32; 
                f1,f2,g1,g2 : in Standard_Complex_Matrices.Matrix;
                A,T1,T2 : out Standard_Complex_Matrices.Matrix );

  -- DECRIPTION :
  --   Transforms two pairs of flags in n-space.

  -- ON ENTRY :
  --   n        ambient dimension;
  --   f1       the first flag of the first pair of flags;
  --   f2       the second flag of the first pair of flags;
  --   g1       the first flag of the second pair of flags;
  --   g2       the second flag of the second pair of flags.

  -- ON RETURN :
  --   A        a regular n-by-n matrix: A*(f1, f2) = (g1*T1, g2*T2);
  --   T1       upper triangular matrix to postmultiply g1 with;
  --   T2       upper triangular matrix to postmultiply g2 with.

  function Residual 
              ( f1,f2,g1,g2,A,T1,T2 : Standard_Complex_Matrices.Matrix ) 
              return double_float;

  -- DESCRIPTION :
  --   Returns the 1-norm of the differences A*f1 - g1*T1 and A*f2 - g2*T2.

end Flag_Transformations;
