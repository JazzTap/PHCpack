with text_io;                            use text_io;
with Communications_with_User;           use Communications_with_User;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;        use Standard_Integer_Numbers_io;
with Standard_Complex_Polynomials;
with Standard_Complex_Poly_Systems;
with Standard_Complex_Solutions;
with Standard_System_and_Solutions_io;
with DoblDobl_Complex_Polynomials;
with DoblDobl_Complex_Poly_Systems;
with DoblDobl_Complex_Solutions;
with DoblDobl_System_and_Solutions_io;
with QuadDobl_Complex_Polynomials;
with QuadDobl_Complex_Poly_Systems;
with QuadDobl_Complex_Solutions;
with QuadDobl_System_and_Solutions_io;
with Standard_Dense_Series_VecVecs;
with DoblDobl_Dense_Series_VecVecs;
with QuadDobl_Dense_Series_VecVecs;
with Standard_Series_Poly_Systems;
with DoblDobl_Series_Poly_Systems;
with QuadDobl_Series_Poly_Systems;
with Series_and_Polynomials;
with Series_and_Solutions;
with Power_Series_Methods;              use Power_Series_Methods;

procedure ts_sersol is

-- DESCRIPTION :
--   Test on the development of series as solutions of polynomial systems.

  procedure Run_Newton
             ( nq,idx : in integer32; echelon : in boolean;
               p : in Standard_Complex_Poly_Systems.Poly_Sys;
               s : in Standard_Complex_Solutions.Solution_List ) is

  -- DESCRIPTION :
  --   The coordinates of the solution vectors in s are the leading
  --   coefficients in a power series solution to p.
  --   Newton's method is performed in standard double precision.

  -- ON ENTRY :
  --   nq      number of equations in p;
  --   idx     index to the series parameter;
  --   echelon is the flag for the echelon Newton's method to be used;
  --   p       a polynomial of nq equations in nv unknowns;
  --   s       a list of solutions.

    use Standard_Complex_Solutions;

    len : constant integer32 := integer32(Length_Of(s));
    dim : constant integer32 := Head_Of(s).n - 1;
    srv : constant Standard_Dense_Series_VecVecs.VecVec(1..len)
        := Series_and_Solutions.Create(s,idx);
    srp : Standard_Series_Poly_Systems.Poly_Sys(p'range)
        := Series_and_Polynomials.System_to_Series_System(p,idx);
    nbrit : integer32 := 0;

  begin
    new_line;
    put("Number of coordinates in the series : "); put(dim,1); put_line(".");
    new_line;
    put("Give the number of steps in Newton's method : ");
    get(nbrit); new_line;
    if echelon then
      put_line("Echelon Newton will be applied.");
      Run_Echelon_Newton(nbrit,srp,srv,true,true);
    else
      if nq = dim then
        put_line("LU Newton will be applied.");
        Run_LU_Newton(nbrit,srp,srv,true,true);
      else
        put_line("QR Newton will be applied.");
        Run_QR_Newton(nbrit,srp,srv,true,true);
      end if;
    end if;
    Standard_Series_Poly_Systems.Clear(srp);
  end Run_Newton;

  procedure Run_Newton
             ( nq,idx : in integer32; echelon : in boolean;
               p : in DoblDobl_Complex_Poly_Systems.Poly_Sys;
               s : in DoblDobl_Complex_Solutions.Solution_List ) is

  -- DESCRIPTION :
  --   The coordinates of the solution vectors in s are the leading
  --   coefficients in a power series solution to p.
  --   Newton's method is performed in double double precision.

  -- ON ENTRY :
  --   nq      number of equations in p;
  --   idx     index to the series parameter;
  --   echelon flag to indicate if the echelon Newton is to be used;
  --   p       a polynomial of nq equations in nv unknowns;
  --   s       a list of solutions.

    use DoblDobl_Complex_Solutions;

    len : constant integer32 := integer32(Length_Of(s));
    dim : constant integer32 := Head_Of(s).n - 1;
    srv : constant DoblDobl_Dense_Series_VecVecs.VecVec(1..len)
        := Series_and_Solutions.Create(s,idx);
    srp : DoblDobl_Series_Poly_Systems.Poly_Sys(p'range)
        := Series_and_Polynomials.System_to_Series_System(p,idx);
    nbrit : integer32 := 0;

  begin
    new_line;
    put("Number of coordinates in the series : "); put(dim,1); put_line(".");
    new_line;
    put("Give the number of steps in Newton's method : ");
    get(nbrit); new_line;
    if echelon then
      put_line("Echelon Newton will be applied.");
      Run_Echelon_Newton(nbrit,srp,srv,true,true);
    else
      if nq = dim then
        put_line("LU Newton will be applied.");
        Run_LU_Newton(nbrit,srp,srv,true,true);
      else
        put_line("QR Newton will be applied.");
        Run_QR_Newton(nbrit,srp,srv,true,true);
      end if;
    end if;
    DoblDobl_Series_Poly_Systems.Clear(srp);
  end Run_Newton;

  procedure Run_Newton
             ( nq,idx : in integer32; echelon : in boolean;
               p : in QuadDobl_Complex_Poly_Systems.Poly_Sys;
               s : in QuadDobl_Complex_Solutions.Solution_List ) is

  -- DESCRIPTION :
  --   The coordinates of the solution vectors in s are the leading
  --   coefficients in a power series solution to p.
  --   Newton's method is performed in quad double precision.

  -- ON ENTRY :
  --   nq      number of equations in p;
  --   idx     index to the series parameter;
  --   echelon flag to indicate if echelon Newton is to be used;
  --   p       a polynomial of nq equations in nv unknowns;
  --   s       a list of solutions.

    use QuadDobl_Complex_Solutions;

    len : constant integer32 := integer32(Length_Of(s));
    dim : constant integer32 := Head_Of(s).n - 1;
    srv : constant QuadDobl_Dense_Series_VecVecs.VecVec(1..len)
        := Series_and_Solutions.Create(s,idx);
    srp : QuadDobl_Series_Poly_Systems.Poly_Sys(p'range)
        := Series_and_Polynomials.System_to_Series_System(p,idx);
    nbrit : integer32 := 0;

  begin
    new_line;
    put("Number of coordinates in the series : "); put(dim,1); put_line(".");
    new_line;
    put("Give the number of steps in Newton's method : ");
    get(nbrit); new_line;
    if echelon then
      put_line("Echelon Newton will be applied.");
      Run_Echelon_Newton(nbrit,srp,srv,true,true);
    else
      if nq = dim then
        put_line("LU Newton will be applied.");
        Run_LU_Newton(nbrit,srp,srv,true,true);
      else
        put_line("QR Newton will be applied.");
        Run_QR_Newton(nbrit,srp,srv,true,true);
      end if;
    end if;
    QuadDobl_Series_Poly_Systems.Clear(srp);
  end Run_Newton;

  procedure Standard_Test ( echelon : in boolean ) is

  -- DESCRIPTION :
  --   Performs a test in standard double precision,
  --   prompting the user for a system and its solutions.

    use Standard_Complex_Polynomials;
    use Standard_Complex_Poly_Systems;
    use Standard_Complex_Solutions;

    lp : Link_to_Poly_Sys;
    nq,nv,idx : integer32 := 0;
    sols : Solution_List;

  begin
    new_line;
    put_line("Reading the file name for a system and solutions ...");
    Standard_System_and_Solutions_io.get(lp,sols);
    new_line;
    nq := lp'last;
    nv := integer32(Number_of_Unknowns(lp(lp'first)));
    put("Read a system of "); put(nq,1);
    put(" equations in "); put(nv,1); put_line(" unknowns.");
    put("Read "); put(integer32(Length_Of(sols)),1); put_line(" solutions.");
    new_line;
    put("Give the index of the parameter : "); get(idx);
    Run_Newton(nq,idx,echelon,lp.all,sols);
  end Standard_Test;

  procedure DoblDobl_Test ( echelon : in boolean ) is

  -- DESCRIPTION :
  --   Performs a test in double double precision,
  --   prompting the user for a system and its solutions.

    use DoblDobl_Complex_Polynomials;
    use DoblDobl_Complex_Poly_Systems;
    use DoblDobl_Complex_Solutions;

    lp : Link_to_Poly_Sys;
    nq,nv,idx : integer32 := 0;
    sols : Solution_List;

  begin
    new_line;
    put_line("Reading the file name for a system and solutions ...");
    DoblDobl_System_and_Solutions_io.get(lp,sols);
    new_line;
    nq := lp'last;
    nv := integer32(Number_of_Unknowns(lp(lp'first)));
    put("Read a system of "); put(nq,1);
    put(" equations in "); put(nv,1); put_line(" unknowns.");
    put("Read "); put(integer32(Length_Of(sols)),1); put_line(" solutions.");
    new_line;
    put("Give the index of the parameter : "); get(idx);
    Run_Newton(nq,idx,echelon,lp.all,sols);
  end DoblDobl_Test;

  procedure QuadDobl_Test ( echelon : in boolean ) is

  -- DESCRIPTION :
  --   Performs a test in quad double precision,
  --   prompting the user for a system and its solutions.

    use QuadDobl_Complex_Polynomials;
    use QuadDobl_Complex_Poly_Systems;
    use QuadDobl_Complex_Solutions;

    lp : Link_to_Poly_Sys;
    nq,nv,idx : integer32 := 0;
    sols : Solution_List;

  begin
    new_line;
    put_line("Reading the file name for a system and solutions ...");
    QuadDobl_System_and_Solutions_io.get(lp,sols);
    new_line;
    nq := lp'last;
    nv := integer32(Number_of_Unknowns(lp(lp'first)));
    put("Read a system of "); put(nq,1);
    put(" equations in "); put(nv,1); put_line(" unknowns.");
    put("Read "); put(integer32(Length_Of(sols)),1); put_line(" solutions.");
    new_line;
    put("Give the index of the parameter : "); get(idx);
    Run_Newton(nq,idx,echelon,lp.all,sols);
  end QuadDobl_Test;

  procedure Main is

  -- DESCRIPTION :
  --   Prompts the user to select the working precision
  --   and then launches the corresponding test.

    prc,ans : character;
    echelon : boolean;

  begin
    new_line;
    put_line("MENU to select the working precision :");
    put_line("  0. standard double precision;");
    put_line("  1. double double precision;");
    put_line("  2. quad double precision.");
    put("Type 0, 1, or 2 to select the working precision : ");
    Ask_Alternative(prc,"012");
    new_line;
    put("Use the lower triangular echelon form ? (y/n) ");
    Ask_Yes_or_No(ans);
    echelon := (ans = 'y');
    case prc is
      when '0' => Standard_Test(echelon);
      when '1' => DoblDobl_Test(echelon);
      when '2' => QuadDobl_Test(echelon);
      when others => null;
    end case;
  end Main;

begin
  Main;
end ts_sersol;
