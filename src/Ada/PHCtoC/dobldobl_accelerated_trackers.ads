with Standard_Integer_Numbers;           use Standard_Integer_Numbers;

package DoblDobl_Accelerated_Trackers is

-- DESCRIPTION :
--   Wraps the C++ code to accelerate Newton's method and path tracking
--   in double double precision.  The Ada procedures are in control.
--   Data is passed to the C++ code via the systems and solutions containers.

  procedure DoblDobl_GPU_Newton ( execmode,verbose : integer32 );

  -- DESCRIPTION :
  --   Calls the accelerated Newton's method in double double precision.
 
  -- REQUIRED :
  --   The containers for polynomial systems and for solutions
  --   in double double precision contain a system and a solution.
  --   The computed solution is place in the solutions container.

  -- ON ENTRY :
  --   execmode   0 (both cpu and gpu), 1 (cpu only), or 2 (gpu only);
  --   verbose    if > 0, then additional output is written to screen.

  procedure DoblDobl_GPU_Track_One ( execmode,verbose : integer32 );

  -- DESCRIPTION :
  --   Calls the accelerated path tracker in double double precision,
  --   for tracking one solution path.

  -- REQUIRED :
  --   A target and start system are defined in PHCpack_Operations
  --   and the solutions container contains one start solution.

  -- ON ENTRY :
  --   execmode   0 (both cpu and gpu), 1 (cpu only), or 2 (gpu only);
  --   verbose    if > 0, then additional output is written to screen.

  procedure DoblDobl_GPU_Track_Many ( execmode,verbose : integer32 );

  -- DESCRIPTION :
  --   Calls the accelerated path tracker in double double precision,
  --   for tracking many solution paths.

  -- REQUIRED :
  --   A target and start system are defined in PHCpack_Operations
  --   and the start solutions are stored in the solutions container.

  -- ON ENTRY :
  --   execmode   0 (both cpu and gpu), 1 (cpu only), or 2 (gpu only);
  --   verbose    if > 0, then additional output is written to screen.

end DoblDobl_Accelerated_Trackers; 
