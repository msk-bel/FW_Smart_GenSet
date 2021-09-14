   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	switch	.data
  15  0000               _Voltage_Phase1:
  16  0000 00000000      	dc.l	0
  17  0004               _Voltage_Phase2:
  18  0004 00000000      	dc.l	0
  19  0008               _Voltage_Phase3:
  20  0008 00000000      	dc.l	0
  21  000c               _Ampere_Phase1:
  22  000c 00000000      	dc.l	0
  23  0010               _Ampere_Phase2:
  24  0010 00000000      	dc.l	0
  25  0014               _Ampere_Phase3:
  26  0014 00000000      	dc.l	0
  27  0018               _Watt_Phase1:
  28  0018 00000000      	dc.l	0
  29  001c               _Watt_Phase2:
  30  001c 00000000      	dc.l	0
  31  0020               _Watt_Phase3:
  32  0020 00000000      	dc.l	0
  84                     ; 49 void calcVolt1(uint32_t voltagePeriod1)
  84                     ; 50 {
  86                     	switch	.text
  87  0000               _calcVolt1:
  89  0000 5208          	subw	sp,#8
  90       00000008      OFST:	set	8
  93                     ; 52     if (checkByte == 'A')
  95  0002 b600          	ld	a,_checkByte
  96  0004 a141          	cp	a,#65
  97  0006 2648          	jrne	L33
  98                     ; 54         tempcalibfactor = voltageCalibrationFactor1 / 100.00;
 100  0008 be00          	ldw	x,_voltageCalibrationFactor1
 101  000a cd0000        	call	c_uitof
 103  000d ae000c        	ldw	x,#L14
 104  0010 cd0000        	call	c_fdiv
 106  0013 96            	ldw	x,sp
 107  0014 1c0005        	addw	x,#OFST-3
 108  0017 cd0000        	call	c_rtol
 111                     ; 55         Voltage_Phase1 = (((float)voltageMultiplier / voltagePeriod1) * tempcalibfactor) * accuracyFactor;
 113  001a 96            	ldw	x,sp
 114  001b 1c000b        	addw	x,#OFST+3
 115  001e cd0000        	call	c_ltor
 117  0021 cd0000        	call	c_ultof
 119  0024 96            	ldw	x,sp
 120  0025 1c0001        	addw	x,#OFST-7
 121  0028 cd0000        	call	c_rtol
 124  002b ae0008        	ldw	x,#L15
 125  002e cd0000        	call	c_ltor
 127  0031 96            	ldw	x,sp
 128  0032 1c0001        	addw	x,#OFST-7
 129  0035 cd0000        	call	c_fdiv
 131  0038 96            	ldw	x,sp
 132  0039 1c0005        	addw	x,#OFST-3
 133  003c cd0000        	call	c_fmul
 135  003f ae000c        	ldw	x,#L14
 136  0042 cd0000        	call	c_fmul
 138  0045 cd0000        	call	c_ftol
 140  0048 ae0000        	ldw	x,#_Voltage_Phase1
 141  004b cd0000        	call	c_rtol
 144  004e 202d          	jra	L55
 145  0050               L33:
 146                     ; 59         Voltage_Phase1 = (((float)voltageMultiplier / voltagePeriod1) * 1) * accuracyFactor;
 148  0050 96            	ldw	x,sp
 149  0051 1c000b        	addw	x,#OFST+3
 150  0054 cd0000        	call	c_ltor
 152  0057 cd0000        	call	c_ultof
 154  005a 96            	ldw	x,sp
 155  005b 1c0001        	addw	x,#OFST-7
 156  005e cd0000        	call	c_rtol
 159  0061 ae0008        	ldw	x,#L15
 160  0064 cd0000        	call	c_ltor
 162  0067 96            	ldw	x,sp
 163  0068 1c0001        	addw	x,#OFST-7
 164  006b cd0000        	call	c_fdiv
 166  006e ae000c        	ldw	x,#L14
 167  0071 cd0000        	call	c_fmul
 169  0074 cd0000        	call	c_ftol
 171  0077 ae0000        	ldw	x,#_Voltage_Phase1
 172  007a cd0000        	call	c_rtol
 174  007d               L55:
 175                     ; 61 }
 178  007d 5b08          	addw	sp,#8
 179  007f 81            	ret
 225                     ; 63 void calcVolt2(uint32_t voltagePeriod2)
 225                     ; 64 {
 226                     	switch	.text
 227  0080               _calcVolt2:
 229  0080 5208          	subw	sp,#8
 230       00000008      OFST:	set	8
 233                     ; 66     if (checkByte == 'A')
 235  0082 b600          	ld	a,_checkByte
 236  0084 a141          	cp	a,#65
 237  0086 2648          	jrne	L101
 238                     ; 68         tempcalibfactor = voltageCalibrationFactor2 / 100.00;
 240  0088 be00          	ldw	x,_voltageCalibrationFactor2
 241  008a cd0000        	call	c_uitof
 243  008d ae000c        	ldw	x,#L14
 244  0090 cd0000        	call	c_fdiv
 246  0093 96            	ldw	x,sp
 247  0094 1c0005        	addw	x,#OFST-3
 248  0097 cd0000        	call	c_rtol
 251                     ; 69         Voltage_Phase2 = (((float)voltageMultiplier / voltagePeriod2) * tempcalibfactor) * accuracyFactor;
 253  009a 96            	ldw	x,sp
 254  009b 1c000b        	addw	x,#OFST+3
 255  009e cd0000        	call	c_ltor
 257  00a1 cd0000        	call	c_ultof
 259  00a4 96            	ldw	x,sp
 260  00a5 1c0001        	addw	x,#OFST-7
 261  00a8 cd0000        	call	c_rtol
 264  00ab ae0008        	ldw	x,#L15
 265  00ae cd0000        	call	c_ltor
 267  00b1 96            	ldw	x,sp
 268  00b2 1c0001        	addw	x,#OFST-7
 269  00b5 cd0000        	call	c_fdiv
 271  00b8 96            	ldw	x,sp
 272  00b9 1c0005        	addw	x,#OFST-3
 273  00bc cd0000        	call	c_fmul
 275  00bf ae000c        	ldw	x,#L14
 276  00c2 cd0000        	call	c_fmul
 278  00c5 cd0000        	call	c_ftol
 280  00c8 ae0004        	ldw	x,#_Voltage_Phase2
 281  00cb cd0000        	call	c_rtol
 284  00ce 202d          	jra	L301
 285  00d0               L101:
 286                     ; 73         Voltage_Phase2 = (((float)voltageMultiplier / voltagePeriod2) * 1) * accuracyFactor;
 288  00d0 96            	ldw	x,sp
 289  00d1 1c000b        	addw	x,#OFST+3
 290  00d4 cd0000        	call	c_ltor
 292  00d7 cd0000        	call	c_ultof
 294  00da 96            	ldw	x,sp
 295  00db 1c0001        	addw	x,#OFST-7
 296  00de cd0000        	call	c_rtol
 299  00e1 ae0008        	ldw	x,#L15
 300  00e4 cd0000        	call	c_ltor
 302  00e7 96            	ldw	x,sp
 303  00e8 1c0001        	addw	x,#OFST-7
 304  00eb cd0000        	call	c_fdiv
 306  00ee ae000c        	ldw	x,#L14
 307  00f1 cd0000        	call	c_fmul
 309  00f4 cd0000        	call	c_ftol
 311  00f7 ae0004        	ldw	x,#_Voltage_Phase2
 312  00fa cd0000        	call	c_rtol
 314  00fd               L301:
 315                     ; 75 }
 318  00fd 5b08          	addw	sp,#8
 319  00ff 81            	ret
 365                     ; 77 void calcVolt3(uint32_t voltagePeriod3)
 365                     ; 78 {
 366                     	switch	.text
 367  0100               _calcVolt3:
 369  0100 5208          	subw	sp,#8
 370       00000008      OFST:	set	8
 373                     ; 80     if (checkByte == 'A')
 375  0102 b600          	ld	a,_checkByte
 376  0104 a141          	cp	a,#65
 377  0106 2648          	jrne	L721
 378                     ; 82         tempcalibfactor = voltageCalibrationFactor3 / 100.00;
 380  0108 be00          	ldw	x,_voltageCalibrationFactor3
 381  010a cd0000        	call	c_uitof
 383  010d ae000c        	ldw	x,#L14
 384  0110 cd0000        	call	c_fdiv
 386  0113 96            	ldw	x,sp
 387  0114 1c0005        	addw	x,#OFST-3
 388  0117 cd0000        	call	c_rtol
 391                     ; 83         Voltage_Phase3 = (((float)voltageMultiplier / voltagePeriod3) * tempcalibfactor) * accuracyFactor;
 393  011a 96            	ldw	x,sp
 394  011b 1c000b        	addw	x,#OFST+3
 395  011e cd0000        	call	c_ltor
 397  0121 cd0000        	call	c_ultof
 399  0124 96            	ldw	x,sp
 400  0125 1c0001        	addw	x,#OFST-7
 401  0128 cd0000        	call	c_rtol
 404  012b ae0008        	ldw	x,#L15
 405  012e cd0000        	call	c_ltor
 407  0131 96            	ldw	x,sp
 408  0132 1c0001        	addw	x,#OFST-7
 409  0135 cd0000        	call	c_fdiv
 411  0138 96            	ldw	x,sp
 412  0139 1c0005        	addw	x,#OFST-3
 413  013c cd0000        	call	c_fmul
 415  013f ae000c        	ldw	x,#L14
 416  0142 cd0000        	call	c_fmul
 418  0145 cd0000        	call	c_ftol
 420  0148 ae0008        	ldw	x,#_Voltage_Phase3
 421  014b cd0000        	call	c_rtol
 424  014e 202d          	jra	L131
 425  0150               L721:
 426                     ; 87         Voltage_Phase3 = (((float)voltageMultiplier / voltagePeriod3) * 1) * accuracyFactor;
 428  0150 96            	ldw	x,sp
 429  0151 1c000b        	addw	x,#OFST+3
 430  0154 cd0000        	call	c_ltor
 432  0157 cd0000        	call	c_ultof
 434  015a 96            	ldw	x,sp
 435  015b 1c0001        	addw	x,#OFST-7
 436  015e cd0000        	call	c_rtol
 439  0161 ae0008        	ldw	x,#L15
 440  0164 cd0000        	call	c_ltor
 442  0167 96            	ldw	x,sp
 443  0168 1c0001        	addw	x,#OFST-7
 444  016b cd0000        	call	c_fdiv
 446  016e ae000c        	ldw	x,#L14
 447  0171 cd0000        	call	c_fmul
 449  0174 cd0000        	call	c_ftol
 451  0177 ae0008        	ldw	x,#_Voltage_Phase3
 452  017a cd0000        	call	c_rtol
 454  017d               L131:
 455                     ; 89 }
 458  017d 5b08          	addw	sp,#8
 459  017f 81            	ret
 505                     ; 91 void calcAmp1(uint32_t ampPeriod1)
 505                     ; 92 {
 506                     	switch	.text
 507  0180               _calcAmp1:
 509  0180 5208          	subw	sp,#8
 510       00000008      OFST:	set	8
 513                     ; 94     if (checkByte == 'A')
 515  0182 b600          	ld	a,_checkByte
 516  0184 a141          	cp	a,#65
 517  0186 2648          	jrne	L551
 518                     ; 96         tempcalibfactor = currentCalibrationFactor1 / 100.00;
 520  0188 be00          	ldw	x,_currentCalibrationFactor1
 521  018a cd0000        	call	c_uitof
 523  018d ae000c        	ldw	x,#L14
 524  0190 cd0000        	call	c_fdiv
 526  0193 96            	ldw	x,sp
 527  0194 1c0005        	addw	x,#OFST-3
 528  0197 cd0000        	call	c_rtol
 531                     ; 97         Ampere_Phase1 = (((float)currentMultiplier / ampPeriod1) * tempcalibfactor) * accuracyFactor;
 533  019a 96            	ldw	x,sp
 534  019b 1c000b        	addw	x,#OFST+3
 535  019e cd0000        	call	c_ltor
 537  01a1 cd0000        	call	c_ultof
 539  01a4 96            	ldw	x,sp
 540  01a5 1c0001        	addw	x,#OFST-7
 541  01a8 cd0000        	call	c_rtol
 544  01ab ae0004        	ldw	x,#L361
 545  01ae cd0000        	call	c_ltor
 547  01b1 96            	ldw	x,sp
 548  01b2 1c0001        	addw	x,#OFST-7
 549  01b5 cd0000        	call	c_fdiv
 551  01b8 96            	ldw	x,sp
 552  01b9 1c0005        	addw	x,#OFST-3
 553  01bc cd0000        	call	c_fmul
 555  01bf ae000c        	ldw	x,#L14
 556  01c2 cd0000        	call	c_fmul
 558  01c5 cd0000        	call	c_ftol
 560  01c8 ae000c        	ldw	x,#_Ampere_Phase1
 561  01cb cd0000        	call	c_rtol
 564  01ce 202d          	jra	L761
 565  01d0               L551:
 566                     ; 101         Ampere_Phase1 = (((float)currentMultiplier / ampPeriod1) * 1) * accuracyFactor;
 568  01d0 96            	ldw	x,sp
 569  01d1 1c000b        	addw	x,#OFST+3
 570  01d4 cd0000        	call	c_ltor
 572  01d7 cd0000        	call	c_ultof
 574  01da 96            	ldw	x,sp
 575  01db 1c0001        	addw	x,#OFST-7
 576  01de cd0000        	call	c_rtol
 579  01e1 ae0004        	ldw	x,#L361
 580  01e4 cd0000        	call	c_ltor
 582  01e7 96            	ldw	x,sp
 583  01e8 1c0001        	addw	x,#OFST-7
 584  01eb cd0000        	call	c_fdiv
 586  01ee ae000c        	ldw	x,#L14
 587  01f1 cd0000        	call	c_fmul
 589  01f4 cd0000        	call	c_ftol
 591  01f7 ae000c        	ldw	x,#_Ampere_Phase1
 592  01fa cd0000        	call	c_rtol
 594  01fd               L761:
 595                     ; 103 }
 598  01fd 5b08          	addw	sp,#8
 599  01ff 81            	ret
 645                     ; 105 void calcAmp2(uint32_t ampPeriod2)
 645                     ; 106 {
 646                     	switch	.text
 647  0200               _calcAmp2:
 649  0200 5208          	subw	sp,#8
 650       00000008      OFST:	set	8
 653                     ; 108     if (checkByte == 'A')
 655  0202 b600          	ld	a,_checkByte
 656  0204 a141          	cp	a,#65
 657  0206 2648          	jrne	L312
 658                     ; 110         tempcalibfactor = currentCalibrationFactor2 / 100.00;
 660  0208 be00          	ldw	x,_currentCalibrationFactor2
 661  020a cd0000        	call	c_uitof
 663  020d ae000c        	ldw	x,#L14
 664  0210 cd0000        	call	c_fdiv
 666  0213 96            	ldw	x,sp
 667  0214 1c0005        	addw	x,#OFST-3
 668  0217 cd0000        	call	c_rtol
 671                     ; 111         Ampere_Phase2 = (((float)currentMultiplier / ampPeriod2) * tempcalibfactor) * accuracyFactor;
 673  021a 96            	ldw	x,sp
 674  021b 1c000b        	addw	x,#OFST+3
 675  021e cd0000        	call	c_ltor
 677  0221 cd0000        	call	c_ultof
 679  0224 96            	ldw	x,sp
 680  0225 1c0001        	addw	x,#OFST-7
 681  0228 cd0000        	call	c_rtol
 684  022b ae0004        	ldw	x,#L361
 685  022e cd0000        	call	c_ltor
 687  0231 96            	ldw	x,sp
 688  0232 1c0001        	addw	x,#OFST-7
 689  0235 cd0000        	call	c_fdiv
 691  0238 96            	ldw	x,sp
 692  0239 1c0005        	addw	x,#OFST-3
 693  023c cd0000        	call	c_fmul
 695  023f ae000c        	ldw	x,#L14
 696  0242 cd0000        	call	c_fmul
 698  0245 cd0000        	call	c_ftol
 700  0248 ae0010        	ldw	x,#_Ampere_Phase2
 701  024b cd0000        	call	c_rtol
 704  024e 202d          	jra	L512
 705  0250               L312:
 706                     ; 115         Ampere_Phase2 = (((float)currentMultiplier / ampPeriod2) * 1) * accuracyFactor;
 708  0250 96            	ldw	x,sp
 709  0251 1c000b        	addw	x,#OFST+3
 710  0254 cd0000        	call	c_ltor
 712  0257 cd0000        	call	c_ultof
 714  025a 96            	ldw	x,sp
 715  025b 1c0001        	addw	x,#OFST-7
 716  025e cd0000        	call	c_rtol
 719  0261 ae0004        	ldw	x,#L361
 720  0264 cd0000        	call	c_ltor
 722  0267 96            	ldw	x,sp
 723  0268 1c0001        	addw	x,#OFST-7
 724  026b cd0000        	call	c_fdiv
 726  026e ae000c        	ldw	x,#L14
 727  0271 cd0000        	call	c_fmul
 729  0274 cd0000        	call	c_ftol
 731  0277 ae0010        	ldw	x,#_Ampere_Phase2
 732  027a cd0000        	call	c_rtol
 734  027d               L512:
 735                     ; 117 }
 738  027d 5b08          	addw	sp,#8
 739  027f 81            	ret
 785                     ; 119 void calcAmp3(uint32_t ampPeriod3)
 785                     ; 120 {
 786                     	switch	.text
 787  0280               _calcAmp3:
 789  0280 5208          	subw	sp,#8
 790       00000008      OFST:	set	8
 793                     ; 122     if (checkByte == 'A')
 795  0282 b600          	ld	a,_checkByte
 796  0284 a141          	cp	a,#65
 797  0286 2648          	jrne	L142
 798                     ; 124         tempcalibfactor = currentCalibrationFactor3 / 100.00;
 800  0288 be00          	ldw	x,_currentCalibrationFactor3
 801  028a cd0000        	call	c_uitof
 803  028d ae000c        	ldw	x,#L14
 804  0290 cd0000        	call	c_fdiv
 806  0293 96            	ldw	x,sp
 807  0294 1c0005        	addw	x,#OFST-3
 808  0297 cd0000        	call	c_rtol
 811                     ; 125         Ampere_Phase3 = (((float)currentMultiplier / ampPeriod3) * tempcalibfactor) * accuracyFactor;
 813  029a 96            	ldw	x,sp
 814  029b 1c000b        	addw	x,#OFST+3
 815  029e cd0000        	call	c_ltor
 817  02a1 cd0000        	call	c_ultof
 819  02a4 96            	ldw	x,sp
 820  02a5 1c0001        	addw	x,#OFST-7
 821  02a8 cd0000        	call	c_rtol
 824  02ab ae0004        	ldw	x,#L361
 825  02ae cd0000        	call	c_ltor
 827  02b1 96            	ldw	x,sp
 828  02b2 1c0001        	addw	x,#OFST-7
 829  02b5 cd0000        	call	c_fdiv
 831  02b8 96            	ldw	x,sp
 832  02b9 1c0005        	addw	x,#OFST-3
 833  02bc cd0000        	call	c_fmul
 835  02bf ae000c        	ldw	x,#L14
 836  02c2 cd0000        	call	c_fmul
 838  02c5 cd0000        	call	c_ftol
 840  02c8 ae0014        	ldw	x,#_Ampere_Phase3
 841  02cb cd0000        	call	c_rtol
 844  02ce 202d          	jra	L342
 845  02d0               L142:
 846                     ; 129         Ampere_Phase3 = (((float)currentMultiplier / ampPeriod3) * 1) * accuracyFactor;
 848  02d0 96            	ldw	x,sp
 849  02d1 1c000b        	addw	x,#OFST+3
 850  02d4 cd0000        	call	c_ltor
 852  02d7 cd0000        	call	c_ultof
 854  02da 96            	ldw	x,sp
 855  02db 1c0001        	addw	x,#OFST-7
 856  02de cd0000        	call	c_rtol
 859  02e1 ae0004        	ldw	x,#L361
 860  02e4 cd0000        	call	c_ltor
 862  02e7 96            	ldw	x,sp
 863  02e8 1c0001        	addw	x,#OFST-7
 864  02eb cd0000        	call	c_fdiv
 866  02ee ae000c        	ldw	x,#L14
 867  02f1 cd0000        	call	c_fmul
 869  02f4 cd0000        	call	c_ftol
 871  02f7 ae0014        	ldw	x,#_Ampere_Phase3
 872  02fa cd0000        	call	c_rtol
 874  02fd               L342:
 875                     ; 131 }
 878  02fd 5b08          	addw	sp,#8
 879  02ff 81            	ret
 925                     ; 133 void calcWatt1(uint32_t wattPeriod1)
 925                     ; 134 {
 926                     	switch	.text
 927  0300               _calcWatt1:
 929  0300 5208          	subw	sp,#8
 930       00000008      OFST:	set	8
 933                     ; 136     if (checkByte == 'A')
 935  0302 b600          	ld	a,_checkByte
 936  0304 a141          	cp	a,#65
 937  0306 2648          	jrne	L762
 938                     ; 138         tempcalibfactor = powerCalibrationFactor1 / 100.00;
 940  0308 be00          	ldw	x,_powerCalibrationFactor1
 941  030a cd0000        	call	c_uitof
 943  030d ae000c        	ldw	x,#L14
 944  0310 cd0000        	call	c_fdiv
 946  0313 96            	ldw	x,sp
 947  0314 1c0005        	addw	x,#OFST-3
 948  0317 cd0000        	call	c_rtol
 951                     ; 139         Watt_Phase1 = (((float)powerMultiplier / wattPeriod1) * tempcalibfactor) * accuracyFactor;
 953  031a 96            	ldw	x,sp
 954  031b 1c000b        	addw	x,#OFST+3
 955  031e cd0000        	call	c_ltor
 957  0321 cd0000        	call	c_ultof
 959  0324 96            	ldw	x,sp
 960  0325 1c0001        	addw	x,#OFST-7
 961  0328 cd0000        	call	c_rtol
 964  032b ae0000        	ldw	x,#L572
 965  032e cd0000        	call	c_ltor
 967  0331 96            	ldw	x,sp
 968  0332 1c0001        	addw	x,#OFST-7
 969  0335 cd0000        	call	c_fdiv
 971  0338 96            	ldw	x,sp
 972  0339 1c0005        	addw	x,#OFST-3
 973  033c cd0000        	call	c_fmul
 975  033f ae000c        	ldw	x,#L14
 976  0342 cd0000        	call	c_fmul
 978  0345 cd0000        	call	c_ftol
 980  0348 ae0018        	ldw	x,#_Watt_Phase1
 981  034b cd0000        	call	c_rtol
 984  034e 202d          	jra	L103
 985  0350               L762:
 986                     ; 143         Watt_Phase1 = (((float)powerMultiplier / wattPeriod1) * 1) * accuracyFactor;
 988  0350 96            	ldw	x,sp
 989  0351 1c000b        	addw	x,#OFST+3
 990  0354 cd0000        	call	c_ltor
 992  0357 cd0000        	call	c_ultof
 994  035a 96            	ldw	x,sp
 995  035b 1c0001        	addw	x,#OFST-7
 996  035e cd0000        	call	c_rtol
 999  0361 ae0000        	ldw	x,#L572
1000  0364 cd0000        	call	c_ltor
1002  0367 96            	ldw	x,sp
1003  0368 1c0001        	addw	x,#OFST-7
1004  036b cd0000        	call	c_fdiv
1006  036e ae000c        	ldw	x,#L14
1007  0371 cd0000        	call	c_fmul
1009  0374 cd0000        	call	c_ftol
1011  0377 ae0018        	ldw	x,#_Watt_Phase1
1012  037a cd0000        	call	c_rtol
1014  037d               L103:
1015                     ; 145 }
1018  037d 5b08          	addw	sp,#8
1019  037f 81            	ret
1065                     ; 147 void calcWatt2(uint32_t wattPeriod2)
1065                     ; 148 {
1066                     	switch	.text
1067  0380               _calcWatt2:
1069  0380 5208          	subw	sp,#8
1070       00000008      OFST:	set	8
1073                     ; 150     if (checkByte == 'A')
1075  0382 b600          	ld	a,_checkByte
1076  0384 a141          	cp	a,#65
1077  0386 2648          	jrne	L523
1078                     ; 152         tempcalibfactor = powerCalibrationFactor2 / 100.00;
1080  0388 be00          	ldw	x,_powerCalibrationFactor2
1081  038a cd0000        	call	c_uitof
1083  038d ae000c        	ldw	x,#L14
1084  0390 cd0000        	call	c_fdiv
1086  0393 96            	ldw	x,sp
1087  0394 1c0005        	addw	x,#OFST-3
1088  0397 cd0000        	call	c_rtol
1091                     ; 153         Watt_Phase2 = (((float)powerMultiplier / wattPeriod2) * tempcalibfactor) * accuracyFactor;
1093  039a 96            	ldw	x,sp
1094  039b 1c000b        	addw	x,#OFST+3
1095  039e cd0000        	call	c_ltor
1097  03a1 cd0000        	call	c_ultof
1099  03a4 96            	ldw	x,sp
1100  03a5 1c0001        	addw	x,#OFST-7
1101  03a8 cd0000        	call	c_rtol
1104  03ab ae0000        	ldw	x,#L572
1105  03ae cd0000        	call	c_ltor
1107  03b1 96            	ldw	x,sp
1108  03b2 1c0001        	addw	x,#OFST-7
1109  03b5 cd0000        	call	c_fdiv
1111  03b8 96            	ldw	x,sp
1112  03b9 1c0005        	addw	x,#OFST-3
1113  03bc cd0000        	call	c_fmul
1115  03bf ae000c        	ldw	x,#L14
1116  03c2 cd0000        	call	c_fmul
1118  03c5 cd0000        	call	c_ftol
1120  03c8 ae001c        	ldw	x,#_Watt_Phase2
1121  03cb cd0000        	call	c_rtol
1124  03ce 202d          	jra	L723
1125  03d0               L523:
1126                     ; 157         Watt_Phase2 = (((float)powerMultiplier / wattPeriod2) * 1) * accuracyFactor;
1128  03d0 96            	ldw	x,sp
1129  03d1 1c000b        	addw	x,#OFST+3
1130  03d4 cd0000        	call	c_ltor
1132  03d7 cd0000        	call	c_ultof
1134  03da 96            	ldw	x,sp
1135  03db 1c0001        	addw	x,#OFST-7
1136  03de cd0000        	call	c_rtol
1139  03e1 ae0000        	ldw	x,#L572
1140  03e4 cd0000        	call	c_ltor
1142  03e7 96            	ldw	x,sp
1143  03e8 1c0001        	addw	x,#OFST-7
1144  03eb cd0000        	call	c_fdiv
1146  03ee ae000c        	ldw	x,#L14
1147  03f1 cd0000        	call	c_fmul
1149  03f4 cd0000        	call	c_ftol
1151  03f7 ae001c        	ldw	x,#_Watt_Phase2
1152  03fa cd0000        	call	c_rtol
1154  03fd               L723:
1155                     ; 159 }
1158  03fd 5b08          	addw	sp,#8
1159  03ff 81            	ret
1205                     ; 161 void calcWatt3(uint32_t wattPeriod3)
1205                     ; 162 {
1206                     	switch	.text
1207  0400               _calcWatt3:
1209  0400 5208          	subw	sp,#8
1210       00000008      OFST:	set	8
1213                     ; 164     if (checkByte == 'A')
1215  0402 b600          	ld	a,_checkByte
1216  0404 a141          	cp	a,#65
1217  0406 2648          	jrne	L353
1218                     ; 166         tempcalibfactor = powerCalibrationFactor3 / 100.00;
1220  0408 be00          	ldw	x,_powerCalibrationFactor3
1221  040a cd0000        	call	c_uitof
1223  040d ae000c        	ldw	x,#L14
1224  0410 cd0000        	call	c_fdiv
1226  0413 96            	ldw	x,sp
1227  0414 1c0005        	addw	x,#OFST-3
1228  0417 cd0000        	call	c_rtol
1231                     ; 167         Watt_Phase3 = (((float)powerMultiplier / wattPeriod3) * tempcalibfactor) * accuracyFactor;
1233  041a 96            	ldw	x,sp
1234  041b 1c000b        	addw	x,#OFST+3
1235  041e cd0000        	call	c_ltor
1237  0421 cd0000        	call	c_ultof
1239  0424 96            	ldw	x,sp
1240  0425 1c0001        	addw	x,#OFST-7
1241  0428 cd0000        	call	c_rtol
1244  042b ae0000        	ldw	x,#L572
1245  042e cd0000        	call	c_ltor
1247  0431 96            	ldw	x,sp
1248  0432 1c0001        	addw	x,#OFST-7
1249  0435 cd0000        	call	c_fdiv
1251  0438 96            	ldw	x,sp
1252  0439 1c0005        	addw	x,#OFST-3
1253  043c cd0000        	call	c_fmul
1255  043f ae000c        	ldw	x,#L14
1256  0442 cd0000        	call	c_fmul
1258  0445 cd0000        	call	c_ftol
1260  0448 ae0020        	ldw	x,#_Watt_Phase3
1261  044b cd0000        	call	c_rtol
1264  044e 202d          	jra	L553
1265  0450               L353:
1266                     ; 171         Watt_Phase3 = (((float)powerMultiplier / wattPeriod3) * 1) * accuracyFactor;
1268  0450 96            	ldw	x,sp
1269  0451 1c000b        	addw	x,#OFST+3
1270  0454 cd0000        	call	c_ltor
1272  0457 cd0000        	call	c_ultof
1274  045a 96            	ldw	x,sp
1275  045b 1c0001        	addw	x,#OFST-7
1276  045e cd0000        	call	c_rtol
1279  0461 ae0000        	ldw	x,#L572
1280  0464 cd0000        	call	c_ltor
1282  0467 96            	ldw	x,sp
1283  0468 1c0001        	addw	x,#OFST-7
1284  046b cd0000        	call	c_fdiv
1286  046e ae000c        	ldw	x,#L14
1287  0471 cd0000        	call	c_fmul
1289  0474 cd0000        	call	c_ftol
1291  0477 ae0020        	ldw	x,#_Watt_Phase3
1292  047a cd0000        	call	c_rtol
1294  047d               L553:
1295                     ; 173 }
1298  047d 5b08          	addw	sp,#8
1299  047f 81            	ret
1395                     	xref.b	_checkByte
1396                     	xref.b	_powerCalibrationFactor3
1397                     	xref.b	_powerCalibrationFactor2
1398                     	xref.b	_powerCalibrationFactor1
1399                     	xref.b	_currentCalibrationFactor3
1400                     	xref.b	_currentCalibrationFactor2
1401                     	xref.b	_currentCalibrationFactor1
1402                     	xref.b	_voltageCalibrationFactor3
1403                     	xref.b	_voltageCalibrationFactor2
1404                     	xref.b	_voltageCalibrationFactor1
1405                     	xdef	_calcWatt3
1406                     	xdef	_calcWatt2
1407                     	xdef	_calcWatt1
1408                     	xdef	_calcAmp3
1409                     	xdef	_calcAmp2
1410                     	xdef	_calcAmp1
1411                     	xdef	_calcVolt3
1412                     	xdef	_calcVolt2
1413                     	xdef	_calcVolt1
1414                     	xdef	_Watt_Phase3
1415                     	xdef	_Ampere_Phase3
1416                     	xdef	_Voltage_Phase3
1417                     	xdef	_Watt_Phase2
1418                     	xdef	_Ampere_Phase2
1419                     	xdef	_Voltage_Phase2
1420                     	xdef	_Watt_Phase1
1421                     	xdef	_Ampere_Phase1
1422                     	xdef	_Voltage_Phase1
1423                     .const:	section	.text
1424  0000               L572:
1425  0000 4c604e99      	dc.w	19552,20121
1426  0004               L361:
1427  0004 47951407      	dc.w	18325,5127
1428  0008               L15:
1429  0008 495a28f2      	dc.w	18778,10482
1430  000c               L14:
1431  000c 42c80000      	dc.w	17096,0
1432                     	xref.b	c_x
1452                     	xref	c_ftol
1453                     	xref	c_fmul
1454                     	xref	c_ultof
1455                     	xref	c_ltor
1456                     	xref	c_rtol
1457                     	xref	c_fdiv
1458                     	xref	c_uitof
1459                     	end
