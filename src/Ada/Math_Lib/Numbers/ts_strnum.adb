with text_io;                            use text_io;
with String_Splitters;                   use String_Splitters;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Floating_Numbers_io;       use Standard_Floating_Numbers_io;
with Standard_Complex_Numbers;           use Standard_Complex_Numbers;
with Standard_Complex_Numbers_io;        use Standard_Complex_Numbers_io;
with Strings_and_Numbers;                use Strings_and_Numbers;

procedure ts_strnum is

-- DESCRIPTION :
--   Test on converting complex floating-point numbers to strings
--   and parsing strings back into complex floating-point numbers.

  procedure Main is

    f : double_float := 0.0;
    c : Complex_Number;
    s : string(1..21) := (1..21 => '#');

  begin
    new_line;
    put("Give a double float : "); get(f);
    put("      -> your float : "); put(f); new_line;
    put(s,f);
    put_line("the float written to a string : "); 
    put_line(s);
    declare
      s : constant string := Convert(f);
    begin
      put("your double float : "); put(f); new_line;
      put("   -> as a string : "); put_line(s);
    end;
    new_line;
    put("Give a complex number : "); get(c);
    declare
      s : constant string := Signed_Coefficient(c);
      s2 : string(1..44);
      dp : natural32 := 0;
      s3 : string(1..44);
      c2,c3 : Complex_Number;
      last : integer;
    begin
      put("your complex number : "); put(c); new_line;
      put("     -> as a string : "); put_line(s);
      put(s2,c);
      put("->  as basic string : "); put_line(s2);
      put("Give number of decimal places : "); get(dp);
      put(s3,c,dp);
      put("-> shortened format : "); put_line(s2);
      put_line("parsing the two strings ...");
      get(s2,c2,last);
      put("-> basic format : "); put(c2); new_line;
      get(s3,c3,last);
      put("-> short format : "); put(c3); new_line;
    end;
    skip_line;
    new_line;
    put_line("Reading a string for a complex number ...");
    declare
      s : constant string := Read_String;
      cs : Complex_Number;
      last : integer;
    begin
      new_line;
      put_line("The string read : "); put(s);
      get(s,cs,last);
      new_line;
      put_line("The complex number : "); put(cs); new_line;
    end;
  end Main;

begin
  Main;
end ts_strnum;
