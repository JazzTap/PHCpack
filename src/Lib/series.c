/* The file series.c contains the definitions of the functions with
 * prototypes documented in series.h. */

#include <stdio.h>
#include "series.h"

int standard_Newton_series ( int idx, int nbr, int verbose )
{
   int fail = 0;
   int idxnbr[2];
   double *c;

   /* printf("idx = %d, nbr = %d, verbose = %d\n",idx,nbr,verbose); */

   idxnbr[0] = idx;
   idxnbr[1] = nbr;

   fail = _ada_use_c2phc(691,idxnbr,&verbose,c);

   return fail;
}

int dobldobl_Newton_series ( int idx, int nbr, int verbose )
{
   int fail = 0;
   int idxnbr[2];
   double *c;

   idxnbr[0] = idx;
   idxnbr[1] = nbr;
   fail = _ada_use_c2phc(692,idxnbr,&verbose,c);

   return fail;
}

int quaddobl_Newton_series ( int idx, int nbr, int verbose )
{
   int fail = 0;
   int idxnbr[2];
   double *c;

   idxnbr[0] = idx;
   idxnbr[1] = nbr;
   fail = _ada_use_c2phc(693,idxnbr,&verbose,c);

   return fail;
}
