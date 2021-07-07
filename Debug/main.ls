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
 139  0006 cd0ca9        	call	_clearBuffer
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
 396                     	switch	.const
 397  000a               L611:
 398  000a 00000064      	dc.l	100
 399                     ; 81 void sms_receive(void)
 399                     ; 82 {
 400                     	switch	.text
 401  002d               _sms_receive:
 403  002d 527a          	subw	sp,#122
 404       0000007a      OFST:	set	122
 407                     ; 86 	uint8_t temp1[10] = "";
 409  002f 96            	ldw	x,sp
 410  0030 1c0006        	addw	x,#OFST-116
 411  0033 90ae0000      	ldw	y,#L55_temp1
 412  0037 a60a          	ld	a,#10
 413  0039 cd0000        	call	c_xymvx
 415                     ; 93 	uint8_t k = 0;
 417  003c 0f79          	clr	(OFST-1,sp)
 419                     ; 94 	uint8_t l = 0;
 421  003e 0f7a          	clr	(OFST+0,sp)
 423                     ; 95 	uint8_t t = 0;
 425                     ; 97 	uint32_t myVar = 0;
 427                     ; 98 	UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 429  0040 4b00          	push	#0
 430  0042 ae0255        	ldw	x,#597
 431  0045 cd0000        	call	_UART1_ITConfig
 433  0048 84            	pop	a
 434                     ; 99 	UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 436  0049 4b00          	push	#0
 437  004b ae0244        	ldw	x,#580
 438  004e cd0000        	call	_UART1_ITConfig
 440  0051 84            	pop	a
 441                     ; 101 	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); //  no echo
 443  0052 4b04          	push	#4
 444  0054 ae022e        	ldw	x,#L541
 445  0057 cd0000        	call	_ms_send_cmd
 447  005a 84            	pop	a
 448                     ; 102 	delay_ms(200);
 450  005b ae00c8        	ldw	x,#200
 451  005e cd0000        	call	_delay_ms
 453                     ; 103 	ms_send_cmd(MSGFT, strlen((const char *)MSGFT));
 455  0061 4b09          	push	#9
 456  0063 ae0224        	ldw	x,#L741
 457  0066 cd0000        	call	_ms_send_cmd
 459  0069 84            	pop	a
 460                     ; 104 	delay_ms(200);
 462  006a ae00c8        	ldw	x,#200
 463  006d cd0000        	call	_delay_ms
 465                     ; 105 	ms_send_cmd(SMSRead, strlen((const char *)SMSRead)); // SMS read
 467  0070 4b09          	push	#9
 468  0072 ae021a        	ldw	x,#L151
 469  0075 cd0000        	call	_ms_send_cmd
 471  0078 84            	pop	a
 472                     ; 107 	for (i = 0; i < 85; i++)
 474  0079 0f05          	clr	(OFST-117,sp)
 476  007b               L361:
 477                     ; 109 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 479  007b ae0020        	ldw	x,#32
 480  007e cd0000        	call	_UART1_GetFlagStatus
 482  0081 4d            	tnz	a
 483  0082 260c          	jrne	L761
 485  0084 be09          	ldw	x,_timeout
 486  0086 1c0001        	addw	x,#1
 487  0089 bf09          	ldw	_timeout,x
 488  008b a32710        	cpw	x,#10000
 489  008e 26eb          	jrne	L361
 490  0090               L761:
 491                     ; 111 		uart_buffer[i] = UART1_ReceiveData8();
 493  0090 96            	ldw	x,sp
 494  0091 1c0024        	addw	x,#OFST-86
 495  0094 9f            	ld	a,xl
 496  0095 5e            	swapw	x
 497  0096 1b05          	add	a,(OFST-117,sp)
 498  0098 2401          	jrnc	L21
 499  009a 5c            	incw	x
 500  009b               L21:
 501  009b 02            	rlwa	x,a
 502  009c 89            	pushw	x
 503  009d cd0000        	call	_UART1_ReceiveData8
 505  00a0 85            	popw	x
 506  00a1 f7            	ld	(x),a
 507                     ; 112 		timeout = 0;
 509  00a2 5f            	clrw	x
 510  00a3 bf09          	ldw	_timeout,x
 511                     ; 107 	for (i = 0; i < 85; i++)
 513  00a5 0c05          	inc	(OFST-117,sp)
 517  00a7 7b05          	ld	a,(OFST-117,sp)
 518  00a9 a155          	cp	a,#85
 519  00ab 25ce          	jrult	L361
 520                     ; 115 	if (strstr(uart_buffer, "+CMGR"))
 522  00ad ae0214        	ldw	x,#L371
 523  00b0 89            	pushw	x
 524  00b1 96            	ldw	x,sp
 525  00b2 1c0026        	addw	x,#OFST-84
 526  00b5 cd0000        	call	_strstr
 528  00b8 5b02          	addw	sp,#2
 529  00ba a30000        	cpw	x,#0
 530  00bd 2756          	jreq	L171
 531                     ; 117 		k = 0;
 533  00bf 0f79          	clr	(OFST-1,sp)
 536  00c1 2002          	jra	L102
 537  00c3               L571:
 538                     ; 120 			k++;
 540  00c3 0c79          	inc	(OFST-1,sp)
 542  00c5               L102:
 543                     ; 118 		while (uart_buffer[k] != '+')
 543                     ; 119 		{
 543                     ; 120 			k++;
 545  00c5 96            	ldw	x,sp
 546  00c6 1c0024        	addw	x,#OFST-86
 547  00c9 9f            	ld	a,xl
 548  00ca 5e            	swapw	x
 549  00cb 1b79          	add	a,(OFST-1,sp)
 550  00cd 2401          	jrnc	L41
 551  00cf 5c            	incw	x
 552  00d0               L41:
 553  00d0 02            	rlwa	x,a
 554  00d1 f6            	ld	a,(x)
 555  00d2 a12b          	cp	a,#43
 556  00d4 26ed          	jrne	L571
 557                     ; 122 		k++;
 559  00d6 0c79          	inc	(OFST-1,sp)
 562  00d8 2002          	jra	L702
 563  00da               L502:
 564                     ; 125 			k++;
 566  00da 0c79          	inc	(OFST-1,sp)
 568  00dc               L702:
 569                     ; 123 		while (uart_buffer[k] != '+')
 571  00dc 96            	ldw	x,sp
 572  00dd 1c0024        	addw	x,#OFST-86
 573  00e0 9f            	ld	a,xl
 574  00e1 5e            	swapw	x
 575  00e2 1b79          	add	a,(OFST-1,sp)
 576  00e4 2401          	jrnc	L61
 577  00e6 5c            	incw	x
 578  00e7               L61:
 579  00e7 02            	rlwa	x,a
 580  00e8 f6            	ld	a,(x)
 581  00e9 a12b          	cp	a,#43
 582  00eb 26ed          	jrne	L502
 583                     ; 127 		for (l = 0; l < 13; l++)
 585  00ed 0f7a          	clr	(OFST+0,sp)
 587  00ef               L312:
 588                     ; 129 			cell_num[l] = uart_buffer[k];
 590  00ef 96            	ldw	x,sp
 591  00f0 1c0012        	addw	x,#OFST-104
 592  00f3 9f            	ld	a,xl
 593  00f4 5e            	swapw	x
 594  00f5 1b7a          	add	a,(OFST+0,sp)
 595  00f7 2401          	jrnc	L02
 596  00f9 5c            	incw	x
 597  00fa               L02:
 598  00fa 02            	rlwa	x,a
 599  00fb 89            	pushw	x
 600  00fc 96            	ldw	x,sp
 601  00fd 1c0026        	addw	x,#OFST-84
 602  0100 9f            	ld	a,xl
 603  0101 5e            	swapw	x
 604  0102 1b7b          	add	a,(OFST+1,sp)
 605  0104 2401          	jrnc	L22
 606  0106 5c            	incw	x
 607  0107               L22:
 608  0107 02            	rlwa	x,a
 609  0108 f6            	ld	a,(x)
 610  0109 85            	popw	x
 611  010a f7            	ld	(x),a
 612                     ; 130 			k++;
 614  010b 0c79          	inc	(OFST-1,sp)
 616                     ; 127 		for (l = 0; l < 13; l++)
 618  010d 0c7a          	inc	(OFST+0,sp)
 622  010f 7b7a          	ld	a,(OFST+0,sp)
 623  0111 a10d          	cp	a,#13
 624  0113 25da          	jrult	L312
 625  0115               L171:
 626                     ; 133 	cell_num[l] = '\0';
 628  0115 96            	ldw	x,sp
 629  0116 1c0012        	addw	x,#OFST-104
 630  0119 9f            	ld	a,xl
 631  011a 5e            	swapw	x
 632  011b 1b7a          	add	a,(OFST+0,sp)
 633  011d 2401          	jrnc	L42
 634  011f 5c            	incw	x
 635  0120               L42:
 636  0120 02            	rlwa	x,a
 637  0121 7f            	clr	(x)
 638                     ; 135 	ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); // Delete SMS
 640  0122 4b0b          	push	#11
 641  0124 ae0208        	ldw	x,#L122
 642  0127 cd0000        	call	_ms_send_cmd
 644  012a 84            	pop	a
 645                     ; 136 	delay_ms(200);
 647  012b ae00c8        	ldw	x,#200
 648  012e cd0000        	call	_delay_ms
 650                     ; 140 	if (strstr(uart_buffer, "CALIBRATE"))
 652  0131 ae01fe        	ldw	x,#L522
 653  0134 89            	pushw	x
 654  0135 96            	ldw	x,sp
 655  0136 1c0026        	addw	x,#OFST-84
 656  0139 cd0000        	call	_strstr
 658  013c 5b02          	addw	sp,#2
 659  013e a30000        	cpw	x,#0
 660  0141 272c          	jreq	L322
 661                     ; 142 		checkByte = 'B';
 663  0143 35420000      	mov	_checkByte,#66
 664                     ; 143 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 666  0147 a6f7          	ld	a,#247
 667  0149 cd0000        	call	_FLASH_Unlock
 669                     ; 145 		FLASH_ProgramByte(CheckByte, 'B'); //Changed by Saqib
 671  014c 4b42          	push	#66
 672  014e ae4025        	ldw	x,#16421
 673  0151 89            	pushw	x
 674  0152 ae0000        	ldw	x,#0
 675  0155 89            	pushw	x
 676  0156 cd0000        	call	_FLASH_ProgramByte
 678  0159 5b05          	addw	sp,#5
 679                     ; 146 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 681  015b a6f7          	ld	a,#247
 682  015d cd0000        	call	_FLASH_Lock
 684                     ; 147 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 686  0160 96            	ldw	x,sp
 687  0161 1c0012        	addw	x,#OFST-104
 688  0164 89            	pushw	x
 689  0165 4b02          	push	#2
 690  0167 ae01fb        	ldw	x,#L722
 691  016a cd0a50        	call	_bSendSMS
 693  016d 5b03          	addw	sp,#3
 694  016f               L322:
 695                     ; 150 	if (strstr(uart_buffer, "CALIBRATION DONE"))
 697  016f ae01ea        	ldw	x,#L332
 698  0172 89            	pushw	x
 699  0173 96            	ldw	x,sp
 700  0174 1c0026        	addw	x,#OFST-84
 701  0177 cd0000        	call	_strstr
 703  017a 5b02          	addw	sp,#2
 704  017c a30000        	cpw	x,#0
 705  017f 272c          	jreq	L132
 706                     ; 152 		checkByte = 'A';
 708  0181 35410000      	mov	_checkByte,#65
 709                     ; 153 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 711  0185 a6f7          	ld	a,#247
 712  0187 cd0000        	call	_FLASH_Unlock
 714                     ; 154 		FLASH_ProgramByte(CheckByte, 'A');
 716  018a 4b41          	push	#65
 717  018c ae4025        	ldw	x,#16421
 718  018f 89            	pushw	x
 719  0190 ae0000        	ldw	x,#0
 720  0193 89            	pushw	x
 721  0194 cd0000        	call	_FLASH_ProgramByte
 723  0197 5b05          	addw	sp,#5
 724                     ; 155 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 726  0199 a6f7          	ld	a,#247
 727  019b cd0000        	call	_FLASH_Lock
 729                     ; 156 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 731  019e 96            	ldw	x,sp
 732  019f 1c0012        	addw	x,#OFST-104
 733  01a2 89            	pushw	x
 734  01a3 4b02          	push	#2
 735  01a5 ae01fb        	ldw	x,#L722
 736  01a8 cd0a50        	call	_bSendSMS
 738  01ab 5b03          	addw	sp,#3
 739  01ad               L132:
 740                     ; 159 	if (strstr(uart_buffer, "V1CalFac = "))
 742  01ad ae01de        	ldw	x,#L732
 743  01b0 89            	pushw	x
 744  01b1 96            	ldw	x,sp
 745  01b2 1c0026        	addw	x,#OFST-84
 746  01b5 cd0000        	call	_strstr
 748  01b8 5b02          	addw	sp,#2
 749  01ba a30000        	cpw	x,#0
 750  01bd 276a          	jreq	L532
 751                     ; 161 		t = k + 42;
 753  01bf 7b79          	ld	a,(OFST-1,sp)
 754  01c1 ab2a          	add	a,#42
 755  01c3 6b79          	ld	(OFST-1,sp),a
 757                     ; 162 		for (n = 0; n < 4; n++)
 759  01c5 0f7a          	clr	(OFST+0,sp)
 761  01c7               L142:
 762                     ; 164 			calibrationFactor[n] = uart_buffer[t];
 764  01c7 96            	ldw	x,sp
 765  01c8 1c0020        	addw	x,#OFST-90
 766  01cb 9f            	ld	a,xl
 767  01cc 5e            	swapw	x
 768  01cd 1b7a          	add	a,(OFST+0,sp)
 769  01cf 2401          	jrnc	L62
 770  01d1 5c            	incw	x
 771  01d2               L62:
 772  01d2 02            	rlwa	x,a
 773  01d3 89            	pushw	x
 774  01d4 96            	ldw	x,sp
 775  01d5 1c0026        	addw	x,#OFST-84
 776  01d8 9f            	ld	a,xl
 777  01d9 5e            	swapw	x
 778  01da 1b7b          	add	a,(OFST+1,sp)
 779  01dc 2401          	jrnc	L03
 780  01de 5c            	incw	x
 781  01df               L03:
 782  01df 02            	rlwa	x,a
 783  01e0 f6            	ld	a,(x)
 784  01e1 85            	popw	x
 785  01e2 f7            	ld	(x),a
 786                     ; 165 			t++;
 788  01e3 0c79          	inc	(OFST-1,sp)
 790                     ; 162 		for (n = 0; n < 4; n++)
 792  01e5 0c7a          	inc	(OFST+0,sp)
 796  01e7 7b7a          	ld	a,(OFST+0,sp)
 797  01e9 a104          	cp	a,#4
 798  01eb 25da          	jrult	L142
 799                     ; 167 		calibrationFactor[n] = '\0';
 801  01ed 96            	ldw	x,sp
 802  01ee 1c0020        	addw	x,#OFST-90
 803  01f1 9f            	ld	a,xl
 804  01f2 5e            	swapw	x
 805  01f3 1b7a          	add	a,(OFST+0,sp)
 806  01f5 2401          	jrnc	L23
 807  01f7 5c            	incw	x
 808  01f8               L23:
 809  01f8 02            	rlwa	x,a
 810  01f9 7f            	clr	(x)
 811                     ; 168 		value = atoi(calibrationFactor);
 813  01fa 96            	ldw	x,sp
 814  01fb 1c0020        	addw	x,#OFST-90
 815  01fe cd0000        	call	_atoi
 817  0201 1f10          	ldw	(OFST-106,sp),x
 819                     ; 169 		voltageCalibrationFactor1 = value; //Added By saqib, earlier not present
 821  0203 1e10          	ldw	x,(OFST-106,sp)
 822  0205 bf00          	ldw	_voltageCalibrationFactor1,x
 823                     ; 174 		WriteFlashWord(value, V1CabFab);
 825  0207 ae4000        	ldw	x,#16384
 826  020a 89            	pushw	x
 827  020b ae0000        	ldw	x,#0
 828  020e 89            	pushw	x
 829  020f 1e14          	ldw	x,(OFST-102,sp)
 830  0211 cd0000        	call	_WriteFlashWord
 832  0214 5b04          	addw	sp,#4
 833                     ; 175 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 835  0216 96            	ldw	x,sp
 836  0217 1c0012        	addw	x,#OFST-104
 837  021a 89            	pushw	x
 838  021b 4b02          	push	#2
 839  021d ae01fb        	ldw	x,#L722
 840  0220 cd0a50        	call	_bSendSMS
 842  0223 5b03          	addw	sp,#3
 844  0225 ac030603      	jpf	L742
 845  0229               L532:
 846                     ; 178 	else if (strstr(uart_buffer, "V2CalFac = "))
 848  0229 ae01d2        	ldw	x,#L352
 849  022c 89            	pushw	x
 850  022d 96            	ldw	x,sp
 851  022e 1c0026        	addw	x,#OFST-84
 852  0231 cd0000        	call	_strstr
 854  0234 5b02          	addw	sp,#2
 855  0236 a30000        	cpw	x,#0
 856  0239 276a          	jreq	L152
 857                     ; 180 		t = k + 42;
 859  023b 7b79          	ld	a,(OFST-1,sp)
 860  023d ab2a          	add	a,#42
 861  023f 6b79          	ld	(OFST-1,sp),a
 863                     ; 181 		for (n = 0; n < 4; n++)
 865  0241 0f7a          	clr	(OFST+0,sp)
 867  0243               L552:
 868                     ; 183 			calibrationFactor[n] = uart_buffer[t];
 870  0243 96            	ldw	x,sp
 871  0244 1c0020        	addw	x,#OFST-90
 872  0247 9f            	ld	a,xl
 873  0248 5e            	swapw	x
 874  0249 1b7a          	add	a,(OFST+0,sp)
 875  024b 2401          	jrnc	L43
 876  024d 5c            	incw	x
 877  024e               L43:
 878  024e 02            	rlwa	x,a
 879  024f 89            	pushw	x
 880  0250 96            	ldw	x,sp
 881  0251 1c0026        	addw	x,#OFST-84
 882  0254 9f            	ld	a,xl
 883  0255 5e            	swapw	x
 884  0256 1b7b          	add	a,(OFST+1,sp)
 885  0258 2401          	jrnc	L63
 886  025a 5c            	incw	x
 887  025b               L63:
 888  025b 02            	rlwa	x,a
 889  025c f6            	ld	a,(x)
 890  025d 85            	popw	x
 891  025e f7            	ld	(x),a
 892                     ; 184 			t++;
 894  025f 0c79          	inc	(OFST-1,sp)
 896                     ; 181 		for (n = 0; n < 4; n++)
 898  0261 0c7a          	inc	(OFST+0,sp)
 902  0263 7b7a          	ld	a,(OFST+0,sp)
 903  0265 a104          	cp	a,#4
 904  0267 25da          	jrult	L552
 905                     ; 186 		calibrationFactor[n] = '\0';
 907  0269 96            	ldw	x,sp
 908  026a 1c0020        	addw	x,#OFST-90
 909  026d 9f            	ld	a,xl
 910  026e 5e            	swapw	x
 911  026f 1b7a          	add	a,(OFST+0,sp)
 912  0271 2401          	jrnc	L04
 913  0273 5c            	incw	x
 914  0274               L04:
 915  0274 02            	rlwa	x,a
 916  0275 7f            	clr	(x)
 917                     ; 187 		value = atoi(calibrationFactor);
 919  0276 96            	ldw	x,sp
 920  0277 1c0020        	addw	x,#OFST-90
 921  027a cd0000        	call	_atoi
 923  027d 1f10          	ldw	(OFST-106,sp),x
 925                     ; 188 		voltageCalibrationFactor2 = value; //Added By saqib, earlier not present
 927  027f 1e10          	ldw	x,(OFST-106,sp)
 928  0281 bf00          	ldw	_voltageCalibrationFactor2,x
 929                     ; 194 		WriteFlashWord(value, V2CabFab);
 931  0283 ae4004        	ldw	x,#16388
 932  0286 89            	pushw	x
 933  0287 ae0000        	ldw	x,#0
 934  028a 89            	pushw	x
 935  028b 1e14          	ldw	x,(OFST-102,sp)
 936  028d cd0000        	call	_WriteFlashWord
 938  0290 5b04          	addw	sp,#4
 939                     ; 195 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 941  0292 96            	ldw	x,sp
 942  0293 1c0012        	addw	x,#OFST-104
 943  0296 89            	pushw	x
 944  0297 4b02          	push	#2
 945  0299 ae01fb        	ldw	x,#L722
 946  029c cd0a50        	call	_bSendSMS
 948  029f 5b03          	addw	sp,#3
 950  02a1 ac030603      	jpf	L742
 951  02a5               L152:
 952                     ; 198 	else if (strstr(uart_buffer, "V3CalFac = "))
 954  02a5 ae01c6        	ldw	x,#L762
 955  02a8 89            	pushw	x
 956  02a9 96            	ldw	x,sp
 957  02aa 1c0026        	addw	x,#OFST-84
 958  02ad cd0000        	call	_strstr
 960  02b0 5b02          	addw	sp,#2
 961  02b2 a30000        	cpw	x,#0
 962  02b5 276a          	jreq	L562
 963                     ; 200 		t = k + 42;
 965  02b7 7b79          	ld	a,(OFST-1,sp)
 966  02b9 ab2a          	add	a,#42
 967  02bb 6b79          	ld	(OFST-1,sp),a
 969                     ; 201 		for (n = 0; n < 4; n++)
 971  02bd 0f7a          	clr	(OFST+0,sp)
 973  02bf               L172:
 974                     ; 203 			calibrationFactor[n] = uart_buffer[t];
 976  02bf 96            	ldw	x,sp
 977  02c0 1c0020        	addw	x,#OFST-90
 978  02c3 9f            	ld	a,xl
 979  02c4 5e            	swapw	x
 980  02c5 1b7a          	add	a,(OFST+0,sp)
 981  02c7 2401          	jrnc	L24
 982  02c9 5c            	incw	x
 983  02ca               L24:
 984  02ca 02            	rlwa	x,a
 985  02cb 89            	pushw	x
 986  02cc 96            	ldw	x,sp
 987  02cd 1c0026        	addw	x,#OFST-84
 988  02d0 9f            	ld	a,xl
 989  02d1 5e            	swapw	x
 990  02d2 1b7b          	add	a,(OFST+1,sp)
 991  02d4 2401          	jrnc	L44
 992  02d6 5c            	incw	x
 993  02d7               L44:
 994  02d7 02            	rlwa	x,a
 995  02d8 f6            	ld	a,(x)
 996  02d9 85            	popw	x
 997  02da f7            	ld	(x),a
 998                     ; 204 			t++;
