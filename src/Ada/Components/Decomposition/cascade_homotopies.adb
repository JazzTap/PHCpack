with Timing_Package;                     use Timing_Package;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Natural_VecVecs;
with Standard_Complex_Poly_Systems_io;   use Standard_Complex_Poly_Systems_io;
with Standard_Complex_Laur_Systems_io;   use Standard_Complex_Laur_Systems_io;
with DoblDobl_Complex_Poly_Systems_io;   use DoblDobl_Complex_Poly_Systems_io;
with DoblDobl_Complex_Laur_Systems_io;   use DoblDobl_Complex_Laur_Systems_io;
with QuadDobl_Complex_Poly_Systems_io;   use QuadDobl_Complex_Poly_Systems_io;
with QuadDobl_Complex_Laur_Systems_io;   use QuadDobl_Complex_Laur_Systems_io;
with Standard_Solution_Splitters;        use Standard_Solution_Splitters;
with DoblDobl_Solution_Splitters;        use DoblDobl_Solution_Splitters;
with QuadDobl_Solution_Splitters;        use QuadDobl_Solution_Splitters;
with Witness_Sets;                       use Witness_Sets;
with Path_Counts_Table;                  use Path_Counts_Table;
with Greeting_Banners;
with Write_Seed_Number;
with Cascade_Homotopy_Steps;             use Cascade_Homotopy_Steps;
with Cascade_Homotopies_io;              use Cascade_Homotopies_io;

