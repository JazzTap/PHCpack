with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Vectors;
with Standard_Complex_Poly_Strings;

package body Standard_Pade_Approximants_io is

  function to_Poly ( c : Vector ) return Poly is

    res : Poly := Null_Poly;
    trm : Term;

  begin
    trm.dg := new Standard_Natural_Vectors.Vector(1..1);
    for k in c'range loop
      trm.dg(1) := natural32(k);
      trm.cf := c(k);
      Add(res,trm);
    end loop;
    Clear(trm);
    return res;
  end to_Poly;

  function t_symbol return Symbol is

    res : Symbol_Table.Symbol;

  begin
    res := (res'range => ' ');
    res(res'first) :=  't';
    return res;
  end t_symbol;

  function Write ( c : Vector; s : Symbol ) return string is

    sa : Array_of_Symbols(1..1);
    p : Poly := to_Poly(c);

  begin
    sa(1) := s;
    declare
      res : constant string
          := Standard_Complex_Poly_Strings.Write(p,sa);
    begin
      Standard_Complex_Polynomials.Clear(p);
      return res;
    end;
  end Write;

  function Write ( c : Vector ) return string is

    tsb : constant Symbol_Table.Symbol := t_symbol;

  begin
    return Write(c,tsb);
  end Write;

  function Write ( p : Pade; s : Symbol ) return string is

    numcff : constant Standard_Complex_Vectors.Vector
           := Numerator_Coefficients(p);
    numstr : constant string := Write(numcff,s);
    dencff : constant Standard_Complex_Vectors.Vector
           := Denominator_Coefficients(p);
    denstr : constant string := Write(dencff,s);
    res : constant string
        := "(" & numstr(1..numstr'last-1) & ")/("
               & denstr(1..denstr'last-1) & ")";

  begin
    return res;
  end Write;

  function Write ( p : Pade ) return string is

    tsb : constant Symbol_Table.Symbol := t_symbol;

  begin
    return Write(p,tsb);
  end Write;

end Standard_Pade_Approximants_io;
