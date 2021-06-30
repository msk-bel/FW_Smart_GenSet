   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
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
 215                     .const:	section	.text
 216  0000               L6:
 217  0000 005b8d81      	dc.l	6000001
 218                     ; 58 void calculateVoltCurrent(uint32_t timeout)
 218                     ; 59 {
 219                     	scross	off
 220                     	switch	.text
 221  0000               _calculateVoltCurrent:
 223  0000 5212          	subw	sp,#18
 224       00000012      OFST:	set	18
 227                     ; 60   uint8_t tempCount = 0;           //local variable to store overflow count
 229                     ; 64   uint16_t ICStartTics = 0;
 231  0002 5f            	clrw	x
 232  0003 1f09          	ldw	(OFST-9,sp),x
 234                     ; 65   uint16_t ICEndTics = 0;
 236                     ; 67   bool FirstCaptureFlag = false;  // Flag for implementing one iteration
 238  0005 7b11          	ld	a,(OFST-1,sp)
 239  0007 a4fe          	and	a,#254
 240  0009 6b11          	ld	(OFST-1,sp),a
 242                     ; 68   bool SecondCaptureFlag = false; // Flag for implementing one iteration
 244  000b 7b11          	ld	a,(OFST-1,sp)
 245  000d a4fd          	and	a,#253
 246  000f 6b11          	ld	(OFST-1,sp),a
 248                     ; 69   bypassPulseTicsFlag = false;    // Flag for implementing one iteration for main while loop
 250  0011 72110000      	bres	_bypassPulseTicsFlag
 252  0015 accc04cc      	jpf	L301
 253  0019               L77:
 254                     ; 78     TIM1_CCxCmd(TIM1_CHANNEL_4, ENABLE); // Enable time 1 channel 4
 256  0019 ae0301        	ldw	x,#769
 257  001c cd0000        	call	_TIM1_CCxCmd
 259                     ; 80     FirstCaptureFlag = false; // Make false to iterate one time
 261  001f 7b11          	ld	a,(OFST-1,sp)
 262  0021 a4fe          	and	a,#254
 263  0023 6b11          	ld	(OFST-1,sp),a
 265                     ; 82     SecondCaptureFlag = false;     // Make false to iterate one time
 267  0025 7b11          	ld	a,(OFST-1,sp)
 268  0027 a4fd          	and	a,#253
 269  0029 6b11          	ld	(OFST-1,sp),a
 271                     ; 83     presentTics = getTics();       // capture value of current tics from timercounter register
 273  002b cd0000        	call	_getTics
 275  002e 96            	ldw	x,sp
 276  002f 1c000d        	addw	x,#OFST-5
 277  0032 cd0000        	call	c_rtol
 280                     ; 84     TIM1_ClearFlag(TIM1_FLAG_CC4); // Clear status bit
 282  0035 ae0010        	ldw	x,#16
 283  0038 cd0000        	call	_TIM1_ClearFlag
 286  003b 2021          	jra	L111
 287  003d               L701:
 288                     ; 88       timer1Ch4_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC4);
 290  003d ae0010        	ldw	x,#16
 291  0040 cd0000        	call	_TIM1_GetFlagStatus
 293  0043 6b12          	ld	(OFST+0,sp),a
 295                     ; 90       if (timer1Ch4_FlagStatus == SET)
 297  0045 7b12          	ld	a,(OFST+0,sp)
 298  0047 a101          	cp	a,#1
 299  0049 2613          	jrne	L111
 300                     ; 92         ICStartTics = TIM1_GetCapture4();
 302  004b cd0000        	call	_TIM1_GetCapture4
 304  004e 1f09          	ldw	(OFST-9,sp),x
 306                     ; 93         TIM1_ClearFlag(TIM1_FLAG_CC4); // Clear status bit
 308  0050 ae0010        	ldw	x,#16
 309  0053 cd0000        	call	_TIM1_ClearFlag
 311                     ; 94         voltCurrent2OverflowCount = 0;
 313  0056 3f00          	clr	_voltCurrent2OverflowCount
 314                     ; 95         FirstCaptureFlag = true; // make it true to let loop iterate one time only
 316  0058 7b11          	ld	a,(OFST-1,sp)
 317  005a aa01          	or	a,#1
 318  005c 6b11          	ld	(OFST-1,sp),a
 320  005e               L111:
 321                     ; 86     while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
 323  005e cd0000        	call	_getTics
 325  0061 96            	ldw	x,sp
 326  0062 1c000d        	addw	x,#OFST-5
 327  0065 cd0000        	call	c_lsub
 329  0068 96            	ldw	x,sp
 330  0069 1c0015        	addw	x,#OFST+3
 331  006c cd0000        	call	c_lcmp
 333  006f 2406          	jruge	L711
 335  0071 7b11          	ld	a,(OFST-1,sp)
 336  0073 a501          	bcp	a,#1
 337  0075 27c6          	jreq	L701
 338  0077               L711:
 339                     ; 99     if (FirstCaptureFlag == true)
 341  0077 7b11          	ld	a,(OFST-1,sp)
 342  0079 a501          	bcp	a,#1
 343  007b 2603          	jrne	L01
 344  007d cc0165        	jp	L121
 345  0080               L01:
 346                     ; 101       presentTics = getTics();
 348  0080 cd0000        	call	_getTics
 350  0083 96            	ldw	x,sp
 351  0084 1c000d        	addw	x,#OFST-5
 352  0087 cd0000        	call	c_rtol
 356  008a ac470147      	jpf	L721
 357  008e               L321:
 358                     ; 105         timer1Ch4_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC4);
 360  008e ae0010        	ldw	x,#16
 361  0091 cd0000        	call	_TIM1_GetFlagStatus
 363  0094 6b12          	ld	(OFST+0,sp),a
 365                     ; 107         if (timer1Ch4_FlagStatus == SET)
 367  0096 7b12          	ld	a,(OFST+0,sp)
 368  0098 a101          	cp	a,#1
 369  009a 2703          	jreq	L21
 370  009c cc0147        	jp	L721
 371  009f               L21:
 372                     ; 109           ICEndTics = TIM1_GetCapture4();
 374  009f cd0000        	call	_TIM1_GetCapture4
 376  00a2 1f0b          	ldw	(OFST-7,sp),x
 378                     ; 110           tempCount = voltCurrent2OverflowCount; // Get number of overflows immediately after captruing tics
 380  00a4 b600          	ld	a,_voltCurrent2OverflowCount
 381  00a6 6b12          	ld	(OFST+0,sp),a
 383                     ; 111           TIM1_ClearFlag(TIM1_FLAG_CC4);
 385  00a8 ae0010        	ldw	x,#16
 386  00ab cd0000        	call	_TIM1_ClearFlag
 388                     ; 112           SecondCaptureFlag = true;
 390  00ae 7b11          	ld	a,(OFST-1,sp)
 391  00b0 aa02          	or	a,#2
 392  00b2 6b11          	ld	(OFST-1,sp),a
 394                     ; 113           TIM1_CCxCmd(TIM1_CHANNEL_4, DISABLE); // Disable time 1 channel 4
 396  00b4 ae0300        	ldw	x,#768
 397  00b7 cd0000        	call	_TIM1_CCxCmd
 399                     ; 115           if (voltCurrentSelectionFlag)
 401                     	btst	_voltCurrentSelectionFlag
 402  00bf 2444          	jruge	L531
 403                     ; 117             voltagePeriod2 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 405  00c1 1e0b          	ldw	x,(OFST-7,sp)
 406  00c3 cd0000        	call	c_uitolx
 408  00c6 96            	ldw	x,sp
 409  00c7 1c0005        	addw	x,#OFST-13
 410  00ca cd0000        	call	c_rtol
 413  00cd 1e09          	ldw	x,(OFST-9,sp)
 414  00cf cd0000        	call	c_uitolx
 416  00d2 96            	ldw	x,sp
 417  00d3 1c0001        	addw	x,#OFST-17
 418  00d6 cd0000        	call	c_rtol
 421  00d9 7b12          	ld	a,(OFST+0,sp)
 422  00db 5f            	clrw	x
 423  00dc 97            	ld	xl,a
 424  00dd 90aeffff      	ldw	y,#65535
 425  00e1 cd0000        	call	c_umul
 427  00e4 96            	ldw	x,sp
 428  00e5 1c0001        	addw	x,#OFST-17
 429  00e8 cd0000        	call	c_lsub
 431  00eb 96            	ldw	x,sp
 432  00ec 1c0005        	addw	x,#OFST-13
 433  00ef cd0000        	call	c_ladd
 435  00f2 ae0004        	ldw	x,#_voltagePeriod2
 436  00f5 cd0000        	call	c_rtol
 438                     ; 118             calcVolt2(voltagePeriod2);
 440  00f8 be06          	ldw	x,_voltagePeriod2+2
 441  00fa 89            	pushw	x
 442  00fb be04          	ldw	x,_voltagePeriod2
 443  00fd 89            	pushw	x
 444  00fe cd0000        	call	_calcVolt2
 446  0101 5b04          	addw	sp,#4
 448  0103 2042          	jra	L721
 449  0105               L531:
 450                     ; 123             currentPeriod2 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 452  0105 1e0b          	ldw	x,(OFST-7,sp)
 453  0107 cd0000        	call	c_uitolx
 455  010a 96            	ldw	x,sp
 456  010b 1c0005        	addw	x,#OFST-13
 457  010e cd0000        	call	c_rtol
 460  0111 1e09          	ldw	x,(OFST-9,sp)
 461  0113 cd0000        	call	c_uitolx
 463  0116 96            	ldw	x,sp
 464  0117 1c0001        	addw	x,#OFST-17
 465  011a cd0000        	call	c_rtol
 468  011d 7b12          	ld	a,(OFST+0,sp)
 469  011f 5f            	clrw	x
 470  0120 97            	ld	xl,a
 471  0121 90aeffff      	ldw	y,#65535
 472  0125 cd0000        	call	c_umul
 474  0128 96            	ldw	x,sp
 475  0129 1c0001        	addw	x,#OFST-17
 476  012c cd0000        	call	c_lsub
 478  012f 96            	ldw	x,sp
 479  0130 1c0005        	addw	x,#OFST-13
 480  0133 cd0000        	call	c_ladd
 482  0136 ae0010        	ldw	x,#_currentPeriod2
 483  0139 cd0000        	call	c_rtol
 485                     ; 124             calcAmp2(currentPeriod2);
 487  013c be12          	ldw	x,_currentPeriod2+2
 488  013e 89            	pushw	x
 489  013f be10          	ldw	x,_currentPeriod2
 490  0141 89            	pushw	x
 491  0142 cd0000        	call	_calcAmp2
 493  0145 5b04          	addw	sp,#4
 494  0147               L721:
 495                     ; 103       while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
 497  0147 cd0000        	call	_getTics
 499  014a 96            	ldw	x,sp
 500  014b 1c000d        	addw	x,#OFST-5
 501  014e cd0000        	call	c_lsub
 503  0151 96            	ldw	x,sp
 504  0152 1c0015        	addw	x,#OFST+3
 505  0155 cd0000        	call	c_lcmp
 507  0158 2440          	jruge	L341
 509  015a 7b11          	ld	a,(OFST-1,sp)
 510  015c a502          	bcp	a,#2
 511  015e 2603          	jrne	L41
 512  0160 cc008e        	jp	L321
 513  0163               L41:
 514  0163 2035          	jra	L341
 515  0165               L121:
 516                     ; 132       if (voltCurrentSelectionFlag)
 518                     	btst	_voltCurrentSelectionFlag
 519  016a 2418          	jruge	L541
 520                     ; 134         voltagePeriod2 = 0;
 522  016c ae0000        	ldw	x,#0
 523  016f bf06          	ldw	_voltagePeriod2+2,x
 524  0171 ae0000        	ldw	x,#0
 525  0174 bf04          	ldw	_voltagePeriod2,x
 526                     ; 136         Voltage_Phase2 = 0;
 528  0176 ae0000        	ldw	x,#0
 529  0179 cf0002        	ldw	_Voltage_Phase2+2,x
 530  017c ae0000        	ldw	x,#0
 531  017f cf0000        	ldw	_Voltage_Phase2,x
 533  0182 2016          	jra	L341
 534  0184               L541:
 535                     ; 141         currentPeriod2 = 0;
 537  0184 ae0000        	ldw	x,#0
 538  0187 bf12          	ldw	_currentPeriod2+2,x
 539  0189 ae0000        	ldw	x,#0
 540  018c bf10          	ldw	_currentPeriod2,x
 541                     ; 143         Ampere_Phase2 = 0;
 543  018e ae0000        	ldw	x,#0
 544  0191 cf0002        	ldw	_Ampere_Phase2+2,x
 545  0194 ae0000        	ldw	x,#0
 546  0197 cf0000        	ldw	_Ampere_Phase2,x
 547  019a               L341:
 548                     ; 152     TIM1_CCxCmd(TIM1_CHANNEL_2, ENABLE); // Enable time 1 channel 2
 550  019a ae0101        	ldw	x,#257
 551  019d cd0000        	call	_TIM1_CCxCmd
 553                     ; 153     FirstCaptureFlag = false;            // Make false to iterate one time
 555  01a0 7b11          	ld	a,(OFST-1,sp)
 556  01a2 a4fe          	and	a,#254
 557  01a4 6b11          	ld	(OFST-1,sp),a
 559                     ; 154     SecondCaptureFlag = false;           // Make false to iterate one time
 561  01a6 7b11          	ld	a,(OFST-1,sp)
 562  01a8 a4fd          	and	a,#253
 563  01aa 6b11          	ld	(OFST-1,sp),a
 565                     ; 155     presentTics = getTics();
 567  01ac cd0000        	call	_getTics
 569  01af 96            	ldw	x,sp
 570  01b0 1c000d        	addw	x,#OFST-5
 571  01b3 cd0000        	call	c_rtol
 574                     ; 156     TIM1_ClearFlag(TIM1_FLAG_CC2);
 576  01b6 ae0004        	ldw	x,#4
 577  01b9 cd0000        	call	_TIM1_ClearFlag
 580  01bc 2021          	jra	L351
 581  01be               L151:
 582                     ; 160       timer1Ch2_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC2);
 584  01be ae0004        	ldw	x,#4
 585  01c1 cd0000        	call	_TIM1_GetFlagStatus
 587  01c4 6b12          	ld	(OFST+0,sp),a
 589                     ; 162       if (timer1Ch2_FlagStatus == SET)
 591  01c6 7b12          	ld	a,(OFST+0,sp)
 592  01c8 a101          	cp	a,#1
 593  01ca 2613          	jrne	L351
 594                     ; 164         voltCurrent1OverflowCount = 0;
 596  01cc 3f00          	clr	_voltCurrent1OverflowCount
 597                     ; 165         ICStartTics = TIM1_GetCapture2();
 599  01ce cd0000        	call	_TIM1_GetCapture2
 601  01d1 1f09          	ldw	(OFST-9,sp),x
 603                     ; 166         TIM1_ClearFlag(TIM1_FLAG_CC2);
 605  01d3 ae0004        	ldw	x,#4
 606  01d6 cd0000        	call	_TIM1_ClearFlag
 608                     ; 167         FirstCaptureFlag = true;
 610  01d9 7b11          	ld	a,(OFST-1,sp)
 611  01db aa01          	or	a,#1
 612  01dd 6b11          	ld	(OFST-1,sp),a
 614  01df               L351:
 615                     ; 158     while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
 617  01df cd0000        	call	_getTics
 619  01e2 96            	ldw	x,sp
 620  01e3 1c000d        	addw	x,#OFST-5
 621  01e6 cd0000        	call	c_lsub
 623  01e9 96            	ldw	x,sp
 624  01ea 1c0015        	addw	x,#OFST+3
 625  01ed cd0000        	call	c_lcmp
 627  01f0 2406          	jruge	L161
 629  01f2 7b11          	ld	a,(OFST-1,sp)
 630  01f4 a501          	bcp	a,#1
 631  01f6 27c6          	jreq	L151
 632  01f8               L161:
 633                     ; 171     if (FirstCaptureFlag == true)
 635  01f8 7b11          	ld	a,(OFST-1,sp)
 636  01fa a501          	bcp	a,#1
 637  01fc 2603          	jrne	L61
 638  01fe cc02e6        	jp	L361
 639  0201               L61:
 640                     ; 173       presentTics = getTics();
 642  0201 cd0000        	call	_getTics
 644  0204 96            	ldw	x,sp
 645  0205 1c000d        	addw	x,#OFST-5
 646  0208 cd0000        	call	c_rtol
 650  020b acc802c8      	jpf	L171
 651  020f               L561:
 652                     ; 177         timer1Ch2_FlagStatus = TIM1_GetFlagStatus(TIM1_FLAG_CC2);
 654  020f ae0004        	ldw	x,#4
 655  0212 cd0000        	call	_TIM1_GetFlagStatus
 657  0215 6b12          	ld	(OFST+0,sp),a
 659                     ; 179         if (timer1Ch2_FlagStatus == SET)
 661  0217 7b12          	ld	a,(OFST+0,sp)
 662  0219 a101          	cp	a,#1
 663  021b 2703          	jreq	L02
 664  021d cc02c8        	jp	L171
 665  0220               L02:
 666                     ; 181           ICEndTics = TIM1_GetCapture2();
 668  0220 cd0000        	call	_TIM1_GetCapture2
 670  0223 1f0b          	ldw	(OFST-7,sp),x
 672                     ; 182           tempCount = voltCurrent1OverflowCount; // Get number of overflows immediately after captruing tics
 674  0225 b600          	ld	a,_voltCurrent1OverflowCount
 675  0227 6b12          	ld	(OFST+0,sp),a
 677                     ; 183           TIM1_ClearFlag(TIM1_FLAG_CC2);
 679  0229 ae0004        	ldw	x,#4
 680  022c cd0000        	call	_TIM1_ClearFlag
 682                     ; 184           SecondCaptureFlag = true;
 684  022f 7b11          	ld	a,(OFST-1,sp)
 685  0231 aa02          	or	a,#2
 686  0233 6b11          	ld	(OFST-1,sp),a
 688                     ; 185           TIM1_CCxCmd(TIM1_CHANNEL_2, DISABLE);
 690  0235 ae0100        	ldw	x,#256
 691  0238 cd0000        	call	_TIM1_CCxCmd
 693                     ; 187           if (voltCurrentSelectionFlag)
 695                     	btst	_voltCurrentSelectionFlag
 696  0240 2444          	jruge	L771
 697                     ; 189             voltagePeriod1 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 699  0242 1e0b          	ldw	x,(OFST-7,sp)
 700  0244 cd0000        	call	c_uitolx
 702  0247 96            	ldw	x,sp
 703  0248 1c0005        	addw	x,#OFST-13
 704  024b cd0000        	call	c_rtol
 707  024e 1e09          	ldw	x,(OFST-9,sp)
 708  0250 cd0000        	call	c_uitolx
 710  0253 96            	ldw	x,sp
 711  0254 1c0001        	addw	x,#OFST-17
 712  0257 cd0000        	call	c_rtol
 715  025a 7b12          	ld	a,(OFST+0,sp)
 716  025c 5f            	clrw	x
 717  025d 97            	ld	xl,a
 718  025e 90aeffff      	ldw	y,#65535
 719  0262 cd0000        	call	c_umul
 721  0265 96            	ldw	x,sp
 722  0266 1c0001        	addw	x,#OFST-17
 723  0269 cd0000        	call	c_lsub
 725  026c 96            	ldw	x,sp
 726  026d 1c0005        	addw	x,#OFST-13
 727  0270 cd0000        	call	c_ladd
 729  0273 ae0000        	ldw	x,#_voltagePeriod1
 730  0276 cd0000        	call	c_rtol
 732                     ; 190             calcVolt1(voltagePeriod1); //Calculate voltage of phase 1
 734  0279 be02          	ldw	x,_voltagePeriod1+2
 735  027b 89            	pushw	x
 736  027c be00          	ldw	x,_voltagePeriod1
 737  027e 89            	pushw	x
 738  027f cd0000        	call	_calcVolt1
 740  0282 5b04          	addw	sp,#4
 742  0284 2042          	jra	L171
 743  0286               L771:
 744                     ; 194             currentPeriod1 = ((timer1MaxCount * tempCount) - ICStartTics) + ICEndTics;
 746  0286 1e0b          	ldw	x,(OFST-7,sp)
 747  0288 cd0000        	call	c_uitolx
 749  028b 96            	ldw	x,sp
 750  028c 1c0005        	addw	x,#OFST-13
 751  028f cd0000        	call	c_rtol
 754  0292 1e09          	ldw	x,(OFST-9,sp)
 755  0294 cd0000        	call	c_uitolx
 757  0297 96            	ldw	x,sp
 758  0298 1c0001        	addw	x,#OFST-17
 759  029b cd0000        	call	c_rtol
 762  029e 7b12          	ld	a,(OFST+0,sp)
 763  02a0 5f            	clrw	x
 764  02a1 97            	ld	xl,a
 765  02a2 90aeffff      	ldw	y,#65535
 766  02a6 cd0000        	call	c_umul
 768  02a9 96            	ldw	x,sp
 769  02aa 1c0001        	addw	x,#OFST-17
 770  02ad cd0000        	call	c_lsub
 772  02b0 96            	ldw	x,sp
 773  02b1 1c0005        	addw	x,#OFST-13
 774  02b4 cd0000        	call	c_ladd
 776  02b7 ae000c        	ldw	x,#_currentPeriod1
 777  02ba cd0000        	call	c_rtol
 779                     ; 195             calcAmp1(currentPeriod1); //Calculate current of phase 1
 781  02bd be0e          	ldw	x,_currentPeriod1+2
 782  02bf 89            	pushw	x
 783  02c0 be0c          	ldw	x,_currentPeriod1
 784  02c2 89            	pushw	x
 785  02c3 cd0000        	call	_calcAmp1
 787  02c6 5b04          	addw	sp,#4
 788  02c8               L171:
 789                     ; 175       while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
 791  02c8 cd0000        	call	_getTics
 793  02cb 96            	ldw	x,sp
 794  02cc 1c000d        	addw	x,#OFST-5
 795  02cf cd0000        	call	c_lsub
 797  02d2 96            	ldw	x,sp
 798  02d3 1c0015        	addw	x,#OFST+3
 799  02d6 cd0000        	call	c_lcmp
 801  02d9 2440          	jruge	L502
 803  02db 7b11          	ld	a,(OFST-1,sp)
 804  02dd a502          	bcp	a,#2
 805  02df 2603          	jrne	L22
 806  02e1 cc020f        	jp	L561
 807  02e4               L22:
 808  02e4 2035          	jra	L502
 809  02e6               L361:
 810                     ; 203       if (voltCurrentSelectionFlag)
 812                     	btst	_voltCurrentSelectionFlag
 813  02eb 2418          	jruge	L702
 814                     ; 205         voltagePeriod1 = 0;
 816  02ed ae0000        	ldw	x,#0
 817  02f0 bf02          	ldw	_voltagePeriod1+2,x
 818  02f2 ae0000        	ldw	x,#0
 819  02f5 bf00          	ldw	_voltagePeriod1,x
 820                     ; 207         Voltage_Phase1 = 0;
 822  02f7 ae0000        	ldw	x,#0
 823  02fa cf0002        	ldw	_Voltage_Phase1+2,x
 824  02fd ae0000        	ldw	x,#0
 825  0300 cf0000        	ldw	_Voltage_Phase1,x
 827  0303 2016          	jra	L502
 828  0305               L702:
 829                     ; 211         currentPeriod1 = 0;
 831  0305 ae0000        	ldw	x,#0
 832  0308 bf0e          	ldw	_currentPeriod1+2,x
 833  030a ae0000        	ldw	x,#0
 834  030d bf0c          	ldw	_currentPeriod1,x
 835                     ; 213         Ampere_Phase1 = 0;
 837  030f ae0000        	ldw	x,#0
 838  0312 cf0002        	ldw	_Ampere_Phase1+2,x
 839  0315 ae0000        	ldw	x,#0
 840  0318 cf0000        	ldw	_Ampere_Phase1,x
 841  031b               L502:
 842                     ; 222     TIM2_CCxCmd(TIM2_CHANNEL_2, ENABLE); // Enable time 1 channel 2
 844  031b ae0101        	ldw	x,#257
 845  031e cd0000        	call	_TIM2_CCxCmd
 847                     ; 223     FirstCaptureFlag = false;            // Make false to iterate one time
 849  0321 7b11          	ld	a,(OFST-1,sp)
 850  0323 a4fe          	and	a,#254
 851  0325 6b11          	ld	(OFST-1,sp),a
 853                     ; 224     SecondCaptureFlag = false;           // Make false to iterate one time
 855  0327 7b11          	ld	a,(OFST-1,sp)
 856  0329 a4fd          	and	a,#253
 857  032b 6b11          	ld	(OFST-1,sp),a
 859                     ; 225     presentTics = getTics();
 861  032d cd0000        	call	_getTics
 863  0330 96            	ldw	x,sp
 864  0331 1c000d        	addw	x,#OFST-5
 865  0334 cd0000        	call	c_rtol
 868                     ; 226     TIM2_ClearFlag(TIM2_FLAG_CC2);
 870  0337 ae0004        	ldw	x,#4
 871  033a cd0000        	call	_TIM2_ClearFlag
 874  033d 2021          	jra	L512
 875  033f               L312:
 876                     ; 230       timer2Ch2_FlagStatus = TIM2_GetFlagStatus(TIM2_FLAG_CC2);
 878  033f ae0004        	ldw	x,#4
 879  0342 cd0000        	call	_TIM2_GetFlagStatus
 881  0345 6b12          	ld	(OFST+0,sp),a
 883                     ; 232       if (timer2Ch2_FlagStatus == SET)
 885  0347 7b12          	ld	a,(OFST+0,sp)
 886  0349 a101          	cp	a,#1
 887  034b 2613          	jrne	L512
 888                     ; 234         ICStartTics = TIM2_GetCapture2();
 890  034d cd0000        	call	_TIM2_GetCapture2
 892  0350 1f09          	ldw	(OFST-9,sp),x
 894                     ; 235         TIM2_ClearFlag(TIM2_FLAG_CC2);
 896  0352 ae0004        	ldw	x,#4
 897  0355 cd0000        	call	_TIM2_ClearFlag
 899                     ; 236         voltCurrent3OverflowCount = 0;
 901  0358 3f00          	clr	_voltCurrent3OverflowCount
 902                     ; 237         FirstCaptureFlag = true;
 904  035a 7b11          	ld	a,(OFST-1,sp)
 905  035c aa01          	or	a,#1
 906  035e 6b11          	ld	(OFST-1,sp),a
 908  0360               L512:
 909                     ; 228     while ((getTics() - presentTics) < timeout && !FirstCaptureFlag)
 911  0360 cd0000        	call	_getTics
 913  0363 96            	ldw	x,sp
 914  0364 1c000d        	addw	x,#OFST-5
 915  0367 cd0000        	call	c_lsub
 917  036a 96            	ldw	x,sp
 918  036b 1c0015        	addw	x,#OFST+3
 919  036e cd0000        	call	c_lcmp
 921  0371 2406          	jruge	L322
 923  0373 7b11          	ld	a,(OFST-1,sp)
 924  0375 a501          	bcp	a,#1
 925  0377 27c6          	jreq	L312
 926  0379               L322:
 927                     ; 241     if (FirstCaptureFlag == true)
 929  0379 7b11          	ld	a,(OFST-1,sp)
 930  037b a501          	bcp	a,#1
 931  037d 2603          	jrne	L42
 932  037f cc0467        	jp	L522
 933  0382               L42:
 934                     ; 243       presentTics = getTics();
 936  0382 cd0000        	call	_getTics
 938  0385 96            	ldw	x,sp
 939  0386 1c000d        	addw	x,#OFST-5
 940  0389 cd0000        	call	c_rtol
 944  038c ac490449      	jpf	L332
 945  0390               L722:
 946                     ; 247         timer2Ch2_FlagStatus = TIM2_GetFlagStatus(TIM2_FLAG_CC2);
 948  0390 ae0004        	ldw	x,#4
 949  0393 cd0000        	call	_TIM2_GetFlagStatus
 951  0396 6b12          	ld	(OFST+0,sp),a
 953                     ; 249         if (timer2Ch2_FlagStatus == SET)
 955  0398 7b12          	ld	a,(OFST+0,sp)
 956  039a a101          	cp	a,#1
 957  039c 2703          	jreq	L62
 958  039e cc0449        	jp	L332
 959  03a1               L62:
 960                     ; 251           ICEndTics = TIM2_GetCapture2();
 962  03a1 cd0000        	call	_TIM2_GetCapture2
 964  03a4 1f0b          	ldw	(OFST-7,sp),x
 966                     ; 252           tempCount = voltCurrent3OverflowCount;
 968  03a6 b600          	ld	a,_voltCurrent3OverflowCount
 969  03a8 6b12          	ld	(OFST+0,sp),a
 971                     ; 253           TIM2_ClearFlag(TIM2_FLAG_CC2);
 973  03aa ae0004        	ldw	x,#4
 974  03ad cd0000        	call	_TIM2_ClearFlag
 976                     ; 254           SecondCaptureFlag = true;
 978  03b0 7b11          	ld	a,(OFST-1,sp)
 979  03b2 aa02          	or	a,#2
 980  03b4 6b11          	ld	(OFST-1,sp),a
 982                     ; 255           TIM2_CCxCmd(TIM2_CHANNEL_2, DISABLE);
 984  03b6 ae0100        	ldw	x,#256
 985  03b9 cd0000        	call	_TIM2_CCxCmd
 987                     ; 257           if (voltCurrentSelectionFlag)
 989                     	btst	_voltCurrentSelectionFlag
 990  03c1 2444          	jruge	L142
 991                     ; 259             voltagePeriod3 = timer2MaxCount * tempCount - ICStartTics + ICEndTics;
 993  03c3 1e0b          	ldw	x,(OFST-7,sp)
 994  03c5 cd0000        	call	c_uitolx
 996  03c8 96            	ldw	x,sp
 997  03c9 1c0005        	addw	x,#OFST-13
 998  03cc cd0000        	call	c_rtol
