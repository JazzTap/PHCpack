with text_io;                            use text_io;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Double_Double_Numbers;              use Double_Double_Numbers;
with Double_Double_Vectors;
with DoblDobl_Complex_Vectors;
with DoblDobl_Complex_Solutions;         use DoblDobl_Complex_Solutions;

package DoblDobl_Quad_Turn_Points_io is

-- DESCRIPTION :
--   This package offers some basic i/o for use in the computation
--   of quadratic turning points in real homotopies,
--   performed in double double precision.

  procedure Write_Vector ( x : in Double_Double_Vectors.Vector );
  procedure Write_Vector ( file : in file_type;
                           x : in Double_Double_Vectors.Vector );
  procedure Write_Vector ( x : in DoblDobl_Complex_Vectors.Vector );
  procedure Write_Vector ( file : in file_type;
                           x : in DoblDobl_Complex_Vectors.Vector );

  -- DESCRIPTION :
  --   Writes a real or complex vector to file or to screen, using the
  --   symbol table, to precede every number by the corresponding symbol.

  procedure Write_Tangent ( x : in Double_Double_Vectors.Vector );
  procedure Write_Tangent ( file : in file_type;
                            x : in Double_Double_Vectors.Vector );
  procedure Write_Tangent ( x : in DoblDobl_Complex_Vectors.Vector );
  procedure Write_Tangent ( file : in file_type;
                            x : in DoblDobl_Complex_Vectors.Vector );

  -- DESCRIPTION :
  --   Writes a real or complex tangent vector to file or to screen, using
  --   the corresponding symbols of the variable for each numerical value.

  procedure Write_Vector_and_its_Tangent
              ( x,t : in Double_Double_Vectors.Vector );
  procedure Write_Vector_and_its_Tangent
              ( file : in file_type;
                x,t : in Double_Double_Vectors.Vector );
  procedure Write_Vector_and_its_Tangent
              ( x,t : in DoblDobl_Complex_Vectors.Vector );
  procedure Write_Vector_and_its_Tangent
              ( file : in file_type;
                x,t : in DoblDobl_Complex_Vectors.Vector );

  -- DESCRIPTION :
  --   Writes the vector x and its corresponding tangent t to file
  --   or to screen.

  procedure Write_Vector_Tangent_and_Determinants
              ( x,t,det : in Double_Double_Vectors.Vector );
  procedure Write_Vector_Tangent_and_Determinants
              ( file : in file_type;
                x,t,det : in Double_Double_Vectors.Vector );

  -- DESCRIPTION :
  --   Writes vector x, its tangent t, and determinants of the Jacobian
  --   matrix at x to screen or to file.

  procedure Read_Initial_Vector
              ( x : in out Double_Double_Vectors.Vector );
  procedure Read_Initial_Vector
              ( x : in out DoblDobl_Complex_Vectors.Vector );

  -- DESCRIPTION :
  --   Prompts the user for a real or complex start solution,
  --   using the symbol table to match names of variables with
  --   the correct values.

  procedure Write_Corrector_Information
              ( x,y : in Double_Double_Vectors.Vector;
                err,res : in double_double );
  procedure Write_Corrector_Information
              ( x,y : in Double_Double_Vectors.Vector;
                err,res,det : in double_double );
  procedure Write_Corrector_Information
              ( file : in file_type;
                x,y : in Double_Double_Vectors.Vector;
                err,res : in double_double );
  procedure Write_Corrector_Information
              ( file : in file_type;
                x,y : in Double_Double_Vectors.Vector;
                err,res,det : in double_double );
  procedure Write_Corrector_Information
              ( x : in DoblDobl_Complex_Vectors.Vector;
                err,res : in double_double );
  procedure Write_Corrector_Information
              ( file : in file_type;
                x : in DoblDobl_Complex_Vectors.Vector;
                err,res : in double_double );
  procedure Write_Corrector_Information
              ( x : in DoblDobl_Complex_Vectors.Vector;
                err,res,det : in double_double );
  procedure Write_Corrector_Information
              ( file : in file_type;
                x : in DoblDobl_Complex_Vectors.Vector;
                err,res,det : in double_double );

  -- DESCRIPTION :
  --   Writes the information of one corrector step to file or to screen.

  -- ON ENTRY :
  --   file     must be opened for output;
  --   x        real or complex solution;
  --   y        value of the system at x (optional);
  --   err      magnitude of the correction applied to x;
  --   res      residual value of the solution;
  --   det      value of determinant at the solution.

  procedure Write_Sweep_Summary
              ( file : in file_type; sols : in Solution_List;
                tol : in double_double;
                mint : out double_double; nbreal : out natural32 );

  -- DESCRIPTION :
  --   Writes a summary of the sweep, for each solution, prints the
  --   final t value, its largest imaginary part, decides whether it
  --   is real and tallies the number of real solutions.
             
  -- ON ENTRY :
  --   file     file for output;
  --   sols     solutions at the end of the sweep;
  --   tol      tolerance on largest imaginary part in absolute value,
  --            any number smaller than tol will be consider real.

  -- ON RETURN :
  --   mint     minimal value of t where the sweep first stopped;
  --   nbreal   total number of real solutions.

  procedure Write_Sweep_Summary
              ( file : in file_type; sols : in Solution_List );

  -- DESCRIPTION :
  --   Writes sweep summary, using default value for the tolerance
  --   when calling the other Write_Sweep_Summary, suppressing
  --   the other return values.

end DoblDobl_Quad_Turn_Points_io;
