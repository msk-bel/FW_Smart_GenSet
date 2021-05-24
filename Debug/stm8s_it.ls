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
  34  0003               _checkit:
  35  0003 00            	dc.b	0
  36                     	bsct
  37  0006               _timeoutForUART:
  38  0006 0000          	dc.w	0
  39                     	switch	.bit
  40  0004               _uartDataReadytoRead:
  41  0004 00            	dc.b	0
  42                     	bsct
  43  0008               _storeEnergyPhase1:
  44  0008 00000000      	dc.l	0
  45  000c               _storeEnergyPhase2:
  46  000c 00000000      	dc.l	0
  47  0010               _storeEnergyPhase3:
  48  0010 00000000      	dc.l	0
  49  0014               _powerAccumulateCount:
  50  0014 00            	dc.b	0
 100                     .const:	section	.text
 101  0000               L6:
 102  0000 02255100      	dc.l	36000000
 103                     ; 73 void TIM1_IRQHandler(void) //to measure energy
 103                     ; 74 {
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
 126                     ; 75   voltCurrent1OverflowCount++;
 128  001a 3c00          	inc	_voltCurrent1OverflowCount
 129                     ; 76   if (powerAccumulateCount > powerAccumulateCountMax)
 131  001c b614          	ld	a,_powerAccumulateCount
 132  001e a13b          	cp	a,#59
 133  0020 2404          	jruge	L01
 134  0022 ac960196      	jpf	L12
 135  0026               L01:
 136                     ; 79     if (powerPeriod1 != 0)
 138  0026 ae0000        	ldw	x,#_powerPeriod1
 139  0029 cd0000        	call	c_lzmp
 141  002c 2602          	jrne	L21
 142  002e 2070          	jpf	L32
 143  0030               L21:
 144                     ; 81       storeEnergyPhase1 = storeEnergyPhase1 + ((float)(powerMultiplier * powerCalibrationFactor1) / powerPeriod1) * powerAccumulateTime;
 146  0030 ae0000        	ldw	x,#_powerPeriod1
 147  0033 cd0000        	call	c_ltor
 149  0036 cd0000        	call	c_ultof
 151  0039 96            	ldw	x,sp
 152  003a 1c0005        	addw	x,#OFST-3
 153  003d cd0000        	call	c_rtol
 156  0040 b600          	ld	a,_powerCalibrationFactor1
 157  0042 5f            	clrw	x
 158  0043 97            	ld	xl,a
 159  0044 cd0000        	call	c_itof
 161  0047 ae0008        	ldw	x,#L13
 162  004a cd0000        	call	c_fmul
 164  004d 96            	ldw	x,sp
 165  004e 1c0005        	addw	x,#OFST-3
 166  0051 cd0000        	call	c_fdiv
 168  0054 ae0004        	ldw	x,#L14
 169  0057 cd0000        	call	c_fmul
 171  005a 96            	ldw	x,sp
 172  005b 1c0001        	addw	x,#OFST-7
 173  005e cd0000        	call	c_rtol
 176  0061 ae0008        	ldw	x,#_storeEnergyPhase1
 177  0064 cd0000        	call	c_ltor
 179  0067 cd0000        	call	c_ultof
 181  006a 96            	ldw	x,sp
 182  006b 1c0001        	addw	x,#OFST-7
 183  006e cd0000        	call	c_fadd
 185  0071 cd0000        	call	c_ftol
 187  0074 ae0008        	ldw	x,#_storeEnergyPhase1
 188  0077 cd0000        	call	c_rtol
 190                     ; 83       if ((storeEnergyPhase1 >= energyResolution))
 192  007a ae0008        	ldw	x,#_storeEnergyPhase1
 193  007d cd0000        	call	c_ltor
 195  0080 ae0000        	ldw	x,#L6
 196  0083 cd0000        	call	c_lcmp
 198  0086 2518          	jrult	L32
 199                     ; 85         energyPhase1++;
 201  0088 ae0010        	ldw	x,#_energyPhase1
 202  008b a601          	ld	a,#1
 203  008d cd0000        	call	c_lgadc
 205                     ; 86         storeEnergyPhase1 = storeEnergyPhase1 - energyResolution;
 207  0090 ae5100        	ldw	x,#20736
 208  0093 bf02          	ldw	c_lreg+2,x
 209  0095 ae0225        	ldw	x,#549
 210  0098 bf00          	ldw	c_lreg,x
 211  009a ae0008        	ldw	x,#_storeEnergyPhase1
 212  009d cd0000        	call	c_lgsub
 214  00a0               L32:
 215                     ; 90     if (powerPeriod2 != 0)
 217  00a0 ae0000        	ldw	x,#_powerPeriod2
 218  00a3 cd0000        	call	c_lzmp
 220  00a6 2602          	jrne	L41
 221  00a8 2070          	jpf	L74
 222  00aa               L41:
 223                     ; 92       storeEnergyPhase2 = storeEnergyPhase2 + ((float)(powerMultiplier * powerCalibrationFactor2) / powerPeriod2) * powerAccumulateTime;
 225  00aa ae0000        	ldw	x,#_powerPeriod2
 226  00ad cd0000        	call	c_ltor
 228  00b0 cd0000        	call	c_ultof
 230  00b3 96            	ldw	x,sp
 231  00b4 1c0005        	addw	x,#OFST-3
 232  00b7 cd0000        	call	c_rtol
 235  00ba b600          	ld	a,_powerCalibrationFactor2
 236  00bc 5f            	clrw	x
 237  00bd 97            	ld	xl,a
 238  00be cd0000        	call	c_itof
 240  00c1 ae0008        	ldw	x,#L13
 241  00c4 cd0000        	call	c_fmul
 243  00c7 96            	ldw	x,sp
 244  00c8 1c0005        	addw	x,#OFST-3
 245  00cb cd0000        	call	c_fdiv
 247  00ce ae0004        	ldw	x,#L14
 248  00d1 cd0000        	call	c_fmul
 250  00d4 96            	ldw	x,sp
 251  00d5 1c0001        	addw	x,#OFST-7
 252  00d8 cd0000        	call	c_rtol
 255  00db ae000c        	ldw	x,#_storeEnergyPhase2
 256  00de cd0000        	call	c_ltor
 258  00e1 cd0000        	call	c_ultof
 260  00e4 96            	ldw	x,sp
 261  00e5 1c0001        	addw	x,#OFST-7
 262  00e8 cd0000        	call	c_fadd
 264  00eb cd0000        	call	c_ftol
 266  00ee ae000c        	ldw	x,#_storeEnergyPhase2
 267  00f1 cd0000        	call	c_rtol
 269                     ; 94       if ((storeEnergyPhase2 >= energyResolution))
 271  00f4 ae000c        	ldw	x,#_storeEnergyPhase2
 272  00f7 cd0000        	call	c_ltor
 274  00fa ae0000        	ldw	x,#L6
 275  00fd cd0000        	call	c_lcmp
 277  0100 2518          	jrult	L74
 278                     ; 96         energyPhase2++;
 280  0102 ae000c        	ldw	x,#_energyPhase2
 281  0105 a601          	ld	a,#1
 282  0107 cd0000        	call	c_lgadc
 284                     ; 97         storeEnergyPhase2 = storeEnergyPhase2 - energyResolution;
 286  010a ae5100        	ldw	x,#20736
 287  010d bf02          	ldw	c_lreg+2,x
 288  010f ae0225        	ldw	x,#549
 289  0112 bf00          	ldw	c_lreg,x
 290  0114 ae000c        	ldw	x,#_storeEnergyPhase2
 291  0117 cd0000        	call	c_lgsub
 293  011a               L74:
 294                     ; 101     if (powerPeriod3 != 0)
 296  011a ae0000        	ldw	x,#_powerPeriod3
 297  011d cd0000        	call	c_lzmp
 299  0120 2602          	jrne	L61
 300  0122 2070          	jpf	L35
 301  0124               L61:
 302                     ; 103       storeEnergyPhase3 = storeEnergyPhase3 + ((float)(powerMultiplier * powerCalibrationFactor3) / powerPeriod3) * powerAccumulateTime;
 304  0124 ae0000        	ldw	x,#_powerPeriod3
 305  0127 cd0000        	call	c_ltor
 307  012a cd0000        	call	c_ultof
 309  012d 96            	ldw	x,sp
 310  012e 1c0005        	addw	x,#OFST-3
 311  0131 cd0000        	call	c_rtol
 314  0134 b600          	ld	a,_powerCalibrationFactor3
 315  0136 5f            	clrw	x
 316  0137 97            	ld	xl,a
 317  0138 cd0000        	call	c_itof
 319  013b ae0008        	ldw	x,#L13
 320  013e cd0000        	call	c_fmul
 322  0141 96            	ldw	x,sp
 323  0142 1c0005        	addw	x,#OFST-3
 324  0145 cd0000        	call	c_fdiv
 326  0148 ae0004        	ldw	x,#L14
 327  014b cd0000        	call	c_fmul
 329  014e 96            	ldw	x,sp
 330  014f 1c0001        	addw	x,#OFST-7
 331  0152 cd0000        	call	c_rtol
 334  0155 ae0010        	ldw	x,#_storeEnergyPhase3
 335  0158 cd0000        	call	c_ltor
 337  015b cd0000        	call	c_ultof
 339  015e 96            	ldw	x,sp
 340  015f 1c0001        	addw	x,#OFST-7
 341  0162 cd0000        	call	c_fadd
 343  0165 cd0000        	call	c_ftol
 345  0168 ae0010        	ldw	x,#_storeEnergyPhase3
 346  016b cd0000        	call	c_rtol
 348                     ; 105       if ((storeEnergyPhase3 >= energyResolution))
 350  016e ae0010        	ldw	x,#_storeEnergyPhase3
 351  0171 cd0000        	call	c_ltor
 353  0174 ae0000        	ldw	x,#L6
 354  0177 cd0000        	call	c_lcmp
 356  017a 2518          	jrult	L35
 357                     ; 107         energyPhase3++;
 359  017c ae0008        	ldw	x,#_energyPhase3
 360  017f a601          	ld	a,#1
 361  0181 cd0000        	call	c_lgadc
 363                     ; 108         storeEnergyPhase3 = storeEnergyPhase3 - energyResolution;
 365  0184 ae5100        	ldw	x,#20736
 366  0187 bf02          	ldw	c_lreg+2,x
 367  0189 ae0225        	ldw	x,#549
 368  018c bf00          	ldw	c_lreg,x
 369  018e ae0010        	ldw	x,#_storeEnergyPhase3
 370  0191 cd0000        	call	c_lgsub
 372  0194               L35:
 373                     ; 112     powerAccumulateCount = 0;
 375  0194 3f14          	clr	_powerAccumulateCount
 376  0196               L12:
 377                     ; 115   if (power1OverflowCount < powerOverflowCountMax)
 379  0196 b603          	ld	a,_power1OverflowCount
 380  0198 a164          	cp	a,#100
 381  019a 2404          	jruge	L75
 382                     ; 117     power1OverflowCount++;
 384  019c 3c03          	inc	_power1OverflowCount
 386  019e 200e          	jra	L16
 387  01a0               L75:
 388                     ; 122     powerPeriod1 = 0;
 390  01a0 ae0000        	ldw	x,#0
 391  01a3 bf02          	ldw	_powerPeriod1+2,x
 392  01a5 ae0000        	ldw	x,#0
 393  01a8 bf00          	ldw	_powerPeriod1,x
 394                     ; 123     power1ReadFlag = false;
 396  01aa 72110000      	bres	_power1ReadFlag
 397  01ae               L16:
 398                     ; 129   if (power2OverflowCount < powerOverflowCountMax)
 400  01ae b604          	ld	a,_power2OverflowCount
 401  01b0 a164          	cp	a,#100
 402  01b2 2404          	jruge	L36
 403                     ; 131     power2OverflowCount++;
 405  01b4 3c04          	inc	_power2OverflowCount
 407  01b6 200e          	jra	L56
 408  01b8               L36:
 409                     ; 136     powerPeriod2 = 0;
 411  01b8 ae0000        	ldw	x,#0
 412  01bb bf02          	ldw	_powerPeriod2+2,x
 413  01bd ae0000        	ldw	x,#0
 414  01c0 bf00          	ldw	_powerPeriod2,x
 415                     ; 137     power2ReadFlag = false;
 417  01c2 72110001      	bres	_power2ReadFlag
 418  01c6               L56:
 419                     ; 143   powerAccumulateCount++;
 421  01c6 3c14          	inc	_powerAccumulateCount
 422                     ; 145   voltCurrent2OverflowCount++;
 424  01c8 3c01          	inc	_voltCurrent2OverflowCount
 425                     ; 147   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 427  01ca a601          	ld	a,#1
 428  01cc cd0000        	call	_TIM1_ClearITPendingBit
 430                     ; 148   TIM1_ClearFlag(TIM1_FLAG_UPDATE);
 432  01cf ae0001        	ldw	x,#1
 433  01d2 cd0000        	call	_TIM1_ClearFlag
 435                     ; 149 }
 438  01d5 5b08          	addw	sp,#8
 439  01d7 85            	popw	x
 440  01d8 bf00          	ldw	c_lreg,x
 441  01da 85            	popw	x
 442  01db bf02          	ldw	c_lreg+2,x
 443  01dd 85            	popw	x
 444  01de bf00          	ldw	c_y,x
 445  01e0 320002        	pop	c_y+2
 446  01e3 85            	popw	x
 447  01e4 bf00          	ldw	c_x,x
 448  01e6 320002        	pop	c_x+2
 449  01e9 80            	iret
 479                     ; 151 void TIM2_UPD_IRQHandler(void) //to control power,voltage,current overflow counter
 479                     ; 152 {
 480                     	switch	.text
 481  01ea               f_TIM2_UPD_IRQHandler:
 483  01ea 8a            	push	cc
 484  01eb 84            	pop	a
 485  01ec a4bf          	and	a,#191
 486  01ee 88            	push	a
 487  01ef 86            	pop	cc
 488  01f0 3b0002        	push	c_x+2
 489  01f3 be00          	ldw	x,c_x
 490  01f5 89            	pushw	x
 491  01f6 3b0002        	push	c_y+2
 492  01f9 be00          	ldw	x,c_y
 493  01fb 89            	pushw	x
 496                     ; 153   ticsOverflowCounter++;
 498  01fc ae0000        	ldw	x,#_ticsOverflowCounter
 499  01ff a601          	ld	a,#1
 500  0201 cd0000        	call	c_lgadc
 502                     ; 155   if (power3OverflowCount < powerOverflowCountMax)
 504  0204 b605          	ld	a,_power3OverflowCount
 505  0206 a164          	cp	a,#100
 506  0208 2404          	jruge	L77
 507                     ; 157     power3OverflowCount++;
 509  020a 3c05          	inc	_power3OverflowCount
 511  020c 200e          	jra	L101
 512  020e               L77:
 513                     ; 161     powerPeriod3 = 0;
 515  020e ae0000        	ldw	x,#0
 516  0211 bf02          	ldw	_powerPeriod3+2,x
 517  0213 ae0000        	ldw	x,#0
 518  0216 bf00          	ldw	_powerPeriod3,x
 519                     ; 162     power3ReadFlag = false;
 521  0218 72110002      	bres	_power3ReadFlag
 522  021c               L101:
 523                     ; 168   voltCurrent3OverflowCount++;
 525  021c 3c02          	inc	_voltCurrent3OverflowCount
 526                     ; 170   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 528  021e a601          	ld	a,#1
 529  0220 cd0000        	call	_TIM2_ClearITPendingBit
 531                     ; 171   TIM2_ClearFlag(TIM2_FLAG_UPDATE);
 533  0223 ae0001        	ldw	x,#1
 534  0226 cd0000        	call	_TIM2_ClearFlag
 536                     ; 172 }
 539  0229 85            	popw	x
 540  022a bf00          	ldw	c_y,x
 541  022c 320002        	pop	c_y+2
 542  022f 85            	popw	x
 543  0230 bf00          	ldw	c_x,x
 544  0232 320002        	pop	c_x+2
 545  0235 80            	iret
 547                     	switch	.ubsct
 548  0000               L301_powerEndTime:
 549  0000 0000          	ds.b	2
 550  0002               L501_power3StartTime:
 551  0002 0000          	ds.b	2
 631                     ; 181 void TIM2_CCP_IRQHandler(void)
 631                     ; 182 {
 632                     	switch	.text
 633  0236               f_TIM2_CCP_IRQHandler:
 635  0236 8a            	push	cc
 636  0237 84            	pop	a
 637  0238 a4bf          	and	a,#191
 638  023a 88            	push	a
 639  023b 86            	pop	cc
 640       00000009      OFST:	set	9
 641  023c 3b0002        	push	c_x+2
 642  023f be00          	ldw	x,c_x
 643  0241 89            	pushw	x
 644  0242 3b0002        	push	c_y+2
 645  0245 be00          	ldw	x,c_y
 646  0247 89            	pushw	x
 647  0248 be02          	ldw	x,c_lreg+2
 648  024a 89            	pushw	x
 649  024b be00          	ldw	x,c_lreg
 650  024d 89            	pushw	x
 651  024e 5209          	subw	sp,#9
 654                     ; 190   timer2Ch1_ITStatus = TIM2_GetITStatus(TIM2_IT_CC1);
 656  0250 a602          	ld	a,#2
 657  0252 cd0000        	call	_TIM2_GetITStatus
 659  0255 6b09          	ld	(OFST+0,sp),a
 661                     ; 192   if (timer2Ch1_ITStatus == SET)
 663  0257 7b09          	ld	a,(OFST+0,sp)
 664  0259 a101          	cp	a,#1
 665  025b 2663          	jrne	L541
 666                     ; 194     powerEndTime = TIM2_GetCapture1(); /* Read Timer value on Input Capture event */
 668  025d cd0000        	call	_TIM2_GetCapture1
 670  0260 bf00          	ldw	L301_powerEndTime,x
 671                     ; 196     if (power3ReadFlag == true) /* Avoid Calculation on first capture */
 673                     	btst	_power3ReadFlag
 674  0267 2442          	jruge	L741
 675                     ; 198       powerPeriod3 = timer2MaxCount * power3OverflowCount - power3StartTime + powerEndTime;
 677  0269 be00          	ldw	x,L301_powerEndTime
 678  026b cd0000        	call	c_uitolx
 680  026e 96            	ldw	x,sp
 681  026f 1c0005        	addw	x,#OFST-4
 682  0272 cd0000        	call	c_rtol
 685  0275 be02          	ldw	x,L501_power3StartTime
 686  0277 cd0000        	call	c_uitolx
 688  027a 96            	ldw	x,sp
 689  027b 1c0001        	addw	x,#OFST-8
 690  027e cd0000        	call	c_rtol
 693  0281 b605          	ld	a,_power3OverflowCount
 694  0283 5f            	clrw	x
 695  0284 97            	ld	xl,a
 696  0285 90aeffff      	ldw	y,#65535
 697  0289 cd0000        	call	c_umul
 699  028c 96            	ldw	x,sp
 700  028d 1c0001        	addw	x,#OFST-8
 701  0290 cd0000        	call	c_lsub
 703  0293 96            	ldw	x,sp
 704  0294 1c0005        	addw	x,#OFST-4
 705  0297 cd0000        	call	c_ladd
 707  029a ae0000        	ldw	x,#_powerPeriod3
 708  029d cd0000        	call	c_rtol
 710                     ; 199       calcWatt3(powerPeriod3);
 712  02a0 be02          	ldw	x,_powerPeriod3+2
 713  02a2 89            	pushw	x
 714  02a3 be00          	ldw	x,_powerPeriod3
 715  02a5 89            	pushw	x
 716  02a6 cd0000        	call	_calcWatt3
 718  02a9 5b04          	addw	sp,#4
 719  02ab               L741:
 720                     ; 219     power3StartTime = powerEndTime;
 722  02ab be00          	ldw	x,L301_powerEndTime
 723  02ad bf02          	ldw	L501_power3StartTime,x
 724                     ; 220     power3OverflowCount = 0;
 726  02af 3f05          	clr	_power3OverflowCount
 727                     ; 221     power3ReadFlag = true;
 729  02b1 72100002      	bset	_power3ReadFlag
 730                     ; 222     TIM2_ClearITPendingBit(TIM2_IT_CC1);
 732  02b5 a602          	ld	a,#2
 733  02b7 cd0000        	call	_TIM2_ClearITPendingBit
 735                     ; 223     TIM2_ClearFlag(TIM2_FLAG_CC1);
 737  02ba ae0002        	ldw	x,#2
 738  02bd cd0000        	call	_TIM2_ClearFlag
 740  02c0               L541:
 741                     ; 225 }
 744  02c0 5b09          	addw	sp,#9
 745  02c2 85            	popw	x
 746  02c3 bf00          	ldw	c_lreg,x
 747  02c5 85            	popw	x
 748  02c6 bf02          	ldw	c_lreg+2,x
 749  02c8 85            	popw	x
 750  02c9 bf00          	ldw	c_y,x
 751  02cb 320002        	pop	c_y+2
 752  02ce 85            	popw	x
 753  02cf bf00          	ldw	c_x,x
 754  02d1 320002        	pop	c_x+2
 755  02d4 80            	iret
 757                     	switch	.ubsct
 758  0004               L351_power2StartTime:
 759  0004 0000          	ds.b	2
 760  0006               L151_power1StartTime:
 761  0006 0000          	ds.b	2
 843                     ; 235 void TIM1_CCP_IRQHandler(void)
 843                     ; 236 {
 844                     	switch	.text
 845  02d5               f_TIM1_CCP_IRQHandler:
 847  02d5 8a            	push	cc
 848  02d6 84            	pop	a
 849  02d7 a4bf          	and	a,#191
 850  02d9 88            	push	a
 851  02da 86            	pop	cc
 852       0000000b      OFST:	set	11
 853  02db 3b0002        	push	c_x+2
 854  02de be00          	ldw	x,c_x
 855  02e0 89            	pushw	x
 856  02e1 3b0002        	push	c_y+2
 857  02e4 be00          	ldw	x,c_y
 858  02e6 89            	pushw	x
 859  02e7 be02          	ldw	x,c_lreg+2
 860  02e9 89            	pushw	x
 861  02ea be00          	ldw	x,c_lreg
 862  02ec 89            	pushw	x
 863  02ed 520b          	subw	sp,#11
 866                     ; 243   timer1Ch1_ITStatus = TIM1_GetITStatus(TIM1_IT_CC1);
 868  02ef a602          	ld	a,#2
 869  02f1 cd0000        	call	_TIM1_GetITStatus
 871  02f4 6b09          	ld	(OFST-2,sp),a
 873                     ; 244   if (timer1Ch1_ITStatus == SET)
 875  02f6 7b09          	ld	a,(OFST-2,sp)
 876  02f8 a101          	cp	a,#1
 877  02fa 2658          	jrne	L312
 878                     ; 246     powerEndTime = TIM1_GetCapture1();
 880  02fc cd0000        	call	_TIM1_GetCapture1
 882  02ff 1f0a          	ldw	(OFST-1,sp),x
 884                     ; 248     if (power1ReadFlag == true) /* Avoid Calculation on first capture */
 886                     	btst	_power1ReadFlag
 887  0306 2437          	jruge	L512
 888                     ; 250       powerPeriod1 = ((timer1MaxCount * power1OverflowCount) - power1StartTime) + powerEndTime;
 890  0308 1e0a          	ldw	x,(OFST-1,sp)
 891  030a cd0000        	call	c_uitolx
 893  030d 96            	ldw	x,sp
 894  030e 1c0005        	addw	x,#OFST-6
 895  0311 cd0000        	call	c_rtol
 898  0314 be06          	ldw	x,L151_power1StartTime
 899  0316 cd0000        	call	c_uitolx
 901  0319 96            	ldw	x,sp
 902  031a 1c0001        	addw	x,#OFST-10
 903  031d cd0000        	call	c_rtol
 906  0320 b603          	ld	a,_power1OverflowCount
 907  0322 5f            	clrw	x
 908  0323 97            	ld	xl,a
 909  0324 90aeffff      	ldw	y,#65535
 910  0328 cd0000        	call	c_umul
 912  032b 96            	ldw	x,sp
 913  032c 1c0001        	addw	x,#OFST-10
 914  032f cd0000        	call	c_lsub
 916  0332 96            	ldw	x,sp
 917  0333 1c0005        	addw	x,#OFST-6
 918  0336 cd0000        	call	c_ladd
 920  0339 ae0000        	ldw	x,#_powerPeriod1
 921  033c cd0000        	call	c_rtol
 923  033f               L512:
 924                     ; 257     power1StartTime = powerEndTime;
 926  033f 1e0a          	ldw	x,(OFST-1,sp)
 927  0341 bf06          	ldw	L151_power1StartTime,x
 928                     ; 258     power1OverflowCount = 0;
 930  0343 3f03          	clr	_power1OverflowCount
 931                     ; 259     power1ReadFlag = true;
 933  0345 72100000      	bset	_power1ReadFlag
 934                     ; 260     TIM1_ClearITPendingBit(TIM1_IT_CC1);
 936  0349 a602          	ld	a,#2
 937  034b cd0000        	call	_TIM1_ClearITPendingBit
 939                     ; 261     TIM1_ClearFlag(TIM1_FLAG_CC1);
 941  034e ae0002        	ldw	x,#2
 942  0351 cd0000        	call	_TIM1_ClearFlag
 944  0354               L312:
 945                     ; 264   timer1Ch3_ITStatus = TIM1_GetITStatus(TIM1_IT_CC2); /* Interrupt status check */
 947  0354 a604          	ld	a,#4
 948  0356 cd0000        	call	_TIM1_GetITStatus
 950  0359 6b09          	ld	(OFST-2,sp),a
 952                     ; 266   if (timer1Ch3_ITStatus == SET)
 954  035b 7b09          	ld	a,(OFST-2,sp)
 955  035d a101          	cp	a,#1
 956  035f 2658          	jrne	L712
 957                     ; 268     powerEndTime = TIM1_GetCapture3();
 959  0361 cd0000        	call	_TIM1_GetCapture3
 961  0364 1f0a          	ldw	(OFST-1,sp),x
 963                     ; 270     if (power2ReadFlag == true) /* Avoid Calculation on first capture */
 965                     	btst	_power2ReadFlag
 966  036b 2437          	jruge	L122
 967                     ; 272       powerPeriod2 = timer1MaxCount * power2OverflowCount - power2StartTime + powerEndTime;
 969  036d 1e0a          	ldw	x,(OFST-1,sp)
 970  036f cd0000        	call	c_uitolx
 972  0372 96            	ldw	x,sp
 973  0373 1c0005        	addw	x,#OFST-6
 974  0376 cd0000        	call	c_rtol
 977  0379 be04          	ldw	x,L351_power2StartTime
 978  037b cd0000        	call	c_uitolx
 980  037e 96            	ldw	x,sp
 981  037f 1c0001        	addw	x,#OFST-10
 982  0382 cd0000        	call	c_rtol
 985  0385 b604          	ld	a,_power2OverflowCount
 986  0387 5f            	clrw	x
 987  0388 97            	ld	xl,a
 988  0389 90aeffff      	ldw	y,#65535
 989  038d cd0000        	call	c_umul
 991  0390 96            	ldw	x,sp
 992  0391 1c0001        	addw	x,#OFST-10
 993  0394 cd0000        	call	c_lsub
 995  0397 96            	ldw	x,sp
 996  0398 1c0005        	addw	x,#OFST-6
 997  039b cd0000        	call	c_ladd
 999  039e ae0000        	ldw	x,#_powerPeriod2
1000  03a1 cd0000        	call	c_rtol
1002  03a4               L122:
1003                     ; 278     power2StartTime = powerEndTime;
1005  03a4 1e0a          	ldw	x,(OFST-1,sp)
1006  03a6 bf04          	ldw	L351_power2StartTime,x
1007                     ; 279     power2OverflowCount = 0;
1009  03a8 3f04          	clr	_power2OverflowCount
1010                     ; 280     power2ReadFlag = true;
1012  03aa 72100001      	bset	_power2ReadFlag
1013                     ; 281     TIM1_ClearITPendingBit(TIM1_IT_CC3);
1015  03ae a608          	ld	a,#8
1016  03b0 cd0000        	call	_TIM1_ClearITPendingBit
1018                     ; 282     TIM1_ClearFlag(TIM1_FLAG_CC3);
1020  03b3 ae0008        	ldw	x,#8
1021  03b6 cd0000        	call	_TIM1_ClearFlag
1023  03b9               L712:
1024                     ; 284 }
1027  03b9 5b0b          	addw	sp,#11
1028  03bb 85            	popw	x
1029  03bc bf00          	ldw	c_lreg,x
1030  03be 85            	popw	x
1031  03bf bf02          	ldw	c_lreg+2,x
1032  03c1 85            	popw	x
1033  03c2 bf00          	ldw	c_y,x
1034  03c4 320002        	pop	c_y+2
1035  03c7 85            	popw	x
1036  03c8 bf00          	ldw	c_x,x
1037  03ca 320002        	pop	c_x+2
1038  03cd 80            	iret
1076                     ; 286 @svlreg void UART1_RCV_IRQHandler(void) // recieve data intrrupt
1076                     ; 287 {
1077                     	switch	.text
1078  03ce               f_UART1_RCV_IRQHandler:
1080  03ce 8a            	push	cc
1081  03cf 84            	pop	a
1082  03d0 a4bf          	and	a,#191
1083  03d2 88            	push	a
1084  03d3 86            	pop	cc
1085       00000001      OFST:	set	1
1086  03d4 3b0002        	push	c_x+2
1087  03d7 be00          	ldw	x,c_x
1088  03d9 89            	pushw	x
1089  03da 3b0002        	push	c_y+2
1090  03dd be00          	ldw	x,c_y
1091  03df 89            	pushw	x
1092  03e0 be02          	ldw	x,c_lreg+2
1093  03e2 89            	pushw	x
1094  03e3 be00          	ldw	x,c_lreg
1095  03e5 89            	pushw	x
1096  03e6 88            	push	a
1099                     ; 288   if (UART1_GetFlagStatus(UART1_FLAG_RXNE)) // If Data is Recieved, this clears
1101  03e7 ae0020        	ldw	x,#32
1102  03ea cd0000        	call	_UART1_GetFlagStatus
1104  03ed 4d            	tnz	a
1105  03ee 2703          	jreq	L142
1106                     ; 290     vSerialRecieveISR();
1108  03f0 cd0000        	call	_vSerialRecieveISR
1110  03f3               L142:
1111                     ; 294   if (UART1_GetFlagStatus(UART1_FLAG_IDLE)) // If Data is Recieved, this clears
1113  03f3 ae0010        	ldw	x,#16
1114  03f6 cd0000        	call	_UART1_GetFlagStatus
1116  03f9 4d            	tnz	a
1117  03fa 2706          	jreq	L342
1118                     ; 296     uint8_t temp = UART1_ReceiveData8(); // This will clear IDLE Flag
1120  03fc cd0000        	call	_UART1_ReceiveData8
1122                     ; 297     vHandleDataRecvUARTviaISR();
1124  03ff cd0000        	call	_vHandleDataRecvUARTviaISR
1126  0402               L342:
1127                     ; 299 }
1130  0402 84            	pop	a
1131  0403 85            	popw	x
1132  0404 bf00          	ldw	c_lreg,x
1133  0406 85            	popw	x
1134  0407 bf02          	ldw	c_lreg+2,x
1135  0409 85            	popw	x
1136  040a bf00          	ldw	c_y,x
1137  040c 320002        	pop	c_y+2
1138  040f 85            	popw	x
1139  0410 bf00          	ldw	c_x,x
1140  0412 320002        	pop	c_x+2
1141  0415 80            	iret
1166                     ; 301 @svlreg void EXTI_PORTD_IRQHandler(void)
1166                     ; 302 {
1167                     	switch	.text
1168  0416               f_EXTI_PORTD_IRQHandler:
1170  0416 8a            	push	cc
1171  0417 84            	pop	a
1172  0418 a4bf          	and	a,#191
1173  041a 88            	push	a
1174  041b 86            	pop	cc
1175  041c 3b0002        	push	c_x+2
1176  041f be00          	ldw	x,c_x
1177  0421 89            	pushw	x
1178  0422 3b0002        	push	c_y+2
1179  0425 be00          	ldw	x,c_y
1180  0427 89            	pushw	x
1181  0428 be02          	ldw	x,c_lreg+2
1182  042a 89            	pushw	x
1183  042b be00          	ldw	x,c_lreg
1184  042d 89            	pushw	x
1187                     ; 305   if (checkit == true)
1189                     	btst	_checkit
1190  0433 2403          	jruge	L552
1191                     ; 325     sms_receive();
1193  0435 cd0000        	call	_sms_receive
1195  0438               L552:
1196                     ; 327   checkit = true;
1198  0438 72100003      	bset	_checkit
1199                     ; 328 }
1202  043c 85            	popw	x
1203  043d bf00          	ldw	c_lreg,x
1204  043f 85            	popw	x
1205  0440 bf02          	ldw	c_lreg+2,x
1206  0442 85            	popw	x
1207  0443 bf00          	ldw	c_y,x
1208  0445 320002        	pop	c_y+2
1209  0448 85            	popw	x
1210  0449 bf00          	ldw	c_x,x
1211  044b 320002        	pop	c_x+2
1212  044e 80            	iret
1235                     ; 338 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
1235                     ; 339 {
1236                     	switch	.text
1237  044f               f_NonHandledInterrupt:
1241                     ; 343 }
1244  044f 80            	iret
1266                     ; 351 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
1266                     ; 352 {
1267                     	switch	.text
1268  0450               f_TRAP_IRQHandler:
1272                     ; 356 }
1275  0450 80            	iret
1297                     ; 363 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
1297                     ; 364 
1297                     ; 365 {
1298                     	switch	.text
1299  0451               f_TLI_IRQHandler:
1303                     ; 369 }
1306  0451 80            	iret
1328                     ; 376 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
1328                     ; 377 {
1329                     	switch	.text
1330  0452               f_AWU_IRQHandler:
1334                     ; 381 }
1337  0452 80            	iret
1359                     ; 388 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
1359                     ; 389 {
1360                     	switch	.text
1361  0453               f_CLK_IRQHandler:
1365                     ; 393 }
1368  0453 80            	iret
1391                     ; 414 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
1391                     ; 415 {
1392                     	switch	.text
1393  0454               f_EXTI_PORTB_IRQHandler:
1397                     ; 419 }
1400  0454 80            	iret
1423                     ; 426 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
1423                     ; 427 {
1424                     	switch	.text
1425  0455               f_EXTI_PORTC_IRQHandler:
1429                     ; 431 }
1432  0455 80            	iret
1455                     ; 450 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
1455                     ; 451 {
1456                     	switch	.text
1457  0456               f_EXTI_PORTE_IRQHandler:
1461                     ; 455 }
1464  0456 80            	iret
1486                     ; 502 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
1486                     ; 503 {
1487                     	switch	.text
1488  0457               f_SPI_IRQHandler:
1492                     ; 507 }
1495  0457 80            	iret
1518                     ; 514 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
1518                     ; 515 {
1519                     	switch	.text
1520  0458               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
1524                     ; 519 }
1527  0458 80            	iret
1550                     ; 526 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
1550                     ; 527 {
1551                     	switch	.text
1552  0459               f_TIM1_CAP_COM_IRQHandler:
1556                     ; 531 }
1559  0459 80            	iret
1582                     ; 564 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
1582                     ; 565 {
1583                     	switch	.text
1584  045a               f_TIM2_UPD_OVF_BRK_IRQHandler:
1588                     ; 569 }
1591  045a 80            	iret
1614                     ; 576 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
1614                     ; 577 {
1615                     	switch	.text
1616  045b               f_TIM2_CAP_COM_IRQHandler:
1620                     ; 581 }
1623  045b 80            	iret
1646                     ; 591 INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
1646                     ; 592 {
1647                     	switch	.text
1648  045c               f_TIM3_UPD_OVF_BRK_IRQHandler:
1652                     ; 596 }
1655  045c 80            	iret
1678                     ; 603 INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
1678                     ; 604 {
1679                     	switch	.text
1680  045d               f_TIM3_CAP_COM_IRQHandler:
1684                     ; 608 }
1687  045d 80            	iret
1710                     ; 618 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
1710                     ; 619 {
1711                     	switch	.text
1712  045e               f_UART1_TX_IRQHandler:
1716                     ; 623 }
1719  045e 80            	iret
1742                     ; 630 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
1742                     ; 631 {
1743                     	switch	.text
1744  045f               f_UART1_RX_IRQHandler:
1748                     ; 635 }
1751  045f 80            	iret
1773                     ; 669 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
1773                     ; 670 {
1774                     	switch	.text
1775  0460               f_I2C_IRQHandler:
1779                     ; 674 }
1782  0460 80            	iret
1805                     ; 708 INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
1805                     ; 709 {
1806                     	switch	.text
1807  0461               f_UART3_TX_IRQHandler:
1811                     ; 713 }
1814  0461 80            	iret
1837                     ; 720 INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
1837                     ; 721 {
1838                     	switch	.text
1839  0462               f_UART3_RX_IRQHandler:
1843                     ; 725 }
1846  0462 80            	iret
1868                     ; 734 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
1868                     ; 735 {
1869                     	switch	.text
1870  0463               f_ADC2_IRQHandler:
1874                     ; 739 }
1877  0463 80            	iret
1900                     ; 774 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1900                     ; 775 {
1901                     	switch	.text
1902  0464               f_TIM4_UPD_OVF_IRQHandler:
1906                     ; 779 }
1909  0464 80            	iret
1932                     ; 787 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1932                     ; 788 {
1933                     	switch	.text
1934  0465               f_EEPROM_EEC_IRQHandler:
1938                     ; 792 }
1941  0465 80            	iret
2139                     	xdef	_powerAccumulateCount
2140                     	xdef	_storeEnergyPhase3
2141                     	xdef	_storeEnergyPhase2
2142                     	xdef	_storeEnergyPhase1
2143                     	switch	.ubsct
2144  0008               _energyPhase3:
2145  0008 00000000      	ds.b	4
2146                     	xdef	_energyPhase3
2147  000c               _energyPhase2:
2148  000c 00000000      	ds.b	4
2149                     	xdef	_energyPhase2
2150  0010               _energyPhase1:
2151  0010 00000000      	ds.b	4
2152                     	xdef	_energyPhase1
2153                     	xref.b	_ticsOverflowCounter
2154                     	xdef	_uartDataReadytoRead
2155                     	xdef	_timeoutForUART
2156                     	xdef	_checkit
2157                     	xdef	_power3ReadFlag
2158                     	xdef	_power2ReadFlag
2159                     	xdef	_power1ReadFlag
2160                     	xref.b	_powerPeriod3
2161                     	xref.b	_powerPeriod2
2162                     	xref.b	_powerPeriod1
2163                     	xdef	_power3OverflowCount
2164                     	xdef	_power2OverflowCount
2165                     	xdef	_power1OverflowCount
2166                     	xref	_sms_receive
2167                     	xdef	_voltCurrent3OverflowCount
2168                     	xdef	_voltCurrent2OverflowCount
2169                     	xdef	_voltCurrent1OverflowCount
2170                     	xref.b	_powerCalibrationFactor3
2171                     	xref.b	_powerCalibrationFactor2
2172                     	xref.b	_powerCalibrationFactor1
2173                     	xref	_calcWatt3
2174                     	xref	_vHandleDataRecvUARTviaISR
2175                     	xref	_vSerialRecieveISR
2176                     	xdef	f_EEPROM_EEC_IRQHandler
2177                     	xdef	f_TIM4_UPD_OVF_IRQHandler
2178                     	xdef	f_ADC2_IRQHandler
2179                     	xdef	f_UART3_TX_IRQHandler
2180                     	xdef	f_UART3_RX_IRQHandler
2181                     	xdef	f_I2C_IRQHandler
2182                     	xdef	f_UART1_RX_IRQHandler
2183                     	xdef	f_UART1_TX_IRQHandler
2184                     	xdef	f_TIM3_CAP_COM_IRQHandler
2185                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
2186                     	xdef	f_TIM2_CAP_COM_IRQHandler
2187                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
2188                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
2189                     	xdef	f_TIM1_CAP_COM_IRQHandler
2190                     	xdef	f_SPI_IRQHandler
2191                     	xdef	f_EXTI_PORTE_IRQHandler
2192                     	xdef	f_EXTI_PORTC_IRQHandler
2193                     	xdef	f_EXTI_PORTB_IRQHandler
2194                     	xdef	f_CLK_IRQHandler
2195                     	xdef	f_AWU_IRQHandler
2196                     	xdef	f_TLI_IRQHandler
2197                     	xdef	f_TRAP_IRQHandler
2198                     	xdef	f_NonHandledInterrupt
2199                     	xref	_UART1_GetFlagStatus
2200                     	xref	_UART1_ReceiveData8
2201                     	xref	_TIM2_ClearITPendingBit
2202                     	xref	_TIM2_GetITStatus
2203                     	xref	_TIM2_ClearFlag
2204                     	xref	_TIM2_GetCapture1
2205                     	xref	_TIM1_ClearITPendingBit
2206                     	xref	_TIM1_GetITStatus
2207                     	xref	_TIM1_ClearFlag
2208                     	xref	_TIM1_GetCapture3
2209                     	xref	_TIM1_GetCapture1
2210                     	xdef	f_EXTI_PORTD_IRQHandler
2211                     	xdef	f_UART1_RCV_IRQHandler
2212                     	xdef	f_TIM1_CCP_IRQHandler
2213                     	xdef	f_TIM1_IRQHandler
2214                     	xdef	f_TIM2_CCP_IRQHandler
2215                     	xdef	f_TIM2_UPD_IRQHandler
2216                     	switch	.const
2217  0004               L14:
2218  0004 3ff34506      	dc.w	16371,17670
2219  0008               L13:
2220  0008 4c604e99      	dc.w	19552,20121
2221                     	xref.b	c_lreg
2222                     	xref.b	c_x
2223                     	xref.b	c_y
2243                     	xref	c_ladd
2244                     	xref	c_lsub
2245                     	xref	c_uitolx
2246                     	xref	c_umul
2247                     	xref	c_lgsub
2248                     	xref	c_lgadc
2249                     	xref	c_lcmp
2250                     	xref	c_ftol
2251                     	xref	c_fadd
2252                     	xref	c_fdiv
2253                     	xref	c_rtol
2254                     	xref	c_fmul
2255                     	xref	c_itof
2256                     	xref	c_ultof
2257                     	xref	c_ltor
2258                     	xref	c_lzmp
2259                     	end
