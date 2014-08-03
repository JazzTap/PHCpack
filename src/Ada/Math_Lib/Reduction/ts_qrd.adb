with text_io;                            use text_io;
with Communications_with_User;           use Communications_with_User;
with Timing_Package;                     use Timing_Package;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;        use Standard_Integer_Numbers_io;
with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Standard_Floating_Numbers_io;       use Standard_Floating_Numbers_io;
with Double_Double_Numbers;              use Double_Double_Numbers;
with Double_Double_Numbers_io;           use Double_Double_Numbers_io;
with Standard_Complex_Numbers;
with DoblDobl_Complex_Numbers;
with Standard_Integer_Vectors;
with Standard_Integer_Vectors_io;        use Standard_Integer_Vectors_io;
with Standard_Floating_Vectors;
with Standard_Floating_Vectors_io;       use Standard_Floating_Vectors_io;
with Standard_Floating_Matrices;
with Standard_Floating_Matrices_io;      use Standard_Floating_Matrices_io;
with Standard_Random_Vectors;            use Standard_Random_Vectors;
with Standard_Random_Matrices;           use Standard_Random_Matrices;
with Standard_Floating_Norms_Equals;     use Standard_Floating_Norms_Equals;
with Standard_Floating_QR_Least_Squares; use Standard_Floating_QR_Least_Squares;
with Standard_Complex_Vectors;
with Standard_Complex_Vectors_io;        use Standard_Complex_Vectors_io;
with Standard_Complex_Matrices;
with Standard_Complex_Matrices_io;       use Standard_Complex_Matrices_io;
with Standard_Complex_Norms_Equals;      use Standard_Complex_Norms_Equals;
with Standard_Complex_QR_Least_Squares;  use Standard_Complex_QR_Least_Squares;
with DoblDobl_Complex_Vectors;
with DoblDobl_Complex_Vectors_io;        use DoblDobl_Complex_Vectors_io;
with DoblDobl_Complex_Matrices;
with DoblDobl_Complex_Matrices_io;       use DoblDobl_Complex_Matrices_io;
with DoblDobl_Complex_Vector_Norms;      use DoblDobl_Complex_Vector_Norms;
with DoblDobl_Random_Vectors;            use DoblDobl_Random_Vectors;
with DoblDobl_Random_Matrices;           use DoblDobl_Random_Matrices;
with DoblDobl_Complex_QR_Least_Squares;  use DoblDobl_Complex_QR_Least_Squares;
with Multprec_Floating_Numbers;          use Multprec_Floating_Numbers;
with Multprec_Floating_Numbers_io;       use Multprec_Floating_Numbers_io;
with Multprec_Complex_Numbers;
with Multprec_Complex_Vectors;
with Multprec_Complex_Vectors_io;        use Multprec_Complex_Vectors_io;
with Multprec_Complex_Matrices;
with Multprec_Complex_Matrices_io;       use Multprec_Complex_Matrices_io;
with Multprec_Random_Vectors;            use Multprec_Random_Vectors;
with Multprec_Random_Matrices;           use Multprec_Random_Matrices;
with Multprec_Complex_Norms_Equals;      use Multprec_Complex_Norms_Equals;
with Multprec_Complex_QR_Least_Squares;  use Multprec_Complex_QR_Least_Squares;

procedure ts_qrd is

-- DESCRIPTION :
--   This program tests the implementation of the QR decomposition
--   and least squares approximation.

