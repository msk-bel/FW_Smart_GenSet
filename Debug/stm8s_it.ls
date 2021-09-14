   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _voltCurrent1OverflowCount:
  16  0000 00            	dc.b	0
  17  0001               _voltCurrent2OverflowCount:
  18  0001 00            	dc.b	0
  19  0002               _voltCurrent3OverflowCount:
  20  0002 00            	dc.b	0
  21  0003               _power1OverflowCount:
  22  0003 00            	dc.b	0
  23  0004               _power2OverflowCount:
  24  0004 00            	dc.b	0
  25  0005               _power3OverflowCount:
  26  0005 00            	dc.b	0
  27                     .bit:	section	.data,bit
  28  0000               _power1ReadFlag:
  29  0000 00            	dc.b	0
  30  0001               _power2ReadFlag:
  31  0001 00            	dc.b	0
  32  0002               _power3ReadFlag:
  33  0002 00            	dc.b	0
  34                     	bsct
  35  0006               _timeoutForUART:
  36  0006 0000          	dc.w	0
  37                     	switch	.bit
  38  0003               _uartDataReadytoRead:
  39  0003 00            	dc.b	0
  40                     	bsct
  41  0008               _storeEnergyPhase1:
  42  0008 00000000      	dc.l	0
  43  000c               _storeEnergyPhase2:
  44  000c 00000000      	dc.l	0
  45  0010               _storeEnergyPhase3:
  46  0010 00000000      	dc.l	0
  47  0014               _powerAccumulateCount:
  48  0014 00            	dc.b	0
 100                     .const:	section	.text
 101  0000               L6:
 102  0000 02255100      	dc.l	36000000
 103                     ; 76 void TIM1_IRQHandler(void) //to measure energy
 103                     ; 77 {
 104                     	switch	.text
 105  0000               f_TIM1_IRQHandler:
 107  0000 8a            	push	cc
 108  0001 84            	pop	a
 109  0002 a4bf          	and	a,#191
 110  0004 88            	push	a
 111  0005 86            	pop	cc
 112       00000008      OFST:	set	8
 113  0006 3b0002        	push	c_x+2
 114  0009 be00          	ldw	x,c_x
 115  000b 89            	pushw	x
 116  000c 3b0002        	push	c_y+2
 117  000f be00          	ldw	x,c_y
 118  0011 89            	pushw	x
 119  0012 be02          	ldw	x,c_lreg+2
 120  0014 89            	pushw	x
 121  0015 be00          	ldw	x,c_lreg
 122  0017 89            	pushw	x
 123  0018 5208          	subw	sp,#8
 126                     ; 78   voltCurrent1OverflowCount++;
 128  001a 3c00          	inc	_voltCurrent1OverflowCount
 129                     ; 79   voltCurrent2OverflowCount++;//Added by Saqib
 131  001c 3c01          	inc	_voltCurrent2OverflowCount
 132                     ; 80   if (powerAccumulateCount > powerAccumulateCountMax)
 134  001e b614          	ld	a,_powerAccumulateCount
 135  0020 a13b          	cp	a,#59
 136  0022 2404          	jruge	L01
 137  0024 ac8c018c      	jpf	L12
 138  0028               L01:
 139                     ; 83     if (powerPeriod1 != 0)
 141  0028 ae0000        	ldw	x,#_powerPeriod1
 142  002b cd0000        	call	c_lzmp
 144  002e 276e          	jreq	L32
 145                     ; 85       storeEnergyPhase1 = storeEnergyPhase1 + ((float)(powerMultiplier * powerCalibrationFactor1) / powerPeriod1) * powerAccumulateTime;
 147  0030 ae0000        	ldw	x,#_powerPeriod1
 148  0033 cd0000        	call	c_ltor
 150  0036 cd0000        	call	c_ultof
 152  0039 96            	ldw	x,sp
 153  003a 1c0005        	addw	x,#OFST-3
 154  003d cd0000        	call	c_rtol
 157  0040 be00          	ldw	x,_powerCalibrationFactor1
 158  0042 cd0000        	call	c_uitof
 160  0045 ae0008        	ldw	x,#L13
 161  0048 cd0000        	call	c_fmul
 163  004b 96            	ldw	x,sp
 164  004c 1c0005        	addw	x,#OFST-3
 165  004f cd0000        	call	c_fdiv
 167  0052 ae0004        	ldw	x,#L14
 168  0055 cd0000        	call	c_fmul
 170  0058 96            	ldw	x,sp
 171  0059 1c0001        	addw	x,#OFST-7
 172  005c cd0000        	call	c_rtol
 175  005f ae0008        	ldw	x,#_storeEnergyPhase1
 176  0062 cd0000        	call	c_ltor
 178  0065 cd0000        	call	c_ultof
 180  0068 96            	ldw	x,sp
 181  0069 1c0001        	addw	x,#OFST-7
 182  006c cd0000        	call	c_fadd
 184  006f cd0000        	call	c_ftol
 186  0072 ae0008        	ldw	x,#_storeEnergyPhase1
 187  0075 cd0000        	call	c_rtol
 189                     ; 87       if ((storeEnergyPhase1 >= energyResolution))
 191  0078 ae0008        	ldw	x,#_storeEnergyPhase1
 192  007b cd0000        	call	c_ltor
 194  007e ae0000        	ldw	x,#L6
 195  0081 cd0000        	call	c_lcmp
 197  0084 2518          	jrult	L32
 198                     ; 89         energyPhase1++;
 200  0086 ae0010        	ldw	x,#_energyPhase1
 201  0089 a601          	ld	a,#1
 202  008b cd0000        	call	c_lgadc
 204                     ; 90         storeEnergyPhase1 = storeEnergyPhase1 - energyResolution;
 206  008e ae5100        	ldw	x,#20736
 207  0091 bf02          	ldw	c_lreg+2,x
 208  0093 ae0225        	ldw	x,#549
 209  0096 bf00          	ldw	c_lreg,x
 210  0098 ae0008        	ldw	x,#_storeEnergyPhase1
 211  009b cd0000        	call	c_lgsub
 213  009e               L32:
 214                     ; 94     if (powerPeriod2 != 0)
 216  009e ae0000        	ldw	x,#_powerPeriod2
 217  00a1 cd0000        	call	c_lzmp
 219  00a4 276e          	jreq	L74
 220                     ; 96       storeEnergyPhase2 = storeEnergyPhase2 + ((float)(powerMultiplier * powerCalibrationFactor2) / powerPeriod2) * powerAccumulateTime;
 222  00a6 ae0000        	ldw	x,#_powerPeriod2
 223  00a9 cd0000        	call	c_ltor
 225  00ac cd0000        	call	c_ultof
 227  00af 96            	ldw	x,sp
 228  00b0 1c0005        	addw	x,#OFST-3
 229  00b3 cd0000        	call	c_rtol
 232  00b6 be00          	ldw	x,_powerCalibrationFactor2
 233  00b8 cd0000        	call	c_uitof
 235  00bb ae0008        	ldw	x,#L13
 236  00be cd0000        	call	c_fmul
 238  00c1 96            	ldw	x,sp
 239  00c2 1c0005        	addw	x,#OFST-3
 240  00c5 cd0000        	call	c_fdiv
 242  00c8 ae0004        	ldw	x,#L14
 243  00cb cd0000        	call	c_fmul
 245  00ce 96            	ldw	x,sp
 246  00cf 1c0001        	addw	x,#OFST-7
 247  00d2 cd0000        	call	c_rtol
 250  00d5 ae000c        	ldw	x,#_storeEnergyPhase2
 251  00d8 cd0000        	call	c_ltor
 253  00db cd0000        	call	c_ultof
 255  00de 96            	ldw	x,sp
 256  00df 1c0001        	addw	x,#OFST-7
 257  00e2 cd0000        	call	c_fadd
 259  00e5 cd0000        	call	c_ftol
 261  00e8 ae000c        	ldw	x,#_storeEnergyPhase2
 262  00eb cd0000        	call	c_rtol
 264                     ; 98       if ((storeEnergyPhase2 >= energyResolution))
 266  00ee ae000c        	ldw	x,#_storeEnergyPhase2
 267  00f1 cd0000        	call	c_ltor
 269  00f4 ae0000        	ldw	x,#L6
 270  00f7 cd0000        	call	c_lcmp
 272  00fa 2518          	jrult	L74
 273                     ; 100         energyPhase2++;
 275  00fc ae000c        	ldw	x,#_energyPhase2
 276  00ff a601          	ld	a,#1
 277  0101 cd0000        	call	c_lgadc
 279                     ; 101         storeEnergyPhase2 = storeEnergyPhase2 - energyResolution;
 281  0104 ae5100        	ldw	x,#20736
 282  0107 bf02          	ldw	c_lreg+2,x
 283  0109 ae0225        	ldw	x,#549
 284  010c bf00          	ldw	c_lreg,x
 285  010e ae000c        	ldw	x,#_storeEnergyPhase2
 286  0111 cd0000        	call	c_lgsub
 288  0114               L74:
 289                     ; 105     if (powerPeriod3 != 0)
 291  0114 ae0000        	ldw	x,#_powerPeriod3
 292  0117 cd0000        	call	c_lzmp
 294  011a 276e          	jreq	L35
 295                     ; 107       storeEnergyPhase3 = storeEnergyPhase3 + ((float)(powerMultiplier * powerCalibrationFactor3) / powerPeriod3) * powerAccumulateTime;
 297  011c ae0000        	ldw	x,#_powerPeriod3
 298  011f cd0000        	call	c_ltor
 300  0122 cd0000        	call	c_ultof
 302  0125 96            	ldw	x,sp
 303  0126 1c0005        	addw	x,#OFST-3
 304  0129 cd0000        	call	c_rtol
 307  012c be00          	ldw	x,_powerCalibrationFactor3
 308  012e cd0000        	call	c_uitof
 310  0131 ae0008        	ldw	x,#L13
 311  0134 cd0000        	call	c_fmul
 313  0137 96            	ldw	x,sp
 314  0138 1c0005        	addw	x,#OFST-3
 315  013b cd0000        	call	c_fdiv
 317  013e ae0004        	ldw	x,#L14
 318  0141 cd0000        	call	c_fmul
 320  0144 96            	ldw	x,sp
 321  0145 1c0001        	addw	x,#OFST-7
 322  0148 cd0000        	call	c_rtol
 325  014b ae0010        	ldw	x,#_storeEnergyPhase3
 326  014e cd0000        	call	c_ltor
 328  0151 cd0000        	call	c_ultof
 330  0154 96            	ldw	x,sp
 331  0155 1c0001        	addw	x,#OFST-7
 332  0158 cd0000        	call	c_fadd
 334  015b cd0000        	call	c_ftol
 336  015e ae0010        	ldw	x,#_storeEnergyPhase3
 337  0161 cd0000        	call	c_rtol
 339                     ; 109       if ((storeEnergyPhase3 >= energyResolution))
 341  0164 ae0010        	ldw	x,#_storeEnergyPhase3
 342  0167 cd0000        	call	c_ltor
 344  016a ae0000        	ldw	x,#L6
 345  016d cd0000        	call	c_lcmp
 347  0170 2518          	jrult	L35
 348                     ; 111         energyPhase3++;
 350  0172 ae0008        	ldw	x,#_energyPhase3
 351  0175 a601          	ld	a,#1
 352  0177 cd0000        	call	c_lgadc
 354                     ; 112         storeEnergyPhase3 = storeEnergyPhase3 - energyResolution;
 356  017a ae5100        	ldw	x,#20736
 357  017d bf02          	ldw	c_lreg+2,x
 358  017f ae0225        	ldw	x,#549
 359  0182 bf00          	ldw	c_lreg,x
 360  0184 ae0010        	ldw	x,#_storeEnergyPhase3
 361  0187 cd0000        	call	c_lgsub
 363  018a               L35:
 364                     ; 116     powerAccumulateCount = 0;
 366  018a 3f14          	clr	_powerAccumulateCount
 367  018c               L12:
 368                     ; 119   if (power1OverflowCount < powerOverflowCountMax)
 370  018c b603          	ld	a,_power1OverflowCount
 371  018e a164          	cp	a,#100
 372  0190 2404          	jruge	L75
 373                     ; 121     power1OverflowCount++;
 375  0192 3c03          	inc	_power1OverflowCount
 377  0194 201a          	jra	L16
 378  0196               L75:
 379                     ; 125     powerPeriod1 = 0;
 381  0196 ae0000        	ldw	x,#0
 382  0199 bf02          	ldw	_powerPeriod1+2,x
 383  019b ae0000        	ldw	x,#0
 384  019e bf00          	ldw	_powerPeriod1,x
 385                     ; 126     Watt_Phase1 = 0; // Added By Saqib
 387  01a0 ae0000        	ldw	x,#0
 388  01a3 cf0002        	ldw	_Watt_Phase1+2,x
 389  01a6 ae0000        	ldw	x,#0
 390  01a9 cf0000        	ldw	_Watt_Phase1,x
 391                     ; 127     power1ReadFlag = false;
 393  01ac 72110000      	bres	_power1ReadFlag
 394  01b0               L16:
 395                     ; 133   if (power2OverflowCount < powerOverflowCountMax)
 397  01b0 b604          	ld	a,_power2OverflowCount
 398  01b2 a164          	cp	a,#100
 399  01b4 2404          	jruge	L36
 400                     ; 135     power2OverflowCount++;
 402  01b6 3c04          	inc	_power2OverflowCount
 404  01b8 201a          	jra	L56
 405  01ba               L36:
 406                     ; 139     powerPeriod2 = 0;
 408  01ba ae0000        	ldw	x,#0
 409  01bd bf02          	ldw	_powerPeriod2+2,x
 410  01bf ae0000        	ldw	x,#0
 411  01c2 bf00          	ldw	_powerPeriod2,x
 412                     ; 140     power2ReadFlag = false;
 414  01c4 72110001      	bres	_power2ReadFlag
 415                     ; 141     Watt_Phase2 = 0; // Added By Saqib
 417  01c8 ae0000        	ldw	x,#0
 418  01cb cf0002        	ldw	_Watt_Phase2+2,x
 419  01ce ae0000        	ldw	x,#0
 420  01d1 cf0000        	ldw	_Watt_Phase2,x
 421  01d4               L56:
 422                     ; 147   powerAccumulateCount++;
 424  01d4 3c14          	inc	_powerAccumulateCount
 425                     ; 151   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 427  01d6 a601          	ld	a,#1
 428  01d8 cd0000        	call	_TIM1_ClearITPendingBit
 430                     ; 152   TIM1_ClearFlag(TIM1_FLAG_UPDATE);
 432  01db ae0001        	ldw	x,#1
 433  01de cd0000        	call	_TIM1_ClearFlag
 435                     ; 153 }
 438  01e1 5b08          	addw	sp,#8
 439  01e3 85            	popw	x
 440  01e4 bf00          	ldw	c_lreg,x
 441  01e6 85            	popw	x
 442  01e7 bf02          	ldw	c_lreg+2,x
 443  01e9 85            	popw	x
 444  01ea bf00          	ldw	c_y,x
 445  01ec 320002        	pop	c_y+2
 446  01ef 85            	popw	x
 447  01f0 bf00          	ldw	c_x,x
 448  01f2 320002        	pop	c_x+2
 449  01f5 80            	iret
 480                     ; 155 void TIM2_UPD_IRQHandler(void) //to control power,voltage,current overflow counter
 480                     ; 156 {
 481                     	switch	.text
 482  01f6               f_TIM2_UPD_IRQHandler:
 484  01f6 8a            	push	cc
 485  01f7 84            	pop	a
 486  01f8 a4bf          	and	a,#191
 487  01fa 88            	push	a
 488  01fb 86            	pop	cc
 489  01fc 3b0002        	push	c_x+2
 490  01ff be00          	ldw	x,c_x
 491  0201 89            	pushw	x
 492  0202 3b0002        	push	c_y+2
 493  0205 be00          	ldw	x,c_y
 494  0207 89            	pushw	x
 497                     ; 157   ticsOverflowCounter++;
 499  0208 ae0000        	ldw	x,#_ticsOverflowCounter
 500  020b a601          	ld	a,#1
 501  020d cd0000        	call	c_lgadc
 503                     ; 159   if (power3OverflowCount < powerOverflowCountMax)
 505  0210 b605          	ld	a,_power3OverflowCount
 506  0212 a164          	cp	a,#100
 507  0214 2404          	jruge	L77
 508                     ; 161     power3OverflowCount++;
 510  0216 3c05          	inc	_power3OverflowCount
 512  0218 201a          	jra	L101
 513  021a               L77:
 514                     ; 165     powerPeriod3 = 0;
 516  021a ae0000        	ldw	x,#0
 517  021d bf02          	ldw	_powerPeriod3+2,x
 518  021f ae0000        	ldw	x,#0
 519  0222 bf00          	ldw	_powerPeriod3,x
 520                     ; 166     Watt_Phase3 = 0; // Added By Saqib
 522  0224 ae0000        	ldw	x,#0
 523  0227 cf0002        	ldw	_Watt_Phase3+2,x
 524  022a ae0000        	ldw	x,#0
 525  022d cf0000        	ldw	_Watt_Phase3,x
 526                     ; 167     power3ReadFlag = false;
 528  0230 72110002      	bres	_power3ReadFlag
 529  0234               L101:
 530                     ; 173   voltCurrent3OverflowCount++;
 532  0234 3c02          	inc	_voltCurrent3OverflowCount
 533                     ; 175   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 535  0236 a601          	ld	a,#1
 536  0238 cd0000        	call	_TIM2_ClearITPendingBit
 538                     ; 176   TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 540  023b ae0001        	ldw	x,#1
 541  023e cd0000        	call	_TIM2_ClearFlag
 543                     ; 177 }
 546  0241 85            	popw	x
 547  0242 bf00          	ldw	c_y,x
 548  0244 320002        	pop	c_y+2
 549  0247 85            	popw	x
 550  0248 bf00          	ldw	c_x,x
 551  024a 320002        	pop	c_x+2
 552  024d 80            	iret
 554                     	switch	.ubsct
 555  0000               L301_powerEndTime:
 556  0000 0000          	ds.b	2
 557  0002               L501_power3StartTime:
 558  0002 0000          	ds.b	2
 638                     ; 186 void TIM2_CCP_IRQHandler(void)
 638                     ; 187 {
 639                     	switch	.text
 640  024e               f_TIM2_CCP_IRQHandler:
 642  024e 8a            	push	cc
 643  024f 84            	pop	a
 644  0250 a4bf          	and	a,#191
 645  0252 88            	push	a
 646  0253 86            	pop	cc
 647       00000009      OFST:	set	9
 648  0254 3b0002        	push	c_x+2
 649  0257 be00          	ldw	x,c_x
 650  0259 89            	pushw	x
 651  025a 3b0002        	push	c_y+2
 652  025d be00          	ldw	x,c_y
 653  025f 89            	pushw	x
 654  0260 be02          	ldw	x,c_lreg+2
 655  0262 89            	pushw	x
 656  0263 be00          	ldw	x,c_lreg
 657  0265 89            	pushw	x
 658  0266 5209          	subw	sp,#9
 661                     ; 195   timer2Ch1_ITStatus = TIM2_GetITStatus(TIM2_IT_CC1);
 663  0268 a602          	ld	a,#2
 664  026a cd0000        	call	_TIM2_GetITStatus
 666  026d 6b09          	ld	(OFST+0,sp),a
 668                     ; 197   if (timer2Ch1_ITStatus == SET)
 670  026f 7b09          	ld	a,(OFST+0,sp)
 671  0271 a101          	cp	a,#1
 672  0273 2663          	jrne	L541
 673                     ; 199     powerEndTime = TIM2_GetCapture1(); /* Read Timer value on Input Capture event */
 675  0275 cd0000        	call	_TIM2_GetCapture1
 677  0278 bf00          	ldw	L301_powerEndTime,x
 678                     ; 201     if (power3ReadFlag == true) /* Avoid Calculation on first capture */
 680                     	btst	_power3ReadFlag
 681  027f 2442          	jruge	L741
 682                     ; 203       powerPeriod3 = timer2MaxCount * power3OverflowCount - power3StartTime + powerEndTime;
 684  0281 be00          	ldw	x,L301_powerEndTime
 685  0283 cd0000        	call	c_uitolx
 687  0286 96            	ldw	x,sp
 688  0287 1c0005        	addw	x,#OFST-4
 689  028a cd0000        	call	c_rtol
 692  028d be02          	ldw	x,L501_power3StartTime
 693  028f cd0000        	call	c_uitolx
 695  0292 96            	ldw	x,sp
 696  0293 1c0001        	addw	x,#OFST-8
 697  0296 cd0000        	call	c_rtol
 700  0299 b605          	ld	a,_power3OverflowCount
 701  029b 5f            	clrw	x
 702  029c 97            	ld	xl,a
 703  029d 90aeffff      	ldw	y,#65535
 704  02a1 cd0000        	call	c_umul
 706  02a4 96            	ldw	x,sp
 707  02a5 1c0001        	addw	x,#OFST-8
 708  02a8 cd0000        	call	c_lsub
 710  02ab 96            	ldw	x,sp
 711  02ac 1c0005        	addw	x,#OFST-4
 712  02af cd0000        	call	c_ladd
 714  02b2 ae0000        	ldw	x,#_powerPeriod3
 715  02b5 cd0000        	call	c_rtol
 717                     ; 204       calcWatt3(powerPeriod3);
 719  02b8 be02          	ldw	x,_powerPeriod3+2
 720  02ba 89            	pushw	x
 721  02bb be00          	ldw	x,_powerPeriod3
 722  02bd 89            	pushw	x
 723  02be cd0000        	call	_calcWatt3
 725  02c1 5b04          	addw	sp,#4
 726  02c3               L741:
 727                     ; 224     power3StartTime = powerEndTime;
 729  02c3 be00          	ldw	x,L301_powerEndTime
 730  02c5 bf02          	ldw	L501_power3StartTime,x
 731                     ; 225     power3OverflowCount = 0;
 733  02c7 3f05          	clr	_power3OverflowCount
 734                     ; 226     power3ReadFlag = true;
 736  02c9 72100002      	bset	_power3ReadFlag
 737                     ; 227     TIM2_ClearITPendingBit(TIM2_IT_CC1);
 739  02cd a602          	ld	a,#2
 740  02cf cd0000        	call	_TIM2_ClearITPendingBit
 742                     ; 228     TIM2_ClearFlag(TIM2_FLAG_CC1);
 744  02d2 ae0002        	ldw	x,#2
 745  02d5 cd0000        	call	_TIM2_ClearFlag
 747  02d8               L541:
 748                     ; 230 }
 751  02d8 5b09          	addw	sp,#9
 752  02da 85            	popw	x
 753  02db bf00          	ldw	c_lreg,x
 754  02dd 85            	popw	x
 755  02de bf02          	ldw	c_lreg+2,x
 756  02e0 85            	popw	x
 757  02e1 bf00          	ldw	c_y,x
 758  02e3 320002        	pop	c_y+2
 759  02e6 85            	popw	x
 760  02e7 bf00          	ldw	c_x,x
 761  02e9 320002        	pop	c_x+2
 762  02ec 80            	iret
 764                     	switch	.ubsct
 765  0004               L351_power2StartTime:
 766  0004 0000          	ds.b	2
 767  0006               L151_power1StartTime:
 768  0006 0000          	ds.b	2
 852                     ; 240 void TIM1_CCP_IRQHandler(void)
 852                     ; 241 {
 853                     	switch	.text
 854  02ed               f_TIM1_CCP_IRQHandler:
 856  02ed 8a            	push	cc
 857  02ee 84            	pop	a
 858  02ef a4bf          	and	a,#191
 859  02f1 88            	push	a
 860  02f2 86            	pop	cc
 861       0000000b      OFST:	set	11
 862  02f3 3b0002        	push	c_x+2
 863  02f6 be00          	ldw	x,c_x
 864  02f8 89            	pushw	x
 865  02f9 3b0002        	push	c_y+2
 866  02fc be00          	ldw	x,c_y
 867  02fe 89            	pushw	x
 868  02ff be02          	ldw	x,c_lreg+2
 869  0301 89            	pushw	x
 870  0302 be00          	ldw	x,c_lreg
 871  0304 89            	pushw	x
 872  0305 520b          	subw	sp,#11
 875                     ; 248   timer1Ch1_ITStatus = TIM1_GetITStatus(TIM1_IT_CC1);
 877  0307 a602          	ld	a,#2
 878  0309 cd0000        	call	_TIM1_GetITStatus
 880  030c 6b09          	ld	(OFST-2,sp),a
 882                     ; 249   if (timer1Ch1_ITStatus == SET)
 884  030e 7b09          	ld	a,(OFST-2,sp)
 885  0310 a101          	cp	a,#1
 886  0312 2663          	jrne	L312
 887                     ; 251     powerEndTime = TIM1_GetCapture1();
 889  0314 cd0000        	call	_TIM1_GetCapture1
 891  0317 1f0a          	ldw	(OFST-1,sp),x
 893                     ; 253     if (power1ReadFlag == true) /* Avoid Calculation on first capture */
 895                     	btst	_power1ReadFlag
 896  031e 2442          	jruge	L512
 897                     ; 255       powerPeriod1 = ((timer1MaxCount * power1OverflowCount) - power1StartTime) + powerEndTime;
 899  0320 1e0a          	ldw	x,(OFST-1,sp)
 900  0322 cd0000        	call	c_uitolx
 902  0325 96            	ldw	x,sp
 903  0326 1c0005        	addw	x,#OFST-6
 904  0329 cd0000        	call	c_rtol
 907  032c be06          	ldw	x,L151_power1StartTime
 908  032e cd0000        	call	c_uitolx
 910  0331 96            	ldw	x,sp
 911  0332 1c0001        	addw	x,#OFST-10
 912  0335 cd0000        	call	c_rtol
 915  0338 b603          	ld	a,_power1OverflowCount
 916  033a 5f            	clrw	x
 917  033b 97            	ld	xl,a
 918  033c 90aeffff      	ldw	y,#65535
 919  0340 cd0000        	call	c_umul
 921  0343 96            	ldw	x,sp
 922  0344 1c0001        	addw	x,#OFST-10
 923  0347 cd0000        	call	c_lsub
 925  034a 96            	ldw	x,sp
 926  034b 1c0005        	addw	x,#OFST-6
 927  034e cd0000        	call	c_ladd
 929  0351 ae0000        	ldw	x,#_powerPeriod1
 930  0354 cd0000        	call	c_rtol
 932                     ; 256       calcWatt1(powerPeriod1);//Added by Saqib
 934  0357 be02          	ldw	x,_powerPeriod1+2
 935  0359 89            	pushw	x
 936  035a be00          	ldw	x,_powerPeriod1
 937  035c 89            	pushw	x
 938  035d cd0000        	call	_calcWatt1
 940  0360 5b04          	addw	sp,#4
 941  0362               L512:
 942                     ; 262     power1StartTime = powerEndTime;
 944  0362 1e0a          	ldw	x,(OFST-1,sp)
 945  0364 bf06          	ldw	L151_power1StartTime,x
 946                     ; 263     power1OverflowCount = 0;
 948  0366 3f03          	clr	_power1OverflowCount
 949                     ; 264     power1ReadFlag = true;
 951  0368 72100000      	bset	_power1ReadFlag
 952                     ; 265     TIM1_ClearITPendingBit(TIM1_IT_CC1);
 954  036c a602          	ld	a,#2
 955  036e cd0000        	call	_TIM1_ClearITPendingBit
 957                     ; 266     TIM1_ClearFlag(TIM1_FLAG_CC1);
 959  0371 ae0002        	ldw	x,#2
 960  0374 cd0000        	call	_TIM1_ClearFlag
 962  0377               L312:
 963                     ; 269   timer1Ch3_ITStatus = TIM1_GetITStatus(/*TIM1_IT_CC2*/TIM1_IT_CC3); /* Interrupt status check */
 965  0377 a608          	ld	a,#8
 966  0379 cd0000        	call	_TIM1_GetITStatus
 968  037c 6b09          	ld	(OFST-2,sp),a
 970                     ; 271   if (timer1Ch3_ITStatus == SET)
 972  037e 7b09          	ld	a,(OFST-2,sp)
 973  0380 a101          	cp	a,#1
 974  0382 2663          	jrne	L712
 975                     ; 273     powerEndTime = TIM1_GetCapture3();
 977  0384 cd0000        	call	_TIM1_GetCapture3
 979  0387 1f0a          	ldw	(OFST-1,sp),x
 981                     ; 275     if (power2ReadFlag == true) /* Avoid Calculation on first capture */
 983                     	btst	_power2ReadFlag
 984  038e 2442          	jruge	L122
 985                     ; 277       powerPeriod2 = timer1MaxCount * power2OverflowCount - power2StartTime + powerEndTime;
 987  0390 1e0a          	ldw	x,(OFST-1,sp)
 988  0392 cd0000        	call	c_uitolx
 990  0395 96            	ldw	x,sp
 991  0396 1c0005        	addw	x,#OFST-6
 992  0399 cd0000        	call	c_rtol
 995  039c be04          	ldw	x,L351_power2StartTime
 996  039e cd0000        	call	c_uitolx
 998  03a1 96            	ldw	x,sp
 999  03a2 1c0001        	addw	x,#OFST-10
1000  03a5 cd0000        	call	c_rtol
1003  03a8 b604          	ld	a,_power2OverflowCount
1004  03aa 5f            	clrw	x
1005  03ab 97            	ld	xl,a
1006  03ac 90aeffff      	ldw	y,#65535
1007  03b0 cd0000        	call	c_umul
1009  03b3 96            	ldw	x,sp
1010  03b4 1c0001        	addw	x,#OFST-10
1011  03b7 cd0000        	call	c_lsub
1013  03ba 96            	ldw	x,sp
1014  03bb 1c0005        	addw	x,#OFST-6
1015  03be cd0000        	call	c_ladd
1017  03c1 ae0000        	ldw	x,#_powerPeriod2
1018  03c4 cd0000        	call	c_rtol
1020                     ; 278       calcWatt2(powerPeriod2);//Added by Saqib
1022  03c7 be02          	ldw	x,_powerPeriod2+2
1023  03c9 89            	pushw	x
1024  03ca be00          	ldw	x,_powerPeriod2
1025  03cc 89            	pushw	x
1026  03cd cd0000        	call	_calcWatt2
1028  03d0 5b04          	addw	sp,#4
1029  03d2               L122:
1030                     ; 284     power2StartTime = powerEndTime;
1032  03d2 1e0a          	ldw	x,(OFST-1,sp)
1033  03d4 bf04          	ldw	L351_power2StartTime,x
1034                     ; 285     power2OverflowCount = 0;
1036  03d6 3f04          	clr	_power2OverflowCount
1037                     ; 286     power2ReadFlag = true;
1039  03d8 72100001      	bset	_power2ReadFlag
1040                     ; 287     TIM1_ClearITPendingBit(TIM1_IT_CC3);
1042  03dc a608          	ld	a,#8
1043  03de cd0000        	call	_TIM1_ClearITPendingBit
1045                     ; 288     TIM1_ClearFlag(TIM1_FLAG_CC3);
1047  03e1 ae0008        	ldw	x,#8
1048  03e4 cd0000        	call	_TIM1_ClearFlag
1050  03e7               L712:
1051                     ; 290 }
1054  03e7 5b0b          	addw	sp,#11
1055  03e9 85            	popw	x
1056  03ea bf00          	ldw	c_lreg,x
1057  03ec 85            	popw	x
1058  03ed bf02          	ldw	c_lreg+2,x
1059  03ef 85            	popw	x
1060  03f0 bf00          	ldw	c_y,x
1061  03f2 320002        	pop	c_y+2
1062  03f5 85            	popw	x
1063  03f6 bf00          	ldw	c_x,x
1064  03f8 320002        	pop	c_x+2
1065  03fb 80            	iret
1103                     ; 292 @svlreg void UART1_RCV_IRQHandler(void) // recieve data intrrupt
1103                     ; 293 {
1104                     	switch	.text
1105  03fc               f_UART1_RCV_IRQHandler:
1107  03fc 8a            	push	cc
1108  03fd 84            	pop	a
1109  03fe a4bf          	and	a,#191
1110  0400 88            	push	a
1111  0401 86            	pop	cc
1112       00000001      OFST:	set	1
1113  0402 3b0002        	push	c_x+2
1114  0405 be00          	ldw	x,c_x
1115  0407 89            	pushw	x
1116  0408 3b0002        	push	c_y+2
1117  040b be00          	ldw	x,c_y
1118  040d 89            	pushw	x
1119  040e be02          	ldw	x,c_lreg+2
1120  0410 89            	pushw	x
1121  0411 be00          	ldw	x,c_lreg
1122  0413 89            	pushw	x
1123  0414 88            	push	a
1126                     ; 294   if (UART1_GetFlagStatus(UART1_FLAG_RXNE)) // If Data is Recieved, this clears
1128  0415 ae0020        	ldw	x,#32
1129  0418 cd0000        	call	_UART1_GetFlagStatus
1131  041b 4d            	tnz	a
1132  041c 2703          	jreq	L142
1133                     ; 296     vSerialRecieveISR();
1135  041e cd0000        	call	_vSerialRecieveISR
1137  0421               L142:
1138                     ; 300   if (UART1_GetFlagStatus(UART1_FLAG_IDLE)) // If Data is Recieved, this clears
1140  0421 ae0010        	ldw	x,#16
1141  0424 cd0000        	call	_UART1_GetFlagStatus
1143  0427 4d            	tnz	a
1144  0428 2706          	jreq	L342
1145                     ; 302     uint8_t temp = UART1_ReceiveData8(); // This will clear IDLE Flag
1147  042a cd0000        	call	_UART1_ReceiveData8
1149                     ; 303     vHandleDataRecvUARTviaISR();
1151  042d cd0000        	call	_vHandleDataRecvUARTviaISR
1153  0430               L342:
1154                     ; 305 }
1157  0430 84            	pop	a
1158  0431 85            	popw	x
1159  0432 bf00          	ldw	c_lreg,x
1160  0434 85            	popw	x
1161  0435 bf02          	ldw	c_lreg+2,x
1162  0437 85            	popw	x
1163  0438 bf00          	ldw	c_y,x
1164  043a 320002        	pop	c_y+2
1165  043d 85            	popw	x
1166  043e bf00          	ldw	c_x,x
1167  0440 320002        	pop	c_x+2
1168  0443 80            	iret
1193                     ; 307 @svlreg void EXTI_PORTD_IRQHandler(void)
1193                     ; 308 {
1194                     	switch	.text
1195  0444               f_EXTI_PORTD_IRQHandler:
1197  0444 8a            	push	cc
1198  0445 84            	pop	a
1199  0446 a4bf          	and	a,#191
1200  0448 88            	push	a
1201  0449 86            	pop	cc
1202  044a 3b0002        	push	c_x+2
1203  044d be00          	ldw	x,c_x
1204  044f 89            	pushw	x
1205  0450 3b0002        	push	c_y+2
1206  0453 be00          	ldw	x,c_y
1207  0455 89            	pushw	x
1208  0456 be02          	ldw	x,c_lreg+2
1209  0458 89            	pushw	x
1210  0459 be00          	ldw	x,c_lreg
1211  045b 89            	pushw	x
1214                     ; 311   if (checkit == 1)
1216  045c b600          	ld	a,_checkit
1217  045e a101          	cp	a,#1
1218  0460 2607          	jrne	L552
1219                     ; 331     sms_receive();
1221  0462 cd0000        	call	_sms_receive
1223                     ; 332     checkit = 1;
1225  0465 35010000      	mov	_checkit,#1
1226  0469               L552:
1227                     ; 335 }
1230  0469 85            	popw	x
1231  046a bf00          	ldw	c_lreg,x
1232  046c 85            	popw	x
1233  046d bf02          	ldw	c_lreg+2,x
1234  046f 85            	popw	x
1235  0470 bf00          	ldw	c_y,x
1236  0472 320002        	pop	c_y+2
1237  0475 85            	popw	x
1238  0476 bf00          	ldw	c_x,x
1239  0478 320002        	pop	c_x+2
1240  047b 80            	iret
1263                     ; 345 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
1263                     ; 346 {
1264                     	switch	.text
1265  047c               f_NonHandledInterrupt:
1269                     ; 350 }
1272  047c 80            	iret
1294                     ; 358 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
1294                     ; 359 {
1295                     	switch	.text
1296  047d               f_TRAP_IRQHandler:
1300                     ; 363 }
1303  047d 80            	iret
1325                     ; 370 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
1325                     ; 371 
1325                     ; 372 {
1326                     	switch	.text
1327  047e               f_TLI_IRQHandler:
1331                     ; 376 }
1334  047e 80            	iret
1356                     ; 383 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
1356                     ; 384 {
1357                     	switch	.text
1358  047f               f_AWU_IRQHandler:
1362                     ; 388 }
1365  047f 80            	iret
1387                     ; 395 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
1387                     ; 396 {
1388                     	switch	.text
1389  0480               f_CLK_IRQHandler:
1393                     ; 400 }
1396  0480 80            	iret
1419                     ; 421 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
1419                     ; 422 {
1420                     	switch	.text
1421  0481               f_EXTI_PORTB_IRQHandler:
1425                     ; 426 }
1428  0481 80            	iret
1451                     ; 433 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
1451                     ; 434 {
1452                     	switch	.text
1453  0482               f_EXTI_PORTC_IRQHandler:
1457                     ; 438 }
1460  0482 80            	iret
1483                     ; 457 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
1483                     ; 458 {
1484                     	switch	.text
1485  0483               f_EXTI_PORTE_IRQHandler:
1489                     ; 462 }
1492  0483 80            	iret
1514                     ; 509 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
1514                     ; 510 {
1515                     	switch	.text
1516  0484               f_SPI_IRQHandler:
1520                     ; 514 }
1523  0484 80            	iret
1546                     ; 521 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
1546                     ; 522 {
1547                     	switch	.text
1548  0485               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
1552                     ; 526 }
1555  0485 80            	iret
1578                     ; 533 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
1578                     ; 534 {
1579                     	switch	.text
1580  0486               f_TIM1_CAP_COM_IRQHandler:
1584                     ; 538 }
1587  0486 80            	iret
1610                     ; 571 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
1610                     ; 572 {
1611                     	switch	.text
1612  0487               f_TIM2_UPD_OVF_BRK_IRQHandler:
1616                     ; 576 }
1619  0487 80            	iret
1642                     ; 583 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
1642                     ; 584 {
1643                     	switch	.text
1644  0488               f_TIM2_CAP_COM_IRQHandler:
1648                     ; 588 }
1651  0488 80            	iret
1674                     ; 598 INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
1674                     ; 599 {
1675                     	switch	.text
1676  0489               f_TIM3_UPD_OVF_BRK_IRQHandler:
1680                     ; 603 }
1683  0489 80            	iret
1706                     ; 610 INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
1706                     ; 611 {
1707                     	switch	.text
1708  048a               f_TIM3_CAP_COM_IRQHandler:
1712                     ; 615 }
1715  048a 80            	iret
1738                     ; 625 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
1738                     ; 626 {
1739                     	switch	.text
1740  048b               f_UART1_TX_IRQHandler:
1744                     ; 630 }
1747  048b 80            	iret
1770                     ; 637 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
1770                     ; 638 {
1771                     	switch	.text
1772  048c               f_UART1_RX_IRQHandler:
1776                     ; 642 }
1779  048c 80            	iret
1801                     ; 676 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
1801                     ; 677 {
1802                     	switch	.text
1803  048d               f_I2C_IRQHandler:
1807                     ; 681 }
1810  048d 80            	iret
1833                     ; 715 INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
1833                     ; 716 {
1834                     	switch	.text
1835  048e               f_UART3_TX_IRQHandler:
1839                     ; 720 }
1842  048e 80            	iret
1865                     ; 727 INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
1865                     ; 728 {
1866                     	switch	.text
1867  048f               f_UART3_RX_IRQHandler:
1871                     ; 732 }
1874  048f 80            	iret
1896                     ; 741 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
1896                     ; 742 {
1897                     	switch	.text
1898  0490               f_ADC2_IRQHandler:
1902                     ; 746 }
1905  0490 80            	iret
1928                     ; 781 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1928                     ; 782 {
1929                     	switch	.text
1930  0491               f_TIM4_UPD_OVF_IRQHandler:
1934                     ; 786 }
1937  0491 80            	iret
1960                     ; 794 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1960                     ; 795 {
1961                     	switch	.text
1962  0492               f_EEPROM_EEC_IRQHandler:
1966                     ; 799 }
1969  0492 80            	iret
2157                     	xdef	_powerAccumulateCount
2158                     	xdef	_storeEnergyPhase3
2159                     	xdef	_storeEnergyPhase2
2160                     	xdef	_storeEnergyPhase1
2161                     	switch	.ubsct
2162  0008               _energyPhase3:
2163  0008 00000000      	ds.b	4
2164                     	xdef	_energyPhase3
2165  000c               _energyPhase2:
2166  000c 00000000      	ds.b	4
2167                     	xdef	_energyPhase2
2168  0010               _energyPhase1:
2169  0010 00000000      	ds.b	4
2170                     	xdef	_energyPhase1
2171                     	xref.b	_ticsOverflowCounter
2172                     	xdef	_uartDataReadytoRead
2173                     	xdef	_timeoutForUART
2174                     	xdef	_power3ReadFlag
2175                     	xdef	_power2ReadFlag
2176                     	xdef	_power1ReadFlag
2177                     	xref.b	_powerPeriod3
2178                     	xref.b	_powerPeriod2
2179                     	xref.b	_powerPeriod1
2180                     	xdef	_power3OverflowCount
2181                     	xdef	_power2OverflowCount
2182                     	xdef	_power1OverflowCount
2183                     	xref	_sms_receive
2184                     	xdef	_voltCurrent3OverflowCount
2185                     	xdef	_voltCurrent2OverflowCount
2186                     	xdef	_voltCurrent1OverflowCount
2187                     	xref.b	_powerCalibrationFactor3
2188                     	xref.b	_powerCalibrationFactor2
2189                     	xref.b	_powerCalibrationFactor1
2190                     	xref	_calcWatt3
2191                     	xref	_calcWatt2
2192                     	xref	_calcWatt1
2193                     	xref	_vHandleDataRecvUARTviaISR
2194                     	xref	_vSerialRecieveISR
2195                     	xref	_Watt_Phase3
2196                     	xref	_Watt_Phase2
2197                     	xref	_Watt_Phase1
2198                     	xref.b	_checkit
2199                     	xdef	f_EEPROM_EEC_IRQHandler
2200                     	xdef	f_TIM4_UPD_OVF_IRQHandler
2201                     	xdef	f_ADC2_IRQHandler
2202                     	xdef	f_UART3_TX_IRQHandler
2203                     	xdef	f_UART3_RX_IRQHandler
2204                     	xdef	f_I2C_IRQHandler
2205                     	xdef	f_UART1_RX_IRQHandler
2206                     	xdef	f_UART1_TX_IRQHandler
2207                     	xdef	f_TIM3_CAP_COM_IRQHandler
2208                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
2209                     	xdef	f_TIM2_CAP_COM_IRQHandler
2210                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
2211                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
2212                     	xdef	f_TIM1_CAP_COM_IRQHandler
2213                     	xdef	f_SPI_IRQHandler
2214                     	xdef	f_EXTI_PORTE_IRQHandler
2215                     	xdef	f_EXTI_PORTC_IRQHandler
2216                     	xdef	f_EXTI_PORTB_IRQHandler
2217                     	xdef	f_CLK_IRQHandler
2218                     	xdef	f_AWU_IRQHandler
2219                     	xdef	f_TLI_IRQHandler
2220                     	xdef	f_TRAP_IRQHandler
2221                     	xdef	f_NonHandledInterrupt
2222                     	xref	_UART1_GetFlagStatus
2223                     	xref	_UART1_ReceiveData8
2224                     	xref	_TIM2_ClearITPendingBit
2225                     	xref	_TIM2_GetITStatus
2226                     	xref	_TIM2_ClearFlag
2227                     	xref	_TIM2_GetCapture1
2228                     	xref	_TIM1_ClearITPendingBit
2229                     	xref	_TIM1_GetITStatus
2230                     	xref	_TIM1_ClearFlag
2231                     	xref	_TIM1_GetCapture3
2232                     	xref	_TIM1_GetCapture1
2233                     	xdef	f_EXTI_PORTD_IRQHandler
2234                     	xdef	f_UART1_RCV_IRQHandler
2235                     	xdef	f_TIM1_CCP_IRQHandler
2236                     	xdef	f_TIM1_IRQHandler
2237                     	xdef	f_TIM2_CCP_IRQHandler
2238                     	xdef	f_TIM2_UPD_IRQHandler
2239                     	switch	.const
2240  0004               L14:
2241  0004 3ff34506      	dc.w	16371,17670
2242  0008               L13:
2243  0008 4c604e99      	dc.w	19552,20121
2244                     	xref.b	c_lreg
2245                     	xref.b	c_x
2246                     	xref.b	c_y
2266                     	xref	c_ladd
2267                     	xref	c_lsub
2268                     	xref	c_uitolx
2269                     	xref	c_umul
2270                     	xref	c_lgsub
2271                     	xref	c_lgadc
2272                     	xref	c_lcmp
2273                     	xref	c_ftol
2274                     	xref	c_fadd
2275                     	xref	c_fdiv
2276                     	xref	c_rtol
2277                     	xref	c_fmul
2278                     	xref	c_uitof
2279                     	xref	c_ultof
2280                     	xref	c_ltor
2281                     	xref	c_lzmp
2282                     	end
