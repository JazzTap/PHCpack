with Double_Double_Numbers;              use Double_Double_Numbers;
with DoblDobl_Complex_Numbers;           use DoblDobl_Complex_Numbers;
with DoblDobl_Random_Vectors;            use DoblDobl_Random_Vectors;
with DoblDobl_Sampling_Machine;

package body DoblDobl_Sample_Lists is

-- CREATORS :

  function Create ( sols : DoblDobl_Complex_Solutions.Solution_List;
                    hyps : DoblDobl_Complex_VecVecs.VecVec )
                  return DoblDobl_Sample_List is

    res,res_last : DoblDobl_Sample_List;
    use DoblDobl_Complex_Solutions;
    tmp : Solution_List := sols;

  begin
    while not Is_Null(tmp) loop
      declare
        s : constant DoblDobl_Sample := Create(Head_Of(tmp).all,hyps);
      begin
        Append(res,res_last,s);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Create;

-- SAMPLERS :

  procedure Sample ( s : in DoblDobl_Sample; m : in natural32;
                     samples,samples_last : in out DoblDobl_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : DoblDobl_Sample;
      begin
        Sample(s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Sample;

  procedure Sample ( file : in file_type; full_output : in boolean;
                     s : in DoblDobl_Sample; m : in natural32;
                     samples,samples_last : in out DoblDobl_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : DoblDobl_Sample;
      begin
        Sample(file,full_output,s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Sample;

  procedure Parallel_Sample
              ( s : in DoblDobl_Sample; m : in natural32;
                samples,samples_last : in out DoblDobl_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : DoblDobl_Sample;
      begin
        Parallel_Sample(s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Parallel_Sample;

  procedure Parallel_Sample
              ( file : in file_type; full_output : in boolean;
                s : in DoblDobl_Sample; m : in natural32;
                samples,samples_last : in out DoblDobl_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : DoblDobl_Sample;
      begin
        Parallel_Sample(file,full_output,s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Parallel_Sample;

  procedure Create_Samples
              ( s2sols : in DoblDobl_Complex_Solutions.Solution_List;
                hyps : in DoblDobl_Complex_VecVecs.VecVec;
                s2,s2_last : in out DoblDobl_Sample_List ) is

  -- DESCRIPTION :
  --   This routine is auxiliary, it creates samples from a list of
  --   solutions and a set of slices.

    use DoblDobl_Complex_Solutions;
    tmp : Solution_List;

  begin
    tmp := s2sols;
    while not Is_Null(tmp) loop
      declare
        newspt : constant DoblDobl_Sample := Create(Head_Of(tmp).all,hyps);
      begin
        Append(s2,s2_last,newspt);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Create_Samples;

  procedure Sample ( s1 : in DoblDobl_Sample_List;
                     hyps : in DoblDobl_Complex_VecVecs.VecVec;
                     s2,s2_last : in out DoblDobl_Sample_List ) is

    s1sols : DoblDobl_Complex_Solutions.Solution_List := Sample_Points(s1);
    s2sols : DoblDobl_Complex_Solutions.Solution_List;

  begin
    DoblDobl_Sampling_Machine.Sample(s1sols,hyps,s2sols);
    Create_Samples(s2sols,hyps,s2,s2_last);
    DoblDobl_Complex_Solutions.Deep_Clear(s1sols);
    DoblDobl_Complex_Solutions.Deep_Clear(s2sols);
  end Sample;

  procedure Sample ( file : in file_type;
                     s1 : in DoblDobl_Sample_List;
                     hyps : in DoblDobl_Complex_VecVecs.VecVec;
                     s2,s2_last : in out DoblDobl_Sample_List ) is

    s1sols : DoblDobl_Complex_Solutions.Solution_List := Sample_Points(s1);
    s2sols : DoblDobl_Complex_Solutions.Solution_List;

  begin
    DoblDobl_Sampling_Machine.Sample(file,s1sols,hyps,s2sols);
    Create_Samples(s2sols,hyps,s2,s2_last);
    DoblDobl_Complex_Solutions.Deep_Clear(s1sols);
    DoblDobl_Complex_Solutions.Deep_Clear(s2sols);
  end Sample;

  procedure Sample_with_Stop
              ( s1 : in DoblDobl_Sample_List;
                x : in DoblDobl_Complex_Vectors.Vector;
                tol : in double_float;
                hyps : in DoblDobl_Complex_VecVecs.VecVec;
                s2,s2_last : in out DoblDobl_Sample_List ) is

    s1sols : DoblDobl_Complex_Solutions.Solution_List := Sample_Points(s1);
    use DoblDobl_Complex_Solutions;
    s2sols,tmp : Solution_List;

  begin
    DoblDobl_Sampling_Machine.Sample_with_Stop(s1sols,x,tol,hyps,s2sols);
    tmp := s2sols;
    while not Is_Null(tmp) loop
      declare
        newspt : constant DoblDobl_Sample := Create(Head_Of(tmp).all,hyps);
      begin
        Append(s2,s2_last,newspt);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    Deep_Clear(s1sols);
    Deep_Clear(s2sols);
  end Sample_with_Stop;

-- SAMPLING MEMBERSHIP TEST :

  function Equal ( x,y : DoblDobl_Complex_Vectors.Vector;
                   tol : double_float ) return boolean is

  -- DESCRIPTION :
  --   Returns true if all components of x and y are as close
  --   to each other as the given tolerance.

    diff : Complex_Number;
    absdif : double_double;

  begin
    for i in x'range loop
      diff := x(i) - y(i);
      absdif := AbsVal(diff);
      if absdif > tol
       then return false;
      end if;
    end loop;
    return true;
  end Equal;

  function Is_In ( s : DoblDobl_Sample_List; tol : double_float;
                   x : DoblDobl_Complex_Vectors.Vector ) return natural32 is

    tmp : DoblDobl_Sample_List := s;

  begin
    for i in 1..Length_Of(s) loop
      declare
        y : constant DoblDobl_Complex_Vectors.Vector
          := Sample_Point(Head_Of(tmp)).v;
      begin
        if Equal(x,y,tol)
         then return natural32(i);
        end if;
      end;
      tmp := Tail_Of(tmp);
    end loop;
    return 0;
  end Is_In;

  function Is_In ( s : DoblDobl_Sample_List; tol : double_float;
                   spt : DoblDobl_Sample ) return natural32 is
  begin
    return Is_In(s,tol,Sample_Point(spt).v);
  end Is_In;

  procedure Membership_Test
                ( s1 : in DoblDobl_Sample_List;
                  x : in DoblDobl_Complex_Vectors.Vector;
                  tol : in double_float; isin : out natural32;
                  s2,s2_last : in out DoblDobl_Sample_List ) is

    n : constant integer32 := x'last;
    m : constant integer32 := integer32(Number_of_Slices(Head_Of(s1)));
    nor : DoblDobl_Complex_Vectors.Vector(1..n);
    hyps : DoblDobl_Complex_VecVecs.VecVec(1..m);
    use DoblDobl_Complex_Vectors;
    eva : Complex_Number;

  begin
    for i in 1..m loop                             -- hyperplanes through x
      nor := Random_Vector(1,n);
      eva := x*nor;
      hyps(i) := new Vector(0..n);
      hyps(i)(nor'range) := nor;
      hyps(i)(0) := -eva;
    end loop;
   -- Sample(s1,hyps,s2,s2_last);                    -- conduct samples+test
    Sample_with_Stop(s1,x,tol,hyps,s2,s2_last);
    isin := Is_In(s2,tol,x);
    DoblDobl_Complex_VecVecs.Clear(hyps);
  end Membership_Test;

-- SELECTORS :

  function Sample_Points ( s : DoblDobl_Sample_List )
                         return DoblDobl_Complex_Solutions.Solution_List is

    use DoblDobl_Complex_Solutions;
    res,res_last : Solution_List;
    tmp : DoblDobl_Sample_List := s;

  begin
    while not Is_Null(tmp) loop
      Append(res,res_last,Sample_Point(Head_Of(tmp)));
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Sample_Points;

  function Select_Sub_List ( l : DoblDobl_Sample_List;
                             f : Standard_Natural_Vectors.Vector )
                           return DoblDobl_Sample_List is

    res,res_last : DoblDobl_Sample_List;
    tmp : DoblDobl_Sample_List := l;
    ind : integer32 := f'first;
  
  begin
    for i in 1..Length_Of(l) loop
      if i = f(ind) then
        Append(res,res_last,Head_Of(tmp));
        ind := ind + 1;
      end if;
      exit when (ind > f'last);
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Select_Sub_List;

  function Select_Sub_Grid ( grid : Array_of_DoblDobl_Sample_Lists;
                             f : Standard_Natural_Vectors.Vector )
                           return Array_of_DoblDobl_Sample_Lists is

    res : Array_of_DoblDobl_Sample_Lists(grid'range);
 
  begin
    for i in grid'range loop
      res(i) := Select_Sub_List(grid(i),f);
    end loop;
    return res;
  end Select_Sub_Grid;

-- DESTRUCTORS :

  procedure Shallow_Clear ( samples : in out DoblDobl_Sample_List ) is
  begin
    Lists_of_DoblDobl_Samples.Clear(Lists_of_DoblDobl_Samples.List(samples));
  end Shallow_Clear;

  procedure Shallow_Clear
                 ( samples : in out Array_of_DoblDobl_Sample_Lists ) is
  begin
    for i in samples'range loop
      Shallow_Clear(samples(i));
    end loop;
  end Shallow_Clear;

  procedure Deep_Clear ( samples : in out DoblDobl_Sample_List ) is

    tmp : DoblDobl_Sample_List := samples;

  begin
    while not Is_Null(tmp) loop
      declare
        sample : DoblDobl_Sample := Head_Of(tmp);
      begin
        Deep_Clear(sample);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    Shallow_Clear(samples);  
  end Deep_Clear;

  procedure Deep_Clear ( samples : in out Array_of_DoblDobl_Sample_Lists ) is
  begin
    for i in samples'range loop
      Deep_Clear(samples(i));
    end loop;
  end Deep_Clear;

end DoblDobl_Sample_Lists;
