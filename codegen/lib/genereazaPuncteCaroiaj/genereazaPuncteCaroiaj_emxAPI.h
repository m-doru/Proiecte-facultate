//
// File: genereazaPuncteCaroiaj_emxAPI.h
//
// MATLAB Coder version            : 3.1
// C/C++ source code generated on  : 08-Dec-2016 16:43:58
//
#ifndef GENEREAZAPUNCTECAROIAJ_EMXAPI_H
#define GENEREAZAPUNCTECAROIAJ_EMXAPI_H

// Include Files
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rtwtypes.h"
#include "genereazaPuncteCaroiaj_types.h"

// Function Declarations
extern emxArray_real_T *emxCreateND_real_T(int numDimensions, int *size);
extern emxArray_uint8_T *emxCreateND_uint8_T(int numDimensions, int *size);
extern emxArray_real_T *emxCreateWrapperND_real_T(double *data, int
  numDimensions, int *size);
extern emxArray_uint8_T *emxCreateWrapperND_uint8_T(unsigned char *data, int
  numDimensions, int *size);
extern emxArray_real_T *emxCreateWrapper_real_T(double *data, int rows, int cols);
extern emxArray_uint8_T *emxCreateWrapper_uint8_T(unsigned char *data, int rows,
  int cols);
extern emxArray_real_T *emxCreate_real_T(int rows, int cols);
extern emxArray_uint8_T *emxCreate_uint8_T(int rows, int cols);
extern void emxDestroyArray_real_T(emxArray_real_T *emxArray);
extern void emxDestroyArray_uint8_T(emxArray_uint8_T *emxArray);
extern void emxInitArray_real_T(emxArray_real_T **pEmxArray, int numDimensions);
extern void emxInitArray_uint8_T(emxArray_uint8_T **pEmxArray, int numDimensions);

#endif

//
// File trailer for genereazaPuncteCaroiaj_emxAPI.h
//
// [EOF]
//
