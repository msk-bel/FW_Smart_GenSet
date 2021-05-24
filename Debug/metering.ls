   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _voltagePeriod1:
  16  0000 00000000      	dc.l	0
  17  0004               _voltagePeriod2:
  18  0004 00000000      	dc.l	0
  19  0008               _voltagePeriod3:
  20  0008 00000000      	dc.l	0
  21  000c               _currentPeriod1:
  22  000c 00000000      	dc.l	0
  23  0010               _currentPeriod2:
  24  0010 00000000      	dc.l	0
  25  0014               _currentPeriod3:
  26  0014 00000000      	dc.l	0
  27  0018               _powerPeriod1:
  28  0018 00000000      	dc.l	0
  29  001c               _powerPeriod2:
  30  001c 00000000      	dc.l	0
  31  0020               _powerPeriod3:
  32  0020 00000000      	dc.l	0
  33  0024               _discardPulseTics:
  34  0024 00000000      	dc.l	0
  35                     .bit:	section	.data,bit
  36  0000               _bypassPulseTicsFlag:
  37  0000 00            	dc.b	0
  38  0001               _voltCurrentSelectionFlag:
  39  0001 00            	dc.b	0
 209                     .const:	section	.text
 210  0000               L6:
 211  0000 005b8d81      	dc.l	6000001
 212                     ; 52 void calculateVoltCurrent(uint32_t timeout)
 212                     ; 53 {
 213                     	scross	off
 214                     	switch	.text
 215  0000               _calculateVoltCurrent:
 217  0000 5212          	subw	sp,#18
 218       00000012      OFST:	set	18
 221                     ; 54   uint8_t tempCount = 0;           //local variable to store overflow count
 223                     ; 58   uint16_t ICStartTics = 0;
 225  0002 5f            	clrw	x
 226  0003 1f09          	ldw	(OFST-9,sp),x
 228                     ; 59   uint16_t ICEndTics = 0;
 230                     ; 61   bool FirstCaptureFlag = false;  // Flag for implementing one iteration
 232  0005 7b0d          	ld	a,(OFST-5,sp)
 233  0007 a4fe          	and	a,#254
 234  0009 6b0d          	ld	(OFST-5,sp),a
 236                     ; 62   bool SecondCaptureFlag = false; // Flag for implementing one iteration
 238  000b 7b0d          	ld	a,(OFST-5,sp)
 239  000d a4fd          	and	a,#253
 240  000f 6b0d          	ld	(OFST-5,sp),a
 242                     ; 63   bypassPulseTicsFlag = false;    // Flag for implementing one iteration for main while loop
 244  0011 72110000      	bres	_bypassPulseTicsFlag
 246  0015 ac780478      	jpf	L301
 247  0019               L77:
 248                     ; 72     TIM1_CCxCmd(TIM1_CHANNEL_4, ENABLE); // Enable time 1 channel 4
 250  0019 ae0301        	ldw	x,#769
 251  001c cd0000        	call	_TIM1_CCxCmd
 253                     ; 73     presentTics = getTics();             // capture value of current tics from timercounter register
 255  001f cd0000        	call	_getTics
 257  0022 96            	ldw	x,sp
 258  0023 1c000e        	addw	x,#OFST-4
 259  0026 cd0000        	call	c_rtol
 262                     ; 74     TIM1_ClearFlag(TIM1_FLAG_CC4);       // Clear status bit
 264  0029 ae0010        	ldw	x,#16
 265  002c cd0000        	call	_TIM1_ClearFlag
 268  002f 2021          	jra	L111
 269  0031               L701:
 270                     ; 78       timer1Ch4_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC4);
 272  0031 ae0010        	ldw	x,#16
 273  0034 cd0000        	call	_TIM1_GetFlagStatus
 275  0037 6b12          	ld	(OFST+0,sp),a
 277                     ; 80       if (timer1Ch4_FlagStatus == SET)
 279  0039 7b12          	ld	a,(OFST+0,sp)
 280  003b a101          	cp	a,#1
 281  003d 2613          	jrne	L111
 282                     ; 82         ICStartTics = TIM1_GetCapture4();
 284  003f cd0000        	call	_TIM1_GetCapture4
 286  0042 1f09          	ldw	(OFST-9,sp),x
 288                     ; 83         TIM1_ClearFlag(TIM1_FLAG_CC4); // Clear status bit
 290  0044 ae0010        	ldw	x,#16
 291  0047 cd0000        	call	_TIM1_ClearFlag
 293                     ; 84         voltCurrent2OverflowCount = 0;
 295  004a 3f00          	clr	_voltCurrent2OverflowCount
 296                     ; 85         FirstCaptureFlag = true; // make it true to let loop iterate one time only
 298  004c 7b0d          	ld	a,(OFST-5,sp)
 299  004e aa01          	or	a,#1
 300  0050 6b0d          	ld	(OFST-5,sp),a
 302  0052               L111:
 303                     ; 76     while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
 305  0052 cd0000        	call	_getTics
 307  0055 96            	ldw	x,sp
 308  0056 1c000e        	addw	x,#OFST-4
 309  0059 cd0000        	call	c_lsub
 311  005c 96            	ldw	x,sp
 312  005d 1c0015        	addw	x,#OFST+3
 313  0060 cd0000        	call	c_lcmp
 315  0063 2406          	jruge	L711
 317  0065 7b0d          	ld	a,(OFST-5,sp)
 318  0067 a501          	bcp	a,#1
 319  0069 27c6          	jreq	L701
 320  006b               L711:
 321                     ; 89     if (FirstCaptureFlag == true)
 323  006b 7b0d          	ld	a,(OFST-5,sp)
 324  006d a501          	bcp	a,#1
 325  006f 2603          	jrne	L01
 326  0071 cc0159        	jp	L121
 327  0074               L01:
 328                     ; 91       presentTics = getTics();
 330  0074 cd0000        	call	_getTics
 332  0077 96            	ldw	x,sp
 333  0078 1c000e        	addw	x,#OFST-4
 334  007b cd0000        	call	c_rtol
 338  007e ac3b013b      	jpf	L721
 339  0082               L321:
 340                     ; 95         timer1Ch4_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC4);
 342  0082 ae0010        	ldw	x,#16
 343  0085 cd0000        	call	_TIM1_GetFlagStatus
 345  0088 6b12          	ld	(OFST+0,sp),a
 347                     ; 97         if (timer1Ch4_FlagStatus == SET)
 349  008a 7b12          	ld	a,(OFST+0,sp)
 350  008c a101          	cp	a,#1
 351  008e 2703          	jreq	L21
 352  0090 cc013b        	jp	L721
 353  0093               L21:
 354                     ; 99           ICEndTics = TIM1_GetCapture4();
 356  0093 cd0000        	call	_TIM1_GetCapture4
 358  0096 1f0b          	ldw	(OFST-7,sp),x
 360                     ; 100           tempCount = voltCurrent2OverflowCount; // Get number of overflows immediately after captruing tics
 362  0098 b600          	ld	a,_voltCurrent2OverflowCount
 363  009a 6b12          	ld	(OFST+0,sp),a
 365                     ; 101           TIM1_ClearFlag(TIM1_FLAG_CC4);
 367  009c ae0010        	ldw	x,#16
 368  009f cd0000        	call	_TIM1_ClearFlag
 370                     ; 102           SecondCaptureFlag = true;
 372  00a2 7b0d          	ld	a,(OFST-5,sp)
 373  00a4 aa02          	or	a,#2
 374  00a6 6b0d          	ld	(OFST-5,sp),a
 376                     ; 103           TIM1_CCxCmd(TIM1_CHANNEL_4, DISABLE); // Disable time 1 channel 4
 378  00a8 ae0300        	ldw	x,#768
 379  00ab cd0000        	call	_TIM1_CCxCmd
 381                     ; 105           if (voltCurrentSelectionFlag)
 383                     	btst	_voltCurrentSelectionFlag
 384  00b3 2444          	jruge	L531
 385                     ; 107             voltagePeriod2 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 387  00b5 1e0b          	ldw	x,(OFST-7,sp)
 388  00b7 cd0000        	call	c_uitolx
 390  00ba 96            	ldw	x,sp
 391  00bb 1c0005        	addw	x,#OFST-13
 392  00be cd0000        	call	c_rtol
 395  00c1 1e09          	ldw	x,(OFST-9,sp)
 396  00c3 cd0000        	call	c_uitolx
 398  00c6 96            	ldw	x,sp
 399  00c7 1c0001        	addw	x,#OFST-17
 400  00ca cd0000        	call	c_rtol
 403  00cd 7b12          	ld	a,(OFST+0,sp)
 404  00cf 5f            	clrw	x
 405  00d0 97            	ld	xl,a
 406  00d1 90aeffff      	ldw	y,#65535
 407  00d5 cd0000        	call	c_umul
 409  00d8 96            	ldw	x,sp
 410  00d9 1c0001        	addw	x,#OFST-17
 411  00dc cd0000        	call	c_lsub
 413  00df 96            	ldw	x,sp
 414  00e0 1c0005        	addw	x,#OFST-13
 415  00e3 cd0000        	call	c_ladd
 417  00e6 ae0004        	ldw	x,#_voltagePeriod2
 418  00e9 cd0000        	call	c_rtol
 420                     ; 108             calcVolt2(voltagePeriod2);
 422  00ec be06          	ldw	x,_voltagePeriod2+2
 423  00ee 89            	pushw	x
 424  00ef be04          	ldw	x,_voltagePeriod2
 425  00f1 89            	pushw	x
 426  00f2 cd0000        	call	_calcVolt2
 428  00f5 5b04          	addw	sp,#4
 430  00f7 2042          	jra	L721
 431  00f9               L531:
 432                     ; 113             currentPeriod2 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 434  00f9 1e0b          	ldw	x,(OFST-7,sp)
 435  00fb cd0000        	call	c_uitolx
 437  00fe 96            	ldw	x,sp
 438  00ff 1c0005        	addw	x,#OFST-13
 439  0102 cd0000        	call	c_rtol
 442  0105 1e09          	ldw	x,(OFST-9,sp)
 443  0107 cd0000        	call	c_uitolx
 445  010a 96            	ldw	x,sp
 446  010b 1c0001        	addw	x,#OFST-17
 447  010e cd0000        	call	c_rtol
 450  0111 7b12          	ld	a,(OFST+0,sp)
 451  0113 5f            	clrw	x
 452  0114 97            	ld	xl,a
 453  0115 90aeffff      	ldw	y,#65535
 454  0119 cd0000        	call	c_umul
 456  011c 96            	ldw	x,sp
 457  011d 1c0001        	addw	x,#OFST-17
 458  0120 cd0000        	call	c_lsub
 460  0123 96            	ldw	x,sp
 461  0124 1c0005        	addw	x,#OFST-13
 462  0127 cd0000        	call	c_ladd
 464  012a ae0010        	ldw	x,#_currentPeriod2
 465  012d cd0000        	call	c_rtol
 467                     ; 114             calcAmp2(currentPeriod2);
 469  0130 be12          	ldw	x,_currentPeriod2+2
 470  0132 89            	pushw	x
 471  0133 be10          	ldw	x,_currentPeriod2
 472  0135 89            	pushw	x
 473  0136 cd0000        	call	_calcAmp2
 475  0139 5b04          	addw	sp,#4
 476  013b               L721:
 477                     ; 93       while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
 479  013b cd0000        	call	_getTics
 481  013e 96            	ldw	x,sp
 482  013f 1c000e        	addw	x,#OFST-4
 483  0142 cd0000        	call	c_lsub
 485  0145 96            	ldw	x,sp
 486  0146 1c0015        	addw	x,#OFST+3
 487  0149 cd0000        	call	c_lcmp
 489  014c 2428          	jruge	L341
 491  014e 7b0d          	ld	a,(OFST-5,sp)
 492  0150 a502          	bcp	a,#2
 493  0152 2603          	jrne	L41
 494  0154 cc0082        	jp	L321
 495  0157               L41:
 496  0157 201d          	jra	L341
 497  0159               L121:
 498                     ; 122       if (voltCurrentSelectionFlag)
 500                     	btst	_voltCurrentSelectionFlag
 501  015e 240c          	jruge	L541
 502                     ; 124         voltagePeriod2 = 0;
 504  0160 ae0000        	ldw	x,#0
 505  0163 bf06          	ldw	_voltagePeriod2+2,x
 506  0165 ae0000        	ldw	x,#0
 507  0168 bf04          	ldw	_voltagePeriod2,x
 509  016a 200a          	jra	L341
 510  016c               L541:
 511                     ; 129         currentPeriod2 = 0;
 513  016c ae0000        	ldw	x,#0
 514  016f bf12          	ldw	_currentPeriod2+2,x
 515  0171 ae0000        	ldw	x,#0
 516  0174 bf10          	ldw	_currentPeriod2,x
 517  0176               L341:
 518                     ; 138     TIM1_CCxCmd(TIM1_CHANNEL_2, ENABLE); // Enable time 1 channel 2
 520  0176 ae0101        	ldw	x,#257
 521  0179 cd0000        	call	_TIM1_CCxCmd
 523                     ; 139     FirstCaptureFlag = false;            // Make false to iterate one time
 525  017c 7b0d          	ld	a,(OFST-5,sp)
 526  017e a4fe          	and	a,#254
 527  0180 6b0d          	ld	(OFST-5,sp),a
 529                     ; 140     SecondCaptureFlag = false;           // Make false to iterate one time
 531  0182 7b0d          	ld	a,(OFST-5,sp)
 532  0184 a4fd          	and	a,#253
 533  0186 6b0d          	ld	(OFST-5,sp),a
 535                     ; 141     presentTics = getTics();
 537  0188 cd0000        	call	_getTics
 539  018b 96            	ldw	x,sp
 540  018c 1c000e        	addw	x,#OFST-4
 541  018f cd0000        	call	c_rtol
 544                     ; 142     TIM1_ClearFlag(TIM1_FLAG_CC2);
 546  0192 ae0004        	ldw	x,#4
 547  0195 cd0000        	call	_TIM1_ClearFlag
 550  0198 2021          	jra	L351
 551  019a               L151:
 552                     ; 146       timer1Ch2_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC2);
 554  019a ae0004        	ldw	x,#4
 555  019d cd0000        	call	_TIM1_GetFlagStatus
 557  01a0 6b12          	ld	(OFST+0,sp),a
 559                     ; 148       if (timer1Ch2_FlagStatus == SET)
 561  01a2 7b12          	ld	a,(OFST+0,sp)
 562  01a4 a101          	cp	a,#1
 563  01a6 2613          	jrne	L351
 564                     ; 150         voltCurrent1OverflowCount = 0;
 566  01a8 3f00          	clr	_voltCurrent1OverflowCount
 567                     ; 151         ICStartTics = TIM1_GetCapture2();
 569  01aa cd0000        	call	_TIM1_GetCapture2
 571  01ad 1f09          	ldw	(OFST-9,sp),x
 573                     ; 152         TIM1_ClearFlag(TIM1_FLAG_CC2);
 575  01af ae0004        	ldw	x,#4
 576  01b2 cd0000        	call	_TIM1_ClearFlag
 578                     ; 153         FirstCaptureFlag = true;
 580  01b5 7b0d          	ld	a,(OFST-5,sp)
 581  01b7 aa01          	or	a,#1
 582  01b9 6b0d          	ld	(OFST-5,sp),a
 584  01bb               L351:
 585                     ; 144     while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
 587  01bb cd0000        	call	_getTics
 589  01be 96            	ldw	x,sp
 590  01bf 1c000e        	addw	x,#OFST-4
 591  01c2 cd0000        	call	c_lsub
 593  01c5 96            	ldw	x,sp
 594  01c6 1c0015        	addw	x,#OFST+3
 595  01c9 cd0000        	call	c_lcmp
 597  01cc 2406          	jruge	L161
 599  01ce 7b0d          	ld	a,(OFST-5,sp)
 600  01d0 a501          	bcp	a,#1
 601  01d2 27c6          	jreq	L151
 602  01d4               L161:
 603                     ; 157     if (FirstCaptureFlag == true)
 605  01d4 7b0d          	ld	a,(OFST-5,sp)
 606  01d6 a501          	bcp	a,#1
 607  01d8 2603          	jrne	L61
 608  01da cc02c2        	jp	L361
 609  01dd               L61:
 610                     ; 159       presentTics = getTics();
 612  01dd cd0000        	call	_getTics
 614  01e0 96            	ldw	x,sp
 615  01e1 1c000e        	addw	x,#OFST-4
 616  01e4 cd0000        	call	c_rtol
 620  01e7 aca402a4      	jpf	L171
 621  01eb               L561:
 622                     ; 163         timer1Ch2_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC2);
 624  01eb ae0004        	ldw	x,#4
 625  01ee cd0000        	call	_TIM1_GetFlagStatus
 627  01f1 6b12          	ld	(OFST+0,sp),a
 629                     ; 165         if (timer1Ch2_FlagStatus == SET)
 631  01f3 7b12          	ld	a,(OFST+0,sp)
 632  01f5 a101          	cp	a,#1
 633  01f7 2703          	jreq	L02
 634  01f9 cc02a4        	jp	L171
 635  01fc               L02:
 636                     ; 167           ICEndTics = TIM1_GetCapture2();
 638  01fc cd0000        	call	_TIM1_GetCapture2
 640  01ff 1f0b          	ldw	(OFST-7,sp),x
 642                     ; 168           tempCount = voltCurrent1OverflowCount; // Get number of overflows immediately after captruing tics
 644  0201 b600          	ld	a,_voltCurrent1OverflowCount
 645  0203 6b12          	ld	(OFST+0,sp),a
 647                     ; 169           TIM1_ClearFlag(TIM1_FLAG_CC2);
 649  0205 ae0004        	ldw	x,#4
 650  0208 cd0000        	call	_TIM1_ClearFlag
 652                     ; 170           SecondCaptureFlag = true;
 654  020b 7b0d          	ld	a,(OFST-5,sp)
 655  020d aa02          	or	a,#2
 656  020f 6b0d          	ld	(OFST-5,sp),a
 658                     ; 171           TIM1_CCxCmd(TIM1_CHANNEL_2, DISABLE);
 660  0211 ae0100        	ldw	x,#256
 661  0214 cd0000        	call	_TIM1_CCxCmd
 663                     ; 173           if (voltCurrentSelectionFlag)
 665                     	btst	_voltCurrentSelectionFlag
 666  021c 2444          	jruge	L771
 667                     ; 175             voltagePeriod1 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 669  021e 1e0b          	ldw	x,(OFST-7,sp)
 670  0220 cd0000        	call	c_uitolx
 672  0223 96            	ldw	x,sp
 673  0224 1c0005        	addw	x,#OFST-13
 674  0227 cd0000        	call	c_rtol
 677  022a 1e09          	ldw	x,(OFST-9,sp)
 678  022c cd0000        	call	c_uitolx
 680  022f 96            	ldw	x,sp
 681  0230 1c0001        	addw	x,#OFST-17
 682  0233 cd0000        	call	c_rtol
 685  0236 7b12          	ld	a,(OFST+0,sp)
 686  0238 5f            	clrw	x
 687  0239 97            	ld	xl,a
 688  023a 90aeffff      	ldw	y,#65535
 689  023e cd0000        	call	c_umul
 691  0241 96            	ldw	x,sp
 692  0242 1c0001        	addw	x,#OFST-17
 693  0245 cd0000        	call	c_lsub
 695  0248 96            	ldw	x,sp
 696  0249 1c0005        	addw	x,#OFST-13
 697  024c cd0000        	call	c_ladd
 699  024f ae0000        	ldw	x,#_voltagePeriod1
 700  0252 cd0000        	call	c_rtol
 702                     ; 176             calcVolt1(voltagePeriod1); //Calculate voltage of phase 1
 704  0255 be02          	ldw	x,_voltagePeriod1+2
 705  0257 89            	pushw	x
 706  0258 be00          	ldw	x,_voltagePeriod1
 707  025a 89            	pushw	x
 708  025b cd0000        	call	_calcVolt1
 710  025e 5b04          	addw	sp,#4
 712  0260 2042          	jra	L171
 713  0262               L771:
 714                     ; 180             currentPeriod1 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 716  0262 1e0b          	ldw	x,(OFST-7,sp)
 717  0264 cd0000        	call	c_uitolx
 719  0267 96            	ldw	x,sp
 720  0268 1c0005        	addw	x,#OFST-13
 721  026b cd0000        	call	c_rtol
 724  026e 1e09          	ldw	x,(OFST-9,sp)
 725  0270 cd0000        	call	c_uitolx
 727  0273 96            	ldw	x,sp
 728  0274 1c0001        	addw	x,#OFST-17
 729  0277 cd0000        	call	c_rtol
 732  027a 7b12          	ld	a,(OFST+0,sp)
 733  027c 5f            	clrw	x
 734  027d 97            	ld	xl,a
 735  027e 90aeffff      	ldw	y,#65535
 736  0282 cd0000        	call	c_umul
 738  0285 96            	ldw	x,sp
 739  0286 1c0001        	addw	x,#OFST-17
 740  0289 cd0000        	call	c_lsub
 742  028c 96            	ldw	x,sp
 743  028d 1c0005        	addw	x,#OFST-13
 744  0290 cd0000        	call	c_ladd
 746  0293 ae000c        	ldw	x,#_currentPeriod1
 747  0296 cd0000        	call	c_rtol
 749                     ; 181             calcAmp1(currentPeriod1); //Calculate current of phase 1
 751  0299 be0e          	ldw	x,_currentPeriod1+2
 752  029b 89            	pushw	x
 753  029c be0c          	ldw	x,_currentPeriod1
 754  029e 89            	pushw	x
 755  029f cd0000        	call	_calcAmp1
 757  02a2 5b04          	addw	sp,#4
 758  02a4               L171:
 759                     ; 161       while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
 761  02a4 cd0000        	call	_getTics
 763  02a7 96            	ldw	x,sp
 764  02a8 1c000e        	addw	x,#OFST-4
 765  02ab cd0000        	call	c_lsub
 767  02ae 96            	ldw	x,sp
 768  02af 1c0015        	addw	x,#OFST+3
 769  02b2 cd0000        	call	c_lcmp
 771  02b5 2428          	jruge	L502
 773  02b7 7b0d          	ld	a,(OFST-5,sp)
 774  02b9 a502          	bcp	a,#2
 775  02bb 2603          	jrne	L22
 776  02bd cc01eb        	jp	L561
 777  02c0               L22:
 778  02c0 201d          	jra	L502
 779  02c2               L361:
 780                     ; 189       if (voltCurrentSelectionFlag)
 782                     	btst	_voltCurrentSelectionFlag
 783  02c7 240c          	jruge	L702
 784                     ; 191         voltagePeriod1 = 0;
 786  02c9 ae0000        	ldw	x,#0
 787  02cc bf02          	ldw	_voltagePeriod1+2,x
 788  02ce ae0000        	ldw	x,#0
 789  02d1 bf00          	ldw	_voltagePeriod1,x
 791  02d3 200a          	jra	L502
 792  02d5               L702:
 793                     ; 195         currentPeriod1 = 0;
 795  02d5 ae0000        	ldw	x,#0
 796  02d8 bf0e          	ldw	_currentPeriod1+2,x
 797  02da ae0000        	ldw	x,#0
 798  02dd bf0c          	ldw	_currentPeriod1,x
 799  02df               L502:
 800                     ; 204     TIM2_CCxCmd(TIM2_CHANNEL_2, ENABLE); // Enable time 1 channel 2
 802  02df ae0101        	ldw	x,#257
 803  02e2 cd0000        	call	_TIM2_CCxCmd
 805                     ; 205     FirstCaptureFlag = false;            // Make false to iterate one time
 807  02e5 7b0d          	ld	a,(OFST-5,sp)
 808  02e7 a4fe          	and	a,#254
 809  02e9 6b0d          	ld	(OFST-5,sp),a
 811                     ; 206     SecondCaptureFlag = false;           // Make false to iterate one time
 813  02eb 7b0d          	ld	a,(OFST-5,sp)
 814  02ed a4fd          	and	a,#253
 815  02ef 6b0d          	ld	(OFST-5,sp),a
 817                     ; 207     presentTics = getTics();
 819  02f1 cd0000        	call	_getTics
 821  02f4 96            	ldw	x,sp
 822  02f5 1c000e        	addw	x,#OFST-4
 823  02f8 cd0000        	call	c_rtol
 826                     ; 208     TIM2_ClearFlag(TIM2_FLAG_CC2);
 828  02fb ae0004        	ldw	x,#4
 829  02fe cd0000        	call	_TIM2_ClearFlag
 832  0301 2021          	jra	L512
 833  0303               L312:
 834                     ; 212       timer2Ch2_FlagStatus = TIM2_GetFlagStatus(TIM2_FLAG_CC2);
 836  0303 ae0004        	ldw	x,#4
 837  0306 cd0000        	call	_TIM2_GetFlagStatus
 839  0309 6b12          	ld	(OFST+0,sp),a
 841                     ; 214       if (timer2Ch2_FlagStatus == SET)
 843  030b 7b12          	ld	a,(OFST+0,sp)
 844  030d a101          	cp	a,#1
 845  030f 2613          	jrne	L512
 846                     ; 216         ICStartTics = TIM2_GetCapture2();
 848  0311 cd0000        	call	_TIM2_GetCapture2
 850  0314 1f09          	ldw	(OFST-9,sp),x
 852                     ; 217         TIM2_ClearFlag(TIM2_FLAG_CC2);
 854  0316 ae0004        	ldw	x,#4
 855  0319 cd0000        	call	_TIM2_ClearFlag
 857                     ; 218         voltCurrent3OverflowCount = 0;
 859  031c 3f00          	clr	_voltCurrent3OverflowCount
 860                     ; 219         FirstCaptureFlag = true;
 862  031e 7b0d          	ld	a,(OFST-5,sp)
 863  0320 aa01          	or	a,#1
 864  0322 6b0d          	ld	(OFST-5,sp),a
 866  0324               L512:
 867                     ; 210     while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
 869  0324 cd0000        	call	_getTics
 871  0327 96            	ldw	x,sp
 872  0328 1c000e        	addw	x,#OFST-4
 873  032b cd0000        	call	c_lsub
 875  032e 96            	ldw	x,sp
 876  032f 1c0015        	addw	x,#OFST+3
 877  0332 cd0000        	call	c_lcmp
 879  0335 2406          	jruge	L322
 881  0337 7b0d          	ld	a,(OFST-5,sp)
 882  0339 a501          	bcp	a,#1
 883  033b 27c6          	jreq	L312
 884  033d               L322:
 885                     ; 223     if (FirstCaptureFlag == true)
 887  033d 7b0d          	ld	a,(OFST-5,sp)
 888  033f a501          	bcp	a,#1
 889  0341 2603          	jrne	L42
 890  0343 cc042b        	jp	L522
 891  0346               L42:
 892                     ; 225       presentTics = getTics();
 894  0346 cd0000        	call	_getTics
 896  0349 96            	ldw	x,sp
 897  034a 1c000e        	addw	x,#OFST-4
 898  034d cd0000        	call	c_rtol
 902  0350 ac0d040d      	jpf	L332
 903  0354               L722:
 904                     ; 229         timer2Ch2_FlagStatus = TIM2_GetFlagStatus(TIM2_FLAG_CC2);
 906  0354 ae0004        	ldw	x,#4
 907  0357 cd0000        	call	_TIM2_GetFlagStatus
 909  035a 6b12          	ld	(OFST+0,sp),a
 911                     ; 231         if (timer2Ch2_FlagStatus == SET)
 913  035c 7b12          	ld	a,(OFST+0,sp)
 914  035e a101          	cp	a,#1
 915  0360 2703          	jreq	L62
 916  0362 cc040d        	jp	L332
 917  0365               L62:
 918                     ; 233           ICEndTics = TIM2_GetCapture2();
 920  0365 cd0000        	call	_TIM2_GetCapture2
 922  0368 1f0b          	ldw	(OFST-7,sp),x
 924                     ; 234           tempCount = voltCurrent3OverflowCount;
 926  036a b600          	ld	a,_voltCurrent3OverflowCount
 927  036c 6b12          	ld	(OFST+0,sp),a
 929                     ; 235           TIM2_ClearFlag(TIM2_FLAG_CC2);
 931  036e ae0004        	ldw	x,#4
 932  0371 cd0000        	call	_TIM2_ClearFlag
 934                     ; 236           SecondCaptureFlag = true;
 936  0374 7b0d          	ld	a,(OFST-5,sp)
 937  0376 aa02          	or	a,#2
 938  0378 6b0d          	ld	(OFST-5,sp),a
 940                     ; 237           TIM2_CCxCmd(TIM2_CHANNEL_2, DISABLE);
 942  037a ae0100        	ldw	x,#256
 943  037d cd0000        	call	_TIM2_CCxCmd
 945                     ; 239           if (voltCurrentSelectionFlag)
 947                     	btst	_voltCurrentSelectionFlag
 948  0385 2444          	jruge	L142
 949                     ; 241             voltagePeriod3 = timer2MaxCount * tempCount - ICStartTics + ICEndTics;
 951  0387 1e0b          	ldw	x,(OFST-7,sp)
 952  0389 cd0000        	call	c_uitolx
 954  038c 96            	ldw	x,sp
 955  038d 1c0005        	addw	x,#OFST-13
 956  0390 cd0000        	call	c_rtol
 959  0393 1e09          	ldw	x,(OFST-9,sp)
 960  0395 cd0000        	call	c_uitolx
 962  0398 96            	ldw	x,sp
 963  0399 1c0001        	addw	x,#OFST-17
 964  039c cd0000        	call	c_rtol
 967  039f 7b12          	ld	a,(OFST+0,sp)
 968  03a1 5f            	clrw	x
 969  03a2 97            	ld	xl,a
 970  03a3 90aeffff      	ldw	y,#65535
 971  03a7 cd0000        	call	c_umul
 973  03aa 96            	ldw	x,sp
 974  03ab 1c0001        	addw	x,#OFST-17
 975  03ae cd0000        	call	c_lsub
 977  03b1 96            	ldw	x,sp
 978  03b2 1c0005        	addw	x,#OFST-13
 979  03b5 cd0000        	call	c_ladd
 981  03b8 ae0008        	ldw	x,#_voltagePeriod3
 982  03bb cd0000        	call	c_rtol
 984                     ; 242             calcVolt3(voltagePeriod3); // Calculate voltage of phase 3
 986  03be be0a          	ldw	x,_voltagePeriod3+2
 987  03c0 89            	pushw	x
 988  03c1 be08          	ldw	x,_voltagePeriod3
 989  03c3 89            	pushw	x
 990  03c4 cd0000        	call	_calcVolt3
 992  03c7 5b04          	addw	sp,#4
 994  03c9 2042          	jra	L332
 995  03cb               L142:
 996                     ; 246             currentPeriod3 = ((timer2MaxCount * tempCount) - ICStartTics) + ICEndTics;
 998  03cb 1e0b          	ldw	x,(OFST-7,sp)
 999  03cd cd0000        	call	c_uitolx
