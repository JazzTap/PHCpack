with Timing_Package;                    use Timing_Package;
with Standard_Natural_Numbers_io;       use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers_io;       use Standard_Integer_Numbers_io;
with Standard_Floating_Numbers;         use Standard_Floating_Numbers;
with Standard_Complex_Numbers;          use Standard_Complex_Numbers;
with Standard_Random_Numbers;           use Standard_Random_Numbers;
with Standard_Complex_Vectors_io;       use Standard_Complex_Vectors_io;
with Standard_Complex_VecVecs;          use Standard_Complex_VecVecs;
with Standard_Random_Vectors;           use Standard_Random_Vectors;
with Standard_Complex_Norms_Equals;     use Standard_Complex_Norms_Equals;
with Standard_Random_Matrices;
with Standard_Natural_Vectors;
with Symbol_Table;
with Standard_Complex_Polynomials;      use Standard_Complex_Polynomials;
with Standard_Complex_Poly_Systems_io;  use Standard_Complex_Poly_Systems_io;
with Standard_Complex_Poly_SysFun;      use Standard_Complex_Poly_SysFun;
with Standard_Complex_Jaco_Matrices;    use Standard_Complex_Jaco_Matrices;
with Standard_Complex_Solutions_io;     use Standard_Complex_Solutions_io;
with Standard_Condition_Tables;         use Standard_Condition_Tables;
with Standard_Homotopy;
with Standard_Continuation_Data;        use Standard_Continuation_Data;
with Standard_IncFix_Continuation;      use Standard_IncFix_Continuation;
with Continuation_Parameters;           use Continuation_Parameters;
with Witness_Sets,Witness_Sets_io;      use Witness_Sets;
with Planes_and_Polynomials;            use Planes_and_Polynomials;
with Standard_Plane_Representations;    use Standard_Plane_Representations;
with Standard_Point_Coordinates;        use Standard_Point_Coordinates;
with Standard_Moving_Planes;            use Standard_Moving_Planes;
with Standard_Plane_Operations;         use Standard_Plane_Operations;
with Standard_Cascading_Planes;         use Standard_Cascading_Planes;
with Standard_Solution_Splitters;       use Standard_Solution_Splitters;
with Standard_Diagonal_Polynomials;     use Standard_Diagonal_Polynomials;
with Standard_Diagonal_Solutions;       use Standard_Diagonal_Solutions;
with Extrinsic_Diagonal_Homotopies;     use Extrinsic_Diagonal_Homotopies;
with Extrinsic_Diagonal_Homotopies_io;

package body Extrinsic_Diagonal_Continuation is

  sia_size : constant natural32 := 20000;

-- AUXILIARIES :

  procedure Extrinsic_Track_Paths
              ( file : in file_type; report : in boolean;
                p,q : in Poly_Sys; 
                sols : in out Solution_List ) is

    timer : Timing_Widget;
    gamma : constant Complex_Number := Random1;
    target : constant Complex_Number := Create(1.0);

    procedure R_Cont is
      new Reporting_Continue(Max_Norm,
                             Standard_Homotopy.Eval,
                             Standard_Homotopy.Diff,
                             Standard_Homotopy.Diff);

    procedure S_Cont is
      new Silent_Continue(Max_Norm,
                          Standard_Homotopy.Eval,
                          Standard_Homotopy.Diff,
                          Standard_Homotopy.Diff);
  begin
    Set_Continuation_Parameter(sols,Create(0.0));
    Standard_Homotopy.Create(p,q,1,gamma);
    tstart(timer);
    if report
     then R_Cont(file,sols,false,target=>target);
     else S_Cont(sols,false,target=>target);
    end if;
    tstop(timer);
    new_line(file);
    print_times(file,timer,"Continuation in Extrinsic Coordinates");
    Standard_Homotopy.Clear;
  end Extrinsic_Track_Paths;

  procedure Extract_Halves ( n : in integer32; x : in Vector;
                             x1,x2 : out Vector ) is

  -- DESCRIPTION :
  --   Puts the first n elements of x in x1 and the last n elements in x2.

  begin
    for i in 1..n loop
      x1(i) := x(i);
      x2(i) := x(i+n);
    end loop;
  end Extract_Halves;

  function Stack_Vectors
             ( m,n1,n2 : integer32; y1,y2 : Vector ) return Vector is

  -- DESCRIPTION :
  --    Returns a vector of range 1..m, obtained by stacking y2
  --    (of range 1..n2) after y1 (of range 1..n1).

    res : Vector(1..m);

  begin
    for i in 1..n1 loop
      res(i) := y1(i);
    end loop;
    for i in 1..n2 loop
      res(n1+i) := y2(i);
    end loop;
    return res;
  end Stack_Vectors;

  function Stack_Matrices
             ( n,n2,m,nA,nB : in integer32; A,B : Matrix ) return Matrix is

  -- DESCRIPTION :
  --   Returns a matrix with m rows and n2 columns with on its
  --   diagonal the nA-by-n matrix A and the nB-by-n matrix B.

    res : Matrix(1..m,1..n2);

  begin
    for i in 1..nA loop
      for j in 1..n loop
        res(i,j) := A(i,j);
        res(i,j+n) := Create(0.0);
      end loop;
    end loop;
    for i in 1..nB loop
      for j in 1..n loop
        res(nA+i,j) := Create(0.0);
        res(nA+i,j+n) := B(i,j);
      end loop;
    end loop;
    return res;
  end Stack_Matrices;