-- GENERAL TESTS ON QR DECOMPOSITION :

  function Extract_Upper_Triangular
                ( a : Standard_Floating_Matrices.Matrix )
                return Standard_Floating_Matrices.Matrix is

  -- DESCRIPTION :
  --   Returns the upper triangular part of the matrix a.

    res : Standard_Floating_Matrices.Matrix(a'range(1),a'range(2));

  begin
    for i in a'range(1) loop
      for j in a'first(2)..(i-1) loop
        res(i,j) := 0.0;
      end loop;
      for j in i..a'last(2) loop
        res(i,j) := a(i,j);
      end loop;
    end loop;
    return res;
  end Extract_Upper_Triangular;

  function Extract_Upper_Triangular
                ( a : Standard_Complex_Matrices.Matrix )
                return Standard_Complex_Matrices.Matrix is

  -- DESCRIPTION :
  --   Returns the upper triangular part of the matrix a.

    use Standard_Complex_Numbers;
    res : Standard_Complex_Matrices.Matrix(a'range(1),a'range(2));

  begin
    for i in a'range(1) loop
      for j in a'first(2)..(i-1) loop
        res(i,j) := Create(0.0);
      end loop;
      for j in i..a'last(2) loop
        res(i,j) := a(i,j);
      end loop;
    end loop;
    return res;
  end Extract_Upper_Triangular;

  function Extract_Upper_Triangular
                ( a : DoblDobl_Complex_Matrices.Matrix )
                return DoblDobl_Complex_Matrices.Matrix is

  -- DESCRIPTION :
  --   Returns the upper triangular part of the matrix a.

    use DoblDobl_Complex_Numbers;
    res : DoblDobl_Complex_Matrices.Matrix(a'range(1),a'range(2));
    zero : constant double_double := create(0.0);

  begin
    for i in a'range(1) loop
      for j in a'first(2)..(i-1) loop
        res(i,j) := Create(zero);
      end loop;
      for j in i..a'last(2) loop
        res(i,j) := a(i,j);
      end loop;
    end loop;
    return res;
  end Extract_Upper_Triangular;

  function Extract_Upper_Triangular
                ( a : Multprec_Complex_Matrices.Matrix )
                return Multprec_Complex_Matrices.Matrix is

  -- DESCRIPTION :
  --   Returns the upper triangular part of the matrix a.

    use Multprec_Complex_Numbers;
    res : Multprec_Complex_Matrices.Matrix(a'range(1),a'range(2));

  begin
    for i in a'range(1) loop
      for j in a'first(2)..(i-1) loop
        res(i,j) := Create(integer(0));
      end loop;
      for j in i..a'last(2) loop
        Copy(a(i,j),res(i,j));
      end loop;
    end loop;
    return res;
  end Extract_Upper_Triangular;

  function Differences ( a,b : in Standard_Floating_Matrices.Matrix )
                       return double_float is

  -- DESCRIPTION :
  --   Returns the sum of the differences of all elements |a(i,j)-b(i,j)|.

    sum : double_float := 0.0;

  begin
    for i in a'range(1) loop
      for j in a'range(2) loop
        sum := sum + abs(a(i,j)-b(i,j));
      end loop;
    end loop;
    return sum;
  end Differences;

  function Differences ( a,b : in Standard_Complex_Matrices.Matrix )
                       return double_float is

  -- DESCRIPTION :
  --   Returns the sum of the differences of all elements |a(i,j)-b(i,j)|.

    use Standard_Complex_Numbers;
    sum : double_float := 0.0;

  begin
    for i in a'range(1) loop
      for j in a'range(2) loop
        sum := sum + AbsVal(a(i,j)-b(i,j));
      end loop;
    end loop;
    return sum;
  end Differences;

  function Differences ( a,b : in DoblDobl_Complex_Matrices.Matrix )
                       return double_double is

  -- DESCRIPTION :
  --   Returns the sum of the differences of all elements |a(i,j)-b(i,j)|.

    use DoblDobl_Complex_Numbers;
    sum : double_double := create(0.0);

  begin
    for i in a'range(1) loop
      for j in a'range(2) loop
        sum := sum + AbsVal(a(i,j)-b(i,j));
      end loop;
    end loop;
    return sum;
  end Differences;

  function Differences ( a,b : in Multprec_Complex_Matrices.Matrix )
                       return Floating_Number is

  -- DESCRIPTION :
  --   Returns the sum of the differences of all elements |a(i,j)-b(i,j)|.

    use Multprec_Complex_Numbers;
    sum : Floating_Number := Create(0.0);
    dif : Complex_Number;
    absdif : Floating_Number;

  begin
    for i in a'range(1) loop
      for j in a'range(2) loop
        dif := a(i,j) - b(i,j);
        absdif := AbsVal(dif);
        Add(sum,absdif);
        Clear(dif); Clear(absdif);
      end loop;
    end loop;
    return sum;
  end Differences;

  function Orthogonality_Check_Sum
             ( q : Standard_Floating_Matrices.Matrix )
             return double_float is

  -- DESCRIPTION :
  --   Tests whether the columns are orthogonal w.r.t. each other,
  --   returns the sum of all inner products of any column in q 
  --   with all its following columns.

    sum,ip : double_float;

  begin
    sum := 0.0;
    for j in q'range(2) loop
      for k in j+1..q'last(2) loop
        ip := 0.0;
        for i in q'range(1) loop
          ip := ip + q(i,j)*q(i,k);
        end loop;
        sum := sum + abs(ip);
      end loop;
    end loop;
    return sum;
  end Orthogonality_Check_Sum;

  function Orthogonality_Check_Sum 
             ( q : Standard_Complex_Matrices.Matrix )
             return double_float is

  -- DESCRIPTION :
  --   Tests whether the columns are orthogonal w.r.t. each other,
  --   returns the sum of all inner products of any column in q with
  --   its following columns.

    use Standard_Complex_Numbers;
    sum : double_float := 0.0;
    ip : Complex_Number;

  begin
    for j in q'range(2) loop
      for k in j+1..q'last(2) loop
        ip := Create(0.0);
        for i in q'range(1) loop
          ip := ip + Conjugate(q(i,j))*q(i,k);
        end loop;
        sum := sum + AbsVal(ip);
      end loop;
    end loop;
    return sum;
  end Orthogonality_Check_Sum;

  function Orthogonality_Check_Sum 
             ( q : DoblDobl_Complex_Matrices.Matrix )
             return double_double is

  -- DESCRIPTION :
  --   Tests whether the columns are orthogonal w.r.t. each other,
  --   returns the sum of all inner products of any column in q with
  --   its following columns.

    use DoblDobl_Complex_Numbers;
    zero : constant double_double := create(0.0);
    sum : double_double := zero;
    ip : Complex_Number;

  begin
    for j in q'range(2) loop
      for k in j+1..q'last(2) loop
        ip := Create(zero);
        for i in q'range(1) loop
          ip := ip + Conjugate(q(i,j))*q(i,k);
        end loop;
        sum := sum + AbsVal(ip);
      end loop;
    end loop;
    return sum;
  end Orthogonality_Check_Sum;

  function Orthogonality_Check_Sum
             ( q : Multprec_Complex_Matrices.Matrix )
             return Floating_Number is

  -- DESCRIPTION :
  --   Tests whether the columns are orthogonal w.r.t. each other,
  --   returns the sum of all inner products of a column with all
  --   its following columns.

    use Multprec_Complex_Numbers;
    sum : Floating_Number := Create(0.0);
    absip : Floating_Number;
    ip,acc : Complex_Number;

  begin
    for j in q'range(2) loop
      for k in j+1..q'last(2) loop
        ip := Create(integer(0));
        for i in q'range(1) loop
          acc := Conjugate(q(i,j));
          Mul(acc,q(i,k));
          Add(ip,acc);
          Clear(acc);
        end loop;
        absip := AbsVal(ip);
        Add(sum,absip);
        Clear(ip);
        Clear(absip);
      end loop;
    end loop;
    return sum;
  end Orthogonality_Check_Sum;

  procedure Test_QRD ( a,q,r : in Standard_Floating_Matrices.Matrix;
                       output : in boolean ) is

    wrk : Standard_Floating_Matrices.Matrix(a'range(1),a'range(2));
    use Standard_Floating_Matrices;

  begin
    if output
     then put_line("The upper triangular part R :"); put(r,3);
    end if;
    wrk := q*r;
    if output
     then put_line("q*r :"); put(wrk,3); 
    end if;
    put("Difference in 1-norm between the matrix and q*r : ");
    put(Differences(a,wrk),3,3,3); new_line;
    put("Orthogonality check sum : ");
    put(Orthogonality_Check_Sum(q),3,3,3); new_line;
  end Test_QRD;

  procedure Test_QRD ( a,q,r : in Standard_Complex_Matrices.Matrix;
                       output : in boolean ) is

    wrk : Standard_Complex_Matrices.Matrix(a'range(1),a'range(2));
    use Standard_Complex_Matrices;

  begin
    if output
     then put_line("The upper triangular part R :"); put(r,3);
    end if;
    wrk := q*r;
    if output
     then put_line("q*r :"); put(wrk,3); 
    end if;
    put("Difference in 1-norm between the matrix and q*r : ");
    put(Differences(a,wrk),3,3,3); new_line;
    put("Orthogonality check sum : ");
    put(Orthogonality_Check_Sum(q),3,3,3); new_line;
  end Test_QRD;

  procedure Test_QRD ( a,q,r : in DoblDobl_Complex_Matrices.Matrix;
                       output : in boolean ) is

    wrk : DoblDobl_Complex_Matrices.Matrix(a'range(1),a'range(2));
    use DoblDobl_Complex_Matrices;

  begin
    if output
     then put_line("The upper triangular part R :"); put(r,3);
    end if;
    wrk := q*r;
    if output
     then put_line("q*r :"); put(wrk,3); 
    end if;
    put("Difference in 1-norm between the matrix and q*r : ");
    put(Differences(a,wrk),3); new_line;
    put("Orthogonality check sum : ");
    put(Orthogonality_Check_Sum(q),3); new_line;
  end Test_QRD;

  procedure Test_QRD ( a,q,r : in Multprec_Complex_Matrices.Matrix;
                       output : in boolean ) is

    wrk : Multprec_Complex_Matrices.Matrix(a'range(1),a'range(2));
    use Multprec_Complex_Matrices;
    dif : Floating_Number;

  begin
    if output
     then put_line("The upper triangular part R :"); put(r,3);
    end if;
    wrk := q*r;
    if output
     then put_line("q*r :"); put(wrk,3); 
    end if;
    put("Difference in 1-norm between the matrix and q*r : ");
    dif := Differences(a,wrk);
    put(dif,3,3,3); new_line;
    Clear(dif);
    Multprec_Complex_Matrices.Clear(wrk);
    dif := Orthogonality_Check_Sum(q);
    put("Orthogonality check sum : ");
    put(dif,3,3,3); new_line;
    Clear(dif);
  end Test_QRD;

