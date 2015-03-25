/* the file giftwrappers.c contains the definitions of the functions 
 * with prototypes documented in giftwrappers.h */

#include <stdlib.h>
#include <stdio.h>

extern void adainit ( void );
extern int _ada_use_c2phc ( int task, int *a, int *b, double *c );
extern void adafinal ( void );

int convex_hull_2d ( int nc_pts, char *pts, int *nc_hull, char *hull )
{
   int fail,i;
   int points[10*nc_pts];
   double *c;

   for(i=0; i<nc_pts; i++) points[i] = (int) pts[i];

   fail = _ada_use_c2phc(580,&nc_pts,points,c);

   *nc_hull = nc_pts;

   for(i=0; i<nc_pts; i++) hull[i] = (char) points[i];
  
   return fail;
}

int convex_hull ( int nc_pts, char *pts )
{
   int fail,i;
   int points[nc_pts];
   double *c;

   for(i=0; i<nc_pts; i++) points[i] = (int) pts[i];

   fail = _ada_use_c2phc(581,&nc_pts,points,c);

   return fail;
}

int number_of_facets ( int dim, int *nbr )
{
   int fail;
   double *c;

   fail = _ada_use_c2phc(582,&dim,nbr,c);

   return fail;
}

int retrieve_facet ( int dim, int fcn, int *nc_rep, char *fctrep )
{
   int fail,k;
   int a = dim;
   int b[100*dim];
   double *c;

   b[0] = fcn;

   fail = _ada_use_c2phc(583,&a,b,c);

   *nc_rep = a;
   for(k=0; k<a; k++) fctrep[k] = (char) b[k];
   fctrep[a] = '\0';

   return fail;
}

int clear_3d_facets ( void )
{
   int fail,*a,*b;
   double *c;

   fail = _ada_use_c2phc(584,a,b,c);

   return fail;
}

int clear_4d_facets ( void )
{
   int fail,*a,*b;
   double *c;

   fail = _ada_use_c2phc(585,a,b,c);

   return fail;
}

int support_size ( void ) 
{
   int fail,nbr;
   int *b;
   double *c;

   fail = _ada_use_c2phc(586,&nbr,b,c);

   return nbr;
}

int support_string ( int size, char *supp )
{
   int fail,i;
   int support[size];
   double *c;

   fail = _ada_use_c2phc(587,&size,support,c);
   for(i=0; i<size; i++) supp[i] = (char) support[i];
   supp[size] = '\0';

   return fail;
}

int clear_support_string ( void )
{
   int fail,*a,*b;
   double *c;

   fail = _ada_use_c2phc(588,a,b,c);

   return fail;
}
