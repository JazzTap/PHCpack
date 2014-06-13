with Standard_Complex_Numbers;           use Standard_Complex_Numbers;
with Standard_Random_Vectors;            use Standard_Random_Vectors;
with Standard_Complex_Norms_Equals;      use Standard_Complex_Norms_Equals;
with Sampling_Machine;

package body Sample_Point_Lists is

-- CREATORS :

  function Create ( sols : Standard_Complex_Solutions.Solution_List;
                    hyps : Standard_Complex_VecVecs.VecVec )
                  return Standard_Sample_List is

    res,res_last : Standard_Sample_List;
    use Standard_Complex_Solutions;
    tmp : Solution_List := sols;

  begin
    while not Is_Null(tmp) loop
      declare
        s : constant Standard_Sample := Create(Head_Of(tmp).all,hyps);
      begin
        Append(res,res_last,s);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Create;

  function Create ( sols : Multprec_Complex_Solutions.Solution_List;
                    hyps : Multprec_Complex_VecVecs.VecVec )
                  return Multprec_Sample_List is

    res,res_last : Multprec_Sample_List;
    use Multprec_Complex_Solutions;
    tmp : Solution_List := sols;

  begin
    while not Is_Null(tmp) loop
      declare
        s : constant Multprec_Sample := Create(Head_Of(tmp).all,hyps);
      begin
        Append(res,res_last,s);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Create;