-- STANDARD REAL TEST DRIVERS :

  procedure Standard_Real_LS_Test
              ( n,m : in integer32; piv : in boolean;
                a : in Standard_Floating_Matrices.Matrix;
                b : in Standard_Floating_Vectors.Vector;
                output : in boolean ) is

    wrk : Standard_Floating_Matrices.Matrix(1..n,1..m) := a;
    qraux : Standard_Floating_Vectors.Vector(1..m) := (1..m => 0.0);
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);
    sol : Standard_Floating_Vectors.Vector(1..m);
    rsd,dum,dum2,dum3 : Standard_Floating_Vectors.Vector(1..n);
    info : integer32;
    use Standard_Floating_Matrices;
    use Standard_Floating_Vectors;

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    QRD(wrk,qraux,jpvt,piv);
    if output
     then put_line("The matrix after QR : "); put(wrk,3);
          put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
    if piv
     then put("The vector jpvt : "); put(jpvt); new_line;
          Permute_Columns(wrk,jpvt);
    end if;
    QRLS(wrk,n,n,m,qraux,b,dum2,dum3,sol,rsd,dum,110,info);
    if piv
     then Permute(sol,jpvt);
    end if;
    if output
     then put_line("The solution : "); put(sol,3); new_line;
    end if;
    dum := b - a*sol;
    if output
     then put_line("right-hand size - matrix*solution : "); 
          put(dum,3); new_line;
    end if;
    put("The norm of residual : "); put(Sum_Norm(dum),3,3,3); new_line;
  end Standard_Real_LS_Test;          

  procedure Standard_Real_QR_Test
              ( n,m : in integer32; piv : in boolean;
                a : in Standard_Floating_Matrices.Matrix;
                output : in boolean ) is

    wrk : Standard_Floating_Matrices.Matrix(1..n,1..m) := a;
    bas : Standard_Floating_Matrices.Matrix(1..n,1..n);
    qraux : Standard_Floating_Vectors.Vector(1..m) := (1..m => 0.0);
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    QRD(wrk,qraux,jpvt,piv);
    if output
     then put_line("The matrix after QR : "); put(wrk,3);
          put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
    if piv
     then put("The vector jpvt : "); put(jpvt); new_line;
          Permute_Columns(wrk,jpvt);
    end if;
    for i in wrk'range(1) loop
      for j in wrk'range(2) loop
        bas(i,j) := wrk(i,j);
      end loop;
      for j in n+1..m loop
        bas(i,j) := 0.0;
      end loop;
    end loop;
    Basis(bas,a);
    if output
     then put_line("The orthogonal part Q of QR  :"); put(bas,3);
    end if;
    Test_QRD(a,bas,Extract_Upper_Triangular(wrk),output);
  end Standard_Real_QR_Test;

  procedure Standard_Interactive_Real_QR_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Floating_Matrices.Matrix(1..n,1..m);

  begin
    put("Give a "); put(n,1); put("x"); put(m,1);   
    put_line(" matrix : "); get(a);
    Standard_Real_QR_Test(n,m,piv,a,true);
  end Standard_Interactive_Real_QR_Test;

  procedure Standard_Interactive_Real_LS_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Floating_Matrices.Matrix(1..n,1..m);
    b : Standard_Floating_Vectors.Vector(1..n);

  begin
    put("Give a "); put(n,1); put("x"); put(m,1);   
    put_line(" matrix : "); get(a);
    put("Give right-hand size "); put(n,1);
    put_line("-vector : "); get(b);
    Standard_Real_LS_Test(n,m,piv,a,b,true);
  end Standard_Interactive_Real_LS_Test;

  procedure Standard_Random_Real_QR_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Floating_Matrices.Matrix(1..n,1..m);
    nb : integer32 := 0;
    output : boolean;
    ans : character;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y');
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m));
      Standard_Real_QR_Test(n,m,piv,a,output);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" QR factoriziations on standard random real matrices.");
    new_line;
    print_times(Standard_Output,timer,"Random Standard Real QR Factorizations");
  end Standard_Random_Real_QR_Test;

  procedure Standard_Random_Real_LS_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Floating_Matrices.Matrix(1..n,1..m);
    b : Standard_Floating_Vectors.Vector(1..n);
    nb : integer32 := 0;
    ans : character;
    output : boolean;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y'); 
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m));
      b := Random_Vector(1,n);
      Standard_Real_LS_Test(n,m,piv,a,b,output);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" real least squares on standard random real matrices.");
    new_line;
    print_times(Standard_Output,timer,"Testing Standard Real Least Squares");
  end Standard_Random_Real_LS_Test;

