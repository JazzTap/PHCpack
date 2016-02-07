/* This file contains the definitions of the prototypes in phcpy2c.h,
   for use in version 3.5 of Python.. */

#include <Python.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "phcpack.h"
#include "unisolvers.h"
#include "giftwrappers.h"
#include "schubert.h"
#include "syscon.h"
#include "solcon.h"
#include "product.h"
#include "lists_and_strings.h"
#include "celcon.h"
#include "scalers.h"
#include "sweep.h"
#include "numbtrop.h"
#include "witset.h"
#include "mapcon.h"
#include "next_track.h"
#include "structmember.h"

extern void adainit ( void );
extern void adafinal ( void );

int g_ada_initialized = 0;
int g_ada_finalized = 0;

void initialize ( void )
{
   if(!g_ada_initialized)
   {
      adainit();
      g_ada_initialized = 1;
      g_ada_finalized = 0;
   }
}

void finalize ( void )
{
   if(!g_ada_finalized)
   {
      adafinal();
      g_ada_finalized = 1;
      g_ada_initialized = 0;
   }
}

/* The wrapping of functions in phcpack.h starts from here. */

static PyObject *py2c_PHCpack_version_string
 ( PyObject *self, PyObject *args )
{
   int fail;
   int size = 40;
   char s[size];

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = version_string(&size,s);
   s[size] = '\0';
              
   return Py_BuildValue("s",s);
}

static PyObject *py2c_set_seed
 ( PyObject *self, PyObject *args )
{
   int fail,seed;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&seed)) return NULL;

   fail = set_seed(seed);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_get_seed
 ( PyObject *self, PyObject *args )
{
   int fail,seed;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;

   fail = get_seed(&seed);
              
   return Py_BuildValue("i",seed);
}

static PyObject *py2c_read_standard_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = read_standard_target_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_standard_target_system_from_file
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *name;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&name)) return NULL;
   fail = read_standard_target_system_from_file(nc,name);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_standard_start_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = read_standard_start_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_standard_start_system_from_file
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *name;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&name)) return NULL;   
   fail = read_standard_start_system_from_file(nc,name);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_dobldobl_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = read_dobldobl_target_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_dobldobl_target_system_from_file
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *name;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&name)) return NULL;
   fail = read_dobldobl_target_system_from_file(nc,name);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_dobldobl_start_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = read_dobldobl_start_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_dobldobl_start_system_from_file
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *name;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&name)) return NULL;   
   fail = read_dobldobl_start_system_from_file(nc,name);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_quaddobl_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = read_quaddobl_target_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_quaddobl_target_system_from_file
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *name;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&name)) return NULL;
   fail = read_quaddobl_target_system_from_file(nc,name);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_quaddobl_start_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = read_quaddobl_start_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_read_quaddobl_start_system_from_file
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *name;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&name)) return NULL;   
   fail = read_quaddobl_start_system_from_file(nc,name);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_define_output_file
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = define_output_file();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_write_standard_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = write_standard_target_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_write_dobldobl_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = write_dobldobl_target_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_write_quaddobl_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = write_quaddobl_target_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_write_standard_start_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = write_standard_start_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_write_dobldobl_start_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = write_dobldobl_start_system();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_write_quaddobl_start_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = write_quaddobl_start_system();
   
   return Py_BuildValue("i",fail);
}

/* The wrapping of copying systems from and to containers starts here. */

static PyObject *py2c_copy_standard_target_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_target_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_target_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_dobldobl_target_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_target_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_quaddobl_target_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_target_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_multprec_target_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_standard_container_to_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_container_to_target_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_container_to_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_dobldobl_container_to_target_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_container_to_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_quaddobl_container_to_target_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_container_to_target_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_multprec_container_to_target_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_start_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_start_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_start_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_dobldobl_start_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_start_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_dobldobl_start_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_start_system_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_multprec_start_system_to_container();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_standard_container_to_start_system 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_container_to_start_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_container_to_start_system 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_dobldobl_container_to_start_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_container_to_start_system 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_quaddobl_container_to_start_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_container_to_start_system 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = copy_multprec_container_to_start_system();
              
   return Py_BuildValue("i",fail);
}

/* creation of homotopy and tracking all solution paths */

static PyObject *py2c_create_standard_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = create_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_create_standard_homotopy_with_gamma
 ( PyObject *self, PyObject *args )
{
   int fail;
   double g_re,g_im;

   initialize();
   if(!PyArg_ParseTuple(args,"dd",&g_re,&g_im)) return NULL;   
   fail = create_homotopy_with_given_gamma(g_re,g_im);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_create_dobldobl_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = create_dobldobl_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_create_dobldobl_homotopy_with_gamma
 ( PyObject *self, PyObject *args )
{
   int fail;
   double g_re,g_im;

   initialize();
   if(!PyArg_ParseTuple(args,"dd",&g_re,&g_im)) return NULL;   
   fail = create_dobldobl_homotopy_with_given_gamma(g_re,g_im);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_create_quaddobl_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = create_quaddobl_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_create_quaddobl_homotopy_with_gamma
 ( PyObject *self, PyObject *args )
{
   int fail;
   double g_re,g_im;

   initialize();
   if(!PyArg_ParseTuple(args,"dd",&g_re,&g_im)) return NULL;   
   fail = create_quaddobl_homotopy_with_given_gamma(g_re,g_im);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_create_multprec_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = create_multprec_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_create_multprec_homotopy_with_gamma
 ( PyObject *self, PyObject *args )
{
   int fail;
   double g_re,g_im;

   initialize();
   if(!PyArg_ParseTuple(args,"dd",&g_re,&g_im)) return NULL;   
   fail = create_multprec_homotopy_with_given_gamma(g_re,g_im);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_standard_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = clear_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_dobldobl_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = clear_dobldobl_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_quaddobl_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = clear_quaddobl_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_multprec_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = clear_multprec_homotopy();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_write_start_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = write_start_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_tune_continuation_parameters
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = tune_continuation_parameters();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_show_continuation_parameters
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = show_continuation_parameters();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_autotune_continuation_parameters
 ( PyObject *self, PyObject *args )
{
   int fail,level,nbdgt;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&level,&nbdgt)) return NULL;   
   fail = autotune_continuation_parameters(level,nbdgt);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_get_value_of_continuation_parameter
 ( PyObject *self, PyObject *args )
{
   int fail,idx;
   double val;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&idx)) return NULL;   
   fail = get_value_of_continuation_parameter(idx,&val);
   
   return Py_BuildValue("d",val);
}

static PyObject *py2c_set_value_of_continuation_parameter
 ( PyObject *self, PyObject *args )
{
   int fail,idx;
   double val;

   initialize();
   if(!PyArg_ParseTuple(args,"id",&idx,&val)) return NULL;   
   fail = set_value_of_continuation_parameter(idx,&val);
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_determine_output_during_continuation
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = determine_output_during_continuation();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solve_by_standard_homotopy_continuation
 ( PyObject *self, PyObject *args )
{
   int fail, nbtasks = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbtasks)) return NULL;   
   fail = solve_by_standard_homotopy_continuation(nbtasks);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solve_by_dobldobl_homotopy_continuation
 ( PyObject *self, PyObject *args )
{
   int fail, nbtasks = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbtasks)) return NULL;   
   fail = solve_by_dobldobl_homotopy_continuation(nbtasks);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solve_by_quaddobl_homotopy_continuation
 ( PyObject *self, PyObject *args )
{
   int fail, nbtasks = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbtasks)) return NULL;   
   fail = solve_by_quaddobl_homotopy_continuation(nbtasks);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solve_by_multprec_homotopy_continuation
 ( PyObject *self, PyObject *args )
{
   int fail,deci;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&deci)) return NULL;   
   fail = solve_by_multprec_homotopy_continuation(deci);

   return Py_BuildValue("i",fail);
}

/* The wrrapping of copying solutions from and to containers starts here. */

static PyObject *py2c_copy_standard_target_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_target_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_target_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_dobldobl_target_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_target_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_quaddobl_target_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_target_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_multprec_target_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_standard_container_to_target_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_container_to_target_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_container_to_target_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_dobldobl_container_to_target_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_container_to_target_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_quaddobl_container_to_target_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_container_to_target_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_multprec_container_to_target_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_start_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_start_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_start_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_dobldobl_start_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_start_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_quaddobl_start_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_start_solutions_to_container
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_multprec_start_solutions_to_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_standard_container_to_start_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_container_to_start_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_dobldobl_container_to_start_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_dobldobl_container_to_start_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_quaddobl_container_to_start_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_quaddobl_container_to_start_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_copy_multprec_container_to_start_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = copy_multprec_container_to_start_solutions();

   return Py_BuildValue("i",fail);
}

/* black box solver, mixed volume calculator, and Newton step */

static PyObject *py2c_solve_system
 ( PyObject *self, PyObject *args )
{
   int fail,rc,nbtasks = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbtasks)) return NULL;
   fail = solve_system(&rc,nbtasks);
   return Py_BuildValue("i",rc);
}

static PyObject *py2c_solve_dobldobl_system
 ( PyObject *self, PyObject *args )
{
   int fail,rc,nbtasks = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbtasks)) return NULL;
   fail = solve_dobldobl_system(&rc,nbtasks);
   return Py_BuildValue("i",rc);
}

static PyObject *py2c_solve_quaddobl_system
 ( PyObject *self, PyObject *args )
{
   int fail,rc,nbtasks = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbtasks)) return NULL;
   fail = solve_quaddobl_system(&rc,nbtasks);
   return Py_BuildValue("i",rc);
}

static PyObject *py2c_solve_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int silent,fail,rc,nbtasks = 0;

   initialize();
   if (!PyArg_ParseTuple(args,"ii",&silent,&nbtasks)) return NULL;
   fail = solve_Laurent_system(&rc,silent,nbtasks);
   return Py_BuildValue("i",rc);
}

static PyObject *py2c_solve_dobldobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int silent,fail,rc,nbtasks = 0;

   initialize();
   if (!PyArg_ParseTuple(args,"ii",&silent,&nbtasks)) return NULL;
   fail = solve_dobldobl_Laurent_system(&rc,silent,nbtasks);
   return Py_BuildValue("i",rc);
}

static PyObject *py2c_solve_quaddobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int silent,fail,rc,nbtasks = 0;

   initialize();
   if (!PyArg_ParseTuple(args,"ii",&silent,&nbtasks)) return NULL;
   fail = solve_quaddobl_Laurent_system(&rc,silent,nbtasks);
   return Py_BuildValue("i",rc);
}

static PyObject *py2c_mixed_volume
 ( PyObject *self, PyObject *args )
{
   int stable,fail,mv,smv;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&stable)) return NULL;
   if(stable == 0)
   {
      fail = mixed_volume(&mv);
      return Py_BuildValue("i",mv);
   }
   else
   {
      fail = stable_mixed_volume(&mv,&smv);
      return Py_BuildValue("(i,i)",mv,smv);
   }
}

static PyObject *py2c_standard_deflate
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = standard_deflate();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_dobldobl_deflate
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = dobldobl_deflate();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_quaddobl_deflate
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = quaddobl_deflate();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_standard_Newton_step
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = standard_Newton_step();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_dobldobl_Newton_step
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = dobldobl_Newton_step();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_quaddobl_Newton_step
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = quaddobl_Newton_step();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_multprec_Newton_step
 ( PyObject *self, PyObject *args )
{
   int fail,decimals;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&decimals)) return NULL;
   fail = multprec_Newton_step(decimals);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_standard_Newton_Laurent_step
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = standard_Newton_Laurent_step();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_dobldobl_Newton_Laurent_step
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = dobldobl_Newton_Laurent_step();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_quaddobl_Newton_Laurent_step
 ( PyObject *self, PyObject *args )
{
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   {
      int fail = quaddobl_Newton_Laurent_step();
      return Py_BuildValue("i",fail);
   }
}

static PyObject *py2c_multprec_Newton_Laurent_step
 ( PyObject *self, PyObject *args )
{
   int fail,decimals;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&decimals)) return NULL;
   fail = multprec_Newton_Laurent_step(decimals);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_varbprec_Newton_Laurent_steps
 ( PyObject *self, PyObject *args )
{
   int fail,dim,wanted,maxitr,maxprc,nbstr;
   char *pols;

   initialize();

   if(!PyArg_ParseTuple(args,"iiiiis",
      &dim,&wanted,&maxitr,&maxprc,&nbstr,&pols)) return NULL;

   fail = varbprec_Newton_Laurent_step(dim,wanted,maxitr,maxprc,nbstr,pols);

   return Py_BuildValue("i",fail);
}

/* The wrapping of the functions in unisolvers.h starts from here */

static PyObject *py2c_usolve_standard
 ( PyObject *self, PyObject *args )
{
   int fail,max,nit;
   double eps;

   initialize();
   if(!PyArg_ParseTuple(args,"id",&max,&eps)) return NULL;
   fail = solve_with_standard_doubles(max,eps,&nit);

   return Py_BuildValue("i",nit);
}

static PyObject *py2c_usolve_dobldobl
 ( PyObject *self, PyObject *args )
{
   int fail,max,nit;
   double eps;

   initialize();
   if(!PyArg_ParseTuple(args,"id",&max,&eps)) return NULL;
   fail = solve_with_double_doubles(max,eps,&nit);

   return Py_BuildValue("i",nit);
}

static PyObject *py2c_usolve_quaddobl
 ( PyObject *self, PyObject *args )
{
   int fail,max,nit;
   double eps;

   initialize();
   if(!PyArg_ParseTuple(args,"id",&max,&eps)) return NULL;
   fail = solve_with_quad_doubles(max,eps,&nit);

   return Py_BuildValue("i",nit);
}

static PyObject *py2c_usolve_multprec
 ( PyObject *self, PyObject *args )
{
   int fail,dcp,max,nit;
   double eps;

   initialize();
   if(!PyArg_ParseTuple(args,"iid",&dcp,&max,&eps)) return NULL;
   fail = solve_with_multiprecision(dcp,max,eps,&nit);

   return Py_BuildValue("i",nit);
}

/* The wrapping of the functions in giftwrappers.h starts from here. */

static PyObject *py2c_giftwrap_planar
 ( PyObject *self, PyObject *args )
{
   int fail,nbc_pts;
   char *pts;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nbc_pts,&pts)) return NULL;

   {
      int nbc_hull;
      char hull[10*nbc_pts];

      fail = convex_hull_2d(nbc_pts,pts,&nbc_hull,hull);
      hull[nbc_hull] = '\0';

      return Py_BuildValue("s",hull);
   }
}

static PyObject *py2c_giftwrap_convex_hull
 ( PyObject *self, PyObject *args )
{
   int fail,nbc_pts;
   char *pts;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nbc_pts,&pts)) return NULL;

   fail = convex_hull(nbc_pts,pts);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_giftwrap_number_of_facets
 ( PyObject *self, PyObject *args )
{
   int fail,dim,number;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;

   fail = number_of_facets(dim,&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_giftwrap_retrieve_facet
 ( PyObject *self, PyObject *args )
{
   int fail,dim,ind,ncp;
   char rep[256];

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&dim,&ind)) return NULL;

   fail = retrieve_facet(dim,ind,&ncp,rep);
   rep[ncp] = '\0';

   return Py_BuildValue("s",rep);
}

static PyObject *py2c_giftwrap_clear_3d_facets
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   

   fail = clear_3d_facets();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_giftwrap_clear_4d_facets
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   

   fail = clear_4d_facets();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_giftwrap_support_size
 ( PyObject *self, PyObject *args )
{
   int nbr;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   nbr = support_size();  

   return Py_BuildValue("i",nbr);
}

static PyObject *py2c_giftwrap_support_string
 ( PyObject *self, PyObject *args )
{
   int nbr,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbr)) return NULL;   
   {
      char support[nbr+1];

      fail = support_string(nbr,support);

      return Py_BuildValue("s",support);
   }
}

static PyObject *py2c_giftwrap_clear_support_string
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = clear_support_string();
   
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_giftwrap_initial_form
 ( PyObject *self, PyObject *args )
{
   int fail,dim,nbc;
   char *normal;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&dim,&nbc,&normal)) return NULL;
   /* printf("the inner normal in wrapper is %s\n", normal); */
   fail = initial_form(dim,nbc,normal);
   
   return Py_BuildValue("i",fail);
}

/* The wrapping of the functions in syscon.h starts from here. */