-- TARGET ROUTINES :

  function Minimal_Intersection_Dimension
             ( n,a,b : integer32 ) return integer32 is

    res : constant integer32 := a + b - n;

  begin
    if res < 0
     then return 0;
     else return res;
    end if;
  end Minimal_Intersection_Dimension;

  function Collapse ( n : integer32; p : Matrix ) return Matrix is

  -- DESCRIPTION :
  --   The matrix on return has the first n rows of p.

     res : Matrix(1..n,p'range(2));

  begin
    for i in 1..n loop
      for j in p'range(2) loop
        res(i,j) := p(i,j);
      end loop;
    end loop;
    return res;
  end Collapse;

  procedure Singular_Filter
              ( file : in file_type;
                sols : in out Solution_List; tol : in double_float ) is

    len : constant natural32 := Length_Of(sols);
    sing,regu : Solution_List;

  begin
    R_Singular_Filter(file,sols,tol,sing,regu);
   -- S_Singular_Filter(sols,tol,sing,regu);
    put(file,"Tested "); put(file,len,1); put(file," solutions, found ");
    put(file,Length_Of(regu),1); put(file," regular and ");
    put(file,Length_Of(sing),1); put_line(file," singular.");
    Clear(sols);
    sols := regu;
  end Singular_Filter;

  procedure Scan_Failed_Paths
              ( file : in file_type; sols : in Solution_List;
                p1,p2 : in Matrix ) is

    tmp : Solution_List := sols;
    ls : Link_to_Solution;
    cnt : natural32 := 0;
    p : Matrix(p1'range(1),p2'range);

  begin
    new_line(file);
    put_line(file,"THE FAILED SOLUTION PATHS : ");
    for i in 1..Length_Of(sols) loop
      ls := Head_Of(tmp);
      if REAL_PART(ls.t) < 1.0 then
        cnt := cnt + 1;
        put(file,"solution "); put(file,i,1);
        put(file," is failed path ");
        put(file,cnt,1); put_line(file," :");
        put(file,ls.all);
        new_line(file);
        for j in p'range(1) loop
          for k in p'range(2) loop
            p(j,k) := p1(j,k)*(Create(1.0)-ls.t) + p2(j,k)*ls.t;
          end loop;
        end loop;
        declare
          x : constant Vector := Affine_Expand(ls.v,p);
        begin
          put_line(file,"The expanded vector : ");
          put_line(file,x);
        end;
      end if;
      tmp := Tail_Of(tmp);
    end loop;
  end Scan_Failed_Paths;

--  procedure Copy_Offset ( p : in Matrix; q : out Matrix ) is
--
--  -- DESCRIPTION :
--  --   Copies offset vector from p to q.
--
--  begin
--    for i in q'range(1) loop
--      q(i,0) := p(i,0);
--    end loop;
--  end Copy_Offset;

--  procedure Copy_Directions ( p : in Matrix; q : out Matrix ) is
--
--  -- DESCRIPTION :
--  --   Copies directions from p to q.
--
--  begin
--    for i in q'range(1) loop
--      for j in 1..q'last(2) loop
--        q(i,j) := p(i,j);
--      end loop;
--    end loop;
--  end Copy_Directions;

--  procedure Copy_Direction ( p : in Matrix; k : in natural;
--                             q : out Matrix ) is
--
--  -- DESCRIPTION :
--  --   Copies the kth direction vector from p to q.
--
--  -- REQUIRED : k <= p'last(2) = q'last(2).
--
--  begin
--    for i in q'range(1) loop
--      q(i,k) := p(i,k);
--    end loop;
--  end Copy_Direction;

--  procedure Start_Intrinsic_Cascade_the_Long_Way
--              ( file : in file_type; report : in boolean;
--                ef : in Eval_Poly_Sys; sjf : in Eval_Jaco_Mat;
--                stapla,tarpla : in Matrix; psols : in out Solution_List ) is
--
--  -- DESCRIPTION :
--  --   This is an experimental procedure to overcome the problems
--  --   with starting the cascade using intrinsic coordinates.
--  --   The suffix "the_Long_Way" reflects the attempt to move over
--  --   the directions one after the other, which failed badly.
--
--    len1,len2 : natural;
--    backsols : Solution_List;
--    wrkpla,endpla : Matrix(stapla'range(1),stapla'range(2));
--
--  begin
--   -- new_line(file);
--   -- put_line(file,"Path Tracking to Start the Cascade");
--   -- new_line(file);
--   -- put_line(file,"Refining the roots at the start...");
--    Refine_Roots(file,ef,sjf,stapla,psols);
--    wrkpla := stapla;
--    Copy_Directions(stapla,endpla); -- Copy_Offset(stapla,endpla);
--    Copy_Offset(tarpla,endpla);     -- Copy_Directions(tarpla,endpla);
--    for i in 0..tarpla'last(2) loop
--      len1 := Length_Of(psols);
--      new_line(file);
--      put(file,"Tracking "); put(file,len1,1);
--      put(file," paths to start the cascade, stage ");
--      put(file,i,1); put_line(file," ...");
--      Intrinsic_Track_Paths(file,report,ef,sjf,wrkpla,endpla,psols);
--      Copy(psols,backsols);
--      new_line(file);
--      put_line(file,"Refining the roots at the target...");
--      Refine_Roots(file,ef,sjf,endpla,psols);
--      len2 := Length_Of(psols);
--      if len1 = len2
--       then put(file,"No paths lost in Start of the Cascade, stage ");
--            put(file,i,1); put_line(file,".  OK");
--       else put(file,len1-len2,1);
--            put(file," paths lost in Start of the Cascade, stage ");
--            put(file,i,1); put_line(file,".  BUG!!!");
--            Scan_Failed_Paths(file,backsols,wrkpla,endpla);
--      end if;
--      wrkpla := endpla;
--     -- Copy_Directions(tarpla,endpla); --Copy_Offset(tarpla,endpla);
--      if i < tarpla'last(2)
--       then Copy_Direction(tarpla,i+1,endpla);
--      end if;
--    end loop;
--  end Start_Intrinsic_Cascade_the_Long_Way;

  procedure Start_Extrinsic_Cascade
              ( file : in file_type; report : in boolean;
                p,q : in Poly_Sys; sols : in out Solution_List ) is

  -- DESCRIPTION :
  --   Does the path following to start the extrinsic cascade.

  -- ON ENTRY :
  --   file     for output and intermediate diagnostics;
  --   report   if reporting version of path trackers is needed;
  --   p        target polynomial system;
  --   q        system to start the cascade;
  --   sols     solutions of the start system q.

  -- ON RETURN :
  --   sols     solutions at the end of converging paths.

   -- pocotime : duration := 0.0;

  begin
   -- put_line(file,"The target system : "); put_line(file,p);
   -- put("Number of unknowns in target system : ");
   -- for i in p'range loop
   --   put(" "); put(Number_of_Unknowns(p(i)),1);
   -- end loop;
   -- new_line;
   -- put_line(file,"The start system : "); put_line(file,q);
   -- put("Number of unknowns in start system : ");
   -- for i in p'range loop
   --   put(" "); put(Number_of_Unknowns(q(i)),1);
   -- end loop;
   -- new_line;
   -- put_line(file,"The start solutions : ");
   -- put(file,Length_Of(sols),Head_Of(sols).n,sols);
    Extrinsic_Track_Paths(file,report,p,q,sols);
  end Start_Extrinsic_Cascade;

  procedure Write_Collapsed_Results
              ( file : in file_type; name : in string;
                p1,p2 : in Poly_Sys; sli : in VecVec; n,k,d : in integer32; 
                sols : in Solution_List ) is

  -- DESCRIPTION :
  --   Writes the results collapsed into the original n-space.

    n1 : constant integer32 := p1'last;
    n2 : constant integer32 := p2'last;
    p : Poly_Sys(1..n1+n2+k);
    cnt : integer32 := 0;
    tsols : Solution_List;

  begin
    for i in 1..n1 loop
      if p1(i) /= Null_Poly then
        cnt := cnt + 1;
        if k = 0
         then Copy(p1(i),p(cnt));
         else p(cnt) := Add_Embedding(p1(i),natural32(k));
        end if;
      end if;
    end loop;
    for i in 1..n2 loop
      if p2(i) /= Null_Poly then
        cnt := cnt + 1;
        if k = 0
         then Copy(p2(i),p(cnt));
         else p(cnt) := Add_Embedding(p2(i),natural32(k));
        end if;
      end if;
    end loop;
    if k > 0 then
      declare
        slice : Standard_Complex_Vectors.Vector(0..n+k);
      begin
        for i in 1..k loop
          cnt := cnt + 1;
          slice(0..n) := sli(i)(0..n);
          for j in 1..n loop
            slice(j) := slice(j) + sli(i)(n+j);
          end loop;
          for j in 1..k loop
            slice(n+j) := sli(i)(2*n+j);
          end loop;
          p(cnt) := Hyperplane(slice);
        end loop;
      end;
    end if;
    put(file,"Witness Set of dimension ");
    put(file,k,1); put(file," and degree ");
    put(file,d,1); put_line(file," :");
    put(file,cnt,1); put(file,"  ");
    put(file,n,1); new_line(file);
    put(file,p(1..cnt));
    tsols := Truncate(sols,n);
    put_line(file,"Witness Points : ");
    put(file,natural32(d),natural32(Head_Of(tsols).n),tsols);
    if Symbol_Table.Number < natural32(p'last)
     then Witness_Sets_io.Add_Embed_Symbols(natural32(d));
    end if;
    if k > 0 then
      declare
        esols : Solution_List := Witness_Sets.Add_Embedding(tsols,natural32(k));
      begin
        Extrinsic_Diagonal_Homotopies_io.Write_Witness_Set
          (file,name,natural32(k),p(1..cnt),esols);
        Clear(esols);
      end;
    else
      Extrinsic_Diagonal_Homotopies_io.Write_Witness_Set
        (file,name,natural32(k),p(1..cnt),tsols);
    end if;
    Clear(p); Clear(tsols);
  end Write_Collapsed_Results;

  procedure Write_Split_Report
              ( file : in file_type; sols_on,nonsols : in Solution_List;
                degree,left_to_do : out natural32 ) is

  -- DESCRIPTION :
  --   Writes a two-line summary of the solution splitter outcome.

  begin
    degree := Length_Of(sols_on);
    left_to_do := Length_Of(nonsols);
    new_line(file);
    put(file,"#solutions on a component : ");
    put(file,degree,1); new_line(file);
    put(file,"#nonsolutions to continue : ");
    put(file,left_to_do,1); new_line(file);
  end Write_Split_Report;

  procedure Down_Extrinsic_Cascade
              ( file : in file_type; name : in string; report : in boolean;
                q : in Poly_Sys; sols : in out Solution_List;
                p1,p2 : in Poly_Sys; sli : in VecVec;
                tol : in double_float; n,k : in integer32 ) is

  -- DESCRIPTION :
  --   Does one path following stage down in the extrinsic cascade.

  -- ON ENTRY :
  --   file     for diagnostics and intermediate results;
  --   name     to write the (super) witness sets to;
  --   report   flag to ask for intermediate output of path trackers;
  --   q        embedded system, serves as start system;
  --   sols     start solutions, all with nonzero slack variable;
  --   p1       original system of the 1st witness set;
  --   p2       original system of the 2nd witness set;
  --   sli      set of k hyperplanes for the top embedding;
  --   tol      tolerance used by the filter;
  --   n        dimension of the ambient space;
  --   k        top dimension.

  -- ON RETURN :
  --   sols     solutions at the end of the paths.

    start,target,wrk : Link_to_Poly_Sys;
    p : constant Poly_Sys(q'range) := Remove_Slice(q);
    sols_on,nonsols : Solution_List;
    degree,left_to_do : natural32;

  begin
    start := new Poly_Sys'(q);
    target := new Poly_Sys'(p);
    for i in reverse 1..k loop
      put(file,"going down in the extrinsic cascade at i = ");
      put(file,i,1); put_line(file," ...");
      Extrinsic_Track_Paths(file,report,target.all,start.all,sols);
      Filter_and_Split_Solutions(sols,2*n,k,tol,sols_on,nonsols);
      Write_Split_Report(file,sols_on,nonsols,degree,left_to_do);
     -- if degree > 0 -- careful: the dimension is i-1 
     --  then Write_Collapsed_Results(file,name,p1,p2,sli,n,i-1,degree,sols_on);
     -- end if;
      if degree > 0 -- this is not a careful fix for the dimension "i" !
       then Write_Collapsed_Results
              (file,name,p1,p2,sli,n,i,integer32(degree),sols_on);
      end if;
      exit when (left_to_do = 0);
      Copy(nonsols,sols);
      Remove_Component(sols);
      wrk := new Poly_Sys'(Remove_Embedding1(target.all,1));
      if i < k then Clear(start); end if;
      start := wrk;
      Clear(target); target := new Poly_Sys'(Remove_Slice(start.all));
    end loop;
  end Down_Extrinsic_Cascade;

  procedure Extrinsic_Diagonal_Homotopy
              ( file : in file_type; name : in string; report : in boolean;
                p1e,p2e : in Poly_Sys; a,b : in natural32;
                sols1,sols2 : in Solution_List ) is

    n : constant integer32 := Head_Of(sols1).n;
    d : constant natural32 := Cascade_Dimension(p1e,p2e,a,b);
    k : constant integer32 := integer32(d) - 2*n;
  -- careful about zero equations at the end after removing embedding...
    p1 : constant Poly_Sys := Remove_Embedding1(p1e,a);
    p2 : constant Poly_Sys := Remove_Embedding1(p2e,b);
    start,target : Poly_Sys(1..integer32(d));
    sli : VecVec(1..k);
    esols,sols_on,nonsols : Solution_List;
    tol : constant double_float := 1.0E-8;
    degree,left_to_do : natural32;

  begin
    Extrinsic_Cascade_Homotopy(p1e,p2e,a,b,sols1,sols2,start,target,esols); 
    new_line(file);
    put_line(file,"target system to solve at start of the cascade :");
    put(file,natural32(target'last),target);
    new_line(file);
    put_line(file,"the system to start the cascade :");
    put(file,natural32(start'last),start);
    new_line(file);
    put_line(file,"THE START SOLUTIONS :");
    put(file,Length_Of(esols),natural32(Head_Of(esols).n),esols);
    sli := Slices(target,natural32(k));
    put(file,"Starting the extrinsic cascade,");
    put(file," n = "); put(file,n,1);
    put(file," d = "); put(file,d,1);
    put(file," k = "); put(file,k,1);
    put(file," #paths = "); put(file,Length_Of(esols),1);
    new_line(file);
    Start_Extrinsic_Cascade(file,report,target,start,esols);
   -- Filter_and_Split_Solutions(file,esols,2*n,k,tol,sols_on,nonsols);
    Filter_and_Split_Solutions(esols,2*n,k,tol,sols_on,nonsols);
    Write_Split_Report(file,sols_on,nonsols,degree,left_to_do);
    if degree > 0
     then Write_Collapsed_Results
            (file,name,p1,p2,sli,n,k,integer32(degree),sols_on);
    end if;
    if left_to_do > 0
     then Down_Extrinsic_Cascade
            (file,name,report,target,nonsols,p1,p2,sli,tol,n,k);
    end if;
  end Extrinsic_Diagonal_Homotopy;

end Extrinsic_Diagonal_Continuation;
