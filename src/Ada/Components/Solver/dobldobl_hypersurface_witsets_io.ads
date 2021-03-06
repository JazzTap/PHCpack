with text_io;                           use text_io;
with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with DoblDobl_Complex_Vectors;          use DoblDobl_Complex_Vectors;
with DoblDobl_Complex_Polynomials;      use DoblDobl_Complex_Polynomials;

package DoblDobl_Hypersurface_Witsets_io is

-- DESCRIPTION :
--   This package collects the function to compute and write a witness set
--   for one polynomial in several variables.

  procedure Write_Witness_Set
               ( n : in integer32; p : in Poly; b,v,t : in Vector );
  procedure Write_Witness_Set
               ( file : in file_type;
                 n : in integer32; p : in Poly; b,v,t : in Vector );

  -- DESCRIPTION :
  --   Writes the witness set for p given intrinsically as b + t*v
  --   in extrinsic format to file.
  --   Prompts the user to provide a file name if file is not provided.

end DoblDobl_Hypersurface_Witsets_io;
