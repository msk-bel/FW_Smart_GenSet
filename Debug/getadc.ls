   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _batVolt:
  16  0000 00000000      	dc.l	0
  17                     	switch	.data
  18  0000               _Temperature1:
  19  0000 00000000      	dc.w	0,0
  20  0004               _Temperature2:
  21  0004 00000000      	dc.w	0,0
  69                     ; 45 void getbatteryvolt(void)
  69                     ; 46 {
  71                     	switch	.text
  72  0000               _getbatteryvolt:
  74  0000 89            	pushw	x
  75       00000002      OFST:	set	2
  78                     ; 48   ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_6, ADC2_ALIGN_RIGHT);
  80  0001 4b08          	push	#8
  81  0003 ae0006        	ldw	x,#6
  82  0006 cd0000        	call	_ADC2_ConversionConfig
  84  0009 84            	pop	a
  85                     ; 49   ADC2_Cmd(ENABLE);
  87  000a a601          	ld	a,#1
  88  000c cd0000        	call	_ADC2_Cmd
  90                     ; 50   delay_ms(20);
  92  000f ae0014        	ldw	x,#20
  93  0012 cd0000        	call	_delay_ms
  95                     ; 51   ADC2_StartConversion();
  97  0015 cd0000        	call	_ADC2_StartConversion
 100  0018               L13:
 101                     ; 53   while (ADC2_GetFlagStatus() == RESET)
 103  0018 cd0000        	call	_ADC2_GetFlagStatus
 105  001b 4d            	tnz	a
 106  001c 27fa          	jreq	L13
 107                     ; 57   batVolt1 = ADC2_GetConversionValue();
 109  001e cd0000        	call	_ADC2_GetConversionValue
 111  0021 1f01          	ldw	(OFST-1,sp),x
 113                     ; 58   ADC2_ClearFlag();
 115  0023 cd0000        	call	_ADC2_ClearFlag
 117                     ; 59   ADC2_Cmd(DISABLE);
 119  0026 4f            	clr	a
 120  0027 cd0000        	call	_ADC2_Cmd
 122                     ; 60   calculateBatVolt(batVolt1);
 124  002a 1e01          	ldw	x,(OFST-1,sp)
 125  002c cd00c3        	call	_calculateBatVolt
 127                     ; 61 }
 130  002f 85            	popw	x
 131  0030 81            	ret
 173                     ; 63 void gettemp1(void)
 173                     ; 64 {
 174                     	switch	.text
 175  0031               _gettemp1:
 177  0031 89            	pushw	x
 178       00000002      OFST:	set	2
 181                     ; 66   ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_2, ADC2_ALIGN_RIGHT);
 183  0032 4b08          	push	#8
 184  0034 ae0002        	ldw	x,#2
 185  0037 cd0000        	call	_ADC2_ConversionConfig
 187  003a 84            	pop	a
 188                     ; 67   ADC2_Cmd(ENABLE);
 190  003b a601          	ld	a,#1
 191  003d cd0000        	call	_ADC2_Cmd
 193                     ; 68   delay_ms(20);
 195  0040 ae0014        	ldw	x,#20
 196  0043 cd0000        	call	_delay_ms
 198                     ; 69   ADC2_StartConversion();
 200  0046 cd0000        	call	_ADC2_StartConversion
 203  0049               L55:
 204                     ; 71   while (ADC2_GetFlagStatus() == RESET)
 206  0049 cd0000        	call	_ADC2_GetFlagStatus
 208  004c 4d            	tnz	a
 209  004d 27fa          	jreq	L55
 210                     ; 75   tempADC = ADC2_GetConversionValue();
 212  004f cd0000        	call	_ADC2_GetConversionValue
 214  0052 1f01          	ldw	(OFST-1,sp),x
 216                     ; 76   ADC2_ClearFlag();
 218  0054 cd0000        	call	_ADC2_ClearFlag
 220                     ; 77   ADC2_Cmd(DISABLE);
 222  0057 4f            	clr	a
 223  0058 cd0000        	call	_ADC2_Cmd
 225                     ; 78   calculateTemp1(tempADC);
 227  005b 1e01          	ldw	x,(OFST-1,sp)
 228  005d ad72          	call	_calculateTemp1
 230                     ; 79 }
 233  005f 85            	popw	x
 234  0060 81            	ret
 276                     ; 81 void gettemp2(void)
 276                     ; 82 {
 277                     	switch	.text
 278  0061               _gettemp2:
 280  0061 89            	pushw	x
 281       00000002      OFST:	set	2
 284                     ; 84   ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_1, ADC2_ALIGN_RIGHT);
 286  0062 4b08          	push	#8
 287  0064 ae0001        	ldw	x,#1
 288  0067 cd0000        	call	_ADC2_ConversionConfig
 290  006a 84            	pop	a
 291                     ; 85   ADC2_Cmd(ENABLE);
 293  006b a601          	ld	a,#1
 294  006d cd0000        	call	_ADC2_Cmd
 296                     ; 86   delay_ms(20);
 298  0070 ae0014        	ldw	x,#20
 299  0073 cd0000        	call	_delay_ms
 301                     ; 87   ADC2_StartConversion();
 303  0076 cd0000        	call	_ADC2_StartConversion
 306  0079               L101:
 307                     ; 89   while (ADC2_GetFlagStatus() == RESET)
 309  0079 cd0000        	call	_ADC2_GetFlagStatus
 311  007c 4d            	tnz	a
 312  007d 27fa          	jreq	L101
 313                     ; 93   tempADC = ADC2_GetConversionValue();
 315  007f cd0000        	call	_ADC2_GetConversionValue
 317  0082 1f01          	ldw	(OFST-1,sp),x
 319                     ; 94   ADC2_ClearFlag();
 321  0084 cd0000        	call	_ADC2_ClearFlag
 323                     ; 95   ADC2_Cmd(DISABLE);
 325  0087 4f            	clr	a
 326  0088 cd0000        	call	_ADC2_Cmd
 328                     ; 96   calculateTemp2(tempADC);
 330  008b 1e01          	ldw	x,(OFST-1,sp)
 331  008d cd0174        	call	_calculateTemp2
 333                     ; 97 }
 336  0090 85            	popw	x
 337  0091 81            	ret
 379                     ; 99 void getFuelLevel(void)
 379                     ; 100 {
 380                     	switch	.text
 381  0092               _getFuelLevel:
 383  0092 89            	pushw	x
 384       00000002      OFST:	set	2
 387                     ; 102   ADC2_ConversionConfig(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_7, ADC2_ALIGN_RIGHT);
 389  0093 4b08          	push	#8
 390  0095 ae0007        	ldw	x,#7
 391  0098 cd0000        	call	_ADC2_ConversionConfig
 393  009b 84            	pop	a
 394                     ; 103   ADC2_Cmd(ENABLE);
 396  009c a601          	ld	a,#1
 397  009e cd0000        	call	_ADC2_Cmd
 399                     ; 104   delay_ms(20);
 401  00a1 ae0014        	ldw	x,#20
 402  00a4 cd0000        	call	_delay_ms
 404                     ; 105   ADC2_StartConversion();
 406  00a7 cd0000        	call	_ADC2_StartConversion
 409  00aa               L521:
 410                     ; 107   while (ADC2_GetFlagStatus() == RESET)
 412  00aa cd0000        	call	_ADC2_GetFlagStatus
 414  00ad 4d            	tnz	a
 415  00ae 27fa          	jreq	L521
 416                     ; 111   tempADC = ADC2_GetConversionValue();
 418  00b0 cd0000        	call	_ADC2_GetConversionValue
 420  00b3 1f01          	ldw	(OFST-1,sp),x
 422                     ; 113   ADC2_ClearFlag();
 424  00b5 cd0000        	call	_ADC2_ClearFlag
 426                     ; 114   ADC2_Cmd(DISABLE);
 428  00b8 4f            	clr	a
 429  00b9 cd0000        	call	_ADC2_Cmd
 431                     ; 115   calculateFuelLevel(tempADC);
 433  00bc 1e01          	ldw	x,(OFST-1,sp)
 434  00be cd0217        	call	_calculateFuelLevel
 436                     ; 116 }
 439  00c1 85            	popw	x
 440  00c2 81            	ret
 475                     ; 118 void calculateBatVolt(uint16_t batVolt2)
 475                     ; 119 {
 476                     	switch	.text
 477  00c3               _calculateBatVolt:
 481                     ; 120   batVolt = ((uint32_t)(batVolt2)*ADCvoltmultiplier) * BatVoltDividerFactor;
 483  00c3 90ae07d9      	ldw	y,#2009
 484  00c7 cd0000        	call	c_umul
 486  00ca ae0000        	ldw	x,#_batVolt
 487  00cd cd0000        	call	c_rtol
 489                     ; 121 }
 492  00d0 81            	ret
 591                     ; 123 void calculateTemp1(uint16_t tempADC1)
 591                     ; 124 {
 592                     	switch	.text
 593  00d1               _calculateTemp1:
 595  00d1 520c          	subw	sp,#12
 596       0000000c      OFST:	set	12
 599                     ; 133   ntcR = adcSeriesResistor * (((float)adcMaxVal / tempADC1) - 1);
 601  00d3 cd0000        	call	c_uitof
 603  00d6 96            	ldw	x,sp
 604  00d7 1c0001        	addw	x,#OFST-11
 605  00da cd0000        	call	c_rtol
 608  00dd ae0018        	ldw	x,#L522
 609  00e0 cd0000        	call	c_ltor
 611  00e3 96            	ldw	x,sp
 612  00e4 1c0001        	addw	x,#OFST-11
 613  00e7 cd0000        	call	c_fdiv
 615  00ea ae0014        	ldw	x,#L532
 616  00ed cd0000        	call	c_fsub
 618  00f0 ae0010        	ldw	x,#L542
 619  00f3 cd0000        	call	c_fmul
 621  00f6 96            	ldw	x,sp
 622  00f7 1c0009        	addw	x,#OFST-3
 623  00fa cd0000        	call	c_rtol
 626                     ; 134   resRatio = ntcR / resistanceRoomTeperature;
 628  00fd 96            	ldw	x,sp
 629  00fe 1c0009        	addw	x,#OFST-3
 630  0101 cd0000        	call	c_ltor
 632  0104 ae000c        	ldw	x,#L552
 633  0107 cd0000        	call	c_fdiv
 635  010a 96            	ldw	x,sp
 636  010b 1c0009        	addw	x,#OFST-3
 637  010e cd0000        	call	c_rtol
 640                     ; 135   logresRatio = log(resRatio);
 642  0111 1e0b          	ldw	x,(OFST-1,sp)
 643  0113 89            	pushw	x
 644  0114 1e0b          	ldw	x,(OFST-1,sp)
 645  0116 89            	pushw	x
 646  0117 cd0000        	call	_log
 648  011a 5b04          	addw	sp,#4
 649  011c 96            	ldw	x,sp
 650  011d 1c0009        	addw	x,#OFST-3
 651  0120 cd0000        	call	c_rtol
 654                     ; 136   temp = logresRatio / ntcCoefficient;
 656  0123 96            	ldw	x,sp
 657  0124 1c0009        	addw	x,#OFST-3
 658  0127 cd0000        	call	c_ltor
 660  012a ae0008        	ldw	x,#L562
 661  012d cd0000        	call	c_fdiv
 663  0130 96            	ldw	x,sp
 664  0131 1c0009        	addw	x,#OFST-3
 665  0134 cd0000        	call	c_rtol
 668                     ; 137   temp1 = 1.0 / RoomTeperature;
 670                     ; 138   temp2 = temp1 + temp;
 672  0137 96            	ldw	x,sp
 673  0138 1c0009        	addw	x,#OFST-3
 674  013b cd0000        	call	c_ltor
 676  013e ae0004        	ldw	x,#L572
 677  0141 cd0000        	call	c_fadd
 679  0144 96            	ldw	x,sp
 680  0145 1c0009        	addw	x,#OFST-3
 681  0148 cd0000        	call	c_rtol
 684                     ; 139   tKelvin = 1 / temp2;
 686  014b a601          	ld	a,#1
 687  014d cd0000        	call	c_ctof
 689  0150 96            	ldw	x,sp
 690  0151 1c0009        	addw	x,#OFST-3
 691  0154 cd0000        	call	c_fdiv
 693  0157 96            	ldw	x,sp
 694  0158 1c0009        	addw	x,#OFST-3
 695  015b cd0000        	call	c_rtol
 698                     ; 140   Temperature1 = tKelvin - 273.15;
 700  015e 96            	ldw	x,sp
 701  015f 1c0009        	addw	x,#OFST-3
 702  0162 cd0000        	call	c_ltor
 704  0165 ae0000        	ldw	x,#L503
 705  0168 cd0000        	call	c_fsub
 707  016b ae0000        	ldw	x,#_Temperature1
 708  016e cd0000        	call	c_rtol
 710                     ; 141 }
 713  0171 5b0c          	addw	sp,#12
 714  0173 81            	ret
 813                     ; 143 void calculateTemp2(uint16_t tempADC2)
 813                     ; 144 {
 814                     	switch	.text
 815  0174               _calculateTemp2:
 817  0174 520c          	subw	sp,#12
 818       0000000c      OFST:	set	12
 821                     ; 155   ntcR = adcSeriesResistor * (((float)adcMaxVal / tempADC2) - 1);
 823  0176 cd0000        	call	c_uitof
 825  0179 96            	ldw	x,sp
 826  017a 1c0001        	addw	x,#OFST-11
 827  017d cd0000        	call	c_rtol
 830  0180 ae0018        	ldw	x,#L522
 831  0183 cd0000        	call	c_ltor
 833  0186 96            	ldw	x,sp
 834  0187 1c0001        	addw	x,#OFST-11
 835  018a cd0000        	call	c_fdiv
 837  018d ae0014        	ldw	x,#L532
 838  0190 cd0000        	call	c_fsub
 840  0193 ae0010        	ldw	x,#L542
 841  0196 cd0000        	call	c_fmul
 843  0199 96            	ldw	x,sp
 844  019a 1c0009        	addw	x,#OFST-3
 845  019d cd0000        	call	c_rtol
 848                     ; 156   resRatio = ntcR / resistanceRoomTeperature;
 850  01a0 96            	ldw	x,sp
 851  01a1 1c0009        	addw	x,#OFST-3
 852  01a4 cd0000        	call	c_ltor
 854  01a7 ae000c        	ldw	x,#L552
 855  01aa cd0000        	call	c_fdiv
 857  01ad 96            	ldw	x,sp
 858  01ae 1c0009        	addw	x,#OFST-3
 859  01b1 cd0000        	call	c_rtol
 862                     ; 157   logresRatio = log(resRatio);
 864  01b4 1e0b          	ldw	x,(OFST-1,sp)
 865  01b6 89            	pushw	x
 866  01b7 1e0b          	ldw	x,(OFST-1,sp)
 867  01b9 89            	pushw	x
 868  01ba cd0000        	call	_log
 870  01bd 5b04          	addw	sp,#4
 871  01bf 96            	ldw	x,sp
 872  01c0 1c0009        	addw	x,#OFST-3
 873  01c3 cd0000        	call	c_rtol
 876                     ; 158   temp = logresRatio / ntcCoefficient;
 878  01c6 96            	ldw	x,sp
 879  01c7 1c0009        	addw	x,#OFST-3
 880  01ca cd0000        	call	c_ltor
 882  01cd ae0008        	ldw	x,#L562
 883  01d0 cd0000        	call	c_fdiv
 885  01d3 96            	ldw	x,sp
 886  01d4 1c0009        	addw	x,#OFST-3
 887  01d7 cd0000        	call	c_rtol
 890                     ; 159   temp1 = 1.0 / RoomTeperature;
 892                     ; 160   temp2 = temp1 + temp;
 894  01da 96            	ldw	x,sp
 895  01db 1c0009        	addw	x,#OFST-3
 896  01de cd0000        	call	c_ltor
 898  01e1 ae0004        	ldw	x,#L572
 899  01e4 cd0000        	call	c_fadd
 901  01e7 96            	ldw	x,sp
 902  01e8 1c0009        	addw	x,#OFST-3
 903  01eb cd0000        	call	c_rtol
 906                     ; 161   tKelvin = 1 / temp2;
 908  01ee a601          	ld	a,#1
 909  01f0 cd0000        	call	c_ctof
 911  01f3 96            	ldw	x,sp
 912  01f4 1c0009        	addw	x,#OFST-3
 913  01f7 cd0000        	call	c_fdiv
 915  01fa 96            	ldw	x,sp
 916  01fb 1c0009        	addw	x,#OFST-3
 917  01fe cd0000        	call	c_rtol
 920                     ; 162   Temperature2 = tKelvin - 273.15;
 922  0201 96            	ldw	x,sp
 923  0202 1c0009        	addw	x,#OFST-3
 924  0205 cd0000        	call	c_ltor
 926  0208 ae0000        	ldw	x,#L503
 927  020b cd0000        	call	c_fsub
 929  020e ae0004        	ldw	x,#_Temperature2
 930  0211 cd0000        	call	c_rtol
 932                     ; 163 }
 935  0214 5b0c          	addw	sp,#12
 936  0216 81            	ret
 971                     ; 165 void calculateFuelLevel(uint16_t fuelLevel) // calculate fuel level in cubic feet
 971                     ; 166 {
 972                     	switch	.text
 973  0217               _calculateFuelLevel:
 975  0217 89            	pushw	x
 976       00000000      OFST:	set	0
 979                     ; 168   if (fuelLevel > 0)
 981  0218 a30000        	cpw	x,#0
 982  021b 2715          	jreq	L104
 983                     ; 170     Fuellevel = ((uint32_t)(fuelLevel)*FuelLevelFactor) * (TankLengthinFoot) * (TankBreadthinFoot); // divide FuelLevelFactor by 100,000
 985  021d a661          	ld	a,#97
 986  021f cd0000        	call	c_cmulx
 988  0222 3803          	sll	c_lreg+3
 989  0224 3902          	rlc	c_lreg+2
 990  0226 3901          	rlc	c_lreg+1
 991  0228 3900          	rlc	c_lreg
 992  022a ae0000        	ldw	x,#_Fuellevel
 993  022d cd0000        	call	c_rtol
 996  0230 2010          	jra	L304
 997  0232               L104:
 998                     ; 172   else if (fuelLevel == 0)
1000  0232 1e01          	ldw	x,(OFST+1,sp)
1001  0234 260c          	jrne	L304
1002                     ; 174     Fuellevel = reserveFuel;
1004  0236 ae0002        	ldw	x,#2
1005  0239 cf0002        	ldw	_Fuellevel+2,x
1006  023c ae0000        	ldw	x,#0
1007  023f cf0000        	ldw	_Fuellevel,x
1008  0242               L304:
1009                     ; 176 }
1012  0242 85            	popw	x
1013  0243 81            	ret
1064                     	xdef	_getFuelLevel
1065                     	xdef	_gettemp2
1066                     	xdef	_gettemp1
1067                     	xdef	_getbatteryvolt
1068                     	xdef	_Temperature2
1069                     	xdef	_Temperature1
1070                     	switch	.bss
1071  0000               _Fuellevel:
1072  0000 00000000      	ds.b	4
1073                     	xdef	_Fuellevel
1074                     	xdef	_batVolt
1075                     	xdef	_calculateFuelLevel
1076                     	xdef	_calculateTemp2
1077                     	xdef	_calculateTemp1
1078                     	xdef	_calculateBatVolt
1079                     	xref	_log
1080                     	xref	_delay_ms
1081                     	xref	_ADC2_ClearFlag
1082                     	xref	_ADC2_GetFlagStatus
1083                     	xref	_ADC2_GetConversionValue
1084                     	xref	_ADC2_StartConversion
1085                     	xref	_ADC2_ConversionConfig
1086                     	xref	_ADC2_Cmd
1087                     .const:	section	.text
1088  0000               L503:
1089  0000 43889333      	dc.w	17288,-27853
1090  0004               L572:
1091  0004 3b5bcf0e      	dc.w	15195,-12530
1092  0008               L562:
1093  0008 4576e000      	dc.w	17782,-8192
1094  000c               L552:
1095  000c 461c4000      	dc.w	17948,16384
1096  0010               L542:
1097  0010 44fa0000      	dc.w	17658,0
1098  0014               L532:
1099  0014 3f800000      	dc.w	16256,0
1100  0018               L522:
1101  0018 447fc000      	dc.w	17535,-16384
1102                     	xref.b	c_lreg
1103                     	xref.b	c_x
1104                     	xref.b	c_y
1124                     	xref	c_cmulx
1125                     	xref	c_ctof
1126                     	xref	c_fadd
1127                     	xref	c_fmul
1128                     	xref	c_fsub
1129                     	xref	c_fdiv
1130                     	xref	c_uitof
1131                     	xref	c_ltor
1132                     	xref	c_rtol
1133                     	xref	c_umul
1134                     	end
