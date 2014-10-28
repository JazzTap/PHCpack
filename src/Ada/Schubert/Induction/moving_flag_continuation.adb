with Communications_with_User;          use Communications_with_User;
with Standard_Natural_Numbers;          use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;       use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers_io;       use Standard_Integer_Numbers_io;
with Standard_Floating_Numbers_io;      use Standard_Floating_Numbers_io;
with Standard_Complex_Numbers;          use Standard_Complex_Numbers;
with Standard_Natural_Vectors_io;       use Standard_Natural_Vectors_io;
with Standard_Natural_Matrices;
with Standard_Natural_Matrices_io;      use Standard_Natural_Matrices_io;
with Standard_Complex_Vectors_io;       use Standard_Complex_Vectors_io;
with Standard_Complex_Matrices_io;      use Standard_Complex_Matrices_io;
with Standard_Complex_Norms_Equals;     use Standard_Complex_Norms_Equals;
with Symbol_Table;
with Matrix_Indeterminates;
with Standard_Complex_Poly_SysFun;      use Standard_Complex_Poly_SysFun;
with Standard_Complex_Poly_Matrices;
with Standard_Complex_Poly_Matrices_io; use Standard_Complex_Poly_Matrices_io;
with Standard_Homotopy;
with Standard_Complex_Solutions_io;     use Standard_Complex_Solutions_io;
with Standard_Root_Refiners;            use Standard_Root_Refiners;
with Standard_IncFix_Continuation;
with Drivers_for_Poly_Continuation;     use Drivers_for_Poly_Continuation;
with Brackets;
with Checker_Boards_io;
with Checker_Moves;
with Checker_Posets_io;
with Checker_Localization_Patterns;
with Checker_Homotopies;
with Moving_Flag_Homotopies;            use Moving_Flag_Homotopies;

package body Moving_Flag_Continuation is

