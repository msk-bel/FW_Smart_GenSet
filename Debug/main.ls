   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
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
 139  0006 cd0bf6        	call	_clearBuffer
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
 415                     ; 89 	uint8_t i,j,m,n,k = 0,l = 0,t = 0;
 417  003c 0f79          	clr	(OFST-1,sp)
 421  003e 0f7a          	clr	(OFST+0,sp)
 425                     ; 91 	uint32_t myVar = 0;
 427                     ; 92 	UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 429  0040 4b00          	push	#0
 430  0042 ae0255        	ldw	x,#597
 431  0045 cd0000        	call	_UART1_ITConfig
 433  0048 84            	pop	a
 434                     ; 93 	UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 436  0049 4b00          	push	#0
 437  004b ae0244        	ldw	x,#580
 438  004e cd0000        	call	_UART1_ITConfig
 440  0051 84            	pop	a
 441                     ; 95 	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); //  no echo
 443  0052 4b04          	push	#4
 444  0054 ae0222        	ldw	x,#L541
 445  0057 cd0000        	call	_ms_send_cmd
 447  005a 84            	pop	a
 448                     ; 96 	delay_ms(200);
 450  005b ae00c8        	ldw	x,#200
 451  005e cd0000        	call	_delay_ms
 453                     ; 97 	ms_send_cmd(MSGFT, strlen((const char *)MSGFT));
 455  0061 4b09          	push	#9
 456  0063 ae0218        	ldw	x,#L741
 457  0066 cd0000        	call	_ms_send_cmd
 459  0069 84            	pop	a
 460                     ; 98 	delay_ms(200);
 462  006a ae00c8        	ldw	x,#200
 463  006d cd0000        	call	_delay_ms
 465                     ; 99 	ms_send_cmd(SMSRead, strlen((const char *)SMSRead)); // SMS read
 467  0070 4b09          	push	#9
 468  0072 ae020e        	ldw	x,#L151
 469  0075 cd0000        	call	_ms_send_cmd
 471  0078 84            	pop	a
 472                     ; 101 	for (i = 0; i < 85; i++)
 474  0079 0f05          	clr	(OFST-117,sp)
 476  007b               L361:
 477                     ; 103 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
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
 491                     ; 105 		uart_buffer[i] = UART1_ReceiveData8();
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
 507                     ; 106 		timeout = 0;
 509  00a2 5f            	clrw	x
 510  00a3 bf09          	ldw	_timeout,x
 511                     ; 101 	for (i = 0; i < 85; i++)
 513  00a5 0c05          	inc	(OFST-117,sp)
 517  00a7 7b05          	ld	a,(OFST-117,sp)
 518  00a9 a155          	cp	a,#85
 519  00ab 25ce          	jrult	L361
 520                     ; 109 	if (strstr(uart_buffer, "+CMGR"))
 522  00ad ae0208        	ldw	x,#L371
 523  00b0 89            	pushw	x
 524  00b1 96            	ldw	x,sp
 525  00b2 1c0026        	addw	x,#OFST-84
 526  00b5 cd0000        	call	_strstr
 528  00b8 5b02          	addw	sp,#2
 529  00ba a30000        	cpw	x,#0
 530  00bd 2756          	jreq	L171
 531                     ; 111 		k = 0;
 533  00bf 0f79          	clr	(OFST-1,sp)
 536  00c1 2002          	jra	L102
 537  00c3               L571:
 538                     ; 114 			k++;
 540  00c3 0c79          	inc	(OFST-1,sp)
 542  00c5               L102:
 543                     ; 112 		while (uart_buffer[k] != '+')
 543                     ; 113 		{
 543                     ; 114 			k++;
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
 557                     ; 116 		k++;
 559  00d6 0c79          	inc	(OFST-1,sp)
 562  00d8 2002          	jra	L702
 563  00da               L502:
 564                     ; 119 			k++;
 566  00da 0c79          	inc	(OFST-1,sp)
 568  00dc               L702:
 569                     ; 117 		while (uart_buffer[k] != '+')
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
 583                     ; 121 		for (l = 0; l < 13; l++)
 585  00ed 0f7a          	clr	(OFST+0,sp)
 587  00ef               L312:
 588                     ; 123 			cell_num[l] = uart_buffer[k];
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
 612                     ; 124 			k++;
 614  010b 0c79          	inc	(OFST-1,sp)
 616                     ; 121 		for (l = 0; l < 13; l++)
 618  010d 0c7a          	inc	(OFST+0,sp)
 622  010f 7b7a          	ld	a,(OFST+0,sp)
 623  0111 a10d          	cp	a,#13
 624  0113 25da          	jrult	L312
 625  0115               L171:
 626                     ; 127 	cell_num[l] = '\0';
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
 638                     ; 129 	ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); // Delete SMS
 640  0122 4b0b          	push	#11
 641  0124 ae01fc        	ldw	x,#L122
 642  0127 cd0000        	call	_ms_send_cmd
 644  012a 84            	pop	a
 645                     ; 130 	delay_ms(200);
 647  012b ae00c8        	ldw	x,#200
 648  012e cd0000        	call	_delay_ms
 650                     ; 134 	if (strstr(uart_buffer, "CALIBRATE"))
 652  0131 ae01f2        	ldw	x,#L522
 653  0134 89            	pushw	x
 654  0135 96            	ldw	x,sp
 655  0136 1c0026        	addw	x,#OFST-84
 656  0139 cd0000        	call	_strstr
 658  013c 5b02          	addw	sp,#2
 659  013e a30000        	cpw	x,#0
 660  0141 272c          	jreq	L322
 661                     ; 136 		checkByte = 'B';
 663  0143 35420000      	mov	_checkByte,#66
 664                     ; 137 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 666  0147 a6f7          	ld	a,#247
 667  0149 cd0000        	call	_FLASH_Unlock
 669                     ; 139 		FLASH_ProgramByte(CheckByte, 'B'); //Changed by Saqib
 671  014c 4b42          	push	#66
 672  014e ae4025        	ldw	x,#16421
 673  0151 89            	pushw	x
 674  0152 ae0000        	ldw	x,#0
 675  0155 89            	pushw	x
 676  0156 cd0000        	call	_FLASH_ProgramByte
 678  0159 5b05          	addw	sp,#5
 679                     ; 140 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 681  015b a6f7          	ld	a,#247
 682  015d cd0000        	call	_FLASH_Lock
 684                     ; 141 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 686  0160 96            	ldw	x,sp
 687  0161 1c0012        	addw	x,#OFST-104
 688  0164 89            	pushw	x
 689  0165 4b02          	push	#2
 690  0167 ae01ef        	ldw	x,#L722
 691  016a cd0a50        	call	_bSendSMS
 693  016d 5b03          	addw	sp,#3
 694  016f               L322:
 695                     ; 144 	if (strstr(uart_buffer, "CALIBRATION DONE"))
 697  016f ae01de        	ldw	x,#L332
 698  0172 89            	pushw	x
 699  0173 96            	ldw	x,sp
 700  0174 1c0026        	addw	x,#OFST-84
 701  0177 cd0000        	call	_strstr
 703  017a 5b02          	addw	sp,#2
 704  017c a30000        	cpw	x,#0
 705  017f 272c          	jreq	L132
 706                     ; 146 		checkByte = 'A';
 708  0181 35410000      	mov	_checkByte,#65
 709                     ; 147 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 711  0185 a6f7          	ld	a,#247
 712  0187 cd0000        	call	_FLASH_Unlock
 714                     ; 148 		FLASH_ProgramByte(CheckByte, 'A');
 716  018a 4b41          	push	#65
 717  018c ae4025        	ldw	x,#16421
 718  018f 89            	pushw	x
 719  0190 ae0000        	ldw	x,#0
 720  0193 89            	pushw	x
 721  0194 cd0000        	call	_FLASH_ProgramByte
 723  0197 5b05          	addw	sp,#5
 724                     ; 149 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 726  0199 a6f7          	ld	a,#247
 727  019b cd0000        	call	_FLASH_Lock
 729                     ; 150 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 731  019e 96            	ldw	x,sp
 732  019f 1c0012        	addw	x,#OFST-104
 733  01a2 89            	pushw	x
 734  01a3 4b02          	push	#2
 735  01a5 ae01ef        	ldw	x,#L722
 736  01a8 cd0a50        	call	_bSendSMS
 738  01ab 5b03          	addw	sp,#3
 739  01ad               L132:
 740                     ; 153 	if (strstr(uart_buffer, "V1CalFac = "))
 742  01ad ae01d2        	ldw	x,#L732
 743  01b0 89            	pushw	x
 744  01b1 96            	ldw	x,sp
 745  01b2 1c0026        	addw	x,#OFST-84
 746  01b5 cd0000        	call	_strstr
 748  01b8 5b02          	addw	sp,#2
 749  01ba a30000        	cpw	x,#0
 750  01bd 276a          	jreq	L532
 751                     ; 155 		t = k + 42;
 753  01bf 7b79          	ld	a,(OFST-1,sp)
 754  01c1 ab2a          	add	a,#42
 755  01c3 6b79          	ld	(OFST-1,sp),a
 757                     ; 156 		for (n = 0; n < 4; n++)
 759  01c5 0f7a          	clr	(OFST+0,sp)
 761  01c7               L142:
 762                     ; 158 			calibrationFactor[n] = uart_buffer[t];
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
 786                     ; 159 			t++;
 788  01e3 0c79          	inc	(OFST-1,sp)
 790                     ; 156 		for (n = 0; n < 4; n++)
 792  01e5 0c7a          	inc	(OFST+0,sp)
 796  01e7 7b7a          	ld	a,(OFST+0,sp)
 797  01e9 a104          	cp	a,#4
 798  01eb 25da          	jrult	L142
 799                     ; 161 		calibrationFactor[n] = '\0';
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
 811                     ; 162 		value = atoi(calibrationFactor);
 813  01fa 96            	ldw	x,sp
 814  01fb 1c0020        	addw	x,#OFST-90
 815  01fe cd0000        	call	_atoi
 817  0201 1f10          	ldw	(OFST-106,sp),x
 819                     ; 163 		voltageCalibrationFactor1 = value; //Added By saqib, earlier not present
 821  0203 1e10          	ldw	x,(OFST-106,sp)
 822  0205 bf00          	ldw	_voltageCalibrationFactor1,x
 823                     ; 168 		WriteFlashWord(value, V1CabFab);
 825  0207 ae4000        	ldw	x,#16384
 826  020a 89            	pushw	x
 827  020b ae0000        	ldw	x,#0
 828  020e 89            	pushw	x
 829  020f 1e14          	ldw	x,(OFST-102,sp)
 830  0211 cd0000        	call	_WriteFlashWord
 832  0214 5b04          	addw	sp,#4
 833                     ; 169 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 835  0216 96            	ldw	x,sp
 836  0217 1c0012        	addw	x,#OFST-104
 837  021a 89            	pushw	x
 838  021b 4b02          	push	#2
 839  021d ae01ef        	ldw	x,#L722
 840  0220 cd0a50        	call	_bSendSMS
 842  0223 5b03          	addw	sp,#3
 844  0225 ac030603      	jpf	L742
 845  0229               L532:
 846                     ; 172 	else if (strstr(uart_buffer, "V2CalFac = "))
 848  0229 ae01c6        	ldw	x,#L352
 849  022c 89            	pushw	x
 850  022d 96            	ldw	x,sp
 851  022e 1c0026        	addw	x,#OFST-84
 852  0231 cd0000        	call	_strstr
 854  0234 5b02          	addw	sp,#2
 855  0236 a30000        	cpw	x,#0
 856  0239 276a          	jreq	L152
 857                     ; 174 		t = k + 42;
 859  023b 7b79          	ld	a,(OFST-1,sp)
 860  023d ab2a          	add	a,#42
 861  023f 6b79          	ld	(OFST-1,sp),a
 863                     ; 175 		for (n = 0; n < 4; n++)
 865  0241 0f7a          	clr	(OFST+0,sp)
 867  0243               L552:
 868                     ; 177 			calibrationFactor[n] = uart_buffer[t];
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
 892                     ; 178 			t++;
 894  025f 0c79          	inc	(OFST-1,sp)
 896                     ; 175 		for (n = 0; n < 4; n++)
 898  0261 0c7a          	inc	(OFST+0,sp)
 902  0263 7b7a          	ld	a,(OFST+0,sp)
 903  0265 a104          	cp	a,#4
 904  0267 25da          	jrult	L552
 905                     ; 180 		calibrationFactor[n] = '\0';
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
 917                     ; 181 		value = atoi(calibrationFactor);
 919  0276 96            	ldw	x,sp
 920  0277 1c0020        	addw	x,#OFST-90
 921  027a cd0000        	call	_atoi
 923  027d 1f10          	ldw	(OFST-106,sp),x
 925                     ; 182 		voltageCalibrationFactor2 = value; //Added By saqib, earlier not present
 927  027f 1e10          	ldw	x,(OFST-106,sp)
 928  0281 bf00          	ldw	_voltageCalibrationFactor2,x
 929                     ; 188 		WriteFlashWord(value, V2CabFab);
 931  0283 ae4004        	ldw	x,#16388
 932  0286 89            	pushw	x
 933  0287 ae0000        	ldw	x,#0
 934  028a 89            	pushw	x
 935  028b 1e14          	ldw	x,(OFST-102,sp)
 936  028d cd0000        	call	_WriteFlashWord
 938  0290 5b04          	addw	sp,#4
 939                     ; 189 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
 941  0292 96            	ldw	x,sp
 942  0293 1c0012        	addw	x,#OFST-104
 943  0296 89            	pushw	x
 944  0297 4b02          	push	#2
 945  0299 ae01ef        	ldw	x,#L722
 946  029c cd0a50        	call	_bSendSMS
 948  029f 5b03          	addw	sp,#3
 950  02a1 ac030603      	jpf	L742
 951  02a5               L152:
 952                     ; 192 	else if (strstr(uart_buffer, "V3CalFac = "))
 954  02a5 ae01ba        	ldw	x,#L762
 955  02a8 89            	pushw	x
 956  02a9 96            	ldw	x,sp
 957  02aa 1c0026        	addw	x,#OFST-84
 958  02ad cd0000        	call	_strstr
 960  02b0 5b02          	addw	sp,#2
 961  02b2 a30000        	cpw	x,#0
 962  02b5 276a          	jreq	L562
 963                     ; 194 		t = k + 42;
 965  02b7 7b79          	ld	a,(OFST-1,sp)
 966  02b9 ab2a          	add	a,#42
 967  02bb 6b79          	ld	(OFST-1,sp),a
 969                     ; 195 		for (n = 0; n < 4; n++)
 971  02bd 0f7a          	clr	(OFST+0,sp)
 973  02bf               L172:
 974                     ; 197 			calibrationFactor[n] = uart_buffer[t];
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
 998                     ; 198 			t++;
