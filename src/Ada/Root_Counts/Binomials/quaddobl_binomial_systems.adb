with Standard_Natural_Numbers;         use Standard_Natural_Numbers;
with Quad_Double_Numbers;              use Quad_Double_Numbers;
with QuadDobl_Complex_Numbers;         use QuadDobl_Complex_Numbers;
with Standard_Natural_Vectors;
with Standard_Integer_Vectors;
with QuadDobl_Complex_Polynomials;
with QuadDobl_Complex_Laurentials;

package body QuadDobl_Binomial_Systems is

-- FORMAT of a BINOMIAL SYSTEM :  p(x) = 0 => x^A = c

  procedure Parse ( p : in Poly_Sys; nq : in integer32;
                    A : out Matrix; c : out Vector; fail : out boolean ) is

    use QuadDobl_Complex_Polynomials;

    equ,mon : integer32;

    procedure Store ( t : in Term; continue : out boolean ) is
    begin
      if mon = 1 then
        for i in t.dg'range loop     -- store monomial in column equ
          A(i,equ) := integer64(t.dg(i));
        end loop;
        c(equ) := t.cf;              -- store coefficient at equ
        mon := mon + 1;
      else
        for i in t.dg'range loop     -- divide by new monomial
          A(i,equ) := A(i,equ) - integer64(t.dg(i));
        end loop;
        c(equ) := -t.cf/c(equ);      -- coefficient to righthand side
      end if;
      continue := true;
    end Store;
    procedure Store_Terms is new Visiting_Iterator(Store);

  begin
    for i in 1..nq loop                   -- check if binomial system
      if Number_of_Terms(p(i)) /= 2 then
        fail := true;
        return;
      end if;
    end loop;
    fail := false;
    for i in 1..nq loop
      equ := i; mon := 1;
      Store_Terms(p(i));
    end loop;
  end Parse;

  procedure Parse ( p : in Laur_Sys; nq : in integer32;
                    A : out Matrix; c : out Vector; fail : out boolean ) is

    use QuadDobl_Complex_Laurentials;

    equ,mon : integer32;

    procedure Store ( t : in Term; continue : out boolean ) is
    begin
      if mon = 1 then
        for i in t.dg'range loop     -- store monomial in column equ
          A(i,equ) := integer64(t.dg(i));
        end loop;
        c(equ) := t.cf;              -- store coefficient at equ
        mon := mon + 1;
      else
        for i in t.dg'range loop     -- divide by new monomial
          A(i,equ) := A(i,equ) - integer64(t.dg(i));
        end loop;
        c(equ) := -t.cf/c(equ);      -- coefficient to righthand side
      end if;
      continue := true;
    end Store;
    procedure Store_Terms is new Visiting_Iterator(Store);

  begin
    for i in 1..nq loop                   -- check if binomial system
      if Number_of_Terms(p(i)) /= 2 then
        fail := true;
        return;
      end if;
    end loop;
    fail := false;
    for i in 1..nq loop
      equ := i; mon := 1;
      Store_Terms(p(i));
    end loop;
  end Parse;

  function Create ( A : Matrix; c : Vector ) return Poly_Sys is

    use QuadDobl_Complex_Polynomials;

    res : Poly_Sys(A'range(2));
    t1,t2 : Term;
    one : constant quad_double := Quad_Double_Numbers.create(1.0);

  begin
    t1.cf := QuadDobl_Complex_Numbers.create(one);
    t1.dg := new Standard_Natural_Vectors.Vector(A'range(1));
    t2.dg := new Standard_Natural_Vectors.Vector(A'range(1));
    for j in res'range loop
      for i in A'range(1) loop
        if A(i,j) >= 0
         then t1.dg(i) := natural32(A(i,j)); t2.dg(i) := 0;
         else t1.dg(i) := 0; t2.dg(i) := natural32(-A(i,j));
        end if;
      end loop;
      res(j) := Create(t1);
      t2.cf := -c(j);
      Add(res(j),t2);
    end loop;
    Clear(t1); Clear(t2);
    return res;
  end Create;

  function Create ( A : Matrix; c : Vector ) return Laur_Sys is

    use QuadDobl_Complex_Laurentials;

    res : Laur_Sys(A'range(2));
    t1,t2 : Term;
    one : constant quad_double := Quad_Double_Numbers.Create(1.0);

  begin
    t1.cf := QuadDobl_Complex_Numbers.Create(one);
    t1.dg := new Standard_Integer_Vectors.Vector(A'range(1));
    t2.dg := new Standard_Integer_Vectors.Vector(A'range(1));
    for j in res'range loop
      for i in A'range(1) loop
        t1.dg(i) := integer32(A(i,j));
        t2.dg(i) := 0;
      end loop;
      res(j) := Create(t1);
      t2.cf := -c(j);
      Add(res(j),t2);
    end loop;
    Clear(t1); Clear(t2);
    return res;
  end Create;

-- EVALUATION of a BINOMIAL SYSTEM :

  function Eval ( A : Matrix; x : Vector ) return Vector is

    res : Vector(A'range(2));
    one : constant quad_double := Quad_Double_Numbers.create(1.0);

  begin
    for i in res'range loop
      res(i) := QuadDobl_Complex_Numbers.create(one);
    end loop;
    for j in A'range(2) loop
      for i in A'range(1) loop
        res(j) := res(j)*(x(i)**integer(A(i,j)));
      end loop;
    end loop;
    return res;
  end Eval;

  function Eval ( A : Matrix; c,x : Vector ) return Vector is

    res : constant Vector(A'range(2)) := Eval(A,x) - c;

  begin
    return res;
  end Eval;

  function Eval ( A : Matrix; s : Solution_List ) return Solution_List is

    res,res_last : Solution_List;
    tmp : Solution_List := s;
    ls : Link_to_Solution;

  begin
    while not Is_Null(tmp) loop
      ls := Head_Of(tmp);
      declare
        res_ls : Solution(ls.n);
      begin
        res_ls.t := ls.t;
        res_ls.m := ls.m;
        res_ls.v := Eval(A,ls.v);
        res_ls.err := ls.err;
        res_ls.rco := ls.rco;
        res_ls.res := ls.res;
        Append(res,res_last,res_ls);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Eval;

end QuadDobl_Binomial_Systems;
