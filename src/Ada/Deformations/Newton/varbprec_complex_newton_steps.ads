with String_Splitters;                   use String_Splitters;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Double_Double_Numbers;              use Double_Double_Numbers;
with Quad_Double_Numbers;                use Quad_Double_Numbers;
with Multprec_Floating_Numbers;          use Multprec_Floating_Numbers;
with Standard_Integer_Vectors;
with Standard_Complex_Vectors;
with DoblDobl_Complex_Vectors;
with QuadDobl_Complex_Vectors;
with Multprec_Complex_Vectors;
with DoblDobl_Complex_Matrices;
with Standard_Complex_Matrices;
with QuadDobl_Complex_Matrices;
with Multprec_Complex_Matrices;
with Standard_Complex_Poly_Systems;
with DoblDobl_Complex_Poly_Systems;
with QuadDobl_Complex_Poly_Systems;
with Multprec_Complex_Poly_Systems;
with Standard_Complex_Jaco_Matrices;
with DoblDobl_Complex_Jaco_Matrices;
with QuadDobl_Complex_Jaco_Matrices;
with Multprec_Complex_Jaco_Matrices;

package Varbprec_Complex_Newton_Steps is

-- DESCRIPTION :
--   Applies one step of Newton's method to a polynomial system,
--   with condition number estimation.

