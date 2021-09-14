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
 228  005d ad7c          	call	_calculateTemp1
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
 331  008d cd017e        	call	_calculateTemp2
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
 434  00be cd0221        	call	_calculateFuelLevel
 436                     ; 116 }
 439  00c1 85            	popw	x
 440  00c2 81            	ret
 475                     ; 118 void calculateBatVolt(uint16_t batVolt2)
 475                     ; 119 {
 476                     	switch	.text
 477  00c3               _calculateBatVolt:
 481                     ; 120   batVolt = ((uint32_t)((batVolt2)*ADCvoltmultiplier) * BatVoltDividerFactor)/ADC_RESOLUTION;
 483  00c3 90ae0031      	ldw	y,#49
 484  00c7 cd0000        	call	c_imul
 486  00ca a629          	ld	a,#41
 487  00cc cd0000        	call	c_cmulx
 489  00cf a60a          	ld	a,#10
 490  00d1 cd0000        	call	c_lursh
 492  00d4 ae0000        	ldw	x,#_batVolt
 493  00d7 cd0000        	call	c_rtol
 495                     ; 121 }
 498  00da 81            	ret
 597                     ; 123 void calculateTemp1(uint16_t tempADC1)
 597                     ; 124 {
 598                     	switch	.text
 599  00db               _calculateTemp1:
 601  00db 520c          	subw	sp,#12
 602       0000000c      OFST:	set	12
 605                     ; 133   ntcR = adcSeriesResistor * (((float)adcMaxVal / tempADC1) - 1);
 607  00dd cd0000        	call	c_uitof
 609  00e0 96            	ldw	x,sp
 610  00e1 1c0001        	addw	x,#OFST-11
 611  00e4 cd0000        	call	c_rtol
 614  00e7 ae0018        	ldw	x,#L522
 615  00ea cd0000        	call	c_ltor
 617  00ed 96            	ldw	x,sp
 618  00ee 1c0001        	addw	x,#OFST-11
 619  00f1 cd0000        	call	c_fdiv
 621  00f4 ae0014        	ldw	x,#L532
 622  00f7 cd0000        	call	c_fsub
 624  00fa ae0010        	ldw	x,#L542
 625  00fd cd0000        	call	c_fmul
 627  0100 96            	ldw	x,sp
 628  0101 1c0009        	addw	x,#OFST-3
 629  0104 cd0000        	call	c_rtol
 632                     ; 134   resRatio = ntcR / resistanceRoomTeperature;
 634  0107 96            	ldw	x,sp
 635  0108 1c0009        	addw	x,#OFST-3
 636  010b cd0000        	call	c_ltor
 638  010e ae000c        	ldw	x,#L552
 639  0111 cd0000        	call	c_fdiv
 641  0114 96            	ldw	x,sp
 642  0115 1c0009        	addw	x,#OFST-3
 643  0118 cd0000        	call	c_rtol
 646                     ; 135   logresRatio = log(resRatio);
 648  011b 1e0b          	ldw	x,(OFST-1,sp)
 649  011d 89            	pushw	x
 650  011e 1e0b          	ldw	x,(OFST-1,sp)
 651  0120 89            	pushw	x
 652  0121 cd0000        	call	_log
 654  0124 5b04          	addw	sp,#4
 655  0126 96            	ldw	x,sp
 656  0127 1c0009        	addw	x,#OFST-3
 657  012a cd0000        	call	c_rtol
 660                     ; 136   temp = logresRatio / ntcCoefficient;
 662  012d 96            	ldw	x,sp
 663  012e 1c0009        	addw	x,#OFST-3
 664  0131 cd0000        	call	c_ltor
 666  0134 ae0008        	ldw	x,#L562
 667  0137 cd0000        	call	c_fdiv
 669  013a 96            	ldw	x,sp
 670  013b 1c0009        	addw	x,#OFST-3
 671  013e cd0000        	call	c_rtol
 674                     ; 137   temp1 = 1.0 / RoomTeperature;
 676                     ; 138   temp2 = temp1 + temp;
 678  0141 96            	ldw	x,sp
 679  0142 1c0009        	addw	x,#OFST-3
 680  0145 cd0000        	call	c_ltor
 682  0148 ae0004        	ldw	x,#L572
 683  014b cd0000        	call	c_fadd
 685  014e 96            	ldw	x,sp
 686  014f 1c0009        	addw	x,#OFST-3
 687  0152 cd0000        	call	c_rtol
 690                     ; 139   tKelvin = 1 / temp2;
 692  0155 a601          	ld	a,#1
 693  0157 cd0000        	call	c_ctof
 695  015a 96            	ldw	x,sp
 696  015b 1c0009        	addw	x,#OFST-3
 697  015e cd0000        	call	c_fdiv
 699  0161 96            	ldw	x,sp
 700  0162 1c0009        	addw	x,#OFST-3
 701  0165 cd0000        	call	c_rtol
 704                     ; 140   Temperature1 = tKelvin - 273.15;
 706  0168 96            	ldw	x,sp
 707  0169 1c0009        	addw	x,#OFST-3
 708  016c cd0000        	call	c_ltor
 710  016f ae0000        	ldw	x,#L503
 711  0172 cd0000        	call	c_fsub
 713  0175 ae0000        	ldw	x,#_Temperature1
 714  0178 cd0000        	call	c_rtol
 716                     ; 141 }
 719  017b 5b0c          	addw	sp,#12
 720  017d 81            	ret
 819                     ; 143 void calculateTemp2(uint16_t tempADC2)
 819                     ; 144 {
 820                     	switch	.text
 821  017e               _calculateTemp2:
 823  017e 520c          	subw	sp,#12
 824       0000000c      OFST:	set	12
 827                     ; 155   ntcR = adcSeriesResistor * (((float)adcMaxVal / tempADC2) - 1);
 829  0180 cd0000        	call	c_uitof
 831  0183 96            	ldw	x,sp
 832  0184 1c0001        	addw	x,#OFST-11
 833  0187 cd0000        	call	c_rtol
 836  018a ae0018        	ldw	x,#L522
 837  018d cd0000        	call	c_ltor
 839  0190 96            	ldw	x,sp
 840  0191 1c0001        	addw	x,#OFST-11
 841  0194 cd0000        	call	c_fdiv
 843  0197 ae0014        	ldw	x,#L532
 844  019a cd0000        	call	c_fsub
 846  019d ae0010        	ldw	x,#L542
 847  01a0 cd0000        	call	c_fmul
 849  01a3 96            	ldw	x,sp
 850  01a4 1c0009        	addw	x,#OFST-3
 851  01a7 cd0000        	call	c_rtol
 854                     ; 156   resRatio = ntcR / resistanceRoomTeperature;
 856  01aa 96            	ldw	x,sp
 857  01ab 1c0009        	addw	x,#OFST-3
 858  01ae cd0000        	call	c_ltor
 860  01b1 ae000c        	ldw	x,#L552
 861  01b4 cd0000        	call	c_fdiv
 863  01b7 96            	ldw	x,sp
 864  01b8 1c0009        	addw	x,#OFST-3
 865  01bb cd0000        	call	c_rtol
 868                     ; 157   logresRatio = log(resRatio);
 870  01be 1e0b          	ldw	x,(OFST-1,sp)
 871  01c0 89            	pushw	x
 872  01c1 1e0b          	ldw	x,(OFST-1,sp)
 873  01c3 89            	pushw	x
 874  01c4 cd0000        	call	_log
 876  01c7 5b04          	addw	sp,#4
 877  01c9 96            	ldw	x,sp
 878  01ca 1c0009        	addw	x,#OFST-3
 879  01cd cd0000        	call	c_rtol
 882                     ; 158   temp = logresRatio / ntcCoefficient;
 884  01d0 96            	ldw	x,sp
 885  01d1 1c0009        	addw	x,#OFST-3
 886  01d4 cd0000        	call	c_ltor
 888  01d7 ae0008        	ldw	x,#L562
 889  01da cd0000        	call	c_fdiv
 891  01dd 96            	ldw	x,sp
 892  01de 1c0009        	addw	x,#OFST-3
 893  01e1 cd0000        	call	c_rtol
 896                     ; 159   temp1 = 1.0 / RoomTeperature;
 898                     ; 160   temp2 = temp1 + temp;
 900  01e4 96            	ldw	x,sp
 901  01e5 1c0009        	addw	x,#OFST-3
 902  01e8 cd0000        	call	c_ltor
 904  01eb ae0004        	ldw	x,#L572
 905  01ee cd0000        	call	c_fadd
 907  01f1 96            	ldw	x,sp
 908  01f2 1c0009        	addw	x,#OFST-3
 909  01f5 cd0000        	call	c_rtol
 912                     ; 161   tKelvin = 1 / temp2;
 914  01f8 a601          	ld	a,#1
 915  01fa cd0000        	call	c_ctof
 917  01fd 96            	ldw	x,sp
 918  01fe 1c0009        	addw	x,#OFST-3
 919  0201 cd0000        	call	c_fdiv
 921  0204 96            	ldw	x,sp
 922  0205 1c0009        	addw	x,#OFST-3
 923  0208 cd0000        	call	c_rtol
 926                     ; 162   Temperature2 = tKelvin - 273.15;
 928  020b 96            	ldw	x,sp
 929  020c 1c0009        	addw	x,#OFST-3
 930  020f cd0000        	call	c_ltor
 932  0212 ae0000        	ldw	x,#L503
 933  0215 cd0000        	call	c_fsub
 935  0218 ae0004        	ldw	x,#_Temperature2
 936  021b cd0000        	call	c_rtol
 938                     ; 163 }
 941  021e 5b0c          	addw	sp,#12
 942  0220 81            	ret
 977                     ; 165 void calculateFuelLevel(uint16_t fuelLevel) // calculate fuel level in cubic feet
 977                     ; 166 {
 978                     	switch	.text
 979  0221               _calculateFuelLevel:
 983                     ; 171     Fuellevel = ((uint32_t)(fuelLevel)/**FuelLevelFactor*/) /** (TankLengthinFoot) * (TankBreadthinFoot)*/; // divide FuelLevelFactor by 100,000
 985  0221 cd0000        	call	c_uitolx
 987  0224 ae0000        	ldw	x,#_Fuellevel
 988  0227 cd0000        	call	c_rtol
 990                     ; 177 }
 993  022a 81            	ret