1000  02db 0c79          	inc	(OFST-1,sp)
1002                     ; 201 		for (n = 0; n < 4; n++)
1004  02dd 0c7a          	inc	(OFST+0,sp)
1008  02df 7b7a          	ld	a,(OFST+0,sp)
1009  02e1 a104          	cp	a,#4
1010  02e3 25da          	jrult	L172
1011                     ; 206 		calibrationFactor[n] = '\0';
1013  02e5 96            	ldw	x,sp
1014  02e6 1c0020        	addw	x,#OFST-90
1015  02e9 9f            	ld	a,xl
1016  02ea 5e            	swapw	x
1017  02eb 1b7a          	add	a,(OFST+0,sp)
1018  02ed 2401          	jrnc	L64
1019  02ef 5c            	incw	x
1020  02f0               L64:
1021  02f0 02            	rlwa	x,a
1022  02f1 7f            	clr	(x)
1023                     ; 207 		value = atoi(calibrationFactor);
1025  02f2 96            	ldw	x,sp
1026  02f3 1c0020        	addw	x,#OFST-90
1027  02f6 cd0000        	call	_atoi
1029  02f9 1f10          	ldw	(OFST-106,sp),x
1031                     ; 208 		voltageCalibrationFactor3 = value;
1033  02fb 1e10          	ldw	x,(OFST-106,sp)
1034  02fd bf00          	ldw	_voltageCalibrationFactor3,x
1035                     ; 214 		WriteFlashWord(value, V3CabFab);
1037  02ff ae4008        	ldw	x,#16392
1038  0302 89            	pushw	x
1039  0303 ae0000        	ldw	x,#0
1040  0306 89            	pushw	x
1041  0307 1e14          	ldw	x,(OFST-102,sp)
1042  0309 cd0000        	call	_WriteFlashWord
1044  030c 5b04          	addw	sp,#4
1045                     ; 215 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1047  030e 96            	ldw	x,sp
1048  030f 1c0012        	addw	x,#OFST-104
1049  0312 89            	pushw	x
1050  0313 4b02          	push	#2
1051  0315 ae01fb        	ldw	x,#L722
1052  0318 cd0a50        	call	_bSendSMS
1054  031b 5b03          	addw	sp,#3
1056  031d ac030603      	jpf	L742
1057  0321               L562:
1058                     ; 218 	else if (strstr(uart_buffer, "I1CalFac = "))
1060  0321 ae01ba        	ldw	x,#L303
1061  0324 89            	pushw	x
1062  0325 96            	ldw	x,sp
1063  0326 1c0026        	addw	x,#OFST-84
1064  0329 cd0000        	call	_strstr
1066  032c 5b02          	addw	sp,#2
1067  032e a30000        	cpw	x,#0
1068  0331 276a          	jreq	L103
1069                     ; 220 		t = k + 42;
1071  0333 7b79          	ld	a,(OFST-1,sp)
1072  0335 ab2a          	add	a,#42
1073  0337 6b79          	ld	(OFST-1,sp),a
1075                     ; 221 		for (n = 0; n < 4; n++)
1077  0339 0f7a          	clr	(OFST+0,sp)
1079  033b               L503:
1080                     ; 223 			calibrationFactor[n] = uart_buffer[t];
1082  033b 96            	ldw	x,sp
1083  033c 1c0020        	addw	x,#OFST-90
1084  033f 9f            	ld	a,xl
1085  0340 5e            	swapw	x
1086  0341 1b7a          	add	a,(OFST+0,sp)
1087  0343 2401          	jrnc	L05
1088  0345 5c            	incw	x
1089  0346               L05:
1090  0346 02            	rlwa	x,a
1091  0347 89            	pushw	x
1092  0348 96            	ldw	x,sp
1093  0349 1c0026        	addw	x,#OFST-84
1094  034c 9f            	ld	a,xl
1095  034d 5e            	swapw	x
1096  034e 1b7b          	add	a,(OFST+1,sp)
1097  0350 2401          	jrnc	L25
1098  0352 5c            	incw	x
1099  0353               L25:
1100  0353 02            	rlwa	x,a
1101  0354 f6            	ld	a,(x)
1102  0355 85            	popw	x
1103  0356 f7            	ld	(x),a
1104                     ; 224 			t++;
1106  0357 0c79          	inc	(OFST-1,sp)
1108                     ; 221 		for (n = 0; n < 4; n++)
1110  0359 0c7a          	inc	(OFST+0,sp)
1114  035b 7b7a          	ld	a,(OFST+0,sp)
1115  035d a104          	cp	a,#4
1116  035f 25da          	jrult	L503
1117                     ; 226 		calibrationFactor[n] = '\0';
1119  0361 96            	ldw	x,sp
1120  0362 1c0020        	addw	x,#OFST-90
1121  0365 9f            	ld	a,xl
1122  0366 5e            	swapw	x
1123  0367 1b7a          	add	a,(OFST+0,sp)
1124  0369 2401          	jrnc	L45
1125  036b 5c            	incw	x
1126  036c               L45:
1127  036c 02            	rlwa	x,a
1128  036d 7f            	clr	(x)
1129                     ; 227 		value = atoi(calibrationFactor);
1131  036e 96            	ldw	x,sp
1132  036f 1c0020        	addw	x,#OFST-90
1133  0372 cd0000        	call	_atoi
1135  0375 1f10          	ldw	(OFST-106,sp),x
1137                     ; 228 		currentCalibrationFactor1 = value; //Added By saqib, earlier not present
1139  0377 1e10          	ldw	x,(OFST-106,sp)
1140  0379 bf00          	ldw	_currentCalibrationFactor1,x
1141                     ; 234 		WriteFlashWord(value, I1CabFab);
1143  037b ae400c        	ldw	x,#16396
1144  037e 89            	pushw	x
1145  037f ae0000        	ldw	x,#0
1146  0382 89            	pushw	x
1147  0383 1e14          	ldw	x,(OFST-102,sp)
1148  0385 cd0000        	call	_WriteFlashWord
1150  0388 5b04          	addw	sp,#4
1151                     ; 235 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1153  038a 96            	ldw	x,sp
1154  038b 1c0012        	addw	x,#OFST-104
1155  038e 89            	pushw	x
1156  038f 4b02          	push	#2
1157  0391 ae01fb        	ldw	x,#L722
1158  0394 cd0a50        	call	_bSendSMS
1160  0397 5b03          	addw	sp,#3
1162  0399 ac030603      	jpf	L742
1163  039d               L103:
1164                     ; 238 	else if (strstr(uart_buffer, "I2CalFac = "))
1166  039d ae01ae        	ldw	x,#L713
1167  03a0 89            	pushw	x
1168  03a1 96            	ldw	x,sp
1169  03a2 1c0026        	addw	x,#OFST-84
1170  03a5 cd0000        	call	_strstr
1172  03a8 5b02          	addw	sp,#2
1173  03aa a30000        	cpw	x,#0
1174  03ad 276a          	jreq	L513
1175                     ; 240 		t = k + 42;
1177  03af 7b79          	ld	a,(OFST-1,sp)
1178  03b1 ab2a          	add	a,#42
1179  03b3 6b79          	ld	(OFST-1,sp),a
1181                     ; 241 		for (n = 0; n < 4; n++)
1183  03b5 0f7a          	clr	(OFST+0,sp)
1185  03b7               L123:
1186                     ; 243 			calibrationFactor[n] = uart_buffer[t];
1188  03b7 96            	ldw	x,sp
1189  03b8 1c0020        	addw	x,#OFST-90
1190  03bb 9f            	ld	a,xl
1191  03bc 5e            	swapw	x
1192  03bd 1b7a          	add	a,(OFST+0,sp)
1193  03bf 2401          	jrnc	L65
1194  03c1 5c            	incw	x
1195  03c2               L65:
1196  03c2 02            	rlwa	x,a
1197  03c3 89            	pushw	x
1198  03c4 96            	ldw	x,sp
1199  03c5 1c0026        	addw	x,#OFST-84
1200  03c8 9f            	ld	a,xl
1201  03c9 5e            	swapw	x
1202  03ca 1b7b          	add	a,(OFST+1,sp)
1203  03cc 2401          	jrnc	L06
1204  03ce 5c            	incw	x
1205  03cf               L06:
1206  03cf 02            	rlwa	x,a
1207  03d0 f6            	ld	a,(x)
1208  03d1 85            	popw	x
1209  03d2 f7            	ld	(x),a
1210                     ; 244 			t++;
1212  03d3 0c79          	inc	(OFST-1,sp)
1214                     ; 241 		for (n = 0; n < 4; n++)
1216  03d5 0c7a          	inc	(OFST+0,sp)
1220  03d7 7b7a          	ld	a,(OFST+0,sp)
1221  03d9 a104          	cp	a,#4
1222  03db 25da          	jrult	L123
1223                     ; 246 		calibrationFactor[n] = '\0';
1225  03dd 96            	ldw	x,sp
1226  03de 1c0020        	addw	x,#OFST-90
1227  03e1 9f            	ld	a,xl
1228  03e2 5e            	swapw	x
1229  03e3 1b7a          	add	a,(OFST+0,sp)
1230  03e5 2401          	jrnc	L26
1231  03e7 5c            	incw	x
1232  03e8               L26:
1233  03e8 02            	rlwa	x,a
1234  03e9 7f            	clr	(x)
1235                     ; 247 		value = atoi(calibrationFactor);
1237  03ea 96            	ldw	x,sp
1238  03eb 1c0020        	addw	x,#OFST-90
1239  03ee cd0000        	call	_atoi
1241  03f1 1f10          	ldw	(OFST-106,sp),x
1243                     ; 248 		currentCalibrationFactor2 = value; //Added By saqib, earlier not present
1245  03f3 1e10          	ldw	x,(OFST-106,sp)
1246  03f5 bf00          	ldw	_currentCalibrationFactor2,x
1247                     ; 254 		WriteFlashWord(value, I2CabFab);
1249  03f7 ae4010        	ldw	x,#16400
1250  03fa 89            	pushw	x
1251  03fb ae0000        	ldw	x,#0
1252  03fe 89            	pushw	x
1253  03ff 1e14          	ldw	x,(OFST-102,sp)
1254  0401 cd0000        	call	_WriteFlashWord
1256  0404 5b04          	addw	sp,#4
1257                     ; 255 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1259  0406 96            	ldw	x,sp
1260  0407 1c0012        	addw	x,#OFST-104
1261  040a 89            	pushw	x
1262  040b 4b02          	push	#2
1263  040d ae01fb        	ldw	x,#L722
1264  0410 cd0a50        	call	_bSendSMS
1266  0413 5b03          	addw	sp,#3
1268  0415 ac030603      	jpf	L742
1269  0419               L513:
1270                     ; 258 	else if (strstr(uart_buffer, "I3CalFac = "))
1272  0419 ae01a2        	ldw	x,#L333
1273  041c 89            	pushw	x
1274  041d 96            	ldw	x,sp
1275  041e 1c0026        	addw	x,#OFST-84
1276  0421 cd0000        	call	_strstr
1278  0424 5b02          	addw	sp,#2
1279  0426 a30000        	cpw	x,#0
1280  0429 276a          	jreq	L133
1281                     ; 260 		t = k + 42;
1283  042b 7b79          	ld	a,(OFST-1,sp)
1284  042d ab2a          	add	a,#42
1285  042f 6b79          	ld	(OFST-1,sp),a
1287                     ; 261 		for (n = 0; n < 4; n++)
1289  0431 0f7a          	clr	(OFST+0,sp)
1291  0433               L533:
1292                     ; 263 			calibrationFactor[n] = uart_buffer[t];
1294  0433 96            	ldw	x,sp
1295  0434 1c0020        	addw	x,#OFST-90
1296  0437 9f            	ld	a,xl
1297  0438 5e            	swapw	x
1298  0439 1b7a          	add	a,(OFST+0,sp)
1299  043b 2401          	jrnc	L46
1300  043d 5c            	incw	x
1301  043e               L46:
1302  043e 02            	rlwa	x,a
1303  043f 89            	pushw	x
1304  0440 96            	ldw	x,sp
1305  0441 1c0026        	addw	x,#OFST-84
1306  0444 9f            	ld	a,xl
1307  0445 5e            	swapw	x
1308  0446 1b7b          	add	a,(OFST+1,sp)
1309  0448 2401          	jrnc	L66
1310  044a 5c            	incw	x
1311  044b               L66:
1312  044b 02            	rlwa	x,a
1313  044c f6            	ld	a,(x)
1314  044d 85            	popw	x
1315  044e f7            	ld	(x),a
1316                     ; 264 			t++;
1318  044f 0c79          	inc	(OFST-1,sp)
1320                     ; 261 		for (n = 0; n < 4; n++)
1322  0451 0c7a          	inc	(OFST+0,sp)
1326  0453 7b7a          	ld	a,(OFST+0,sp)
1327  0455 a104          	cp	a,#4
1328  0457 25da          	jrult	L533
1329                     ; 266 		calibrationFactor[n] = '\0';
1331  0459 96            	ldw	x,sp
1332  045a 1c0020        	addw	x,#OFST-90
1333  045d 9f            	ld	a,xl
1334  045e 5e            	swapw	x
1335  045f 1b7a          	add	a,(OFST+0,sp)
1336  0461 2401          	jrnc	L07
1337  0463 5c            	incw	x
1338  0464               L07:
1339  0464 02            	rlwa	x,a
1340  0465 7f            	clr	(x)
1341                     ; 267 		value = atoi(calibrationFactor);
1343  0466 96            	ldw	x,sp
1344  0467 1c0020        	addw	x,#OFST-90
1345  046a cd0000        	call	_atoi
1347  046d 1f10          	ldw	(OFST-106,sp),x
1349                     ; 268 		currentCalibrationFactor3 = value;
1351  046f 1e10          	ldw	x,(OFST-106,sp)
1352  0471 bf00          	ldw	_currentCalibrationFactor3,x
1353                     ; 274 		WriteFlashWord(value, I3CabFab);
1355  0473 ae4014        	ldw	x,#16404
1356  0476 89            	pushw	x
1357  0477 ae0000        	ldw	x,#0
1358  047a 89            	pushw	x
1359  047b 1e14          	ldw	x,(OFST-102,sp)
1360  047d cd0000        	call	_WriteFlashWord
1362  0480 5b04          	addw	sp,#4
1363                     ; 275 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1365  0482 96            	ldw	x,sp
1366  0483 1c0012        	addw	x,#OFST-104
1367  0486 89            	pushw	x
1368  0487 4b02          	push	#2
1369  0489 ae01fb        	ldw	x,#L722
1370  048c cd0a50        	call	_bSendSMS
1372  048f 5b03          	addw	sp,#3
1374  0491 ac030603      	jpf	L742
1375  0495               L133:
1376                     ; 278 	else if (strstr(uart_buffer, "P1CalFac = "))
1378  0495 ae0196        	ldw	x,#L743
1379  0498 89            	pushw	x
1380  0499 96            	ldw	x,sp
1381  049a 1c0026        	addw	x,#OFST-84
1382  049d cd0000        	call	_strstr
1384  04a0 5b02          	addw	sp,#2
1385  04a2 a30000        	cpw	x,#0
1386  04a5 276a          	jreq	L543
1387                     ; 280 		t = k + 42;
1389  04a7 7b79          	ld	a,(OFST-1,sp)
1390  04a9 ab2a          	add	a,#42
1391  04ab 6b79          	ld	(OFST-1,sp),a
1393                     ; 281 		for (n = 0; n < 4; n++)
1395  04ad 0f7a          	clr	(OFST+0,sp)
1397  04af               L153:
1398                     ; 283 			calibrationFactor[n] = uart_buffer[t];
1400  04af 96            	ldw	x,sp
1401  04b0 1c0020        	addw	x,#OFST-90
1402  04b3 9f            	ld	a,xl
1403  04b4 5e            	swapw	x
1404  04b5 1b7a          	add	a,(OFST+0,sp)
1405  04b7 2401          	jrnc	L27
1406  04b9 5c            	incw	x
1407  04ba               L27:
1408  04ba 02            	rlwa	x,a
1409  04bb 89            	pushw	x
1410  04bc 96            	ldw	x,sp
1411  04bd 1c0026        	addw	x,#OFST-84
1412  04c0 9f            	ld	a,xl
1413  04c1 5e            	swapw	x
1414  04c2 1b7b          	add	a,(OFST+1,sp)
1415  04c4 2401          	jrnc	L47
1416  04c6 5c            	incw	x
1417  04c7               L47:
1418  04c7 02            	rlwa	x,a
1419  04c8 f6            	ld	a,(x)
1420  04c9 85            	popw	x
1421  04ca f7            	ld	(x),a
1422                     ; 284 			t++;
1424  04cb 0c79          	inc	(OFST-1,sp)
1426                     ; 281 		for (n = 0; n < 4; n++)
1428  04cd 0c7a          	inc	(OFST+0,sp)
1432  04cf 7b7a          	ld	a,(OFST+0,sp)
1433  04d1 a104          	cp	a,#4
1434  04d3 25da          	jrult	L153
1435                     ; 286 		calibrationFactor[n] = '\0';
1437  04d5 96            	ldw	x,sp
1438  04d6 1c0020        	addw	x,#OFST-90
1439  04d9 9f            	ld	a,xl
1440  04da 5e            	swapw	x
1441  04db 1b7a          	add	a,(OFST+0,sp)
1442  04dd 2401          	jrnc	L67
1443  04df 5c            	incw	x
1444  04e0               L67:
1445  04e0 02            	rlwa	x,a
1446  04e1 7f            	clr	(x)
1447                     ; 287 		value = atoi(calibrationFactor);
1449  04e2 96            	ldw	x,sp
1450  04e3 1c0020        	addw	x,#OFST-90
1451  04e6 cd0000        	call	_atoi
1453  04e9 1f10          	ldw	(OFST-106,sp),x
1455                     ; 288 		powerCalibrationFactor1 = value; //Added By saqib, earlier not present
1457  04eb 1e10          	ldw	x,(OFST-106,sp)
1458  04ed bf00          	ldw	_powerCalibrationFactor1,x
1459                     ; 294 		WriteFlashWord(value, P1CabFab);
1461  04ef ae4018        	ldw	x,#16408
1462  04f2 89            	pushw	x
1463  04f3 ae0000        	ldw	x,#0
1464  04f6 89            	pushw	x
1465  04f7 1e14          	ldw	x,(OFST-102,sp)
1466  04f9 cd0000        	call	_WriteFlashWord
1468  04fc 5b04          	addw	sp,#4
1469                     ; 295 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1471  04fe 96            	ldw	x,sp
1472  04ff 1c0012        	addw	x,#OFST-104
1473  0502 89            	pushw	x
1474  0503 4b02          	push	#2
1475  0505 ae01fb        	ldw	x,#L722
1476  0508 cd0a50        	call	_bSendSMS
1478  050b 5b03          	addw	sp,#3
1480  050d ac030603      	jpf	L742
1481  0511               L543:
1482                     ; 298 	else if (strstr(uart_buffer, "P2CalFac = "))
1484  0511 ae018a        	ldw	x,#L363
1485  0514 89            	pushw	x
1486  0515 96            	ldw	x,sp
1487  0516 1c0026        	addw	x,#OFST-84
1488  0519 cd0000        	call	_strstr
1490  051c 5b02          	addw	sp,#2
1491  051e a30000        	cpw	x,#0
1492  0521 2768          	jreq	L163
1493                     ; 300 		t = k + 42;
1495  0523 7b79          	ld	a,(OFST-1,sp)
1496  0525 ab2a          	add	a,#42
1497  0527 6b79          	ld	(OFST-1,sp),a
1499                     ; 301 		for (n = 0; n < 4; n++)
1501  0529 0f7a          	clr	(OFST+0,sp)
1503  052b               L563:
1504                     ; 303 			calibrationFactor[n] = uart_buffer[t];
1506  052b 96            	ldw	x,sp
1507  052c 1c0020        	addw	x,#OFST-90
1508  052f 9f            	ld	a,xl
1509  0530 5e            	swapw	x
1510  0531 1b7a          	add	a,(OFST+0,sp)
1511  0533 2401          	jrnc	L001
1512  0535 5c            	incw	x
1513  0536               L001:
1514  0536 02            	rlwa	x,a
1515  0537 89            	pushw	x
1516  0538 96            	ldw	x,sp
1517  0539 1c0026        	addw	x,#OFST-84
1518  053c 9f            	ld	a,xl
1519  053d 5e            	swapw	x
1520  053e 1b7b          	add	a,(OFST+1,sp)
1521  0540 2401          	jrnc	L201
1522  0542 5c            	incw	x
1523  0543               L201:
1524  0543 02            	rlwa	x,a
1525  0544 f6            	ld	a,(x)
1526  0545 85            	popw	x
1527  0546 f7            	ld	(x),a
1528                     ; 304 			t++;
1530  0547 0c79          	inc	(OFST-1,sp)
1532                     ; 301 		for (n = 0; n < 4; n++)
1534  0549 0c7a          	inc	(OFST+0,sp)
1538  054b 7b7a          	ld	a,(OFST+0,sp)
1539  054d a104          	cp	a,#4
1540  054f 25da          	jrult	L563
1541                     ; 306 		calibrationFactor[n] = '\0';
1543  0551 96            	ldw	x,sp
1544  0552 1c0020        	addw	x,#OFST-90
1545  0555 9f            	ld	a,xl
1546  0556 5e            	swapw	x
1547  0557 1b7a          	add	a,(OFST+0,sp)
1548  0559 2401          	jrnc	L401
1549  055b 5c            	incw	x
1550  055c               L401:
1551  055c 02            	rlwa	x,a
1552  055d 7f            	clr	(x)
1553                     ; 307 		value = atoi(calibrationFactor);
1555  055e 96            	ldw	x,sp
1556  055f 1c0020        	addw	x,#OFST-90
1557  0562 cd0000        	call	_atoi
1559  0565 1f10          	ldw	(OFST-106,sp),x
1561                     ; 308 		powerCalibrationFactor2 = value; //Added By saqib, earlier not present
1563  0567 1e10          	ldw	x,(OFST-106,sp)
1564  0569 bf00          	ldw	_powerCalibrationFactor2,x
1565                     ; 314 		WriteFlashWord(value, P2CabFab);
1567  056b ae401c        	ldw	x,#16412
1568  056e 89            	pushw	x
1569  056f ae0000        	ldw	x,#0
1570  0572 89            	pushw	x
1571  0573 1e14          	ldw	x,(OFST-102,sp)
1572  0575 cd0000        	call	_WriteFlashWord
1574  0578 5b04          	addw	sp,#4
1575                     ; 315 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1577  057a 96            	ldw	x,sp
1578  057b 1c0012        	addw	x,#OFST-104
1579  057e 89            	pushw	x
1580  057f 4b02          	push	#2
1581  0581 ae01fb        	ldw	x,#L722
1582  0584 cd0a50        	call	_bSendSMS
1584  0587 5b03          	addw	sp,#3
1586  0589 2078          	jra	L742
1587  058b               L163:
1588                     ; 318 	else if (strstr(uart_buffer, "P3CalFac = "))
1590  058b ae017e        	ldw	x,#L773
1591  058e 89            	pushw	x
1592  058f 96            	ldw	x,sp
1593  0590 1c0026        	addw	x,#OFST-84
1594  0593 cd0000        	call	_strstr
1596  0596 5b02          	addw	sp,#2
1597  0598 a30000        	cpw	x,#0
1598  059b 2766          	jreq	L742
1599                     ; 320 		t = k + 42;
1601  059d 7b79          	ld	a,(OFST-1,sp)
1602  059f ab2a          	add	a,#42
1603  05a1 6b79          	ld	(OFST-1,sp),a
1605                     ; 321 		for (n = 0; n < 4; n++)
1607  05a3 0f7a          	clr	(OFST+0,sp)
1609  05a5               L104:
1610                     ; 323 			calibrationFactor[n] = uart_buffer[t];
1612  05a5 96            	ldw	x,sp
1613  05a6 1c0020        	addw	x,#OFST-90
1614  05a9 9f            	ld	a,xl
1615  05aa 5e            	swapw	x
1616  05ab 1b7a          	add	a,(OFST+0,sp)
1617  05ad 2401          	jrnc	L601
1618  05af 5c            	incw	x
1619  05b0               L601:
1620  05b0 02            	rlwa	x,a
1621  05b1 89            	pushw	x
1622  05b2 96            	ldw	x,sp
1623  05b3 1c0026        	addw	x,#OFST-84
1624  05b6 9f            	ld	a,xl
1625  05b7 5e            	swapw	x
1626  05b8 1b7b          	add	a,(OFST+1,sp)
1627  05ba 2401          	jrnc	L011
1628  05bc 5c            	incw	x
1629  05bd               L011:
1630  05bd 02            	rlwa	x,a
1631  05be f6            	ld	a,(x)
1632  05bf 85            	popw	x
1633  05c0 f7            	ld	(x),a
1634                     ; 324 			t++;
1636  05c1 0c79          	inc	(OFST-1,sp)
1638                     ; 321 		for (n = 0; n < 4; n++)
1640  05c3 0c7a          	inc	(OFST+0,sp)
1644  05c5 7b7a          	ld	a,(OFST+0,sp)
1645  05c7 a104          	cp	a,#4
1646  05c9 25da          	jrult	L104
1647                     ; 326 		calibrationFactor[n] = '\0';
1649  05cb 96            	ldw	x,sp
1650  05cc 1c0020        	addw	x,#OFST-90
1651  05cf 9f            	ld	a,xl
1652  05d0 5e            	swapw	x
1653  05d1 1b7a          	add	a,(OFST+0,sp)
1654  05d3 2401          	jrnc	L211
1655  05d5 5c            	incw	x
1656  05d6               L211:
1657  05d6 02            	rlwa	x,a
1658  05d7 7f            	clr	(x)
1659                     ; 327 		value = atoi(calibrationFactor);
1661  05d8 96            	ldw	x,sp
1662  05d9 1c0020        	addw	x,#OFST-90
1663  05dc cd0000        	call	_atoi
1665  05df 1f10          	ldw	(OFST-106,sp),x
1667                     ; 328 		powerCalibrationFactor3 = value;
1669  05e1 1e10          	ldw	x,(OFST-106,sp)
1670  05e3 bf00          	ldw	_powerCalibrationFactor3,x
1671                     ; 335 		WriteFlashWord(value, P3CabFab);
1673  05e5 ae4020        	ldw	x,#16416
1674  05e8 89            	pushw	x
1675  05e9 ae0000        	ldw	x,#0
1676  05ec 89            	pushw	x
1677  05ed 1e14          	ldw	x,(OFST-102,sp)
1678  05ef cd0000        	call	_WriteFlashWord
1680  05f2 5b04          	addw	sp,#4
1681                     ; 336 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1683  05f4 96            	ldw	x,sp
1684  05f5 1c0012        	addw	x,#OFST-104
1685  05f8 89            	pushw	x
1686  05f9 4b02          	push	#2
1687  05fb ae01fb        	ldw	x,#L722
1688  05fe cd0a50        	call	_bSendSMS
1690  0601 5b03          	addw	sp,#3
1691  0603               L742:
1692                     ; 339 	if (strstr(uart_buffer, "CURRENT1"))
1694  0603 ae0175        	ldw	x,#L114
1695  0606 89            	pushw	x
1696  0607 96            	ldw	x,sp
1697  0608 1c0026        	addw	x,#OFST-84
1698  060b cd0000        	call	_strstr
1700  060e 5b02          	addw	sp,#2
1701  0610 a30000        	cpw	x,#0
1702  0613 2716          	jreq	L704
1703                     ; 341 		sendSMSCurrent(Ampere_Phase1, cell_num); //Changed by Saqib
1705  0615 96            	ldw	x,sp
1706  0616 1c0012        	addw	x,#OFST-104
1707  0619 89            	pushw	x
1708  061a ce0002        	ldw	x,_Ampere_Phase1+2
1709  061d 89            	pushw	x
1710  061e ce0000        	ldw	x,_Ampere_Phase1
1711  0621 89            	pushw	x
1712  0622 cd0cbe        	call	_sendSMSCurrent
1714  0625 5b06          	addw	sp,#6
1716  0627 ac3b0a3b      	jpf	L314
1717  062b               L704:
1718                     ; 343 	else if ((strstr(uart_buffer, "VOLTAGE1")))
1720  062b ae016c        	ldw	x,#L714
1721  062e 89            	pushw	x
1722  062f 96            	ldw	x,sp
1723  0630 1c0026        	addw	x,#OFST-84
1724  0633 cd0000        	call	_strstr
1726  0636 5b02          	addw	sp,#2
1727  0638 a30000        	cpw	x,#0
1728  063b 2716          	jreq	L514
1729                     ; 345 		sendSMSVoltage(Voltage_Phase1, cell_num); //Changed by Saqib
1731  063d 96            	ldw	x,sp
1732  063e 1c0012        	addw	x,#OFST-104
1733  0641 89            	pushw	x
1734  0642 ce0002        	ldw	x,_Voltage_Phase1+2
1735  0645 89            	pushw	x
1736  0646 ce0000        	ldw	x,_Voltage_Phase1
1737  0649 89            	pushw	x
1738  064a cd0da8        	call	_sendSMSVoltage
1740  064d 5b06          	addw	sp,#6
1742  064f ac3b0a3b      	jpf	L314
1743  0653               L514:
1744                     ; 347 	else if ((strstr(uart_buffer, "POWER1")))
1746  0653 ae0165        	ldw	x,#L524
1747  0656 89            	pushw	x
1748  0657 96            	ldw	x,sp
1749  0658 1c0026        	addw	x,#OFST-84
1750  065b cd0000        	call	_strstr
1752  065e 5b02          	addw	sp,#2
1753  0660 a30000        	cpw	x,#0
1754  0663 2716          	jreq	L324
1755                     ; 349 		sendSMSPower(Watt_Phase1, cell_num); //Changed by Saqib
1757  0665 96            	ldw	x,sp
1758  0666 1c0012        	addw	x,#OFST-104
1759  0669 89            	pushw	x
1760  066a ce0002        	ldw	x,_Watt_Phase1+2
1761  066d 89            	pushw	x
1762  066e ce0000        	ldw	x,_Watt_Phase1
1763  0671 89            	pushw	x
1764  0672 cd0e92        	call	_sendSMSPower
1766  0675 5b06          	addw	sp,#6
1768  0677 ac3b0a3b      	jpf	L314
1769  067b               L324:
1770                     ; 351 	else if (strstr(uart_buffer, "CURRENT2"))
1772  067b ae015c        	ldw	x,#L334
1773  067e 89            	pushw	x
1774  067f 96            	ldw	x,sp
1775  0680 1c0026        	addw	x,#OFST-84
1776  0683 cd0000        	call	_strstr
1778  0686 5b02          	addw	sp,#2
1779  0688 a30000        	cpw	x,#0
1780  068b 2716          	jreq	L134
1781                     ; 353 		sendSMSCurrent(Ampere_Phase2, cell_num); //Changed by Saqib
1783  068d 96            	ldw	x,sp
1784  068e 1c0012        	addw	x,#OFST-104
1785  0691 89            	pushw	x
1786  0692 ce0002        	ldw	x,_Ampere_Phase2+2
1787  0695 89            	pushw	x
1788  0696 ce0000        	ldw	x,_Ampere_Phase2
1789  0699 89            	pushw	x
1790  069a cd0cbe        	call	_sendSMSCurrent
1792  069d 5b06          	addw	sp,#6
1794  069f ac3b0a3b      	jpf	L314
1795  06a3               L134:
1796                     ; 355 	else if ((strstr(uart_buffer, "VOLTAGE2")))
1798  06a3 ae0153        	ldw	x,#L144
1799  06a6 89            	pushw	x
1800  06a7 96            	ldw	x,sp
1801  06a8 1c0026        	addw	x,#OFST-84
1802  06ab cd0000        	call	_strstr
1804  06ae 5b02          	addw	sp,#2
1805  06b0 a30000        	cpw	x,#0
1806  06b3 2716          	jreq	L734
1807                     ; 357 		sendSMSVoltage(Voltage_Phase2, cell_num); //Changed by Saqib
1809  06b5 96            	ldw	x,sp
1810  06b6 1c0012        	addw	x,#OFST-104
1811  06b9 89            	pushw	x
1812  06ba ce0002        	ldw	x,_Voltage_Phase2+2
1813  06bd 89            	pushw	x
1814  06be ce0000        	ldw	x,_Voltage_Phase2
1815  06c1 89            	pushw	x
1816  06c2 cd0da8        	call	_sendSMSVoltage
1818  06c5 5b06          	addw	sp,#6
1820  06c7 ac3b0a3b      	jpf	L314
1821  06cb               L734:
1822                     ; 359 	else if ((strstr(uart_buffer, "POWER2")))
1824  06cb ae014c        	ldw	x,#L744
1825  06ce 89            	pushw	x
1826  06cf 96            	ldw	x,sp
1827  06d0 1c0026        	addw	x,#OFST-84
1828  06d3 cd0000        	call	_strstr
1830  06d6 5b02          	addw	sp,#2
1831  06d8 a30000        	cpw	x,#0
1832  06db 2716          	jreq	L544
1833                     ; 361 		sendSMSPower(Watt_Phase2, cell_num); //Changed by Saqib
1835  06dd 96            	ldw	x,sp
1836  06de 1c0012        	addw	x,#OFST-104
1837  06e1 89            	pushw	x
1838  06e2 ce0002        	ldw	x,_Watt_Phase2+2
1839  06e5 89            	pushw	x
1840  06e6 ce0000        	ldw	x,_Watt_Phase2
1841  06e9 89            	pushw	x
1842  06ea cd0e92        	call	_sendSMSPower
1844  06ed 5b06          	addw	sp,#6
1846  06ef ac3b0a3b      	jpf	L314
1847  06f3               L544:
1848                     ; 363 	else if (strstr(uart_buffer, "CURRENT3"))
1850  06f3 ae0143        	ldw	x,#L554
1851  06f6 89            	pushw	x
1852  06f7 96            	ldw	x,sp
1853  06f8 1c0026        	addw	x,#OFST-84
1854  06fb cd0000        	call	_strstr
1856  06fe 5b02          	addw	sp,#2
1857  0700 a30000        	cpw	x,#0
1858  0703 2716          	jreq	L354
1859                     ; 365 		sendSMSCurrent(Ampere_Phase3, cell_num); //Changed by Saqib
1861  0705 96            	ldw	x,sp
1862  0706 1c0012        	addw	x,#OFST-104
1863  0709 89            	pushw	x
1864  070a ce0002        	ldw	x,_Ampere_Phase3+2
1865  070d 89            	pushw	x
1866  070e ce0000        	ldw	x,_Ampere_Phase3
1867  0711 89            	pushw	x
1868  0712 cd0cbe        	call	_sendSMSCurrent
1870  0715 5b06          	addw	sp,#6
1872  0717 ac3b0a3b      	jpf	L314
1873  071b               L354:
1874                     ; 367 	else if ((strstr(uart_buffer, "VOLTAGE3")))
1876  071b ae013a        	ldw	x,#L364
1877  071e 89            	pushw	x
1878  071f 96            	ldw	x,sp
1879  0720 1c0026        	addw	x,#OFST-84
1880  0723 cd0000        	call	_strstr
1882  0726 5b02          	addw	sp,#2
1883  0728 a30000        	cpw	x,#0
1884  072b 2716          	jreq	L164
1885                     ; 369 		sendSMSVoltage(Voltage_Phase3, cell_num); //Changed by Saqib
1887  072d 96            	ldw	x,sp
1888  072e 1c0012        	addw	x,#OFST-104
1889  0731 89            	pushw	x
1890  0732 ce0002        	ldw	x,_Voltage_Phase3+2
1891  0735 89            	pushw	x
1892  0736 ce0000        	ldw	x,_Voltage_Phase3
1893  0739 89            	pushw	x
1894  073a cd0da8        	call	_sendSMSVoltage
1896  073d 5b06          	addw	sp,#6
1898  073f ac3b0a3b      	jpf	L314
1899  0743               L164:
1900                     ; 371 	else if ((strstr(uart_buffer, "POWER3")))
1902  0743 ae0133        	ldw	x,#L174
1903  0746 89            	pushw	x
1904  0747 96            	ldw	x,sp
1905  0748 1c0026        	addw	x,#OFST-84
1906  074b cd0000        	call	_strstr
1908  074e 5b02          	addw	sp,#2
1909  0750 a30000        	cpw	x,#0
1910  0753 2716          	jreq	L764
1911                     ; 373 		sendSMSPower(Watt_Phase3, cell_num); //Changed by Saqib
1913  0755 96            	ldw	x,sp
1914  0756 1c0012        	addw	x,#OFST-104
1915  0759 89            	pushw	x
1916  075a ce0002        	ldw	x,_Watt_Phase3+2
1917  075d 89            	pushw	x
1918  075e ce0000        	ldw	x,_Watt_Phase3
1919  0761 89            	pushw	x
1920  0762 cd0e92        	call	_sendSMSPower
1922  0765 5b06          	addw	sp,#6
1924  0767 ac3b0a3b      	jpf	L314
1925  076b               L764:
1926                     ; 375 	else if ((strstr(uart_buffer, "RADIATOR-TEMP")))
1928  076b ae0125        	ldw	x,#L774
1929  076e 89            	pushw	x
1930  076f 96            	ldw	x,sp
1931  0770 1c0026        	addw	x,#OFST-84
1932  0773 cd0000        	call	_strstr
1934  0776 5b02          	addw	sp,#2
1935  0778 a30000        	cpw	x,#0
1936  077b 2603          	jrne	L621
1937  077d cc083e        	jp	L574
1938  0780               L621:
1939                     ; 377 		myVar = (uint32_t)(Temperature1 * 100);
1941  0780 ae0000        	ldw	x,#_Temperature1
1942  0783 cd0000        	call	c_ltor
1944  0786 ae0121        	ldw	x,#L505
1945  0789 cd0000        	call	c_fmul
1947  078c cd0000        	call	c_ftol
1949  078f 96            	ldw	x,sp
1950  0790 1c0001        	addw	x,#OFST-121
1951  0793 cd0000        	call	c_rtol
1954                     ; 378 		vClearBuffer(uart_buffer, 85);
1956  0796 4b55          	push	#85
1957  0798 96            	ldw	x,sp
1958  0799 1c0025        	addw	x,#OFST-85
1959  079c cd0000        	call	_vClearBuffer
1961  079f 84            	pop	a
1962                     ; 379 		strcpy(uart_buffer, "Radiator Temperature: ");
1964  07a0 96            	ldw	x,sp
1965  07a1 1c0024        	addw	x,#OFST-86
1966  07a4 90ae010a      	ldw	y,#L115
1967  07a8               L411:
1968  07a8 90f6          	ld	a,(y)
1969  07aa 905c          	incw	y
1970  07ac f7            	ld	(x),a
1971  07ad 5c            	incw	x
1972  07ae 4d            	tnz	a
1973  07af 26f7          	jrne	L411
1974                     ; 380 		sprintf(temp1, "%ld", myVar / 100);
1976  07b1 96            	ldw	x,sp
1977  07b2 1c0001        	addw	x,#OFST-121
1978  07b5 cd0000        	call	c_ltor
1980  07b8 ae000a        	ldw	x,#L611
1981  07bb cd0000        	call	c_ludv
1983  07be be02          	ldw	x,c_lreg+2
1984  07c0 89            	pushw	x
1985  07c1 be00          	ldw	x,c_lreg
1986  07c3 89            	pushw	x
1987  07c4 ae0106        	ldw	x,#L315
1988  07c7 89            	pushw	x
1989  07c8 96            	ldw	x,sp
1990  07c9 1c000c        	addw	x,#OFST-110
1991  07cc cd0000        	call	_sprintf
1993  07cf 5b06          	addw	sp,#6
1994                     ; 381 		strcat(uart_buffer, temp1);
1996  07d1 96            	ldw	x,sp
1997  07d2 1c0006        	addw	x,#OFST-116
1998  07d5 89            	pushw	x
1999  07d6 96            	ldw	x,sp
2000  07d7 1c0026        	addw	x,#OFST-84
2001  07da cd0000        	call	_strcat
2003  07dd 85            	popw	x
2004                     ; 382 		strcat(uart_buffer, ".");
2006  07de ae0104        	ldw	x,#L515
2007  07e1 89            	pushw	x
2008  07e2 96            	ldw	x,sp
2009  07e3 1c0026        	addw	x,#OFST-84
2010  07e6 cd0000        	call	_strcat
2012  07e9 85            	popw	x
2013                     ; 383 		sprintf(temp1, "%ld", myVar % 100);
2015  07ea 96            	ldw	x,sp
2016  07eb 1c0001        	addw	x,#OFST-121
2017  07ee cd0000        	call	c_ltor
2019  07f1 ae000a        	ldw	x,#L611
2020  07f4 cd0000        	call	c_lumd
2022  07f7 be02          	ldw	x,c_lreg+2
2023  07f9 89            	pushw	x
2024  07fa be00          	ldw	x,c_lreg
2025  07fc 89            	pushw	x
2026  07fd ae0106        	ldw	x,#L315
2027  0800 89            	pushw	x
2028  0801 96            	ldw	x,sp
2029  0802 1c000c        	addw	x,#OFST-110
2030  0805 cd0000        	call	_sprintf
2032  0808 5b06          	addw	sp,#6
2033                     ; 384 		strcat(uart_buffer, temp1);
2035  080a 96            	ldw	x,sp
2036  080b 1c0006        	addw	x,#OFST-116
2037  080e 89            	pushw	x
2038  080f 96            	ldw	x,sp
2039  0810 1c0026        	addw	x,#OFST-84
2040  0813 cd0000        	call	_strcat
2042  0816 85            	popw	x
2043                     ; 385 		strcat(uart_buffer, " C");
2045  0817 ae0101        	ldw	x,#L715
2046  081a 89            	pushw	x
2047  081b 96            	ldw	x,sp
2048  081c 1c0026        	addw	x,#OFST-84
2049  081f cd0000        	call	_strcat
2051  0822 85            	popw	x
2052                     ; 386 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2054  0823 96            	ldw	x,sp
2055  0824 1c0012        	addw	x,#OFST-104
2056  0827 89            	pushw	x
2057  0828 96            	ldw	x,sp
2058  0829 1c0026        	addw	x,#OFST-84
2059  082c cd0000        	call	_strlen
2061  082f 9f            	ld	a,xl
2062  0830 88            	push	a
2063  0831 96            	ldw	x,sp
2064  0832 1c0027        	addw	x,#OFST-83
2065  0835 cd0a50        	call	_bSendSMS
2067  0838 5b03          	addw	sp,#3
2069  083a ac3b0a3b      	jpf	L314
2070  083e               L574:
2071                     ; 388 	else if ((strstr(uart_buffer, "ENGINE-TEMP")))
2073  083e ae00f5        	ldw	x,#L525
2074  0841 89            	pushw	x
2075  0842 96            	ldw	x,sp
2076  0843 1c0026        	addw	x,#OFST-84
2077  0846 cd0000        	call	_strstr
2079  0849 5b02          	addw	sp,#2
2080  084b a30000        	cpw	x,#0
2081  084e 2603          	jrne	L031
2082  0850 cc0911        	jp	L325
2083  0853               L031:
2084                     ; 390 		myVar = (uint32_t)(Temperature2 * 100);
2086  0853 ae0000        	ldw	x,#_Temperature2
2087  0856 cd0000        	call	c_ltor
2089  0859 ae0121        	ldw	x,#L505
2090  085c cd0000        	call	c_fmul
2092  085f cd0000        	call	c_ftol
2094  0862 96            	ldw	x,sp
2095  0863 1c0001        	addw	x,#OFST-121
2096  0866 cd0000        	call	c_rtol
2099                     ; 391 		vClearBuffer(uart_buffer, 85);
2101  0869 4b55          	push	#85
2102  086b 96            	ldw	x,sp
2103  086c 1c0025        	addw	x,#OFST-85
2104  086f cd0000        	call	_vClearBuffer
2106  0872 84            	pop	a
2107                     ; 392 		strcpy(uart_buffer, "Engine Temperature: ");
2109  0873 96            	ldw	x,sp
2110  0874 1c0024        	addw	x,#OFST-86
2111  0877 90ae00e0      	ldw	y,#L725
2112  087b               L021:
2113  087b 90f6          	ld	a,(y)
2114  087d 905c          	incw	y
2115  087f f7            	ld	(x),a
2116  0880 5c            	incw	x
2117  0881 4d            	tnz	a
2118  0882 26f7          	jrne	L021
2119                     ; 393 		sprintf(temp1, "%ld", myVar / 100);
2121  0884 96            	ldw	x,sp
2122  0885 1c0001        	addw	x,#OFST-121
2123  0888 cd0000        	call	c_ltor
2125  088b ae000a        	ldw	x,#L611
2126  088e cd0000        	call	c_ludv
2128  0891 be02          	ldw	x,c_lreg+2
2129  0893 89            	pushw	x
2130  0894 be00          	ldw	x,c_lreg
2131  0896 89            	pushw	x
2132  0897 ae0106        	ldw	x,#L315
2133  089a 89            	pushw	x
2134  089b 96            	ldw	x,sp
2135  089c 1c000c        	addw	x,#OFST-110
2136  089f cd0000        	call	_sprintf
2138  08a2 5b06          	addw	sp,#6
2139                     ; 394 		strcat(uart_buffer, temp1);
2141  08a4 96            	ldw	x,sp
2142  08a5 1c0006        	addw	x,#OFST-116
2143  08a8 89            	pushw	x
2144  08a9 96            	ldw	x,sp
2145  08aa 1c0026        	addw	x,#OFST-84
2146  08ad cd0000        	call	_strcat
2148  08b0 85            	popw	x
2149                     ; 395 		strcat(uart_buffer, ".");
2151  08b1 ae0104        	ldw	x,#L515
2152  08b4 89            	pushw	x
2153  08b5 96            	ldw	x,sp
2154  08b6 1c0026        	addw	x,#OFST-84
2155  08b9 cd0000        	call	_strcat
2157  08bc 85            	popw	x
2158                     ; 396 		sprintf(temp1, "%ld", myVar % 100);
2160  08bd 96            	ldw	x,sp
2161  08be 1c0001        	addw	x,#OFST-121
2162  08c1 cd0000        	call	c_ltor
2164  08c4 ae000a        	ldw	x,#L611
2165  08c7 cd0000        	call	c_lumd
2167  08ca be02          	ldw	x,c_lreg+2
2168  08cc 89            	pushw	x
2169  08cd be00          	ldw	x,c_lreg
2170  08cf 89            	pushw	x
2171  08d0 ae0106        	ldw	x,#L315
2172  08d3 89            	pushw	x
2173  08d4 96            	ldw	x,sp
2174  08d5 1c000c        	addw	x,#OFST-110
2175  08d8 cd0000        	call	_sprintf
2177  08db 5b06          	addw	sp,#6
2178                     ; 397 		strcat(uart_buffer, temp1);
2180  08dd 96            	ldw	x,sp
2181  08de 1c0006        	addw	x,#OFST-116
2182  08e1 89            	pushw	x
2183  08e2 96            	ldw	x,sp
2184  08e3 1c0026        	addw	x,#OFST-84
2185  08e6 cd0000        	call	_strcat
2187  08e9 85            	popw	x
2188                     ; 398 		strcat(uart_buffer, " C");
2190  08ea ae0101        	ldw	x,#L715
2191  08ed 89            	pushw	x
2192  08ee 96            	ldw	x,sp
2193  08ef 1c0026        	addw	x,#OFST-84
2194  08f2 cd0000        	call	_strcat
2196  08f5 85            	popw	x
2197                     ; 399 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2199  08f6 96            	ldw	x,sp
2200  08f7 1c0012        	addw	x,#OFST-104
2201  08fa 89            	pushw	x
2202  08fb 96            	ldw	x,sp
2203  08fc 1c0026        	addw	x,#OFST-84
2204  08ff cd0000        	call	_strlen
2206  0902 9f            	ld	a,xl
2207  0903 88            	push	a
2208  0904 96            	ldw	x,sp
2209  0905 1c0027        	addw	x,#OFST-83
2210  0908 cd0a50        	call	_bSendSMS
2212  090b 5b03          	addw	sp,#3
2214  090d ac3b0a3b      	jpf	L314
2215  0911               L325:
2216                     ; 401 	else if ((strstr(uart_buffer, "BATTERY-VOLT")))
2218  0911 ae00d3        	ldw	x,#L535
2219  0914 89            	pushw	x
2220  0915 96            	ldw	x,sp
2221  0916 1c0026        	addw	x,#OFST-84
2222  0919 cd0000        	call	_strstr
2224  091c 5b02          	addw	sp,#2
2225  091e a30000        	cpw	x,#0
2226  0921 2603          	jrne	L231
2227  0923 cc09ca        	jp	L335
2228  0926               L231:
2229                     ; 404 		vClearBuffer(uart_buffer, 85);
2231  0926 4b55          	push	#85
2232  0928 96            	ldw	x,sp
2233  0929 1c0025        	addw	x,#OFST-85
2234  092c cd0000        	call	_vClearBuffer
2236  092f 84            	pop	a
2237                     ; 405 		strcpy(uart_buffer, "Battery: ");
2239  0930 96            	ldw	x,sp
2240  0931 1c0024        	addw	x,#OFST-86
2241  0934 90ae00c9      	ldw	y,#L735
2242  0938               L221:
2243  0938 90f6          	ld	a,(y)
2244  093a 905c          	incw	y
2245  093c f7            	ld	(x),a
2246  093d 5c            	incw	x
2247  093e 4d            	tnz	a
2248  093f 26f7          	jrne	L221
2249                     ; 406 		sprintf(temp1, "%ld", batVolt / 100);
2251  0941 ae0000        	ldw	x,#_batVolt
2252  0944 cd0000        	call	c_ltor
2254  0947 ae000a        	ldw	x,#L611
2255  094a cd0000        	call	c_ludv
2257  094d be02          	ldw	x,c_lreg+2
2258  094f 89            	pushw	x
2259  0950 be00          	ldw	x,c_lreg
2260  0952 89            	pushw	x
2261  0953 ae0106        	ldw	x,#L315
2262  0956 89            	pushw	x
2263  0957 96            	ldw	x,sp
2264  0958 1c000c        	addw	x,#OFST-110
2265  095b cd0000        	call	_sprintf
2267  095e 5b06          	addw	sp,#6
2268                     ; 407 		strcat(uart_buffer, temp1);
2270  0960 96            	ldw	x,sp
2271  0961 1c0006        	addw	x,#OFST-116
2272  0964 89            	pushw	x
2273  0965 96            	ldw	x,sp
2274  0966 1c0026        	addw	x,#OFST-84
2275  0969 cd0000        	call	_strcat
2277  096c 85            	popw	x
2278                     ; 408 		strcat(uart_buffer, ".");
2280  096d ae0104        	ldw	x,#L515
2281  0970 89            	pushw	x
2282  0971 96            	ldw	x,sp
2283  0972 1c0026        	addw	x,#OFST-84
2284  0975 cd0000        	call	_strcat
2286  0978 85            	popw	x
2287                     ; 409 		sprintf(temp1, "%ld", batVolt % 100);
2289  0979 ae0000        	ldw	x,#_batVolt
2290  097c cd0000        	call	c_ltor
2292  097f ae000a        	ldw	x,#L611
2293  0982 cd0000        	call	c_lumd
2295  0985 be02          	ldw	x,c_lreg+2
2296  0987 89            	pushw	x
2297  0988 be00          	ldw	x,c_lreg
2298  098a 89            	pushw	x
2299  098b ae0106        	ldw	x,#L315
2300  098e 89            	pushw	x
2301  098f 96            	ldw	x,sp
2302  0990 1c000c        	addw	x,#OFST-110
2303  0993 cd0000        	call	_sprintf
2305  0996 5b06          	addw	sp,#6
2306                     ; 410 		strcat(uart_buffer, temp1);
2308  0998 96            	ldw	x,sp
2309  0999 1c0006        	addw	x,#OFST-116
2310  099c 89            	pushw	x
2311  099d 96            	ldw	x,sp
2312  099e 1c0026        	addw	x,#OFST-84
2313  09a1 cd0000        	call	_strcat
2315  09a4 85            	popw	x
2316                     ; 411 		strcat(uart_buffer, " Volts");
2318  09a5 ae00c2        	ldw	x,#L145
2319  09a8 89            	pushw	x
2320  09a9 96            	ldw	x,sp
2321  09aa 1c0026        	addw	x,#OFST-84
2322  09ad cd0000        	call	_strcat
2324  09b0 85            	popw	x
2325                     ; 412 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2327  09b1 96            	ldw	x,sp
2328  09b2 1c0012        	addw	x,#OFST-104
2329  09b5 89            	pushw	x
2330  09b6 96            	ldw	x,sp
2331  09b7 1c0026        	addw	x,#OFST-84
2332  09ba cd0000        	call	_strlen
2334  09bd 9f            	ld	a,xl
2335  09be 88            	push	a
2336  09bf 96            	ldw	x,sp
2337  09c0 1c0027        	addw	x,#OFST-83
2338  09c3 cd0a50        	call	_bSendSMS
2340  09c6 5b03          	addw	sp,#3
2342  09c8 2071          	jra	L314
2343  09ca               L335:
2344                     ; 414 	else if ((strstr(uart_buffer, "FUEL-LEVEL")))
2346  09ca ae00b7        	ldw	x,#L745
2347  09cd 89            	pushw	x
2348  09ce 96            	ldw	x,sp
2349  09cf 1c0026        	addw	x,#OFST-84
2350  09d2 cd0000        	call	_strstr
2352  09d5 5b02          	addw	sp,#2
2353  09d7 a30000        	cpw	x,#0
2354  09da 275f          	jreq	L314
2355                     ; 416 		vClearBuffer(uart_buffer, 85);
2357  09dc 4b55          	push	#85
2358  09de 96            	ldw	x,sp
2359  09df 1c0025        	addw	x,#OFST-85
2360  09e2 cd0000        	call	_vClearBuffer
2362  09e5 84            	pop	a
2363                     ; 417 		strcpy(uart_buffer, "Fuel: ");
2365  09e6 96            	ldw	x,sp
2366  09e7 1c0024        	addw	x,#OFST-86
2367  09ea 90ae00b0      	ldw	y,#L155
2368  09ee               L421:
2369  09ee 90f6          	ld	a,(y)
2370  09f0 905c          	incw	y
2371  09f2 f7            	ld	(x),a
2372  09f3 5c            	incw	x
2373  09f4 4d            	tnz	a
2374  09f5 26f7          	jrne	L421
2375                     ; 418 		sprintf(temp1, "%ld", Fuellevel);
2377  09f7 ce0002        	ldw	x,_Fuellevel+2
2378  09fa 89            	pushw	x
2379  09fb ce0000        	ldw	x,_Fuellevel
2380  09fe 89            	pushw	x
2381  09ff ae0106        	ldw	x,#L315
2382  0a02 89            	pushw	x
2383  0a03 96            	ldw	x,sp
2384  0a04 1c000c        	addw	x,#OFST-110
2385  0a07 cd0000        	call	_sprintf
2387  0a0a 5b06          	addw	sp,#6
2388                     ; 419 		strcat(uart_buffer, temp1);
2390  0a0c 96            	ldw	x,sp
2391  0a0d 1c0006        	addw	x,#OFST-116
2392  0a10 89            	pushw	x
2393  0a11 96            	ldw	x,sp
2394  0a12 1c0026        	addw	x,#OFST-84
2395  0a15 cd0000        	call	_strcat
2397  0a18 85            	popw	x
2398                     ; 420 		strcat(uart_buffer, " Value");
2400  0a19 ae00a9        	ldw	x,#L355
2401  0a1c 89            	pushw	x
2402  0a1d 96            	ldw	x,sp
2403  0a1e 1c0026        	addw	x,#OFST-84
2404  0a21 cd0000        	call	_strcat
2406  0a24 85            	popw	x
2407                     ; 421 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
2409  0a25 96            	ldw	x,sp
2410  0a26 1c0012        	addw	x,#OFST-104
2411  0a29 89            	pushw	x
2412  0a2a 96            	ldw	x,sp
2413  0a2b 1c0026        	addw	x,#OFST-84
2414  0a2e cd0000        	call	_strlen
2416  0a31 9f            	ld	a,xl
2417  0a32 88            	push	a
2418  0a33 96            	ldw	x,sp
2419  0a34 1c0027        	addw	x,#OFST-83
2420  0a37 ad17          	call	_bSendSMS
2422  0a39 5b03          	addw	sp,#3
2423  0a3b               L314:
2424                     ; 424 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2426  0a3b 4b01          	push	#1
2427  0a3d ae0255        	ldw	x,#597
2428  0a40 cd0000        	call	_UART1_ITConfig
2430  0a43 84            	pop	a
2431                     ; 425 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2433  0a44 4b01          	push	#1
2434  0a46 ae0244        	ldw	x,#580
2435  0a49 cd0000        	call	_UART1_ITConfig
2437  0a4c 84            	pop	a
2438                     ; 426 }
2441  0a4d 5b7a          	addw	sp,#122
2442  0a4f 81            	ret
2445                     	switch	.const
2446  000e               L555_buffer:
2447  000e 41542b434d47  	dc.b	"AT+CMGS=",34
2448  0017 2b3932333331  	dc.b	"+923316821907",34,0
2547                     ; 428 bool bSendSMS(char *message, uint8_t messageLength, char *Number)
2547                     ; 429 {
2548                     	switch	.text
2549  0a50               _bSendSMS:
2551  0a50 89            	pushw	x
2552  0a51 5235          	subw	sp,#53
2553       00000035      OFST:	set	53
2556                     ; 430 	uint8_t buffer[24] = "AT+CMGS=\"+923316821907\"";
2558  0a53 96            	ldw	x,sp
2559  0a54 1c0005        	addw	x,#OFST-48
2560  0a57 90ae000e      	ldw	y,#L555_buffer
2561  0a5b a618          	ld	a,#24
2562  0a5d cd0000        	call	c_xymvx
2564                     ; 433 	uint32_t whileTimeout = 650000;
2566  0a60 aeeb10        	ldw	x,#60176
2567  0a63 1f03          	ldw	(OFST-50,sp),x
2568  0a65 ae0009        	ldw	x,#9
2569  0a68 1f01          	ldw	(OFST-52,sp),x
2571                     ; 434 	delay_ms(2000);
2573  0a6a ae07d0        	ldw	x,#2000
2574  0a6d cd0000        	call	_delay_ms
2576                     ; 435 	for (i = 10; i < 22; i++)
2578  0a70 a60a          	ld	a,#10
2579  0a72 6b35          	ld	(OFST+0,sp),a
2581  0a74               L526:
2582                     ; 437 		buffer[i] = *(Number + (i - 9));
2584  0a74 96            	ldw	x,sp
2585  0a75 1c0005        	addw	x,#OFST-48
2586  0a78 9f            	ld	a,xl
2587  0a79 5e            	swapw	x
2588  0a7a 1b35          	add	a,(OFST+0,sp)
2589  0a7c 2401          	jrnc	L631
2590  0a7e 5c            	incw	x
2591  0a7f               L631:
2592  0a7f 02            	rlwa	x,a
2593  0a80 7b35          	ld	a,(OFST+0,sp)
2594  0a82 905f          	clrw	y
2595  0a84 9097          	ld	yl,a
2596  0a86 72a20009      	subw	y,#9
2597  0a8a 72f93b        	addw	y,(OFST+6,sp)
2598  0a8d 90f6          	ld	a,(y)
2599  0a8f f7            	ld	(x),a
2600                     ; 435 	for (i = 10; i < 22; i++)
2602  0a90 0c35          	inc	(OFST+0,sp)
2606  0a92 7b35          	ld	a,(OFST+0,sp)
2607  0a94 a116          	cp	a,#22
2608  0a96 25dc          	jrult	L526
2609                     ; 439 	i++;
2611  0a98 0c35          	inc	(OFST+0,sp)
2613                     ; 440 	buffer[i] = '\0';
2615  0a9a 96            	ldw	x,sp
2616  0a9b 1c0005        	addw	x,#OFST-48
2617  0a9e 9f            	ld	a,xl
2618  0a9f 5e            	swapw	x
2619  0aa0 1b35          	add	a,(OFST+0,sp)
2620  0aa2 2401          	jrnc	L041
2621  0aa4 5c            	incw	x
2622  0aa5               L041:
2623  0aa5 02            	rlwa	x,a
2624  0aa6 7f            	clr	(x)
2625                     ; 442 	ms_send_cmd(buffer, strlen((const char *)buffer));
2627  0aa7 96            	ldw	x,sp
2628  0aa8 1c0005        	addw	x,#OFST-48
2629  0aab cd0000        	call	_strlen
2631  0aae 9f            	ld	a,xl
2632  0aaf 88            	push	a
2633  0ab0 96            	ldw	x,sp
2634  0ab1 1c0006        	addw	x,#OFST-47
2635  0ab4 cd0000        	call	_ms_send_cmd
2637  0ab7 84            	pop	a
2638                     ; 443 	delay_ms(20);
2640  0ab8 ae0014        	ldw	x,#20
2641  0abb cd0000        	call	_delay_ms
2643                     ; 445 	for (i = 0; i < messageLength; i++)
2645  0abe 0f35          	clr	(OFST+0,sp)
2648  0ac0 2016          	jra	L736
2649  0ac2               L546:
2650                     ; 447 		while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2652  0ac2 ae0040        	ldw	x,#64
2653  0ac5 cd0000        	call	_UART1_GetFlagStatus
2655  0ac8 4d            	tnz	a
2656  0ac9 27f7          	jreq	L546
2657                     ; 449 		UART1_SendData8(*(message + i));
2659  0acb 7b35          	ld	a,(OFST+0,sp)
2660  0acd 5f            	clrw	x
2661  0ace 97            	ld	xl,a
2662  0acf 72fb36        	addw	x,(OFST+1,sp)
2663  0ad2 f6            	ld	a,(x)
2664  0ad3 cd0000        	call	_UART1_SendData8
2666                     ; 445 	for (i = 0; i < messageLength; i++)
2668  0ad6 0c35          	inc	(OFST+0,sp)
2670  0ad8               L736:
2673  0ad8 7b35          	ld	a,(OFST+0,sp)
2674  0ada 113a          	cp	a,(OFST+5,sp)
2675  0adc 25e4          	jrult	L546
2676                     ; 451 	delay_ms(10);
2678  0ade ae000a        	ldw	x,#10
2679  0ae1 cd0000        	call	_delay_ms
2682  0ae4               L356:
2683                     ; 452 	while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2685  0ae4 ae0040        	ldw	x,#64
2686  0ae7 cd0000        	call	_UART1_GetFlagStatus
2688  0aea 4d            	tnz	a
2689  0aeb 27f7          	jreq	L356
2690                     ; 454 	UART1_SendData8(0x1A);
2692  0aed a61a          	ld	a,#26
2693  0aef cd0000        	call	_UART1_SendData8
2695                     ; 455 	delay_ms(200); // Wait for 2 Seconds to check response of Module if SMS has been send or not
2697  0af2 ae00c8        	ldw	x,#200
2698  0af5 cd0000        	call	_delay_ms
2700                     ; 457 	tempBuffer[0] = 0;
2702  0af8 0f1d          	clr	(OFST-24,sp)
2704                     ; 458 	tempBuffer[1] = 0;
2706  0afa 0f1e          	clr	(OFST-23,sp)
2709  0afc 2021          	jra	L366
2710  0afe               L176:
2711                     ; 461 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
2713  0afe ae0020        	ldw	x,#32
2714  0b01 cd0000        	call	_UART1_GetFlagStatus
2716  0b04 4d            	tnz	a
2717  0b05 260c          	jrne	L576
2719  0b07 be09          	ldw	x,_timeout
2720  0b09 1c0001        	addw	x,#1
2721  0b0c bf09          	ldw	_timeout,x
2722  0b0e a32710        	cpw	x,#10000
2723  0b11 26eb          	jrne	L176
2724  0b13               L576:
2725                     ; 463 		tempBuffer[0] = tempBuffer[1];
2727  0b13 7b1e          	ld	a,(OFST-23,sp)
2728  0b15 6b1d          	ld	(OFST-24,sp),a
2730                     ; 464 		tempBuffer[1] = UART1_ReceiveData8();
2732  0b17 cd0000        	call	_UART1_ReceiveData8
2734  0b1a 6b1e          	ld	(OFST-23,sp),a
2736                     ; 465 		timeout = 0;
2738  0b1c 5f            	clrw	x
2739  0b1d bf09          	ldw	_timeout,x
2740  0b1f               L366:
2741                     ; 459 	while (tempBuffer[0] != '+' && tempBuffer[1] != 'C' && --whileTimeout > 0)
2743  0b1f 7b1d          	ld	a,(OFST-24,sp)
2744  0b21 a12b          	cp	a,#43
2745  0b23 2718          	jreq	L776
2747  0b25 7b1e          	ld	a,(OFST-23,sp)
2748  0b27 a143          	cp	a,#67
2749  0b29 2712          	jreq	L776
2751  0b2b 96            	ldw	x,sp
2752  0b2c 1c0001        	addw	x,#OFST-52
2753  0b2f a601          	ld	a,#1
2754  0b31 cd0000        	call	c_lgsbc
2757  0b34 96            	ldw	x,sp
2758  0b35 1c0001        	addw	x,#OFST-52
2759  0b38 cd0000        	call	c_lzmp
2761  0b3b 26c1          	jrne	L176
2762  0b3d               L776:
2763                     ; 467 	for (i = 2; i < 23; i++)
2765  0b3d a602          	ld	a,#2
2766  0b3f 6b35          	ld	(OFST+0,sp),a
2768  0b41               L317:
2769                     ; 469 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
2771  0b41 ae0020        	ldw	x,#32
2772  0b44 cd0000        	call	_UART1_GetFlagStatus
2774  0b47 4d            	tnz	a
2775  0b48 260c          	jrne	L717
2777  0b4a be09          	ldw	x,_timeout
2778  0b4c 1c0001        	addw	x,#1
2779  0b4f bf09          	ldw	_timeout,x
2780  0b51 a32710        	cpw	x,#10000
2781  0b54 26eb          	jrne	L317
2782  0b56               L717:
2783                     ; 471 		tempBuffer[i] = UART1_ReceiveData8();
2785  0b56 96            	ldw	x,sp
2786  0b57 1c001d        	addw	x,#OFST-24
2787  0b5a 9f            	ld	a,xl
2788  0b5b 5e            	swapw	x
2789  0b5c 1b35          	add	a,(OFST+0,sp)
2790  0b5e 2401          	jrnc	L241
2791  0b60 5c            	incw	x
2792  0b61               L241:
2793  0b61 02            	rlwa	x,a
2794  0b62 89            	pushw	x
2795  0b63 cd0000        	call	_UART1_ReceiveData8
2797  0b66 85            	popw	x
2798  0b67 f7            	ld	(x),a
2799                     ; 472 		timeout = 0;
2801  0b68 5f            	clrw	x
2802  0b69 bf09          	ldw	_timeout,x
2803                     ; 467 	for (i = 2; i < 23; i++)
2805  0b6b 0c35          	inc	(OFST+0,sp)
2809  0b6d 7b35          	ld	a,(OFST+0,sp)
2810  0b6f a117          	cp	a,#23
2811  0b71 25ce          	jrult	L317
2812                     ; 474 	tempBuffer[i] = '\0';
2814  0b73 96            	ldw	x,sp
2815  0b74 1c001d        	addw	x,#OFST-24
2816  0b77 9f            	ld	a,xl
2817  0b78 5e            	swapw	x
2818  0b79 1b35          	add	a,(OFST+0,sp)
2819  0b7b 2401          	jrnc	L441
2820  0b7d 5c            	incw	x
2821  0b7e               L441:
2822  0b7e 02            	rlwa	x,a
2823  0b7f 7f            	clr	(x)
2824                     ; 476 	if (strstr(tempBuffer, "+CMGS"))
2826  0b80 ae00a3        	ldw	x,#L327
2827  0b83 89            	pushw	x
2828  0b84 96            	ldw	x,sp
2829  0b85 1c001f        	addw	x,#OFST-22
2830  0b88 cd0000        	call	_strstr
2832  0b8b 5b02          	addw	sp,#2
2833  0b8d a30000        	cpw	x,#0
2834  0b90 2704          	jreq	L127
2835                     ; 478 		return TRUE;
2837  0b92 a601          	ld	a,#1
2839  0b94 2001          	jra	L641
2840  0b96               L127:
2841                     ; 482 		return FALSE;
2843  0b96 4f            	clr	a
2845  0b97               L641:
2847  0b97 5b37          	addw	sp,#55
2848  0b99 81            	ret
2851                     	switch	.const
2852  0026               L727_STATUS1:
2853  0026 444f574e4c4f  	dc.b	"DOWNLOAD",0
2928                     ; 486 int GSM_DOWNLOAD(void)
2928                     ; 487 {
2929                     	switch	.text
2930  0b9a               _GSM_DOWNLOAD:
2932  0b9a 5217          	subw	sp,#23
2933       00000017      OFST:	set	23
2936                     ; 490 	const char STATUS1[] = "DOWNLOAD";
2938  0b9c 96            	ldw	x,sp
2939  0b9d 1c0001        	addw	x,#OFST-22
2940  0ba0 90ae0026      	ldw	y,#L727_STATUS1
2941  0ba4 a609          	ld	a,#9
2942  0ba6 cd0000        	call	c_xymvx
2944                     ; 492 	uint16_t gsm_download_timeout = 10000;
2946  0ba9 ae2710        	ldw	x,#10000
2947  0bac 1f15          	ldw	(OFST-2,sp),x
2949                     ; 494 	for (r1 = 0; r1 < 11; r1++)
2951  0bae 0f17          	clr	(OFST+0,sp)
2953  0bb0               L777:
2954                     ; 496 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_download_timeout > 0))
2956  0bb0 ae0020        	ldw	x,#32
2957  0bb3 cd0000        	call	_UART1_GetFlagStatus
2959  0bb6 4d            	tnz	a
2960  0bb7 2609          	jrne	L3001
2962  0bb9 1e15          	ldw	x,(OFST-2,sp)
2963  0bbb 1d0001        	subw	x,#1
2964  0bbe 1f15          	ldw	(OFST-2,sp),x
2966  0bc0 26ee          	jrne	L777
2967  0bc2               L3001:
2968                     ; 498 		response_buffer[r1] = UART1_ReceiveData8();
2970  0bc2 96            	ldw	x,sp
2971  0bc3 1c000a        	addw	x,#OFST-13
2972  0bc6 9f            	ld	a,xl
2973  0bc7 5e            	swapw	x
2974  0bc8 1b17          	add	a,(OFST+0,sp)
2975  0bca 2401          	jrnc	L251
2976  0bcc 5c            	incw	x
2977  0bcd               L251:
2978  0bcd 02            	rlwa	x,a
2979  0bce 89            	pushw	x
2980  0bcf cd0000        	call	_UART1_ReceiveData8
2982  0bd2 85            	popw	x
2983  0bd3 f7            	ld	(x),a
2984                     ; 494 	for (r1 = 0; r1 < 11; r1++)
2986  0bd4 0c17          	inc	(OFST+0,sp)
2990  0bd6 7b17          	ld	a,(OFST+0,sp)
2991  0bd8 a10b          	cp	a,#11
2992  0bda 25d4          	jrult	L777
2993                     ; 501 	ret3 = strstr(response_buffer, STATUS1);
2995  0bdc 96            	ldw	x,sp
2996  0bdd 1c0001        	addw	x,#OFST-22
2997  0be0 89            	pushw	x
2998  0be1 96            	ldw	x,sp
2999  0be2 1c000c        	addw	x,#OFST-11
3000  0be5 cd0000        	call	_strstr
3002  0be8 5b02          	addw	sp,#2
3003  0bea 1f15          	ldw	(OFST-2,sp),x
3005                     ; 503 	if (ret3)
3007  0bec 1e15          	ldw	x,(OFST-2,sp)
3008  0bee 2705          	jreq	L5001
3009                     ; 506 		return 1;
3011  0bf0 ae0001        	ldw	x,#1
3013  0bf3 2001          	jra	L451
3014  0bf5               L5001:
3015                     ; 513 		return 0;
3017  0bf5 5f            	clrw	x
3019  0bf6               L451:
3021  0bf6 5b17          	addw	sp,#23
3022  0bf8 81            	ret
3025                     	switch	.const
3026  002f               L1101_OK:
3027  002f 4f4b00        	dc.b	"OK",0
3092                     ; 517 int GSM_OK_FAST(void)
3092                     ; 518 {
3093                     	switch	.text
3094  0bf9               _GSM_OK_FAST:
3096  0bf9 5206          	subw	sp,#6
3097       00000006      OFST:	set	6
3100                     ; 520 	uint16_t gsm_ok_timeout = 7000;
3102  0bfb ae1b58        	ldw	x,#7000
3103  0bfe 1f04          	ldw	(OFST-2,sp),x
3105                     ; 521 	const char OK[3] = "OK";
3107  0c00 96            	ldw	x,sp
3108  0c01 1c0001        	addw	x,#OFST-5
3109  0c04 90ae002f      	ldw	y,#L1101_OK
3110  0c08 a603          	ld	a,#3
3111  0c0a cd0000        	call	c_xymvx
3113                     ; 524 	for (p = 0; p < 30; p++) //8 for error
3115  0c0d 0f06          	clr	(OFST+0,sp)
3117  0c0f               L5501:
3118                     ; 526 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_ok_timeout > 0))
3120  0c0f ae0020        	ldw	x,#32
3121  0c12 cd0000        	call	_UART1_GetFlagStatus
3123  0c15 4d            	tnz	a
3124  0c16 2609          	jrne	L1601
3126  0c18 1e04          	ldw	x,(OFST-2,sp)
3127  0c1a 1d0001        	subw	x,#1
3128  0c1d 1f04          	ldw	(OFST-2,sp),x
3130  0c1f 26ee          	jrne	L5501
3131  0c21               L1601:
3132                     ; 529 		response_buffer[p] = UART1_ReceiveData8();
3134  0c21 7b06          	ld	a,(OFST+0,sp)
3135  0c23 5f            	clrw	x
3136  0c24 97            	ld	xl,a
3137  0c25 89            	pushw	x
3138  0c26 cd0000        	call	_UART1_ReceiveData8
3140  0c29 85            	popw	x
3141  0c2a d70000        	ld	(_response_buffer,x),a
3142                     ; 524 	for (p = 0; p < 30; p++) //8 for error
3144  0c2d 0c06          	inc	(OFST+0,sp)
3148  0c2f 7b06          	ld	a,(OFST+0,sp)
3149  0c31 a11e          	cp	a,#30
3150  0c33 25da          	jrult	L5501
3151                     ; 532 	ret1 = strstr(response_buffer, OK);
3153  0c35 96            	ldw	x,sp
3154  0c36 1c0001        	addw	x,#OFST-5
3155  0c39 89            	pushw	x
3156  0c3a ae0000        	ldw	x,#_response_buffer
3157  0c3d cd0000        	call	_strstr
3159  0c40 5b02          	addw	sp,#2
3160  0c42 1f04          	ldw	(OFST-2,sp),x
3162                     ; 534 	if (ret1)
3164  0c44 1e04          	ldw	x,(OFST-2,sp)
3165  0c46 2705          	jreq	L3601
3166                     ; 536 		return 1;
3168  0c48 ae0001        	ldw	x,#1
3170  0c4b 2001          	jra	L061
3171  0c4d               L3601:
3172                     ; 542 		return 0;
3174  0c4d 5f            	clrw	x
3176  0c4e               L061:
3178  0c4e 5b06          	addw	sp,#6
3179  0c50 81            	ret
3182                     	switch	.const
3183  0032               L7601_OK:
3184  0032 4f4b00        	dc.b	"OK",0
3249                     ; 545 int GSM_OK(void)
3249                     ; 546 {
3250                     	switch	.text
3251  0c51               _GSM_OK:
3253  0c51 5206          	subw	sp,#6
3254       00000006      OFST:	set	6
3257                     ; 548 	uint16_t gsm_ok_timeout = 30000;
3259  0c53 ae7530        	ldw	x,#30000
3260  0c56 1f04          	ldw	(OFST-2,sp),x
3262                     ; 549 	const char OK[3] = "OK";
3264  0c58 96            	ldw	x,sp
3265  0c59 1c0001        	addw	x,#OFST-5
3266  0c5c 90ae0032      	ldw	y,#L7601_OK
3267  0c60 a603          	ld	a,#3
3268  0c62 cd0000        	call	c_xymvx
3270                     ; 552 	for (p = 0; p < 30; p++) //8 for error
3272  0c65 0f06          	clr	(OFST+0,sp)
3274  0c67               L3311:
3275                     ; 554 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_ok_timeout > 0))
3277  0c67 ae0020        	ldw	x,#32
3278  0c6a cd0000        	call	_UART1_GetFlagStatus
3280  0c6d 4d            	tnz	a
3281  0c6e 2609          	jrne	L7311
3283  0c70 1e04          	ldw	x,(OFST-2,sp)
3284  0c72 1d0001        	subw	x,#1
3285  0c75 1f04          	ldw	(OFST-2,sp),x
3287  0c77 26ee          	jrne	L3311
3288  0c79               L7311:
3289                     ; 557 		response_buffer[p] = UART1_ReceiveData8();
3291  0c79 7b06          	ld	a,(OFST+0,sp)
3292  0c7b 5f            	clrw	x
3293  0c7c 97            	ld	xl,a
3294  0c7d 89            	pushw	x
3295  0c7e cd0000        	call	_UART1_ReceiveData8
3297  0c81 85            	popw	x
3298  0c82 d70000        	ld	(_response_buffer,x),a
3299                     ; 552 	for (p = 0; p < 30; p++) //8 for error
3301  0c85 0c06          	inc	(OFST+0,sp)
3305  0c87 7b06          	ld	a,(OFST+0,sp)
3306  0c89 a11e          	cp	a,#30
3307  0c8b 25da          	jrult	L3311
3308                     ; 560 	ret1 = strstr(response_buffer, OK);
3310  0c8d 96            	ldw	x,sp
3311  0c8e 1c0001        	addw	x,#OFST-5
3312  0c91 89            	pushw	x
3313  0c92 ae0000        	ldw	x,#_response_buffer
3314  0c95 cd0000        	call	_strstr
3316  0c98 5b02          	addw	sp,#2
3317  0c9a 1f04          	ldw	(OFST-2,sp),x
3319                     ; 562 	if (ret1)
3321  0c9c 1e04          	ldw	x,(OFST-2,sp)
3322  0c9e 2705          	jreq	L1411
3323                     ; 564 		return 1;
3325  0ca0 ae0001        	ldw	x,#1
3327  0ca3 2001          	jra	L461
3328  0ca5               L1411:
3329                     ; 570 		return 0;
3331  0ca5 5f            	clrw	x
3333  0ca6               L461:
3335  0ca6 5b06          	addw	sp,#6
3336  0ca8 81            	ret
3371                     ; 574 void clearBuffer()
3371                     ; 575 {
3372                     	switch	.text
3373  0ca9               _clearBuffer:
3375  0ca9 88            	push	a
3376       00000001      OFST:	set	1
3379                     ; 577 	for (s = 0; s < 100; s++)
3381  0caa 0f01          	clr	(OFST+0,sp)
3383  0cac               L3611:
3384                     ; 580 		response_buffer[s] = '\0';
3386  0cac 7b01          	ld	a,(OFST+0,sp)
3387  0cae 5f            	clrw	x
3388  0caf 97            	ld	xl,a
3389  0cb0 724f0000      	clr	(_response_buffer,x)
3390                     ; 577 	for (s = 0; s < 100; s++)
3392  0cb4 0c01          	inc	(OFST+0,sp)
3396  0cb6 7b01          	ld	a,(OFST+0,sp)
3397  0cb8 a164          	cp	a,#100
3398  0cba 25f0          	jrult	L3611
3399                     ; 583 }
3402  0cbc 84            	pop	a
3403  0cbd 81            	ret
3406                     	switch	.const
3407  0035               L1711_current:
3408  0035 43757272656e  	dc.b	"Current is ",0
3409  0041 000000000000  	ds.b	14
3410  004f               L3711_currentUnit:
3411  004f 20416d707300  	dc.b	" Amps",0
3542                     ; 586 void sendSMSCurrent(uint32_t Current, uint8_t *cell_number)
3542                     ; 587 {
3543                     	switch	.text
3544  0cbe               _sendSMSCurrent:
3546  0cbe 5239          	subw	sp,#57
3547       00000039      OFST:	set	57
3550                     ; 591 	uint8_t current[26] = "Current is ";
3552  0cc0 96            	ldw	x,sp
3553  0cc1 1c0007        	addw	x,#OFST-50
3554  0cc4 90ae0035      	ldw	y,#L1711_current
3555  0cc8 a61a          	ld	a,#26
3556  0cca cd0000        	call	c_xymvx
3558                     ; 592 	uint8_t currentUnit[6] = " Amps";
3560  0ccd 96            	ldw	x,sp
3561  0cce 1c0001        	addw	x,#OFST-56
3562  0cd1 90ae004f      	ldw	y,#L3711_currentUnit
3563  0cd5 a606          	ld	a,#6
3564  0cd7 cd0000        	call	c_xymvx
3566                     ; 593 	uint8_t templen = 0;
3568                     ; 594 	uint8_t decplace = 0;
3570                     ; 598 	sprintf(tempwho, "%lu", Current);
3572  0cda 1e3e          	ldw	x,(OFST+5,sp)
3573  0cdc 89            	pushw	x
3574  0cdd 1e3e          	ldw	x,(OFST+5,sp)
3575  0cdf 89            	pushw	x
3576  0ce0 ae009f        	ldw	x,#L3621
3577  0ce3 89            	pushw	x
3578  0ce4 96            	ldw	x,sp
3579  0ce5 1c0028        	addw	x,#OFST-17
3580  0ce8 cd0000        	call	_sprintf
3582  0ceb 5b06          	addw	sp,#6
3583                     ; 599 	templen = strlen(tempwho);
3585  0ced 96            	ldw	x,sp
3586  0cee 1c0022        	addw	x,#OFST-23
3587  0cf1 cd0000        	call	_strlen
3589  0cf4 01            	rrwa	x,a
3590  0cf5 6b21          	ld	(OFST-24,sp),a
3591  0cf7 02            	rlwa	x,a
3593                     ; 600 	decplace = templen - 2;
3595  0cf8 7b21          	ld	a,(OFST-24,sp)
3596  0cfa a002          	sub	a,#2
3597  0cfc 6b38          	ld	(OFST-1,sp),a
3599                     ; 601 	tempwho2[decplace] = '.';
3601  0cfe 96            	ldw	x,sp
3602  0cff 1c0028        	addw	x,#OFST-17
3603  0d02 9f            	ld	a,xl
3604  0d03 5e            	swapw	x
3605  0d04 1b38          	add	a,(OFST-1,sp)
3606  0d06 2401          	jrnc	L271
3607  0d08 5c            	incw	x
3608  0d09               L271:
3609  0d09 02            	rlwa	x,a
3610  0d0a a62e          	ld	a,#46
3611  0d0c f7            	ld	(x),a
3612                     ; 602 	for (w = 0; w < decplace; w++)
3614  0d0d 0f39          	clr	(OFST+0,sp)
3617  0d0f 201e          	jra	L1721
3618  0d11               L5621:
3619                     ; 604 		tempwho2[w] = tempwho[w];
3621  0d11 96            	ldw	x,sp
3622  0d12 1c0028        	addw	x,#OFST-17
3623  0d15 9f            	ld	a,xl
3624  0d16 5e            	swapw	x
3625  0d17 1b39          	add	a,(OFST+0,sp)
3626  0d19 2401          	jrnc	L471
3627  0d1b 5c            	incw	x
3628  0d1c               L471:
3629  0d1c 02            	rlwa	x,a
3630  0d1d 89            	pushw	x
3631  0d1e 96            	ldw	x,sp
3632  0d1f 1c0024        	addw	x,#OFST-21
3633  0d22 9f            	ld	a,xl
3634  0d23 5e            	swapw	x
3635  0d24 1b3b          	add	a,(OFST+2,sp)
3636  0d26 2401          	jrnc	L671
3637  0d28 5c            	incw	x
3638  0d29               L671:
3639  0d29 02            	rlwa	x,a
3640  0d2a f6            	ld	a,(x)
3641  0d2b 85            	popw	x
3642  0d2c f7            	ld	(x),a
3643                     ; 602 	for (w = 0; w < decplace; w++)
3645  0d2d 0c39          	inc	(OFST+0,sp)
3647  0d2f               L1721:
3650  0d2f 7b39          	ld	a,(OFST+0,sp)
3651  0d31 1138          	cp	a,(OFST-1,sp)
3652  0d33 25dc          	jrult	L5621
3653                     ; 606 	f = decplace + 1;
3655  0d35 7b38          	ld	a,(OFST-1,sp)
3656  0d37 4c            	inc	a
3657  0d38 6b38          	ld	(OFST-1,sp),a
3659                     ; 607 	for (w = f; w <= templen; w++)
3661  0d3a 7b38          	ld	a,(OFST-1,sp)
3662  0d3c 6b39          	ld	(OFST+0,sp),a
3665  0d3e 2023          	jra	L1031
3666  0d40               L5721:
3667                     ; 609 		u = w - 1;
3669  0d40 7b39          	ld	a,(OFST+0,sp)
3670  0d42 4a            	dec	a
3671  0d43 6b38          	ld	(OFST-1,sp),a
3673                     ; 610 		tempwho2[w] = tempwho[u];
3675  0d45 96            	ldw	x,sp
3676  0d46 1c0028        	addw	x,#OFST-17
3677  0d49 9f            	ld	a,xl
3678  0d4a 5e            	swapw	x
3679  0d4b 1b39          	add	a,(OFST+0,sp)
3680  0d4d 2401          	jrnc	L002
3681  0d4f 5c            	incw	x
3682  0d50               L002:
3683  0d50 02            	rlwa	x,a
3684  0d51 89            	pushw	x
3685  0d52 96            	ldw	x,sp
3686  0d53 1c0024        	addw	x,#OFST-21
3687  0d56 9f            	ld	a,xl
3688  0d57 5e            	swapw	x
3689  0d58 1b3a          	add	a,(OFST+1,sp)
3690  0d5a 2401          	jrnc	L202
3691  0d5c 5c            	incw	x
3692  0d5d               L202:
3693  0d5d 02            	rlwa	x,a
3694  0d5e f6            	ld	a,(x)
3695  0d5f 85            	popw	x
3696  0d60 f7            	ld	(x),a
3697                     ; 607 	for (w = f; w <= templen; w++)
3699  0d61 0c39          	inc	(OFST+0,sp)
3701  0d63               L1031:
3704  0d63 7b39          	ld	a,(OFST+0,sp)
3705  0d65 1121          	cp	a,(OFST-24,sp)
3706  0d67 23d7          	jrule	L5721
3707                     ; 612 	tempwho2[w] = '\0';
3709  0d69 96            	ldw	x,sp
3710  0d6a 1c0028        	addw	x,#OFST-17
3711  0d6d 9f            	ld	a,xl
3712  0d6e 5e            	swapw	x
3713  0d6f 1b39          	add	a,(OFST+0,sp)
3714  0d71 2401          	jrnc	L402
3715  0d73 5c            	incw	x
3716  0d74               L402:
3717  0d74 02            	rlwa	x,a
3718  0d75 7f            	clr	(x)
3719                     ; 613 	strcat(tempwho2, currentUnit);
3721  0d76 96            	ldw	x,sp
3722  0d77 1c0001        	addw	x,#OFST-56
3723  0d7a 89            	pushw	x
3724  0d7b 96            	ldw	x,sp
3725  0d7c 1c002a        	addw	x,#OFST-15
3726  0d7f cd0000        	call	_strcat
3728  0d82 85            	popw	x
3729                     ; 614 	strcat(current, tempwho2);
3731  0d83 96            	ldw	x,sp
3732  0d84 1c0028        	addw	x,#OFST-17
3733  0d87 89            	pushw	x
3734  0d88 96            	ldw	x,sp
3735  0d89 1c0009        	addw	x,#OFST-48
3736  0d8c cd0000        	call	_strcat
3738  0d8f 85            	popw	x
3739                     ; 615 	bSendSMS(current, strlen((const char *)current), cell_number);
3741  0d90 1e40          	ldw	x,(OFST+7,sp)
3742  0d92 89            	pushw	x
3743  0d93 96            	ldw	x,sp
3744  0d94 1c0009        	addw	x,#OFST-48
3745  0d97 cd0000        	call	_strlen
3747  0d9a 9f            	ld	a,xl
3748  0d9b 88            	push	a
3749  0d9c 96            	ldw	x,sp
3750  0d9d 1c000a        	addw	x,#OFST-47
3751  0da0 cd0a50        	call	_bSendSMS
3753  0da3 5b03          	addw	sp,#3
3754                     ; 616 }
3757  0da5 5b39          	addw	sp,#57
3758  0da7 81            	ret
3761                     	switch	.const
3762  0055               L5031_voltage:
3763  0055 566f6c746167  	dc.b	"Voltage is ",0
3764  0061 000000000000  	ds.b	17
3765  0072               L7031_voltageUnit:
3766  0072 20566f6c7473  	dc.b	" Volts",0
3897                     ; 618 void sendSMSVoltage(uint32_t Voltage, uint8_t *cell_number)
3897                     ; 619 {
3898                     	switch	.text
3899  0da8               _sendSMSVoltage:
3901  0da8 523d          	subw	sp,#61
3902       0000003d      OFST:	set	61
3905                     ; 623 	uint8_t voltage[29] = "Voltage is ";
3907  0daa 96            	ldw	x,sp
3908  0dab 1c0008        	addw	x,#OFST-53
3909  0dae 90ae0055      	ldw	y,#L5031_voltage
3910  0db2 a61d          	ld	a,#29
3911  0db4 cd0000        	call	c_xymvx
3913                     ; 624 	uint8_t voltageUnit[7] = " Volts";
3915  0db7 96            	ldw	x,sp
3916  0db8 1c0001        	addw	x,#OFST-60
3917  0dbb 90ae0072      	ldw	y,#L7031_voltageUnit
3918  0dbf a607          	ld	a,#7
3919  0dc1 cd0000        	call	c_xymvx
3921                     ; 625 	uint8_t templen = 0;
3923                     ; 626 	uint8_t decplace = 0;
3925                     ; 630 	sprintf(tempwho, "%lu", Voltage);
3927  0dc4 1e42          	ldw	x,(OFST+5,sp)
3928  0dc6 89            	pushw	x
3929  0dc7 1e42          	ldw	x,(OFST+5,sp)
3930  0dc9 89            	pushw	x
3931  0dca ae009f        	ldw	x,#L3621
3932  0dcd 89            	pushw	x
3933  0dce 96            	ldw	x,sp
3934  0dcf 1c002c        	addw	x,#OFST-17
3935  0dd2 cd0000        	call	_sprintf
3937  0dd5 5b06          	addw	sp,#6
3938                     ; 631 	templen = strlen(tempwho);
3940  0dd7 96            	ldw	x,sp
3941  0dd8 1c0026        	addw	x,#OFST-23
3942  0ddb cd0000        	call	_strlen
3944  0dde 01            	rrwa	x,a
3945  0ddf 6b25          	ld	(OFST-24,sp),a
3946  0de1 02            	rlwa	x,a
3948                     ; 632 	decplace = templen - 2;
3950  0de2 7b25          	ld	a,(OFST-24,sp)
3951  0de4 a002          	sub	a,#2
3952  0de6 6b3c          	ld	(OFST-1,sp),a
3954                     ; 633 	tempwho2[decplace] = '.';
3956  0de8 96            	ldw	x,sp
3957  0de9 1c002c        	addw	x,#OFST-17
3958  0dec 9f            	ld	a,xl
3959  0ded 5e            	swapw	x
3960  0dee 1b3c          	add	a,(OFST-1,sp)
3961  0df0 2401          	jrnc	L012
3962  0df2 5c            	incw	x
3963  0df3               L012:
3964  0df3 02            	rlwa	x,a
3965  0df4 a62e          	ld	a,#46
3966  0df6 f7            	ld	(x),a
3967                     ; 634 	for (w = 0; w < decplace; w++)
3969  0df7 0f3d          	clr	(OFST+0,sp)
3972  0df9 201e          	jra	L3041
3973  0dfb               L7731:
3974                     ; 636 		tempwho2[w] = tempwho[w];
3976  0dfb 96            	ldw	x,sp
3977  0dfc 1c002c        	addw	x,#OFST-17
3978  0dff 9f            	ld	a,xl
3979  0e00 5e            	swapw	x
3980  0e01 1b3d          	add	a,(OFST+0,sp)
3981  0e03 2401          	jrnc	L212
3982  0e05 5c            	incw	x
3983  0e06               L212:
3984  0e06 02            	rlwa	x,a
3985  0e07 89            	pushw	x
3986  0e08 96            	ldw	x,sp
3987  0e09 1c0028        	addw	x,#OFST-21
3988  0e0c 9f            	ld	a,xl
3989  0e0d 5e            	swapw	x
3990  0e0e 1b3f          	add	a,(OFST+2,sp)
3991  0e10 2401          	jrnc	L412
3992  0e12 5c            	incw	x
3993  0e13               L412:
3994  0e13 02            	rlwa	x,a
3995  0e14 f6            	ld	a,(x)
3996  0e15 85            	popw	x
3997  0e16 f7            	ld	(x),a
3998                     ; 634 	for (w = 0; w < decplace; w++)
4000  0e17 0c3d          	inc	(OFST+0,sp)
4002  0e19               L3041:
4005  0e19 7b3d          	ld	a,(OFST+0,sp)
4006  0e1b 113c          	cp	a,(OFST-1,sp)
4007  0e1d 25dc          	jrult	L7731
4008                     ; 638 	f = decplace + 1;
4010  0e1f 7b3c          	ld	a,(OFST-1,sp)
4011  0e21 4c            	inc	a
4012  0e22 6b3c          	ld	(OFST-1,sp),a
4014                     ; 639 	for (w = f; w <= templen; w++)
4016  0e24 7b3c          	ld	a,(OFST-1,sp)
4017  0e26 6b3d          	ld	(OFST+0,sp),a
4020  0e28 2023          	jra	L3141
4021  0e2a               L7041:
4022                     ; 641 		u = w - 1;
4024  0e2a 7b3d          	ld	a,(OFST+0,sp)
4025  0e2c 4a            	dec	a
4026  0e2d 6b3c          	ld	(OFST-1,sp),a
4028                     ; 642 		tempwho2[w] = tempwho[u];
4030  0e2f 96            	ldw	x,sp
4031  0e30 1c002c        	addw	x,#OFST-17
4032  0e33 9f            	ld	a,xl
4033  0e34 5e            	swapw	x
4034  0e35 1b3d          	add	a,(OFST+0,sp)
4035  0e37 2401          	jrnc	L612
4036  0e39 5c            	incw	x
4037  0e3a               L612:
4038  0e3a 02            	rlwa	x,a
4039  0e3b 89            	pushw	x
4040  0e3c 96            	ldw	x,sp
4041  0e3d 1c0028        	addw	x,#OFST-21
4042  0e40 9f            	ld	a,xl
4043  0e41 5e            	swapw	x
4044  0e42 1b3e          	add	a,(OFST+1,sp)
4045  0e44 2401          	jrnc	L022
4046  0e46 5c            	incw	x
4047  0e47               L022:
4048  0e47 02            	rlwa	x,a
4049  0e48 f6            	ld	a,(x)
4050  0e49 85            	popw	x
4051  0e4a f7            	ld	(x),a
4052                     ; 639 	for (w = f; w <= templen; w++)
4054  0e4b 0c3d          	inc	(OFST+0,sp)
4056  0e4d               L3141:
4059  0e4d 7b3d          	ld	a,(OFST+0,sp)
4060  0e4f 1125          	cp	a,(OFST-24,sp)
4061  0e51 23d7          	jrule	L7041
4062                     ; 644 	tempwho2[w] = '\0';
4064  0e53 96            	ldw	x,sp
4065  0e54 1c002c        	addw	x,#OFST-17
4066  0e57 9f            	ld	a,xl
4067  0e58 5e            	swapw	x
4068  0e59 1b3d          	add	a,(OFST+0,sp)
4069  0e5b 2401          	jrnc	L222
4070  0e5d 5c            	incw	x
4071  0e5e               L222:
4072  0e5e 02            	rlwa	x,a
4073  0e5f 7f            	clr	(x)
4074                     ; 645 	strcat(tempwho2, voltageUnit);
4076  0e60 96            	ldw	x,sp
4077  0e61 1c0001        	addw	x,#OFST-60
4078  0e64 89            	pushw	x
4079  0e65 96            	ldw	x,sp
4080  0e66 1c002e        	addw	x,#OFST-15
4081  0e69 cd0000        	call	_strcat
4083  0e6c 85            	popw	x
4084                     ; 646 	strcat(voltage, tempwho2);
4086  0e6d 96            	ldw	x,sp
4087  0e6e 1c002c        	addw	x,#OFST-17
4088  0e71 89            	pushw	x
4089  0e72 96            	ldw	x,sp
4090  0e73 1c000a        	addw	x,#OFST-51
4091  0e76 cd0000        	call	_strcat
4093  0e79 85            	popw	x
4094                     ; 647 	bSendSMS(voltage, strlen((const char *)voltage), cell_number);
4096  0e7a 1e44          	ldw	x,(OFST+7,sp)
4097  0e7c 89            	pushw	x
4098  0e7d 96            	ldw	x,sp
4099  0e7e 1c000a        	addw	x,#OFST-51
4100  0e81 cd0000        	call	_strlen
4102  0e84 9f            	ld	a,xl
4103  0e85 88            	push	a
4104  0e86 96            	ldw	x,sp
4105  0e87 1c000b        	addw	x,#OFST-50
4106  0e8a cd0a50        	call	_bSendSMS
4108  0e8d 5b03          	addw	sp,#3
4109                     ; 648 }
4112  0e8f 5b3d          	addw	sp,#61
4113  0e91 81            	ret
4116                     	switch	.const
4117  0079               L7141_power:
4118  0079 506f77657220  	dc.b	"Power is ",0
4119  0083 000000000000  	ds.b	21
4120  0098               L1241_powerUnit:
4121  0098 205761747473  	dc.b	" Watts",0
4252                     ; 650 void sendSMSPower(uint32_t Power, uint8_t *cell_number)
4252                     ; 651 {
4253                     	switch	.text
4254  0e92               _sendSMSPower:
4256  0e92 523f          	subw	sp,#63
4257       0000003f      OFST:	set	63
4260                     ; 655 	uint8_t power[31] = "Power is ";
4262  0e94 96            	ldw	x,sp
4263  0e95 1c0008        	addw	x,#OFST-55
4264  0e98 90ae0079      	ldw	y,#L7141_power
4265  0e9c a61f          	ld	a,#31
4266  0e9e cd0000        	call	c_xymvx
4268                     ; 656 	uint8_t powerUnit[7] = " Watts";
4270  0ea1 96            	ldw	x,sp
4271  0ea2 1c0001        	addw	x,#OFST-62
4272  0ea5 90ae0098      	ldw	y,#L1241_powerUnit
4273  0ea9 a607          	ld	a,#7
4274  0eab cd0000        	call	c_xymvx
4276                     ; 657 	uint8_t templen = 0;
4278                     ; 658 	uint8_t decplace = 0;
4280                     ; 662 	sprintf(tempwho, "%lu", Power);
4282  0eae 1e44          	ldw	x,(OFST+5,sp)
4283  0eb0 89            	pushw	x
4284  0eb1 1e44          	ldw	x,(OFST+5,sp)
4285  0eb3 89            	pushw	x
4286  0eb4 ae009f        	ldw	x,#L3621
4287  0eb7 89            	pushw	x
4288  0eb8 96            	ldw	x,sp
4289  0eb9 1c002e        	addw	x,#OFST-17
4290  0ebc cd0000        	call	_sprintf
4292  0ebf 5b06          	addw	sp,#6
4293                     ; 663 	templen = strlen(tempwho);
4295  0ec1 96            	ldw	x,sp
4296  0ec2 1c0028        	addw	x,#OFST-23
4297  0ec5 cd0000        	call	_strlen
4299  0ec8 01            	rrwa	x,a
4300  0ec9 6b27          	ld	(OFST-24,sp),a
4301  0ecb 02            	rlwa	x,a
4303                     ; 664 	decplace = templen - 2;
4305  0ecc 7b27          	ld	a,(OFST-24,sp)
4306  0ece a002          	sub	a,#2
4307  0ed0 6b3e          	ld	(OFST-1,sp),a
4309                     ; 665 	tempwho2[decplace] = '.';
4311  0ed2 96            	ldw	x,sp
4312  0ed3 1c002e        	addw	x,#OFST-17
4313  0ed6 9f            	ld	a,xl
4314  0ed7 5e            	swapw	x
4315  0ed8 1b3e          	add	a,(OFST-1,sp)
4316  0eda 2401          	jrnc	L622
4317  0edc 5c            	incw	x
4318  0edd               L622:
4319  0edd 02            	rlwa	x,a
4320  0ede a62e          	ld	a,#46
4321  0ee0 f7            	ld	(x),a
4322                     ; 666 	for (w = 0; w < decplace; w++)
4324  0ee1 0f3f          	clr	(OFST+0,sp)
4327  0ee3 201e          	jra	L5151
4328  0ee5               L1151:
4329                     ; 668 		tempwho2[w] = tempwho[w];
4331  0ee5 96            	ldw	x,sp
4332  0ee6 1c002e        	addw	x,#OFST-17
4333  0ee9 9f            	ld	a,xl
4334  0eea 5e            	swapw	x
4335  0eeb 1b3f          	add	a,(OFST+0,sp)
4336  0eed 2401          	jrnc	L032
4337  0eef 5c            	incw	x
4338  0ef0               L032:
4339  0ef0 02            	rlwa	x,a
4340  0ef1 89            	pushw	x
4341  0ef2 96            	ldw	x,sp
4342  0ef3 1c002a        	addw	x,#OFST-21
4343  0ef6 9f            	ld	a,xl
4344  0ef7 5e            	swapw	x
4345  0ef8 1b41          	add	a,(OFST+2,sp)
4346  0efa 2401          	jrnc	L232
4347  0efc 5c            	incw	x
4348  0efd               L232:
4349  0efd 02            	rlwa	x,a
4350  0efe f6            	ld	a,(x)
4351  0eff 85            	popw	x
4352  0f00 f7            	ld	(x),a
4353                     ; 666 	for (w = 0; w < decplace; w++)
4355  0f01 0c3f          	inc	(OFST+0,sp)
4357  0f03               L5151:
4360  0f03 7b3f          	ld	a,(OFST+0,sp)
4361  0f05 113e          	cp	a,(OFST-1,sp)
4362  0f07 25dc          	jrult	L1151
4363                     ; 670 	f = decplace + 1;
4365  0f09 7b3e          	ld	a,(OFST-1,sp)
4366  0f0b 4c            	inc	a
4367  0f0c 6b3e          	ld	(OFST-1,sp),a
4369                     ; 671 	for (w = f; w <= templen; w++)
4371  0f0e 7b3e          	ld	a,(OFST-1,sp)
4372  0f10 6b3f          	ld	(OFST+0,sp),a
4375  0f12 2023          	jra	L5251
4376  0f14               L1251:
4377                     ; 673 		u = w - 1;
4379  0f14 7b3f          	ld	a,(OFST+0,sp)
4380  0f16 4a            	dec	a
4381  0f17 6b3e          	ld	(OFST-1,sp),a
4383                     ; 674 		tempwho2[w] = tempwho[u];
4385  0f19 96            	ldw	x,sp
4386  0f1a 1c002e        	addw	x,#OFST-17
4387  0f1d 9f            	ld	a,xl
4388  0f1e 5e            	swapw	x
4389  0f1f 1b3f          	add	a,(OFST+0,sp)
4390  0f21 2401          	jrnc	L432
4391  0f23 5c            	incw	x
4392  0f24               L432:
4393  0f24 02            	rlwa	x,a
4394  0f25 89            	pushw	x
4395  0f26 96            	ldw	x,sp
4396  0f27 1c002a        	addw	x,#OFST-21
4397  0f2a 9f            	ld	a,xl
4398  0f2b 5e            	swapw	x
4399  0f2c 1b40          	add	a,(OFST+1,sp)
4400  0f2e 2401          	jrnc	L632
4401  0f30 5c            	incw	x
4402  0f31               L632:
4403  0f31 02            	rlwa	x,a
4404  0f32 f6            	ld	a,(x)
4405  0f33 85            	popw	x
4406  0f34 f7            	ld	(x),a
4407                     ; 671 	for (w = f; w <= templen; w++)
4409  0f35 0c3f          	inc	(OFST+0,sp)
4411  0f37               L5251:
4414  0f37 7b3f          	ld	a,(OFST+0,sp)
4415  0f39 1127          	cp	a,(OFST-24,sp)
4416  0f3b 23d7          	jrule	L1251
4417                     ; 676 	tempwho2[w] = '\0';
4419  0f3d 96            	ldw	x,sp
4420  0f3e 1c002e        	addw	x,#OFST-17
4421  0f41 9f            	ld	a,xl
4422  0f42 5e            	swapw	x
4423  0f43 1b3f          	add	a,(OFST+0,sp)
4424  0f45 2401          	jrnc	L042
4425  0f47 5c            	incw	x
4426  0f48               L042:
4427  0f48 02            	rlwa	x,a
4428  0f49 7f            	clr	(x)
4429                     ; 677 	strcat(tempwho2, powerUnit);
4431  0f4a 96            	ldw	x,sp
4432  0f4b 1c0001        	addw	x,#OFST-62
4433  0f4e 89            	pushw	x
4434  0f4f 96            	ldw	x,sp
4435  0f50 1c0030        	addw	x,#OFST-15
4436  0f53 cd0000        	call	_strcat
4438  0f56 85            	popw	x
4439                     ; 678 	strcat(power, tempwho2);
4441  0f57 96            	ldw	x,sp
4442  0f58 1c002e        	addw	x,#OFST-17
4443  0f5b 89            	pushw	x
4444  0f5c 96            	ldw	x,sp
4445  0f5d 1c000a        	addw	x,#OFST-53
4446  0f60 cd0000        	call	_strcat
4448  0f63 85            	popw	x
4449                     ; 679 	bSendSMS(power, strlen((const char *)power), cell_number);
4451  0f64 1e46          	ldw	x,(OFST+7,sp)
4452  0f66 89            	pushw	x
4453  0f67 96            	ldw	x,sp
4454  0f68 1c000a        	addw	x,#OFST-53
4455  0f6b cd0000        	call	_strlen
4457  0f6e 9f            	ld	a,xl
4458  0f6f 88            	push	a
4459  0f70 96            	ldw	x,sp
4460  0f71 1c000b        	addw	x,#OFST-52
4461  0f74 cd0a50        	call	_bSendSMS
4463  0f77 5b03          	addw	sp,#3
4464                     ; 680 }
4467  0f79 5b3f          	addw	sp,#63
4468  0f7b 81            	ret
4606                     	xdef	_main
4607                     	xdef	_IMEIRecievedOKFlag
4608                     	xdef	_activation_flag
4609                     	xdef	_arm_flag
4610                     	xdef	_gprs_post_response_status
4611                     	xdef	_sms_recev
4612                     	xdef	_flag2
4613                     	xdef	_cloud_gps_data_flag
4614                     	xdef	_timeout
4615                     	xdef	_previousTics
4616                     	xdef	_stmDataReceive
4617                     	xref	_getFuelLevel
4618                     	xdef	_systemSetup
4619                     	xref	_sendDataToCloud
4620                     	xdef	_bSendSMS
4621                     	xref	_gettemp2
4622                     	xref	_gettemp1
4623                     	xref	_getbatteryvolt
4624                     	xdef	_sendSMSPower
4625                     	xdef	_sendSMSVoltage
4626                     	xdef	_sendSMSCurrent
4627                     	xdef	_sms_receive
4628                     	xref	_atoi
4629                     	xref	_calculateVoltCurrent
4630                     	xref.b	_checkByte
4631                     	xref.b	_powerCalibrationFactor3
4632                     	xref.b	_powerCalibrationFactor2
4633                     	xref.b	_powerCalibrationFactor1
4634                     	xref.b	_currentCalibrationFactor3
4635                     	xref.b	_currentCalibrationFactor2
4636                     	xref.b	_currentCalibrationFactor1
4637                     	xref.b	_voltageCalibrationFactor3
4638                     	xref.b	_voltageCalibrationFactor2
4639                     	xref.b	_voltageCalibrationFactor1
4640                     	xdef	_clearBuffer
4641                     	xref	_ms_send_cmd
4642                     	xref	_Temperature2
4643                     	xref	_Temperature1
4644                     	xref	_Fuellevel
4645                     	xref.b	_batVolt
4646                     	xref	_Watt_Phase3
4647                     	xref	_Ampere_Phase3
4648                     	xref	_Voltage_Phase3
4649                     	xref	_Watt_Phase2
4650                     	xref	_Ampere_Phase2
4651                     	xref	_Voltage_Phase2
4652                     	xref	_Watt_Phase1
4653                     	xref	_Ampere_Phase1
4654                     	xref	_Voltage_Phase1
4655                     	xref	_vHandle_MQTT
4656                     	xref	_vClearBuffer
4657                     	xdef	_GSM_OK_FAST
4658                     	xdef	_GSM_DOWNLOAD
4659                     	xdef	_GSM_OK
4660                     	xref	_SIMCom_setup
4661                     	xdef	_response_buffer
4662                     	xdef	_gprs_init_flag
4663                     	switch	.ubsct
4664  0000               _OK:
4665  0000 00            	ds.b	1
4666                     	xdef	_OK
4667                     	xdef	_cloud_connectivity_flag
4668                     	xdef	_noEchoFlag
4669                     	xref	_sprintf
4670                     	xref	_strlen
4671                     	xref	_strstr
4672                     	xref	_strcat
4673                     	xref	_WriteFlashWord
4674                     	xref	_systemInit
4675                     	xref	_delay_ms
4676                     	xref	_FLASH_ProgramByte
4677                     	xref	_FLASH_Lock
4678                     	xref	_FLASH_Unlock
4679                     	xref	_UART1_GetFlagStatus
4680                     	xref	_UART1_SendData8
4681                     	xref	_UART1_ReceiveData8
4682                     	xref	_UART1_ITConfig
4683                     	switch	.const
4684  009f               L3621:
4685  009f 256c7500      	dc.b	"%lu",0
4686  00a3               L327:
4687  00a3 2b434d475300  	dc.b	"+CMGS",0
4688  00a9               L355:
4689  00a9 2056616c7565  	dc.b	" Value",0
4690  00b0               L155:
4691  00b0 4675656c3a20  	dc.b	"Fuel: ",0
4692  00b7               L745:
4693  00b7 4655454c2d4c  	dc.b	"FUEL-LEVEL",0
4694  00c2               L145:
4695  00c2 20566f6c7473  	dc.b	" Volts",0
4696  00c9               L735:
4697  00c9 426174746572  	dc.b	"Battery: ",0
4698  00d3               L535:
4699  00d3 424154544552  	dc.b	"BATTERY-VOLT",0
4700  00e0               L725:
4701  00e0 456e67696e65  	dc.b	"Engine Temperature"
4702  00f2 3a2000        	dc.b	": ",0
4703  00f5               L525:
4704  00f5 454e47494e45  	dc.b	"ENGINE-TEMP",0
4705  0101               L715:
4706  0101 204300        	dc.b	" C",0
4707  0104               L515:
4708  0104 2e00          	dc.b	".",0
4709  0106               L315:
4710  0106 256c6400      	dc.b	"%ld",0
4711  010a               L115:
4712  010a 526164696174  	dc.b	"Radiator Temperatu"
4713  011c 72653a2000    	dc.b	"re: ",0
4714  0121               L505:
4715  0121 42c80000      	dc.w	17096,0
4716  0125               L774:
4717  0125 524144494154  	dc.b	"RADIATOR-TEMP",0
4718  0133               L174:
4719  0133 504f57455233  	dc.b	"POWER3",0
4720  013a               L364:
4721  013a 564f4c544147  	dc.b	"VOLTAGE3",0
4722  0143               L554:
4723  0143 43555252454e  	dc.b	"CURRENT3",0
4724  014c               L744:
4725  014c 504f57455232  	dc.b	"POWER2",0
4726  0153               L144:
4727  0153 564f4c544147  	dc.b	"VOLTAGE2",0
4728  015c               L334:
4729  015c 43555252454e  	dc.b	"CURRENT2",0
4730  0165               L524:
4731  0165 504f57455231  	dc.b	"POWER1",0
4732  016c               L714:
4733  016c 564f4c544147  	dc.b	"VOLTAGE1",0
4734  0175               L114:
4735  0175 43555252454e  	dc.b	"CURRENT1",0
4736  017e               L773:
4737  017e 503343616c46  	dc.b	"P3CalFac = ",0
4738  018a               L363:
4739  018a 503243616c46  	dc.b	"P2CalFac = ",0
4740  0196               L743:
4741  0196 503143616c46  	dc.b	"P1CalFac = ",0
4742  01a2               L333:
4743  01a2 493343616c46  	dc.b	"I3CalFac = ",0
4744  01ae               L713:
4745  01ae 493243616c46  	dc.b	"I2CalFac = ",0
4746  01ba               L303:
4747  01ba 493143616c46  	dc.b	"I1CalFac = ",0
4748  01c6               L762:
4749  01c6 563343616c46  	dc.b	"V3CalFac = ",0
4750  01d2               L352:
4751  01d2 563243616c46  	dc.b	"V2CalFac = ",0
4752  01de               L732:
4753  01de 563143616c46  	dc.b	"V1CalFac = ",0
4754  01ea               L332:
4755  01ea 43414c494252  	dc.b	"CALIBRATION DONE",0
4756  01fb               L722:
4757  01fb 4f4b00        	dc.b	"OK",0
4758  01fe               L522:
4759  01fe 43414c494252  	dc.b	"CALIBRATE",0
4760  0208               L122:
4761  0208 41542b434d47  	dc.b	"AT+CMGD=1,4",0
4762  0214               L371:
4763  0214 2b434d475200  	dc.b	"+CMGR",0
4764  021a               L151:
4765  021a 41542b434d47  	dc.b	"AT+CMGR=1",0
4766  0224               L741:
4767  0224 41542b434d47  	dc.b	"AT+CMGF=1",0
4768  022e               L541:
4769  022e 4154453000    	dc.b	"ATE0",0
4770                     	xref.b	c_lreg
4771                     	xref.b	c_x
4791                     	xref	c_lzmp
4792                     	xref	c_lgsbc
4793                     	xref	c_lumd
4794                     	xref	c_ludv
4795                     	xref	c_rtol
4796                     	xref	c_ftol
4797                     	xref	c_fmul
4798                     	xref	c_ltor
4799                     	xref	c_xymvx
4800                     	end
