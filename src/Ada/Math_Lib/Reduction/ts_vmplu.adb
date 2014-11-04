with text_io;                           use text_io;
with Communications_with_User;          use Communications_with_User;
with Standard_Natural_Numbers;          use Standard_Natural_Numbers;
with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;       use Standard_Integer_Numbers_io;
with Standard_Floating_Numbers;         use Standard_Floating_Numbers;
with Standard_Floating_Numbers_io;      use Standard_Floating_Numbers_io;
with Standard_Complex_Numbers;
with Standard_Complex_Numbers_io;       use Standard_Complex_Numbers_io;
with Double_Double_Numbers;             use Double_Double_Numbers;
with Double_Double_Numbers_io;          use Double_Double_Numbers_io;
with Quad_Double_Numbers;               use Quad_Double_Numbers;
with Quad_Double_Numbers_io;            use Quad_Double_Numbers_io;
with DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Numbers_io;       use DoblDobl_Complex_Numbers_io;
with QuadDobl_Complex_Numbers;
with QuadDobl_Complex_Numbers_io;       use QuadDobl_Complex_Numbers_io;
with Standard_Mathematical_Functions;   use Standard_Mathematical_Functions;
with DoblDobl_Mathematical_Functions;   use DoblDobl_Mathematical_Functions;
with QuadDobl_Mathematical_Functions;   use QuadDobl_Mathematical_Functions;
with Standard_Integer_Vectors;
with Standard_Floating_Vectors;
with Standard_Floating_Vectors_io;      use Standard_Floating_Vectors_io;
with Standard_Floating_Matrices;
with Standard_Floating_Matrices_io;     use Standard_Floating_Matrices_io;
with Standard_Complex_Vectors;
with Standard_Complex_Vectors_io;       use Standard_Complex_Vectors_io;
with Standard_Complex_Matrices;
with Double_Double_Vectors;
with Double_Double_Vectors_io;          use Double_Double_Vectors_io;
with Double_Double_Matrices;
with Quad_Double_Vectors;
with Quad_Double_Vectors_io;            use Quad_Double_Vectors_io;
with Quad_Double_Matrices;
with DoblDobl_Complex_Vectors;
with DoblDobl_Complex_Vectors_io;       use DoblDobl_Complex_Vectors_io;
with DoblDobl_Complex_Matrices;
with QuadDobl_Complex_Vectors;
with QuadDobl_Complex_Vectors_io;       use QuadDobl_Complex_Vectors_io;
with QuadDobl_Complex_Matrices;
with VarbPrec_Matrix_Conversions;       use VarbPrec_Matrix_Conversions;
with Standard_Random_Matrices;
with DoblDobl_Random_Matrices;
with QuadDobl_Random_Matrices;
with Random_Conditioned_Matrices;       use Random_Conditioned_Matrices;
with Standard_Floating_Linear_Solvers;
with Standard_Complex_Linear_Solvers;
with Double_Double_Linear_Solvers;
with Quad_Double_Linear_Solvers;
with DoblDobl_Complex_Linear_Solvers;
with QuadDobl_Complex_Linear_Solvers;
with VarbPrec_Floating_Linear_Solvers;  use VarbPrec_Floating_Linear_Solvers;
with VarbPrec_Complex_Linear_Solvers;   use VarbPrec_Complex_Linear_Solvers;

procedure ts_vmplu is