static PyObject *py2c_syscon_read_standard_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_read_standard_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_read_standard_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_read_standard_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_read_dobldobl_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_read_dobldobl_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_read_dobldobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_read_dobldobl_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_read_quaddobl_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_read_quaddobl_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_read_quaddobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_read_quaddobl_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_read_multprec_system
 ( PyObject *self, PyObject *args )
{
   int fail,deci;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&deci)) return NULL;   
   fail = syscon_read_multprec_system(deci);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_read_multprec_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail,deci;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&deci)) return NULL;   
   fail = syscon_read_multprec_Laurent_system(deci);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_random_system
 ( PyObject *self, PyObject *args )
{
   int fail,n,m,d,c;

   initialize();
   if(!PyArg_ParseTuple(args,"iiii",&n,&m,&d,&c)) return NULL;   
   fail = syscon_random_system(n,m,d,c);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_standard_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_standard_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_standard_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_standard_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_dobldobl_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_dobldobl_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_dobldobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_dobldobl_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_quaddobl_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_quaddobl_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_quaddobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_quaddobl_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_multprec_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_multprec_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_write_multprec_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_multprec_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_standard_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_standard_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_standard_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_standard_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_dobldobl_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_dobldobl_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_dobldobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_dobldobl_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_quaddobl_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_quaddobl_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_quaddobl_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_quaddobl_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_multprec_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_multprec_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_multprec_Laurent_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_multprec_Laurent_system();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_number_of_symbols
 ( PyObject *self, PyObject *args )
{
   int nb,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_number_of_symbols(&nb);
              
   return Py_BuildValue("i",nb);
}

static PyObject *py2c_syscon_write_symbols
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_write_symbols();
   printf("\n");
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_string_of_symbols
 ( PyObject *self, PyObject *args )
{
   int nb;
   int fail = syscon_number_of_symbols(&nb);
   int size = 80*nb;
   char s[size];

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_string_of_symbols(&size,s);
              
   return Py_BuildValue("s",s);
}

static PyObject *py2c_syscon_remove_symbol_name
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = syscon_remove_symbol_name_from_table(nc,s);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_clear_symbol_table
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = syscon_clear_symbol_table();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_number_of_standard_polynomials
 ( PyObject *self, PyObject *args )
{
   int fail,number;

   initialize();
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_standard_polynomials(&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_dobldobl_polynomials
 ( PyObject *self, PyObject *args )
{
   int fail,number;

   initialize();
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_dobldobl_polynomials(&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_quaddobl_polynomials
 ( PyObject *self, PyObject *args )
{
   int fail,number;

   initialize();
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_quaddobl_polynomials(&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_multprec_polynomials
 ( PyObject *self, PyObject *args )
{
   int fail,number;

   initialize();
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_multprec_polynomials(&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_standard_Laurentials
 ( PyObject *self, PyObject *args )
{
   int fail,number;
   static PyObject *a;

   initialize();
   /* if (!PyArg_ParseTuple(args,"i",&number)) return NULL; */
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_standard_Laurentials(&number);

   /* a = Py_BuildValue("{i:i}",fail,number);	 
   return a; */

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_dobldobl_Laurentials
 ( PyObject *self, PyObject *args )
{
   int fail,number;

   initialize();
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_dobldobl_Laurentials(&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_quaddobl_Laurentials
 ( PyObject *self, PyObject *args )
{
   int fail,number;

   initialize();
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_quaddobl_Laurentials(&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_multprec_Laurentials
 ( PyObject *self, PyObject *args )
{
   int fail,number;

   initialize();
   if (!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_number_of_multprec_Laurentials(&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_initialize_number_of_standard_polynomials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_standard_polynomials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_initialize_number_of_dobldobl_polynomials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_dobldobl_polynomials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_initialize_number_of_quaddobl_polynomials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_quaddobl_polynomials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_initialize_number_of_multprec_polynomials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_multprec_polynomials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_initialize_number_of_standard_Laurentials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_standard_Laurentials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_initialize_number_of_dobldobl_Laurentials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_dobldobl_Laurentials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_initialize_number_of_quaddobl_Laurentials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_quaddobl_Laurentials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_initialize_number_of_multprec_Laurentials
 ( PyObject *self, PyObject *args )
{      
   int fail,dim;

   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;
   initialize();
   fail = syscon_initialize_number_of_multprec_Laurentials(dim);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_degree_of_standard_polynomial
 ( PyObject *self, PyObject *args )
{
   int fail,equ,deg;

   if(!PyArg_ParseTuple(args,"i",&equ)) return NULL;
   initialize();
   fail = syscon_degree_of_standard_polynomial(equ,&deg);
                 
   return Py_BuildValue("i",deg);
}

static PyObject *py2c_syscon_degree_of_dobldobl_polynomial
 ( PyObject *self, PyObject *args )
{
   int fail,equ,deg;

   if(!PyArg_ParseTuple(args,"i",&equ)) return NULL;
   initialize();
   fail = syscon_degree_of_dobldobl_polynomial(equ,&deg);
                 
   return Py_BuildValue("i",deg);
}

static PyObject *py2c_syscon_degree_of_quaddobl_polynomial
 ( PyObject *self, PyObject *args )
{
   int fail,equ,deg;

   if(!PyArg_ParseTuple(args,"i",&equ)) return NULL;
   initialize();
   fail = syscon_degree_of_quaddobl_polynomial(equ,&deg);
                 
   return Py_BuildValue("i",deg);
}

static PyObject *py2c_syscon_degree_of_multprec_polynomial
 ( PyObject *self, PyObject *args )
{
   int fail,equ,deg;

   if(!PyArg_ParseTuple(args,"i",&equ)) return NULL;
   initialize();
   fail = syscon_degree_of_multprec_polynomial(equ,&deg);
                 
   return Py_BuildValue("i",deg);
}

static PyObject *py2c_syscon_number_of_terms
 ( PyObject *self, PyObject *args )
{
   int fail,i,number;

   initialize();
   /* if (!PyArg_ParseTuple(args,"ii",&i,&number)) return NULL; */
   if (!PyArg_ParseTuple(args,"i",&i)) return NULL;
   fail = syscon_number_of_standard_terms(i,&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_number_of_Laurent_terms
 ( PyObject *self, PyObject *args )
{
   int fail,i,number;

   initialize();
   /* if (!PyArg_ParseTuple(args,"ii",&i,&number)) return NULL; */
   if (!PyArg_ParseTuple(args,"i",&i)) return NULL;
   fail = syscon_number_of_standard_Laurent_terms(i,&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_syscon_retrieve_term
 ( PyObject *self, PyObject *args )
{
   int fail, *exp;
   int i,j,n,k;
   double *c;
   static PyObject *a;

   initialize();
   if(!PyArg_ParseTuple(args, "iiiid", &i,&j,&n,&exp,&c)) return NULL;

   exp = (int *)malloc(n * sizeof(int));
   c   = (double *)malloc(2*sizeof(double));

   fail = syscon_retrieve_standard_term(i,j,n,exp,c);
     
   a = Py_BuildValue("i", fail);	 
   
   free(exp);
   free(c);

   return a;           
}

static PyObject *py2c_syscon_store_standard_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&nc,&n,&k,&p)) return NULL;
   fail = syscon_store_standard_polynomial(nc,n,k,p);

   if(fail != 0) printf("Failed to store %s.\n",p);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_store_dobldobl_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&nc,&n,&k,&p)) return NULL;
   fail = syscon_store_dobldobl_polynomial(nc,n,k,p);
           
   if(fail != 0) printf("Failed to store %s.\n",p);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_store_quaddobl_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&nc,&n,&k,&p)) return NULL;
   fail = syscon_store_quaddobl_polynomial(nc,n,k,p);

   if(fail != 0) printf("Failed to store %s.\n",p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_store_multprec_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k,dp;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiiis",&nc,&n,&k,&dp,&p)) return NULL;
   fail = syscon_store_multprec_polynomial(nc,n,k,dp,p);

   if(fail != 0) printf("Failed to store %s.\n",p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_load_standard_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
   
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_standard_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_standard_polynomial(k,&nc,p);
                 
      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_load_dobldobl_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_dobldobl_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_dobldobl_polynomial(k,&nc,p);
                 
      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_load_quaddobl_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_quaddobl_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_quaddobl_polynomial(k,&nc,p);
                 
      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_load_multprec_polynomial
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_multprec_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_multprec_polynomial(k,&nc,p);
                 
      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_store_standard_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&nc,&n,&k,&p)) return NULL;
   fail = syscon_store_standard_Laurential(nc,n,k,p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_store_dobldobl_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&nc,&n,&k,&p)) return NULL;
   fail = syscon_store_dobldobl_Laurential(nc,n,k,p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_store_quaddobl_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&nc,&n,&k,&p)) return NULL;
   fail = syscon_store_quaddobl_Laurential(nc,n,k,p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_store_multprec_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,n,nc,k,size;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iiiis",&nc,&n,&k,&size,&p)) return NULL;
   fail = syscon_store_multprec_Laurential(nc,n,k,size,p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_load_standard_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_standard_Laurent_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_standard_Laurential(k,&nc,p);
                 
      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_load_dobldobl_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_dobldobl_Laurent_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_dobldobl_Laurential(k,&nc,p);
                 
      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_load_quaddobl_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_quaddobl_Laurent_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_quaddobl_Laurential(k,&nc,p);

      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_load_multprec_Laurential
 ( PyObject *self, PyObject *args )
{      
   int fail,nc,k,szl;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_multprec_Laurent_size_limit(k,&szl);
   {
      char p[szl];

      fail = syscon_load_multprec_Laurential(k,&nc,p);
                 
      return Py_BuildValue("s",p);
   }
}

static PyObject *py2c_syscon_total_degree
 ( PyObject *self, PyObject *args )
{
   int fail,totdeg;
                 
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = syscon_total_degree(&totdeg);
                 
   return Py_BuildValue("i",totdeg);
}

static PyObject *py2c_syscon_standard_drop_variable_by_index
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_standard_drop_variable_by_index(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_standard_drop_variable_by_name
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = syscon_standard_drop_variable_by_name(nc,s);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_dobldobl_drop_variable_by_index
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_dobldobl_drop_variable_by_index(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_dobldobl_drop_variable_by_name
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = syscon_dobldobl_drop_variable_by_name(nc,s);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_quaddobl_drop_variable_by_index
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = syscon_quaddobl_drop_variable_by_index(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_syscon_quaddobl_drop_variable_by_name
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = syscon_quaddobl_drop_variable_by_name(nc,s);

   return Py_BuildValue("i",fail);
}

/* The wrapping of the functions in solcon.h starts from here. */

static PyObject *py2c_solcon_read_standard_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_read_standard_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_read_dobldobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_read_dobldobl_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_read_quaddobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_read_quaddobl_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_read_multprec_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_read_multprec_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_write_standard_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_write_standard_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_write_dobldobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_write_dobldobl_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_write_quaddobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_write_quaddobl_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_write_multprec_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_write_multprec_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_clear_standard_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_clear_standard_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_clear_dobldobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_clear_dobldobl_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_clear_quaddobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_clear_quaddobl_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_clear_multprec_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_clear_multprec_solutions();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_open_solution_input_file
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_open_solution_input_file();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_length_standard_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,i,number;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&i)) return NULL;
   fail = solcon_length_standard_solution_string(i,&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_solcon_length_dobldobl_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,i,number;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&i)) return NULL;
   fail = solcon_length_dobldobl_solution_string(i,&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_solcon_length_quaddobl_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,i,number;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&i)) return NULL;
   fail = solcon_length_quaddobl_solution_string(i,&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_solcon_length_multprec_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,i,number;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&i)) return NULL;
   fail = solcon_length_multprec_solution_string(i,&number);

   return Py_BuildValue("i",number);
}

static PyObject *py2c_solcon_write_standard_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"ii",&n,&k)) return NULL;
   p = (char*)malloc((k+1)*sizeof(char));
   fail = solcon_write_standard_solution_string(n,k,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_write_dobldobl_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"ii",&n,&k)) return NULL;
   p = (char*)malloc((k+1)*sizeof(char));
   fail = solcon_write_dobldobl_solution_string(n,k,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_write_quaddobl_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"ii",&n,&k)) return NULL;
   p = (char*)malloc((k+1)*sizeof(char));
   fail = solcon_write_quaddobl_solution_string(n,k,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_write_multprec_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"ii",&n,&k)) return NULL;
   p = (char*)malloc((k+1)*sizeof(char));
   fail = solcon_write_multprec_solution_string(n,k,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_retrieve_next_standard_initialize
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_retrieve_next_standard_initialize();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_retrieve_next_dobldobl_initialize
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_retrieve_next_dobldobl_initialize();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_retrieve_next_quaddobl_initialize
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_retrieve_next_quaddobl_initialize();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_retrieve_next_multprec_initialize
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_retrieve_next_multprec_initialize();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_move_current_standard_to_next
 ( PyObject *self, PyObject *args )
{
   int fail,cursor;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_move_current_standard_to_next(&cursor);
              
   return Py_BuildValue("i",cursor);
}

static PyObject *py2c_solcon_move_current_dobldobl_to_next
 ( PyObject *self, PyObject *args )
{
   int fail,cursor;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_move_current_dobldobl_to_next(&cursor);
              
   return Py_BuildValue("i",cursor);
}

static PyObject *py2c_solcon_move_current_quaddobl_to_next
 ( PyObject *self, PyObject *args )
{
   int fail,cursor;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_move_current_quaddobl_to_next(&cursor);
              
   return Py_BuildValue("i",cursor);
}

static PyObject *py2c_solcon_move_current_multprec_to_next
 ( PyObject *self, PyObject *args )
{
   int fail,cursor;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_move_current_multprec_to_next(&cursor);
              
   return Py_BuildValue("i",cursor);
}

static PyObject *py2c_solcon_length_current_standard_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,cursor,len;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_length_current_standard_solution_string(&cursor,&len);
   if(cursor == 0) len = 0;

   return Py_BuildValue("i",len);
}

static PyObject *py2c_solcon_length_current_dobldobl_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,cursor,len;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_length_current_dobldobl_solution_string(&cursor,&len);
   if(cursor == 0) len = 0;

   return Py_BuildValue("i",len);
}

static PyObject *py2c_solcon_length_current_quaddobl_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,cursor,len;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_length_current_quaddobl_solution_string(&cursor,&len);
   if(cursor == 0) len = 0;

   return Py_BuildValue("i",len);
}

static PyObject *py2c_solcon_length_current_multprec_solution_string
 ( PyObject *self, PyObject *args )
{
   int fail,cursor,len;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = solcon_length_current_multprec_solution_string(&cursor,&len);
   if(cursor == 0) len = 0;

   return Py_BuildValue("i",len);
}

static PyObject *py2c_solcon_write_current_standard_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   p = (char*)malloc((n+1)*sizeof(char));
   fail = solcon_write_current_standard_solution_string(&k,n,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_write_current_dobldobl_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   p = (char*)malloc((n+1)*sizeof(char));
   fail = solcon_write_current_dobldobl_solution_string(&k,n,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_write_current_quaddobl_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   p = (char*)malloc((n+1)*sizeof(char));
   fail = solcon_write_current_quaddobl_solution_string(&k,n,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_write_current_multprec_solution_string
 ( PyObject *self, PyObject *args )
{      
   int fail;
   int n,k;
   char *p;
   static PyObject* a;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   p = (char*)malloc((n+1)*sizeof(char));
   fail = solcon_write_current_multprec_solution_string(&k,n,p);
                 
   a = Py_BuildValue("s",p);

   free(p);
   
   return a;
}

static PyObject *py2c_solcon_append_standard_solution_string
 ( PyObject *self, PyObject *args )
{      
   char fail;
   int n,k;
   char *p;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&n,&k,&p)) return NULL;

   /* printf("Calling solcon_append_solution_string ...\n"); */

   fail = solcon_append_standard_solution_string(n,k,p);

   if(fail != 0) printf("Failed to append solution %s.\n",p);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_append_dobldobl_solution_string
 ( PyObject *self, PyObject *args )
{      
   char fail;
   int n,k;
   char *p;
   
   initialize();
   if(!PyArg_ParseTuple(args,"iis",&n,&k,&p)) return NULL;
   fail = solcon_append_dobldobl_solution_string(n,k,p);

   if(fail != 0) printf("Failed to append solution %s.\n",p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_append_quaddobl_solution_string
 ( PyObject *self, PyObject *args )
{      
   char fail;
   int n,k;
   char *p;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&n,&k,&p)) return NULL;
   fail = solcon_append_quaddobl_solution_string(n,k,p);

   if(fail != 0) printf("Failed to append solution %s.\n",p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_append_multprec_solution_string
 ( PyObject *self, PyObject *args )
{      
   char fail;
   int n,k;
   char *p;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&n,&k,&p)) return NULL;
   fail = solcon_append_multprec_solution_string(n,k,p);

   if(fail != 0) printf("Failed to append solution %s.\n",p);
                 
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_number_of_standard_solutions
 ( PyObject *self, PyObject *args )
{      
   int result,n;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   result = solcon_number_of_standard_solutions(&n);
                 
   return Py_BuildValue("i",n);
}

static PyObject *py2c_solcon_number_of_dobldobl_solutions
 ( PyObject *self, PyObject *args )
{      
   int result,n;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   result = solcon_number_of_dobldobl_solutions(&n);
                 
   return Py_BuildValue("i",n);
}

static PyObject *py2c_solcon_number_of_quaddobl_solutions
 ( PyObject *self, PyObject *args )
{      
   int result,n;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   result = solcon_number_of_quaddobl_solutions(&n);
                 
   return Py_BuildValue("i",n);
}

static PyObject *py2c_solcon_number_of_multprec_solutions
 ( PyObject *self, PyObject *args )
{      
   int result,n;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   result = solcon_number_of_multprec_solutions(&n);
                 
   return Py_BuildValue("i",n);
}

static PyObject *py2c_solcon_standard_drop_coordinate_by_index
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = solcon_standard_drop_coordinate_by_index(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_standard_drop_coordinate_by_name
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = solcon_standard_drop_coordinate_by_name(nc,s);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_dobldobl_drop_coordinate_by_index
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = solcon_dobldobl_drop_coordinate_by_index(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_dobldobl_drop_coordinate_by_name
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = solcon_dobldobl_drop_coordinate_by_name(nc,s);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_quaddobl_drop_coordinate_by_index
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = solcon_quaddobl_drop_coordinate_by_index(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_solcon_quaddobl_drop_coordinate_by_name
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = solcon_quaddobl_drop_coordinate_by_name(nc,s);

   return Py_BuildValue("i",fail);
}

/* The wrapping of functions with prototypes in product.h starts here. */

static PyObject *py2c_product_supporting_set_structure 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = supporting_set_structure();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_product_write_set_structure
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = write_set_structure();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_product_set_structure_string
 ( PyObject *self, PyObject *args )
{
   int fail;
   int size = 1024;
   char s[size];

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = set_structure_string(&size,s);
   s[size] = '\0';
              
   return Py_BuildValue("s",s);
}

static PyObject *py2c_product_parse_set_structure
 ( PyObject *self, PyObject *args )
{
   int nc,fail;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&nc,&s)) return NULL;
   fail = parse_set_structure(nc,s);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_product_is_set_structure_supporting
 ( PyObject *self, PyObject *args )
{
   int fail,result;

   initialize();
   if (!PyArg_ParseTuple(args,"i",&result)) return NULL;
   fail = is_set_structure_supporting(&result);

   return Py_BuildValue("i",result);
}

static PyObject *py2c_product_linear_product_root_count
 ( PyObject *self, PyObject *args )
{
   int fail,r;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = linear_product_root_count(&r);

   return Py_BuildValue("i",r);
}

static PyObject *py2c_product_random_linear_product_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = random_linear_product_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_product_solve_linear_product_system
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = solve_linear_product_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_product_clear_set_structure
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = clear_set_structure();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_product_m_homogeneous_Bezout_number
 ( PyObject *self, PyObject *args )
{
   int fail,mbz,ncp;
   char partition[256];

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = m_homogeneous_Bezout_number(&mbz,&ncp,partition);

   return Py_BuildValue("(i,s)",mbz,partition);
}

static PyObject *py2c_product_m_partition_Bezout_number
 ( PyObject *self, PyObject *args )
{
   int fail,mbz,ncp;
   char *partition;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&ncp,&partition)) return NULL;
   fail = m_partition_Bezout_number(&mbz,ncp,partition);

   return Py_BuildValue("i",mbz);
}

static PyObject *py2c_product_m_homogeneous_start_system
 ( PyObject *self, PyObject *args )
{
   int fail,mbz,ncp;
   char *partition;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&ncp,&partition)) return NULL;
   fail = m_homogeneous_start_system(ncp,partition);

   return Py_BuildValue("i",mbz);
}

/* wrapping functions in celcon.h starts here */

static PyObject *py2c_celcon_initialize_supports
 ( PyObject *self, PyObject *args )
{
   int fail,nbr;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&nbr)) return NULL;
   fail = celcon_initialize_supports(nbr);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_set_type_of_mixture
 ( PyObject *self, PyObject *args )
{
   int fail,r,cnt;
   char *strmix;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&r,&strmix)) return NULL;

   cnt = itemcount(strmix);
   {
      int mix[cnt];

      str2intlist(cnt,strmix,mix);
      fail = celcon_set_type_of_mixture(r,mix);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_type_of_mixture
 ( PyObject *self, PyObject *args )
{
   int fail,r,nbc;
   int mix[64];
   char strmix[256];

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;

   fail = celcon_type_of_mixture(&r,mix);
   nbc = intlist2str(r,mix,strmix);

   return Py_BuildValue("s",strmix);
}

static PyObject *py2c_celcon_append_lifted_point
 ( PyObject *self, PyObject *args )
{
   int fail,dim,ind,cnt;
   char *strpoint;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&dim,&ind,&strpoint)) return NULL;

   cnt = itemcount(strpoint);
   {
      double point[cnt];

      str2dbllist(cnt,strpoint,point);
      fail = celcon_append_lifted_point(dim,ind,point);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_retrieve_lifted_point
 ( PyObject *self, PyObject *args )
{
   int fail,dim,sup,ind,nbc;
   char strpoint[256];

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&dim,&sup,&ind)) return NULL;
   {
      double liftedpoint[dim];

      fail = celcon_get_lifted_point(dim,sup,ind,liftedpoint);
      nbc = dbllist2str(dim,liftedpoint,strpoint);
   }

   return Py_BuildValue("s",strpoint);
}

static PyObject *py2c_celcon_mixed_volume_of_supports
 ( PyObject *self, PyObject *args )
{
   int fail,mv;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_mixed_volume_of_supports(&mv);

   return Py_BuildValue("i",mv);
}

static PyObject *py2c_celcon_number_of_cells
 ( PyObject *self, PyObject *args )
{
   int fail,length;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_number_of_cells(&length);

   return Py_BuildValue("i",length);
}

static PyObject *py2c_celcon_standard_random_coefficient_system 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_create_random_coefficient_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_dobldobl_random_coefficient_system 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_dobldobl_random_coefficient_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_quaddobl_random_coefficient_system 
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_quaddobl_random_coefficient_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_copy_into_standard_systems_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_copy_into_systems_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_copy_into_dobldobl_systems_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_copy_into_dobldobl_systems_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_copy_into_quaddobl_systems_container
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_copy_into_quaddobl_systems_container();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_standard_polyhedral_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;
  
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_create_polyhedral_homotopy();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_dobldobl_polyhedral_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;
  
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_dobldobl_polyhedral_homotopy();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_quaddobl_polyhedral_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;
  
   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_quaddobl_polyhedral_homotopy();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_solve_standard_start_system
 ( PyObject *self, PyObject *args )
{
   int fail,k,nb;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = celcon_solve_start_system(k,&nb);

   return Py_BuildValue("i",nb);
}

static PyObject *py2c_celcon_solve_dobldobl_start_system
 ( PyObject *self, PyObject *args )
{
   int fail,k,nb;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = celcon_solve_dobldobl_start_system(k,&nb);

   return Py_BuildValue("i",nb);
}

static PyObject *py2c_celcon_solve_quaddobl_start_system
 ( PyObject *self, PyObject *args )
{
   int fail,k,nb;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = celcon_solve_quaddobl_start_system(k,&nb);

   return Py_BuildValue("i",nb);
}

static PyObject *py2c_celcon_track_standard_solution_path
 ( PyObject *self, PyObject *args )
{
   int fail,k,i,otp;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&k,&i,&otp)) return NULL;
   fail = celcon_track_solution_path(k,i,otp);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_track_dobldobl_solution_path
 ( PyObject *self, PyObject *args )
{
   int fail,k,i,otp;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&k,&i,&otp)) return NULL;
   fail = celcon_track_dobldobl_solution_path(k,i,otp);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_track_quaddobl_solution_path
 ( PyObject *self, PyObject *args )
{
   int fail,k,i,otp;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&k,&i,&otp)) return NULL;
   fail = celcon_track_quaddobl_solution_path(k,i,otp);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_copy_target_standard_solution_to_container
 ( PyObject *self, PyObject *args )
{
   int fail,k,i;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&i)) return NULL;
   fail = celcon_copy_target_solution_to_container(k,i);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_copy_target_dobldobl_solution_to_container
 ( PyObject *self, PyObject *args )
{
   int fail,k,i;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&i)) return NULL;
   fail = celcon_copy_target_dobldobl_solution_to_container(k,i);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_copy_target_quaddobl_solution_to_container
 ( PyObject *self, PyObject *args )
{
   int fail,k,i;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&i)) return NULL;
   fail = celcon_copy_target_quaddobl_solution_to_container(k,i);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_permute_standard_system
 ( PyObject *self, PyObject *args )
{
   int fail,k,i;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_permute_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_permute_dobldobl_system
 ( PyObject *self, PyObject *args )
{
   int fail,k,i;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_permute_dobldobl_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_permute_quaddobl_system
 ( PyObject *self, PyObject *args )
{
   int fail,k,i;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_permute_quaddobl_system();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_celcon_clear_container
 ( PyObject *self, PyObject *args )
{
   int fail,k,i;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = celcon_clear_mixed_cell_configuration();

   return Py_BuildValue("i",fail);
}

/* The wrapping of the functions with prototypes in scale.h starts here. */

static PyObject *py2c_scale_standard_system
 ( PyObject *self, PyObject *args )
{
   int fail,mode,dim,i;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&mode)) return NULL;
   fail = syscon_number_of_standard_polynomials(&dim);
   if((fail == 0) && (dim > 0))
   {
      double cff[4*dim+2];  

      fail = standard_scale_system(mode,cff);
      if(fail == 0)
      {
         if(mode > 0)
         {
            PyObject *result, *item;
            result = PyList_New(4*dim+1);
            for(i=0; i<4*dim+1; i++)
            {
               item = PyFloat_FromDouble(cff[i]);
               PyList_SET_ITEM(result,i,item);
            }
            return result;
         }
      }
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_scale_dobldobl_system
 ( PyObject *self, PyObject *args )
{
   int fail,mode,dim,i;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&mode)) return NULL;
   fail = syscon_number_of_dobldobl_polynomials(&dim);
   if((fail == 0) && (dim > 0))
   {
      double cff[8*dim+4];  

      fail = dobldobl_scale_system(mode,cff);
      if(fail == 0)
      {
         if(mode > 0)
         {
            PyObject *result, *item;
            result = PyList_New(8*dim+1);
            for(i=0; i<8*dim+1; i++)
            {
               item = PyFloat_FromDouble(cff[i]);
               PyList_SET_ITEM(result,i,item);
            }
            return result;
         }
      }
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_scale_quaddobl_system
 ( PyObject *self, PyObject *args )
{
   int fail,mode,dim,i;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&mode)) return NULL;
   fail = syscon_number_of_quaddobl_polynomials(&dim);
   if((fail == 0) && (dim > 0))
   {
      double cff[16*dim+8];  

      fail = quaddobl_scale_system(mode,cff);
      if(fail == 0)
      {
         if(mode > 0)
         {
            PyObject *result, *item;
            result = PyList_New(16*dim+1);
            for(i=0; i<16*dim+1; i++)
            {
               item = PyFloat_FromDouble(cff[i]);
               PyList_SET_ITEM(result,i,item);
            }
            return result;
         }
      }
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_scale_standard_solutions 
 ( PyObject *self, PyObject *args )
{
   int fail,dim;
   char *cff;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&dim,&cff)) return NULL;
   {
      double scf[dim];

      str2dbllist(dim,cff,scf);
      fail = standard_scale_solutions(dim,10,scf);
   }

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_scale_dobldobl_solutions 
 ( PyObject *self, PyObject *args )
{
   int fail,dim;
   char *cff;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&dim,&cff)) return NULL;
   {
      double scf[dim];

      str2dbllist(dim,cff,scf);
      fail = dobldobl_scale_solutions(dim,10,scf);
   }

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_scale_quaddobl_solutions 
 ( PyObject *self, PyObject *args )
{
   int fail,dim;
   char *cff;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&dim,&cff)) return NULL;
   {
      double scf[dim];

      str2dbllist(dim,cff,scf);
      fail = quaddobl_scale_solutions(dim,10,scf);
   }
   return Py_BuildValue("i",fail);
}

/* The wrapping of the functions with prototypes in sweep.h starts here. */

static PyObject *py2c_sweep_define_parameters_numerically
 ( PyObject *self, PyObject *args )
{
   int fail,nq,nv,np,cnt;
   char *strpars;

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&nq,&nv,&np,&strpars)) return NULL;

   cnt = itemcount(strpars);
   {
      int pars[cnt];

      str2intlist(cnt,strpars,pars);
      fail = sweep_define_parameters_numerically(nq,nv,np,pars);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_define_parameters_symbolically
 ( PyObject *self, PyObject *args )
{
   int fail,nq,nv,np,nc;
   char *pars;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiis",&nq,&nv,&np,&nc,&pars)) return NULL;

   fail = sweep_define_parameters_symbolically(nq,nv,np,nc,pars);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_get_number_of_equations
 ( PyObject *self, PyObject *args )
{
   int fail,nb;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   

   fail = sweep_get_number_of_equations(&nb);

   return Py_BuildValue("i",nb);
}

static PyObject *py2c_sweep_get_number_of_variables
 ( PyObject *self, PyObject *args )
{
   int fail,nb;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   

   fail = sweep_get_number_of_variables(&nb);

   return Py_BuildValue("i",nb);
}

static PyObject *py2c_sweep_get_number_of_parameters
 ( PyObject *self, PyObject *args )
{
   int fail,nb;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   

   fail = sweep_get_number_of_parameters(&nb);

   return Py_BuildValue("i",nb);
}

static PyObject *py2c_sweep_get_indices_numerically
 ( PyObject *self, PyObject *args )
{
   int fail,np,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   

   fail = sweep_get_number_of_parameters(&np);
   {
      int idx[np];
      char stridx[np*10];

      fail = sweep_get_indices_numerically(idx);

      nc = intlist2str(np,idx,stridx);

      return Py_BuildValue("s",stridx);
   }
}

static PyObject *py2c_sweep_get_indices_symbolically
 ( PyObject *self, PyObject *args )
{
   int fail,np,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   

   fail = sweep_get_number_of_parameters(&np);
   {
      char buf[np*20]; /* assumes no more than 20 characters per symbol */

      fail = sweep_get_indices_symbolically(&nc,buf);

      buf[nc] = '\0';

      return Py_BuildValue("s",buf);
   }
}

static PyObject *py2c_sweep_clear_definitions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = sweep_clear_definitions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_set_standard_start
 ( PyObject *self, PyObject *args )
{
   int fail,m;
   char *strvals;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&m,&strvals)) return NULL;
   {
      const int n = 2*m;
      double vals[n];

      str2dbllist(n,strvals,vals);

      fail = sweep_set_standard_start(n,vals);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_set_standard_target
 ( PyObject *self, PyObject *args )
{
   int fail,m;
   char *strvals;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&m,&strvals)) return NULL;
   {
      const int n = 2*m;
      double vals[n];

      str2dbllist(n,strvals,vals);

      fail = sweep_set_standard_target(n,vals);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_set_dobldobl_start
 ( PyObject *self, PyObject *args )
{
   int fail,m;
   char *strvals;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&m,&strvals)) return NULL;
   {
      const int n = 4*m;
      double vals[n];

      str2dbllist(n,strvals,vals);

      fail = sweep_set_dobldobl_start(n,vals);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_set_dobldobl_target
 ( PyObject *self, PyObject *args )
{
   int fail,m;
   char *strvals;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&m,&strvals)) return NULL;
   {
      const int n = 4*m;
      double vals[n];

      str2dbllist(n,strvals,vals);

      fail = sweep_set_dobldobl_target(n,vals);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_set_quaddobl_start
 ( PyObject *self, PyObject *args )
{
   int fail,m;
   char *strvals;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&m,&strvals)) return NULL;
   {
      const int n = 8*m;
      double vals[n];

      str2dbllist(n,strvals,vals);

      fail = sweep_set_quaddobl_start(n,vals);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_set_quaddobl_target
 ( PyObject *self, PyObject *args )
{
   int fail,m;
   char *strvals;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&m,&strvals)) return NULL;
   {
      const int n = 8*m;
      double vals[n];

      str2dbllist(n,strvals,vals);

      fail = sweep_set_quaddobl_target(n,vals);
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_get_standard_start
 ( PyObject *self, PyObject *args )
{
   int fail,n,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   {
      double cff[n];
      char strcff[n*25];

      fail = sweep_get_standard_start(n,cff);

      nc = dbllist2str(n,cff,strcff);

      return Py_BuildValue("s",strcff);
   }
}

static PyObject *py2c_sweep_get_standard_target
 ( PyObject *self, PyObject *args )
{
   int fail,n,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   {
      double cff[n];
      char strcff[n*25];

      fail = sweep_get_standard_target(n,cff);

      nc = dbllist2str(n,cff,strcff);

      return Py_BuildValue("s",strcff);
   }
}

static PyObject *py2c_sweep_get_dobldobl_start
 ( PyObject *self, PyObject *args )
{
   int fail,n,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   {
      double cff[n];
      char strcff[n*25];

      fail = sweep_get_dobldobl_start(n,cff);

      nc = dbllist2str(n,cff,strcff);

      return Py_BuildValue("s",strcff);
   }
}

static PyObject *py2c_sweep_get_dobldobl_target
 ( PyObject *self, PyObject *args )
{
   int fail,n,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   {
      double cff[n];
      char strcff[n*25];

      fail = sweep_get_dobldobl_target(n,cff);

      nc = dbllist2str(n,cff,strcff);

      return Py_BuildValue("s",strcff);
   }
}

static PyObject *py2c_sweep_get_quaddobl_start
 ( PyObject *self, PyObject *args )
{
   int fail,n,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   {
      double cff[n];
      char strcff[n*25];

      fail = sweep_get_quaddobl_start(n,cff);

      nc = dbllist2str(n,cff,strcff);

      return Py_BuildValue("s",strcff);
   }
}

static PyObject *py2c_sweep_get_quaddobl_target
 ( PyObject *self, PyObject *args )
{
   int fail,n,nc;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;
   {
      double cff[n];
      char strcff[n*25];

      fail = sweep_get_quaddobl_target(n,cff);

      nc = dbllist2str(n,cff,strcff);

      return Py_BuildValue("s",strcff);
   }
}

static PyObject *py2c_sweep_standard_complex_run
 ( PyObject *self, PyObject *args )
{
   int fail,choice;
   double g_re,g_im;

   initialize();
   if(!PyArg_ParseTuple(args,"idd",&choice,&g_re,&g_im)) return NULL;   

   fail = sweep_standard_complex_run(choice,&g_re,&g_im);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_dobldobl_complex_run
 ( PyObject *self, PyObject *args )
{
   int fail,choice;
   double g_re,g_im;

   initialize();
   if(!PyArg_ParseTuple(args,"idd",&choice,&g_re,&g_im)) return NULL;   
   {
      if(choice < 2)
         fail = sweep_dobldobl_complex_run(choice,&g_re,&g_im);
      else
      {
         double regamma[2];
         double imgamma[2];
         regamma[0] = g_re; regamma[1] = 0.0;
         imgamma[0] = g_im; imgamma[1] = 0.0;
         fail = sweep_dobldobl_complex_run(choice,regamma,imgamma);
      }
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_quaddobl_complex_run
 ( PyObject *self, PyObject *args )
{
   int fail,choice;
   double g_re,g_im;

   initialize();
   if(!PyArg_ParseTuple(args,"idd",&choice,&g_re,&g_im)) return NULL;   
   {
      if(choice < 2)
         fail = sweep_quaddobl_complex_run(choice,&g_re,&g_im);
      else
      {
         double regamma[4];
         double imgamma[4];
         regamma[0] = g_re; regamma[1] = 0.0;
         regamma[2] = 0.0;  regamma[3] = 0.0;
         imgamma[0] = g_im; imgamma[1] = 0.0;
         imgamma[2] = 0.0;  imgamma[3] = 0.0;
         fail = sweep_quaddobl_complex_run(choice,regamma,imgamma);
      }
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_standard_real_run
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = sweep_standard_real_run();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_dobldobl_real_run
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = sweep_dobldobl_real_run();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_sweep_quaddobl_real_run
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = sweep_quaddobl_real_run();

   return Py_BuildValue("i",fail);
}

/* The wrapping of the numerical tropisms container starts here. */

static PyObject *py2c_numbtrop_standard_initialize
 ( PyObject *self, PyObject *args )
{
   int fail,nbt,dim,k;
   char *data; /* all numbers come in one long string */

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&nbt,&dim,&data)) return NULL;   
   {
      const int lendata = nbt*(dim+2);
      double numbers[lendata];
      int wnd[nbt];
      double dir[nbt*dim];
      double err[nbt];

      str2dbllist(lendata,data,numbers);

      for(k=0; k<nbt; k++) wnd[k] = (int) numbers[k];
      for(k=0; k<nbt*dim; k++) dir[k] = numbers[nbt+k];
      for(k=0; k<nbt; k++) err[k] = numbers[nbt*(dim+1)+k];

      fail = numbtrop_standard_initialize(nbt,dim,wnd,dir,err);     
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_dobldobl_initialize
 ( PyObject *self, PyObject *args )
{
   int fail,nbt,dim,k;;
   char *data; /* all numbers come in one long string */

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&nbt,&dim,&data)) return NULL;   
   {
      const int lendata = nbt + 2*nbt*(dim+1);
      double numbers[lendata];
      int wnd[nbt];
      double dir[2*nbt*dim];
      double err[2*nbt];

      str2dbllist(lendata,data,numbers);

      for(k=0; k<nbt; k++) wnd[k] = (int) numbers[k];
      for(k=0; k<2*nbt*dim; k++) dir[k] = numbers[nbt+k];
      for(k=0; k<2*nbt; k++) err[k] = numbers[nbt+2*nbt*dim+k];

      fail = numbtrop_dobldobl_initialize(nbt,dim,wnd,dir,err);     
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_quaddobl_initialize
 ( PyObject *self, PyObject *args )
{
   int fail,nbt,dim,k;
   char *data; /* all numbers come in one long string */

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&nbt,&dim,&data)) return NULL;   
   {
      const int lendata = nbt + 4*nbt*(dim+1);
      double numbers[lendata];
      int wnd[nbt];
      double dir[4*nbt*dim];
      double err[4*nbt];

      str2dbllist(lendata,data,numbers);

      for(k=0; k<nbt; k++) wnd[k] = (int) numbers[k];
      for(k=0; k<4*nbt*dim; k++) dir[k] = numbers[nbt+k];
      for(k=0; k<4*nbt; k++) err[k] = numbers[nbt+4*nbt*dim+k];

      fail = numbtrop_quaddobl_initialize(nbt,dim,wnd,dir,err);     
   }

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_standard_retrieve
 ( PyObject *self, PyObject *args )
{
   int fail,nbt,dim,k,nbc;
   char *fltlist;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&nbt,&dim)) return NULL;   
   {
      int wnd[nbt];
      double dir[nbt*dim];
      double err[nbt];
      double data[nbt*(dim+2)];

      fail = numbtrop_standard_retrieve(nbt,dim,wnd,dir,err);

      for(k=0; k<nbt; k++) data[k] = (double) wnd[k];
      for(k=0; k<nbt*dim; k++) data[nbt+k] = dir[k];
      for(k=0; k<nbt; k++) data[nbt*(dim+1)+k] = err[k];

      /* printf("data = \n");
      for(k=0; k<nbt*(dim+2); k++) printf(" %.14e",data[k]); */

      fltlist = (char*)calloc(25*nbt*(dim+2), sizeof(char));
      nbc = dbllist2str(nbt*(dim+2),data,fltlist);
      /* printf("\nnbc = %d\n", nbc);
      printf("25*nbt*(dim+2) = %d\n", 25*nbt*(dim+2));
      printf("len(fltlist) = %lu\n", strlen(fltlist));
      printf("\nfltlist = %s\n",fltlist); */
   }
   return Py_BuildValue("(i, s)", fail, fltlist);
}

static PyObject *py2c_numbtrop_dobldobl_retrieve
 ( PyObject *self, PyObject *args )
{
   int fail,nbt,dim,k,nbc;
   char *fltlist;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&nbt,&dim)) return NULL;   
   {
      int wnd[nbt];
      double dir[2*nbt*dim];
      double err[2*nbt];
      const int lendata = nbt+2*nbt*(dim+1);
      double data[lendata];

      fail = numbtrop_dobldobl_retrieve(nbt,dim,wnd,dir,err);

      for(k=0; k<nbt; k++) data[k] = (double) wnd[k];
      for(k=0; k<2*nbt*dim; k++) data[nbt+k] = dir[k];
      for(k=0; k<2*nbt; k++) data[nbt+2*nbt*dim+k] = err[k];

      fltlist = (char*)calloc(50*nbt*(dim+2), sizeof(char));
      nbc = dbllist2str(lendata,data,fltlist);
   }
   return Py_BuildValue("(i, s)", fail, fltlist);
}

static PyObject *py2c_numbtrop_quaddobl_retrieve
 ( PyObject *self, PyObject *args )
{
   int fail,nbt,dim,k,nbc;
   char *fltlist;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&nbt,&dim)) return NULL;   
   {
      int wnd[nbt];
      double dir[4*nbt*dim];
      double err[4*nbt];
      const int lendata = nbt+4*nbt*(dim+1);
      double data[lendata];

      fail = numbtrop_quaddobl_retrieve(nbt,dim,wnd,dir,err);

      for(k=0; k<nbt; k++) data[k] = (double) wnd[k];
      for(k=0; k<4*nbt*dim; k++) data[nbt+k] = dir[k];
      for(k=0; k<4*nbt; k++) data[nbt+4*nbt*dim+k] = err[k];

      fltlist = (char*)calloc(75*nbt*(dim+2), sizeof(char));
      nbc = dbllist2str(lendata,data,fltlist);
      /* printf("fltlist = %s\n",fltlist);
      printf("lendata = %d, nbc = %d\n", lendata, nbc); */
   }
   return Py_BuildValue("(i, s)", fail, fltlist);
}

static PyObject *py2c_numbtrop_standard_size
 ( PyObject *self, PyObject *args )
{
   int fail,nbt;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_standard_size(&nbt);

   return Py_BuildValue("i",nbt);
}

static PyObject *py2c_numbtrop_dobldobl_size
 ( PyObject *self, PyObject *args )
{
   int fail,nbt;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_dobldobl_size(&nbt);

   return Py_BuildValue("i",nbt);
}

static PyObject *py2c_numbtrop_quaddobl_size
 ( PyObject *self, PyObject *args )
{
   int fail,nbt;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_quaddobl_size(&nbt);

   return Py_BuildValue("i",nbt);
}


static PyObject *py2c_numbtrop_standard_dimension
 ( PyObject *self, PyObject *args )
{
   int fail,dim;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_standard_dimension(&dim);

   return Py_BuildValue("i",dim);
}

