//
// File: genereazaPuncteCaroiaj_emxutil.h
//
// MATLAB Coder version            : 3.1
// C/C++ source code generated on  : 08-Dec-2016 16:43:58
//
#ifndef GENEREAZAPUNCTECAROIAJ_EMXUTIL_H
#define GENEREAZAPUNCTECAROIAJ_EMXUTIL_H

// Include Files
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rtwtypes.h"
#include "genereazaPuncteCaroiaj_types.h"

// Function Declarations
extern void emxEnsureCapacity(emxArray__common *emxArray, int oldNumel, int
  elementSize);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxFree_uint8_T(emxArray_uint8_T **pEmxArray);
extern void emxInit_real_T(emxArray_real_T **pEmxArray, int numDimensions);
extern void emxInit_uint8_T(emxArray_uint8_T **pEmxArray, int numDimensions);

#endif

//
// File trailer for genereazaPuncteCaroiaj_emxutil.h
//
// [EOF]
//
