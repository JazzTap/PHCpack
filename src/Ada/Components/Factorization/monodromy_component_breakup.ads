with text_io;                           use text_io;
with Standard_Natural_Numbers;          use Standard_Natural_Numbers;
with Standard_Floating_Numbers;         use Standard_Floating_Numbers;
with Double_Double_Numbers;             use Double_Double_Numbers;
with Quad_Double_Numbers;               use Quad_Double_Numbers;
with Standard_Natural_Vectors;
with Standard_Natural_VecVecs;
with Standard_Complex_Poly_Systems;
with Standard_Complex_Laur_Systems;
with DoblDobl_Complex_Poly_Systems;
with DoblDobl_Complex_Laur_Systems;
with QuadDobl_Complex_Poly_Systems;
with QuadDobl_Complex_Laur_Systems;
with Standard_Complex_Solutions;
with DoblDobl_Complex_Solutions;
with QuadDobl_Complex_Solutions;
with Sample_Point_Lists;                use Sample_Point_Lists;
with DoblDobl_Sample_Lists;             use DoblDobl_Sample_Lists;
with QuadDobl_Sample_Lists;             use QuadDobl_Sample_Lists;

package Monodromy_Component_Breakup is

-- DESCRIPTION :
--   This package uses monodromy and linear traces to factor positive
--   dimensional solution sets into irreducible components.
--   Three different levels of precision are supported:
--   standard double, double double, or quad double precision.

