with text_io;                            use text_io;
with Communications_with_User;           use Communications_with_User;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Complex_Numbers;           use Standard_Complex_Numbers;
with Standard_Complex_Numbers_io;        use Standard_Complex_Numbers_io;
with Standard_Random_Numbers;
with DoblDobl_Complex_Poly_Systems;
with DoblDobl_Complex_Poly_Systems_io;   use DoblDobl_Complex_Poly_Systems_io;
with DoblDobl_Complex_Solutions;
with DoblDobl_Complex_Solutions_io;      use DoblDobl_Complex_Solutions_io;
with DoblDobl_System_and_Solutions_io;
with DoblDobl_PolySys_Container;
with DoblDobl_Solutions_Container;
with PHCpack_Operations;
with DoblDobl_AlgoDiffEval_Trackers;     use DoblDobl_AlgoDiffEval_Trackers;

procedure ts_adepath_dd is

-- DESCRIPTION :
--   Procedure to test the development of Newton's method and path trackers
--   using algorithmic differentiation for the evaluation,
--   in double double precision.

  function Prompt_for_Verbose return integer32 is

  -- DESCRIPTION :
  --   Asks the user if extra output is wanted and returns 0 or 1.

    ans : character;

  begin
    new_line;
    put("Extra output before and after the computations ? (y/n) ");
    Ask_Yes_or_No(ans);
    if ans = 'y'
     then return 1;
     else return 0;
    end if;
  end Prompt_for_Verbose;

  procedure DoblDobl_Newton is

  -- DESCRIPTION :
  --   Reads a polynomial system and a corresponding list of solutions
  --   in double double precision.

    use DoblDobl_Complex_Poly_Systems;
    use DoblDobl_Complex_Solutions;

    p : Link_to_Poly_Sys;
    sols,newtsols : Solution_List;
    verbose : integer32;

  begin
    new_line;
    put_line("Reading a system with solutions ...");
    DoblDobl_System_and_Solutions_io.get(p,sols);
    new_line;
    put("Read "); put(Length_Of(sols),1); put_line(" solutions.");
    put_line("Initializing the systems container ...");
    DoblDobl_PolySys_Container.Initialize(p.all);
    put_line("Initializing the solutions container ...");
    DoblDobl_Solutions_Container.Initialize(sols);
    verbose := Prompt_for_Verbose;
    DoblDobl_ADE_Newton(verbose);
    newtsols := DoblDobl_Solutions_Container.Retrieve;
    put_line("The solutions after Newton's method :");
    put(standard_output,Length_Of(newtsols),
        natural32(Head_Of(newtsols).n),newtsols);
  end DoblDobl_Newton;

  procedure DoblDobl_Track_one_Path is

  -- DESCRIPTION :
  --   Reads a target and start system, with a solution in double double
  --   precision and calls the path tracker.

    use DoblDobl_Complex_Poly_Systems;
    use DoblDobl_Complex_Solutions;

    target,start : Link_to_Poly_Sys;
    sols,newtsols : Solution_List;
    verbose : integer32;
    gamma : constant Complex_Number
          := Standard_Random_Numbers.Random1;

  begin
    new_line;
    put_line("Reading a target system ...");
    get(target);
    new_line;
    put_line("Reading a start system with solutions ...");
    DoblDobl_System_and_Solutions_io.get(start,sols);
    new_line;
    put("gamma = "); put(gamma); new_line;
    new_line;
    put("Read "); put(Length_Of(sols),1); put_line(" solutions.");
    put_line("Initializing the data for container copies ...");
    PHCpack_Operations.Store_Target_System(target.all);
    PHCpack_Operations.Store_Start_System(start.all);
    put_line("Initializing the solutions container ...");
    DoblDobl_Solutions_Container.Initialize(sols);
    verbose := Prompt_for_Verbose;
    DoblDobl_ADE_Track_One(verbose,gamma);
    newtsols := DoblDobl_Solutions_Container.Retrieve;
    put_line("The solutions after path tracking :");
    put(standard_output,Length_Of(newtsols),
        natural32(Head_Of(newtsols).n),newtsols);
  end DoblDobl_Track_one_Path;

  procedure DoblDobl_Track_many_Paths is

  -- DESCRIPTION :
  --   Reads a target and start system, with solutions in double double
  --   precision, and calls the path tracker.

    use DoblDobl_Complex_Poly_Systems;
    use DoblDobl_Complex_Solutions;

    target,start : Link_to_Poly_Sys;
    sols,newtsols : Solution_List;
    verbose : integer32;
    gamma : constant Complex_Number
          := Standard_Random_Numbers.Random1;

  begin
    new_line;
    put_line("Reading a target system ...");
    get(target);
    new_line;
    put_line("Reading a start system with solutions ...");
    DoblDobl_System_and_Solutions_io.get(start,sols);
    new_line;
    put("gamma = "); put(gamma); new_line;
    new_line;
    put("Read "); put(Length_Of(sols),1); put_line(" solutions.");
    put_line("Initializing the data for container copies ...");
    PHCpack_Operations.Store_Target_System(target.all);
    PHCpack_Operations.Store_Start_System(start.all);
    put_line("Initializing the solutions container ...");
    DoblDobl_Solutions_Container.Initialize(sols);
    verbose := Prompt_for_Verbose;
    DoblDobl_ADE_Track_Many(verbose,gamma);
    newtsols := DoblDobl_Solutions_Container.Retrieve;
    put_line("The solutions after path tracking :");
    put(standard_output,Length_Of(newtsols),
        natural32(Head_Of(newtsols).n),newtsols);
  end DoblDobl_Track_many_Paths;

  procedure Main is

    ans : character;

  begin
    new_line;
    put_line("MENU to test ADE code in standard double precision :");
    put_line("  0. apply Newton's method on one single solution;");
    put_line("  1. track one single solution path from start to target;");
    put_line("  2. track many solution paths from start to target.");
    put("Type 0, 1, or 2 to make your choice : ");
    Ask_Alternative(ans,"012");
    case ans is
      when '0' => DoblDobl_Newton;
      when '1' => DoblDobl_Track_one_Path;
      when '2' => DoblDobl_Track_Many_Paths;
      when others => null;
    end case;
  end Main;

begin
  Main;
end ts_adepath_dd;
