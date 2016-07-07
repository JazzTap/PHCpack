package body DoblDobl_Dense_Series is

-- CREATORS :

  function Create ( i : integer ) return Series is
  begin
    return Create(i,0);
  end Create;

  function Create ( f : double_float ) return Series is
  begin
    return Create(f,0);
  end Create;

  function Create ( f : double_double ) return Series is
  begin
    return Create(f,0);
  end Create;

  function Create ( c : Complex_Number ) return Series is
  begin
    return Create(c,0);
  end Create;

  function Create ( i : integer; deg : integer32 ) return Series is

    res : Series;
    zero : constant double_double := create(0.0);

  begin
    res.deg := deg;
    res.cff(0) := Create(i);
    res.cff(1..deg)
      := DoblDobl_Complex_Vectors.Vector'(1..deg => Create(zero));
    return res;
  end Create;

  function Create ( f : double_float; deg : integer32 ) return Series is

    res : Series;
    zero : constant double_double := create(0.0);
    dd_f : constant double_double := create(f);

  begin
    res.deg := deg;
    res.cff(0) := Create(dd_f);
    res.cff(1..deg)
      := DoblDobl_Complex_Vectors.Vector'(1..deg => Create(zero));
    return res;
  end Create;

  function Create ( f : double_double; deg : integer32 ) return Series is

    res : Series;
    zero : constant double_double := create(0.0);

  begin
    res.deg := deg;
    res.cff(0) := Create(f);
    res.cff(1..deg)
      := DoblDobl_Complex_Vectors.Vector'(1..deg => Create(zero));
    return res;
  end Create;

  function Create ( c : Complex_Number; deg : integer32 ) return Series is

    res : Series;
    zero : constant double_double := create(0.0);

  begin
    res.deg := deg;
    res.cff(0) := c;
    res.cff(1..deg)
      := DoblDobl_Complex_Vectors.Vector'(1..deg => Create(zero));
    return res;
  end Create;

  function Create ( c : DoblDobl_Complex_Vectors.Vector ) return Series is

    res : Series;

  begin
    if c'last <= max_deg then
      res.deg := c'last;
      res.cff(0..c'last) := c;
    else
      res.deg := max_deg;
      res.cff := c(0..max_deg);
    end if;
    return res;
  end Create;

  function Create ( s : Series; deg : integer32 ) return Series is

    res : Series;
    dd_zero : constant double_double := create(0.0);
    zero : constant Complex_Number := Create(dd_zero);

  begin
    res.deg := deg;
    if deg <= s.deg then
      for i in 0..res.deg loop
        res.cff(i) := s.cff(i);
      end loop;
    else
      for i in 0..s.deg loop
        res.cff(i) := s.cff(i);
      end loop;
      for i in s.deg+1..deg loop
        res.cff(i) := zero;
      end loop;
    end if;
    return res;
  end Create;

-- EQUALITY AND COPY :

  function Equal ( s,t : Series ) return boolean is

    dd_zero : constant double_double := create(0.0);
    zero : constant Complex_Number := Create(dd_zero);

  begin
    if s.deg <= t.deg then
      for i in 0..s.deg loop
        if not DoblDobl_Complex_Numbers.Equal(s.cff(i),t.cff(i))
         then return false;
        end if;
      end loop;
      for i in s.deg+1..t.deg loop
        if not DoblDobl_Complex_Numbers.Equal(t.cff(i),zero)
         then return false;
        end if;
      end loop;
      return true;
    else
      return DoblDobl_Dense_Series.Equal(t,s);
    end if;
  end Equal;

  procedure Copy ( s : in Series; t : in out Series ) is
  begin
    t.deg := s.deg;
    for i in 0..s.deg loop
      t.cff(i) := s.cff(i);
    end loop;
  end Copy;

-- COMPLEX CONJUGATE :

  function Conjugate ( s : Series ) return Series is

    res : Series;

  begin
    res.deg := s.deg;
    for i in 0..res.deg loop
      res.cff(i) := Conjugate(s.cff(i));
    end loop;
    return res;
  end Conjugate;

-- ARITHMETICAL OPERATORS :

  function "+" ( s : Series; c : Complex_Number ) return Series is

    res : Series := s;

  begin
    res.cff(0) := s.cff(0) + c;
    return res;
  end "+";

  function "+" ( c : Complex_Number; s : Series ) return Series is

    res : Series := s;
  
  begin
    res.cff(0) := c + s.cff(0);
    return res;
  end "+";

  procedure Add ( s : in out Series; c : in Complex_Number ) is
  begin
    s.cff(0) := s.cff(0) + c;
  end Add;

  function "+" ( s : Series ) return Series is

    res : constant Series := s;

  begin
    return res;
  end "+";

  function "+" ( s,t : Series ) return Series is

    res : Series;

  begin
    if s.deg = t.deg then
      res.deg := s.deg;
      for i in 0..res.deg loop
        res.cff(i) := s.cff(i) + t.cff(i);
      end loop;
    elsif s.deg < t.deg then -- deg of result is t.deg
      res.deg := t.deg;
      for i in 0..s.deg loop
        res.cff(i) := s.cff(i) + t.cff(i);
      end loop;
      for i in s.deg+1..t.deg loop -- copy remaining terms from t
        res.cff(i) := t.cff(i);
      end loop;
    else -- s.deg > t.deg and the deg of result is s.deg
      res.deg := s.deg;
      for i in 0..t.deg loop
        res.cff(i) := s.cff(i) + t.cff(i);
      end loop;
      for i in t.deg+1..s.deg loop -- copy remaining terms from s
        res.cff(i) := s.cff(i);
      end loop;
    end if;
    return res;
  end "+";

  procedure Add ( s : in out Series; t : in Series ) is
  begin
    if t.deg >= s.deg then  -- do not ignore terms of deg > s.deg!
      for i in 0..s.deg loop
        s.cff(i) := s.cff(i) + t.cff(i);
      end loop;
      if t.deg > s.deg then 
        for i in s.deg+1..t.deg loop -- copy higher deg terms
          s.cff(i) := t.cff(i);
        end loop;
        s.deg := t.deg; -- adjust the deg of s
      end if;
    else          -- add only the coefficients of index <= t.deg
      for i in 0..t.deg loop
        s.cff(i) := s.cff(i) + t.cff(i);
      end loop;
    end if;
  end Add;

  function "-" ( s : Series; c : Complex_Number ) return Series is

    res : Series := s;

  begin
    res.cff(0) := s.cff(0) - c;
    return res;
  end "-";

  function "-" ( c : Complex_Number; s : Series ) return Series is

    res : Series;

  begin
    res.deg := s.deg;
    res.cff(0) := c - s.cff(0);
    for k in 1..res.deg loop
      res.cff(k) := -s.cff(k);
    end loop;
    return res;
  end "-";

  procedure Sub ( s : in out Series; c : in Complex_Number ) is
  begin
    s.cff(0) := s.cff(0) - c;
  end Sub;

  function "-" ( s : Series ) return Series is

    res : Series;

  begin
    res.deg := s.deg;
    for i in 0..res.deg loop
      res.cff(i) := -s.cff(i);
    end loop;
    return res;
  end "-";

  procedure Min ( s : in out Series ) is
  begin
    for i in 0..s.deg loop
      s.cff(i) := -s.cff(i);
    end loop;
  end Min;

  function "-" ( s,t : Series ) return Series is

    res : Series;

  begin
    if s.deg = t.deg then
      res.deg := s.deg;
      for i in 0..t.deg loop
        res.cff(i) := s.cff(i) - t.cff(i);
      end loop;
    elsif s.deg < t.deg then -- the deg of the result is t.deg
      res.deg := t.deg;
      for i in 0..s.deg loop
        res.cff(i) := s.cff(i) - t.cff(i);
      end loop;
      for i in s.deg+1..t.deg loop -- copy remaining terms
        res.cff(i) := -t.cff(i);       -- of t with minus sign
      end loop;
    else
      res.deg := s.deg;
      for i in 0..s.deg loop
        res.cff(i) := s.cff(i) - t.cff(i);
      end loop;
      for i in t.deg+1..s.deg loop -- copy remaining terms of s
        res.cff(i) := s.cff(i);
      end loop;
    end if;
    return res;
  end "-";

  procedure Sub ( s : in out Series; t : in Series ) is
  begin
    if t.deg >= s.deg then -- do not ignore terms of t of index > s.deg!
      for i in 0..s.deg loop
        s.cff(i) := s.cff(i) - t.cff(i);
      end loop;
      if t.deg > s.deg then
        for i in s.deg+1..t.deg loop -- subtract higher deg terms
          s.cff(i) := -t.cff(i);
        end loop;
        s.deg := t.deg; -- s become a series of higher deg
      end if;
    else
      for i in 0..t.deg loop
        s.cff(i) := s.cff(i) - t.cff(i);
      end loop;
    end if;
  end Sub;

  function "*" ( s : Series; c : Complex_Number ) return Series is

    res : Series;

  begin
    res.deg := s.deg;
    for k in 0..s.deg loop
      res.cff(k) := s.cff(k)*c;
    end loop;
    return res;
  end "*";

  function "*" ( c : Complex_Number; s : Series ) return Series is

    res : Series;

  begin
    res.deg := s.deg;
    for k in 0..s.deg loop
      res.cff(k) := c*s.cff(k);
    end loop;
    return res;
  end "*";

  procedure Mul ( s : in out Series; c : in Complex_Number ) is
  begin
    for i in 0..s.deg loop
      s.cff(i) := s.cff(i)*c;
    end loop;
  end Mul;

  function "*" ( s,t : Series ) return Series is

    res : Series;

  begin
    if s.deg = t.deg then
      res.deg := s.deg;
      for i in 0..res.deg loop
        res.cff(i) := s.cff(0)*t.cff(i);
        for j in 1..i loop
          res.cff(i) := res.cff(i) + s.cff(j)*t.cff(i-j);
        end loop;
      end loop;
    elsif s.deg < t.deg then
      res.deg := t.deg;
      for i in 0..res.deg loop
        res.cff(i) := s.cff(0)*t.cff(i);
        for j in 1..i loop
          exit when j > s.deg;
          res.cff(i) := res.cff(i) + s.cff(j)*t.cff(i-j);
        end loop;
      end loop;
    else -- s.deg > t.deg, we then flip s and t
      res.deg := s.deg;
      for i in 0..res.deg loop
        res.cff(i) := t.cff(0)*s.cff(i);
        for j in 1..i loop
          exit when j > t.deg;
          res.cff(i) := res.cff(i) + t.cff(j)*s.cff(i-j);
        end loop;
      end loop;
    end if;
    return res;
  end "*";

  procedure Mul ( s : in out Series; t : in Series ) is

    res : constant Series := s*t;

  begin
    s := res;
  end Mul;

  function Inverse ( s : Series ) return Series is

    res : Series;
    one : constant double_double := create(1.0);

  begin
    res.deg := s.deg;
    res.cff(0) := one/s.cff(0);
    for i in 1..res.deg loop
      res.cff(i) := -s.cff(1)*res.cff(i-1);
      for j in 2..i loop
        res.cff(i) := res.cff(i) - s.cff(j)*res.cff(i-j);
      end loop;
      res.cff(i) := res.cff(i)/s.cff(0);
    end loop;
    return res;
  end Inverse;

  function "/" ( s : Series; c : Complex_Number ) return Series is

    res : Series;

  begin
    res.deg := s.deg;
    for k in 0..s.deg loop
      res.cff(k) := s.cff(k)/c;
    end loop;
    return res;
  end "/";

  function "/" ( c : Complex_Number; s : Series ) return Series is
  begin
    return c*Inverse(s);
  end "/";

  procedure Div ( s : in out Series; c : in Complex_Number ) is
  begin
    for k in 0..s.deg loop
      s.cff(k) := s.cff(k)/c;
    end loop;
  end Div;

  function "/" ( s,t : Series ) return Series is
  begin
    return s*Inverse(t);
  end "/";

  procedure Div ( s : in out Series; t : in Series ) is

    invt : constant Series := Inverse(t);

  begin
    Mul(s,invt);
  end Div;

  function "**" ( s : Series; p : integer ) return Series is

    res : Series;

  begin
    if p = 0 then
      res := Create(1);
    elsif p > 0 then
      res := s;
      for k in 2..p loop
        Mul(res,s);
      end loop;
    else -- p < 0
      res := s;
      for k in 2..(-p) loop
        Mul(res,s);
      end loop;
      res := Inverse(res);
    end if;
    return res;
  end "**";

  function "**" ( s : Series; p : natural32 ) return Series is

    res : Series;

  begin
    if p = 0 then
      res := Create(1);
    else
      res := s;
      for k in 2..p loop
        Mul(res,s);
      end loop;
    end if;
    return res;
  end "**";

-- EVALUATORS :

  function Eval ( s : Series; t : double_double ) return Complex_Number is

    res : Complex_Number := s.cff(0);
    pwt : double_double := t;

  begin
    for i in 1..(s.deg-1) loop
      res := res + s.cff(i)*pwt;
      pwt := pwt*t;
    end loop;
    res := res + s.cff(s.deg)*pwt;
    return res;
  end Eval;

  function Eval ( s : Series; t : Complex_Number ) return Complex_Number is

    res : Complex_Number := s.cff(0);
    pwt : Complex_Number := t;

  begin
    for i in 1..(s.deg-1) loop
      res := res + s.cff(i)*pwt;
      pwt := pwt*t;
    end loop;
    res := res + s.cff(s.deg)*pwt;
    return res;
  end Eval;

  procedure Filter ( s : in out Series; tol : in double_float ) is

    zero : constant double_double := create(0.0);

  begin
    for i in 0..s.deg loop
      if AbsVal(s.cff(i)) < tol
       then s.cff(i) := Create(zero);
      end if;
    end loop;
  end Filter;

-- SHIFT OPERATORS :

  function binomial ( n,k : integer32 ) return integer32 is

  -- DESCRIPTION :
  --   Returns the binomial coefficient n choose k.

    res : integer32 := 1;

  begin
    return res;
  end binomial;

  function Shift ( s : Series; c : double_double ) return Series is

    res : Series;
    bcf : double_double;
    sgn : integer32;

  begin
    res.deg := s.deg;
    for i in 0..s.deg loop
      res.cff(i) := Create(integer32(0));
      sgn := 1;
      for j in 0..i loop
        bcf := double_double_numbers.create(sgn*binomial(i,j));
        bcf := bcf*(c**(natural(i-j)));
        res.cff(j) := res.cff(j) + s.cff(i)*bcf;
        sgn := -sgn;
      end loop;
    end loop;
    return res;
  end Shift;

  function Shift ( s : Series; c : Complex_Number ) return Series is

    res : Series;
    bcf : double_double;
    rcf : Complex_Number;
    sgn : integer32;

  begin
    res.deg := s.deg;
    for i in 0..s.deg loop
      res.cff(i) := Create(integer32(0));
      sgn := 1;
      for j in 0..i loop
        bcf := double_double_numbers.create(sgn*binomial(i,j));
        rcf := bcf*(c**(natural(i-j)));
        res.cff(j) := res.cff(j) + s.cff(i)*rcf;
        sgn := -sgn;
      end loop;
    end loop;
    return res;
  end Shift;

  procedure Shift ( s : in out Series; c : in double_double ) is
 
    r : constant Series := Shift(s,c);
   
  begin
    s := r;
  end Shift;

  procedure Shift ( s : in out Series; c : in Complex_Number ) is
 
    r : constant Series := Shift(s,c);
   
  begin
    s := r;
  end Shift;

-- DESTRUCTOR :

  procedure Clear ( s : in out Series ) is

    zero : constant double_double := create(0.0);

  begin
    s.deg := 0;
    for i in s.cff'range loop
      s.cff(i) := Create(zero);
    end loop;
  end Clear;

end DoblDobl_Dense_Series;
