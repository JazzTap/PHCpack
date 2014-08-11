with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with DoblDobl_Mathematical_Functions;    use DoblDobl_Mathematical_Functions;

package body DoblDobl_Complex_Vector_Norms is

  function Conjugated_Inner_Product ( v,w : Vector ) return Complex_Number is

    zero : constant double_double := create(0.0);
    res : Complex_Number := Create(zero);

  begin
    for i in v'range loop
      res := res + Conjugate(v(i))*w(i);
    end loop;
    return res;
  end Conjugated_Inner_Product;

  function Norm2 ( v : Vector ) return double_double is

    res : double_double := Create(0.0);

  begin
    for i in v'range loop
       res := res + REAL_PART(v(i))*REAL_PART(v(i))
                  + IMAG_PART(v(i))*IMAG_PART(v(i));
    end loop;
    res := SQRT(res);
    return res;
  end Norm2;

  function Sum_Norm ( v : Vector ) return double_double is

    res : double_double := Create(0.0);

  begin
    for i in v'range loop
      res := res + AbsVal(v(i));
    end loop;
    return res;
  end Sum_Norm;

  function Max_Norm ( v : Vector ) return double_double is

    res : double_double := AbsVal(v(v'first));
    tmp : double_double;

  begin
    for i in v'first+1..v'last loop
      tmp := AbsVal(v(i));
      if tmp > res
       then res := tmp;
      end if;
    end loop;
    return res;
  end Max_Norm;

end DoblDobl_Complex_Vector_Norms;
