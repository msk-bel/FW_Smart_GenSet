   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  14                     	bsct
  15  0000               _stmDataReceive:
  16  0000 00            	dc.b	0
  17  0001 00            	dc.b	0
  18  0002 00            	dc.b	0
  19  0003 00            	dc.b	0
  20  0004 00            	dc.b	0
  21  0005               _previousTics:
  22  0005 00000000      	dc.l	0
  62                     	switch	.data
  63  0000               _response_buffer:
  64  0000 00            	dc.b	0
  65  0001 000000000000  	ds.b	99
  66                     	bsct
  67  0009               _timeout:
  68  0009 0000          	dc.w	0
  69  000b               _cloud_gps_data_flag:
  70  000b 00            	dc.b	0
  71  000c               _flag2:
  72  000c 00            	dc.b	0
  73  000d               _sms_recev:
  74  000d 00            	dc.b	0
  75  000e               _cloud_connectivity_flag:
  76  000e 00            	dc.b	0
  77  000f               _gprs_post_response_status:
  78  000f 00            	dc.b	0
  79  0010               _gprs_init_flag:
  80  0010 00            	dc.b	0
  81  0011               _noEchoFlag:
  82  0011 00            	dc.b	0
  83                     .bit:	section	.data,bit
  84  0000               _arm_flag:
  85  0000 00            	dc.b	0
  86  0001               _activation_flag:
  87  0001 00            	dc.b	0
  88                     	bsct
  89  0012               _IMEIRecievedOKFlag:
  90  0012 00            	dc.b	0
 122                     ; 52 void systemSetup(void)
 122                     ; 53 {
 124                     	switch	.text
 125  0000               _systemSetup:
 129                     ; 54 	systemInit();
 131  0000 cd0000        	call	_systemInit
 133                     ; 55 	SIMCom_setup();
 135  0003 cd0000        	call	_SIMCom_setup
 137                     ; 58 	clearBuffer();
 139  0006 cd0c79        	call	_clearBuffer
 141                     ; 59 }
 144  0009 81            	ret
 175                     ; 61 void main(void)
 175                     ; 62 {
 176                     	switch	.text
 177  000a               _main:
 181                     ; 63 	systemSetup();
 183  000a adf4          	call	_systemSetup
 185  000c               L15:
 186                     ; 67 		calculateVoltCurrent(maxPeriodWidth);
 188  000c ae0d40        	ldw	x,#3392
 189  000f 89            	pushw	x
 190  0010 ae0003        	ldw	x,#3
 191  0013 89            	pushw	x
 192  0014 cd0000        	call	_calculateVoltCurrent
 194  0017 5b04          	addw	sp,#4
 195                     ; 69 		getbatteryvolt();
 197  0019 cd0000        	call	_getbatteryvolt
 199                     ; 70 		gettemp1();
 201  001c cd0000        	call	_gettemp1
 203                     ; 71 		gettemp2();
 205  001f cd0000        	call	_gettemp2
 207                     ; 72 		getFuelLevel();
 209  0022 cd0000        	call	_getFuelLevel
 211                     ; 73 		sendDataToCloud(); // Uncommented by Saqib
 213  0025 cd0000        	call	_sendDataToCloud
 215                     ; 74 		vHandle_MQTT();	   //Added By Saqib
 217  0028 cd0000        	call	_vHandle_MQTT
 220  002b 20df          	jra	L15
 223                     .const:	section	.text
 224  0000               L55_temp1:
 225  0000 00            	dc.b	0
 226  0001 000000000000  	ds.b	9
 395                     	switch	.const
 396  000a               L611:
 397  000a 00000064      	dc.l	100
 398                     ; 82 void sms_receive(void)
 398                     ; 83 {
 399                     	switch	.text
 400  002d               _sms_receive:
 402  002d 5278          	subw	sp,#120
 403       00000078      OFST:	set	120
 406                     ; 87 	uint8_t temp1[10] = "";
 408  002f 96            	ldw	x,sp
 409  0030 1c0006        	addw	x,#OFST-114
 410  0033 90ae0000      	ldw	y,#L55_temp1
 411  0037 a60a          	ld	a,#10
 412  0039 cd0000        	call	c_xymvx
 414                     ; 94 	uint8_t k = 0;
 416  003c 0f78          	clr	(OFST+0,sp)
 418                     ; 95 	uint8_t l = 0;
 420  003e 0f77          	clr	(OFST-1,sp)
 422                     ; 96 	uint8_t t = 0;
 424                     ; 98 	uint32_t myVar = 0;
 426                     ; 99 	UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 428  0040 4b00          	push	#0
 429  0042 ae0255        	ldw	x,#597
 430  0045 cd0000        	call	_UART1_ITConfig
 432  0048 84            	pop	a
 433                     ; 100 	UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 435  0049 4b00          	push	#0
 436  004b ae0244        	ldw	x,#580
 437  004e cd0000        	call	_UART1_ITConfig
 439  0051 84            	pop	a
 440                     ; 102 	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); //  no echo
 442  0052 4b04          	push	#4
 443  0054 ae022b        	ldw	x,#L541
 444  0057 cd0000        	call	_ms_send_cmd
 446  005a 84            	pop	a
 447                     ; 103 	delay_ms(200);
 449  005b ae00c8        	ldw	x,#200
 450  005e cd0000        	call	_delay_ms
 452                     ; 104 	ms_send_cmd(MSGFT, strlen((const char *)MSGFT));
 454  0061 4b09          	push	#9
 455  0063 ae0221        	ldw	x,#L741
 456  0066 cd0000        	call	_ms_send_cmd
 458  0069 84            	pop	a
 459                     ; 105 	delay_ms(200);
 461  006a ae00c8        	ldw	x,#200
 462  006d cd0000        	call	_delay_ms
 464                     ; 106 	ms_send_cmd(SMSRead, strlen((const char *)SMSRead)); // SMS read
 466  0070 4b09          	push	#9
 467  0072 ae0217        	ldw	x,#L151
 468  0075 cd0000        	call	_ms_send_cmd
 470  0078 84            	pop	a
 471                     ; 108 	for (i = 0; i < 85; i++)
 473  0079 0f05          	clr	(OFST-115,sp)
 475  007b               L361:
 476                     ; 110 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 478  007b ae0020        	ldw	x,#32
 479  007e cd0000        	call	_UART1_GetFlagStatus
 481  0081 4d            	tnz	a
 482  0082 260c          	jrne	L761
 484  0084 be09          	ldw	x,_timeout
 485  0086 1c0001        	addw	x,#1
 486  0089 bf09          	ldw	_timeout,x
 487  008b a32710        	cpw	x,#10000
 488  008e 26eb          	jrne	L361
 489  0090               L761:
 490                     ; 112 		uart_buffer[i] = UART1_ReceiveData8();
 492  0090 96            	ldw	x,sp
 493  0091 1c0022        	addw	x,#OFST-86
 494  0094 9f            	ld	a,xl
 495  0095 5e            	swapw	x
 496  0096 1b05          	add	a,(OFST-115,sp)
 497  0098 2401          	jrnc	L21
 498  009a 5c            	incw	x
 499  009b               L21:
 500  009b 02            	rlwa	x,a
 501  009c 89            	pushw	x
 502  009d cd0000        	call	_UART1_ReceiveData8
 504  00a0 85            	popw	x
 505  00a1 f7            	ld	(x),a
 506                     ; 113 		timeout = 0;
 508  00a2 5f            	clrw	x
 509  00a3 bf09          	ldw	_timeout,x
 510                     ; 108 	for (i = 0; i < 85; i++)
 512  00a5 0c05          	inc	(OFST-115,sp)
 516  00a7 7b05          	ld	a,(OFST-115,sp)
 517  00a9 a155          	cp	a,#85
 518  00ab 25ce          	jrult	L361
 519                     ; 116 	if (strstr(uart_buffer, "+CMGR"))
 521  00ad ae0211        	ldw	x,#L371
 522  00b0 89            	pushw	x
 523  00b1 96            	ldw	x,sp
 524  00b2 1c0024        	addw	x,#OFST-84
 525  00b5 cd0000        	call	_strstr
 527  00b8 5b02          	addw	sp,#2
 528  00ba a30000        	cpw	x,#0
 529  00bd 2756          	jreq	L171
 530                     ; 118 		k = 0;
 532  00bf 0f78          	clr	(OFST+0,sp)
 535  00c1 2002          	jra	L102
 536  00c3               L571:
 537                     ; 121 			k++;
 539  00c3 0c78          	inc	(OFST+0,sp)
 541  00c5               L102:
 542                     ; 119 		while (uart_buffer[k] != '+')
 542                     ; 120 		{
 542                     ; 121 			k++;
 544  00c5 96            	ldw	x,sp
 545  00c6 1c0022        	addw	x,#OFST-86
 546  00c9 9f            	ld	a,xl
 547  00ca 5e            	swapw	x
 548  00cb 1b78          	add	a,(OFST+0,sp)
 549  00cd 2401          	jrnc	L41
 550  00cf 5c            	incw	x
 551  00d0               L41:
 552  00d0 02            	rlwa	x,a
 553  00d1 f6            	ld	a,(x)
 554  00d2 a12b          	cp	a,#43
 555  00d4 26ed          	jrne	L571
 556                     ; 123 		k++;
 558  00d6 0c78          	inc	(OFST+0,sp)
 561  00d8 2002          	jra	L702
 562  00da               L502:
 563                     ; 126 			k++;
 565  00da 0c78          	inc	(OFST+0,sp)
 567  00dc               L702:
 568                     ; 124 		while (uart_buffer[k] != '+')
 570  00dc 96            	ldw	x,sp
 571  00dd 1c0022        	addw	x,#OFST-86
 572  00e0 9f            	ld	a,xl
 573  00e1 5e            	swapw	x
 574  00e2 1b78          	add	a,(OFST+0,sp)
 575  00e4 2401          	jrnc	L61
 576  00e6 5c            	incw	x
 577  00e7               L61:
 578  00e7 02            	rlwa	x,a
 579  00e8 f6            	ld	a,(x)
 580  00e9 a12b          	cp	a,#43
 581  00eb 26ed          	jrne	L502
 582                     ; 128 		for (l = 0; l < 13; l++)
 584  00ed 0f77          	clr	(OFST-1,sp)
 586  00ef               L312:
 587                     ; 130 			cell_num[l] = uart_buffer[k];
 589  00ef 96            	ldw	x,sp
 590  00f0 1c0010        	addw	x,#OFST-104
 591  00f3 9f            	ld	a,xl
 592  00f4 5e            	swapw	x
 593  00f5 1b77          	add	a,(OFST-1,sp)
 594  00f7 2401          	jrnc	L02
 595  00f9 5c            	incw	x
 596  00fa               L02:
 597  00fa 02            	rlwa	x,a
 598  00fb 89            	pushw	x
 599  00fc 96            	ldw	x,sp
 600  00fd 1c0024        	addw	x,#OFST-84
 601  0100 9f            	ld	a,xl
 602  0101 5e            	swapw	x
 603  0102 1b7a          	add	a,(OFST+2,sp)
 604  0104 2401          	jrnc	L22
 605  0106 5c            	incw	x
 606  0107               L22:
 607  0107 02            	rlwa	x,a
 608  0108 f6            	ld	a,(x)
 609  0109 85            	popw	x
 610  010a f7            	ld	(x),a
 611                     ; 131 			k++;
 613  010b 0c78          	inc	(OFST+0,sp)
 615                     ; 128 		for (l = 0; l < 13; l++)
 617  010d 0c77          	inc	(OFST-1,sp)
 621  010f 7b77          	ld	a,(OFST-1,sp)
 622  0111 a10d          	cp	a,#13
 623  0113 25da          	jrult	L312
 624  0115               L171:
 625                     ; 134 	cell_num[l] = '\0';
 627  0115 96            	ldw	x,sp
 628  0116 1c0010        	addw	x,#OFST-104
 629  0119 9f            	ld	a,xl
 630  011a 5e            	swapw	x
 631  011b 1b77          	add	a,(OFST-1,sp)
 632  011d 2401          	jrnc	L42
 633  011f 5c            	incw	x
 634  0120               L42:
 635  0120 02            	rlwa	x,a
 636  0121 7f            	clr	(x)
 637                     ; 136 	ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); // Delete SMS
 639  0122 4b0b          	push	#11
 640  0124 ae0205        	ldw	x,#L122
 641  0127 cd0000        	call	_ms_send_cmd
 643  012a 84            	pop	a
 644                     ; 137 	delay_ms(200);
 646  012b ae00c8        	ldw	x,#200
 647  012e cd0000        	call	_delay_ms
 649                     ; 141 	if (strstr(uart_buffer, "CALIBRATE"))
 651  0131 ae01fb        	ldw	x,#L522
 652  0134 89            	pushw	x
 653  0135 96            	ldw	x,sp
 654  0136 1c0024        	addw	x,#OFST-84
 655  0139 cd0000        	call	_strstr
 657  013c 5b02          	addw	sp,#2
 658  013e a30000        	cpw	x,#0
 659  0141 271d          	jreq	L322
 660                     ; 143 		checkByte = 'B';
 662  0143 35420000      	mov	_checkByte,#66
 663                     ; 144 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 665  0147 a6f7          	ld	a,#247
 666  0149 cd0000        	call	_FLASH_Unlock
 668                     ; 146 		FLASH_ProgramByte(CheckByte, 'B'); //Changed by Saqib
 670  014c 4b42          	push	#66
 671  014e ae4009        	ldw	x,#16393
 672  0151 89            	pushw	x
 673  0152 ae0000        	ldw	x,#0
 674  0155 89            	pushw	x
 675  0156 cd0000        	call	_FLASH_ProgramByte
 677  0159 5b05          	addw	sp,#5
 678                     ; 147 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 680  015b a6f7          	ld	a,#247
 681  015d cd0000        	call	_FLASH_Lock
 683  0160               L322:
 684                     ; 150 	if (strstr(uart_buffer, "CALIBRATION DONE"))
 686  0160 ae01ea        	ldw	x,#L132
 687  0163 89            	pushw	x
 688  0164 96            	ldw	x,sp
 689  0165 1c0024        	addw	x,#OFST-84
 690  0168 cd0000        	call	_strstr
 692  016b 5b02          	addw	sp,#2
 693  016d a30000        	cpw	x,#0
 694  0170 271d          	jreq	L722
 695                     ; 152 		checkByte = 'A';
 697  0172 35410000      	mov	_checkByte,#65
 698                     ; 153 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 700  0176 a6f7          	ld	a,#247
 701  0178 cd0000        	call	_FLASH_Unlock
 703                     ; 154 		FLASH_ProgramByte(CheckByte, 'A');
 705  017b 4b41          	push	#65
 706  017d ae4009        	ldw	x,#16393
 707  0180 89            	pushw	x
 708  0181 ae0000        	ldw	x,#0
 709  0184 89            	pushw	x
 710  0185 cd0000        	call	_FLASH_ProgramByte
 712  0188 5b05          	addw	sp,#5
 713                     ; 155 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 715  018a a6f7          	ld	a,#247
 716  018c cd0000        	call	_FLASH_Lock
 718  018f               L722:
 719                     ; 158 	if (strstr(uart_buffer, "V1CalFac = "))
 721  018f ae01de        	ldw	x,#L532
 722  0192 89            	pushw	x
 723  0193 96            	ldw	x,sp
 724  0194 1c0024        	addw	x,#OFST-84
 725  0197 cd0000        	call	_strstr
 727  019a 5b02          	addw	sp,#2
 728  019c a30000        	cpw	x,#0
 729  019f 2768          	jreq	L332
 730                     ; 160 		t = k + 42;
 732  01a1 7b78          	ld	a,(OFST+0,sp)
 733  01a3 ab2a          	add	a,#42
 734  01a5 6b78          	ld	(OFST+0,sp),a
 736                     ; 161 		for (n = 0; n < 4; n++)
 738  01a7 0f77          	clr	(OFST-1,sp)
 740  01a9               L732:
 741                     ; 163 			calibrationFactor[n] = uart_buffer[t];
 743  01a9 96            	ldw	x,sp
 744  01aa 1c001e        	addw	x,#OFST-90
 745  01ad 9f            	ld	a,xl
 746  01ae 5e            	swapw	x
 747  01af 1b77          	add	a,(OFST-1,sp)
 748  01b1 2401          	jrnc	L62
 749  01b3 5c            	incw	x
 750  01b4               L62:
 751  01b4 02            	rlwa	x,a
 752  01b5 89            	pushw	x
 753  01b6 96            	ldw	x,sp
 754  01b7 1c0024        	addw	x,#OFST-84
 755  01ba 9f            	ld	a,xl
 756  01bb 5e            	swapw	x
 757  01bc 1b7a          	add	a,(OFST+2,sp)
 758  01be 2401          	jrnc	L03
 759  01c0 5c            	incw	x
 760  01c1               L03:
 761  01c1 02            	rlwa	x,a
 762  01c2 f6            	ld	a,(x)
 763  01c3 85            	popw	x
 764  01c4 f7            	ld	(x),a
 765                     ; 164 			t++;
 767  01c5 0c78          	inc	(OFST+0,sp)
 769                     ; 161 		for (n = 0; n < 4; n++)
 771  01c7 0c77          	inc	(OFST-1,sp)
 775  01c9 7b77          	ld	a,(OFST-1,sp)
 776  01cb a104          	cp	a,#4
 777  01cd 25da          	jrult	L732
 778                     ; 166 		calibrationFactor[n] = '\0';
 780  01cf 96            	ldw	x,sp
 781  01d0 1c001e        	addw	x,#OFST-90
 782  01d3 9f            	ld	a,xl
 783  01d4 5e            	swapw	x
 784  01d5 1b77          	add	a,(OFST-1,sp)
 785  01d7 2401          	jrnc	L23
 786  01d9 5c            	incw	x
 787  01da               L23:
 788  01da 02            	rlwa	x,a
 789  01db 7f            	clr	(x)
 790                     ; 167 		value = atoi(calibrationFactor);
 792  01dc 96            	ldw	x,sp
 793  01dd 1c001e        	addw	x,#OFST-90
 794  01e0 cd0000        	call	_atoi
 796  01e3 01            	rrwa	x,a
 797  01e4 6b78          	ld	(OFST+0,sp),a
 798  01e6 02            	rlwa	x,a
 800                     ; 168 		voltageCalibrationFactor1 = value; //Added By saqib, earlier not present
 802  01e7 7b78          	ld	a,(OFST+0,sp)
 803  01e9 b700          	ld	_voltageCalibrationFactor1,a
 804                     ; 169 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 806  01eb a6f7          	ld	a,#247
 807  01ed cd0000        	call	_FLASH_Unlock
 809                     ; 170 		FLASH_ProgramByte(V1CabFab, value);
 811  01f0 7b78          	ld	a,(OFST+0,sp)
 812  01f2 88            	push	a
 813  01f3 ae4000        	ldw	x,#16384
 814  01f6 89            	pushw	x
 815  01f7 ae0000        	ldw	x,#0
 816  01fa 89            	pushw	x
 817  01fb cd0000        	call	_FLASH_ProgramByte
 819  01fe 5b05          	addw	sp,#5
 820                     ; 171 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 822  0200 a6f7          	ld	a,#247
 823  0202 cd0000        	call	_FLASH_Lock
 826  0205 acd305d3      	jpf	L542
 827  0209               L332:
 828                     ; 174 	else if (strstr(uart_buffer, "V2CalFac = "))
 830  0209 ae01d2        	ldw	x,#L152
 831  020c 89            	pushw	x
 832  020d 96            	ldw	x,sp
 833  020e 1c0024        	addw	x,#OFST-84
 834  0211 cd0000        	call	_strstr
 836  0214 5b02          	addw	sp,#2
 837  0216 a30000        	cpw	x,#0
 838  0219 2768          	jreq	L742
 839                     ; 176 		t = k + 42;
 841  021b 7b78          	ld	a,(OFST+0,sp)
 842  021d ab2a          	add	a,#42
 843  021f 6b78          	ld	(OFST+0,sp),a
 845                     ; 177 		for (n = 0; n < 4; n++)
 847  0221 0f77          	clr	(OFST-1,sp)
 849  0223               L352:
 850                     ; 179 			calibrationFactor[n] = uart_buffer[t];
 852  0223 96            	ldw	x,sp
 853  0224 1c001e        	addw	x,#OFST-90
 854  0227 9f            	ld	a,xl
 855  0228 5e            	swapw	x
 856  0229 1b77          	add	a,(OFST-1,sp)
 857  022b 2401          	jrnc	L43
 858  022d 5c            	incw	x
 859  022e               L43:
 860  022e 02            	rlwa	x,a
 861  022f 89            	pushw	x
 862  0230 96            	ldw	x,sp
 863  0231 1c0024        	addw	x,#OFST-84
 864  0234 9f            	ld	a,xl
 865  0235 5e            	swapw	x
 866  0236 1b7a          	add	a,(OFST+2,sp)
 867  0238 2401          	jrnc	L63
 868  023a 5c            	incw	x
 869  023b               L63:
 870  023b 02            	rlwa	x,a
 871  023c f6            	ld	a,(x)
 872  023d 85            	popw	x
 873  023e f7            	ld	(x),a
 874                     ; 180 			t++;
 876  023f 0c78          	inc	(OFST+0,sp)
 878                     ; 177 		for (n = 0; n < 4; n++)
 880  0241 0c77          	inc	(OFST-1,sp)
 884  0243 7b77          	ld	a,(OFST-1,sp)
 885  0245 a104          	cp	a,#4
 886  0247 25da          	jrult	L352
 887                     ; 182 		calibrationFactor[n] = '\0';
 889  0249 96            	ldw	x,sp
 890  024a 1c001e        	addw	x,#OFST-90
 891  024d 9f            	ld	a,xl
 892  024e 5e            	swapw	x
 893  024f 1b77          	add	a,(OFST-1,sp)
 894  0251 2401          	jrnc	L04
 895  0253 5c            	incw	x
 896  0254               L04:
 897  0254 02            	rlwa	x,a
 898  0255 7f            	clr	(x)
 899                     ; 183 		value = atoi(calibrationFactor);
 901  0256 96            	ldw	x,sp
 902  0257 1c001e        	addw	x,#OFST-90
 903  025a cd0000        	call	_atoi
 905  025d 01            	rrwa	x,a
 906  025e 6b78          	ld	(OFST+0,sp),a
 907  0260 02            	rlwa	x,a
 909                     ; 184 		voltageCalibrationFactor2 = value; //Added By saqib, earlier not present
 911  0261 7b78          	ld	a,(OFST+0,sp)
 912  0263 b700          	ld	_voltageCalibrationFactor2,a
 913                     ; 185 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 915  0265 a6f7          	ld	a,#247
 916  0267 cd0000        	call	_FLASH_Unlock
 918                     ; 186 		FLASH_ProgramByte(V2CabFab, value);
 920  026a 7b78          	ld	a,(OFST+0,sp)
 921  026c 88            	push	a
 922  026d ae4001        	ldw	x,#16385
 923  0270 89            	pushw	x
 924  0271 ae0000        	ldw	x,#0
 925  0274 89            	pushw	x
 926  0275 cd0000        	call	_FLASH_ProgramByte
 928  0278 5b05          	addw	sp,#5
 929                     ; 187 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 931  027a a6f7          	ld	a,#247
 932  027c cd0000        	call	_FLASH_Lock
 935  027f acd305d3      	jpf	L542
 936  0283               L742:
 937                     ; 190 	else if (strstr(uart_buffer, "V3CalFac = "))
 939  0283 ae01c6        	ldw	x,#L562
 940  0286 89            	pushw	x
 941  0287 96            	ldw	x,sp
 942  0288 1c0024        	addw	x,#OFST-84
 943  028b cd0000        	call	_strstr
 945  028e 5b02          	addw	sp,#2
 946  0290 a30000        	cpw	x,#0
 947  0293 2768          	jreq	L362
 948                     ; 192 		t = k + 42;
 950  0295 7b78          	ld	a,(OFST+0,sp)
 951  0297 ab2a          	add	a,#42
 952  0299 6b78          	ld	(OFST+0,sp),a
 954                     ; 193 		for (n = 0; n < 4; n++)
 956  029b 0f77          	clr	(OFST-1,sp)
 958  029d               L762:
 959                     ; 195 			calibrationFactor[n] = uart_buffer[t];
 961  029d 96            	ldw	x,sp
 962  029e 1c001e        	addw	x,#OFST-90
 963  02a1 9f            	ld	a,xl
 964  02a2 5e            	swapw	x
 965  02a3 1b77          	add	a,(OFST-1,sp)
 966  02a5 2401          	jrnc	L24
 967  02a7 5c            	incw	x
 968  02a8               L24:
 969  02a8 02            	rlwa	x,a
 970  02a9 89            	pushw	x
 971  02aa 96            	ldw	x,sp
 972  02ab 1c0024        	addw	x,#OFST-84
 973  02ae 9f            	ld	a,xl
 974  02af 5e            	swapw	x
 975  02b0 1b7a          	add	a,(OFST+2,sp)
 976  02b2 2401          	jrnc	L44
 977  02b4 5c            	incw	x
 978  02b5               L44:
 979  02b5 02            	rlwa	x,a
 980  02b6 f6            	ld	a,(x)
 981  02b7 85            	popw	x
 982  02b8 f7            	ld	(x),a
 983                     ; 196 			t++;
 985  02b9 0c78          	inc	(OFST+0,sp)
 987                     ; 193 		for (n = 0; n < 4; n++)
 989  02bb 0c77          	inc	(OFST-1,sp)
 993  02bd 7b77          	ld	a,(OFST-1,sp)
 994  02bf a104          	cp	a,#4
 995  02c1 25da          	jrult	L762
 996                     ; 198 		calibrationFactor[n] = '\0';
 998  02c3 96            	ldw	x,sp
 999  02c4 1c001e        	addw	x,#OFST-90
1000  02c7 9f            	ld	a,xl
1001  02c8 5e            	swapw	x
1002  02c9 1b77          	add	a,(OFST-1,sp)
1003  02cb 2401          	jrnc	L64
1004  02cd 5c            	incw	x
1005  02ce               L64:
1006  02ce 02            	rlwa	x,a
1007  02cf 7f            	clr	(x)
1008                     ; 199 		value = atoi(calibrationFactor);
1010  02d0 96            	ldw	x,sp
1011  02d1 1c001e        	addw	x,#OFST-90
1012  02d4 cd0000        	call	_atoi
1014  02d7 01            	rrwa	x,a
1015  02d8 6b78          	ld	(OFST+0,sp),a
1016  02da 02            	rlwa	x,a
1018                     ; 200 		voltageCalibrationFactor3 = value;
1020  02db 7b78          	ld	a,(OFST+0,sp)
1021  02dd b700          	ld	_voltageCalibrationFactor3,a
1022                     ; 201 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1024  02df a6f7          	ld	a,#247
1025  02e1 cd0000        	call	_FLASH_Unlock
1027                     ; 202 		FLASH_ProgramByte(V3CabFab, value);
1029  02e4 7b78          	ld	a,(OFST+0,sp)
1030  02e6 88            	push	a
1031  02e7 ae4002        	ldw	x,#16386
1032  02ea 89            	pushw	x
1033  02eb ae0000        	ldw	x,#0
1034  02ee 89            	pushw	x
1035  02ef cd0000        	call	_FLASH_ProgramByte
1037  02f2 5b05          	addw	sp,#5
1038                     ; 203 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1040  02f4 a6f7          	ld	a,#247
1041  02f6 cd0000        	call	_FLASH_Lock
1044  02f9 acd305d3      	jpf	L542
1045  02fd               L362:
1046                     ; 206 	else if (strstr(uart_buffer, "I1CalFac = "))
1048  02fd ae01ba        	ldw	x,#L103
1049  0300 89            	pushw	x
1050  0301 96            	ldw	x,sp
1051  0302 1c0024        	addw	x,#OFST-84
1052  0305 cd0000        	call	_strstr
1054  0308 5b02          	addw	sp,#2
1055  030a a30000        	cpw	x,#0
1056  030d 2768          	jreq	L772
1057                     ; 208 		t = k + 42;
1059  030f 7b78          	ld	a,(OFST+0,sp)
1060  0311 ab2a          	add	a,#42
1061  0313 6b78          	ld	(OFST+0,sp),a
1063                     ; 209 		for (n = 0; n < 4; n++)
1065  0315 0f77          	clr	(OFST-1,sp)
1067  0317               L303:
1068                     ; 211 			calibrationFactor[n] = uart_buffer[t];
1070  0317 96            	ldw	x,sp
1071  0318 1c001e        	addw	x,#OFST-90
1072  031b 9f            	ld	a,xl
1073  031c 5e            	swapw	x
1074  031d 1b77          	add	a,(OFST-1,sp)
1075  031f 2401          	jrnc	L05
1076  0321 5c            	incw	x
1077  0322               L05:
1078  0322 02            	rlwa	x,a
1079  0323 89            	pushw	x
1080  0324 96            	ldw	x,sp
1081  0325 1c0024        	addw	x,#OFST-84
1082  0328 9f            	ld	a,xl
1083  0329 5e            	swapw	x
1084  032a 1b7a          	add	a,(OFST+2,sp)
1085  032c 2401          	jrnc	L25
1086  032e 5c            	incw	x
1087  032f               L25:
1088  032f 02            	rlwa	x,a
1089  0330 f6            	ld	a,(x)
1090  0331 85            	popw	x
1091  0332 f7            	ld	(x),a
1092                     ; 212 			t++;
1094  0333 0c78          	inc	(OFST+0,sp)
1096                     ; 209 		for (n = 0; n < 4; n++)
1098  0335 0c77          	inc	(OFST-1,sp)
1102  0337 7b77          	ld	a,(OFST-1,sp)
1103  0339 a104          	cp	a,#4
1104  033b 25da          	jrult	L303
1105                     ; 214 		calibrationFactor[n] = '\0';
1107  033d 96            	ldw	x,sp
1108  033e 1c001e        	addw	x,#OFST-90
1109  0341 9f            	ld	a,xl
1110  0342 5e            	swapw	x
1111  0343 1b77          	add	a,(OFST-1,sp)
1112  0345 2401          	jrnc	L45
1113  0347 5c            	incw	x
1114  0348               L45:
1115  0348 02            	rlwa	x,a
1116  0349 7f            	clr	(x)
1117                     ; 215 		value = atoi(calibrationFactor);
1119  034a 96            	ldw	x,sp
1120  034b 1c001e        	addw	x,#OFST-90
1121  034e cd0000        	call	_atoi
1123  0351 01            	rrwa	x,a
1124  0352 6b78          	ld	(OFST+0,sp),a
1125  0354 02            	rlwa	x,a
1127                     ; 216 		currentCalibrationFactor1 = value; //Added By saqib, earlier not present
1129  0355 7b78          	ld	a,(OFST+0,sp)
1130  0357 b700          	ld	_currentCalibrationFactor1,a
1131                     ; 217 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1133  0359 a6f7          	ld	a,#247
1134  035b cd0000        	call	_FLASH_Unlock
1136                     ; 218 		FLASH_ProgramByte(I1CabFab, value);
1138  035e 7b78          	ld	a,(OFST+0,sp)
1139  0360 88            	push	a
1140  0361 ae4003        	ldw	x,#16387
1141  0364 89            	pushw	x
1142  0365 ae0000        	ldw	x,#0
1143  0368 89            	pushw	x
1144  0369 cd0000        	call	_FLASH_ProgramByte
1146  036c 5b05          	addw	sp,#5
1147                     ; 219 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1149  036e a6f7          	ld	a,#247
1150  0370 cd0000        	call	_FLASH_Lock
1153  0373 acd305d3      	jpf	L542
1154  0377               L772:
1155                     ; 222 	else if (strstr(uart_buffer, "I2CalFac = "))
1157  0377 ae01ae        	ldw	x,#L513
1158  037a 89            	pushw	x
1159  037b 96            	ldw	x,sp
1160  037c 1c0024        	addw	x,#OFST-84
1161  037f cd0000        	call	_strstr
1163  0382 5b02          	addw	sp,#2
1164  0384 a30000        	cpw	x,#0
1165  0387 2768          	jreq	L313
1166                     ; 224 		t = k + 42;
1168  0389 7b78          	ld	a,(OFST+0,sp)
1169  038b ab2a          	add	a,#42
1170  038d 6b78          	ld	(OFST+0,sp),a
1172                     ; 225 		for (n = 0; n < 4; n++)
1174  038f 0f77          	clr	(OFST-1,sp)
1176  0391               L713:
1177                     ; 227 			calibrationFactor[n] = uart_buffer[t];
1179  0391 96            	ldw	x,sp
1180  0392 1c001e        	addw	x,#OFST-90
1181  0395 9f            	ld	a,xl
1182  0396 5e            	swapw	x
1183  0397 1b77          	add	a,(OFST-1,sp)
1184  0399 2401          	jrnc	L65
1185  039b 5c            	incw	x
1186  039c               L65:
1187  039c 02            	rlwa	x,a
1188  039d 89            	pushw	x
1189  039e 96            	ldw	x,sp
1190  039f 1c0024        	addw	x,#OFST-84
1191  03a2 9f            	ld	a,xl
1192  03a3 5e            	swapw	x
1193  03a4 1b7a          	add	a,(OFST+2,sp)
1194  03a6 2401          	jrnc	L06
1195  03a8 5c            	incw	x
1196  03a9               L06:
1197  03a9 02            	rlwa	x,a
1198  03aa f6            	ld	a,(x)
1199  03ab 85            	popw	x
1200  03ac f7            	ld	(x),a
1201                     ; 228 			t++;
1203  03ad 0c78          	inc	(OFST+0,sp)
1205                     ; 225 		for (n = 0; n < 4; n++)
1207  03af 0c77          	inc	(OFST-1,sp)
1211  03b1 7b77          	ld	a,(OFST-1,sp)
1212  03b3 a104          	cp	a,#4
1213  03b5 25da          	jrult	L713
1214                     ; 230 		calibrationFactor[n] = '\0';
1216  03b7 96            	ldw	x,sp
1217  03b8 1c001e        	addw	x,#OFST-90
1218  03bb 9f            	ld	a,xl
1219  03bc 5e            	swapw	x
1220  03bd 1b77          	add	a,(OFST-1,sp)
1221  03bf 2401          	jrnc	L26
1222  03c1 5c            	incw	x
1223  03c2               L26:
1224  03c2 02            	rlwa	x,a
1225  03c3 7f            	clr	(x)
1226                     ; 231 		value = atoi(calibrationFactor);
1228  03c4 96            	ldw	x,sp
1229  03c5 1c001e        	addw	x,#OFST-90
1230  03c8 cd0000        	call	_atoi
1232  03cb 01            	rrwa	x,a
1233  03cc 6b78          	ld	(OFST+0,sp),a
1234  03ce 02            	rlwa	x,a
1236                     ; 232 		currentCalibrationFactor2 = value; //Added By saqib, earlier not present
1238  03cf 7b78          	ld	a,(OFST+0,sp)
1239  03d1 b700          	ld	_currentCalibrationFactor2,a
1240                     ; 233 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1242  03d3 a6f7          	ld	a,#247
1243  03d5 cd0000        	call	_FLASH_Unlock
1245                     ; 234 		FLASH_ProgramByte(I2CabFab, value);
1247  03d8 7b78          	ld	a,(OFST+0,sp)
1248  03da 88            	push	a
1249  03db ae4004        	ldw	x,#16388
1250  03de 89            	pushw	x
1251  03df ae0000        	ldw	x,#0
1252  03e2 89            	pushw	x
1253  03e3 cd0000        	call	_FLASH_ProgramByte
1255  03e6 5b05          	addw	sp,#5
1256                     ; 235 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1258  03e8 a6f7          	ld	a,#247
1259  03ea cd0000        	call	_FLASH_Lock
1262  03ed acd305d3      	jpf	L542
1263  03f1               L313:
1264                     ; 238 	else if (strstr(uart_buffer, "I3CalFac = "))
1266  03f1 ae01a2        	ldw	x,#L133
1267  03f4 89            	pushw	x
1268  03f5 96            	ldw	x,sp
1269  03f6 1c0024        	addw	x,#OFST-84
1270  03f9 cd0000        	call	_strstr
1272  03fc 5b02          	addw	sp,#2
1273  03fe a30000        	cpw	x,#0
1274  0401 2768          	jreq	L723
1275                     ; 240 		t = k + 42;
1277  0403 7b78          	ld	a,(OFST+0,sp)
1278  0405 ab2a          	add	a,#42
1279  0407 6b78          	ld	(OFST+0,sp),a
1281                     ; 241 		for (n = 0; n < 4; n++)
1283  0409 0f77          	clr	(OFST-1,sp)
1285  040b               L333:
1286                     ; 243 			calibrationFactor[n] = uart_buffer[t];
1288  040b 96            	ldw	x,sp
1289  040c 1c001e        	addw	x,#OFST-90
1290  040f 9f            	ld	a,xl
1291  0410 5e            	swapw	x
1292  0411 1b77          	add	a,(OFST-1,sp)
1293  0413 2401          	jrnc	L46
1294  0415 5c            	incw	x
1295  0416               L46:
1296  0416 02            	rlwa	x,a
1297  0417 89            	pushw	x
1298  0418 96            	ldw	x,sp
1299  0419 1c0024        	addw	x,#OFST-84
1300  041c 9f            	ld	a,xl
1301  041d 5e            	swapw	x
1302  041e 1b7a          	add	a,(OFST+2,sp)
1303  0420 2401          	jrnc	L66
1304  0422 5c            	incw	x
1305  0423               L66:
1306  0423 02            	rlwa	x,a
1307  0424 f6            	ld	a,(x)
1308  0425 85            	popw	x
1309  0426 f7            	ld	(x),a
1310                     ; 244 			t++;
1312  0427 0c78          	inc	(OFST+0,sp)
1314                     ; 241 		for (n = 0; n < 4; n++)
1316  0429 0c77          	inc	(OFST-1,sp)
1320  042b 7b77          	ld	a,(OFST-1,sp)
1321  042d a104          	cp	a,#4
1322  042f 25da          	jrult	L333
1323                     ; 246 		calibrationFactor[n] = '\0';
1325  0431 96            	ldw	x,sp
1326  0432 1c001e        	addw	x,#OFST-90
1327  0435 9f            	ld	a,xl
1328  0436 5e            	swapw	x
1329  0437 1b77          	add	a,(OFST-1,sp)
1330  0439 2401          	jrnc	L07
1331  043b 5c            	incw	x
1332  043c               L07:
1333  043c 02            	rlwa	x,a
1334  043d 7f            	clr	(x)
1335                     ; 247 		value = atoi(calibrationFactor);
1337  043e 96            	ldw	x,sp
1338  043f 1c001e        	addw	x,#OFST-90
1339  0442 cd0000        	call	_atoi
1341  0445 01            	rrwa	x,a
1342  0446 6b78          	ld	(OFST+0,sp),a
1343  0448 02            	rlwa	x,a
1345                     ; 248 		currentCalibrationFactor3 = value;
1347  0449 7b78          	ld	a,(OFST+0,sp)
1348  044b b700          	ld	_currentCalibrationFactor3,a
1349                     ; 249 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1351  044d a6f7          	ld	a,#247
1352  044f cd0000        	call	_FLASH_Unlock
1354                     ; 250 		FLASH_ProgramByte(I3CabFab, value);
1356  0452 7b78          	ld	a,(OFST+0,sp)
1357  0454 88            	push	a
1358  0455 ae4005        	ldw	x,#16389
1359  0458 89            	pushw	x
1360  0459 ae0000        	ldw	x,#0
1361  045c 89            	pushw	x
1362  045d cd0000        	call	_FLASH_ProgramByte
1364  0460 5b05          	addw	sp,#5
1365                     ; 251 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1367  0462 a6f7          	ld	a,#247
1368  0464 cd0000        	call	_FLASH_Lock
1371  0467 acd305d3      	jpf	L542
1372  046b               L723:
1373                     ; 254 	else if (strstr(uart_buffer, "P1CalFac = "))
1375  046b ae0196        	ldw	x,#L543
1376  046e 89            	pushw	x
1377  046f 96            	ldw	x,sp
1378  0470 1c0024        	addw	x,#OFST-84
1379  0473 cd0000        	call	_strstr
1381  0476 5b02          	addw	sp,#2
1382  0478 a30000        	cpw	x,#0
1383  047b 2768          	jreq	L343
1384                     ; 256 		t = k + 42;
1386  047d 7b78          	ld	a,(OFST+0,sp)
1387  047f ab2a          	add	a,#42
1388  0481 6b78          	ld	(OFST+0,sp),a
1390                     ; 257 		for (n = 0; n < 4; n++)
1392  0483 0f77          	clr	(OFST-1,sp)
1394  0485               L743:
1395                     ; 259 			calibrationFactor[n] = uart_buffer[t];
1397  0485 96            	ldw	x,sp
1398  0486 1c001e        	addw	x,#OFST-90
1399  0489 9f            	ld	a,xl
1400  048a 5e            	swapw	x
1401  048b 1b77          	add	a,(OFST-1,sp)
1402  048d 2401          	jrnc	L27
1403  048f 5c            	incw	x
1404  0490               L27:
1405  0490 02            	rlwa	x,a
1406  0491 89            	pushw	x
1407  0492 96            	ldw	x,sp
1408  0493 1c0024        	addw	x,#OFST-84
1409  0496 9f            	ld	a,xl
1410  0497 5e            	swapw	x
1411  0498 1b7a          	add	a,(OFST+2,sp)
1412  049a 2401          	jrnc	L47
1413  049c 5c            	incw	x
1414  049d               L47:
1415  049d 02            	rlwa	x,a
1416  049e f6            	ld	a,(x)
1417  049f 85            	popw	x
1418  04a0 f7            	ld	(x),a
1419                     ; 260 			t++;
1421  04a1 0c78          	inc	(OFST+0,sp)
1423                     ; 257 		for (n = 0; n < 4; n++)
1425  04a3 0c77          	inc	(OFST-1,sp)
1429  04a5 7b77          	ld	a,(OFST-1,sp)
1430  04a7 a104          	cp	a,#4
1431  04a9 25da          	jrult	L743
1432                     ; 262 		calibrationFactor[n] = '\0';
1434  04ab 96            	ldw	x,sp
1435  04ac 1c001e        	addw	x,#OFST-90
1436  04af 9f            	ld	a,xl
1437  04b0 5e            	swapw	x
1438  04b1 1b77          	add	a,(OFST-1,sp)
1439  04b3 2401          	jrnc	L67
1440  04b5 5c            	incw	x
1441  04b6               L67:
1442  04b6 02            	rlwa	x,a
1443  04b7 7f            	clr	(x)
1444                     ; 263 		value = atoi(calibrationFactor);
1446  04b8 96            	ldw	x,sp
1447  04b9 1c001e        	addw	x,#OFST-90
1448  04bc cd0000        	call	_atoi
1450  04bf 01            	rrwa	x,a
1451  04c0 6b78          	ld	(OFST+0,sp),a
1452  04c2 02            	rlwa	x,a
1454                     ; 264 		powerCalibrationFactor1 = value; //Added By saqib, earlier not present
1456  04c3 7b78          	ld	a,(OFST+0,sp)
1457  04c5 b700          	ld	_powerCalibrationFactor1,a
1458                     ; 265 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1460  04c7 a6f7          	ld	a,#247
1461  04c9 cd0000        	call	_FLASH_Unlock
1463                     ; 266 		FLASH_ProgramByte(P1CabFab, value);
1465  04cc 7b78          	ld	a,(OFST+0,sp)
1466  04ce 88            	push	a
1467  04cf ae4006        	ldw	x,#16390
1468  04d2 89            	pushw	x
1469  04d3 ae0000        	ldw	x,#0
1470  04d6 89            	pushw	x
1471  04d7 cd0000        	call	_FLASH_ProgramByte
1473  04da 5b05          	addw	sp,#5
1474                     ; 267 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1476  04dc a6f7          	ld	a,#247
1477  04de cd0000        	call	_FLASH_Lock
1480  04e1 acd305d3      	jpf	L542
1481  04e5               L343:
1482                     ; 270 	else if (strstr(uart_buffer, "P2CalFac = "))
1484  04e5 ae018a        	ldw	x,#L163
1485  04e8 89            	pushw	x
1486  04e9 96            	ldw	x,sp
1487  04ea 1c0024        	addw	x,#OFST-84
1488  04ed cd0000        	call	_strstr
1490  04f0 5b02          	addw	sp,#2
1491  04f2 a30000        	cpw	x,#0
1492  04f5 2766          	jreq	L753
1493                     ; 272 		t = k + 42;
1495  04f7 7b78          	ld	a,(OFST+0,sp)
1496  04f9 ab2a          	add	a,#42
1497  04fb 6b78          	ld	(OFST+0,sp),a
1499                     ; 273 		for (n = 0; n < 4; n++)
1501  04fd 0f77          	clr	(OFST-1,sp)
1503  04ff               L363:
1504                     ; 275 			calibrationFactor[n] = uart_buffer[t];
1506  04ff 96            	ldw	x,sp
1507  0500 1c001e        	addw	x,#OFST-90
1508  0503 9f            	ld	a,xl
1509  0504 5e            	swapw	x
1510  0505 1b77          	add	a,(OFST-1,sp)
1511  0507 2401          	jrnc	L001
1512  0509 5c            	incw	x
1513  050a               L001:
1514  050a 02            	rlwa	x,a
1515  050b 89            	pushw	x
1516  050c 96            	ldw	x,sp
1517  050d 1c0024        	addw	x,#OFST-84
1518  0510 9f            	ld	a,xl
1519  0511 5e            	swapw	x
1520  0512 1b7a          	add	a,(OFST+2,sp)
1521  0514 2401          	jrnc	L201
1522  0516 5c            	incw	x
1523  0517               L201:
1524  0517 02            	rlwa	x,a
1525  0518 f6            	ld	a,(x)
1526  0519 85            	popw	x
1527  051a f7            	ld	(x),a
1528                     ; 276 			t++;
1530  051b 0c78          	inc	(OFST+0,sp)
1532                     ; 273 		for (n = 0; n < 4; n++)
1534  051d 0c77          	inc	(OFST-1,sp)
1538  051f 7b77          	ld	a,(OFST-1,sp)
1539  0521 a104          	cp	a,#4
1540  0523 25da          	jrult	L363
1541                     ; 278 		calibrationFactor[n] = '\0';
1543  0525 96            	ldw	x,sp
1544  0526 1c001e        	addw	x,#OFST-90
1545  0529 9f            	ld	a,xl
1546  052a 5e            	swapw	x
1547  052b 1b77          	add	a,(OFST-1,sp)
1548  052d 2401          	jrnc	L401
1549  052f 5c            	incw	x
1550  0530               L401:
1551  0530 02            	rlwa	x,a
1552  0531 7f            	clr	(x)
1553                     ; 279 		value = atoi(calibrationFactor);
1555  0532 96            	ldw	x,sp
1556  0533 1c001e        	addw	x,#OFST-90
1557  0536 cd0000        	call	_atoi
1559  0539 01            	rrwa	x,a
1560  053a 6b78          	ld	(OFST+0,sp),a
1561  053c 02            	rlwa	x,a
1563                     ; 280 		powerCalibrationFactor2 = value; //Added By saqib, earlier not present
1565  053d 7b78          	ld	a,(OFST+0,sp)
1566  053f b700          	ld	_powerCalibrationFactor2,a
1567                     ; 281 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1569  0541 a6f7          	ld	a,#247
1570  0543 cd0000        	call	_FLASH_Unlock
1572                     ; 282 		FLASH_ProgramByte(P2CabFab, value);
1574  0546 7b78          	ld	a,(OFST+0,sp)
1575  0548 88            	push	a
1576  0549 ae4007        	ldw	x,#16391
1577  054c 89            	pushw	x
1578  054d ae0000        	ldw	x,#0
1579  0550 89            	pushw	x
1580  0551 cd0000        	call	_FLASH_ProgramByte
1582  0554 5b05          	addw	sp,#5
1583                     ; 283 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1585  0556 a6f7          	ld	a,#247
1586  0558 cd0000        	call	_FLASH_Lock
1589  055b 2076          	jra	L542
1590  055d               L753:
1591                     ; 286 	else if (strstr(uart_buffer, "P3CalFac = "))
1593  055d ae017e        	ldw	x,#L573
1594  0560 89            	pushw	x
1595  0561 96            	ldw	x,sp
1596  0562 1c0024        	addw	x,#OFST-84
1597  0565 cd0000        	call	_strstr
1599  0568 5b02          	addw	sp,#2
1600  056a a30000        	cpw	x,#0
1601  056d 2764          	jreq	L542
1602                     ; 288 		t = k + 42;
1604  056f 7b78          	ld	a,(OFST+0,sp)
1605  0571 ab2a          	add	a,#42
1606  0573 6b78          	ld	(OFST+0,sp),a
1608                     ; 289 		for (n = 0; n < 4; n++)
1610  0575 0f77          	clr	(OFST-1,sp)
1612  0577               L773:
1613                     ; 291 			calibrationFactor[n] = uart_buffer[t];
1615  0577 96            	ldw	x,sp
1616  0578 1c001e        	addw	x,#OFST-90
1617  057b 9f            	ld	a,xl
1618  057c 5e            	swapw	x
1619  057d 1b77          	add	a,(OFST-1,sp)
1620  057f 2401          	jrnc	L601
1621  0581 5c            	incw	x
1622  0582               L601:
1623  0582 02            	rlwa	x,a
1624  0583 89            	pushw	x
1625  0584 96            	ldw	x,sp
1626  0585 1c0024        	addw	x,#OFST-84
1627  0588 9f            	ld	a,xl
1628  0589 5e            	swapw	x
1629  058a 1b7a          	add	a,(OFST+2,sp)
1630  058c 2401          	jrnc	L011
1631  058e 5c            	incw	x
1632  058f               L011:
1633  058f 02            	rlwa	x,a
1634  0590 f6            	ld	a,(x)
1635  0591 85            	popw	x
1636  0592 f7            	ld	(x),a
1637                     ; 292 			t++;
1639  0593 0c78          	inc	(OFST+0,sp)
1641                     ; 289 		for (n = 0; n < 4; n++)
1643  0595 0c77          	inc	(OFST-1,sp)
1647  0597 7b77          	ld	a,(OFST-1,sp)
1648  0599 a104          	cp	a,#4
1649  059b 25da          	jrult	L773
1650                     ; 294 		calibrationFactor[n] = '\0';
1652  059d 96            	ldw	x,sp
1653  059e 1c001e        	addw	x,#OFST-90
1654  05a1 9f            	ld	a,xl
1655  05a2 5e            	swapw	x
1656  05a3 1b77          	add	a,(OFST-1,sp)
1657  05a5 2401          	jrnc	L211
1658  05a7 5c            	incw	x
1659  05a8               L211:
1660  05a8 02            	rlwa	x,a
1661  05a9 7f            	clr	(x)
1662                     ; 295 		value = atoi(calibrationFactor);
1664  05aa 96            	ldw	x,sp
1665  05ab 1c001e        	addw	x,#OFST-90
1666  05ae cd0000        	call	_atoi
1668  05b1 01            	rrwa	x,a
1669  05b2 6b78          	ld	(OFST+0,sp),a
1670  05b4 02            	rlwa	x,a
1672                     ; 296 		powerCalibrationFactor3 = value;
1674  05b5 7b78          	ld	a,(OFST+0,sp)
1675  05b7 b700          	ld	_powerCalibrationFactor3,a
1676                     ; 297 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1678  05b9 a6f7          	ld	a,#247
1679  05bb cd0000        	call	_FLASH_Unlock
1681                     ; 298 		FLASH_ProgramByte(P3CabFab, value);
1683  05be 7b78          	ld	a,(OFST+0,sp)
1684  05c0 88            	push	a
1685  05c1 ae4008        	ldw	x,#16392
1686  05c4 89            	pushw	x
1687  05c5 ae0000        	ldw	x,#0
1688  05c8 89            	pushw	x
1689  05c9 cd0000        	call	_FLASH_ProgramByte
1691  05cc 5b05          	addw	sp,#5
1692                     ; 299 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1694  05ce a6f7          	ld	a,#247
1695  05d0 cd0000        	call	_FLASH_Lock
1697  05d3               L542:
1698                     ; 302 	if (strstr(uart_buffer, "CURRENT1"))
1700  05d3 ae0175        	ldw	x,#L704
1701  05d6 89            	pushw	x
1702  05d7 96            	ldw	x,sp
1703  05d8 1c0024        	addw	x,#OFST-84
1704  05db cd0000        	call	_strstr
1706  05de 5b02          	addw	sp,#2
1707  05e0 a30000        	cpw	x,#0
1708  05e3 2716          	jreq	L504
1709                     ; 304 		sendSMSCurrent(Ampere_Phase1, cell_num); //Changed by Saqib
1711  05e5 96            	ldw	x,sp
1712  05e6 1c0010        	addw	x,#OFST-104
1713  05e9 89            	pushw	x
1714  05ea ce0002        	ldw	x,_Ampere_Phase1+2
1715  05ed 89            	pushw	x
1716  05ee ce0000        	ldw	x,_Ampere_Phase1
1717  05f1 89            	pushw	x
1718  05f2 cd0c8e        	call	_sendSMSCurrent
1720  05f5 5b06          	addw	sp,#6
1722  05f7 ac0b0a0b      	jpf	L114
1723  05fb               L504:
1724                     ; 306 	else if ((strstr(uart_buffer, "VOLTAGE1")))
1726  05fb ae016c        	ldw	x,#L514
1727  05fe 89            	pushw	x
1728  05ff 96            	ldw	x,sp
1729  0600 1c0024        	addw	x,#OFST-84
1730  0603 cd0000        	call	_strstr
1732  0606 5b02          	addw	sp,#2
1733  0608 a30000        	cpw	x,#0
1734  060b 2716          	jreq	L314
1735                     ; 308 		sendSMSVoltage(Voltage_Phase1, cell_num); //Changed by Saqib
1737  060d 96            	ldw	x,sp
1738  060e 1c0010        	addw	x,#OFST-104
1739  0611 89            	pushw	x
1740  0612 ce0002        	ldw	x,_Voltage_Phase1+2
1741  0615 89            	pushw	x
1742  0616 ce0000        	ldw	x,_Voltage_Phase1
1743  0619 89            	pushw	x
1744  061a cd0d78        	call	_sendSMSVoltage
1746  061d 5b06          	addw	sp,#6
1748  061f ac0b0a0b      	jpf	L114
1749  0623               L314:
1750                     ; 310 	else if ((strstr(uart_buffer, "POWER1")))
1752  0623 ae0165        	ldw	x,#L324
1753  0626 89            	pushw	x
1754  0627 96            	ldw	x,sp
1755  0628 1c0024        	addw	x,#OFST-84
1756  062b cd0000        	call	_strstr
1758  062e 5b02          	addw	sp,#2
1759  0630 a30000        	cpw	x,#0
1760  0633 2716          	jreq	L124
1761                     ; 312 		sendSMSPower(Watt_Phase1, cell_num); //Changed by Saqib
1763  0635 96            	ldw	x,sp
1764  0636 1c0010        	addw	x,#OFST-104
1765  0639 89            	pushw	x
1766  063a ce0002        	ldw	x,_Watt_Phase1+2
1767  063d 89            	pushw	x
1768  063e ce0000        	ldw	x,_Watt_Phase1
1769  0641 89            	pushw	x
1770  0642 cd0e62        	call	_sendSMSPower
1772  0645 5b06          	addw	sp,#6
1774  0647 ac0b0a0b      	jpf	L114
1775  064b               L124:
1776                     ; 314 	else if (strstr(uart_buffer, "CURRENT2"))
1778  064b ae015c        	ldw	x,#L134
1779  064e 89            	pushw	x
1780  064f 96            	ldw	x,sp
1781  0650 1c0024        	addw	x,#OFST-84
1782  0653 cd0000        	call	_strstr
1784  0656 5b02          	addw	sp,#2
1785  0658 a30000        	cpw	x,#0
1786  065b 2716          	jreq	L724
1787                     ; 316 		sendSMSCurrent(Ampere_Phase2, cell_num); //Changed by Saqib
1789  065d 96            	ldw	x,sp
1790  065e 1c0010        	addw	x,#OFST-104
1791  0661 89            	pushw	x
1792  0662 ce0002        	ldw	x,_Ampere_Phase2+2
1793  0665 89            	pushw	x
1794  0666 ce0000        	ldw	x,_Ampere_Phase2
1795  0669 89            	pushw	x
1796  066a cd0c8e        	call	_sendSMSCurrent
1798  066d 5b06          	addw	sp,#6
1800  066f ac0b0a0b      	jpf	L114
1801  0673               L724:
1802                     ; 318 	else if ((strstr(uart_buffer, "VOLTAGE2")))
1804  0673 ae0153        	ldw	x,#L734
1805  0676 89            	pushw	x
1806  0677 96            	ldw	x,sp
1807  0678 1c0024        	addw	x,#OFST-84
1808  067b cd0000        	call	_strstr
1810  067e 5b02          	addw	sp,#2
1811  0680 a30000        	cpw	x,#0
1812  0683 2716          	jreq	L534
1813                     ; 320 		sendSMSVoltage(Voltage_Phase2, cell_num); //Changed by Saqib
1815  0685 96            	ldw	x,sp
1816  0686 1c0010        	addw	x,#OFST-104
1817  0689 89            	pushw	x
1818  068a ce0002        	ldw	x,_Voltage_Phase2+2
1819  068d 89            	pushw	x
1820  068e ce0000        	ldw	x,_Voltage_Phase2
1821  0691 89            	pushw	x
1822  0692 cd0d78        	call	_sendSMSVoltage
1824  0695 5b06          	addw	sp,#6
1826  0697 ac0b0a0b      	jpf	L114
1827  069b               L534:
1828                     ; 322 	else if ((strstr(uart_buffer, "POWER2")))
1830  069b ae014c        	ldw	x,#L544
1831  069e 89            	pushw	x
1832  069f 96            	ldw	x,sp
1833  06a0 1c0024        	addw	x,#OFST-84
1834  06a3 cd0000        	call	_strstr
1836  06a6 5b02          	addw	sp,#2
1837  06a8 a30000        	cpw	x,#0
1838  06ab 2716          	jreq	L344
1839                     ; 324 		sendSMSPower(Watt_Phase2, cell_num); //Changed by Saqib
1841  06ad 96            	ldw	x,sp
1842  06ae 1c0010        	addw	x,#OFST-104
1843  06b1 89            	pushw	x
1844  06b2 ce0002        	ldw	x,_Watt_Phase2+2
1845  06b5 89            	pushw	x
1846  06b6 ce0000        	ldw	x,_Watt_Phase2
1847  06b9 89            	pushw	x
1848  06ba cd0e62        	call	_sendSMSPower
1850  06bd 5b06          	addw	sp,#6
1852  06bf ac0b0a0b      	jpf	L114
1853  06c3               L344:
1854                     ; 326 	else if (strstr(uart_buffer, "CURRENT3"))
1856  06c3 ae0143        	ldw	x,#L354
1857  06c6 89            	pushw	x
1858  06c7 96            	ldw	x,sp
1859  06c8 1c0024        	addw	x,#OFST-84
1860  06cb cd0000        	call	_strstr
1862  06ce 5b02          	addw	sp,#2
1863  06d0 a30000        	cpw	x,#0
1864  06d3 2716          	jreq	L154
1865                     ; 328 		sendSMSCurrent(Ampere_Phase3, cell_num); //Changed by Saqib
1867  06d5 96            	ldw	x,sp
1868  06d6 1c0010        	addw	x,#OFST-104
1869  06d9 89            	pushw	x
1870  06da ce0002        	ldw	x,_Ampere_Phase3+2
1871  06dd 89            	pushw	x
1872  06de ce0000        	ldw	x,_Ampere_Phase3
1873  06e1 89            	pushw	x
1874  06e2 cd0c8e        	call	_sendSMSCurrent
1876  06e5 5b06          	addw	sp,#6
1878  06e7 ac0b0a0b      	jpf	L114
1879  06eb               L154:
1880                     ; 330 	else if ((strstr(uart_buffer, "VOLTAGE3")))
1882  06eb ae013a        	ldw	x,#L164
1883  06ee 89            	pushw	x
1884  06ef 96            	ldw	x,sp
1885  06f0 1c0024        	addw	x,#OFST-84
1886  06f3 cd0000        	call	_strstr
1888  06f6 5b02          	addw	sp,#2
1889  06f8 a30000        	cpw	x,#0
1890  06fb 2716          	jreq	L754
1891                     ; 332 		sendSMSVoltage(Voltage_Phase3, cell_num); //Changed by Saqib
1893  06fd 96            	ldw	x,sp
1894  06fe 1c0010        	addw	x,#OFST-104
1895  0701 89            	pushw	x
1896  0702 ce0002        	ldw	x,_Voltage_Phase3+2
1897  0705 89            	pushw	x
1898  0706 ce0000        	ldw	x,_Voltage_Phase3
1899  0709 89            	pushw	x
1900  070a cd0d78        	call	_sendSMSVoltage
1902  070d 5b06          	addw	sp,#6
1904  070f ac0b0a0b      	jpf	L114
1905  0713               L754:
1906                     ; 334 	else if ((strstr(uart_buffer, "POWER3")))
1908  0713 ae0133        	ldw	x,#L764
1909  0716 89            	pushw	x
1910  0717 96            	ldw	x,sp
1911  0718 1c0024        	addw	x,#OFST-84
1912  071b cd0000        	call	_strstr
1914  071e 5b02          	addw	sp,#2
1915  0720 a30000        	cpw	x,#0
1916  0723 2716          	jreq	L564
1917                     ; 336 		sendSMSPower(Watt_Phase3, cell_num); //Changed by Saqib
1919  0725 96            	ldw	x,sp
1920  0726 1c0010        	addw	x,#OFST-104
1921  0729 89            	pushw	x
1922  072a ce0002        	ldw	x,_Watt_Phase3+2
1923  072d 89            	pushw	x
1924  072e ce0000        	ldw	x,_Watt_Phase3
1925  0731 89            	pushw	x
1926  0732 cd0e62        	call	_sendSMSPower
1928  0735 5b06          	addw	sp,#6
1930  0737 ac0b0a0b      	jpf	L114
1931  073b               L564:
1932                     ; 338 	else if ((strstr(uart_buffer, "RADIATOR-TEMP")))
1934  073b ae0125        	ldw	x,#L574
1935  073e 89            	pushw	x
1936  073f 96            	ldw	x,sp
1937  0740 1c0024        	addw	x,#OFST-84
1938  0743 cd0000        	call	_strstr
1940  0746 5b02          	addw	sp,#2
1941  0748 a30000        	cpw	x,#0
1942  074b 2603          	jrne	L621
1943  074d cc080e        	jp	L374
1944  0750               L621:
1945                     ; 340 		myVar = (uint32_t)(Temperature1 * 100);
1947  0750 ae0000        	ldw	x,#_Temperature1
1948  0753 cd0000        	call	c_ltor
1950  0756 ae0121        	ldw	x,#L305
1951  0759 cd0000        	call	c_fmul
1953  075c cd0000        	call	c_ftol
1955  075f 96            	ldw	x,sp
1956  0760 1c0001        	addw	x,#OFST-119
1957  0763 cd0000        	call	c_rtol
1960                     ; 341 		vClearBuffer(uart_buffer, 85);
1962  0766 4b55          	push	#85
1963  0768 96            	ldw	x,sp
1964  0769 1c0023        	addw	x,#OFST-85
1965  076c cd0000        	call	_vClearBuffer
1967  076f 84            	pop	a
1968                     ; 342 		strcpy(uart_buffer, "Radiator Temperature: ");
1970  0770 96            	ldw	x,sp
1971  0771 1c0022        	addw	x,#OFST-86
1972  0774 90ae010a      	ldw	y,#L705
1973  0778               L411:
1974  0778 90f6          	ld	a,(y)
1975  077a 905c          	incw	y
1976  077c f7            	ld	(x),a
1977  077d 5c            	incw	x
1978  077e 4d            	tnz	a
1979  077f 26f7          	jrne	L411
1980                     ; 343 		sprintf(temp1, "%ld", myVar / 100);
1982  0781 96            	ldw	x,sp
1983  0782 1c0001        	addw	x,#OFST-119
1984  0785 cd0000        	call	c_ltor
1986  0788 ae000a        	ldw	x,#L611
1987  078b cd0000        	call	c_ludv
1989  078e be02          	ldw	x,c_lreg+2
1990  0790 89            	pushw	x
1991  0791 be00          	ldw	x,c_lreg
1992  0793 89            	pushw	x
1993  0794 ae0106        	ldw	x,#L115
1994  0797 89            	pushw	x
1995  0798 96            	ldw	x,sp
1996  0799 1c000c        	addw	x,#OFST-108
1997  079c cd0000        	call	_sprintf
1999  079f 5b06          	addw	sp,#6
2000                     ; 344 		strcat(uart_buffer, temp1);
2002  07a1 96            	ldw	x,sp
2003  07a2 1c0006        	addw	x,#OFST-114
2004  07a5 89            	pushw	x
2005  07a6 96            	ldw	x,sp
2006  07a7 1c0024        	addw	x,#OFST-84
2007  07aa cd0000        	call	_strcat
2009  07ad 85            	popw	x
2010                     ; 345 		strcat(uart_buffer, ".");
2012  07ae ae0104        	ldw	x,#L315
2013  07b1 89            	pushw	x
2014  07b2 96            	ldw	x,sp
2015  07b3 1c0024        	addw	x,#OFST-84
2016  07b6 cd0000        	call	_strcat
2018  07b9 85            	popw	x
2019                     ; 346 		sprintf(temp1, "%ld", myVar % 100);
2021  07ba 96            	ldw	x,sp
2022  07bb 1c0001        	addw	x,#OFST-119
2023  07be cd0000        	call	c_ltor
2025  07c1 ae000a        	ldw	x,#L611
2026  07c4 cd0000        	call	c_lumd
2028  07c7 be02          	ldw	x,c_lreg+2
2029  07c9 89            	pushw	x
2030  07ca be00          	ldw	x,c_lreg
2031  07cc 89            	pushw	x
2032  07cd ae0106        	ldw	x,#L115
2033  07d0 89            	pushw	x
2034  07d1 96            	ldw	x,sp
2035  07d2 1c000c        	addw	x,#OFST-108
2036  07d5 cd0000        	call	_sprintf
2038  07d8 5b06          	addw	sp,#6
2039                     ; 347 		strcat(uart_buffer, temp1);
2041  07da 96            	ldw	x,sp
2042  07db 1c0006        	addw	x,#OFST-114
2043  07de 89            	pushw	x
2044  07df 96            	ldw	x,sp
2045  07e0 1c0024        	addw	x,#OFST-84
2046  07e3 cd0000        	call	_strcat
2048  07e6 85            	popw	x
2049                     ; 348 		strcat(uart_buffer, " C");
2051  07e7 ae0101        	ldw	x,#L515
2052  07ea 89            	pushw	x
2053  07eb 96            	ldw	x,sp
2054  07ec 1c0024        	addw	x,#OFST-84
2055  07ef cd0000        	call	_strcat
2057  07f2 85            	popw	x
2058                     ; 349 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2060  07f3 96            	ldw	x,sp
2061  07f4 1c0010        	addw	x,#OFST-104
2062  07f7 89            	pushw	x
2063  07f8 96            	ldw	x,sp
2064  07f9 1c0024        	addw	x,#OFST-84
2065  07fc cd0000        	call	_strlen
2067  07ff 9f            	ld	a,xl
2068  0800 88            	push	a
2069  0801 96            	ldw	x,sp
2070  0802 1c0025        	addw	x,#OFST-83
2071  0805 cd0a20        	call	_bSendSMS
2073  0808 5b03          	addw	sp,#3
2075  080a ac0b0a0b      	jpf	L114
2076  080e               L374:
2077                     ; 351 	else if ((strstr(uart_buffer, "ENGINE-TEMP")))
2079  080e ae00f5        	ldw	x,#L325
2080  0811 89            	pushw	x
2081  0812 96            	ldw	x,sp
2082  0813 1c0024        	addw	x,#OFST-84
2083  0816 cd0000        	call	_strstr
2085  0819 5b02          	addw	sp,#2
2086  081b a30000        	cpw	x,#0
2087  081e 2603          	jrne	L031
2088  0820 cc08e1        	jp	L125
2089  0823               L031:
2090                     ; 353 		myVar = (uint32_t)(Temperature2 * 100);
2092  0823 ae0000        	ldw	x,#_Temperature2
2093  0826 cd0000        	call	c_ltor
2095  0829 ae0121        	ldw	x,#L305
2096  082c cd0000        	call	c_fmul
2098  082f cd0000        	call	c_ftol
2100  0832 96            	ldw	x,sp
2101  0833 1c0001        	addw	x,#OFST-119
2102  0836 cd0000        	call	c_rtol
2105                     ; 354 		vClearBuffer(uart_buffer, 85);
2107  0839 4b55          	push	#85
2108  083b 96            	ldw	x,sp
2109  083c 1c0023        	addw	x,#OFST-85
2110  083f cd0000        	call	_vClearBuffer
2112  0842 84            	pop	a
2113                     ; 355 		strcpy(uart_buffer, "Engine Temperature: ");
2115  0843 96            	ldw	x,sp
2116  0844 1c0022        	addw	x,#OFST-86
2117  0847 90ae00e0      	ldw	y,#L525
2118  084b               L021:
2119  084b 90f6          	ld	a,(y)
2120  084d 905c          	incw	y
2121  084f f7            	ld	(x),a
2122  0850 5c            	incw	x
2123  0851 4d            	tnz	a
2124  0852 26f7          	jrne	L021
2125                     ; 356 		sprintf(temp1, "%ld", myVar / 100);
2127  0854 96            	ldw	x,sp
2128  0855 1c0001        	addw	x,#OFST-119
2129  0858 cd0000        	call	c_ltor
2131  085b ae000a        	ldw	x,#L611
2132  085e cd0000        	call	c_ludv
2134  0861 be02          	ldw	x,c_lreg+2
2135  0863 89            	pushw	x
2136  0864 be00          	ldw	x,c_lreg
2137  0866 89            	pushw	x
2138  0867 ae0106        	ldw	x,#L115
2139  086a 89            	pushw	x
2140  086b 96            	ldw	x,sp
2141  086c 1c000c        	addw	x,#OFST-108
2142  086f cd0000        	call	_sprintf
2144  0872 5b06          	addw	sp,#6
2145                     ; 357 		strcat(uart_buffer, temp1);
2147  0874 96            	ldw	x,sp
2148  0875 1c0006        	addw	x,#OFST-114
2149  0878 89            	pushw	x
2150  0879 96            	ldw	x,sp
2151  087a 1c0024        	addw	x,#OFST-84
2152  087d cd0000        	call	_strcat
2154  0880 85            	popw	x
2155                     ; 358 		strcat(uart_buffer, ".");
2157  0881 ae0104        	ldw	x,#L315
2158  0884 89            	pushw	x
2159  0885 96            	ldw	x,sp
2160  0886 1c0024        	addw	x,#OFST-84
2161  0889 cd0000        	call	_strcat
2163  088c 85            	popw	x
2164                     ; 359 		sprintf(temp1, "%ld", myVar % 100);
2166  088d 96            	ldw	x,sp
2167  088e 1c0001        	addw	x,#OFST-119
2168  0891 cd0000        	call	c_ltor
2170  0894 ae000a        	ldw	x,#L611
2171  0897 cd0000        	call	c_lumd
2173  089a be02          	ldw	x,c_lreg+2
2174  089c 89            	pushw	x
2175  089d be00          	ldw	x,c_lreg
2176  089f 89            	pushw	x
2177  08a0 ae0106        	ldw	x,#L115
2178  08a3 89            	pushw	x
2179  08a4 96            	ldw	x,sp
2180  08a5 1c000c        	addw	x,#OFST-108
2181  08a8 cd0000        	call	_sprintf
2183  08ab 5b06          	addw	sp,#6
2184                     ; 360 		strcat(uart_buffer, temp1);
2186  08ad 96            	ldw	x,sp
2187  08ae 1c0006        	addw	x,#OFST-114
2188  08b1 89            	pushw	x
2189  08b2 96            	ldw	x,sp
2190  08b3 1c0024        	addw	x,#OFST-84
2191  08b6 cd0000        	call	_strcat
2193  08b9 85            	popw	x
2194                     ; 361 		strcat(uart_buffer, " C");
2196  08ba ae0101        	ldw	x,#L515
2197  08bd 89            	pushw	x
2198  08be 96            	ldw	x,sp
2199  08bf 1c0024        	addw	x,#OFST-84
2200  08c2 cd0000        	call	_strcat
2202  08c5 85            	popw	x
2203                     ; 362 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2205  08c6 96            	ldw	x,sp
2206  08c7 1c0010        	addw	x,#OFST-104
2207  08ca 89            	pushw	x
2208  08cb 96            	ldw	x,sp
2209  08cc 1c0024        	addw	x,#OFST-84
2210  08cf cd0000        	call	_strlen
2212  08d2 9f            	ld	a,xl
2213  08d3 88            	push	a
2214  08d4 96            	ldw	x,sp
2215  08d5 1c0025        	addw	x,#OFST-83
2216  08d8 cd0a20        	call	_bSendSMS
2218  08db 5b03          	addw	sp,#3
2220  08dd ac0b0a0b      	jpf	L114
2221  08e1               L125:
2222                     ; 364 	else if ((strstr(uart_buffer, "BATTERY-VOLT")))
2224  08e1 ae00d3        	ldw	x,#L335
2225  08e4 89            	pushw	x
2226  08e5 96            	ldw	x,sp
2227  08e6 1c0024        	addw	x,#OFST-84
2228  08e9 cd0000        	call	_strstr
2230  08ec 5b02          	addw	sp,#2
2231  08ee a30000        	cpw	x,#0
2232  08f1 2603          	jrne	L231
2233  08f3 cc099a        	jp	L135
2234  08f6               L231:
2235                     ; 367 		vClearBuffer(uart_buffer, 85);
2237  08f6 4b55          	push	#85
2238  08f8 96            	ldw	x,sp
2239  08f9 1c0023        	addw	x,#OFST-85
2240  08fc cd0000        	call	_vClearBuffer
2242  08ff 84            	pop	a
2243                     ; 368 		strcpy(uart_buffer, "Battery: ");
2245  0900 96            	ldw	x,sp
2246  0901 1c0022        	addw	x,#OFST-86
2247  0904 90ae00c9      	ldw	y,#L535
2248  0908               L221:
2249  0908 90f6          	ld	a,(y)
2250  090a 905c          	incw	y
2251  090c f7            	ld	(x),a
2252  090d 5c            	incw	x
2253  090e 4d            	tnz	a
2254  090f 26f7          	jrne	L221
2255                     ; 369 		sprintf(temp1, "%ld", batVolt / 100);
2257  0911 ae0000        	ldw	x,#_batVolt
2258  0914 cd0000        	call	c_ltor
2260  0917 ae000a        	ldw	x,#L611
2261  091a cd0000        	call	c_ludv
2263  091d be02          	ldw	x,c_lreg+2
2264  091f 89            	pushw	x
2265  0920 be00          	ldw	x,c_lreg
2266  0922 89            	pushw	x
2267  0923 ae0106        	ldw	x,#L115
2268  0926 89            	pushw	x
2269  0927 96            	ldw	x,sp
2270  0928 1c000c        	addw	x,#OFST-108
2271  092b cd0000        	call	_sprintf
2273  092e 5b06          	addw	sp,#6
2274                     ; 370 		strcat(uart_buffer, temp1);
2276  0930 96            	ldw	x,sp
2277  0931 1c0006        	addw	x,#OFST-114
2278  0934 89            	pushw	x
2279  0935 96            	ldw	x,sp
2280  0936 1c0024        	addw	x,#OFST-84
2281  0939 cd0000        	call	_strcat
2283  093c 85            	popw	x
2284                     ; 371 		strcat(uart_buffer, ".");
2286  093d ae0104        	ldw	x,#L315
2287  0940 89            	pushw	x
2288  0941 96            	ldw	x,sp
2289  0942 1c0024        	addw	x,#OFST-84
2290  0945 cd0000        	call	_strcat
2292  0948 85            	popw	x
2293                     ; 372 		sprintf(temp1, "%ld", batVolt % 100);
2295  0949 ae0000        	ldw	x,#_batVolt
2296  094c cd0000        	call	c_ltor
2298  094f ae000a        	ldw	x,#L611
2299  0952 cd0000        	call	c_lumd
2301  0955 be02          	ldw	x,c_lreg+2
2302  0957 89            	pushw	x
2303  0958 be00          	ldw	x,c_lreg
2304  095a 89            	pushw	x
2305  095b ae0106        	ldw	x,#L115
2306  095e 89            	pushw	x
2307  095f 96            	ldw	x,sp
2308  0960 1c000c        	addw	x,#OFST-108
2309  0963 cd0000        	call	_sprintf
2311  0966 5b06          	addw	sp,#6
2312                     ; 373 		strcat(uart_buffer, temp1);
2314  0968 96            	ldw	x,sp
2315  0969 1c0006        	addw	x,#OFST-114
2316  096c 89            	pushw	x
2317  096d 96            	ldw	x,sp
2318  096e 1c0024        	addw	x,#OFST-84
2319  0971 cd0000        	call	_strcat
2321  0974 85            	popw	x
2322                     ; 374 		strcat(uart_buffer, " Volts");
2324  0975 ae00c2        	ldw	x,#L735
2325  0978 89            	pushw	x
2326  0979 96            	ldw	x,sp
2327  097a 1c0024        	addw	x,#OFST-84
2328  097d cd0000        	call	_strcat
2330  0980 85            	popw	x
2331                     ; 375 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2333  0981 96            	ldw	x,sp
2334  0982 1c0010        	addw	x,#OFST-104
2335  0985 89            	pushw	x
2336  0986 96            	ldw	x,sp
2337  0987 1c0024        	addw	x,#OFST-84
2338  098a cd0000        	call	_strlen
2340  098d 9f            	ld	a,xl
2341  098e 88            	push	a
2342  098f 96            	ldw	x,sp
2343  0990 1c0025        	addw	x,#OFST-83
2344  0993 cd0a20        	call	_bSendSMS
2346  0996 5b03          	addw	sp,#3
2348  0998 2071          	jra	L114
2349  099a               L135:
2350                     ; 377 	else if ((strstr(uart_buffer, "FUEL-LEVEL")))
2352  099a ae00b7        	ldw	x,#L545
2353  099d 89            	pushw	x
2354  099e 96            	ldw	x,sp
2355  099f 1c0024        	addw	x,#OFST-84
2356  09a2 cd0000        	call	_strstr
2358  09a5 5b02          	addw	sp,#2
2359  09a7 a30000        	cpw	x,#0
2360  09aa 275f          	jreq	L114
2361                     ; 379 		vClearBuffer(uart_buffer, 85);
2363  09ac 4b55          	push	#85
2364  09ae 96            	ldw	x,sp
2365  09af 1c0023        	addw	x,#OFST-85
2366  09b2 cd0000        	call	_vClearBuffer
2368  09b5 84            	pop	a
2369                     ; 380 		strcpy(uart_buffer, "Fuel: ");
2371  09b6 96            	ldw	x,sp
2372  09b7 1c0022        	addw	x,#OFST-86
2373  09ba 90ae00b0      	ldw	y,#L745
2374  09be               L421:
2375  09be 90f6          	ld	a,(y)
2376  09c0 905c          	incw	y
2377  09c2 f7            	ld	(x),a
2378  09c3 5c            	incw	x
2379  09c4 4d            	tnz	a
2380  09c5 26f7          	jrne	L421
2381                     ; 381 		sprintf(temp1, "%ld", Fuellevel);
2383  09c7 ce0002        	ldw	x,_Fuellevel+2
2384  09ca 89            	pushw	x
2385  09cb ce0000        	ldw	x,_Fuellevel
2386  09ce 89            	pushw	x
2387  09cf ae0106        	ldw	x,#L115
2388  09d2 89            	pushw	x
2389  09d3 96            	ldw	x,sp
2390  09d4 1c000c        	addw	x,#OFST-108
2391  09d7 cd0000        	call	_sprintf
2393  09da 5b06          	addw	sp,#6
2394                     ; 382 		strcat(uart_buffer, temp1);
2396  09dc 96            	ldw	x,sp
2397  09dd 1c0006        	addw	x,#OFST-114
2398  09e0 89            	pushw	x
2399  09e1 96            	ldw	x,sp
2400  09e2 1c0024        	addw	x,#OFST-84
2401  09e5 cd0000        	call	_strcat
2403  09e8 85            	popw	x
2404                     ; 383 		strcat(uart_buffer, " Value");
2406  09e9 ae00a9        	ldw	x,#L155
2407  09ec 89            	pushw	x
2408  09ed 96            	ldw	x,sp
2409  09ee 1c0024        	addw	x,#OFST-84
2410  09f1 cd0000        	call	_strcat
2412  09f4 85            	popw	x
2413                     ; 384 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2415  09f5 96            	ldw	x,sp
2416  09f6 1c0010        	addw	x,#OFST-104
2417  09f9 89            	pushw	x
2418  09fa 96            	ldw	x,sp
2419  09fb 1c0024        	addw	x,#OFST-84
2420  09fe cd0000        	call	_strlen
2422  0a01 9f            	ld	a,xl
2423  0a02 88            	push	a
2424  0a03 96            	ldw	x,sp
2425  0a04 1c0025        	addw	x,#OFST-83
2426  0a07 ad17          	call	_bSendSMS
2428  0a09 5b03          	addw	sp,#3
2429  0a0b               L114:
2430                     ; 387 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2432  0a0b 4b01          	push	#1
2433  0a0d ae0255        	ldw	x,#597
2434  0a10 cd0000        	call	_UART1_ITConfig
2436  0a13 84            	pop	a
2437                     ; 388 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2439  0a14 4b01          	push	#1
2440  0a16 ae0244        	ldw	x,#580
2441  0a19 cd0000        	call	_UART1_ITConfig
2443  0a1c 84            	pop	a
2444                     ; 389 }
2447  0a1d 5b78          	addw	sp,#120
2448  0a1f 81            	ret
2451                     	switch	.const
2452  000e               L355_buffer:
2453  000e 41542b434d47  	dc.b	"AT+CMGS=",34
2454  0017 2b3932333331  	dc.b	"+923316821907",34,0
2553                     ; 391 bool bSendSMS(char *message, uint8_t messageLength, char *Number)
2553                     ; 392 {
2554                     	switch	.text
2555  0a20               _bSendSMS:
2557  0a20 89            	pushw	x
2558  0a21 5235          	subw	sp,#53
2559       00000035      OFST:	set	53
2562                     ; 393 	uint8_t buffer[24] = "AT+CMGS=\"+923316821907\"";
2564  0a23 96            	ldw	x,sp
2565  0a24 1c0005        	addw	x,#OFST-48
2566  0a27 90ae000e      	ldw	y,#L355_buffer
2567  0a2b a618          	ld	a,#24
2568  0a2d cd0000        	call	c_xymvx
2570                     ; 396 	uint32_t whileTimeout = 650000;
2572  0a30 aeeb10        	ldw	x,#60176
2573  0a33 1f03          	ldw	(OFST-50,sp),x
2574  0a35 ae0009        	ldw	x,#9
2575  0a38 1f01          	ldw	(OFST-52,sp),x
2577                     ; 397 	delay_ms(2000);
2579  0a3a ae07d0        	ldw	x,#2000
2580  0a3d cd0000        	call	_delay_ms
2582                     ; 398 	for (i = 10; i < 22; i++)
2584  0a40 a60a          	ld	a,#10
2585  0a42 6b35          	ld	(OFST+0,sp),a
2587  0a44               L326:
2588                     ; 400 		buffer[i] = *(Number + (i - 9));
2590  0a44 96            	ldw	x,sp
2591  0a45 1c0005        	addw	x,#OFST-48
2592  0a48 9f            	ld	a,xl
2593  0a49 5e            	swapw	x
2594  0a4a 1b35          	add	a,(OFST+0,sp)
2595  0a4c 2401          	jrnc	L631
2596  0a4e 5c            	incw	x
2597  0a4f               L631:
2598  0a4f 02            	rlwa	x,a
2599  0a50 7b35          	ld	a,(OFST+0,sp)
2600  0a52 905f          	clrw	y
2601  0a54 9097          	ld	yl,a
2602  0a56 72a20009      	subw	y,#9
2603  0a5a 72f93b        	addw	y,(OFST+6,sp)
2604  0a5d 90f6          	ld	a,(y)
2605  0a5f f7            	ld	(x),a
2606                     ; 398 	for (i = 10; i < 22; i++)
2608  0a60 0c35          	inc	(OFST+0,sp)
2612  0a62 7b35          	ld	a,(OFST+0,sp)
2613  0a64 a116          	cp	a,#22
2614  0a66 25dc          	jrult	L326
2615                     ; 402 	i++;
2617  0a68 0c35          	inc	(OFST+0,sp)
2619                     ; 403 	buffer[i] = '\0';
2621  0a6a 96            	ldw	x,sp
2622  0a6b 1c0005        	addw	x,#OFST-48
2623  0a6e 9f            	ld	a,xl
2624  0a6f 5e            	swapw	x
2625  0a70 1b35          	add	a,(OFST+0,sp)
2626  0a72 2401          	jrnc	L041
2627  0a74 5c            	incw	x
2628  0a75               L041:
2629  0a75 02            	rlwa	x,a
2630  0a76 7f            	clr	(x)
2631                     ; 405 	ms_send_cmd(buffer, strlen((const char *)buffer));
2633  0a77 96            	ldw	x,sp
2634  0a78 1c0005        	addw	x,#OFST-48
2635  0a7b cd0000        	call	_strlen
2637  0a7e 9f            	ld	a,xl
2638  0a7f 88            	push	a
2639  0a80 96            	ldw	x,sp
2640  0a81 1c0006        	addw	x,#OFST-47
2641  0a84 cd0000        	call	_ms_send_cmd
2643  0a87 84            	pop	a
2644                     ; 406 	delay_ms(20);
2646  0a88 ae0014        	ldw	x,#20
2647  0a8b cd0000        	call	_delay_ms
2649                     ; 408 	for (i = 0; i < messageLength; i++)
2651  0a8e 0f35          	clr	(OFST+0,sp)
2654  0a90 2016          	jra	L536
2655  0a92               L346:
2656                     ; 410 		while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2658  0a92 ae0040        	ldw	x,#64
2659  0a95 cd0000        	call	_UART1_GetFlagStatus
2661  0a98 4d            	tnz	a
2662  0a99 27f7          	jreq	L346
2663                     ; 412 		UART1_SendData8(*(message + i));
2665  0a9b 7b35          	ld	a,(OFST+0,sp)
2666  0a9d 5f            	clrw	x
2667  0a9e 97            	ld	xl,a
2668  0a9f 72fb36        	addw	x,(OFST+1,sp)
2669  0aa2 f6            	ld	a,(x)
2670  0aa3 cd0000        	call	_UART1_SendData8
2672                     ; 408 	for (i = 0; i < messageLength; i++)
2674  0aa6 0c35          	inc	(OFST+0,sp)
2676  0aa8               L536:
2679  0aa8 7b35          	ld	a,(OFST+0,sp)
2680  0aaa 113a          	cp	a,(OFST+5,sp)
2681  0aac 25e4          	jrult	L346
2682                     ; 414 	delay_ms(10);
2684  0aae ae000a        	ldw	x,#10
2685  0ab1 cd0000        	call	_delay_ms
2688  0ab4               L156:
2689                     ; 415 	while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2691  0ab4 ae0040        	ldw	x,#64
2692  0ab7 cd0000        	call	_UART1_GetFlagStatus
2694  0aba 4d            	tnz	a
2695  0abb 27f7          	jreq	L156
2696                     ; 417 	UART1_SendData8(0x1A);
2698  0abd a61a          	ld	a,#26
2699  0abf cd0000        	call	_UART1_SendData8
2701                     ; 418 	delay_ms(200); // Wait for 2 Seconds to check response of Module if SMS has been send or not
2703  0ac2 ae00c8        	ldw	x,#200
2704  0ac5 cd0000        	call	_delay_ms
2706                     ; 420 	tempBuffer[0] = 0;
2708  0ac8 0f1d          	clr	(OFST-24,sp)
2710                     ; 421 	tempBuffer[1] = 0;
2712  0aca 0f1e          	clr	(OFST-23,sp)
2715  0acc 2021          	jra	L166
2716  0ace               L766:
2717                     ; 424 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
2719  0ace ae0020        	ldw	x,#32
2720  0ad1 cd0000        	call	_UART1_GetFlagStatus
2722  0ad4 4d            	tnz	a
2723  0ad5 260c          	jrne	L376
2725  0ad7 be09          	ldw	x,_timeout
2726  0ad9 1c0001        	addw	x,#1
2727  0adc bf09          	ldw	_timeout,x
2728  0ade a32710        	cpw	x,#10000
2729  0ae1 26eb          	jrne	L766
2730  0ae3               L376:
2731                     ; 426 		tempBuffer[0] = tempBuffer[1];
2733  0ae3 7b1e          	ld	a,(OFST-23,sp)
2734  0ae5 6b1d          	ld	(OFST-24,sp),a
2736                     ; 427 		tempBuffer[1] = UART1_ReceiveData8();
2738  0ae7 cd0000        	call	_UART1_ReceiveData8
2740  0aea 6b1e          	ld	(OFST-23,sp),a
2742                     ; 428 		timeout = 0;
2744  0aec 5f            	clrw	x
2745  0aed bf09          	ldw	_timeout,x
2746  0aef               L166:
2747                     ; 422 	while (tempBuffer[0] != '+' && tempBuffer[1] != 'C' && --whileTimeout > 0)
2749  0aef 7b1d          	ld	a,(OFST-24,sp)
2750  0af1 a12b          	cp	a,#43
2751  0af3 2718          	jreq	L576
2753  0af5 7b1e          	ld	a,(OFST-23,sp)
2754  0af7 a143          	cp	a,#67
2755  0af9 2712          	jreq	L576
2757  0afb 96            	ldw	x,sp
2758  0afc 1c0001        	addw	x,#OFST-52
2759  0aff a601          	ld	a,#1
2760  0b01 cd0000        	call	c_lgsbc
2763  0b04 96            	ldw	x,sp
2764  0b05 1c0001        	addw	x,#OFST-52
2765  0b08 cd0000        	call	c_lzmp
2767  0b0b 26c1          	jrne	L766
2768  0b0d               L576:
2769                     ; 430 	for (i = 2; i < 23; i++)
2771  0b0d a602          	ld	a,#2
2772  0b0f 6b35          	ld	(OFST+0,sp),a
2774  0b11               L117:
2775                     ; 432 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
2777  0b11 ae0020        	ldw	x,#32
2778  0b14 cd0000        	call	_UART1_GetFlagStatus
2780  0b17 4d            	tnz	a
2781  0b18 260c          	jrne	L517
2783  0b1a be09          	ldw	x,_timeout
2784  0b1c 1c0001        	addw	x,#1
2785  0b1f bf09          	ldw	_timeout,x
2786  0b21 a32710        	cpw	x,#10000
2787  0b24 26eb          	jrne	L117
2788  0b26               L517:
2789                     ; 434 		tempBuffer[i] = UART1_ReceiveData8();
2791  0b26 96            	ldw	x,sp
2792  0b27 1c001d        	addw	x,#OFST-24
2793  0b2a 9f            	ld	a,xl
2794  0b2b 5e            	swapw	x
2795  0b2c 1b35          	add	a,(OFST+0,sp)
2796  0b2e 2401          	jrnc	L241
2797  0b30 5c            	incw	x
2798  0b31               L241:
2799  0b31 02            	rlwa	x,a
2800  0b32 89            	pushw	x
2801  0b33 cd0000        	call	_UART1_ReceiveData8
2803  0b36 85            	popw	x
2804  0b37 f7            	ld	(x),a
2805                     ; 435 		timeout = 0;
2807  0b38 5f            	clrw	x
2808  0b39 bf09          	ldw	_timeout,x
2809                     ; 430 	for (i = 2; i < 23; i++)
2811  0b3b 0c35          	inc	(OFST+0,sp)
2815  0b3d 7b35          	ld	a,(OFST+0,sp)
2816  0b3f a117          	cp	a,#23
2817  0b41 25ce          	jrult	L117
2818                     ; 437 	tempBuffer[i] = '\0';
2820  0b43 96            	ldw	x,sp
2821  0b44 1c001d        	addw	x,#OFST-24
2822  0b47 9f            	ld	a,xl
2823  0b48 5e            	swapw	x
2824  0b49 1b35          	add	a,(OFST+0,sp)
2825  0b4b 2401          	jrnc	L441
2826  0b4d 5c            	incw	x
2827  0b4e               L441:
2828  0b4e 02            	rlwa	x,a
2829  0b4f 7f            	clr	(x)
2830                     ; 439 	if (strstr(tempBuffer, "+CMGS"))
2832  0b50 ae00a3        	ldw	x,#L127
2833  0b53 89            	pushw	x
2834  0b54 96            	ldw	x,sp
2835  0b55 1c001f        	addw	x,#OFST-22
2836  0b58 cd0000        	call	_strstr
2838  0b5b 5b02          	addw	sp,#2
2839  0b5d a30000        	cpw	x,#0
2840  0b60 2704          	jreq	L717
2841                     ; 441 		return TRUE;
2843  0b62 a601          	ld	a,#1
2845  0b64 2001          	jra	L641
2846  0b66               L717:
2847                     ; 445 		return FALSE;
2849  0b66 4f            	clr	a
2851  0b67               L641:
2853  0b67 5b37          	addw	sp,#55
2854  0b69 81            	ret
2857                     	switch	.const
2858  0026               L527_STATUS1:
2859  0026 444f574e4c4f  	dc.b	"DOWNLOAD",0
2934                     ; 449 int GSM_DOWNLOAD(void)
2934                     ; 450 {
2935                     	switch	.text
2936  0b6a               _GSM_DOWNLOAD:
2938  0b6a 5217          	subw	sp,#23
2939       00000017      OFST:	set	23
2942                     ; 453 	const char STATUS1[] = "DOWNLOAD";
2944  0b6c 96            	ldw	x,sp
2945  0b6d 1c0001        	addw	x,#OFST-22
2946  0b70 90ae0026      	ldw	y,#L527_STATUS1
2947  0b74 a609          	ld	a,#9
2948  0b76 cd0000        	call	c_xymvx
2950                     ; 455 	uint16_t gsm_download_timeout = 10000;
2952  0b79 ae2710        	ldw	x,#10000
2953  0b7c 1f15          	ldw	(OFST-2,sp),x
2955                     ; 457 	for (r1 = 0; r1 < 11; r1++)
2957  0b7e 0f17          	clr	(OFST+0,sp)
2959  0b80               L577:
2960                     ; 459 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_download_timeout > 0))
2962  0b80 ae0020        	ldw	x,#32
2963  0b83 cd0000        	call	_UART1_GetFlagStatus
2965  0b86 4d            	tnz	a
2966  0b87 2609          	jrne	L1001
2968  0b89 1e15          	ldw	x,(OFST-2,sp)
2969  0b8b 1d0001        	subw	x,#1
2970  0b8e 1f15          	ldw	(OFST-2,sp),x
2972  0b90 26ee          	jrne	L577
2973  0b92               L1001:
2974                     ; 461 		response_buffer[r1] = UART1_ReceiveData8();
2976  0b92 96            	ldw	x,sp
2977  0b93 1c000a        	addw	x,#OFST-13
2978  0b96 9f            	ld	a,xl
2979  0b97 5e            	swapw	x
2980  0b98 1b17          	add	a,(OFST+0,sp)
2981  0b9a 2401          	jrnc	L251
2982  0b9c 5c            	incw	x
2983  0b9d               L251:
2984  0b9d 02            	rlwa	x,a
2985  0b9e 89            	pushw	x
2986  0b9f cd0000        	call	_UART1_ReceiveData8
2988  0ba2 85            	popw	x
2989  0ba3 f7            	ld	(x),a
2990                     ; 457 	for (r1 = 0; r1 < 11; r1++)
2992  0ba4 0c17          	inc	(OFST+0,sp)
2996  0ba6 7b17          	ld	a,(OFST+0,sp)
2997  0ba8 a10b          	cp	a,#11
2998  0baa 25d4          	jrult	L577
2999                     ; 464 	ret3 = strstr(response_buffer, STATUS1);
3001  0bac 96            	ldw	x,sp
3002  0bad 1c0001        	addw	x,#OFST-22
3003  0bb0 89            	pushw	x
3004  0bb1 96            	ldw	x,sp
3005  0bb2 1c000c        	addw	x,#OFST-11
3006  0bb5 cd0000        	call	_strstr
3008  0bb8 5b02          	addw	sp,#2
3009  0bba 1f15          	ldw	(OFST-2,sp),x
3011                     ; 466 	if (ret3)
3013  0bbc 1e15          	ldw	x,(OFST-2,sp)
3014  0bbe 2705          	jreq	L3001
3015                     ; 469 		return 1;
3017  0bc0 ae0001        	ldw	x,#1
3019  0bc3 2001          	jra	L451
3020  0bc5               L3001:
3021                     ; 476 		return 0;
3023  0bc5 5f            	clrw	x
3025  0bc6               L451:
3027  0bc6 5b17          	addw	sp,#23
3028  0bc8 81            	ret
3031                     	switch	.const
3032  002f               L7001_OK:
3033  002f 4f4b00        	dc.b	"OK",0
3098                     ; 480 int GSM_OK_FAST(void)
3098                     ; 481 {
3099                     	switch	.text
3100  0bc9               _GSM_OK_FAST:
3102  0bc9 5206          	subw	sp,#6
3103       00000006      OFST:	set	6
3106                     ; 483 	uint16_t gsm_ok_timeout = 7000;
3108  0bcb ae1b58        	ldw	x,#7000
3109  0bce 1f04          	ldw	(OFST-2,sp),x
3111                     ; 484 	const char OK[3] = "OK";
3113  0bd0 96            	ldw	x,sp
3114  0bd1 1c0001        	addw	x,#OFST-5
3115  0bd4 90ae002f      	ldw	y,#L7001_OK
3116  0bd8 a603          	ld	a,#3
3117  0bda cd0000        	call	c_xymvx
3119                     ; 487 	for (p = 0; p < 30; p++) //8 for error
3121  0bdd 0f06          	clr	(OFST+0,sp)
3123  0bdf               L3501:
3124                     ; 489 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_ok_timeout > 0))
3126  0bdf ae0020        	ldw	x,#32
3127  0be2 cd0000        	call	_UART1_GetFlagStatus
3129  0be5 4d            	tnz	a
3130  0be6 2609          	jrne	L7501
3132  0be8 1e04          	ldw	x,(OFST-2,sp)
3133  0bea 1d0001        	subw	x,#1
3134  0bed 1f04          	ldw	(OFST-2,sp),x
3136  0bef 26ee          	jrne	L3501
3137  0bf1               L7501:
3138                     ; 492 		response_buffer[p] = UART1_ReceiveData8();
3140  0bf1 7b06          	ld	a,(OFST+0,sp)
3141  0bf3 5f            	clrw	x
3142  0bf4 97            	ld	xl,a
3143  0bf5 89            	pushw	x
3144  0bf6 cd0000        	call	_UART1_ReceiveData8
3146  0bf9 85            	popw	x
3147  0bfa d70000        	ld	(_response_buffer,x),a
3148                     ; 487 	for (p = 0; p < 30; p++) //8 for error
3150  0bfd 0c06          	inc	(OFST+0,sp)
3154  0bff 7b06          	ld	a,(OFST+0,sp)
3155  0c01 a11e          	cp	a,#30
3156  0c03 25da          	jrult	L3501
3157                     ; 495 	ret1 = strstr(response_buffer, OK);
3159  0c05 96            	ldw	x,sp
3160  0c06 1c0001        	addw	x,#OFST-5
3161  0c09 89            	pushw	x
3162  0c0a ae0000        	ldw	x,#_response_buffer
3163  0c0d cd0000        	call	_strstr
3165  0c10 5b02          	addw	sp,#2
3166  0c12 1f04          	ldw	(OFST-2,sp),x
3168                     ; 497 	if (ret1)
3170  0c14 1e04          	ldw	x,(OFST-2,sp)
3171  0c16 2705          	jreq	L1601
3172                     ; 499 		return 1;
3174  0c18 ae0001        	ldw	x,#1
3176  0c1b 2001          	jra	L061
3177  0c1d               L1601:
3178                     ; 505 		return 0;
3180  0c1d 5f            	clrw	x
3182  0c1e               L061:
3184  0c1e 5b06          	addw	sp,#6
3185  0c20 81            	ret
3188                     	switch	.const
3189  0032               L5601_OK:
3190  0032 4f4b00        	dc.b	"OK",0
3255                     ; 508 int GSM_OK(void)
3255                     ; 509 {
3256                     	switch	.text
3257  0c21               _GSM_OK:
3259  0c21 5206          	subw	sp,#6
3260       00000006      OFST:	set	6
3263                     ; 511 	uint16_t gsm_ok_timeout = 30000;
3265  0c23 ae7530        	ldw	x,#30000
3266  0c26 1f04          	ldw	(OFST-2,sp),x
3268                     ; 512 	const char OK[3] = "OK";
3270  0c28 96            	ldw	x,sp
3271  0c29 1c0001        	addw	x,#OFST-5
3272  0c2c 90ae0032      	ldw	y,#L5601_OK
3273  0c30 a603          	ld	a,#3
3274  0c32 cd0000        	call	c_xymvx
3276                     ; 515 	for (p = 0; p < 30; p++) //8 for error
3278  0c35 0f06          	clr	(OFST+0,sp)
3280  0c37               L1311:
3281                     ; 517 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_ok_timeout > 0))
3283  0c37 ae0020        	ldw	x,#32
3284  0c3a cd0000        	call	_UART1_GetFlagStatus
3286  0c3d 4d            	tnz	a
3287  0c3e 2609          	jrne	L5311
3289  0c40 1e04          	ldw	x,(OFST-2,sp)
3290  0c42 1d0001        	subw	x,#1
3291  0c45 1f04          	ldw	(OFST-2,sp),x
3293  0c47 26ee          	jrne	L1311
3294  0c49               L5311:
3295                     ; 520 		response_buffer[p] = UART1_ReceiveData8();
3297  0c49 7b06          	ld	a,(OFST+0,sp)
3298  0c4b 5f            	clrw	x
3299  0c4c 97            	ld	xl,a
3300  0c4d 89            	pushw	x
3301  0c4e cd0000        	call	_UART1_ReceiveData8
3303  0c51 85            	popw	x
3304  0c52 d70000        	ld	(_response_buffer,x),a
3305                     ; 515 	for (p = 0; p < 30; p++) //8 for error
3307  0c55 0c06          	inc	(OFST+0,sp)
3311  0c57 7b06          	ld	a,(OFST+0,sp)
3312  0c59 a11e          	cp	a,#30
3313  0c5b 25da          	jrult	L1311
3314                     ; 523 	ret1 = strstr(response_buffer, OK);
3316  0c5d 96            	ldw	x,sp
3317  0c5e 1c0001        	addw	x,#OFST-5
3318  0c61 89            	pushw	x
3319  0c62 ae0000        	ldw	x,#_response_buffer
3320  0c65 cd0000        	call	_strstr
3322  0c68 5b02          	addw	sp,#2
3323  0c6a 1f04          	ldw	(OFST-2,sp),x
3325                     ; 525 	if (ret1)
3327  0c6c 1e04          	ldw	x,(OFST-2,sp)
3328  0c6e 2705          	jreq	L7311
3329                     ; 527 		return 1;
3331  0c70 ae0001        	ldw	x,#1
3333  0c73 2001          	jra	L461
3334  0c75               L7311:
3335                     ; 533 		return 0;
3337  0c75 5f            	clrw	x
3339  0c76               L461:
3341  0c76 5b06          	addw	sp,#6
3342  0c78 81            	ret
3377                     ; 537 void clearBuffer()
3377                     ; 538 {
3378                     	switch	.text
3379  0c79               _clearBuffer:
3381  0c79 88            	push	a
3382       00000001      OFST:	set	1
3385                     ; 540 	for (s = 0; s < 100; s++)
3387  0c7a 0f01          	clr	(OFST+0,sp)
3389  0c7c               L1611:
3390                     ; 543 		response_buffer[s] = '\0';
3392  0c7c 7b01          	ld	a,(OFST+0,sp)
3393  0c7e 5f            	clrw	x
3394  0c7f 97            	ld	xl,a
3395  0c80 724f0000      	clr	(_response_buffer,x)
3396                     ; 540 	for (s = 0; s < 100; s++)
3398  0c84 0c01          	inc	(OFST+0,sp)
3402  0c86 7b01          	ld	a,(OFST+0,sp)
3403  0c88 a164          	cp	a,#100
3404  0c8a 25f0          	jrult	L1611
3405                     ; 546 }
3408  0c8c 84            	pop	a
3409  0c8d 81            	ret
3412                     	switch	.const
3413  0035               L7611_current:
3414  0035 43757272656e  	dc.b	"Current is ",0
3415  0041 000000000000  	ds.b	14
3416  004f               L1711_currentUnit:
3417  004f 20416d707300  	dc.b	" Amps",0
3548                     ; 549 void sendSMSCurrent(uint32_t Current, uint8_t *cell_number)
3548                     ; 550 {
3549                     	switch	.text
3550  0c8e               _sendSMSCurrent:
3552  0c8e 5239          	subw	sp,#57
3553       00000039      OFST:	set	57
3556                     ; 554 	uint8_t current[26] = "Current is ";
3558  0c90 96            	ldw	x,sp
3559  0c91 1c0007        	addw	x,#OFST-50
3560  0c94 90ae0035      	ldw	y,#L7611_current
3561  0c98 a61a          	ld	a,#26
3562  0c9a cd0000        	call	c_xymvx
3564                     ; 555 	uint8_t currentUnit[6] = " Amps";
3566  0c9d 96            	ldw	x,sp
3567  0c9e 1c0001        	addw	x,#OFST-56
3568  0ca1 90ae004f      	ldw	y,#L1711_currentUnit
3569  0ca5 a606          	ld	a,#6
3570  0ca7 cd0000        	call	c_xymvx
3572                     ; 556 	uint8_t templen = 0;
3574                     ; 557 	uint8_t decplace = 0;
3576                     ; 561 	sprintf(tempwho, "%lu", Current);
3578  0caa 1e3e          	ldw	x,(OFST+5,sp)
3579  0cac 89            	pushw	x
3580  0cad 1e3e          	ldw	x,(OFST+5,sp)
3581  0caf 89            	pushw	x
3582  0cb0 ae009f        	ldw	x,#L1621
3583  0cb3 89            	pushw	x
3584  0cb4 96            	ldw	x,sp
3585  0cb5 1c0028        	addw	x,#OFST-17
3586  0cb8 cd0000        	call	_sprintf
3588  0cbb 5b06          	addw	sp,#6
3589                     ; 562 	templen = strlen(tempwho);
3591  0cbd 96            	ldw	x,sp
3592  0cbe 1c0022        	addw	x,#OFST-23
3593  0cc1 cd0000        	call	_strlen
3595  0cc4 01            	rrwa	x,a
3596  0cc5 6b21          	ld	(OFST-24,sp),a
3597  0cc7 02            	rlwa	x,a
3599                     ; 563 	decplace = templen - 2;
3601  0cc8 7b21          	ld	a,(OFST-24,sp)
3602  0cca a002          	sub	a,#2
3603  0ccc 6b38          	ld	(OFST-1,sp),a
3605                     ; 564 	tempwho2[decplace] = '.';
3607  0cce 96            	ldw	x,sp
3608  0ccf 1c0028        	addw	x,#OFST-17
3609  0cd2 9f            	ld	a,xl
3610  0cd3 5e            	swapw	x
3611  0cd4 1b38          	add	a,(OFST-1,sp)
3612  0cd6 2401          	jrnc	L271
3613  0cd8 5c            	incw	x
3614  0cd9               L271:
3615  0cd9 02            	rlwa	x,a
3616  0cda a62e          	ld	a,#46
3617  0cdc f7            	ld	(x),a
3618                     ; 565 	for (w = 0; w < decplace; w++)
3620  0cdd 0f39          	clr	(OFST+0,sp)
3623  0cdf 201e          	jra	L7621
3624  0ce1               L3621:
3625                     ; 567 		tempwho2[w] = tempwho[w];
3627  0ce1 96            	ldw	x,sp
3628  0ce2 1c0028        	addw	x,#OFST-17
3629  0ce5 9f            	ld	a,xl
3630  0ce6 5e            	swapw	x
3631  0ce7 1b39          	add	a,(OFST+0,sp)
3632  0ce9 2401          	jrnc	L471
3633  0ceb 5c            	incw	x
3634  0cec               L471:
3635  0cec 02            	rlwa	x,a
3636  0ced 89            	pushw	x
3637  0cee 96            	ldw	x,sp
3638  0cef 1c0024        	addw	x,#OFST-21
3639  0cf2 9f            	ld	a,xl
3640  0cf3 5e            	swapw	x
3641  0cf4 1b3b          	add	a,(OFST+2,sp)
3642  0cf6 2401          	jrnc	L671
3643  0cf8 5c            	incw	x
3644  0cf9               L671:
3645  0cf9 02            	rlwa	x,a
3646  0cfa f6            	ld	a,(x)
3647  0cfb 85            	popw	x
3648  0cfc f7            	ld	(x),a
3649                     ; 565 	for (w = 0; w < decplace; w++)
3651  0cfd 0c39          	inc	(OFST+0,sp)
3653  0cff               L7621:
3656  0cff 7b39          	ld	a,(OFST+0,sp)
3657  0d01 1138          	cp	a,(OFST-1,sp)
3658  0d03 25dc          	jrult	L3621
3659                     ; 569 	f = decplace + 1;
3661  0d05 7b38          	ld	a,(OFST-1,sp)
3662  0d07 4c            	inc	a
3663  0d08 6b38          	ld	(OFST-1,sp),a
3665                     ; 570 	for (w = f; w <= templen; w++)
3667  0d0a 7b38          	ld	a,(OFST-1,sp)
3668  0d0c 6b39          	ld	(OFST+0,sp),a
3671  0d0e 2023          	jra	L7721
3672  0d10               L3721:
3673                     ; 572 		u = w - 1;
3675  0d10 7b39          	ld	a,(OFST+0,sp)
3676  0d12 4a            	dec	a
3677  0d13 6b38          	ld	(OFST-1,sp),a
3679                     ; 573 		tempwho2[w] = tempwho[u];
3681  0d15 96            	ldw	x,sp
3682  0d16 1c0028        	addw	x,#OFST-17
3683  0d19 9f            	ld	a,xl
3684  0d1a 5e            	swapw	x
3685  0d1b 1b39          	add	a,(OFST+0,sp)
3686  0d1d 2401          	jrnc	L002
3687  0d1f 5c            	incw	x
3688  0d20               L002:
3689  0d20 02            	rlwa	x,a
3690  0d21 89            	pushw	x
3691  0d22 96            	ldw	x,sp
3692  0d23 1c0024        	addw	x,#OFST-21
3693  0d26 9f            	ld	a,xl
3694  0d27 5e            	swapw	x
3695  0d28 1b3a          	add	a,(OFST+1,sp)
3696  0d2a 2401          	jrnc	L202
3697  0d2c 5c            	incw	x
3698  0d2d               L202:
3699  0d2d 02            	rlwa	x,a
3700  0d2e f6            	ld	a,(x)
3701  0d2f 85            	popw	x
3702  0d30 f7            	ld	(x),a
3703                     ; 570 	for (w = f; w <= templen; w++)
3705  0d31 0c39          	inc	(OFST+0,sp)
3707  0d33               L7721:
3710  0d33 7b39          	ld	a,(OFST+0,sp)
3711  0d35 1121          	cp	a,(OFST-24,sp)
3712  0d37 23d7          	jrule	L3721
3713                     ; 575 	tempwho2[w] = '\0';
3715  0d39 96            	ldw	x,sp
3716  0d3a 1c0028        	addw	x,#OFST-17
3717  0d3d 9f            	ld	a,xl
3718  0d3e 5e            	swapw	x
3719  0d3f 1b39          	add	a,(OFST+0,sp)
3720  0d41 2401          	jrnc	L402
3721  0d43 5c            	incw	x
3722  0d44               L402:
3723  0d44 02            	rlwa	x,a
3724  0d45 7f            	clr	(x)
3725                     ; 576 	strcat(tempwho2, currentUnit);
3727  0d46 96            	ldw	x,sp
3728  0d47 1c0001        	addw	x,#OFST-56
3729  0d4a 89            	pushw	x
3730  0d4b 96            	ldw	x,sp
3731  0d4c 1c002a        	addw	x,#OFST-15
3732  0d4f cd0000        	call	_strcat
3734  0d52 85            	popw	x
3735                     ; 577 	strcat(current, tempwho2);
3737  0d53 96            	ldw	x,sp
3738  0d54 1c0028        	addw	x,#OFST-17
3739  0d57 89            	pushw	x
3740  0d58 96            	ldw	x,sp
3741  0d59 1c0009        	addw	x,#OFST-48
3742  0d5c cd0000        	call	_strcat
3744  0d5f 85            	popw	x
3745                     ; 578 	bSendSMS(current, strlen((const char *)current), cell_number);
3747  0d60 1e40          	ldw	x,(OFST+7,sp)
3748  0d62 89            	pushw	x
3749  0d63 96            	ldw	x,sp
3750  0d64 1c0009        	addw	x,#OFST-48
3751  0d67 cd0000        	call	_strlen
3753  0d6a 9f            	ld	a,xl
3754  0d6b 88            	push	a
3755  0d6c 96            	ldw	x,sp
3756  0d6d 1c000a        	addw	x,#OFST-47
3757  0d70 cd0a20        	call	_bSendSMS
3759  0d73 5b03          	addw	sp,#3
3760                     ; 579 }
3763  0d75 5b39          	addw	sp,#57
3764  0d77 81            	ret
3767                     	switch	.const
3768  0055               L3031_voltage:
3769  0055 566f6c746167  	dc.b	"Voltage is ",0
3770  0061 000000000000  	ds.b	17
3771  0072               L5031_voltageUnit:
3772  0072 20566f6c7473  	dc.b	" Volts",0
3903                     ; 581 void sendSMSVoltage(uint32_t Voltage, uint8_t *cell_number)
3903                     ; 582 {
3904                     	switch	.text
3905  0d78               _sendSMSVoltage:
3907  0d78 523d          	subw	sp,#61
3908       0000003d      OFST:	set	61
3911                     ; 586 	uint8_t voltage[29] = "Voltage is ";
3913  0d7a 96            	ldw	x,sp
3914  0d7b 1c0008        	addw	x,#OFST-53
3915  0d7e 90ae0055      	ldw	y,#L3031_voltage
3916  0d82 a61d          	ld	a,#29
3917  0d84 cd0000        	call	c_xymvx
3919                     ; 587 	uint8_t voltageUnit[7] = " Volts";
3921  0d87 96            	ldw	x,sp
3922  0d88 1c0001        	addw	x,#OFST-60
3923  0d8b 90ae0072      	ldw	y,#L5031_voltageUnit
3924  0d8f a607          	ld	a,#7
3925  0d91 cd0000        	call	c_xymvx
3927                     ; 588 	uint8_t templen = 0;
3929                     ; 589 	uint8_t decplace = 0;
3931                     ; 593 	sprintf(tempwho, "%lu", Voltage);
3933  0d94 1e42          	ldw	x,(OFST+5,sp)
3934  0d96 89            	pushw	x
3935  0d97 1e42          	ldw	x,(OFST+5,sp)
3936  0d99 89            	pushw	x
3937  0d9a ae009f        	ldw	x,#L1621
3938  0d9d 89            	pushw	x
3939  0d9e 96            	ldw	x,sp
3940  0d9f 1c002c        	addw	x,#OFST-17
3941  0da2 cd0000        	call	_sprintf
3943  0da5 5b06          	addw	sp,#6
3944                     ; 594 	templen = strlen(tempwho);
3946  0da7 96            	ldw	x,sp
3947  0da8 1c0026        	addw	x,#OFST-23
3948  0dab cd0000        	call	_strlen
3950  0dae 01            	rrwa	x,a
3951  0daf 6b25          	ld	(OFST-24,sp),a
3952  0db1 02            	rlwa	x,a
3954                     ; 595 	decplace = templen - 2;
3956  0db2 7b25          	ld	a,(OFST-24,sp)
3957  0db4 a002          	sub	a,#2
3958  0db6 6b3c          	ld	(OFST-1,sp),a
3960                     ; 596 	tempwho2[decplace] = '.';
3962  0db8 96            	ldw	x,sp
3963  0db9 1c002c        	addw	x,#OFST-17
3964  0dbc 9f            	ld	a,xl
3965  0dbd 5e            	swapw	x
3966  0dbe 1b3c          	add	a,(OFST-1,sp)
3967  0dc0 2401          	jrnc	L012
3968  0dc2 5c            	incw	x
3969  0dc3               L012:
3970  0dc3 02            	rlwa	x,a
3971  0dc4 a62e          	ld	a,#46
3972  0dc6 f7            	ld	(x),a
3973                     ; 597 	for (w = 0; w < decplace; w++)
3975  0dc7 0f3d          	clr	(OFST+0,sp)
3978  0dc9 201e          	jra	L1041
3979  0dcb               L5731:
3980                     ; 599 		tempwho2[w] = tempwho[w];
3982  0dcb 96            	ldw	x,sp
3983  0dcc 1c002c        	addw	x,#OFST-17
3984  0dcf 9f            	ld	a,xl
3985  0dd0 5e            	swapw	x
3986  0dd1 1b3d          	add	a,(OFST+0,sp)
3987  0dd3 2401          	jrnc	L212
3988  0dd5 5c            	incw	x
3989  0dd6               L212:
3990  0dd6 02            	rlwa	x,a
3991  0dd7 89            	pushw	x
3992  0dd8 96            	ldw	x,sp
3993  0dd9 1c0028        	addw	x,#OFST-21
3994  0ddc 9f            	ld	a,xl
3995  0ddd 5e            	swapw	x
3996  0dde 1b3f          	add	a,(OFST+2,sp)
3997  0de0 2401          	jrnc	L412
3998  0de2 5c            	incw	x
3999  0de3               L412:
4000  0de3 02            	rlwa	x,a
4001  0de4 f6            	ld	a,(x)
4002  0de5 85            	popw	x
4003  0de6 f7            	ld	(x),a
4004                     ; 597 	for (w = 0; w < decplace; w++)
4006  0de7 0c3d          	inc	(OFST+0,sp)
4008  0de9               L1041:
4011  0de9 7b3d          	ld	a,(OFST+0,sp)
4012  0deb 113c          	cp	a,(OFST-1,sp)
4013  0ded 25dc          	jrult	L5731
4014                     ; 601 	f = decplace + 1;
4016  0def 7b3c          	ld	a,(OFST-1,sp)
4017  0df1 4c            	inc	a
4018  0df2 6b3c          	ld	(OFST-1,sp),a
4020                     ; 602 	for (w = f; w <= templen; w++)
4022  0df4 7b3c          	ld	a,(OFST-1,sp)
4023  0df6 6b3d          	ld	(OFST+0,sp),a
4026  0df8 2023          	jra	L1141
4027  0dfa               L5041:
4028                     ; 604 		u = w - 1;
4030  0dfa 7b3d          	ld	a,(OFST+0,sp)
4031  0dfc 4a            	dec	a
4032  0dfd 6b3c          	ld	(OFST-1,sp),a
4034                     ; 605 		tempwho2[w] = tempwho[u];
4036  0dff 96            	ldw	x,sp
4037  0e00 1c002c        	addw	x,#OFST-17
4038  0e03 9f            	ld	a,xl
4039  0e04 5e            	swapw	x
4040  0e05 1b3d          	add	a,(OFST+0,sp)
4041  0e07 2401          	jrnc	L612
4042  0e09 5c            	incw	x
4043  0e0a               L612:
4044  0e0a 02            	rlwa	x,a
4045  0e0b 89            	pushw	x
4046  0e0c 96            	ldw	x,sp
4047  0e0d 1c0028        	addw	x,#OFST-21
4048  0e10 9f            	ld	a,xl
4049  0e11 5e            	swapw	x
4050  0e12 1b3e          	add	a,(OFST+1,sp)
4051  0e14 2401          	jrnc	L022
4052  0e16 5c            	incw	x
4053  0e17               L022:
4054  0e17 02            	rlwa	x,a
4055  0e18 f6            	ld	a,(x)
4056  0e19 85            	popw	x
4057  0e1a f7            	ld	(x),a
4058                     ; 602 	for (w = f; w <= templen; w++)
4060  0e1b 0c3d          	inc	(OFST+0,sp)
4062  0e1d               L1141:
4065  0e1d 7b3d          	ld	a,(OFST+0,sp)
4066  0e1f 1125          	cp	a,(OFST-24,sp)
4067  0e21 23d7          	jrule	L5041
4068                     ; 607 	tempwho2[w] = '\0';
4070  0e23 96            	ldw	x,sp
4071  0e24 1c002c        	addw	x,#OFST-17
4072  0e27 9f            	ld	a,xl
4073  0e28 5e            	swapw	x
4074  0e29 1b3d          	add	a,(OFST+0,sp)
4075  0e2b 2401          	jrnc	L222
4076  0e2d 5c            	incw	x
4077  0e2e               L222:
4078  0e2e 02            	rlwa	x,a
4079  0e2f 7f            	clr	(x)
4080                     ; 608 	strcat(tempwho2, voltageUnit);
4082  0e30 96            	ldw	x,sp
4083  0e31 1c0001        	addw	x,#OFST-60
4084  0e34 89            	pushw	x
4085  0e35 96            	ldw	x,sp
4086  0e36 1c002e        	addw	x,#OFST-15
4087  0e39 cd0000        	call	_strcat
4089  0e3c 85            	popw	x
4090                     ; 609 	strcat(voltage, tempwho2);
4092  0e3d 96            	ldw	x,sp
4093  0e3e 1c002c        	addw	x,#OFST-17
4094  0e41 89            	pushw	x
4095  0e42 96            	ldw	x,sp
4096  0e43 1c000a        	addw	x,#OFST-51
4097  0e46 cd0000        	call	_strcat
4099  0e49 85            	popw	x
4100                     ; 610 	bSendSMS(voltage, strlen((const char *)voltage), cell_number);
4102  0e4a 1e44          	ldw	x,(OFST+7,sp)
4103  0e4c 89            	pushw	x
4104  0e4d 96            	ldw	x,sp
4105  0e4e 1c000a        	addw	x,#OFST-51
4106  0e51 cd0000        	call	_strlen
4108  0e54 9f            	ld	a,xl
4109  0e55 88            	push	a
4110  0e56 96            	ldw	x,sp
4111  0e57 1c000b        	addw	x,#OFST-50
4112  0e5a cd0a20        	call	_bSendSMS
4114  0e5d 5b03          	addw	sp,#3
4115                     ; 611 }
4118  0e5f 5b3d          	addw	sp,#61
4119  0e61 81            	ret
4122                     	switch	.const
4123  0079               L5141_power:
4124  0079 506f77657220  	dc.b	"Power is ",0
4125  0083 000000000000  	ds.b	21
4126  0098               L7141_powerUnit:
4127  0098 205761747473  	dc.b	" Watts",0
4258                     ; 613 void sendSMSPower(uint32_t Power, uint8_t *cell_number)
4258                     ; 614 {
4259                     	switch	.text
4260  0e62               _sendSMSPower:
4262  0e62 523f          	subw	sp,#63
4263       0000003f      OFST:	set	63
4266                     ; 618 	uint8_t power[31] = "Power is ";
4268  0e64 96            	ldw	x,sp
4269  0e65 1c0008        	addw	x,#OFST-55
4270  0e68 90ae0079      	ldw	y,#L5141_power
4271  0e6c a61f          	ld	a,#31
4272  0e6e cd0000        	call	c_xymvx
4274                     ; 619 	uint8_t powerUnit[7] = " Watts";
4276  0e71 96            	ldw	x,sp
4277  0e72 1c0001        	addw	x,#OFST-62
4278  0e75 90ae0098      	ldw	y,#L7141_powerUnit
4279  0e79 a607          	ld	a,#7
4280  0e7b cd0000        	call	c_xymvx
4282                     ; 620 	uint8_t templen = 0;
4284                     ; 621 	uint8_t decplace = 0;
4286                     ; 625 	sprintf(tempwho, "%lu", Power);
4288  0e7e 1e44          	ldw	x,(OFST+5,sp)
4289  0e80 89            	pushw	x
4290  0e81 1e44          	ldw	x,(OFST+5,sp)
4291  0e83 89            	pushw	x
4292  0e84 ae009f        	ldw	x,#L1621
4293  0e87 89            	pushw	x
4294  0e88 96            	ldw	x,sp
4295  0e89 1c002e        	addw	x,#OFST-17
4296  0e8c cd0000        	call	_sprintf
4298  0e8f 5b06          	addw	sp,#6
4299                     ; 626 	templen = strlen(tempwho);
4301  0e91 96            	ldw	x,sp
4302  0e92 1c0028        	addw	x,#OFST-23
4303  0e95 cd0000        	call	_strlen
4305  0e98 01            	rrwa	x,a
4306  0e99 6b27          	ld	(OFST-24,sp),a
4307  0e9b 02            	rlwa	x,a
4309                     ; 627 	decplace = templen - 2;
4311  0e9c 7b27          	ld	a,(OFST-24,sp)
4312  0e9e a002          	sub	a,#2
4313  0ea0 6b3e          	ld	(OFST-1,sp),a
4315                     ; 628 	tempwho2[decplace] = '.';
4317  0ea2 96            	ldw	x,sp
4318  0ea3 1c002e        	addw	x,#OFST-17
4319  0ea6 9f            	ld	a,xl
4320  0ea7 5e            	swapw	x
4321  0ea8 1b3e          	add	a,(OFST-1,sp)
4322  0eaa 2401          	jrnc	L622
4323  0eac 5c            	incw	x
4324  0ead               L622:
4325  0ead 02            	rlwa	x,a
4326  0eae a62e          	ld	a,#46
4327  0eb0 f7            	ld	(x),a
4328                     ; 629 	for (w = 0; w < decplace; w++)
4330  0eb1 0f3f          	clr	(OFST+0,sp)
4333  0eb3 201e          	jra	L3151
4334  0eb5               L7051:
4335                     ; 631 		tempwho2[w] = tempwho[w];
4337  0eb5 96            	ldw	x,sp
4338  0eb6 1c002e        	addw	x,#OFST-17
4339  0eb9 9f            	ld	a,xl
4340  0eba 5e            	swapw	x
4341  0ebb 1b3f          	add	a,(OFST+0,sp)
4342  0ebd 2401          	jrnc	L032
4343  0ebf 5c            	incw	x
4344  0ec0               L032:
4345  0ec0 02            	rlwa	x,a
4346  0ec1 89            	pushw	x
4347  0ec2 96            	ldw	x,sp
4348  0ec3 1c002a        	addw	x,#OFST-21
4349  0ec6 9f            	ld	a,xl
4350  0ec7 5e            	swapw	x
4351  0ec8 1b41          	add	a,(OFST+2,sp)
4352  0eca 2401          	jrnc	L232
4353  0ecc 5c            	incw	x
4354  0ecd               L232:
4355  0ecd 02            	rlwa	x,a
4356  0ece f6            	ld	a,(x)
4357  0ecf 85            	popw	x
4358  0ed0 f7            	ld	(x),a
4359                     ; 629 	for (w = 0; w < decplace; w++)
4361  0ed1 0c3f          	inc	(OFST+0,sp)
4363  0ed3               L3151:
4366  0ed3 7b3f          	ld	a,(OFST+0,sp)
4367  0ed5 113e          	cp	a,(OFST-1,sp)
4368  0ed7 25dc          	jrult	L7051
4369                     ; 633 	f = decplace + 1;
4371  0ed9 7b3e          	ld	a,(OFST-1,sp)
4372  0edb 4c            	inc	a
4373  0edc 6b3e          	ld	(OFST-1,sp),a
4375                     ; 634 	for (w = f; w <= templen; w++)
4377  0ede 7b3e          	ld	a,(OFST-1,sp)
4378  0ee0 6b3f          	ld	(OFST+0,sp),a
4381  0ee2 2023          	jra	L3251
4382  0ee4               L7151:
4383                     ; 636 		u = w - 1;
4385  0ee4 7b3f          	ld	a,(OFST+0,sp)
4386  0ee6 4a            	dec	a
4387  0ee7 6b3e          	ld	(OFST-1,sp),a
4389                     ; 637 		tempwho2[w] = tempwho[u];
4391  0ee9 96            	ldw	x,sp
4392  0eea 1c002e        	addw	x,#OFST-17
4393  0eed 9f            	ld	a,xl
4394  0eee 5e            	swapw	x
4395  0eef 1b3f          	add	a,(OFST+0,sp)
4396  0ef1 2401          	jrnc	L432
4397  0ef3 5c            	incw	x
4398  0ef4               L432:
4399  0ef4 02            	rlwa	x,a
4400  0ef5 89            	pushw	x
4401  0ef6 96            	ldw	x,sp
4402  0ef7 1c002a        	addw	x,#OFST-21
4403  0efa 9f            	ld	a,xl
4404  0efb 5e            	swapw	x
4405  0efc 1b40          	add	a,(OFST+1,sp)
4406  0efe 2401          	jrnc	L632
4407  0f00 5c            	incw	x
4408  0f01               L632:
4409  0f01 02            	rlwa	x,a
4410  0f02 f6            	ld	a,(x)
4411  0f03 85            	popw	x
4412  0f04 f7            	ld	(x),a
4413                     ; 634 	for (w = f; w <= templen; w++)
4415  0f05 0c3f          	inc	(OFST+0,sp)
4417  0f07               L3251:
4420  0f07 7b3f          	ld	a,(OFST+0,sp)
4421  0f09 1127          	cp	a,(OFST-24,sp)
4422  0f0b 23d7          	jrule	L7151
4423                     ; 639 	tempwho2[w] = '\0';
4425  0f0d 96            	ldw	x,sp
4426  0f0e 1c002e        	addw	x,#OFST-17
4427  0f11 9f            	ld	a,xl
4428  0f12 5e            	swapw	x
4429  0f13 1b3f          	add	a,(OFST+0,sp)
4430  0f15 2401          	jrnc	L042
4431  0f17 5c            	incw	x
4432  0f18               L042:
4433  0f18 02            	rlwa	x,a
4434  0f19 7f            	clr	(x)
4435                     ; 640 	strcat(tempwho2, powerUnit);
4437  0f1a 96            	ldw	x,sp
4438  0f1b 1c0001        	addw	x,#OFST-62
4439  0f1e 89            	pushw	x
4440  0f1f 96            	ldw	x,sp
4441  0f20 1c0030        	addw	x,#OFST-15
4442  0f23 cd0000        	call	_strcat
4444  0f26 85            	popw	x
4445                     ; 641 	strcat(power, tempwho2);
4447  0f27 96            	ldw	x,sp
4448  0f28 1c002e        	addw	x,#OFST-17
4449  0f2b 89            	pushw	x
4450  0f2c 96            	ldw	x,sp
4451  0f2d 1c000a        	addw	x,#OFST-53
4452  0f30 cd0000        	call	_strcat
4454  0f33 85            	popw	x
4455                     ; 642 	bSendSMS(power, strlen((const char *)power), cell_number);
4457  0f34 1e46          	ldw	x,(OFST+7,sp)
4458  0f36 89            	pushw	x
4459  0f37 96            	ldw	x,sp
4460  0f38 1c000a        	addw	x,#OFST-53
4461  0f3b cd0000        	call	_strlen
4463  0f3e 9f            	ld	a,xl
4464  0f3f 88            	push	a
4465  0f40 96            	ldw	x,sp
4466  0f41 1c000b        	addw	x,#OFST-52
4467  0f44 cd0a20        	call	_bSendSMS
4469  0f47 5b03          	addw	sp,#3
4470                     ; 643 }
4473  0f49 5b3f          	addw	sp,#63
4474  0f4b 81            	ret
4612                     	xdef	_main
4613                     	xdef	_IMEIRecievedOKFlag
4614                     	xdef	_activation_flag
4615                     	xdef	_arm_flag
4616                     	xdef	_gprs_post_response_status
4617                     	xdef	_sms_recev
4618                     	xdef	_flag2
4619                     	xdef	_cloud_gps_data_flag
4620                     	xdef	_timeout
4621                     	xdef	_previousTics
4622                     	xdef	_stmDataReceive
4623                     	xref	_getFuelLevel
4624                     	xdef	_systemSetup
4625                     	xref	_sendDataToCloud
4626                     	xdef	_bSendSMS
4627                     	xref	_gettemp2
4628                     	xref	_gettemp1
4629                     	xref	_getbatteryvolt
4630                     	xdef	_sendSMSPower
4631                     	xdef	_sendSMSVoltage
4632                     	xdef	_sendSMSCurrent
4633                     	xdef	_sms_receive
4634                     	xref	_atoi
4635                     	xref	_calculateVoltCurrent
4636                     	xref.b	_checkByte
4637                     	xref.b	_powerCalibrationFactor3
4638                     	xref.b	_powerCalibrationFactor2
4639                     	xref.b	_powerCalibrationFactor1
4640                     	xref.b	_currentCalibrationFactor3
4641                     	xref.b	_currentCalibrationFactor2
4642                     	xref.b	_currentCalibrationFactor1
4643                     	xref.b	_voltageCalibrationFactor3
4644                     	xref.b	_voltageCalibrationFactor2
4645                     	xref.b	_voltageCalibrationFactor1
4646                     	xdef	_clearBuffer
4647                     	xref	_ms_send_cmd
4648                     	xref	_Temperature2
4649                     	xref	_Temperature1
4650                     	xref	_Fuellevel
4651                     	xref.b	_batVolt
4652                     	xref	_Watt_Phase3
4653                     	xref	_Ampere_Phase3
4654                     	xref	_Voltage_Phase3
4655                     	xref	_Watt_Phase2
4656                     	xref	_Ampere_Phase2
4657                     	xref	_Voltage_Phase2
4658                     	xref	_Watt_Phase1
4659                     	xref	_Ampere_Phase1
4660                     	xref	_Voltage_Phase1
4661                     	xref	_vHandle_MQTT
4662                     	xref	_vClearBuffer
4663                     	xdef	_GSM_OK_FAST
4664                     	xdef	_GSM_DOWNLOAD
4665                     	xdef	_GSM_OK
4666                     	xref	_SIMCom_setup
4667                     	xdef	_response_buffer
4668                     	xdef	_gprs_init_flag
4669                     	switch	.ubsct
4670  0000               _OK:
4671  0000 00            	ds.b	1
4672                     	xdef	_OK
4673                     	xdef	_cloud_connectivity_flag
4674                     	xdef	_noEchoFlag
4675                     	xref	_sprintf
4676                     	xref	_strlen
4677                     	xref	_strstr
4678                     	xref	_strcat
4679                     	xref	_systemInit
4680                     	xref	_delay_ms
4681                     	xref	_FLASH_ProgramByte
4682                     	xref	_FLASH_Lock
4683                     	xref	_FLASH_Unlock
4684                     	xref	_UART1_GetFlagStatus
4685                     	xref	_UART1_SendData8
4686                     	xref	_UART1_ReceiveData8
4687                     	xref	_UART1_ITConfig
4688                     	switch	.const
4689  009f               L1621:
4690  009f 256c7500      	dc.b	"%lu",0
4691  00a3               L127:
4692  00a3 2b434d475300  	dc.b	"+CMGS",0
4693  00a9               L155:
4694  00a9 2056616c7565  	dc.b	" Value",0
4695  00b0               L745:
4696  00b0 4675656c3a20  	dc.b	"Fuel: ",0
4697  00b7               L545:
4698  00b7 4655454c2d4c  	dc.b	"FUEL-LEVEL",0
4699  00c2               L735:
4700  00c2 20566f6c7473  	dc.b	" Volts",0
4701  00c9               L535:
4702  00c9 426174746572  	dc.b	"Battery: ",0
4703  00d3               L335:
4704  00d3 424154544552  	dc.b	"BATTERY-VOLT",0
4705  00e0               L525:
4706  00e0 456e67696e65  	dc.b	"Engine Temperature"
4707  00f2 3a2000        	dc.b	": ",0
4708  00f5               L325:
4709  00f5 454e47494e45  	dc.b	"ENGINE-TEMP",0
4710  0101               L515:
4711  0101 204300        	dc.b	" C",0
4712  0104               L315:
4713  0104 2e00          	dc.b	".",0
4714  0106               L115:
4715  0106 256c6400      	dc.b	"%ld",0
4716  010a               L705:
4717  010a 526164696174  	dc.b	"Radiator Temperatu"
4718  011c 72653a2000    	dc.b	"re: ",0
4719  0121               L305:
4720  0121 42c80000      	dc.w	17096,0
4721  0125               L574:
4722  0125 524144494154  	dc.b	"RADIATOR-TEMP",0
4723  0133               L764:
4724  0133 504f57455233  	dc.b	"POWER3",0
4725  013a               L164:
4726  013a 564f4c544147  	dc.b	"VOLTAGE3",0
4727  0143               L354:
4728  0143 43555252454e  	dc.b	"CURRENT3",0
4729  014c               L544:
4730  014c 504f57455232  	dc.b	"POWER2",0
4731  0153               L734:
4732  0153 564f4c544147  	dc.b	"VOLTAGE2",0
4733  015c               L134:
4734  015c 43555252454e  	dc.b	"CURRENT2",0
4735  0165               L324:
4736  0165 504f57455231  	dc.b	"POWER1",0
4737  016c               L514:
4738  016c 564f4c544147  	dc.b	"VOLTAGE1",0
4739  0175               L704:
4740  0175 43555252454e  	dc.b	"CURRENT1",0
4741  017e               L573:
4742  017e 503343616c46  	dc.b	"P3CalFac = ",0
4743  018a               L163:
4744  018a 503243616c46  	dc.b	"P2CalFac = ",0
4745  0196               L543:
4746  0196 503143616c46  	dc.b	"P1CalFac = ",0
4747  01a2               L133:
4748  01a2 493343616c46  	dc.b	"I3CalFac = ",0
4749  01ae               L513:
4750  01ae 493243616c46  	dc.b	"I2CalFac = ",0
4751  01ba               L103:
4752  01ba 493143616c46  	dc.b	"I1CalFac = ",0
4753  01c6               L562:
4754  01c6 563343616c46  	dc.b	"V3CalFac = ",0
4755  01d2               L152:
4756  01d2 563243616c46  	dc.b	"V2CalFac = ",0
4757  01de               L532:
4758  01de 563143616c46  	dc.b	"V1CalFac = ",0
4759  01ea               L132:
4760  01ea 43414c494252  	dc.b	"CALIBRATION DONE",0
4761  01fb               L522:
4762  01fb 43414c494252  	dc.b	"CALIBRATE",0
4763  0205               L122:
4764  0205 41542b434d47  	dc.b	"AT+CMGD=1,4",0
4765  0211               L371:
4766  0211 2b434d475200  	dc.b	"+CMGR",0
4767  0217               L151:
4768  0217 41542b434d47  	dc.b	"AT+CMGR=1",0
4769  0221               L741:
4770  0221 41542b434d47  	dc.b	"AT+CMGF=1",0
4771  022b               L541:
4772  022b 4154453000    	dc.b	"ATE0",0
4773                     	xref.b	c_lreg
4774                     	xref.b	c_x
4794                     	xref	c_lzmp
4795                     	xref	c_lgsbc
4796                     	xref	c_lumd
4797                     	xref	c_ludv
4798                     	xref	c_rtol
4799                     	xref	c_ftol
4800                     	xref	c_fmul
4801                     	xref	c_ltor
4802                     	xref	c_xymvx
4803                     	end
