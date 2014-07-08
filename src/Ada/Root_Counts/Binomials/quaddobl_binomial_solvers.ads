with text_io;                          use text_io;
with Standard_Integer_Numbers;         use Standard_Integer_Numbers;
with Quad_Double_Numbers;              use Quad_Double_Numbers;
with QuadDobl_Complex_Vectors;
with Standard_Integer64_Matrices;
with Multprec_Integer_Matrices;
with QuadDobl_Complex_Solutions;       use QuadDobl_Complex_Solutions;

package QuadDobl_Binomial_Solvers is

-- DESCRIPTION :
--   This package solves binomial systems with standard coefficients.
--   Only solutions with all components different from zero are computed.
--   The Hermite Normal Form turns x^A = c into y^U = c, x = y^M.

-- SOLVERS for UPPER TRIANGULAR systems :

  function Rank ( U : Standard_Integer64_Matrices.Matrix ) return integer32;

  -- DESCRIPTION :
  --   Returns the rank of the upper triangular matrix U.

  function Degree ( U : Standard_Integer64_Matrices.Matrix ) return integer64;

  -- DESCRIPTION :
  --   Returns the product of the diagonal elements on U.

  function Solve_Upper_Square
             ( U : Standard_Integer64_Matrices.Matrix;
               c : QuadDobl_Complex_Vectors.Vector ) return Solution_List;
  function Solve_Upper_Square
             ( U : Multprec_Integer_Matrices.Matrix;
               c : QuadDobl_Complex_Vectors.Vector ) return Solution_List;
  function Solve_Upper_Square
             ( file : file_type;
               U : Standard_Integer64_Matrices.Matrix;
               c : QuadDobl_Complex_Vectors.Vector ) return Solution_List;
  function Solve_Upper_Square
             ( file : file_type;
               U : Multprec_Integer_Matrices.Matrix;
               c : QuadDobl_Complex_Vectors.Vector ) return Solution_List;

  -- DESCRIPTION :
  --   Returns the solutions to x^U = c.

  -- REQUIRED : U is upper triangular and the system is square,
  --            and det(U) /= 0; U'range(2) = c'range.

  -- ON ENTRY :
  --   file    for intermediate output and testing diagnostics;
  --   U       exponent matrix of x^U, columnwise orientation;
  --   c       right-hand side coefficient vector.

  -- ON RETURN :
  --   list of solutions to x^U = c, as many as |det(U)|.

  procedure Solve_Upper_Square
             ( U : in Standard_Integer64_Matrices.Matrix;
               c : in QuadDobl_Complex_Vectors.Vector;
               s : in Solution_List );

  -- DESCRIPTION :
  --   Computes the solutions to x^U = c.

  -- REQUIRED : U is upper triangular and the system is square,
  --            and det(U) /= 0; U'range(2) = c'range,
  --   moreover: Length_Of(s) >= |det(U)|.

  -- ON ENTRY :
  --   U       exponent matrix of x^U, columnwise orientation;
  --   c       right-hand side coefficient vector;
  --   s       list of at least |det(U)| solutions of dimension n,
  --           where n equals c'length.

  -- ON RETURN :
  --   s       list of solutions to x^U = c, as many as |det(U)|.

  function Extend_to_Square
             ( U : Standard_Integer64_Matrices.Matrix )
             return Standard_Integer64_Matrices.Matrix;

  -- DESCRIPTION :
  --   Extends the matrix to a square one, adding the unit vectors.

  function Extend_with_Vector
             ( c,v : QuadDobl_Complex_Vectors.Vector )
             return QuadDobl_Complex_Vectors.Vector;

  -- DESCRIPTION :
  --   Extends the vector c with the values in v.

  procedure Solve_Upper_General
              ( U : in Standard_Integer64_Matrices.Matrix;
                c : in QuadDobl_Complex_Vectors.Vector;
                sols : out Solution_List;
                ext_U : out Standard_Integer64_Matrices.Matrix;
                f,ext_c : out QuadDobl_Complex_Vectors.Vector );
  procedure Solve_Upper_General
              ( file : in file_type;
                U : in Standard_Integer64_Matrices.Matrix;
                c : in QuadDobl_Complex_Vectors.Vector;
                sols : out Solution_List;
                ext_U : out Standard_Integer64_Matrices.Matrix;
                f,ext_c : out QuadDobl_Complex_Vectors.Vector );
  procedure Solve_Upper_General
              ( U : in Standard_Integer64_Matrices.Matrix;
                c,f : in QuadDobl_Complex_Vectors.Vector;
                sols : out Solution_List;
                ext_U : out Standard_Integer64_Matrices.Matrix;
                ext_c : out QuadDobl_Complex_Vectors.Vector );
  procedure Solve_Upper_General
              ( file : in file_type;
                U : in Standard_Integer64_Matrices.Matrix;
                c,f : in QuadDobl_Complex_Vectors.Vector;
                sols : out Solution_List;
                ext_U : out Standard_Integer64_Matrices.Matrix;
                ext_c : out QuadDobl_Complex_Vectors.Vector );

  -- DESCRIPTION :
  --   Returns a witness set for a general upper triangular binomial system.

  -- REQUIRED : U is upper triangular, U'last(1) > U'last(2) = rank(U),
  --   U'range(2) = c'range; and f'length = U'last(1) - U'last(2),
  --   so f'length is the dimension of the solution set.

  -- ON ENTRY :
  --   file     for intermediate output and testing diagnostics;
  --   U        exponent matrix of x^U, columnwise orientation;
  --   c        right-hand side coefficient vector;
  --   f        values for the free variables, if not specified,
  --            then random numbers will be generated and returned in f.

  -- ON RETURN :
  --   sols     solutions to y^U = c, last f'length values of y are f;
  --   ext_U    upper triangular matrix extend with last unit vectors;
  --   f        if f was not specified, then f is a random vector;
  --   ext_c    coefficient vector c extended with the values in f.

