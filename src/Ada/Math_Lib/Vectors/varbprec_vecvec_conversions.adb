with Standard_Floating_Numbers;          use Standard_Floating_Numbers;
with Double_Double_Numbers;              use Double_Double_Numbers;
with Quad_Double_Numbers;                use Quad_Double_Numbers;
with Multprec_Floating_Numbers;          use Multprec_Floating_Numbers;
with Standard_Complex_Numbers;
with DoblDobl_Complex_Numbers;
with DoblDobl_Complex_Numbers_cv;        use DoblDobl_Complex_Numbers_cv;
with QuadDobl_Complex_Numbers;
with QuadDobl_Complex_Numbers_cv;        use QuadDobl_Complex_Numbers_cv;
with Multprec_Complex_Numbers;
with Multprec_Complex_Number_Tools;      use Multprec_Complex_Number_Tools;
with Standard_Floating_Vectors;
with Standard_Complex_Vectors;
with Double_Double_Vectors;
with DoblDobl_Complex_Vectors;
with Quad_Double_Vectors;
with QuadDobl_Complex_Vectors;
with Multprec_Floating_Vectors;
with Multprec_Complex_Vectors;
with Multprec_DoblDobl_Convertors;       use Multprec_DoblDobl_Convertors;
with Multprec_QuadDobl_Convertors;       use Multprec_QuadDobl_Convertors;

