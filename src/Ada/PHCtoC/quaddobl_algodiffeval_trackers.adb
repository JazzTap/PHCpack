package body QuadDobl_AlgoDiffEval_Trackers is

  procedure QuadDobl_ADE_Newton ( verbose : integer32 ) is

    return_of_call : integer32;

    function newton ( v : integer32 ) return integer32;
    pragma import(C, newton, "adenewton_qd");

  begin
    return_of_call := newton(verbose);
  end QuadDobl_ADE_Newton;

  procedure QuadDobl_ADE_Track_One ( verbose : integer32 ) is

    return_of_call : integer32;

    function one_track ( v : integer32 ) return integer32;
    pragma import(C, one_track, "adeonepath_qd");

  begin
    return_of_call := one_track(verbose);
  end QuadDobl_ADE_Track_One;

  procedure QuadDobl_ADE_Track_Many ( verbose : integer32 ) is

    return_of_call : integer32;

    function many_track ( v : integer32 ) return integer32;
    pragma import(C, many_track, "ademanypaths_qd");

  begin
    return_of_call := many_track(verbose);
  end QuadDobl_ADE_Track_Many;

end QuadDobl_AlgoDiffEval_Trackers; 
