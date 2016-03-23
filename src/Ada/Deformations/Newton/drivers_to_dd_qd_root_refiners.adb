with text_io;                            use text_io;
with Communications_with_User;           use Communications_with_User;
with Timing_Package;                     use Timing_Package;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Complex_Laur_Systems;
with Multprec_Complex_Laurentials_io;
with Multprec_Complex_Laur_Systems;
with DoblDobl_Polynomial_Convertors;     use DoblDobl_Polynomial_Convertors;
with DoblDobl_Complex_Laurentials;       use DoblDobl_Complex_Laurentials;
with DoblDobl_Complex_Poly_Systems;
with DoblDobl_Complex_Poly_Systems_io;   use DoblDobl_Complex_Poly_Systems_io;
with DoblDobl_Complex_Laur_Systems_io;   use DoblDobl_Complex_Laur_Systems_io;
with DoblDobl_Laur_Poly_Convertors;
with QuadDobl_Complex_Laurentials;       use QuadDobl_Complex_Laurentials;
with QuadDobl_Complex_Laur_Systems_io;   use QuadDobl_Complex_Laur_Systems_io;
with QuadDobl_Polynomial_Convertors;     use QuadDobl_Polynomial_Convertors;
with QuadDobl_Complex_Poly_Systems;
with QuadDobl_Laur_Poly_Convertors;
with Standard_Complex_Solutions;
with DoblDobl_Complex_Solutions_io;
with QuadDobl_Complex_Solutions_io;
with Multprec_Complex_Solutions;
with Standard_System_and_Solutions_io;
with Multprec_System_and_Solutions_io;
with Root_Refining_Parameters;           use Root_Refining_Parameters;
with DoblDobl_Root_Refiners;             use DoblDobl_Root_Refiners;
with QuadDobl_Root_Refiners;             use QuadDobl_Root_Refiners;

