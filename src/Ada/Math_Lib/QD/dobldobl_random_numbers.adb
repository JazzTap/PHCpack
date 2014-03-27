with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Random_Numbers;
with Standard_Mathematical_Functions;
with Double_Double_Constants;
with DoblDobl_Mathematical_Functions;

package body DoblDobl_Random_Numbers is

  function Random return double_double is

    res : double_double;
    rf : constant double_float := Standard_Random_Numbers.Random;

  begin
    res := Create(rf);
    return res;
  end Random;

  function Random_Magnitude ( m : natural32 ) return double_double is

    res : double_double := Random;
    r : constant double_float := Standard_Random_Numbers.Random_Magnitude(m);

  begin
    res := r*res;
    return res;
  end Random_Magnitude;

  function Random return Complex_Number is

    res : Complex_Number;
    rf1 : constant double_float := Standard_Random_Numbers.Random;
    rf2 : constant double_float := Standard_Random_Numbers.Random;
    rlp : constant double_double := create(rf1);
    imp : constant double_double := create(rf2);

  begin
    res := create(rlp,imp);
    return res;
  end Random;

  function Random1 return Complex_Number is

    res : Complex_Number;
    arg : double_double := DoblDobl_Random_Numbers.Random;
    cs,sn : double_double;

  begin
    arg := arg*Double_Double_Constants.pi;
    cs := DoblDobl_Mathematical_Functions.cos(arg);
    sn := DoblDobl_Mathematical_Functions.sin(arg);
    res := create(cs,sn);
    return res;
  end Random1;

  function Random_Magnitude ( m : natural32 ) return Complex_Number is

    res : Complex_Number := Random1;
    r : constant double_float := Standard_Random_Numbers.Random_Magnitude(m);
    r_dd : constant double_double := create(r);

  begin
    res := r_dd*res;
    return res;
  end Random_Magnitude;

end DoblDobl_Random_Numbers;