1000  02db 0c79          	inc	(OFST-1,sp)
1002                     ; 195 		for (n = 0; n < 4; n++)
1004  02dd 0c7a          	inc	(OFST+0,sp)
1008  02df 7b7a          	ld	a,(OFST+0,sp)
1009  02e1 a104          	cp	a,#4
1010  02e3 25da          	jrult	L172
1011                     ; 200 		calibrationFactor[n] = '\0';
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
1023                     ; 201 		value = atoi(calibrationFactor);
1025  02f2 96            	ldw	x,sp
1026  02f3 1c0020        	addw	x,#OFST-90
1027  02f6 cd0000        	call	_atoi
1029  02f9 1f10          	ldw	(OFST-106,sp),x
1031                     ; 202 		voltageCalibrationFactor3 = value;
1033  02fb 1e10          	ldw	x,(OFST-106,sp)
1034  02fd bf00          	ldw	_voltageCalibrationFactor3,x
1035                     ; 208 		WriteFlashWord(value, V3CabFab);
1037  02ff ae4008        	ldw	x,#16392
1038  0302 89            	pushw	x
1039  0303 ae0000        	ldw	x,#0
1040  0306 89            	pushw	x
1041  0307 1e14          	ldw	x,(OFST-102,sp)
1042  0309 cd0000        	call	_WriteFlashWord
1044  030c 5b04          	addw	sp,#4
1045                     ; 209 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1047  030e 96            	ldw	x,sp
1048  030f 1c0012        	addw	x,#OFST-104
1049  0312 89            	pushw	x
1050  0313 4b02          	push	#2
1051  0315 ae01ef        	ldw	x,#L722
1052  0318 cd0a50        	call	_bSendSMS
1054  031b 5b03          	addw	sp,#3
1056  031d ac030603      	jpf	L742
1057  0321               L562:
1058                     ; 212 	else if (strstr(uart_buffer, "I1CalFac = "))
1060  0321 ae01ae        	ldw	x,#L303
1061  0324 89            	pushw	x
1062  0325 96            	ldw	x,sp
1063  0326 1c0026        	addw	x,#OFST-84
1064  0329 cd0000        	call	_strstr
1066  032c 5b02          	addw	sp,#2
1067  032e a30000        	cpw	x,#0
1068  0331 276a          	jreq	L103
1069                     ; 214 		t = k + 42;
1071  0333 7b79          	ld	a,(OFST-1,sp)
1072  0335 ab2a          	add	a,#42
1073  0337 6b79          	ld	(OFST-1,sp),a
1075                     ; 215 		for (n = 0; n < 4; n++)
1077  0339 0f7a          	clr	(OFST+0,sp)
1079  033b               L503:
1080                     ; 217 			calibrationFactor[n] = uart_buffer[t];
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
1104                     ; 218 			t++;
1106  0357 0c79          	inc	(OFST-1,sp)
1108                     ; 215 		for (n = 0; n < 4; n++)
1110  0359 0c7a          	inc	(OFST+0,sp)
1114  035b 7b7a          	ld	a,(OFST+0,sp)
1115  035d a104          	cp	a,#4
1116  035f 25da          	jrult	L503
1117                     ; 220 		calibrationFactor[n] = '\0';
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
1129                     ; 221 		value = atoi(calibrationFactor);
1131  036e 96            	ldw	x,sp
1132  036f 1c0020        	addw	x,#OFST-90
1133  0372 cd0000        	call	_atoi
1135  0375 1f10          	ldw	(OFST-106,sp),x
1137                     ; 222 		currentCalibrationFactor1 = value; //Added By saqib, earlier not present
1139  0377 1e10          	ldw	x,(OFST-106,sp)
1140  0379 bf00          	ldw	_currentCalibrationFactor1,x
1141                     ; 228 		WriteFlashWord(value, I1CabFab);
1143  037b ae400c        	ldw	x,#16396
1144  037e 89            	pushw	x
1145  037f ae0000        	ldw	x,#0
1146  0382 89            	pushw	x
1147  0383 1e14          	ldw	x,(OFST-102,sp)
1148  0385 cd0000        	call	_WriteFlashWord
1150  0388 5b04          	addw	sp,#4
1151                     ; 229 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1153  038a 96            	ldw	x,sp
1154  038b 1c0012        	addw	x,#OFST-104
1155  038e 89            	pushw	x
1156  038f 4b02          	push	#2
1157  0391 ae01ef        	ldw	x,#L722
1158  0394 cd0a50        	call	_bSendSMS
1160  0397 5b03          	addw	sp,#3
1162  0399 ac030603      	jpf	L742
1163  039d               L103:
1164                     ; 232 	else if (strstr(uart_buffer, "I2CalFac = "))
1166  039d ae01a2        	ldw	x,#L713
1167  03a0 89            	pushw	x
1168  03a1 96            	ldw	x,sp
1169  03a2 1c0026        	addw	x,#OFST-84
1170  03a5 cd0000        	call	_strstr
1172  03a8 5b02          	addw	sp,#2
1173  03aa a30000        	cpw	x,#0
1174  03ad 276a          	jreq	L513
1175                     ; 234 		t = k + 42;
1177  03af 7b79          	ld	a,(OFST-1,sp)
1178  03b1 ab2a          	add	a,#42
1179  03b3 6b79          	ld	(OFST-1,sp),a
1181                     ; 235 		for (n = 0; n < 4; n++)
1183  03b5 0f7a          	clr	(OFST+0,sp)
1185  03b7               L123:
1186                     ; 237 			calibrationFactor[n] = uart_buffer[t];
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
1210                     ; 238 			t++;
1212  03d3 0c79          	inc	(OFST-1,sp)
1214                     ; 235 		for (n = 0; n < 4; n++)
1216  03d5 0c7a          	inc	(OFST+0,sp)
1220  03d7 7b7a          	ld	a,(OFST+0,sp)
1221  03d9 a104          	cp	a,#4
1222  03db 25da          	jrult	L123
1223                     ; 240 		calibrationFactor[n] = '\0';
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
1235                     ; 241 		value = atoi(calibrationFactor);
1237  03ea 96            	ldw	x,sp
1238  03eb 1c0020        	addw	x,#OFST-90
1239  03ee cd0000        	call	_atoi
1241  03f1 1f10          	ldw	(OFST-106,sp),x
1243                     ; 242 		currentCalibrationFactor2 = value; //Added By saqib, earlier not present
1245  03f3 1e10          	ldw	x,(OFST-106,sp)
1246  03f5 bf00          	ldw	_currentCalibrationFactor2,x
1247                     ; 248 		WriteFlashWord(value, I2CabFab);
1249  03f7 ae4010        	ldw	x,#16400
1250  03fa 89            	pushw	x
1251  03fb ae0000        	ldw	x,#0
1252  03fe 89            	pushw	x
1253  03ff 1e14          	ldw	x,(OFST-102,sp)
1254  0401 cd0000        	call	_WriteFlashWord
1256  0404 5b04          	addw	sp,#4
1257                     ; 249 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1259  0406 96            	ldw	x,sp
1260  0407 1c0012        	addw	x,#OFST-104
1261  040a 89            	pushw	x
1262  040b 4b02          	push	#2
1263  040d ae01ef        	ldw	x,#L722
1264  0410 cd0a50        	call	_bSendSMS
1266  0413 5b03          	addw	sp,#3
1268  0415 ac030603      	jpf	L742
1269  0419               L513:
1270                     ; 252 	else if (strstr(uart_buffer, "I3CalFac = "))
1272  0419 ae0196        	ldw	x,#L333
1273  041c 89            	pushw	x
1274  041d 96            	ldw	x,sp
1275  041e 1c0026        	addw	x,#OFST-84
1276  0421 cd0000        	call	_strstr
1278  0424 5b02          	addw	sp,#2
1279  0426 a30000        	cpw	x,#0
1280  0429 276a          	jreq	L133
1281                     ; 254 		t = k + 42;
1283  042b 7b79          	ld	a,(OFST-1,sp)
1284  042d ab2a          	add	a,#42
1285  042f 6b79          	ld	(OFST-1,sp),a
1287                     ; 255 		for (n = 0; n < 4; n++)
1289  0431 0f7a          	clr	(OFST+0,sp)
1291  0433               L533:
1292                     ; 257 			calibrationFactor[n] = uart_buffer[t];
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
1316                     ; 258 			t++;
1318  044f 0c79          	inc	(OFST-1,sp)
1320                     ; 255 		for (n = 0; n < 4; n++)
1322  0451 0c7a          	inc	(OFST+0,sp)
1326  0453 7b7a          	ld	a,(OFST+0,sp)
1327  0455 a104          	cp	a,#4
1328  0457 25da          	jrult	L533
1329                     ; 260 		calibrationFactor[n] = '\0';
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
1341                     ; 261 		value = atoi(calibrationFactor);
1343  0466 96            	ldw	x,sp
1344  0467 1c0020        	addw	x,#OFST-90
1345  046a cd0000        	call	_atoi
1347  046d 1f10          	ldw	(OFST-106,sp),x
1349                     ; 262 		currentCalibrationFactor3 = value;
1351  046f 1e10          	ldw	x,(OFST-106,sp)
1352  0471 bf00          	ldw	_currentCalibrationFactor3,x
1353                     ; 268 		WriteFlashWord(value, I3CabFab);
1355  0473 ae4014        	ldw	x,#16404
1356  0476 89            	pushw	x
1357  0477 ae0000        	ldw	x,#0
1358  047a 89            	pushw	x
1359  047b 1e14          	ldw	x,(OFST-102,sp)
1360  047d cd0000        	call	_WriteFlashWord
1362  0480 5b04          	addw	sp,#4
1363                     ; 269 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1365  0482 96            	ldw	x,sp
1366  0483 1c0012        	addw	x,#OFST-104
1367  0486 89            	pushw	x
1368  0487 4b02          	push	#2
1369  0489 ae01ef        	ldw	x,#L722
1370  048c cd0a50        	call	_bSendSMS
1372  048f 5b03          	addw	sp,#3
1374  0491 ac030603      	jpf	L742
1375  0495               L133:
1376                     ; 272 	else if (strstr(uart_buffer, "P1CalFac = "))
1378  0495 ae018a        	ldw	x,#L743
1379  0498 89            	pushw	x
1380  0499 96            	ldw	x,sp
1381  049a 1c0026        	addw	x,#OFST-84
1382  049d cd0000        	call	_strstr
1384  04a0 5b02          	addw	sp,#2
1385  04a2 a30000        	cpw	x,#0
1386  04a5 276a          	jreq	L543
1387                     ; 274 		t = k + 42;
1389  04a7 7b79          	ld	a,(OFST-1,sp)
1390  04a9 ab2a          	add	a,#42
1391  04ab 6b79          	ld	(OFST-1,sp),a
1393                     ; 275 		for (n = 0; n < 4; n++)
1395  04ad 0f7a          	clr	(OFST+0,sp)
1397  04af               L153:
1398                     ; 277 			calibrationFactor[n] = uart_buffer[t];
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
1422                     ; 278 			t++;
1424  04cb 0c79          	inc	(OFST-1,sp)
1426                     ; 275 		for (n = 0; n < 4; n++)
1428  04cd 0c7a          	inc	(OFST+0,sp)
1432  04cf 7b7a          	ld	a,(OFST+0,sp)
1433  04d1 a104          	cp	a,#4
1434  04d3 25da          	jrult	L153
1435                     ; 280 		calibrationFactor[n] = '\0';
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
1447                     ; 281 		value = atoi(calibrationFactor);
1449  04e2 96            	ldw	x,sp
1450  04e3 1c0020        	addw	x,#OFST-90
1451  04e6 cd0000        	call	_atoi
1453  04e9 1f10          	ldw	(OFST-106,sp),x
1455                     ; 282 		powerCalibrationFactor1 = value; //Added By saqib, earlier not present
1457  04eb 1e10          	ldw	x,(OFST-106,sp)
1458  04ed bf00          	ldw	_powerCalibrationFactor1,x
1459                     ; 288 		WriteFlashWord(value, P1CabFab);
1461  04ef ae4018        	ldw	x,#16408
1462  04f2 89            	pushw	x
1463  04f3 ae0000        	ldw	x,#0
1464  04f6 89            	pushw	x
1465  04f7 1e14          	ldw	x,(OFST-102,sp)
1466  04f9 cd0000        	call	_WriteFlashWord
1468  04fc 5b04          	addw	sp,#4
1469                     ; 289 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1471  04fe 96            	ldw	x,sp
1472  04ff 1c0012        	addw	x,#OFST-104
1473  0502 89            	pushw	x
1474  0503 4b02          	push	#2
1475  0505 ae01ef        	ldw	x,#L722
1476  0508 cd0a50        	call	_bSendSMS
1478  050b 5b03          	addw	sp,#3
1480  050d ac030603      	jpf	L742
1481  0511               L543:
1482                     ; 292 	else if (strstr(uart_buffer, "P2CalFac = "))
1484  0511 ae017e        	ldw	x,#L363
1485  0514 89            	pushw	x
1486  0515 96            	ldw	x,sp
1487  0516 1c0026        	addw	x,#OFST-84
1488  0519 cd0000        	call	_strstr
1490  051c 5b02          	addw	sp,#2
1491  051e a30000        	cpw	x,#0
1492  0521 2768          	jreq	L163
1493                     ; 294 		t = k + 42;
1495  0523 7b79          	ld	a,(OFST-1,sp)
1496  0525 ab2a          	add	a,#42
1497  0527 6b79          	ld	(OFST-1,sp),a
1499                     ; 295 		for (n = 0; n < 4; n++)
1501  0529 0f7a          	clr	(OFST+0,sp)
1503  052b               L563:
1504                     ; 297 			calibrationFactor[n] = uart_buffer[t];
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
1528                     ; 298 			t++;
1530  0547 0c79          	inc	(OFST-1,sp)
1532                     ; 295 		for (n = 0; n < 4; n++)
1534  0549 0c7a          	inc	(OFST+0,sp)
1538  054b 7b7a          	ld	a,(OFST+0,sp)
1539  054d a104          	cp	a,#4
1540  054f 25da          	jrult	L563
1541                     ; 300 		calibrationFactor[n] = '\0';
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
1553                     ; 301 		value = atoi(calibrationFactor);
1555  055e 96            	ldw	x,sp
1556  055f 1c0020        	addw	x,#OFST-90
1557  0562 cd0000        	call	_atoi
1559  0565 1f10          	ldw	(OFST-106,sp),x
1561                     ; 302 		powerCalibrationFactor2 = value; //Added By saqib, earlier not present
1563  0567 1e10          	ldw	x,(OFST-106,sp)
1564  0569 bf00          	ldw	_powerCalibrationFactor2,x
1565                     ; 308 		WriteFlashWord(value, P2CabFab);
1567  056b ae401c        	ldw	x,#16412
1568  056e 89            	pushw	x
1569  056f ae0000        	ldw	x,#0
1570  0572 89            	pushw	x
1571  0573 1e14          	ldw	x,(OFST-102,sp)
1572  0575 cd0000        	call	_WriteFlashWord
1574  0578 5b04          	addw	sp,#4
1575                     ; 309 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1577  057a 96            	ldw	x,sp
1578  057b 1c0012        	addw	x,#OFST-104
1579  057e 89            	pushw	x
1580  057f 4b02          	push	#2
1581  0581 ae01ef        	ldw	x,#L722
1582  0584 cd0a50        	call	_bSendSMS
1584  0587 5b03          	addw	sp,#3
1586  0589 2078          	jra	L742
1587  058b               L163:
1588                     ; 312 	else if (strstr(uart_buffer, "P3CalFac = "))
1590  058b ae0172        	ldw	x,#L773
1591  058e 89            	pushw	x
1592  058f 96            	ldw	x,sp
1593  0590 1c0026        	addw	x,#OFST-84
1594  0593 cd0000        	call	_strstr
1596  0596 5b02          	addw	sp,#2
1597  0598 a30000        	cpw	x,#0
1598  059b 2766          	jreq	L742
1599                     ; 314 		t = k + 42;
1601  059d 7b79          	ld	a,(OFST-1,sp)
1602  059f ab2a          	add	a,#42
1603  05a1 6b79          	ld	(OFST-1,sp),a
1605                     ; 315 		for (n = 0; n < 4; n++)
1607  05a3 0f7a          	clr	(OFST+0,sp)
1609  05a5               L104:
1610                     ; 317 			calibrationFactor[n] = uart_buffer[t];
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
1634                     ; 318 			t++;
1636  05c1 0c79          	inc	(OFST-1,sp)
1638                     ; 315 		for (n = 0; n < 4; n++)
1640  05c3 0c7a          	inc	(OFST+0,sp)
1644  05c5 7b7a          	ld	a,(OFST+0,sp)
1645  05c7 a104          	cp	a,#4
1646  05c9 25da          	jrult	L104
1647                     ; 320 		calibrationFactor[n] = '\0';
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
1659                     ; 321 		value = atoi(calibrationFactor);
1661  05d8 96            	ldw	x,sp
1662  05d9 1c0020        	addw	x,#OFST-90
1663  05dc cd0000        	call	_atoi
1665  05df 1f10          	ldw	(OFST-106,sp),x
1667                     ; 322 		powerCalibrationFactor3 = value;
1669  05e1 1e10          	ldw	x,(OFST-106,sp)
1670  05e3 bf00          	ldw	_powerCalibrationFactor3,x
1671                     ; 329 		WriteFlashWord(value, P3CabFab);
1673  05e5 ae4020        	ldw	x,#16416
1674  05e8 89            	pushw	x
1675  05e9 ae0000        	ldw	x,#0
1676  05ec 89            	pushw	x
1677  05ed 1e14          	ldw	x,(OFST-102,sp)
1678  05ef cd0000        	call	_WriteFlashWord
1680  05f2 5b04          	addw	sp,#4
1681                     ; 330 		bSendSMS("OK",strlen((const char*)"OK"),cell_num);
1683  05f4 96            	ldw	x,sp
1684  05f5 1c0012        	addw	x,#OFST-104
1685  05f8 89            	pushw	x
1686  05f9 4b02          	push	#2
1687  05fb ae01ef        	ldw	x,#L722
1688  05fe cd0a50        	call	_bSendSMS
1690  0601 5b03          	addw	sp,#3
1691  0603               L742:
1692                     ; 333 	if (strstr(uart_buffer, "CURRENT1"))
1694  0603 ae0169        	ldw	x,#L114
1695  0606 89            	pushw	x
1696  0607 96            	ldw	x,sp
1697  0608 1c0026        	addw	x,#OFST-84
1698  060b cd0000        	call	_strstr
1700  060e 5b02          	addw	sp,#2
1701  0610 a30000        	cpw	x,#0
1702  0613 2716          	jreq	L704
1703                     ; 335 		sendSMSCurrent(Ampere_Phase1, cell_num); //Changed by Saqib
1705  0615 96            	ldw	x,sp
1706  0616 1c0012        	addw	x,#OFST-104
1707  0619 89            	pushw	x
1708  061a ce0002        	ldw	x,_Ampere_Phase1+2
1709  061d 89            	pushw	x
1710  061e ce0000        	ldw	x,_Ampere_Phase1
1711  0621 89            	pushw	x
1712  0622 cd0c0b        	call	_sendSMSCurrent
1714  0625 5b06          	addw	sp,#6
1716  0627 ac3b0a3b      	jpf	L314
1717  062b               L704:
1718                     ; 337 	else if ((strstr(uart_buffer, "VOLTAGE1")))
1720  062b ae0160        	ldw	x,#L714
1721  062e 89            	pushw	x
1722  062f 96            	ldw	x,sp
1723  0630 1c0026        	addw	x,#OFST-84
1724  0633 cd0000        	call	_strstr
1726  0636 5b02          	addw	sp,#2
1727  0638 a30000        	cpw	x,#0
1728  063b 2716          	jreq	L514
1729                     ; 339 		sendSMSVoltage(Voltage_Phase1, cell_num); //Changed by Saqib
1731  063d 96            	ldw	x,sp
1732  063e 1c0012        	addw	x,#OFST-104
1733  0641 89            	pushw	x
1734  0642 ce0002        	ldw	x,_Voltage_Phase1+2
1735  0645 89            	pushw	x
1736  0646 ce0000        	ldw	x,_Voltage_Phase1
1737  0649 89            	pushw	x
1738  064a cd0cf5        	call	_sendSMSVoltage
1740  064d 5b06          	addw	sp,#6
1742  064f ac3b0a3b      	jpf	L314
1743  0653               L514:
1744                     ; 341 	else if ((strstr(uart_buffer, "POWER1")))
1746  0653 ae0159        	ldw	x,#L524
1747  0656 89            	pushw	x
1748  0657 96            	ldw	x,sp
1749  0658 1c0026        	addw	x,#OFST-84
1750  065b cd0000        	call	_strstr
1752  065e 5b02          	addw	sp,#2
1753  0660 a30000        	cpw	x,#0
1754  0663 2716          	jreq	L324
1755                     ; 343 		sendSMSPower(Watt_Phase1, cell_num); //Changed by Saqib
1757  0665 96            	ldw	x,sp
1758  0666 1c0012        	addw	x,#OFST-104
1759  0669 89            	pushw	x
1760  066a ce0002        	ldw	x,_Watt_Phase1+2
1761  066d 89            	pushw	x
1762  066e ce0000        	ldw	x,_Watt_Phase1
1763  0671 89            	pushw	x
1764  0672 cd0ddf        	call	_sendSMSPower
1766  0675 5b06          	addw	sp,#6
1768  0677 ac3b0a3b      	jpf	L314
1769  067b               L324:
1770                     ; 345 	else if (strstr(uart_buffer, "CURRENT2"))
1772  067b ae0150        	ldw	x,#L334
1773  067e 89            	pushw	x
1774  067f 96            	ldw	x,sp
1775  0680 1c0026        	addw	x,#OFST-84
1776  0683 cd0000        	call	_strstr
1778  0686 5b02          	addw	sp,#2
1779  0688 a30000        	cpw	x,#0
1780  068b 2716          	jreq	L134
1781                     ; 347 		sendSMSCurrent(Ampere_Phase2, cell_num); //Changed by Saqib
1783  068d 96            	ldw	x,sp
1784  068e 1c0012        	addw	x,#OFST-104
1785  0691 89            	pushw	x
1786  0692 ce0002        	ldw	x,_Ampere_Phase2+2
1787  0695 89            	pushw	x
1788  0696 ce0000        	ldw	x,_Ampere_Phase2
1789  0699 89            	pushw	x
1790  069a cd0c0b        	call	_sendSMSCurrent
1792  069d 5b06          	addw	sp,#6
1794  069f ac3b0a3b      	jpf	L314
1795  06a3               L134:
1796                     ; 349 	else if ((strstr(uart_buffer, "VOLTAGE2")))
1798  06a3 ae0147        	ldw	x,#L144
1799  06a6 89            	pushw	x
1800  06a7 96            	ldw	x,sp
1801  06a8 1c0026        	addw	x,#OFST-84
1802  06ab cd0000        	call	_strstr
1804  06ae 5b02          	addw	sp,#2
1805  06b0 a30000        	cpw	x,#0
1806  06b3 2716          	jreq	L734
1807                     ; 351 		sendSMSVoltage(Voltage_Phase2, cell_num); //Changed by Saqib
1809  06b5 96            	ldw	x,sp
1810  06b6 1c0012        	addw	x,#OFST-104
1811  06b9 89            	pushw	x
1812  06ba ce0002        	ldw	x,_Voltage_Phase2+2
1813  06bd 89            	pushw	x
1814  06be ce0000        	ldw	x,_Voltage_Phase2
1815  06c1 89            	pushw	x
1816  06c2 cd0cf5        	call	_sendSMSVoltage
1818  06c5 5b06          	addw	sp,#6
1820  06c7 ac3b0a3b      	jpf	L314
1821  06cb               L734:
1822                     ; 353 	else if ((strstr(uart_buffer, "POWER2")))
1824  06cb ae0140        	ldw	x,#L744
1825  06ce 89            	pushw	x
1826  06cf 96            	ldw	x,sp
1827  06d0 1c0026        	addw	x,#OFST-84
1828  06d3 cd0000        	call	_strstr
1830  06d6 5b02          	addw	sp,#2
1831  06d8 a30000        	cpw	x,#0
1832  06db 2716          	jreq	L544
1833                     ; 355 		sendSMSPower(Watt_Phase2, cell_num); //Changed by Saqib
1835  06dd 96            	ldw	x,sp
1836  06de 1c0012        	addw	x,#OFST-104
1837  06e1 89            	pushw	x
1838  06e2 ce0002        	ldw	x,_Watt_Phase2+2
1839  06e5 89            	pushw	x
1840  06e6 ce0000        	ldw	x,_Watt_Phase2
1841  06e9 89            	pushw	x
1842  06ea cd0ddf        	call	_sendSMSPower
1844  06ed 5b06          	addw	sp,#6
1846  06ef ac3b0a3b      	jpf	L314
1847  06f3               L544:
1848                     ; 357 	else if (strstr(uart_buffer, "CURRENT3"))
1850  06f3 ae0137        	ldw	x,#L554
1851  06f6 89            	pushw	x
1852  06f7 96            	ldw	x,sp
1853  06f8 1c0026        	addw	x,#OFST-84
1854  06fb cd0000        	call	_strstr
1856  06fe 5b02          	addw	sp,#2
1857  0700 a30000        	cpw	x,#0
1858  0703 2716          	jreq	L354
1859                     ; 359 		sendSMSCurrent(Ampere_Phase3, cell_num); //Changed by Saqib
1861  0705 96            	ldw	x,sp
1862  0706 1c0012        	addw	x,#OFST-104
1863  0709 89            	pushw	x
1864  070a ce0002        	ldw	x,_Ampere_Phase3+2
1865  070d 89            	pushw	x
1866  070e ce0000        	ldw	x,_Ampere_Phase3
1867  0711 89            	pushw	x
1868  0712 cd0c0b        	call	_sendSMSCurrent
1870  0715 5b06          	addw	sp,#6
1872  0717 ac3b0a3b      	jpf	L314
1873  071b               L354:
1874                     ; 361 	else if ((strstr(uart_buffer, "VOLTAGE3")))
1876  071b ae012e        	ldw	x,#L364
1877  071e 89            	pushw	x
1878  071f 96            	ldw	x,sp
1879  0720 1c0026        	addw	x,#OFST-84
1880  0723 cd0000        	call	_strstr
1882  0726 5b02          	addw	sp,#2
1883  0728 a30000        	cpw	x,#0
1884  072b 2716          	jreq	L164
1885                     ; 363 		sendSMSVoltage(Voltage_Phase3, cell_num); //Changed by Saqib
1887  072d 96            	ldw	x,sp
1888  072e 1c0012        	addw	x,#OFST-104
1889  0731 89            	pushw	x
1890  0732 ce0002        	ldw	x,_Voltage_Phase3+2
1891  0735 89            	pushw	x
1892  0736 ce0000        	ldw	x,_Voltage_Phase3
1893  0739 89            	pushw	x
1894  073a cd0cf5        	call	_sendSMSVoltage
1896  073d 5b06          	addw	sp,#6
1898  073f ac3b0a3b      	jpf	L314
1899  0743               L164:
1900                     ; 365 	else if ((strstr(uart_buffer, "POWER3")))
1902  0743 ae0127        	ldw	x,#L174
1903  0746 89            	pushw	x
1904  0747 96            	ldw	x,sp
1905  0748 1c0026        	addw	x,#OFST-84
1906  074b cd0000        	call	_strstr
1908  074e 5b02          	addw	sp,#2
1909  0750 a30000        	cpw	x,#0
1910  0753 2716          	jreq	L764
1911                     ; 367 		sendSMSPower(Watt_Phase3, cell_num); //Changed by Saqib
1913  0755 96            	ldw	x,sp
1914  0756 1c0012        	addw	x,#OFST-104
1915  0759 89            	pushw	x
1916  075a ce0002        	ldw	x,_Watt_Phase3+2
1917  075d 89            	pushw	x
1918  075e ce0000        	ldw	x,_Watt_Phase3
1919  0761 89            	pushw	x
1920  0762 cd0ddf        	call	_sendSMSPower
1922  0765 5b06          	addw	sp,#6
1924  0767 ac3b0a3b      	jpf	L314
1925  076b               L764:
1926                     ; 369 	else if ((strstr(uart_buffer, "RADIATOR-TEMP")))
1928  076b ae0119        	ldw	x,#L774
1929  076e 89            	pushw	x
1930  076f 96            	ldw	x,sp
1931  0770 1c0026        	addw	x,#OFST-84
1932  0773 cd0000        	call	_strstr
1934  0776 5b02          	addw	sp,#2
1935  0778 a30000        	cpw	x,#0
1936  077b 2603          	jrne	L621
1937  077d cc083e        	jp	L574
1938  0780               L621:
1939                     ; 371 		myVar = (uint32_t)(Temperature1 * 100);
1941  0780 ae0000        	ldw	x,#_Temperature1
1942  0783 cd0000        	call	c_ltor
1944  0786 ae0115        	ldw	x,#L505
1945  0789 cd0000        	call	c_fmul
1947  078c cd0000        	call	c_ftol
1949  078f 96            	ldw	x,sp
1950  0790 1c0001        	addw	x,#OFST-121
1951  0793 cd0000        	call	c_rtol
1954                     ; 372 		vClearBuffer(uart_buffer, 85);
1956  0796 4b55          	push	#85
1957  0798 96            	ldw	x,sp
1958  0799 1c0025        	addw	x,#OFST-85
1959  079c cd0000        	call	_vClearBuffer
1961  079f 84            	pop	a
1962                     ; 373 		strcpy(uart_buffer, "Radiator Temperature: ");
1964  07a0 96            	ldw	x,sp
1965  07a1 1c0024        	addw	x,#OFST-86
1966  07a4 90ae00fe      	ldw	y,#L115
1967  07a8               L411:
1968  07a8 90f6          	ld	a,(y)
1969  07aa 905c          	incw	y
1970  07ac f7            	ld	(x),a
1971  07ad 5c            	incw	x
1972  07ae 4d            	tnz	a
1973  07af 26f7          	jrne	L411
1974                     ; 374 		sprintf(temp1, "%ld", myVar / 100);
1976  07b1 96            	ldw	x,sp
1977  07b2 1c0001        	addw	x,#OFST-121
1978  07b5 cd0000        	call	c_ltor
1980  07b8 ae000a        	ldw	x,#L611
1981  07bb cd0000        	call	c_ludv
1983  07be be02          	ldw	x,c_lreg+2
1984  07c0 89            	pushw	x
1985  07c1 be00          	ldw	x,c_lreg
1986  07c3 89            	pushw	x
1987  07c4 ae00fa        	ldw	x,#L315
1988  07c7 89            	pushw	x
1989  07c8 96            	ldw	x,sp
1990  07c9 1c000c        	addw	x,#OFST-110
1991  07cc cd0000        	call	_sprintf
1993  07cf 5b06          	addw	sp,#6
1994                     ; 375 		strcat(uart_buffer, temp1);
1996  07d1 96            	ldw	x,sp
1997  07d2 1c0006        	addw	x,#OFST-116
1998  07d5 89            	pushw	x
1999  07d6 96            	ldw	x,sp
2000  07d7 1c0026        	addw	x,#OFST-84
2001  07da cd0000        	call	_strcat
2003  07dd 85            	popw	x
2004                     ; 376 		strcat(uart_buffer, ".");
2006  07de ae00f8        	ldw	x,#L515
2007  07e1 89            	pushw	x
2008  07e2 96            	ldw	x,sp
2009  07e3 1c0026        	addw	x,#OFST-84
2010  07e6 cd0000        	call	_strcat
2012  07e9 85            	popw	x
2013                     ; 377 		sprintf(temp1, "%ld", myVar % 100);
2015  07ea 96            	ldw	x,sp
2016  07eb 1c0001        	addw	x,#OFST-121
2017  07ee cd0000        	call	c_ltor
2019  07f1 ae000a        	ldw	x,#L611
2020  07f4 cd0000        	call	c_lumd
2022  07f7 be02          	ldw	x,c_lreg+2
2023  07f9 89            	pushw	x
2024  07fa be00          	ldw	x,c_lreg
2025  07fc 89            	pushw	x
2026  07fd ae00fa        	ldw	x,#L315
2027  0800 89            	pushw	x
2028  0801 96            	ldw	x,sp
2029  0802 1c000c        	addw	x,#OFST-110
2030  0805 cd0000        	call	_sprintf
2032  0808 5b06          	addw	sp,#6
2033                     ; 378 		strcat(uart_buffer, temp1);
2035  080a 96            	ldw	x,sp
2036  080b 1c0006        	addw	x,#OFST-116
2037  080e 89            	pushw	x
2038  080f 96            	ldw	x,sp
2039  0810 1c0026        	addw	x,#OFST-84
2040  0813 cd0000        	call	_strcat
2042  0816 85            	popw	x
2043                     ; 379 		strcat(uart_buffer, " C");
2045  0817 ae00f5        	ldw	x,#L715
2046  081a 89            	pushw	x
2047  081b 96            	ldw	x,sp
2048  081c 1c0026        	addw	x,#OFST-84
2049  081f cd0000        	call	_strcat
2051  0822 85            	popw	x
2052                     ; 380 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
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
2071                     ; 382 	else if ((strstr(uart_buffer, "ENGINE-TEMP")))
2073  083e ae00e9        	ldw	x,#L525
2074  0841 89            	pushw	x
2075  0842 96            	ldw	x,sp
2076  0843 1c0026        	addw	x,#OFST-84
2077  0846 cd0000        	call	_strstr
2079  0849 5b02          	addw	sp,#2
2080  084b a30000        	cpw	x,#0
2081  084e 2603          	jrne	L031
2082  0850 cc0911        	jp	L325
2083  0853               L031:
2084                     ; 384 		myVar = (uint32_t)(Temperature2 * 100);
2086  0853 ae0000        	ldw	x,#_Temperature2
2087  0856 cd0000        	call	c_ltor
2089  0859 ae0115        	ldw	x,#L505
2090  085c cd0000        	call	c_fmul
2092  085f cd0000        	call	c_ftol
2094  0862 96            	ldw	x,sp
2095  0863 1c0001        	addw	x,#OFST-121
2096  0866 cd0000        	call	c_rtol
2099                     ; 385 		vClearBuffer(uart_buffer, 85);
2101  0869 4b55          	push	#85
2102  086b 96            	ldw	x,sp
2103  086c 1c0025        	addw	x,#OFST-85
2104  086f cd0000        	call	_vClearBuffer
2106  0872 84            	pop	a
2107                     ; 386 		strcpy(uart_buffer, "Engine Temperature: ");
2109  0873 96            	ldw	x,sp
2110  0874 1c0024        	addw	x,#OFST-86
2111  0877 90ae00d4      	ldw	y,#L725
2112  087b               L021:
2113  087b 90f6          	ld	a,(y)
2114  087d 905c          	incw	y
2115  087f f7            	ld	(x),a
2116  0880 5c            	incw	x
2117  0881 4d            	tnz	a
2118  0882 26f7          	jrne	L021
2119                     ; 387 		sprintf(temp1, "%ld", myVar / 100);
2121  0884 96            	ldw	x,sp
2122  0885 1c0001        	addw	x,#OFST-121
2123  0888 cd0000        	call	c_ltor
2125  088b ae000a        	ldw	x,#L611
2126  088e cd0000        	call	c_ludv
2128  0891 be02          	ldw	x,c_lreg+2
2129  0893 89            	pushw	x
2130  0894 be00          	ldw	x,c_lreg
2131  0896 89            	pushw	x
2132  0897 ae00fa        	ldw	x,#L315
2133  089a 89            	pushw	x
2134  089b 96            	ldw	x,sp
2135  089c 1c000c        	addw	x,#OFST-110
2136  089f cd0000        	call	_sprintf
2138  08a2 5b06          	addw	sp,#6
2139                     ; 388 		strcat(uart_buffer, temp1);
2141  08a4 96            	ldw	x,sp
2142  08a5 1c0006        	addw	x,#OFST-116
2143  08a8 89            	pushw	x
2144  08a9 96            	ldw	x,sp
2145  08aa 1c0026        	addw	x,#OFST-84
2146  08ad cd0000        	call	_strcat
2148  08b0 85            	popw	x
2149                     ; 389 		strcat(uart_buffer, ".");
2151  08b1 ae00f8        	ldw	x,#L515
2152  08b4 89            	pushw	x
2153  08b5 96            	ldw	x,sp
2154  08b6 1c0026        	addw	x,#OFST-84
2155  08b9 cd0000        	call	_strcat
2157  08bc 85            	popw	x
2158                     ; 390 		sprintf(temp1, "%ld", myVar % 100);
2160  08bd 96            	ldw	x,sp
2161  08be 1c0001        	addw	x,#OFST-121
2162  08c1 cd0000        	call	c_ltor
2164  08c4 ae000a        	ldw	x,#L611
2165  08c7 cd0000        	call	c_lumd
2167  08ca be02          	ldw	x,c_lreg+2
2168  08cc 89            	pushw	x
2169  08cd be00          	ldw	x,c_lreg
2170  08cf 89            	pushw	x
2171  08d0 ae00fa        	ldw	x,#L315
2172  08d3 89            	pushw	x
2173  08d4 96            	ldw	x,sp
2174  08d5 1c000c        	addw	x,#OFST-110
2175  08d8 cd0000        	call	_sprintf
2177  08db 5b06          	addw	sp,#6
2178                     ; 391 		strcat(uart_buffer, temp1);
2180  08dd 96            	ldw	x,sp
2181  08de 1c0006        	addw	x,#OFST-116
2182  08e1 89            	pushw	x
2183  08e2 96            	ldw	x,sp
2184  08e3 1c0026        	addw	x,#OFST-84
2185  08e6 cd0000        	call	_strcat
2187  08e9 85            	popw	x
2188                     ; 392 		strcat(uart_buffer, " C");
2190  08ea ae00f5        	ldw	x,#L715
2191  08ed 89            	pushw	x
2192  08ee 96            	ldw	x,sp
2193  08ef 1c0026        	addw	x,#OFST-84
2194  08f2 cd0000        	call	_strcat
2196  08f5 85            	popw	x
2197                     ; 393 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
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
2216                     ; 395 	else if ((strstr(uart_buffer, "BATTERY-VOLT")))
2218  0911 ae00c7        	ldw	x,#L535
2219  0914 89            	pushw	x
2220  0915 96            	ldw	x,sp
2221  0916 1c0026        	addw	x,#OFST-84
2222  0919 cd0000        	call	_strstr
2224  091c 5b02          	addw	sp,#2
2225  091e a30000        	cpw	x,#0
2226  0921 2603          	jrne	L231
2227  0923 cc09ca        	jp	L335
2228  0926               L231:
2229                     ; 398 		vClearBuffer(uart_buffer, 85);
2231  0926 4b55          	push	#85
2232  0928 96            	ldw	x,sp
2233  0929 1c0025        	addw	x,#OFST-85
2234  092c cd0000        	call	_vClearBuffer
2236  092f 84            	pop	a
2237                     ; 399 		strcpy(uart_buffer, "Battery: ");
2239  0930 96            	ldw	x,sp
2240  0931 1c0024        	addw	x,#OFST-86
2241  0934 90ae00bd      	ldw	y,#L735
2242  0938               L221:
2243  0938 90f6          	ld	a,(y)
2244  093a 905c          	incw	y
2245  093c f7            	ld	(x),a
2246  093d 5c            	incw	x
2247  093e 4d            	tnz	a
2248  093f 26f7          	jrne	L221
2249                     ; 400 		sprintf(temp1, "%ld", batVolt / 100);
2251  0941 ae0000        	ldw	x,#_batVolt
2252  0944 cd0000        	call	c_ltor
2254  0947 ae000a        	ldw	x,#L611
2255  094a cd0000        	call	c_ludv
2257  094d be02          	ldw	x,c_lreg+2
2258  094f 89            	pushw	x
2259  0950 be00          	ldw	x,c_lreg
2260  0952 89            	pushw	x
2261  0953 ae00fa        	ldw	x,#L315
2262  0956 89            	pushw	x
2263  0957 96            	ldw	x,sp
2264  0958 1c000c        	addw	x,#OFST-110
2265  095b cd0000        	call	_sprintf
2267  095e 5b06          	addw	sp,#6
2268                     ; 401 		strcat(uart_buffer, temp1);
2270  0960 96            	ldw	x,sp
2271  0961 1c0006        	addw	x,#OFST-116
2272  0964 89            	pushw	x
2273  0965 96            	ldw	x,sp
2274  0966 1c0026        	addw	x,#OFST-84
2275  0969 cd0000        	call	_strcat
2277  096c 85            	popw	x
2278                     ; 402 		strcat(uart_buffer, ".");
2280  096d ae00f8        	ldw	x,#L515
2281  0970 89            	pushw	x
2282  0971 96            	ldw	x,sp
2283  0972 1c0026        	addw	x,#OFST-84
2284  0975 cd0000        	call	_strcat
2286  0978 85            	popw	x
2287                     ; 403 		sprintf(temp1, "%ld", batVolt % 100);
2289  0979 ae0000        	ldw	x,#_batVolt
2290  097c cd0000        	call	c_ltor
2292  097f ae000a        	ldw	x,#L611
2293  0982 cd0000        	call	c_lumd
2295  0985 be02          	ldw	x,c_lreg+2
2296  0987 89            	pushw	x
2297  0988 be00          	ldw	x,c_lreg
2298  098a 89            	pushw	x
2299  098b ae00fa        	ldw	x,#L315
2300  098e 89            	pushw	x
2301  098f 96            	ldw	x,sp
2302  0990 1c000c        	addw	x,#OFST-110
2303  0993 cd0000        	call	_sprintf
2305  0996 5b06          	addw	sp,#6
2306                     ; 404 		strcat(uart_buffer, temp1);
2308  0998 96            	ldw	x,sp
2309  0999 1c0006        	addw	x,#OFST-116
2310  099c 89            	pushw	x
2311  099d 96            	ldw	x,sp
2312  099e 1c0026        	addw	x,#OFST-84
2313  09a1 cd0000        	call	_strcat
2315  09a4 85            	popw	x
2316                     ; 405 		strcat(uart_buffer, " Volts");
2318  09a5 ae00b6        	ldw	x,#L145
2319  09a8 89            	pushw	x
2320  09a9 96            	ldw	x,sp
2321  09aa 1c0026        	addw	x,#OFST-84
2322  09ad cd0000        	call	_strcat
2324  09b0 85            	popw	x
2325                     ; 406 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
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
2344                     ; 408 	else if ((strstr(uart_buffer, "FUEL-LEVEL")))
2346  09ca ae00ab        	ldw	x,#L745
2347  09cd 89            	pushw	x
2348  09ce 96            	ldw	x,sp
2349  09cf 1c0026        	addw	x,#OFST-84
2350  09d2 cd0000        	call	_strstr
2352  09d5 5b02          	addw	sp,#2
2353  09d7 a30000        	cpw	x,#0
2354  09da 275f          	jreq	L314
2355                     ; 410 		vClearBuffer(uart_buffer, 85);
2357  09dc 4b55          	push	#85
2358  09de 96            	ldw	x,sp
2359  09df 1c0025        	addw	x,#OFST-85
2360  09e2 cd0000        	call	_vClearBuffer
2362  09e5 84            	pop	a
2363                     ; 411 		strcpy(uart_buffer, "Fuel: ");
2365  09e6 96            	ldw	x,sp
2366  09e7 1c0024        	addw	x,#OFST-86
2367  09ea 90ae00a4      	ldw	y,#L155
2368  09ee               L421:
2369  09ee 90f6          	ld	a,(y)
2370  09f0 905c          	incw	y
2371  09f2 f7            	ld	(x),a
2372  09f3 5c            	incw	x
2373  09f4 4d            	tnz	a
2374  09f5 26f7          	jrne	L421
2375                     ; 412 		sprintf(temp1, "%ld", Fuellevel);
2377  09f7 ce0002        	ldw	x,_Fuellevel+2
2378  09fa 89            	pushw	x
2379  09fb ce0000        	ldw	x,_Fuellevel
2380  09fe 89            	pushw	x
2381  09ff ae00fa        	ldw	x,#L315
2382  0a02 89            	pushw	x
2383  0a03 96            	ldw	x,sp
2384  0a04 1c000c        	addw	x,#OFST-110
2385  0a07 cd0000        	call	_sprintf
2387  0a0a 5b06          	addw	sp,#6
2388                     ; 413 		strcat(uart_buffer, temp1);
2390  0a0c 96            	ldw	x,sp
2391  0a0d 1c0006        	addw	x,#OFST-116
2392  0a10 89            	pushw	x
2393  0a11 96            	ldw	x,sp
2394  0a12 1c0026        	addw	x,#OFST-84
2395  0a15 cd0000        	call	_strcat
2397  0a18 85            	popw	x
2398                     ; 414 		strcat(uart_buffer, " Value");
2400  0a19 ae009d        	ldw	x,#L355
2401  0a1c 89            	pushw	x
2402  0a1d 96            	ldw	x,sp
2403  0a1e 1c0026        	addw	x,#OFST-84
2404  0a21 cd0000        	call	_strcat
2406  0a24 85            	popw	x
2407                     ; 415 		bSendSMS(uart_buffer, strlen((const char *)uart_buffer), cell_num);
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
2424                     ; 418 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2426  0a3b 4b01          	push	#1
2427  0a3d ae0255        	ldw	x,#597
2428  0a40 cd0000        	call	_UART1_ITConfig
2430  0a43 84            	pop	a
2431                     ; 419 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2433  0a44 4b01          	push	#1
2434  0a46 ae0244        	ldw	x,#580
2435  0a49 cd0000        	call	_UART1_ITConfig
2437  0a4c 84            	pop	a
2438                     ; 420 }
2441  0a4d 5b7a          	addw	sp,#122
2442  0a4f 81            	ret
2445                     	switch	.const
2446  000e               L555_buffer:
2447  000e 41542b434d47  	dc.b	"AT+CMGS=",34
2448  0017 2b3932333331  	dc.b	"+923316821907",34,0
2547                     ; 422 bool bSendSMS(char *message, uint8_t messageLength, char *Number)
2547                     ; 423 {
2548                     	switch	.text
2549  0a50               _bSendSMS:
2551  0a50 89            	pushw	x
2552  0a51 5235          	subw	sp,#53
2553       00000035      OFST:	set	53
2556                     ; 424 	uint8_t buffer[24] = "AT+CMGS=\"+923316821907\"";
2558  0a53 96            	ldw	x,sp
2559  0a54 1c0005        	addw	x,#OFST-48
2560  0a57 90ae000e      	ldw	y,#L555_buffer
2561  0a5b a618          	ld	a,#24
2562  0a5d cd0000        	call	c_xymvx
2564                     ; 427 	uint32_t whileTimeout = 650000;
2566  0a60 aeeb10        	ldw	x,#60176
2567  0a63 1f03          	ldw	(OFST-50,sp),x
2568  0a65 ae0009        	ldw	x,#9
2569  0a68 1f01          	ldw	(OFST-52,sp),x
2571                     ; 428 	delay_ms(2000);
2573  0a6a ae07d0        	ldw	x,#2000
2574  0a6d cd0000        	call	_delay_ms
2576                     ; 429 	for (i = 10; i < 22; i++)
2578  0a70 a60a          	ld	a,#10
2579  0a72 6b35          	ld	(OFST+0,sp),a
2581  0a74               L526:
2582                     ; 431 		buffer[i] = *(Number + (i - 9));
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
2600                     ; 429 	for (i = 10; i < 22; i++)
2602  0a90 0c35          	inc	(OFST+0,sp)
2606  0a92 7b35          	ld	a,(OFST+0,sp)
2607  0a94 a116          	cp	a,#22
2608  0a96 25dc          	jrult	L526
2609                     ; 433 	i++;
2611  0a98 0c35          	inc	(OFST+0,sp)
2613                     ; 434 	buffer[i] = '\0';
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
2625                     ; 436 	ms_send_cmd(buffer, strlen((const char *)buffer));
2627  0aa7 96            	ldw	x,sp
2628  0aa8 1c0005        	addw	x,#OFST-48
2629  0aab cd0000        	call	_strlen
2631  0aae 9f            	ld	a,xl
2632  0aaf 88            	push	a
2633  0ab0 96            	ldw	x,sp
2634  0ab1 1c0006        	addw	x,#OFST-47
2635  0ab4 cd0000        	call	_ms_send_cmd
2637  0ab7 84            	pop	a
2638                     ; 437 	delay_ms(20);
2640  0ab8 ae0014        	ldw	x,#20
2641  0abb cd0000        	call	_delay_ms
2643                     ; 439 	for (i = 0; i < messageLength; i++)
2645  0abe 0f35          	clr	(OFST+0,sp)
2648  0ac0 201a          	jra	L736
2649  0ac2               L546:
2650                     ; 441 		while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2652  0ac2 ae0040        	ldw	x,#64
2653  0ac5 cd0000        	call	_UART1_GetFlagStatus
2655  0ac8 4d            	tnz	a
2656  0ac9 27f7          	jreq	L546
2657                     ; 443 		UART1_SendData8(*(message + i));
2659  0acb 7b36          	ld	a,(OFST+1,sp)
2660  0acd 97            	ld	xl,a
2661  0ace 7b37          	ld	a,(OFST+2,sp)
2662  0ad0 1b35          	add	a,(OFST+0,sp)
2663  0ad2 2401          	jrnc	L241
2664  0ad4 5c            	incw	x
2665  0ad5               L241:
2666  0ad5 02            	rlwa	x,a
2667  0ad6 f6            	ld	a,(x)
2668  0ad7 cd0000        	call	_UART1_SendData8
2670                     ; 439 	for (i = 0; i < messageLength; i++)
2672  0ada 0c35          	inc	(OFST+0,sp)
2674  0adc               L736:
2677  0adc 7b35          	ld	a,(OFST+0,sp)
2678  0ade 113a          	cp	a,(OFST+5,sp)
2679  0ae0 25e0          	jrult	L546
2680                     ; 445 	delay_ms(10);
2682  0ae2 ae000a        	ldw	x,#10
2683  0ae5 cd0000        	call	_delay_ms
2686  0ae8               L356:
2687                     ; 446 	while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2689  0ae8 ae0040        	ldw	x,#64
2690  0aeb cd0000        	call	_UART1_GetFlagStatus
2692  0aee 4d            	tnz	a
2693  0aef 27f7          	jreq	L356
2694                     ; 448 	UART1_SendData8(0x1A);
2696  0af1 a61a          	ld	a,#26
2697  0af3 cd0000        	call	_UART1_SendData8
2699                     ; 449 	delay_ms(200); // Wait for 2 Seconds to check response of Module if SMS has been send or not
2701  0af6 ae00c8        	ldw	x,#200
2702  0af9 cd0000        	call	_delay_ms
2704                     ; 451 	tempBuffer[0] = 0;
2706  0afc 0f1d          	clr	(OFST-24,sp)
2708                     ; 452 	tempBuffer[1] = 0;
2710  0afe 0f1e          	clr	(OFST-23,sp)
2713  0b00 2021          	jra	L366
2714  0b02               L176:
2715                     ; 455 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
2717  0b02 ae0020        	ldw	x,#32
2718  0b05 cd0000        	call	_UART1_GetFlagStatus
2720  0b08 4d            	tnz	a
2721  0b09 260c          	jrne	L576
2723  0b0b be09          	ldw	x,_timeout
2724  0b0d 1c0001        	addw	x,#1
2725  0b10 bf09          	ldw	_timeout,x
2726  0b12 a32710        	cpw	x,#10000
2727  0b15 26eb          	jrne	L176
2728  0b17               L576:
2729                     ; 457 		tempBuffer[0] = tempBuffer[1];
2731  0b17 7b1e          	ld	a,(OFST-23,sp)
2732  0b19 6b1d          	ld	(OFST-24,sp),a
2734                     ; 458 		tempBuffer[1] = UART1_ReceiveData8();
2736  0b1b cd0000        	call	_UART1_ReceiveData8
2738  0b1e 6b1e          	ld	(OFST-23,sp),a
2740                     ; 459 		timeout = 0;
2742  0b20 5f            	clrw	x
2743  0b21 bf09          	ldw	_timeout,x
2744  0b23               L366:
2745                     ; 453 	while (tempBuffer[0] != '+' && tempBuffer[1] != 'C' && --whileTimeout > 0)
2747  0b23 7b1d          	ld	a,(OFST-24,sp)
2748  0b25 a12b          	cp	a,#43
2749  0b27 2718          	jreq	L776
2751  0b29 7b1e          	ld	a,(OFST-23,sp)
2752  0b2b a143          	cp	a,#67
2753  0b2d 2712          	jreq	L776
2755  0b2f 96            	ldw	x,sp
2756  0b30 1c0001        	addw	x,#OFST-52
2757  0b33 a601          	ld	a,#1
2758  0b35 cd0000        	call	c_lgsbc
2761  0b38 96            	ldw	x,sp
2762  0b39 1c0001        	addw	x,#OFST-52
2763  0b3c cd0000        	call	c_lzmp
2765  0b3f 26c1          	jrne	L176
2766  0b41               L776:
2767                     ; 461 	for (i = 2; i < 23; i++)
2769  0b41 a602          	ld	a,#2
2770  0b43 6b35          	ld	(OFST+0,sp),a
2772  0b45               L317:
2773                     ; 463 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
2775  0b45 ae0020        	ldw	x,#32
2776  0b48 cd0000        	call	_UART1_GetFlagStatus
2778  0b4b 4d            	tnz	a
2779  0b4c 260c          	jrne	L717
2781  0b4e be09          	ldw	x,_timeout
2782  0b50 1c0001        	addw	x,#1
2783  0b53 bf09          	ldw	_timeout,x
2784  0b55 a32710        	cpw	x,#10000
2785  0b58 26eb          	jrne	L317
2786  0b5a               L717:
2787                     ; 465 		tempBuffer[i] = UART1_ReceiveData8();
2789  0b5a 96            	ldw	x,sp
2790  0b5b 1c001d        	addw	x,#OFST-24
2791  0b5e 9f            	ld	a,xl
2792  0b5f 5e            	swapw	x
2793  0b60 1b35          	add	a,(OFST+0,sp)
2794  0b62 2401          	jrnc	L441
2795  0b64 5c            	incw	x
2796  0b65               L441:
2797  0b65 02            	rlwa	x,a
2798  0b66 89            	pushw	x
2799  0b67 cd0000        	call	_UART1_ReceiveData8
2801  0b6a 85            	popw	x
2802  0b6b f7            	ld	(x),a
2803                     ; 466 		timeout = 0;
2805  0b6c 5f            	clrw	x
2806  0b6d bf09          	ldw	_timeout,x
2807                     ; 461 	for (i = 2; i < 23; i++)
2809  0b6f 0c35          	inc	(OFST+0,sp)
2813  0b71 7b35          	ld	a,(OFST+0,sp)
2814  0b73 a117          	cp	a,#23
2815  0b75 25ce          	jrult	L317
2816                     ; 468 	tempBuffer[i] = '\0';
2818  0b77 96            	ldw	x,sp
2819  0b78 1c001d        	addw	x,#OFST-24
2820  0b7b 9f            	ld	a,xl
2821  0b7c 5e            	swapw	x
2822  0b7d 1b35          	add	a,(OFST+0,sp)
2823  0b7f 2401          	jrnc	L641
2824  0b81 5c            	incw	x
2825  0b82               L641:
2826  0b82 02            	rlwa	x,a
2827  0b83 7f            	clr	(x)
2828                     ; 470 	if (strstr(tempBuffer, "+CMGS"))
2830  0b84 ae0097        	ldw	x,#L327
2831  0b87 89            	pushw	x
2832  0b88 96            	ldw	x,sp
2833  0b89 1c001f        	addw	x,#OFST-22
2834  0b8c cd0000        	call	_strstr
2836  0b8f 5b02          	addw	sp,#2
2837  0b91 a30000        	cpw	x,#0
2838  0b94 2704          	jreq	L127
2839                     ; 472 		return TRUE;
2841  0b96 a601          	ld	a,#1
2843  0b98 2001          	jra	L051
2844  0b9a               L127:
2845                     ; 476 		return FALSE;
2847  0b9a 4f            	clr	a
2849  0b9b               L051:
2851  0b9b 5b37          	addw	sp,#55
2852  0b9d 81            	ret
2855                     	switch	.const
2856  0026               L727_OK:
2857  0026 4f4b00        	dc.b	"OK",0
2922                     ; 540 int GSM_OK(void)
2922                     ; 541 {
2923                     	switch	.text
2924  0b9e               _GSM_OK:
2926  0b9e 5206          	subw	sp,#6
2927       00000006      OFST:	set	6
2930                     ; 543 	uint16_t gsm_ok_timeout = 30000;
2932  0ba0 ae7530        	ldw	x,#30000
2933  0ba3 1f04          	ldw	(OFST-2,sp),x
2935                     ; 544 	const char OK[3] = "OK";
2937  0ba5 96            	ldw	x,sp
2938  0ba6 1c0001        	addw	x,#OFST-5
2939  0ba9 90ae0026      	ldw	y,#L727_OK
2940  0bad a603          	ld	a,#3
2941  0baf cd0000        	call	c_xymvx
2943                     ; 547 	for (p = 0; p < 30; p++) //8 for error
2945  0bb2 0f06          	clr	(OFST+0,sp)
2947  0bb4               L377:
2948                     ; 549 		while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == FALSE && (--gsm_ok_timeout > 0))
2950  0bb4 ae0020        	ldw	x,#32
2951  0bb7 cd0000        	call	_UART1_GetFlagStatus
2953  0bba 4d            	tnz	a
2954  0bbb 2609          	jrne	L777
2956  0bbd 1e04          	ldw	x,(OFST-2,sp)
2957  0bbf 1d0001        	subw	x,#1
2958  0bc2 1f04          	ldw	(OFST-2,sp),x
2960  0bc4 26ee          	jrne	L377
2961  0bc6               L777:
2962                     ; 552 		response_buffer[p] = UART1_ReceiveData8();
2964  0bc6 7b06          	ld	a,(OFST+0,sp)
2965  0bc8 5f            	clrw	x
2966  0bc9 97            	ld	xl,a
2967  0bca 89            	pushw	x
2968  0bcb cd0000        	call	_UART1_ReceiveData8
2970  0bce 85            	popw	x
2971  0bcf d70000        	ld	(_response_buffer,x),a
2972                     ; 547 	for (p = 0; p < 30; p++) //8 for error
2974  0bd2 0c06          	inc	(OFST+0,sp)
2978  0bd4 7b06          	ld	a,(OFST+0,sp)
2979  0bd6 a11e          	cp	a,#30
2980  0bd8 25da          	jrult	L377
2981                     ; 555 	ret1 = strstr(response_buffer, OK);
2983  0bda 96            	ldw	x,sp
2984  0bdb 1c0001        	addw	x,#OFST-5
2985  0bde 89            	pushw	x
2986  0bdf ae0000        	ldw	x,#_response_buffer
2987  0be2 cd0000        	call	_strstr
2989  0be5 5b02          	addw	sp,#2
2990  0be7 1f04          	ldw	(OFST-2,sp),x
2992                     ; 557 	if (ret1)
2994  0be9 1e04          	ldw	x,(OFST-2,sp)
2995  0beb 2705          	jreq	L1001
2996                     ; 559 		return 1;
2998  0bed ae0001        	ldw	x,#1
3000  0bf0 2001          	jra	L451
3001  0bf2               L1001:
3002                     ; 565 		return 0;
3004  0bf2 5f            	clrw	x
3006  0bf3               L451:
3008  0bf3 5b06          	addw	sp,#6
3009  0bf5 81            	ret
3044                     ; 569 void clearBuffer()
3044                     ; 570 {
3045                     	switch	.text
3046  0bf6               _clearBuffer:
3048  0bf6 88            	push	a
3049       00000001      OFST:	set	1
3052                     ; 572 	for (s = 0; s < 100; s++)
3054  0bf7 0f01          	clr	(OFST+0,sp)
3056  0bf9               L3201:
3057                     ; 575 		response_buffer[s] = '\0';
3059  0bf9 7b01          	ld	a,(OFST+0,sp)
3060  0bfb 5f            	clrw	x
3061  0bfc 97            	ld	xl,a
3062  0bfd 724f0000      	clr	(_response_buffer,x)
3063                     ; 572 	for (s = 0; s < 100; s++)
3065  0c01 0c01          	inc	(OFST+0,sp)
3069  0c03 7b01          	ld	a,(OFST+0,sp)
3070  0c05 a164          	cp	a,#100
3071  0c07 25f0          	jrult	L3201
3072                     ; 578 }
3075  0c09 84            	pop	a
3076  0c0a 81            	ret
3079                     	switch	.const
3080  0029               L1301_current:
3081  0029 43757272656e  	dc.b	"Current is ",0
3082  0035 000000000000  	ds.b	14
3083  0043               L3301_currentUnit:
3084  0043 20416d707300  	dc.b	" Amps",0
3215                     ; 581 void sendSMSCurrent(uint32_t Current, uint8_t *cell_number)
3215                     ; 582 {
3216                     	switch	.text
3217  0c0b               _sendSMSCurrent:
3219  0c0b 5239          	subw	sp,#57
3220       00000039      OFST:	set	57
3223                     ; 586 	uint8_t current[26] = "Current is ";
3225  0c0d 96            	ldw	x,sp
3226  0c0e 1c0007        	addw	x,#OFST-50
3227  0c11 90ae0029      	ldw	y,#L1301_current
3228  0c15 a61a          	ld	a,#26
3229  0c17 cd0000        	call	c_xymvx
3231                     ; 587 	uint8_t currentUnit[6] = " Amps";
3233  0c1a 96            	ldw	x,sp
3234  0c1b 1c0001        	addw	x,#OFST-56
3235  0c1e 90ae0043      	ldw	y,#L3301_currentUnit
3236  0c22 a606          	ld	a,#6
3237  0c24 cd0000        	call	c_xymvx
3239                     ; 588 	uint8_t templen = 0;
3241                     ; 589 	uint8_t decplace = 0;
3243                     ; 593 	sprintf(tempwho, "%lu", Current);
3245  0c27 1e3e          	ldw	x,(OFST+5,sp)
3246  0c29 89            	pushw	x
3247  0c2a 1e3e          	ldw	x,(OFST+5,sp)
3248  0c2c 89            	pushw	x
3249  0c2d ae0093        	ldw	x,#L3211
3250  0c30 89            	pushw	x
3251  0c31 96            	ldw	x,sp
3252  0c32 1c0028        	addw	x,#OFST-17
3253  0c35 cd0000        	call	_sprintf
3255  0c38 5b06          	addw	sp,#6
3256                     ; 594 	templen = strlen(tempwho);
3258  0c3a 96            	ldw	x,sp
3259  0c3b 1c0022        	addw	x,#OFST-23
3260  0c3e cd0000        	call	_strlen
3262  0c41 01            	rrwa	x,a
3263  0c42 6b21          	ld	(OFST-24,sp),a
3264  0c44 02            	rlwa	x,a
3266                     ; 595 	decplace = templen - 2;
3268  0c45 7b21          	ld	a,(OFST-24,sp)
3269  0c47 a002          	sub	a,#2
3270  0c49 6b38          	ld	(OFST-1,sp),a
3272                     ; 596 	tempwho2[decplace] = '.';
3274  0c4b 96            	ldw	x,sp
3275  0c4c 1c0028        	addw	x,#OFST-17
3276  0c4f 9f            	ld	a,xl
3277  0c50 5e            	swapw	x
3278  0c51 1b38          	add	a,(OFST-1,sp)
3279  0c53 2401          	jrnc	L261
3280  0c55 5c            	incw	x
3281  0c56               L261:
3282  0c56 02            	rlwa	x,a
3283  0c57 a62e          	ld	a,#46
3284  0c59 f7            	ld	(x),a
3285                     ; 597 	for (w = 0; w < decplace; w++)
3287  0c5a 0f39          	clr	(OFST+0,sp)
3290  0c5c 201e          	jra	L1311
3291  0c5e               L5211:
3292                     ; 599 		tempwho2[w] = tempwho[w];
3294  0c5e 96            	ldw	x,sp
3295  0c5f 1c0028        	addw	x,#OFST-17
3296  0c62 9f            	ld	a,xl
3297  0c63 5e            	swapw	x
3298  0c64 1b39          	add	a,(OFST+0,sp)
3299  0c66 2401          	jrnc	L461
3300  0c68 5c            	incw	x
3301  0c69               L461:
3302  0c69 02            	rlwa	x,a
3303  0c6a 89            	pushw	x
3304  0c6b 96            	ldw	x,sp
3305  0c6c 1c0024        	addw	x,#OFST-21
3306  0c6f 9f            	ld	a,xl
3307  0c70 5e            	swapw	x
3308  0c71 1b3b          	add	a,(OFST+2,sp)
3309  0c73 2401          	jrnc	L661
3310  0c75 5c            	incw	x
3311  0c76               L661:
3312  0c76 02            	rlwa	x,a
3313  0c77 f6            	ld	a,(x)
3314  0c78 85            	popw	x
3315  0c79 f7            	ld	(x),a
3316                     ; 597 	for (w = 0; w < decplace; w++)
3318  0c7a 0c39          	inc	(OFST+0,sp)
3320  0c7c               L1311:
3323  0c7c 7b39          	ld	a,(OFST+0,sp)
3324  0c7e 1138          	cp	a,(OFST-1,sp)
3325  0c80 25dc          	jrult	L5211
3326                     ; 601 	f = decplace + 1;
3328  0c82 7b38          	ld	a,(OFST-1,sp)
3329  0c84 4c            	inc	a
3330  0c85 6b38          	ld	(OFST-1,sp),a
3332                     ; 602 	for (w = f; w <= templen; w++)
3334  0c87 7b38          	ld	a,(OFST-1,sp)
3335  0c89 6b39          	ld	(OFST+0,sp),a
3338  0c8b 2023          	jra	L1411
3339  0c8d               L5311:
3340                     ; 604 		u = w - 1;
3342  0c8d 7b39          	ld	a,(OFST+0,sp)
3343  0c8f 4a            	dec	a
3344  0c90 6b38          	ld	(OFST-1,sp),a
3346                     ; 605 		tempwho2[w] = tempwho[u];
3348  0c92 96            	ldw	x,sp
3349  0c93 1c0028        	addw	x,#OFST-17
3350  0c96 9f            	ld	a,xl
3351  0c97 5e            	swapw	x
3352  0c98 1b39          	add	a,(OFST+0,sp)
3353  0c9a 2401          	jrnc	L071
3354  0c9c 5c            	incw	x
3355  0c9d               L071:
3356  0c9d 02            	rlwa	x,a
3357  0c9e 89            	pushw	x
3358  0c9f 96            	ldw	x,sp
3359  0ca0 1c0024        	addw	x,#OFST-21
3360  0ca3 9f            	ld	a,xl
3361  0ca4 5e            	swapw	x
3362  0ca5 1b3a          	add	a,(OFST+1,sp)
3363  0ca7 2401          	jrnc	L271
3364  0ca9 5c            	incw	x
3365  0caa               L271:
3366  0caa 02            	rlwa	x,a
3367  0cab f6            	ld	a,(x)
3368  0cac 85            	popw	x
3369  0cad f7            	ld	(x),a
3370                     ; 602 	for (w = f; w <= templen; w++)
3372  0cae 0c39          	inc	(OFST+0,sp)
3374  0cb0               L1411:
3377  0cb0 7b39          	ld	a,(OFST+0,sp)
3378  0cb2 1121          	cp	a,(OFST-24,sp)
3379  0cb4 23d7          	jrule	L5311
3380                     ; 607 	tempwho2[w] = '\0';
3382  0cb6 96            	ldw	x,sp
3383  0cb7 1c0028        	addw	x,#OFST-17
3384  0cba 9f            	ld	a,xl
3385  0cbb 5e            	swapw	x
3386  0cbc 1b39          	add	a,(OFST+0,sp)
3387  0cbe 2401          	jrnc	L471
3388  0cc0 5c            	incw	x
3389  0cc1               L471:
3390  0cc1 02            	rlwa	x,a
3391  0cc2 7f            	clr	(x)
3392                     ; 608 	strcat(tempwho2, currentUnit);
3394  0cc3 96            	ldw	x,sp
3395  0cc4 1c0001        	addw	x,#OFST-56
3396  0cc7 89            	pushw	x
3397  0cc8 96            	ldw	x,sp
3398  0cc9 1c002a        	addw	x,#OFST-15
3399  0ccc cd0000        	call	_strcat
3401  0ccf 85            	popw	x
3402                     ; 609 	strcat(current, tempwho2);
3404  0cd0 96            	ldw	x,sp
3405  0cd1 1c0028        	addw	x,#OFST-17
3406  0cd4 89            	pushw	x
3407  0cd5 96            	ldw	x,sp
3408  0cd6 1c0009        	addw	x,#OFST-48
3409  0cd9 cd0000        	call	_strcat
3411  0cdc 85            	popw	x
3412                     ; 610 	bSendSMS(current, strlen((const char *)current), cell_number);
3414  0cdd 1e40          	ldw	x,(OFST+7,sp)
3415  0cdf 89            	pushw	x
3416  0ce0 96            	ldw	x,sp
3417  0ce1 1c0009        	addw	x,#OFST-48
3418  0ce4 cd0000        	call	_strlen
3420  0ce7 9f            	ld	a,xl
3421  0ce8 88            	push	a
3422  0ce9 96            	ldw	x,sp
3423  0cea 1c000a        	addw	x,#OFST-47
3424  0ced cd0a50        	call	_bSendSMS
3426  0cf0 5b03          	addw	sp,#3
3427                     ; 611 }
3430  0cf2 5b39          	addw	sp,#57
3431  0cf4 81            	ret
3434                     	switch	.const
3435  0049               L5411_voltage:
3436  0049 566f6c746167  	dc.b	"Voltage is ",0
3437  0055 000000000000  	ds.b	17
3438  0066               L7411_voltageUnit:
3439  0066 20566f6c7473  	dc.b	" Volts",0
3570                     ; 613 void sendSMSVoltage(uint32_t Voltage, uint8_t *cell_number)
3570                     ; 614 {
3571                     	switch	.text
3572  0cf5               _sendSMSVoltage:
3574  0cf5 523d          	subw	sp,#61
3575       0000003d      OFST:	set	61
3578                     ; 618 	uint8_t voltage[29] = "Voltage is ";
3580  0cf7 96            	ldw	x,sp
3581  0cf8 1c0008        	addw	x,#OFST-53
3582  0cfb 90ae0049      	ldw	y,#L5411_voltage
3583  0cff a61d          	ld	a,#29
3584  0d01 cd0000        	call	c_xymvx
3586                     ; 619 	uint8_t voltageUnit[7] = " Volts";
3588  0d04 96            	ldw	x,sp
3589  0d05 1c0001        	addw	x,#OFST-60
3590  0d08 90ae0066      	ldw	y,#L7411_voltageUnit
3591  0d0c a607          	ld	a,#7
3592  0d0e cd0000        	call	c_xymvx
3594                     ; 620 	uint8_t templen = 0;
3596                     ; 621 	uint8_t decplace = 0;
3598                     ; 625 	sprintf(tempwho, "%lu", Voltage);
3600  0d11 1e42          	ldw	x,(OFST+5,sp)
3601  0d13 89            	pushw	x
3602  0d14 1e42          	ldw	x,(OFST+5,sp)
3603  0d16 89            	pushw	x
3604  0d17 ae0093        	ldw	x,#L3211
3605  0d1a 89            	pushw	x
3606  0d1b 96            	ldw	x,sp
3607  0d1c 1c002c        	addw	x,#OFST-17
3608  0d1f cd0000        	call	_sprintf
3610  0d22 5b06          	addw	sp,#6
3611                     ; 626 	templen = strlen(tempwho);
3613  0d24 96            	ldw	x,sp
3614  0d25 1c0026        	addw	x,#OFST-23
3615  0d28 cd0000        	call	_strlen
3617  0d2b 01            	rrwa	x,a
3618  0d2c 6b25          	ld	(OFST-24,sp),a
3619  0d2e 02            	rlwa	x,a
3621                     ; 627 	decplace = templen - 2;
3623  0d2f 7b25          	ld	a,(OFST-24,sp)
3624  0d31 a002          	sub	a,#2
3625  0d33 6b3c          	ld	(OFST-1,sp),a
3627                     ; 628 	tempwho2[decplace] = '.';
3629  0d35 96            	ldw	x,sp
3630  0d36 1c002c        	addw	x,#OFST-17
3631  0d39 9f            	ld	a,xl
3632  0d3a 5e            	swapw	x
3633  0d3b 1b3c          	add	a,(OFST-1,sp)
3634  0d3d 2401          	jrnc	L002
3635  0d3f 5c            	incw	x
3636  0d40               L002:
3637  0d40 02            	rlwa	x,a
3638  0d41 a62e          	ld	a,#46
3639  0d43 f7            	ld	(x),a
3640                     ; 629 	for (w = 0; w < decplace; w++)
3642  0d44 0f3d          	clr	(OFST+0,sp)
3645  0d46 201e          	jra	L3421
3646  0d48               L7321:
3647                     ; 631 		tempwho2[w] = tempwho[w];
3649  0d48 96            	ldw	x,sp
3650  0d49 1c002c        	addw	x,#OFST-17
3651  0d4c 9f            	ld	a,xl
3652  0d4d 5e            	swapw	x
3653  0d4e 1b3d          	add	a,(OFST+0,sp)
3654  0d50 2401          	jrnc	L202
3655  0d52 5c            	incw	x
3656  0d53               L202:
3657  0d53 02            	rlwa	x,a
3658  0d54 89            	pushw	x
3659  0d55 96            	ldw	x,sp
3660  0d56 1c0028        	addw	x,#OFST-21
3661  0d59 9f            	ld	a,xl
3662  0d5a 5e            	swapw	x
3663  0d5b 1b3f          	add	a,(OFST+2,sp)
3664  0d5d 2401          	jrnc	L402
3665  0d5f 5c            	incw	x
3666  0d60               L402:
3667  0d60 02            	rlwa	x,a
3668  0d61 f6            	ld	a,(x)
3669  0d62 85            	popw	x
3670  0d63 f7            	ld	(x),a
3671                     ; 629 	for (w = 0; w < decplace; w++)
3673  0d64 0c3d          	inc	(OFST+0,sp)
3675  0d66               L3421:
3678  0d66 7b3d          	ld	a,(OFST+0,sp)
3679  0d68 113c          	cp	a,(OFST-1,sp)
3680  0d6a 25dc          	jrult	L7321
3681                     ; 633 	f = decplace + 1;
3683  0d6c 7b3c          	ld	a,(OFST-1,sp)
3684  0d6e 4c            	inc	a
3685  0d6f 6b3c          	ld	(OFST-1,sp),a
3687                     ; 634 	for (w = f; w <= templen; w++)
3689  0d71 7b3c          	ld	a,(OFST-1,sp)
3690  0d73 6b3d          	ld	(OFST+0,sp),a
3693  0d75 2023          	jra	L3521
3694  0d77               L7421:
3695                     ; 636 		u = w - 1;
3697  0d77 7b3d          	ld	a,(OFST+0,sp)
3698  0d79 4a            	dec	a
3699  0d7a 6b3c          	ld	(OFST-1,sp),a
3701                     ; 637 		tempwho2[w] = tempwho[u];
3703  0d7c 96            	ldw	x,sp
3704  0d7d 1c002c        	addw	x,#OFST-17
3705  0d80 9f            	ld	a,xl
3706  0d81 5e            	swapw	x
3707  0d82 1b3d          	add	a,(OFST+0,sp)
3708  0d84 2401          	jrnc	L602
3709  0d86 5c            	incw	x
3710  0d87               L602:
3711  0d87 02            	rlwa	x,a
3712  0d88 89            	pushw	x
3713  0d89 96            	ldw	x,sp
3714  0d8a 1c0028        	addw	x,#OFST-21
3715  0d8d 9f            	ld	a,xl
3716  0d8e 5e            	swapw	x
3717  0d8f 1b3e          	add	a,(OFST+1,sp)
3718  0d91 2401          	jrnc	L012
3719  0d93 5c            	incw	x
3720  0d94               L012:
3721  0d94 02            	rlwa	x,a
3722  0d95 f6            	ld	a,(x)
3723  0d96 85            	popw	x
3724  0d97 f7            	ld	(x),a
3725                     ; 634 	for (w = f; w <= templen; w++)
3727  0d98 0c3d          	inc	(OFST+0,sp)
3729  0d9a               L3521:
3732  0d9a 7b3d          	ld	a,(OFST+0,sp)
3733  0d9c 1125          	cp	a,(OFST-24,sp)
3734  0d9e 23d7          	jrule	L7421
3735                     ; 639 	tempwho2[w] = '\0';
3737  0da0 96            	ldw	x,sp
3738  0da1 1c002c        	addw	x,#OFST-17
3739  0da4 9f            	ld	a,xl
3740  0da5 5e            	swapw	x
3741  0da6 1b3d          	add	a,(OFST+0,sp)
3742  0da8 2401          	jrnc	L212
3743  0daa 5c            	incw	x
3744  0dab               L212:
3745  0dab 02            	rlwa	x,a
3746  0dac 7f            	clr	(x)
3747                     ; 640 	strcat(tempwho2, voltageUnit);
3749  0dad 96            	ldw	x,sp
3750  0dae 1c0001        	addw	x,#OFST-60
3751  0db1 89            	pushw	x
3752  0db2 96            	ldw	x,sp
3753  0db3 1c002e        	addw	x,#OFST-15
3754  0db6 cd0000        	call	_strcat
3756  0db9 85            	popw	x
3757                     ; 641 	strcat(voltage, tempwho2);
3759  0dba 96            	ldw	x,sp
3760  0dbb 1c002c        	addw	x,#OFST-17
3761  0dbe 89            	pushw	x
3762  0dbf 96            	ldw	x,sp
3763  0dc0 1c000a        	addw	x,#OFST-51
3764  0dc3 cd0000        	call	_strcat
3766  0dc6 85            	popw	x
3767                     ; 642 	bSendSMS(voltage, strlen((const char *)voltage), cell_number);
3769  0dc7 1e44          	ldw	x,(OFST+7,sp)
3770  0dc9 89            	pushw	x
3771  0dca 96            	ldw	x,sp
3772  0dcb 1c000a        	addw	x,#OFST-51
3773  0dce cd0000        	call	_strlen
3775  0dd1 9f            	ld	a,xl
3776  0dd2 88            	push	a
3777  0dd3 96            	ldw	x,sp
3778  0dd4 1c000b        	addw	x,#OFST-50
3779  0dd7 cd0a50        	call	_bSendSMS
3781  0dda 5b03          	addw	sp,#3
3782                     ; 643 }
3785  0ddc 5b3d          	addw	sp,#61
3786  0dde 81            	ret
3789                     	switch	.const
3790  006d               L7521_power:
3791  006d 506f77657220  	dc.b	"Power is ",0
3792  0077 000000000000  	ds.b	21
3793  008c               L1621_powerUnit:
3794  008c 205761747473  	dc.b	" Watts",0
3925                     ; 645 void sendSMSPower(uint32_t Power, uint8_t *cell_number)
3925                     ; 646 {
3926                     	switch	.text
3927  0ddf               _sendSMSPower:
3929  0ddf 523f          	subw	sp,#63
3930       0000003f      OFST:	set	63
3933                     ; 650 	uint8_t power[31] = "Power is ";
3935  0de1 96            	ldw	x,sp
3936  0de2 1c0008        	addw	x,#OFST-55
3937  0de5 90ae006d      	ldw	y,#L7521_power
3938  0de9 a61f          	ld	a,#31
3939  0deb cd0000        	call	c_xymvx
3941                     ; 651 	uint8_t powerUnit[7] = " Watts";
3943  0dee 96            	ldw	x,sp
3944  0def 1c0001        	addw	x,#OFST-62
3945  0df2 90ae008c      	ldw	y,#L1621_powerUnit
3946  0df6 a607          	ld	a,#7
3947  0df8 cd0000        	call	c_xymvx
3949                     ; 652 	uint8_t templen = 0;
3951                     ; 653 	uint8_t decplace = 0;
3953                     ; 657 	sprintf(tempwho, "%lu", Power);
3955  0dfb 1e44          	ldw	x,(OFST+5,sp)
3956  0dfd 89            	pushw	x
3957  0dfe 1e44          	ldw	x,(OFST+5,sp)
3958  0e00 89            	pushw	x
3959  0e01 ae0093        	ldw	x,#L3211
3960  0e04 89            	pushw	x
3961  0e05 96            	ldw	x,sp
3962  0e06 1c002e        	addw	x,#OFST-17
3963  0e09 cd0000        	call	_sprintf
3965  0e0c 5b06          	addw	sp,#6
3966                     ; 658 	templen = strlen(tempwho);
3968  0e0e 96            	ldw	x,sp
3969  0e0f 1c0028        	addw	x,#OFST-23
3970  0e12 cd0000        	call	_strlen
3972  0e15 01            	rrwa	x,a
3973  0e16 6b27          	ld	(OFST-24,sp),a
3974  0e18 02            	rlwa	x,a
3976                     ; 659 	decplace = templen - 2;
3978  0e19 7b27          	ld	a,(OFST-24,sp)
3979  0e1b a002          	sub	a,#2
3980  0e1d 6b3e          	ld	(OFST-1,sp),a
3982                     ; 660 	tempwho2[decplace] = '.';
3984  0e1f 96            	ldw	x,sp
3985  0e20 1c002e        	addw	x,#OFST-17
3986  0e23 9f            	ld	a,xl
3987  0e24 5e            	swapw	x
3988  0e25 1b3e          	add	a,(OFST-1,sp)
3989  0e27 2401          	jrnc	L612
3990  0e29 5c            	incw	x
3991  0e2a               L612:
3992  0e2a 02            	rlwa	x,a
3993  0e2b a62e          	ld	a,#46
3994  0e2d f7            	ld	(x),a
3995                     ; 661 	for (w = 0; w < decplace; w++)
3997  0e2e 0f3f          	clr	(OFST+0,sp)
4000  0e30 201e          	jra	L5531
4001  0e32               L1531:
4002                     ; 663 		tempwho2[w] = tempwho[w];
4004  0e32 96            	ldw	x,sp
4005  0e33 1c002e        	addw	x,#OFST-17
4006  0e36 9f            	ld	a,xl
4007  0e37 5e            	swapw	x
4008  0e38 1b3f          	add	a,(OFST+0,sp)
4009  0e3a 2401          	jrnc	L022
4010  0e3c 5c            	incw	x
4011  0e3d               L022:
4012  0e3d 02            	rlwa	x,a
4013  0e3e 89            	pushw	x
4014  0e3f 96            	ldw	x,sp
4015  0e40 1c002a        	addw	x,#OFST-21
4016  0e43 9f            	ld	a,xl
4017  0e44 5e            	swapw	x
4018  0e45 1b41          	add	a,(OFST+2,sp)
4019  0e47 2401          	jrnc	L222
4020  0e49 5c            	incw	x
4021  0e4a               L222:
4022  0e4a 02            	rlwa	x,a
4023  0e4b f6            	ld	a,(x)
4024  0e4c 85            	popw	x
4025  0e4d f7            	ld	(x),a
4026                     ; 661 	for (w = 0; w < decplace; w++)
4028  0e4e 0c3f          	inc	(OFST+0,sp)
4030  0e50               L5531:
4033  0e50 7b3f          	ld	a,(OFST+0,sp)
4034  0e52 113e          	cp	a,(OFST-1,sp)
4035  0e54 25dc          	jrult	L1531
4036                     ; 665 	f = decplace + 1;
4038  0e56 7b3e          	ld	a,(OFST-1,sp)
4039  0e58 4c            	inc	a
4040  0e59 6b3e          	ld	(OFST-1,sp),a
4042                     ; 666 	for (w = f; w <= templen; w++)
4044  0e5b 7b3e          	ld	a,(OFST-1,sp)
4045  0e5d 6b3f          	ld	(OFST+0,sp),a
4048  0e5f 2023          	jra	L5631
4049  0e61               L1631:
4050                     ; 668 		u = w - 1;
4052  0e61 7b3f          	ld	a,(OFST+0,sp)
4053  0e63 4a            	dec	a
4054  0e64 6b3e          	ld	(OFST-1,sp),a
4056                     ; 669 		tempwho2[w] = tempwho[u];
4058  0e66 96            	ldw	x,sp
4059  0e67 1c002e        	addw	x,#OFST-17
4060  0e6a 9f            	ld	a,xl
4061  0e6b 5e            	swapw	x
4062  0e6c 1b3f          	add	a,(OFST+0,sp)
4063  0e6e 2401          	jrnc	L422
4064  0e70 5c            	incw	x
4065  0e71               L422:
4066  0e71 02            	rlwa	x,a
4067  0e72 89            	pushw	x
4068  0e73 96            	ldw	x,sp
4069  0e74 1c002a        	addw	x,#OFST-21
4070  0e77 9f            	ld	a,xl
4071  0e78 5e            	swapw	x
4072  0e79 1b40          	add	a,(OFST+1,sp)
4073  0e7b 2401          	jrnc	L622
4074  0e7d 5c            	incw	x
4075  0e7e               L622:
4076  0e7e 02            	rlwa	x,a
4077  0e7f f6            	ld	a,(x)
4078  0e80 85            	popw	x
4079  0e81 f7            	ld	(x),a
4080                     ; 666 	for (w = f; w <= templen; w++)
4082  0e82 0c3f          	inc	(OFST+0,sp)
4084  0e84               L5631:
4087  0e84 7b3f          	ld	a,(OFST+0,sp)
4088  0e86 1127          	cp	a,(OFST-24,sp)
4089  0e88 23d7          	jrule	L1631
4090                     ; 671 	tempwho2[w] = '\0';
4092  0e8a 96            	ldw	x,sp
4093  0e8b 1c002e        	addw	x,#OFST-17
4094  0e8e 9f            	ld	a,xl
4095  0e8f 5e            	swapw	x
4096  0e90 1b3f          	add	a,(OFST+0,sp)
4097  0e92 2401          	jrnc	L032
4098  0e94 5c            	incw	x
4099  0e95               L032:
4100  0e95 02            	rlwa	x,a
4101  0e96 7f            	clr	(x)
4102                     ; 672 	strcat(tempwho2, powerUnit);
4104  0e97 96            	ldw	x,sp
4105  0e98 1c0001        	addw	x,#OFST-62
4106  0e9b 89            	pushw	x
4107  0e9c 96            	ldw	x,sp
4108  0e9d 1c0030        	addw	x,#OFST-15
4109  0ea0 cd0000        	call	_strcat
4111  0ea3 85            	popw	x
4112                     ; 673 	strcat(power, tempwho2);
4114  0ea4 96            	ldw	x,sp
4115  0ea5 1c002e        	addw	x,#OFST-17
4116  0ea8 89            	pushw	x
4117  0ea9 96            	ldw	x,sp
4118  0eaa 1c000a        	addw	x,#OFST-53
4119  0ead cd0000        	call	_strcat
4121  0eb0 85            	popw	x
4122                     ; 674 	bSendSMS(power, strlen((const char *)power), cell_number);
4124  0eb1 1e46          	ldw	x,(OFST+7,sp)
4125  0eb3 89            	pushw	x
4126  0eb4 96            	ldw	x,sp
4127  0eb5 1c000a        	addw	x,#OFST-53
4128  0eb8 cd0000        	call	_strlen
4130  0ebb 9f            	ld	a,xl
4131  0ebc 88            	push	a
4132  0ebd 96            	ldw	x,sp
4133  0ebe 1c000b        	addw	x,#OFST-52
4134  0ec1 cd0a50        	call	_bSendSMS
4136  0ec4 5b03          	addw	sp,#3
4137                     ; 675 }
4140  0ec6 5b3f          	addw	sp,#63
4141  0ec8 81            	ret
4279                     	xdef	_main
4280                     	xdef	_IMEIRecievedOKFlag
4281                     	xdef	_activation_flag
4282                     	xdef	_arm_flag
4283                     	xdef	_gprs_post_response_status
4284                     	xdef	_sms_recev
4285                     	xdef	_flag2
4286                     	xdef	_cloud_gps_data_flag
4287                     	xdef	_timeout
4288                     	xdef	_previousTics
4289                     	xdef	_stmDataReceive
4290                     	xref	_getFuelLevel
4291                     	xdef	_systemSetup
4292                     	xref	_sendDataToCloud
4293                     	xdef	_bSendSMS
4294                     	xref	_gettemp2
4295                     	xref	_gettemp1
4296                     	xref	_getbatteryvolt
4297                     	xdef	_sendSMSPower
4298                     	xdef	_sendSMSVoltage
4299                     	xdef	_sendSMSCurrent
4300                     	xdef	_sms_receive
4301                     	xref	_atoi
4302                     	xref	_calculateVoltCurrent
4303                     	xref.b	_checkByte
4304                     	xref.b	_powerCalibrationFactor3
4305                     	xref.b	_powerCalibrationFactor2
4306                     	xref.b	_powerCalibrationFactor1
4307                     	xref.b	_currentCalibrationFactor3
4308                     	xref.b	_currentCalibrationFactor2
4309                     	xref.b	_currentCalibrationFactor1
4310                     	xref.b	_voltageCalibrationFactor3
4311                     	xref.b	_voltageCalibrationFactor2
4312                     	xref.b	_voltageCalibrationFactor1
4313                     	xdef	_clearBuffer
4314                     	xref	_ms_send_cmd
4315                     	xref	_Temperature2
4316                     	xref	_Temperature1
4317                     	xref	_Fuellevel
4318                     	xref.b	_batVolt
4319                     	xref	_Watt_Phase3
4320                     	xref	_Ampere_Phase3
4321                     	xref	_Voltage_Phase3
4322                     	xref	_Watt_Phase2
4323                     	xref	_Ampere_Phase2
4324                     	xref	_Voltage_Phase2
4325                     	xref	_Watt_Phase1
4326                     	xref	_Ampere_Phase1
4327                     	xref	_Voltage_Phase1
4328                     	xref	_vHandle_MQTT
4329                     	xref	_vClearBuffer
4330                     	xdef	_GSM_OK
4331                     	xref	_SIMCom_setup
4332                     	xdef	_response_buffer
4333                     	xdef	_gprs_init_flag
4334                     	switch	.ubsct
4335  0000               _OK:
4336  0000 00            	ds.b	1
4337                     	xdef	_OK
4338                     	xdef	_cloud_connectivity_flag
4339                     	xdef	_noEchoFlag
4340                     	xref	_sprintf
4341                     	xref	_strlen
4342                     	xref	_strstr
4343                     	xref	_strcat
4344                     	xref	_WriteFlashWord
4345                     	xref	_systemInit
4346                     	xref	_delay_ms
4347                     	xref	_FLASH_ProgramByte
4348                     	xref	_FLASH_Lock
4349                     	xref	_FLASH_Unlock
4350                     	xref	_UART1_GetFlagStatus
4351                     	xref	_UART1_SendData8
4352                     	xref	_UART1_ReceiveData8
4353                     	xref	_UART1_ITConfig
4354                     	switch	.const
4355  0093               L3211:
4356  0093 256c7500      	dc.b	"%lu",0
4357  0097               L327:
4358  0097 2b434d475300  	dc.b	"+CMGS",0
4359  009d               L355:
4360  009d 2056616c7565  	dc.b	" Value",0
4361  00a4               L155:
4362  00a4 4675656c3a20  	dc.b	"Fuel: ",0
4363  00ab               L745:
4364  00ab 4655454c2d4c  	dc.b	"FUEL-LEVEL",0
4365  00b6               L145:
4366  00b6 20566f6c7473  	dc.b	" Volts",0
4367  00bd               L735:
4368  00bd 426174746572  	dc.b	"Battery: ",0
4369  00c7               L535:
4370  00c7 424154544552  	dc.b	"BATTERY-VOLT",0
4371  00d4               L725:
4372  00d4 456e67696e65  	dc.b	"Engine Temperature"
4373  00e6 3a2000        	dc.b	": ",0
4374  00e9               L525:
4375  00e9 454e47494e45  	dc.b	"ENGINE-TEMP",0
4376  00f5               L715:
4377  00f5 204300        	dc.b	" C",0
4378  00f8               L515:
4379  00f8 2e00          	dc.b	".",0
4380  00fa               L315:
4381  00fa 256c6400      	dc.b	"%ld",0
4382  00fe               L115:
4383  00fe 526164696174  	dc.b	"Radiator Temperatu"
4384  0110 72653a2000    	dc.b	"re: ",0
4385  0115               L505:
4386  0115 42c80000      	dc.w	17096,0
4387  0119               L774:
4388  0119 524144494154  	dc.b	"RADIATOR-TEMP",0
4389  0127               L174:
4390  0127 504f57455233  	dc.b	"POWER3",0
4391  012e               L364:
4392  012e 564f4c544147  	dc.b	"VOLTAGE3",0
4393  0137               L554:
4394  0137 43555252454e  	dc.b	"CURRENT3",0
4395  0140               L744:
4396  0140 504f57455232  	dc.b	"POWER2",0
4397  0147               L144:
4398  0147 564f4c544147  	dc.b	"VOLTAGE2",0
4399  0150               L334:
4400  0150 43555252454e  	dc.b	"CURRENT2",0
4401  0159               L524:
4402  0159 504f57455231  	dc.b	"POWER1",0
4403  0160               L714:
4404  0160 564f4c544147  	dc.b	"VOLTAGE1",0
4405  0169               L114:
4406  0169 43555252454e  	dc.b	"CURRENT1",0
4407  0172               L773:
4408  0172 503343616c46  	dc.b	"P3CalFac = ",0
4409  017e               L363:
4410  017e 503243616c46  	dc.b	"P2CalFac = ",0
4411  018a               L743:
4412  018a 503143616c46  	dc.b	"P1CalFac = ",0
4413  0196               L333:
4414  0196 493343616c46  	dc.b	"I3CalFac = ",0
4415  01a2               L713:
4416  01a2 493243616c46  	dc.b	"I2CalFac = ",0
4417  01ae               L303:
4418  01ae 493143616c46  	dc.b	"I1CalFac = ",0
4419  01ba               L762:
4420  01ba 563343616c46  	dc.b	"V3CalFac = ",0
4421  01c6               L352:
4422  01c6 563243616c46  	dc.b	"V2CalFac = ",0
4423  01d2               L732:
4424  01d2 563143616c46  	dc.b	"V1CalFac = ",0
4425  01de               L332:
4426  01de 43414c494252  	dc.b	"CALIBRATION DONE",0
4427  01ef               L722:
4428  01ef 4f4b00        	dc.b	"OK",0
4429  01f2               L522:
4430  01f2 43414c494252  	dc.b	"CALIBRATE",0
4431  01fc               L122:
4432  01fc 41542b434d47  	dc.b	"AT+CMGD=1,4",0
4433  0208               L371:
4434  0208 2b434d475200  	dc.b	"+CMGR",0
4435  020e               L151:
4436  020e 41542b434d47  	dc.b	"AT+CMGR=1",0
4437  0218               L741:
4438  0218 41542b434d47  	dc.b	"AT+CMGF=1",0
4439  0222               L541:
4440  0222 4154453000    	dc.b	"ATE0",0
4441                     	xref.b	c_lreg
4442                     	xref.b	c_x
4462                     	xref	c_lzmp
4463                     	xref	c_lgsbc
4464                     	xref	c_lumd
4465                     	xref	c_ludv
4466                     	xref	c_rtol
4467                     	xref	c_ftol
4468                     	xref	c_fmul
4469                     	xref	c_ltor
4470                     	xref	c_xymvx
4471                     	end