-- STANDARD COMPLEX TEST DRIVERS :

  procedure Standard_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean;
                a : Standard_Complex_Matrices.Matrix;
                output : in boolean ) is

    use Standard_Complex_Numbers;
    wrk : Standard_Complex_Matrices.Matrix(1..n,1..m) := a;
    bas : Standard_Complex_Matrices.Matrix(1..n,1..n);
    qraux : Standard_Complex_Vectors.Vector(1..m) := (1..m => Create(0.0));
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    QRD(wrk,qraux,jpvt,piv);
    if output
     then put_line("The matrix after QR : "); put(wrk,3);
          put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
   -- put("The vector jpvt : "); put(jpvt); new_line;
    if not piv then
      for i in wrk'range(1) loop
        for j in wrk'range(2) loop
          bas(i,j) := wrk(i,j);
        end loop;
        for j in n+1..m loop
          bas(i,j) := Create(0.0);
        end loop;
      end loop;
      Basis(bas,a);
      if output
       then put_line("The orthogonal part Q of QR  :"); put(bas,3);
      end if;
      Test_QRD(a,bas,Extract_Upper_Triangular(wrk),output);
    end if;
  end Standard_Complex_QR_Test;

  procedure Standard_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean;
                a : Standard_Complex_Matrices.Matrix;
                b : Standard_Complex_Vectors.Vector;
                output : in boolean ) is

    use Standard_Complex_Numbers;
    wrk : Standard_Complex_Matrices.Matrix(1..n,1..m) := a;
    qraux : Standard_Complex_Vectors.Vector(1..m) := (1..m => Create(0.0));
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);
    sol : Standard_Complex_Vectors.Vector(1..m);
    rsd,dum,dum2,dum3 : Standard_Complex_Vectors.Vector(1..n);
    info : integer32;
    use Standard_Complex_Matrices;
    use Standard_Complex_Vectors; 

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    QRD(wrk,qraux,jpvt,piv);
    if output then
      put_line("The matrix after QR : "); put(wrk,3);
      put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
   -- put("The vector jpvt : "); put(jpvt); new_line;
    QRLS(wrk,n,m,qraux,b,dum,dum2,sol,rsd,dum3,110,info);
    if output
     then put_line("The solution : "); put(sol,3); new_line;
    end if;
    dum := b - a*sol;
    if output then 
      put_line("right-hand size - matrix*solution : ");
      put(dum,3); new_line;
    end if;
    put("Sum norm of residual : "); put(Sum_Norm(dum),3,3,3); new_line;
  end Standard_Complex_LS_Test;

  procedure Standard_Interactive_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Complex_Matrices.Matrix(1..n,1..m);
    ans : character;

  begin
    loop
      put("Give a "); put(n,1); put("x"); put(m,1);
      put_line(" matrix : "); get(a);
      Standard_Complex_QR_Test(n,m,piv,a,true);
      put("Do you want more tests ? (y/n) ");
      Ask_Yes_or_No(ans);
      exit when (ans /= 'y');
    end loop;
  end Standard_Interactive_Complex_QR_Test;

  procedure Standard_Interactive_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Complex_Matrices.Matrix(1..n,1..m);
    b : Standard_Complex_Vectors.Vector(1..n);
    ans : character;

  begin
    loop
      put("Give a "); put(n,1); put("x"); put(m,1);
      put_line(" matrix : "); get(a);
      put("Give right-hand size "); put(n,1);
      put_line("-vector : "); get(b); 
      Standard_Complex_LS_Test(n,m,piv,a,b,true);
      put("Do you want more tests ? (y/n) ");
      Ask_Yes_or_No(ans);
      exit when (ans /= 'y');
    end loop;
  end Standard_Interactive_Complex_LS_Test;

  procedure Standard_Random_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Complex_Matrices.Matrix(1..n,1..m);
    nb : integer32 := 0;
    ans : character;
    output : boolean;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y');
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m));
      Standard_Complex_QR_Test(n,m,piv,a,output);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" QR factorizations on random standard complex matrices.");
    new_line;
    print_times(Standard_Output,timer,
                "Random Standard Complex QR Factorizations");
  end Standard_Random_Complex_QR_Test;

  procedure Standard_Random_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Standard_Complex_Matrices.Matrix(1..n,1..m);
    b : Standard_Complex_Vectors.Vector(1..n);
    nb : integer32 := 0;
    ans : character;
    output : boolean;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y');
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m));
      b := Random_Vector(1,n);
      Standard_Complex_LS_Test(n,m,piv,a,b,output);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" least squares on random standard complex matrices.");
    new_line;
    print_times(Standard_Output,timer,"Random Standard Complex Least Squares");
  end Standard_Random_Complex_LS_Test;

