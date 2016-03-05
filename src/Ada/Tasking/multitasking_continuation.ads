with text_io;                           use text_io;
with String_Splitters;
with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Complex_Poly_Systems;
with Standard_Complex_Solutions;
with DoblDobl_Complex_Solutions;
with QuadDobl_Complex_Solutions;

package Multitasking_Continuation is

-- DESCRIPTION :
--   Offers routines to track all paths using multitasking.

  procedure Silent_Path_Tracker
               ( ls : in Standard_Complex_Solutions.Link_to_Solution );
  procedure Silent_Path_Tracker
               ( ls : in DoblDobl_Complex_Solutions.Link_to_Solution );
  procedure Silent_Path_Tracker
               ( ls : in QuadDobl_Complex_Solutions.Link_to_Solution );

  procedure Silent_Path_Tracker
               ( id,nb : in integer32;
                 ls : in Standard_Complex_Solutions.Link_to_Solution );
  procedure Silent_Path_Tracker
               ( id,nb : in integer32;
                 ls : in DoblDobl_Complex_Solutions.Link_to_Solution );
  procedure Silent_Path_Tracker
               ( id,nb : in integer32;
                 ls : in QuadDobl_Complex_Solutions.Link_to_Solution );

  -- DESCRIPTION :
  --   Task with identification number id reports the receipt of
  --   solution with number nb, with data in ls.
  --   If id and nb are omitted, then Silent_Path_Tracker remains mute,
  --   otherwise one line is written to screen allowing the user to
  --   monitor the progress of the computations.

  procedure Silent_Laurent_Path_Tracker
               ( ls : in Standard_Complex_Solutions.Link_to_Solution );
  procedure Silent_Laurent_Path_Tracker
               ( ls : in DoblDobl_Complex_Solutions.Link_to_Solution );
  procedure Silent_Laurent_Path_Tracker
               ( ls : in QuadDobl_Complex_Solutions.Link_to_Solution );

  procedure Silent_Laurent_Path_Tracker
               ( id,nb : in integer32;
                 ls : in Standard_Complex_Solutions.Link_to_Solution );
  procedure Silent_Laurent_Path_Tracker
               ( id,nb : in integer32;
                 ls : in DoblDobl_Complex_Solutions.Link_to_Solution );
  procedure Silent_Laurent_Path_Tracker
               ( id,nb : in integer32;
                 ls : in QuadDobl_Complex_Solutions.Link_to_Solution );

  -- DESCRIPTION :
  --   Path trackers for Laurent polynomial systems.

  procedure Silent_Multitasking_Path_Tracker
               ( sols : in out Standard_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Silent_Multitasking_Path_Tracker
               ( sols : in out DoblDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Silent_Multitasking_Path_Tracker
               ( sols : in out QuadDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );

  procedure Reporting_Multitasking_Path_Tracker
               ( sols : in out Standard_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Reporting_Multitasking_Path_Tracker
               ( sols : in out DoblDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Reporting_Multitasking_Path_Tracker
               ( sols : in out QuadDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );

  procedure Silent_Multitasking_Laurent_Path_Tracker
               ( sols : in out Standard_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Silent_Multitasking_Laurent_Path_Tracker
               ( sols : in out DoblDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Silent_Multitasking_Laurent_Path_Tracker
               ( sols : in out QuadDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );

  procedure Reporting_Multitasking_Laurent_Path_Tracker
               ( sols : in out Standard_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Reporting_Multitasking_Laurent_Path_Tracker
               ( sols : in out DoblDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );
  procedure Reporting_Multitasking_Laurent_Path_Tracker
               ( sols : in out QuadDobl_Complex_Solutions.Solution_List;
                 n : in integer32 );

  -- DESCRIPTION :
  --   n tasks will track the paths starting at sols.
  --   The silent version stays mute, while the reporting version
  --   allows the user to monitor the progress of the computations.

  -- REQUIRED :
  --   {Standard,DoblDobl,QuadDobl}_Homotopy has been initialized properly,
  --   or Standard_Laurent_Homotopy for the *Laurent* trackers.

  -- ON ENTRY :
  --   sols      start solutions.

  -- ON RETURN :
  --   sols      solutions at the end of the paths. 

  procedure Driver_to_Path_Tracker
               ( file : in file_type;
                 p : in Standard_Complex_Poly_Systems.Poly_Sys;
                 ls : in String_Splitters.Link_to_Array_of_Strings;
                 n,nbequ,nbvar : in integer32 );

  -- DESCRIPTION :
  --   Driver to Multitasking_Path_Tracker, for mainpoco.

  -- ON ENTRY :
  --   file      the output file;
  --   p         target polynomial system to be solved;
  --   ls        string representation of the polynomials in p,
  --             for conversion to double double or quad double precision;
  --   n         number of tasks;
  --   nbequ     the number of equations;
  --   nbvar     the number of variables.

end Multitasking_Continuation;
