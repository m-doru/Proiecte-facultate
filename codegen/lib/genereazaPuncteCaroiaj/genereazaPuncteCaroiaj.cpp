//
// File: genereazaPuncteCaroiaj.cpp
//
// MATLAB Coder version            : 3.1
// C/C++ source code generated on  : 08-Dec-2016 16:43:58
//

// Include Files
#include "rt_nonfinite.h"
#include "genereazaPuncteCaroiaj.h"
#include "genereazaPuncteCaroiaj_emxutil.h"

// Function Declarations
static double rt_roundd_snf(double u);

// Function Definitions

//
// Arguments    : double u
// Return Type  : double
//
static double rt_roundd_snf(double u)
{
  double y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

//
// genereaza puncte pe baza unui caroiaj
//  un caroiaj este o retea de drepte orizontale si verticale de forma urmatoare:
//
//         |   |   |   |
//       --+---+---+---+--
//         |   |   |   |
//       --+---+---+---+--
//         |   |   |   |
//       --+---+---+---+--
//         |   |   |   |
//       --+---+---+---+--
//         |   |   |   |
//
//  Input:
//        img - imaginea input
//        nrPuncteX - numarul de drepte verticale folosit la constructia caroiajului
//                  - in desenul de mai sus aceste drepte sunt identificate cu simbolul |
//        nrPuncteY - numarul de drepte orizontale folosit la constructia caroiajului
//                  - in desenul de mai sus aceste drepte sunt identificate cu simbolul --
//          margine - numarul de pixeli de la marginea imaginii (sus, jos, stanga, dreapta) pentru care nu se considera puncte
//  Output:
//        puncteCaroiaj - matrice (nrPuncteX * nrPuncteY) X 2
//                      - fiecare linie reprezinta un punct (y,x) de pe caroiaj aflat la intersectia dreptelor orizontale si verticale
//                      - in desenul de mai sus aceste puncte sunt idenficate cu semnul +
// Arguments    : const emxArray_uint8_T *img
//                int nrPuncteX
//                int nrPuncteY
//                int margine
//                emxArray_real_T *puncteCaroiaj
// Return Type  : void
//
void genereazaPuncteCaroiaj(const emxArray_uint8_T *img, int nrPuncteX, int
  nrPuncteY, int margine, emxArray_real_T *puncteCaroiaj)
{
  int i0;
  long long i1;
  int loop_ub;
  double d0;
  int nrLinii;
  int nrColoane;
  int y;
  unsigned int b_y;
  unsigned int c_y;
  unsigned int q;
  int d_y;
  int e_y;
  int punct_start[2];
  int i;
  int j;
  i0 = puncteCaroiaj->size[0] * puncteCaroiaj->size[1];
  i1 = (long long)nrPuncteX * nrPuncteY;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  puncteCaroiaj->size[0] = (int)i1;
  puncteCaroiaj->size[1] = 2;
  emxEnsureCapacity((emxArray__common *)puncteCaroiaj, i0, (int)sizeof(double));
  i1 = (long long)nrPuncteX * nrPuncteY;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  loop_ub = (int)i1 << 1;
  for (i0 = 0; i0 < loop_ub; i0++) {
    puncteCaroiaj->data[i0] = 0.0;
  }

  // completati codul
  i0 = margine;
  if (i0 > 1073741823) {
    i0 = MAX_int32_T;
  } else if (i0 <= -1073741824) {
    i0 = MIN_int32_T;
  } else {
    i0 <<= 1;
  }

  d0 = (double)img->size[0] - (double)i0;
  if (d0 < 2.147483648E+9) {
    if (d0 >= -2.147483648E+9) {
      i0 = (int)d0;
    } else {
      i0 = MIN_int32_T;
    }
  } else {
    i0 = MAX_int32_T;
  }

  nrLinii = i0;
  i0 = margine;
  if (i0 > 1073741823) {
    i0 = MAX_int32_T;
  } else if (i0 <= -1073741824) {
    i0 = MIN_int32_T;
  } else {
    i0 <<= 1;
  }

  d0 = (double)img->size[1] - (double)i0;
  if (d0 < 2.147483648E+9) {
    if (d0 >= -2.147483648E+9) {
      i0 = (int)d0;
    } else {
      i0 = MIN_int32_T;
    }
  } else {
    i0 = MAX_int32_T;
  }

  nrColoane = i0;
  i1 = nrPuncteX - 1LL;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  loop_ub = (int)i1;
  if (loop_ub == 0) {
    if (nrColoane == 0) {
      y = 0;
    } else if (nrColoane < 0) {
      y = MIN_int32_T;
    } else {
      y = MAX_int32_T;
    }
  } else if (loop_ub == 1) {
    y = nrColoane;
  } else if (loop_ub == -1) {
    y = -nrColoane;
  } else {
    if (nrColoane >= 0) {
      b_y = (unsigned int)nrColoane;
    } else {
      b_y = (unsigned int)-nrColoane;
    }

    if (loop_ub >= 0) {
      c_y = (unsigned int)loop_ub;
    } else if (loop_ub == MIN_int32_T) {
      c_y = 2147483648U;
    } else {
      c_y = (unsigned int)-loop_ub;
    }

    if (c_y == 0U) {
      q = MAX_uint32_T;
    } else {
      q = b_y / c_y;
    }

    b_y -= q * c_y;
    if ((b_y > 0U) && (b_y >= (c_y >> 1U) + (c_y & 1U))) {
      q++;
    }

    y = (int)q;
    if ((nrColoane < 0) != (loop_ub < 0)) {
      y = -(int)q;
    }
  }

  i1 = nrPuncteY - 1LL;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  loop_ub = (int)i1;
  if (loop_ub == 0) {
    if (nrLinii == 0) {
      d_y = 0;
    } else if (nrLinii < 0) {
      d_y = MIN_int32_T;
    } else {
      d_y = MAX_int32_T;
    }
  } else if (loop_ub == 1) {
    d_y = nrLinii;
  } else if (loop_ub == -1) {
    d_y = -nrLinii;
  } else {
    if (nrLinii >= 0) {
      b_y = (unsigned int)nrLinii;
    } else {
      b_y = (unsigned int)-nrLinii;
    }

    if (loop_ub >= 0) {
      c_y = (unsigned int)loop_ub;
    } else if (loop_ub == MIN_int32_T) {
      c_y = 2147483648U;
    } else {
      c_y = (unsigned int)-loop_ub;
    }

    if (c_y == 0U) {
      q = MAX_uint32_T;
    } else {
      q = b_y / c_y;
    }

    b_y -= q * c_y;
    if ((b_y > 0U) && (b_y >= (c_y >> 1U) + (c_y & 1U))) {
      q++;
    }

    d_y = (int)q;
    if ((nrLinii < 0) != (loop_ub < 0)) {
      d_y = -(int)q;
    }
  }

  i1 = nrPuncteX - 1LL;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  i1 = (long long)y * (int)i1;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  i1 = (long long)nrColoane - (int)i1;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  e_y = (int)rt_roundd_snf((double)(int)i1 / 2.0);
  i1 = nrPuncteY - 1LL;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  i1 = (long long)d_y * (int)i1;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  i1 = (long long)nrColoane - (int)i1;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  i0 = (int)rt_roundd_snf((double)(int)i1 / 2.0);
  i1 = (long long)margine + i0;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  punct_start[0] = (int)i1;
  i1 = (long long)margine + e_y;
  if (i1 > 2147483647LL) {
    i1 = 2147483647LL;
  } else {
    if (i1 < -2147483648LL) {
      i1 = -2147483648LL;
    }
  }

  punct_start[1] = (int)i1;
  for (i = 1; i <= nrPuncteY; i++) {
    for (j = 1; j <= nrPuncteX; j++) {
      i1 = i - 1LL;
      if (i1 > 2147483647LL) {
        i1 = 2147483647LL;
      } else {
        if (i1 < -2147483648LL) {
          i1 = -2147483648LL;
        }
      }

      i1 = (long long)(int)i1 * nrPuncteY;
      if (i1 > 2147483647LL) {
        i1 = 2147483647LL;
      } else {
        if (i1 < -2147483648LL) {
          i1 = -2147483648LL;
        }
      }

      i1 = (long long)(int)i1 + j;
      if (i1 > 2147483647LL) {
        i1 = 2147483647LL;
      } else {
        if (i1 < -2147483648LL) {
          i1 = -2147483648LL;
        }
      }

      loop_ub = (int)i1;
      for (i0 = 0; i0 < 2; i0++) {
        puncteCaroiaj->data[(loop_ub + puncteCaroiaj->size[0] * i0) - 1] =
          punct_start[i0];
      }

      i1 = (long long)punct_start[1] + y;
      if (i1 > 2147483647LL) {
        i1 = 2147483647LL;
      } else {
        if (i1 < -2147483648LL) {
          i1 = -2147483648LL;
        }
      }

      punct_start[1] = (int)i1;
    }

    i1 = (long long)punct_start[0] + d_y;
    if (i1 > 2147483647LL) {
      i1 = 2147483647LL;
    } else {
      if (i1 < -2147483648LL) {
        i1 = -2147483648LL;
      }
    }

    punct_start[0] = (int)i1;
    i1 = (long long)margine + e_y;
    if (i1 > 2147483647LL) {
      i1 = 2147483647LL;
    } else {
      if (i1 < -2147483648LL) {
        i1 = -2147483648LL;
      }
    }

    punct_start[1] = (int)i1;
  }
}

//
// File trailer for genereazaPuncteCaroiaj.cpp
//
// [EOF]
//
