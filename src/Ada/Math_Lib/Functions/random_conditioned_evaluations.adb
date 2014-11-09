with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Complex_Numbers;
with Standard_Natural_Vectors;
with Standard_Complex_Vectors;
with Standard_Random_Vectors;
with Standard_Complex_Poly_Functions;   use Standard_Complex_Poly_Functions;
with Standard_Random_Polynomials;
with Double_Double_Numbers;             use Double_Double_Numbers;
with DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Vectors;
with DoblDobl_Random_Vectors;
with DoblDobl_Complex_Poly_Functions;   use DoblDobl_Complex_Poly_Functions;
with DoblDobl_Random_Polynomials;
with Quad_Double_Numbers;               use Quad_Double_Numbers;
with QuadDobl_Complex_Numbers;
with QuadDobl_Complex_Vectors;
with QuadDobl_Random_Vectors;
with QuadDobl_Complex_Poly_Functions;   use QuadDobl_Complex_Poly_Functions;
with QuadDobl_Random_Polynomials;
with Multprec_Floating_Numbers;         use Multprec_Floating_Numbers;
with Multprec_Complex_Numbers;
with Multprec_Complex_Number_Tools;     use Multprec_Complex_Number_Tools;
with Multprec_Random_Vectors;
with Multprec_Complex_Poly_Functions;   use Multprec_Complex_Poly_Functions;
with Multprec_Random_Polynomials;