package body Drivers_to_dd_qd_Root_Refiners is

  procedure Standard_to_DoblDobl_Complex
              ( p : out DoblDobl_Complex_Laur_Systems.Link_to_Laur_Sys;
                s : out DoblDobl_Complex_Solutions.Solution_List ) is

    q : Standard_Complex_Laur_Systems.Link_to_Laur_Sys;
    sols : Standard_Complex_Solutions.Solution_List;

  begin
    Standard_System_and_Solutions_io.get(q,sols);
    declare
      sq : constant DoblDobl_Complex_Laur_Systems.Laur_Sys
         := Standard_Laur_Sys_to_DoblDobl_Complex(q.all);
    begin
      p := new DoblDobl_Complex_Laur_Systems.Laur_Sys'(sq);
    end;
    s := DoblDobl_Complex_Solutions.Create(sols);
  end Standard_to_DoblDobl_Complex;

  procedure Multprec_to_DoblDobl_Complex
              ( p : out DoblDobl_Complex_Laur_Systems.Link_to_Laur_Sys;
                s : out DoblDobl_Complex_Solutions.Solution_List ) is

    q : Multprec_Complex_Laur_Systems.Link_to_Laur_Sys;
    sols : Multprec_Complex_Solutions.Solution_List;

  begin
    Multprec_Complex_Laurentials_io.Set_Working_Precision(5);
    Multprec_System_and_Solutions_io.get(q,sols);
    declare
      sq : constant DoblDobl_Complex_Laur_Systems.Laur_Sys
         := Multprec_Laur_Sys_to_DoblDobl_Complex(q.all);
    begin
      p := new DoblDobl_Complex_Laur_Systems.Laur_Sys'(sq);
    end;
    s := DoblDobl_Complex_Solutions.Create(sols);
  end Multprec_to_DoblDobl_Complex;

  procedure Standard_to_QuadDobl_Complex
              ( p : out QuadDobl_Complex_Laur_Systems.Link_to_Laur_Sys;
                s : out QuadDobl_Complex_Solutions.Solution_List ) is

    q : Standard_Complex_Laur_Systems.Link_to_Laur_Sys;
    sols : Standard_Complex_Solutions.Solution_List;

  begin
    Standard_System_and_Solutions_io.get(q,sols);
    declare
      sq : constant QuadDobl_Complex_Laur_Systems.Laur_Sys
         := Standard_Laur_Sys_to_QuadDobl_Complex(q.all);
    begin
      p := new QuadDobl_Complex_Laur_Systems.Laur_Sys'(sq);
    end;
    s := QuadDobl_Complex_Solutions.Create(sols);
  end Standard_to_QuadDobl_Complex;

  procedure Multprec_to_QuadDobl_Complex
              ( p : out QuadDobl_Complex_Laur_Systems.Link_to_Laur_Sys;
                s : out QuadDobl_Complex_Solutions.Solution_List ) is

    q : Multprec_Complex_Laur_Systems.Link_to_Laur_Sys;
    sols : Multprec_Complex_Solutions.Solution_List;

  begin
    Multprec_Complex_Laurentials_io.Set_Working_Precision(10);
    Multprec_System_and_Solutions_io.get(q,sols);
    declare
      sq : constant QuadDobl_Complex_Laur_Systems.Laur_Sys
         := Multprec_Laur_Sys_to_QuadDobl_Complex(q.all);
    begin
      p := new QuadDobl_Complex_Laur_Systems.Laur_Sys'(sq);
    end;
    s := QuadDobl_Complex_Solutions.Create(sols);
  end Multprec_to_QuadDobl_Complex;

  procedure DD_Root_Refinement is

  -- DESCRIPTION :
  --   Driver dedicated to refining in double double precision.

    timer : Timing_Widget;
    file : file_type;
    dd_p : DoblDobl_Complex_Laur_Systems.Link_to_Laur_Sys;
    dd_s : DoblDobl_Complex_Solutions.Solution_List;
    nbeq,nvar : natural32;
    epsxa,epsfa,tolsing : double_float;
    numit,maxit : natural32 := 0;
    deflate,wout : boolean;

  begin
    Multprec_to_DoblDobl_Complex(dd_p,dd_s);
    new_line;
    put_line("Reading the name of the output file ...");
    Read_Name_and_Create_File(file);
    nvar := Number_of_Unknowns(dd_p(dd_p'first));
    nbeq := natural32(dd_p'last);
    if nbeq = nvar
     then put(file,nbeq,dd_p.all);
     else put(file,nbeq,nvar,dd_p.all);
    end if;
    DoblDobl_Default_Root_Refining_Parameters
      (epsxa,epsfa,tolsing,maxit,deflate,wout);
    Standard_Menu_Root_Refining_Parameters
      (file,epsxa,epsfa,tolsing,maxit,deflate,wout);
    new_line; put("Refining "); 
    put(DoblDobl_Complex_Solutions.Length_Of(dd_s),1);
    put(" solutions ...");
    put_line(" see the output file for results."); new_line;
    if DoblDobl_Laur_Poly_Convertors.Is_Genuine_Laurent(dd_p.all) then
      tstart(timer);
     -- DoblDobl_Root_Refiner(dd_p.all,dd_s);
      Reporting_Root_Refiner -- no deflate for Laurent systems yet
        (file,dd_p.all,dd_s,epsxa,epsfa,tolsing,numit,maxit,wout);
      tstop(timer);
    else
      declare
        use DoblDobl_Laur_Poly_Convertors;         
        q : DoblDobl_Complex_Poly_Systems.Poly_Sys(dd_p'range)
          := Laurent_to_Polynomial_System(dd_p.all);
      begin
        tstart(timer);
       -- DoblDobl_Root_Refiner(q,dd_s);
        Reporting_Root_Refiner
          (file,q,dd_s,epsxa,epsfa,tolsing,numit,maxit,deflate,wout);
        tstop(timer);
      end;
    end if;
   -- DoblDobl_Complex_Solutions_io.write(file,dd_s);
    new_line(file);
    print_times(file,timer,"double double Newton refinement");
    close(file);
  end DD_Root_Refinement;

  procedure QD_Root_Refinement is

  -- DESCRIPTION :
  --   Driver dedicated to root refinement in quad double precision.

    timer : Timing_Widget;
    file : file_type;
    qd_p : QuadDobl_Complex_Laur_Systems.Link_to_Laur_Sys;
    qd_s : QuadDobl_Complex_Solutions.Solution_List;
    nbeq,nvar : natural32;
    epsxa,epsfa,tolsing : double_float;
    numit,maxit : natural32 := 0;
    deflate,wout : boolean;

  begin
    Multprec_to_QuadDobl_Complex(qd_p,qd_s);
    new_line;
    put_line("Reading the name of the output file ...");
    Read_Name_and_Create_File(file);
    nvar := Number_of_Unknowns(qd_p(qd_p'first));
    nbeq := natural32(qd_p'last);
    if nbeq = nvar
     then put(file,nbeq,qd_p.all);
     else put(file,nbeq,nvar,qd_p.all);
    end if;
    QuadDobl_Default_Root_Refining_Parameters
      (epsxa,epsfa,tolsing,maxit,deflate,wout);
    Standard_Menu_Root_Refining_Parameters
      (file,epsxa,epsfa,tolsing,maxit,deflate,wout);
    new_line; put("Refining "); 
    put(QuadDobl_Complex_Solutions.Length_Of(qd_s),1);
    put(" solutions ...");
    put_line(" see the output file for results."); new_line;
    if QuadDobl_Laur_Poly_Convertors.Is_Genuine_Laurent(qd_p.all) then
      tstart(timer);
     -- QuadDobl_Root_Refiner(qd_p.all,qd_s);
      Reporting_Root_Refiner  -- no deflation for Laurent systems yet
        (file,qd_p.all,qd_s,epsxa,epsfa,tolsing,numit,maxit,wout);
      tstop(timer);
    else
      declare
        use QuadDobl_Laur_Poly_Convertors;         
        q : QuadDobl_Complex_Poly_Systems.Poly_Sys(qd_p'range)
          := Laurent_to_Polynomial_System(qd_p.all);
      begin
        tstart(timer);
       -- QuadDobl_Root_Refiner(q,qd_s);
        Reporting_Root_Refiner
          (file,q,qd_s,epsxa,epsfa,tolsing,numit,maxit,deflate,wout);
        tstop(timer);
      end;
    end if;
   -- QuadDobl_Complex_Solutions_io.write(file,qd_s);
    new_line(file);
    print_times(file,timer,"quad double Newton refinement");
    close(file);
  end QD_Root_Refinement;

  procedure DD_QD_Root_Refinement is

    ans : character;

  begin
    new_line;
    put_line("MENU for Newton in double double or quad double arithmetic :");
    put_line("  1. use complex double double arithmetic;");
    put_line("  2. use complex quad double arithmetic.");
    put("Type 1 or 2 to make a choice : ");
    Ask_Alternative(ans,"12");
    if ans = '1'
     then DD_Root_Refinement;
     else QD_Root_Refinement;
    end if;
  end DD_QD_Root_Refinement;

end Drivers_to_dd_qd_Root_Refiners;
