with Communications_with_User;           use Communications_with_User;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;        use Standard_Integer_Numbers_io;
with Standard_Complex_Poly_Systems_io;   use Standard_Complex_Poly_Systems_io;
with Standard_Complex_Laur_Systems_io;   use Standard_Complex_Laur_Systems_io;
with DoblDobl_Complex_Poly_Systems_io;   use DoblDobl_Complex_Poly_Systems_io;
with QuadDobl_Complex_Poly_Systems_io;   use QuadDobl_Complex_Poly_Systems_io;

package body Prompt_for_Systems is

  procedure Scan_System
               ( file : in out file_type; name : in string;
                 lp : in out Standard_Complex_Poly_Systems.Link_to_Poly_Sys;
                 onfile : out boolean ) is

  -- DESCRIPTION :
  --   Checks whether the given file name corresponds to a file with
  --   a polynomial system in a correct format.
  --   If this is the case, then onfile is true on return and lp
  --   contains the system.

  begin
    if name /= "" then
      Open(file,in_file,name);
      get(file,lp);
      onfile := true;
    else
      onfile := false;
    end if;
   -- if lp /= null then
   --   put("in Scan_System : ");
   --   put(" #equations = "); put(lp'last,1); new_line;
   -- end if;
  exception
    when others =>
      new_line;
      put("Could not open file with name "); put_line(name);
      lp := null;
      onfile := false;
      return;
  end Scan_System;

  procedure Scan_System
               ( file : in out file_type; name : in string;
                 lp : in out Standard_Complex_Laur_Systems.Link_to_Laur_Sys;
                 onfile : out boolean ) is

  -- DESCRIPTION :
  --   Checks whether the given file name corresponds to a file with
  --   a polynomial system in a correct format.
  --   If this is the case, then onfile is true on return and lp
  --   contains the system.

  begin
    if name /= "" then
      Open(file,in_file,name);
      get(file,lp);
      onfile := true;
    else
      onfile := false;
    end if;
   -- if lp /= null then
   --   put("in Scan_System : ");
   --   put(" #equations = "); put(lp'last,1); new_line;
   -- end if;
  exception
    when others =>
      new_line;
      put("Could not open file with name "); put_line(name);
      lp := null;
      onfile := false;
      return;
  end Scan_System;

  procedure Scan_System
               ( file : in out file_type; name : in string;
                 lp : in out DoblDobl_Complex_Poly_Systems.Link_to_Poly_Sys;
                 onfile : out boolean ) is

  -- DESCRIPTION :
  --   Checks whether the given file name corresponds to a file with
  --   a polynomial system in a correct format.
  --   If this is the case, then onfile is true on return and lp
  --   contains the system.

  begin
    if name /= "" then
      Open(file,in_file,name);
      get(file,lp);
      onfile := true;
    else
      onfile := false;
    end if;
   -- if lp /= null then
   --   put("in Scan_System : ");
   --   put(" #equations = "); put(lp'last,1); new_line;
   -- end if;
  exception
    when others =>
      new_line;
      put("Could not open file with name "); put_line(name);
      lp := null;
      onfile := false;
      return;
  end Scan_System;

  procedure Scan_System
               ( file : in out file_type; name : in string;
                 lp : in out QuadDobl_Complex_Poly_Systems.Link_to_Poly_Sys;
                 onfile : out boolean ) is

  -- DESCRIPTION :
  --   Checks whether the given file name corresponds to a file with
  --   a polynomial system in a correct format.
  --   If this is the case, then onfile is true on return and lp
  --   contains the system.

  begin
    if name /= "" then
      Open(file,in_file,name);
      get(file,lp);
      onfile := true;
    else
      onfile := false;
    end if;
   -- if lp /= null then
   --   put("in Scan_System : ");
   --   put(" #equations = "); put(lp'last,1); new_line;
   -- end if;
  exception
    when others =>
      new_line;
      put("Could not open file with name "); put_line(name);
      lp := null;
      onfile := false;
      return;
  end Scan_System;

  procedure Read_System
              ( file : in out file_type; name : in string;
                lp : in out Standard_Complex_Poly_Systems.Link_to_Poly_Sys;
                onfile : out boolean ) is

    use Standard_Complex_Poly_Systems;

    ans : character;
    n : integer32;

  begin
    Scan_System(file,name,lp,onfile);
    if lp = null then
      loop
        new_line;
        put("Is the system on a file ? (y/n/i=info) ");
        Ask_Alternative(ans,"yni");
        if ans = 'i' then
          new_line;
          Standard_Complex_Poly_Systems_io.Display_Format;
          new_line;
        end if;
        exit when ans /= 'i';
      end loop;
      new_line;
      if ans = 'y' then
        put_line("Reading the name of the input file.");
        Read_Name_and_Open_File(file);
        get(file,lp);
        onfile := true;
        n := lp'length;
      else
        put("Give the dimension : "); get(n);
        lp := new Standard_Complex_Poly_Systems.Poly_Sys(1..n);
        put("Give "); put(n,1); put(" "); put(n,1);
        put_line("-variate polynomials :");
        get(natural32(n),lp.all);
        skip_line;  -- skip end_of_line symbol
        onfile := false;
      end if;
    end if;
   -- put_line("at end of Read_System : ");
   -- put("#equations : "); put(lp'last,1);
   -- put(", #variables : "); put(Number_of_Unknowns(lp(lp'first)),1);
   -- new_line;
  end Read_System;

  procedure Read_System
              ( file : in out file_type; name : in string;
                lp : in out Standard_Complex_Laur_Systems.Link_to_Laur_Sys;
                onfile : out boolean ) is

    use Standard_Complex_Laur_Systems;

    ans : character;
    n : integer32;

  begin
    Scan_System(file,name,lp,onfile);
    if lp = null then
      loop
        new_line;
        put("Is the system on a file ? (y/n/i=info) ");
        Ask_Alternative(ans,"yni");
        if ans = 'i' then
          new_line;
          Standard_Complex_Laur_Systems_io.Display_Format;
          new_line;
        end if;
        exit when ans /= 'i';
      end loop;
      new_line;
      if ans = 'y' then
        put_line("Reading the name of the input file.");
        Read_Name_and_Open_File(file);
        get(file,lp);
        onfile := true;
        n := lp'length;
      else
        put("Give the dimension : "); get(n);
        lp := new Standard_Complex_Laur_Systems.Laur_Sys(1..n);
        put("Give "); put(n,1); put(" "); put(n,1);
        put_line("-variate polynomials :");
        get(natural32(n),lp.all);
        skip_line;  -- skip end_of_line symbol
        onfile := false;
      end if;
    end if;
   -- put_line("at end of Read_System : ");
   -- put("#equations : "); put(lp'last,1);
   -- put(", #variables : "); put(Number_of_Unknowns(lp(lp'first)),1);
   -- new_line;
  end Read_System;

  procedure Read_System
              ( file : in out file_type; name : in string;
                lp : in out DoblDobl_Complex_Poly_Systems.Link_to_Poly_Sys;
                onfile : out boolean ) is

    use DoblDobl_Complex_Poly_Systems;

    ans : character;
    n : integer32;

  begin
    Scan_System(file,name,lp,onfile);
    if lp = null then
      loop
        new_line;
        put("Is the system on a file ? (y/n/i=info) ");
        Ask_Alternative(ans,"yni");
        if ans = 'i' then
          new_line;
          Standard_Complex_Poly_Systems_io.Display_Format;
          new_line;
        end if;
        exit when ans /= 'i';
      end loop;
      new_line;
      if ans = 'y' then
        put_line("Reading the name of the input file.");
        Read_Name_and_Open_File(file);
        get(file,lp);
        onfile := true;
        n := lp'length;
      else
        put("Give the dimension : "); get(n);
        lp := new DoblDobl_Complex_Poly_Systems.Poly_Sys(1..n);
        put("Give "); put(n,1); put(" "); put(n,1);
        put_line("-variate polynomials :");
        get(standard_input,lp.all);
        skip_line;  -- skip end_of_line symbol
        onfile := false;
      end if;
    end if;
   -- put_line("at end of Read_System : ");
   -- put("#equations : "); put(lp'last,1);
   -- put(", #variables : "); put(Number_of_Unknowns(lp(lp'first)),1);
   -- new_line;
  end Read_System;

  procedure Read_System
              ( file : in out file_type; name : in string;
                lp : in out QuadDobl_Complex_Poly_Systems.Link_to_Poly_Sys;
                onfile : out boolean ) is

    use QuadDobl_Complex_Poly_Systems;

    ans : character;
    n : integer32;

  begin
    Scan_System(file,name,lp,onfile);
    if lp = null then
      loop
        new_line;
        put("Is the system on a file ? (y/n/i=info) ");
        Ask_Alternative(ans,"yni");
        if ans = 'i' then
          new_line;
          Standard_Complex_Poly_Systems_io.Display_Format;
          new_line;
        end if;
        exit when ans /= 'i';
      end loop;
      new_line;
      if ans = 'y' then
        put_line("Reading the name of the input file.");
        Read_Name_and_Open_File(file);
        get(file,lp);
        onfile := true;
        n := lp'length;
      else
        put("Give the dimension : "); get(n);
        lp := new QuadDobl_Complex_Poly_Systems.Poly_Sys(1..n);
        put("Give "); put(n,1); put(" "); put(n,1);
        put_line("-variate polynomials :");
        get(standard_input,lp.all);
        skip_line;  -- skip end_of_line symbol
        onfile := false;
      end if;
    end if;
   -- put_line("at end of Read_System : ");
   -- put("#equations : "); put(lp'last,1);
   -- put(", #variables : "); put(Number_of_Unknowns(lp(lp'first)),1);
   -- new_line;
  end Read_System;

end Prompt_for_Systems;
