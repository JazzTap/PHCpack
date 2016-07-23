with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Double_Double_Numbers;             use Double_Double_Numbers;
with DoblDobl_Complex_Numbers;          use DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Vectors;
with DoblDobl_Complex_VecVecs;
with DoblDobl_Dense_Series;
with DoblDobl_Dense_Series_Vectors;

package DoblDobl_Dense_Vector_Series is

-- DESCRIPTION :
--   A series vector is a vector of truncated power series, with complex
--   numbers as coefficients.  A vector series is a truncated power series,
--   where the coefficients are vectors.  As a data type, a vector series
--   is represented as a vector of vectors, of maximum degree.

  type Vector is record
    deg : integer32; -- the last power in the series
                     -- the eror is of order deg+1
    cff : DoblDobl_Complex_VecVecs.VecVec(0..DoblDobl_Dense_Series.max_deg);
     -- only coefficients in the range 0..deg are defined
     -- all vectors in cff have the same range
  end record;

-- CONSTRUCTORS :

  function Create ( v : DoblDobl_Dense_Series_Vectors.Vector )
                  return DoblDobl_Dense_Vector_Series.Vector;

  -- DESCRIPTION :
  --   A vector which has as entries truncated power series
  --   is converted into a series with vectors as coefficients.
  --   The range of the vector on entry is 1..n, where n is the
  --   number of series in as entries in v.
  --   The range of the vector on return is 1..d, where d is the
  --   degree of each series in v.

  -- REQUIRED :
  --   The assumption is that every series in v has the same degree d.

  function Create ( v : DoblDobl_Dense_Vector_Series.Vector )
                  return DoblDobl_Dense_Series_Vectors.Vector;

  -- DESCRIPTION :
  --   A truncated power series with vectors as coefficients
  --   is converted into a vector of truncated power series.
  --   The vector on entry has range 1..d, where d is v.deg.
  --   The vector on return has range 1..n, where n = v(i)'last.

  -- REQUIRED :
  --   The degree of v must be at least zero, at least one of
  --   the coefficients in v must be defined.

-- EVALUATORS :

  function Eval ( v : DoblDobl_Dense_Vector_Series.Vector;
                  t : double_double )
                return DoblDobl_Complex_Vectors.Vector;
  function Eval ( v : DoblDobl_Dense_Vector_Series.Vector;
                  t : Complex_Number )
                return DoblDobl_Complex_Vectors.Vector;

  -- DESCRIPTION :
  --   Returns the values of all series in v at t.

  -- REQUIRED : v.deg >= 0 and v.cff(0) is defined.

-- DESTRUCTOR :

  procedure Clear ( v : in out DoblDobl_Dense_Vector_Series.Vector );

  -- DESCRIPTION :
  --   Deallocates all coefficients in the series.
  --   On return, the degree of v equals -1, because all coefficients
  --   of v, all v(i), have been deallocated.

end DoblDobl_Dense_Vector_Series;