static PyObject *py2c_numbtrop_dobldobl_dimension
 ( PyObject *self, PyObject *args )
{
   int fail,dim;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_dobldobl_dimension(&dim);

   return Py_BuildValue("i",dim);
}

static PyObject *py2c_numbtrop_quaddobl_dimension
 ( PyObject *self, PyObject *args )
{
   int fail,dim;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_quaddobl_dimension(&dim);

   return Py_BuildValue("i",dim);
}

static PyObject *py2c_numbtrop_store_standard_tropism
 ( PyObject *self, PyObject *args )
{
   int fail,dim,idx,wnd,k;
   char *data; /* all double numbers come in one long string */

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&dim,&idx,&wnd,&data)) return NULL;   
   {
      const int lendata = dim+1;
      double numbers[lendata];
      double dir[dim];
      double err;

      str2dbllist(lendata,data,numbers);

      for(k=0; k<dim; k++) dir[k] = numbers[k];
      err = numbers[dim];

      fail = numbtrop_store_standard_tropism(dim,idx,wnd,dir,err);     
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_store_dobldobl_tropism
 ( PyObject *self, PyObject *args )
{
   int fail,dim,idx,wnd,k;
   char *data; /* all double numbers come in one long string */

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&dim,&idx,&wnd,&data)) return NULL;   
   {
      const int lendata = 2*dim+2;
      double numbers[lendata];
      double dir[2*dim];
      double err[2];

      str2dbllist(lendata,data,numbers);

      for(k=0; k<2*dim; k++) dir[k] = numbers[k];
      err[0] = numbers[2*dim];
      err[1] = numbers[2*dim+1];

      fail = numbtrop_store_dobldobl_tropism(dim,idx,wnd,dir,err);     
   }
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_store_quaddobl_tropism
 ( PyObject *self, PyObject *args )
{
   int fail,dim,idx,wnd,k;
   char *data; /* all double numbers come in one long string */

   /* printf("inside py2c store quaddobl tropism ...\n"); */

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&dim,&idx,&wnd,&data)) return NULL;   
   {
      const int lendata = 4*dim+4;
      double numbers[lendata];
      double dir[4*dim];
      double err[4];

      str2dbllist(lendata,data,numbers);

      for(k=0; k<4*dim; k++) dir[k] = numbers[k];
      err[0] = numbers[4*dim];
      err[1] = numbers[4*dim+1];
      err[2] = numbers[4*dim+2];
      err[3] = numbers[4*dim+3];

      fail = numbtrop_store_quaddobl_tropism(dim,idx,wnd,dir,err);     
   }
   /* printf("leaving py2c store quaddobl tropism ...\n"); */

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_standard_retrieve_tropism
 ( PyObject *self, PyObject *args )
{
   int fail,dim,idx,wnd,k,nbc;
   char *fltlist;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&dim,&idx)) return NULL;   
   {
      double dir[dim];
      double err;
      double direrr[dim+1];

      fail = numbtrop_standard_retrieve_tropism(dim,idx,&wnd,dir,&err);

      fltlist = (char*)calloc(25*(dim+1), sizeof(char));
      for(k=0; k<dim; k++) direrr[k] = dir[k];
      direrr[dim] = err;
      nbc = dbllist2str(dim+1,direrr,fltlist);
   }
   return Py_BuildValue("(i,i,s)",fail,wnd,fltlist);
}

static PyObject *py2c_numbtrop_dobldobl_retrieve_tropism
 ( PyObject *self, PyObject *args )
{
   int fail,dim,idx,wnd,k,nbc;
   char *fltlist;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&dim,&idx)) return NULL;   
   {
      double dir[2*dim];
      double err[2];
      double direrr[2*dim+2];

      fail = numbtrop_dobldobl_retrieve_tropism(dim,idx,&wnd,dir,err);

      fltlist = (char*)calloc(50*(dim+1), sizeof(char));
      for(k=0; k<2*dim; k++) direrr[k] = dir[k];
      direrr[2*dim] = err[0];
      direrr[2*dim+1] = err[1];
      nbc = dbllist2str(2*dim+2,direrr,fltlist);
   }
   return Py_BuildValue("(i,i,s)",fail,wnd,fltlist);
}

static PyObject *py2c_numbtrop_quaddobl_retrieve_tropism
 ( PyObject *self, PyObject *args )
{
   int fail,dim,idx,wnd,k,nbc;
   char *fltlist;

   /* printf("inside py2c numbtrop quaddobl retrieve tropism ...\n"); */

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&dim,&idx)) return NULL;   
   {
      double dir[4*dim];
      double err[4];
      double direrr[4*dim+4];

      fail = numbtrop_quaddobl_retrieve_tropism(dim,idx,&wnd,dir,err);

      fltlist = (char*)calloc(75*(dim+1), sizeof(char));
      for(k=0; k<4*dim; k++) direrr[k] = dir[k];
      direrr[4*dim] = err[0];
      direrr[4*dim+1] = err[1];
      direrr[4*dim+2] = err[2];
      direrr[4*dim+3] = err[3];
      nbc = dbllist2str(4*dim+4,direrr,fltlist);

      /* printf("fltlist = %s\n", fltlist);
      printf("nbc = %d\n", nbc); */
   }

   /* printf("leaving py2c numbtrop quaddobl retrieve tropism ...\n"); */

   return Py_BuildValue("(i,i,s)",fail,wnd,fltlist);
}

static PyObject *py2c_numbtrop_standard_clear
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_standard_clear();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_dobldobl_clear
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_dobldobl_clear();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_numbtrop_quaddobl_clear
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = numbtrop_quaddobl_clear();

   return Py_BuildValue("i",fail);
}

/* The wrapping of the functions with prototypes in witset.h starts here. */

static PyObject *py2c_embed_system
 ( PyObject *self, PyObject *args )
{
   int d,prc,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&d,&prc)) return NULL;
   fail = embed_system(d,prc);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_embed_standard_system
 ( PyObject *self, PyObject *args )
{
   int d,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&d)) return NULL;
   fail = embed_standard_system(d);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_embed_dobldobl_system
 ( PyObject *self, PyObject *args )
{
   int d,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&d)) return NULL;
   fail = embed_dobldobl_system(d);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_embed_quaddobl_system
 ( PyObject *self, PyObject *args )
{
   int d,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&d)) return NULL;
   fail = embed_quaddobl_system(d);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_standard_cascade_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = create_cascade_homotopy();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_dobldobl_cascade_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = create_dobldobl_cascade_homotopy();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_quaddobl_cascade_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = create_quaddobl_cascade_homotopy();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_standard_to_mute
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = set_state_to_silent();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_dobldobl_to_mute
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = set_dobldobl_state_to_silent();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_quaddobl_to_mute
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = set_quaddobl_state_to_silent();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_standard_to_verbose
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = set_standard_state_to_verbose();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_dobldobl_to_verbose
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = set_dobldobl_state_to_verbose();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_quaddobl_to_verbose
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = set_quaddobl_state_to_verbose();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_define_output_file_with_string
 ( PyObject *self, PyObject *args )
{
   int n,fail;
   char *name;

   initialize();
   if(!PyArg_ParseTuple(args,"is",&n,&name)) return NULL;
   fail = define_output_file_with_string(n,name);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_standard_assign_labels
 ( PyObject *self, PyObject *args )
{
   int n,nbsols,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&n,&nbsols)) return NULL;
   fail = standard_assign_labels(n,nbsols);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_dobldobl_assign_labels
 ( PyObject *self, PyObject *args )
{
   int n,nbsols,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&n,&nbsols)) return NULL;
   fail = dobldobl_assign_labels(n,nbsols);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_quaddobl_assign_labels
 ( PyObject *self, PyObject *args )
{
   int n,nbsols,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&n,&nbsols)) return NULL;
   fail = quaddobl_assign_labels(n,nbsols);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_initialize_standard_sampler
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = initialize_sampler(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_initialize_dobldobl_sampler
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = initialize_dobldobl_sampler(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_initialize_quaddobl_sampler
 ( PyObject *self, PyObject *args )
{
   int k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&k)) return NULL;
   fail = initialize_quaddobl_sampler(k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_initialize_standard_monodromy
 ( PyObject *self, PyObject *args )
{
   int n,d,k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&n,&d,&k)) return NULL;
   fail = initialize_monodromy(n,d,k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_initialize_dobldobl_monodromy
 ( PyObject *self, PyObject *args )
{
   int n,d,k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&n,&d,&k)) return NULL;
   fail = initialize_dobldobl_monodromy(n,d,k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_initialize_quaddobl_monodromy
 ( PyObject *self, PyObject *args )
{
   int n,d,k,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&n,&d,&k)) return NULL;
   fail = initialize_quaddobl_monodromy(n,d,k);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_standard_trace_grid_diagnostics
 ( PyObject *self, PyObject *args )
{
   int fail;
   double err,dis;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = trace_grid_diagnostics(&err,&dis);

   return Py_BuildValue("(d,d)",err,dis);
}

static PyObject *py2c_factor_dobldobl_trace_grid_diagnostics
 ( PyObject *self, PyObject *args )
{
   int fail;
   double err,dis;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = dobldobl_trace_grid_diagnostics(&err,&dis);

   return Py_BuildValue("(d,d)",err,dis);
}

static PyObject *py2c_factor_quaddobl_trace_grid_diagnostics
 ( PyObject *self, PyObject *args )
{
   int fail;
   double err,dis;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = quaddobl_trace_grid_diagnostics(&err,&dis);

   return Py_BuildValue("(d,d)",err,dis);
}

static PyObject *py2c_factor_store_standard_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = store_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_store_dobldobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = store_dobldobl_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_store_quaddobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = store_quaddobl_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_restore_standard_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = restore_solutions();

   return Py_BuildValue("i",fail);
}


static PyObject *py2c_factor_restore_dobldobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = restore_dobldobl_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_restore_quaddobl_solutions
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = restore_quaddobl_solutions();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_standard_track_paths
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = track_paths();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_dobldobl_track_paths
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = dobldobl_track_paths();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_quaddobl_track_paths
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = quaddobl_track_paths();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_swap_standard_slices
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = swap_slices();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_swap_dobldobl_slices
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = swap_dobldobl_slices();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_swap_quaddobl_slices
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = swap_quaddobl_slices();

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_new_standard_slices
 ( PyObject *self, PyObject *args )
{
   int k,n,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&n)) return NULL;
   fail = new_slices(k,n);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_new_dobldobl_slices
 ( PyObject *self, PyObject *args )
{
   int k,n,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&n)) return NULL;
   fail = new_dobldobl_slices(k,n);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_new_quaddobl_slices
 ( PyObject *self, PyObject *args )
{
   int k,n,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&n)) return NULL;
   fail = new_quaddobl_slices(k,n);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_standard_trace_slice
 ( PyObject *self, PyObject *args )
{
   int first,fail;
   double r[2];

   initialize();
   if(!PyArg_ParseTuple(args,"i",&first)) return NULL;

   r[1] = 0.0;
   if(first == 1)                  /* determine constant coefficient */
      r[0] = -1.0;
   else
      r[0] = +1.0;

   fail = assign_coefficient_of_slice(0,0,r);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_dobldobl_trace_slice
 ( PyObject *self, PyObject *args )
{
   int first,fail;
   double r[4];

   initialize();
   if(!PyArg_ParseTuple(args,"i",&first)) return NULL;

   r[1] = 0.0; r[2] = 0.0; r[3] = 0.0;
   if(first == 1)                  /* determine constant coefficient */
      r[0] = -1.0;
   else
      r[0] = +1.0;

   fail = assign_dobldobl_coefficient_of_slice(0,0,r);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_set_quaddobl_trace_slice
 ( PyObject *self, PyObject *args )
{
   int first,fail;
   double r[8];

   initialize();
   if(!PyArg_ParseTuple(args,"i",&first)) return NULL;

   r[1] = 0.0; r[2] = 0.0; r[3] = 0.0; r[4] = 0.0;
   r[5] = 0.0; r[6] = 0.0; r[7] = 0.0;
   if(first == 1)                  /* determine constant coefficient */
      r[0] = -1.0;
   else
      r[0] = +1.0;

   fail = assign_quaddobl_coefficient_of_slice(0,0,r);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_store_standard_gammas
 ( PyObject *self, PyObject *args )
{
   int n,i,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;

   {
      double re_gamma[n];
      double im_gamma[n];
    
      for(i=0; i<n; i++)
         random_complex(&re_gamma[i],&im_gamma[i]);
      fail = store_standard_gamma(n,re_gamma,im_gamma);
   }

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_store_dobldobl_gammas
 ( PyObject *self, PyObject *args )
{
   int n,i,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;

   {
      double re_gamma[2*n];
      double im_gamma[2*n];
    
      for(i=0; i<n; i++)
         random_dobldobl_complex(&re_gamma[2*i],&im_gamma[2*i]);
      fail = store_dobldobl_gamma(n,re_gamma,im_gamma);
   }

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_store_quaddobl_gammas
 ( PyObject *self, PyObject *args )
{
   int n,i,fail;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&n)) return NULL;

   {
      double re_gamma[4*n];
      double im_gamma[4*n];
    
      for(i=0; i<n; i++)
         random_quaddobl_complex(&re_gamma[4*i],&im_gamma[4*i]);
      fail = store_quaddobl_gamma(n,re_gamma,im_gamma);
   }

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_factor_permutation_after_standard_loop
 ( PyObject *self, PyObject *args )
{
   int d,fail,nb;
   char *result;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&d)) return NULL;
   {
      int i,permutation[d];
      char s[d*10];

      fail = permutation_after_loop(d,permutation);
   /* printf("the permutation :");
      for(i=0; i<d; i++) printf(" %d",permutation[i]);
      printf("\n"); */

      nb = list2str(d,permutation,s);
      result = (char*)calloc(nb,sizeof(char));
      for(i=0; i<nb; i++) result[i] = s[i];
   }
   /* printf("the resulting string : %s\n",result); */
   return Py_BuildValue("s",result);
}

static PyObject *py2c_factor_permutation_after_dobldobl_loop
 ( PyObject *self, PyObject *args )
{
   int d,fail,nb;
   char *result;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&d)) return NULL;
   {
      int i,permutation[d];
      char s[d*10];

      fail = permutation_after_dobldobl_loop(d,permutation);
   /* printf("the permutation :");
      for(i=0; i<d; i++) printf(" %d",permutation[i]);
      printf("\n"); */

      nb = list2str(d,permutation,s);
      result = (char*)calloc(nb,sizeof(char));
      for(i=0; i<nb; i++) result[i] = s[i];
   }
   /* printf("the resulting string : %s\n",result); */
   return Py_BuildValue("s",result);
}

static PyObject *py2c_factor_permutation_after_quaddobl_loop
 ( PyObject *self, PyObject *args )
{
   int d,fail,nb;
   char *result;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&d)) return NULL;
   {
      int i,permutation[d];
      char s[d*10];

      fail = permutation_after_quaddobl_loop(d,permutation);
   /* printf("the permutation :");
      for(i=0; i<d; i++) printf(" %d",permutation[i]);
      printf("\n"); */

      nb = list2str(d,permutation,s);
      result = (char*)calloc(nb,sizeof(char));
      for(i=0; i<nb; i++) result[i] = s[i];
   }
   /* printf("the resulting string : %s\n",result); */
   return Py_BuildValue("s",result);
}

static PyObject *py2c_factor_update_standard_decomposition
 ( PyObject *self, PyObject *args )
{
   int fail,i,d,nc;
   char *permutation;
   int done = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&d,&nc,&permutation)) return NULL;
   {
      int nb,perm[d],nf[2];

   /* printf("updating with ");
      for(i=0; i<nc; i++) printf("%c",permutation[i]);
      printf("\n"); */

      nb = str2list(nc,permutation,perm);

   /* printf("after str2list :");
      for(i=0; i<nb; i++) printf(" %d",perm[i]);
      printf("\n"); */

      fail = update_decomposition(d,perm,nf,&done);
   /* printf("number of factors : %d -> %d\n",nf[0],nf[1]); */
   }
   return Py_BuildValue("i",done);
}

static PyObject *py2c_factor_update_dobldobl_decomposition
 ( PyObject *self, PyObject *args )
{
   int fail,i,d,nc;
   char *permutation;
   int done = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&d,&nc,&permutation)) return NULL;
   {
      int nb,perm[d],nf[2];

   /* printf("updating with ");
      for(i=0; i<nc; i++) printf("%c",permutation[i]);
      printf("\n"); */

      nb = str2list(nc,permutation,perm);

   /* printf("after str2list :");
      for(i=0; i<nb; i++) printf(" %d",perm[i]);
      printf("\n"); */

      fail = update_dobldobl_decomposition(d,perm,nf,&done);
   /* printf("number of factors : %d -> %d\n",nf[0],nf[1]); */
   }
   return Py_BuildValue("i",done);
}

static PyObject *py2c_factor_update_quaddobl_decomposition
 ( PyObject *self, PyObject *args )
{
   int fail,i,d,nc;
   char *permutation;
   int done = 0;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&d,&nc,&permutation)) return NULL;
   {
      int nb,perm[d],nf[2];

   /* printf("updating with ");
      for(i=0; i<nc; i++) printf("%c",permutation[i]);
      printf("\n"); */

      nb = str2list(nc,permutation,perm);

   /* printf("after str2list :");
      for(i=0; i<nb; i++) printf(" %d",perm[i]);
      printf("\n"); */

      fail = update_quaddobl_decomposition(d,perm,nf,&done);
   /* printf("number of factors : %d -> %d\n",nf[0],nf[1]); */
   }
   return Py_BuildValue("i",done);
}

static PyObject *py2c_factor_number_of_standard_components
 ( PyObject *self, PyObject *args )
{
   int fail,nf;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;

   fail = number_of_irreducible_factors(&nf);

   return Py_BuildValue("i",nf);
}

static PyObject *py2c_factor_number_of_dobldobl_components
 ( PyObject *self, PyObject *args )
{
   int fail,nf;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;

   fail = number_of_dobldobl_factors(&nf);

   return Py_BuildValue("i",nf);
}

static PyObject *py2c_factor_number_of_quaddobl_components
 ( PyObject *self, PyObject *args )
{
   int fail,nf;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;

   fail = number_of_quaddobl_factors(&nf);

   return Py_BuildValue("i",nf);
}

static PyObject *py2c_factor_witness_points_of_standard_component
 ( PyObject *self, PyObject *args )
{
   int fail,totdeg,k;
   char *result;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&totdeg,&k)) return NULL;
   {
      int deg,nb,i;
      int w[totdeg];
      char s[10*totdeg];

      fail = witness_points_of_irreducible_factor(k,&deg,w);

      nb = list2str(deg,w,s);
      result = (char*)calloc(nb,sizeof(char));
      for(i=0; i<nb; i++) result[i] = s[i];
   }
   return Py_BuildValue("s",result);
}

static PyObject *py2c_factor_witness_points_of_dobldobl_component
 ( PyObject *self, PyObject *args )
{
   int fail,totdeg,k;
   char *result;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&totdeg,&k)) return NULL;
   {
      int deg,nb,i;
      int w[totdeg];
      char s[10*totdeg];

      fail = witness_points_of_dobldobl_factor(k,&deg,w);

      nb = list2str(deg,w,s);
      result = (char*)calloc(nb,sizeof(char));
      for(i=0; i<nb; i++) result[i] = s[i];
   }
   return Py_BuildValue("s",result);
}

static PyObject *py2c_factor_witness_points_of_quaddobl_component
 ( PyObject *self, PyObject *args )
{
   int fail,totdeg,k;
   char *result;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&totdeg,&k)) return NULL;
   {
      int deg,nb,i;
      int w[totdeg];
      char s[10*totdeg];

      fail = witness_points_of_quaddobl_factor(k,&deg,w);

      nb = list2str(deg,w,s);
      result = (char*)calloc(nb,sizeof(char));
      for(i=0; i<nb; i++) result[i] = s[i];
   }
   return Py_BuildValue("s",result);
}

static PyObject *py2c_factor_standard_trace_sum_difference
 ( PyObject *self, PyObject *args )
{
   int d,k,nc,fail;
   char *ws;
   double tsd;

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&d,&k,&nc,&ws)) return NULL;
   {
      int i,nb,witset[d];

      nb = str2list(nc,ws,witset);
   /* printf("the witness points :");
      for(i=0; i<nb; i++) printf(" %d",witset[i]);
      printf("\n"); */

      fail = trace_sum_difference(nb,witset,&tsd);
   /* printf("trace sum difference : %.3e\n",tsd); */
   }
   return Py_BuildValue("d",tsd);
}

static PyObject *py2c_factor_dobldobl_trace_sum_difference
 ( PyObject *self, PyObject *args )
{
   int d,k,nc,fail;
   char *ws;
   double tsd;

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&d,&k,&nc,&ws)) return NULL;
   {
      int i,nb,witset[d];

      nb = str2list(nc,ws,witset);
   /* printf("the witness points :");
      for(i=0; i<nb; i++) printf(" %d",witset[i]);
      printf("\n"); */

      fail = dobldobl_trace_sum_difference(nb,witset,&tsd);
   /* printf("trace sum difference : %.3e\n",tsd); */
   }
   return Py_BuildValue("d",tsd);
}

static PyObject *py2c_factor_quaddobl_trace_sum_difference
 ( PyObject *self, PyObject *args )
{
   int d,k,nc,fail;
   char *ws;
   double tsd;

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&d,&k,&nc,&ws)) return NULL;
   {
      int i,nb,witset[d];

      nb = str2list(nc,ws,witset);
   /* printf("the witness points :");
      for(i=0; i<nb; i++) printf(" %d",witset[i]);
      printf("\n"); */

      fail = quaddobl_trace_sum_difference(nb,witset,&tsd);
   /* printf("trace sum difference : %.3e\n",tsd); */
   }
   return Py_BuildValue("d",tsd);
}

static PyObject *py2c_witset_standard_membertest
 ( PyObject *self, PyObject *args )
{
   int v,n,d,m,fail,onp,ins;
   double r,h;
   char *p;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiidds",&v,&n,&d,&m,&r,&h,&p)) return NULL;
   {
      const int dim = 2*n;
      double tpt[dim];

      str2dbllist(dim,p,tpt);
      fail = standard_homotopy_membership_test(v,n,d,r,h,tpt,&onp,&ins);
   }
   return Py_BuildValue("(i,i,i)",fail,onp,ins);
}

static PyObject *py2c_witset_dobldobl_membertest
 ( PyObject *self, PyObject *args )
{
   int v,n,d,m,fail,onp,ins;
   double r,h;
   char *p;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiidds",&v,&n,&d,&m,&r,&h,&p)) return NULL;
   {
      const int dim = 4*n;
      double tpt[dim];

      str2dbllist(dim,p,tpt);
      fail = dobldobl_homotopy_membership_test(v,n,d,r,h,tpt,&onp,&ins);
   }
   return Py_BuildValue("(i,i,i)",fail,onp,ins);
}

static PyObject *py2c_witset_quaddobl_membertest
 ( PyObject *self, PyObject *args )
{
   int v,n,d,m,fail,onp,ins;
   double r,h;
   char *p;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiidds",&v,&n,&d,&m,&r,&h,&p)) return NULL;
   {
      const int dim = 8*n;
      double tpt[dim];

      str2dbllist(dim,p,tpt);
      fail = quaddobl_homotopy_membership_test(v,n,d,r,h,tpt,&onp,&ins);
   }
   return Py_BuildValue("(i,i,i)",fail,onp,ins);
}

static PyObject *py2c_standard_witset_of_hypersurface
 ( PyObject *self, PyObject *args )
{
   int fail,nv,nc;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iis",&nv,&nc,&p)) return NULL;
   fail = standard_witset_of_hypersurface(nv,nc,p);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_dobldobl_witset_of_hypersurface
 ( PyObject *self, PyObject *args )
{
   int fail,nv,nc;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iis",&nv,&nc,&p)) return NULL;
   fail = dobldobl_witset_of_hypersurface(nv,nc,p);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_quaddobl_witset_of_hypersurface
 ( PyObject *self, PyObject *args )
{
   int fail,nv,nc;
   char *p;   
                 
   initialize();
   if(!PyArg_ParseTuple(args,"iis",&nv,&nc,&p)) return NULL;
   fail = quaddobl_witset_of_hypersurface(nv,nc,p);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_standard_diagonal_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,a,b;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&a,&b)) return NULL;
   fail = standard_diagonal_homotopy(a,b);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_dobldobl_diagonal_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,a,b;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&a,&b)) return NULL;
   fail = dobldobl_diagonal_homotopy(a,b);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_quaddobl_diagonal_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,a,b;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&a,&b)) return NULL;
   fail = quaddobl_diagonal_homotopy(a,b);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_standard_diagonal_cascade_solutions
 ( PyObject *self, PyObject *args )
{
   int fail,a,b;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&a,&b)) return NULL;
   fail = standard_diagonal_cascade_solutions(a,b);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_dobldobl_diagonal_cascade_solutions
 ( PyObject *self, PyObject *args )
{
   int fail,a,b;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&a,&b)) return NULL;
   fail = dobldobl_diagonal_cascade_solutions(a,b);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_quaddobl_diagonal_cascade_solutions
 ( PyObject *self, PyObject *args )
{
   int fail,a,b;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&a,&b)) return NULL;
   fail = quaddobl_diagonal_cascade_solutions(a,b);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_extrinsic_top_diagonal_dimension
 ( PyObject *self, PyObject *args )
{
   int fail,a,b,n1,n2,d;

   initialize();
   if(!PyArg_ParseTuple(args,"iiii",&n1,&n2,&a,&b)) return NULL;
   fail = extrinsic_top_diagonal_dimension(n1,n2,a,b,&d);

   if(fail == 0)
      return Py_BuildValue("i",d);
   else
      return Py_BuildValue("i",fail);
}

static PyObject *py2c_diagonal_symbols_doubler 
 ( PyObject *self, PyObject *args )
{
   int fail,n,d,nc;
   char *s;

   initialize();
   if(!PyArg_ParseTuple(args,"iiis",&n,&d,&nc,&s)) return NULL;
   fail = diagonal_symbols_doubler(n,d,nc,s);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_standard_collapse_diagonal
 ( PyObject *self, PyObject *args )
{
   int fail,k,d;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&d)) return NULL;
   fail = standard_collapse_diagonal(k,d);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_dobldobl_collapse_diagonal
 ( PyObject *self, PyObject *args )
{
   int fail,k,d;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&d)) return NULL;
   fail = dobldobl_collapse_diagonal(k,d);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_quaddobl_collapse_diagonal
 ( PyObject *self, PyObject *args )
{
   int fail,k,d;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&k,&d)) return NULL;
   fail = quaddobl_collapse_diagonal(k,d);

   return Py_BuildValue("i",fail);
}

/* The wrapping of functions with prototypes in schubert.h starts here. */

static PyObject *py2c_schubert_pieri_count
 ( PyObject *self, PyObject *args )
{
   int fail,m,p,q,r;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&m,&p,&q)) return NULL;
   fail = Pieri_root_count(m,p,q,&r);

   return Py_BuildValue("i",r);
}

static PyObject *py2c_schubert_resolve_conditions
 ( PyObject *self, PyObject *args )
{
   int n,k,nbc,nc,fail,r,vrb;
   char *cond;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiisi",&n,&k,&nbc,&nc,&cond,&vrb)) return NULL;
/*
   printf("the number of characters : %d\n", nc);
   printf("the conditions : %s\n", cond);
   printf("the conditions parsed : ");
*/
   {
      int cds[k*nbc];
      int pos = 0;
      int idx = 0;
      while((idx < k*nbc) && (pos < nc))
      {
         while(cond[pos] == ' ' && pos < nc) pos++;
         if(pos > nc) break;
         cds[idx] = 0;
         while(cond[pos] != ' ')
         {
            if(cond[pos] == '\0') break;
            cds[idx] = cds[idx]*10 + (cond[pos] - '0');
            pos = pos + 1;
            if(pos >= nc) break;
         }
         /* printf(" %d", cds[idx]); */
         idx = idx + 1;
      }
      fail = resolve_Schubert_conditions(n,k,nbc,cds,vrb,&r);
   }
   return Py_BuildValue("i",r);
}

static PyObject *py2c_schubert_standard_littlewood_richardson_homotopies
 ( PyObject *self, PyObject *args )
{
   int i,n,k,nbc,nc,fail,r,vrb,vrf,szn;
   char *cond;
   char *name;

   initialize();
   if(!PyArg_ParseTuple
         (args,"iiiisiiis",&n,&k,&nbc,&nc,&cond,&vrb,&vrf,&szn,&name))
      return NULL;
/*
   printf("name of the output file : %s\n", name);
   printf("the number of characters : %d\n", nc);
   printf("the conditions : %s\n", cond);
   printf("the conditions parsed : ");
*/
   {
      int cds[k*nbc];
      int pos = 0;
      int idx = 0;
      while((idx < k*nbc) && (pos < nc))
      {
         while(cond[pos] == ' ' && pos < nc) pos++;
         if(pos > nc) break;
         cds[idx] = 0;
         while(cond[pos] != ' ')
         {
            if(cond[pos] == '\0') break;
            cds[idx] = cds[idx]*10 + (cond[pos] - '0');
            pos = pos + 1;
            if(pos >= nc) break;
         }
         /* printf(" %d", cds[idx]); */
         idx = idx + 1;
      }
      const int fgsize = 2*(nbc-2)*n*n;
      double fg[fgsize];
      char stfg[fgsize*24+2];
      fail = standard_Littlewood_Richardson_homotopies
               (n,k,nbc,cds,vrb,vrf,szn,name,&r,fg);
      stfg[0] = '[';
      idx = 1;
      for(i=0; i<fgsize; i++)
      {
         sprintf(&stfg[idx],"%+.16e",fg[i]); idx = idx + 23;
         stfg[idx] = ','; idx = idx + 1;
      }
      stfg[idx-1] = ']';
      stfg[idx] = '\0';
      /* printf("The string with flag coefficients :\n%s\n", stfg); */

      return Py_BuildValue("(i,s)",r,stfg);
   }
}

