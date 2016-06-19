with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Dense_Series;
with Standard_Complex_Polynomials;
with Standard_Complex_Poly_Systems;
with Standard_Series_Polynomials;
with Standard_Series_Poly_Systems;

package Series_and_Polynomials is

-- DESCRIPTION :
--   Exports functions to convert polynomials with complex coefficients
--   into polynomials with series as coefficients, and vice versa.
--   The conversion routines give immediate access to symbolic i/o.

  function Series_to_Polynomial
             ( s : Standard_Dense_Series.Series )
             return Standard_Complex_Polynomials.Poly;

  -- DESCRIPTION :
  --   Returns the representation of the series s as a polynomial
  --   in one variable with complex coefficients.
  --   This conversion is useful for symbolic output of a series.

  function Polynomial_to_Series
             ( p : Standard_Complex_Polynomials.Poly )
             return Standard_Dense_Series.Series;

  -- DESCRIPTION :
  --   Given in p a polynomial in one variable with complex coefficients,
  --   returns the series representation of p.
  --   This conversion is useful for symbolic input of a series.

  -- REQUIRED : degree(p) <= Standard_Dense_Series.max_order.

  function Polynomial_to_Series_Polynomial
             ( p : Standard_Complex_Polynomials.Poly;
               idx : integer32 := 0; verbose : boolean := false )
             return Standard_Series_Polynomials.Poly;

  -- DESCRIPTION :
  --   By default, if idx is zero, then the coefficient of each term in p
  --   is copied into a series of order zero.  Otherwise, if idx > 0,
  --   then the variable with that index in p is the series parameter.
  --   For example, t^3*x + 2*t*x becomes (2*t + t^3)*x, if idx = 1.
  --   If idx > 0, the number of variables in the polynomial on return is 
  --   one less than the number of variables in the input polynomial p.
  --   Extra output is written to screen if verbose is true.

  function Series_Polynomial_to_Polynomial
             ( s : Standard_Series_Polynomials.Poly;
               idx : integer32 := 0; verbose : boolean := false )
             return Standard_Complex_Polynomials.Poly;

  -- DESCRIPTION :
  --   Converts a polynomial s with coefficients as series
  --   into a polynomial with complex coefficients.
  --   The first variable in the polynomial on return is
  --   the parameter in the series coefficient of s.
  --   Extra output is written to screen if verbose is true.

  function System_to_Series_System
             ( p : Standard_Complex_Poly_Systems.Poly_Sys;
               idx : integer32 := 0; verbose : boolean := false )
             return Standard_Series_Poly_Systems.Poly_Sys;

  -- DESCRIPTION :
  --   Calls the Polynomial_to_Series_Polynomial to each p(i)
  --   and returns the corresponding system of polynomials
  --   which have as coefficients series with complex coefficients.

  function Series_System_to_System
             ( s : Standard_Series_Poly_Systems.Poly_Sys;
               idx : integer32 := 0; verbose : boolean := false )
             return Standard_Complex_Poly_Systems.Poly_Sys;

  -- DESCRIPTION :
  --   Calls the Series_Polynomial_to_Polynomial to each p(i)
  --   and returns the corresponding system of series polynomials.

  procedure Set_Order ( p : in out Standard_Series_Polynomials.Poly;
                        order : in integer32 );
  procedure Set_Order ( p : in out Standard_Series_Poly_Systems.Poly_Sys;
                        order : in integer32 );

  -- DESCRIPTION :
  --   Sets the order of every term in p to the given order.
  --   If the given order is larger than the current order,
  --   then the extra coefficients are set to zero.

end Series_and_Polynomials;