-- DESCRIPTION :
--   Test on variable precision linear system solving with LU decomposition,
--   with real and complex standard double and double double numbers.
--   We simulate the variable precision to achieve a wanted number of
--   correct decimal places when solving a linear system.
--   It is important that for large condition numbers, the coefficient
--   matrix of the system is computed with sufficiently high precision.

  procedure Standard_Real_Solve
              ( dim,want_dcp : in integer32;
                mat : in Standard_Floating_Matrices.Matrix ) is

  -- DESCRIPTION :
  --   Makes a righthandside vector b so x = (1,1,..,1) is the exact solution.
  --   Solves the linear system in standard double floating-point arithmetic.
  --   Verifies whether the computed solution has indeed at least as many 
  --   decimal places correct as the value of want_dcp.

    x : constant Standard_Floating_Vectors.Vector(1..dim) := (1..dim => 1.0);
    b : Standard_Floating_Vectors.Vector(1..dim);
    wrk : Standard_Floating_Matrices.Matrix(1..dim,1..dim) := mat;
    piv : Standard_Integer_Vectors.Vector(1..dim);
    inf : integer32;
    tol : constant double_float := 10.0**(integer(-want_dcp - 1));
    okay : boolean := true;
    adf : double_float;
  
    use Standard_Floating_Matrices;

  begin
    b := mat*x;
    Standard_Floating_Linear_Solvers.lufac(wrk,dim,piv,inf);
    Standard_Floating_Linear_Solvers.lusolve(wrk,dim,piv,b);
    put_line("The computed solution :"); put_line(b);
    for i in b'range loop
      adf := abs(b(i) - x(i));
      if adf > tol then
        put("x("); put(i,1); put(") = "); put(b(i));
        put_line(" is off!"); okay := false;
      end if;
      exit when not okay;
    end loop;
    if okay then
      put("Solution accurate with at least ");
      put(want_dcp,1); put_line(" decimal places.");
    else
      put("Accuracy of "); put(want_dcp,1); 
      put_line(" decimal places is not obtained.");
    end if;
  end Standard_Real_Solve;

  procedure Standard_Complex_Solve
              ( dim,want_dcp : in integer32;
                mat : in Standard_Complex_Matrices.Matrix ) is

  -- DESCRIPTION :
  --   Makes a righthandside vector b so x = (1,1,..,1) is the exact solution.
  --   Solves the linear system in standard double floating-point arithmetic.
  --   Verifies whether the computed solution has indeed at least as many 
  --   decimal places correct as the value of want_dcp.

    use Standard_Complex_Numbers;

    one : constant Complex_Number := create(1.0);
    x : constant Standard_Complex_Vectors.Vector(1..dim) := (1..dim => one);
    b : Standard_Complex_Vectors.Vector(1..dim);
    wrk : Standard_Complex_Matrices.Matrix(1..dim,1..dim) := mat;
    piv : Standard_Integer_Vectors.Vector(1..dim);
    inf : integer32;
    tol : constant double_float := 10.0**(integer(-want_dcp - 1));
    okay : boolean := true;
    adf : double_float;
  
    use Standard_Complex_Matrices;

  begin
    b := mat*x;
    Standard_Complex_Linear_Solvers.lufac(wrk,dim,piv,inf);
    Standard_Complex_Linear_Solvers.lusolve(wrk,dim,piv,b);
    put_line("The computed solution :"); put_line(b);
    for i in b'range loop
      adf := AbsVal(b(i) - x(i));
      if adf > tol then
        put("x("); put(i,1); put(") = "); put(b(i));
        put_line(" is off!"); okay := false;
      end if;
      exit when not okay;
    end loop;
    if okay then
      put("Solution accurate with at least ");
      put(want_dcp,1); put_line(" decimal places.");
    else
      put("Accuracy of "); put(want_dcp,1); 
      put_line(" decimal places is not obtained.");
    end if;
  end Standard_Complex_Solve;

  procedure DoblDobl_Real_Solve
              ( dim,want_dcp : in integer32;
                mat : in Double_Double_Matrices.Matrix ) is

  -- DESCRIPTION :
  --   Makes a righthandside vector b so x = (1,1,..,1) is the exact solution.
  --   Solves the linear system in double double floating-point arithmetic.
  --   Verifies whether the computed solution has indeed at least as many 
  --   decimal places correct as the value of want_dcp.

    one : constant double_double := create(1.0);
    x : constant Double_Double_Vectors.Vector(1..dim) := (1..dim => one);
    b : Double_Double_Vectors.Vector(1..dim);
    wrk : Double_Double_Matrices.Matrix(1..dim,1..dim) := mat;
    piv : Standard_Integer_Vectors.Vector(1..dim);
    inf : integer32;
    tol : constant double_float := 10.0**(integer(-want_dcp - 1));
    okay : boolean := true;
    adf : double_double;
  
    use Double_Double_Matrices;

  begin
    b := mat*x;
    Double_Double_Linear_Solvers.lufac(wrk,dim,piv,inf);
    Double_Double_Linear_Solvers.lusolve(wrk,dim,piv,b);
    put_line("The computed solution :"); put_line(b);
    for i in b'range loop
      adf := abs(b(i) - x(i));
      if adf > tol then
        put("x("); put(i,1); put(") = "); put(b(i));
        put_line(" is off!"); okay := false;
      end if;
      exit when not okay;
    end loop;
    if okay then
      put("Solution accurate with at least ");
      put(want_dcp,1); put_line(" decimal places.");
    else
      put("Accuracy of "); put(want_dcp,1); 
      put_line(" decimal places is not obtained.");
    end if;
  end DoblDobl_Real_Solve;

  procedure DoblDobl_Complex_Solve
              ( dim,want_dcp : in integer32;
                mat : in DoblDobl_Complex_Matrices.Matrix ) is

  -- DESCRIPTION :
  --   Makes a righthandside vector b so x = (1,1,..,1) is the exact solution.
  --   Solves the linear system in double double floating-point arithmetic.
  --   Verifies whether the computed solution has indeed at least as many 
  --   decimal places correct as the value of want_dcp.

    use DoblDobl_Complex_Numbers;

    dd_one : constant double_double := create(1.0);
    one : constant Complex_Number := create(dd_one);
    x : constant DoblDobl_Complex_Vectors.Vector(1..dim) := (1..dim => one);
    b : DoblDobl_Complex_Vectors.Vector(1..dim);
    wrk : DoblDobl_Complex_Matrices.Matrix(1..dim,1..dim) := mat;
    piv : Standard_Integer_Vectors.Vector(1..dim);
    inf : integer32;
    tol : constant double_float := 10.0**(integer(-want_dcp - 1));
    okay : boolean := true;
    adf : double_double;
  
    use DoblDobl_Complex_Matrices;

  begin
    b := mat*x;
    DoblDobl_Complex_Linear_Solvers.lufac(wrk,dim,piv,inf);
    DoblDobl_Complex_Linear_Solvers.lusolve(wrk,dim,piv,b);
    put_line("The computed solution :"); put_line(b);
    for i in b'range loop
      adf := AbsVal(b(i) - x(i));
      if adf > tol then
        put("x("); put(i,1); put(") = "); put(b(i));
        put_line(" is off!"); okay := false;
      end if;
      exit when not okay;
    end loop;
    if okay then
      put("Solution accurate with at least ");
      put(want_dcp,1); put_line(" decimal places.");
    else
      put("Accuracy of "); put(want_dcp,1); 
      put_line(" decimal places is not obtained.");
    end if;
  end DoblDobl_Complex_Solve;

  procedure QuadDobl_Real_Solve
              ( dim,want_dcp : in integer32;
                mat : in Quad_Double_Matrices.Matrix ) is

  -- DESCRIPTION :
  --   Makes a righthandside vector b so x = (1,1,..,1) is the exact solution.
  --   Solves the linear system in quad double floating-point arithmetic.
  --   Verifies whether the computed solution has indeed at least as many 
  --   decimal places correct as the value of want_dcp.

    one : constant quad_double := create(1.0);
    x : constant Quad_Double_Vectors.Vector(1..dim) := (1..dim => one);
    b : Quad_Double_Vectors.Vector(1..dim);
    wrk : Quad_Double_Matrices.Matrix(1..dim,1..dim) := mat;
    piv : Standard_Integer_Vectors.Vector(1..dim);
    inf : integer32;
    tol : constant double_float := 10.0**(integer(-want_dcp - 1));
    okay : boolean := true;
    adf : quad_double;
  
    use Quad_Double_Matrices;

  begin
    b := mat*x;
    Quad_Double_Linear_Solvers.lufac(wrk,dim,piv,inf);
    Quad_Double_Linear_Solvers.lusolve(wrk,dim,piv,b);
    put_line("The computed solution :"); put_line(b);
    for i in b'range loop
      adf := abs(b(i) - x(i));
      if adf > tol then
        put("x("); put(i,1); put(") = "); put(b(i));
        put_line(" is off!"); okay := false;
      end if;
      exit when not okay;
    end loop;
    if okay then
      put("Solution accurate with at least ");
      put(want_dcp,1); put_line(" decimal places.");
    else
      put("Accuracy of "); put(want_dcp,1); 
      put_line(" decimal places is not obtained.");
    end if;
  end QuadDobl_Real_Solve;

  procedure QuadDobl_Complex_Solve
              ( dim,want_dcp : in integer32;
                mat : in QuadDobl_Complex_Matrices.Matrix ) is

  -- DESCRIPTION :
  --   Makes a righthandside vector b so x = (1,1,..,1) is the exact solution.
  --   Solves the linear system in double double floating-point arithmetic.
  --   Verifies whether the computed solution has indeed at least as many 
  --   decimal places correct as the value of want_dcp.

    use QuadDobl_Complex_Numbers;

    qd_one : constant quad_double := create(1.0);
    one : constant Complex_Number := create(qd_one);
    x : constant QuadDobl_Complex_Vectors.Vector(1..dim) := (1..dim => one);
    b : QuadDobl_Complex_Vectors.Vector(1..dim);
    wrk : QuadDobl_Complex_Matrices.Matrix(1..dim,1..dim) := mat;
    piv : Standard_Integer_Vectors.Vector(1..dim);
    inf : integer32;
    tol : constant double_float := 10.0**(integer(-want_dcp - 1));
    okay : boolean := true;
    adf : quad_double;
  
    use QuadDobl_Complex_Matrices;

  begin
    b := mat*x;
    QuadDobl_Complex_Linear_Solvers.lufac(wrk,dim,piv,inf);
    QuadDobl_Complex_Linear_Solvers.lusolve(wrk,dim,piv,b);
    put_line("The computed solution :"); put_line(b);
    for i in b'range loop
      adf := AbsVal(b(i) - x(i));
      if adf > tol then
        put("x("); put(i,1); put(") = "); put(b(i));
        put_line(" is off!"); okay := false;
      end if;
      exit when not okay;
    end loop;
    if okay then
      put("Solution accurate with at least ");
      put(want_dcp,1); put_line(" decimal places.");
    else
      put("Accuracy of "); put(want_dcp,1); 
      put_line(" decimal places is not obtained.");
    end if;
  end QuadDobl_Complex_Solve;

  procedure Standard_Real_Test ( n : in integer32; c : in double_float ) is

  -- DESCRIPTION :
  --   Generates a random n-dimensional matrix with condition number c
  --   and calls the LU factorization with condition number estimator.

    mat : Standard_Floating_Matrices.Matrix(1..n,1..n)
        := Random_Conditioned_Matrix(n,c);
    loss_dcp,want_dcp : integer32 := 0;
    precision : integer32 := 16;

  begin
    new_line;
    put("The given condition number :"); put(c,3); new_line;
    loss_dcp := Estimated_Loss_of_Decimal_Places(mat);
    put("-> Estimated loss of decimal places : "); put(loss_dcp,1); new_line;
    new_line;
    put("Give the wanted number of decimal places : "); get(want_dcp);
    precision := precision + loss_dcp;
    put("-> Number of decimal places left in precision : ");
    put(precision,1); new_line;
    if precision >= want_dcp then
      put_line("-> Standard double precision will suffice, solving ...");
      Standard_Real_Solve(n,want_dcp,mat);
    else
      put_line("-> Standard double precision will not suffice.");
      precision := 32 + loss_dcp;
      if precision >= want_dcp then
        declare
          dd_mat : constant Double_Double_Matrices.Matrix(1..n,1..n)
                 := d2dd(mat);
        begin
          put_line("-> Double double precision will suffice.");
          DoblDobl_Real_Solve(n,want_dcp,dd_mat);
        end;
      else
        put_line("-> Double double precision will not suffice.");
        precision := 64 + loss_dcp;
        if precision >= want_dcp then
          declare
            qd_mat : constant Quad_Double_Matrices.Matrix(1..n,1..n)
                   := d2qd(mat);
          begin
            put_line("-> Quad double precision will suffice.");
            QuadDobl_Real_Solve(n,want_dcp,qd_mat);
          end;
        else
          put_line("-> Quad double precision will not suffice.");
        end if;
      end if;
    end if;
  end Standard_Real_Test;

  procedure DoblDobl_Real_Test ( n : in integer32; c : in double_float ) is

  -- DESCRIPTION :
  --   Generates a random n-dimensional matrix with condition number c
  --   and calls the LU factorization with condition number estimator.

    mat : Double_Double_Matrices.Matrix(1..n,1..n)
        := Random_Conditioned_Matrix(n,c);
    loss_dcp,want_dcp : integer32 := 0;
    precision : integer32 := 32;

  begin
    new_line;
    put("The given condition number :"); put(c,3); new_line;
    loss_dcp := Estimated_Loss_of_Decimal_Places(mat);
    put("-> Estimated loss of decimal places : "); put(loss_dcp,1); new_line;
    new_line;
    put("Give the wanted number of decimal places : "); get(want_dcp);
    precision := precision + loss_dcp;
    put("-> Number of decimal places left in precision : ");
    put(precision,1); new_line;
    if precision >= want_dcp then
      put_line("-> Double double precision will suffice.");
      DoblDobl_Real_Solve(n,want_dcp,mat);
    else
      put_line("-> Double double precision will not suffice.");
      precision := 64 + loss_dcp;
      if precision >= want_dcp then
        declare
          qd_mat : constant Quad_Double_Matrices.Matrix(1..n,1..n)
                 := dd2qd(mat);
        begin
          put_line("-> Quad double precision will suffice.");
          QuadDobl_Real_Solve(n,want_dcp,qd_mat);
        end;
      else
        put_line("-> Quad double precision will not suffice.");
      end if;
    end if;
  end DoblDobl_Real_Test;

  procedure QuadDobl_Real_Test ( n : in integer32; c : in double_float ) is

  -- DESCRIPTION :
  --   Generates a random n-dimensional matrix with condition number c
  --   and calls the LU factorization with condition number estimator.

    mat : Quad_Double_Matrices.Matrix(1..n,1..n)
        := Random_Conditioned_Matrix(n,c);
    loss_dcp,want_dcp : integer32 := 0;
    precision : integer32 := 64;

  begin
    new_line;
    put("The given condition number :"); put(c,3); new_line;
    loss_dcp := Estimated_Loss_of_Decimal_Places(mat);
    put("-> Estimated loss of decimal places : "); put(loss_dcp,1); new_line;
    new_line;
    put("Give the wanted number of decimal places : "); get(want_dcp);
    precision := precision + loss_dcp;
    put("-> Number of decimal places left in precision : ");
    put(precision,1); new_line;
    if precision >= want_dcp then
      put_line("-> Quad double precision will suffice.");
      QuadDobl_Real_Solve(n,want_dcp,mat);
    else
      put_line("-> Quad double precision will not suffice.");
    end if;
  end QuadDobl_Real_Test;

  procedure Standard_Complex_Test ( n : in integer32; c : in double_float ) is

  -- DESCRIPTION :
  --   Generates a random n-dimensional matrix with condition number c
  --   and calls the LU factorization with condition number estimator.

    mat : Standard_Complex_Matrices.Matrix(1..n,1..n)
        := Random_Conditioned_Matrix(n,c);
    loss_dcp,want_dcp : integer32 := 0;
    precision : integer32 := 16;

  begin
    new_line;
    put("The given condition number :"); put(c,3); new_line;
    loss_dcp := Estimated_Loss_of_Decimal_Places(mat);
    put("-> Estimated loss of decimal places : "); put(loss_dcp,1); new_line;
    new_line;
    put("Give the wanted number of decimal places : "); get(want_dcp);
    precision := precision + loss_dcp;
    put("-> Number of decimal places left in precision : ");
    put(precision,1); new_line;
    if precision >= want_dcp then
      put_line("-> Standard double precision will suffice, solving ...");
      Standard_Complex_Solve(n,want_dcp,mat);
    else
      put_line("-> Standard double precision will not suffice.");
      precision := 32 + loss_dcp;
      if precision >= want_dcp then
        declare
          dd_mat : constant DoblDobl_Complex_Matrices.Matrix(1..n,1..n)
                 := d2dd(mat);
        begin
          put_line("-> Double double precision will suffice.");
          DoblDobl_Complex_Solve(n,want_dcp,dd_mat);
        end;
      else
        put_line("-> Double double precision will not suffice.");
        precision := 64 + loss_dcp;
        if precision >= want_dcp then
          declare
            qd_mat : constant QuadDobl_Complex_Matrices.Matrix(1..n,1..n)
                   := d2qd(mat);
          begin
            put_line("-> Quad double precision will suffice.");
            QuadDobl_Complex_Solve(n,want_dcp,qd_mat);
          end;
        else
          put_line("Quad double precision will not suffice.");
        end if;
      end if;
    end if;
  end Standard_Complex_Test;

  procedure DoblDobl_Complex_Test ( n : in integer32; c : in double_float ) is

  -- DESCRIPTION :
  --   Generates a random n-dimensional matrix with condition number c
  --   and calls the LU factorization with condition number estimator.

    mat : DoblDobl_Complex_Matrices.Matrix(1..n,1..n)
        := Random_Conditioned_Matrix(n,c);
    loss_dcp,want_dcp : integer32 := 0;
    precision : integer32 := 32;

  begin
    new_line;
    put("The given condition number :"); put(c,3); new_line;
    loss_dcp := Estimated_Loss_of_Decimal_Places(mat);
    put("-> Estimated loss of decimal places : "); put(loss_dcp,1); new_line;
    new_line;
    put("Give the wanted number of decimal places : "); get(want_dcp);
    precision := precision + loss_dcp;
    put("-> Number of decimal places left in precision : ");
    put(precision,1); new_line;
    if precision >= want_dcp then
      put_line("-> Double double precision will suffice.");
      DoblDobl_Complex_Solve(n,want_dcp,mat);
    else
      put_line("-> Double double precision will not suffice.");
      precision := 64 + loss_dcp;
      if precision >= want_dcp then
        declare
          qd_mat : constant QuadDobl_Complex_Matrices.Matrix(1..n,1..n)
                 := dd2qd(mat);
        begin
          put_line("-> Quad double precision will suffice.");
          QuadDobl_Complex_Solve(n,want_dcp,qd_mat);
        end;
      else
        put_line("Quad double precision will not suffice.");
      end if;
    end if;
  end DoblDobl_Complex_Test;

  procedure QuadDobl_Complex_Test ( n : in integer32; c : in double_float ) is

  -- DESCRIPTION :
  --   Generates a random n-dimensional matrix with condition number c
  --   and calls the LU factorization with condition number estimator.

    mat : QuadDobl_Complex_Matrices.Matrix(1..n,1..n)
        := Random_Conditioned_Matrix(n,c);
    loss_dcp,want_dcp : integer32 := 0;
    precision : integer32 := 64;

  begin
    new_line;
    put("The given condition number :"); put(c,3); new_line;
    loss_dcp := Estimated_Loss_of_Decimal_Places(mat);
    put("-> Estimated loss of decimal places : "); put(loss_dcp,1); new_line;
    new_line;
    put("Give the wanted number of decimal places : "); get(want_dcp);
    precision := precision + loss_dcp;
    put("-> Number of decimal places left in precision : ");
    put(precision,1); new_line;
    precision := precision + loss_dcp;
    put("-> Number of decimal places left in precision : ");
    put(precision,1); new_line;
    if precision >= want_dcp then
      put_line("-> Quad double precision will suffice.");
      QuadDobl_Complex_Solve(n,want_dcp,mat);
    else
      put_line("-> Quad double precision will not suffice.");
    end if;
  end QuadDobl_Complex_Test;

  procedure Main is

  -- DESCRIPTION :
  --   Prompts the user for the dimension, condition number,
  --   and ask whether real or complex arithmetic is needed.

    dim : integer32 := 0;
    cnd : double_float := 1.0;
    ans : character;
    exl : integer32;

  begin
    new_line;
    put_line("Interactive test on variable precision LU decomposition ...");
    put("Give the dimension : "); get(dim);
    put("Give the condition number : "); get(cnd);
    exl := integer32(log10(cnd));
    put("-> expected loss of accuracy : "); put(exl,1); new_line;
    put("Real or complex arithmetic ? (r/c) ");
    Ask_Alternative(ans,"rc");
    if ans = 'r' then
      if exl < 16 then
        Standard_Real_Test(dim,cnd);
      elsif exl < 32 then
        DoblDobl_Real_Test(dim,cnd);
      else
        QuadDobl_Real_Test(dim,cnd);
      end if;
    else
      if exl < 16 then
        Standard_Complex_Test(dim,cnd);
      elsif exl < 32 then
        DoblDobl_Complex_Test(dim,cnd);
      else
        QuadDobl_Complex_Test(dim,cnd);
      end if;
    end if;
  end Main;

begin
  Main;
end ts_vmplu;