package body Random_Conditioned_Evaluations is

  procedure Random_Conditioned_Evaluation_Problem
              ( n,d,m,c : in natural32;
                cffsz,pntsz,close : in double_float;
                f : out Standard_Complex_Polynomials.Poly;
                z : out Standard_Complex_Vectors.Vector ) is

    use Standard_Complex_Numbers;

    p : Standard_Complex_Polynomials.Poly;
    x : Standard_Complex_Vectors.Vector(1..integer32(n))
      := Standard_Random_Vectors.Random_Vector(1,integer32(n));
    t : Standard_Complex_Polynomials.Term;

  begin
    if m = 0
     then p := Standard_Random_Polynomials.Random_Dense_Poly(n,d,c);
     else p := Standard_Random_Polynomials.Random_Sparse_Poly(n,d,m,c);
    end if;
    t.dg := new Standard_Natural_Vectors.Vector'(1..integer32(n) => 0);
    t.cf := Standard_Complex_Numbers.Create(cffsz);
    Standard_Complex_Polynomials.Mul(p,t);
    for i in x'range loop
      x(i) := Standard_Complex_Numbers.Create(pntsz)*x(i);
    end loop;
    t.cf := Eval(p,x);
    Standard_Complex_Polynomials.Sub(p,t);
    t.cf := Standard_Complex_Numbers.Create(close);
    Standard_Complex_Polynomials.Add(p,t);
    Standard_Complex_Polynomials.Clear(t);
    f := p;
    z := x;
  end Random_Conditioned_Evaluation_Problem;

  procedure Random_Conditioned_Evaluation_Problem
              ( n,d,m,c : in natural32;
                cffsz,pntsz,close : in double_float;
                f : out DoblDobl_Complex_Polynomials.Poly;
                z : out DoblDobl_Complex_Vectors.Vector ) is

    use DoblDobl_Complex_Numbers;

    dd_cffsz : constant double_double := create(cffsz);
    dd_pntsz : constant double_double := create(pntsz);
    dd_close : constant double_double := create(close);
    p : DoblDobl_Complex_Polynomials.Poly;
    x : DoblDobl_Complex_Vectors.Vector(1..integer32(n))
      := DoblDobl_Random_Vectors.Random_Vector(1,integer32(n));
    t : DoblDobl_Complex_Polynomials.Term;

  begin
    if m = 0
     then p := DoblDobl_Random_Polynomials.Random_Dense_Poly(n,d,c);
     else p := DoblDobl_Random_Polynomials.Random_Sparse_Poly(n,d,m,c);
    end if;
    t.dg := new Standard_Natural_Vectors.Vector'(1..integer32(n) => 0);
    t.cf := DoblDobl_Complex_Numbers.Create(dd_cffsz);
    DoblDobl_Complex_Polynomials.Mul(p,t);
    for i in x'range loop
      x(i) := DoblDobl_Complex_Numbers.Create(dd_pntsz)*x(i);
    end loop;
    t.cf := Eval(p,x);
    DoblDobl_Complex_Polynomials.Sub(p,t);
    t.cf := DoblDobl_Complex_Numbers.Create(dd_close);
    DoblDobl_Complex_Polynomials.Add(p,t);
    DoblDobl_Complex_Polynomials.Clear(t);
    f := p;
    z := x;
  end Random_Conditioned_Evaluation_Problem;

  procedure Random_Conditioned_Evaluation_Problem
              ( n,d,m,c : in natural32;
                cffsz,pntsz,close : in double_float;
                f : out QuadDobl_Complex_Polynomials.Poly;
                z : out QuadDobl_Complex_Vectors.Vector ) is

    use QuadDobl_Complex_Numbers;

    qd_cffsz : constant quad_double := create(cffsz);
    qd_pntsz : constant quad_double := create(pntsz);
    qd_close : constant quad_double := create(close);
    p : QuadDobl_Complex_Polynomials.Poly;
    x : QuadDobl_Complex_Vectors.Vector(1..integer32(n))
      := QuadDobl_Random_Vectors.Random_Vector(1,integer32(n));
    t : QuadDobl_Complex_Polynomials.Term;

  begin
    if m = 0
     then p := QuadDobl_Random_Polynomials.Random_Dense_Poly(n,d,c);
     else p := QuadDobl_Random_Polynomials.Random_Sparse_Poly(n,d,m,c);
    end if;
    t.dg := new Standard_Natural_Vectors.Vector'(1..integer32(n) => 0);
    t.cf := QuadDobl_Complex_Numbers.Create(qd_cffsz);
    QuadDobl_Complex_Polynomials.Mul(p,t);
    for i in x'range loop
      x(i) := QuadDobl_Complex_Numbers.Create(qd_pntsz)*x(i);
    end loop;
    t.cf := Eval(p,x);
    QuadDobl_Complex_Polynomials.Sub(p,t);
    t.cf := QuadDobl_Complex_Numbers.Create(qd_close);
    QuadDobl_Complex_Polynomials.Add(p,t);
    QuadDobl_Complex_Polynomials.Clear(t);
    f := p;
    z := x;
  end Random_Conditioned_Evaluation_Problem;

  procedure Random_Conditioned_Evaluation_Problem
              ( n,d,m,c,sz : in natural32;
                cffsz,pntsz,close : in double_float;
                f : out Multprec_Complex_Polynomials.Poly;
                z : out Multprec_Complex_Vectors.Vector ) is

    use Multprec_Complex_Numbers;

    mp_cffsz : Floating_Number := create(cffsz);
    mp_pntsz : Floating_Number := create(pntsz);
    cp_pntsz : Complex_Number := create(mp_pntsz);
    mp_close : Floating_Number := create(close);
    p : Multprec_Complex_Polynomials.Poly;
    x : Multprec_Complex_Vectors.Vector(1..integer32(n))
      := Multprec_Random_Vectors.Random_Vector(1,integer32(n),sz);
    t : Multprec_Complex_Polynomials.Term;

  begin
    if m = 0
     then p := Multprec_Random_Polynomials.Random_Dense_Poly(n,d,c);
     else p := Multprec_Random_Polynomials.Random_Sparse_Poly(n,d,m,c);
    end if;
    t.dg := new Standard_Natural_Vectors.Vector'(1..integer32(n) => 0);
    t.cf := Multprec_Complex_Numbers.Create(mp_cffsz);
    Multprec_Complex_Number_Tools.Set_Size(t.cf,sz);
    Multprec_Complex_Polynomials.Mul(p,t);
    for i in x'range loop
      Multprec_Complex_Numbers.Mul(x(i),cp_pntsz);
      Multprec_Complex_Number_Tools.Set_Size(x(i),sz);
    end loop;
    Multprec_Complex_Numbers.Clear(t.cf);
    t.cf := Eval(p,x);
    Multprec_Complex_Polynomials.Sub(p,t);
    Multprec_Complex_Numbers.Clear(t.cf);
    t.cf := Multprec_Complex_Numbers.Create(mp_close);
    Multprec_Complex_Polynomials.Add(p,t);
    Multprec_Complex_Polynomials.Clear(t);
    Multprec_Complex_Numbers.Clear(cp_pntsz);
    Multprec_Floating_Numbers.Clear(mp_pntsz);
    Multprec_Floating_Numbers.Clear(mp_cffsz);
    Multprec_Floating_Numbers.Clear(mp_close);
    f := p;
    z := x;
  end Random_Conditioned_Evaluation_Problem;

end Random_Conditioned_Evaluations;
