/*
 * Copyright (c) 2015-2015 Texas Instruments Incorporated
 *
 * e_lgammaf.c -- float version of e_lgamma.c.
 * Conversion to float by Ian Lance Taylor, Cygnus Support, ian@cygnus.com.
 */

/*
 * ====================================================
 * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
 *
 * Developed at SunPro, a Sun Microsystems, Inc. business.
 * Permission to use, copy, modify, and distribute this
 * software is freely granted, provided that this notice
 * is preserved.
 * ====================================================
 */

/* lgammaf(x)
 * Return the logarithm of the Gamma function of x.
 *
 * Method: call lgammaf_r
 */

#include <float.h>
#define __BSD_VISIBLE 1
#include "math.h"
#include "math_private.h"

float
lgammaf(float x)
{
        int signgam;

	return __lgammaf_r(x,&signgam);
}

#if DBL_MANT_DIG == FLT_MANT_DIG
double lgamma(double x) __attribute__((__alias__("lgammaf")));
#endif

#if LDBL_MANT_DIG == FLT_MANT_DIG
long double lgammal(long double x) __attribute__((__alias__("lgammaf")));
#endif