-- PART I : estimators and Newton steps at various level of precision

  procedure Estimate_Loss_in_Newton_Step
              ( f : in Standard_Complex_Poly_Systems.Poly_Sys;
                jf : in Standard_Complex_Jaco_Matrices.Jaco_Mat;
                z : in Standard_Complex_Vectors.Vector;
                jfz : out Standard_Complex_Matrices.Matrix;
                piv : out Standard_Integer_Vectors.Vector;
                fz : out Standard_Complex_Vectors.Vector;
                jfzrco,fzrco : out double_float;
                jfzloss,fzloss : out integer32 );
  procedure Estimate_Loss_in_Newton_Step
              ( f : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                jf : in DoblDobl_Complex_Jaco_Matrices.Jaco_Mat;
                z : in DoblDobl_Complex_Vectors.Vector;
                jfz : out DoblDobl_Complex_Matrices.Matrix;
                piv : out Standard_Integer_Vectors.Vector;
                fz : out DoblDobl_Complex_Vectors.Vector;
                jfzrco,fzrco : out double_double;
                jfzloss,fzloss : out integer32 );
  procedure Estimate_Loss_in_Newton_Step
              ( f : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                jf : in QuadDobl_Complex_Jaco_Matrices.Jaco_Mat;
                z : in QuadDobl_Complex_Vectors.Vector;
                jfz : out QuadDobl_Complex_Matrices.Matrix;
                piv : out Standard_Integer_Vectors.Vector;
                fz : out QuadDobl_Complex_Vectors.Vector;
                jfzrco,fzrco : out quad_double;
                jfzloss,fzloss : out integer32 );
  procedure Estimate_Loss_in_Newton_Step
              ( f : in Multprec_Complex_Poly_Systems.Poly_Sys;
                jf : in Multprec_Complex_Jaco_Matrices.Jaco_Mat;
                z : in Multprec_Complex_Vectors.Vector;
                jfz : out Multprec_Complex_Matrices.Matrix;
                piv : out Standard_Integer_Vectors.Vector;
                fz : out Multprec_Complex_Vectors.Vector;
                jfzrco,fzrco : out Floating_Number;
                jfzloss,fzloss : out integer32 );
                
  -- DESCRIPTION :
  --   Estimates the condition numbers and determines the loss of decimal
  --   places when applying one Newton step on a system at some point.

  -- REQUIRED : the system has as many equations as unknowns,
  --   in particular: f'range = z'range = jf'range(1) = jf'range(2).

  -- ON ENTRY :
  --   f        a polynomial system in several variables;
  --   jf       the Jacobian matrix of f;
  --   z        current approximation for a solution of f(x) = 0.

  -- ON RETURN :
  --   jfz      output of lufco on the Jacobian matrix jf,
  --            evaluated at z, suitable for back substitution if nonsingular;
  --   piv      pivoting information computed by lufco;
  --   fz       evaluation of f at z;
  --   jfzrco   estimate for inverse condition number of jfz;
  --   fzrco    inverse condition number of evaluating f at z;
  --   jfzloss  10-logarithm of jfzrco, as indication for the loss of
  --            decimal places when computing the update in a Newton step;
  --   fzloss   10-logarithm of fzrco, as indication for the loss of
  --            decimal places when evaluating f at z.

  procedure do_Newton_Step
              ( z : in out Standard_Complex_Vectors.Vector;
                jfz : in Standard_Complex_Matrices.Matrix;
                piv : in Standard_Integer_Vectors.Vector;
                fz : in Standard_Complex_Vectors.Vector;
                err : out double_float );
  procedure do_Newton_Step
              ( z : in out DoblDobl_Complex_Vectors.Vector;
                jfz : in DoblDobl_Complex_Matrices.Matrix;
                piv : in Standard_Integer_Vectors.Vector;
                fz : in DoblDobl_Complex_Vectors.Vector;
                err : out double_double );
  procedure do_Newton_Step
              ( z : in out QuadDobl_Complex_Vectors.Vector;
                jfz : in QuadDobl_Complex_Matrices.Matrix;
                piv : in Standard_Integer_Vectors.Vector;
                fz : in QuadDobl_Complex_Vectors.Vector;
                err : out quad_double );
  procedure do_Newton_Step
              ( z : in out Multprec_Complex_Vectors.Vector;
                jfz : in Multprec_Complex_Matrices.Matrix;
                piv : in Standard_Integer_Vectors.Vector;
                fz : in Multprec_Complex_Vectors.Vector;
                err : out Floating_Number );

  -- DESCRIPTION :
  --   Updates the point z with one Newton step,
  --   using the output of Estimate_Loss_in_Newton_Step.

  -- ON ENTRY :
  --   z        current approximation for a solution;
  --   jfz      output of lufco, LU factorization of Jacobian matrix;
  --   piv      pivoting information of the LU factorization;
  --   fz       system evaluated at z.

  -- ON RETURN :
  --   z        updated approximation for a solution;
  --   err      magnitude of the correction term added to z.

  function Minimum ( a,b : integer32 ) return integer32;

  -- DESCRIPTION :
  --   Returns the minimum of a and b, used to compute the total loss,
  --   as the minimum of the loss in the accuracy of the linear solving
  --   and the loss in the accuracy of the polynomial evaluation.

  procedure Newton_Step_to_Wanted_Accuracy
              ( f : in Standard_Complex_Poly_Systems.Poly_Sys;
                jf : in Standard_Complex_Jaco_Matrices.Jaco_Mat;
                z : in out Standard_Complex_Vectors.Vector;
                want : in integer32; loss : out integer32;
                jfzrco,fzrco,err : out double_float;
                fz : out Standard_Complex_Vectors.Vector;
                fail : out boolean );
  procedure Newton_Step_to_Wanted_Accuracy
              ( f : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                jf : in DoblDobl_Complex_Jaco_Matrices.Jaco_Mat;
                z : in out DoblDobl_Complex_Vectors.Vector;
                want : in integer32; loss : out integer32;
                jfzrco,fzrco,err : out double_double;
                fz : out DoblDobl_Complex_Vectors.Vector;
                fail : out boolean );
  procedure Newton_Step_to_Wanted_Accuracy
              ( f : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                jf : in QuadDobl_Complex_Jaco_Matrices.Jaco_Mat;
                z : in out QuadDobl_Complex_Vectors.Vector;
                want : in integer32; loss : out integer32;
                jfzrco,fzrco,err : out quad_double;
                fz : out QuadDobl_Complex_Vectors.Vector;
                fail : out boolean );
  procedure Newton_Step_to_Wanted_Accuracy
              ( f : in Multprec_Complex_Poly_Systems.Poly_Sys;
                jf : in Multprec_Complex_Jaco_Matrices.Jaco_Mat;
                z : in out Multprec_Complex_Vectors.Vector;
                prec,want : in integer32; loss : out integer32;
                jfzrco,fzrco,err : out Floating_Number;
                fz : out Multprec_Complex_Vectors.Vector;
                fail : out boolean );

  -- DESCRIPTION :
  --   Estimates the loss of accuracy and if the loss is small enough
  --   to achieve the desired wanted number of decimal places with
  --   the double, double double, quad double, or arbitrary precision, 
  --   then one Newton step is done.

  -- ON ENTRY :
  --   f        polynomial system in as many equations in as many variables;
  --   jf       Jacobian matrix of the system f;
  --   z        current approximation for a solution of f;
  --   prec     number of decimal places in the arbitrary multiprecision;
  --   want     wanted number of decimal places to be accurate.

  -- ON RETURN :
  --   z        if not fail, then updated approximation for a solution;
  --   loss     estimated loss of decimal places;
  --   jfzrco   inverse condition number of the Jacobian matrix at z;
  --   fzrco    inverse condition number of the evaluation problem of f at z;
  --   err      if not fail, then magnitude of the correction added to z;
  --   fz       system f evaluated at z;
  --   fail     if the precision is insufficient to meet the accuracy.

