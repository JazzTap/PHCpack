with text_io;                             use text_io;
with Communications_with_User;            use Communications_with_User;
with Standard_Integer_Numbers;            use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;         use Standard_Integer_Numbers_io;
with Standard_Complex_Numbers;            use Standard_Complex_Numbers;
with Standard_Dense_Series;
with Standard_Dense_Series_io;            use Standard_Dense_Series_io;
with Standard_Dense_Series_Vectors;
with Standard_Dense_Series_Vectors_io;    use Standard_Dense_Series_Vectors_io;
with Standard_Series_Vector_Norms;
with DoblDobl_Dense_Series;
with DoblDobl_Dense_Series_io;            use DoblDobl_Dense_Series_io;
with DoblDobl_Dense_Series_Vectors;
with DoblDobl_Series_Vector_Norms;
with QuadDobl_Dense_Series;
with QuadDobl_Dense_Series_io;            use QuadDobl_Dense_Series_io;
with QuadDobl_Dense_Series_Vectors;
with QuadDobl_Series_Vector_Norms;
with Standard_Random_Series;
with DoblDobl_Random_Series;
with QuadDobl_Random_Series;

procedure ts_servec is

-- DESCRIPTION :
--   Test on vectors of truncated power series.

  procedure Write ( v : in Standard_Dense_Series_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Writes the components of the vector to standard output.
 
  begin
    for i in v'range loop
      put("Component "); put(i,1); put_line(" :");
      put(v(i));
    end loop;
  end Write;

  procedure Write ( v : in DoblDobl_Dense_Series_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Writes the components of the vector to standard output.
 
  begin
    for i in v'range loop
      put("Component "); put(i,1); put_line(" :");
      put(v(i));
    end loop;
  end Write;

  procedure Write ( v : in QuadDobl_Dense_Series_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Writes the components of the vector to standard output.
 
  begin
    for i in v'range loop
      put("Component "); put(i,1); put_line(" :");
      put(v(i));
    end loop;
  end Write;

  procedure Standard_Test_Norm 
              ( v : in Standard_Dense_Series_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Test on normalization of the vector v.

    use Standard_Dense_Series;
    use Standard_Dense_Series_Vectors;
    use Standard_Series_Vector_Norms;

    sn : constant Series := Norm(v);
    snv : Series;
    nv : Vector(v'range);

  begin
    new_line;
    put_line("The norm of v : "); put(sn);
    nv := Normalize(v);
    put_line("The normalized vector : "); Write(nv);
    snv := Square_of_Norm(nv);
    put_line("Square of norm of normalized vector :"); put(snv);
  end Standard_Test_Norm;

  procedure DoblDobl_Test_Norm 
              ( v : in DoblDobl_Dense_Series_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Test on normalization of the vector v.

    use DoblDobl_Dense_Series;
    use DoblDobl_Dense_Series_Vectors;
    use DoblDobl_Series_Vector_Norms;

    sn : constant Series := Norm(v);
    snv : Series;
    nv : Vector(v'range);

  begin
    new_line;
    put_line("The norm of v : "); put(sn);
    nv := Normalize(v);
    put_line("The normalized vector : "); Write(nv);
    snv := Square_of_Norm(nv);
    put_line("Square of norm of normalized vector :"); put(snv);
  end DoblDobl_Test_Norm;

  procedure QuadDobl_Test_Norm 
              ( v : in QuadDobl_Dense_Series_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Test on normalization of the vector v.

    use QuadDobl_Dense_Series;
    use QuadDobl_Dense_Series_Vectors;
    use QuadDobl_Series_Vector_Norms;

    sn : constant Series := Norm(v);
    snv : Series;
    nv : Vector(v'range);

  begin
    new_line;
    put_line("The norm of v : "); put(sn);
    nv := Normalize(v);
    put_line("The normalized vector : "); Write(nv);
    snv := Square_of_Norm(nv);
    put_line("Square of norm of normalized vector :"); put(snv);
  end QuadDobl_Test_Norm;

  procedure Standard_Test ( dim,order : in integer32 ) is

  -- DESCRIPTION :
  --   Generates a random vector of range 1..dim,
  --   with series of the given order, in standard double precision.
  --   Tests the computation of the norm and the normalization.

    v : Standard_Dense_Series_Vectors.Vector(1..dim)
      := Standard_Random_Series.Random_Series_Vector(1,dim,order);

  begin
    Write(v);
    Standard_Test_Norm(v);
  end Standard_Test;

  procedure DoblDobl_Test ( dim,order : in integer32 ) is

  -- DESCRIPTION :
  --   Generates a random vector of range 1..dim,
  --   with series of the given order, in double double precision.
  --   Tests the computation of the norm and the normalization.

    v : DoblDobl_Dense_Series_Vectors.Vector(1..dim)
      := DoblDobl_Random_Series.Random_Series_Vector(1,dim,order);

  begin
    Write(v);
    DoblDobl_Test_Norm(v);
  end DoblDobl_Test;

  procedure QuadDobl_Test ( dim,order : in integer32 ) is

  -- DESCRIPTION :
  --   Generates a random vector of range 1..dim,
  --   with series of the given order, in quad double precision.
  --   Tests the computation of the norm and the normalization.

    v : QuadDobl_Dense_Series_Vectors.Vector(1..dim)
      := QuadDobl_Random_Series.Random_Series_Vector(1,dim,order);

  begin
    Write(v);
    QuadDobl_Test_Norm(v);
  end QuadDobl_Test;

  procedure Main is

  -- DESCRIPTION :
  --   Prompts the user for a dimension, an order
  --   and then generates a random vector.

    dim,order : integer32 := 0;
    ans : character;

  begin
    new_line;
    put("Give the dimension : "); get(dim);
    put("Give the order : "); get(order);
    new_line;
    put_line("MENU to select the working precision :");
    put_line("  0. standard double precision;");
    put_line("  1. double double precision; or");
    put_line("  2. quad double precision.");
    put("Type 0, 1, or 2 to select the precision : ");
    Ask_Alternative(ans,"012");
    new_line;
    case ans is
      when '0' => Standard_Test(dim,order);
      when '1' => DoblDobl_Test(dim,order);
      when '2' => QuadDobl_Test(dim,order);
      when others => null;
    end case;
  end Main;

begin
  Main;
end ts_servec;
