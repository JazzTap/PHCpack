with Standard_Floating_Numbers;          use Standard_Floating_Numbers;

package body Standard_AlgoDiffEval_Trackers is

  procedure Standard_ADE_Newton ( verbose : in integer32 ) is

    return_of_call : integer32;

    function newton ( v : integer32 ) return integer32;
    pragma import(C, newton, "adenewton_d");

  begin
    return_of_call := newton(verbose);
  end Standard_ADE_Newton;

  procedure Standard_ADE_Track_One
              ( verbose : in integer32; gamma : in Complex_Number ) is

    return_of_call : integer32;
    regam : constant double_float := REAL_PART(gamma);
    imgam : constant double_float := IMAG_PART(gamma);

    function one_track ( v : integer32; r,i : double_float ) return integer32;
    pragma import(C, one_track, "adeonepath_d");

  begin
    return_of_call := one_track(verbose,regam,imgam);
  end Standard_ADE_Track_One;

  procedure Standard_ADE_Track_Many
              ( verbose : in integer32; gamma : in Complex_Number ) is

    return_of_call : integer32;
    regam : constant double_float := REAL_PART(gamma);
    imgam : constant double_float := IMAG_PART(gamma);

    function many_track ( v : integer32; r,i : double_float ) return integer32;
    pragma import(C, many_track, "ademanypaths_d");

  begin
    return_of_call := many_track(verbose,regam,imgam);
  end Standard_ADE_Track_Many;

end Standard_AlgoDiffEval_Trackers; 
