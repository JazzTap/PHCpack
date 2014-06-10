with Standard_Natural_Numbers;            use Standard_Natural_Numbers;
with DoblDobl_Complex_Numbers;            use DoblDobl_Complex_Numbers;
with Standard_Speelpenning_Products;

package body DoblDobl_Speelpenning_Products is

  function Straight_Speel
             ( x : DoblDobl_Complex_Vectors.Vector )
             return DoblDobl_Complex_Vectors.Vector is

    n : constant integer32 := x'last;
    res : DoblDobl_Complex_Vectors.Vector(0..n);

  begin
    res(0) := x(1);
    res(n) := x(1);
    for i in 2..(n-1) loop   -- does 2*(n-1) multiplications
      res(0) := res(0)*x(i);
      res(n) := res(n)*x(i);
    end loop;
    res(0) := res(0)*x(n);   -- 2*(n-1) + 1 = 2*n - 1
    for i in 1..(n-1) loop
      res(i) := x(n);
      for j in 1..n-1 loop   -- does n*(n-2) multiplications
        if i /= j
         then res(i) := res(i)*x(j);
        end if;
      end loop;
    end loop;
    return res;
  end Straight_Speel;

  function Straight_Speel
             ( e : Standard_Natural_Vectors.Vector;
               x : DoblDobl_Complex_Vectors.Vector )
             return DoblDobl_Complex_Vectors.Vector is

    n : constant integer32 := x'last;
    res : DoblDobl_Complex_Vectors.Vector(0..n);

  begin
    if e(1) = 0
     then res(0) := Create(integer(1));
     else res(0) := x(1);
    end if;
    for i in 2..(n-1) loop   -- does |e|-1 multiplications
      if e(i) > 0
       then res(0) := res(0)*x(i);
      end if;
    end loop;
    if e(n) = 0 then
      res(n) := Create(integer(0));
    else
      res(0) := res(0)*x(n);
      if e(1) = 0
       then res(n) := Create(integer(1));
       else res(n) := x(1);
      end if;
      for i in 2..(n-1) loop
        if e(i) > 0
         then res(n) := res(n)*x(i);
        end if;
      end loop;
    end if;
    for i in 1..(n-1) loop
      if e(i) = 0 then
        res(i) := Create(integer(0));
      else
        if e(n) = 0
         then res(i) := Create(integer(1));
         else res(i) := x(n);
        end if;
        for j in 1..n-1 loop   -- does n*(n-2) multiplications
          if i /= j then
            if e(j) > 0
             then res(i) := res(i)*x(j);
            end if;
          end if;
        end loop;
      end if;
    end loop;
    return res;
  end Straight_Speel;

  function Reverse_Speel
             ( x : DoblDobl_Complex_Vectors.Vector )
             return DoblDobl_Complex_Vectors.Vector is

    n : constant integer32 := x'last;
    res : DoblDobl_Complex_Vectors.Vector(0..n);
    fwd : DoblDobl_Complex_Vectors.Vector(1..n);
    back : Complex_Number;

  begin
    fwd(1) := x(1);              -- fwd (forward) accumulates products
    for i in 2..n loop                     -- of consecutive variables
      fwd(i) := fwd(i-1)*x(i);             -- does n-1 multiplications
    end loop;
    res(0) := fwd(n);
    res(n) := fwd(n-1);
    back := x(n);                -- back accumulates backward products
    for i in reverse 2..n-1 loop  -- loop does 2*(n-1) multiplications
      res(i) := fwd(i-1)*back;
      back := x(i)*back;
    end loop;
    res(1) := back;
    return res;
  end Reverse_Speel;

  procedure Nonzeroes
             ( e : in Standard_Natural_Vectors.Vector;
               x : in DoblDobl_Complex_Vectors.Vector;
               idx : out Standard_Integer_Vectors.Vector;
               enz : out Standard_Natural_Vectors.Vector;
               xnz : out DoblDobl_Complex_Vectors.Vector ) is

    ind : integer32 := e'first-1;

  begin
    for i in e'range loop
      if e(i) /= 0 then
        ind := ind + 1;
        idx(ind) := i;
        enz(ind) := e(i);
        xnz(ind) := x(i);
      end if;
    end loop;
  end Nonzeroes;

  function Indexed_Speel
             ( nx,nz : integer32;
               indnz : Standard_Integer_Vectors.Vector;
               x : DoblDobl_Complex_Vectors.Vector )
             return DoblDobl_Complex_Vectors.Vector is

    res : DoblDobl_Complex_Vectors.Vector(0..nx);
    nzx : DoblDobl_Complex_Vectors.Vector(1..nz);
    eva : DoblDobl_Complex_Vectors.Vector(0..nz);

  begin
    for k in 1..nz loop
      nzx(k) := x(indnz(k));
    end loop;
    eva := Reverse_Speel(nzx);
    res(0) := eva(0);
    res(1..nx) := (1..nx => Create(integer(0)));
    for i in 1..nz loop
      res(indnz(i)) := eva(i);
    end loop;
    return res;
  end Indexed_Speel;

  function Reverse_Speel
             ( e : Standard_Natural_Vectors.Vector;
               x : DoblDobl_Complex_Vectors.Vector )
             return DoblDobl_Complex_Vectors.Vector is

    n : constant integer32 := x'last;
    res : DoblDobl_Complex_Vectors.Vector(0..n);
    nz : constant integer32
       := integer32(Standard_Speelpenning_Products.Number_of_Nonzeroes(e));

  begin
    if nz = 0 then
      res(0) := Create(integer(1));
      res(1..n) := (1..n => Create(integer(0)));
    elsif nz = 1 then
      declare
        ind : constant integer32
            := Standard_Speelpenning_Products.Nonzero_Index(e);
      begin
        res(0) := x(ind);
        res(1..n) := (1..n => Create(integer(0)));
        res(ind) := Create(integer(1));
      end;
    else
      declare
        nze : Standard_Natural_Vectors.Vector(1..nz);
        ind : Standard_Integer_Vectors.Vector(1..nz);
        nzx : DoblDobl_Complex_Vectors.Vector(1..nz);
       -- eva : DoblDobl_Complex_Vectors.Vector(0..nz);
      begin
        Nonzeroes(e,x,ind,nze,nzx);
        res := Indexed_Speel(n,nz,ind,x);
       -- eva := Reverse_Speel(nzx);
       -- res(0) := eva(0);
       -- res(1..n) := (1..n => Create(integer(0)));
       -- for i in ind'range loop
       --   res(ind(i)) := eva(i);
       -- end loop;
      end;
    end if;
    return res;
  end Reverse_Speel;

end DoblDobl_Speelpenning_Products;