package body Varbprec_VecVec_Conversions is

  function d2dd ( mtx : Standard_Floating_VecVecs.VecVec )
                return Double_Double_VecVecs.VecVec is

    res : Double_Double_VecVecs.VecVec(mtx'range);
    stv : Standard_Floating_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      stv := mtx(i);
      declare
        ddv : Double_Double_Vectors.Vector(stv'range); 
      begin
        for j in stv'range loop
          ddv(j) := create(stv(j));
        end loop;
        res(i) := new Double_Double_Vectors.Vector'(ddv);
      end;
    end loop;
    return res;
  end d2dd;

  function d2dd ( mtx : Standard_Complex_VecVecs.VecVec )
                return DoblDobl_Complex_VecVecs.VecVec is

    res : DoblDobl_Complex_VecVecs.VecVec(mtx'range);
    stv : Standard_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      stv := mtx(i);
      declare
        ddv : DoblDobl_Complex_Vectors.Vector(stv'range);
      begin
        for j in stv'range loop
          declare
            strp : constant double_float
                 := Standard_Complex_Numbers.REAL_PART(stv(j));
            ddrp : constant double_double := create(strp);
            stip : constant double_float
                 := Standard_Complex_Numbers.IMAG_PART(stv(j));
            ddip : constant double_double := create(stip);
          begin
            ddv(j) := DoblDobl_Complex_Numbers.create(ddrp,ddip);
          end;
        end loop;
        res(i) := new DoblDobl_Complex_Vectors.Vector'(ddv);
      end;
    end loop;
    return res;
  end d2dd;

  function d2qd ( mtx : Standard_Floating_VecVecs.VecVec )
                return Quad_Double_VecVecs.VecVec is

    res : Quad_Double_VecVecs.VecVec(mtx'range);
    stv : Standard_Floating_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      stv := mtx(i);
      declare
        qdv : Quad_Double_Vectors.Vector(stv'range);
      begin
        for j in stv'range loop
          qdv(j) := create(stv(j));
        end loop;
        res(i) := new Quad_Double_Vectors.Vector'(qdv);
      end;
    end loop;
    return res;
  end d2qd;

  function d2qd ( mtx : Standard_Complex_VecVecs.VecVec )
                return QuadDobl_Complex_VecVecs.VecVec is

    res : QuadDobl_Complex_VecVecs.VecVec(mtx'range);
    stv : Standard_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      stv := mtx(i);
      declare
        qdv : QuadDobl_Complex_Vectors.Vector(stv'range);
      begin
        for j in stv'range loop
          declare
            strp : constant double_float
                 := Standard_Complex_Numbers.REAL_PART(stv(j));
            ddrp : constant double_double := create(strp);
            qdrp : constant quad_double := create(ddrp);
            stip : constant double_float
                 := Standard_Complex_Numbers.IMAG_PART(stv(j));
            ddip : constant double_double := create(stip);
            qdip : constant quad_double := create(ddip);
          begin
            qdv(j) := QuadDobl_Complex_Numbers.create(qdrp,qdip);
          end;
        end loop;
        res(i) := new QuadDobl_Complex_Vectors.Vector'(qdv);
      end;
    end loop;
    return res;
  end d2qd;

  function d2mp ( mtx : Standard_Floating_VecVecs.VecVec )
                return Multprec_Floating_VecVecs.VecVec is

    res : Multprec_Floating_VecVecs.VecVec(mtx'range);
    stv : Standard_Floating_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      stv := mtx(i);
      declare
        mpv : Multprec_Floating_Vectors.Vector(stv'range);
      begin
        for j in stv'range loop
          mpv(j) := create(stv(j));
        end loop;
        res(i) := new Multprec_Floating_Vectors.Vector'(mpv);
      end;
    end loop;
    return res;
  end d2mp;

  function d2mp ( mtx : Standard_Complex_VecVecs.VecVec )
                return Multprec_Complex_VecVecs.VecVec is

    res : Multprec_Complex_VecVecs.VecVec(mtx'range);
    stv : Standard_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      stv := mtx(i);
      declare
        mpv : Multprec_Complex_Vectors.Vector(stv'range);
      begin
        for j in stv'range loop
          declare
            strp : constant double_float
                 := Standard_Complex_Numbers.REAL_PART(stv(j));
            mprp : Floating_Number := Create(strp);
            stip : constant double_float
                 := Standard_Complex_Numbers.IMAG_PART(stv(j));
            mpip : Floating_Number := create(stip);
          begin
            mpv(j) := Multprec_Complex_Numbers.create(mprp,mpip);
            Multprec_Floating_Numbers.Clear(mprp);
            Multprec_Floating_Numbers.Clear(mpip);
          end;
        end loop;
        res(i) := new Multprec_Complex_Vectors.Vector'(mpv);
      end;
    end loop;
    return res;
  end d2mp;

  function dd2d ( mtx : Double_Double_VecVecs.VecVec )
                return Standard_Floating_VecVecs.VecVec is

    res : Standard_Floating_VecVecs.VecVec(mtx'range);
    ddv : Double_Double_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      ddv := mtx(i);
      declare
        stv : Standard_Floating_Vectors.Vector(ddv'range);
      begin
        for j in ddv'range loop
          stv(j) := to_double(ddv(j));
        end loop;
        res(i) := new Standard_Floating_Vectors.Vector'(stv);
      end;
    end loop;
    return res;
  end dd2d;

  function dd2d ( mtx : DoblDobl_Complex_VecVecs.VecVec )
                return Standard_Complex_VecVecs.VecVec is

    res : Standard_Complex_VecVecs.VecVec(mtx'range);
    ddv : DoblDobl_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      ddv := mtx(i);
      declare
        stv : Standard_Complex_Vectors.Vector(ddv'range);
      begin
        for j in stv'range loop
          declare
            ddrp : constant double_double
                 := DoblDobl_Complex_Numbers.REAL_PART(ddv(j));
            strp : constant double_float := to_double(ddrp);
            ddip : constant double_double
                 := DoblDobl_Complex_Numbers.IMAG_PART(ddv(j));
            stip : constant double_float := to_double(ddip);
          begin
            stv(j) := Standard_Complex_Numbers.create(strp,stip);
          end;
        end loop;
        res(i) := new Standard_Complex_Vectors.Vector'(stv);
      end;
    end loop;
    return res;
  end dd2d;

  function dd2qd ( mtx : Double_Double_VecVecs.VecVec )
                 return Quad_Double_VecVecs.VecVec is

    res : Quad_Double_VecVecs.VecVec(mtx'range);
    ddv : Double_Double_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      ddv := mtx(i);
      declare
        qdv : Quad_Double_Vectors.Vector(ddv'range);
      begin
        for j in ddv'range loop
          qdv(j) := create(ddv(j));
        end loop;
        res(i) := new Quad_Double_Vectors.Vector'(qdv);
      end;
    end loop;
    return res;
  end dd2qd;

  function dd2qd ( mtx : DoblDobl_Complex_VecVecs.VecVec )
                 return QuadDobl_Complex_VecVecs.VecVec is

    res : QuadDobl_Complex_VecVecs.VecVec(mtx'range);
    ddv : DoblDobl_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      ddv := mtx(i);
      declare
        qdv : QuadDobl_Complex_Vectors.Vector(ddv'range);
      begin
        for j in ddv'range loop
          declare
            ddrp : constant double_double
                 := DoblDobl_Complex_Numbers.REAL_PART(ddv(j));
            qdrp : constant quad_double := create(ddrp);
            ddip : constant double_double
                 := DoblDobl_Complex_Numbers.IMAG_PART(ddv(j));
            qdip : constant quad_double := create(ddip);
          begin
            qdv(j) := QuadDobl_Complex_Numbers.create(qdrp,qdip);
          end;
        end loop;
        res(i) := new QuadDobl_Complex_Vectors.Vector'(qdv);
      end;
    end loop;
    return res;
  end dd2qd;

  function dd2mp ( mtx : Double_Double_VecVecs.VecVec )
                 return Multprec_Floating_VecVecs.VecVec is

    res : Multprec_Floating_VecVecs.VecVec(mtx'range);
    ddv : Double_Double_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      ddv := mtx(i);
      declare
        mpv : Multprec_Floating_Vectors.Vector(ddv'range);
      begin
        for j in ddv'range loop
          mpv(j) := to_floating_number(ddv(j));
        end loop;
        res(i) := new Multprec_Floating_Vectors.Vector'(mpv);
      end;
    end loop;
    return res;
  end dd2mp;

  function dd2mp ( mtx : DoblDobl_Complex_VecVecs.VecVec )
                 return Multprec_Complex_VecVecs.VecVec is

    res : Multprec_Complex_VecVecs.VecVec(mtx'range);
    ddv : DoblDobl_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      ddv := mtx(i);
      declare
        mpv : Multprec_Complex_Vectors.Vector(ddv'range);
      begin
        for j in ddv'range loop
          mpv(j) := DoblDobl_Complex_to_MultPrec(ddv(j));
        end loop;
        res(i) := new Multprec_Complex_Vectors.Vector'(mpv);
      end;
    end loop;
    return res;
  end dd2mp;

  function qd2d ( mtx : Quad_Double_VecVecs.VecVec )
                return Standard_Floating_VecVecs.VecVec is

    res : Standard_Floating_VecVecs.VecVec(mtx'range);
    qdv : Quad_Double_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      qdv := mtx(i);
      declare
        stv : Standard_Floating_Vectors.Vector(qdv'range);
      begin
        for j in qdv'range loop
          stv(j) := to_double(qdv(j));
        end loop;
        res(i) := new Standard_Floating_Vectors.Vector'(stv);
      end;
    end loop;
    return res;
  end qd2d;

  function qd2d ( mtx : QuadDobl_Complex_VecVecs.VecVec )
                return Standard_Complex_VecVecs.VecVec is

    res : Standard_Complex_VecVecs.VecVec(mtx'range);
    qdv : QuadDobl_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      qdv := mtx(i);
      declare
        stv : Standard_Complex_Vectors.Vector(qdv'range);
      begin
        for j in qdv'range loop
          declare
            qdrp : constant quad_double
                 := QuadDobl_Complex_Numbers.REAL_PART(qdv(j));
            strp : constant double_float := to_double(qdrp);
            qdip : constant quad_double
                 := QuadDobl_Complex_Numbers.IMAG_PART(qdv(j));
            stip : constant double_float := to_double(qdip);
          begin
            stv(j) := Standard_Complex_Numbers.create(strp,stip);
          end;
        end loop;
        res(i) := new Standard_Complex_Vectors.Vector'(stv);
      end;
    end loop;
    return res;
  end qd2d;

  function qd2dd ( mtx : Quad_Double_VecVecs.VecVec )
                 return Double_Double_VecVecs.VecVec is

    res : Double_Double_VecVecs.VecVec(mtx'range);
    qdv : Quad_Double_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      qdv := mtx(i);
      declare
        ddv : Double_DOuble_Vectors.Vector(qdv'range);
      begin
        for j in qdv'range loop
          ddv(j) := to_double_double(qdv(j));
        end loop;
        res(i) := new Double_Double_Vectors.Vector'(ddv);
      end;
    end loop;
    return res;
  end qd2dd;

  function qd2dd ( mtx : QuadDobl_Complex_VecVecs.VecVec )
                 return DoblDobl_Complex_VecVecs.VecVec is

    res : DoblDobl_Complex_VecVecs.VecVec(mtx'range);
    qdv : QuadDobl_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      qdv := mtx(i);
      declare
        ddv : DoblDobl_Complex_Vectors.Vector(qdv'range);
      begin
        for j in qdv'range loop
          declare
            qdrp : constant quad_double
                 := QuadDobl_Complex_Numbers.REAL_PART(qdv(j));
            ddrp : constant double_double := to_double_double(qdrp);
            qdip : constant quad_double
                 := QuadDobl_Complex_Numbers.IMAG_PART(qdv(j));
            ddip : constant double_double := to_double_double(qdip);
          begin
            ddv(j) := DoblDobl_Complex_Numbers.create(ddrp,ddip);
          end;
        end loop;
        res(i) := new DoblDobl_Complex_Vectors.Vector'(ddv);
      end;
    end loop;
    return res;
  end qd2dd;

  function qd2mp ( mtx : Quad_Double_VecVecs.VecVec )
                 return Multprec_Floating_VecVecs.VecVec is

    res : Multprec_Floating_VecVecs.VecVec(mtx'range);
    qdv : Quad_Double_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      qdv := mtx(i);
      declare
        mpv : Multprec_Floating_Vectors.Vector(qdv'range);
      begin
        for j in qdv'range loop
          mpv(j) := to_floating_number(qdv(j));
        end loop;
        res(i) := new Multprec_Floating_Vectors.Vector'(mpv);
      end;
    end loop;
    return res;
  end qd2mp;

  function qd2mp ( mtx : QuadDobl_Complex_VecVecs.VecVec )
                 return Multprec_Complex_VecVecs.VecVec is

    res : Multprec_Complex_VecVecs.VecVec(mtx'range);
    qdv : QuadDobl_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      qdv := mtx(i);
      declare
        mpv : Multprec_Complex_Vectors.Vector(qdv'range);
      begin
        for j in qdv'range loop
          mpv(j) := QuadDobl_Complex_to_MultPrec(qdv(j));
        end loop;
        res(i) := new Multprec_Complex_Vectors.Vector'(mpv);
      end;
    end loop;
    return res;
  end qd2mp;

  procedure Set_Size ( mtx : in out Multprec_Floating_VecVecs.VecVec;
                       size : in natural32 ) is

    v : Multprec_Floating_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      v := mtx(i);
      for j in v'range loop
        Multprec_Floating_Numbers.Set_Size(v(j),size);
      end loop;
    end loop;
  end Set_Size;

  procedure Set_Size ( mtx : in out Multprec_Complex_VecVecs.VecVec;
                       size : in natural32 ) is

    v : Multprec_Complex_Vectors.Link_to_Vector;

  begin
    for i in mtx'range loop
      v := mtx(i);
      for j in v'range loop
        Set_Size(v(j),size);
      end loop;
    end loop;
  end Set_Size;

end Varbprec_VecVec_Conversions;
