/* Defining complex type for CPU computations (the host).
   Template parameter value specifies precision level */

#ifndef __COMPLEXH_H__
#define __COMPLEXH_H__

#define __CUDAC__

#ifdef __CUDAC__
#define HOST __host__
#define DEVICE __device__
#else
#define HOST
#define DEVICE
#endif

#include <iostream>
#include <qd/qd_real.h>

using namespace std;

template <class T>
class complexH
{
   template <class T1>
   friend std::ostream& operator<<
      ( std::ostream& os, const complexH<T1>& number );

   template <class T1>
   friend std::ifstream& operator>>
      ( std::ifstream& is, const complexH<T1>& number );

   public:

      complexH<T> operator=(complexH<T>);
      complexH(T,T,bool);
      complexH(double,double);
      complexH(const complexH<T> &);
      void init(double,double);

      complexH() {};
      complexH operator+(complexH);
      complexH operator-(complexH);
      complexH operator*(complexH);
      complexH operator*(T);
      complexH operator*(int);
      complexH operator/(complexH);
      T absv() {return sqrt(real*real+imag*imag);};
      complexH adj() {return complexH(real,-imag,(bool)1);};
      // void init(double,double);
      //void init(qd_real,qd_real);

      T real;
      T imag;
};

template<class T, int size>
class storage
{
   public:

      complexH<T> array[size];

      void print()
      {
         for(int i=0; i<size; i++) cout << array[i];
      }

      void copyToStor( complexH<T>* a)
      {
         for(int i=0; i<size; i++) array[i]=a[i];
      }

};

template <class T>
complexH<T>::complexH ( const complexH<T>& source )
{
   real = source.real;
   imag = source.imag;
}

template <class T>
std::ostream& operator<< ( std::ostream& os, const complexH<T>& number )
{
   int pr = 2*sizeof(T);
   cout.precision(pr);
   os << number.real << " + i*" << number.imag << endl;
   return os;
}

template <class T>
std:: ifstream& operator >> ( std::ifstream& is, const complexH<T>& number )
{
   is >> number.real >> "+i*" >> number.imag;
   return is;
}

template <class T>
complexH<T> complexH<T>::operator= ( complexH<T> a )
{
   real = a.real;
   imag = a.imag;

   return *this;
}

template <class T>
complexH<T>::complexH(T a, T b, bool c)
{
   real = a;
   imag = b;
}

/*
template <class T>
complexH<T>::complexH(double a, double b)
{
real.x[0] = a;
imag.x[0] =b;
}
*/

template <class T>
complexH<T>::complexH(double a, double b)
{
   real.x[0] = a; real.x[1]=0.0;
   imag.x[0] = b; imag.x[1]=0.0;
}

template <>
inline complexH<qd_real>::complexH(double a, double b)
{
   real.x[0] = a; real.x[1]=0.0; real.x[2]=0.0; real.x[3]=0.0;
   imag.x[0] = b; imag.x[1]=0.0; imag.x[2]=0.0; imag.x[3]=0.0;
}

template <>
inline complexH<double>::complexH ( double a, double b )
{
   real = a; 
   imag = b; 
}

template <class T>
void complexH<T>::init(double a, double b)
{
   complexH<T> temp(a,b);

   real = temp.real;
   imag = temp.imag;
}

//template <class T>
//complexH<T>::complexH() {}

template <class T>
__device__ complexH<T> complexH<T>::operator+(complexH<T> a)
{
   return complexH( real + a.real, imag + a.imag,1);
}

template <class T>
complexH<T> complexH<T>::operator-(complexH<T> a)
{
   return complexH( real - a.real, imag - a.imag,1);
}

template <class T>
complexH<T> complexH<T>::operator*(complexH<T> a)
{
   return complexH( real*a.real-imag*a.imag, imag*a.real+real*a.imag,1);
}

template <class T>
complexH<T> complexH<T>::operator*(T a)
{
  return complexH( real*a, imag*a,1);
}

template <class T>
complexH<T> complexH<T>::operator*(int a)
{
   return complexH( real*a, imag*a,1);
}

template <class T>
complexH<T> complexH<T>::operator/(complexH<T> a)
{
   return complexH((real*a.real+imag*a.imag)/(a.real*a.real+a.imag*a.imag),
                   (imag*a.real-real*a.imag)/ (a.real*a.real+a.imag*a.imag),1);
}

#endif
