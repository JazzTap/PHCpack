package body Greeting_Banners is

  function Version return string is

    res : constant string := "PHCv2.3.95 released 2014-10-31";

  begin
    return res;
  end Version;

end Greeting_Banners;
