with Standard_Natural_Numbers;          use Standard_Natural_Numbers;
with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Floating_Numbers;         use Standard_Floating_Numbers;
with Double_Double_Numbers;             use Double_Double_Numbers;
with DoblDobl_Complex_Numbers;          use DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Vectors;

package DoblDobl_Dense_Series is

-- DESCRIPTION :
--   A double double dense series is defined by a coefficient vector x,
--   which stores the coefficients of a truncated power series,
--   such as x(0) + x(1)*t + x(2)*t^2 + .. + x(x'last)*t^x'last,
--   in double double precision.
--   Because the series is dense, the powers of the parameter t
--   are stored implicitly as the indices in the coefficient vector.
--   With the definitions and operations in this package,
--   the DoblDobl_Dense_Series_Ring is defined.

  max_order : constant integer32 := 16;

-- Because the type of the number in a ring must be a definite type,
-- we cannot allow truncated series of arbitrary length, but must fix
-- the order of the series at compile time to some number.

  type Series is record
    order : integer32; 
    -- the last exponent in the series, the error is O(t^(order+1))
    cff : DoblDobl_Complex_Vectors.Vector(0..max_order);
    -- only the coefficients in the range 0..order are used
  end record;

-- CONSTRUCTORS :

  function Create ( i : integer ) return Series;
  function Create ( f : double_float ) return Series;
  function Create ( f : double_double ) return Series;
  function Create ( c : Complex_Number ) return Series;

  -- DESCRIPTION :
  --   Returns a series with one element, the value of i, f, or c.

  function Create ( i : integer; order : integer32 ) return Series;
  function Create ( f : double_float; order : integer32 ) return Series;
  function Create ( f : double_double; order : integer32 ) return Series;
  function Create ( c : Complex_Number; order : integer32 ) return Series;

  -- DESCRIPTION :
  --   Returns a series of the given order where the leading element
  --   at position 0 has the value of i, f, or c.

  -- REQUIRED : order <= max_order.

  function Create ( c : DoblDobl_Complex_Vectors.Vector ) return Series;

  -- DESCRIPTION :
  --   Returns a series with coefficients in c, with order equal
  --   to c'last if c'last <= max_order.  If c'last > max_order,
  --   then the coefficients in c with index > max_order are ignored.

  -- REQUIRED : c'first = 0.

  function Create ( s : Series; order : integer32 ) return Series;

  -- DESCRIPTION :
  --   Returns a series of the given order with coefficients in s.
  --   If order > s'last, then the series on return has all
  --   coefficients of s, padded with zeros.
  --   If order < s'last, then the series on return is a truncation
  --   of the series in s, with only the coefficients in s(0..order).

  -- REQUIRED : order <= max_order.

-- EQUALITY AND COPY :

  function Equal ( s,t : Series ) return boolean;

  -- DESCRIPTION :
  --   Returns true if all coefficients are the same.
  --   If the orders of s and t are different,
  --   then the extra coefficients must be zero for equality to hold.

  procedure Copy ( s : in Series; t : in out Series );

  -- DESCRIPTION :
  --   Copies the coefficients of s to t
  --   and sets the order of t to the order of s.

-- COMPLEX CONJUGATE :

  function Conjugate ( s : Series ) return Series;

  -- DESCRIPTION :
  --   The complex conjugate of a series s has as coefficients
  --   the complex conjugates of the coefficients of s.

-- ARITHMETICAL OPERATORS :

  function "+" ( s : Series; c : Complex_Number ) return Series;

  -- DESCRIPTION :
  --   Returns a series which is a copy of s,
  --   but with c added to the constant term of s.

  function "+" ( c : Complex_Number; s : Series ) return Series;

  -- DESCRIPTION :
  --   Returns a series which is a copy of s,
  --   but with c added to the constant term of s.

  procedure Add ( s : in out Series; c : in Complex_Number );

  -- DESCRIPTION :
  --   This is equivalent to s := s + c.

  function "+" ( s : Series ) return Series;

  -- DESCRIPTION :
  --   Returns a copy of s.

  function "+" ( s,t : Series ) return Series;

  -- DESCRIPTION :
  --   Adds the series s to t.  The order of the series
  --   on return is the maximum of s.order and t.order.
 
  procedure Add ( s : in out Series; t : in Series );

  -- DESCRIPTION :
  --   Adds the series t to s.  If t.order > s.order,
  --   then the order of s will be upgraded to t.order.

  function "-" ( s : Series; c : Complex_Number ) return Series;

  -- DESCRIPTION :
  --   Returns the series s - c, subtracting c from the constant
  --   coefficient of s.

  function "-" ( c : Complex_Number; s : Series ) return Series;

  -- DESCRIPTION :
  --   Returns the series c - s.

  procedure Sub ( s : in out Series; c : in Complex_Number );

  -- DESCRIPTION :
  --   This is equivalent to s := s - c.

  function "-" ( s : Series ) return Series;

  -- DESCRIPTION :
  --   The coefficients of series on return has all signs flipped.

  procedure Min ( s : in out Series );

  -- DESCRIPTION :
  --   This is equivalent to s := -s.

  function "-" ( s,t : Series ) return Series;

  -- DESCRIPTION :
  --   Subtracts the series t from s.  The order of the series
  --   on return is the maximum of s.order and t.order.

  procedure Sub ( s : in out Series; t : in Series );

  -- DESCRIPTION :
  --   Subtracts the series t from s.  If t.order > s.order,
  --   then the order of s will be upgraded to t.order.

  function "*" ( s : Series; c : Complex_Number ) return Series;

  -- DESCRIPTION :
  --   Returns s*c.

  function "*" ( c : Complex_Number; s : Series ) return Series;

  -- DESCRIPTION :
  --   Returns c*s.

  procedure Mul ( s : in out Series; c : in Complex_Number );

  -- DESCRIPTION :
  --   Is equivalent to s := s*c.

  function "*" ( s,t : Series ) return Series;

  -- DESCRIPTION :
  --   Returns the multiplication of the series s with t.
  --   The order of the series on return is the maximum
  --   of s.order and t.order.
 
  procedure Mul ( s : in out Series; t : in Series );

  -- DESCRIPTION :
  --   Multiplies the series s with t.  If t.order > s.order,
  --   then the order of s will be upgrade to t.order.

  function Inverse ( s : Series ) return Series;

  -- DESCRIPTION :
  --   Returns the inverse of the series with coefficients in s.

  -- REQUIRED : s(0) /= 0.

  function "/" ( s : Series; c : Complex_Number ) return Series;

  -- DESCRIPTION :
  --   Returns the series s/c, where every coefficient of s
  --   is divided by c.

  -- REQUIRED : c /= 0.

  procedure Div ( s : in out Series; c : in Complex_Number );

  -- DESCRIPTION :
  --   This is equivalent to s := s/c.

  -- REQUIRED : c /= 0.

  function "/" ( c : Complex_Number; s : Series ) return Series;

  -- DESCRIPTION :
  --   Returns c/s, obtained by multiplying all coefficient of
  --   the inverse of s with c.

  -- REQUIRED : s.cff(0) /= 0.

  function "/" ( s,t : Series ) return Series;

  -- DESCRIPTION :
  --   Returns the series c = s/t.  The order of the series
  --   on return is the maximum of s.order and t.order.

  -- REQUIRED : t.cff(0) /= 0.

  procedure Div ( s : in out Series; t : in Series );

  -- DESCRIPTION :
  --   Divides the series s by t.  If t.order > s.order,
  --   then the order of the series of s will be upgraded to t.order.

  -- REQUIRED : t.cff(0) /= 0.

  function "**" ( s : Series; p : integer ) return Series;
  function "**" ( s : Series; p : natural32 ) return Series;

  -- DESCRIPTION :
  --   Returns s**p, s to the power p.

  -- REQUIRED : if p < 0, then s.cff(0) /= 0.

-- EVALUATORS :

  function Eval ( s : Series; t : double_double ) return Complex_Number;
  function Eval ( s : Series; t : Complex_Number ) return Complex_Number;

  -- DESCRIPTION :
  --   Returns the value c(0) + c(1)*t + .. + c(s.order)*t**s.order,
  --   where c abbreviates the coefficient vector s.cff.

  procedure Filter ( s : in out Series; tol : in double_float );

  -- DESCRIPTION :
  --   All coefficients of s that are less than tol in magnitude 
  --   are set to zero.

-- SHIFT OPERATORS :

  function Shift ( s : Series; c : double_double ) return Series;
  function Shift ( s : Series; c : Complex_Number ) return Series;

  -- DESCRIPTION :
  --   The series on return has the coefficients of the series s,
  --   where the series parameter is replaced by t-c.

  procedure Shift ( s : in out Series; c : in double_double );
  procedure Shift ( s : in out Series; c : in Complex_Number );

  -- DESCRIPTION :
  --   On return, s = Shift(s,c).

-- DESTRUCTOR :

  procedure Clear ( s : in out Series );

  -- DESCRIPTION :
  --   All coefficients of s are set to zero.
  --   Also the order of s is set to zero.

end DoblDobl_Dense_Series;
