;******************************************************************************
;* MULT1632_F5HW.ASM - v15.12.1                                               *
;*                                                                            *
;* Copyright (c) 2011-2016 Texas Instruments Incorporated                     *
;* http://www.ti.com/                                                         *
;*                                                                            *
;*  Redistribution and  use in source  and binary forms, with  or without     *
;*  modification,  are permitted provided  that the  following conditions     *
;*  are met:                                                                  *
;*                                                                            *
;*     Redistributions  of source  code must  retain the  above copyright     *
;*     notice, this list of conditions and the following disclaimer.          *
;*                                                                            *
;*     Redistributions in binary form  must reproduce the above copyright     *
;*     notice, this  list of conditions  and the following  disclaimer in     *
;*     the  documentation  and/or   other  materials  provided  with  the     *
;*     distribution.                                                          *
;*                                                                            *
;*     Neither the  name of Texas Instruments Incorporated  nor the names     *
;*     of its  contributors may  be used to  endorse or  promote products     *
;*     derived  from   this  software  without   specific  prior  written     *
;*     permission.                                                            *
;*                                                                            *
;*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS     *
;*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT     *
;*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR     *
;*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT     *
;*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,     *
;*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT     *
;*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,     *
;*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY     *
;*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT     *
;*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE     *
;*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.      *
;*                                                                            *
;******************************************************************************
;****************************************************************************
;* __mpysl_f5hw   (int32 = (int32)int16 * (int32)int16)
;*  
;*   - Operand 1 is in R12
;*   - Operand 2 is in R13
;*   - Result is in R13:R12
;*
;* To ensure that the multiply is performed atomically, interrupts are disabled
;* upon routine entry. Interrupt state is restored upon exit.
;;
;*   Registers used:  R12,R13
;****************************************************************************
OP1		.equ    R12
OP2		.equ	R13
MPYU_OP1	.equ	0x04C0
MPYS_OP1	.equ	0x04C2
MPY_OP2		.equ	0x04C8
RESULT_LO	.equ	0x04CA
RESULT_HI	.equ	0x04CC

     .if __TI_EABI__
        .asg __mspabi_mpysl_f5hw, __mpysl_f5hw
        .asg __mspabi_mpyul_f5hw, __mpyul_f5hw
     .endif

     .if $DEFINED(__LARGE_CODE_MODEL__)
        .asg  4, RETADDRSZ
     .else
        .asg  2, RETADDRSZ
     .endif

        .global __mpysl_f5hw
	.sect	".text:__mpysl"
	.clink
	.align 2
__mpysl_f5hw:  .asmfunc  stack_usage(2 + RETADDRSZ)
	PUSH.W	SR			; Save current interrupt state
	DINT				; Disable interrupts
	NOP				; Account for latency
	MOV.W	OP1,&MPYS_OP1		; Load operand 1 into multiplier
	MOV.W	OP2,&MPY_OP2		; Load operand 2 which triggers MPY
	MOV.W	&RESULT_LO, R12		; Move result into return register
	MOV.W	&RESULT_HI, R13		; Move result into return register
    .if $DEFINED(__LARGE_CODE_MODEL__)
	POP.W  SR
        NOP                             ; CPU19 Compatibility
        RETA
    .else
	RETI
    .endif
	.endasmfunc

;****************************************************************************
;* __mpyul_f5hw   (int32 = (int32)uint16 * (int32)uint16)
;*  
;*   - Operand 1 is in R12
;*   - Operand 2 is in R13
;*   - Result is in R13:R12
;*
;* To ensure that the multiply is performed atomically, interrupts are disabled
;* upon routine entry. Interrupt state is restored upon exit.
;;
;*   Registers used:  R12,R13
;****************************************************************************
        .global __mpyul_f5hw
	.sect	".text:__mpyul"
	.clink
	.align 2
__mpyul_f5hw:  .asmfunc  stack_usage(2 + RETADDRSZ)
	PUSH.W	SR			; Save current interrupt state
	DINT				; Disable interrupts
	NOP				; Account for latency
	MOV.W	OP1,&MPYU_OP1		; Load operand 1 into multiplier
	MOV.W	OP2,&MPY_OP2		; Load operand 2 which triggers MPY
	MOV.W	&RESULT_LO, R12		; Move result into return register
	MOV.W	&RESULT_HI, R13		; Move result into return register
    .if $DEFINED(__LARGE_CODE_MODEL__)
	POP.W  SR
        NOP                             ; CPU19 Compatibility
        RETA
    .else
	RETI
    .endif
	.endasmfunc

;******************************************************************************
;* BUILD ATTRIBUTES                                                           *
;*    HW_MPY_INLINE_INFO=1:  file does not have any inlined hw mpy            *
;*    HW_MPY_ISR_INFO   =1:  file does not have ISR's with mpy or func calls  *
;******************************************************************************
	.battr "TI", Tag_File, 1, Tag_HW_MPY_INLINE_INFO(1)
	.battr "TI", Tag_File, 1, Tag_HW_MPY_ISR_INFO(1)
