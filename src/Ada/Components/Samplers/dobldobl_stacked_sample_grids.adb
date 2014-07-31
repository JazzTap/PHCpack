with unchecked_deallocation;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers_io;        use Standard_Integer_Numbers_io;
with Double_Double_Numbers_io;           use Double_Double_Numbers_io;
with DoblDobl_Complex_Numbers;           use DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Numbers_io;        use DoblDobl_Complex_Numbers_io;
with Double_Double_Matrices_io;          use Double_Double_Matrices_io;
with DoblDobl_Complex_Matrices;          use DoblDobl_Complex_Matrices;
with DoblDobl_Complex_Matrices_io;       use DoblDobl_Complex_Matrices_io;
with DoblDobl_Random_Matrices;           use DoblDobl_Random_Matrices;
with DoblDobl_Sampling_Machine;
with DoblDobl_Rectangular_Sample_Grids;  use DoblDobl_Rectangular_Sample_Grids;

package body DoblDobl_Stacked_Sample_Grids is

-- CREATORS :

  function Create ( k,n,d : integer32; sps : DoblDobl_Sample_List;
                    sli : VecVec; rancff : Matrix ) 
                  return Stacked_Sample_Grid is

  -- DESCRIPTION :
  --   Recursive version of the creator; k is the index to the varying slice.

    res : Stacked_Sample_Grid(k,d);
    len : natural32;
    startsps : DoblDobl_Sample_List;

  begin
    res.hyp := sli(1..k);
    res.n := natural32(n);
    if k = 1 then
      len := Length_Of(sps);
      res.g := new Array_of_DoblDobl_Sample_Lists(0..integer32(len));
      res.g(0) := sps;
      for i in 1..integer32(len) loop
        declare
          newsli : DoblDobl_Complex_VecVecs.VecVec(sli'range);
          newsps,newsps_last : DoblDobl_Sample_List;
        begin
          for j in sli'range loop
            newsli(j) := new DoblDobl_Complex_Vectors.Vector'(sli(j).all);
          end loop;
          newsli(k)(0) := rancff(k,i);
          Sample(sps,newsli,newsps,newsps_last);
          res.g(i) := newsps;
        end;
      end loop;
    else
      for i in reverse 1..d loop
        declare
          newsli : DoblDobl_Complex_VecVecs.VecVec(sli'range);
          gridai : Stacked_Sample_Grid(k-1,d);
          newstartsps,newstartsps_last : DoblDobl_Sample_List;
        begin
          if i = d then
            gridai := Create(k-1,n,d,sps,sli,rancff);
            startsps := sps;
          else
            for j in sli'range loop
              newsli(j) := new DoblDobl_Complex_Vectors.Vector'(sli(j).all);
            end loop;
            newsli(k)(0) := rancff(k,d-i);
            Sample(startsps,newsli,newstartsps,newstartsps_last);
            DoblDobl_Sampling_Machine.Change_Slices(newsli);
            gridai := Create(k-1,n,d,newstartsps,newsli,rancff);
            startsps := newstartsps;
          end if;
          res.a(i) := new Stacked_Sample_Grid'(gridai);
        end;
      end loop;
      -- res.pts(0) := res.hyp(k)(1..n)*Sample_Point(Head_Of(sps)).v;
      res.pts(0) := -res.hyp(k)(0);
      for i in 1..d loop
        res.pts(i) := -rancff(k,i);
      end loop;
      DoblDobl_Sampling_Machine.Change_Slices(sli);
      declare
        newsli : DoblDobl_Complex_VecVecs.VecVec(sli'range);
      begin
        for j in sli'range loop
          newsli(j) := new DoblDobl_Complex_Vectors.Vector'(sli(j).all);
        end loop;
        newsli(k)(0) := rancff(k,d);
        Sample_on_Slices(Head_Of(sps),newsli,res.spt);
      end;
    end if;
    return res;
  end Create;

  function Create_Full ( k,n,d : integer32; sps : DoblDobl_Sample_List;
                         sli : VecVec; rancff : Matrix ) 
                       return Stacked_Sample_Grid is

  -- DESCRIPTION :
  --   Recursive version of the full creator; k is the index to the
  --   varying slice.

  -- NOTE :
  --   Unlike the Create above, the order in the recursion is straight,
  --   not in reverse.

    res : Stacked_Sample_Grid(sli'last-k+1,d);
    len : natural32;
    startsps : DoblDobl_Sample_List;

  begin
    for i in k..sli'last loop
      res.hyp(i-k+1) := sli(i);
    end loop;
    res.n := natural32(n);
    if k = sli'last then
      len := Length_Of(sps);
      res.g := new Array_of_DoblDobl_Sample_Lists(0..integer32(len));
      res.g(0) := sps;
      for i in 1..integer32(len) loop
        declare
          newsli : DoblDobl_Complex_VecVecs.VecVec(sli'range);
          newsps,newsps_last : DoblDobl_Sample_List;
        begin
          for j in sli'range loop
            newsli(j) := new DoblDobl_Complex_Vectors.Vector'(sli(j).all);
          end loop;
          newsli(k)(0) := rancff(k,i);
          Sample(sps,newsli,newsps,newsps_last);
          res.g(i) := newsps;
        end;
      end loop;
    else
      for i in 0..d loop
        declare
          newsli : DoblDobl_Complex_VecVecs.VecVec(sli'range);
          gridai : Stacked_Sample_Grid(sli'last-k,d);
          newstartsps,newstartsps_last : DoblDobl_Sample_List;
        begin
          if i = 0 then
            gridai := Create_Full(k+1,n,d,sps,sli,rancff);
            startsps := sps;
          else
            for j in sli'range loop
              newsli(j) := new DoblDobl_Complex_Vectors.Vector'(sli(j).all);
            end loop;
            newsli(k)(0) := rancff(k,i);
            Sample(startsps,newsli,newstartsps,newstartsps_last);
            DoblDobl_Sampling_Machine.Change_Slices(newsli);
            gridai := Create_Full(k+1,n,d,newstartsps,newsli,rancff);
            startsps := newstartsps;
          end if;
          res.a(i) := new Stacked_Sample_Grid'(gridai);
        end;
      end loop;
    end if;
    res.pts(0) := -sli(k)(0);
    for i in 1..d loop
      res.pts(i) := -rancff(k,i);
    end loop;
    return res;
  end Create_Full;

  function Create ( file : file_type; sps : DoblDobl_Sample_List )
                  return Stacked_Sample_Grid is

    d : constant integer32 := integer32(Length_Of(sps));
    n : constant integer32 := Number_of_Variables(Head_Of(sps));
    k : constant integer32 := Number_of_Slices(Head_Of(sps));
    rancff : constant Matrix(1..k,1..d)
           := Random_Matrix(natural32(k),natural32(d));
    sli : constant VecVec := Hyperplane_Sections(Head_Of(sps));

  begin
    put_line(file,"The matrix of random constant coefficients : ");
    put(file,rancff,3);
    return Create(k,n,d,sps,sli,rancff);
  end Create;

  function Create_Full ( file : file_type; sps : DoblDobl_Sample_List )
                       return Stacked_Sample_Grid is

    d : constant integer32 := integer32(Length_Of(sps));
    n : constant integer32 := Number_of_Variables(Head_Of(sps));
    k : constant integer32 := Number_of_Slices(Head_Of(sps));
    rancff : constant Matrix(1..k,1..d)
           := Random_Matrix(natural32(k),natural32(d));
    sli : constant VecVec := Hyperplane_Sections(Head_Of(sps));

  begin
    put_line(file,"The matrix of random constant coefficients : ");
    put(file,rancff,3);
    return Create_Full(1,n,d,sps,sli,rancff);
  end Create_Full;

-- SELECTOR :

  function Grid_Size ( n,d : natural32 ) return natural32 is

    sum : natural32;

  begin
    if n = 2 then
      return (d+1)*d + 1;
    else
      sum := 1;
      for i in 1..d loop
        sum := sum + Grid_Size(n-1,d);
      end loop;
      return sum;
    end if;
  end Grid_Size;

  function Full_Grid_Size ( n,d : natural32 ) return natural32 is

    prod : natural32 := d;

  begin
    for i in 1..n-1 loop
      prod := prod*(d+1);
    end loop;
    return prod;
  end Full_Grid_Size;

  function Rotate ( rot : VecVec; x : Vector ) return Vector is

    res : Vector(rot'range);

  begin
    for i in res'range loop
      res(i) := rot(i)(x'range)*x;
    end loop;
    return res;
  end Rotate;

-- DIAGNOSTICS :

  procedure Write_Errors
              ( file : in file_type; grid : in Stacked_Sample_Grid ) is
  begin
    put(file,"Errors in grid at degree ");
    put(file,grid.d,1); put(file," and dimension "); 
    put(file,grid.k,1); put_line(file," :");
    if grid.k = 1 then
      put(file,Errors(grid.g.all));
    else
      for i in reverse 1..grid.d loop
        Write_Errors(file,grid.a(i).all);
      end loop;
      if grid.a(0) = null
       then put_line(file,"Error at last sample : ");
            put(file,Sample_Point(grid.spt).err,3); new_line(file);
       else Write_Errors(file,grid.a(0).all);
      end if;
    end if;
  end Write_Errors;

  function Maximal_Error ( grid : Stacked_Sample_Grid )
                         return double_double is

    res,err : double_double;

  begin
    if grid.k = 1 then
      res := Maximal_Error(grid.g.all);
    else
      res := Maximal_Error(grid.a(1).all);
      for i in 2..grid.d loop
        err := Maximal_Error(grid.a(i).all);
        if err > res
         then res := err;
        end if;
      end loop;
      if grid.a(0) = null
       then err := Sample_Point(grid.spt).err;
       else err := Maximal_Error(grid.a(0).all);
      end if;
      if err > res
       then res := err;
      end if;
    end if;
    return res;
  end Maximal_Error;

  function Minimal_Distance ( grid : Stacked_Sample_Grid )
                            return double_double is

    min,dist : double_double;

  begin
    if grid.k = 1 then
      min := Minimal_Distance(grid.g.all);
    else
      min := Minimal_Distance(grid.a(1).all);
      for i in 2..grid.d loop
        dist := Minimal_Distance(grid.a(i).all);
        if dist < min
         then min := dist;
        end if;
      end loop;
      if grid.a(0) /= null then
        dist := Minimal_Distance(grid.a(0).all);
        if dist < min
         then min := dist;
        end if;
      end if;
    end if;
    return min;
  end Minimal_Distance;

  procedure Write_Value
               ( file : in file_type; grid_hyp : in VecVec;
                 spt : in DoblDobl_Sample ) is

  -- DESCRIPTION :
  --   Writes the value of the sample point at the normals in grid_hyp.
    
    eva : Complex_Number;
    pt : constant Vector := Sample_Point(spt).v;

  begin
    for k in grid_hyp'range loop
      eva := grid_hyp(k)(pt'range)*pt;
      put(file,eva); new_line(file);
    end loop;
  end Write_Value;

  procedure Write_Grid_Values
              ( file : in file_type; hyp : in VecVec;
                grid : in Stacked_Sample_Grid ) is

    tmp : DoblDobl_Sample_List;
    len : natural32;

  begin
    put(file,"Values at grid points at degree ");
    put(file,grid.d,1); put(file," and dimension ");
    put(file,grid.k,1); put_line(file," :");
    if grid.k = 1 then
      len := Length_Of(grid.g(grid.g'first));
      for i in grid.g'range loop
        put(file,"At sample list "); put(file,i,1); put_line(file," :");
        tmp := grid.g(i);
        for j in 1..len loop
          put(file,"Values at sample ");
          put(file,j,1); put_line(file," :");
          Write_Value(file,hyp,Head_Of(tmp));
          tmp := Tail_Of(tmp);
        end loop;
      end loop;
    else
      for i in reverse 1..grid.d loop
        Write_Grid_Values(file,hyp,grid.a(i).all);
      end loop;
      if grid.a(0) = null then
        put_line(file,"Value at last sample :");
        Write_Value(file,hyp,grid.spt);
      else
        Write_Grid_Values(file,hyp,grid.a(0).all);
      end if;
    end if;
  end Write_Grid_Values;

  procedure Write_Full_Grid_Values
              ( file : in file_type; hyp : in VecVec;
                grid : in Stacked_Sample_Grid ) is

    tmp : DoblDobl_Sample_List;
    len : natural32;

  begin
    put(file,"Values at grid points at degree ");
    put(file,grid.d,1); put(file," and dimension ");
    put(file,grid.k,1); put_line(file," :");
    if grid.k = 1 then
      len := Length_Of(grid.g(grid.g'first));
      for i in grid.g'range loop
        put(file,"At sample list "); put(file,i,1); put_line(file," :");
        tmp := grid.g(i);
        for j in 1..len loop
          put(file,"Values at sample ");
          put(file,j,1); put_line(file," :");
          Write_Value(file,hyp,Head_Of(tmp));
          tmp := Tail_Of(tmp);
        end loop;
      end loop;
    else
      for i in 0..grid.d loop
        Write_Full_Grid_Values(file,hyp,grid.a(i).all);
      end loop;
    end if;
  end Write_Full_Grid_Values;

  procedure Write_Grid_Values
              ( file : in file_type; grid : in Stacked_Sample_Grid ) is
  begin
    Write_Grid_Values(file,grid.hyp,grid);
  end Write_Grid_Values;

  procedure Write_Full_Grid_Values
              ( file : in file_type; grid : in Stacked_Sample_Grid ) is
  begin
    Write_Full_Grid_Values(file,grid.hyp,grid);
  end Write_Full_Grid_Values;

-- DESTRUCTORS :

  procedure Clear ( l : in out Link_to_Array_of_DoblDobl_Sample_Lists ) is

    procedure free is
      new unchecked_deallocation(Array_of_DoblDobl_Sample_Lists,
                                 Link_to_Array_of_DoblDobl_Sample_Lists);
  begin
    if l /= null
     then Deep_Clear(l.all);
          free(l);
    end if;
  end Clear;

  procedure Clear ( s : in out Link_to_Stacked_Sample_Grid ) is

    procedure free is 
      new unchecked_deallocation(Stacked_Sample_Grid,
                                 Link_to_Stacked_Sample_Grid);

  begin
    if s /= null
     then free(s);
    end if;
  end Clear;

  procedure Clear ( s : in out Array_of_Stacked_Sample_Grids ) is
  begin
    for i in s'range loop
      Clear(s(i));
    end loop;
  end Clear;

  procedure Clear ( s : in out Stacked_Sample_Grid ) is
  begin
    case s.n is
      when 2 => Clear(s.g);
      when others => Clear(s.a);
    end case;
  end Clear;

end DoblDobl_Stacked_Sample_Grids;