-- PART II : estimating loss of accuracy

  procedure Standard_Estimate_Loss_of_Accuracy
              ( f : in Array_of_Strings; z : in string;
                jfrco,fzrco : out double_float; loss : out integer32 );
  procedure DoblDobl_Estimate_Loss_of_Accuracy
              ( f : in Array_of_Strings; z : in string;
                jfrco,fzrco : out double_double; loss : out integer32 );
  procedure QuadDobl_Estimate_Loss_of_Accuracy
              ( f : in Array_of_Strings; z : in string;
                jfrco,fzrco : out quad_double; loss : out integer32 );

  -- DESCRIPTION :
  --   Evaluates the system in f and vector in z in standard
  --   double, double double, or quad double  precision to determine the 
  --   condition numbers of the Jacobian matrix and evaluation problem.

  -- REQUIRED : f'range = number of equations and variables,
  --   so z will parse into a complex vector of that many variables.

  -- ON ENTRY :
  --   f        array of strings the contain a polynomial system;
  --   z        string of numbers, separated by newline symbols.

  -- ON RETURN :
  --   jfrco    inverse condition number of Jacobian matrix of f at z;
  --   fzrco    inverse condition number of evaluating f at z;
  --   loss     loss of number of decimal places, as negative number.

  procedure Estimate_Loss_of_Accuracy
              ( f : in Array_of_Strings; z : in string;
                jfrco,fzrco : out Floating_Number; loss : out integer32 );

  -- DESCRIPTION :
  --   Evaluates the system in f and vector in z at various precision
  --   until sufficiently high to determine the condition numbers
  --   of the Jacobian matrix and evaluation problem.

  -- ON ENTRY :
  --   f        array of strings the contain a polynomial system;
  --   z        string of numbers, separated by newline symbols.

  -- ON RETURN :
  --   jfrco    inverse condition number of Jacobian matrix of f at z;
  --   fzrco    inverse condition number of evaluating f at z;
  --   loss     loss of number of decimal places, as negative number.

  function Estimate_Loss_of_Accuracy
              ( f : Array_of_Strings; z : string ) return integer32;

  -- DESCRIPTION :
  --   Returns estimated loss of decimal places as a negative number
  --   based on condition number estimates for one Newton step on f at z.
  --   This function encapsulates the same named procedure.

end Varbprec_Complex_Newton_Steps;
