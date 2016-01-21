with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with C_Integer_Arrays;                  use C_Integer_Arrays;
with C_Double_Arrays;                   use C_Double_Arrays;

function use_numbtrop ( job : integer32;
                        a : C_intarrs.Pointer;
                        b : C_intarrs.Pointer;
                        c : C_dblarrs.Pointer ) return integer32;

-- DESCRIPTION :
--   Gateway to the container to manage numerically computed tropisms.

-- ON ENTRY :
--   job   =   1 : initialize for tropisms in standard double precision,
--                 on input in a[0] are the number of tropisms, and
--                 in a[1] the length of the tropisms, in b are then
--                 the winding numbers, as many as the value of a[0],
--                 in c are all the floating-point coefficients,
--                 as many as (1+a[0])*a[1], for the coordinates of the
--                 tropisms and the errors on the numerical tropisms; 
--             2 : initialize for tropisms in double double precision,
--                 on input in a[0] are the number of tropisms, and
--                 in a[1] the length of the tropisms, in b are then
--                 the winding numbers, as many as the value of a[0],
--                 in c are all the floating-point coefficients,
--                 as many as 2*(1+a[0])*a[1], for the coordinates of the
--                 tropisms and the errors on the numerical tropisms; 
--             3 : initialize for tropisms in quad double precision,
--                 on input in a[0] are the number of tropisms, and
--                 in a[1] the length of the tropisms, in b are then
--                 the winding numbers, as many as the value of a[0],
--                 in c are all the floating-point coefficients,
--                 as many as 4*(1+a[0])*a[1], for the coordinates of the
--                 tropisms and the errors on the numerical tropisms; 
--             4 : store a tropism in standard double precision,
--                 on input in a[0] is the length of the tropism, and
--                 in a[1] the index of the tropism, 
--                 in b is the winding number,
--                 in c are all the floating-point coefficients,
--                 as many as a[0] + 1, with the coordinates of the 
--                 tropisms and the error;
--             5 : store a tropism in double double precision,
--                 on input in a[0] is the length of the tropism, and
--                 in a[1] the index of the tropism, 
--                 in b is the winding number,
--                 in c are all the floating-point coefficients,
--                 as many as 2*a[0] + 2, with the coordinates of the 
--                 tropisms and the error;
--             6 : store a tropism in quad double precision,
--                 on input in a[0] is the length of the tropism, and
--                 in a[1] the index of the tropism, 
--                 in b is the winding number,
--                 in c are all the floating-point coefficients,
--                 as many as 4*a[0] + 4, with the coordinates of the 
--                 tropisms and the error;
--             7 : retrieve all tropisms in standard double precision;
--             8 : retrieve all tropisms in double double precision;
--             9 : retrieve all tropisms in quad double precision;
--            10 : the number of tropisms in standard double precision
--                 is returned in a;
--            11 : the number of tropisms in double double precision
--                 is returned in a;
--            12 : number of tropisms in quad double precision
--                 is returned in a;
--            13 : retrieve one tropism in standard double precision;
--            14 : retrieve one tropism in double double precision;
--            15 : retrieve one tropism in quad double precision;
--            16 : clear all tropisms in standard double precision;
--            17 : clear all tropisms in double double precision;
--            18 : clear all tropisms in quad double precision.

-- ON RETURN :
--   0 if the operation was successful, otherwise something went wrong,
--   or job not in the right range.
