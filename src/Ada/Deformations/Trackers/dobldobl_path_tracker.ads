with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with DoblDobl_Complex_Numbers;           use DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Poly_Systems;      use DoblDobl_Complex_Poly_Systems;
with DoblDobl_Complex_Solutions;         use DoblDobl_Complex_Solutions;
with DoblDobl_Continuation_Data;         use DoblDobl_Continuation_Data;

package DoblDobl_Path_Tracker is

-- DESCRIPTION :
--   This package implements a path tracker with a next() method.

-- CONSTRUCTORS :

  procedure Init ( s : in Link_to_Solution );

  -- DESRIPTION :
  --   Stores s as the current solution, leaves the homotopy as it is.
  --   This is useful for tracking the next path in the same homotopy.

  procedure Init ( p,q : in Link_to_Poly_sys; fixed_gamma : in boolean );
  procedure Init ( p,q : in Link_to_Poly_sys; fixed_gamma : in boolean;
                   s : in Link_to_Solution );

  -- DESCRIPTION :
  --   Initializes the homotopy with target system p, start system q,
  --   and stores the start solution s (if given).
  --   If fixed_gamma is true, then gamma will be a fixed default value,
  --   otherwise a new random gamma constant will be generated.
  --   The k constant in the homotopy will be set to some good value.
  --   The condition of the continuation parameters is set to zero.

  procedure Init ( p,q : in Link_to_Poly_sys;
                   gamma : in Complex_Number; k : in natural32 );
  procedure Init ( p,q : in Link_to_Poly_sys; s : in Link_to_Solution;
                   gamma : in Complex_Number; k : in natural32 );

  -- DESCRIPTION :
  --   Initializes the homotopy with target system p, start system q,
  --   and stores the start solution s (if given).
  --   The given gamma and k will be used as constants in the homotopy.
  --   The condition of the continuation parameters is set to zero.

  procedure Init ( p,q : in Link_to_Poly_sys;
                   gamma : in Complex_Number; k,cp : in natural32 );
  procedure Init ( p,q : in Link_to_Poly_sys; s : in Link_to_Solution;
                   gamma : in Complex_Number; k,cp : in natural32 );

  -- DESCRIPTION :
  --   Initializes the homotopy with target system p, start system q,
  --   and stores the start solution s (if given).
  --   The given gamma and k will be used as constants in the homotopy.
  --   The condition of the continuation parameters is set to cp.

-- SELECTORS :

  function get_current return Link_to_Solution;
  function get_current return Solu_Info;

  -- DESCRIPTION :
  --   Returns the current solution.

  function get_next return Link_to_Solution;

  -- DESCRIPTION :
  --   Does one step of a predictor-corrector method till success.
  --   The default for the target of the continuation parameter t is one.

  function get_next ( target_t : Complex_Number ) return Link_to_Solution;

  -- DESCRIPTION :
  --   Does one step of a predictor-corrector method till success
  --   for the given target of the continuation parameter.

-- DESCTRUCTOR :

  procedure Clear;

  -- DESCRIPTION :
  --   Clears the homotopy data and resets all data.

end DoblDobl_Path_Tracker;
