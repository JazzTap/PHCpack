with text_io;                             use text_io;
with Communications_with_User;            use Communications_with_User;
with Standard_Integer_Numbers;            use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;         use Standard_Integer_Numbers_io;
with Standard_Floating_Numbers;           use Standard_Floating_Numbers;
with Standard_Complex_Numbers;            use Standard_Complex_Numbers;
with Standard_Integer_Vectors;
with Standard_Integer_Vectors_io;         use Standard_Integer_Vectors_io;
with Standard_Dense_Series;               use Standard_Dense_Series;
with Standard_Dense_Series_io;            use Standard_Dense_Series_io;
with Standard_Dense_Series_Vectors;
with Standard_Dense_Series_Matrices;
with Standard_Random_Series;
with Standard_Linear_Series_Solvers;      use Standard_Linear_Series_Solvers;
with Standard_Least_Squares_Series;       use Standard_Least_Squares_Series;

procedure ts_sermat is

-- DESCRIPTION :
--   Test on matrices of truncated dense power series.

  procedure Write ( v : in Standard_Dense_Series_Vectors.Vector ) is
  begin
    for i in v'range loop
      put("Component "); put(i,1); put_line(" :");
      put(v(i));
    end loop;
  end Write;

  procedure Write ( A : in Standard_Dense_Series_Matrices.Matrix ) is
  begin
    for i in A'range(1) loop
      for j in A'range(2) loop
        put("Component ");
        put(i,1); put(", "); put(j,1); put_line(" :");
        put(A(i,j));
      end loop;
    end loop;
  end Write;

  procedure Random_Linear_Solve ( n,order : in integer32 ) is

  -- DESCRIPTION :
  --   Generates a random matrix A and right hand side vector b
  --   of dimension n and solves the linear system A*x = b.
  --   The series are all of the given order.

    A : Standard_Dense_Series_Matrices.Matrix(1..n,1..n)
      := Standard_Random_Series.Random_Series_Matrix(1,n,1,n,order);
    wrk : Standard_Dense_Series_Matrices.Matrix(1..n,1..n) := A;
    b : Standard_Dense_Series_Vectors.Vector(1..n)
      := Standard_Random_Series.Random_Series_Vector(1,n,order);
    x : Standard_Dense_Series_Vectors.Vector(1..n) := b;
    ipvt : Standard_Integer_Vectors.Vector(1..n);
    info : integer32;
    rsd : Standard_Dense_Series_Vectors.Vector(1..n);

    use Standard_Dense_Series_Vectors;
    use Standard_Dense_Series_Matrices;

  begin
    put_line("The coefficient matrix A :"); Write(A);
    put_line("The right hand side vector b :"); Write(b);
    LUfac(wrk,n,ipvt,info);
    put("The pivots : "); put(ipvt); new_line;
    LUsolve(wrk,n,ipvt,x);
    put_line("The solution x to A*x = b :"); Write(x);
    rsd := b - A*x;
    put_line("The residual b - A*x :"); Write(rsd);
  end Random_Linear_Solve;

  procedure Random_Least_Squares ( n,m,order : in integer32 ) is

  -- DESCRIPTION :
  --   Generates a random n-by-m matrix A with series of the given order.
  --   A random solution x is generated and then the right hand side
  --   vector b is A*x.  for n > m this is an overdetermined linear
  --   system A*x = b, where the solution x is the generated vector.

    use Standard_Dense_Series_Matrices;

    A : Standard_Dense_Series_Matrices.Matrix(1..n,1..m)
      := Standard_Random_Series.Random_Series_Matrix(1,n,1,m,order);
    x : Standard_Dense_Series_Vectors.Vector(1..m)
      := Standard_Random_Series.Random_Series_Vector(1,m,order);
    b : Standard_Dense_Series_Vectors.Vector(1..n) := A*x;
    wrk : Standard_Dense_Series_Matrices.Matrix(1..n,1..m) := A;
    ipvt : Standard_Integer_Vectors.Vector(A'range(2));
    qraux : Standard_Dense_Series_Vectors.Vector(A'range(2));

  begin
    put_line("The coefficient matrix A :"); Write(A);
    put_line("The solution x :"); Write(x);
    put_line("The right hand side vector b :"); Write(b);
    QRD(wrk,qraux,ipvt,false);
  end Random_Least_Squares;

  procedure Main is

  -- DESCRIPTION :
  --   Prompts the user for the dimension of the linear system
  --   and the order of the series.

    dim,ord,nrows,ncols : integer32 := 0;
    ans : character;

  begin
    new_line;
    put("Give the order of the series : "); get(ord);
    new_line;
    put("Square system ? (y/n) ");
    Ask_Yes_or_No(ans);
    if ans = 'y' then
      put("Give the dimension : "); get(dim);
      Random_Linear_Solve(dim,ord);
    else
      put("Give number number of rows : "); get(nrows);
      put("Give number number of colums : "); get(ncols);
      Random_Least_Squares(nrows,ncols,ord);
    end if;
  end Main;

begin
  Main;
end ts_sermat;
