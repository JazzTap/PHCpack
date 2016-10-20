-- an interface to the Littlewood-Richardson homotopies in PHCpack.
-- Note that this package needs version 1.6.1 of PHCpack.m2.

newPackage(
  "LRhomotopies",
  Version => "0.6", 
  Date => "19 October 2016",
  Authors => {
    {Name => "Jan Verschelde", 
     Email => "jan@math.uic.edu",
     HomePage => "http://www.math.uic.edu/~jan"}},
  Headline => "Interface to LR-homotopies in PHCpack"
)

export{"LRrule", "LRtriple", "parseTriplet", "wrapTriplet", "LRcheater"}

debug needsPackage "PHCpack"

-- the helper functions section starts here

stripLeadingSpaces := (s) -> (
-- 
-- DESCRIPTION :
--   Returns the string s with leading spaces stripped.
--
  if #s == 0 then
    return s
  else
    if first(s) == " " then
    (
       s1 := substring(s,1,#s);
       return stripLeadingSpaces(s1)
    )
    else
       return s
);

stripTrailingSpaces := (s) -> (
-- 
-- DESCRIPTION :
--   Returns the string s with trailing spaces stripped.
--
  if #s == 0 then
    return s
  else
    if last(s) == " " then
    (
       s1 := substring(s,0,#s-1);
       return stripTrailingSpaces(s1)
    )
    else
       return s
);

replaceConsecutiveSpaces := (s) -> (
-- 
-- DESCRIPTION :
--   Replaces sequences of consecutive spaces by exactly one.
--
  doubles := select("  ", s);
  if #doubles == 0 then
    return s
  else
  (
    s1 := replace("  ", " ", s);
    return replaceConsecutiveSpaces(s1)
  )
);

makeRealRow := (line) -> (
--
-- DESCRIPTION :
--   Given in line is a line of double numbers in scientific format,
--   with the big E notation.  Returns a list of real numbers.
--
  data := replace("E", "e", line);       -- replace the "E" by "e"
  data = replace("e\\+00", "", data);    -- M2 complaints at 2.3e+00
  data = replace("e\\+", "e", data);     -- M2 complaints at 2.3e+01
  data = stripLeadingSpaces(data);       -- remove leading spaces
  data = stripTrailingSpaces(data);      -- remove trailing spaces
  data = replaceConsecutiveSpaces(data); -- exactly one space as separator
  nbrs := separate(" ", data);           -- separate the list
  return apply(nbrs, x-> value(x));     -- list of doubles
);

makeComplexRow := (line) -> (
--
-- DESCRIPTION :
--   Given in line is a line of double numbers in scientific format,
--   with the big E notation.  Returns a list of complex numbers,
--   using the consecutive doubles as real and imaginary parts.
--
  data := replace("E", "e", line);       -- replace the "E" by "e"
  data = replace("e\\+00", "", data);    -- M2 complaints at 2.3e+00
  data = replace("e\\+", "e", data);     -- M2 complaints at 2.3e+01
  data = stripLeadingSpaces(data);       -- remove leading spaces
  data = stripTrailingSpaces(data);      -- remove trailing spaces
  data = replaceConsecutiveSpaces(data); -- exactly one space as separator
  nbrs := separate(" ", data);           -- separate the list
  vals := apply(nbrs, x-> value(x));     -- list of doubles
  twos := pack(2, vals);                 -- make list of pairs
  return apply(twos, x-> x#0 + ii*x#1)   -- turn each pair into complex number
);

makeRealMatrix := (dim, data) -> (
--
-- DESCRIPTION :
--   Returns a matrix with as many rows as the value of dim,
--   taking the values on the lines in data.
--
  result := {};
  for k from 0 to dim-1 do
    if k < #data then
      result = append(result, makeRealRow(data#k));
  return matrix(result)
);

makeComplexMatrix := (dim, data) -> (
--
-- DESCRIPTION :
--   Returns a matrix with as many rows as the value of dim,
--   taking the values on the lines in data.
--
  result := {};
  for k from 0 to dim-1 do
    if k < #data then
      result = append(result, makeComplexRow(data#k));
  return matrix(result)
);

extractMovedFlag := (dim, data) -> (
--
-- DESCRIPTTION :
--   Given a list of lines in data.
--   Searches for the line which contains the banner "MOVED"
--   and then returns the matrix of as many rows as the value
--   of dim, stores in the lines of data following the banner.
--
  for k from 0 to #data-1 do
  (
    moved := select("MOVED", data#k);
    if #moved > 0 then
    (
      subdata := {}; row := 0;
      for i from 1 to dim do
      (
        row = k + i;
        subdata = append(subdata, data#row);
      );
      return makeRealMatrix(dim, subdata)
    )
  );
  return {}
);

extractSolutionPlane := (dim, data) -> (
--
-- DESCRIPTTION :
--   Given a list of lines in data.
--   Searches for the line which contains the banner "SOLUTION"
--   and then returns the matrix of as many rows as the value
--   of dim, stores in the lines of data following the banner.
--
  for k from 0 to #data-1 do
  (
    solplane := select("SOLUTION", data#k);
    if #solplane > 0 then
    (
      subdata := {};
      row := 0;
      for i from 1 to dim do
      (
        row = k + i;
        subdata = append(subdata, data#row);
      );
      return makeComplexMatrix(dim, subdata)
    )
  );
  return {}
);

extractSubList := (startIdx, nbr, data) -> (
--
-- DESCRIPTION :
--   Given a list of lists in data, returns a sublist of data,
--   with as many sublists as the value of nbr,
--   starting at the startIdx+1.
--
  result := {};
  row := startIdx;
  for i from 1 to nbr do
  (
    row = startIdx + i;
    if row < #data then
      result = append(result, data#row);
  );
  return result
);

extractSolutionPlanes := (dim, data) -> (
--
-- DESCRIPTTION :
--   Given a list of lines in data.
--   Searches for the line which contains the banner "SOLUTION"
--   and then returns the matrix of as many rows as the value
--   of dim, stores in the lines of data following the banner.
--
  result := {};
  for k from 0 to #data-1 do
  (
    solplane := select("SOLUTION", data#k);
    if #solplane > 0 then
    (
      subdata := extractSubList(k, dim, data);
      result = append(result, makeComplexMatrix(dim, subdata));
      current := k+dim+1;
      while current+dim < #data-1 do
      (   
        subdata = extractSubList(current, dim, data);
        result = append(result, makeComplexMatrix(dim, subdata));
        current = current + dim + 1;
      )
    )
  );
  return result
);

extractFixedFlags := (dim, nbr, data) -> (
--
-- DESCRIPTION :
--   Extracts the fixed flags from the list of lines in data.
--   Every flag has dim rows and their number equals nbr.
--
  result := {};
  firstflag := makeComplexMatrix(dim, data);
  result = append(result, firstflag);
  current := dim; -- skip first dim rows and blank row
  subdata := {};
  for k from 1 to nbr-1 do
  (
    subdata = extractSubList(current, dim, data);
    result = append(result, makeComplexMatrix(dim, subdata));
    current = current + dim + 1;
  );
  return result
);

extractDimensions := (data) -> (
--
-- DESCRIPTION :
--   On input in data are the lines of the output string of the first
--   string returned by LRtriple. 
--   On return is the dimension of the flags and the number of flags.
--   This is a sanity check on the soundness on the output file.
--
  dim := 0; -- dimension of the flags
  while #data#dim > 0 do dim = dim + 1; -- read till the first blank line

  current := dim; -- at a blank line
  nbr := 1;       -- found one fixed flag
  while true do   -- count the blank lines till at moved flag
  (
    current = current + 1;
    moved := select("MOVED", data#current);
    if #moved > 0 then break;
    if #data#current == 0 then nbr = nbr + 1;
  );
  return (dim, nbr)
);

-- end of the helper functions section
 
LRruleIn = method();
LRruleIn(ZZ,ZZ,Matrix) := (a,n,m) -> (
-- 
-- DESCRIPTION :
--   Prepares the input for phc -e option #4 to resolve a Schubert
--   intersection condition, for example: [2 4 6]^3.
--
-- REQUIRED : phc must be in the execution path.
--
-- ON ENTRY :
--   a         should be 4 for root count, 5 for solutions;
--   n         ambient dimension;
--   m         matrix with in rows the intersection conditions,
--             the first element of each row is the number of times
--             the intersection bracket must be taken.
-- 
-- ON RETURN :
--   result    a string with input for phc -e, i.e.: if s is place
--             in the file "input" then phc -e < input will work.
--
   versionPHC := versionNumber(, Verbose=>true);
   result := "";
   if #versionPHC#0 > 0 then
   (
      result = concatenate(toString(a),"\n");
      nr := numgens target m;
      nc := numgens source m;
      result = concatenate(result,toString(n),"\n");
      for i from 0 to nr-1 do
      (
         result = concatenate(result,"[ ");
         for j from 1 to nc-1 do
            result = concatenate(result,toString(m_(i,j))," ");
         if m_(i,0) > 1 then
            result = concatenate(result,"]^",toString(m_(i,0)))
         else
            result = concatenate(result,"]");
         if i < nr-1 then result = concatenate(result,"*");
      );
      result = concatenate(result,";");
   );
   return result
);

dataToFile = method()
dataToFile(String,String) := (data,name) -> (
--
-- DESCRIPTION :
--   Writes the all characters in the string data to the
--   file with the given name for the LRrule computation.
--
   file := openOut name;
   file << data << endl;
   close file;
);

lastLine = method()
lastLine(String) := (name) -> (
--
-- DESCRIPTION :
--   Returns a string with the contents of the last line
--   ond file with the given name.
--
   s := get name;
   L := lines(s);
   n := #L-1;
   result := L_n;
   result
);

LRrule = method();
LRrule(ZZ,Matrix) := (n,m) -> (
-- 
-- DESCRIPTION :
--   Returns the intersection condition and its result.
--
-- ON ENTRY :
--   n         ambient dimension;
--   m         matrix with in rows the intersection conditions,
--             the first element of each row is the number of times
--             the intersection bracket must be taken.
-- 
-- ON RETURN :
--   s         a string with an equation, with at the left the
--             intersection condition and at the right the result.
--
   d := LRruleIn(4,n,m);
   -- stdio << "the input data for phc -e : " << endl <<  d;
   PHCinputFile := temporaryFileName() | "PHCinput";
   PHCoutputFile := temporaryFileName() | "PHCoutput";
   stdio << endl << "writing data to file " << PHCinputFile << endl;
   dataToFile(d,PHCinputFile);
   stdio << "running phc -e, writing output to " << PHCoutputFile << endl;
   run("phc -e < " | PHCinputFile | " > " | PHCoutputFile);
   stdio << "opening output file " << PHCoutputFile << endl;
   outcome := lastLine(PHCoutputFile);
   s := substring(4,#d-5,d);
   s = concatenate(s,outcome);
   s
);

ringFromString = method();
ringFromString(String) := (p) -> (
--
-- DESCRIPTION :
--   Given in p a polynomial system in PHCpack format,
--   returns the polynomial ring.
--
   -- stdio << "the input data for phc -o : " << endl <<  p;
   PHCinpFile := temporaryFileName() | "PHCinp";
   PHCoutFile := temporaryFileName() | "PHCout";
   PHCsesFile := temporaryFileName() | "PHCses";
   stdio << endl << "writing data to file " << PHCinpFile << endl;
   dataToFile(p,PHCinpFile);
   stdio << "running phc -o, writing output to " << PHCoutFile << endl;
   run("phc -o " | PHCinpFile | " " | PHCoutFile | " > " | PHCsesFile);
   s := get PHCoutFile;
   -- stdio << "the string of symbols :" << s;
   if s_0 == " " then (
      s = substring(1, s)
   );
   L := separate(" ", s);
   -- stdio << "the list of symbols as strings" << L;
   v := apply(L, x -> value(x));
   -- stdio << "the list of symbols as strings" << v;
   CC_53[v]
);

systemFromString = method();
systemFromString (String, Ring) := (p, R) -> (
--
-- DESCRIPTION :
--   Given in the string p a polynomial system in PHCpack format
--   and a polynomial ring with as symbols the names of the variables
--   used in the string p, the polynomial system in p is returned as
--   a proper polynomial system in Macaulay2.   
--
   PHCinpFile := temporaryFileName() | "PHCipt";
   stdio << endl << "writing data to file " << PHCinpFile << endl;
   dataToFile(p,PHCinpFile);
   use R;
   return systemFromFile(PHCinpFile);
);

SchubertSystemFromFile = method();
SchubertSystemFromFile(String) := (name) -> (
--
-- DESCRIPTION :
--   Given the name of the output file of a run of phc -e with option #5,
--   this method returns a string with the polynomial system solved.
--
-- ON ENTRY :
--   name      name of the output file of a run of phc -e with option #5,
--             must contain the banner "POLYNOMIAL SYSTEM" followed by
--             the polynomial equations solved.
--            
-- ON RETURN :
--   (f,p,s)   a sequence with flag and polynomial system, and solutions,
--   f         random complex coordinates of the fixed flag,
--   p         the solved polynomial equations,
--   s         solutions to the polynomials in string format.
--
   data := get name;
   L := lines(data);
   nf := position(L,i->i=="THE FIXED FLAGS :");
   np := position(L,i->i=="THE POLYNOMIAL SYSTEM :");
   K := take(L,{np,#L-1});
   ns := np + position(K,i->i=="THE SOLUTIONS :");
   f := concatenate(L_(nf+1),"\n");
   for i from nf+2 to np-1 do f = concatenate(f,L_i,"\n");
   p := concatenate(L_(np+1),"\n");
   for i from np+2 to ns-1 do p = concatenate(p,L_i,"\n");
   s := concatenate(L_(ns+1),"\n");
   for i from ns+2 to #L-1 do s = concatenate(s,L_i,"\n");
   result := (f, p, s);
   result
);

LRtriple = method();
LRtriple(ZZ,Matrix) := (n,m) -> (
--
-- DESCRIPTION :
--   Solves one checker game for a triple Schubert intersection.
--
-- ON ENTRY :
--   n         ambient dimension;
--   m         matrix with in rows the intersection conditions,
--             the first element of each row is the number of times
--             the intersection bracket must be taken.
-- 
-- ON RETURN :
--   (f,r,p,s) a sequence with the result of the Schubert problem:
--   r         the polynomial ring for the symbols of the variables
--             representing the solutions in the matrix representations,
--   f         a string representation of a fixed flag,
--   p         the polynomial system solved,
--   s         a string with solutions to the polynomial system.
--
   d := LRruleIn(5,n,m);  -- option 5 of phc -e
   PHCinputFile := temporaryFileName() | "PHCip";
   PHCoutputFile := temporaryFileName() | "PHCout";
   PHCsessionFile := temporaryFileName() | "PHCses";
   PHCsolutions := temporaryFileName() | "PHCsolutions";
   d = concatenate(d,"\n0\n");  -- solve a generic instance for random flags
   d = concatenate(d,"0\n");  -- standard double precision
   d = concatenate(d,"0\n");  -- generate random flags
   d = concatenate(d,PHCoutputFile,"\n");
   d = concatenate(d,"0\n");  -- no intermediate output written to file
   d = concatenate(d,"n\n");  -- use an efficient problem formulation
   d = concatenate(d,"y\n");  -- square the overdetermined homotopies
   d = concatenate(d,"0\n");  -- do not change default continuation parameters
   d = concatenate(d,"0\n");  -- no intermediate output during continuation
   stdio << "the input data for phc -e : " << endl <<  d;
   stdio << endl << "writing data to file " << PHCinputFile << endl;
   dataToFile(d,PHCinputFile);
   stdio << "running phc -e, session output to " << PHCsessionFile << endl;
   stdio << "                writing output to " << PHCoutputFile << endl;
   run("phc -e < " | PHCinputFile | " > " | PHCsessionFile);
   run("phc -z " | PHCoutputFile | " " | PHCsolutions);
   stdio << "opening output file " << PHCsolutions << endl;
  -- stdio << endl << "extracting fixed flags, polynomial system, solutions";
  -- stdio << endl;
   fps := SchubertSystemFromFile(PHCoutputFile);
   result := (fps_0,fps_1,fps_2);
   result
);

parseTriplet = method();
parseTriplet(String,String,String) := (f,p,s) -> (
--
-- DESCRIPTION :
--   Returns the polynomial ring of the variables, the polynomial system,
--   the solutions and the fixed flag as Macaulay objects, when given
--   the string representations of the flag f, the polynomial system p,
--   and the list of solutions in s.
--
   R := ringFromString(p);
   spR := systemFromString(p, R);
   sdata := concatenate("THE SOLUTIONS :\n", s);
   PHCiptsolsFile := temporaryFileName() | "PHCsols";
   PHCoptsolsFile := temporaryFileName() | "PHCsols";
   stdio << "writing solutions to " << PHCiptsolsFile;
   dataToFile(sdata,PHCiptsolsFile);
   stdio << "running phc -z ..." << endl;
   run(PHCexe|" -z " | PHCiptsolsFile | " "| PHCoptsolsFile);
   sols := parseSolutions(PHCoptsolsFile, R);
   linesf := lines f;
   (dim, nbr) := extractDimensions(linesf);
   stdio << "the dimension : " << dim << endl; 
   stdio << "the number of flags : " << nbr << endl; 
   fixedFlags := extractFixedFlags(dim, nbr, linesf);
   movedFlag := extractMovedFlag(dim, linesf);
   solutionPlanes := extractSolutionPlanes(dim, linesf);
   result := (R, spR, sols, fixedFlags, movedFlag, solutionPlanes);
   result
);

wrapTriplet = method();
wrapTriplet(String,String,String) := (f,p,s) -> (
--
-- DESCRIPTION :
--   Wraps the triplet of strings: fixed flag f, polynomial system p,
--   and solutions s into one string suitable for parsing by phc -e.
--
   result := concatenate("THE FIXED FLAGS :\n",f);
   result = concatenate(result,"THE POLYNOMIAL SYSTEM :\n",p);
   result = concatenate(result,"THE SOLUTIONS :\n",s);
   result
);

cheaterInputFile = method();
cheaterInputFile(String) := (data) -> (
--
-- DESCRIPTION :
--   Generates a file name and writes the data in the string to it.
--   Returns the name of this input file.
-- 
-- ON ENTRY :
--   w         the outcome of LRtriple(n,m), wrapped into a string.
--
-- ON RETURN :
--   name      name of the file that contains the data.
--
   name := temporaryFileName() | "PHCcheaterInput";
   stdio << "writing start data to " << name << endl;
   file := openOut name;
   file << data << endl;
   close file;
   name
);

LRcheater = method();
LRcheater(ZZ,Matrix,String) := (n,m,w) -> (
--
-- DESCRIPTION :
--   Runs a cheater's homotopy from a generic instance of a Schubert
--   triple intersection to a real instance.
--
-- ON ENTRY :
--   n         ambient dimension;
--   m         matrix with in rows the intersection conditions,
--             the first element of each row is the number of times
--             the intersection bracket must be taken,
--   w         the outcome of LRtriple(n,m), wrapped into string.
--
-- ON RETURN :
--   t         a real triple Schubert intersection problem.
--   
   PHCinputCheater := cheaterInputFile(w);
   PHCoutputCheater := temporaryFileName() | "PHCoutputCheater";
   PHCinputSession := temporaryFileName() | "PHCinputSession";
   PHCsessionCheater := temporaryFileName() | "PHCsessionCheater";
   -- PHCsolutionsCheater := temporaryFileName() | "PHCsolutionsCheater";
   d := LRruleIn(5,n,m);        -- option 5 of phc -e
   d = concatenate(d,"\n1\n");  -- run Cheater's homotopy
   d = concatenate(d,PHCinputCheater,"\n");
   d = concatenate(d,"y\n");    -- generate real flags
   d = concatenate(d,PHCoutputCheater,"\n");
   -- stdio << "the input data for phc -e : " << endl <<  d;
   stdio << endl << "writing data to file " << PHCinputSession << endl;
   dataToFile(d,PHCinputSession);
   stdio << "running phc -e, session output to " << PHCsessionCheater << endl;
   stdio << "                writing output to " << PHCoutputCheater << endl;
   run("phc -e < " | PHCinputSession | " > " | PHCsessionCheater);
   -- run("phc -z " | PHCoutputCheater | " " | PHCsolutionsCheater);
   -- stdio << "opening output file " << PHCsolutionsCheater << endl;
   -- stdio << endl << "extracting fixed flags, polynomial system, solutions";
   -- stdio << endl;
   fp := SchubertSystemFromFile(PHCoutputCheater);
   -- s := get PHCsolutionsCheater;
   result := (fp_0,fp_1,fp_2);
   result
);

--##########################################################################--
-- DOCUMENTATION
--##########################################################################--

beginDocumentation()

load "./LRhomotopiesDoc.m2";
