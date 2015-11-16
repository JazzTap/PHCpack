with text_io;                            use text_io;
with Standard_Natural_Numbers;           use Standard_Natural_Numbers;
with Standard_Integer_Numbers;           use Standard_Integer_Numbers;
with Standard_Complex_Polynomials;
with Standard_Complex_Poly_Systems;

package Square_and_Embed_Systems is

-- DESCRIPTION :
--   This package contains procedures to embed a polynomial system
--   adding slack variables and/or extra random hyperplanes, needed
--   to set up homotopies to compute generic points on all components.

  function Restrict ( t : Standard_Complex_Polynomials.Term;
                      m,k : integer32 )
                    return Standard_Complex_Polynomials.Term;

  -- DESCRIPTION :
  --   Only the first m variables and the last k variables remain.

  function Restrict ( p : Standard_Complex_Polynomials.Poly;
                      m,k : integer32 )
                    return Standard_Complex_Polynomials.Poly;

  -- DESCRIPTION :
  --   Restricts the polynomial to an m-dimensional subspace, spanned
  --   by the first m variables, leaving the k last slack variables intact.

  procedure Interactive_Embed_Square_System 
              ( file : in file_type;
                p : in Standard_Complex_Poly_Systems.Poly_Sys;
                embsys : out Standard_Complex_Poly_Systems.Link_to_Poly_Sys;
                topdim : out natural32 );

  -- DESCRIPTION :
  --   Prompts the user to enter the expected top dimension, 
  --   which is returned in topdim,
  --   creates the embedded system and writes it on file.
  --   This procedure is called by Interactive_Square_and_Embed,
  --   in case the given polynomial system is square.

  procedure Embed_Square_System 
              ( p : in Standard_Complex_Poly_Systems.Poly_Sys;
                topdim : in natural32;
                embsys : out Standard_Complex_Poly_Systems.Link_to_Poly_Sys );

  -- DESCRIPTION :
  --   Noninteractive version of the previous procedure.

  -- ON ENTRY :
  --   p        system with as many equations as variables;
  --   topdim   the topdimension.
 
  -- ON RETURN :
  --   embsys   system with as many extra linear equations as topdim
  --            and with the symbol table enlarged with as many
  --            symbols for the slack variables as the value of topdim.

  function Full_Embed_Nonsquare_System
              ( p : Standard_Complex_Poly_Systems.Poly_Sys;
                nq,nv,k : natural32 )
              return Standard_Complex_Poly_Systems.Poly_Sys;

  -- DESCRIPTION :
  --   Constructs an embedding of a nonsquare system,
  --   using slices not restricted to any particular subspace.

  -- ON ENTRY :
  --   p        nonsquare polynomial system;
  --   nq       number of equations;
  --   nv       number of variables;
  --   k        number of slices to be added to the system.

  -- ON RETURN :
  --   Square polynomial system with k additional linear equations.

  procedure Interactive_Embed_Nonsquare_System
              ( file : in file_type;
                p : in Standard_Complex_Poly_Systems.Poly_Sys;
                nbequ,nbunk : in natural32;
                embsys : out Standard_Complex_Poly_Systems.Link_to_Poly_Sys;
                topdim : out natural32 );

  -- DESCRIPTION :
  --   Constructs an embedding of a nonsquare system with number of
  --   equations in nbequ and number of unknowns in nbunk.
  --   The user is prompted for the expected top dimension.
  --   Slack variables are added for overdetermined systems.
  --   Dummy variables are added for underdetermined systems.
  --   The embedded system is written to file.

  procedure Embed_Nonsquare_System
              ( p : in Standard_Complex_Poly_Systems.Poly_Sys;
                nbequ,nbunk,topdim : in natural32;
                embsys : out Standard_Complex_Poly_Systems.Link_to_Poly_Sys );

  -- DESCRIPTION :
  --   Noninteractive version of the above procedure.
  --   To a system p with a number of equations equal to nbequ
  --   and a number of variables equal to nbunk, sufficiently many slack
  --   variables and random linear equations will be added corresponding
  --   to the top dimension in topdim.

  procedure Interactive_Square_and_Embed
              ( file : in file_type;
                p : in Standard_Complex_Poly_Systems.Poly_Sys;
                ep : out Standard_Complex_Poly_Systems.Link_to_Poly_Sys;
                k : out natural32 );

  -- DESCRIPTION :
  --   Distinguishes between systems that are square and not square.
  --   The embedding of nonsquare systems involves the addition of
  --   extra slack variables (in case the system is overdetermined)
  --   or the use of dummy variables (for underdetermined systems).
  --   Therefore the embedding for square systems is treated separately
  --   from the embedding of the nonsquare systems.

  -- ON ENTRY :
  --   file     for output;
  --   p        system in any number of equations and variables.
 
  -- ON RETURN :
  --   ep       embedded system with extra slack variables;
  --   k        the dimension as entered by the user.

  procedure Square_and_Embed
              ( p : in Standard_Complex_Poly_Systems.Poly_Sys;
                topdim : in natural32;
                ep : out Standard_Complex_Poly_Systems.Link_to_Poly_Sys );

  -- DESCRIPTION : 
  --   Noninteractive version of the procedure above,
  --   works for systems in any number of equations and variables
  --   and takes care of the symbol table adjustment.
  --   Makes the system p square and adds an embedding corresponding to
  --   the top dimension topdim.

  function Remove_Last_Variables
             ( p : Standard_Complex_Poly_Systems.Poly_Sys; n : natural32 )
             return Standard_Complex_Poly_Systems.Poly_Sys;

  -- DESCRIPTION :
  --   Removes the last n variables of the system p.

  -- REQUIRED : n >= Number_of_Unknowns(p(i)), for i in p'range.

  procedure Remove_Last_Variables
              ( p : in out Standard_Complex_Poly_Systems.Poly_Sys;
                n : in natural32 );

  -- DESCRIPTION :
  --   Removes the last n variables of the system p.

  -- REQUIRED : n >= Number_of_Unknowns(p(i)), for i in p'range.

  function Remove_Embedding
             ( p : Standard_Complex_Poly_Systems.Poly_Sys;
               dim,ns : natural32 )
             return Standard_Complex_Poly_Systems.Poly_Sys;

  -- DESCRIPTION :
  --   Removes the embedding and extra slack variables from the system p.

  -- ON ENTRY :
  --   p       an embedded polynomial system;
  --   dim     dimension of the solution set used in the embedding;
  --   ns      number of extra slack variables which need to be removed.

  -- REQUIRED :
  --   All slack variables are located as last variables in p.

end Square_and_Embed_Systems;