package body Cascade_Homotopies is

  procedure Witness_Generate
              ( outfile,resfile : in file_type; nt : in natural32;
                ep : in Standard_Complex_Poly_Systems.Poly_Sys;
                sols : in Standard_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use Standard_Complex_Poly_Systems;
    use Standard_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Poly_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Poly_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Poly_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    put_line(resfile,ep);
    Write_Super_Witness_Points(resfile,sols0);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        new_line(resfile);
        put_line(resfile,embsys(i-1).all);
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Super_Witness_Points(resfile,rsols1);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Super_Witness_Points(resfile,rsols0);
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( outfile,resfile : in file_type; nt : in natural32;
                ep : in Standard_Complex_Laur_Systems.Laur_Sys;
                sols : in Standard_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use Standard_Complex_Laur_Systems;
    use Standard_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Laur_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Laur_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Laur_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    put_line(resfile,ep);
    Write_Super_Witness_Points(resfile,sols0);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        new_line(resfile);
        put_line(resfile,embsys(i-1).all);
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Super_Witness_Points(resfile,rsols1);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Super_Witness_Points(resfile,rsols0);
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( outfile,resfile : in file_type; nt : in natural32;
                ep : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                sols : in DoblDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use DoblDobl_Complex_Poly_Systems;
    use DoblDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Poly_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Poly_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Poly_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    put_line(resfile,ep);
    Write_Super_Witness_Points(resfile,sols0);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        new_line(resfile);
        put_line(resfile,embsys(i-1).all);
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Super_Witness_Points(resfile,rsols1);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Super_Witness_Points(resfile,rsols0);
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( outfile,resfile : in file_type; nt : in natural32;
                ep : in DoblDobl_Complex_Laur_Systems.Laur_Sys;
                sols : in DoblDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use DoblDobl_Complex_Laur_Systems;
    use DoblDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Laur_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Laur_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Laur_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    put_line(resfile,ep);
    Write_Super_Witness_Points(resfile,sols0);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        new_line(resfile);
        put_line(resfile,embsys(i-1).all);
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Super_Witness_Points(resfile,rsols1);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Super_Witness_Points(resfile,rsols0);
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( outfile,resfile : in file_type; nt : in natural32;
                ep : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                sols : in QuadDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use QuadDobl_Complex_Poly_Systems;
    use QuadDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Poly_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Poly_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Poly_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    put_line(resfile,ep);
    Write_Super_Witness_Points(resfile,sols0);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        new_line(resfile);
        put_line(resfile,embsys(i-1).all);
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Super_Witness_Points(resfile,rsols1);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Super_Witness_Points(resfile,rsols0);
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( outfile,resfile : in file_type; nt : in natural32;
                ep : in QuadDobl_Complex_Laur_Systems.Laur_Sys;
                sols : in QuadDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use QuadDobl_Complex_Laur_Systems;
    use QuadDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Laur_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Laur_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Laur_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    put_line(resfile,ep);
    Write_Super_Witness_Points(resfile,sols0);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        new_line(resfile);
        put_line(resfile,embsys(i-1).all);
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Super_Witness_Points(resfile,rsols1);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Super_Witness_Points(resfile,rsols0);
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( name : in string; outfile : in file_type;
                nt : in natural32;
                ep : in Standard_Complex_Poly_Systems.Poly_Sys;
                sols : in Standard_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use Standard_Complex_Poly_Systems;
    use Standard_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Poly_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Poly_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Poly_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    Write_Witness_Superset(name,ep,sols0,topdim);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Witness_Superset(name,embsys(i-1).all,rsols1,0);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Witness_Superset(name,embsys(i-1).all,rsols0,natural32(i-1));
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( name : in string; outfile : in file_type;
                nt : in natural32;
                ep : in Standard_Complex_Laur_Systems.Laur_Sys;
                sols : in Standard_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use Standard_Complex_Laur_Systems;
    use Standard_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Laur_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Laur_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Laur_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    Write_Witness_Superset(name,ep,sols0,topdim);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Witness_Superset(name,embsys(i-1).all,rsols1,0);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Witness_Superset(name,embsys(i-1).all,rsols0,natural32(i-1));
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( name : in string; outfile : in file_type;
                nt : in natural32;
                ep : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
                sols : in DoblDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use DoblDobl_Complex_Poly_Systems;
    use DoblDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Poly_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Poly_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Poly_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    Write_Witness_Superset(name,ep,sols0,topdim);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Witness_Superset(name,embsys(i-1).all,rsols1,0);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Witness_Superset(name,embsys(i-1).all,rsols0,natural32(i-1));
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( name : in string; outfile : in file_type;
                nt : in natural32;
                ep : in DoblDobl_Complex_Laur_Systems.Laur_Sys;
                sols : in DoblDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use DoblDobl_Complex_Laur_Systems;
    use DoblDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Laur_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Laur_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Laur_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    Write_Witness_Superset(name,ep,sols0,topdim);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Witness_Superset(name,embsys(i-1).all,rsols1,0);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Witness_Superset(name,embsys(i-1).all,rsols0,natural32(i-1));
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( name : in string; outfile : in file_type;
                nt : in natural32;
                ep : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
                sols : in QuadDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use QuadDobl_Complex_Poly_Systems;
    use QuadDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Poly_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Poly_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Poly_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    Write_Witness_Superset(name,ep,sols0,topdim);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Witness_Superset(name,embsys(i-1).all,rsols1,0);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Witness_Superset(name,embsys(i-1).all,rsols0,natural32(i-1));
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

  procedure Witness_Generate
              ( name : in string; outfile : in file_type;
                nt : in natural32;
                ep : in QuadDobl_Complex_Laur_Systems.Laur_Sys;
                sols : in QuadDobl_Complex_Solutions.Solution_List;
                topdim : in natural32; zerotol : in double_float ) is

    use QuadDobl_Complex_Laur_Systems;
    use QuadDobl_Complex_Solutions;

    timer : Timing_Widget;
    wsols,sols0,sols1 : Solution_List;
    n : constant natural32 := natural32(ep'last)-topdim;
    pocotime : duration;
    embsys : Array_of_Laur_Sys(0..integer32(topdim));
    pathcnts : Standard_Natural_VecVecs.VecVec(embsys'range);

  begin
    tstart(timer);
    embsys(integer32(topdim)) := new Laur_Sys'(ep);
    for i in 0..topdim-1 loop
      embsys(integer32(i)) := new Laur_Sys'(Remove_Embedding1(ep,topdim-i));
    end loop;
    Filter_and_Split_Solutions
      (outfile,sols,integer32(n),integer32(topdim),zerotol,sols0,sols1);
    Update_Path_Counts
      (pathcnts,topdim,Length_Of(sols),Length_Of(sols0),Length_Of(sols1));
    Write_Witness_Superset(name,ep,sols0,topdim);
    if not Is_Null(sols1) then
      Copy(sols1,wsols);
      for i in reverse 1..integer32(topdim) loop
        Clear(sols0); Clear(sols1);
        Down_Continuation
          (outfile,nt,embsys(i).all,natural32(i),zerotol,
           wsols,sols0,sols1,pocotime);
        Update_Path_Counts
          (pathcnts,natural32(i-1),
           Length_Of(wsols),Length_Of(sols0),Length_Of(sols1));
        if i = 1 then
          if not Is_Null(sols1) then
            declare
              rsols1 : constant Solution_List := Remove_Component(sols1);
            begin
              Write_Witness_Superset(name,embsys(i-1).all,rsols1,0);
            end;
          end if;
        elsif not Is_Null(sols0) then
          declare
            rsols0 : constant Solution_List := Remove_Component(sols0);
          begin
            Write_Witness_Superset(name,embsys(i-1).all,rsols0,natural32(i-1));
          end;
        end if;
        Clear(wsols);
        exit when Is_Null(sols1);
        wsols := Remove_Component(sols1);
      end loop;
      Clear(sols0);
    end if;
    tstop(timer);
    Write_Path_Counts(outfile,pathcnts);
    new_line(outfile);
    print_times(outfile,timer,"Witness Generate with Cascade of Homotopies");
    new_line(outfile);
    Write_Seed_Number(outfile);
    put_line(outfile,Greeting_Banners.Version);
  end Witness_Generate;

end Cascade_Homotopies;
