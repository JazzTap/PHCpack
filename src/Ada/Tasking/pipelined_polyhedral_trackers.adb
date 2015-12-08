with Standard_Integer_Numbers_io;       use Standard_Integer_Numbers_io;
with Standard_Integer_Vectors_io;       use Standard_Integer_Vectors_io;
with Standard_Integer_VecVecs_io;       use Standard_Integer_VecVecs_io;
with Standard_Complex_Vectors_io;       use Standard_Complex_Vectors_io;
with Standard_Complex_VecVecs_io;       use Standard_Complex_VecVecs_io;
with Floating_Mixed_Subdivisions_io;    use Floating_Mixed_Subdivisions_io;

with Standard_Natural_NUmbers_io;       use Standard_Natural_Numbers_io;
with Standard_Floating_Numbers;         use Standard_Floating_Numbers;
with Standard_Natural_Vectors;
with Standard_Natural_Vectors_io;       use Standard_Natural_Vectors_io;
with Standard_Floating_VecVecs;
with Standard_Complex_Vectors;
with Standard_Complex_VecVecs;
with Standard_Integer_Matrices;
with Standard_Integer_Linear_Solvers;
with Standard_Complex_Matrices;
with Standard_Complex_Linear_Solvers;
with Lists_of_Floating_Vectors;
with Arrays_of_Integer_Vector_Lists;
with Arrays_of_Floating_Vector_Lists;
with Standard_Complex_Laur_Systems_io;  use Standard_Complex_Laur_Systems_io;
with Standard_Complex_Laur_Functions;
with Standard_Complex_Laur_SysFun;
with Standard_Complex_Laur_JacoMats;
with Exponent_Vectors;
with Supports_of_Polynomial_Systems;
with Standard_Radial_Solvers;
with Standard_Binomial_Systems;
with Standard_Binomial_Solvers;
with Floating_Mixed_Subdivisions_io;
with Random_Coefficient_Systems;
with MixedVol_Algorithm;                use MixedVol_Algorithm;
with Semaphore;
with Polyhedral_Start_Systems;          use Polyhedral_Start_Systems;
with Single_Polyhedral_Trackers;        use Single_Polyhedral_Trackers;
with Pipelined_Labeled_Cells;           use Pipelined_Labeled_Cells;

