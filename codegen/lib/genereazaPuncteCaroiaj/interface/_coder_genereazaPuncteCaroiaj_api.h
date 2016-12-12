/*
 * File: _coder_genereazaPuncteCaroiaj_api.h
 *
 * MATLAB Coder version            : 3.1
 * C/C++ source code generated on  : 08-Dec-2016 16:43:58
 */

#ifndef _CODER_GENEREAZAPUNCTECAROIAJ_API_H
#define _CODER_GENEREAZAPUNCTECAROIAJ_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_genereazaPuncteCaroiaj_api.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef struct_emxArray_uint8_T
#define struct_emxArray_uint8_T

struct emxArray_uint8_T
{
  uint8_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_uint8_T*/

#ifndef typedef_emxArray_uint8_T
#define typedef_emxArray_uint8_T

typedef struct emxArray_uint8_T emxArray_uint8_T;

#endif                                 /*typedef_emxArray_uint8_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void genereazaPuncteCaroiaj(emxArray_uint8_T *img, int32_T nrPuncteX,
  int32_T nrPuncteY, int32_T margine, emxArray_real_T *puncteCaroiaj);
extern void genereazaPuncteCaroiaj_api(const mxArray *prhs[4], const mxArray
  *plhs[1]);
extern void genereazaPuncteCaroiaj_atexit(void);
extern void genereazaPuncteCaroiaj_initialize(void);
extern void genereazaPuncteCaroiaj_terminate(void);
extern void genereazaPuncteCaroiaj_xil_terminate(void);

#endif

/*
 * File trailer for _coder_genereazaPuncteCaroiaj_api.h
 *
 * [EOF]
 */
