with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Complex_Numbers;          use Standard_Complex_Numbers;
with Standard_Random_Vectors;           use Standard_Random_Vectors;
with Standard_Random_Matrices;          use Standard_Random_Matrices;
with Standard_Natural_Vectors;
with Standard_Integer_Vectors;
with Standard_Complex_Norms_Equals;     use Standard_Complex_Norms_Equals;
with Standard_Complex_QR_Least_Squares; use Standard_Complex_QR_Least_Squares;
with Standard_Complex_Poly_SysFun;      use Standard_Complex_Poly_SysFun;
with Standard_Embed_Polynomials;        use Standard_Embed_Polynomials;

package body Standard_Deflate_Singularities is

-- AUXILIARY ROUTINES :

  function Random_Sum_of_Multipliers 
              ( n,k : integer32 ; c : Vector ) return Poly is

  -- DESCRIPTION :
  --   Returns the polynomial equation in n+k variables,
  --   expressing that a combination of the k multipliers equals one.
  --   The multipliers are at the last k positions.
  --   The k coefficients in the combination of the multipliers
  --   are in the vector c.

    res : Poly := Null_Poly;
    t : Term;

  begin
    t.dg := new Standard_Natural_Vectors.Vector'(1..n+k => 0);
    for i in 1..k loop
      t.dg(n+i) := 1;
      t.cf := c(i);
      Add(res,t);
      t.dg(n+i) := 0;
    end loop;
    t.cf := Create(-1.0);
    Add(res,t);
    Clear(t);
    return res;
  end Random_Sum_of_Multipliers;

  function Multiply ( jm : Jaco_Mat; a : Matrix ) return Jaco_Mat is

  -- DESCRIPTION :
  --   Multiplies the given Jacobi matrix with the matrix a.
  --   On return is a matrix with in its columns random combinations
  --   of the columns of the original Jacobi matrix.

    res : Jaco_Mat(jm'range(1),a'range(2));
    zero : constant Complex_Number := Create(0.0);

  begin
    for i in res'range(1) loop
      for j in res'range(2) loop
        res(i,j) := Null_Poly;
        for k in a'range(1) loop
          if (a(k,j) /= zero) and (jm(i,k) /= Null_Poly) then
            declare
              s : Poly := a(k,j)*jm(i,k);
            begin
              Add(res(i,j),s);
              Clear(s);
            end;
          end if;
        end loop;
      end loop;
    end loop;
    return res;
  end Multiply;

