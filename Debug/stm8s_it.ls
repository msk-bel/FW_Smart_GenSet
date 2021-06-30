   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
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
 112       0000000c      OFST:	set	12
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
 123  0018 520c          	subw	sp,#12
 126                     ; 78   voltCurrent1OverflowCount++;
 128  001a 3c00          	inc	_voltCurrent1OverflowCount
 129                     ; 79   voltCurrent2OverflowCount++;//Added by Saqib
 131  001c 3c01          	inc	_voltCurrent2OverflowCount
 132                     ; 80   if (powerAccumulateCount > powerAccumulateCountMax)
 134  001e b614          	ld	a,_powerAccumulateCount
 135  0020 a13b          	cp	a,#59
 136  0022 2404          	jruge	L01
 137  0024 acc801c8      	jpf	L12
 138  0028               L01:
 139                     ; 83     if (powerPeriod1 != 0)
 141  0028 ae0000        	ldw	x,#_powerPeriod1
 142  002b cd0000        	call	c_lzmp
 144  002e 2604          	jrne	L21
 145  0030 acb200b2      	jpf	L32
 146  0034               L21:
 147                     ; 85       storeEnergyPhase1 = storeEnergyPhase1 + ((float)(powerMultiplier * powerCalibrationFactor1) / powerPeriod1) * powerAccumulateTime;
 149  0034 ae0000        	ldw	x,#_powerPeriod1
 150  0037 cd0000        	call	c_ltor
 152  003a cd0000        	call	c_ultof
 154  003d 96            	ldw	x,sp
 155  003e 1c0009        	addw	x,#OFST-3
 156  0041 cd0000        	call	c_rtol
 159  0044 b600          	ld	a,_powerCalibrationFactor1
 160  0046 5f            	clrw	x
 161  0047 97            	ld	xl,a
 162  0048 cd0000        	call	c_itof
 164  004b 96            	ldw	x,sp
 165  004c 1c0005        	addw	x,#OFST-7
 166  004f cd0000        	call	c_rtol
 169  0052 ae0008        	ldw	x,#L13
 170  0055 cd0000        	call	c_ltor
 172  0058 96            	ldw	x,sp
 173  0059 1c0005        	addw	x,#OFST-7
 174  005c cd0000        	call	c_fmul
 176  005f 96            	ldw	x,sp
 177  0060 1c0009        	addw	x,#OFST-3
 178  0063 cd0000        	call	c_fdiv
 180  0066 ae0004        	ldw	x,#L14
 181  0069 cd0000        	call	c_fmul
 183  006c 96            	ldw	x,sp
 184  006d 1c0001        	addw	x,#OFST-11
 185  0070 cd0000        	call	c_rtol
 188  0073 ae0008        	ldw	x,#_storeEnergyPhase1
 189  0076 cd0000        	call	c_ltor
 191  0079 cd0000        	call	c_ultof
 193  007c 96            	ldw	x,sp
 194  007d 1c0001        	addw	x,#OFST-11
 195  0080 cd0000        	call	c_fadd
 197  0083 cd0000        	call	c_ftol
 199  0086 ae0008        	ldw	x,#_storeEnergyPhase1
 200  0089 cd0000        	call	c_rtol
 202                     ; 87       if ((storeEnergyPhase1 >= energyResolution))
 204  008c ae0008        	ldw	x,#_storeEnergyPhase1
 205  008f cd0000        	call	c_ltor
 207  0092 ae0000        	ldw	x,#L6
 208  0095 cd0000        	call	c_lcmp
 210  0098 2518          	jrult	L32
 211                     ; 89         energyPhase1++;
 213  009a ae0010        	ldw	x,#_energyPhase1
 214  009d a601          	ld	a,#1
 215  009f cd0000        	call	c_lgadc
 217                     ; 90         storeEnergyPhase1 = storeEnergyPhase1 - energyResolution;
 219  00a2 ae5100        	ldw	x,#20736
 220  00a5 bf02          	ldw	c_lreg+2,x
 221  00a7 ae0225        	ldw	x,#549
 222  00aa bf00          	ldw	c_lreg,x
 223  00ac ae0008        	ldw	x,#_storeEnergyPhase1
 224  00af cd0000        	call	c_lgsub
 226  00b2               L32:
 227                     ; 94     if (powerPeriod2 != 0)
 229  00b2 ae0000        	ldw	x,#_powerPeriod2
 230  00b5 cd0000        	call	c_lzmp
 232  00b8 2604          	jrne	L41
 233  00ba ac3c013c      	jpf	L74
 234  00be               L41:
 235                     ; 96       storeEnergyPhase2 = storeEnergyPhase2 + ((float)(powerMultiplier * powerCalibrationFactor2) / powerPeriod2) * powerAccumulateTime;
 237  00be ae0000        	ldw	x,#_powerPeriod2
 238  00c1 cd0000        	call	c_ltor
 240  00c4 cd0000        	call	c_ultof
 242  00c7 96            	ldw	x,sp
 243  00c8 1c0009        	addw	x,#OFST-3
 244  00cb cd0000        	call	c_rtol
 247  00ce b600          	ld	a,_powerCalibrationFactor2
 248  00d0 5f            	clrw	x
 249  00d1 97            	ld	xl,a
 250  00d2 cd0000        	call	c_itof
 252  00d5 96            	ldw	x,sp
 253  00d6 1c0005        	addw	x,#OFST-7
 254  00d9 cd0000        	call	c_rtol
 257  00dc ae0008        	ldw	x,#L13
 258  00df cd0000        	call	c_ltor
 260  00e2 96            	ldw	x,sp
 261  00e3 1c0005        	addw	x,#OFST-7
 262  00e6 cd0000        	call	c_fmul
 264  00e9 96            	ldw	x,sp
 265  00ea 1c0009        	addw	x,#OFST-3
 266  00ed cd0000        	call	c_fdiv
 268  00f0 ae0004        	ldw	x,#L14
 269  00f3 cd0000        	call	c_fmul
 271  00f6 96            	ldw	x,sp
 272  00f7 1c0001        	addw	x,#OFST-11
 273  00fa cd0000        	call	c_rtol
 276  00fd ae000c        	ldw	x,#_storeEnergyPhase2
 277  0100 cd0000        	call	c_ltor
 279  0103 cd0000        	call	c_ultof
 281  0106 96            	ldw	x,sp
 282  0107 1c0001        	addw	x,#OFST-11
 283  010a cd0000        	call	c_fadd
 285  010d cd0000        	call	c_ftol
 287  0110 ae000c        	ldw	x,#_storeEnergyPhase2
 288  0113 cd0000        	call	c_rtol
 290                     ; 98       if ((storeEnergyPhase2 >= energyResolution))
 292  0116 ae000c        	ldw	x,#_storeEnergyPhase2
 293  0119 cd0000        	call	c_ltor
 295  011c ae0000        	ldw	x,#L6
 296  011f cd0000        	call	c_lcmp
 298  0122 2518          	jrult	L74
 299                     ; 100         energyPhase2++;
 301  0124 ae000c        	ldw	x,#_energyPhase2
 302  0127 a601          	ld	a,#1
 303  0129 cd0000        	call	c_lgadc
 305                     ; 101         storeEnergyPhase2 = storeEnergyPhase2 - energyResolution;
 307  012c ae5100        	ldw	x,#20736
 308  012f bf02          	ldw	c_lreg+2,x
 309  0131 ae0225        	ldw	x,#549
 310  0134 bf00          	ldw	c_lreg,x
 311  0136 ae000c        	ldw	x,#_storeEnergyPhase2
 312  0139 cd0000        	call	c_lgsub
 314  013c               L74:
 315                     ; 105     if (powerPeriod3 != 0)
 317  013c ae0000        	ldw	x,#_powerPeriod3
 318  013f cd0000        	call	c_lzmp
 320  0142 2604          	jrne	L61
 321  0144 acc601c6      	jpf	L35
 322  0148               L61:
 323                     ; 107       storeEnergyPhase3 = storeEnergyPhase3 + ((float)(powerMultiplier * powerCalibrationFactor3) / powerPeriod3) * powerAccumulateTime;
 325  0148 ae0000        	ldw	x,#_powerPeriod3
 326  014b cd0000        	call	c_ltor
 328  014e cd0000        	call	c_ultof
 330  0151 96            	ldw	x,sp
 331  0152 1c0009        	addw	x,#OFST-3
 332  0155 cd0000        	call	c_rtol
 335  0158 b600          	ld	a,_powerCalibrationFactor3
 336  015a 5f            	clrw	x
 337  015b 97            	ld	xl,a
 338  015c cd0000        	call	c_itof
 340  015f 96            	ldw	x,sp
 341  0160 1c0005        	addw	x,#OFST-7
 342  0163 cd0000        	call	c_rtol
 345  0166 ae0008        	ldw	x,#L13
 346  0169 cd0000        	call	c_ltor
 348  016c 96            	ldw	x,sp
 349  016d 1c0005        	addw	x,#OFST-7
 350  0170 cd0000        	call	c_fmul
 352  0173 96            	ldw	x,sp
 353  0174 1c0009        	addw	x,#OFST-3
 354  0177 cd0000        	call	c_fdiv
 356  017a ae0004        	ldw	x,#L14
 357  017d cd0000        	call	c_fmul
 359  0180 96            	ldw	x,sp
 360  0181 1c0001        	addw	x,#OFST-11
 361  0184 cd0000        	call	c_rtol
 364  0187 ae0010        	ldw	x,#_storeEnergyPhase3
 365  018a cd0000        	call	c_ltor
 367  018d cd0000        	call	c_ultof
 369  0190 96            	ldw	x,sp
 370  0191 1c0001        	addw	x,#OFST-11
 371  0194 cd0000        	call	c_fadd
 373  0197 cd0000        	call	c_ftol
 375  019a ae0010        	ldw	x,#_storeEnergyPhase3
 376  019d cd0000        	call	c_rtol
 378                     ; 109       if ((storeEnergyPhase3 >= energyResolution))
 380  01a0 ae0010        	ldw	x,#_storeEnergyPhase3
 381  01a3 cd0000        	call	c_ltor
 383  01a6 ae0000        	ldw	x,#L6
 384  01a9 cd0000        	call	c_lcmp
 386  01ac 2518          	jrult	L35
 387                     ; 111         energyPhase3++;
 389  01ae ae0008        	ldw	x,#_energyPhase3
 390  01b1 a601          	ld	a,#1
 391  01b3 cd0000        	call	c_lgadc
 393                     ; 112         storeEnergyPhase3 = storeEnergyPhase3 - energyResolution;
 395  01b6 ae5100        	ldw	x,#20736
 396  01b9 bf02          	ldw	c_lreg+2,x
 397  01bb ae0225        	ldw	x,#549
 398  01be bf00          	ldw	c_lreg,x
 399  01c0 ae0010        	ldw	x,#_storeEnergyPhase3
 400  01c3 cd0000        	call	c_lgsub
 402  01c6               L35:
 403                     ; 116     powerAccumulateCount = 0;
 405  01c6 3f14          	clr	_powerAccumulateCount
 406  01c8               L12:
 407                     ; 119   if (power1OverflowCount < powerOverflowCountMax)
 409  01c8 b603          	ld	a,_power1OverflowCount
 410  01ca a164          	cp	a,#100
 411  01cc 2404          	jruge	L75
 412                     ; 121     power1OverflowCount++;
 414  01ce 3c03          	inc	_power1OverflowCount
 416  01d0 201a          	jra	L16
 417  01d2               L75:
 418                     ; 125     powerPeriod1 = 0;
 420  01d2 ae0000        	ldw	x,#0
 421  01d5 bf02          	ldw	_powerPeriod1+2,x
 422  01d7 ae0000        	ldw	x,#0
 423  01da bf00          	ldw	_powerPeriod1,x
 424                     ; 126     Watt_Phase1 = 0; // Added By Saqib
 426  01dc ae0000        	ldw	x,#0
 427  01df cf0002        	ldw	_Watt_Phase1+2,x
 428  01e2 ae0000        	ldw	x,#0
 429  01e5 cf0000        	ldw	_Watt_Phase1,x
 430                     ; 127     power1ReadFlag = false;
 432  01e8 72110000      	bres	_power1ReadFlag
 433  01ec               L16:
 434                     ; 133   if (power2OverflowCount < powerOverflowCountMax)
 436  01ec b604          	ld	a,_power2OverflowCount
 437  01ee a164          	cp	a,#100
 438  01f0 2404          	jruge	L36
 439                     ; 135     power2OverflowCount++;
 441  01f2 3c04          	inc	_power2OverflowCount
 443  01f4 201a          	jra	L56
 444  01f6               L36:
 445                     ; 139     powerPeriod2 = 0;
 447  01f6 ae0000        	ldw	x,#0
 448  01f9 bf02          	ldw	_powerPeriod2+2,x
 449  01fb ae0000        	ldw	x,#0
 450  01fe bf00          	ldw	_powerPeriod2,x
 451                     ; 140     power2ReadFlag = false;
 453  0200 72110001      	bres	_power2ReadFlag
 454                     ; 141     Watt_Phase2 = 0; // Added By Saqib
 456  0204 ae0000        	ldw	x,#0
 457  0207 cf0002        	ldw	_Watt_Phase2+2,x
 458  020a ae0000        	ldw	x,#0
 459  020d cf0000        	ldw	_Watt_Phase2,x
 460  0210               L56:
 461                     ; 147   powerAccumulateCount++;
 463  0210 3c14          	inc	_powerAccumulateCount
 464                     ; 151   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 466  0212 a601          	ld	a,#1
 467  0214 cd0000        	call	_TIM1_ClearITPendingBit
 469                     ; 152   TIM1_ClearFlag(TIM1_FLAG_UPDATE);
 471  0217 ae0001        	ldw	x,#1
 472  021a cd0000        	call	_TIM1_ClearFlag
 474                     ; 153 }
 477  021d 5b0c          	addw	sp,#12
 478  021f 85            	popw	x
 479  0220 bf00          	ldw	c_lreg,x
 480  0222 85            	popw	x
 481  0223 bf02          	ldw	c_lreg+2,x
 482  0225 85            	popw	x
 483  0226 bf00          	ldw	c_y,x
 484  0228 320002        	pop	c_y+2
 485  022b 85            	popw	x
 486  022c bf00          	ldw	c_x,x
 487  022e 320002        	pop	c_x+2
 488  0231 80            	iret
 519                     ; 155 void TIM2_UPD_IRQHandler(void) //to control power,voltage,current overflow counter
 519                     ; 156 {
 520                     	switch	.text
 521  0232               f_TIM2_UPD_IRQHandler:
 523  0232 8a            	push	cc
 524  0233 84            	pop	a
 525  0234 a4bf          	and	a,#191
 526  0236 88            	push	a
 527  0237 86            	pop	cc
 528  0238 3b0002        	push	c_x+2
 529  023b be00          	ldw	x,c_x
 530  023d 89            	pushw	x
 531  023e 3b0002        	push	c_y+2
 532  0241 be00          	ldw	x,c_y
 533  0243 89            	pushw	x
 536                     ; 157   ticsOverflowCounter++;
 538  0244 ae0000        	ldw	x,#_ticsOverflowCounter
 539  0247 a601          	ld	a,#1
 540  0249 cd0000        	call	c_lgadc
 542                     ; 159   if (power3OverflowCount < powerOverflowCountMax)
 544  024c b605          	ld	a,_power3OverflowCount
 545  024e a164          	cp	a,#100
 546  0250 2404          	jruge	L77
 547                     ; 161     power3OverflowCount++;
 549  0252 3c05          	inc	_power3OverflowCount
 551  0254 201a          	jra	L101
 552  0256               L77:
 553                     ; 165     powerPeriod3 = 0;
 555  0256 ae0000        	ldw	x,#0
 556  0259 bf02          	ldw	_powerPeriod3+2,x
 557  025b ae0000        	ldw	x,#0
 558  025e bf00          	ldw	_powerPeriod3,x
 559                     ; 166     Watt_Phase3 = 0; // Added By Saqib
 561  0260 ae0000        	ldw	x,#0
 562  0263 cf0002        	ldw	_Watt_Phase3+2,x
 563  0266 ae0000        	ldw	x,#0
 564  0269 cf0000        	ldw	_Watt_Phase3,x
 565                     ; 167     power3ReadFlag = false;
 567  026c 72110002      	bres	_power3ReadFlag
 568  0270               L101:
 569                     ; 173   voltCurrent3OverflowCount++;
 571  0270 3c02          	inc	_voltCurrent3OverflowCount
 572                     ; 175   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 574  0272 a601          	ld	a,#1
 575  0274 cd0000        	call	_TIM2_ClearITPendingBit
 577                     ; 176   TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 579  0277 ae0001        	ldw	x,#1
 580  027a cd0000        	call	_TIM2_ClearFlag
 582                     ; 177 }
 585  027d 85            	popw	x
 586  027e bf00          	ldw	c_y,x
 587  0280 320002        	pop	c_y+2
 588  0283 85            	popw	x
 589  0284 bf00          	ldw	c_x,x
 590  0286 320002        	pop	c_x+2
 591  0289 80            	iret
 593                     	switch	.ubsct
 594  0000               L301_powerEndTime:
 595  0000 0000          	ds.b	2
 596  0002               L501_power3StartTime:
 597  0002 0000          	ds.b	2
 677                     ; 186 void TIM2_CCP_IRQHandler(void)
 677                     ; 187 {
 678                     	switch	.text
 679  028a               f_TIM2_CCP_IRQHandler:
 681  028a 8a            	push	cc
 682  028b 84            	pop	a
 683  028c a4bf          	and	a,#191
 684  028e 88            	push	a
 685  028f 86            	pop	cc
 686       00000009      OFST:	set	9
 687  0290 3b0002        	push	c_x+2
 688  0293 be00          	ldw	x,c_x
 689  0295 89            	pushw	x
 690  0296 3b0002        	push	c_y+2
 691  0299 be00          	ldw	x,c_y
 692  029b 89            	pushw	x
 693  029c be02          	ldw	x,c_lreg+2
 694  029e 89            	pushw	x
 695  029f be00          	ldw	x,c_lreg
 696  02a1 89            	pushw	x
 697  02a2 5209          	subw	sp,#9
 700                     ; 195   timer2Ch1_ITStatus = TIM2_GetITStatus(TIM2_IT_CC1);
 702  02a4 a602          	ld	a,#2
 703  02a6 cd0000        	call	_TIM2_GetITStatus
 705  02a9 6b09          	ld	(OFST+0,sp),a
 707                     ; 197   if (timer2Ch1_ITStatus == SET)
 709  02ab 7b09          	ld	a,(OFST+0,sp)
 710  02ad a101          	cp	a,#1
 711  02af 2663          	jrne	L541
 712                     ; 199     powerEndTime = TIM2_GetCapture1(); /* Read Timer value on Input Capture event */
 714  02b1 cd0000        	call	_TIM2_GetCapture1
 716  02b4 bf00          	ldw	L301_powerEndTime,x
 717                     ; 201     if (power3ReadFlag == true) /* Avoid Calculation on first capture */
 719                     	btst	_power3ReadFlag
 720  02bb 2442          	jruge	L741
 721                     ; 203       powerPeriod3 = timer2MaxCount * power3OverflowCount - power3StartTime + powerEndTime;
 723  02bd be00          	ldw	x,L301_powerEndTime
 724  02bf cd0000        	call	c_uitolx
 726  02c2 96            	ldw	x,sp
 727  02c3 1c0005        	addw	x,#OFST-4
 728  02c6 cd0000        	call	c_rtol
 731  02c9 be02          	ldw	x,L501_power3StartTime
 732  02cb cd0000        	call	c_uitolx
 734  02ce 96            	ldw	x,sp
 735  02cf 1c0001        	addw	x,#OFST-8
 736  02d2 cd0000        	call	c_rtol
 739  02d5 b605          	ld	a,_power3OverflowCount
 740  02d7 5f            	clrw	x
 741  02d8 97            	ld	xl,a
 742  02d9 90aeffff      	ldw	y,#65535
 743  02dd cd0000        	call	c_umul
 745  02e0 96            	ldw	x,sp
 746  02e1 1c0001        	addw	x,#OFST-8
 747  02e4 cd0000        	call	c_lsub
 749  02e7 96            	ldw	x,sp
 750  02e8 1c0005        	addw	x,#OFST-4
 751  02eb cd0000        	call	c_ladd
 753  02ee ae0000        	ldw	x,#_powerPeriod3
 754  02f1 cd0000        	call	c_rtol
 756                     ; 204       calcWatt3(powerPeriod3);
 758  02f4 be02          	ldw	x,_powerPeriod3+2
 759  02f6 89            	pushw	x
 760  02f7 be00          	ldw	x,_powerPeriod3
 761  02f9 89            	pushw	x
 762  02fa cd0000        	call	_calcWatt3
 764  02fd 5b04          	addw	sp,#4
 765  02ff               L741:
 766                     ; 224     power3StartTime = powerEndTime;
 768  02ff be00          	ldw	x,L301_powerEndTime
 769  0301 bf02          	ldw	L501_power3StartTime,x
 770                     ; 225     power3OverflowCount = 0;
 772  0303 3f05          	clr	_power3OverflowCount
 773                     ; 226     power3ReadFlag = true;
 775  0305 72100002      	bset	_power3ReadFlag
 776                     ; 227     TIM2_ClearITPendingBit(TIM2_IT_CC1);
 778  0309 a602          	ld	a,#2
 779  030b cd0000        	call	_TIM2_ClearITPendingBit
 781                     ; 228     TIM2_ClearFlag(TIM2_FLAG_CC1);
 783  030e ae0002        	ldw	x,#2
 784  0311 cd0000        	call	_TIM2_ClearFlag
 786  0314               L541:
 787                     ; 230 }
 790  0314 5b09          	addw	sp,#9
 791  0316 85            	popw	x
 792  0317 bf00          	ldw	c_lreg,x
 793  0319 85            	popw	x
 794  031a bf02          	ldw	c_lreg+2,x
 795  031c 85            	popw	x
 796  031d bf00          	ldw	c_y,x
 797  031f 320002        	pop	c_y+2
 798  0322 85            	popw	x
 799  0323 bf00          	ldw	c_x,x
 800  0325 320002        	pop	c_x+2
 801  0328 80            	iret
 803                     	switch	.ubsct
 804  0004               L351_power2StartTime:
 805  0004 0000          	ds.b	2
 806  0006               L151_power1StartTime:
 807  0006 0000          	ds.b	2
 891                     ; 240 void TIM1_CCP_IRQHandler(void)
 891                     ; 241 {
 892                     	switch	.text
 893  0329               f_TIM1_CCP_IRQHandler:
 895  0329 8a            	push	cc
 896  032a 84            	pop	a
 897  032b a4bf          	and	a,#191
 898  032d 88            	push	a
 899  032e 86            	pop	cc
 900       0000000b      OFST:	set	11
 901  032f 3b0002        	push	c_x+2
 902  0332 be00          	ldw	x,c_x
 903  0334 89            	pushw	x
 904  0335 3b0002        	push	c_y+2
 905  0338 be00          	ldw	x,c_y
 906  033a 89            	pushw	x
 907  033b be02          	ldw	x,c_lreg+2
 908  033d 89            	pushw	x
 909  033e be00          	ldw	x,c_lreg
 910  0340 89            	pushw	x
 911  0341 520b          	subw	sp,#11
 914                     ; 248   timer1Ch1_ITStatus = TIM1_GetITStatus(TIM1_IT_CC1);
 916  0343 a602          	ld	a,#2
 917  0345 cd0000        	call	_TIM1_GetITStatus
 919  0348 6b09          	ld	(OFST-2,sp),a
 921                     ; 249   if (timer1Ch1_ITStatus == SET)
 923  034a 7b09          	ld	a,(OFST-2,sp)
 924  034c a101          	cp	a,#1
 925  034e 2663          	jrne	L312
 926                     ; 251     powerEndTime = TIM1_GetCapture1();
 928  0350 cd0000        	call	_TIM1_GetCapture1
 930  0353 1f0a          	ldw	(OFST-1,sp),x
 932                     ; 253     if (power1ReadFlag == true) /* Avoid Calculation on first capture */
 934                     	btst	_power1ReadFlag
 935  035a 2442          	jruge	L512
 936                     ; 255       powerPeriod1 = ((timer1MaxCount * power1OverflowCount) - power1StartTime) + powerEndTime;
 938  035c 1e0a          	ldw	x,(OFST-1,sp)
 939  035e cd0000        	call	c_uitolx
 941  0361 96            	ldw	x,sp
 942  0362 1c0005        	addw	x,#OFST-6
 943  0365 cd0000        	call	c_rtol
 946  0368 be06          	ldw	x,L151_power1StartTime
 947  036a cd0000        	call	c_uitolx
 949  036d 96            	ldw	x,sp
 950  036e 1c0001        	addw	x,#OFST-10
 951  0371 cd0000        	call	c_rtol
 954  0374 b603          	ld	a,_power1OverflowCount
 955  0376 5f            	clrw	x
 956  0377 97            	ld	xl,a
 957  0378 90aeffff      	ldw	y,#65535
 958  037c cd0000        	call	c_umul
 960  037f 96            	ldw	x,sp
 961  0380 1c0001        	addw	x,#OFST-10
 962  0383 cd0000        	call	c_lsub
 964  0386 96            	ldw	x,sp
 965  0387 1c0005        	addw	x,#OFST-6
 966  038a cd0000        	call	c_ladd
 968  038d ae0000        	ldw	x,#_powerPeriod1
 969  0390 cd0000        	call	c_rtol
 971                     ; 256       calcWatt1(powerPeriod1);//Added by Saqib
 973  0393 be02          	ldw	x,_powerPeriod1+2
 974  0395 89            	pushw	x
 975  0396 be00          	ldw	x,_powerPeriod1
 976  0398 89            	pushw	x
 977  0399 cd0000        	call	_calcWatt1
 979  039c 5b04          	addw	sp,#4
 980  039e               L512:
 981                     ; 262     power1StartTime = powerEndTime;
 983  039e 1e0a          	ldw	x,(OFST-1,sp)
 984  03a0 bf06          	ldw	L151_power1StartTime,x
 985                     ; 263     power1OverflowCount = 0;
 987  03a2 3f03          	clr	_power1OverflowCount
 988                     ; 264     power1ReadFlag = true;
 990  03a4 72100000      	bset	_power1ReadFlag
 991                     ; 265     TIM1_ClearITPendingBit(TIM1_IT_CC1);
 993  03a8 a602          	ld	a,#2
 994  03aa cd0000        	call	_TIM1_ClearITPendingBit
 996                     ; 266     TIM1_ClearFlag(TIM1_FLAG_CC1);
 998  03ad ae0002        	ldw	x,#2
 999  03b0 cd0000        	call	_TIM1_ClearFlag
1001  03b3               L312:
1002                     ; 269   timer1Ch3_ITStatus = TIM1_GetITStatus(/*TIM1_IT_CC2*/TIM1_IT_CC3); /* Interrupt status check */
1004  03b3 a608          	ld	a,#8
1005  03b5 cd0000        	call	_TIM1_GetITStatus
1007  03b8 6b09          	ld	(OFST-2,sp),a
1009                     ; 271   if (timer1Ch3_ITStatus == SET)
1011  03ba 7b09          	ld	a,(OFST-2,sp)
1012  03bc a101          	cp	a,#1
1013  03be 2663          	jrne	L712
1014                     ; 273     powerEndTime = TIM1_GetCapture3();
1016  03c0 cd0000        	call	_TIM1_GetCapture3
1018  03c3 1f0a          	ldw	(OFST-1,sp),x
1020                     ; 275     if (power2ReadFlag == true) /* Avoid Calculation on first capture */
1022                     	btst	_power2ReadFlag
1023  03ca 2442          	jruge	L122
1024                     ; 277       powerPeriod2 = timer1MaxCount * power2OverflowCount - power2StartTime + powerEndTime;
1026  03cc 1e0a          	ldw	x,(OFST-1,sp)
1027  03ce cd0000        	call	c_uitolx
1029  03d1 96            	ldw	x,sp
1030  03d2 1c0005        	addw	x,#OFST-6
1031  03d5 cd0000        	call	c_rtol
1034  03d8 be04          	ldw	x,L351_power2StartTime
1035  03da cd0000        	call	c_uitolx
1037  03dd 96            	ldw	x,sp
1038  03de 1c0001        	addw	x,#OFST-10
1039  03e1 cd0000        	call	c_rtol
1042  03e4 b604          	ld	a,_power2OverflowCount
1043  03e6 5f            	clrw	x
1044  03e7 97            	ld	xl,a
1045  03e8 90aeffff      	ldw	y,#65535
1046  03ec cd0000        	call	c_umul
1048  03ef 96            	ldw	x,sp
1049  03f0 1c0001        	addw	x,#OFST-10
1050  03f3 cd0000        	call	c_lsub
1052  03f6 96            	ldw	x,sp
1053  03f7 1c0005        	addw	x,#OFST-6
1054  03fa cd0000        	call	c_ladd
1056  03fd ae0000        	ldw	x,#_powerPeriod2
1057  0400 cd0000        	call	c_rtol
1059                     ; 278       calcWatt2(powerPeriod2);//Added by Saqib
1061  0403 be02          	ldw	x,_powerPeriod2+2
1062  0405 89            	pushw	x
1063  0406 be00          	ldw	x,_powerPeriod2
1064  0408 89            	pushw	x
1065  0409 cd0000        	call	_calcWatt2
1067  040c 5b04          	addw	sp,#4
1068  040e               L122:
1069                     ; 284     power2StartTime = powerEndTime;
1071  040e 1e0a          	ldw	x,(OFST-1,sp)
1072  0410 bf04          	ldw	L351_power2StartTime,x
1073                     ; 285     power2OverflowCount = 0;
1075  0412 3f04          	clr	_power2OverflowCount
1076                     ; 286     power2ReadFlag = true;
1078  0414 72100001      	bset	_power2ReadFlag
1079                     ; 287     TIM1_ClearITPendingBit(TIM1_IT_CC3);
1081  0418 a608          	ld	a,#8
1082  041a cd0000        	call	_TIM1_ClearITPendingBit
1084                     ; 288     TIM1_ClearFlag(TIM1_FLAG_CC3);
1086  041d ae0008        	ldw	x,#8
1087  0420 cd0000        	call	_TIM1_ClearFlag
1089  0423               L712:
1090                     ; 290 }
1093  0423 5b0b          	addw	sp,#11
1094  0425 85            	popw	x
1095  0426 bf00          	ldw	c_lreg,x
1096  0428 85            	popw	x
1097  0429 bf02          	ldw	c_lreg+2,x
1098  042b 85            	popw	x
1099  042c bf00          	ldw	c_y,x
1100  042e 320002        	pop	c_y+2
1101  0431 85            	popw	x
1102  0432 bf00          	ldw	c_x,x
1103  0434 320002        	pop	c_x+2
1104  0437 80            	iret
1142                     ; 292 @svlreg void UART1_RCV_IRQHandler(void) // recieve data intrrupt
1142                     ; 293 {
1143                     	switch	.text
1144  0438               f_UART1_RCV_IRQHandler:
1146  0438 8a            	push	cc
1147  0439 84            	pop	a
1148  043a a4bf          	and	a,#191
1149  043c 88            	push	a
1150  043d 86            	pop	cc
1151       00000001      OFST:	set	1
1152  043e 3b0002        	push	c_x+2
1153  0441 be00          	ldw	x,c_x
1154  0443 89            	pushw	x
1155  0444 3b0002        	push	c_y+2
1156  0447 be00          	ldw	x,c_y
1157  0449 89            	pushw	x
1158  044a be02          	ldw	x,c_lreg+2
1159  044c 89            	pushw	x
1160  044d be00          	ldw	x,c_lreg
1161  044f 89            	pushw	x
1162  0450 88            	push	a
1165                     ; 294   if (UART1_GetFlagStatus(UART1_FLAG_RXNE)) // If Data is Recieved, this clears
1167  0451 ae0020        	ldw	x,#32
1168  0454 cd0000        	call	_UART1_GetFlagStatus
1170  0457 4d            	tnz	a
1171  0458 2703          	jreq	L142
1172                     ; 296     vSerialRecieveISR();
1174  045a cd0000        	call	_vSerialRecieveISR
1176  045d               L142:
1177                     ; 300   if (UART1_GetFlagStatus(UART1_FLAG_IDLE)) // If Data is Recieved, this clears
1179  045d ae0010        	ldw	x,#16
1180  0460 cd0000        	call	_UART1_GetFlagStatus
1182  0463 4d            	tnz	a
1183  0464 2706          	jreq	L342
1184                     ; 302     uint8_t temp = UART1_ReceiveData8(); // This will clear IDLE Flag
1186  0466 cd0000        	call	_UART1_ReceiveData8
1188                     ; 303     vHandleDataRecvUARTviaISR();
1190  0469 cd0000        	call	_vHandleDataRecvUARTviaISR
1192  046c               L342:
1193                     ; 305 }
1196  046c 84            	pop	a
1197  046d 85            	popw	x
1198  046e bf00          	ldw	c_lreg,x
1199  0470 85            	popw	x
1200  0471 bf02          	ldw	c_lreg+2,x
1201  0473 85            	popw	x
1202  0474 bf00          	ldw	c_y,x
1203  0476 320002        	pop	c_y+2
1204  0479 85            	popw	x
1205  047a bf00          	ldw	c_x,x
1206  047c 320002        	pop	c_x+2
1207  047f 80            	iret
1232                     ; 307 @svlreg void EXTI_PORTD_IRQHandler(void)
1232                     ; 308 {
1233                     	switch	.text
1234  0480               f_EXTI_PORTD_IRQHandler:
1236  0480 8a            	push	cc
1237  0481 84            	pop	a
1238  0482 a4bf          	and	a,#191
1239  0484 88            	push	a
1240  0485 86            	pop	cc
1241  0486 3b0002        	push	c_x+2
1242  0489 be00          	ldw	x,c_x
1243  048b 89            	pushw	x
1244  048c 3b0002        	push	c_y+2
1245  048f be00          	ldw	x,c_y
1246  0491 89            	pushw	x
1247  0492 be02          	ldw	x,c_lreg+2
1248  0494 89            	pushw	x
1249  0495 be00          	ldw	x,c_lreg
1250  0497 89            	pushw	x
1253                     ; 311   if (checkit == 1)
1255  0498 b600          	ld	a,_checkit
1256  049a a101          	cp	a,#1
1257  049c 2607          	jrne	L552
1258                     ; 331     sms_receive();
1260  049e cd0000        	call	_sms_receive
1262                     ; 332     checkit = 1;
1264  04a1 35010000      	mov	_checkit,#1
1265  04a5               L552:
1266                     ; 335 }
1269  04a5 85            	popw	x
1270  04a6 bf00          	ldw	c_lreg,x
1271  04a8 85            	popw	x
1272  04a9 bf02          	ldw	c_lreg+2,x
1273  04ab 85            	popw	x
1274  04ac bf00          	ldw	c_y,x
1275  04ae 320002        	pop	c_y+2
1276  04b1 85            	popw	x
1277  04b2 bf00          	ldw	c_x,x
1278  04b4 320002        	pop	c_x+2
1279  04b7 80            	iret
1302                     ; 345 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
1302                     ; 346 {
1303                     	switch	.text
1304  04b8               f_NonHandledInterrupt:
1308                     ; 350 }
1311  04b8 80            	iret
1333                     ; 358 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
1333                     ; 359 {
1334                     	switch	.text
1335  04b9               f_TRAP_IRQHandler:
1339                     ; 363 }
1342  04b9 80            	iret
1364                     ; 370 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
1364                     ; 371 
1364                     ; 372 {
1365                     	switch	.text
1366  04ba               f_TLI_IRQHandler:
1370                     ; 376 }
1373  04ba 80            	iret
1395                     ; 383 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
1395                     ; 384 {
1396                     	switch	.text
1397  04bb               f_AWU_IRQHandler:
1401                     ; 388 }
1404  04bb 80            	iret
1426                     ; 395 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
1426                     ; 396 {
1427                     	switch	.text
1428  04bc               f_CLK_IRQHandler:
1432                     ; 400 }
1435  04bc 80            	iret
1458                     ; 421 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
1458                     ; 422 {
1459                     	switch	.text
1460  04bd               f_EXTI_PORTB_IRQHandler:
1464                     ; 426 }
1467  04bd 80            	iret
1490                     ; 433 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
1490                     ; 434 {
1491                     	switch	.text
1492  04be               f_EXTI_PORTC_IRQHandler:
1496                     ; 438 }
1499  04be 80            	iret
1522                     ; 457 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
1522                     ; 458 {
1523                     	switch	.text
1524  04bf               f_EXTI_PORTE_IRQHandler:
1528                     ; 462 }
1531  04bf 80            	iret
1553                     ; 509 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
1553                     ; 510 {
1554                     	switch	.text
1555  04c0               f_SPI_IRQHandler:
1559                     ; 514 }
1562  04c0 80            	iret
1585                     ; 521 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
1585                     ; 522 {
1586                     	switch	.text
1587  04c1               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
1591                     ; 526 }
1594  04c1 80            	iret
1617                     ; 533 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
1617                     ; 534 {
1618                     	switch	.text
1619  04c2               f_TIM1_CAP_COM_IRQHandler:
1623                     ; 538 }
1626  04c2 80            	iret
1649                     ; 571 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
1649                     ; 572 {
1650                     	switch	.text
1651  04c3               f_TIM2_UPD_OVF_BRK_IRQHandler:
1655                     ; 576 }
1658  04c3 80            	iret
1681                     ; 583 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
1681                     ; 584 {
1682                     	switch	.text
1683  04c4               f_TIM2_CAP_COM_IRQHandler:
1687                     ; 588 }
1690  04c4 80            	iret
1713                     ; 598 INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
1713                     ; 599 {
1714                     	switch	.text
1715  04c5               f_TIM3_UPD_OVF_BRK_IRQHandler:
1719                     ; 603 }
1722  04c5 80            	iret
1745                     ; 610 INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
1745                     ; 611 {
1746                     	switch	.text
1747  04c6               f_TIM3_CAP_COM_IRQHandler:
1751                     ; 615 }
1754  04c6 80            	iret
1777                     ; 625 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
1777                     ; 626 {
1778                     	switch	.text
1779  04c7               f_UART1_TX_IRQHandler:
1783                     ; 630 }
1786  04c7 80            	iret
1809                     ; 637 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
1809                     ; 638 {
1810                     	switch	.text
1811  04c8               f_UART1_RX_IRQHandler:
1815                     ; 642 }
1818  04c8 80            	iret
1840                     ; 676 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
1840                     ; 677 {
1841                     	switch	.text
1842  04c9               f_I2C_IRQHandler:
1846                     ; 681 }
1849  04c9 80            	iret
1872                     ; 715 INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
1872                     ; 716 {
1873                     	switch	.text
1874  04ca               f_UART3_TX_IRQHandler:
1878                     ; 720 }
1881  04ca 80            	iret
1904                     ; 727 INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
1904                     ; 728 {
1905                     	switch	.text
1906  04cb               f_UART3_RX_IRQHandler:
1910                     ; 732 }
1913  04cb 80            	iret
1935                     ; 741 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
1935                     ; 742 {
1936                     	switch	.text
1937  04cc               f_ADC2_IRQHandler:
1941                     ; 746 }
1944  04cc 80            	iret
1967                     ; 781 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1967                     ; 782 {
1968                     	switch	.text
1969  04cd               f_TIM4_UPD_OVF_IRQHandler:
1973                     ; 786 }
1976  04cd 80            	iret
1999                     ; 794 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1999                     ; 795 {
2000                     	switch	.text
2001  04ce               f_EEPROM_EEC_IRQHandler:
2005                     ; 799 }
2008  04ce 80            	iret
2196                     	xdef	_powerAccumulateCount
2197                     	xdef	_storeEnergyPhase3
2198                     	xdef	_storeEnergyPhase2
2199                     	xdef	_storeEnergyPhase1
2200                     	switch	.ubsct
2201  0008               _energyPhase3:
2202  0008 00000000      	ds.b	4
2203                     	xdef	_energyPhase3
2204  000c               _energyPhase2:
2205  000c 00000000      	ds.b	4
2206                     	xdef	_energyPhase2
2207  0010               _energyPhase1:
2208  0010 00000000      	ds.b	4
2209                     	xdef	_energyPhase1
2210                     	xref.b	_ticsOverflowCounter
2211                     	xdef	_uartDataReadytoRead
2212                     	xdef	_timeoutForUART
2213                     	xdef	_power3ReadFlag
2214                     	xdef	_power2ReadFlag
2215                     	xdef	_power1ReadFlag
2216                     	xref.b	_powerPeriod3
2217                     	xref.b	_powerPeriod2
2218                     	xref.b	_powerPeriod1
2219                     	xdef	_power3OverflowCount
2220                     	xdef	_power2OverflowCount
2221                     	xdef	_power1OverflowCount
2222                     	xref	_sms_receive
2223                     	xdef	_voltCurrent3OverflowCount
2224                     	xdef	_voltCurrent2OverflowCount
2225                     	xdef	_voltCurrent1OverflowCount
2226                     	xref.b	_powerCalibrationFactor3
2227                     	xref.b	_powerCalibrationFactor2
2228                     	xref.b	_powerCalibrationFactor1
2229                     	xref	_calcWatt3
2230                     	xref	_calcWatt2
2231                     	xref	_calcWatt1
2232                     	xref	_vHandleDataRecvUARTviaISR
2233                     	xref	_vSerialRecieveISR
2234                     	xref	_Watt_Phase3
2235                     	xref	_Watt_Phase2
2236                     	xref	_Watt_Phase1
2237                     	xref.b	_checkit
2238                     	xdef	f_EEPROM_EEC_IRQHandler
2239                     	xdef	f_TIM4_UPD_OVF_IRQHandler
2240                     	xdef	f_ADC2_IRQHandler
2241                     	xdef	f_UART3_TX_IRQHandler
2242                     	xdef	f_UART3_RX_IRQHandler
2243                     	xdef	f_I2C_IRQHandler
2244                     	xdef	f_UART1_RX_IRQHandler
2245                     	xdef	f_UART1_TX_IRQHandler
2246                     	xdef	f_TIM3_CAP_COM_IRQHandler
2247                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
2248                     	xdef	f_TIM2_CAP_COM_IRQHandler
2249                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
2250                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
2251                     	xdef	f_TIM1_CAP_COM_IRQHandler
2252                     	xdef	f_SPI_IRQHandler
2253                     	xdef	f_EXTI_PORTE_IRQHandler
2254                     	xdef	f_EXTI_PORTC_IRQHandler
2255                     	xdef	f_EXTI_PORTB_IRQHandler
2256                     	xdef	f_CLK_IRQHandler
2257                     	xdef	f_AWU_IRQHandler
2258                     	xdef	f_TLI_IRQHandler
2259                     	xdef	f_TRAP_IRQHandler
2260                     	xdef	f_NonHandledInterrupt
2261                     	xref	_UART1_GetFlagStatus
2262                     	xref	_UART1_ReceiveData8
2263                     	xref	_TIM2_ClearITPendingBit
2264                     	xref	_TIM2_GetITStatus
2265                     	xref	_TIM2_ClearFlag
2266                     	xref	_TIM2_GetCapture1
2267                     	xref	_TIM1_ClearITPendingBit
2268                     	xref	_TIM1_GetITStatus
2269                     	xref	_TIM1_ClearFlag
2270                     	xref	_TIM1_GetCapture3
2271                     	xref	_TIM1_GetCapture1
2272                     	xdef	f_EXTI_PORTD_IRQHandler
2273                     	xdef	f_UART1_RCV_IRQHandler
2274                     	xdef	f_TIM1_CCP_IRQHandler
2275                     	xdef	f_TIM1_IRQHandler
2276                     	xdef	f_TIM2_CCP_IRQHandler
2277                     	xdef	f_TIM2_UPD_IRQHandler
2278                     	switch	.const
2279  0004               L14:
2280  0004 3ff34506      	dc.w	16371,17670
2281  0008               L13:
2282  0008 4c604e99      	dc.w	19552,20121
2283                     	xref.b	c_lreg
2284                     	xref.b	c_x
2285                     	xref.b	c_y
2305                     	xref	c_ladd
2306                     	xref	c_lsub
2307                     	xref	c_uitolx
2308                     	xref	c_umul
2309                     	xref	c_lgsub
2310                     	xref	c_lgadc
2311                     	xref	c_lcmp
2312                     	xref	c_ftol
2313                     	xref	c_fadd
2314                     	xref	c_fdiv
2315                     	xref	c_fmul
2316                     	xref	c_rtol
2317                     	xref	c_itof
2318                     	xref	c_ultof
2319                     	xref	c_ltor
2320                     	xref	c_lzmp
2321                     	end