1001  03cf 1e09          	ldw	x,(OFST-9,sp)
1002  03d1 cd0000        	call	c_uitolx
1004  03d4 96            	ldw	x,sp
1005  03d5 1c0001        	addw	x,#OFST-17
1006  03d8 cd0000        	call	c_rtol
1009  03db 7b12          	ld	a,(OFST+0,sp)
1010  03dd 5f            	clrw	x
1011  03de 97            	ld	xl,a
1012  03df 90aeffff      	ldw	y,#65535
1013  03e3 cd0000        	call	c_umul
1015  03e6 96            	ldw	x,sp
1016  03e7 1c0001        	addw	x,#OFST-17
1017  03ea cd0000        	call	c_lsub
1019  03ed 96            	ldw	x,sp
1020  03ee 1c0005        	addw	x,#OFST-13
1021  03f1 cd0000        	call	c_ladd
1023  03f4 ae0008        	ldw	x,#_voltagePeriod3
1024  03f7 cd0000        	call	c_rtol
1026                     ; 260             calcVolt3(voltagePeriod3); // Calculate voltage of phase 3
1028  03fa be0a          	ldw	x,_voltagePeriod3+2
1029  03fc 89            	pushw	x
1030  03fd be08          	ldw	x,_voltagePeriod3
1031  03ff 89            	pushw	x
1032  0400 cd0000        	call	_calcVolt3
1034  0403 5b04          	addw	sp,#4
1036  0405 2042          	jra	L332
1037  0407               L142:
1038                     ; 264             currentPeriod3 = ((timer2MaxCount * tempCount) - ICStartTics) + ICEndTics;
1040  0407 1e0b          	ldw	x,(OFST-7,sp)
1041  0409 cd0000        	call	c_uitolx
1043  040c 96            	ldw	x,sp
1044  040d 1c0005        	addw	x,#OFST-13
1045  0410 cd0000        	call	c_rtol
1048  0413 1e09          	ldw	x,(OFST-9,sp)
1049  0415 cd0000        	call	c_uitolx
1051  0418 96            	ldw	x,sp
1052  0419 1c0001        	addw	x,#OFST-17
1053  041c cd0000        	call	c_rtol
1056  041f 7b12          	ld	a,(OFST+0,sp)
1057  0421 5f            	clrw	x
1058  0422 97            	ld	xl,a
1059  0423 90aeffff      	ldw	y,#65535
1060  0427 cd0000        	call	c_umul
1062  042a 96            	ldw	x,sp
1063  042b 1c0001        	addw	x,#OFST-17
1064  042e cd0000        	call	c_lsub
1066  0431 96            	ldw	x,sp
1067  0432 1c0005        	addw	x,#OFST-13
1068  0435 cd0000        	call	c_ladd
1070  0438 ae0014        	ldw	x,#_currentPeriod3
1071  043b cd0000        	call	c_rtol
1073                     ; 265             calcAmp3(currentPeriod3); // Calculate current of phase 3
1075  043e be16          	ldw	x,_currentPeriod3+2
1076  0440 89            	pushw	x
1077  0441 be14          	ldw	x,_currentPeriod3
1078  0443 89            	pushw	x
1079  0444 cd0000        	call	_calcAmp3
1081  0447 5b04          	addw	sp,#4
1082  0449               L332:
1083                     ; 245       while ((getTics() - presentTics) < timeout && !SecondCaptureFlag)
1085  0449 cd0000        	call	_getTics
1087  044c 96            	ldw	x,sp
1088  044d 1c000d        	addw	x,#OFST-5
1089  0450 cd0000        	call	c_lsub
1091  0453 96            	ldw	x,sp
1092  0454 1c0015        	addw	x,#OFST+3
1093  0457 cd0000        	call	c_lcmp
1095  045a 2440          	jruge	L742
1097  045c 7b11          	ld	a,(OFST-1,sp)
1098  045e a502          	bcp	a,#2
1099  0460 2603          	jrne	L03
1100  0462 cc0390        	jp	L722
1101  0465               L03:
1102  0465 2035          	jra	L742
1103  0467               L522:
1104                     ; 273       if (voltCurrentSelectionFlag)
1106                     	btst	_voltCurrentSelectionFlag
1107  046c 2418          	jruge	L152
1108                     ; 275         voltagePeriod3 = 0;
1110  046e ae0000        	ldw	x,#0
1111  0471 bf0a          	ldw	_voltagePeriod3+2,x
1112  0473 ae0000        	ldw	x,#0
1113  0476 bf08          	ldw	_voltagePeriod3,x
1114                     ; 277         Voltage_Phase3 = 0;
1116  0478 ae0000        	ldw	x,#0
1117  047b cf0002        	ldw	_Voltage_Phase3+2,x
1118  047e ae0000        	ldw	x,#0
1119  0481 cf0000        	ldw	_Voltage_Phase3,x
1121  0484 2016          	jra	L742
1122  0486               L152:
1123                     ; 281         currentPeriod3 = 0;
1125  0486 ae0000        	ldw	x,#0
1126  0489 bf16          	ldw	_currentPeriod3+2,x
1127  048b ae0000        	ldw	x,#0
1128  048e bf14          	ldw	_currentPeriod3,x
1129                     ; 283         Ampere_Phase3 = 0;
1131  0490 ae0000        	ldw	x,#0
1132  0493 cf0002        	ldw	_Ampere_Phase3+2,x
1133  0496 ae0000        	ldw	x,#0
1134  0499 cf0000        	ldw	_Ampere_Phase3,x
1135  049c               L742:
1136                     ; 287     if (voltCurrentSelectionFlag)
1138                     	btst	_voltCurrentSelectionFlag
1139  04a1 240f          	jruge	L552
1140                     ; 289       GPIO_WriteLow(currentVoltSelectionPin);
1142  04a3 4b04          	push	#4
1143  04a5 ae500f        	ldw	x,#20495
1144  04a8 cd0000        	call	_GPIO_WriteLow
1146  04ab 84            	pop	a
1147                     ; 290       voltCurrentSelectionFlag = false;
1149  04ac 72110001      	bres	_voltCurrentSelectionFlag
1151  04b0 200d          	jra	L752
1152  04b2               L552:
1153                     ; 294       GPIO_WriteHigh(currentVoltSelectionPin);
1155  04b2 4b04          	push	#4
1156  04b4 ae500f        	ldw	x,#20495
1157  04b7 cd0000        	call	_GPIO_WriteHigh
1159  04ba 84            	pop	a
1160                     ; 295       voltCurrentSelectionFlag = true;
1162  04bb 72100001      	bset	_voltCurrentSelectionFlag
1163  04bf               L752:
1164                     ; 298     discardPulseTics = getTics();
1166  04bf cd0000        	call	_getTics
1168  04c2 ae0024        	ldw	x,#_discardPulseTics
1169  04c5 cd0000        	call	c_rtol
1171                     ; 299     bypassPulseTicsFlag = true;
1173  04c8 72100000      	bset	_bypassPulseTicsFlag
1174  04cc               L301:
1175                     ; 71   while (getTics() - discardPulseTics > discardPulseTimeout && !bypassPulseTicsFlag)
1177  04cc cd0000        	call	_getTics
1179  04cf ae0024        	ldw	x,#_discardPulseTics
1180  04d2 cd0000        	call	c_lsub
1182  04d5 ae0000        	ldw	x,#L6
1183  04d8 cd0000        	call	c_lcmp
1185  04db 250a          	jrult	L162
1187                     	btst	_bypassPulseTicsFlag
1188  04e2 2503          	jrult	L23
1189  04e4 cc0019        	jp	L77
1190  04e7               L23:
1191  04e7               L162:
1192                     ; 312 }
1195  04e7 5b12          	addw	sp,#18
1196  04e9 81            	ret
1323                     	xdef	_voltCurrentSelectionFlag
1324                     	xdef	_bypassPulseTicsFlag
1325                     	xdef	_discardPulseTics
1326                     	xdef	_powerPeriod3
1327                     	xdef	_powerPeriod2
1328                     	xdef	_powerPeriod1
1329                     	xdef	_currentPeriod3
1330                     	xdef	_currentPeriod2
1331                     	xdef	_currentPeriod1
1332                     	xdef	_voltagePeriod3
1333                     	xdef	_voltagePeriod2
1334                     	xdef	_voltagePeriod1
1335                     	xdef	_calculateVoltCurrent
1336                     	xref.b	_voltCurrent3OverflowCount
1337                     	xref.b	_voltCurrent2OverflowCount
1338                     	xref.b	_voltCurrent1OverflowCount
1339                     	xref	_calcAmp3
1340                     	xref	_calcAmp2
1341                     	xref	_calcAmp1
1342                     	xref	_calcVolt3
1343                     	xref	_calcVolt2
1344                     	xref	_calcVolt1
1345                     	xref	_Ampere_Phase3
1346                     	xref	_Voltage_Phase3
1347                     	xref	_Ampere_Phase2
1348                     	xref	_Voltage_Phase2
1349                     	xref	_Ampere_Phase1
1350                     	xref	_Voltage_Phase1
1351                     	xref	_getTics
1352                     	xref	_TIM2_ClearFlag
1353                     	xref	_TIM2_GetFlagStatus
1354                     	xref	_TIM2_GetCapture2
1355                     	xref	_TIM2_CCxCmd
1356                     	xref	_TIM1_ClearFlag
1357                     	xref	_TIM1_GetFlagStatus
1358                     	xref	_TIM1_GetCapture4
1359                     	xref	_TIM1_GetCapture2
1360                     	xref	_TIM1_CCxCmd
1361                     	xref	_GPIO_WriteLow
1362                     	xref	_GPIO_WriteHigh
1363                     	xref.b	c_x
1364                     	xref.b	c_y
1383                     	xref	c_ladd
1384                     	xref	c_uitolx
1385                     	xref	c_umul
1386                     	xref	c_lcmp
1387                     	xref	c_lsub
1388                     	xref	c_rtol
1389                     	end
