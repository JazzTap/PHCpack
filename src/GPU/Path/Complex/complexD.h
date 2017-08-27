// The class complexD defines complex arithmetic on the device,
// the real type is a templated parameter T.

#ifndef __COMPLEXD_H__
#define __COMPLEXD_H__

template <class T>
class complexD
{
   public:

      __device__ complexD(){};
      __device__ complexD ( double, double );
      __device__ complexD operator+ ( complexD );
      __device__ complexD operator* ( complexD );
      __device__ complexD operator- ( complexD );
      __device__ complexD operator/ ( complexD );
      __device__ void operator*= ( complexD );
      __device__ void operator+= ( complexD );
      __device__ void operator/= ( double );
      __device__ complexD adj();
      __device__ complexD adj_multiple ( complexD a );
      __device__ double norm_double();
      __device__ double norm1_double();
      __device__ void init_imag();

      double real;
      double imag;
};

#endif /* __COMPLEXD_H__ */
