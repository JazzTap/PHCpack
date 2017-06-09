with text_io;                            use text_io;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Complex_Poly_Systems;
with Standard_Complex_Poly_Systems_io;   use Standard_Complex_Poly_Systems_io;
with Standard_Complex_Solutions;
with Standard_Complex_Solutions_io;      use Standard_Complex_Solutions_io;
with Standard_System_and_Solutions_io;
with Standard_Solutions_Container;
with PHCpack_Operations;

procedure ts_runtrack is

-- DESCRIPTION :
--   Development of path trackers which write the results immediately
--   in the solution container.

  procedure Standard_Track_Paths is

  -- DESCRIPTION :
  --   Tracks all paths starting at the solutions
  --   stored as start solutions.
  --   The solutions container will contain all solutions.
  --   Solutions are appended directly after the computation.
  --   There is no root postprocessing stage.

  -- REQUIRED :
  --   The data in PHCpack_Operations have been initialized with
  --   a target system, start system with start solutions,
  --   in double precision.
    
    use Standard_Complex_Solutions;
 
    sols,tmp : Solution_List;
    len : double_float;
    nbstep,nbfail,nbiter,nbsyst : natural32;
    crash : boolean;
    cnt : natural32 := 0;

  begin
    PHCpack_Operations.Retrieve_Start_Solutions(sols);
    Standard_Solutions_Container.Clear;
    tmp := sols;
    while not Is_Null(tmp) loop
      declare
        ls : constant Link_to_Solution := Head_Of(tmp);
      begin
        PHCpack_Operations.Silent_Path_Tracker
          (ls,len,nbstep,nbfail,nbiter,nbsyst,crash);
        cnt := cnt + 1;
        put("Solution "); put(cnt,1); put_line(" :");
        put_vector(ls.v);
        Standard_Solutions_Container.Append(ls);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    put("Number of solutions in the solution container : ");
    put(Standard_Solutions_Container.Length,1);
    new_line;
  end Standard_Track_Paths;

  procedure Main is

  -- DESCRIPTION :
  --   Prompts the user for a target and a start system
  --   with start solution and then launches the tracking.

    lp,lq : Standard_Complex_Poly_Systems.Link_to_Poly_Sys;
    sols : Standard_Complex_Solutions.Solution_List;

  begin
    new_line;
    put_line("Reading a target system ...");
    get(lp);
    PHCpack_Operations.Store_Target_System(lp.all);
    Standard_System_and_Solutions_io.get(lq,sols);
    PHCpack_Operations.Store_Start_System(lq.all);
    PHCpack_Operations.Store_Start_Solutions(sols);
    new_line;
    put("Read ");
    put(Standard_Complex_Solutions.Length_Of(sols),1);
    put_line(" start solutions.");
    new_line;
    PHCpack_Operations.Create_Standard_Homotopy;
    Standard_Track_Paths;
  end Main;

begin
  Main;
end ts_runtrack;
