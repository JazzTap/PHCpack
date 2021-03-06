with text_io;                            use text_io;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Quad_Double_Numbers;                use Quad_Double_Numbers;
with QuadDobl_Complex_Numbers;           use QuadDobl_Complex_Numbers;
with Quad_Double_Vectors;
with QuadDobl_Complex_Vectors;
with Quad_Double_VecVecs;

package Directions_of_QuadDobl_Paths is

-- DESCRIPTION :
--   This package provides some routines to estimate numerically the direction
--   of a solution path diverging to a solution of a face system,
--   using quad double complex arithmetic.

-- APPLICATION OF EXTRAPOLATION :

  procedure Shift_Up ( v : in out Quad_Double_Vectors.Vector;
                       x : in quad_double );

  -- DESCRIPTION :
  --   Puts x at v(v'first) after a shift-up: v(i+1) := v(i).

  procedure Extrapolation_Window
                ( r,m : in integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out Quad_DOuble_VecVecs.VecVec );

  -- DESCRIPTION :
  --   The data (dt,s,logs and logx) are stored as in a window: when
  --   full at the incoming of a new element, all elements are shifted 
  --   and the oldest element drops off.

  procedure Refresh_Window
                ( r,m : in integer32;
                  dt : in Quad_Double_Vectors.Vector;
                  s,logs : in out Quad_Double_Vectors.Vector );

  -- DESCRIPTION :
  --   Recomputes s and logs, after m has been changed.

  procedure Write_Update_Information
                ( file : in file_type;
                  r,m : in integer32; s,logs : in quad_double;
                  logx : in Quad_Double_Vectors.Vector );

  -- DESCRIPTION :
  --   Writes r, s, log(s) and log|x(s)| on file.
  --   The current version only writes a banner with r and m.

  procedure Affine_Update_Extrapolation_Data
                ( r,m : in integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx,wvl0,wvl1,wvltmp : in out Quad_Double_VecVecs.VecVec );

  -- DESCRIPTION :
  --   Updates the data needed to extrapolate in the affine case.

  procedure Projective_Update_Extrapolation_Data
                ( r,m : in integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out Quad_Double_VecVecs.VecVec );

  -- DESCRIPTION :
  --   Updates the data needed to extrapolate in the projective case,
  --   under the assumption that the homogenization variable appears lastly.

  procedure Update_Errors
                ( r : in integer32;
                  errorv : in out Quad_Double_Vectors.Vector;
                  error : out quad_double;
                  wvl0,wvl1,wvltmp : in out Quad_Double_VecVecs.VecVec );

  -- DESCRIPTION :
  --   Updates the error computation after the extrapolation.

  -- REQUIRED : r >= 1.

-- ESTIMATING THE WINDING NUMBER :

  procedure Frequency_of_Estimate
               ( newest : in integer32; max : in natural32;
                 m,estm : in out integer32; cnt : in out natural32;
                 newm : out boolean );

  -- DESCRIPTION :
  --   Given a new estimate for the winding number, the procedure updates
  --   the count of the number of times newest equals estm.
  --   This procedure delays the assignment of the estimate estm to m,
  --   until the counter cnt reaches the threshold max.

  -- ON ENTRY :
  --   newest    newly computed estimate for m;
  --   max       threshold on cnt before estm is returned;
  --   m         current value of the winding number;
  --   estm      previous estimate of the winding number,
  --             for use of comparing against newest;
  --   cnt       number of consecutive guesses that yielded estm.

  -- ON RETURN :
  --   m         updated current value for the winding number;
  --   estm      updated estimate for the winding number;
  --   cnt       updated number of consecutive estimates that yielded estm;
  --   newm      true if m has changed, false otherwise.

  procedure Extrapolate_on_Errors
               ( r : in integer32; h : in quad_double;
                 err : in Quad_Double_Vectors.Vector;
                 estm : out Quad_Double_Vectors.Vector );

  -- DESCRIPTION :
  --   Performs an rth-order extrapolation on the errors.

  -- ON ENTRY :
  --   r         order of the extrapolation method;
  --   h         ratio in geometric sequence;
  --   err       vector of range 0..r+1 with differences of estimates for
  --             the outer normal, the most recent error is err(0).

  -- ON RETURN :
  --   estm      estimated values for m, consecutively obtained by
  --             application of higher orders of extrapolation.

  procedure Accuracy_of_Estimates
               ( estm : in Quad_Double_Vectors.Vector;
                 success : out boolean; k : out integer32;
                 estwin : out integer32; eps : out quad_double );

  -- DESCRIPTION :
  --   Determines the estimate for the winding number based on the
  --   approximations obtained by consecutive higher order of extrapolation.

  -- ON ENTRY :
  --   estm      approximations obtained by consecutive extrapolations,
  --             which has range 1..r+1, where r is the order.

  -- ON RETURN :
  --   success   true if the sequence of approximations improved in
  --             accuracy, i.e.: the extrapolation worked, false otherwise;
  --   k         the order of best value: integer32(estm(k-1)) = estwin;
  --   estwin    the estimated value for the winding number;
  --   eps       the accuracy of the winding number.

  procedure Estimate0
               ( r : in integer32; max : in natural32;
                 m,estm : in out integer32; cnt : in out natural32;
                 dt : in Quad_Double_Vectors.Vector;
                 err,newerr : in quad_double; rat,eps : out quad_double;
                 newm : out boolean );

  -- DESCRIPTION :
  --   Returns an 0th-order estimate of the cycle number m.
  
  -- ON ENTRY :
  --   r         extrapolation order;
  --   max       threshold on cnt before estm is returned;
  --   m         current value of m;
  --   estm      previous estimate;
  --   cnt       number of consecutive guesses that yielded estm;
  --   dt        consecutive distances to the target;
  --   err       previous error;
  --   newerr    current error.

  -- ON RETURN :
  --   m         new value of m;
  --   estm      new estimate;
  --   cnt       updated number of consecutive guesses that yielded estm;
  --   rat       ratio used to estimate m;
  --   eps       accuracy of the rounding value for m;
  --   newm      true if m has changed.

  procedure Estimate_Winding_Number
               ( file : in file_type; r : in integer32;
                 max : in natural32; m,estm : in out integer32;
                 cnt : in out natural32; h : in quad_double;
                 diferr : in Quad_Double_Vectors.Vector;
                 rat,eps : out quad_double; newm : out boolean );

  -- DESCRIPTION :
  --   Estimates m by extrapolation on consecutvie differences of errors,
  --   stored in the parameter diferr.  For the specfication of the other
  --   parameters, see the procedure Estimate0.

-- APPLYING THE vLpRs-Algorithm :

  function vLpRs_Extrapolate
                ( r : integer32;
                  s,logs : Quad_Double_Vectors.Vector;
                  logx : Quad_Double_VecVecs.VecVec )
                return Quad_Double_Vectors.Vector;

  -- DESCRIPTION :
  --   Higher-order extrapolation is based on vLpRs-Algorithm.

  -- REQUIRED : r >= 1.

  function vLpRs_Extrapolate
                ( file : file_type; r : integer32;
                  s,logs : Quad_Double_Vectors.Vector;
                  logx : Quad_Double_VecVecs.VecVec )
                return Quad_Double_Vectors.Vector;

  -- DESCRIPTION :
  --   Higher-order extrapolation based on vLpRs-Algorithm.

  -- REQUIRED : r >= 1.

  procedure vLpRs_Extrapolate
                ( file : in file_type; r : in integer32;
                  s,logs : in Quad_Double_Vectors.Vector;
                  logx,wvl0 : in Quad_Double_VecVecs.VecVec;
                  wvl1 : in out Quad_Double_VecVecs.VecVec;
                  w,wv,wl : out Quad_Double_Vectors.Vector );

  -- DESCRIPTION :
  --   Higher-order extrapolation based on vLpRs-Algorithm,
  --   writes an error table on file.

  -- REQUIRED : r >= 1.

-- FIRST ORDER APPROXIMATION (no extrapolation) :

  procedure Affine_Update_Direction
                ( t,prev_t,target : in Complex_Number;
                  x,prevx : in QuadDobl_Complex_Vectors.Vector;
                  prevdls,prevstep : in out quad_double;
                  prevdiff,v : in out Quad_Double_Vectors.Vector );

  -- DESCRIPTION :
  --   Computes an approximation of the direction of the path.
  --   When prevdls /= 0.0, a second-order extrapolation will be applied.

  -- ON ENTRY :
  --   t          current value of continuation parameter;
  --   prev_t     previous value of continuation parameter;
  --   target     target value of continuation parameter;
  --   x          current solution vector;
  --   prevx      solution vector for previous value of continuation parameter;
  --   prevdls    previous difference of the logs of distances to target;
  --   prevstep   previous step size;
  --   prevdiff   previous difference of the logs of the solution vectors;
  --   v          current approximate direction of the path.

  procedure Projective_Update_Direction
                ( t,prev_t,target : in Complex_Number;
                  x,prevx : in QuadDobl_Complex_Vectors.Vector;
                  prevdls,prevstep : in out quad_double;
                  prevdiff,v : in out Quad_Double_Vectors.Vector );

  -- DESCRIPTION :
  --   Does the same as the other procedure, under the assumption that the
  --   solution vector lies in projective space.

  -- REQUIRED : 
  --   The homogenization variable is the last element of the solution vector.

  procedure Affine_Update_Direction
                ( r,m,estm : in out integer32;
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx,wvl0,wvl1,wvltmp : in out Quad_Double_VecVecs.VecVec;
                  v,diferr : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double );

  procedure Affine_Update_Direction
                ( file : in file_type;
                  r,m,estm : in out integer32;
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx,wvl0,wvl1,wvltmp : in out Quad_Double_VecVecs.VecVec;
                  v,diferr : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double );

  -- DESCRIPTION :
  --   Higher-order extrapolation method that produces direction with error of
  --   order (t-target)^r, when the solution path converges to regular solution
  --   in affine space.

  -- REQUIRED : s'range = logs'range = logx'range = 0..max,
  --   wvl'range = 1..max, logx(i)'range = wvl'range(i) = 1..n,
  --   diferr'range = 0..max, max >= 1, equals maximal order of extrapolator.

  -- ON ENTRY :
  --   file       to write intermediate data, if not submitted, no output;
  --   r          last meaningful entry in logx and logs;
  --   m          current value for multiplicity;
  --   estm       current estimate for multiplicity;
  --   cntm       number of consecutive times estm has been guessed;
  --   thresm     threshold for changing the m to estm;
  --   er         order of extrapolator on the errors;
  --   t          current value of continuation parameter;
  --   target     target value of continuation parameter;
  --   x          current solution for t;
  --   dt         consecutive distances of t-values to target value;
  --   s          consecutive s-values, with proper value for m;
  --   logs       logarithms of previous values (target - t);
  --   logx       logarithms of previous solution vectors;
  --   wvl0       previous consecutive estimates for direction;
  --   wvl1       current consecutive estimates for direction;
  --   wvltmp     work space for updating wvl0 and wvl1.

  -- ON RETURN :
  --   r          if r < logs'last, then r will be raised by one,
  --              otherwise r remains unchanged;
  --   s          updated distance vector;
  --   logs       updated vector of logarithms of distances to target;
  --   logx       updated vector of solution vectors;
  --   wvl0       updated previous consecutive estimates, equals wvl1;
  --   wvl1       updated current consecutive estimates for direction;
  --   v          estimated direction of path;
  --   diferr     norms of consecutive differences of estimates for v;
  --   error      norm of errorv;

  procedure Projective_Update_Direction
                ( r,m,estm : in out integer32;
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out Quad_Double_VecVecs.VecVec;
                  prevv,v : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double );

  procedure Projective_Update_Direction
                ( file : in file_type;
                  r,m,estm : in out integer32;
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out Quad_Double_VecVecs.VecVec;
                  prevv,v : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double );

  -- DESCRIPTION :
  --   Higher-order extrapolation method that produces direction with error of
  --   order (t-target)^r, when the solution path converges to regular solution
  --   in affine space.

  -- REQUIRED :
  --   x(x'last) contains value of variable introduced to homogenize the system.

end Directions_of_QuadDobl_Paths;