static PyObject *py2c_schubert_dobldobl_littlewood_richardson_homotopies
 ( PyObject *self, PyObject *args )
{
   int i,n,k,nbc,nc,fail,r,vrb,vrf,szn;
   char *cond;
   char *name;

   initialize();
   if(!PyArg_ParseTuple
         (args,"iiiisiiis",&n,&k,&nbc,&nc,&cond,&vrb,&vrf,&szn,&name))
      return NULL;
/*
   printf("name of the output file : %s\n", name);
   printf("the number of characters : %d\n", nc);
   printf("the conditions : %s\n", cond);
   printf("the conditions parsed : ");
*/
   {
      int cds[k*nbc];
      int pos = 0;
      int idx = 0;
      while((idx < k*nbc) && (pos < nc))
      {
         while(cond[pos] == ' ' && pos < nc) pos++;
         if(pos > nc) break;
         cds[idx] = 0;
         while(cond[pos] != ' ')
         {
            if(cond[pos] == '\0') break;
            cds[idx] = cds[idx]*10 + (cond[pos] - '0');
            pos = pos + 1;
            if(pos >= nc) break;
         }
         /* printf(" %d", cds[idx]); */
         idx = idx + 1;
      }
      const int fgsize = 4*(nbc-2)*n*n;
      double fg[fgsize];
      char stfg[fgsize*24+2];
      fail = dobldobl_Littlewood_Richardson_homotopies
               (n,k,nbc,cds,vrb,vrf,szn,name,&r,fg);
      stfg[0] = '[';
      idx = 1;
      for(i=0; i<fgsize; i++)
      {
         sprintf(&stfg[idx],"%+.16e",fg[i]); idx = idx + 23;
         stfg[idx] = ','; idx = idx + 1;
      }
      stfg[idx-1] = ']';
      stfg[idx] = '\0';
      /* printf("The string with flag coefficients :\n%s\n", stfg); */

      return Py_BuildValue("(i,s)",r,stfg);
   }
}

static PyObject *py2c_schubert_quaddobl_littlewood_richardson_homotopies
 ( PyObject *self, PyObject *args )
{
   int i,n,k,nbc,nc,fail,r,vrb,vrf,szn;
   char *cond;
   char *name;

   initialize();
   if(!PyArg_ParseTuple
         (args,"iiiisiiis",&n,&k,&nbc,&nc,&cond,&vrb,&vrf,&szn,&name))
      return NULL;
/*
   printf("name of the output file : %s\n", name);
   printf("the number of characters : %d\n", nc);
   printf("the conditions : %s\n", cond);
   printf("the conditions parsed : ");
*/
   {
      int cds[k*nbc];
      int pos = 0;
      int idx = 0;
      while((idx < k*nbc) && (pos < nc))
      {
         while(cond[pos] == ' ' && pos < nc) pos++;
         if(pos > nc) break;
         cds[idx] = 0;
         while(cond[pos] != ' ')
         {
            if(cond[pos] == '\0') break;
            cds[idx] = cds[idx]*10 + (cond[pos] - '0');
            pos = pos + 1;
            if(pos >= nc) break;
         }
         /* printf(" %d", cds[idx]); */
         idx = idx + 1;
      }
      const int fgsize = 8*(nbc-2)*n*n;
      double fg[fgsize];
      char stfg[fgsize*24+2];
      fail = quaddobl_Littlewood_Richardson_homotopies
               (n,k,nbc,cds,vrb,vrf,szn,name,&r,fg);
      stfg[0] = '[';
      idx = 1;
      for(i=0; i<fgsize; i++)
      {
         sprintf(&stfg[idx],"%+.16e",fg[i]); idx = idx + 23;
         stfg[idx] = ','; idx = idx + 1;
      }
      stfg[idx-1] = ']';
      stfg[idx] = '\0';
      /* printf("The string with flag coefficients :\n%s\n", stfg); */

      return Py_BuildValue("(i,s)",r,stfg);
   }
}

static PyObject *py2c_schubert_localization_poset
 ( PyObject *self, PyObject *args )
{
   int fail,m,p,q,nc;
   const int buffer_size = 10240; /* must be calculated based on m,p,q */
   char ps[buffer_size];

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&m,&p,&q)) return NULL;
   fail = localization_poset(m,p,q,&nc,ps);

   return Py_BuildValue("s",ps);
}

static PyObject *py2c_schubert_pieri_homotopies
 ( PyObject *self, PyObject *args )
{
   int fail,m,p,q,nc,r;
   char *A;
   char *pts;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiiss",&m,&p,&q,&nc,&A,&pts)) return NULL;
   /* printf("receiving %d characters in py2c_pieri_homotopies\n",nc); */
   /* printf("the last character is %c\n",A[nc-1]); */
   fail = run_Pieri_homotopies(m,p,q,nc,&r,A,pts);

   return Py_BuildValue("i",r);
}

static PyObject *py2c_schubert_osculating_planes
 ( PyObject *self, PyObject *args )
{
   int fail,m,p,q,nc;
   char *pts;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiis",&m,&p,&q,&nc,&pts)) return NULL;

   {
      const int d = m+p;
      const int n = m*p + q*d;
      const int size = n*m*d*30;
      char planes[size];

      /* printf("passing %d characters through ...\n",nc);
      printf("size = %d\n",size); */
      fail = real_osculating_planes(m,p,q,&nc,pts,planes);

      return Py_BuildValue("s",planes);
   }
}

static PyObject *py2c_schubert_pieri_system
 ( PyObject *self, PyObject *args )
{
   int fail,m,p,q,nc,r;
   char *A;

   initialize();
   if(!PyArg_ParseTuple(args,"iiiisi",&m,&p,&q,&nc,&A,&r)) return NULL;
   fail = Pieri_polynomial_system(m,p,q,nc,A,r);

   return Py_BuildValue("i",fail);
}

/* The wrapping of the functions with prototypes in mapcon.h starts here. */

static PyObject *py2c_mapcon_solve_system
 ( PyObject *self, PyObject *args )
{
   int fail,puretopdim;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&puretopdim)) return NULL;   
   fail = mapcon_solve_system(puretopdim);
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_mapcon_write_maps
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = mapcon_write_maps();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_mapcon_clear_maps
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = mapcon_clear_maps();
              
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_mapcon_top_dimension
 ( PyObject *self, PyObject *args )
{
   int fail,topdim;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;   
   fail = mapcon_top_dimension(&topdim);
              
   return Py_BuildValue("i",topdim);
}

static PyObject *py2c_mapcon_number_of_maps
 ( PyObject *self, PyObject *args )
{
   int fail,dim,nbmaps;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&dim)) return NULL;   
   fail = mapcon_number_of_maps(dim,&nbmaps);
              
   return Py_BuildValue("i",nbmaps);
}

static PyObject *py2c_mapcon_degree_of_map
 ( PyObject *self, PyObject *args )
{
   int fail,dim,ind,deg;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&dim,&ind)) return NULL;   
   fail = mapcon_degree_of_map(dim,ind,&deg);
              
   return Py_BuildValue("i",deg);
}

static PyObject *py2c_mapcon_coefficients_of_map
 ( PyObject *self, PyObject *args )
{
   int fail,dim,ind,nbvar,i;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&dim,&ind,&nbvar)) return NULL;   

   double *cff;
   cff = (double*)calloc(2*nbvar,sizeof(double));

   fail = mapcon_coefficients_of_map(dim,ind,nbvar,cff);

   double re_cff,im_cff;
   PyObject *result, *item;
   result = PyList_New(nbvar);
   for(i=0; i<nbvar; i++)
   {
      re_cff = cff[2*i];
      im_cff = cff[2*i+1];
      item = PyComplex_FromDoubles(re_cff,im_cff);
      PyList_SET_ITEM(result,i,item);
   }
   free(cff);

   return result;
}

static PyObject *py2c_mapcon_exponents_of_map
 ( PyObject *self, PyObject *args )
{
   int fail,dim,ind,nbvar,i;

   initialize();
   if(!PyArg_ParseTuple(args,"iii",&dim,&ind,&nbvar)) return NULL;   

   int *exp;
   exp = (int*)calloc(dim*nbvar,sizeof(int));

   fail = mapcon_exponents_of_map(dim,ind,nbvar,exp);

   PyObject *result, *item;
   result = PyList_New(dim*nbvar);
   for(i=0; i<dim*nbvar; i++)
   {
      item = PyLong_FromLong(exp[i]); /* no PyInt_FromLong() */
      PyList_SET_ITEM(result,i,item);
   }
   free(exp);
      
   return result;
}

/* The wrapping of the functions with prototypes in next_track.h starts. */

