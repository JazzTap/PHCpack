// Defines the prototypes for the kernels to compute the 2-norm of a vector
// in double, double double, and quad double precision.
// The file "all_norm_kernels.cu" contains the corresponding kernels.

#ifndef __ALL_NORM_KERNELS_H__
#define __ALL_NORM_KERNELS_H__

__global__ void small_normalize_vector
 ( complex<double>* v, int dim, int dimLog2, double* twonorm );
__global__ void small_normalize_vector
 ( complex<gdd_real>* v, int dim, int dimLog2, gdd_real* twonorm );
__global__ void small_normalize_vector
 ( complex<gqd_real>* v, int dim, int dimLog2, gqd_real* twonorm );
/*
 * DESCRIPTION :
 *   Kernel function to compute the norm of the vector in v,
 *   for vectors of small dimension,
 *   in double, double double, and quad double precision.
 *
 * REQUIRED :
 *   The dimension dim equals the block size,
 *   which is the number of threads in the block.
 *
 * ON ENTRY :
 *   v         vector of complex numbers of dimension dim;
 *   dim       dimension of the vector must equal the block size;
 *   dimLog2   equals ceil(log2((double) dim), used in sum reduction.
 *
 * ON RETURN :
 *   v         vector in same direction of original v with norm one;
 *   twonorm   the 2-norm of the original vector v. */

__global__ void large_normalize_vector
 ( complex<double>* v, int dim, int rnd, int rndLog2, int BS, int BSLog2,
   double* twonorm );
__global__ void large_normalize_vector
 ( complex<gdd_real>* v, int dim, int rnd, int rndLog2, int BS, int BSLog2,
   gdd_real* twonorm );
__global__ void large_normalize_vector
 ( complex<gqd_real>* v, int dim, int rnd, int rndLog2, int BS, int BSLog2,
   gqd_real* twonorm );
/*
 * DESCRIPTION :
 *   Kernel function to compute the norm of the vector in v,
 *   for vectors of large dimension,
 *   for double, double double, and quad double precision.
 *
 * REQUIRED :
 *   The dimension dim equals the block size BS times rnd.
 *   The block size BS is the number of threads in the block.
 *
 * ON ENTRY :
 *   v         vector of complex numbers of dimension dim;
 *   dim       dimension of the vector must equal rnd*BS;
 *   rnd       the number of rounds or the multiplier for the dimension;
 *   rndLog2   the 2-logarithm of rnd for use in sum reduction;
 *   BS        the block size or the number of threads in the block;
 *   BSLog2    equals ceil(log2((double) BS), used in sum reduction.
 *
 * ON RETURN :
 *   v         vector in same direction of original v with norm one;
 *   twonorm   the 2-norm of the original vector v. */

void GPU_norm
 ( complex<double>* v_h, int dim, int freq, int BS, double* twonorm );
void GPU_norm
 ( complex<gdd_real>* v_h, int dim, int freq, int BS, gdd_real* twonorm );
void GPU_norm 
 ( complex<gqd_real>* v_h, int dim, int freq, int BS, gqd_real* twonorm );
/*
 * DESCRIPTION :
 *   Allocates global memory on the card, transfers the data for the vector
 *   into the allocated memory, computes the 2-norm, normalizes the vector,
 *   and transfers the result from global memory of the card 
 *   to the memory of the host.
 *
 * ON ENTRY :
 *   v_h       vector of complex numbers of dimension dim;
 *   dim       dimension of the vector v_h;
 *   freq      frequency of the number of kernel launches (for timings);
 *   BS        block size, number of threads per block.
 *
 * ON RETURN :
 *   v_h       the normalized vector v_h;
 *   twonorm   the 2-norm of the original vector v_h. */

#endif
