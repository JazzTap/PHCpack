with text_io;                            use text_io;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Complex_Poly_Systems;
with Standard_Complex_Laur_Systems;
with DoblDobl_Complex_Poly_Systems;
with DoblDobl_Complex_Laur_Systems;
with QuadDobl_Complex_Poly_Systems;
with QuadDobl_Complex_Laur_Systems;
with Standard_Complex_Solutions;
with DoblDobl_Complex_Solutions;
with QuadDobl_Complex_Solutions;

package Drivers_to_Cascade_Filtering is

-- DESCRIPTION :
--   This package contains drivers to the cascade homotopies.

  procedure Standard_Witness_Generate
              ( nt : in natural32; inpname,outname : in string );
  procedure DoblDobl_Witness_Generate
              ( nt : in natural32; inpname,outname : in string );
  procedure QuadDobl_Witness_Generate
              ( nt : in natural32; inpname,outname : in string );

  -- DESCRIPTION :
  --   Interactive driver to call the Witness_Generate procedure,
  --   in standard double, double double, or quad double precision.
  --   Names for the input and output file are passed at the command line.

  -- ON ENTRY :
  --   nt       number of tasks, if zero, then no tasking;
  --   inpname  name of the input file;
  --   outname  name of the output file.

  procedure Driver_to_Witness_Generate
              ( nt : in natural32; inpname,outname : in string );

  -- DESCRIPTION :
  --   Prompts the user for the level of the working precision and
  --   then calls the Standard, DoblDobl, or QuadDobl_Witness_Generate.
  --   Names for the input and output file are passed at the command line.

  -- ON ENTRY :
  --   nt       number of tasks, if zero, then no tasking;
  --   inpname  name of the input file;
  --   outname  name of the output file.

  procedure Prompt_for_Top_Dimension
              ( nq,nv : in natural32; topdim,lowdim : out natural32 );

  -- DESCRIPTION :
  --   Prompts the user for the value of the top dimension
  --   and checks whether what gets entered is not larger than nv-1
  --   and that it is at least larger than the lowest dimension
  --   for underdetermined inputs.

  -- ON ENTRY :
  --   nq       number of equations in the system;
  --   nv       number of variables in the system.

  -- ON RETURN :
  --   topdim   the requested top dimension.
  --   lowdim   the computed lower bound on the dimension.

  procedure Standard_Embed_and_Cascade
              ( file : in file_type; name : in string; nt : in natural32; 
                p : in Standard_Complex_Poly_Systems.Poly_Sys );
  procedure DoblDobl_Embed_and_Cascade
              ( file : in file_type; name : in string; nt : in natural32; 
                p : in DoblDobl_Complex_Poly_Systems.Poly_Sys );
  procedure QuadDobl_Embed_and_Cascade
              ( file : in file_type; name : in string; nt : in natural32; 
                p : in QuadDobl_Complex_Poly_Systems.Poly_Sys );
  procedure Standard_Embed_and_Cascade
              ( file : in file_type; name : in string; nt : in natural32; 
                p : in Standard_Complex_Laur_Systems.Laur_Sys );
  procedure DoblDobl_Embed_and_Cascade
              ( file : in file_type; name : in string; nt : in natural32; 
                p : in DoblDobl_Complex_Laur_Systems.Laur_Sys );
  procedure QuadDobl_Embed_and_Cascade
              ( file : in file_type; name : in string; nt : in natural32; 
                p : in QuadDobl_Complex_Laur_Systems.Laur_Sys );

  -- DESCRIPTION :
  --   Prompts the user to enter the top dimension, embeds the system,
  --   and then runs a cascade of homotopies,
  --   in standard double, double double, or quad double precision.

  -- ON ENTRY :
  --   file     file opened for output;
  --   name     name of the output file;
  --   nt       number of tasks for multitasking,
  --            if zero, then no multitasking will be used;
  --   p        an ordinary or a Laurent polynomial system.

  procedure Standard_Run_Cascade
              ( nt,topdim : in natural32;
                embsys : in Standard_Complex_Poly_Systems.Poly_Sys;
                sols : in Standard_Complex_Solutions.Solution_List;
                filter,factor : in boolean );
  procedure Standard_Run_Cascade
              ( nt,topdim : in natural32;
                embsys : in Standard_Complex_Laur_Systems.Laur_Sys;
                sols : in Standard_Complex_Solutions.Solution_List;
                filter,factor : in boolean );
  procedure DoblDobl_Run_Cascade
              ( nt,topdim : in natural32;
                embsys : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                sols : in DoblDobl_Complex_Solutions.Solution_List;
                filter,factor : in boolean );
  procedure DoblDobl_Run_Cascade
              ( nt,topdim : in natural32;
                embsys : in DoblDobl_Complex_Laur_Systems.Laur_Sys;
                sols : in DoblDobl_Complex_Solutions.Solution_List;
                filter,factor : in boolean );
  procedure QuadDobl_Run_Cascade
              ( nt,topdim : in natural32;
                embsys : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                sols : in QuadDobl_Complex_Solutions.Solution_List;
                filter,factor : in boolean );
  procedure QuadDobl_Run_Cascade
              ( nt,topdim : in natural32;
                embsys : in QuadDobl_Complex_Laur_Systems.Laur_Sys;
                sols : in QuadDobl_Complex_Solutions.Solution_List;
                filter,factor : in boolean );

  -- DESCRIPTION :
  --   Given an embedding of the top dimensional solution set,
  --   runs a cascade of homotopies,
  --   in standard double, double double, or quad double precision.

  -- ON ENTRY :
  --   nt       number of tasks for multitasking,
  --            if zero, then no multitasking will be used;
  --   topdim   the top dimension of the solution set;
  --   embsys   an embedded system for the top dimension;
  --   sols     solutions of the system embsys;
  --   filter   if true, then junk points will be removed,
  --            otherwise, the output will be superwitness sets.
  --   factor   if true and filter, then the filtered witness sets will be
  --            factored into irreducible components,
  --            otherwise, the output sets may still be reducible.

  procedure Standard_Embed_and_Cascade
              ( nt : in natural32;
                p : in Standard_Complex_Poly_Systems.Poly_Sys;
                filter,factor : in boolean );
  procedure Standard_Embed_and_Cascade
              ( nt : in natural32;
                p : in Standard_Complex_Laur_Systems.Laur_Sys;
                filter,factor : in boolean );
  procedure DoblDobl_Embed_and_Cascade
              ( nt : in natural32;
                p : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                filter,factor : in boolean );
  procedure DoblDobl_Embed_and_Cascade
              ( nt : in natural32;
                p : in DoblDobl_Complex_Laur_Systems.Laur_Sys;
                filter,factor : in boolean );
  procedure QuadDobl_Embed_and_Cascade
              ( nt : in natural32;
                p : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                filter,factor : in boolean );
  procedure QuadDobl_Embed_and_Cascade
              ( nt : in natural32;
                p : in QuadDobl_Complex_Laur_Systems.Laur_Sys;
                filter,factor : in boolean );

  -- DESCRIPTION :
  --   Prompts the user to enter the top dimension, embeds the system,
  --   and then runs a cascade of homotopies,
  --   in double, double double, or quad double precision.
  --   All output is written to screen.

  -- ON ENTRY :
  --   nt       number of tasks for multitasking,
  --            if zero, then no multitasking will be used;
  --   p        an ordinary or a Laurent polynomial system;
  --   filter   if true, then junk points will be removed,
  --            otherwise, the output will be superwitness sets.
  --   factor   if true and filter, then the filtered witness sets will be
  --            factored into irreducible components,
  --            otherwise, the output sets may still be reducible.

  procedure Standard_Embed_and_Cascade
              ( nt : in natural32; inpname,outname : in string );
  procedure DoblDobl_Embed_and_Cascade
              ( nt : in natural32; inpname,outname : in string );
  procedure QuadDobl_Embed_and_Cascade
              ( nt : in natural32; inpname,outname : in string );

  -- DESCRIPTION :
  --   Does the embedding of the top dimension and runs the cascade,
  --   in standard double, double double, or quad double precision.

  -- ON ENTRY :
  --   nt       the number of tasks, if 0 then no multitasking,
  --            otherwise nt tasks will be used to track the paths;
  --   inpname  name of the input file;
  --   outname  name of the output file.

  procedure Embed_and_Cascade
              ( nt : in natural32; inpname,outname : in string );

  -- DESCRIPTION :
  --   Prompts the user for the level of working precision,
  --   does the embedding of the top dimension and runs the cascade.

  -- ON ENTRY :
  --   nt       the number of tasks, if 0 then no multitasking,
  --            otherwise nt tasks will be used to track the paths;
  --   inpname  name of the input file;
  --   outname  name of the output file.

end Drivers_to_Cascade_Filtering;