-- DOBLDOBL COMPLEX TEST DRIVERS :

  procedure DoblDobl_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean;
                a : DoblDobl_Complex_Matrices.Matrix;
                output : in boolean ) is

    use DoblDobl_Complex_Numbers;
    wrk : DoblDobl_Complex_Matrices.Matrix(1..n,1..m) := a;
    bas : DoblDobl_Complex_Matrices.Matrix(1..n,1..n);
    zero : constant double_double := create(0.0);
    qraux : DoblDobl_Complex_Vectors.Vector(1..m) := (1..m => Create(zero));
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    QRD(wrk,qraux,jpvt,piv);
    if output
     then put_line("The matrix after QR : "); put(wrk,3);
          put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
   -- put("The vector jpvt : "); put(jpvt); new_line;
    if not piv then
      for i in wrk'range(1) loop
        for j in wrk'range(2) loop
          bas(i,j) := wrk(i,j);
        end loop;
        for j in n+1..m loop
          bas(i,j) := Create(zero);
        end loop;
      end loop;
      Basis(bas,a);
      if output
       then put_line("The orthogonal part Q of QR  :"); put(bas,3);
      end if;
      Test_QRD(a,bas,Extract_Upper_Triangular(wrk),output);
    end if;
  end DoblDobl_Complex_QR_Test;

  procedure DoblDobl_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean;
                a : DoblDobl_Complex_Matrices.Matrix;
                b : DoblDobl_Complex_Vectors.Vector;
                output : in boolean ) is

    use DoblDobl_Complex_Numbers;
    wrk : DoblDobl_Complex_Matrices.Matrix(1..n,1..m) := a;
    zero : constant double_double := create(0.0);
    qraux : DoblDobl_Complex_Vectors.Vector(1..m) := (1..m => Create(zero));
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);
    sol : DoblDobl_Complex_Vectors.Vector(1..m);
    rsd,dum,dum2,dum3 : DoblDobl_Complex_Vectors.Vector(1..n);
    info : integer32;
    use DoblDobl_Complex_Matrices;
    use DoblDobl_Complex_Vectors; 

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    QRD(wrk,qraux,jpvt,piv);
    if output then
      put_line("The matrix after QR : "); put(wrk,3);
      put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
   -- put("The vector jpvt : "); put(jpvt); new_line;
    QRLS(wrk,n,m,qraux,b,dum,dum2,sol,rsd,dum3,110,info);
    if output
     then put_line("The solution : "); put(sol,3); new_line;
    end if;
    dum := b - a*sol;
    if output then 
      put_line("right-hand size - matrix*solution : ");
      put(dum,3); new_line;
    end if;
    put("Sum norm of residual : "); put(Sum_Norm(dum),3); new_line;
  end DoblDobl_Complex_LS_Test;

  procedure DoblDobl_Interactive_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : DoblDobl_Complex_Matrices.Matrix(1..n,1..m);
    ans : character;

  begin
    loop
      put("Give a "); put(n,1); put("x"); put(m,1);
      put_line(" matrix : "); get(a);
      DoblDobl_Complex_QR_Test(n,m,piv,a,true);
      put("Do you want more tests ? (y/n) ");
      Ask_Yes_or_No(ans);
      exit when (ans /= 'y');
    end loop;
  end DoblDobl_Interactive_Complex_QR_Test;

  procedure DoblDobl_Interactive_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : DoblDobl_Complex_Matrices.Matrix(1..n,1..m);
    b : DoblDobl_Complex_Vectors.Vector(1..n);
    ans : character;

  begin
    loop
      put("Give a "); put(n,1); put("x"); put(m,1);
      put_line(" matrix : "); get(a);
      put("Give right-hand size "); put(n,1);
      put_line("-vector : "); get(b); 
      DoblDobl_Complex_LS_Test(n,m,piv,a,b,true);
      put("Do you want more tests ? (y/n) ");
      Ask_Yes_or_No(ans);
      exit when (ans /= 'y');
    end loop;
  end DoblDobl_Interactive_Complex_LS_Test;

  procedure DoblDobl_Random_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : DoblDobl_Complex_Matrices.Matrix(1..n,1..m);
    nb : integer32 := 0;
    ans : character;
    output : boolean;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y');
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m));
      DoblDobl_Complex_QR_Test(n,m,piv,a,output);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" QR factorizations on random double double complex matrices.");
    new_line;
    print_times(Standard_Output,timer,
                "Random DoblDobl Complex QR Factorizations");
  end DoblDobl_Random_Complex_QR_Test;

  procedure DoblDobl_Random_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : DoblDobl_Complex_Matrices.Matrix(1..n,1..m);
    b : DoblDobl_Complex_Vectors.Vector(1..n);
    nb : integer32 := 0;
    ans : character;
    output : boolean;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y');
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m));
      b := Random_Vector(1,n);
      DoblDobl_Complex_LS_Test(n,m,piv,a,b,output);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" least squares on random double double complex matrices.");
    new_line;
    print_times(Standard_Output,timer,"Random DoblDobl Complex Least Squares");
  end DoblDobl_Random_Complex_LS_Test;