-- AUXILIARIES FOR LINEAR TRACE CERTIFICATES :

  function Create ( p : Standard_Complex_Poly_Systems.Poly_Sys;
                    sols : Standard_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_Standard_Sample_Lists;
  function Create ( file : file_type;
                    p : Standard_Complex_Poly_Systems.Poly_Sys;
                    sols : Standard_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_Standard_Sample_Lists;

  function Create ( p : DoblDobl_Complex_Poly_Systems.Poly_Sys;
                    sols : DoblDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_DoblDobl_Sample_Lists;
  function Create ( file : file_type;
                    p : DoblDobl_Complex_Poly_Systems.Poly_Sys;
                    sols : DoblDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_DoblDobl_Sample_Lists;

  function Create ( p : QuadDobl_Complex_Poly_Systems.Poly_Sys;
                    sols : QuadDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_QuadDobl_Sample_Lists;
  function Create ( file : file_type;
                    p : QuadDobl_Complex_Poly_Systems.Poly_Sys;
                    sols : QuadDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_QuadDobl_Sample_Lists;

  -- DESCRIPTION :
  --   Returns a grid of sample points needed for linear traces
  --   in standard double, double double, or quad double precision,
  --   for witness sets defined by an ordinary polynomial system.

  -- REQUIRED : the sampling machine is initialized and tuned.

  function Create ( p : Standard_Complex_Laur_Systems.Laur_Sys;
                    sols : Standard_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_Standard_Sample_Lists;
  function Create ( file : file_type;
                    p : Standard_Complex_Laur_Systems.Laur_Sys;
                    sols : Standard_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_Standard_Sample_Lists;

  function Create ( p : DoblDobl_Complex_Laur_Systems.Laur_Sys;
                    sols : DoblDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_DoblDobl_Sample_Lists;
  function Create ( file : file_type;
                    p : DoblDobl_Complex_Laur_Systems.Laur_Sys;
                    sols : DoblDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_DoblDobl_Sample_Lists;

  function Create ( p : QuadDobl_Complex_Laur_Systems.Laur_Sys;
                    sols : QuadDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_QuadDobl_Sample_Lists;
  function Create ( file : file_type;
                    p : QuadDobl_Complex_Laur_Systems.Laur_Sys;
                    sols : QuadDobl_Complex_Solutions.Solution_List;
                    dim : natural32 )
                  return Array_of_QuadDobl_Sample_Lists;

  -- DESCRIPTION :
  --   Returns a grid of sample points needed for linear traces
  --   in standard double, double double, or quad double precision,
  --   for witness sets defined by a Laurent polynomial system.

  -- REQUIRED : the sampling machine is initialized and tuned.

-- VALIDATION OF BREAKUP WITH LINEAR TRACES :

  function Trace_Sum_Difference
                ( f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_Standard_Sample_Lists ) return double_float;
  function Trace_Sum_Difference
                ( file : file_type;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_Standard_Sample_Lists ) return double_float;

  function Trace_Sum_Difference
                ( f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_DoblDobl_Sample_Lists ) return double_double;
  function Trace_Sum_Difference
                ( file : file_type;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_DoblDobl_Sample_Lists ) return double_double;

  function Trace_Sum_Difference
                ( f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_QuadDobl_Sample_Lists ) return quad_double;
  function Trace_Sum_Difference
                ( file : file_type;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_QuadDobl_Sample_Lists ) return quad_double;

  -- DESCRIPTION :
  --   Returns the difference between the sum computed at the samples
  --   and the sum evaluated at the linear trace,
  --   in standard double, double double, or quad double precision.

  -- ON ENTRY :
  --   file       for intermediate output and diagnostics;
  --   f          candidate factor collects labels of witness points;
  --   grid       grid with samples on parallel slices.

  -- ON RETURN :
  --   difference (in absolute value) between sum at samples and trace.

  function Certify_Factor
                ( tol : double_float;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_Standard_Sample_Lists ) return boolean;
  function Certify_Factor
                ( file : file_type; tol : double_float;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_Standard_Sample_Lists ) return boolean;

  function Certify_Factor
                ( tol : double_float;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_DoblDobl_Sample_Lists ) return boolean;
  function Certify_Factor
                ( file : file_type; tol : double_float;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_DoblDobl_Sample_Lists ) return boolean;

  function Certify_Factor
                ( tol : double_float;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_QuadDobl_Sample_Lists ) return boolean;
  function Certify_Factor
                ( file : file_type; tol : double_float;
                  f : Standard_Natural_Vectors.Vector;
                  grid : Array_of_QuadDobl_Sample_Lists ) return boolean;

  -- DESCRIPTION :
  --   Computes the linear trace on the grid to see if the witness points
  --   labeled by the entries in f form an irreducible factor.

  -- ON ENTRY :
  --   file       for intermediate output and diagnostics;
  --   tol        tolerance to decide whether two floats are equal;
  --   f          candidate factor collects labels of witness points;
  --   grid       grid with samples on parallel slices.

  -- ON RETURN :
  --   true if f forms a genuine irreducible factor, false otherwise.

  function Is_Factorization
                ( tol : double_float;
                  f : Standard_Natural_VecVecs.VecVec;
                  grid : Array_of_Standard_Sample_Lists ) return boolean;
  function Is_Factorization
                ( file : file_type; tol : double_float;
                  f : Standard_Natural_VecVecs.VecVec;
                  grid : Array_of_Standard_Sample_Lists ) return boolean;

  function Is_Factorization
                ( tol : double_float;
                  f : Standard_Natural_VecVecs.VecVec;
                  grid : Array_of_DoblDobl_Sample_Lists ) return boolean;
  function Is_Factorization
                ( file : file_type; tol : double_float;
                  f : Standard_Natural_VecVecs.VecVec;
                  grid : Array_of_DoblDobl_Sample_Lists ) return boolean;

  function Is_Factorization
                ( tol : double_float;
                  f : Standard_Natural_VecVecs.VecVec;
                  grid : Array_of_QuadDobl_Sample_Lists ) return boolean;
  function Is_Factorization
                ( file : file_type; tol : double_float;
                  f : Standard_Natural_VecVecs.VecVec;
                  grid : Array_of_QuadDobl_Sample_Lists ) return boolean;

  -- DESCRIPTION :
  --   Applies linear traces on the grid to certify whether the partition
  --   of the set of witness points forms an irreducible decomposition,
  --   in standard double, double double, or quad double precision.

  -- ON ENTRY :
  --   file       for intermediate output and diagnostics;
  --   tol        tolerance to decide whether two floats are equal;
  --   f          candidate factorization is partition of witness point set;
  --   grid       grid with samples on parallel slices.

  -- ON RETURN :
  --   true if f forms a genuine irreducible decomposition, false otherwise.

-- APPLICATION OF MONODROMY FOLLOWED BY LINEAR TRACES :

  procedure Monodromy_Breakup
                ( grid : in Array_of_Standard_Sample_Lists;
                  dim,threshold : in natural32; tol : in double_float;
                  f : in Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Monodromy_Breakup
                ( file : in file_type;
                  grid : in Array_of_Standard_Sample_Lists;
                  dim,threshold : in natural32; tol : in double_float;
                  f : in Standard_Natural_VecVecs.Link_to_VecVec );

  procedure Monodromy_Breakup
                ( grid : in Array_of_DoblDobl_Sample_Lists;
                  dim,threshold : in natural32; tol : in double_float;
                  f : in Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Monodromy_Breakup
                ( file : in file_type;
                  grid : in Array_of_DoblDobl_Sample_Lists;
                  dim,threshold : in natural32; tol : in double_float;
                  f : in Standard_Natural_VecVecs.Link_to_VecVec );

  procedure Monodromy_Breakup
                ( grid : in Array_of_QuadDobl_Sample_Lists;
                  dim,threshold : in natural32; tol : in double_float;
                  f : in Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Monodromy_Breakup
                ( file : in file_type;
                  grid : in Array_of_QuadDobl_Sample_Lists;
                  dim,threshold : in natural32; tol : in double_float;
                  f : in Standard_Natural_VecVecs.Link_to_VecVec );

  -- DESCRIPTION :
  --   Applies monodromy loops starting at sps to compute the factorization f,
  --   in standard double, double double, or quad double precision,
  --   for witness sets defined by an ordinary polynomial system.
 
  -- REQUIRED : the sampling machine is initialized and tuned.

  -- ON ENTRY :
  --   file       for intermediate output and diagnostics;
  --   grid       needed for validation with linear traces;
  --   dim        dimension of the solution set;
  --   threshold  limit on the number of iterations which keep the
  --              factorization unchanged;
  --   tol        tolerance to decide whether points are equal;
  --   f          initialization of the factorization.

  -- ON RETURN :
  --   f          groupings of witness points along the irreducible factors.

-- DRIVER ROUTINES :

  procedure Factor ( p : in Standard_Complex_Poly_Systems.Poly_Sys;
                     dim : in natural32;
                     grid : in Array_of_Standard_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Factor ( file : in file_type;
                     p : in Standard_Complex_Poly_Systems.Poly_Sys;
                     dim : in natural32;
                     grid : in Array_of_Standard_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );

  procedure Factor ( p : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                     dim : in natural32;
                     grid : in Array_of_DoblDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Factor ( file : in file_type;
                     p : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                     dim : in natural32;
                     grid : in Array_of_DoblDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );

  procedure Factor ( p : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                     dim : in natural32;
                     grid : in Array_of_QuadDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Factor ( file : in file_type;
                     p : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                     dim : in natural32;
                     grid : in Array_of_QuadDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );

  -- DESCRIPTION :
  --   Applies monodromy loops to factor a pure dimensional solution set
  --   into irreducible components, in standard double, double double,
  --   or quad double precision.

  -- REQUIRED : the sampling machine is initialized and tuned.

  -- ON ENTRY :
  --   file          for intermediate output and diagnostics;
  --   p             embedded polynomial system;
  --   dim           dimension of the solution set;
  --   grid          grid for the linear traces.

  -- ON RETURN :
  --   f             irreducible decomposition of witness point set.

  procedure Factor ( p : in Standard_Complex_Laur_Systems.Laur_Sys;
                     dim : in natural32;
                     grid : in Array_of_Standard_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Factor ( file : in file_type;
                     p : in Standard_Complex_Laur_Systems.Laur_Sys;
                     dim : in natural32;
                     grid : in Array_of_Standard_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );

  procedure Factor ( p : in DoblDobl_Complex_Laur_Systems.Laur_Sys;
                     dim : in natural32;
                     grid : in Array_of_DoblDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Factor ( file : in file_type;
                     p : in DoblDobl_Complex_Laur_Systems.Laur_Sys;
                     dim : in natural32;
                     grid : in Array_of_DoblDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );

  procedure Factor ( p : in QuadDobl_Complex_Laur_Systems.Laur_Sys;
                     dim : in natural32;
                     grid : in Array_of_QuadDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );
  procedure Factor ( file : in file_type;
                     p : in QuadDobl_Complex_Laur_Systems.Laur_Sys;
                     dim : in natural32;
                     grid : in Array_of_QuadDobl_Sample_Lists;
                     f : out Standard_Natural_VecVecs.Link_to_VecVec );

  -- DESCRIPTION :
  --   Applies monodromy loops to factor a pure dimensional solution set
  --   into irreducible components, in standard double, double double,
  --   or quad double precision, for witness sets defined by Laurent
  --   polynomial systems.

  -- REQUIRED : the sampling machine is initialized and tuned.

  -- ON ENTRY :
  --   file          for intermediate output and diagnostics;
  --   p             embedded polynomial system;
  --   dim           dimension of the solution set;
  --   grid          grid for the linear traces.

  -- ON RETURN :
  --   f             irreducible decomposition of witness point set.

end Monodromy_Component_Breakup;