-- GENERAL SOLVERS :

  procedure Solve ( A : in Standard_Integer64_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Standard_Integer64_Matrices.Matrix;
                    Asols : out Solution_List );
  procedure Solve ( A : in Multprec_Integer_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Multprec_Integer_Matrices.Matrix;
                    Asols : out Solution_List );
  procedure Solve ( A : in Standard_Integer64_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Standard_Integer64_Matrices.Matrix;
                    Usols,Asols : out Solution_List );
  procedure Solve ( A : in Multprec_Integer_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Multprec_Integer_Matrices.Matrix;
                    Usols,Asols : out Solution_List );
  procedure Solve ( file : in file_type;
                    A : in Standard_Integer64_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Standard_Integer64_Matrices.Matrix;
                    Asols : out Solution_List );
  procedure Solve ( file : in file_type;
                    A : in Multprec_Integer_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Multprec_Integer_Matrices.Matrix;
                    Asols : out Solution_List );
  procedure Solve ( file : in file_type;
                    A : in Standard_Integer64_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Standard_Integer64_Matrices.Matrix;
                    Usols,Asols : out Solution_List );
  procedure Solve ( file : in file_type;
                    A : in Multprec_Integer_Matrices.Matrix;
                    c : in QuadDobl_Complex_Vectors.Vector; r : out integer32;
                    M,U : out Multprec_Integer_Matrices.Matrix;
                    Usols,Asols : out Solution_List );

  -- DESCRIPTION :
  --   Returns the solutions to the system x^A = c.

  -- REQUIRED : A'range(2) = c'range.

  -- ON ENTRY :
  --   file     for intermediate output and diagnostics;
  --   A        exponents of the monomials are in the columns of A;
  --   c        righthand side vector of the system x^A = c.

  -- ON RETURN :
  --   r        the rank of the matrix A,
  --            if r = A'last(2), then we have a complete intersection,
  --            and the solution set has dimension A'last(2) - A'last(1);
  --   M        unimodular transformation to make A upper triangular;
  --   U        upper triangular matrix, obtained as M*A = U;
  --   Usols    solutions to the system y^U = c, x = y^M.
  --   Asols    solutions to the system x^A = c.

-- RESIDUAL CALCULATION :

  function Sum_Residuals
              ( A : Standard_Integer64_Matrices.Matrix;
                c : QuadDobl_Complex_Vectors.Vector; sols : Solution_List )
              return quad_double;

  -- DESCRIPTION :
  --   Returns the sum of all residuals x^A - c, obtained as Max_Norm,
  --   for x running through the whole solution list.

  procedure Write_Residuals
              ( file : in file_type;
                A : in Standard_Integer64_Matrices.Matrix;
                c : in QuadDobl_Complex_Vectors.Vector;
                sols : in Solution_List );

  -- DESCRIPTION :
  --   Writes the residuals, max norm of x^A - c to the file,
  --   for all solutions in sols.

end QuadDobl_Binomial_Solvers;