package body Pipelined_Polyhedral_Trackers is

  function Lifted_Supports
              ( n,r : integer32;
                mix : Standard_Integer_Vectors.Vector;
                idx : Standard_Integer_Vectors.Link_to_Vector;
                vtx : Standard_Integer_VecVecs.Link_to_VecVec;
                lft : Standard_Floating_Vectors.Link_to_Vector )
              return Arrays_of_Floating_Vector_Lists.Array_of_Lists is

  -- DESCRIPTION :
  --   Joins the vertex points and their lifting values into one
  --   array of lists of lifted supports.

  -- ON ENTRY :
  --   n        ambient dimension of the points, before the lifting;
  --   r        number of different supports;
  --   mix      type of mixture, number of occurrences of each support;
  --   idx      indices to the vertex points;
  --   vtx      coordinates of the vertex points;
  --   lft      lifting values for the vertex points.

  -- ON RETURN :
  --   An array of range 1..r of lifted supports.

    res : Arrays_of_Floating_Vector_Lists.Array_of_Lists(1..r);
    res_last : Arrays_of_Floating_Vector_Lists.Array_of_Lists(1..r);
    ind : integer32 := 0;
    vpt : Standard_Integer_Vectors.Link_to_Vector;
    idxlft : integer32 := lft'first-1;

  begin
    put("mix = "); put(mix); new_line;
    put("idx = "); put(idx.all); new_line;
    for k in 1..idx'last loop
      ind := ind + 1;
      put("support "); put(ind,1); put_line(" :");
      for i in idx(k-1)..(idx(k)-1) loop
        vpt := vtx(i);
        declare
          lpt : Standard_Floating_Vectors.Vector(1..n+1);
          ilp : integer32 := 0;
        begin
          for j in vpt'range loop
            ilp := ilp + 1;
            lpt(ilp) := double_float(vpt(j));
          end loop;
          idxlft := idxlft + 1;
          lpt(n+1) := lft(idxlft);
          Lists_of_Floating_Vectors.Append(res(ind),res_last(ind),lpt);
        end;
      end loop;
    end loop;
    return res;
  end Lifted_Supports;

  procedure Track_Cell
              ( sem : in out Semaphore.Lock; idtask,n,r : in integer32; 
                mix : in Standard_Integer_Vectors.Vector;
                mic : in Mixed_Cell;
                lif : in Arrays_of_Floating_Vector_Lists.Array_of_Lists;
                cff : in Standard_Complex_VecVecs.VecVec;
                dpw : in Standard_Floating_VecVecs.Link_to_VecVec;
                cft : in Standard_Complex_VecVecs.Link_to_VecVec;
                epv : in Exponent_Vectors.Exponent_Vectors_Array;
                hom : in Standard_Complex_Laur_SysFun.Eval_Coeff_Laur_Sys;
                ejf : in Standard_Complex_Laur_JacoMats.Eval_Coeff_Jaco_Mat;
                jmf : in Standard_Complex_Laur_JacoMats.Mult_Factors;
                q : in Standard_Complex_Laur_Systems.Laur_Sys;
                tmv : in out natural32;
                sols : in out Standard_Complex_Solutions.Solution_List;
                last : in out Standard_Complex_Solutions.Solution_List ) is

  -- DESCRIPTION :
  --   One task tracks all paths defined by a polyhedral homotopy determined
  --   by one mixed cell in a regular mixed cell configuration.
  --   As many paths as the volume of the cell are tracked.

  -- ON ENTRY :
  --   sem      semaphore for the critical sections;
  --   idtask   identification number of the task;
  --   n        ambient dimension of the points, before lifting;
  --   r        number of different supports;
  --   mix      type of mixture, counts the number of occurrences;
  --   mic      a mixed cell in a regular mixed cell configuration;
  --   lif      lifted supports, in an array of range 1..r;
  --   cff      coefficients of the system q;
  --   dpw      pointer to work space for the powers in the homotopy;
  --   cft      pointer to work space for coefficient in t;
  --   epv      exponents of the homotopy;
  --   hom      evaluable form of the coefficient polyhedral homotopy;
  --   ejf      evaluable form of the Jacobian matrix;
  --   jmf      multiplication factors of the Jacobian matrix;
  --   q        a random coefficient system;
  --   tmv      current number of paths tracked by the task;
  --   sols     pointer to the first solution in a list;
  --   last     pointer to the last solution in a list.

  -- ON RETURN :
  --   tmv      updated number of paths tracked by the task;
  --   sols     if sols was null on entry, then sols points to the first
  --            solution contributed by this first cell;
  --   last     pointer has moved as many positions as the mixed volume
  --            of the cell and the list sols contains as many additional
  --            solutions of q as that mixed volume.

    use Supports_of_Polynomial_Systems;

    s_c : Standard_Complex_Vectors.Vector(1..2*n);    -- for fully mixed
    CC : Standard_Complex_Matrices.Matrix(1..n,1..n); -- for semi mixed
    piv : Standard_Integer_Vectors.Vector(1..n);
    pdetU : natural32;
    info : integer32;
    A,M,U : Standard_Integer_Matrices.Matrix(q'range,q'range);
    b,wrk : Standard_Complex_Vectors.Vector(q'range);
    brd,logbrd,logx,e10x : Standard_Floating_Vectors.Vector(b'range);
    bsc : Standard_Complex_Vectors.Vector(b'range);
    ls : Standard_Complex_Solutions.Link_to_Solution;
    ptr : Standard_Complex_Solutions.Solution_List;

  begin
    if r = n then
     -- put_line("The Coefficients : "); put(cff);
     -- put("The exponent vectors array : ");
     -- for i in epv'range loop
     --   put(epv(i));
     -- end loop;
     -- put_line("The mixed cell : "); put(natural32(n),mix,mic);
      Select_Coefficients(cff,epv,mic.pts.all,s_c);
     -- put_line("The selected coefficients : "); put_line(s_c);
      Fully_Mixed_To_Binomial_Format(s_c,mic.pts.all,A,b);
    else
      Select_Subsystem_to_Matrix_Format(cff,epv,mix,mic.pts.all,A,CC,b);
      Standard_Complex_Linear_Solvers.lufac(CC,n,piv,info);
      Standard_Complex_Linear_Solvers.lusolve(CC,n,piv,b);
    end if;
    U := A;
    Standard_Integer_Linear_Solvers.Upper_Triangulate(M,U);
    pdetU := Volume_of_Diagonal(U);
    Semaphore.Request(sem);
    ptr := last;
    Allocate(sols,last,n,integer32(pdetU));
    if Standard_Complex_Solutions.Is_Null(ptr)
     then ptr := sols;
     else ptr := Standard_Complex_Solutions.Tail_Of(ptr);
    end if;
    brd := Standard_Radial_Solvers.Radii(b);
    bsc := Standard_Radial_Solvers.Scale(b,brd);
    Standard_Binomial_Solvers.Solve_Upper_Square(U,bsc,ptr);
    Semaphore.Release(sem);
    logbrd := Standard_Radial_Solvers.Log10(brd);
    logx := Standard_Radial_Solvers.Radial_Upper_Solve(U,logbrd);
    logx := Standard_Radial_Solvers.Multiply(M,logx);
    e10x := Standard_Radial_Solvers.Exp10(logx);
    for i in 1..pdetU loop
      ls := Standard_Complex_Solutions.Head_Of(ptr);
      Standard_Binomial_Systems.Eval(M,ls.v,wrk);
      ls.v := wrk;
      Standard_Radial_Solvers.Multiply(ls.v,e10x);
      Track_Path(mix,lif,mic.nor,cff,dpw,cft,epv,hom,ejf,jmf,ls);
      ptr := Standard_Complex_Solutions.Tail_Of(ptr);
    end loop;
    tmv := tmv + pdetU;
  end Track_Cell;

  procedure Reporting_Multitasking_Tracker
              ( file : in file_type;
                nt,nbequ,r : in integer32;
                mtype,perm,idx : in Standard_Integer_Vectors.Link_to_Vector;
                vtx : in Standard_Integer_VecVecs.Link_to_VecVec;
                lft : in Standard_Floating_Vectors.Link_to_Vector;
                mcc : out Mixed_Subdivision; mv : out natural32;
                q : out Standard_Complex_Laur_Systems.Laur_Sys;
                sols : out Standard_Complex_Solutions.Solution_List ) is

    use Standard_Complex_Laur_SysFun;
    use Standard_Complex_Laur_JacoMats;
    use Standard_Complex_Solutions;

    sem : Semaphore.Lock;
    mix : constant Standard_Integer_Vectors.Vector := Mixture(r,mtype);
    lif : Arrays_of_Floating_Vector_Lists.Array_of_Lists(mix'range)
        := Lifted_Supports(nbequ,r,mix,idx,vtx,lft);
    hom : Eval_Coeff_Laur_Sys(1..nbequ);
    cff : Standard_Complex_VecVecs.VecVec(hom'range);
    epv : Exponent_Vectors.Exponent_Vectors_Array(hom'range);
    ejf : Eval_Coeff_Jaco_Mat(hom'range,hom'first..hom'last+1);
    jmf : Mult_Factors(ejf'range(1),ejf'range(2));
    tmv : Standard_Natural_Vectors.Vector(2..nt) := (2..nt => 0);
    dpw : Standard_Floating_VecVecs.Array_of_VecVecs(2..nt);
    cft : Standard_Complex_VecVecs.Array_of_VecVecs(2..nt);
    tasksols,lastsols : Array_of_Solution_Lists(2..nt);
    permq : Standard_Complex_Laur_Systems.Laur_Sys(1..nbequ);

    procedure Track ( idtask,r : in integer32; 
                      mtype : in Standard_Integer_Vectors.Link_to_Vector;
                      mic : in out Mixed_Cell ) is
    begin
      Track_Cell(sem,idtask,nbequ,r,mix,mic,lif,cff,dpw(idtask),cft(idtask),
        epv,hom,ejf,jmf,q,tmv(idtask),tasksols(idtask),lastsols(idtask));
    end Track;

  begin
    permq := Random_Coefficient_Systems.Create(natural32(nbequ),mix,lif);
    for i in perm'range loop
      q(perm(i)+1) := permq(i+1);
    end loop;
    put_line(file,q);
    new_line(file);
    put_line(file,"THE LIFTED SUPPORTS :");
    Floating_Mixed_Subdivisions_io.put(file,lif);
    cff := Coeff(q);
    epv := Exponent_Vectors.Create(q);
    hom := Create(q);
    Create(q,ejf,jmf);
    Allocate_Workspace_for_Exponents(epv,dpw);
    Allocate_Workspace_for_Coefficients(cff,cft);
    Pipelined_Mixed_Cells
      (nt,nbequ,true,r,mtype,perm,idx,vtx,lft,mcc,mv,Track'access);
    put("Number of paths tracked : "); put(tmv); 
    put(" => "); put(Standard_Natural_Vectors.Sum(tmv),1); new_line;
    for k in tasksols'range loop
      Standard_Complex_Solutions.Push(tasksols(k),sols);
    end loop;
  end Reporting_Multitasking_Tracker;

  procedure Reporting_Multitasking_Tracker
              ( file : in file_type;
                nt,nbequ,nbpts : in integer32;
                ind,cnt : in Standard_Integer_Vectors.Vector;
                support : in Standard_Integer_Vectors.Link_to_Vector;
                r : out integer32;
                mtype,perm : out Standard_Integer_Vectors.Link_to_Vector;
                mcc : out Mixed_Subdivision; mv : out natural32;
                q : out Standard_Complex_Laur_Systems.Laur_Sys;
                sols : out Standard_Complex_Solutions.Solution_List ) is

    stlb : constant double_float := 0.0; -- no stable mv for now...
    idx,sdx,ndx : Standard_Integer_Vectors.Link_to_Vector;
    vtx,spt : Standard_Integer_VecVecs.Link_to_VecVec;
    lft : Standard_Floating_Vectors.Link_to_Vector;

  begin
    mv_upto_pre4mv
      (nbequ,nbpts,ind,cnt,support.all,r,mtype,perm,idx,vtx,sdx,spt,ndx);
    put("ind = "); put(ind); new_line;
    put("cnt = "); put(cnt); new_line;
    put("perm = "); put(perm); new_line;
    put("idx = "); put(idx); new_line;
    put("sdx = "); put(sdx); new_line;
    put("ndx = "); put(ndx); new_line;
    put_line("The permutation : ");
    for i in perm'range loop
      put(i,1); put(" : "); put(perm(i),1); new_line;
    end loop;
    mv_lift(nbequ,stlb,r,idx,vtx,lft);
    Reporting_Multitasking_Tracker
      (file,nt,nbequ,r,mtype,perm,idx,vtx,lft,mcc,mv,q,sols);
    Standard_Integer_Vectors.Clear(idx);
    Standard_Integer_Vectors.Clear(sdx);
    Standard_Integer_Vectors.Clear(ndx);
    Standard_Floating_Vectors.Clear(lft);
    Standard_Integer_VecVecs.Deep_Clear(vtx);
  end Reporting_Multitasking_Tracker;

end Pipelined_Polyhedral_Trackers;
