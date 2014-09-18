with Standard_Complex_Numbers;           use Standard_Complex_Numbers;
with Standard_Integer_Vectors;
with Standard_Complex_Linear_Solvers;    use Standard_Complex_Linear_Solvers;

package body Flag_Transformations is

  function Coefficient_Matrix
             ( n : integer32;
               f1,f2,g1,g2 : Standard_Complex_Matrices.Matrix )
             return Standard_Complex_Matrices.Matrix is

    dim : constant integer32 := 2*n*n;
    res : Standard_Complex_Matrices.Matrix(1..dim,1..dim);
    offset : integer32 := 0;

  begin
    for i in res'range(1) loop
      for j in res'range(2) loop
        res(i,j) := Create(0.0);
      end loop;
    end loop;
    for k in 0..(n-1) loop
      for i in 1..n loop
        for j in 1..n loop
          res(k*n+i,k*n+j) := f1(j,i);
          res(n*(n+k)+i,k*n+j) := f2(j,i);
        end loop;
      end loop;
    end loop;
    for i in 1..n-1 loop
      for j in 1..n-i loop
        for k in 0..(n-1) loop
         -- put("i = "); put(i,1);
         -- put("  j = "); put(j,1); put("  k = "); put(k,1);
         -- put("  row : "); put(k*n+i+j,1);
         -- put("  col : "); put(offset+n*n+j,1); new_line;
          res(k*n+i+j,offset+n*n+j) := -g1(k+1,i);
        end loop;
      end loop;
      offset := offset + n - i;
    end loop;
   -- new_line;
    for i in 1..n loop
      for j in 1..n-i+1 loop
        for k in 0..(n-1) loop
         -- put("i = "); put(i,1);
         -- put("  j = "); put(j,1); put("  k = "); put(k,1);
         -- put("  row : "); put(n*(n+k)+i+j-1,1);
         -- put("  col : "); put(offset+n*n+j,1); new_line;
          res(n*(n+k)+i+j-1,offset+n*n+j) := -g2(k+1,i);
        end loop;
      end loop;
      offset := offset + n - i + 1;
    end loop;
    return res;
  end Coefficient_Matrix;

  function Right_Hand_Side
             ( n : integer32; g : Standard_Complex_Matrices.Matrix )
             return Standard_Complex_Vectors.Vector is

    dim : constant integer32 := 2*n*n;
    res : Standard_Complex_Vectors.Vector(1..dim);
    ind : integer32 := 0;

  begin
    for i in g'range(1) loop
      for j in g'range(2) loop
        ind := ind + 1;
        res(ind) := g(i,j);
      end loop;
    end loop;
    for i in ind+1..res'last loop
      res(i) := Create(0.0);
    end loop;
    return res;
  end Right_Hand_Side;

  procedure Extract_Matrices
              ( n : in integer32; sol : in Standard_Complex_Vectors.Vector;
                A,T1,T2 : out Standard_Complex_Matrices.Matrix ) is

    idx : integer32 := 0;

  begin
    for i in 1..n loop
      for j in 1..n loop
        idx := idx + 1;
        A(i,j) := sol(idx);
      end loop;
    end loop;
    for i in 1..n loop
      for j in 1..(i-1) loop
        T1(i,j) := Create(0.0);
      end loop;
      T1(i,i) := Create(1.0);
      for j in (i+1)..n loop
        idx := idx + 1;
        T1(i,j) := sol(idx);
      end loop;
    end loop;
    for i in 1..n loop
      for j in 1..(i-1) loop
        T2(i,j) := Create(0.0);
      end loop;
      for j in i..n loop
        idx := idx + 1;
        T2(i,j) := sol(idx);
      end loop;
    end loop;
  end Extract_Matrices;

  procedure Transform
              ( n : in integer32; 
                f1,f2,g1,g2 : in Standard_Complex_Matrices.Matrix;
                A,T1,T2 : out Standard_Complex_Matrices.Matrix ) is

    dim : constant integer32 := 2*n*n;
    mat : Standard_Complex_Matrices.Matrix(1..dim,1..dim)
        := Coefficient_Matrix(n,f1,f2,g1,g2);
    rhs : Standard_Complex_Vectors.Vector(1..dim)
        := Right_Hand_Side(n,g1);
    ipvt : Standard_Integer_Vectors.Vector(1..dim);
    info : integer32;

  begin
    lufac(mat,dim,ipvt,info);
    lusolve(mat,dim,ipvt,rhs);
    Extract_Matrices(n,rhs,A,T1,T2);
  end Transform;

  function Residual
             ( f1,f2,g1,g2,A,T1,T2 : Standard_Complex_Matrices.Matrix )
             return double_float is

    res : double_float := 0.0;

    use Standard_Complex_Matrices;

    Af1 : constant Standard_Complex_Matrices.Matrix := A*f1;
    Af2 : constant Standard_Complex_Matrices.Matrix := A*f2;
    g1T1 : constant Standard_Complex_Matrices.Matrix := g1*T1;
    g2T2 : constant Standard_Complex_Matrices.Matrix := g2*T2;
    d1 : constant Standard_Complex_Matrices.Matrix := Af1 - g1T1;
    d2 : constant Standard_Complex_Matrices.Matrix := Af2 - g2T2;
    val : double_float;

  begin
    for i in d1'range(1) loop
      for j in d1'range(2) loop
        val := AbsVal(d1(i,j));
        res := res + val;
      end loop;
    end loop;
    for i in d2'range(1) loop
      for j in d2'range(2) loop
        val := AbsVal(d2(i,j));
        res := res + val;
      end loop;
    end loop;
    return res;
  end Residual;

end Flag_Transformations;
