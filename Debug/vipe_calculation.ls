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
  97  0006 264a          	jrne	L33
  98                     ; 54         tempcalibfactor = voltageCalibrationFactor1 / 100.00;
 100  0008 b600          	ld	a,_voltageCalibrationFactor1
 101  000a 5f            	clrw	x
 102  000b 97            	ld	xl,a
 103  000c cd0000        	call	c_itof
 105  000f ae000c        	ldw	x,#L14
 106  0012 cd0000        	call	c_fdiv
 108  0015 96            	ldw	x,sp
 109  0016 1c0005        	addw	x,#OFST-3
 110  0019 cd0000        	call	c_rtol
 113                     ; 55         Voltage_Phase1 = (((float)voltageMultiplier / voltagePeriod1) * tempcalibfactor) * accuracyFactor;
 115  001c 96            	ldw	x,sp
 116  001d 1c000b        	addw	x,#OFST+3
 117  0020 cd0000        	call	c_ltor
 119  0023 cd0000        	call	c_ultof
 121  0026 96            	ldw	x,sp
 122  0027 1c0001        	addw	x,#OFST-7
 123  002a cd0000        	call	c_rtol
 126  002d ae0008        	ldw	x,#L15
 127  0030 cd0000        	call	c_ltor
 129  0033 96            	ldw	x,sp
 130  0034 1c0001        	addw	x,#OFST-7
 131  0037 cd0000        	call	c_fdiv
 133  003a 96            	ldw	x,sp
 134  003b 1c0005        	addw	x,#OFST-3
 135  003e cd0000        	call	c_fmul
 137  0041 ae000c        	ldw	x,#L14
 138  0044 cd0000        	call	c_fmul
 140  0047 cd0000        	call	c_ftol
 142  004a ae0000        	ldw	x,#_Voltage_Phase1
 143  004d cd0000        	call	c_rtol
 146  0050 202d          	jra	L55
 147  0052               L33:
 148                     ; 59         Voltage_Phase1 = (((float)voltageMultiplier / voltagePeriod1) * 1) * accuracyFactor;
 150  0052 96            	ldw	x,sp
 151  0053 1c000b        	addw	x,#OFST+3
 152  0056 cd0000        	call	c_ltor
 154  0059 cd0000        	call	c_ultof
 156  005c 96            	ldw	x,sp
 157  005d 1c0001        	addw	x,#OFST-7
 158  0060 cd0000        	call	c_rtol
 161  0063 ae0008        	ldw	x,#L15
 162  0066 cd0000        	call	c_ltor
 164  0069 96            	ldw	x,sp
 165  006a 1c0001        	addw	x,#OFST-7
 166  006d cd0000        	call	c_fdiv
 168  0070 ae000c        	ldw	x,#L14
 169  0073 cd0000        	call	c_fmul
 171  0076 cd0000        	call	c_ftol
 173  0079 ae0000        	ldw	x,#_Voltage_Phase1
 174  007c cd0000        	call	c_rtol
 176  007f               L55:
 177                     ; 61 }
 180  007f 5b08          	addw	sp,#8
 181  0081 81            	ret
 227                     ; 63 void calcVolt2(uint32_t voltagePeriod2)
 227                     ; 64 {
 228                     	switch	.text
 229  0082               _calcVolt2:
 231  0082 5208          	subw	sp,#8
 232       00000008      OFST:	set	8
 235                     ; 66     if (checkByte == 'A')
 237  0084 b600          	ld	a,_checkByte
 238  0086 a141          	cp	a,#65
 239  0088 264a          	jrne	L101
 240                     ; 68         tempcalibfactor = voltageCalibrationFactor2 / 100.00;
 242  008a b600          	ld	a,_voltageCalibrationFactor2
 243  008c 5f            	clrw	x
 244  008d 97            	ld	xl,a
 245  008e cd0000        	call	c_itof
 247  0091 ae000c        	ldw	x,#L14
 248  0094 cd0000        	call	c_fdiv
 250  0097 96            	ldw	x,sp
 251  0098 1c0005        	addw	x,#OFST-3
 252  009b cd0000        	call	c_rtol
 255                     ; 69         Voltage_Phase2 = (((float)voltageMultiplier / voltagePeriod2) * tempcalibfactor) * accuracyFactor;
 257  009e 96            	ldw	x,sp
 258  009f 1c000b        	addw	x,#OFST+3
 259  00a2 cd0000        	call	c_ltor
 261  00a5 cd0000        	call	c_ultof
 263  00a8 96            	ldw	x,sp
 264  00a9 1c0001        	addw	x,#OFST-7
 265  00ac cd0000        	call	c_rtol
 268  00af ae0008        	ldw	x,#L15
 269  00b2 cd0000        	call	c_ltor
 271  00b5 96            	ldw	x,sp
 272  00b6 1c0001        	addw	x,#OFST-7
 273  00b9 cd0000        	call	c_fdiv
 275  00bc 96            	ldw	x,sp
 276  00bd 1c0005        	addw	x,#OFST-3
 277  00c0 cd0000        	call	c_fmul
 279  00c3 ae000c        	ldw	x,#L14
 280  00c6 cd0000        	call	c_fmul
 282  00c9 cd0000        	call	c_ftol
 284  00cc ae0004        	ldw	x,#_Voltage_Phase2
 285  00cf cd0000        	call	c_rtol
 288  00d2 202d          	jra	L301
 289  00d4               L101:
 290                     ; 73         Voltage_Phase2 = (((float)voltageMultiplier / voltagePeriod2) * 1) * accuracyFactor;
 292  00d4 96            	ldw	x,sp
 293  00d5 1c000b        	addw	x,#OFST+3
 294  00d8 cd0000        	call	c_ltor
 296  00db cd0000        	call	c_ultof
 298  00de 96            	ldw	x,sp
 299  00df 1c0001        	addw	x,#OFST-7
 300  00e2 cd0000        	call	c_rtol
 303  00e5 ae0008        	ldw	x,#L15
 304  00e8 cd0000        	call	c_ltor
 306  00eb 96            	ldw	x,sp
 307  00ec 1c0001        	addw	x,#OFST-7
 308  00ef cd0000        	call	c_fdiv
 310  00f2 ae000c        	ldw	x,#L14
 311  00f5 cd0000        	call	c_fmul
 313  00f8 cd0000        	call	c_ftol
 315  00fb ae0004        	ldw	x,#_Voltage_Phase2
 316  00fe cd0000        	call	c_rtol
 318  0101               L301:
 319                     ; 75 }
 322  0101 5b08          	addw	sp,#8
 323  0103 81            	ret
 369                     ; 77 void calcVolt3(uint32_t voltagePeriod3)
 369                     ; 78 {
 370                     	switch	.text
 371  0104               _calcVolt3:
 373  0104 5208          	subw	sp,#8
 374       00000008      OFST:	set	8
 377                     ; 80     if (checkByte == 'A')
 379  0106 b600          	ld	a,_checkByte
 380  0108 a141          	cp	a,#65
 381  010a 264a          	jrne	L721
 382                     ; 82         tempcalibfactor = voltageCalibrationFactor3 / 100.00;
 384  010c b600          	ld	a,_voltageCalibrationFactor3
 385  010e 5f            	clrw	x
 386  010f 97            	ld	xl,a
 387  0110 cd0000        	call	c_itof
 389  0113 ae000c        	ldw	x,#L14
 390  0116 cd0000        	call	c_fdiv
 392  0119 96            	ldw	x,sp
 393  011a 1c0005        	addw	x,#OFST-3
 394  011d cd0000        	call	c_rtol
 397                     ; 83         Voltage_Phase3 = (((float)voltageMultiplier / voltagePeriod3) * tempcalibfactor) * accuracyFactor;
 399  0120 96            	ldw	x,sp
 400  0121 1c000b        	addw	x,#OFST+3
 401  0124 cd0000        	call	c_ltor
 403  0127 cd0000        	call	c_ultof
 405  012a 96            	ldw	x,sp
 406  012b 1c0001        	addw	x,#OFST-7
 407  012e cd0000        	call	c_rtol
 410  0131 ae0008        	ldw	x,#L15
 411  0134 cd0000        	call	c_ltor
 413  0137 96            	ldw	x,sp
 414  0138 1c0001        	addw	x,#OFST-7
 415  013b cd0000        	call	c_fdiv
 417  013e 96            	ldw	x,sp
 418  013f 1c0005        	addw	x,#OFST-3
 419  0142 cd0000        	call	c_fmul
 421  0145 ae000c        	ldw	x,#L14
 422  0148 cd0000        	call	c_fmul
 424  014b cd0000        	call	c_ftol
 426  014e ae0008        	ldw	x,#_Voltage_Phase3
 427  0151 cd0000        	call	c_rtol
 430  0154 202d          	jra	L131
 431  0156               L721:
 432                     ; 87         Voltage_Phase3 = (((float)voltageMultiplier / voltagePeriod3) * 1) * accuracyFactor;
 434  0156 96            	ldw	x,sp
 435  0157 1c000b        	addw	x,#OFST+3
 436  015a cd0000        	call	c_ltor
 438  015d cd0000        	call	c_ultof
 440  0160 96            	ldw	x,sp
 441  0161 1c0001        	addw	x,#OFST-7
 442  0164 cd0000        	call	c_rtol
 445  0167 ae0008        	ldw	x,#L15
 446  016a cd0000        	call	c_ltor
 448  016d 96            	ldw	x,sp
 449  016e 1c0001        	addw	x,#OFST-7
 450  0171 cd0000        	call	c_fdiv
 452  0174 ae000c        	ldw	x,#L14
 453  0177 cd0000        	call	c_fmul
 455  017a cd0000        	call	c_ftol
 457  017d ae0008        	ldw	x,#_Voltage_Phase3
 458  0180 cd0000        	call	c_rtol
 460  0183               L131:
 461                     ; 89 }
 464  0183 5b08          	addw	sp,#8
 465  0185 81            	ret
 511                     ; 91 void calcAmp1(uint32_t ampPeriod1)
 511                     ; 92 {
 512                     	switch	.text
 513  0186               _calcAmp1:
 515  0186 5208          	subw	sp,#8
 516       00000008      OFST:	set	8
 519                     ; 94     if (checkByte == 'A')
 521  0188 b600          	ld	a,_checkByte
 522  018a a141          	cp	a,#65
 523  018c 264a          	jrne	L551
 524                     ; 96         tempcalibfactor = currentCalibrationFactor3 / 100.00;
 526  018e b600          	ld	a,_currentCalibrationFactor3
 527  0190 5f            	clrw	x
 528  0191 97            	ld	xl,a
 529  0192 cd0000        	call	c_itof
 531  0195 ae000c        	ldw	x,#L14
 532  0198 cd0000        	call	c_fdiv
 534  019b 96            	ldw	x,sp
 535  019c 1c0005        	addw	x,#OFST-3
 536  019f cd0000        	call	c_rtol
 539                     ; 97         Ampere_Phase1 = (((float)currentMultiplier / ampPeriod1) * tempcalibfactor) * accuracyFactor;
 541  01a2 96            	ldw	x,sp
 542  01a3 1c000b        	addw	x,#OFST+3
 543  01a6 cd0000        	call	c_ltor
 545  01a9 cd0000        	call	c_ultof
 547  01ac 96            	ldw	x,sp
 548  01ad 1c0001        	addw	x,#OFST-7
 549  01b0 cd0000        	call	c_rtol
 552  01b3 ae0004        	ldw	x,#L361
 553  01b6 cd0000        	call	c_ltor
 555  01b9 96            	ldw	x,sp
 556  01ba 1c0001        	addw	x,#OFST-7
 557  01bd cd0000        	call	c_fdiv
 559  01c0 96            	ldw	x,sp
 560  01c1 1c0005        	addw	x,#OFST-3
 561  01c4 cd0000        	call	c_fmul
 563  01c7 ae000c        	ldw	x,#L14
 564  01ca cd0000        	call	c_fmul
 566  01cd cd0000        	call	c_ftol
 568  01d0 ae000c        	ldw	x,#_Ampere_Phase1
 569  01d3 cd0000        	call	c_rtol
 572  01d6 202d          	jra	L761
 573  01d8               L551:
 574                     ; 101         Ampere_Phase1 = (((float)currentMultiplier / ampPeriod1) * 1) * accuracyFactor;
 576  01d8 96            	ldw	x,sp
 577  01d9 1c000b        	addw	x,#OFST+3
 578  01dc cd0000        	call	c_ltor
 580  01df cd0000        	call	c_ultof
 582  01e2 96            	ldw	x,sp
 583  01e3 1c0001        	addw	x,#OFST-7
 584  01e6 cd0000        	call	c_rtol
 587  01e9 ae0004        	ldw	x,#L361
 588  01ec cd0000        	call	c_ltor
 590  01ef 96            	ldw	x,sp
 591  01f0 1c0001        	addw	x,#OFST-7
 592  01f3 cd0000        	call	c_fdiv
 594  01f6 ae000c        	ldw	x,#L14
 595  01f9 cd0000        	call	c_fmul
 597  01fc cd0000        	call	c_ftol
 599  01ff ae000c        	ldw	x,#_Ampere_Phase1
 600  0202 cd0000        	call	c_rtol
 602  0205               L761:
 603                     ; 103 }
 606  0205 5b08          	addw	sp,#8
 607  0207 81            	ret
 653                     ; 105 void calcAmp2(uint32_t ampPeriod2)
 653                     ; 106 {
 654                     	switch	.text
 655  0208               _calcAmp2:
 657  0208 5208          	subw	sp,#8
 658       00000008      OFST:	set	8
 661                     ; 108     if (checkByte == 'A')
 663  020a b600          	ld	a,_checkByte
 664  020c a141          	cp	a,#65
 665  020e 264a          	jrne	L312
 666                     ; 110         tempcalibfactor = currentCalibrationFactor3 / 100.00;
 668  0210 b600          	ld	a,_currentCalibrationFactor3
 669  0212 5f            	clrw	x
 670  0213 97            	ld	xl,a
 671  0214 cd0000        	call	c_itof
 673  0217 ae000c        	ldw	x,#L14
 674  021a cd0000        	call	c_fdiv
 676  021d 96            	ldw	x,sp
 677  021e 1c0005        	addw	x,#OFST-3
 678  0221 cd0000        	call	c_rtol
 681                     ; 111         Ampere_Phase2 = (((float)currentMultiplier / ampPeriod2) * tempcalibfactor) * accuracyFactor;
 683  0224 96            	ldw	x,sp
 684  0225 1c000b        	addw	x,#OFST+3
 685  0228 cd0000        	call	c_ltor
 687  022b cd0000        	call	c_ultof
 689  022e 96            	ldw	x,sp
 690  022f 1c0001        	addw	x,#OFST-7
 691  0232 cd0000        	call	c_rtol
 694  0235 ae0004        	ldw	x,#L361
 695  0238 cd0000        	call	c_ltor
 697  023b 96            	ldw	x,sp
 698  023c 1c0001        	addw	x,#OFST-7
 699  023f cd0000        	call	c_fdiv
 701  0242 96            	ldw	x,sp
 702  0243 1c0005        	addw	x,#OFST-3
 703  0246 cd0000        	call	c_fmul
 705  0249 ae000c        	ldw	x,#L14
 706  024c cd0000        	call	c_fmul
 708  024f cd0000        	call	c_ftol
 710  0252 ae0010        	ldw	x,#_Ampere_Phase2
 711  0255 cd0000        	call	c_rtol
 714  0258 202d          	jra	L512
 715  025a               L312:
 716                     ; 115         Ampere_Phase2 = (((float)currentMultiplier / ampPeriod2) * 1) * accuracyFactor;
 718  025a 96            	ldw	x,sp
 719  025b 1c000b        	addw	x,#OFST+3
 720  025e cd0000        	call	c_ltor
 722  0261 cd0000        	call	c_ultof
 724  0264 96            	ldw	x,sp
 725  0265 1c0001        	addw	x,#OFST-7
 726  0268 cd0000        	call	c_rtol
 729  026b ae0004        	ldw	x,#L361
 730  026e cd0000        	call	c_ltor
 732  0271 96            	ldw	x,sp
 733  0272 1c0001        	addw	x,#OFST-7
 734  0275 cd0000        	call	c_fdiv
 736  0278 ae000c        	ldw	x,#L14
 737  027b cd0000        	call	c_fmul
 739  027e cd0000        	call	c_ftol
 741  0281 ae0010        	ldw	x,#_Ampere_Phase2
 742  0284 cd0000        	call	c_rtol
 744  0287               L512:
 745                     ; 117 }
 748  0287 5b08          	addw	sp,#8
 749  0289 81            	ret
 795                     ; 119 void calcAmp3(uint32_t ampPeriod3)
 795                     ; 120 {
 796                     	switch	.text
 797  028a               _calcAmp3:
 799  028a 5208          	subw	sp,#8
 800       00000008      OFST:	set	8
 803                     ; 122     if (checkByte == 'A')
 805  028c b600          	ld	a,_checkByte
 806  028e a141          	cp	a,#65
 807  0290 264a          	jrne	L142
 808                     ; 124         tempcalibfactor = currentCalibrationFactor3 / 100.00;
 810  0292 b600          	ld	a,_currentCalibrationFactor3
 811  0294 5f            	clrw	x
 812  0295 97            	ld	xl,a
 813  0296 cd0000        	call	c_itof
 815  0299 ae000c        	ldw	x,#L14
 816  029c cd0000        	call	c_fdiv
 818  029f 96            	ldw	x,sp
 819  02a0 1c0005        	addw	x,#OFST-3
 820  02a3 cd0000        	call	c_rtol
 823                     ; 125         Ampere_Phase3 = (((float)currentMultiplier / ampPeriod3) * tempcalibfactor) * accuracyFactor;
 825  02a6 96            	ldw	x,sp
 826  02a7 1c000b        	addw	x,#OFST+3
 827  02aa cd0000        	call	c_ltor
 829  02ad cd0000        	call	c_ultof
 831  02b0 96            	ldw	x,sp
 832  02b1 1c0001        	addw	x,#OFST-7
 833  02b4 cd0000        	call	c_rtol
 836  02b7 ae0004        	ldw	x,#L361
 837  02ba cd0000        	call	c_ltor
 839  02bd 96            	ldw	x,sp
 840  02be 1c0001        	addw	x,#OFST-7
 841  02c1 cd0000        	call	c_fdiv
 843  02c4 96            	ldw	x,sp
 844  02c5 1c0005        	addw	x,#OFST-3
 845  02c8 cd0000        	call	c_fmul
 847  02cb ae000c        	ldw	x,#L14
 848  02ce cd0000        	call	c_fmul
 850  02d1 cd0000        	call	c_ftol
 852  02d4 ae0014        	ldw	x,#_Ampere_Phase3
 853  02d7 cd0000        	call	c_rtol
 856  02da 202d          	jra	L342
 857  02dc               L142:
 858                     ; 129         Ampere_Phase3 = (((float)currentMultiplier / ampPeriod3) * 1) * accuracyFactor;
 860  02dc 96            	ldw	x,sp
 861  02dd 1c000b        	addw	x,#OFST+3
 862  02e0 cd0000        	call	c_ltor
 864  02e3 cd0000        	call	c_ultof
 866  02e6 96            	ldw	x,sp
 867  02e7 1c0001        	addw	x,#OFST-7
 868  02ea cd0000        	call	c_rtol
 871  02ed ae0004        	ldw	x,#L361
 872  02f0 cd0000        	call	c_ltor
 874  02f3 96            	ldw	x,sp
 875  02f4 1c0001        	addw	x,#OFST-7
 876  02f7 cd0000        	call	c_fdiv
 878  02fa ae000c        	ldw	x,#L14
 879  02fd cd0000        	call	c_fmul
 881  0300 cd0000        	call	c_ftol
 883  0303 ae0014        	ldw	x,#_Ampere_Phase3
 884  0306 cd0000        	call	c_rtol
 886  0309               L342:
 887                     ; 131 }
 890  0309 5b08          	addw	sp,#8
 891  030b 81            	ret
 937                     ; 133 void calcWatt1(uint32_t wattPeriod1)
 937                     ; 134 {
 938                     	switch	.text
 939  030c               _calcWatt1:
 941  030c 5208          	subw	sp,#8
 942       00000008      OFST:	set	8
 945                     ; 136     if (checkByte == 'A')
 947  030e b600          	ld	a,_checkByte
 948  0310 a141          	cp	a,#65
 949  0312 264a          	jrne	L762
 950                     ; 138         tempcalibfactor = powerCalibrationFactor3 / 100.00;
 952  0314 b600          	ld	a,_powerCalibrationFactor3
 953  0316 5f            	clrw	x
 954  0317 97            	ld	xl,a
 955  0318 cd0000        	call	c_itof
 957  031b ae000c        	ldw	x,#L14
 958  031e cd0000        	call	c_fdiv
 960  0321 96            	ldw	x,sp
 961  0322 1c0005        	addw	x,#OFST-3
 962  0325 cd0000        	call	c_rtol
 965                     ; 139         Watt_Phase1 = (((float)powerMultiplier / wattPeriod1) * tempcalibfactor) * accuracyFactor;
 967  0328 96            	ldw	x,sp
 968  0329 1c000b        	addw	x,#OFST+3
 969  032c cd0000        	call	c_ltor
 971  032f cd0000        	call	c_ultof
 973  0332 96            	ldw	x,sp
 974  0333 1c0001        	addw	x,#OFST-7
 975  0336 cd0000        	call	c_rtol
 978  0339 ae0000        	ldw	x,#L572
 979  033c cd0000        	call	c_ltor
 981  033f 96            	ldw	x,sp
 982  0340 1c0001        	addw	x,#OFST-7
 983  0343 cd0000        	call	c_fdiv
 985  0346 96            	ldw	x,sp
 986  0347 1c0005        	addw	x,#OFST-3
 987  034a cd0000        	call	c_fmul
 989  034d ae000c        	ldw	x,#L14
 990  0350 cd0000        	call	c_fmul
 992  0353 cd0000        	call	c_ftol
 994  0356 ae0018        	ldw	x,#_Watt_Phase1
 995  0359 cd0000        	call	c_rtol
 998  035c 202d          	jra	L103
 999  035e               L762:
1000                     ; 143         Watt_Phase1 = (((float)powerMultiplier / wattPeriod1) * 1) * accuracyFactor;
1002  035e 96            	ldw	x,sp
1003  035f 1c000b        	addw	x,#OFST+3
1004  0362 cd0000        	call	c_ltor
1006  0365 cd0000        	call	c_ultof
1008  0368 96            	ldw	x,sp
1009  0369 1c0001        	addw	x,#OFST-7
1010  036c cd0000        	call	c_rtol
1013  036f ae0000        	ldw	x,#L572
1014  0372 cd0000        	call	c_ltor
1016  0375 96            	ldw	x,sp
1017  0376 1c0001        	addw	x,#OFST-7
1018  0379 cd0000        	call	c_fdiv
1020  037c ae000c        	ldw	x,#L14
1021  037f cd0000        	call	c_fmul
1023  0382 cd0000        	call	c_ftol
1025  0385 ae0018        	ldw	x,#_Watt_Phase1
1026  0388 cd0000        	call	c_rtol
1028  038b               L103:
1029                     ; 145 }
1032  038b 5b08          	addw	sp,#8
1033  038d 81            	ret
1079                     ; 147 void calcWatt2(uint32_t wattPeriod2)
1079                     ; 148 {
1080                     	switch	.text
1081  038e               _calcWatt2:
1083  038e 5208          	subw	sp,#8
1084       00000008      OFST:	set	8
1087                     ; 150     if (checkByte == 'A')
1089  0390 b600          	ld	a,_checkByte
1090  0392 a141          	cp	a,#65
1091  0394 264a          	jrne	L523
1092                     ; 152         tempcalibfactor = powerCalibrationFactor3 / 100.00;
1094  0396 b600          	ld	a,_powerCalibrationFactor3
1095  0398 5f            	clrw	x
1096  0399 97            	ld	xl,a
1097  039a cd0000        	call	c_itof
1099  039d ae000c        	ldw	x,#L14
1100  03a0 cd0000        	call	c_fdiv
1102  03a3 96            	ldw	x,sp
1103  03a4 1c0005        	addw	x,#OFST-3
1104  03a7 cd0000        	call	c_rtol
1107                     ; 153         Watt_Phase2 = (((float)powerMultiplier / wattPeriod2) * tempcalibfactor) * accuracyFactor;
1109  03aa 96            	ldw	x,sp
1110  03ab 1c000b        	addw	x,#OFST+3
1111  03ae cd0000        	call	c_ltor
1113  03b1 cd0000        	call	c_ultof
1115  03b4 96            	ldw	x,sp
1116  03b5 1c0001        	addw	x,#OFST-7
1117  03b8 cd0000        	call	c_rtol
1120  03bb ae0000        	ldw	x,#L572
1121  03be cd0000        	call	c_ltor
1123  03c1 96            	ldw	x,sp
1124  03c2 1c0001        	addw	x,#OFST-7
1125  03c5 cd0000        	call	c_fdiv
1127  03c8 96            	ldw	x,sp
1128  03c9 1c0005        	addw	x,#OFST-3
1129  03cc cd0000        	call	c_fmul
1131  03cf ae000c        	ldw	x,#L14
1132  03d2 cd0000        	call	c_fmul
1134  03d5 cd0000        	call	c_ftol
1136  03d8 ae001c        	ldw	x,#_Watt_Phase2
1137  03db cd0000        	call	c_rtol
1140  03de 202d          	jra	L723
1141  03e0               L523:
1142                     ; 157         Watt_Phase2 = (((float)powerMultiplier / wattPeriod2) * 1) * accuracyFactor;
1144  03e0 96            	ldw	x,sp
1145  03e1 1c000b        	addw	x,#OFST+3
1146  03e4 cd0000        	call	c_ltor
1148  03e7 cd0000        	call	c_ultof
1150  03ea 96            	ldw	x,sp
1151  03eb 1c0001        	addw	x,#OFST-7
1152  03ee cd0000        	call	c_rtol
1155  03f1 ae0000        	ldw	x,#L572
1156  03f4 cd0000        	call	c_ltor
1158  03f7 96            	ldw	x,sp
1159  03f8 1c0001        	addw	x,#OFST-7
1160  03fb cd0000        	call	c_fdiv
1162  03fe ae000c        	ldw	x,#L14
1163  0401 cd0000        	call	c_fmul
1165  0404 cd0000        	call	c_ftol
1167  0407 ae001c        	ldw	x,#_Watt_Phase2
1168  040a cd0000        	call	c_rtol
1170  040d               L723:
1171                     ; 159 }
1174  040d 5b08          	addw	sp,#8
1175  040f 81            	ret
1221                     ; 161 void calcWatt3(uint32_t wattPeriod3)
1221                     ; 162 {
1222                     	switch	.text
1223  0410               _calcWatt3:
1225  0410 5208          	subw	sp,#8
1226       00000008      OFST:	set	8
1229                     ; 164     if (checkByte == 'A')
1231  0412 b600          	ld	a,_checkByte
1232  0414 a141          	cp	a,#65
1233  0416 264a          	jrne	L353
1234                     ; 166         tempcalibfactor = powerCalibrationFactor3 / 100.00;
1236  0418 b600          	ld	a,_powerCalibrationFactor3
1237  041a 5f            	clrw	x
1238  041b 97            	ld	xl,a
1239  041c cd0000        	call	c_itof
1241  041f ae000c        	ldw	x,#L14
1242  0422 cd0000        	call	c_fdiv
1244  0425 96            	ldw	x,sp
1245  0426 1c0005        	addw	x,#OFST-3
1246  0429 cd0000        	call	c_rtol
1249                     ; 167         Watt_Phase3 = (((float)powerMultiplier / wattPeriod3) * tempcalibfactor) * accuracyFactor;
1251  042c 96            	ldw	x,sp
1252  042d 1c000b        	addw	x,#OFST+3
1253  0430 cd0000        	call	c_ltor
1255  0433 cd0000        	call	c_ultof
1257  0436 96            	ldw	x,sp
1258  0437 1c0001        	addw	x,#OFST-7
1259  043a cd0000        	call	c_rtol
1262  043d ae0000        	ldw	x,#L572
1263  0440 cd0000        	call	c_ltor
1265  0443 96            	ldw	x,sp
1266  0444 1c0001        	addw	x,#OFST-7
1267  0447 cd0000        	call	c_fdiv
1269  044a 96            	ldw	x,sp
1270  044b 1c0005        	addw	x,#OFST-3
1271  044e cd0000        	call	c_fmul
1273  0451 ae000c        	ldw	x,#L14
1274  0454 cd0000        	call	c_fmul
1276  0457 cd0000        	call	c_ftol
1278  045a ae0020        	ldw	x,#_Watt_Phase3
1279  045d cd0000        	call	c_rtol
1282  0460 202d          	jra	L553
1283  0462               L353:
1284                     ; 171         Watt_Phase3 = (((float)powerMultiplier / wattPeriod3) * 1) * accuracyFactor;
1286  0462 96            	ldw	x,sp
1287  0463 1c000b        	addw	x,#OFST+3
1288  0466 cd0000        	call	c_ltor
1290  0469 cd0000        	call	c_ultof
1292  046c 96            	ldw	x,sp
1293  046d 1c0001        	addw	x,#OFST-7
1294  0470 cd0000        	call	c_rtol
1297  0473 ae0000        	ldw	x,#L572
1298  0476 cd0000        	call	c_ltor
1300  0479 96            	ldw	x,sp
1301  047a 1c0001        	addw	x,#OFST-7
1302  047d cd0000        	call	c_fdiv
1304  0480 ae000c        	ldw	x,#L14
1305  0483 cd0000        	call	c_fmul
1307  0486 cd0000        	call	c_ftol
1309  0489 ae0020        	ldw	x,#_Watt_Phase3
1310  048c cd0000        	call	c_rtol
1312  048f               L553:
1313                     ; 173 }
1316  048f 5b08          	addw	sp,#8
1317  0491 81            	ret
1413                     	xdef	_Watt_Phase3
1414                     	xdef	_Watt_Phase2
1415                     	xdef	_Watt_Phase1
1416                     	xdef	_Ampere_Phase3
1417                     	xdef	_Ampere_Phase2
1418                     	xdef	_Ampere_Phase1
1419                     	xdef	_Voltage_Phase3
1420                     	xdef	_Voltage_Phase2
1421                     	xdef	_Voltage_Phase1
1422                     	xref.b	_checkByte
1423                     	xref.b	_powerCalibrationFactor3
1424                     	xref.b	_currentCalibrationFactor3
1425                     	xref.b	_voltageCalibrationFactor3
1426                     	xref.b	_voltageCalibrationFactor2
1427                     	xref.b	_voltageCalibrationFactor1
1428                     	xdef	_calcWatt3
1429                     	xdef	_calcWatt2
1430                     	xdef	_calcWatt1
1431                     	xdef	_calcAmp3
1432                     	xdef	_calcAmp2
1433                     	xdef	_calcAmp1
1434                     	xdef	_calcVolt3
1435                     	xdef	_calcVolt2
1436                     	xdef	_calcVolt1
1437                     .const:	section	.text
1438  0000               L572:
1439  0000 4c604e99      	dc.w	19552,20121
1440  0004               L361:
1441  0004 47951407      	dc.w	18325,5127
1442  0008               L15:
1443  0008 495a28f2      	dc.w	18778,10482
1444  000c               L14:
1445  000c 42c80000      	dc.w	17096,0
1446                     	xref.b	c_x
1466                     	xref	c_ftol
1467                     	xref	c_fmul
1468                     	xref	c_ultof
1469                     	xref	c_ltor
1470                     	xref	c_rtol
1471                     	xref	c_fdiv
1472                     	xref	c_itof
1473                     	end