static PyObject *py2c_initialize_standard_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,fixed;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&fixed)) return NULL;
   fail = initialize_standard_homotopy(fixed);
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_dobldobl_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,fixed;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&fixed)) return NULL;
   fail = initialize_dobldobl_homotopy(fixed);
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_quaddobl_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,fixed;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&fixed)) return NULL;
   fail = initialize_quaddobl_homotopy(fixed);
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_multprec_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,deci,fixed;

   initialize();
   if(!PyArg_ParseTuple(args,"ii",&fixed,&deci)) return NULL;
   fail = initialize_multprec_homotopy(fixed,deci);
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_varbprec_homotopy
 ( PyObject *self, PyObject *args )
{
   int fail,fixed,nctgt,ncstr;
   char *tgt;
   char *str;

   initialize();
   if(!PyArg_ParseTuple(args,"iisis",&fixed,&nctgt,&tgt,&ncstr,&str))
      return NULL;
   fail = initialize_varbprec_homotopy(fixed,nctgt,tgt,ncstr,str);
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_standard_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = initialize_standard_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_dobldobl_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = initialize_dobldobl_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_quaddobl_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = initialize_quaddobl_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_multprec_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = initialize_multprec_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_initialize_varbprec_solution
 ( PyObject *self, PyObject *args )
{
   int fail,nv,nc;
   char *sol;

   initialize();
   if(!PyArg_ParseTuple(args,"iis",&nv,&nc,&sol)) return NULL;
   fail = initialize_varbprec_solution(nv,nc,sol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_next_standard_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = next_standard_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_next_dobldobl_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = next_dobldobl_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_next_quaddobl_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = next_quaddobl_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_next_multprec_solution
 ( PyObject *self, PyObject *args )
{
   int fail,indsol;

   initialize();
   if(!PyArg_ParseTuple(args,"i",&indsol)) return NULL;
   fail = next_multprec_solution(indsol);

   return Py_BuildValue("i",fail);
}

static PyObject *py2c_next_varbprec_solution
 ( PyObject *self, PyObject *args )
{
   int fail,want,mxpr,mxit,verb,nc;
   char *sol;

   initialize();
   if(!PyArg_ParseTuple(args,"iiii",&want,&mxpr,&mxit,&verb)) return NULL;
   sol = next_varbprec_solution(want,mxpr,mxit,verb,&nc,&fail);

   return Py_BuildValue("(i,s)",fail,sol);
}

static PyObject *py2c_clear_standard_tracker
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = clear_standard_tracker();
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_dobldobl_tracker
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = clear_dobldobl_tracker();
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_quaddobl_tracker
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = clear_quaddobl_tracker();
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_multprec_tracker
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = clear_multprec_tracker();
   return Py_BuildValue("i",fail);
}

static PyObject *py2c_clear_varbprec_tracker
 ( PyObject *self, PyObject *args )
{
   int fail;

   initialize();
   if(!PyArg_ParseTuple(args,"")) return NULL;
   fail = clear_varbprec_tracker();
   return Py_BuildValue("i",fail);
}

static PyMethodDef phcpy2c3_methods[] = 
{
   {"py2c_PHCpack_version_string", py2c_PHCpack_version_string, METH_VARARGS,
    "Returns the version string of PHCpack.\n The version string is 40 characters long."},
   {"py2c_set_seed", py2c_set_seed, METH_VARARGS, 
    "Takes the value of the integer given on input\n and sets the seed for the random number generators.\n This fixing of the seed enables reproducible runs." },
   {"py2c_get_seed", py2c_get_seed, METH_VARARGS,
    "Returns the current value of the seed.\n Using this value in py2c_set_seed will ensure that the\n results of previous runs can be reproduced."},
   {"py2c_read_standard_target_system", py2c_read_standard_target_system,
     METH_VARARGS, 
    "Prompts the user to enter a target system that will\n be parsed in standard double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_standard_target_system_from_file",
     py2c_read_standard_target_system_from_file, METH_VARARGS,
    "The two input arguments are a number and a string:\n 1) The number equals the number of characters in the string.\n 2) The string given on input is the name of a file which contains\n a target system to be parsed in standard double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_standard_start_system", py2c_read_standard_start_system,
     METH_VARARGS,
    "Prompts the user to enter a start system that will\n be parsed in standard double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_standard_start_system_from_file",
     py2c_read_standard_start_system_from_file, METH_VARARGS,
    "The two input arguments are a number and a string:\n 1) The number equals the number of characters in the string.\n 2) The string given on input is the name of a file which contains\n a start system to be parsed in standard double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_dobldobl_target_system", py2c_read_dobldobl_target_system,
     METH_VARARGS,
    "Prompts the user to enter a target system that will\n be parsed in double double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_dobldobl_target_system_from_file",
     py2c_read_dobldobl_target_system_from_file, METH_VARARGS,
   "The two input arguments are a number and a string:\n 1) The number equals the number of characters in the string.\n 2) The string given on input is the name of a file which contains\n a target system to be parsed in double double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_dobldobl_start_system", py2c_read_dobldobl_start_system,
     METH_VARARGS,
    "Prompts the user to enter a start system that will\n be parsed in double double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_dobldobl_start_system_from_file",
     py2c_read_dobldobl_start_system_from_file, METH_VARARGS, 
    "The two input arguments are a number and a string:\n 1) The number equals the number of characters in the string.\n 2) The string given on input is the name of a file which contains\n a start system to be parsed in double double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_quaddobl_target_system", py2c_read_quaddobl_target_system,
     METH_VARARGS,
    "Prompts the user to enter a target system that will\n be parsed in quad double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_quaddobl_target_system_from_file",
     py2c_read_quaddobl_target_system_from_file, METH_VARARGS,
    "The two input arguments are a number and a string:\n 1) The number equals the number of characters in the string.\n 2) The string given on input is the name of a file which contains\n a target system to be parsed in quad double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_quaddobl_start_system", py2c_read_quaddobl_start_system,
     METH_VARARGS,
    "Prompts the user to enter a start system that will\n be parsed in quad double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_read_quaddobl_start_system_from_file",
     py2c_read_quaddobl_start_system_from_file, METH_VARARGS,
    "The two input arguments are a number and a string:\n 1) The number equals the number of characters in the string.\n 2) The string given on input is the name of a file which contains\n a start system to be parsed in quad double precision.\n The failure code is returned, which is zero if all went well."},
   {"py2c_define_output_file", py2c_define_output_file, METH_VARARGS,
    "Prompts the user to define the output file.\n On return is the failure code, which is zero if all went well."},
   {"py2c_write_standard_target_system",
     py2c_write_standard_target_system, METH_VARARGS, 
    "Writes the target system as stored in standard double precision\n to screen or to the defined output file."},
   {"py2c_write_dobldobl_target_system",
     py2c_write_dobldobl_target_system, METH_VARARGS, 
    "Writes the target system as stored in double double precision\n to screen or to the defined output file."},
   {"py2c_write_quaddobl_target_system",
     py2c_write_quaddobl_target_system, METH_VARARGS, 
    "Writes the target system as stored in quad double precision\n to screen or to the defined output file."},
   {"py2c_write_standard_start_system",
     py2c_write_standard_start_system, METH_VARARGS,
    "Writes the start system as stored in standard double precision\n to screen or to the defined output file."},
   {"py2c_write_dobldobl_start_system",
     py2c_write_dobldobl_start_system, METH_VARARGS,
    "Writes the start system as stored in double double precision\n to screen or to the defined output file."},
   {"py2c_write_quaddobl_start_system",
     py2c_write_quaddobl_start_system, METH_VARARGS,
    "Writes the start system as stored in quad double precision\n to screen or to the defined output file."},
   {"py2c_write_start_solutions", py2c_write_start_solutions, METH_VARARGS,
    "Writes the start solutions in standard double precision either to\n the screen (standard output) or to the defined output file.\n On return is the failure code, which is zero if all is well."},
   {"py2c_copy_standard_target_system_to_container",
     py2c_copy_standard_target_system_to_container, METH_VARARGS,
    "Copies the target system to the container for systems\n with coefficients in standard double precision."},
   {"py2c_copy_dobldobl_target_system_to_container",
     py2c_copy_dobldobl_target_system_to_container, METH_VARARGS,
    "Copies the target system to the container for systems\n with coefficients in double double precision."},
   {"py2c_copy_quaddobl_target_system_to_container",
     py2c_copy_quaddobl_target_system_to_container, METH_VARARGS,
    "Copies the target system to the container for systems\n with coefficients in quad double precision."},
   {"py2c_copy_multprec_target_system_to_container",
     py2c_copy_multprec_target_system_to_container, METH_VARARGS,
    "copies multiprecision target system to container"},
   {"py2c_copy_standard_container_to_target_system",
     py2c_copy_standard_container_to_target_system, METH_VARARGS,
    "Copies the system in the container for systems with coefficients\n in standard double precision to the target system."},
   {"py2c_copy_dobldobl_container_to_target_system",
     py2c_copy_dobldobl_container_to_target_system, METH_VARARGS,
    "Copies the system in the container for systems with coefficients\n in double double precision to the target system."},
   {"py2c_copy_quaddobl_container_to_target_system",
     py2c_copy_quaddobl_container_to_target_system, METH_VARARGS,
    "Copies the system in the container for systems with coefficients\n in quad double precision to the target system."},
   {"py2c_copy_multprec_container_to_target_system",
     py2c_copy_multprec_container_to_target_system, METH_VARARGS,
    "Copies the system in the container for systems with coefficients\n in arbitrary multiprecision to the target system."},
   {"py2c_copy_start_system_to_container",
     py2c_copy_start_system_to_container, METH_VARARGS,
    "Copies the start system to the container for systems\n with coefficients in standard double precision."},
   {"py2c_copy_dobldobl_start_system_to_container",
     py2c_copy_dobldobl_start_system_to_container, METH_VARARGS,
    "Copies the start system to the container for systems\n with coefficients in double double precision."},
   {"py2c_copy_quaddobl_start_system_to_container",
     py2c_copy_quaddobl_start_system_to_container, METH_VARARGS, 
    "Copies the start system to the container for systems\n with coefficients in quad double precision."},
   {"py2c_copy_multprec_start_system_to_container",
     py2c_copy_multprec_start_system_to_container, METH_VARARGS, 
    "Copies the start system to the container for systems\n with coefficients in arbitrary multiprecision."},
   {"py2c_copy_standard_container_to_start_system",
     py2c_copy_standard_container_to_start_system, METH_VARARGS, 
    "Copies the system in the container for systems with coefficients\n in standard double precision to the start system."},
   {"py2c_copy_dobldobl_container_to_start_system",
     py2c_copy_dobldobl_container_to_start_system, METH_VARARGS,
    "Copies the system in the container for systems with coefficients\n in double double precision to the start system."},
   {"py2c_copy_quaddobl_container_to_start_system",
     py2c_copy_quaddobl_container_to_start_system, METH_VARARGS,
    "Copies the system in the container for systems with coefficients\n in quad double precision to the start system."},
   {"py2c_copy_multprec_container_to_start_system",
     py2c_copy_multprec_container_to_start_system, METH_VARARGS,
    "Copies the system in the container for systems with coefficients\n in arbitrary multiprecision to the start system."},
   {"py2c_create_standard_homotopy", py2c_create_standard_homotopy,
     METH_VARARGS,
    "Initializes the data for a homotopy in standard double precision.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_create_standard_homotopy_with_gamma",
     py2c_create_standard_homotopy_with_gamma, METH_VARARGS,
    "Initializes the data for a homotopy in standard double precision.\n On input are two doubles: the real and imaginary part of the gamma constant.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_create_dobldobl_homotopy", py2c_create_dobldobl_homotopy,
     METH_VARARGS,
    "Initializes the data for a homotopy in double double precision.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_create_dobldobl_homotopy_with_gamma",
     py2c_create_dobldobl_homotopy_with_gamma, METH_VARARGS,
    "Initializes the data for a homotopy in double double precision.\n On input are two doubles: the real and imaginary part of the gamma constant.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_create_quaddobl_homotopy", py2c_create_quaddobl_homotopy,
     METH_VARARGS,
    "Initializes the data for a homotopy in quad double precision.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_create_quaddobl_homotopy_with_gamma",
     py2c_create_quaddobl_homotopy_with_gamma, METH_VARARGS,
    "Initializes the data for a homotopy in quad double precision.\n On input are two doubles: the real and imaginary part of the gamma constant.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_create_multprec_homotopy", py2c_create_multprec_homotopy,
     METH_VARARGS,
    "Initializes the data for a homotopy in arbitrary multiprecision.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_create_multprec_homotopy_with_gamma",
     py2c_create_multprec_homotopy_with_gamma, METH_VARARGS,
    "Initializes the data for a homotopy in arbitrary multiprecision.\n On input are two doubles: the real and imaginary part of the gamma constant.\n The failure code is returned, which is zero when all goes well."},
   {"py2c_clear_standard_homotopy", py2c_clear_standard_homotopy, METH_VARARGS,
    "Deallocation of the homotopy stored in standard double precision.\n On return is the failure code, which equals zero if all is well."},
   {"py2c_clear_dobldobl_homotopy", py2c_clear_dobldobl_homotopy, METH_VARARGS,
    "Deallocation of the homotopy stored in double double precision.\n On return is the failure code, which equals zero if all is well."},
   {"py2c_clear_quaddobl_homotopy", py2c_clear_quaddobl_homotopy, METH_VARARGS,
    "Deallocation of the homotopy stored in quad double precision.\n On return is the failure code, which equals zero if all is well."},
   {"py2c_clear_multprec_homotopy", py2c_clear_multprec_homotopy, METH_VARARGS,
    "Deallocation of the homotopy stored in arbitrary multiprecision.\n On return is the failure code, which equals zero if all is well."},
   {"py2c_tune_continuation_parameters", py2c_tune_continuation_parameters,
     METH_VARARGS,
    "Interactive procedure to tune the continuation parameters."},
   {"py2c_show_continuation_parameters", py2c_show_continuation_parameters,
     METH_VARARGS,
    "Shows the current values of the continuation parameters."},
   {"py2c_autotune_continuation_parameters",
     py2c_autotune_continuation_parameters, METH_VARARGS, 
    "Tunes the values of the continuation parameters.\n On input are two integers:\n 1) the difficulty level of the solution paths; and\n 2) the number of decimal places in the precision."},
   {"py2c_get_value_of_continuation_parameter",
     py2c_get_value_of_continuation_parameter, METH_VARARGS,
   "Returns the value of a continuation parameter.\n On input is the index of this continuation parameter, an integer ranging from 1 to 34.\n On return is a double with the value of the corresponding parameter."},
   {"py2c_set_value_of_continuation_parameter",
     py2c_set_value_of_continuation_parameter, METH_VARARGS,
   "Sets the value of a continuation parameter.\n On input is the index of this continuation parameter, an integer ranging from 1 to 34;\n and the new value for the continuation parameter.\n On return is a double with the value of the corresponding parameter."},
   {"py2c_determine_output_during_continuation", 
     py2c_determine_output_during_continuation, METH_VARARGS, 
    "Interactive procedure to determine the level of output during the path tracking."},
   {"py2c_solve_by_standard_homotopy_continuation",
     py2c_solve_by_standard_homotopy_continuation, METH_VARARGS,
    "Tracks the paths defined by the homotopy in standard double precision.\n On input is one integer: the number of tasks for path tracking.\n If that input number is zero, then no multitasking is applied.\n On return is the failure code, which is zero when all went well."},
   {"py2c_solve_by_dobldobl_homotopy_continuation",
     py2c_solve_by_dobldobl_homotopy_continuation, METH_VARARGS, 
    "Tracks the paths defined by the homotopy in double double precision.\n On input is one integer: the number of tasks for path tracking.\n If that input number is zero, then no multitasking is applied.\n On return is the failure code, which is zero when all went well."},
   {"py2c_solve_by_quaddobl_homotopy_continuation",
     py2c_solve_by_quaddobl_homotopy_continuation, METH_VARARGS,
    "Tracks the paths defined by the homotopy in quad double precision.\n On input is one integer: the number of tasks for path tracking.\n If that input number is zero, then no multitasking is applied.\n On return is the failure code, which is zero when all went well."},
   {"py2c_solve_by_multprec_homotopy_continuation",
     py2c_solve_by_multprec_homotopy_continuation, METH_VARARGS, 
    "Tracks the paths defined by the homotopy in arbitrary multiprecision.\n On input is one integer: the number of decimal places in the precision.\n On return is the failure code, which is zero when all went well."},
   {"py2c_copy_standard_target_solutions_to_container",
     py2c_copy_standard_target_solutions_to_container, METH_VARARGS,
    "Copies the target solutions in standard double precision to the\n container for solutions in standard double precision."},
   {"py2c_copy_dobldobl_target_solutions_to_container",
     py2c_copy_dobldobl_target_solutions_to_container, METH_VARARGS,
    "Copies the target solutions in double double precision to the\n container for solutions in double double precision."},
   {"py2c_copy_quaddobl_target_solutions_to_container",
     py2c_copy_quaddobl_target_solutions_to_container, METH_VARARGS,
    "Copies the target solutions in quad double precision to the\n container for solutions in quad double precision."},
   {"py2c_copy_multprec_target_solutions_to_container",
     py2c_copy_multprec_target_solutions_to_container, METH_VARARGS,
    "Copies the target solutions in arbitrary multiprecision to the\n container for solutions in arbitrary multiprecision."},
   {"py2c_copy_standard_container_to_target_solutions",
     py2c_copy_standard_container_to_target_solutions, METH_VARARGS,
    "Copies the solutions in standard double precision from the\n container to the target solutions in standard double precision."},
   {"py2c_copy_dobldobl_container_to_target_solutions",
     py2c_copy_dobldobl_container_to_target_solutions, METH_VARARGS,
    "Copies the solutions in double double precision from the\n container to the target solutions in double double precision."},
   {"py2c_copy_quaddobl_container_to_target_solutions",
     py2c_copy_quaddobl_container_to_target_solutions, METH_VARARGS,
    "Copies the solutions in quad double precision from the\n container to the target solutions in quad double precision."},
   {"py2c_copy_multprec_container_to_target_solutions",
     py2c_copy_multprec_container_to_target_solutions, METH_VARARGS,
    "Copies the solutions in arbitrary multiprecision from the\n container to the target solutions in arbitrary multiprecision."},
   {"py2c_copy_start_solutions_to_container",
     py2c_copy_start_solutions_to_container, METH_VARARGS,
    "Copies the start solutions in standard double precision to the\n container for solutions in standard double precision."},
   {"py2c_copy_dobldobl_start_solutions_to_container",
     py2c_copy_dobldobl_start_solutions_to_container, METH_VARARGS,
    "Copies the start solutions in double double precision to the\n container for solutions in double double precision."},
   {"py2c_copy_quaddobl_start_solutions_to_container",
     py2c_copy_quaddobl_start_solutions_to_container, METH_VARARGS,
    "Copies the start solutions in quad double precision to the\n container for solutions in quad double precision."},
   {"py2c_copy_multprec_start_solutions_to_container",
     py2c_copy_multprec_start_solutions_to_container, METH_VARARGS,
    "Copies the start solutions in arbitrary multiprecision to the\n container for solutions in arbitrary multiprecision."},
   {"py2c_copy_standard_container_to_start_solutions",
     py2c_copy_standard_container_to_start_solutions, METH_VARARGS,
    "Copies the solutions in standard double precision from the\n container to the start solutions in standard double precision."},
   {"py2c_copy_dobldobl_container_to_start_solutions",
     py2c_copy_dobldobl_container_to_start_solutions, METH_VARARGS, 
    "Copies the solutions in double double precision from the\n container to the start solutions in double double precision."},
   {"py2c_copy_quaddobl_container_to_start_solutions",
     py2c_copy_quaddobl_container_to_start_solutions, METH_VARARGS,
    "Copies the solutions in quad double precision from the\n container to the start solutions in quad double precision."},
   {"py2c_copy_multprec_container_to_start_solutions",
     py2c_copy_multprec_container_to_start_solutions, METH_VARARGS,
    "Copies the solutions in arbitrary multiprecision from the\n container to the start solutions in arbitrary multiprecision."},
   {"py2c_solve_system", py2c_solve_system, METH_VARARGS,
    "Calls the blackbox solver on the system stored in the container for\n systems with coefficients in standard double precision.\n One integer is expected on input: the number of tasks.\n If that number is zero, then no multitasking is applied.\n On return, the container for solutions in standard double precision\n contains the solutions to the system in the standard systems container."},
   {"py2c_solve_dobldobl_system", py2c_solve_dobldobl_system, METH_VARARGS,
    "Calls the blackbox solver on the system stored in the container for\n systems with coefficients in double double precision.\n One integer is expected on input: the number of tasks.\n If that number is zero, then no multitasking is applied.\n On return, the container for solutions in double double precision\n contains the solutions to the system in the dobldobl systems container."},
   {"py2c_solve_quaddobl_system", py2c_solve_quaddobl_system, METH_VARARGS,
    "Calls the blackbox solver on the system stored in the container for\n systems with coefficients in quad double precision.\n One integer is expected on input: the number of tasks.\n If that number is zero, then no multitasking is applied.\n On return, the container for solutions in quad double precision\n contains the solutions to the system in the quaddobl systems container."},
   {"py2c_solve_Laurent_system", py2c_solve_Laurent_system, METH_VARARGS,
    "Calls the blackbox solver on the system stored in the container for\n Laurent systems with coefficients in standard double precision.\n Two integers are expected on input:\n 1) a boolean flag silent: if 1, then no intermediate output about\n the root counts is printed, if 0, then the solver is verbose; and \n 2) the number of tasks: if 0, then no multitasking is applied,\n otherwise as many tasks as the number will run.\n On return, the container for solutions in standard double precision\n contains the solutions to the system in the standard Laurent systems\n container."},
   {"py2c_solve_dobldobl_Laurent_system",
     py2c_solve_dobldobl_Laurent_system, METH_VARARGS,
    "Calls the blackbox solver on the system stored in the container for\n Laurent systems with coefficients in double double precision.\n Two integers are expected on input:\n 1) a boolean flag silent: if 1, then no intermediate output about\n the root counts is printed, if 0, then the solver is verbose; and \n 2) the number of tasks: if 0, then no multitasking is applied,\n otherwise as many tasks as the number will run.\n On return, the container for solutions in double double precision\n contains the solutions to the system in the double double Laurent systems\n container."},
   {"py2c_solve_quaddobl_Laurent_system",
     py2c_solve_quaddobl_Laurent_system, METH_VARARGS,
    "Calls the blackbox solver on the system stored in the container for\n Laurent systems with coefficients in quad double precision.\n Two integers are expected on input:\n 1) a boolean flag silent: if 1, then no intermediate output about\n the root counts is printed, if 0, then the solver is verbose; and \n 2) the number of tasks: if 0, then no multitasking is applied,\n otherwise as many tasks as the number will run.\n On return, the container for solutions in quad double precision\n contains the solutions to the system in the quad double Laurent systems\n container."},
   {"py2c_mixed_volume", py2c_mixed_volume, METH_VARARGS,
    "Computes the mixed volume, and the stable mixed volume as well if\n the input parameter equals 1.  On return is the mixed volume, or\n a tuple with the mixed volume and the stable mixed volume."},
   {"py2c_standard_deflate", py2c_standard_deflate, METH_VARARGS,
    "Applies deflation in standard double precision to the system and\n the solutions stored in the containers.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_dobldobl_deflate", py2c_dobldobl_deflate, METH_VARARGS,
    "Applies deflation in double double precision to the system and\n the solutions stored in the containers.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_quaddobl_deflate", py2c_quaddobl_deflate, METH_VARARGS,
    "Applies deflation in quad double precision to the system and\n the solutions stored in the containers.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_standard_Newton_step", py2c_standard_Newton_step, METH_VARARGS,
    "Applies one Newton step in standard double precision to the system in\n the standard systems container and to the solutions in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_dobldobl_Newton_step", py2c_dobldobl_Newton_step, METH_VARARGS,
    "Applies one Newton step in double double precision to the system in\n the standard systems container and to the solutions in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_quaddobl_Newton_step", py2c_quaddobl_Newton_step, METH_VARARGS,
    "Applies one Newton step in quad double precision to the system in\n the standard systems container and to the solutions in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_multprec_Newton_step", py2c_multprec_Newton_step, METH_VARARGS,
    "Applies one Newton step in arbitrary multiprecision to the system in\n the multprec systems container and to the solutions in the container.\n On input is an integer, the number of decimal places in the precision.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_standard_Newton_Laurent_step", py2c_standard_Newton_Laurent_step,
     METH_VARARGS, 
    "Applies one Newton step in standard double precision to the Laurent\n system in the standard Laurent systems container and to the solutions\n in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_dobldobl_Newton_Laurent_step", py2c_dobldobl_Newton_Laurent_step,
     METH_VARARGS,
    "Applies one Newton step in double double precision to the Laurent\n system in the standard Laurent systems container and to the solutions\n in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_quaddobl_Newton_Laurent_step", py2c_quaddobl_Newton_Laurent_step,
     METH_VARARGS, 
    "Applies one Newton step in quad double precision to the Laurent\n system in the standard Laurent systems container and to the solutions\n in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_multprec_Newton_Laurent_step", py2c_multprec_Newton_Laurent_step,
     METH_VARARGS,
    "Applies one Newton step in arbitrary multiprecision to the Laurent\n system in the multprec Laurent systems container and to the solutions\n in the container.\n On input is an integer: the number of decimal places in the precision.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_varbprec_Newton_Laurent_steps", py2c_varbprec_Newton_Laurent_steps,
     METH_VARARGS,
    "Applies Newton's method in variable precision.\n There are six input parameters:\n 1) the dimension: the number of variables and equations;\n 2) the accuracy, expressed as the correct number of decimal places;\n 3) the maximum number of iterations in Newton's method;\n 4) an upper bound on the number of decimal places in the precision;\n 5) a string, with the representation of the polynomials in the system.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_usolve_standard", py2c_usolve_standard, METH_VARARGS,
    "Applies the method of Weierstrass to compute all roots of a\n polynomial in one variable with standard double precision arithmetic.\n On input are two numbers:\n 1) the maximum number of iterations in the method of Weierstrass; and\n 2) the epsilon requirement on the accuracy of the roots.\n Before calling this function, the polynomial should be stored in\n the standard systems container.  After the call of this function,\n the standard solutions container contains the roots of the polynomial.\n On return is the number of iterations done by the solver."},
   {"py2c_usolve_dobldobl", py2c_usolve_dobldobl, METH_VARARGS,
    "Applies the method of Weierstrass to compute all roots of a\n polynomial in one variable with double double precision arithmetic.\n On input are two numbers:\n 1) the maximum number of iterations in the method of Weierstrass; and\n 2) the epsilon requirement on the accuracy of the roots.\n Before calling this function, the polynomial should be stored in\n the dobldobl systems container.  After the call of this function,\n the dobldobl solutions container contains the roots of the polynomial.\n On return is the number of iterations done by the solver."},
   {"py2c_usolve_quaddobl", py2c_usolve_quaddobl, METH_VARARGS,
    "Applies the method of Weierstrass to compute all roots of a\n polynomial in one variable with quad double precision arithmetic.\n On input are two numbers:\n 1) the maximum number of iterations in the method of Weierstrass; and\n 2) the epsilon requirement on the accuracy of the roots.\n Before calling this function, the polynomial should be stored in\n the quaddobl systems container.  After the call of this function,\n the quaddobl solutions container contains the roots of the polynomial.\n On return is the number of iterations done by the solver."},
   {"py2c_usolve_multprec", py2c_usolve_multprec, METH_VARARGS,
    "Applies the method of Weierstrass to compute all roots of a\n polynomial in one variable with arbitrary multiprecision arithmetic.\n On input are three numbers:\n 1) the number of decimal places in the working precision;\n 2) the maximum number of iterations in the method of Weierstrass; and\n 3) the epsilon requirement on the accuracy of the roots.\n Before calling this function, the polynomial should be stored in\n the multprec systems container.  After the call of this function,\n the multprec solutions container contains the roots of the polynomial.\n On return is the number of iterations done by the solver."},
   {"py2c_giftwrap_planar", py2c_giftwrap_planar, METH_VARARGS,
    "Applies the giftwrapping algorithm to a planar point configuration.\n On input are an integer and a string:\n 1) the number of points in the list;\n 2) the string representation of a Python list of tuples.\n On return is the string representation of the vertex points,\n sorted so that each two consecutive points define an edge."},
   {"py2c_giftwrap_convex_hull", py2c_giftwrap_convex_hull, METH_VARARGS,
    "Applies the giftwrapping algorithm to a point configuration.\n On input are an integer and a string:\n 1) the number of points in the list;\n 2) the string representation of a Python list of tuples.\n When the function returns, the internal data structures\n to store the convex hull are defined.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_giftwrap_number_of_facets", py2c_giftwrap_number_of_facets,
    METH_VARARGS,
    "Returns the number of facets of the given dimension.\n On input is an integer, the dimension of the facet."},
   {"py2c_giftwrap_retrieve_facet", py2c_giftwrap_retrieve_facet, METH_VARARGS,
    "Returns the string representation of a facet.\n On input are two integer numbers:\n 1) the dimension of the facet;\n 2) the index of the facet."},
   {"py2c_giftwrap_clear_3d_facets", py2c_giftwrap_clear_3d_facets,
    METH_VARARGS,
    "Deallocates list of facets of convex hull stored in 3-space."},
   {"py2c_giftwrap_clear_4d_facets", py2c_giftwrap_clear_4d_facets,
    METH_VARARGS,
    "Deallocates list of facets of convex hull stored in 4-space."},
   {"py2c_giftwrap_support_size", py2c_giftwrap_support_size, METH_VARARGS,
    "Returns the number of characters in the string representation of\n the support of the first Laurent polynomial in the container."},
   {"py2c_giftwrap_support_string", py2c_giftwrap_support_string,
    METH_VARARGS,
    "Returns the string representation of the support of a Laurent polynomial."},
   {"py2c_giftwrap_clear_support_string", py2c_giftwrap_clear_support_string,
    METH_VARARGS,
    "Deallocates the string representation of the support set\n that was stored internally by the call py2c_giftwrap_support_size."},
   {"py2c_giftwrap_initial_form", py2c_giftwrap_initial_form, METH_VARARGS,
    "Replaces the system in the Laurent systems container by its initial form.\n There are three input parameters:\n 1) the dimension, number of coordinates in the inner normal;\n 2) the number of characters in the string representation for the normal;\n 3) the string representation of the inner normal.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_syscon_read_standard_system",
     py2c_syscon_read_standard_system, METH_VARARGS,
    "Interactive procedure to read a polynomial system with coefficients\n in standard double precision.\n The system will be placed in the standard systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_read_standard_Laurent_system",
     py2c_syscon_read_standard_Laurent_system, METH_VARARGS,
    "Interactive procedure to read a Laurent polynomial system with\n coefficients in standard double precision.\n The system will be placed in the standard Laurent systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_read_dobldobl_system", py2c_syscon_read_dobldobl_system,
    METH_VARARGS,
    "Interactive procedure to read a polynomial system with coefficients\n in double double precision.\n The system will be placed in the dobldobl systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_read_dobldobl_Laurent_system",
     py2c_syscon_read_dobldobl_Laurent_system, METH_VARARGS, 
    "Interactive procedure to read a Laurent polynomial system with\n coefficients in double double precision.\n The system will be placed in the dobldobl Laurent systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_read_quaddobl_system", py2c_syscon_read_quaddobl_system,
    METH_VARARGS, 
    "Interactive procedure to read a polynomial system with coefficients\n in quad double precision.\n The system will be placed in the quaddobl systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_read_quaddobl_Laurent_system",
     py2c_syscon_read_quaddobl_Laurent_system, METH_VARARGS,
    "Interactive procedure to read a Laurent polynomial system with\n coefficients in quad double precision.\n The system will be placed in the quaddobl Laurent systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_read_multprec_system", py2c_syscon_read_multprec_system,
     METH_VARARGS,
    "Interactive procedure to read a polynomial system with coefficients\n in arbitrary multiprecision.  The one input parameter is an integer,\n the number of decimal places in the working precision.\n The system will be placed in the multprec systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_read_multprec_Laurent_system",
     py2c_syscon_read_multprec_Laurent_system, METH_VARARGS,
    "Interactive procedure to read a Laurent polynomial system with\n coefficients in arbitrary multiprecision.  The one input parameter is\n an integer, the number of decimal places in the working precision.\n The system will be placed in the multprec Laurent systems container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_random_system", py2c_syscon_random_system, METH_VARARGS,
    "Places in the systems container a random polynomial system\n with coefficients in standard double precision.\n There are four integers as input parameters:\n 1) n, the number of polynomials and variables;\n 2) m, the number of monomials per equation;\n 3) d, the largest degree of each monomial;\n 4) c, the type of coefficient: 0 if on the complex unit circle,\n 1, if all coefficients are one, 2, if all coefficients are\n random floats in [-1,+1]."}, 
   {"py2c_syscon_write_standard_system",
     py2c_syscon_write_standard_system, METH_VARARGS,
    "Writes the polynomial system with standard double precision coefficients\n that is stored in the container."},
   {"py2c_syscon_write_standard_Laurent_system",
     py2c_syscon_write_standard_Laurent_system, METH_VARARGS,
    "Writes the Laurent polynomial system with standard double precision\n coefficients that is stored in the container."},
   {"py2c_syscon_write_dobldobl_system",
     py2c_syscon_write_dobldobl_system, METH_VARARGS,
    "Writes the polynomial system with double double precision coefficients\n that is stored in the container."},
   {"py2c_syscon_write_dobldobl_Laurent_system",
     py2c_syscon_write_dobldobl_Laurent_system, METH_VARARGS,
    "Writes the Laurent polynomial system with double double precision\n coefficients that is stored in the container."},
   {"py2c_syscon_write_quaddobl_system",
     py2c_syscon_write_quaddobl_system, METH_VARARGS,
    "Writes the polynomial system with quad double precision coefficients\n that is stored in the container."},
   {"py2c_syscon_write_quaddobl_Laurent_system",
     py2c_syscon_write_quaddobl_Laurent_system, METH_VARARGS,
    "Writes the Laurent polynomial system with quad double precision\n coefficients that is stored in the container."},
   {"py2c_syscon_write_multprec_system",
     py2c_syscon_write_multprec_system, METH_VARARGS, 
    "Writes the polynomial system with arbitrary multiprecision coefficients\n that is stored in the container."},
   {"py2c_syscon_write_multprec_Laurent_system",
     py2c_syscon_write_multprec_Laurent_system, METH_VARARGS,
    "Writes the Laurent polynomial system with arbitrary multiprecision\n coefficients that is stored in the container."},
   {"py2c_syscon_clear_standard_system",
     py2c_syscon_clear_standard_system, METH_VARARGS, 
    "Deallocates the container for polynomial systems\n with coefficients in standard double precision."},
   {"py2c_syscon_clear_standard_Laurent_system",
     py2c_syscon_clear_standard_Laurent_system, METH_VARARGS,
    "Deallocates the container for Laurent polynomial systems\n with coefficients in standard double precision."},
   {"py2c_syscon_clear_dobldobl_system",
     py2c_syscon_clear_dobldobl_system, METH_VARARGS, 
    "Deallocates the container for polynomial systems\n with coefficients in double double precision."},
   {"py2c_syscon_clear_dobldobl_Laurent_system",
     py2c_syscon_clear_dobldobl_Laurent_system, METH_VARARGS,
    "Deallocates the container for Laurent polynomial systems\n with coefficients in double double precision."},
   {"py2c_syscon_clear_quaddobl_system",
     py2c_syscon_clear_quaddobl_system, METH_VARARGS, 
    "Deallocates the container for polynomial systems\n with coefficients in quad double precision."},
   {"py2c_syscon_clear_quaddobl_Laurent_system",
     py2c_syscon_clear_quaddobl_Laurent_system, METH_VARARGS, 
    "Deallocates the container for Laurent polynomial systems\n with coefficients in quad double precision."},
   {"py2c_syscon_clear_multprec_system",
     py2c_syscon_clear_multprec_system, METH_VARARGS,
    "Deallocates the container for polynomial systems\n with coefficients in arbitrary multiprecision."},
   {"py2c_syscon_clear_multprec_Laurent_system",
     py2c_syscon_clear_multprec_Laurent_system, METH_VARARGS,
    "Deallocates the container for Laurent polynomial systems\n with coefficients in arbitrary multiprecision."},
   {"py2c_syscon_number_of_symbols",
     py2c_syscon_number_of_symbols, METH_VARARGS,
    "Returns the number of symbols in the symbol table."},
   {"py2c_syscon_write_symbols", py2c_syscon_write_symbols, METH_VARARGS, 
    "Writes the symbols in the symbol table to screen.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_syscon_string_of_symbols",
     py2c_syscon_string_of_symbols, METH_VARARGS,
    "Returns a string that contains the symbols in the symbol table.\n The symbols are separate from each other by one space."},
   {"py2c_syscon_remove_symbol_name", py2c_syscon_remove_symbol_name,
     METH_VARARGS,
    "Removes a symbol, given by name, from the symbol table.\n On input are two arguments:\n 1) an integer, as the number of characters in the name;\n 2) a string of characters with the name of the symbol.\n The failure code is returned, which equals zero when all went well."},
   {"py2c_syscon_clear_symbol_table", py2c_syscon_clear_symbol_table,
     METH_VARARGS, "Clears the symbol table."},
   {"py2c_solcon_read_standard_solutions",
     py2c_solcon_read_standard_solutions, METH_VARARGS,
    "Interactive function to read the solutions into the container,\n in standard double precision.\n Returns the failure code, which is zero when all went well."},
   {"py2c_solcon_read_dobldobl_solutions", py2c_solcon_read_dobldobl_solutions,
     METH_VARARGS,
    "Interactive function to read the solutions into the container,\n in double double precision.\n Returns the failure code, which is zero when all went well."},
   {"py2c_solcon_read_quaddobl_solutions", py2c_solcon_read_quaddobl_solutions,
     METH_VARARGS,
    "Interactive function to read the solutions into the container,\n in quad double precision.\n Returns the failure code, which is zero when all went well."},
   {"py2c_solcon_read_multprec_solutions", py2c_solcon_read_multprec_solutions,
     METH_VARARGS,
    "Interactive function to read the solutions into the container,\n in arbitrary multiprecision.\n Returns the failure code, which is zero when all went well."},
   {"py2c_solcon_write_standard_solutions",
     py2c_solcon_write_standard_solutions, METH_VARARGS,
    "Writes the solutions in standard double precision to screen.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_write_dobldobl_solutions",
     py2c_solcon_write_dobldobl_solutions, METH_VARARGS,
    "Writes the solutions in double double precision to screen.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_write_quaddobl_solutions",
     py2c_solcon_write_quaddobl_solutions, METH_VARARGS,
    "Writes the solutions in quad double precision to screen.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_write_multprec_solutions",
     py2c_solcon_write_multprec_solutions, METH_VARARGS,
    "Writes the solutions in arbitrary multiprecision to screen.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_clear_standard_solutions",
     py2c_solcon_clear_standard_solutions, METH_VARARGS,
    "Deallocates the container for solutions in standard double precision.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_clear_dobldobl_solutions",
     py2c_solcon_clear_dobldobl_solutions, METH_VARARGS,
    "Deallocates the container for solutions in double double precision.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_clear_quaddobl_solutions",
     py2c_solcon_clear_quaddobl_solutions, METH_VARARGS,
    "Deallocates the container for solutions in quad double precision.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_clear_multprec_solutions",
     py2c_solcon_clear_multprec_solutions, METH_VARARGS,
    "Deallocates the container for solutions in arbitrary multiprecision.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_solcon_open_solution_input_file",
     py2c_solcon_open_solution_input_file, METH_VARARGS,
    "Prompts the user for the name of the input file for the solutions and\n opens the input file.  All subsequent reading happens from this input.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_syscon_number_of_standard_polynomials",
     py2c_syscon_number_of_standard_polynomials,
     METH_VARARGS, 
    "Returns the number of polynomials with coefficients in standard\n double precision as stored in the systems container."},
   {"py2c_syscon_number_of_dobldobl_polynomials",
     py2c_syscon_number_of_dobldobl_polynomials, METH_VARARGS, 
    "Returns the number of polynomials with coefficients in double\n double precision as stored in the systems container."},
   {"py2c_syscon_number_of_quaddobl_polynomials",
     py2c_syscon_number_of_quaddobl_polynomials, METH_VARARGS, 
    "Returns the number of polynomials with coefficients in quad\n double precision as stored in the systems container."},
   {"py2c_syscon_number_of_multprec_polynomials",
     py2c_syscon_number_of_multprec_polynomials, METH_VARARGS, 
    "Returns the number of polynomials with coefficients in arbitrary\n multiprecision as stored in the systems container."},
   {"py2c_syscon_number_of_standard_Laurentials",
     py2c_syscon_number_of_standard_Laurentials, METH_VARARGS, 
    "Returns the number of Laurent polynomials with coefficients in\n standard double precision as stored in the systems container."},
   {"py2c_syscon_number_of_dobldobl_Laurentials",
     py2c_syscon_number_of_dobldobl_Laurentials, METH_VARARGS, 
    "Returns the number of Laurent polynomials with coefficients in\n double double precision as stored in the systems container."},
   {"py2c_syscon_number_of_quaddobl_Laurentials",
     py2c_syscon_number_of_quaddobl_Laurentials, METH_VARARGS, 
    "Returns the number of Laurent polynomials with coefficients in\n quad double precision as stored in the systems container."},
   {"py2c_syscon_number_of_multprec_Laurentials",
     py2c_syscon_number_of_multprec_Laurentials, METH_VARARGS, 
    "Returns the number of Laurent polynomials with coefficients in\n arbitrary multiprecision as stored in the systems container."},
   {"py2c_syscon_initialize_number_of_standard_polynomials",
     py2c_syscon_initialize_number_of_standard_polynomials, METH_VARARGS,
    "Initialzes the container for polynomials with coefficients in\n standard double precision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_initialize_number_of_dobldobl_polynomials",
     py2c_syscon_initialize_number_of_dobldobl_polynomials, METH_VARARGS,
    "Initialzes the container for polynomials with coefficients in\n double double precision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_initialize_number_of_quaddobl_polynomials",
     py2c_syscon_initialize_number_of_quaddobl_polynomials, METH_VARARGS,
    "Initialzes the container for polynomials with coefficients in\n quad double precision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_initialize_number_of_multprec_polynomials",
     py2c_syscon_initialize_number_of_multprec_polynomials, METH_VARARGS,
    "Initialzes the container for polynomials with coefficients in\n arbitrary multiprecision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_initialize_number_of_standard_Laurentials",
     py2c_syscon_initialize_number_of_standard_Laurentials, METH_VARARGS,
    "Initialzes the container for Laurent polynomials with coefficients\n in standard double precision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_initialize_number_of_dobldobl_Laurentials",
     py2c_syscon_initialize_number_of_dobldobl_Laurentials, METH_VARARGS,
    "Initialzes the container for Laurent polynomials with coefficients\n in double double precision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_initialize_number_of_quaddobl_Laurentials",
     py2c_syscon_initialize_number_of_quaddobl_Laurentials, METH_VARARGS,
    "Initialzes the container for Laurent polynomials with coefficients\n in quad double precision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_initialize_number_of_multprec_Laurentials",
     py2c_syscon_initialize_number_of_multprec_Laurentials, METH_VARARGS,
    "Initialzes the container for Laurent polynomials with coefficients\n in arbitrary multiprecision.  The input argument is an integer,\n the number of polynomials in the container.\n The failure code is returned, which equals zero if all went well."},
   {"py2c_syscon_degree_of_standard_polynomial",
     py2c_syscon_degree_of_standard_polynomial, METH_VARARGS,
    "Returns the degree of the k-th polynomial in the container for\n polynomials with coefficients in standard double precision.\n The index k of the polynomial is the one input argument."},
   {"py2c_syscon_degree_of_dobldobl_polynomial",
     py2c_syscon_degree_of_dobldobl_polynomial, METH_VARARGS,
    "Returns the degree of the k-th polynomial in the container for\n polynomials with coefficients in double double precision.\n The index k of the polynomial is the one input argument."},
   {"py2c_syscon_degree_of_quaddobl_polynomial",
     py2c_syscon_degree_of_quaddobl_polynomial, METH_VARARGS,
    "Returns the degree of the k-th polynomial in the container for\n polynomials with coefficients in quad double precision.\n The index k of the polynomial is the one input argument."},
   {"py2c_syscon_degree_of_multprec_polynomial",
     py2c_syscon_degree_of_multprec_polynomial, METH_VARARGS,
    "Returns the degree of the k-th polynomial in the container for\n polynomials with coefficients in arbitrary multiprecision.\n The index k of the polynomial is the one input argument."},
   {"py2c_syscon_number_of_terms", 
     py2c_syscon_number_of_terms, METH_VARARGS,
    "Returns the number of terms in the k-th polynomial stored in the\n container for systems with coefficients in standard double precision.\n The input parameter k is the index of the polynomial k."},
   {"py2c_syscon_number_of_Laurent_terms",
     py2c_syscon_number_of_Laurent_terms, METH_VARARGS,
    "Returns the number of terms in the k-th Laurent polynomial stored\n in the container for Laurent polynomials systems with coefficients\n in standard double precision.\n The input parameter k is the index of the polynomial k."},
   {"py2c_syscon_retrieve_term",
     py2c_syscon_retrieve_term, METH_VARARGS,
    "Retrieves one term of a polynomial with coefficients in standard\n double precision, that is stored in the systems container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_syscon_store_standard_polynomial",
     py2c_syscon_store_standard_polynomial, METH_VARARGS, 
    "Defines the k-th polynomial in the systems container for polynomials\n with coefficients in standard double precision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are four input parameters, three integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_store_dobldobl_polynomial",
     py2c_syscon_store_dobldobl_polynomial, METH_VARARGS,
    "Defines the k-th polynomial in the systems container for polynomials\n with coefficients in double double precision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are four input parameters, three integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_store_quaddobl_polynomial",
     py2c_syscon_store_quaddobl_polynomial, METH_VARARGS,
    "Defines the k-th polynomial in the systems container for polynomials\n with coefficients in quad double precision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are four input parameters, three integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_store_multprec_polynomial",
     py2c_syscon_store_multprec_polynomial, METH_VARARGS,
    "Defines the k-th polynomial in the systems container for polynomials\n with coefficients in arbitrary multiprecision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are five input parameters, four integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) dp, the number of decimal places to parse the coefficients;\n 5) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_load_standard_polynomial",
     py2c_syscon_load_standard_polynomial, METH_VARARGS,
    "Returns the k-th polynomial in the systems container\n with standard double complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_load_dobldobl_polynomial",
     py2c_syscon_load_dobldobl_polynomial, METH_VARARGS,
    "Returns the k-th polynomial in the systems container\n with double double complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_load_quaddobl_polynomial",
     py2c_syscon_load_quaddobl_polynomial, METH_VARARGS,
    "Returns the k-th polynomial in the systems container\n with quad double complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_load_multprec_polynomial",
     py2c_syscon_load_multprec_polynomial, METH_VARARGS,
    "Returns the k-th polynomial in the systems container\n with arbitrary multiprecision complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_store_standard_Laurential",
     py2c_syscon_store_standard_Laurential, METH_VARARGS,
    "Defines the k-th polynomial in the systems container for Laurent\n polynomials with coefficients in standard double precision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are four input parameters, three integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_store_dobldobl_Laurential",
     py2c_syscon_store_dobldobl_Laurential, METH_VARARGS,
    "Defines the k-th polynomial in the systems container for Laurent\n polynomials with coefficients in double double precision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are four input parameters, three integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_store_quaddobl_Laurential",
     py2c_syscon_store_quaddobl_Laurential, METH_VARARGS,
    "Defines the k-th polynomial in the systems container for Laurent\n polynomials with coefficients in quad double precision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are four input parameters, three integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_store_multprec_Laurential",
     py2c_syscon_store_multprec_Laurential, METH_VARARGS,
    "Defines the k-th polynomial in the systems container for Laurent\n polynomials with coefficients in arbitrary multiprecision.\n As a precondition for this function, the container must be initialized\n for sufficiently many polynomials, in any case >= k.\n There are five input parameters, four integers and one string:\n 1) nc, the number of characters in the string p;\n 2) n, the number of variables in the multivariate polynomial;\n 3) k, the index of the polynomial in the system;\n 4) dp, the number of decimal places to parse the coefficients;\n 5) p, a valid string representation for a polynomial.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_syscon_load_standard_Laurential",
     py2c_syscon_load_standard_Laurential, METH_VARARGS,
    "Returns the k-th polynomial in the Laurent systems container\n with standard double complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_load_dobldobl_Laurential",
     py2c_syscon_load_dobldobl_Laurential, METH_VARARGS,
    "Returns the k-th polynomial in the Laurent systems container\n with double double complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_load_quaddobl_Laurential",
     py2c_syscon_load_quaddobl_Laurential, METH_VARARGS,
    "Returns the k-th polynomial in the Laurent systems container\n with quad double complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_load_multprec_Laurential",
     py2c_syscon_load_multprec_Laurential, METH_VARARGS,
    "Returns the k-th polynomial in the Laurent systems container\n with arbitrary multiprecision complex coefficients as a string.\n The value for k is in the one integer parameter of this function."},
   {"py2c_syscon_total_degree", py2c_syscon_total_degree, METH_VARARGS,
    "Returns in d the total degree of the system with coefficients in\n standard double precision, as stored in the container."},
   {"py2c_syscon_standard_drop_variable_by_index",
     py2c_syscon_standard_drop_variable_by_index, METH_VARARGS,
    "Replaces the system in the standard double precision container\n with the same system that has its k-th variable dropped.\n The index k of the vaiable is given as an input parameter.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_syscon_standard_drop_variable_by_name",
     py2c_syscon_standard_drop_variable_by_name, METH_VARARGS,
    "Replaces the system in the standard double precision container\n with the same system that have that variable dropped\n corresponding to the name in the string s of nc characters long.\n The function has two input parameters, an integer and a string:\n 1) nc, the number of characters in the string with the name;\n 2) s, a string that holds the name of the variable.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_syscon_dobldobl_drop_variable_by_index",
     py2c_syscon_dobldobl_drop_variable_by_index, METH_VARARGS,
    "Replaces the system in the double double precision container\n with the same system that has its k-th variable dropped.\n The index k of the vaiable is given as an input parameter.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_syscon_dobldobl_drop_variable_by_name",
     py2c_syscon_dobldobl_drop_variable_by_name, METH_VARARGS,
    "Replaces the system in the double double precision container\n with the same system that have that variable dropped\n corresponding to the name in the string s of nc characters long.\n The function has two input parameters, an integer and a string:\n 1) nc, the number of characters in the string with the name;\n 2) s, a string that holds the name of the variable.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_syscon_quaddobl_drop_variable_by_index",
     py2c_syscon_quaddobl_drop_variable_by_index, METH_VARARGS,
    "Replaces the system in the quad double precision container\n with the same system that has its k-th variable dropped.\n The index k of the vaiable is given as an input parameter.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_syscon_quaddobl_drop_variable_by_name",
     py2c_syscon_quaddobl_drop_variable_by_name, METH_VARARGS,
    "Replaces the system in the quad double precision container\n with the same system that have that variable dropped\n corresponding to the name in the string s of nc characters long.\n The function has two input parameters, an integer and a string:\n 1) nc, the number of characters in the string with the name;\n 2) s, a string that holds the name of the variable.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_length_standard_solution_string",
     py2c_solcon_length_standard_solution_string,
     METH_VARARGS,
    "On input is the index k to a solution in standard double precision,\n stored in the container.  On return is the length of the string\n representation for that k-th solution in the container."},
   {"py2c_solcon_length_dobldobl_solution_string",
     py2c_solcon_length_dobldobl_solution_string, METH_VARARGS,
    "On input is the index k to a solution in double double precision,\n stored in the container.  On return is the length of the string\n representation for that k-th solution in the container."},
   {"py2c_solcon_length_quaddobl_solution_string",
     py2c_solcon_length_quaddobl_solution_string, METH_VARARGS,
    "On input is the index k to a solution in quad double precision,\n stored in the container.  On return is the length of the string\n representation for that k-th solution in the container."},
   {"py2c_solcon_length_multprec_solution_string",
     py2c_solcon_length_multprec_solution_string, METH_VARARGS,
    "On input is the index k to a solution in arbitrary multiprecision,\n stored in the container.  On return is the length of the string\n representation for that k-th solution in the container."},
   {"py2c_solcon_write_standard_solution_string",
     py2c_solcon_write_standard_solution_string,
     METH_VARARGS,
    "Returns the string representation for the k-th solution stored\n in standard double precision in the container.\n On input are two integers:\n 1) the index to the solution; and\n 2) the number of characters in the string representation\n for that solution."},
   {"py2c_solcon_write_dobldobl_solution_string",
     py2c_solcon_write_dobldobl_solution_string, METH_VARARGS,
    "Returns the string representation for the k-th solution stored\n in double double precision in the container.\n On input are two integers:\n 1) the index to the solution; and\n 2) the number of characters in the string representation\n for that solution."},
   {"py2c_solcon_write_quaddobl_solution_string",
     py2c_solcon_write_quaddobl_solution_string, METH_VARARGS, 
    "Returns the string representation for the k-th solution stored\n in quad double precision in the container.\n On input are two integers:\n 1) the index to the solution; and\n 2) the number of characters in the string representation\n for that solution."},
   {"py2c_solcon_write_multprec_solution_string",
     py2c_solcon_write_multprec_solution_string, METH_VARARGS,
    "Returns the string representation for the k-th solution stored\n in arbitrary multiprecision in the container.\n On input are two integers:\n 1) the index to the solution; and\n 2) the number of characters in the string representation\n for that solution."},
   {"py2c_solcon_retrieve_next_standard_initialize",
     py2c_solcon_retrieve_next_standard_initialize, METH_VARARGS,
    "Resets the pointer to the current standard solution in the container\n to the first solution in the list.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_retrieve_next_dobldobl_initialize",
     py2c_solcon_retrieve_next_dobldobl_initialize, METH_VARARGS,
    "Resets the pointer to the current dobldobl solution in the container\n to the first solution in the list.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_retrieve_next_quaddobl_initialize",
     py2c_solcon_retrieve_next_quaddobl_initialize, METH_VARARGS,
    "Resets the pointer to the current quaddobl solution in the container\n to the first solution in the list.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_retrieve_next_multprec_initialize",
     py2c_solcon_retrieve_next_multprec_initialize, METH_VARARGS,
    "Resets the pointer to the current multprec solution in the container\n to the first solution in the list.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_move_current_standard_to_next",
     py2c_solcon_move_current_standard_to_next, METH_VARARGS,
    "Moves the pointer to the current solution in standard double precision\n to the next solution and returns the value of the cursor.\n If cursor on return is zero, then either the pointer was null\n or there is no next solution."},
   {"py2c_solcon_move_current_dobldobl_to_next",
     py2c_solcon_move_current_dobldobl_to_next, METH_VARARGS,
    "Moves the pointer to the current solution in double double precision\n to the next solution and returns the value of the cursor.\n If cursor on return is zero, then either the pointer was null\n or there is no next solution."},
   {"py2c_solcon_move_current_quaddobl_to_next",
     py2c_solcon_move_current_quaddobl_to_next, METH_VARARGS,
    "Moves the pointer to the current solution in quad double precision\n to the next solution and returns the value of the cursor.\n If cursor on return is zero, then either the pointer was null\n or there is no next solution."},
   {"py2c_solcon_move_current_multprec_to_next",
     py2c_solcon_move_current_multprec_to_next, METH_VARARGS,
    "Moves the pointer to the current solution in arbitrary multiprecision\n to the next solution and returns the value of the cursor.\n If cursor on return is zero, then either the pointer was null\n or there is no next solution."},
   {"py2c_solcon_length_current_standard_solution_string",
     py2c_solcon_length_current_standard_solution_string, METH_VARARGS,
    "Returns the number of characters in the string representation\n of the current standard double solution in the container,\n at the place indicated by the value of the cursor.\n If this value equals zero, then there is no current solution,\n and then the length on return equals zero."},
   {"py2c_solcon_length_current_dobldobl_solution_string",
     py2c_solcon_length_current_dobldobl_solution_string, METH_VARARGS,
    "Returns the number of characters in the string representation\n of the current double double solution in the container,\n at the place indicated by the value of the cursor.\n If this value equals zero, then there is no current solution,\n and then the length on return equals zero."},
   {"py2c_solcon_length_current_quaddobl_solution_string",
     py2c_solcon_length_current_quaddobl_solution_string, METH_VARARGS,
    "Returns the number of characters in the string representation\n of the current quad double solution in the container,\n at the place indicated by the value of the cursor.\n If this value equals zero, then there is no current solution,\n and then the length on return equals zero."},
   {"py2c_solcon_length_current_multprec_solution_string",
     py2c_solcon_length_current_multprec_solution_string, METH_VARARGS,
    "Returns the number of characters in the string representation\n of the current arbitrary multiprecision solution in the container,\n at the place indicated by the value of the cursor.\n If this value equals zero, then there is no current solution,\n and then the length on return equals zero."},
   {"py2c_solcon_write_current_standard_solution_string",
     py2c_solcon_write_current_standard_solution_string, METH_VARARGS,
    "Writes the current standard double solution in the solution container\n to the string s of n+1 characters.\n The last character is the end of string symbol.\n The value of n is given as the one input parameter to this function.\n On return is the string that contains the string representation of\n the current solution in standard double precision in the container."},
   {"py2c_solcon_write_current_dobldobl_solution_string",
     py2c_solcon_write_current_dobldobl_solution_string, METH_VARARGS,
    "Writes the current double double solution in the solution container\n to the string s of n+1 characters.\n The last character is the end of string symbol.\n The value of n is given as the one input parameter to this function.\n On return is the string that contains the string representation of\n the current solution in standard double precision in the container."},
   {"py2c_solcon_write_current_quaddobl_solution_string",
     py2c_solcon_write_current_quaddobl_solution_string, METH_VARARGS,
    "Writes the current quad double solution in the solution container\n to the string s of n+1 characters.\n The last character is the end of string symbol.\n The value of n is given as the one input parameter to this function.\n On return is the string that contains the string representation of\n the current solution in standard double precision in the container."},
   {"py2c_solcon_write_current_multprec_solution_string",
     py2c_solcon_write_current_multprec_solution_string, METH_VARARGS,
    "Writes the current arbitrary multiprecision solution in the solution container\n to the string s of n+1 characters.\n The last character is the end of string symbol.\n The value of n is given as the one input parameter to this function.\n On return is the string that contains the string representation of\n the current solution in standard double precision in the container."},
   {"py2c_solcon_append_standard_solution_string",
     py2c_solcon_append_standard_solution_string,
     METH_VARARGS, 
    "Appends a solution in standard double precision to the list\n of solutions already stored in the container.\n There are three input parameters:\n 1) the number of variables;\n 2) the number of characters in the string;\n 3) the string representing the solution to append to the list.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_solcon_append_dobldobl_solution_string",
     py2c_solcon_append_dobldobl_solution_string, METH_VARARGS,
    "Appends a solution in double double precision to the list\n of solutions already stored in the container.\n There are three input parameters:\n 1) the number of variables;\n 2) the number of characters in the string;\n 3) the string representing the solution to append to the list.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_solcon_append_quaddobl_solution_string",
     py2c_solcon_append_quaddobl_solution_string, METH_VARARGS,
    "Appends a solution in quad double precision to the list\n of solutions already stored in the container.\n There are three input parameters:\n 1) the number of variables;\n 2) the number of characters in the string;\n 3) the string representing the solution to append to the list.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_solcon_append_multprec_solution_string",
     py2c_solcon_append_multprec_solution_string, METH_VARARGS,
    "Appends a solution in arbitrary multiprecision to the list\n of solutions already stored in the container.\n There are three input parameters:\n 1) the number of variables;\n 2) the number of characters in the string;\n 3) the string representing the solution to append to the list.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_solcon_number_of_standard_solutions",
     py2c_solcon_number_of_standard_solutions, METH_VARARGS,
    "Returns the number of solutions in standard double precision,\n as stored in the container."},
   {"py2c_solcon_number_of_dobldobl_solutions",
     py2c_solcon_number_of_dobldobl_solutions, METH_VARARGS, 
    "Returns the number of solutions in double double precision,\n as stored in the container."},
   {"py2c_solcon_number_of_quaddobl_solutions",
     py2c_solcon_number_of_quaddobl_solutions, METH_VARARGS, 
    "Returns the number of solutions in quad double precision,\n as stored in the container."},
   {"py2c_solcon_number_of_multprec_solutions",
     py2c_solcon_number_of_multprec_solutions, METH_VARARGS, 
    "Returns the number of solutions in arbitrary multiprecision,\n as stored in the container."},
   {"py2c_solcon_standard_drop_coordinate_by_index",
     py2c_solcon_standard_drop_coordinate_by_index, METH_VARARGS,
    "Replaces the solutions in the standard double precision container\n with the same solutions that have their k-th coordinate dropped.\n There is one input parameter: the index k of the coordinate.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_standard_drop_coordinate_by_name",
     py2c_solcon_standard_drop_coordinate_by_name, METH_VARARGS,
    "Replaces the solutions in the standard double precision container\n with the same solutions that have their coordinate dropped\n corresponding to the name in the string s of nc characters long.\n There are two input parameters, an integer and a string:\n 1) nc, the number of characters in the string with the name;\n 2) s, the string with the name of the variable.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_dobldobl_drop_coordinate_by_index",
     py2c_solcon_dobldobl_drop_coordinate_by_index, METH_VARARGS,
    "Replaces the solutions in the double double precision container\n with the same solutions that have their k-th coordinate dropped.\n There is one input parameter: the index k of the coordinate.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_dobldobl_drop_coordinate_by_name",
     py2c_solcon_dobldobl_drop_coordinate_by_name, METH_VARARGS,
    "Replaces the solutions in the double double precision container\n with the same solutions that have their coordinate dropped\n corresponding to the name in the string s of nc characters long.\n There are two input parameters, an integer and a string:\n 1) nc, the number of characters in the string with the name;\n 2) s, the string with the name of the variable.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_quaddobl_drop_coordinate_by_index",
     py2c_solcon_quaddobl_drop_coordinate_by_index, METH_VARARGS,
    "Replaces the solutions in the quad double precision container\n with the same solutions that have their k-th coordinate dropped.\n There is one input parameter: the index k of the coordinate.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_solcon_quaddobl_drop_coordinate_by_name",
     py2c_solcon_quaddobl_drop_coordinate_by_name, METH_VARARGS,
    "Replaces the solutions in the quad double precision container\n with the same solutions that have their coordinate dropped\n corresponding to the name in the string s of nc characters long.\n There are two input parameters, an integer and a string:\n 1) nc, the number of characters in the string with the name;\n 2) s, the string with the name of the variable.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_product_supporting_set_structure",
     py2c_product_supporting_set_structure, METH_VARARGS,
    "Builds a supporting set structure for the system stored in the\n container with coefficients in standard double precision."},
   {"py2c_product_write_set_structure", py2c_product_write_set_structure,
     METH_VARARGS, 
    "Writes the supporting set structure to screen."},
   {"py2c_product_set_structure_string", py2c_product_set_structure_string,
     METH_VARARGS,
    "Returns the string representation of the set structure."},
   {"py2c_product_parse_set_structure", py2c_product_parse_set_structure,
     METH_VARARGS, 
    "Parses a given string into a set structure.\n On input are two parameters, one integer and one string:\n 1) the number of characters in the given string; and\n 2) the characters in the string.\n On return is the failure code, if zero, then the string\n has been parsed into a valid set structure."},
   {"py2c_product_is_set_structure_supporting",
     py2c_product_is_set_structure_supporting, METH_VARARGS,
    "Checks whether the stored set structure is supporting\n for the system in the standard systems container.\n Returns an integer which represents true (1) or false (0)."},
   {"py2c_product_linear_product_root_count",
     py2c_product_linear_product_root_count, METH_VARARGS,
    "Returns the linear-product root count, computed from\n the supporting set structure."},
   {"py2c_product_random_linear_product_system",
     py2c_product_random_linear_product_system, METH_VARARGS, 
    "Builds a random linear-product system based on the\n stored set structure.   On return is the failure code,\n which equals zero if all went well."},
   {"py2c_product_solve_linear_product_system",
     py2c_product_solve_linear_product_system, METH_VARARGS,
    "Computes all solutions to the linear-product system\n and stores the solutions in the container for solutions\n in standard double precision.  On return is the failure\n code, which equals zero if all went well."},
   {"py2c_product_clear_set_structure", py2c_product_clear_set_structure,
     METH_VARARGS,
    "Deallocates the set structure."},
   {"py2c_product_m_homogeneous_Bezout_number",
     py2c_product_m_homogeneous_Bezout_number, METH_VARARGS,
    "For the system in the standard systems container,\n a heuristic partition of the set of variables may\n lead to a Bezout number that is smaller than the total degree.\n On return is the m-homogeneous Bezout number for the\n string representation of the partition that is returned\n as the second argument in the tuple."},
   {"py2c_product_m_partition_Bezout_number",
     py2c_product_m_partition_Bezout_number, METH_VARARGS,
    "Given a partition of the set of variables, computes\n the m-homogeneous Bezout number for the system in\n the standard systems container.\n On input are two arguments:\n 1) the number of characters in the string (second argument); and\n 2) the string representation for a partition of the variables.\n On return is the m-homogeneous Bezout number."},
   {"py2c_product_m_homogeneous_start_system",
     py2c_product_m_homogeneous_start_system, METH_VARARGS,
    "Given a partition of the set of variables, constructs\n an m-homogeneous Bezout number for the system in\n the standard systems container.\n On input are two arguments:\n 1) the number of characters in the string (second argument); and\n 2) the string representation for a partition of the variables.\n On return is the m-homogeneous Bezout number."},
   {"py2c_celcon_initialize_supports",
     py2c_celcon_initialize_supports, METH_VARARGS,
    "Initializes the cell container with the number of distinct supports,\n this number is given as the one input parameter.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_celcon_set_type_of_mixture",
     py2c_celcon_set_type_of_mixture, METH_VARARGS,
    "Defines the type of mixture of the support sets.\n On input are two parameters, an integer and a string:\n 1) the integer equals the number of distinct supports;\n 2) the string is a string representation of a Python list of integers,\n there are as many integers as the value of the first parameter.\n Each integer is a positive number, equal to the number of occurrences\n of each support set."},
   {"py2c_celcon_type_of_mixture",
     py2c_celcon_type_of_mixture, METH_VARARGS,
    "Returns the string representation of the type of mixture of the support sets.\n This string is the string representation of a Python list of integers."},
   {"py2c_celcon_append_lifted_point",
     py2c_celcon_append_lifted_point, METH_VARARGS,
    "Appends a lifted point to the cells container.\n There are three input parameters:\n 1) the dimension of the point;\n 2) the index of the support to where to append to; and\n 3) the string representation of the lifted point.\n Returns the failure code, which equals zero when all went well."},
   {"py2c_celcon_retrieve_lifted_point",
     py2c_celcon_retrieve_lifted_point, METH_VARARGS,
    "Returns a string representation of a lifted point.\n On input are three integer numbers:\n 1) the number of coordinates in the lifted point;\n 2) the index to the support set; and\n 3) the index to the point in that support set."},
   {"py2c_celcon_mixed_volume_of_supports",
     py2c_celcon_mixed_volume_of_supports, METH_VARARGS,
    "Returns the mixed volume of the supports stored in the cell container."},
   {"py2c_celcon_number_of_cells", py2c_celcon_number_of_cells,
    METH_VARARGS, "returns the number of cells in the cell container"},
   {"py2c_celcon_standard_random_coefficient_system",
     py2c_celcon_standard_random_coefficient_system, METH_VARARGS,
    "Based on the lifted supports stored in the container,\n a random coefficient system with coefficients in standard double\n precision is stored in the cell container."},
   {"py2c_celcon_dobldobl_random_coefficient_system",
     py2c_celcon_dobldobl_random_coefficient_system, METH_VARARGS,
    "Based on the lifted supports stored in the container,\n a random coefficient system with coefficients in double double\n precision is stored in the cell container."},
   {"py2c_celcon_quaddobl_random_coefficient_system",
     py2c_celcon_quaddobl_random_coefficient_system, METH_VARARGS,
    "Based on the lifted supports stored in the container,\n a random coefficient system with coefficients in quad double\n precision is stored in the cell container."},
   {"py2c_celcon_copy_into_standard_systems_container",
     py2c_celcon_copy_into_standard_systems_container, METH_VARARGS,
    "The random coefficient system in standard double precision is copied\n from the cell container to the container for systems with\n coefficients in standard double precision."},
   {"py2c_celcon_copy_into_dobldobl_systems_container",
     py2c_celcon_copy_into_dobldobl_systems_container, METH_VARARGS,
    "The random coefficient system in double double precision is copied\n from the cell container to the container for systems with\n coefficients in double double precision."},
   {"py2c_celcon_copy_into_quaddobl_systems_container",
     py2c_celcon_copy_into_quaddobl_systems_container, METH_VARARGS,
    "The random coefficient system in quad double precision is copied\n from the cell container to the container for systems with\n coefficients in quad double precision."},
   {"py2c_celcon_standard_polyhedral_homotopy",
     py2c_celcon_standard_polyhedral_homotopy, METH_VARARGS, 
    "Based on the lifting and the random coefficient system,\n the polyhedral homotopy to solve the random coefficient system\n in standard double precision is constructed.\n This function also initializes the internal data structures to store\n the solutions of start and target systems.\n The lifted supports and the random coefficient system are defined.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_celcon_dobldobl_polyhedral_homotopy",
     py2c_celcon_dobldobl_polyhedral_homotopy, METH_VARARGS, 
    "Based on the lifting and the random coefficient system,\n the polyhedral homotopy to solve the random coefficient system\n in double double precision is constructed.\n This function also initializes the internal data structures to store\n the solutions of start and target systems.\n The lifted supports and the random coefficient system are defined.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_celcon_quaddobl_polyhedral_homotopy",
     py2c_celcon_quaddobl_polyhedral_homotopy, METH_VARARGS, 
    "Based on the lifting and the random coefficient system,\n the polyhedral homotopy to solve the random coefficient system\n in quad double precision is constructed.\n This function also initializes the internal data structures to store\n the solutions of start and target systems.\n The lifted supports and the random coefficient system are defined.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_celcon_solve_standard_start_system",
     py2c_celcon_solve_standard_start_system, METH_VARARGS, 
    "Solves the start system corresponding to the k-th mixed cell,\n using standard double precision arithmetic.\n The precondition for this function is that the creation of\n the polyhedral homotopy in standard double precision ended well.\n On return is the number of solution found, which must equal\n the mixed volume of the k-th mixed cell."},
   {"py2c_celcon_solve_dobldobl_start_system",
     py2c_celcon_solve_dobldobl_start_system, METH_VARARGS, 
    "Solves the start system corresponding to the k-th mixed cell,\n using double double precision arithmetic.\n The precondition for this function is that the creation of\n the polyhedral homotopy in double double precision ended well.\n On return is the number of solution found, which must equal\n the mixed volume of the k-th mixed cell."},
   {"py2c_celcon_solve_quaddobl_start_system",
     py2c_celcon_solve_quaddobl_start_system, METH_VARARGS, 
    "Solves the start system corresponding to the k-th mixed cell,\n using quad double precision arithmetic.\n The precondition for this function is that the creation of\n the polyhedral homotopy in quad double precision ended well.\n On return is the number of solution found, which must equal\n the mixed volume of the k-th mixed cell."},
   {"py2c_celcon_track_standard_solution_path",
     py2c_celcon_track_standard_solution_path, METH_VARARGS, 
    "Tracks a solution path starting at the i-th solution of the k-th cell,\n using standard double precision arithmetic.\n The precondition for this function is that the start system defined\n by the k-th mixed cell is solved in standard double precision.\n There are three input parameters:\n 1) k, the index to a mixed cell in the cell container;\n 2) i, the index to a solution path defined by that mixed cell;\n 3) otp, the level for intermediate output during path tracking.\n A target solution corresponding to the k-th cell is added on return."},
   {"py2c_celcon_track_dobldobl_solution_path",
     py2c_celcon_track_dobldobl_solution_path, METH_VARARGS, 
    "Tracks a solution path starting at the i-th solution of the k-th cell,\n using double double precision arithmetic.\n The precondition for this function is that the start system defined\n by the k-th mixed cell is solved in double double precision.\n There are three input parameters:\n 1) k, the index to a mixed cell in the cell container;\n 2) i, the index to a solution path defined by that mixed cell;\n 3) otp, the level for intermediate output during path tracking.\n A target solution corresponding to the k-th cell is added on return."},
   {"py2c_celcon_track_quaddobl_solution_path",
     py2c_celcon_track_quaddobl_solution_path, METH_VARARGS, 
    "Tracks a solution path starting at the i-th solution of the k-th cell,\n using quad double precision arithmetic.\n The precondition for this function is that the start system defined\n by the k-th mixed cell is solved in quad double precision.\n There are three input parameters:\n 1) k, the index to a mixed cell in the cell container;\n 2) i, the index to a solution path defined by that mixed cell;\n 3) otp, the level for intermediate output during path tracking.\n A target solution corresponding to the k-th cell is added on return."},
   {"py2c_celcon_copy_target_standard_solution_to_container",
     py2c_celcon_copy_target_standard_solution_to_container, METH_VARARGS, 
    "Copies the i-th target solution corresponding to the k-th mixed cell\n to the container for solutions in standard double precision.\n There are two input parameters for this function:\n 1) k, the index to the mixed cell;\n 2) i, the index to the i-th solution path defined by the cell.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_celcon_copy_target_dobldobl_solution_to_container",
     py2c_celcon_copy_target_dobldobl_solution_to_container, METH_VARARGS, 
    "Copies the i-th target solution corresponding to the k-th mixed cell\n to the container for solutions in double double precision.\n There are two input parameters for this function:\n 1) k, the index to the mixed cell;\n 2) i, the index to the i-th solution path defined by the cell.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_celcon_copy_target_quaddobl_solution_to_container",
     py2c_celcon_copy_target_quaddobl_solution_to_container, METH_VARARGS, 
    "Copies the i-th target solution corresponding to the k-th mixed cell\n to the container for solutions in quad double precision.\n There are two input parameters for this function:\n 1) k, the index to the mixed cell;\n 2) i, the index to the i-th solution path defined by the cell.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_celcon_permute_standard_system",
     py2c_celcon_permute_standard_system, METH_VARARGS,
    "Permutes the systems in the container for polynomial and Laurent systems\n with standard double coefficients corresponding to the permutation\n used to compute the mixed-cell configuration.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_celcon_permute_dobldobl_system",
     py2c_celcon_permute_dobldobl_system, METH_VARARGS,
    "Permutes the systems in the container for polynomial and Laurent systems\n with double double coefficients corresponding to the permutation\n used to compute the mixed-cell configuration.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_celcon_permute_quaddobl_system",
     py2c_celcon_permute_quaddobl_system, METH_VARARGS,
    "Permutes the systems in the container for polynomial and Laurent systems\n with quad double coefficients corresponding to the permutation\n used to compute the mixed-cell configuration.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_celcon_clear_container", py2c_celcon_clear_container, METH_VARARGS,
    "Deallocates the data in the cell container."},
   {"py2c_scale_standard_system", py2c_scale_standard_system, METH_VARARGS,
    "Applies scaling to the system in the standard systems container,\n with standard double precision arithmetic.  The system in the standard\n systems container is replaced by the scaled system.\n On entry is one integer, which should be either 0, 1, or 2:\n 0 for only scaling of the equations,\n 1 variable scaling without variability reduction,\n 2 variable scaling with variability reduction.\n On return is a tuple with the scaling coefficients (if mode > 0)\n and the estimated inverse condition number of the scaling problem."},
   {"py2c_scale_dobldobl_system", py2c_scale_dobldobl_system, METH_VARARGS,
    "Applies scaling to the system in the dobldobl systems container,\n with double double precision arithmetic.  The system in the dobldobl\n systems container is replaced by the scaled system.\n On entry is one integer, which should be either 0, 1, or 2:\n 0 for only scaling of the equations,\n 1 variable scaling without variability reduction,\n 2 variable scaling with variability reduction.\n On return is a tuple with the scaling coefficients (if mode > 0)\n and the estimated inverse condition number of the scaling problem."},
   {"py2c_scale_quaddobl_system", py2c_scale_quaddobl_system, METH_VARARGS,
    "Applies scaling to the system in the quaddobl systems container,\n with quad double precision arithmetic.  The system in the quaddobl\n systems container is replaced by the scaled system.\n On entry is one integer, which should be either 0, 1, or 2:\n 0 for only scaling of the equations,\n 1 variable scaling without variability reduction,\n 2 variable scaling with variability reduction.\n On return is a tuple with the scaling coefficients (if mode > 0)\n and the estimated inverse condition number of the scaling problem."},
   {"py2c_scale_standard_solutions",
     py2c_scale_standard_solutions, METH_VARARGS,
    "Replaces the solutions in the standard solutions container with\n the scaled solutions, scaled with standard double precision arithmetic,\n using the given scaling coefficients.\n On entry are two parameters: an integer and a string.\n The integer contains the number of elements in the list\n of scaling coefficients (doubles) stored in the string.\n The format of the string is the Python string representation\n of a list of doubles, i.e.: starting with [ and ending with ]."},
   {"py2c_scale_dobldobl_solutions",
     py2c_scale_dobldobl_solutions, METH_VARARGS,
    "Replaces the solutions in the dobldobl solutions container with\n the scaled solutions, scaled with double double precision arithmetic,\n using the given scaling coefficients.\n On entry are two parameters: an integer and a string.\n The integer contains the number of elements in the list\n of scaling coefficients (doubles) stored in the string.\n The format of the string is the Python string representation\n of a list of doubles, i.e.: starting with [ and ending with ]."},
   {"py2c_scale_quaddobl_solutions",
     py2c_scale_quaddobl_solutions, METH_VARARGS,
    "Replaces the solutions in the quaddobl solutions container with\n the scaled solutions, scaled with quad double precision arithmetic,\n using the given scaling coefficients.\n On entry are two parameters: an integer and a string.\n The integer contains the number of elements in the list\n of scaling coefficients (doubles) stored in the string.\n The format of the string is the Python string representation\n of a list of doubles, i.e.: starting with [ and ending with ]."},
   {"py2c_sweep_define_parameters_numerically",
     py2c_sweep_define_parameters_numerically, METH_VARARGS,
    "Defines the indices to the variables that serve as parameters\n numerically, that is: via integer indices.\n On entry are three integer numbers and a string.\n The string is a string representation of a Python list of integers,\n The three integers are the number of equations, the number of variables,\n and the number of parameters.  The number of variables m includes the\n number of parameters.  Then there should be as many as m indices in\n the list of integers to define which of the variables are parameters."},
   {"py2c_sweep_define_parameters_symbolically",
     py2c_sweep_define_parameters_symbolically, METH_VARARGS,
    "Defines the indices to the variables that serve as parameters\n symbolically, that is, as names of variables.\n For this to work, the symbol table must be initialized.\n On entry are four integer numbers and a string.\n The four integers are the number of equations, the number of variables,\n the number of parameters (the number of variables m includes the\n number of parameters), and the number of characters in the string.\n The string contains the names of the parameters, separated by one comma.\n For this to work, the symbol table must be initialized, e.g.:\n via the reading of a polynomial system."},
   {"py2c_sweep_get_number_of_equations",
     py2c_sweep_get_number_of_equations, METH_VARARGS,
    "Returns the number of equations in the sweep homotopy."},
   {"py2c_sweep_get_number_of_variables",
     py2c_sweep_get_number_of_variables, METH_VARARGS,
    "Returns the number of variables in the sweep homotopy."},
   {"py2c_sweep_get_number_of_parameters",
     py2c_sweep_get_number_of_parameters, METH_VARARGS,
    "Returns the number of parameters in the sweep homotopy."},
   {"py2c_sweep_get_indices_numerically",
     py2c_sweep_get_indices_numerically, METH_VARARGS,
    "Returns the indices of the variables that are parameters,\n as the string representation of a Python list of integers."},
   {"py2c_sweep_get_indices_symbolically",
     py2c_sweep_get_indices_symbolically, METH_VARARGS,
    "Returns a string with the names of the parameters,\n each separated by one space."},
   {"py2c_sweep_clear_definitions",
     py2c_sweep_clear_definitions, METH_VARARGS,
    "Clears the definitions in the sweep homotopy."},
   {"py2c_sweep_set_standard_start",
     py2c_sweep_set_standard_start, METH_VARARGS,
    "Sets the start values for the m parameters in standard double precision,\n giving on input an integer m and 2*m doubles, with the consecutive\n real and imaginary parts for the start values of all m parameters.\n The doubles are given in a string representation of a Python\n list of doubles."},
   {"py2c_sweep_set_standard_target",
     py2c_sweep_set_standard_target, METH_VARARGS,
    "Sets the target values for the m parameters in standard double precision,\n giving on input an integer m and 2*m doubles, with the consecutive\n real and imaginary parts for the target values of all m parameters."},
   {"py2c_sweep_set_dobldobl_start",
     py2c_sweep_set_dobldobl_start, METH_VARARGS,
    "Sets the start values for the m parameters in double double precision,\n giving on input an integer m and 4*m doubles, with the consecutive\n real and imaginary parts for the start values of all m parameters."},
   {"py2c_sweep_set_dobldobl_target",
     py2c_sweep_set_dobldobl_target, METH_VARARGS,
    "Sets the target values for the m parameters in double double precision,\n giving on input an integer m and 4*m doubles, with the consecutive\n real and imaginary parts for the target values of all m parameters."},
   {"py2c_sweep_set_quaddobl_start",
     py2c_sweep_set_quaddobl_start, METH_VARARGS,
    "Sets the start values for the m parameters in quad double precision,\n giving on input an integer m and 8*m doubles, with the consecutive\n real and imaginary parts for the start values of all m parameters."},
   {"py2c_sweep_set_quaddobl_target",
     py2c_sweep_set_quaddobl_target, METH_VARARGS,
    "Sets the target values for the m parameters in quad double precision,\n giving on input an integer m and 8*m doubles, with the consecutive\n real and imaginary parts for the target values of all m parameters."},
   {"py2c_sweep_get_standard_start",
     py2c_sweep_get_standard_start, METH_VARARGS,
    "Gets the start values for the parameters in standard double precision,\n giving on input the number n of doubles that need to be returned.\n On return will be n doubles, for the consecutive real and imaginary\n parts for the start values of all parameters,\n stored in the string representation of a Python list of doubles."},
   {"py2c_sweep_get_standard_target",
     py2c_sweep_get_standard_target, METH_VARARGS,
    "Gets the target values for the parameters in standard double precision,\n giving on input the number n of doubles that need to be returned.\n On return will be n doubles, for the consecutive real and imaginary\n parts for the target values of all parameters,\n stored in the string representation of a Python list of doubles."},
   {"py2c_sweep_get_dobldobl_start",
     py2c_sweep_get_dobldobl_start, METH_VARARGS,
    "Gets the start values for the parameters in double double precision,\n giving on input the number n of doubles that need to be returned.\n On return will be n doubles, for the consecutive real and imaginary\n parts for the start values of all parameters,\n stored in the string representation of a Python list of doubles."},
   {"py2c_sweep_get_dobldobl_target",
     py2c_sweep_get_dobldobl_target, METH_VARARGS,
    "Gets the target values for the parameters in double double precision,\n giving on input the number n of doubles that need to be returned.\n On return will be n doubles, for the consecutive real and imaginary\n parts for the target values of all parameters,\n stored in the string representation of a Python list of doubles."},
   {"py2c_sweep_get_quaddobl_start",
     py2c_sweep_get_quaddobl_start, METH_VARARGS,
    "Gets the start values for the parameters in quad double precision,\n giving on input the number n of doubles that need to be returned.\n On return will be n doubles, for the consecutive real and imaginary\n parts for the start values of all parameters,\n stored in the string representation of a Python list of doubles."},
   {"py2c_sweep_get_quaddobl_target",
     py2c_sweep_get_quaddobl_target, METH_VARARGS,
    "Returns the target values for the parameters in quad double precision,\n giving on input the number n of doubles that need to be returned.\n On return will be n doubles, for the consecutive real and imaginary\n parts for the target values of all parameters,\n stored in the string representation of a Python list of doubles."},
   {"py2c_sweep_standard_complex_run",
     py2c_sweep_standard_complex_run, METH_VARARGS,
    "Starts the trackers in a complex convex parameter homotopy,\n in standard double precision, where the indices to the parameters,\n start and target values are already defined.  Moreover, the containers\n of systems and solutions in standard double precision have been\n initialized with a parametric systems and start solutions.\n The first input parameter is 0, 1, or 2, for respectively\n a randomly generated gamma (0), or no gamma (1), or a user given\n gamma with real and imaginary parts given in 2 pointers to doubles."},
   {"py2c_sweep_dobldobl_complex_run",
     py2c_sweep_dobldobl_complex_run, METH_VARARGS,
    "Starts the trackers in a complex convex parameter homotopy,\n in double double precision, where the indices to the parameters,\n start and target values are already defined.  Moreover, the containers\n of systems and solutions in double double precision have been\n initialized with a parametric systems and start solutions.\n The first input parameter is 0, 1, or 2, for respectively\n a randomly generated gamma (0), or no gamma (1), or a user given\n gamma with real and imaginary parts given in 2 pointers to doubles."},
   {"py2c_sweep_quaddobl_complex_run",
     py2c_sweep_quaddobl_complex_run, METH_VARARGS,
    "Starts the trackers in a complex convex parameter homotopy,\n in quad double precision, where the indices to the parameters,\n start and target values are already defined.  Moreover, the containers\n of systems and solutions in quad double precision have been\n initialized with a parametric systems and start solutions.\n The first input parameter is 0, 1, or 2, for respectively\n a randomly generated gamma (0), or no gamma (1), or a user given\n gamma with real and imaginary parts given in 2 pointers to doubles."},
   {"py2c_sweep_standard_real_run",
     py2c_sweep_standard_real_run, METH_VARARGS, 
    "There are no input arguments to this routine.\n Starts a sweep with a natural parameter in a family of n equations\n in n+1 variables, where the last variable is the artificial parameter s\n that moves the one natural parameter from a start to target value.\n The last equation is of the form (1-s)*(A - v[0]) + s*(A - v[1]),\n where A is the natural parameter, going from the start value v[0]\n to the target value v[1].\n This family must be stored in the systems container in standard double\n precision and the corresponding start solutions in the standard solutions\n container, where every solution has the value v[0] for the A variable.\n The sweep stops when s reaches the value v[1], or when a singularity\n is encountered on the path."},
   {"py2c_sweep_dobldobl_real_run",
     py2c_sweep_dobldobl_real_run, METH_VARARGS, 
    "There are no input arguments to this routine.\n Starts a sweep with a natural parameter in a family of n equations\n in n+1 variables, where the last variable is the artificial parameter s\n that moves the one natural parameter from a start to target value.\n The last equation is of the form (1-s)*(A - v[0]) + s*(A - v[1]),\n where A is the natural parameter, going from the start value v[0]\n to the target value v[1].\n This family must be stored in the systems container in double double\n precision and the corresponding start solutions in the dobldobl solutions\n container, where every solution has the value v[0] for the A variable.\n The sweep stops when s reaches the value v[1], or when a singularity\n is encountered on the path."},
   {"py2c_sweep_quaddobl_real_run",
     py2c_sweep_quaddobl_real_run, METH_VARARGS, 
    "There are no input arguments to this routine.\n Starts a sweep with a natural parameter in a family of n equations\n in n+1 variables, where the last variable is the artificial parameter s\n that moves the one natural parameter from a start to target value.\n The last equation is of the form (1-s)*(A - v[0]) + s*(A - v[1]),\n where A is the natural parameter, going from the start value v[0]\n to the target value v[1].\n This family must be stored in the systems container in quad double\n precision and the corresponding start solutions in the quaddobl solutions\n container, where every solution has the value v[0] for the A variable.\n The sweep stops when s reaches the value v[1], or when a singularity\n is encountered on the path."},
   {"py2c_numbtrop_standard_initialize",
     py2c_numbtrop_standard_initialize, METH_VARARGS,
    "Initializes the numerical tropisms container,\n in standard double precision.  The input parameters are\n nbt : number of tropisms;\n dim : length_of_each tropism;\n wnd : winding numbers, as many as nbt;\n dir : nbt*dim doubles with the coordinates of the tropisms;\n err : errors on the tropisms, as many doubles as the value of nbt.\n The numbers in wnd, dir, and err must be given in one string,\n as the string representation of a list of doubles.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_numbtrop_dobldobl_initialize",
     py2c_numbtrop_dobldobl_initialize, METH_VARARGS,
    "Initializes the numerical tropisms container,\n in double double precision.  The input parameters are\n nbt : number of tropisms;\n dim : length_of_each tropism;\n wnd : winding numbers, as many as nbt;\n dir : 2*nbt*dim doubles with the coordinates of the tropisms;\n err : errors on the tropisms, as many doubles as the value of 2*nbt.\n The numbers in wnd, dir, and err must be given in one string,\n as the string representation of a list of doubles.\n On return is the the failure code, which equals zero if all went well."},
   {"py2c_numbtrop_quaddobl_initialize",
     py2c_numbtrop_quaddobl_initialize, METH_VARARGS,
    "Initializes the numerical tropisms container,\n in quad double precision.  The input parameters are\n nbt : number of tropisms;\n dim : length_of_each tropism;\n wnd : winding numbers, as many as nbt;\n dir : 4*nbt*dim doubles with the coordinates of the tropisms;\n err : errors on the tropisms, as many doubles as the value of 4*nbt.\n The numbers in wnd, dir, and err must be given in one string,\n as the string representation of a list of doubles.\n On return is the the failure code, which equals zero if all went well."},
   {"py2c_numbtrop_standard_retrieve",
     py2c_numbtrop_standard_retrieve, METH_VARARGS,
    "Retrieves all tropisms stored in standard double precision.\n The input parameters are two integers:\n nbt : number of tropisms;\n dim : length_of_each tropism.\n On return are\n wnd : winding numbers, as many as nbt;\n dir : nbt*dim doubles with the coordinates of the tropisms;\n err : errors on the tropisms, as many doubles as the value of nbt.\n All numbers are returns in one string, as the string representation\n of a list of doubles.\n The failure code, which equals zero if all went well."},
   {"py2c_numbtrop_dobldobl_retrieve",
     py2c_numbtrop_dobldobl_retrieve, METH_VARARGS,
    "Retrieves all tropisms stored in double double precision.\n The input parameters are two integers:\n nbt : number of tropisms;\n dim : length_of_each tropism.\n On return are\n wnd : winding numbers, as many as nbt;\n dir : 2*nbt*dim doubles with the coordinates of the tropisms;\n err : errors on the tropisms, as many doubles as the value of 2*nbt.\n All numbers are returns in one string, as the string representation\n of a list of doubles.\n The failure code, which equals zero if all went well."},
   {"py2c_numbtrop_quaddobl_retrieve",
     py2c_numbtrop_quaddobl_retrieve, METH_VARARGS,
    "Retrieves all tropisms stored in quad double precision.\n The input parameters are two integers:\n nbt : number of tropisms;\n dim : length_of_each tropism.\n On return are\n wnd : winding numbers, as many as nbt;\n dir : 4*nbt*dim doubles with the coordinates of the tropisms;\n err : errors on the tropisms, as many doubles as the value of 4*nbt.\n All numbers are returns in one string, as the string representation\n of a list of doubles.\n The failure code, which equals zero if all went well."},
   {"py2c_numbtrop_standard_size", py2c_numbtrop_standard_size, METH_VARARGS,
    "Returns the number of tropisms, stored in standard double\n precision, in the numerical tropisms container."},
   {"py2c_numbtrop_dobldobl_size", py2c_numbtrop_dobldobl_size, METH_VARARGS,
    "Returns the number of tropisms, stored in double double\n precision, in the numerical tropisms container."},
   {"py2c_numbtrop_quaddobl_size", py2c_numbtrop_quaddobl_size, METH_VARARGS,
    "Returns the number of tropisms, stored in quad double\n precision, in the numerical tropisms container."},
   {"py2c_numbtrop_standard_dimension",
     py2c_numbtrop_standard_dimension, METH_VARARGS,
    "Returns the dimension of the tropisms, stored in standard double\n precision, in the numerical tropisms container."},
   {"py2c_numbtrop_dobldobl_dimension",
     py2c_numbtrop_dobldobl_dimension, METH_VARARGS,
    "Returns the dimension of the tropisms, stored in double double\n precision, in the numerical tropisms container."},
   {"py2c_numbtrop_quaddobl_dimension",
     py2c_numbtrop_quaddobl_dimension, METH_VARARGS,
    "Returns the dimension of the tropisms, stored in quad double\n precision, in the numerical tropisms container."},
   {"py2c_numbtrop_store_standard_tropism",
     py2c_numbtrop_store_standard_tropism, METH_VARARGS,
    "Stores a tropism given in standard double precision.\n The first three input parmeters are integers:\n dim : the length of the tropism vector;\n idx : the index of the tropism, indexing starts at one,\n and ends at nbt, what is returned by standard_size;\n wnd : estimated winding number;\n The other input parameters are of type double:\n dir : coordinates of the tropisms, as many as dim;\n err : the error on the tropism.\n All dim+1 doubles are given in one string,\n the string representation of a list of doubles."},
   {"py2c_numbtrop_store_dobldobl_tropism",
     py2c_numbtrop_store_dobldobl_tropism, METH_VARARGS,
    "Stores a tropism given in double double precision.\n The first three input parameters are integers:\n dim : the length of the tropism vector;\n idx : the index of the tropism, indexing starts at one,\n and ends at nbt, what is returned by dobldobl_size;\n wnd : estimated winding number;\n The other input parameters are of type double:\n dir : coordinates of the tropisms, as many as 2*dim;\n err : the error on the tropism, two doubles.\n All 2*dim+2 doubles are given in one string,\n the string representatin of a list of doubles."},
   {"py2c_numbtrop_store_quaddobl_tropism",
     py2c_numbtrop_store_quaddobl_tropism, METH_VARARGS,
    "Stores a tropism given in quad double precision.\n The first three input parameters are integers:\n dim : the length of the tropism vector;\n idx : the index of the tropism, indexing starts at one,\n and ends at nbt, what is returned by quaddobl_size;\n The other input parameters are of type double:\n wnd : estimated winding number;\n dir : coordinates of the tropisms, as many as 4*dim;\n err : the error on the tropism, four double\n All 4*dim+4 doubles are given in one string,\n the string representatin of a list of doubles."},
   {"py2c_numbtrop_standard_retrieve_tropism",
     py2c_numbtrop_standard_retrieve_tropism, METH_VARARGS,
    "Returns one tropism, stored in standard double precision.\n The input parameters are two integers:\n dim : the length of the tropism vector;\n idx : the index of the tropism, indexing starts at one,\n and ends at nbt, what is returned by numbtrop_standard_size.\n The first parameter on return is an integer:\n wnd : estimated winding number;\n The other output parameters are of type double:\n dir : coordinates of the tropisms, as many as dim;\n err : the error on the tropism.\n All dim+1 doubles are returned in one string,\n the string representation of a list of doubles."},
   {"py2c_numbtrop_dobldobl_retrieve_tropism",
     py2c_numbtrop_dobldobl_retrieve_tropism, METH_VARARGS,
    "Returns one tropism, stored in double double precision.\n The input parameters are two integers:\n dim : the length of the tropism vector;\n idx : the index of the tropism, indexing starts at one,\n and ends at nbt, what is returned by numbtrop_dobldobl_size.\n The first parameter on return is an integer:\n wnd : estimated winding number;\n The other output parameters are of type double:\n dir : coordinates of the tropisms, as many as 2*dim;\n err : the error on the tropism, two doubles.\n All 2*dim+2 doubles are returned in one string,\n the string representation of a list of doubles."},
   {"py2c_numbtrop_quaddobl_retrieve_tropism",
     py2c_numbtrop_quaddobl_retrieve_tropism, METH_VARARGS,
    "Returns one tropism, stored in quad double precision.\n The input parameters are two integers:\n dim : the length of the tropism vector;\n idx : the index of the tropism, indexing starts at one,\n and ends at nbt, what is returned by numbtrop_quaddobl_size.\n The first parameter on return is an integer:\n wnd : estimated winding number;\n The other output parameters are of type double:\n dir : coordinates of the tropisms, as many as 4*dim;\n err : the error on the tropism, four doubles.\n All 4*dim+4 doubles are returned in one string,\n the string representation of a list of doubles."},
   {"py2c_numbtrop_standard_clear", py2c_numbtrop_standard_clear, METH_VARARGS,
    "Deallocates the stored numerically computed tropisms,\n computed in standard double precision."},
   {"py2c_numbtrop_dobldobl_clear", py2c_numbtrop_dobldobl_clear, METH_VARARGS,
    "Deallocates the stored numerically computed tropisms,\n computed in double double precision."},
   {"py2c_numbtrop_quaddobl_clear", py2c_numbtrop_quaddobl_clear, METH_VARARGS,
    "Deallocates the stored numerically computed tropisms,\n computed in quad double precision."},
   {"py2c_embed_system", py2c_embed_system, METH_VARARGS,
    "Replaces the system in the container with its embedding of dimension d.\n The dimension d is given as the first integer parameter on input.\n The second integer parameter indicates the precision, either 0, 1, or 2,\n respectively for double, double double, or quad double precision.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_embed_standard_system", py2c_embed_standard_system, METH_VARARGS,
    "Replaces the system with coefficients in standard double precision\n in the container with its embedding of dimension d.\n The dimension d is given as an integer parameter on input.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_embed_dobldobl_system", py2c_embed_dobldobl_system, METH_VARARGS,
    "Replaces the system with coefficients in double double precision\n in the container with its embedding of dimension d.\n The dimension d is given as an integer parameter on input.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_embed_quaddobl_system", py2c_embed_quaddobl_system, METH_VARARGS,
    "Replaces the system with coefficients in quad double precision\n in the container with its embedding of dimension d.\n The dimension d is given as an integer parameter on input.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_standard_cascade_homotopy", py2c_standard_cascade_homotopy,
     METH_VARARGS,
    "Creates a homotopy in standard double precision using the stored\n systems to go one level down the cascade, removing one slice.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_dobldobl_cascade_homotopy", py2c_dobldobl_cascade_homotopy,
     METH_VARARGS,
    "Creates a homotopy in double double precision using the stored\n systems to go one level down the cascade, removing one slice.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_quaddobl_cascade_homotopy", py2c_quaddobl_cascade_homotopy,
     METH_VARARGS,
    "Creates a homotopy in quad double precision using the stored\n systems to go one level down the cascade, removing one slice.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_factor_set_standard_to_mute",
     py2c_factor_set_standard_to_mute, METH_VARARGS,
    "Sets the state of monodromy permutations in standard double\n precision to silent."},
   {"py2c_factor_set_dobldobl_to_mute",
     py2c_factor_set_dobldobl_to_mute, METH_VARARGS,
    "Sets the state of monodromy permutations in double double\n precision to silent."},
   {"py2c_factor_set_quaddobl_to_mute",
     py2c_factor_set_quaddobl_to_mute, METH_VARARGS,
    "Sets the state of monodromy permutations in quad double\n precision to silent."},
   {"py2c_factor_set_standard_to_verbose",
     py2c_factor_set_standard_to_verbose, METH_VARARGS,
    "Sets the state of monodromy permutations in standard double\n precision to verbose."},
   {"py2c_factor_set_dobldobl_to_verbose",
     py2c_factor_set_dobldobl_to_verbose, METH_VARARGS,
    "Sets the state of monodromy permutations in double double\n precision to verbose."},
   {"py2c_factor_set_quaddobl_to_verbose",
     py2c_factor_set_quaddobl_to_verbose, METH_VARARGS,
    "Sets the state of monodromy permutations in quad double\n precision to verbose."},
   {"py2c_factor_define_output_file_with_string",
     py2c_factor_define_output_file_with_string, METH_VARARGS,
    "Defines the output file for the factorization.\n On input are an integer and a string:\n 1) the integer equals the number of characters in the string; and\n 2) the string contains the name of a file.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_factor_standard_assign_labels",
     py2c_factor_standard_assign_labels, METH_VARARGS,
    "Assigns labels, replacing the multiplicity field of each solution\n in standard double precision stored in the container.\n On entry are two integers:\n 1) n, the number of coordinates of the solutions;\n 2) nbsols, the number of solutions in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_factor_dobldobl_assign_labels",
     py2c_factor_dobldobl_assign_labels, METH_VARARGS,
    "Assigns labels, replacing the multiplicity field of each solution\n in double double precision stored in the container.\n On entry are two integers:\n 1) n, the number of coordinates of the solutions;\n 2) nbsols, the number of solutions in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_factor_quaddobl_assign_labels",
     py2c_factor_quaddobl_assign_labels, METH_VARARGS,
    "Assigns labels, replacing the multiplicity field of each solution\n in quad double precision stored in the container.\n On entry are two integers:\n 1) n, the number of coordinates of the solutions;\n 2) nbsols, the number of solutions in the container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_factor_initialize_standard_sampler",
     py2c_factor_initialize_standard_sampler, METH_VARARGS,
    "Initializes the sampling machine with a witness set,\n in standard double precision.\n On entry is the dimension or the number of hyperplanes\n to slide the positive dimensional solution set."},
   {"py2c_factor_initialize_dobldobl_sampler",
     py2c_factor_initialize_dobldobl_sampler, METH_VARARGS,
    "Initializes the sampling machine with a witness set,\n in double double precision.\n On entry is the dimension or the number of hyperplanes\n to slide the positive dimensional solution set."},
   {"py2c_factor_initialize_quaddobl_sampler",
     py2c_factor_initialize_quaddobl_sampler, METH_VARARGS,
    "Initializes the sampling machine with a witness set,\n in quad double precision.\n On entry is the dimension or the number of hyperplanes\n to slide the positive dimensional solution set."},
   {"py2c_factor_initialize_standard_monodromy",
     py2c_factor_initialize_standard_monodromy, METH_VARARGS,
    "Initializes the internal data structures for n loops,\n to factor a k-dimensional solution component of degree d,\n in standard double precision.\n There are three integers on input, in the following order:\n 1) n, the number of loops;\n 2) d, the degree of the solution set;\n 3) k, the dimensional of the solution set.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_factor_initialize_dobldobl_monodromy",
     py2c_factor_initialize_dobldobl_monodromy, METH_VARARGS,
    "Initializes the internal data structures for n loops,\n to factor a k-dimensional solution component of degree d,\n in double double precision.\n There are three integers on input, in the following order:\n 1) n, the number of loops;\n 2) d, the degree of the solution set;\n 3) k, the dimensional of the solution set.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_factor_initialize_quaddobl_monodromy",
     py2c_factor_initialize_quaddobl_monodromy, METH_VARARGS,
    "Initializes the internal data structures for n loops,\n to factor a k-dimensional solution component of degree d,\n in quad double precision.\n There are three integers on input, in the following order:\n 1) n, the number of loops;\n 2) d, the degree of the solution set;\n 3) k, the dimensional of the solution set.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_factor_standard_trace_grid_diagnostics",
     py2c_factor_standard_trace_grid_diagnostics, METH_VARARGS,
    "Returns a tuple of two doubles with the diagnostics on the\n trace grid computed in standard double precision.\n The first double is the largest error of the samples.\n The second double is the smallest distance between two samples."},
   {"py2c_factor_dobldobl_trace_grid_diagnostics",
     py2c_factor_dobldobl_trace_grid_diagnostics, METH_VARARGS,
    "Returns a tuple of two doubles with the diagnostics on the\n trace grid computed in double double precision.\n The first double is the largest error of the samples.\n The second double is the smallest distance between two samples."},
   {"py2c_factor_quaddobl_trace_grid_diagnostics",
     py2c_factor_quaddobl_trace_grid_diagnostics, METH_VARARGS,
    "Returns a tuple of two doubles with the diagnostics on the\n trace grid computed in quad double precision.\n The first double is the largest error of the samples.\n The second double is the smallest distance between two samples."},
   {"py2c_factor_store_standard_solutions",
     py2c_factor_store_standard_solutions, METH_VARARGS,
    "Stores the solutions in the container, in standard double precision,\n to the data for monodromy loops."},
   {"py2c_factor_store_dobldobl_solutions",
     py2c_factor_store_dobldobl_solutions, METH_VARARGS,
    "Stores the solutions in the container, in double double precision,\n to the data for monodromy loops."},
   {"py2c_factor_store_quaddobl_solutions",
     py2c_factor_store_quaddobl_solutions, METH_VARARGS,
    "Stores the solutions in the container, in quad double precision,\n to the data for monodromy loops."},
   {"py2c_factor_restore_standard_solutions",
     py2c_factor_restore_standard_solutions, METH_VARARGS,
    "Restores the first initialized solutions, in standard double precision,\n from sampler to the container."},
   {"py2c_factor_restore_dobldobl_solutions",
     py2c_factor_restore_dobldobl_solutions, METH_VARARGS,
    "Restores the first initialized solutions, in double double precision,\n from sampler to the container."},
   {"py2c_factor_restore_quaddobl_solutions",
     py2c_factor_restore_quaddobl_solutions, METH_VARARGS,
    "Restores the first initialized solutions, in quad double precision,\n from sampler to the container."},
   {"py2c_factor_standard_track_paths",
     py2c_factor_standard_track_paths, METH_VARARGS,
    "Tracks as many paths as defined by witness set,\n in standard double precision.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_dobldobl_track_paths",
     py2c_factor_dobldobl_track_paths, METH_VARARGS,
    "Tracks as many paths as defined by witness set,\n in double double precision.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_quaddobl_track_paths",
     py2c_factor_quaddobl_track_paths, METH_VARARGS,
    "Tracks as many paths as defined by witness set,\n in quad double precision.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_swap_standard_slices",
     py2c_factor_swap_standard_slices, METH_VARARGS,
    "Swaps the current slices with new slices and takes new solutions\n as start to turn back, in standard double precision.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_swap_dobldobl_slices",
     py2c_factor_swap_dobldobl_slices, METH_VARARGS,
    "Swaps the current slices with new slices and takes new solutions\n as start to turn back, in double double precision.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_swap_quaddobl_slices",
     py2c_factor_swap_quaddobl_slices, METH_VARARGS,
    "Swaps the current slices with new slices and takes new solutions\n as start to turn back, in quad double precision.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_new_standard_slices",
     py2c_factor_new_standard_slices, METH_VARARGS,
    "Generates k random slides in n-space, in standard double precision.\n The k and the n are the two input parameters.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_new_dobldobl_slices",
     py2c_factor_new_dobldobl_slices, METH_VARARGS,
    "Generates k random slides in n-space, in double double precision.\n The k and the n are the two input parameters.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_new_quaddobl_slices",
     py2c_factor_new_quaddobl_slices, METH_VARARGS,
    "Generates k random slides in n-space, in quad double precision.\n The k and the n are the two input parameters.\n On return is the failure code, which is zero when all went well."},
   {"py2c_factor_set_standard_trace_slice",
     py2c_factor_set_standard_trace_slice, METH_VARARGS,
    "Assigns the constant coefficient of the first slice,\n in standard double precision.\n On entry is a flag to indicate if it was the first time or not.\n On return is the failure code, which is zero if all went well."},
   {"py2c_factor_set_dobldobl_trace_slice",
     py2c_factor_set_dobldobl_trace_slice, METH_VARARGS,
    "Assigns the constant coefficient of the first slice,\n in double double precision.\n On entry is a flag to indicate if it was the first time or not.\n On return is the failure code, which is zero if all went well."},
   {"py2c_factor_set_quaddobl_trace_slice",
     py2c_factor_set_quaddobl_trace_slice, METH_VARARGS,
    "Assigns the constant coefficient of the first slice,\n in quad double precision.\n On entry is a flag to indicate if it was the first time or not.\n On return is the failure code, which is zero if all went well."},
   {"py2c_factor_store_standard_gammas",
     py2c_factor_store_standard_gammas, METH_VARARGS,
    "Stores the gamma constants in standard double precision\n for the sampler in the monodromy loops.\n Generates as many random complex constants as the value on input.\n On return is the failure code, which is zero if all went well."},
   {"py2c_factor_store_dobldobl_gammas",
     py2c_factor_store_dobldobl_gammas, METH_VARARGS,
    "Stores the gamma constants in double double precision\n for the sampler in the monodromy loops.\n Generates as many random complex constants as the value on input.\n On return is the failure code, which is zero if all went well."},
   {"py2c_factor_store_quaddobl_gammas",
     py2c_factor_store_quaddobl_gammas, METH_VARARGS,
    "Stores the gamma constants in quad double precision\n for the sampler in the monodromy loops.\n Generates as many random complex constants as the value on input.\n On return is the failure code, which is zero if all went well."},
   {"py2c_factor_permutation_after_standard_loop",
     py2c_factor_permutation_after_standard_loop, METH_VARARGS,
    "For a set of degree d, computes the permutation using the solutions\n most recently stored, after a loop in standard double precision.\n The number d is the input parameter of this function.\n On return is the string representation of the permutation."},
   {"py2c_factor_permutation_after_dobldobl_loop",
     py2c_factor_permutation_after_dobldobl_loop, METH_VARARGS,
    "For a set of degree d, computes the permutation using the solutions\n most recently stored, after a loop in double double precision.\n The number d is the input parameter of this function.\n On return is the string representation of the permutation."},
   {"py2c_factor_permutation_after_quaddobl_loop",
     py2c_factor_permutation_after_quaddobl_loop, METH_VARARGS,
    "For a set of degree d, computes the permutation using the solutions\n most recently stored, after a loop in quad double precision.\n The number d is the input parameter of this function.\n On return is the string representation of the permutation."},
   {"py2c_factor_update_standard_decomposition",
     py2c_factor_update_standard_decomposition, METH_VARARGS,
    "Updates the decomposition with the given permutation of d elements,\n computed in standard double precision.\n On entry are two integers and one string:\n 1) d, the number of elements in the permutation;\n 2) nc, the number of characters in the string;\n 3) p, the string representation of the permutation.\n Returns one if the current decomposition is certified,\n otherwise returns zero."},
   {"py2c_factor_update_dobldobl_decomposition",
     py2c_factor_update_dobldobl_decomposition, METH_VARARGS,
    "Updates the decomposition with the given permutation of d elements,\n computed in double double precision.\n On entry are two integers and one string:\n 1) d, the number of elements in the permutation;\n 2) nc, the number of characters in the string;\n 3) p, the string representation of the permutation.\n Returns one if the current decomposition is certified,\n otherwise returns zero."},
   {"py2c_factor_update_quaddobl_decomposition",
     py2c_factor_update_quaddobl_decomposition, METH_VARARGS,
    "Updates the decomposition with the given permutation of d elements,\n computed in quad double precision.\n On entry are two integers and one string:\n 1) d, the number of elements in the permutation;\n 2) nc, the number of characters in the string;\n 3) p, the string representation of the permutation.\n Returns one if the current decomposition is certified,\n otherwise returns zero."},
   {"py2c_factor_number_of_standard_components",
     py2c_factor_number_of_standard_components, METH_VARARGS,
    "Returns the number of irreducible factors in the current standard double\n precision decomposition of the witness set."},
   {"py2c_factor_number_of_dobldobl_components",
     py2c_factor_number_of_dobldobl_components, METH_VARARGS,
    "Returns the number of irreducible factors in the current double double\n precision decomposition of the witness set."},
   {"py2c_factor_number_of_quaddobl_components",
     py2c_factor_number_of_quaddobl_components, METH_VARARGS,
    "Returns the number of irreducible factors in the current quad double\n precision decomposition of the witness set."},
   {"py2c_factor_witness_points_of_standard_component",
     py2c_factor_witness_points_of_standard_component, METH_VARARGS,
    "Returns a string which represents an irreducible component,\n computed in standard double precision.\n On entry are two integers:\n 1) the sum of the degrees of all components;\n 2) the index of the component."},
   {"py2c_factor_witness_points_of_dobldobl_component",
     py2c_factor_witness_points_of_dobldobl_component, METH_VARARGS,
    "Returns a string which represents an irreducible component,\n computed in double double precision.\n On entry are two integers:\n 1) the sum of the degrees of all components;\n 2) the index of the component."},
   {"py2c_factor_witness_points_of_quaddobl_component",
     py2c_factor_witness_points_of_quaddobl_component, METH_VARARGS,
    "Returns a string which represents an irreducible component,\n computed in quad double precision.\n On entry are two integers:\n 1) the sum of the degrees of all components;\n 2) the index of the component."},
   {"py2c_factor_standard_trace_sum_difference",
     py2c_factor_standard_trace_sum_difference, METH_VARARGS,
    "Returns the difference between the actual sum at the samples\n defined by the labels to the generic points in the factor,\n and the trace sum, computed in standard double precision.\n On entry are three integer numbers and one string:\n 1) d, the number of points in the witness set;\n 2) k, the dimension of the solution set;\n 3) nc, the number of characters in the string;\n 4) ws, the string representing the labels of the witness set."},
   {"py2c_factor_dobldobl_trace_sum_difference",
     py2c_factor_dobldobl_trace_sum_difference, METH_VARARGS,
    "Returns the difference between the actual sum at the samples\n defined by the labels to the generic points in the factor,\n and the trace sum, computed in double double precision.\n On entry are three integer numbers and one string:\n 1) d, the number of points in the witness set;\n 2) k, the dimension of the solution set;\n 3) nc, the number of characters in the string;\n 4) ws, the string representing the labels of the witness set."},
   {"py2c_factor_quaddobl_trace_sum_difference",
     py2c_factor_quaddobl_trace_sum_difference, METH_VARARGS,
    "Returns the difference between the actual sum at the samples\n defined by the labels to the generic points in the factor,\n and the trace sum, computed in quad double precision.\n On entry are three integer numbers and one string:\n 1) d, the number of points in the witness set;\n 2) k, the dimension of the solution set;\n 3) nc, the number of characters in the string;\n 4) ws, the string representing the labels of the witness set."},
   {"py2c_witset_standard_membertest",
     py2c_witset_standard_membertest, METH_VARARGS,
    "Executes the homotopy membership test for a point to belong to\n a witness set in standard double precision.\n The containers in standard double precision must contain the\n embedded system and its corresponding solutions for the winess set\n of a positive dimensional solution set.\n On entry are the seven parameters, the first four are integers:\n 1) vrb, an integer flag (0 or 1) for the verbosity of the test,\n 2) nvr, the ambient dimension, number of coordinates of the point,\n 3) dim, the dimension of the witness set,\n 4) nbc, the number of characters in the string representing the point;\n the next two parameters are two doubles:\n 5) restol, tolerance on the residual for the valuation of the point,\n 6) homtol, tolerance on the homotopy membership test for the point;\n and the last parameter is a string:\n 7) tpt, the string representation of the point as a list with as\n many as 2*nvr doubles for the real and imaginary parts of the\n standard double precision coordinates of the test point.\n On return are three 0/1 integers, to be interpreted as booleans:\n 1) fail, the failure code of the procedure,\n 2) onsys, 0 if the evaluation test failed, 1 if success,\n 3) onset, 0 if not a member of the witness set, 1 if a member."},
   {"py2c_witset_dobldobl_membertest",
     py2c_witset_dobldobl_membertest, METH_VARARGS,
    "Executes the homotopy membership test for a point to belong to\n a witness set in double double precision.\n The containers in double double precision must contain the\n embedded system and its corresponding solutions for the winess set\n of a positive dimensional solution set.\n On entry are the seven parameters, the first four are integers:\n 1) vrb, an integer flag (0 or 1) for the verbosity of the test,\n 2) nvr, the ambient dimension, number of coordinates of the point,\n 3) dim, the dimension of the witness set,\n 4) nbc, the number of characters in the string representing the point;\n the next two parameters are two doubles:\n 5) restol, tolerance on the residual for the valuation of the point,\n 6) homtol, tolerance on the homotopy membership test for the point;\n and the last parameter is a string:\n 7) tpt, the string representation of the point as a list with as\n many as 4*nvr doubles for the real and imaginary parts of the\n double double precision coordinates of the test point.\n On return are three 0/1 integers, to be interpreted as booleans:\n 1) fail, the failure code of the procedure,\n 2) onsys, 0 if the evaluation test failed, 1 if success,\n 3) onset, 0 if not a member of the witness set, 1 if a member."},
   {"py2c_witset_quaddobl_membertest",
     py2c_witset_quaddobl_membertest, METH_VARARGS,
    "Executes the homotopy membership test for a point to belong to\n a witness set in quad double precision.\n The containers in quad double precision must contain the\n embedded system and its corresponding solutions for the winess set\n of a positive dimensional solution set.\n On entry are the seven parameters, the first four are integers:\n 1) vrb, an integer flag (0 or 1) for the verbosity of the test,\n 2) nvr, the ambient dimension, number of coordinates of the point,\n 3) dim, the dimension of the witness set,\n 4) nbc, the number of characters in the string representing the point;\n the next two parameters are two doubles:\n 5) restol, tolerance on the residual for the valuation of the point,\n 6) homtol, tolerance on the homotopy membership test for the point;\n and the last parameter is a string:\n 7) tpt, the string representation of the point as a list with as\n many as 8*nvr doubles for the real and imaginary parts of the\n quad double precision coordinates of the test point.\n On return are three 0/1 integers, to be interpreted as booleans:\n 1) fail, the failure code of the procedure,\n 2) onsys, 0 if the evaluation test failed, 1 if success,\n 3) onset, 0 if not a member of the witness set, 1 if a member."},
   {"py2c_standard_witset_of_hypersurface", py2c_standard_witset_of_hypersurface,
     METH_VARARGS,
    "Given in the string p of nc characters a polynomial in nv variables,\n terminated by a semicolon, the systems and solutions container\n in standard double precision on return contain a witness set for\n the hypersurface defined by p.\n On entry are two integers and one string, in the following order:\n 1) nv, the number of variables of the polynomials;\n 2) nc, the number of characters in the string p;\n 3) p, string representation of a polynomial, terminates with a semicolon.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_dobldobl_witset_of_hypersurface", py2c_dobldobl_witset_of_hypersurface,
     METH_VARARGS,
    "Given in the string p of nc characters a polynomial in nv variables,\n terminated by a semicolon, the systems and solutions container\n in double double precision on return contain a witness set for\n the hypersurface defined by p.\n On entry are two integers and one string, in the following order:\n 1) nv, the number of variables of the polynomials;\n 2) nc, the number of characters in the string p;\n 3) p, string representation of a polynomial, terminates with a semicolon.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_quaddobl_witset_of_hypersurface", py2c_quaddobl_witset_of_hypersurface,
     METH_VARARGS,
    "Given in the string p of nc characters a polynomial in nv variables,\n terminated by a semicolon, the systems and solutions container\n in quad double precision on return contain a witness set for\n the hypersurface defined by p.\n On entry are two integers and one string, in the following order:\n 1) nv, the number of variables of the polynomials;\n 2) nc, the number of characters in the string p;\n 3) p, string representation of a polynomial, terminates with a semicolon.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_standard_diagonal_homotopy", py2c_standard_diagonal_homotopy,
     METH_VARARGS,
    "Creates a diagonal homotopy to intersect two solution sets of\n dimensions a and b respectively, where a >= b.\n The two input parameters are values for a and b.\n The systems stored as target and start system in the container,\n in standard double precision, define the witness sets for\n these two solution sets."},
   {"py2c_dobldobl_diagonal_homotopy", py2c_dobldobl_diagonal_homotopy,
     METH_VARARGS,
    "Creates a diagonal homotopy to intersect two solution sets of\n dimensions a and b respectively, where a >= b.\n The two input parameters are values for a and b.\n The systems stored as target and start system in the container,\n in double double precision, define the witness sets for\n these two solution sets."},
   {"py2c_quaddobl_diagonal_homotopy", py2c_quaddobl_diagonal_homotopy,
     METH_VARARGS,
    "Creates a diagonal homotopy to intersect two solution sets of\n dimensions a and b respectively, where a >= b.\n The two input parameters are values for a and b.\n The systems stored as target and start system in the container,\n in quad double precision, define the witness sets for\n these two solution sets."},
   {"py2c_standard_diagonal_cascade_solutions",
     py2c_standard_diagonal_cascade_solutions, METH_VARARGS,
    "Makes the start solutions to start the cascade homotopy to\n intersect two solution sets of dimensions a and b, where a >= b,\n in standard double precision.\n The dimensions a and b are given as input parameters.\n The systems stored as target and start system in the container\n define the witness sets for these two solution sets.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_dobldobl_diagonal_cascade_solutions",
     py2c_dobldobl_diagonal_cascade_solutions, METH_VARARGS,
    "Makes the start solutions to start the cascade homotopy to\n intersect two solution sets of dimensions a and b, where a >= b,\n in double double precision.\n The dimensions a and b are given as input parameters.\n The systems stored as target and start system in the container\n define the witness sets for these two solution sets.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_quaddobl_diagonal_cascade_solutions",
     py2c_quaddobl_diagonal_cascade_solutions, METH_VARARGS,
    "Makes the start solutions to start the cascade homotopy to\n intersect two solution sets of dimensions a and b, where a >= b,\n in quad double precision.\n The dimensions a and b are given as input parameters.\n The systems stored as target and start system in the container\n define the witness sets for these two solution sets.\n On return is the failure code, which equals zero when all went well."},
   {"py2c_extrinsic_top_diagonal_dimension",
     py2c_extrinsic_top_diagonal_dimension, METH_VARARGS,
    "Returns the dimension of the start and target system to\n start the extrinsic cascade to intersect two witness sets,\n respectively of dimensions a and b, with ambient dimensions\n respectively equal to n1 and n2.\n There are four integers as parameters on input: n1, n2, a and b."},
   {"py2c_diagonal_symbols_doubler",
     py2c_diagonal_symbols_doubler, METH_VARARGS, 
    "Doubles the number of symbols in the symbol table to enable the\n writing of the target system to string properly when starting the\n cascade of a diagonal homotopy in extrinsic coordinates.\n On input are three integers, n, d, nc, and one string s.\n On input are n, the ambient dimension = #variables before the embedding,\n d is the number of slack variables, or the dimension of the first set,\n and in s (nc characters) are the symbols for the first witness set.\n This function takes the symbols in s and combines those symbols with\n those in the current symbol table for the second witness set stored\n in the standard systems container.  On return, the symbol table\n contains then all symbols to write the top system in the cascade\n to start the diagonal homotopy."},
   {"py2c_standard_collapse_diagonal",
     py2c_standard_collapse_diagonal, METH_VARARGS,
    "Eliminates the extrinsic diagonal for the system and solutions\n in the containers for standard doubles.  On input are two integers:\n 1) k, the current number of slack variables in the embedding;\n 2) d, the number of slack variables to add to the final embedding.\n The system in the container has its diagonal eliminated and is\n embedded with k+d slack variables.  The solutions corresponding\n to this system are in the solutions container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_dobldobl_collapse_diagonal",
     py2c_dobldobl_collapse_diagonal, METH_VARARGS,
    "Eliminates the extrinsic diagonal for the system and solutions\n in the containers for double doubles.  On input are two integers:\n 1) k, the current number of slack variables in the embedding;\n 2) d, the number of slack variables to add to the final embedding.\n The system in the container has its diagonal eliminated and is\n embedded with k+d slack variables.  The solutions corresponding\n to this system are in the solutions container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_quaddobl_collapse_diagonal",
     py2c_quaddobl_collapse_diagonal, METH_VARARGS,
    "Eliminates the extrinsic diagonal for the system and solutions\n in the containers for quad doubles.  On input are two integers:\n 1) k, the current number of slack variables in the embedding;\n 2) d, the number of slack variables to add to the final embedding.\n The system in the container has its diagonal eliminated and is\n embedded with k+d slack variables.  The solutions corresponding\n to this system are in the solutions container.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_schubert_pieri_count", py2c_schubert_pieri_count, METH_VARARGS,
    "Returns the number of p-plane producing curves of degree q\n that meet m*p + q*(m+p) given general m-planes.\n On input are three integer numbers:\n 1) m, the dimension of the input planes;\n 2) p, the dimension of the output planes; and\n 3) q, the degree of the curve that produces p-planes.\n The dimension of the ambient space of this Pieri problem is m+p."},
   {"py2c_schubert_resolve_conditions", py2c_schubert_resolve_conditions,
     METH_VARARGS,
    "Resolves a general Schubert intersection condition in n-space\n for k-planes subject to conditions defined by brackers.\n On return is the root count, the number of k-planes that satisfy\n the intersection conditions imposed by the brackets for general flags.\n On entry are five integers and one string:\n 1) n, the ambient dimension, where the k-planes live;\n 2) k, the dimension of the solution planes;\n 3) c, the number of intersection conditions;\n 4) nc, the number of characters in the string brackets;\n 5) brackets is a string representation of c brackets, where the numbers\n in each bracket are separated by spaces;\n 6) the flag verbose: when 0, no intermediate output is written,\n when 1, then the resolution is dispayed on screen."},
   {"py2c_schubert_standard_littlewood_richardson_homotopies",
     py2c_schubert_standard_littlewood_richardson_homotopies, METH_VARARGS,
    "Runs the Littlewood-Richardson homotopies to resolve a number of\n general Schubert intersection conditions on k-planes in n-space,\n in standard double precision.\n The polynomial system that was solved is in the container for\n systems with coefficients in standard double precision and the\n corresponding solutions are in the standard solutions container.\n On entry are six integers and two strings, in the following order:\n 1) n, the ambient dimension, where the k-planes live;\n 2) k, the dimension of the solution planes;\n 3) c,the number of intersection conditions;\n 4) nc, the number of characters in the string brackets;\n 5) brackets is a string representation of c brackets, where the numbers\n in each bracket are separated by spaces;\n 6) the flag verbose: when 0, no intermediate output is written,\n when 1, then the resolution is dispayed on screen;\n 7) the flag verify: when 0, no diagnostic verification is done,\n when 1, then diagnostic verification is written to file;\n 8) nbchar, the number of characters in the string filename;\n 9) filename is the name of the output file.\n The function returns a tuple of an integer and a string:\n 0) r is the formal root count as the number of k-planes\n for conditions imposed by the brackets for general flags;\n 1) flags, a string with the coefficients of the general flags."},
   {"py2c_schubert_dobldobl_littlewood_richardson_homotopies",
     py2c_schubert_dobldobl_littlewood_richardson_homotopies, METH_VARARGS,
    "Runs the Littlewood-Richardson homotopies to resolve a number of\n general Schubert intersection conditions on k-planes in n-space,\n in double double precision.\n The polynomial system that was solved is in the container for\n systems with coefficients in double double precision and the\n corresponding solutions are in the dobldobl solutions container.\n On entry are six integers and two strings, in the following order:\n 1) n, the ambient dimension, where the k-planes live;\n 2) k, the dimension of the solution planes;\n 3) c,the number of intersection conditions;\n 4) nc, the number of characters in the string brackets;\n 5) brackets is a string representation of c brackets, where the numbers\n in each bracket are separated by spaces;\n 6) the flag verbose: when 0, no intermediate output is written,\n when 1, then the resolution is dispayed on screen;\n 7) the flag verify: when 0, no diagnostic verification is done,\n when 1, then diagnostic verification is written to file;\n 8) nbchar, the number of characters in the string filename;\n 9) filename is the name of the output file.\n The function returns a tuple of an integer and a string:\n 0) r is the formal root count as the number of k-planes\n for conditions imposed by the brackets for general flags;\n 1) flags, a string with the coefficients of the general flags."},
   {"py2c_schubert_quaddobl_littlewood_richardson_homotopies",
     py2c_schubert_quaddobl_littlewood_richardson_homotopies, METH_VARARGS,
    "Runs the Littlewood-Richardson homotopies to resolve a number of\n general Schubert intersection conditions on k-planes in n-space,\n in quad double precision.\n The polynomial system that was solved is in the container for\n systems with coefficients in quad double precision and the\n corresponding solutions are in the quaddobl solutions container.\n On entry are six integers and two strings, in the following order:\n 1) n, the ambient dimension, where the k-planes live;\n 2) k, the dimension of the solution planes;\n 3) c,the number of intersection conditions;\n 4) nc, the number of characters in the string brackets;\n 5) brackets is a string representation of c brackets, where the numbers\n in each bracket are separated by spaces;\n 6) the flag verbose: when 0, no intermediate output is written,\n when 1, then the resolution is dispayed on screen;\n 7) the flag verify: when 0, no diagnostic verification is done,\n when 1, then diagnostic verification is written to file;\n 8) nbchar, the number of characters in the string filename;\n 9) filename is the name of the output file.\n The function returns a tuple of an integer and a string:\n 0) r is the formal root count as the number of k-planes\n for conditions imposed by the brackets for general flags;\n 1) flags, a string with the coefficients of the general flags."},
   {"py2c_schubert_localization_poset", py2c_schubert_localization_poset,
     METH_VARARGS,
    "Returns the string representation of the localization poset for the\n Pieri root count for m, p, and q.  The input parameters are the\n integer values for m, p, and q:\n 1) m, the dimension of the input planes;\n 2) p, the dimension of the output planes;\n 3) q, the degree of the curves that produce p-planes."},
   {"py2c_schubert_pieri_homotopies", py2c_schubert_pieri_homotopies,
    METH_VARARGS,
   "Runs the Pieri homotopies for (m,p,q) dimensions on generic input data.\n On return the systems container for systems with coefficients in standard\n double precision contains the polynomial system solved and in the\n solutions in standard double precision are in the solutions container.\n On entry are four integers and two strings:\n 1) m, the dimension of the input planes;\n 2) p, the dimension of the output planes;\n 3) q, the degree of the solution maps;\n 4) nc, the number of characters in the string A;\n 5) A, the string with m*p + q*(m+p) random complex input m-planes,\n where the real and imaginary parts are separated by a space;\n 6) pts, the string with m*p + q*(m+p) random complex interpolation\n points, only needed if q > 0.\n The function returns the combinatorial Pieri root count,\n which should equal the number of solutions in the container."},
   {"py2c_schubert_osculating_planes", py2c_schubert_osculating_planes,
     METH_VARARGS, 
    "Returns the string representation of n real m-planes in\n d-space osculating a rational normal curve\n at the n points in s, where n = m*p + q*(m+p) and d = m+p.\n On entry are four integers and one string:\n 1) m, the dimension of the input planes;\n 2) p, the dimension of the output planes;\n 3) q, the degree of the solution maps;\n 4) nc, the number of characters in the string pts; and\n 5) pts, the string with m*p + q*(m+p) interpolation points."},
   {"py2c_schubert_pieri_system", py2c_schubert_pieri_system, METH_VARARGS,
    "Fills the container of systems with coefficients in standard\n double precision with a polynomial system that expresses the\n intersection conditions of a general Pieri problem.\n On input are five integers and one string:\n 1) m, the dimension of the input planes;\n 2) p, the dimension of the output planes;\n 3) q, the degree of the solution maps;\n 4) nc, the number of characters in the string A;\n 5) A,  m*p + q*(m+p) random complex input m-planes, where\n the real and imaginary parts are separated by a space;\n 6) a flag is_real: if == 1, then the coefficients of A are real,\n if == 0, then the coefficients of A are complex.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_mapcon_solve_system", py2c_mapcon_solve_system, METH_VARARGS,
    "Solves the binomial system stored in the Laurent systems container.\n There is one input argument, either one or zero.\n If one, then only the pure top dimensional solutions are computed.\n If zero, then all solution sets are computed.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_mapcon_write_maps", py2c_mapcon_write_maps, METH_VARARGS,
    "Writes the maps stored in the container to screen.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_mapcon_clear_maps", py2c_mapcon_clear_maps, METH_VARARGS, 
    "Deallocates the maps stored in the container.\n Returns the failure code, which equals zero if all went well."},
   {"py2c_mapcon_top_dimension", py2c_mapcon_top_dimension, METH_VARARGS,
    "Returns the top dimension of the maps in the container."},
   {"py2c_mapcon_number_of_maps", py2c_mapcon_number_of_maps, METH_VARARGS, 
    "Returns the number of maps in the container."},
   {"py2c_mapcon_degree_of_map", py2c_mapcon_degree_of_map, METH_VARARGS,
    "Given the dimension and index of a map, given as two integers as\n input parameters, returns the degree of that map."},
   {"py2c_mapcon_coefficients_of_map", py2c_mapcon_coefficients_of_map,
     METH_VARARGS,
    "Returns the coefficients of a monomial map stored in the container.\n On entry are three parameters:\n 1) the dimension of the map;\n 2) the index of the map in all maps of that dimension;\n 3) the number of variables.\n On return is a Python list of complex doubles."},
   {"py2c_mapcon_exponents_of_map", py2c_mapcon_exponents_of_map, METH_VARARGS,
    "Returns the exponents of a monomial map stored in the container.\n On entry are three parameters:\n 1) the dimension of the map;\n 2) the index of the map in all maps of that dimension;\n 3) the number of variables.\n On return is a Python list of integers."},
   {"py2c_initialize_standard_homotopy", py2c_initialize_standard_homotopy,
     METH_VARARGS,
   "Initializes the homotopy to track a path with a generator,\n using standard double precision arithmetic.\n There is one integer number on input to be considered as a boolean,\n as an indicator whether a fixed gamma constant will be used.\n Before calling this routine the target and start system must\n be copied over from the standard systems container."},
   {"py2c_initialize_dobldobl_homotopy", py2c_initialize_dobldobl_homotopy,
     METH_VARARGS,
   "Initializes the homotopy to track a path with a generator,\n using double double precision arithmetic.\n There is one integer number on input to be considered as a boolean,\n as an indicator whether a fixed gamma constant will be used.\n Before calling this routine the target and start system must\n be copied over from the dobldobl systems container."},
   {"py2c_initialize_quaddobl_homotopy", py2c_initialize_quaddobl_homotopy,
     METH_VARARGS,
   "Initializes the homotopy to track a path with a generator,\n using quad double precision arithmetic.\n There is one integer number on input to be considered as a boolean,\n as an indicator whether a fixed gamma constant will be used.\n Before calling this routine the target and start system must\n be copied over from the quaddobl systems container."},
   {"py2c_initialize_multprec_homotopy", py2c_initialize_multprec_homotopy,
     METH_VARARGS,
    "Initializes the homotopy to track a path with a generator,\n using arbitrary multiprecision arithmetic.\n There is are two integer numbers on input:\n 1) one to be considered as a boolean,\n as an indicator whether a fixed gamma constant will be used; and\n 2) the number of decimal places in the working precision.\n Before calling this routine the target and start system must\n be copied over from the multprec systems container."},
   {"py2c_initialize_varbprec_homotopy", py2c_initialize_varbprec_homotopy,
     METH_VARARGS,
    "Initializes the variable precision homotopy with the target and\n start system stored in the strings.\n On entry are three integers and two strings, in the following order:\n 1) fixed_gamma is a flag: if 1, then a fixed value for the gamma constant\n is used, if 0, a random value for gamma will be generated;\n 2) nc_target, the number of characters in the string target;\n 3) target, the string representation of the target system;\n 4) nc_start, the number of characters in the string start;\n 5) start, the string representation of the start system.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_initialize_standard_solution", py2c_initialize_standard_solution, 
     METH_VARARGS,
    "Initializes the path tracker with a generator with a solution\n from the standard solutions container.  The index to the solution\n is given as an integer input parameter.  The counting of the\n indices starts at one, so the first solution has index one."},
   {"py2c_initialize_dobldobl_solution", py2c_initialize_dobldobl_solution,
     METH_VARARGS,
    "Initializes the path tracker with a generator with a solution\n from the dobldobl solutions container.  The index to the solution\n is given as an integer input parameter.  The counting of the\n indices starts at one, so the first solution has index one."},
   {"py2c_initialize_quaddobl_solution", py2c_initialize_quaddobl_solution,
     METH_VARARGS,
    "Initializes the path tracker with a generator with a solution\n from the quaddobl solutions container.  The index to the solution\n is given as an integer input parameter.  The counting of the\n indices starts at one, so the first solution has index one."},
   {"py2c_initialize_multprec_solution", py2c_initialize_multprec_solution,
     METH_VARARGS, 
    "Initializes the path tracker with a generator with a solution\n from the multprec solutions container.  The index to the solution\n is given as an integer input parameter.  The counting of the\n indices starts at one, so the first solution has index one."},
   {"py2c_initialize_varbprec_solution", py2c_initialize_varbprec_solution,
     METH_VARARGS,
    "Uses the string representation of a solution to initialize the\n variable precision path tracker with.\n There are three input parameters, two integers and one string:\n 1) nv, the number of variables in the solution;\n 2) nc, the number of characters in the string sol;\n 3) sol, the string representation of a solution.\n On return is the failure code, which equals zero if all went well."},
   {"py2c_next_standard_solution", py2c_next_standard_solution, 
     METH_VARARGS,
    "Computes the next point on the solution path with standard double\n precision for the given index.  This index is given as an input\n parameter.  The index to the solution path starts its count at one.\n The point itself is stored in the standard solutions container.\n The functions py2c_initialized_standard_tracker and\n py2c_initialize_standard_solution must have been executed earlier.\n The failcode is returned, which equals zero if all is well."},
   {"py2c_next_dobldobl_solution", py2c_next_dobldobl_solution,
     METH_VARARGS,
    "Computes the next point on the solution path with double double\n precision for the given index.  This index is given as an input\n parameter.  The index to the solution path starts its count at one.\n The point itself is stored in the dobldobl solutions container.\n The functions py2c_initialized_dobldobl_tracker and\n py2c_initialize_dobldobl_solution must have been executed earlier.\n The failcode is returned, which equals zero if all is well."},
   {"py2c_next_quaddobl_solution", py2c_next_quaddobl_solution,
     METH_VARARGS,
    "Computes the next point on the solution path with quad double\n precision for the given index.  This index is given as an input\n parameter.  The index to the solution path starts its count at one.\n The point itself is stored in the quaddobl solutions container.\n The functions py2c_initialized_quaddobl_tracker and\n py2c_initialize_quaddobl_solution must have been executed earlier.\n The failcode is returned, which equals zero if all is well."},
   {"py2c_next_multprec_solution", py2c_next_multprec_solution,
     METH_VARARGS,
    "Computes the next point on the solution path with arbitrary\n multiprecision for the given index.  This index is given as an input\n parameter.  The index to the solution path starts its count at one.\n The point itself is stored in the multprec solutions container.\n The functions py2c_initialized_multprec_tracker and\n py2c_initialize_multprec_solution must have been executed earlier.\n The failcode is returned, which equals zero if all is well."},
   {"py2c_next_varbprec_solution", py2c_next_varbprec_solution,
     METH_VARARGS,
    "Computes the next point on a solution path in variable precision.\n There are four integer input parameters:\n 1) the number of correct decimal places in the solution;\n 2) an upper bound on the number of decimal places in the precision;\n 3) the maximum number of Newton iterations;\n 4) a flag zero or one to indicate the verbose level.\n On return is a tuple:\n 0) the failure code, which equals zero if all went well; and\n 1) the string representation of the next solution on the path."},
   {"py2c_clear_standard_tracker", py2c_clear_standard_tracker, METH_VARARGS, 
    "Deallocates data used in the standard double precision tracker\n with a generator."},
   {"py2c_clear_dobldobl_tracker", py2c_clear_dobldobl_tracker, METH_VARARGS, 
    "Deallocates data used in the double double precision tracker\n with a generator."},
   {"py2c_clear_quaddobl_tracker", py2c_clear_quaddobl_tracker, METH_VARARGS,
    "Deallocates data used in the quad double precision tracker\n with a generator."},
   {"py2c_clear_multprec_tracker", py2c_clear_multprec_tracker, METH_VARARGS,
    "Deallocates data used in the arbitrary multiprecision tracker\n with a generator."},
   {"py2c_clear_varbprec_tracker", py2c_clear_varbprec_tracker, METH_VARARGS, 
    "Deallocates data used in the variable precision tracker\n with a generator."},
   {NULL, NULL, 0, NULL} 
};

/* This is the initialization routine which will be called by the 
 * Python run-time when the library is imported in order to retrieve 
 * a pointer to the above method address table.
 * Note that therefore this routine must be visible in the dynamic library
 * either through the use of a ".def" file or by a compiler instruction 
 * such as "declspec(export)" */

static struct PyModuleDef phcpy2c3module = {
   PyModuleDef_HEAD_INIT,
   "phcpy2c3",
   NULL, /* no module documentation */
   -1,
   phcpy2c3_methods
};

PyMODINIT_FUNC 
PyInit_phcpy2c3(void)
{
   return PyModule_Create(&phcpy2c3module);
}
