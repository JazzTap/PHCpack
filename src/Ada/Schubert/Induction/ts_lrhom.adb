with text_io;                            use text_io;
with Communications_with_User;           use Communications_with_User;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Natural_Numbers_io;        use Standard_Natural_Numbers_io;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Integer_Numbers_io;        use Standard_Integer_Numbers_io;
with Multprec_Natural_Numbers;           use Multprec_Natural_Numbers;
with Multprec_Natural_Numbers_io;        use Multprec_Natural_Numbers_io;
with Standard_Natural_Vectors;           use Standard_Natural_Vectors;
with Standard_Natural_Vectors_io;        use Standard_Natural_Vectors_io;
with Brackets;                           use Brackets;
with Bracket_Monomials;                  use Bracket_Monomials;
with Bracket_Monomials_io;               use Bracket_Monomials_io;
with Checker_Boards_io;                  use Checker_Boards_io;
with Checker_Moves;                      use Checker_Moves;
with Checker_Posets,Checker_Posets_io;   use Checker_Posets,Checker_Posets_io;
with Intersection_Posets;
with Intersection_Posets_io;             use Intersection_Posets_io;

procedure ts_lrhom is

-- DESCRIPTION :
--   Interactive development of the application of Littlewood-Richardson
--   homotopies to solve general Schubert problems.

  procedure Read_Brackets ( bm : out Bracket_Monomial ) is

  -- DECRIPTION :
  --   Prompts the user for a bracket monomial.

  begin
    new_line;
    put_line("A product of brackets is for example ");
    put_line("  [2 4 6]*[2 4 6]*[2 4 6]; or [2 4 6]^3;");
    put_line("Give a product of brackets, terminate by a semicolon ;");
    get(bm);
    put("Your product : "); put(bm); new_line;
  end Read_Brackets;

  function Process_Conditions
             ( n,k,m : integer32; conds : Array_of_Brackets )
             return Intersection_Posets.Intersection_Poset is

  -- DESCRIPTION :
  --   Process the m conditions stored in conds on k-planes in n-space.
  --   Returns the intersection poset.

    use Intersection_Posets;
    res : Intersection_Poset(m-1);
    p : constant Vector(1..n) := Identity_Permutation(natural32(n));
    rows,cols : Vector(1..k);
    ps : Poset;
    ans : character;
    silent : boolean;

  begin
    new_line;
    put("Intermediate output during formal root count ? (y/n) "); 
    Ask_Yes_or_No(ans);
    silent := (ans = 'n');
   -- put_line("Reading the first two intersection conditions...");
    rows := Standard_Natural_Vectors.Vector(conds(1).all);
    cols := Standard_Natural_Vectors.Vector(conds(2).all);
   -- Read_Permutation(rows); Read_Permutation(cols);
    if not Happy_Checkers(p,rows,cols) then
      put_line("Your conditions form an unhappy configuration.");
    else
      ps := Create(n,rows,cols);
      res := Create(m-1,ps);
      for k in 3..m loop
       -- put("Reading intersection condition "); put(k,1); put_line("...");
       -- Read_Permutation(cols);
        cols := Standard_Natural_Vectors.Vector(conds(k).all);
        Intersect(res,cols,silent);
      end loop;
    end if;
    return res;
  end Process_Conditions;

  procedure Walk_from_Root_to_Leaves
              ( n,k : in integer32; bm : in Bracket_Monomial ) is

  -- DESCRIPTION :
  --   Prompts the user for m intersection conditions on k-planes in n-space,
  --   and writes the expansion to resolve the conditions from the top down,
  --   walking the intersection poset from the root to the leaves.

  -- ON ENTRY :
  --   n        ambient space
  --   k        dimension of the solution planes;
  --   bm       product of k-brackets, with conditions on the k-planes.

    use Intersection_Posets;

    cnd : constant Array_of_Brackets := Create(bm);
    nbc : constant integer32 := cnd'last;
    ips : Intersection_Poset(nbc-1) := Process_Conditions(n,k,nbc,cnd);
    tmp : Poset_List;
    lpn : Link_to_Poset_Node;

    procedure Write_Parent ( node : in Link_to_Poset_Node ) is

    -- DESCRIPITION :
    --   Writes the root node of the parent given on input in node
    --   and also writes the leaf nodes of the parent.

    begin
      Checker_Posets_io.Write_Nodes_in_Poset(node.ps,node.ps.black'first);
      Checker_Posets_io.Write_Nodes_in_Poset(node.ps,node.ps.black'last);
    end Write_Parent;
    procedure Write_Parents is
      new Intersection_Posets.Enumerate_Parents(Write_Parent);

  begin
    put_line("Resolving the intersection conditions :");
    Write_Expansion(ips);
    for i in 1..ips.m loop
      put("The nodes at level "); put(i,1); put_line(" :");
      tmp := ips.nodes(i);
      for j in 1..Length_Of(ips.nodes(i)) loop
        lpn := Head_Of(tmp);
        put("-> poset node "); put(j,1); put_line(", root and leaves :");
       -- Checker_Posets_io.Write(lpn.ps);
        Checker_Posets_io.Write_Nodes_in_Poset(lpn.ps,lpn.ps.black'first);
        Checker_Posets_io.Write_Nodes_in_Poset(lpn.ps,lpn.ps.black'last);
        if i > 1 then
          put_line("-> its parents are listed by their root and leaves :");
          Write_Parents(ips.nodes(i-1),lpn.all);
        end if;
        tmp := Tail_Of(tmp);
      end loop;
    end loop;
  end Walk_from_Root_to_Leaves;

  procedure Initialize_Leaves_to_One
              ( pl : in out Intersection_Posets.Poset_List ) is

  -- DESCRIPTION :
  --   Initializes the root count at the leaves in the posets to one.

    tmp : Intersection_Posets.Poset_List := pl;
    lpn : Intersection_Posets.Link_to_Poset_Node;
    cps : Checker_Posets.Poset;
    lnd : Checker_Posets.Link_to_Node;

    use Intersection_Posets;

  begin
    while not Is_Null(tmp) loop
      lpn := Head_Of(tmp);
      cps := lpn.ps;
      for i in cps.white'first..(cps.white'last-1) loop
        lnd := cps.white(i);
        while lnd /= null loop
          Clear(lnd.coeff);
          lnd.coeff := Create(natural32(0));
          lnd := lnd.next_sibling;
        end loop;
      end loop;
      Clear(cps.white(cps.white'last).coeff);
      cps.white(cps.white'last).coeff := Create(natural32(1));
      tmp := Tail_Of(tmp);
    end loop;
  end Initialize_Leaves_to_One;

  procedure Initialize_Nodes_to_Zero
              ( pl : in out Intersection_Posets.Poset_List ) is

  -- DESCRIPTION :
  --   Initializes the root count at the internal nodes in the posets
  --   to zero.

    tmp : Intersection_Posets.Poset_List := pl;
    lpn : Intersection_Posets.Link_to_Poset_Node;
    cps : Checker_Posets.Poset;
    lnd : Checker_Posets.Link_to_Node;

    use Intersection_Posets;

  begin
    while not Is_Null(tmp) loop
      lpn := Head_Of(tmp);
      cps := lpn.ps;
      for i in cps.white'range loop
        lnd := cps.white(i);
        while lnd /= null loop
          Clear(lnd.coeff);
          lnd.coeff := Create(natural32(0));
          lnd := lnd.next_sibling;     
        end loop;
      end loop;
      tmp := Tail_Of(tmp);
    end loop;
  end Initialize_Nodes_to_Zero;

  procedure Connect_Checker_Posets_to_Count
              ( pl : in Intersection_Posets.Poset_List;
                nd : in Intersection_Posets.Poset_Node ) is

  -- DESCRIPTION :
  --   Connects the root counts at the root of the child poset with
  --   those leaves of the parent poset for which the conditions match.
  --   The main purpose of the connection is to count the roots
  --   bottom up, from the leaves to the root.

  -- ON ENTRY :
  --   pl       list of checker posets at some level of the parent nodes
  --            to the node nd in the intersection poset;
  --   nd       poset of the child.

    use Intersection_Posets;

    procedure Connect_Parent ( node : in Link_to_Poset_Node ) is

    -- DESCRIPTION :
    --   Connects the leaf of the parent given on input in node.

      child : constant Checker_Posets.Poset := nd.ps;
      childnode : constant Link_to_Node := child.white(child.white'first);
      childconds : constant Standard_Natural_Vectors.Vector
                 := childnode.rows;     -- root
      gamenode : Link_to_Node := node.ps.white(node.ps.white'last);
      parentconds : constant Standard_Natural_Vectors.Vector
                  := node.ps.white(node.ps.white'last).cols; -- leaf

    begin
     -- Checker_Posets_io.Write_Nodes_in_Poset(node.ps,node.ps.black'first);
      put_line("** Before assigning coefficients at parent :");
      Checker_Posets_io.Write_Nodes_in_Poset(node.ps,node.ps.black'last);
      put("  conditions at child  : "); put(childconds); new_line;
      put("  conditions at parent : ");
      loop
        put(gamenode.cols); 
        if Standard_Natural_Vectors.Equal(gamenode.cols,childconds)
         then Add(gamenode.coeff,childnode.coeff);
        end if;
        exit when (gamenode.next_sibling = null);
        put(" |");
        gamenode := gamenode.next_sibling;
      end loop;
      new_line;
      put_line("** After assigning coefficients at parent :");
      Checker_Posets_io.Write_Nodes_in_Poset(node.ps,node.ps.black'last);
    end Connect_Parent;
    procedure Connect_Parents is
      new Intersection_Posets.Enumerate_Parents(Connect_Parent);

  begin
    Connect_Parents(pl,nd);
  end Connect_Checker_Posets_to_Count;

  procedure Connect_Checker_Posets_to_Track
              ( pl : in Intersection_Posets.Poset_List;
                nd : in Intersection_Posets.Poset_Node ) is

  -- DESCRIPTION :
  --   Connects the root counts at the root of the child poset with
  --   those leaves of the parent poset for which the conditions match.
  --   The main purpose of the connection is to stub the homotopies
  --   and show the progress of tracking of the paths.

  -- ON ENTRY :
  --   pl       list of checker posets at some level of the parent nodes
  --            to the node nd in the intersection poset;
  --   nd       poset of the child.

    use Intersection_Posets;

    procedure Connect_Parent ( node : in Link_to_Poset_Node ) is

    -- DESCRIPTION :
    --   Connects the leaf of the parent given on input in node.

      child : constant Checker_Posets.Poset := nd.ps;
      childnode : constant Link_to_Node := child.white(child.white'first);
      childconds : constant Standard_Natural_Vectors.Vector
                 := childnode.rows;     -- root
      gamenode : Link_to_Node := node.ps.white(node.ps.white'last);
      parentconds : constant Standard_Natural_Vectors.Vector
                  := node.ps.white(node.ps.white'last).cols; -- leaf

    begin
     -- put_line("** Before assigning coefficients at parent :");
     -- Checker_Posets_io.Write_Nodes_in_Poset(node.ps,node.ps.black'last);
      loop
        if Standard_Natural_Vectors.Equal(gamenode.cols,childconds) then
          Add(gamenode.coeff,childnode.coeff);
          put("*** number of paths from child to the parent : ");
          put(childnode.coeff); put_line(" ***");
        end if;
        exit when (gamenode.next_sibling = null);
        gamenode := gamenode.next_sibling;
      end loop;
      new_line;
      put_line("** After assigning coefficients at parent :");
      Checker_Posets_io.Write_Nodes_in_Poset(node.ps,node.ps.black'last);
    end Connect_Parent;
    procedure Connect_Parents is
      new Intersection_Posets.Enumerate_Parents(Connect_Parent);

  begin
    Connect_Parents(pl,nd);
  end Connect_Checker_Posets_to_Track;

  procedure Walk_from_Leaves_to_Root
              ( n,k : in integer32; bm : in Bracket_Monomial ) is

  -- DESCRIPTION :
  --   Prompts the user for m intersection conditions on k-planes in n-space,
  --   and writes the evolution of the root count from the leaves to the root.

  -- ON ENTRY :
  --   n        ambient space
  --   k        dimension of the solution planes;
  --   bm       product of k-brackets, with conditions on the k-planes.

    use Intersection_Posets;

    cnd : constant Array_of_Brackets := Create(bm);
    nbc : constant integer32 := cnd'last;
    ips : Intersection_Poset(nbc-1) := Process_Conditions(n,k,nbc,cnd);
    tmp : Poset_List;
    lpn : Link_to_Poset_Node;
    roco : Natural_Number;

  begin
   -- put_line("Resolving the intersection conditions :");
   -- Write_Expansion(ips);
    roco := Final_Sum(ips);
    put("The formal root count : "); put(roco); new_line;
    Initialize_Leaves_to_One(ips.nodes(ips.m));
    for i in 1..ips.m-1 loop
      Initialize_Nodes_to_Zero(ips.nodes(i));
    end loop;
    for i in reverse 1..ips.m loop
      new_line;
      put("The nodes at level "); put(i,1); put_line(" :");
      tmp := ips.nodes(i);
      for j in 1..Length_Of(ips.nodes(i)) loop
        lpn := Head_Of(tmp);
       -- put_line("poset before adding from leaves to root : ");
       -- Checker_Posets_io.Write(lpn.ps);
        Checker_Posets.Add_from_Leaves_to_Root(lpn.ps);
        put_line("poset after adding from leaves to root : ");
        Checker_Posets_io.Write(lpn.ps);
        put("-> poset node "); put(j,1); put_line(", root and leaves :");
        Checker_Posets_io.Write_Nodes_in_Poset(lpn.ps,lpn.ps.black'first);
        Checker_Posets_io.Write_Nodes_in_Poset(lpn.ps,lpn.ps.black'last);
        if i > 1 then
         -- put_line("-> its parents are listed by their root :");
          put_line("-> its parents are listed by their leaf :");
          Connect_Checker_Posets_to_Count(ips.nodes(i-1),lpn.all);
        end if;
        tmp := Tail_Of(tmp);
      end loop;
    end loop;
    put(" Top down root count : "); put(roco); new_line;
    lpn := Head_Of(ips.nodes(1));
    put("Bottom up root count : ");
    put(lpn.ps.white(lpn.ps.white'first).coeff); new_line;
  end Walk_from_Leaves_to_Root;

  procedure Stubbing_Littlewood_Richardson
              ( n,k : in integer32; bm : in Bracket_Monomial ) is

  -- DESCRIPTION :
  --   This procedure shows the progress of the application of Littlewood-
  --   Richardson homotopies to solve general Schubert problems.
  --   Prompts the user for m intersection conditions on k-planes in n-space,
  --   and writes the evolution of the root count from the leaves to the root.

  -- ON ENTRY :
  --   n        ambient space
  --   k        dimension of the solution planes;
  --   bm       product of k-brackets, with conditions on the k-planes.

    use Intersection_Posets;

    cnd : constant Array_of_Brackets := Create(bm);
    nbc : constant integer32 := cnd'last;
    ips : Intersection_Poset(nbc-1) := Process_Conditions(n,k,nbc,cnd);
    tmp : Poset_List;
    lpn : Link_to_Poset_Node;
    roco : Natural_Number;

  begin
    roco := Final_Sum(ips);
    put("The formal root count : "); put(roco); new_line;
    Initialize_Leaves_to_One(ips.nodes(ips.m));
    for i in 1..ips.m-1 loop
      Initialize_Nodes_to_Zero(ips.nodes(i));
    end loop;
    for i in reverse 1..ips.m loop
      new_line;
      put("Solving at level "); put(i,1); put_line(" :");
      tmp := ips.nodes(i);
      for j in 1..Length_Of(ips.nodes(i)) loop
        lpn := Head_Of(tmp);
        Checker_Posets.Add_from_Leaves_to_Root(lpn.ps);
        put("-> poset node "); put(j,1); put_line(", root and leaves :");
        Checker_Posets_io.Write_Nodes_in_Poset(lpn.ps,lpn.ps.black'first);
        Checker_Posets_io.Write_Nodes_in_Poset(lpn.ps,lpn.ps.black'last);
        put("*** number of paths tracking in checker game : ");
        put(lpn.ps.white(lpn.ps.white'first).coeff); put_line(" ***");
        if i > 1 then
          put_line("-> solving at the leaves of its parents :");
          Connect_Checker_Posets_to_Track(ips.nodes(i-1),lpn.all);
        end if;
        tmp := Tail_Of(tmp);
      end loop;
    end loop;
    put(" Top down root count : "); put(roco); new_line;
    lpn := Head_Of(ips.nodes(1));
    put("Bottom up root count : ");
    put(lpn.ps.white(lpn.ps.white'first).coeff); new_line;
  end Stubbing_Littlewood_Richardson;

  procedure Main is

  -- DESCRIPTION :
  --   Provides the user with a list of test procedures
  --   and prompts to make a choice.

    ans : character;
    n,k : integer32 := 0;
    bm : Bracket_Monomial;

  begin
    new_line;
    put_line("MENU to solve Schubert problems with LR homotopies : ");
    put_line("  0. walk through intersection poset from root to leaves;");
    put_line("  1. walk through intersection poset from leaves to root;");
    put_line("  2. stubbing the run of Littlewood-Richardson homotopies.");
    put("Type 0, 1, or 2 to select ");
    Ask_Alternative(ans,"012");
    new_line;
    put("Give the ambient dimension : "); get(n);
    put("Give the dimension of the planes : "); get(k);
    Read_Brackets(bm);
    case ans is
      when '0' => Walk_from_Root_to_Leaves(n,k,bm);
      when '1' => Walk_from_Leaves_to_Root(n,k,bm);
      when '2' => Stubbing_Littlewood_Richardson(n,k,bm);
      when others => null;
    end case;
  end Main;

begin
  Main;
end ts_lrhom;
