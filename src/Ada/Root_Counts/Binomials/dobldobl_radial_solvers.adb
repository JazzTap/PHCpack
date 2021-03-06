with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Multprec_Integer_Numbers;          use Multprec_Integer_Numbers;
with Double_Double_Numbers;             use Double_Double_Numbers;
with DoblDobl_Complex_Numbers;          use DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Numbers_Polar;    use DoblDobl_Complex_Numbers_Polar;
with Multprec_Floating_Numbers;         use Multprec_Floating_Numbers;
with Multprec_Floating_Vectors;         use Multprec_Floating_Vectors;
with Multprec_DoblDobl_Convertors;      use Multprec_DoblDobl_Convertors;

package body DoblDobl_Radial_Solvers is

  function Radii ( c : DoblDobl_Complex_Vectors.Vector )
                 return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(c'range);

  begin
    for i in c'range loop
      res(i) := Radius(c(i));
    end loop;
    return res;
  end Radii;

  function Scale ( c : DoblDobl_Complex_Vectors.Vector;
                   r : Double_Double_Vectors.Vector )
                 return DoblDobl_Complex_Vectors.Vector is

    res : DoblDobl_Complex_Vectors.Vector(c'range);

  begin
    for i in c'range loop
      res(i) := c(i)/r(i);
    end loop;
    return res;
  end Scale;

  function Log10 ( r : Double_Double_Vectors.Vector ) 
                 return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(r'range);

  begin
    for i in r'range loop
      res(i) := LOG10(r(i));
    end loop;
    return res;
  end Log10;

  function Exp10 ( r : Double_Double_Vectors.Vector ) 
                 return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(r'range);
    ten : constant double_double := Double_Double_Numbers.create(10.0);
  
  begin
    for i in r'range loop
      res(i) := ten**r(i);
    end loop;
    return res;
  end Exp10;

  function Radial_Upper_Solve
              ( U : Standard_Integer64_Matrices.Matrix;
                logr : Double_Double_Vectors.Vector )
              return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(logr'range);
    eva : double_double;

  begin
    for i in res'range loop
      res(i) := create(0.0);
    end loop;
    for j in U'range loop
      eva := logr(j);
      for i in 1..j-1 loop
        eva := eva - create(integer(U(i,j)))*res(i);
      end loop;
      res(j) := eva/create(integer(U(j,j)));
    end loop;
    return res;
  end Radial_Upper_Solve;

  function to_double_double ( x : Integer_Number ) return double_double is

  -- DESCRIPTION :
  --   Converts the multiprecision integer number to a double float.

    f : Floating_Number := create(x);
    res : constant double_double := to_double_double(f);

  begin
    Clear(f);
    return res;
  end to_double_double;

  function Radial_Upper_Solve
              ( U : Multprec_Integer_Matrices.Matrix;
                logr : Double_Double_Vectors.Vector )
              return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(logr'range);
    eva : double_double;

  begin
    for i in res'range loop
      res(i) := create(0.0);
    end loop;
    for j in U'range loop
      eva := logr(j);
      for i in 1..j-1 loop
        eva := eva - to_double_double(U(i,j))*res(i);
      end loop;
      res(j) := eva/to_double_double(U(j,j));
    end loop;
    return res;
  end Radial_Upper_Solve;

  function Multiply ( A : in Standard_Integer64_Matrices.Matrix;
                      x : in Double_Double_Vectors.Vector )
                    return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(x'range);

  begin
    for i in x'range loop
      res(i) := create(0.0);
    end loop;
    for j in A'range(1) loop
      for i in A'range(2) loop
        res(j) := res(j) + create(integer(A(i,j)))*x(i);
      end loop;
    end loop;
    return res;
  end Multiply;

  function Multiply ( A : in Multprec_Integer_Matrices.Matrix;
                      x : in Double_Double_Vectors.Vector )
                    return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(x'range);
    mp_res : Multprec_Floating_Vectors.Vector(x'range);
    mp_x : Multprec_Floating_Vectors.Vector(x'range);

  begin
    for i in x'range loop
      res(i) := create(0.0);
    end loop;
    for i in x'range loop
      mp_x(i) := to_floating_number(x(i));
      mp_res(i) := Create(0.0);
    end loop;
    for j in A'range(1) loop
      for i in A'range(2) loop
       -- res(j) := res(j) + to_double_float(A(i,j))*x(i);
        declare
          mpAij : Floating_Number := Create(A(i,j));
          acc : Floating_Number :=  mpAij*mp_x(i);
        begin
          Add(mp_res(j),acc);
          Clear(mpAij); Clear(acc);
        end;
      end loop;
    end loop;
    for i in res'range loop
      res(i) := to_double_double(mp_res(i));
      Clear(mp_res(i)); Clear(mp_x(i));
    end loop;
    return res;
  end Multiply;

  function Eval ( A : in Standard_Integer64_Matrices.Matrix;
                  x : in Double_Double_Vectors.Vector )
                return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(x'range);

  begin
    for i in res'range loop
      res(i) := create(1.0);
    end loop;
    for j in A'range(2) loop
      for i in A'range(1) loop
         res(j) := res(j)*(x(i)**integer(A(i,j)));
      end loop;
    end loop;
    return res;
  end Eval;

  function Binary_Exponentiation
             ( x : double_double; e : Integer_Number ) return double_double is

  -- DESCRIPTION :
  --   Returns x^e using binary exponentiation.

    res,acc : double_double;
    one : constant double_double := create(1.0);
    abse : Integer_Number;

  begin
    if Equal(e,0) then
      res := one;
    else
      if e > 0
       then Copy(e,abse);
       else abse := -e;
      end if;
      res := x; acc := one;
      if abse > 1 then          -- use binary exponentiation
        while abse > 0 loop
          if Rmd(abse,2) = 1
           then acc := acc*res;
          end if;
          Div(abse,2);
          if abse > 0
           then res := res*res;
          end if;
        end loop;
      else
        acc := res;
      end if;
      if e < 0
       then res := 1.0/acc;          -- compute reciprocal
       else res := acc;
      end if;
    end if;
    return res;
  end Binary_Exponentiation;

  function Eval ( A : in Multprec_Integer_Matrices.Matrix;
                  x : in Double_Double_Vectors.Vector )
                return Double_Double_Vectors.Vector is

    res : Double_Double_Vectors.Vector(x'range);
    pwr : double_double;

  begin
    for i in res'range loop
      res(i) := create(1.0);
    end loop;
    for j in A'range(2) loop
      for i in A'range(1) loop
         pwr := Binary_Exponentiation(x(i),A(i,j));
         res(j) := res(j)*pwr; -- res(j) := res(j)*(x(i)**integer(A(i,j)));
      end loop;
    end loop;
    return res;
  end Eval;

  procedure Multiply ( s : in out DoblDobl_Complex_Vectors.Vector;
                       r : in Double_Double_Vectors.Vector ) is
  begin
    for i in s'range loop
      s(i) := s(i)*r(i);
    end loop;
  end Multiply;

  procedure Multiply ( s : in out Solution;
                       r : in Double_Double_Vectors.Vector )  is
  begin
    Multiply(s.v,r);
  end Multiply;

  procedure Multiply ( s : in out Solution_List;
                       r : in Double_Double_Vectors.Vector ) is

    tmp : Solution_List := s;
    ls : Link_to_Solution;

  begin
    while not Is_Null(tmp) loop
      ls := Head_Of(tmp);
      Multiply(ls.v,r);
      Set_Head(tmp,ls);
      tmp := Tail_Of(tmp);
    end loop;
  end Multiply;

end DoblDobl_Radial_Solvers;