-- MULTPREC COMPLEX TEST DRIVERS :

  procedure Multprec_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean;
                a : Multprec_Complex_Matrices.Matrix;
                output : in boolean ) is

    use Multprec_Complex_Numbers;
    wrk,upp : Multprec_Complex_Matrices.Matrix(1..n,1..m);
    bas : Multprec_Complex_Matrices.Matrix(1..n,1..n);
    qraux : Multprec_Complex_Vectors.Vector(1..m)
          := (1..m => Create(integer(0)));
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    Multprec_Complex_Matrices.Copy(a,wrk);
    QRD(wrk,qraux,jpvt,piv);
    if output
     then put_line("The matrix after QR : "); put(wrk,3);
          put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
   -- put("The vector jpvt : "); put(jpvt); new_line;
    if not piv then
      for i in wrk'range(1) loop
        for j in wrk'range(2) loop
          Copy(wrk(i,j),bas(i,j));
        end loop;
        for j in n+1..m loop
          bas(i,j) := Create(integer(0));
        end loop;
      end loop;
      Basis(bas,a);
      if output
       then put_line("The orthogonal part Q of QR  :"); put(bas,3);
      end if;
      upp := Extract_Upper_Triangular(wrk);
      Test_QRD(a,bas,upp,output);
      Multprec_Complex_Matrices.Clear(bas); 
      Multprec_Complex_Matrices.Clear(upp);
    end if;
    Multprec_Complex_Matrices.Clear(wrk);
    Multprec_Complex_Vectors.Clear(qraux);
  end Multprec_Complex_QR_Test;

  procedure Multprec_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean;
                a : Multprec_Complex_Matrices.Matrix;
                b : Multprec_Complex_Vectors.Vector;
                output : in boolean ) is

    use Multprec_Complex_Numbers;
    wrk : Multprec_Complex_Matrices.Matrix(1..n,1..m);
    qraux : Multprec_Complex_Vectors.Vector(1..m)
          := (1..m => Create(integer(0)));
    jpvt : Standard_Integer_Vectors.Vector(1..m) := (1..m => 0);
    sol : Multprec_Complex_Vectors.Vector(1..m);
    rsd,dum1,dum2,dum3,res,eva : Multprec_Complex_Vectors.Vector(1..n);
    resi : Floating_Number;
    info : integer32;
    use Multprec_Complex_Matrices;
    use Multprec_Complex_Vectors; 

  begin
    if output
     then put_line("The matrix : "); put(a,3);
    end if;
    Multprec_Complex_Matrices.Copy(a,wrk);
    QRD(wrk,qraux,jpvt,piv);
    if output
     then put_line("The matrix after QR : "); put(wrk,3);
          put_line("The vector qraux : "); put(qraux,3); new_line;
    end if;
    if piv
     then put("The vector jpvt : "); put(jpvt); new_line;
    end if;
    QRLS(wrk,n,n,m,qraux,b,dum1,dum2,sol,rsd,dum3,110,info);
    Multprec_Complex_Vectors.Clear(dum1);
    Multprec_Complex_Vectors.Clear(dum2);
    Multprec_Complex_Vectors.Clear(dum3);
    if output
     then put_line("The solution : "); put(sol,3); new_line;
    end if;
    eva := a*sol;
    res := b - eva;
    if output
     then put_line("right-hand size - matrix*solution : ");
          put(res,3); new_line;
    end if;
    resi := Sum_Norm(res);
    put("Sum norm of residual : "); put(resi,3); new_line;
    Clear(resi);
    Multprec_Complex_Vectors.Clear(eva);
    Multprec_Complex_Vectors.Clear(res);
    Multprec_Complex_Vectors.Clear(sol);
    Multprec_Complex_Vectors.Clear(rsd);
    Multprec_Complex_Vectors.Clear(qraux);
    Multprec_Complex_Matrices.Clear(wrk);
  end Multprec_Complex_LS_Test;

  procedure Multprec_Interactive_Complex_QR_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Multprec_Complex_Matrices.Matrix(1..n,1..m);
    ans : character;

  begin
    loop
      put("Give a "); put(n,1); put("x"); put(m,1);
      put_line(" matrix : "); get(a);
      Multprec_Complex_QR_Test(n,m,piv,a,true);
      Multprec_Complex_Matrices.Clear(a);
      put("Do you want more tests ? (y/n) ");
      Ask_Yes_or_No(ans);
      exit when (ans /= 'y');
    end loop;
  end Multprec_Interactive_Complex_QR_Test;

  procedure Multprec_Interactive_Complex_LS_Test
              ( n,m : in integer32; piv : in boolean ) is

    a : Multprec_Complex_Matrices.Matrix(1..n,1..m);
    b : Multprec_Complex_Vectors.Vector(1..n);
    ans : character;

  begin
    loop
      put("Give a "); put(n,1); put("x"); put(m,1);
      put_line(" matrix : "); get(a);
      put("Give right-hand size "); put(n,1);
      put_line("-vector : "); get(b); 
      Multprec_Complex_LS_Test(n,m,piv,a,b,true);
      Multprec_Complex_Matrices.Clear(a);
      Multprec_Complex_Vectors.Clear(b);
      put("Do you want more tests ? (y/n) ");
      Ask_Yes_or_No(ans);
      exit when (ans /= 'y');
    end loop;
  end Multprec_Interactive_Complex_LS_Test;

  procedure Multprec_Random_Complex_QR_Test
              ( n,m : in integer32; sz : in natural32; piv : in boolean ) is

    a : Multprec_Complex_Matrices.Matrix(1..n,1..m);
    nb : natural32 := 0;
    ans : character;
    output : boolean;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y');
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m),sz);
      Multprec_Complex_QR_Test(n,m,piv,a,output);
      Multprec_Complex_Matrices.Clear(a);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" QR factorizations on multprec random complex matrices.");
    new_line;
    print_times(Standard_Output,timer,"Random Multprec Complex QR Testing");
  end Multprec_Random_Complex_QR_Test;

  procedure Multprec_Random_Complex_LS_Test
              ( n,m : integer32; sz : in natural32; piv : in boolean ) is

    a : Multprec_Complex_Matrices.Matrix(1..n,1..m);
    b : Multprec_Complex_Vectors.Vector(1..n);
    nb : natural32 := 0;
    ans : character;
    output : boolean;
    timer : Timing_Widget;

  begin
    put("Give the number of tests : "); get(nb);
    put("Do you want to see all matrices and vectors ? (y/n) ");
    Ask_Yes_or_No(ans);
    output := (ans = 'y');
    tstart(timer);
    for i in 1..nb loop
      a := Random_Matrix(natural32(n),natural32(m),sz);
      b := Random_Vector(1,n,sz);
      Multprec_Complex_LS_Test(n,m,piv,a,b,output);
      Multprec_Complex_Matrices.Clear(a);
      Multprec_Complex_Vectors.Clear(b);
    end loop;
    tstop(timer);
    put("Tested "); put(nb,1);
    put_line(" least squares on multprec random complex matrices");
    new_line;
    print_times(Standard_Output,timer,"Random Multprec Complex Least Squares");
  end Multprec_Random_Complex_LS_Test;

