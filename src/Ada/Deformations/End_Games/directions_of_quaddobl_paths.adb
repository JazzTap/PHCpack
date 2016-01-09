with Standard_Integer_Numbers_io;        use Standard_Integer_Numbers_io;
with Quad_Double_Numbers_io;             use Quad_Double_Numbers_io;
with QuadDobl_Mathematical_Functions;    use QuadDobl_Mathematical_Functions;
with Quad_Double_Vectors_io;             use Quad_Double_Vectors_io;
with Quad_Double_Matrices;               use Quad_Double_Matrices;
with Quad_Double_Matrices_io;            use Quad_Double_Matrices_io;
with Standard_Integer_Vectors;
with Standard_Integer_Vectors_io;        use Standard_Integer_Vectors_io;
with QuadDobl_vLpRs_Algorithm;           use QuadDobl_vLpRs_Algorithm;

package body Directions_of_QuadDobl_Paths is

-- AUXILIARY :

  function Norm1 ( x : Quad_Double_Vectors.Vector )
                 return quad_double is

    res : quad_double := create(0.0);

  begin
    for i in x'range loop
      res := res + abs(x(i));
    end loop;
    return res;
  end Norm1;

  procedure Shift_Up ( v : in out Quad_Double_Vectors.Vector;
                       x : in quad_double ) is

  -- DESCRIPTION :
  --   Puts x at v(v'first) after a shift-up: v(i+1) := v(i).

  begin
    for i in reverse v'first..(v'last-1) loop
      v(i+1) := v(i);
    end loop;
    v(v'first) := x;
  end Shift_Up;

-- FIRST ORDER EXTRAPOLATION  :

  procedure Affine_Update_Direction
                ( t,prev_t,target : in Complex_Number;
                  x,prevx : in QuadDobl_Complex_Vectors.Vector;
                  prevdls,prevstep : in out quad_double;
                  prevdiff,v : in out Quad_Double_Vectors.Vector ) is

    newdls : quad_double;
    newstep : constant quad_double := AbsVal(t-prev_t);
    newdiff : Quad_Double_Vectors.Vector(prevdiff'range);
    ratio,factor : quad_double;

  begin
    for i in v'range loop
      newdiff(i) := LOG10(AbsVal(x(i))) - LOG10(AbsVal(prevx(i)));
    end loop;
    newdls := LOG10(AbsVal(target-prev_t)) - LOG10(AbsVal(target-t));
    if not is_zero(prevdls) then
      ratio := prevstep/newstep;
      factor := prevdls - ratio*newdls;
      for i in v'range loop
        v(i) := (prevdiff(i) - ratio*newdiff(i))/factor;
      end loop;
    end if;
    prevdiff := newdiff;
    prevstep := newstep;
    prevdls := newdls;
  end Affine_Update_Direction;

  procedure Projective_Update_Direction
                ( t,prev_t,target : in Complex_Number;
                  x,prevx : in QuadDobl_Complex_Vectors.Vector;
                  prevdls,prevstep : in out quad_double;
                  prevdiff,v : in out Quad_Double_Vectors.Vector ) is

    newdls : quad_double;
    newstep : constant quad_double := AbsVal(t-prev_t);
    newdiff : Quad_Double_Vectors.Vector(prevdiff'range);
    ratio,factor : quad_double;

  begin
    for i in v'range loop
      newdiff(i) := ( LOG10(AbsVal(x(i))) - LOG10(AbsVal(x(x'last))) )
      - ( LOG10(AbsVal(prevx(i))) - LOG10(AbsVal(prevx(prevx'last))) );
    end loop;
    newdls := LOG10(AbsVal(target-prev_t)) - LOG10(AbsVal(target-t));
    if not is_zero(prevdls) then -- if prevdls /= 0.0 then
      ratio := prevstep/newstep;
      factor := prevdls - ratio*newdls;
      for i in v'range loop
        v(i) := (prevdiff(i) - ratio*newdiff(i))/factor;
      end loop;
    end if;
    prevdiff := newdiff;
    prevstep := newstep;
    prevdls := newdls;
  end Projective_Update_Direction;

-- DATA MANAGEMENT FOR HIGHER-ORDER EXTRAPOLATION :

  procedure Extrapolation_Window
                ( r,m : in integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out VecVec ) is

  -- DESCRIPTION :
  --   The data (dt,s,logs and logx) are stored as in a window: when
  --   full at the incoming of a new element, all elements are shifted 
  --   and the oldest element drops off.

    use Quad_Double_Vectors;

  begin
    if (r = s'last) and (logx(r) /= null) then
      for i in s'first+1..s'last loop   -- shift the data
        s(i-1) := s(i);
        dt(i-1) := dt(i);
        logs(i-1) := logs(i);
        logx(i-1).all := logx(i).all;
      end loop;
    end if;
    dt(r) := (AbsVal(target-t));
    s(r) := (dt(r))**(1.0/Quad_Double_Numbers.create(m));
    logs(r) := LOG10(s(r));
  end Extrapolation_Window;

  procedure Refresh_Window
              ( r,m : in integer32; dt : in Quad_Double_Vectors.Vector;
                s,logs : in out Quad_Double_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Recomputes s and logs, after m has been changed.

  begin
    for i in s'first..r loop
      s(i) := (dt(i))**(1.0/Quad_Double_Numbers.Create(m));
      logs(i) := LOG10(s(i));
    end loop;
  end Refresh_Window;

  procedure Write_Update_Information
                ( file : in file_type; r,m : in integer32;
                  s,logs : in quad_double;
                  logx : in Quad_Double_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Writes r, s, log(s) and log|x(s)| on file.
  --   The current version only writes a banner with r and m.

  begin
    put(file,"extrapolation with r = "); put(file,r,1);
    put(file," and m = "); put(file,m,1); --put_line(file," : ");
   -- put(file,"m : "); put(file,s); 
   -- put(file,"  log(s) : "); put(file,logs);
   -- put(file,"   log|x(s)| : ");
   -- put(file,logx);
   -- for i in logx'range loop
   --   put(file,logx(i));
   -- end loop;
    new_line(file);
  end Write_Update_Information;

  procedure Affine_Update_Extrapolation_Data
                ( r,m : in integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx,wvl0,wvl1,wvltmp : in out VecVec ) is

  -- DESCRIPTION :
  --   Updates the data needed to extrapolate in the affine case.

    use Quad_Double_Vectors;

  begin
    Extrapolation_Window(r,m,t,target,x,dt,s,logs,logx);
    if logx(r) = null
     then logx(r) := new Quad_Double_Vectors.Vector(x'range);
    end if;
    if r > 0 then
      if wvl0(r) = null then
         wvl0(r) := new Quad_Double_Vectors.Vector'(x'range => create(0.0));
         wvl1(r) := new Quad_Double_Vectors.Vector'(x'range => create(0.0));
         wvltmp(r) := new Quad_Double_Vectors.Vector'(x'range => create(0.0));
      end if;
    end if;
    for i in x'range loop
      logx(r)(i) := LOG10(AbsVal(x(i)));
    end loop;
  end Affine_Update_Extrapolation_Data;

  procedure Projective_Update_Extrapolation_Data
                ( r,m : in integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out VecVec ) is

  -- DESCRIPTION :
  --   Updates the data needed to extrapolate in the projective case,
  --   under the assumption that the homogenization variable appears lastly.

    use Quad_Double_Vectors;

  begin
    Extrapolation_Window(r,m,t,target,x,dt,s,logs,logx);
    if logx(r) = null
     then logx(r) := new Quad_Double_Vectors.Vector(x'first..x'last-1);
    end if;
    for i in x'first..x'last-1 loop
      logx(r)(i) := LOG10(AbsVal(x(i))) - LOG10(AbsVal(x(x'last)));
    end loop;
  end Projective_Update_Extrapolation_Data;

  procedure Update_Errors
              ( r : in integer32;
                errorv : in out Quad_Double_Vectors.Vector;
                error : out quad_double; wvl0,wvl1,wvltmp : in out VecVec ) is

  -- DESCRIPTION :
  --   Updates the error computation after the extrapolation.

  -- REQUIRED : r >= 1.

  begin
    if r = 1 then
      for i in errorv'range loop
        errorv(i) := abs(wvltmp(r)(i) - wvl1(r)(i));
      end loop;
    else
      for i in errorv'range loop
        errorv(i) := abs(wvltmp(r-1)(i) - wvl1(r-1)(i));
      end loop;
    end if;
    error := Norm1(errorv);
    for i in 1..r loop
      wvl0(i).all := wvl1(i).all;
      wvl1(i).all := wvltmp(i).all;
    end loop;
  end Update_Errors;

-- ESTIMATING THE CYCLE NUMBER :

  procedure Frequency_of_Estimate
               ( newest : in integer32; max : in natural32;
                 m,estm : in out integer32; cnt : in out natural32;
                 eps : in quad_double; newm : out boolean ) is

  -- DESCRIPTION :
  --   This procedure manages the frequencies of the estimated values for m.
  --   Only after the same estimate has been found a certain number of
  --   times, the new estimate will be accepted.
  --   The current version does not take the accuracy eps into account.

  -- ON ENTRY :
  --   newest    newly computed estimate for m;
  --   max       threshold on cnt before estm is returned;
  --   m         current value of m;
  --   estm      previous estimate;
  --   cnt       number of consecutive guesses that yielded estm;
  --   eps       accuracy of the current estimate.

  -- ON RETURN :
  --   m         new value of m;
  --   estm      new estimate;
  --   cnt       updated number of consecutive guesses that yielded estm;
  --   newm      true if m has changed.

  begin
    if cnt = 0 then                                       -- initial estimate
      estm := newest;
      cnt := 1;
    elsif newest = estm then         -- update frequency for current estimate
      cnt := cnt + 1;
    else 
      cnt := 1;                                 -- new estimate found
      estm := newest;
    end if;
    if estm /= m then        -- look for modification of current cycle number
      if (cnt >= max) --and (eps <= 0.1)
       then m := estm; newm := true;
       else newm := false;
      end if;
     else newm := false;
    end if;
  end Frequency_of_Estimate;

  procedure Extrapolate_on_Errors
               ( file : in file_type;
                 r : in integer32; h : in quad_double;
                 err : in Quad_Double_Vectors.Vector;
                 estm : out quad_double ) is

  -- DESCRIPTION :
  --   Performs an rth-order extrapolation on the errors.

  -- ON ENTRY :
  --   file      to write intermediate results on;
  --   r         order of the extrapolation method;
  --   h         ratio in geometric sequence;
  --   err       vector of range 0..r+1 with differences of estimates for
  --             the outer normal, the most recent error is err(0).

  -- ON RETURN :
  --   extm      estimated value for m.

    em,hm,exterr : Quad_Double_Vectors.Vector(1..r+1);
    dlog : constant quad_double := log10(h);
    f : quad_double;

  begin
    for j in exterr'range loop
      exterr(j) := log10(err(j-1)) - log10(err(j));
    end loop;
    em(1) := dlog/exterr(1);                           -- 0th order estimate
   -- if (m(1) < 0.0001) or (m(1) > 1000.0)              -- avoid divergence
   --  then m(r+1) := m(1);
   --  else 
          hm(1) := h**(1.0/em(1));
          for k in 1..r loop
            f := hm(k) - 1.0;
            for j in 1..r-k+1 loop
              exterr(j) := exterr(j+1) + (exterr(j+1) - exterr(j))/f;
            end loop;
            em(k+1) := dlog/exterr(1);
   --  exit when ((m(k+1) < 0.0001) or (m(k+1) > 1000.0));
            hm(k+1) := h**(Quad_Double_Numbers.create(k+1)/em(k+1));
          end loop;
   -- end if;
    estm := em(r+1);
    put(file,"em(0.."); put(file,r,1); put(file,") : ");
    for i in em'range loop
      put(file," "); put(file,em(i),3);
    end loop;
    new_line(file);
  exception
    when others => null;
  end Extrapolate_on_Errors;

  procedure Estimate0
               ( r : in integer32; max : in natural32;
                 m,estm : in out integer32; cnt : in out natural32;
                 dt : in Quad_Double_Vectors.Vector;
                 err,newerr : in quad_double; rat,eps : out quad_double;
                 newm : out boolean ) is

  -- DESCRIPTION :
  --   Returns an 0th-order estimate of the cycle number m.
  
  -- ON ENTRY :
  --   r         extrapolation order;
  --   max       threshold on cnt before estm is returned;
  --   m         current value of m;
  --   estm      previous estimate;
  --   cnt       number of consecutive guesses that yielded estm;
  --   dt        consecutive distances to the target;
  --   err       previous error;
  --   newerr    current error.

  -- ON RETURN :
  --   m         new value of m;
  --   estm      new estimate;
  --   cnt       updated number of consecutive guesses that yielded estm;
  --   rat       ratio used to estimate m;
  --   eps       accuracy of the rounding value for m;
  --   newm      true if m has changed.

    dferr : constant quad_double := log10(newerr) - log10(err);
    h : constant quad_double := dt(r)/dt(r-1);
    dfsr1 : constant quad_double := log10(h);
    ratio : constant quad_double := abs(dfsr1/dferr);
    res : integer32 := integer32(hihi_part(ratio));
    accuracy : constant quad_double
             := abs(Quad_Double_Numbers.create(res) - ratio);

  begin
    if res = 0
     then res := 1;
    end if;
    Frequency_of_Estimate(res,max,m,estm,cnt,accuracy,newm);
    rat := ratio; eps := accuracy;
  end Estimate0;

  procedure Estimate
               ( file : in file_type; r : in integer32;
                 max : in natural32; m,estm : in out integer32;
                 cnt : in out natural32; h : in quad_double;
                 diferr : in Quad_Double_Vectors.Vector;
                 rat,eps : out quad_double; newm : out boolean ) is

  -- DESCRIPTION :
  --   Estimates m by extrapolation on consecutvie differences of errors,
  --   stored in the parameter diferr.  For the specfication of the other
  --   parameters, see the procedure Estimate0.

    res : integer32;
    fltestm,accuracy : quad_double;

  begin
   -- if r < dt'last
   --  then Extrapolate_on_Errors(file,r-1,h,diferr(0..r),fltestm);
   --  else
    Extrapolate_on_Errors(file,r,h,diferr(0..r+1),fltestm);
   -- end if;
    res := integer32(hihi_part(fltestm));
    if res <= 0
     then res := 1;
    end if;
    accuracy := abs(Quad_Double_Numbers.create(res) - fltestm);
    Frequency_of_Estimate(res,max,m,estm,cnt,accuracy,newm);
    rat := fltestm; eps := accuracy;
  end Estimate;

-- APPLYING THE vLpRs-Algorithm :

  function vLpRs_Extrapolate
                ( r : integer32; s,logs : Quad_Double_Vectors.Vector;
                  logx : VecVec )
                return Quad_Double_Vectors.Vector is

  -- DESCRIPTION :
  --   Higher-order extrapolation is based on vLpRs-Algorithm.

  -- REQUIRED : r >= 1.

    res : Quad_Double_Vectors.Vector(logx(r).all'range);
    logx1 : Quad_Double_Vectors.Vector(0..r);
    rt1,rt2 : Matrix(1..r-1,1..r-1);
    srp,dsp : Quad_Double_Vectors.Vector(1..r-1) := (0..r-1 => create(0.0));
    p : Quad_Double_Vectors.Vector(0..r-1) := (0..r-1 => create(0.0));
    l,v : Quad_Double_Vectors.Vector(0..r) := (0..r => create(1.0));

  begin
    rt1(1,1) := create(0.0); rt2(1,1) := create(0.0);
    for i in res'range loop
      for j in logx1'range loop
        logx1(j) := logx(j)(i);
      end loop;
      vLpRs_full(r,s(0..r),logs(0..r),logx1(0..r),srp,dsp,p,l,v,rt1,rt2);
      res(i) := v(r)/l(r);
    end loop;
    return res;
  end vLpRs_Extrapolate;

  function vLpRs_Extrapolate
                ( file : file_type; r : integer32;
                  s,logs : Quad_Double_Vectors.Vector; logx : VecVec )
                return Quad_Double_Vectors.Vector is

  -- DESCRIPTION :
  --   Higher-order extrapolation based on vLpRs-Algorithm.

  -- REQUIRED : r >= 1.

    res : Quad_Double_Vectors.Vector(logx(r).all'range);
    logx1 : Quad_Double_Vectors.Vector(0..r);
    rt1,rt2 : Matrix(1..r-1,1..r-1);
    srp,dsp : Quad_Double_Vectors.Vector(1..r-1) := (0..r-1 => create(0.0));
    p : Quad_Double_Vectors.Vector(0..r-1) := (0..r-1 => create(0.0));
    l,v : Quad_Double_Vectors.Vector(0..r) := (0..r => create(0.0));

  begin
    for i in rt1'range(1) loop
      for j in rt1'range(2) loop
        rt1(i,j) := create(0.0); rt2(i,j) := create(0.0);
      end loop;
    end loop;
    for i in res'range loop
      for j in logx1'range loop
        logx1(j) := logx(j)(i);
      end loop;
      vLpRs_pipe(file,r,s(0..r),logs(0..r),logx1(0..r),srp,dsp,p,l,v,rt1,rt2);
      res(i) := v(r)/l(r);
    end loop;
    return res;
  end vLpRs_Extrapolate;

  procedure vLpRs_Extrapolate
                ( file : in file_type; r : in integer32;
                  s,logs : in Quad_Double_Vectors.Vector;
                  logx,wvl0 : in VecVec; wvl1 : in out VecVec;
                  w,wv,wl : out Quad_Double_Vectors.Vector ) is

  -- DESCRIPTION :
  --   Higher-order extrapolation based on vLpRs-Algorithm,
  --   writes an error table on file.

  -- REQUIRED : r >= 1.

    n : constant integer32 := logx(r)'length;
    logx1 : Quad_Double_Vectors.Vector(0..r);
    rt1,rt2 : Matrix(1..r-1,1..r-1);
    srp,dsp : Quad_Double_Vectors.Vector(1..r-1) := (1..r-1 => create(0.0));
    p : Quad_Double_Vectors.Vector(0..r-1) := (0..r-1 => create(0.0));
    l,v : Quad_Double_Vectors.Vector(0..r) := (0..r => create(0.0));
    error : Quad_Double_Vectors.Vector(1..r) := (1..r => create(0.0));

  begin
    for i in rt1'range(1) loop
      for j in rt1'range(2) loop
        rt1(i,j) := create(0.0); rt2(i,j) := create(0.0);
      end loop;
    end loop;
    for i in logx(r)'range loop
      for j in logx1'range loop
        logx1(j) := logx(j)(i);
      end loop;
      vLpRs_pipe(file,r,s(0..r),logs(0..r),logx1(0..r),srp,dsp,p,l,v,rt1,rt2);
      w(i) := v(r)/l(r);
      put(file,s(r),3);
      for j in 1..r loop
        wvl1(j)(i) := v(j)/l(j);
        error(j) := abs(wvl1(j)(i)-wvl0(j)(i));
        put(file," "); put(file,error(j),3);
      end loop;
      new_line(file);
    end loop;
    wv := v; wl := l;
  end vLpRs_Extrapolate;

-- HIGHER-ORDER EXTRAPOLATION (target routines) :

  procedure Affine_Update_Direction
                ( r,m,estm : in out integer32;
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx,wvl0,wvl1,wvltmp : in out VecVec;
                  v,diferr : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double ) is

    use Quad_Double_Vectors;
    res : Quad_Double_Vectors.Vector(v'range);
   -- eps : quad_double;
    newerr : quad_double;
    newm : boolean := false;

  begin
    Affine_Update_Extrapolation_Data
      (r,m,t,target,x,dt,s,logs,logx,wvl0,wvl1,wvltmp);
    if r >= 1 then
      res := vLpRs_Extrapolate(r,s,logs,logx);
      newerr := Norm1(res-v);
    end if;
    if r < s'last
     then r := r+1;
    end if;
    if r >= 3 and (newerr < error) then
      --Estimate(r,r,thresm,m,estm,cntm,dt,s,logs,error,newerr,eps,newm);
      if newm then
        res := vLpRs_Extrapolate(r,s,logs,logx);
        newerr := Norm1(res-v);
      end if;
    end if;
    if r >= 1
     then v := res; error := newerr;
    end if;
  end Affine_Update_Direction;

  procedure Affine_Update_Direction
                ( file : in file_type; 
                  r,m,estm : in out integer32; 
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx,wvl0,wvl1,wvltmp : in out VecVec;
                  v,diferr : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double ) is

    use Quad_Double_Vectors;
   -- res,errorv,newerrv : Quad_Double_Vectors.Vector(v'range);
    res,errorv : Quad_Double_Vectors.Vector(v'range);
    wv,wl : Quad_Double_Vectors.Vector(0..r);
    ind : integer32 := 1;      -- errors based on first-order extrapolation
    rat,eps : quad_double;
   -- newerr : quad_double;
   -- mv,cntmv,estmv : Standard_Integer_Vectors.Vector(v'range);
    newm : boolean := false;

  begin
    Affine_Update_Extrapolation_Data
      (r,m,t,target,x,dt,s,logs,logx,wvl0,wvl1,wvltmp);
    Write_Update_Information(file,r,m,s(r),logs(r),logx(r).all);
    if r >= 1 then
      vLpRs_Extrapolate(file,r,s,logs,logx,wvl1,wvltmp,res,wv,wl);
      if r = 1 then diferr(0) := create(1.0); end if;
      for i in errorv'range loop
        errorv(i) := abs(wvltmp(ind)(i) - wvl1(ind)(i));
      end loop;
      Shift_Up(diferr,Norm1(errorv));
      if er < diferr'last-1 then er := er+1; end if;
    end if;
    if er >= 1 and (diferr(0) < diferr(1)) then
     -- Estimate0(r,thresm,m,estm,cntm,diferr(1),diferr(0),rat,eps,newm);
      Estimate(file,er,thresm,m,estm,cntm,dt(r)/dt(r-1),
               diferr,rat,eps,newm);
      put(file,"Ratio for m : "); put(file,rat,3);
      put(file," and accuracy : "); put(file,eps,3); new_line(file);
      if newm then
        Refresh_Window(r,m,dt,s,logs);
        put_line(file,"Extrapolation after adjusting the m-value :");
        vLpRs_Extrapolate(file,r,s,logs,logx,wvl1,wvltmp,res,wv,wl);
        for i in errorv'range loop
          errorv(i) := abs(wvltmp(ind)(i) - wvl1(ind)(i));
        end loop;
        Shift_Up(diferr,Norm1(errorv)); er := -2;
        put(file,"old direction : "); put(file,v); new_line(file);
        put(file,"new direction : "); put(file,res); new_line(file);
      end if;
    end if;
    if r >= 1 then
      v := res;
      Update_Errors(r,errorv,error,wvl0,wvl1,wvltmp);
    end if;
    if r < s'last then r := r+1; end if;
  end Affine_Update_Direction;

  procedure Projective_Update_Direction
                ( r,m,estm : in out integer32;
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out VecVec;
                  prevv,v : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double ) is

    use Quad_Double_Vectors;
    res : Quad_Double_Vectors.Vector(v'range);
   -- eps : quad_double;
    newerr : quad_double;
    newm : boolean := false;

  begin
    Projective_Update_Extrapolation_Data(r,m,t,target,x,dt,s,logs,logx);
    if r >= 1 then
      res := vLpRs_Extrapolate(r,s,logs,logx);
      error := Norm1(res-prevv); newerr := Norm1(res-v);
      prevv := v;
      v := res;
    end if;
   -- if r >= 2 and (newerr < error)
   --  then Estimate(r,r,thresm,m,estm,cntm,dt,s,logs,error,newerr,eps,newm);
   -- end if;
    if r < s'last
     then r := r+1;
    end if;
    error := newerr;
  end Projective_Update_Direction;

  procedure Projective_Update_Direction
                ( file : in file_type;
                  r,m,estm : in out integer32;
                  cntm : in out natural32; thresm : in natural32;
                  er : in out integer32; t,target : in Complex_Number;
                  x : in QuadDobl_Complex_Vectors.Vector;
                  dt,s,logs : in out Quad_Double_Vectors.Vector;
                  logx : in out VecVec;
                  prevv,v : in out Quad_Double_Vectors.Vector;
                  error : in out quad_double ) is

    use Quad_Double_Vectors;
    res : Quad_Double_Vectors.Vector(v'range);
   -- eps : quad_double;
    newerr : quad_double;
    newm : boolean := false;

  begin
    Projective_Update_Extrapolation_Data(r,m,t,target,x,dt,s,logs,logx);
    Write_Update_Information(file,r,m,s(r),logs(r),logx(r).all);
    if r >= 1 then
      res := vLpRs_Extrapolate(file,r,s,logs,logx);
      error := Norm1(res-prevv);
      newerr := Norm1(res-v);
      prevv := v;
      v := res;
    end if;
    if r < s'last
     then r := r+1;
    end if;
   -- if r >= 2 and (newerr < error)
   --  then Estimate(r,r,thresm,m,estm,cntm,dt,s,logs,error,newerr,eps,newm);
   -- end if;
    error := newerr;
  end Projective_Update_Direction;

end Directions_of_QuadDobl_Paths;
