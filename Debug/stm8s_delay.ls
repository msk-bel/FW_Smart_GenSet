   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _ticsOverflowCounter:
  16  0000 00000000      	dc.l	0
  66                     ; 5 void delay_us(unsigned int  value)
  66                     ; 6 {
  68                     	switch	.text
  69  0000               _delay_us:
  71  0000 89            	pushw	x
  72       00000002      OFST:	set	2
  75                     ; 7 	register unsigned int loops =  (dly_const * value) ;
  77  0001 cd0000        	call	c_uitof
  79  0004 ae0004        	ldw	x,#L73
  80  0007 cd0000        	call	c_fmul
  82  000a cd0000        	call	c_ftoi
  84  000d 1f01          	ldw	(OFST-1,sp),x
  87  000f 2008          	jra	L74
  88  0011               L34:
  89                     ; 11 		_asm ("nop");
  92  0011 9d            nop
  94                     ; 12 		loops--;
  96  0012 1e01          	ldw	x,(OFST-1,sp)
  97  0014 1d0001        	subw	x,#1
  98  0017 1f01          	ldw	(OFST-1,sp),x
 100  0019               L74:
 101                     ; 9 	while(loops)
 103  0019 1e01          	ldw	x,(OFST-1,sp)
 104  001b 26f4          	jrne	L34
 105                     ; 14 }
 109  001d 85            	popw	x
 110  001e 81            	ret
 145                     ; 17 void delay_ms(unsigned int  value)
 145                     ; 18 {
 146                     	switch	.text
 147  001f               _delay_ms:
 149  001f 89            	pushw	x
 150       00000000      OFST:	set	0
 153  0020 200c          	jra	L37
 154  0022               L17:
 155                     ; 21 		delay_us(1000);
 157  0022 ae03e8        	ldw	x,#1000
 158  0025 add9          	call	_delay_us
 160                     ; 22 		value--;
 162  0027 1e01          	ldw	x,(OFST+1,sp)
 163  0029 1d0001        	subw	x,#1
 164  002c 1f01          	ldw	(OFST+1,sp),x
 165  002e               L37:
 166                     ; 19 	while(value)
 168  002e 1e01          	ldw	x,(OFST+1,sp)
 169  0030 26f0          	jrne	L17
 170                     ; 24 }
 174  0032 85            	popw	x
 175  0033 81            	ret
 211                     .const:	section	.text
 212  0000               L21:
 213  0000 0000ffff      	dc.l	65535
 214                     ; 26 uint32_t getTics(void)
 214                     ; 27 {  
 215                     	switch	.text
 216  0034               _getTics:
 218  0034 5206          	subw	sp,#6
 219       00000006      OFST:	set	6
 222                     ; 28   uint16_t getTimerTics=TIM2_GetCounter();
 224  0036 cd0000        	call	_TIM2_GetCounter
 226  0039 1f05          	ldw	(OFST-1,sp),x
 228                     ; 29  	return (uint32_t)ticsOverflowCounter*timer2MaxCount+getTimerTics;
 230  003b 1e05          	ldw	x,(OFST-1,sp)
 231  003d cd0000        	call	c_uitolx
 233  0040 96            	ldw	x,sp
 234  0041 1c0001        	addw	x,#OFST-5
 235  0044 cd0000        	call	c_rtol
 238  0047 ae0000        	ldw	x,#_ticsOverflowCounter
 239  004a cd0000        	call	c_ltor
 241  004d ae0000        	ldw	x,#L21
 242  0050 cd0000        	call	c_lmul
 244  0053 96            	ldw	x,sp
 245  0054 1c0001        	addw	x,#OFST-5
 246  0057 cd0000        	call	c_ladd
 250  005a 5b06          	addw	sp,#6
 251  005c 81            	ret
 276                     	xdef	_ticsOverflowCounter
 277                     	xdef	_getTics
 278                     	xdef	_delay_ms
 279                     	xdef	_delay_us
 280                     	xref	_TIM2_GetCounter
 281                     	switch	.const
 282  0004               L73:
 283  0004 3f800000      	dc.w	16256,0
 284                     	xref.b	c_x
 304                     	xref	c_ladd
 305                     	xref	c_rtol
 306                     	xref	c_uitolx
 307                     	xref	c_lmul
 308                     	xref	c_ltor
 309                     	xref	c_ftoi
 310                     	xref	c_fmul
 311                     	xref	c_uitof
 312                     	end