1044                     	xdef	_getFuelLevel
1045                     	xdef	_gettemp2
1046                     	xdef	_gettemp1
1047                     	xdef	_getbatteryvolt
1048                     	xdef	_Temperature2
1049                     	xdef	_Temperature1
1050                     	switch	.bss
1051  0000               _Fuellevel:
1052  0000 00000000      	ds.b	4
1053                     	xdef	_Fuellevel
1054                     	xdef	_batVolt
1055                     	xdef	_calculateFuelLevel
1056                     	xdef	_calculateTemp2
1057                     	xdef	_calculateTemp1
1058                     	xdef	_calculateBatVolt
1059                     	xref	_log
1060                     	xref	_delay_ms
1061                     	xref	_ADC2_ClearFlag
1062                     	xref	_ADC2_GetFlagStatus
1063                     	xref	_ADC2_GetConversionValue
1064                     	xref	_ADC2_StartConversion
1065                     	xref	_ADC2_ConversionConfig
1066                     	xref	_ADC2_Cmd
1067                     .const:	section	.text
1068  0000               L503:
1069  0000 43889333      	dc.w	17288,-27853
1070  0004               L572:
1071  0004 3b5bcf0e      	dc.w	15195,-12530
1072  0008               L562:
1073  0008 4576e000      	dc.w	17782,-8192
1074  000c               L552:
1075  000c 461c4000      	dc.w	17948,16384
1076  0010               L542:
1077  0010 44fa0000      	dc.w	17658,0
1078  0014               L532:
1079  0014 3f800000      	dc.w	16256,0
1080  0018               L522:
1081  0018 447fc000      	dc.w	17535,-16384
1082                     	xref.b	c_x
1102                     	xref	c_uitolx
1103                     	xref	c_ctof
1104                     	xref	c_fadd
1105                     	xref	c_fmul
1106                     	xref	c_fsub
1107                     	xref	c_fdiv
1108                     	xref	c_uitof
1109                     	xref	c_ltor
1110                     	xref	c_rtol
1111                     	xref	c_lursh
1112                     	xref	c_cmulx
1113                     	xref	c_imul
1114                     	end