1001  03d0 96            	ldw	x,sp
1002  03d1 1c0005        	addw	x,#OFST-13
1003  03d4 cd0000        	call	c_rtol
1006  03d7 1e09          	ldw	x,(OFST-9,sp)
1007  03d9 cd0000        	call	c_uitolx
1009  03dc 96            	ldw	x,sp
1010  03dd 1c0001        	addw	x,#OFST-17
1011  03e0 cd0000        	call	c_rtol
1014  03e3 7b12          	ld	a,(OFST+0,sp)
1015  03e5 5f            	clrw	x
1016  03e6 97            	ld	xl,a
1017  03e7 90aeffff      	ldw	y,#65535
1018  03eb cd0000        	call	c_umul
1020  03ee 96            	ldw	x,sp
1021  03ef 1c0001        	addw	x,#OFST-17
1022  03f2 cd0000        	call	c_lsub
1024  03f5 96            	ldw	x,sp
1025  03f6 1c0005        	addw	x,#OFST-13
1026  03f9 cd0000        	call	c_ladd
1028  03fc ae0014        	ldw	x,#_currentPeriod3
1029  03ff cd0000        	call	c_rtol
1031                     ; 247             calcAmp3(currentPeriod3); // Calculate current of phase 3
1033  0402 be16          	ldw	x,_currentPeriod3+2
1034  0404 89            	pushw	x
1035  0405 be14          	ldw	x,_currentPeriod3
1036  0407 89            	pushw	x
1037  0408 cd0000        	call	_calcAmp3
1039  040b 5b04          	addw	sp,#4
1040  040d               L332:
1041                     ; 227       while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
1043  040d cd0000        	call	_getTics
1045  0410 96            	ldw	x,sp
1046  0411 1c000e        	addw	x,#OFST-4
1047  0414 cd0000        	call	c_lsub
1049  0417 96            	ldw	x,sp
1050  0418 1c0015        	addw	x,#OFST+3
1051  041b cd0000        	call	c_lcmp
1053  041e 2428          	jruge	L742
1055  0420 7b0d          	ld	a,(OFST-5,sp)
1056  0422 a502          	bcp	a,#2
1057  0424 2603          	jrne	L03
1058  0426 cc0354        	jp	L722
1059  0429               L03:
1060  0429 201d          	jra	L742
1061  042b               L522:
1062                     ; 255       if (voltCurrentSelectionFlag)
1064                     	btst	_voltCurrentSelectionFlag
1065  0430 240c          	jruge	L152
1066                     ; 257         voltagePeriod3 = 0;
1068  0432 ae0000        	ldw	x,#0
1069  0435 bf0a          	ldw	_voltagePeriod3+2,x
1070  0437 ae0000        	ldw	x,#0
1071  043a bf08          	ldw	_voltagePeriod3,x
1073  043c 200a          	jra	L742
1074  043e               L152:
1075                     ; 261         currentPeriod3 = 0;
1077  043e ae0000        	ldw	x,#0
1078  0441 bf16          	ldw	_currentPeriod3+2,x
1079  0443 ae0000        	ldw	x,#0
1080  0446 bf14          	ldw	_currentPeriod3,x
1081  0448               L742:
1082                     ; 265     if (voltCurrentSelectionFlag)
1084                     	btst	_voltCurrentSelectionFlag
1085  044d 240f          	jruge	L552
1086                     ; 267       GPIO_WriteLow(currentVoltSelectionPin);
1088  044f 4b04          	push	#4
1089  0451 ae500f        	ldw	x,#20495
1090  0454 cd0000        	call	_GPIO_WriteLow
1092  0457 84            	pop	a
1093                     ; 268       voltCurrentSelectionFlag = false;
1095  0458 72110001      	bres	_voltCurrentSelectionFlag
1097  045c 200d          	jra	L752
1098  045e               L552:
1099                     ; 272       GPIO_WriteHigh(currentVoltSelectionPin);
1101  045e 4b04          	push	#4
1102  0460 ae500f        	ldw	x,#20495
1103  0463 cd0000        	call	_GPIO_WriteHigh
1105  0466 84            	pop	a
1106                     ; 273       voltCurrentSelectionFlag = true;
1108  0467 72100001      	bset	_voltCurrentSelectionFlag
1109  046b               L752:
1110                     ; 276     discardPulseTics = getTics();
1112  046b cd0000        	call	_getTics
1114  046e ae0024        	ldw	x,#_discardPulseTics
1115  0471 cd0000        	call	c_rtol
1117                     ; 277     bypassPulseTicsFlag = true;
1119  0474 72100000      	bset	_bypassPulseTicsFlag
1120  0478               L301:
1121                     ; 65   while (getTics() - discardPulseTics > discardPulseTimeout && !bypassPulseTicsFlag)
1123  0478 cd0000        	call	_getTics
1125  047b ae0024        	ldw	x,#_discardPulseTics
1126  047e cd0000        	call	c_lsub
1128  0481 ae0000        	ldw	x,#L6
1129  0484 cd0000        	call	c_lcmp
1131  0487 250a          	jrult	L162
1133                     	btst	_bypassPulseTicsFlag
1134  048e 2503          	jrult	L23
1135  0490 cc0019        	jp	L77
1136  0493               L23:
1137  0493               L162:
1138                     ; 279 }
1141  0493 5b12          	addw	sp,#18
1142  0495 81            	ret
1269                     	xdef	_voltCurrentSelectionFlag
1270                     	xdef	_bypassPulseTicsFlag
1271                     	xdef	_discardPulseTics
1272                     	xdef	_powerPeriod3
1273                     	xdef	_powerPeriod2
1274                     	xdef	_powerPeriod1
1275                     	xdef	_currentPeriod3
1276                     	xdef	_currentPeriod2
1277                     	xdef	_currentPeriod1
1278                     	xdef	_voltagePeriod3
1279                     	xdef	_voltagePeriod2
1280                     	xdef	_voltagePeriod1
1281                     	xdef	_calculateVoltCurrent
1282                     	xref.b	_voltCurrent3OverflowCount
1283                     	xref.b	_voltCurrent2OverflowCount
1284                     	xref.b	_voltCurrent1OverflowCount
1285                     	xref	_calcAmp3
1286                     	xref	_calcAmp2
1287                     	xref	_calcAmp1
1288                     	xref	_calcVolt3
1289                     	xref	_calcVolt2
1290                     	xref	_calcVolt1
1291                     	xref	_getTics
1292                     	xref	_TIM2_ClearFlag
1293                     	xref	_TIM2_GetFlagStatus
1294                     	xref	_TIM2_GetCapture2
1295                     	xref	_TIM2_CCxCmd
1296                     	xref	_TIM1_ClearFlag
1297                     	xref	_TIM1_GetFlagStatus
1298                     	xref	_TIM1_GetCapture4
1299                     	xref	_TIM1_GetCapture2
1300                     	xref	_TIM1_CCxCmd
1301                     	xref	_GPIO_WriteLow
1302                     	xref	_GPIO_WriteHigh
1303                     	xref.b	c_x
1304                     	xref.b	c_y
1323                     	xref	c_ladd
1324                     	xref	c_uitolx
1325                     	xref	c_umul
1326                     	xref	c_lcmp
1327                     	xref	c_lsub
1328                     	xref	c_rtol
1329                     	end
