/*****************************************************************************/
/* BOOT.C   v15.12.1 - Initialize the MSP430 C runtime environment           */
/*                                                                           */
/* Copyright (c) 2003-2016 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/
#include "boot.h"
#include "boot_hooks.h"

#ifdef __TI_RTS_BUILD
/*---------------------------------------------------------------------------*/
/* __TI_default_c_int00 indicates that the default TI entry routine is being  */
/* used.  The linker makes assumptions about what exit does when this symbol */
/* is seen. This symbols should NOT be defined if a customized exit routine  */
/* is used.                                                                  */
/*---------------------------------------------------------------------------*/
__asm("__TI_default_c_int00 .set 1");
#endif

/*---------------------------------------------------------------------------*/
/* Allocate the memory for the system stack.  This section will be sized     */
/* by the linker.                                                            */
/*---------------------------------------------------------------------------*/
#pragma DATA_SECTION (_stack, ".stack");
#if defined(__LARGE_DATA_MODEL__)
long _stack;
#else
int _stack;
#endif

__asm("\t.global _c_int00");
__asm("\t.global _reset_vector");
__asm("\t.sect   \".reset\"");
__asm("\t.align  2");
__asm("_reset_vector:\n\t.field _c_int00, 16");

/*****************************************************************************/
/* C_INT00() - C ENVIRONMENT ENTRY POINT                                     */
/*****************************************************************************/
#pragma CLINK(_c_int00)
CSTART_DECL _c_int00()
{
   STACK_INIT();

   /*------------------------------------------------------------------------*/
   /* Allow for any application-specific low level initialization prior to   */
   /* initializing the C/C++ environment (global variable initialization,    */
   /* constructers).  If _system_pre_init() returns 0, then bypass C/C++     */
   /* initialization.  NOTE: BYPASSING THE CALL TO THE C/C++ INITIALIZATION  */
   /* ROUTINE MAY RESULT IN PROGRAM FAILURE.                                 */
   /*------------------------------------------------------------------------*/
   if(_system_pre_init() != 0)  _auto_init();

   /*------------------------------------------------------------------------*/
   /* Handle any argc/argv arguments if supported by an MSP430 loader.       */
   /*------------------------------------------------------------------------*/
   _args_main();

   exit(1);
}