-- TARGET ROUTINES :

  function Deflate ( f : Poly_Sys; m : natural32;
                     a : Matrix; c : Vector ) return Poly_Sys is

    n : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    jm : Jaco_Mat(f'range,1..n) := Create(f);
    res : constant Poly_Sys := Deflate(f,jm,m,a,c);

  begin
    Clear(jm);
    return res;
  end Deflate;

  function Deflate ( f : Poly_Sys; jm : Jaco_Mat; m : natural32;
                     a : Matrix; c : Vector ) return Poly_Sys is

    n_equ : constant integer32 := f'last-f'first+1;
    n_var : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    res : Poly_Sys(f'first..f'last+n_equ+1);
    ind : integer32;
    jma : Jaco_Mat(jm'range(1),a'range(2)) := Multiply(jm,a);
    ejm : Jaco_Mat(jm'range(1),a'range(2)) := Add_Variables(jma,m);
    multiplier : Term;

  begin
    for i in f'range loop 
      res(i) := Add_Variables(f(i),m);
    end loop;
    res(res'last) := Random_Sum_of_Multipliers(n_var,integer32(m),c);
    multiplier.cf := Create(1.0);
    multiplier.dg := new Standard_Natural_Vectors.Vector'
                           (1..n_var+integer32(m) => 0);
    for i in ejm'range(1) loop
      for j in ejm'range(2) loop
        multiplier.dg(n_var+j) := 1;
        Mul(ejm(i,j),multiplier);
        multiplier.dg(n_var+j) := 0;
      end loop;
    end loop;
    Clear(multiplier);
    ind := f'last;
    for i in 1..n_equ loop
      ind := ind + 1;
      res(ind) := Null_Poly;
      for j in ejm'range(2) loop
        Add(res(ind),ejm(i,j));
      end loop;
    end loop;
    Clear(jma); Clear(ejm);
    return res;
  end Deflate;

  function Deflate ( f : Poly_Sys; m : natural32 ) return Poly_Sys is

    nv : constant natural32 := Number_of_Unknowns(f(f'first));
    jm : Jaco_Mat(f'range,1..integer32(nv)) := Create(f);
    res : constant Poly_Sys := Deflate(f,jm,m);

  begin
    Clear(jm);
    return res;
  end Deflate;

  function Deflate ( f : Poly_Sys; jm : Jaco_Mat;
                     m : natural32 ) return Poly_Sys is

    nv : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    ne : constant integer32 := f'last-f'first+1;
    cf : constant Vector(1..integer32(m)) := Random_Vector(1,integer32(m));
    a : constant Matrix(1..nv,1..integer32(m))
      := Random_Matrix(natural32(nv),m);
    res : constant Poly_Sys(f'first..f'last+ne+1) := Deflate(f,jm,m,a,cf);

  begin
    return res;
  end Deflate;

  function Deflate_Corank_One ( f : Poly_Sys ) return Poly_Sys is

    nv : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    c : constant Vector(1..nv) := Random_Vector(1,nv);

  begin
    return Deflate_Corank_One(f,c);
  end Deflate_Corank_One;

  function Deflate_Corank_One
             ( f : Poly_Sys; jm : Jaco_Mat ) return Poly_Sys is

    nv : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    c : constant Vector(1..nv) := Random_Vector(1,nv);

  begin
    return Deflate_Corank_One(f,jm,c);
  end Deflate_Corank_One;

  function Deflate_Corank_One ( f : Poly_Sys; c : Vector ) return Poly_Sys is

    n : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    jm : Jaco_Mat(f'range,1..n) := Create(f);
    res : constant Poly_Sys := Deflate_Corank_One(f,jm,c);

  begin
    Clear(jm);
    return res;
  end Deflate_Corank_One;
  
  function Deflate_Corank_One ( f : Poly_Sys; jm : Jaco_Mat; c : Vector )
                              return Poly_Sys is

    nv : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    nq : constant integer32 := f'last-f'first+1;
    res : Poly_Sys(1..2*nq+1);
    ejm : Jaco_Mat(jm'range(1),jm'range(2))
        := Add_Variables(jm,natural32(nv));
    ind : integer32;
    multiplier : Term;

  begin
    for i in f'range loop 
      res(i) := Add_Variables(f(i),natural32(nv));
    end loop;
    multiplier.cf := Create(1.0);
    multiplier.dg := new Standard_Natural_Vectors.Vector'(1..2*nv => 0);
    for i in ejm'range(1) loop
      for j in ejm'range(2) loop
        multiplier.dg(nv+j) := 1;
        Mul(ejm(i,j),multiplier);
        multiplier.dg(nv+j) := 0;
      end loop;
    end loop;
    Clear(multiplier);
    ind := f'last;
    for i in 1..nq loop
      ind := ind + 1;
      res(ind) := Null_Poly;
      for j in ejm'range(2) loop
        Add(res(ind),ejm(i,j));
      end loop;
    end loop;
    res(res'last) := Random_Sum_of_Multipliers(nv,nv,c);
    Clear(ejm);
    return res;
  end Deflate_Corank_One;

  function Deflate_Corank_One
              ( f : Poly_Sys; k,nq,nv : natural32 ) return Poly_Sys is

    res : Poly_Sys(1..f'last+integer32(nq)+1);
    n : constant integer32 := integer32(Number_of_Unknowns(f(f'first)));
    jm,ejm : Jaco_Mat(1..integer32(nq),1..n);
    multiplier : Term;
    c : constant Vector(1..integer32(nv)) := Random_Vector(1,integer32(nv));
    ind : integer32;

  begin
    if k = 1
     then ind := f'first - 1;                 -- just compute Jacobian matrix
     else ind := f'last - integer32(nq) - 1;  -- skip last scalar equation
    end if;
    for i in jm'range(1) loop
      for j in 1..n loop
        jm(i,j) := Diff(f(ind+i),j);
      end loop;
    end loop;
    for i in f'range loop 
      res(i) := Add_Variables(f(i),nv);
    end loop;
    ejm := Add_Variables(jm,nv);
    multiplier.cf := Create(1.0);
    multiplier.dg := new Standard_Natural_Vectors.Vector'
                           (1..n+integer32(nv) => 0);
    ind := integer32(nv);  -- multiply columns of Jacobian with multipliers
    for j in 1..n loop
      ind := ind + 1;
      multiplier.dg(ind) := 1;
      for i in ejm'range(1) loop
        Mul(ejm(i,j),multiplier);
      end loop;
      multiplier.dg(ind) := 0;
    end loop;
    Clear(multiplier);
    ind := f'last;
    for i in ejm'range(1) loop
      ind := ind + 1;
      res(ind) := Null_Poly;
      for j in ejm'range(2) loop
        Add(res(ind),ejm(i,j));
      end loop;
    end loop;
    res(res'last) := Random_Sum_of_Multipliers(n,integer32(nv),c);
    Clear(jm); Clear(ejm);
    return res;
  end Deflate_Corank_One;

  function Multiplier_Index ( t : Term; m : natural32 ) return natural32 is

  -- DESCRIPTION :
  --   Returns the index of the multiplier in the term,
  --   or zero if no multiplier occurs in t.

  begin
    for i in 1..integer32(m) loop
      if t.dg(t.dg'last-integer32(m)+i) = 1
       then return natural32(i);
      end if;
    end loop;
    return 0;
  end Multiplier_Index;

  function Remove_Multipliers ( t : Term; m : natural32 ) return Term is

  -- DESCRIPTION :
  --   Returns the term t with its last m degrees removed.

    res : Term;

  begin
    res.cf := t.cf;
    res.dg := new Standard_Natural_Vectors.Vector'
                    (t.dg(1..t.dg'last-integer32(m)));
    return res;
  end Remove_Multipliers;

  function Multiplier_Polynomials
             ( f : Poly; m : natural32 ) return Poly_Sys is

  -- DESCRIPTION :
  --   Given a polynomial f, linear in its last m variables, the system
  --   on return collects in the i-th place all monomials with the i-th
  --   multiplier, with the m multipliers removed.

    res : Poly_Sys(0..integer32(m)) := (0..integer32(m) => Null_Poly);

    procedure Visit_Term ( t : in Term; continue : out boolean ) is

      ind : constant integer32 := integer32(Multiplier_Index(t,m));
      nt : Term := Remove_Multipliers(t,m);

    begin
      Add(res(ind),nt);
      Clear(nt);
      continue := true;
    end Visit_Term;
    procedure Visit_Terms is new Visiting_Iterator(Visit_Term);

  begin
    Visit_Terms(f);
    return res;
  end Multiplier_Polynomials;

  procedure Multiplier_System
               ( f : in Poly_Sys; z : in Vector; n,m : in natural32;
                 A : out Matrix; b : out Vector ) is

  -- DESCRIPTION :
  --   Returns in A and b the linear system to compute the multipliers.

  -- ON ENTRY :
  --   f         the equations of deflated system;
  --   z         current approximation for the root;
  --   n         number of new equations added by the deflation;
  --   m         number of multipliers added by the deflation.

  -- ON RETURN :
  --   A         coefficient matrix of linear system for multipliers;
  --   b         right-hand side vector of linear system.

  begin
    for i in 1..integer32(n) loop
      declare
        sys : Poly_Sys(0..integer32(m))
            := Multiplier_Polynomials(f(integer32(n)-1+i),m);
        eva : constant Vector(0..integer32(m)) := Eval(sys,z);
      begin
        b(i) := -eva(0);
        for j in 1..integer32(m) loop
          A(i,j) := eva(j);
        end loop;
        Clear(sys);
      end;
    end loop;
  end Multiplier_System;

  procedure Multipliers ( f : in Poly_Sys; z : in Vector; n,m : in natural32;
                          lambda : out Vector; resid : out double_float ) is

    A,wrk : Matrix(1..integer32(n),1..integer32(m));
    b : Standard_Complex_Vectors.Vector(1..integer32(n));
    qraux : Standard_Complex_Vectors.Vector(A'range(2))
          := (A'range(2) => Create(0.0));
    jpvt : Standard_Integer_Vectors.Vector(A'range(2))
         := (A'range(2) => 0);
    rsd,dum : Standard_Complex_Vectors.Vector(A'range(1));
    info : integer32;

  begin
    Multiplier_System(f,z,n,m,A,b);
    wrk := A;
    QRD(wrk,qraux,jpvt,false);
    QRLS(wrk,integer32(n),integer32(m),qraux,b,
         dum,dum,lambda,rsd,dum,110,info);
    dum := b - A*lambda;
    resid := Max_Norm(dum);
  end Multipliers;

  procedure Multipliers ( f : in Poly_Sys; z : in Vector; m : in natural32;
                          lambda : out Vector; resid : out double_float ) is

  -- NOTE that f has 2*n+1 equations after deflation of system
  --      with n equations.

    n : constant integer32 := (f'last-1)/2+1;

  begin
    Multipliers(f,z,natural32(n),m,lambda,resid);
  end Multipliers;

  function Strip_Multipliers ( t : Term; nv : natural32 ) return Term is

    res : Term;

  begin
    res.cf := t.cf;
    res.dg := new Standard_Natural_Vectors.Vector(1..integer32(nv));
    for i in 1..integer32(nv) loop
      res.dg(i) := t.dg(i);
    end loop;
    return res;
  end Strip_Multipliers;

  function Strip_Multipliers ( p : Poly; nv : natural32 ) return Poly is

    res : Poly := Null_Poly;

    procedure Strip_Term ( t : in Term; continue : out boolean ) is

      st : Term := Strip_Multipliers(t,nv);

    begin
      Add(res,st);
      Clear(st);
      continue := true;
    end Strip_Term;
    procedure Strip_Terms is new Visiting_Iterator(Strip_Term);

  begin
    Strip_Terms(p);
    return res;
  end Strip_Multipliers;

  function Strip_Multipliers
              ( f : Poly_Sys; nq,nv : natural32 ) return Poly_Sys is

    res : Poly_Sys(1..integer32(nq));

  begin
    for i in res'range loop
      res(i) := Strip_Multipliers(f(i),nv);
    end loop;
    return res;
  end Strip_Multipliers;

  function Strip_Multipliers
             ( s : Solution; nv : natural32 ) return Solution is

    res : Solution(integer32(nv));

  begin
    res.t := s.t;
    res.m := s.m;
    res.err := s.err;
    res.rco := s.rco;
    res.res := s.res;
    res.v := s.v(1..integer32(nv));
    return res;
  end Strip_Multipliers;

  function Strip_Multipliers
             ( s : Solution_List; nv : natural32 ) return Solution_List is

    res,res_last,tmp : Solution_List;
    ls : Link_to_Solution;

  begin
    tmp := s;
    while not Is_Null(tmp) loop
      ls := Head_Of(tmp);
      Append(res,res_last,Strip_Multipliers(ls.all,nv));
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Strip_Multipliers;

end Standard_Deflate_Singularities;