-- AUXILIARIES :

  function Create ( x : Standard_Complex_Vectors.Vector ) return Solution is

  -- DESCRIPTION :
  --   Returns the solution representation of the vector x.

    res : Solution(x'last-1);

  begin
    res.t := x(x'last);
    res.m := 1;
    res.v := x(x'first..x'last-1);
    res.err := 0.0;
    res.rco := 1.0;
    res.res := 0.0;
    return res;
  end Create;

  function Create ( x : Standard_Complex_Vectors.Vector ) 
                  return Solution_List is

  -- DESCRIPTION :
  --   Returns the solution list representation of the vector x.

    sol : constant Solution(x'last-1) := Create(x);
    res : Solution_List;

  begin
    Add(res,sol);
    return res;
  end Create;

-- TARGET ROUTINES :

  procedure Set_Parameters ( file : in file_type; report : out boolean ) is

    oc : natural32;

  begin
    new_line;
    Driver_for_Continuation_Parameters(file);
    new_line;
    Driver_for_Process_io(file,oc);
    report := not (oc = 0);
    new_line;
    put_line("No more input expected.  See output file for results...");
    new_line;
    new_line(file);
  end Set_Parameters;

  procedure Call_Path_Trackers
              ( n : in integer32; h : in Poly_Sys;
                xt : in out Standard_Complex_Vectors.Vector;
                sol : out Link_to_Solution ) is

    use Standard_IncFix_Continuation;

    sols : Solution_List := Create(xt);

    procedure Track is
      new Silent_Continue(Max_Norm,Standard_Homotopy.Eval,
                          Standard_Homotopy.Diff,Standard_Homotopy.Diff);

  begin
    Standard_Homotopy.Create(h,n+1);
    Track(sols,false,Create(1.0));
    xt(xt'first..xt'last-1) := Head_Of(sols).v;
    xt(xt'last) := Head_Of(sols).t;
    sol := Head_Of(sols);
    Standard_Homotopy.Clear;
  exception -- adding this exception handler caused no longer exception ...
    when others => put_line("exception in Call Path Trackers"); raise;
  end Call_Path_Trackers;

  procedure Call_Path_Trackers
              ( file : in file_type; n : in integer32; h : in Poly_Sys;
                xt : in out Standard_Complex_Vectors.Vector;
                sol : out Link_to_Solution ) is

    use Standard_IncFix_Continuation;

    sols : Solution_List := Create(xt);

    procedure Track is
      new Reporting_Continue(Max_Norm,Standard_Homotopy.Eval,
                             Standard_Homotopy.Diff,Standard_Homotopy.Diff);

  begin
    Standard_Homotopy.Create(h,n+1);
    Track(file,sols,false,Create(1.0));
    xt(xt'first..xt'last-1) := Head_Of(sols).v;
    xt(xt'last) := Head_Of(sols).t;
    sol := Head_Of(sols);
    Standard_Homotopy.Clear;
  exception -- adding this exception handler caused no longer exception ...
    when others => put_line("exception in Call Path Trackers"); raise;
  end Call_Path_Trackers;

  procedure Call_Path_Trackers
              ( file : in file_type; n : in integer32; h : in Poly_Sys;
                xtsols,sols : in out Solution_List ) is

    use Standard_IncFix_Continuation;

    xtp,tmp : Solution_List;
    xtls,ls : Link_to_Solution;

    procedure Track is
      new Reporting_Continue(Max_Norm,Standard_Homotopy.Eval,
                             Standard_Homotopy.Diff,Standard_Homotopy.Diff);

  begin
    Standard_Homotopy.Create(h,n+1);
    Track(file,xtsols,false,Create(1.0));
    tmp := sols;
    xtp := xtsols;
    put_line(file,"In Call_Path_Trackers ...");
    put(file,"Number of solutions in sols   : ");
    put(file,Length_Of(sols),1); new_line(file);
    put(file,"Number of solutions in xtsols : ");
    put(file,Length_Of(xtsols),1); new_line(file);
    while not Is_Null(xtp) loop
      xtls := Head_Of(xtp);
      ls := Head_Of(tmp);
      ls.v := xtls.v(ls.v'range);
      ls.t := xtls.t;
      Set_Head(tmp,ls);
      tmp := Tail_Of(tmp);
      xtp := Tail_Of(xtp);
    end loop;
    Standard_Homotopy.Clear;
  exception -- adding this exception handler caused no longer exception ...
    when others => put_line("exception in Call Path Trackers"); raise;
  end Call_Path_Trackers;

  procedure Call_Path_Trackers
              ( n : in integer32; h : in Poly_Sys;
                xtsols,sols : in out Solution_List ) is

    use Standard_IncFix_Continuation;

    xtp,tmp : Solution_List;
    xtls,ls : Link_to_Solution;

    procedure Track is
      new Silent_Continue(Max_Norm,Standard_Homotopy.Eval,
                          Standard_Homotopy.Diff,Standard_Homotopy.Diff);

  begin
    Standard_Homotopy.Create(h,n+1);
    Track(xtsols,false,Create(1.0));
    tmp := sols;
    xtp := xtsols;
    while not Is_Null(xtp) loop
      xtls := Head_Of(xtp);
      ls := Head_Of(tmp);
      ls.v := xtls.v(ls.v'range);
      ls.t := xtls.t;
      Set_Head(tmp,ls);
      tmp := Tail_Of(tmp);
      xtp := Tail_Of(xtp);
    end loop;
    Standard_Homotopy.Clear;
  exception -- adding this exception handler caused no longer exception ...
    when others => put_line("exception in Call Path Trackers"); raise;
  end Call_Path_Trackers;

  procedure Track_First_Move
              ( file : in file_type;
                n : in integer32; h : in Poly_Sys; tol : in double_float;
                sol : in out Link_to_Solution; fail : out boolean ) is

    x : Standard_Complex_Vectors.Vector(1..n);
    xt : Standard_Complex_Vectors.Vector(1..n+1);
    y : Standard_Complex_Vectors.Vector(h'range);
    res : double_float;
    sh : Poly_Sys(1..n) := Square(n,h);
    yh : Standard_Complex_Vectors.Vector(sh'range);
    sh0 : Poly_Sys(sh'range);
    sols : Solution_List;
    epsxa : constant double_float := 1.0E-12;
    tolsing : constant double_float := tol;
    epsfa : constant double_float := 1.0E-12;
    numit : natural32 := 0;
    deflate : boolean := false;

  begin
    Start_Solution(h,fail,x,res);
    if fail then
      put_line(file,"no start solution found...");
    else
      new_line(file);
      put(file,"The residual of the start solution : ");
      put(file,res,3); new_line(file);
      xt(x'range) := x; xt(xt'last) := Create(0.0);
      yh := Eval(sh,xt);
      put_line(file,"Value of the start solution at the squared homotopy :");
      put_line(file,yh);
      sols := Create(xt);
      if sol = null then
        put_line(file,"In Track_First_Move, sol is null.");
      else
        put_line(file,"In Track_First_Move, the solution on input :");
        put(file,sol.all); new_line(file);
      end if;
      put_line(file,"The start solution in Track_First_Move : ");
      put(file,Head_Of(sols).all); new_line(file);
      sh0 := Eval(sh,Create(0.0),n+1);
      Reporting_Root_Refiner
        (file,sh0,sols,epsxa,epsfa,tolsing,numit,3,deflate,false);
      Clear(sh0); --Clear(sols);
      Call_Path_Trackers(file,n,sh,xt,sol);
      put(file,"The residual of the end solution : ");
      y := Eval(h,xt); res := Max_Norm(y);
      put(file,res,3); new_line(file); new_line(file);
      fail := (res > epsfa);
    end if;
    Standard_Complex_Poly_Systems.Clear(sh);
  exception
    when others => put_line("exception in Track_First_Move"); raise;
  end Track_First_Move;

  procedure Track_Next_Move
              ( file : in file_type;
                n : in integer32; h : in Poly_Sys; tol : in double_float;
                sol : in out Link_to_Solution; fail : out boolean ) is

    xt : Standard_Complex_Vectors.Vector(1..n+1);
    y : Standard_Complex_Vectors.Vector(h'range);
    res : double_float;
    sh : Poly_Sys(1..n) := Square(n,h);
    yh : Standard_Complex_Vectors.Vector(sh'range);
    sh0 : Poly_Sys(sh'range);
    sols : Solution_List;
    epsxa : constant double_float := 1.0E-12;
    tolsing : constant double_float := tol;
    epsfa : constant double_float := 1.0E-12;
    numit : natural32 := 0;
    deflate : boolean := false;

  begin
    xt(sol.v'range) := sol.v; xt(xt'last) := Create(0.0);
    y := Eval(h,xt);
    new_line(file);
    put_line(file,"Value of the start solution at the original homotopy :");
    put_line(file,y);
    res := Max_Norm(y);
    put(file,"The residual : "); put(file,res,3); new_line(file);
    fail := (res > tolsing);
    yh := Eval(sh,xt);
    put_line(file,"Value of the start solution at the squared homotopy :");
    put_line(file,yh);
    res := Max_Norm(y);
    put(file,"The residual : "); put(file,res,3); new_line(file);
    fail := fail and (res > tolsing);
    if fail then
      put_line(file,"-> residual too high, abort path tracking");
    else
      sols := Create(xt);
      sh0 := Eval(sh,Create(0.0),n+1);
      Reporting_Root_Refiner
        (file,sh0,sols,epsxa,epsfa,tolsing,numit,3,deflate,false);
      Call_Path_Trackers(file,n,sh,xt,sol);
      put(file,"The residual of the end solution at original homotopy : ");
      y := Eval(h,xt); res := Max_Norm(y);
      put(file,res,3); new_line(file); new_line(file);
      fail := (res > tolsing);
    end if;
    Clear(sh); Clear(sh0); --Clear(sols);
  exception
    when others => put_line("exception in Track_Next_Move ..."); raise;
  end Track_Next_Move;

  procedure Track_Next_Move
              ( file : in file_type;
                n : in integer32; h : in Poly_Sys; tol : in double_float;
                sols : in out Solution_List; fail : out boolean ) is

    xt : Standard_Complex_Vectors.Vector(1..n+1);
    y : Standard_Complex_Vectors.Vector(h'range);
    res : double_float;
    sh : Poly_Sys(1..n) := Square(n,h);
    yh : Standard_Complex_Vectors.Vector(sh'range);
    sh0 : Poly_Sys(sh'range);
    epsxa : constant double_float := 1.0E-12;
    tolsing : constant double_float := tol;
    epsfa : constant double_float := 1.0E-12;
    numit : natural32 := 0;
    deflate : boolean := false;
    tmp : Solution_List := sols;
    ls : Link_to_Solution;
    xtsols,xt_sols_last : Solution_List;

  begin
    while not Is_Null(tmp) loop
      ls := Head_Of(tmp);
      xt(ls.v'range) := ls.v; xt(xt'last) := Create(0.0);
      y := Eval(h,xt);
      new_line(file);
      put_line(file,"Value of the start solution at the original homotopy :");
      put_line(file,y);
      res := Max_Norm(y);
      put(file,"The residual : "); put(file,res,3); new_line(file);
      fail := (res > tolsing);
      yh := Eval(sh,xt);
      put_line(file,"Value of the start solution at the squared homotopy :");
      put_line(file,yh);
      res := Max_Norm(y);
      put(file,"The residual : "); put(file,res,3); new_line(file);
      fail := fail and (res > tolsing);
      Append(xtsols,xt_sols_last,Create(xt));
      tmp := Tail_Of(tmp);
    end loop;
    if fail then
      put_line(file,"-> residual too high, abort path tracking");
    else
      sh0 := Eval(sh,Create(0.0),n+1);
      Reporting_Root_Refiner
        (file,sh0,xtsols,epsxa,epsfa,tolsing,numit,3,deflate,false);
      put(file,"Number of solutions in xtsols : ");
      put(file,Length_Of(xtsols),1); new_line(file);
      put(file,"Number of solutions in sols   : ");
      put(file,Length_Of(sols),1); new_line(file);
      Call_Path_Trackers(file,n,sh,xtsols,sols);
      tmp := xtsols;
      Clear(sh0);
      sh0 := Eval(sh,Create(1.0),n+1);
      while not Is_Null(tmp) loop
        ls := Head_Of(tmp);
        put(file,"The residual of the end solution at squared homotopy  :");
        yh := Eval(sh0,ls.v); res := Max_Norm(yh);
        put(file,res,3); new_line(file);
        put_line(file,"Evaluating the end solution at the original homotopy :");
        declare
          xt : Standard_Complex_Vectors.Vector(ls.v'first..ls.v'last+1);
        begin
          xt(ls.v'range) := ls.v;
          xt(xt'last) := ls.t;
          y := Eval(h,xt);
        end;
        put_line(file,y);
        put(file,"The residual of the end solution at original homotopy :");
        res := Max_Norm(y);
        put(file,res,3); new_line(file);
        fail := (res > tolsing);
        tmp := Tail_Of(tmp);
      end loop;
    end if;
    Clear(sh); Clear(sh0); --Clear(sols);
  exception
    when others => put_line("exception in Track_Next_Move ..."); raise;
  end Track_Next_Move;

  procedure Track_Next_Move
              ( n : in integer32; h : in Poly_Sys; tol : in double_float;
                sols : in out Solution_List; fail : out boolean ) is

    xt : Standard_Complex_Vectors.Vector(1..n+1);
    sh : Poly_Sys(1..n) := Square(n,h);
    tmp : Solution_List := sols;
    ls : Link_to_Solution;
    xtsols,xt_sols_last : Solution_List;

  begin
    fail := false;
    while not Is_Null(tmp) loop
      ls := Head_Of(tmp);
      xt(ls.v'range) := ls.v;
      xt(xt'last) := Create(0.0);
      fail := fail and (ls.res > tol);
      Append(xtsols,xt_sols_last,Create(xt));
      tmp := Tail_Of(tmp);
    end loop;
    if not fail then
      Call_Path_Trackers(n,sh,xtsols,sols);
      tmp := xtsols;
      while not Is_Null(tmp) loop
        ls := Head_Of(tmp);
        declare
          xt : Standard_Complex_Vectors.Vector(ls.v'first..ls.v'last+1);
        begin
          xt(ls.v'range) := ls.v;
          xt(xt'last) := ls.t;
        end;
        fail := fail and (ls.res > tol);
        tmp := Tail_Of(tmp);
      end loop;
    end if;
    Clear(sh);
  exception
    when others => put_line("exception in Track_Next_Move ..."); raise;
  end Track_Next_Move;

  procedure Initialize_Symbol_Table
              ( n,k : in integer32;
                q,rows,cols : in Standard_Natural_Vectors.Vector;
                dim : out integer32 ) is

  -- DESCRIPTION :
  --   Uses the localization pattern to initialize the symbol table.
  --   On return in dim is the number of free variables.

    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,q,rows,cols);

  begin
    dim := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));
    if not Symbol_Table.Empty
     then Symbol_Table.Clear;
    end if;
  end Initialize_Symbol_Table;

  procedure Generalizing_Homotopy
              ( file : in file_type; n,k : in integer32;
                q,p,rows,cols : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf,nf : in Standard_Complex_Matrices.Matrix;
                h : out Link_to_Poly_Sys; dim : out integer32 ) is

   -- f : constant natural := Checker_Moves.Falling_Checker(p);
   -- a : constant natural := Checker_Moves.Ascending_Checker(p,f);
   -- t : Standard_Natural_Matrices.Matrix(1..n,1..n)
   --   := Checker_Localization_Patterns.Transformation(n,q(f));
   -- m : Standard_Natural_Matrices.Matrix(1..n,1..n)
   --   := Checker_Localization_Patterns.Moving_Flag(p);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,p,rows,cols);
        -- rows and cols must be rows and cols with p, not with q!
        --   := Checker_Localization_Patterns.Column_Pattern(n,k,q,rows,cols);
        -- must use q (current) not p (previous)

  begin
   -- Checker_Boards_io.Write_Permutation(file,p,rows,cols,m,t);
    dim := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));
   -- put(file,"The degree of freedom of the localization map : ");
   -- put(file,dim,1); new_line(file);
    if not Symbol_Table.Empty
     then Symbol_Table.Clear;
    end if;
    Initialize_Homotopy_Symbols(natural32(dim),locmap);
    if cond'last = 1 then
      declare
        c : constant Brackets.Bracket(1..k)
          := Brackets.Bracket(cond(cond'first).all);
      begin
        One_Flag_Homotopy(file,n,k,q,p,rows,cols,c,vf(vf'first).all,mf,nf,h);
      end;
    else
      Moving_Flag_Homotopy(file,n,k,q,p,rows,cols,cond,vf,mf,nf,h);
    end if;
    put(file,"The moving flag homotopy has ");
    put(file,h'last,1); put(file," equations in ");
    put(file,dim,1); put_line(file,"+1 unknowns ..."); -- put(file,h.all);
  end Generalizing_Homotopy;

  procedure Generalizing_Homotopy
              ( n,k : in integer32;
                q,p,rows,cols : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf,nf : in Standard_Complex_Matrices.Matrix;
                h : out Link_to_Poly_Sys; dim : out integer32 ) is

   -- f : constant natural := Checker_Moves.Falling_Checker(p);
   -- a : constant natural := Checker_Moves.Ascending_Checker(p,f);
   -- t : Standard_Natural_Matrices.Matrix(1..n,1..n)
   --   := Checker_Localization_Patterns.Transformation(n,q(f));
   -- m : Standard_Natural_Matrices.Matrix(1..n,1..n)
   --   := Checker_Localization_Patterns.Moving_Flag(p);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,p,rows,cols);
        -- rows and cols must be rows and cols with p, not with q!
        --   := Checker_Localization_Patterns.Column_Pattern(n,k,q,rows,cols);
        -- must use q (current) not p (previous)

  begin
    dim := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));
    if cond'last = 1 then
      declare
        c : constant Brackets.Bracket(1..k)
          := Brackets.Bracket(cond(cond'first).all);
      begin
        One_Flag_Homotopy(n,k,q,p,rows,cols,c,vf(vf'first).all,mf,nf,h);
      end;
    else
      Moving_Flag_Homotopy(n,k,q,p,rows,cols,cond,vf,mf,nf,h);
    end if;
  end Generalizing_Homotopy;

  procedure Verify_Intersection_Conditions
              ( file : in file_type; n,k : in integer32;
                q,rows,cols : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                x : in Standard_Complex_Vectors.Vector ) is

    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,q,rows,cols);
    dim : natural32;
    f : Link_to_Poly_Sys;

  begin
    dim := Checker_Localization_Patterns.Degree_of_Freedom(locmap);
    if not Symbol_Table.Empty
     then Symbol_Table.Clear;
    end if;
    Matrix_Indeterminates.Initialize_Symbols(dim,locmap);
   -- note: p and parameters mf and nf needed for this call ...
   -- Flag_Conditions(file,n,k,q,p,rows,cols,cond,vf,mf,nf,f);
    Flag_Conditions(n,k,q,rows,cols,cond,mf,vf,f);
    put(file,"At q = "); put(file,q);
    put(file,"  rows = "); put(file,rows);
    put(file,"  cols = "); put(file,cols); new_line(file);
    put_line(file,"Verification of intersection conditions :");
    put_line(file,"The moving flag : ");
    Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
    declare
      z : Standard_Complex_Vectors.Vector(x'range);
      fail : boolean;
      res : double_float;
      y : constant Standard_Complex_Vectors.Vector(f'range) := Eval(f.all,x);
    begin
      put_line(file,"The given solution :"); put_line(file,x);
      put_line(file,"The value of the given solution :"); put_line(file,y);
      First_Solution(f.all,fail,z,res);
      if fail then
        put_line(file,"failed to recompute the solution");
      else
        put_line(file,"The recomputed solution :"); put_line(file,z);
        put(file,"with residual :"); put(file,res,3); new_line(file);
      end if;
    end;
   -- Clear(f); -- executing this Clear(f) results in a crash ...
  exception
    when others => put_line("exception in verify_intersection conditions");
                   raise;
  end Verify_Intersection_Conditions;

  procedure Verify_Intersection_Conditions
              ( file : in file_type; n,k : in integer32;
                q,rows,cols : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                sols : in Solution_List;
                tol : in double_float; fail : out boolean ) is

    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,q,rows,cols);
    dim : natural32;
    f : Link_to_Poly_Sys;
    tmp : Solution_List := sols;
    ls : Link_to_Solution;

  begin
    dim := Checker_Localization_Patterns.Degree_of_Freedom(locmap);
    if not Symbol_Table.Empty
     then Symbol_Table.Clear;
    end if;
    Matrix_Indeterminates.Initialize_Symbols(dim,locmap);
   -- note: p and parameters mf and nf needed for this call ...
   -- Flag_Conditions(file,n,k,q,p,rows,cols,cond,vf,mf,nf,f);
    Flag_Conditions(n,k,q,rows,cols,cond,mf,vf,f);
    put(file,"At q = "); put(file,q);
    put(file,"  rows = "); put(file,rows);
    put(file,"  cols = "); put(file,cols); new_line(file);
    put_line(file,"Verification of intersection conditions :");
    put_line(file,"The moving flag : ");
    Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
    fail := true; -- assume all solutions are failures
    while not Is_Null(tmp) loop
      ls := Head_Of(tmp);
      declare
        res : double_float;
        y : constant Standard_Complex_Vectors.Vector(f'range)
          := Eval(f.all,ls.v);
      begin
        put_line(file,"The given solution :"); put_line(file,ls.v);
        put_line(file,"The value of the given solution :"); put_line(file,y);
        res := Max_Norm(y);
        put(file,"The residual : "); put(file,res,3); new_line(file);
        if fail
         then fail := (res > tol); -- no fail as soon as one succeeds
        end if;
      end;
      tmp := Tail_Of(tmp);
    end loop;
   -- Clear(f); -- executing this Clear(f) results in a crash ...
  exception
    when others => put_line("exception in verify_intersection conditions");
                   raise;
  end Verify_Intersection_Conditions;

  procedure Copy_Flags ( src : in Standard_Complex_VecMats.VecMat;
                         dst : in out Standard_Complex_VecMats.VecMat ) is
  begin
    for i in src'range loop
      declare
        A : constant Standard_Complex_Matrices.Link_to_Matrix := src(i);
      begin
        dst(i) := new Standard_Complex_Matrices.Matrix'(A.all);
      end;
    end loop;
  end Copy_Flags;

  procedure Trivial_Stay
              ( file : in file_type; n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                ls : in out Link_to_Solution; fail : out boolean ) is

    gh : Link_to_Poly_Sys;
    dim : constant integer32
        := integer32(Checker_Localization_Patterns.Degree_of_Freedom(q,qr,qc));
    x : Standard_Complex_Vectors.Vector(1..dim);
    res : double_float;

  begin
    fail := false;
    if ind = 0 then
      Flag_Conditions(n,k,q,qr,qc,cond,vf,gh);
      First_Solution(gh.all,fail,x,res);
      put_line(file,"The first solution :"); put_line(file,x);
      put(file,"Residual of first solution : "); put(file,res,3);
      if fail then
        put_line(file," failed first solution.");
      else
        put_line(file," found first solution.");
        declare
          sol : Solution(dim);
        begin
          sol.t := Create(0.0); sol.m := 1; sol.v := x;
          sol.err := 0.0; sol.res := res; sol.rco := 1.0;
          ls := new Solution'(sol);
        end;
      end if;
    end if;
    if not fail then
      put(file,"Transforming solution planes with critical row = ");
      put(file,ctr,1); put_line(file,".");
      Checker_Homotopies.Trivial_Stay_Coordinates
        (file,n,k,ctr,q,p,qr,qc,pr,pc,ls.v);
      put_line(file,"Verifying after coordinate changes ...");
      Verify_Intersection_Conditions(file,n,k,q,qr,qc,cond,mf,vf,ls.v);
    end if;
    Clear(gh);
  end Trivial_Stay;

  procedure Trivial_Stay
              ( file : in file_type; n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                sols : in out Solution_List;
                tol : in double_float; fail : out boolean ) is
  begin
    put(file,"Transforming solution planes with critical row = ");
    put(file,ctr,1); put_line(file,".");
    put_line(file,"The solution given to the Trivial_Stay_Coordinates : ");
    put(file,Length_Of(sols),natural32(Head_Of(sols).n),sols);
    Checker_Homotopies.Trivial_Stay_Coordinates
      (file,n,k,ctr,q,p,qr,qc,pr,pc,sols);
    put_line(file,"Verifying after coordinate changes ...");
    Verify_Intersection_Conditions(file,n,k,q,qr,qc,cond,mf,vf,sols,tol,fail);
  end Trivial_Stay;

  procedure Trivial_Stay
              ( n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                sols : in out Solution_List; fail : out boolean ) is
  begin
    fail := false; -- no checks anymore ...
    Checker_Homotopies.Trivial_Stay_Coordinates
      (n,k,ctr,q,p,qr,qc,pr,pc,sols);
  end Trivial_Stay;

  procedure Stay_Homotopy
              ( file : in file_type; n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf,start_mf : in Standard_Complex_Matrices.Matrix;
                ls : in out Link_to_Solution; 
                tol : in double_float; fail : out boolean ) is

    gh : Link_to_Poly_Sys;
    xp : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k)
       := Checker_Homotopies.Stay_Moving_Plane(n,k,ctr,p,pr,pc);
    xpm : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,q,qr,qc);
    dim : constant integer32
        := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));

  begin
    fail := true;
    Initialize_Homotopy_Symbols(natural32(dim),locmap);
    put_line(file,"The moving coordinates : "); put(file,xp);
    put_line(file,"the new moving flag when making the stay homotopy :");
    Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
    put_line(file,"the old moving flag when making the stay homotopy :");
    Moving_Flag_Homotopies.Write_Moving_Flag(file,start_mf);
    xpm := Moving_Flag(start_mf,xp);
    put_line(file,"The moving coordinates after multiplication by M :");
    put(file,xpm);
    Flag_Conditions(n,k,xpm,cond,vf,gh);
    if ind = 0
     then Track_First_Move(file,dim,gh.all,tol,ls,fail);
     else Track_Next_Move(file,dim,gh.all,tol,ls,fail);
    end if;
    if not fail then
      put(file,"Transforming solution planes with critical row = ");
      put(file,ctr,1); put_line(file,".");
      Checker_Homotopies.Homotopy_Stay_Coordinates
        (file,n,k,ctr,q,qr,qc,mf,xpm,ls.v);
      put_line(file,"Verifying after coordinate changes ...");
      Verify_Intersection_Conditions(file,n,k,q,qr,qc,cond,mf,vf,ls.v);
    end if;
    Standard_Complex_Poly_Matrices.Clear(xp);
    Standard_Complex_Poly_Matrices.Clear(xpm);
    Clear(gh);
  exception
    when others => put_line("exception in Stay_Homotopy"); raise;
  end Stay_Homotopy;

  procedure Stay_Homotopy
              ( file : in file_type; n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf,start_mf : in Standard_Complex_Matrices.Matrix;
                sols : in out Solution_List;
                tol : in double_float; fail : out boolean ) is

    gh : Link_to_Poly_Sys;
    xp : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k)
       := Checker_Homotopies.Stay_Moving_Plane(n,k,ctr,p,pr,pc);
    xpm : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,q,qr,qc);
    dim : constant integer32
        := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));

  begin
    fail := true;
    Initialize_Homotopy_Symbols(natural32(dim),locmap);
    put_line(file,"The moving coordinates : "); put(file,xp);
    put_line(file,"the new moving flag when making the stay homotopy :");
    Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
    put_line(file,"the old moving flag when making the stay homotopy :");
    Moving_Flag_Homotopies.Write_Moving_Flag(file,start_mf);
    xpm := Moving_Flag(start_mf,xp);
    put_line(file,"The moving coordinates after multiplication by M :");
    put(file,xpm);
    Flag_Conditions(n,k,xpm,cond,vf,gh);
    Track_Next_Move(file,dim,gh.all,tol,sols,fail);
    if not fail then
      put(file,"Transforming solution planes with critical row = ");
      put(file,ctr,1); put_line(file,".");
      Checker_Homotopies.Homotopy_Stay_Coordinates
        (file,n,k,ctr,q,qr,qc,mf,xpm,sols);
      put_line(file,"Verifying after coordinate changes ...");
      Verify_Intersection_Conditions
        (file,n,k,q,qr,qc,cond,mf,vf,sols,tol,fail);
    end if;
    Standard_Complex_Poly_Matrices.Clear(xp);
    Standard_Complex_Poly_Matrices.Clear(xpm);
    Clear(gh);
  exception
    when others => put_line("exception in Stay_Homotopy"); raise;
  end Stay_Homotopy;

  procedure Stay_Homotopy
              ( n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf,start_mf : in Standard_Complex_Matrices.Matrix;
                sols : in out Solution_List;
                tol : in double_float; fail : out boolean ) is

    gh : Link_to_Poly_Sys;
    xp : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k)
       := Checker_Homotopies.Stay_Moving_Plane(n,k,ctr,p,pr,pc);
    xpm : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,q,qr,qc);
    dim : constant integer32
        := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));

  begin
    fail := true;
    xpm := Moving_Flag(start_mf,xp);
    Flag_Conditions(n,k,xpm,cond,vf,gh);
    Track_Next_Move(dim,gh.all,tol,sols,fail);
    if not fail then
      Checker_Homotopies.Homotopy_Stay_Coordinates
        (n,k,ctr,q,qr,qc,mf,xpm,sols);
    end if;
    Standard_Complex_Poly_Matrices.Clear(xp);
    Standard_Complex_Poly_Matrices.Clear(xpm);
    Clear(gh);
  exception
    when others => put_line("exception in Stay_Homotopy"); raise;
  end Stay_Homotopy;

  procedure Swap_Homotopy
              ( file : in file_type; n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf,start_mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                ls : in out Link_to_Solution;
                tol : in double_float; fail : out boolean ) is

    big_r : constant integer32 := Checker_Homotopies.Swap_Checker(q,qr,qc);
    dc : constant integer32 := Checker_Moves.Descending_Checker(q);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,p,pr,pc);
    s : constant integer32 := Checker_Homotopies.Swap_Column(ctr,locmap);
    xp : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k)
       := Checker_Homotopies.Swap_Moving_Plane(file,n,k,ctr,big_r,s,q,p,pr,pc);
    xpm : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k);
    dim : constant integer32
        := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));
    gh : Link_to_Poly_Sys;

  begin
    Initialize_Homotopy_Symbols(natural32(dim),locmap);
    put_line(file,"The moving coordinates : "); put(file,xp); 
    xpm := Moving_Flag(start_mf,xp);
    put_line(file,"The moving coordinates after multiplication by M :");
    put(file,xpm);
    fail := true;
    Flag_Conditions(n,k,xpm,cond,vf,gh);
    if ind = 0
     then Track_First_Move(file,dim,gh.all,tol,ls,fail);
     else Track_Next_Move(file,dim,gh.all,tol,ls,fail);
    end if;
    if not fail then
      put(file,"Transforming solution planes with critical row = ");
      put(file,ctr,1); put_line(file,".");
      if big_r > ctr + 1
       then Checker_Homotopies.First_Swap_Coordinates
              (file,n,k,ctr,big_r,dc,s,q,p,qr,qc,pr,pc,mf,xpm,ls.v);
       else Checker_Homotopies.Second_Swap_Coordinates
              (file,n,k,ctr,s,q,qr,qc,mf,xpm,ls.v);
      end if;
      put_line(file,"Verifying after coordinate changes ...");
      Verify_Intersection_Conditions(file,n,k,q,qr,qc,cond,mf,vf,ls.v);
    end if;
    Standard_Complex_Poly_Systems.Clear(gh);
    Standard_Complex_Poly_Matrices.Clear(xp);
    Standard_Complex_Poly_Matrices.Clear(xpm);
  exception
    when others => put_line("exception in Swap_Homotopy"); raise;
  end Swap_Homotopy;

  procedure Swap_Homotopy
              ( file : in file_type; n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf,start_mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                sols : in out Solution_List;
                tol : in double_float; fail : out boolean ) is

    big_r : constant integer32 := Checker_Homotopies.Swap_Checker(q,qr,qc);
    dc : constant integer32 := Checker_Moves.Descending_Checker(q);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,p,pr,pc);
    s : constant integer32 := Checker_Homotopies.Swap_Column(ctr,locmap);
    xp : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k)
       := Checker_Homotopies.Swap_Moving_Plane(file,n,k,ctr,big_r,s,q,p,pr,pc);
    xpm : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k);
    dim : constant integer32
        := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));
    gh : Link_to_Poly_Sys;

  begin
    Initialize_Homotopy_Symbols(natural32(dim),locmap);
    put_line(file,"The moving coordinates : "); put(file,xp); 
    xpm := Moving_Flag(start_mf,xp);
    put_line(file,"The moving coordinates after multiplication by M :");
    put(file,xpm);
    fail := true;
    Flag_Conditions(n,k,xpm,cond,vf,gh);
    Track_Next_Move(file,dim,gh.all,tol,sols,fail);
    if not fail then
      put(file,"Transforming solution planes with critical row = ");
      put(file,ctr,1); put_line(file,".");
      if big_r > ctr + 1
       then Checker_Homotopies.First_Swap_Coordinates
              (file,n,k,ctr,big_r,dc,s,q,p,qr,qc,pr,pc,mf,xpm,sols);
       else Checker_Homotopies.Second_Swap_Coordinates
              (file,n,k,ctr,s,q,qr,qc,mf,xpm,sols);
      end if;
      put_line(file,"Verifying after coordinate changes ...");
      Verify_Intersection_Conditions
        (file,n,k,q,qr,qc,cond,mf,vf,sols,tol,fail);
    end if;
    Standard_Complex_Poly_Systems.Clear(gh);
    Standard_Complex_Poly_Matrices.Clear(xp);
    Standard_Complex_Poly_Matrices.Clear(xpm);
  exception
    when others => put_line("exception in Swap_Homotopy"); raise;
  end Swap_Homotopy;

  procedure Swap_Homotopy
              ( n,k,ctr,ind : in integer32;
                q,p,qr,qc,pr,pc : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                mf,start_mf : in Standard_Complex_Matrices.Matrix;
                vf : in Standard_Complex_VecMats.VecMat;
                sols : in out Solution_List;
                tol : in double_float; fail : out boolean ) is

    big_r : constant integer32 := Checker_Homotopies.Swap_Checker(q,qr,qc);
    dc : constant integer32 := Checker_Moves.Descending_Checker(q);
    locmap : constant Standard_Natural_Matrices.Matrix(1..n,1..k)
           := Checker_Localization_Patterns.Column_Pattern(n,k,p,pr,pc);
    s : constant integer32 := Checker_Homotopies.Swap_Column(ctr,locmap);
    xp : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k)
       := Checker_Homotopies.Swap_Moving_Plane(n,k,ctr,big_r,s,q,p,pr,pc);
    xpm : Standard_Complex_Poly_Matrices.Matrix(1..n,1..k);
    dim : constant integer32
        := integer32(Checker_Localization_Patterns.Degree_of_Freedom(locmap));
    gh : Link_to_Poly_Sys;

  begin
    xpm := Moving_Flag(start_mf,xp);
    fail := true;
    Flag_Conditions(n,k,xpm,cond,vf,gh);
    Track_Next_Move(dim,gh.all,tol,sols,fail);
    if not fail then
      if big_r > ctr + 1
       then Checker_Homotopies.First_Swap_Coordinates
              (n,k,ctr,big_r,dc,s,q,p,qr,qc,pr,pc,mf,xpm,sols);
       else Checker_Homotopies.Second_Swap_Coordinates
              (n,k,ctr,s,q,qr,qc,mf,xpm,sols);
      end if;
    end if;
    Standard_Complex_Poly_Systems.Clear(gh);
    Standard_Complex_Poly_Matrices.Clear(xp);
    Standard_Complex_Poly_Matrices.Clear(xpm);
  exception
    when others => put_line("exception in Swap_Homotopy"); raise;
  end Swap_Homotopy;

  procedure Track_Path_in_Poset
              ( file : in file_type; n,k : in integer32; ps : in Poset;
                path : in Array_of_Nodes; count : in integer32;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf : in out Standard_Complex_Matrices.Matrix;
                ls : in out Link_to_Solution; unhappy : out boolean ) is

    leaf : constant Link_to_Node := path(path'first);
    ip : constant Standard_Natural_Vectors.Vector(1..n) 
       := Checker_Moves.Identity_Permutation(natural32(n));
    p,q : Standard_Natural_Vectors.Vector(1..n);
    pr,pc,qr,qc : Standard_Natural_Vectors.Vector(1..k);
    cnd : constant Standard_Natural_Vectors.Vector(1..k)
        := cond(cond'first).all;
    t : Standard_Natural_Matrices.Matrix(1..n,1..n);
    start_mf : Standard_Complex_Matrices.Matrix(1..n,1..n) := Identity(n);
    dim,ptr,homtp,ctr,ind,fc : integer32;
    stay_child : boolean;
    fail : boolean := false;
    tol : constant double_float := 1.0E-6;

    use Standard_Complex_Matrices;

  begin
    new_line(file);
    if not Checker_Moves.Happy_Checkers(ip,leaf.cols,cnd) then
      put(file,"No tracking for path "); put(file,count,1);
      put(file," because "); Checker_Posets_io.Write(file,leaf.cols,cnd);
      put_line(file," is not happy.");
      unhappy := true;
    else
      unhappy := false;
      put(file,"Tracking path "); put(file,count,1);
      put(file," in poset starting at a happy ");
      Checker_Posets_io.Write(file,leaf.cols,cnd); put_line(file," ...");
      p := ps.black(ps.black'last).all;
      pr := leaf.rows; pc := leaf.cols;
      for i in path'first+1..path'last loop
        ptr := ps.black'last - i + 1;
        p := ps.black(ptr+1).all; pr := path(i-1).rows; pc := path(i-1).cols;
        q := ps.black(ptr).all; qr := path(i).rows; qc := path(i).cols;
        Checker_Posets_io.Write_Node_in_Path(file,n,k,ps,path,i);
        stay_child := Checker_Posets.Is_Stay_Child(path(i).all,path(i-1).all);
        fc := Checker_Moves.Falling_Checker(p);
        put(file,"Calling Transformation with index = ");
        put(file,integer32(q(fc)),1);
        put(file," where fc = "); put(file,fc,1);
        put(file," and q = "); put(file,q); new_line(file);
        t := Checker_Localization_Patterns.Transformation(n,integer32(q(fc)));
        put_line(file,"The pattern t for the numerical transformation ");
        put(file,t);
        put_line(file,"The numerical transformation :");
        Write_Moving_Flag(file,Numeric_Transformation(t));
        put_line(file,"The moving flag before the update :");
        Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
        start_mf := mf;
        mf := mf*Numeric_Transformation(t);
        put_line(file,"The moving flag after the update :");
        Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
        Checker_Homotopies.Define_Generalizing_Homotopy
           (file,n,q,qr,qc,stay_child,homtp,ctr);
        Initialize_Symbol_Table(n,k,q,qr,qc,dim);
        ind := i-path'first-1; -- ind = 0 signals start solution
        if homtp = 0 then
          Trivial_Stay
            (file,n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,mf,vf,ls,fail);
        elsif homtp = 1 then
          Stay_Homotopy(file,n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,
                        vf,mf,start_mf,ls,tol,fail);
        else -- homtp = 2
          Moving_Flag_Homotopies.Add_t_Symbol;
          Swap_Homotopy(file,n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,
                        mf,start_mf,vf,ls,tol,fail);
        end if;
        if fail then
          put_line(file,"no longer a valid solution, abort tracking");
          new_line(file);
          exit;
        end if;
      end loop;
    end if;
  end Track_Path_in_Poset;

  procedure Track_Path_in_Poset
              ( file : in file_type; n,k : in integer32; ps : in Poset;
                path : in Array_of_Nodes; count : in integer32;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf : in out Standard_Complex_Matrices.Matrix;
                start : in Solution_List; sols : out Solution_List;
                unhappy : out boolean ) is

    leaf : constant Link_to_Node := path(path'first);
    ip : constant Standard_Natural_Vectors.Vector(1..n) 
       := Checker_Moves.Identity_Permutation(natural32(n));
    p,q : Standard_Natural_Vectors.Vector(1..n);
    pr,pc,qr,qc : Standard_Natural_Vectors.Vector(1..k);
    cnd : constant Standard_Natural_Vectors.Vector(1..k)
        := cond(cond'first).all;
    t : Standard_Natural_Matrices.Matrix(1..n,1..n);
    start_mf : Standard_Complex_Matrices.Matrix(1..n,1..n) := Identity(n);
    dim,ptr,homtp,ctr,ind,fc : integer32;
    stay_child : boolean;
    fail : boolean := false;
    tol : constant double_float := 1.0E-6;

    use Standard_Complex_Matrices;

  begin
    new_line(file);
    if not Checker_Moves.Happy_Checkers(ip,leaf.cols,cnd) then
      put(file,"No tracking for path "); put(file,count,1);
      put(file," because "); Checker_Posets_io.Write(file,leaf.cols,cnd);
      put_line(file," is not happy.");
      unhappy := true;
    else
      if Is_Null(start) then
        put_line(file,"No start solutions ?  Abort track path in poset.");
        return;
      else
        put(file,"In track path in poset, number of start solutions : ");
        put(file,Length_Of(start),1); put_line(file,".");
        put_line(file,"THE START SOLUTIONS :");
        put(file,Length_Of(start),natural32(Head_Of(start).n),start);
      end if;
      unhappy := false;
      put(file,"Tracking path "); put(file,count,1);
      put(file," in poset starting at a happy ");
      Checker_Posets_io.Write(file,leaf.cols,cnd); put_line(file," ...");
      p := ps.black(ps.black'last).all;
      pr := leaf.rows; pc := leaf.cols;
      Copy(start,sols);
      for i in path'first+1..path'last loop
        ptr := ps.black'last - i + 1;
        p := ps.black(ptr+1).all; pr := path(i-1).rows; pc := path(i-1).cols;
        q := ps.black(ptr).all; qr := path(i).rows; qc := path(i).cols;
        Checker_Posets_io.Write_Node_in_Path(file,n,k,ps,path,i);
        stay_child := Checker_Posets.Is_Stay_Child(path(i).all,path(i-1).all);
        fc := Checker_Moves.Falling_Checker(p);
        put(file,"Calling Transformation with index = ");
        put(file,integer32(q(fc)),1);
        put(file," where fc = "); put(file,fc,1);
        put(file," and q = "); put(file,q); new_line(file);
        t := Checker_Localization_Patterns.Transformation(n,integer32(q(fc)));
        put_line(file,"The pattern t for the numerical transformation ");
        put(file,t);
        put_line(file,"The numerical transformation :");
        Write_Moving_Flag(file,Numeric_Transformation(t));
        put_line(file,"The moving flag before the update :");
        Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
        start_mf := mf;
        mf := mf*Numeric_Transformation(t);
        put_line(file,"The moving flag after the update :");
        Moving_Flag_Homotopies.Write_Moving_Flag(file,mf);
        Checker_Homotopies.Define_Generalizing_Homotopy
          (file,n,q,qr,qc,stay_child,homtp,ctr);
        Initialize_Symbol_Table(n,k,q,qr,qc,dim);
        ind := i-path'first-1; -- ind = 0 signals start solution
        if homtp = 0 then
          Trivial_Stay
            (file,n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,mf,vf,sols,tol,fail);
        elsif homtp = 1 then
          Stay_Homotopy(file,n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,
                        vf,mf,start_mf,sols,tol,fail);
        else -- homtp = 2
          Moving_Flag_Homotopies.Add_t_Symbol;
          Swap_Homotopy(file,n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,
                        mf,start_mf,vf,sols,tol,fail);
        end if;
        if fail then
          put_line(file,"no longer a valid solution, abort tracking");
          new_line(file);
          unhappy := true; -- prevent from being concatenated
          exit;
        end if;
      end loop;
    end if;
  end Track_Path_in_Poset;

  procedure Track_Path_in_Poset
              ( n,k : in integer32; ps : in Poset;
                path : in Array_of_Nodes; count : in integer32;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                mf : in out Standard_Complex_Matrices.Matrix;
                start : in Solution_List; sols : out Solution_List;
                unhappy : out boolean ) is

    leaf : constant Link_to_Node := path(path'first);
    ip : constant Standard_Natural_Vectors.Vector(1..n) 
       := Checker_Moves.Identity_Permutation(natural32(n));
    p,q : Standard_Natural_Vectors.Vector(1..n);
    pr,pc,qr,qc : Standard_Natural_Vectors.Vector(1..k);
    cnd : constant Standard_Natural_Vectors.Vector(1..k)
        := cond(cond'first).all;
    t : Standard_Natural_Matrices.Matrix(1..n,1..n);
    start_mf : Standard_Complex_Matrices.Matrix(1..n,1..n) := Identity(n);
    ptr,homtp,ctr,ind,fc : integer32;
    stay_child : boolean;
    fail : boolean := false;
    tol : constant double_float := 1.0E-6;

    use Standard_Complex_Matrices;

  begin
    if not Checker_Moves.Happy_Checkers(ip,leaf.cols,cnd) then
      unhappy := true;
    else
      if Is_Null(start) then
        return;
      end if;
      unhappy := false;
      p := ps.black(ps.black'last).all;
      pr := leaf.rows; pc := leaf.cols;
      Copy(start,sols);
      for i in path'first+1..path'last loop
        ptr := ps.black'last - i + 1;
        p := ps.black(ptr+1).all; pr := path(i-1).rows; pc := path(i-1).cols;
        q := ps.black(ptr).all; qr := path(i).rows; qc := path(i).cols;
        stay_child := Checker_Posets.Is_Stay_Child(path(i).all,path(i-1).all);
        fc := Checker_Moves.Falling_Checker(p);
        t := Checker_Localization_Patterns.Transformation(n,integer32(q(fc)));
        start_mf := mf;
        mf := mf*Numeric_Transformation(t);
        Checker_Homotopies.Define_Generalizing_Homotopy
          (n,q,qr,qc,stay_child,homtp,ctr);
        ind := i-path'first-1; -- ind = 0 signals start solution
        if homtp = 0 then
          Trivial_Stay
            (n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,mf,vf,sols,fail);
        elsif homtp = 1 then
          Stay_Homotopy(n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,
                        vf,mf,start_mf,sols,tol,fail);
        else -- homtp = 2
          Swap_Homotopy(n,k,ctr,ind,q,p,qr,qc,pr,pc,cond,
                        mf,start_mf,vf,sols,tol,fail);
        end if;
        if fail then
          unhappy := true; -- prevent from being concatenated
          exit;
        end if;
      end loop;
    end if;
  end Track_Path_in_Poset;

  procedure Track_All_Paths_in_Poset
              ( file : in file_type; n,k : in integer32; ps : in Poset;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                sols : out Solution_List ) is

    cnt : integer32 := 0;
    sols_last : Solution_List := sols;

    procedure Track_Path ( nds : in Array_of_Nodes; ct : out boolean ) is

      mf : Standard_Complex_Matrices.Matrix(1..n,1..n) := Identity(n);
      ls : Link_to_Solution;
      fail : boolean;

    begin
      cnt := cnt + 1;
      Track_Path_in_Poset(file,n,k,ps,nds,cnt,cond,vf,mf,ls,fail);
      if not fail
       then Append(sols,sols_last,ls.all);
      end if;
      ct := true;
    end Track_Path;
    procedure Enumerate_Paths is new Enumerate_Paths_in_Poset(Track_Path);

  begin
    Enumerate_Paths(ps);
  end Track_All_Paths_in_Poset;

  procedure Track_All_Paths_in_Poset
              ( file : in file_type; n,k : in integer32; ps : in Poset;
                child : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                start : in Solution_List; sols : out Solution_List ) is

    cnt : integer32 := 0;
    sols_last : Solution_List := sols;

    procedure Track_Path ( nds : in Array_of_Nodes; ct : out boolean ) is

      mf : Standard_Complex_Matrices.Matrix(1..n,1..n) := Identity(n);
      pp_sols : Solution_List; -- solutions on path in poset
      fail : boolean;
      leaf : constant Standard_Natural_Vectors.Vector := nds(nds'first).cols;

    begin
      cnt := cnt + 1;
      new_line(file);
      put(file,"Examining match for path "); put(file,cnt,1);
      put_line(file," ...");
      put(file,"-> leaf : "); put(file,leaf);
      put(file,"  child : "); put(file,child);
      if not Standard_Natural_Vectors.Equal(leaf,child) then
        put(file," no match, skip path "); put(file,cnt,1); new_line(file);
      else
        put(file," match at path "); put(file,cnt,1); new_line(file);
        Track_Path_in_Poset(file,n,k,ps,nds,cnt,cond,vf,mf,start,pp_sols,fail);
        if not fail
         then Concat(sols,sols_last,pp_sols);
        end if;
      end if;
      ct := true;
    end Track_Path;
    procedure Enumerate_Paths is new Enumerate_Paths_in_Poset(Track_Path);

  begin
    Enumerate_Paths(ps);
  end Track_All_Paths_in_Poset;

  procedure Track_All_Paths_in_Poset
              ( n,k : in integer32; ps : in Poset;
                child : in Standard_Natural_Vectors.Vector;
                cond : in Standard_Natural_VecVecs.VecVec;
                vf : in Standard_Complex_VecMats.VecMat;
                start : in Solution_List; sols : out Solution_List ) is

    cnt : integer32 := 0;
    sols_last : Solution_List := sols;

    procedure Track_Path ( nds : in Array_of_Nodes; ct : out boolean ) is

      mf : Standard_Complex_Matrices.Matrix(1..n,1..n) := Identity(n);
      pp_sols : Solution_List; -- solutions on path in poset
      fail : boolean;
      leaf : constant Standard_Natural_Vectors.Vector := nds(nds'first).cols;

    begin
      cnt := cnt + 1;
      if Standard_Natural_Vectors.Equal(leaf,child) then
        Track_Path_in_Poset(n,k,ps,nds,cnt,cond,vf,mf,start,pp_sols,fail);
        if not fail
         then Concat(sols,sols_last,pp_sols);
        end if;
      end if;
      ct := true;
    end Track_Path;
    procedure Enumerate_Paths is new Enumerate_Paths_in_Poset(Track_Path);

  begin
    Enumerate_Paths(ps);
  end Track_All_Paths_in_Poset;

end Moving_Flag_Continuation;
