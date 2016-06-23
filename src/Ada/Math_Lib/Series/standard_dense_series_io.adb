with Standard_Integer_Numbers_io;
with Standard_Complex_Vectors_io;

package body Standard_Dense_Series_io is

  procedure get ( s : out Series ) is
  begin
    get(standard_input,s);
  end get;

  procedure get ( file : in file_type; s : out Series ) is
  begin
    s.order := 0;
    Standard_Integer_Numbers_io.get(file,s.order);
    Standard_Complex_Vectors_io.get(file,s.cff(0..s.order));
  end get;

  procedure put ( s : in Series ) is
  begin
    put(standard_output,s);
  end put;

  procedure put ( file : in file_type; s : in Series ) is
  begin
    Standard_Complex_Vectors_io.put_line(file,s.cff(0..s.order));
  end put;

end Standard_Dense_Series_io;
