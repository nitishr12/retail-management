/*****************************************************************************/
/* BOOT_SPECIAL.C   v15.12.1 - Specialized boot routines                     */
/*                                                                           */
/* Copyright (c) 2013-2016 Texas Instruments Incorporated                    */
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

extern void __mpu_init(void);

/*****************************************************************************/
/* C_INT00_NOARGS() - Specialized version of _c_int00 that does not handle   */
/*                    arguments passed to main.                              */
/*****************************************************************************/
#pragma CLINK(_c_int00_noargs)
CSTART_DECL _c_int00_noargs()
{
   STACK_INIT();
   if(_system_pre_init() != 0) _auto_init();
   main(0);
   exit(1);
}

/*****************************************************************************/
/* C_INT00_NOEXIT() - Specialized version of _c_int00 that directly calls    */
/*                    abort and skips cleanup in exit.                       */
/*****************************************************************************/
#pragma CLINK(_c_int00_noexit)
CSTART_DECL _c_int00_noexit()
{
   STACK_INIT();
   if(_system_pre_init() != 0) _auto_init();
   _args_main();
   abort();
}

/*****************************************************************************/
/* C_INT00_NOINIT_NOEXIT() - Specialized version of _c_int00 that does not   */
/*                           perform auto initialization and calls abort     */
/*                           directly.                                       */
/*****************************************************************************/
#pragma CLINK(_c_int00_noinit_noargs_noexit)
CSTART_DECL _c_int00_noinit_noargs_noexit()
{
   STACK_INIT();
   _system_pre_init();
   main(0);
   abort();
}

/*****************************************************************************/
/* C_INT00_NOINIT_NOEXIT() - Specialized version of _c_int00 that does not   */
/*                           perform auto initialization and calls abort     */
/*                           directly.                                       */
/*****************************************************************************/
#pragma CLINK(_c_int00_noargs_noexit)
CSTART_DECL _c_int00_noargs_noexit()
{
   STACK_INIT();
   if (_system_pre_init() != 0) _auto_init();
   main(0);
   abort();
}

/*****************************************************************************/
/* C_INT00_MPU_INIT() - Specialized version of _c_int00 that initializes the */
/*                      FRAM memory protection unit.                         */
/*****************************************************************************/
#pragma CLINK(_c_int00_mpu)
CSTART_DECL _c_int00_mpu()
{
   STACK_INIT();
   __mpu_init();
   if(_system_pre_init() != 0)  _auto_init();
   _args_main();
   exit(1);
}

/*****************************************************************************/
/* C_INT00_NOARGS_MPU_INIT() - Specialized version of _c_int00 that          */ 
/*                             initializes the FRAM memory protection unit   */
/*                             and does not handle arguments passed to main. */
/*****************************************************************************/
#pragma CLINK(_c_int00_noargs_mpu)
CSTART_DECL _c_int00_noargs_mpu()
{
   STACK_INIT();
   __mpu_init();
   if(_system_pre_init() != 0) _auto_init();
   main(0);
   exit(1);
}

/*****************************************************************************/
/* C_INT00_NOEXIT_MPU_INIT() - Specialized version of _c_int00 that          */
/*                             initializes the FRAM memory protection unit   */
/*                             and directly calls abort and skips cleanup in */
/*                             exit.                                         */
/*****************************************************************************/
#pragma CLINK(_c_int00_noexit_mpu)
CSTART_DECL _c_int00_noexit_mpu()
{
   STACK_INIT();
   __mpu_init();
   if(_system_pre_init() != 0) _auto_init();
   _args_main();
   abort();
}

/*****************************************************************************/
/* C_INT00_NOINIT_NOEXIT_MPU_INIT() - Specialized version of _c_int00 that   */
/*                                    initializes the FRAM memory protection */
/*                                    unit and does not perform auto         */
/*                                    initialization and calls abort         */
/*                                    directly.                              */
/*****************************************************************************/
#pragma CLINK(_c_int00_noinit_noargs_noexit_mpu)
CSTART_DECL _c_int00_noinit_noargs_noexit_mpu()
{
   STACK_INIT();
   __mpu_init();
   _system_pre_init();
   main(0);
   abort();
}

/*****************************************************************************/
/* C_INT00_NOINIT_NOEXIT_MPU_INIT() - Specialized version of _c_int00 that   */
/*                                    initializes the FRAM memory protection */
/*                                    unit and does not perform auto         */
/*                                    initialization and calls abort         */
/*                                    directly.                              */
/*****************************************************************************/
#pragma CLINK(_c_int00_noargs_noexit_mpu)
CSTART_DECL _c_int00_noargs_noexit_mpu()
{
   STACK_INIT();
   __mpu_init();
   if (_system_pre_init() != 0) _auto_init();
   main(0);
   abort();
}


