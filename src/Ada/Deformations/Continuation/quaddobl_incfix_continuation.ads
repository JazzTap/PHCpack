with text_io;                            use text_io;
with Quad_Double_Numbers;                use Quad_Double_Numbers;
with QuadDobl_Complex_Numbers;           use QuadDobl_Complex_Numbers;
with QuadDobl_Complex_Vectors;           use QuadDobl_Complex_Vectors;
with QuadDobl_Complex_Matrices;          use QuadDobl_Complex_Matrices;
with QuadDobl_Complex_Solutions;         use QuadDobl_Complex_Solutions;

package QuadDobl_IncFix_Continuation is

-- DESCRIPTION :
--   The procedures below implement an increment-and-fix continuation
--   method with quad double numbers.  The generic parameters are 
--   a norm function, an evaluator and a differentiator of the homotopy.
--   There are two basic versions: a silent and a reporting one.
--   The silent continuation simply performs its calculations without output
--   of intermediate results.  The reporting continuation routine allows to
--   put various kinds of intermediate results on a file.
--   It is assumed that the continuation parameters are already determined
--   before calling these routines (see Continuation_Parameters).

-- THE SILENT VERSIONS :

  generic

    with function Norm ( x : Vector ) return quad_double;
    with function H  ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Matrix;

  procedure Silent_Continue
               ( sols : in out Solution_List;
                 target : in Complex_Number := Create(integer(1)) );

  -- DESCRIPTION :
  --   Basic version of path tracking.

  -- ON ENTRY :
  --   sols      start solutions;
  --   target    value of the continuation parameter at the end.

  -- ON RETURN :
  --   sols      the computed solutions.

  generic

    with function Norm ( x : Vector ) return quad_double;
    with function H  ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Matrix;
    with function Stop_Test ( s : Solution ) return boolean;

  procedure Silent_Continue_with_Stop
               ( sols : in out Solution_List;
                 target : in Complex_Number := Create(integer(1)) );

  -- DESCRIPTION :
  --   Path tracking stops as soon as one of the end solutions
  --   meets the criterion provided by the Stop_Test.

  -- ON ENTRY :
  --   sols      start solutions;
  --   target    value of the continuation parameter at the end.

  -- ON RETURN :
  --   sols      the computed solutions.

-- THE REPORTING VERSIONS :

  generic

    with function Norm ( x : Vector ) return quad_double;
    with function H  ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Matrix;

  procedure Reporting_Continue
               ( file : in file_type; sols : in out Solution_List;
                 target : in Complex_Number := Create(integer(1)) );

  -- DESCRIPTION :
  --   This routine implements the continuation strategy.

  -- ON ENTRY :
  --   file      to write intermediate results on (if Reporting_);
  --   sols      the start solutions;
  --   target    value for the continuation parameter at the end.
 
  -- ON RETURN :
  --   sols      the computed solutions.

  generic

    with function Norm ( x : Vector ) return quad_double;
    with function H  ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Vector;
    with function dH ( x : Vector; t : Complex_Number ) return Matrix;
    with function Stop_Test ( s : Solution ) return boolean;

  procedure Reporting_Continue_with_Stop
               ( file : in file_type; sols : in out Solution_List;
                 target : in Complex_Number := Create(integer(1)) );

  -- DESCRIPTION :
  --   Path tracking stops as soon as one of the end solutions
  --   meets the criterion provided by the Stop_Test.

  -- ON ENTRY :
  --   file      to write intermediate results on (if Reporting_);
  --   sols      the start solutions;
  --   target    value for the continuation parameter at the end.
 
  -- ON RETURN :
  --   sols      the computed solutions.

end QuadDobl_IncFix_Continuation;