-- MAIN PROGRAM :

  procedure Main is

    n,m : integer32 := 0;
    sz : natural32 := 0;
    choice : character;
    piv : constant boolean := false;

  begin
    new_line;
    put_line("Test on the QR decomposition and Least Squares.");
    loop
      new_line;
      put_line("Choose one of the following : ");
      put_line("  0. Exit this program.");
      put_line("  1. QR-decomposition on given standard floating matrix.");
      put_line("  2.                           standard complex matrix.");
      put_line("  3.                  on random standard floating matrix.");
      put_line("  4.                            standard complex matrix.");
      put_line("  5. Least Squares on given standard floating matrix.");
      put_line("  6.                        standard complex matrix.");
      put_line("  7.               on random standard floating matrix.");
      put_line("  8.                         standard complex matrix.");
      put_line("  9. QR-decomposition on given dobldobl complex matrix.");
      put_line("  A.                  on random dobldobl complex matrix.");
      put_line("  B. Least Squares on given dobldobl complex matrix.");
      put_line("  C.               on random dobldobl complex matrix.");
      put_line("  D. QR-decomposition on given multprec complex matrix.");
      put_line("  E.                  on random multprec complex matrix.");
      put_line("  F. Least Squares on given multprec complex matrix.");
      put_line("  G.               on random multprec complex matrix.");
	  put("Make your choice (0, 1, .. , A, B, .., G) : ");
      Ask_Alternative(choice,"0123456789ABCDEFG");
      exit when (choice = '0');
      new_line;
      put("Give the number of rows of the matrix : "); get(n);
      put("Give the number of columns of the matrix : "); get(m);
      if choice = 'D' or choice = 'E' or choice = 'F' or choice = 'G'
       then put("Give the size of the numbers : "); get(sz);
      end if;
      case choice is
        when '1' => Standard_Interactive_Real_QR_Test(n,m,piv);
        when '2' => Standard_Interactive_Complex_QR_Test(n,m,piv);
        when '3' => Standard_Random_Real_QR_Test(n,m,piv);
        when '4' => Standard_Random_Complex_QR_Test(n,m,piv);
        when '5' => Standard_Interactive_Real_LS_Test(n,m,piv);
        when '6' => Standard_Interactive_Complex_LS_Test(n,m,piv);
        when '7' => Standard_Random_Real_LS_Test(n,m,piv);
        when '8' => Standard_Random_Complex_LS_Test(n,m,piv);
        when '9' => DoblDobl_Interactive_Complex_QR_Test(n,m,piv);
        when 'A' => DoblDobl_Random_Complex_QR_Test(n,m,piv);
        when 'B' => DoblDobl_Interactive_Complex_LS_Test(n,m,piv);
        when 'C' => DoblDobl_Random_Complex_LS_Test(n,m,piv);
        when 'D' => Multprec_Interactive_Complex_QR_Test(n,m,piv);
        when 'E' => Multprec_Random_Complex_QR_Test(n,m,sz,piv);
        when 'F' => Multprec_Interactive_Complex_LS_Test(n,m,piv);
        when 'G' => Multprec_Random_Complex_LS_Test(n,m,sz,piv);
        when others => null;
      end case;
    end loop;
  end Main;

begin
  Main;
end ts_qrd;
