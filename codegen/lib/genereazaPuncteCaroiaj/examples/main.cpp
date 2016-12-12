//
// File: main.cpp
//
// MATLAB Coder version            : 3.1
// C/C++ source code generated on  : 08-Dec-2016 16:43:58
//

//***********************************************************************
// This automatically generated example C main file shows how to call
// entry-point functions that MATLAB Coder generated. You must customize
// this file for your application. Do not modify this file directly.
// Instead, make a copy of this file, modify it, and integrate it into
// your development environment.
//
// This file initializes entry-point function arguments to a default
// size and value before calling the entry-point functions. It does
// not store or use any values returned from the entry-point functions.
// If necessary, it does pre-allocate memory for returned values.
// You can use this file as a starting point for a main function that
// you can deploy in your application.
//
// After you copy the file, and before you deploy it, you must make the
// following changes:
// * For variable-size function arguments, change the example sizes to
// the sizes that your application requires.
// * Change the example values of function arguments to the values that
// your application requires.
// * If the entry-point functions return values, store these values or
// otherwise use them as required by your application.
//
//***********************************************************************
// Include Files
#include "rt_nonfinite.h"
#include "genereazaPuncteCaroiaj.h"
#include "main.h"
#include "genereazaPuncteCaroiaj_terminate.h"
#include "genereazaPuncteCaroiaj_emxAPI.h"
#include "genereazaPuncteCaroiaj_initialize.h"

// Function Declarations
static emxArray_uint8_T *argInit_d1000xd1000x3_uint8_T();
static int argInit_int32_T();
static unsigned char argInit_uint8_T();
static void main_genereazaPuncteCaroiaj();

// Function Definitions

//
// Arguments    : void
// Return Type  : emxArray_uint8_T *
//
static emxArray_uint8_T *argInit_d1000xd1000x3_uint8_T()
{
  emxArray_uint8_T *result;
  static int iv0[3] = { 2, 2, 3 };

  int idx0;
  int idx1;
  int idx2;

  // Set the size of the array.
  // Change this size to the value that the application requires.
  result = emxCreateND_uint8_T(3, *(int (*)[3])&iv0[0]);

  // Loop over the array to initialize each element.
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    for (idx1 = 0; idx1 < result->size[1U]; idx1++) {
      for (idx2 = 0; idx2 < 3; idx2++) {
        // Set the value of the array element.
        // Change this value to the value that the application requires.
        result->data[(idx0 + result->size[0] * idx1) + result->size[0] *
          result->size[1] * idx2] = argInit_uint8_T();
      }
    }
  }

  return result;
}

//
// Arguments    : void
// Return Type  : int
//
static int argInit_int32_T()
{
  return 0;
}

//
// Arguments    : void
// Return Type  : unsigned char
//
static unsigned char argInit_uint8_T()
{
  return 0;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_genereazaPuncteCaroiaj()
{
  emxArray_real_T *puncteCaroiaj;
  emxArray_uint8_T *img;
  emxInitArray_real_T(&puncteCaroiaj, 2);

  // Initialize function 'genereazaPuncteCaroiaj' input arguments.
  // Initialize function input argument 'img'.
  img = argInit_d1000xd1000x3_uint8_T();

  // Call the entry-point 'genereazaPuncteCaroiaj'.
  genereazaPuncteCaroiaj(img, argInit_int32_T(), argInit_int32_T(),
    argInit_int32_T(), puncteCaroiaj);
  emxDestroyArray_real_T(puncteCaroiaj);
  emxDestroyArray_uint8_T(img);
}

//
// Arguments    : int argc
//                const char * const argv[]
// Return Type  : int
//
int main(int, const char * const [])
{
  // Initialize the application.
  // You do not need to do this more than one time.
  genereazaPuncteCaroiaj_initialize();

  // Invoke the entry-point functions.
  // You can call entry-point functions multiple times.
  main_genereazaPuncteCaroiaj();

  // Terminate the application.
  // You do not need to do this more than one time.
  genereazaPuncteCaroiaj_terminate();
  return 0;
}

//
// File trailer for main.cpp
//
// [EOF]
//