-- SAMPLERS and REFINERS :

  procedure Sample ( s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Standard_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Standard_Sample;
      begin
        Sample(s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Sample;

  procedure Sample ( file : in file_type; full_output : in boolean;
                     s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Standard_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Standard_Sample;
      begin
        Sample(file,full_output,s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Sample;

  procedure Sample ( s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Multprec_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Multprec_Sample;
      begin
        Sample(s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Sample;

  procedure Sample ( file : in file_type; full_output : in boolean;
                     s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Multprec_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Multprec_Sample;
      begin
        Sample(file,full_output,s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Sample;

  procedure Parallel_Sample
                   ( s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Standard_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Standard_Sample;
      begin
        Parallel_Sample(s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Parallel_Sample;

  procedure Parallel_Sample
                   ( file : in file_type; full_output : in boolean;
                     s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Standard_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Standard_Sample;
      begin
        Parallel_Sample(file,full_output,s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Parallel_Sample;

  procedure Parallel_Sample
                   ( s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Multprec_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Multprec_Sample;
      begin
        Parallel_Sample(s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Parallel_Sample;

  procedure Parallel_Sample
                   ( file : in file_type; full_output : in boolean;
                     s : in Standard_Sample; m : in natural32;
                     samples,samples_last : in out Multprec_Sample_List ) is
  begin
    for i in 1..m loop
      declare
        s2 : Multprec_Sample;
      begin
        Parallel_Sample(file,full_output,s,s2);
        Append(samples,samples_last,s2);
      end;
    end loop;
  end Parallel_Sample;

  procedure Create_Samples
              ( s2sols : in Standard_Complex_Solutions.Solution_List;
                hyps : in Standard_Complex_VecVecs.VecVec;
                s2,s2_last : in out Standard_Sample_List ) is

  -- DESCRIPTION :
  --   This routine is auxiliary, it creates samples from a list of
  --   solutions and a set of slices.

    use Standard_Complex_Solutions;
    tmp : Solution_List;

  begin
    tmp := s2sols;
    while not Is_Null(tmp) loop
      declare
        newspt : constant Standard_Sample := Create(Head_Of(tmp).all,hyps);
      begin
        Append(s2,s2_last,newspt);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Create_Samples;

  procedure Sample ( s1 : in Standard_Sample_List;
                     hyps : in Standard_Complex_VecVecs.VecVec;
                     s2,s2_last : in out Standard_Sample_List ) is

    s1sols : Standard_Complex_Solutions.Solution_List := Sample_Points(s1);
    s2sols : Standard_Complex_Solutions.Solution_List;

  begin
    Sampling_Machine.Sample(s1sols,hyps,s2sols);
    Create_Samples(s2sols,hyps,s2,s2_last);
    Standard_Complex_Solutions.Deep_Clear(s1sols);
    Standard_Complex_Solutions.Deep_Clear(s2sols);
  end Sample;

  procedure Sample ( s1 : in Standard_Sample_List;
                     hyps : in Standard_Complex_VecVecs.VecVec;
                     s2,s2_last : in out Multprec_Sample_List ) is

    s1sols : Standard_Complex_Solutions.Solution_List := Sample_Points(s1);
    s2sols : Standard_Complex_Solutions.Solution_List;
    sts2,sts2_last : Standard_Sample_List;

  begin
    Sampling_Machine.Sample(s1sols,hyps,s2sols);
    Create_Samples(s2sols,hyps,sts2,sts2_last);
    Refine(sts2,s2,s2_last);
    Standard_Complex_Solutions.Deep_Clear(s1sols);
    Standard_Complex_Solutions.Deep_Clear(s2sols);
  end Sample;

  procedure Sample_on_Slices
                   ( s1 : in Standard_Sample_List;
                     sthyps : in Standard_Complex_VecVecs.VecVec;
                     mphyps : in Multprec_Complex_VecVecs.VecVec;
                     s2,s2_last : in out Multprec_Sample_List ) is

    s1sols : Standard_Complex_Solutions.Solution_List := Sample_Points(s1);
    s2sols : Standard_Complex_Solutions.Solution_List;
    sts2,sts2_last : Standard_Sample_List;

  begin
    Sampling_Machine.Sample(s1sols,sthyps,s2sols);
    Create_Samples(s2sols,sthyps,sts2,sts2_last);
    Refine_on_Slices(sts2,mphyps,s2,s2_last);
    Standard_Complex_Solutions.Deep_Clear(s1sols);
    Standard_Complex_Solutions.Deep_Clear(s2sols);
  end Sample_on_Slices;

  procedure Sample ( file : in file_type;
                     s1 : in Standard_Sample_List;
                     hyps : in Standard_Complex_VecVecs.VecVec;
                     s2,s2_last : in out Standard_Sample_List ) is

    s1sols : Standard_Complex_Solutions.Solution_List := Sample_Points(s1);
    s2sols : Standard_Complex_Solutions.Solution_List;

  begin
    Sampling_Machine.Sample(file,s1sols,hyps,s2sols);
    Create_Samples(s2sols,hyps,s2,s2_last);
    Standard_Complex_Solutions.Deep_Clear(s1sols);
    Standard_Complex_Solutions.Deep_Clear(s2sols);
  end Sample;

  procedure Sample_with_Stop
                   ( s1 : in Standard_Sample_List;
                     x : in Standard_Complex_Vectors.Vector;
                     tol : in double_float;
                     hyps : in Standard_Complex_VecVecs.VecVec;
                     s2,s2_last : in out Standard_Sample_List ) is

    s1sols : Standard_Complex_Solutions.Solution_List := Sample_Points(s1);
    use Standard_Complex_Solutions;
    s2sols,tmp : Solution_List;

  begin
    Sampling_Machine.Sample_with_Stop(s1sols,x,tol,hyps,s2sols);
    tmp := s2sols;
    while not Is_Null(tmp) loop
      declare
        newspt : constant Standard_Sample := Create(Head_Of(tmp).all,hyps);
      begin
        Append(s2,s2_last,newspt);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    Deep_Clear(s1sols);
    Deep_Clear(s2sols);
  end Sample_with_Stop;

  procedure Refine ( s1 : in out Standard_Sample_List;
                     s2,s2_last : in out Multprec_Sample_List ) is

    tmp : Standard_Sample_List := s1;

  begin
    while not Is_Null(tmp) loop
      declare
        sts1 : Standard_Sample := Head_Of(tmp);
        mps1 : Multprec_Sample;
      begin
        Refine(sts1,mps1);
        Set_Head(tmp,sts1);
        Append(s2,s2_last,mps1);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine;

  procedure Refine ( file : in file_type; full_output : in boolean;
                     s1 : in out Standard_Sample_List;
                     s2,s2_last : in out Multprec_Sample_List ) is

    tmp : Standard_Sample_List := s1;

  begin
    while not Is_Null(tmp) loop
      declare
        sts1 : Standard_Sample := Head_Of(tmp);
        mps1 : Multprec_Sample;
      begin
        Refine(file,full_output,sts1,mps1);
        Set_Head(tmp,sts1);
        Append(s2,s2_last,mps1);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine;

  procedure Refine ( samples : in out Multprec_Sample_List ) is

    tmp : Multprec_Sample_List := samples;

  begin
    while not Is_Null(tmp) loop
      declare
        s : Multprec_Sample := Head_Of(tmp);
      begin
        Refine(s);
        Set_Head(tmp,s);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine;

  procedure Refine ( file : in file_type; full_output : in boolean;
                     samples : in out Multprec_Sample_List ) is

    tmp : Multprec_Sample_List := samples;

  begin
    while not Is_Null(tmp) loop
      declare
        s : Multprec_Sample := Head_Of(tmp);
      begin
        Refine(file,full_output,s);
        Set_Head(tmp,s);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine;

  procedure Refine_on_Slices
                   ( s1 : in out Standard_Sample_List;
                     hyps : in Multprec_Complex_VecVecs.VecVec;
                     s2,s2_last : in out Multprec_Sample_List ) is

    tmp : Standard_Sample_List := s1;

  begin
    while not Is_Null(tmp) loop
      declare
        sts1 : Standard_Sample := Head_Of(tmp);
        mps1 : Multprec_Sample;
      begin
        Refine_on_Slices(sts1,hyps,mps1);
        Set_Head(tmp,sts1);
        Append(s2,s2_last,mps1);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine_on_Slices;

  procedure Refine_on_Slices
                   ( file : in file_type; full_output : in boolean;
                     s1 : in out Standard_Sample_List;
                     hyps : in Multprec_Complex_VecVecs.VecVec;
                     s2,s2_last : in out Multprec_Sample_List ) is

    tmp : Standard_Sample_List := s1;

  begin
    while not Is_Null(tmp) loop
      declare
        sts1 : Standard_Sample := Head_Of(tmp);
        mps1 : Multprec_Sample;
      begin
        Refine_on_Slices(file,full_output,sts1,hyps,mps1);
        Set_Head(tmp,sts1);
        Append(s2,s2_last,mps1);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine_on_Slices;

  procedure Refine_on_Slices ( samples : in out Multprec_Sample_List ) is

    tmp : Multprec_Sample_List := samples;

  begin
    while not Is_Null(tmp) loop
      declare
        s : Multprec_Sample := Head_Of(tmp);
      begin
        Refine_on_Slices(s);
        Set_Head(tmp,s);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine_on_Slices;

  procedure Refine_on_Slices
                   ( file : in file_type; full_output : in boolean;
                     samples : in out Multprec_Sample_List ) is

    tmp : Multprec_Sample_List := samples;

  begin
    while not Is_Null(tmp) loop
      declare
        s : Multprec_Sample := Head_Of(tmp);
      begin
        Refine_on_Slices(file,full_output,s);
        Set_Head(tmp,s);
      end;
      tmp := Tail_Of(tmp);
    end loop;
  end Refine_on_Slices;

-- SAMPLING MEMBERSHIP TEST :

  function Is_In ( s : Standard_Sample_List; tol : double_float;
                   x : Standard_Complex_Vectors.Vector ) return natural32 is

    tmp : Standard_Sample_List := s;

  begin
    for i in 1..Length_Of(s) loop
      declare
        y : constant Standard_Complex_Vectors.Vector
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

  function Is_In ( s : Standard_Sample_List; tol : double_float;
                   spt : Standard_Sample ) return natural32 is
  begin
    return Is_In(s,tol,Sample_Point(spt).v);
  end Is_In;

  procedure Membership_Test
                ( s1 : in Standard_Sample_List;
                  x : in Standard_Complex_Vectors.Vector;
                  tol : in double_float; isin : out natural32;
                  s2,s2_last : in out Standard_Sample_List ) is

    n : constant integer32 := x'last;
    m : constant integer32 := Number_of_Slices(Head_Of(s1));
    nor : Standard_Complex_Vectors.Vector(1..n);
    hyps : Standard_Complex_VecVecs.VecVec(1..m);
    use Standard_Complex_Vectors;
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
    Standard_Complex_VecVecs.Clear(hyps);
  end Membership_Test;

-- SELECTORS :

  function Sample_Points ( s : Standard_Sample_List )
                         return Standard_Complex_Solutions.Solution_List is

    use Standard_Complex_Solutions;
    res,res_last : Solution_List;
    tmp : Standard_Sample_List := s;

  begin
    while not Is_Null(tmp) loop
      Append(res,res_last,Sample_Point(Head_Of(tmp)));
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Sample_Points;

  function Sample_Points ( s : Multprec_Sample_List )
                         return Multprec_Complex_Solutions.Solution_List is

    use Multprec_Complex_Solutions; 
    res,res_last : Solution_List;
    tmp : Multprec_Sample_List := s;

  begin
    while not Is_Null(tmp) loop
      Append(res,res_last,Sample_Point(Head_Of(tmp)));
      tmp := Tail_Of(tmp);
    end loop;
    return res;
  end Sample_Points;

  function Select_Sub_List ( l : Standard_Sample_List;
                             f : Standard_Natural_Vectors.Vector )
                           return Standard_Sample_List is

    res,res_last : Standard_Sample_List;
    tmp : Standard_Sample_List := l;
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

  function Select_Sub_Grid ( grid : Array_of_Standard_Sample_Lists;
                             f : Standard_Natural_Vectors.Vector )
                           return Array_of_Standard_Sample_Lists is

    res : Array_of_Standard_Sample_Lists(grid'range);
 
  begin
    for i in grid'range loop
      res(i) := Select_Sub_List(grid(i),f);
    end loop;
    return res;
  end Select_Sub_Grid;

-- DESTRUCTORS :

  procedure Shallow_Clear ( samples : in out Standard_Sample_List ) is
  begin
    Lists_of_Standard_Samples.Clear(Lists_of_Standard_Samples.List(samples));
  end Shallow_Clear;

  procedure Shallow_Clear ( samples : in out Multprec_Sample_List ) is
  begin
    Lists_of_Multprec_Samples.Clear(Lists_of_Multprec_Samples.List(samples));
  end Shallow_Clear;

  procedure Shallow_Clear
                 ( samples : in out Array_of_Standard_Sample_Lists ) is
  begin
    for i in samples'range loop
      Shallow_Clear(samples(i));
    end loop;
  end Shallow_Clear;

  procedure Shallow_Clear
                 ( samples : in out Array_of_Multprec_Sample_Lists ) is
  begin
    for i in samples'range loop
      Shallow_Clear(samples(i));
    end loop;
  end Shallow_Clear;

  procedure Deep_Clear ( samples : in out Standard_Sample_List ) is

    tmp : Standard_Sample_List := samples;

  begin
    while not Is_Null(tmp) loop
      declare
        sample : Standard_Sample := Head_Of(tmp);
      begin
        Deep_Clear(sample);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    Shallow_Clear(samples);  
  end Deep_Clear;

  procedure Deep_Clear ( samples : in out Multprec_Sample_List ) is

    tmp : Multprec_Sample_List := samples;

  begin
    while not Is_Null(tmp) loop
      declare
        sample : Multprec_Sample := Head_Of(tmp);
      begin
        Deep_Clear(sample);
      end;
      tmp := Tail_Of(tmp);
    end loop;
    Shallow_Clear(samples);
  end Deep_Clear;

  procedure Deep_Clear ( samples : in out Array_of_Standard_Sample_Lists ) is
  begin
    for i in samples'range loop
      Deep_Clear(samples(i));
    end loop;
  end Deep_Clear;

  procedure Deep_Clear ( samples : in out Array_of_Multprec_Sample_Lists ) is
  begin
    for i in samples'range loop
      Deep_Clear(samples(i));
    end loop;
  end Deep_Clear;

end Sample_Point_Lists;
