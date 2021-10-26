   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  48                     ; 54 void SIMCom_setup(void)
  48                     ; 55 {
  50                     	switch	.text
  51  0000               _SIMCom_setup:
  55                     ; 56     delay_ms(100);
  57  0000 ae0064        	ldw	x,#100
  58  0003 cd0000        	call	_delay_ms
  60                     ; 57     SIMComrestart(); //Restart the SIMCOMM 868 module
  62  0006 cd00d7        	call	_SIMComrestart
  64                     ; 58     delay_ms(10000);
  66  0009 ae2710        	ldw	x,#10000
  67  000c cd0000        	call	_delay_ms
  69                     ; 60     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  71  000f 4b04          	push	#4
  72  0011 ae0127        	ldw	x,#L12
  73  0014 cd0000        	call	_ms_send_cmd
  75  0017 84            	pop	a
  76                     ; 61     delay_ms(20000);                                   //need to adjust the delay
  78  0018 ae4e20        	ldw	x,#20000
  79  001b cd0000        	call	_delay_ms
  81                     ; 62     delay_ms(1000);
  83  001e ae03e8        	ldw	x,#1000
  84  0021 cd0000        	call	_delay_ms
  86                     ; 63     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  88  0024 4b04          	push	#4
  89  0026 ae0127        	ldw	x,#L12
  90  0029 cd0000        	call	_ms_send_cmd
  92  002c 84            	pop	a
  93                     ; 64     ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
  95  002d 4b0b          	push	#11
  96  002f ae011b        	ldw	x,#L32
  97  0032 cd0000        	call	_ms_send_cmd
  99  0035 84            	pop	a
 100                     ; 65     delay_ms(1000);
 102  0036 ae03e8        	ldw	x,#1000
 103  0039 cd0000        	call	_delay_ms
 105                     ; 67     ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
 107  003c 4b0a          	push	#10
 108  003e ae0110        	ldw	x,#L52
 109  0041 cd0000        	call	_ms_send_cmd
 111  0044 84            	pop	a
 112                     ; 68     delay_ms(1000);
 114  0045 ae03e8        	ldw	x,#1000
 115  0048 cd0000        	call	_delay_ms
 117                     ; 70     vPrintStickerInfo(); //Added by Saqib
 119  004b cd0384        	call	_vPrintStickerInfo
 121                     ; 71     delay_ms(1000);
 123  004e ae03e8        	ldw	x,#1000
 124  0051 cd0000        	call	_delay_ms
 126                     ; 78     ms_send_cmd(MODULE_RI_OTHERS_OFF, strlen((const char *)MODULE_RI_OTHERS_OFF)); /* Disable power saving mode */
 128  0054 4b1c          	push	#28
 129  0056 ae00f3        	ldw	x,#L72
 130  0059 cd0000        	call	_ms_send_cmd
 132  005c 84            	pop	a
 133                     ; 79     delay_ms(500);
 135  005d ae01f4        	ldw	x,#500
 136  0060 cd0000        	call	_delay_ms
 138                     ; 80     ms_send_cmd(MODULE_RI_RING_OFF, strlen((const char *)MODULE_RI_RING_OFF)); /* Disable power saving mode */
 140  0063 4b1b          	push	#27
 141  0065 ae00d7        	ldw	x,#L13
 142  0068 cd0000        	call	_ms_send_cmd
 144  006b 84            	pop	a
 145                     ; 81     delay_ms(500);
 147  006c ae01f4        	ldw	x,#500
 148  006f cd0000        	call	_delay_ms
 150                     ; 82     ms_send_cmd(MODULE_RI_SMS_ON, strlen((const char *)MODULE_RI_SMS_ON)); /* Disable power saving mode */
 152  0072 4b2a          	push	#42
 153  0074 ae00ac        	ldw	x,#L33
 154  0077 cd0000        	call	_ms_send_cmd
 156  007a 84            	pop	a
 157                     ; 83     delay_ms(500);
 159  007b ae01f4        	ldw	x,#500
 160  007e cd0000        	call	_delay_ms
 162                     ; 92     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
 164  0081 4b04          	push	#4
 165  0083 ae0127        	ldw	x,#L12
 166  0086 cd0000        	call	_ms_send_cmd
 168  0089 84            	pop	a
 169                     ; 93     delay_ms(1000);
 171  008a ae03e8        	ldw	x,#1000
 172  008d cd0000        	call	_delay_ms
 174                     ; 130     ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
 176  0090 4b0a          	push	#10
 177  0092 ae00a1        	ldw	x,#L53
 178  0095 cd0000        	call	_ms_send_cmd
 180  0098 84            	pop	a
 181                     ; 131     delay_ms(1000);
 183  0099 ae03e8        	ldw	x,#1000
 184  009c cd0000        	call	_delay_ms
 186                     ; 133     ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
 188  009f 4b18          	push	#24
 189  00a1 ae0088        	ldw	x,#L73
 190  00a4 cd0000        	call	_ms_send_cmd
 192  00a7 84            	pop	a
 193                     ; 134     delay_ms(1000);
 195  00a8 ae03e8        	ldw	x,#1000
 196  00ab cd0000        	call	_delay_ms
 198                     ; 136     ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
 200  00ae 4b1b          	push	#27
 201  00b0 ae006c        	ldw	x,#L14
 202  00b3 cd0000        	call	_ms_send_cmd
 204  00b6 84            	pop	a
 205                     ; 137     delay_ms(1000);
 207  00b7 ae03e8        	ldw	x,#1000
 208  00ba cd0000        	call	_delay_ms
 210                     ; 139     ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
 212  00bd 4b0c          	push	#12
 213  00bf ae005f        	ldw	x,#L34
 214  00c2 cd0000        	call	_ms_send_cmd
 216  00c5 84            	pop	a
 217                     ; 140     delay_ms(1000);
 219  00c6 ae03e8        	ldw	x,#1000
 220  00c9 cd0000        	call	_delay_ms
 222                     ; 145     delay_ms(1000); //Added by Saqib
 224  00cc ae03e8        	ldw	x,#1000
 225  00cf cd0000        	call	_delay_ms
 227                     ; 223     checkit = 1; //Recieve data through Ringer Interrupt
 229  00d2 35010000      	mov	_checkit,#1
 230                     ; 224 }
 233  00d6 81            	ret
 261                     ; 270 void SIMComrestart()
 261                     ; 271 {
 262                     	switch	.text
 263  00d7               _SIMComrestart:
 267                     ; 272     ms_send_cmd(SIMCom_OFF, strlen((const char *)SIMCom_OFF)); /* Power down the SIMCom module */
 269  00d7 4b0a          	push	#10
 270  00d9 ae0054        	ldw	x,#L55
 271  00dc cd0000        	call	_ms_send_cmd
 273  00df 84            	pop	a
 274                     ; 273     delay_ms(800);
 276  00e0 ae0320        	ldw	x,#800
 277  00e3 cd0000        	call	_delay_ms
 279                     ; 275     GPIO_WriteHigh(PWRKEY);
 281  00e6 4b20          	push	#32
 282  00e8 ae500a        	ldw	x,#20490
 283  00eb cd0000        	call	_GPIO_WriteHigh
 285  00ee 84            	pop	a
 286                     ; 276     delay_ms(1000);
 288  00ef ae03e8        	ldw	x,#1000
 289  00f2 cd0000        	call	_delay_ms
 291                     ; 278     GPIO_WriteLow(PWRKEY);
 293  00f5 4b20          	push	#32
 294  00f7 ae500a        	ldw	x,#20490
 295  00fa cd0000        	call	_GPIO_WriteLow
 297  00fd 84            	pop	a
 298                     ; 279     delay_ms(1000);
 300  00fe ae03e8        	ldw	x,#1000
 301  0101 cd0000        	call	_delay_ms
 303                     ; 280 }
 306  0104 81            	ret
 354                     ; 282 void checkNum()
 354                     ; 283 {
 355                     	switch	.text
 356  0105               _checkNum:
 358  0105 5203          	subw	sp,#3
 359       00000003      OFST:	set	3
 362                     ; 284     uint16_t timeout = 0;
 364  0107 5f            	clrw	x
 365  0108 1f01          	ldw	(OFST-2,sp),x
 367                     ; 286     ms_send_cmd(check_num, strlen((const char *)check_num)); // SMS read
 369  010a 4b07          	push	#7
 370  010c ae004c        	ldw	x,#L101
 371  010f cd0000        	call	_ms_send_cmd
 373  0112 84            	pop	a
 374                     ; 288     for (s = 0; s < 75; s++)
 376  0113 0f03          	clr	(OFST+0,sp)
 378  0115               L311:
 379                     ; 290         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 381  0115 ae0020        	ldw	x,#32
 382  0118 cd0000        	call	_UART1_GetFlagStatus
 384  011b 4d            	tnz	a
 385  011c 260c          	jrne	L711
 387  011e 1e01          	ldw	x,(OFST-2,sp)
 388  0120 1c0001        	addw	x,#1
 389  0123 1f01          	ldw	(OFST-2,sp),x
 391  0125 a32710        	cpw	x,#10000
 392  0128 26eb          	jrne	L311
 393  012a               L711:
 394                     ; 292         response_buffer[s] = UART1_ReceiveData8();
 396  012a 7b03          	ld	a,(OFST+0,sp)
 397  012c 5f            	clrw	x
 398  012d 97            	ld	xl,a
 399  012e 89            	pushw	x
 400  012f cd0000        	call	_UART1_ReceiveData8
 402  0132 85            	popw	x
 403  0133 d70000        	ld	(_response_buffer,x),a
 404                     ; 293         timeout = 0;
 406  0136 5f            	clrw	x
 407  0137 1f01          	ldw	(OFST-2,sp),x
 409                     ; 288     for (s = 0; s < 75; s++)
 411  0139 0c03          	inc	(OFST+0,sp)
 415  013b 7b03          	ld	a,(OFST+0,sp)
 416  013d a14b          	cp	a,#75
 417  013f 25d4          	jrult	L311
 418                     ; 295 }
 421  0141 5b03          	addw	sp,#3
 422  0143 81            	ret
 491                     ; 297 void getIMEI(void)
 491                     ; 298 {
 492                     	switch	.text
 493  0144               _getIMEI:
 495  0144 521d          	subw	sp,#29
 496       0000001d      OFST:	set	29
 499                     ; 304     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 501  0146 4b00          	push	#0
 502  0148 ae0255        	ldw	x,#597
 503  014b cd0000        	call	_UART1_ITConfig
 505  014e 84            	pop	a
 506                     ; 305     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 508  014f 4b00          	push	#0
 509  0151 ae0244        	ldw	x,#580
 510  0154 cd0000        	call	_UART1_ITConfig
 512  0157 84            	pop	a
 513                     ; 307     ms_send_cmd(IMEIcmnd, strlen((const char *)IMEIcmnd)); //"AT+HTTPSSL=1"
 515  0158 4b06          	push	#6
 516  015a ae0045        	ldw	x,#L351
 517  015d cd0000        	call	_ms_send_cmd
 519  0160 84            	pop	a
 520                     ; 310     for (i = 0; i < 25; i++)
 522  0161 0f1d          	clr	(OFST+0,sp)
 524  0163               L561:
 525                     ; 312         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++ulTimout != 10000))
 527  0163 ae0020        	ldw	x,#32
 528  0166 cd0000        	call	_UART1_GetFlagStatus
 530  0169 4d            	tnz	a
 531  016a 260c          	jrne	L171
 533  016c 1e1a          	ldw	x,(OFST-3,sp)
 534  016e 1c0001        	addw	x,#1
 535  0171 1f1a          	ldw	(OFST-3,sp),x
 537  0173 a32710        	cpw	x,#10000
 538  0176 26eb          	jrne	L561
 539  0178               L171:
 540                     ; 314         localBuffer[i] = UART1_ReceiveData8();
 542  0178 96            	ldw	x,sp
 543  0179 1c0001        	addw	x,#OFST-28
 544  017c 9f            	ld	a,xl
 545  017d 5e            	swapw	x
 546  017e 1b1d          	add	a,(OFST+0,sp)
 547  0180 2401          	jrnc	L41
 548  0182 5c            	incw	x
 549  0183               L41:
 550  0183 02            	rlwa	x,a
 551  0184 89            	pushw	x
 552  0185 cd0000        	call	_UART1_ReceiveData8
 554  0188 85            	popw	x
 555  0189 f7            	ld	(x),a
 556                     ; 315         ulTimout = 0;
 558  018a 5f            	clrw	x
 559  018b 1f1a          	ldw	(OFST-3,sp),x
 561                     ; 310     for (i = 0; i < 25; i++)
 563  018d 0c1d          	inc	(OFST+0,sp)
 567  018f 7b1d          	ld	a,(OFST+0,sp)
 568  0191 a119          	cp	a,#25
 569  0193 25ce          	jrult	L561
 570                     ; 317     localBuffer[i] = '\0';
 572  0195 96            	ldw	x,sp
 573  0196 1c0001        	addw	x,#OFST-28
 574  0199 9f            	ld	a,xl
 575  019a 5e            	swapw	x
 576  019b 1b1d          	add	a,(OFST+0,sp)
 577  019d 2401          	jrnc	L61
 578  019f 5c            	incw	x
 579  01a0               L61:
 580  01a0 02            	rlwa	x,a
 581  01a1 7f            	clr	(x)
 582                     ; 318     j = 0;
 584  01a2 0f1c          	clr	(OFST-1,sp)
 586                     ; 319     for (i = 2; i < 17; i++)
 588  01a4 a602          	ld	a,#2
 589  01a6 6b1d          	ld	(OFST+0,sp),a
 591  01a8               L371:
 592                     ; 321         aunIMEI[j] = localBuffer[i];
 594  01a8 7b1c          	ld	a,(OFST-1,sp)
 595  01aa 5f            	clrw	x
 596  01ab 97            	ld	xl,a
 597  01ac 89            	pushw	x
 598  01ad 96            	ldw	x,sp
 599  01ae 1c0003        	addw	x,#OFST-26
 600  01b1 9f            	ld	a,xl
 601  01b2 5e            	swapw	x
 602  01b3 1b1f          	add	a,(OFST+2,sp)
 603  01b5 2401          	jrnc	L02
 604  01b7 5c            	incw	x
 605  01b8               L02:
 606  01b8 02            	rlwa	x,a
 607  01b9 f6            	ld	a,(x)
 608  01ba 85            	popw	x
 609  01bb e710          	ld	(_aunIMEI,x),a
 610                     ; 322         j++;
 612  01bd 0c1c          	inc	(OFST-1,sp)
 614                     ; 319     for (i = 2; i < 17; i++)
 616  01bf 0c1d          	inc	(OFST+0,sp)
 620  01c1 7b1d          	ld	a,(OFST+0,sp)
 621  01c3 a111          	cp	a,#17
 622  01c5 25e1          	jrult	L371
 623                     ; 324     aunIMEI[j] = '\0';
 625  01c7 7b1c          	ld	a,(OFST-1,sp)
 626  01c9 5f            	clrw	x
 627  01ca 97            	ld	xl,a
 628  01cb 6f10          	clr	(_aunIMEI,x)
 629                     ; 325     delay_ms(200);
 631  01cd ae00c8        	ldw	x,#200
 632  01d0 cd0000        	call	_delay_ms
 634                     ; 327     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 636  01d3 4b01          	push	#1
 637  01d5 ae0255        	ldw	x,#597
 638  01d8 cd0000        	call	_UART1_ITConfig
 640  01db 84            	pop	a
 641                     ; 328     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
 643  01dc 4b01          	push	#1
 644  01de ae0244        	ldw	x,#580
 645  01e1 cd0000        	call	_UART1_ITConfig
 647  01e4 84            	pop	a
 648                     ; 329 }
 651  01e5 5b1d          	addw	sp,#29
 652  01e7 81            	ret
 655                     	bsct
 656  0000               L102_unMQTTCounter:
 657  0000 00            	dc.b	0
 658  0001               L302_unMQQT_PingCounter:
 659  0001 00            	dc.b	0
 819                     ; 621 void vHandle_MQTT(void)
 819                     ; 622 {
 820                     	switch	.text
 821  01e8               _vHandle_MQTT:
 823  01e8 89            	pushw	x
 824       00000002      OFST:	set	2
 827                     ; 623     uint8_t unLength = 0;
 829                     ; 628     if (IMEIRecievedOKFlag)
 831  01e9 3d00          	tnz	_IMEIRecievedOKFlag
 832  01eb 2750          	jreq	L172
 833                     ; 630         eTCP_Status = enGet_TCP_Status();
 835  01ed ad70          	call	_enGet_TCP_Status
 837  01ef 6b02          	ld	(OFST+0,sp),a
 839                     ; 631         if (eTCP_Status == eTCP_STAT_CONNECT_OK)
 841  01f1 7b02          	ld	a,(OFST+0,sp)
 842  01f3 a107          	cp	a,#7
 843  01f5 263c          	jrne	L372
 844                     ; 633             if (unMQTTCounter == 0)
 846  01f7 3d00          	tnz	L102_unMQTTCounter
 847  01f9 260a          	jrne	L572
 848                     ; 635                 vMQTT_Subscribe(aunMQTT_Subscribe_Topic);
 850  01fb ae0000        	ldw	x,#_aunMQTT_Subscribe_Topic
 851  01fe cd0000        	call	_vMQTT_Subscribe
 853                     ; 636                 unMQTTCounter++;
 855  0201 3c00          	inc	L102_unMQTTCounter
 857  0203 203b          	jra	L513
 858  0205               L572:
 859                     ; 638             else if (unMQTTCounter == 1)
 861  0205 b600          	ld	a,L102_unMQTTCounter
 862  0207 a101          	cp	a,#1
 863  0209 260d          	jrne	L103
 864                     ; 640                 delay_ms(100);
 866  020b ae0064        	ldw	x,#100
 867  020e cd0000        	call	_delay_ms
 869                     ; 641                 vMevris_Send_IMEI();
 871  0211 cd0000        	call	_vMevris_Send_IMEI
 873                     ; 642                 unMQTTCounter++;
 875  0214 3c00          	inc	L102_unMQTTCounter
 877  0216 2028          	jra	L513
 878  0218               L103:
 879                     ; 645             else if (unMQTTCounter == 2)
 881  0218 b600          	ld	a,L102_unMQTTCounter
 882  021a a102          	cp	a,#2
 883  021c 260d          	jrne	L503
 884                     ; 647                 delay_ms(100);
 886  021e ae0064        	ldw	x,#100
 887  0221 cd0000        	call	_delay_ms
 889                     ; 648                 vMevris_Send_Version();
 891  0224 cd0000        	call	_vMevris_Send_Version
 893                     ; 649                 unMQTTCounter++;
 895  0227 3c00          	inc	L102_unMQTTCounter
 897  0229 2015          	jra	L513
 898  022b               L503:
 899                     ; 652             else if (unMQTTCounter >= 3)
 901  022b b600          	ld	a,L102_unMQTTCounter
 902  022d a103          	cp	a,#3
 903  022f 250f          	jrult	L513
 904  0231 200d          	jra	L513
 905  0233               L372:
 906                     ; 659             vMQTT_Connect(aunMQTT_ClientID);
 908  0233 ae0000        	ldw	x,#_aunMQTT_ClientID
 909  0236 cd0000        	call	_vMQTT_Connect
 911                     ; 660             unMQTTCounter = 0;
 913  0239 3f00          	clr	L102_unMQTTCounter
 914  023b 2003          	jra	L513
 915  023d               L172:
 916                     ; 665         vPrintStickerInfo();
 918  023d cd0384        	call	_vPrintStickerInfo
 920  0240               L513:
 921                     ; 667 }
 924  0240 85            	popw	x
 925  0241 81            	ret
 978                     ; 671 void vClearBuffer(char *temp, uint8_t unLen)
 978                     ; 672 {
 979                     	switch	.text
 980  0242               _vClearBuffer:
 982  0242 89            	pushw	x
 983  0243 88            	push	a
 984       00000001      OFST:	set	1
 987                     ; 674     for (i = 0; i < unLen; i++)
 989  0244 0f01          	clr	(OFST+0,sp)
 992  0246 200e          	jra	L153
 993  0248               L543:
 994                     ; 676         *(temp + i) = '\0';
 996  0248 7b02          	ld	a,(OFST+1,sp)
 997  024a 97            	ld	xl,a
 998  024b 7b03          	ld	a,(OFST+2,sp)
 999  024d 1b01          	add	a,(OFST+0,sp)
1000  024f 2401          	jrnc	L62
1001  0251 5c            	incw	x
1002  0252               L62:
1003  0252 02            	rlwa	x,a
1004  0253 7f            	clr	(x)
1005                     ; 674     for (i = 0; i < unLen; i++)
1007  0254 0c01          	inc	(OFST+0,sp)
1009  0256               L153:
1012  0256 7b01          	ld	a,(OFST+0,sp)
1013  0258 1106          	cp	a,(OFST+5,sp)
1014  025a 25ec          	jrult	L543
1015                     ; 678 }
1018  025c 5b03          	addw	sp,#3
1019  025e 81            	ret
1079                     ; 680 enTCP_STATUS enGet_TCP_Status(void)
1079                     ; 681 {
1080                     	switch	.text
1081  025f               _enGet_TCP_Status:
1083  025f 5203          	subw	sp,#3
1084       00000003      OFST:	set	3
1087                     ; 683     uint8_t j = 0;
1089  0261 0f03          	clr	(OFST+0,sp)
1091                     ; 743     ms_send_cmd(MQTT_CHECK_STATUS, strlen((const char *)MQTT_CHECK_STATUS));
1093  0263 4b0b          	push	#11
1094  0265 ae0039        	ldw	x,#L304
1095  0268 cd0000        	call	_ms_send_cmd
1097  026b 84            	pop	a
1098                     ; 744     delay_ms(1000);
1100  026c ae03e8        	ldw	x,#1000
1101  026f cd0000        	call	_delay_ms
1103                     ; 746     if (strstr(response_buffer, "+QMTCONN:"))
1105  0272 ae002f        	ldw	x,#L704
1106  0275 89            	pushw	x
1107  0276 ae0000        	ldw	x,#_response_buffer
1108  0279 cd0000        	call	_strstr
1110  027c 5b02          	addw	sp,#2
1111  027e a30000        	cpw	x,#0
1112  0281 2603          	jrne	L44
1113  0283 cc0316        	jp	L504
1114  0286               L44:
1115                     ; 748         i = strstr(response_buffer, "+QMTCONN:");
1117  0286 ae002f        	ldw	x,#L704
1118  0289 89            	pushw	x
1119  028a ae0000        	ldw	x,#_response_buffer
1120  028d cd0000        	call	_strstr
1122  0290 5b02          	addw	sp,#2
1123  0292 1f01          	ldw	(OFST-2,sp),x
1125                     ; 749         if (i)
1127  0294 1e01          	ldw	x,(OFST-2,sp)
1128  0296 2602          	jrne	L64
1129  0298 2078          	jp	L114
1130  029a               L64:
1132  029a 2002          	jra	L514
1133  029c               L314:
1134                     ; 752                 j++;
1136  029c 0c03          	inc	(OFST+0,sp)
1138  029e               L514:
1139                     ; 751             while (*(i + j) != ',' && j < 100)
1141  029e 7b01          	ld	a,(OFST-2,sp)
1142  02a0 97            	ld	xl,a
1143  02a1 7b02          	ld	a,(OFST-1,sp)
1144  02a3 1b03          	add	a,(OFST+0,sp)
1145  02a5 2401          	jrnc	L23
1146  02a7 5c            	incw	x
1147  02a8               L23:
1148  02a8 02            	rlwa	x,a
1149  02a9 f6            	ld	a,(x)
1150  02aa a12c          	cp	a,#44
1151  02ac 2706          	jreq	L124
1153  02ae 7b03          	ld	a,(OFST+0,sp)
1154  02b0 a164          	cp	a,#100
1155  02b2 25e8          	jrult	L314
1156  02b4               L124:
1157                     ; 756             j++;
1159  02b4 0c03          	inc	(OFST+0,sp)
1161                     ; 758             if (*(i + j) == '1')
1163  02b6 7b01          	ld	a,(OFST-2,sp)
1164  02b8 97            	ld	xl,a
1165  02b9 7b02          	ld	a,(OFST-1,sp)
1166  02bb 1b03          	add	a,(OFST+0,sp)
1167  02bd 2401          	jrnc	L43
1168  02bf 5c            	incw	x
1169  02c0               L43:
1170  02c0 02            	rlwa	x,a
1171  02c1 f6            	ld	a,(x)
1172  02c2 a131          	cp	a,#49
1173  02c4 2606          	jrne	L324
1174                     ; 760                 eStatus = eTCP_STAT_IP_INITIAL;
1176  02c6 a601          	ld	a,#1
1177  02c8 6b03          	ld	(OFST+0,sp),a
1180  02ca 204c          	jra	L544
1181  02cc               L324:
1182                     ; 763             else if (*(i + j) == '2')
1184  02cc 7b01          	ld	a,(OFST-2,sp)
1185  02ce 97            	ld	xl,a
1186  02cf 7b02          	ld	a,(OFST-1,sp)
1187  02d1 1b03          	add	a,(OFST+0,sp)
1188  02d3 2401          	jrnc	L63
1189  02d5 5c            	incw	x
1190  02d6               L63:
1191  02d6 02            	rlwa	x,a
1192  02d7 f6            	ld	a,(x)
1193  02d8 a132          	cp	a,#50
1194  02da 2606          	jrne	L724
1195                     ; 765                 eStatus = eTCP_STAT_CONNECTING;
1197  02dc a606          	ld	a,#6
1198  02de 6b03          	ld	(OFST+0,sp),a
1201  02e0 2036          	jra	L544
1202  02e2               L724:
1203                     ; 768             else if (*(i + j) == '3')
1205  02e2 7b01          	ld	a,(OFST-2,sp)
1206  02e4 97            	ld	xl,a
1207  02e5 7b02          	ld	a,(OFST-1,sp)
1208  02e7 1b03          	add	a,(OFST+0,sp)
1209  02e9 2401          	jrnc	L04
1210  02eb 5c            	incw	x
1211  02ec               L04:
1212  02ec 02            	rlwa	x,a
1213  02ed f6            	ld	a,(x)
1214  02ee a133          	cp	a,#51
1215  02f0 2606          	jrne	L334
1216                     ; 770                 eStatus = eTCP_STAT_CONNECT_OK;
1218  02f2 a607          	ld	a,#7
1219  02f4 6b03          	ld	(OFST+0,sp),a
1222  02f6 2020          	jra	L544
1223  02f8               L334:
1224                     ; 776             else if (*(i + j) == '4')
1226  02f8 7b01          	ld	a,(OFST-2,sp)
1227  02fa 97            	ld	xl,a
1228  02fb 7b02          	ld	a,(OFST-1,sp)
1229  02fd 1b03          	add	a,(OFST+0,sp)
1230  02ff 2401          	jrnc	L24
1231  0301 5c            	incw	x
1232  0302               L24:
1233  0302 02            	rlwa	x,a
1234  0303 f6            	ld	a,(x)
1235  0304 a134          	cp	a,#52
1236  0306 2606          	jrne	L734
1237                     ; 778                 eStatus = eTCP_STAT_CLOSED;
1239  0308 a609          	ld	a,#9
1240  030a 6b03          	ld	(OFST+0,sp),a
1243  030c 200a          	jra	L544
1244  030e               L734:
1245                     ; 782                 eStatus = eTCP_STAT_UNKNOWN;
1247  030e 0f03          	clr	(OFST+0,sp)
1249  0310 2006          	jra	L544
1250  0312               L114:
1251                     ; 787             eStatus = eTCP_STAT_UNKNOWN;
1253  0312 0f03          	clr	(OFST+0,sp)
1255  0314 2002          	jra	L544
1256  0316               L504:
1257                     ; 792         eStatus = eTCP_STAT_UNKNOWN;
1259  0316 0f03          	clr	(OFST+0,sp)
1261  0318               L544:
1262                     ; 795     return eStatus;
1264  0318 7b03          	ld	a,(OFST+0,sp)
1267  031a 5b03          	addw	sp,#3
1268  031c 81            	ret
1354                     ; 821 bool bValidIMEIRecieved(char *myArray)
1354                     ; 822 {
1355                     	switch	.text
1356  031d               _bValidIMEIRecieved:
1358  031d 89            	pushw	x
1359  031e 5203          	subw	sp,#3
1360       00000003      OFST:	set	3
1363                     ; 823     uint8_t i = 0, j = 0, k = 0;
1369  0320 0f02          	clr	(OFST-1,sp)
1371                     ; 824     for (j = 0; j < 20; j++)
1373  0322 0f03          	clr	(OFST+0,sp)
1375  0324               L115:
1376                     ; 826         if (myArray[j] > 0x39 || myArray[j] < 0x30)
1378  0324 7b04          	ld	a,(OFST+1,sp)
1379  0326 97            	ld	xl,a
1380  0327 7b05          	ld	a,(OFST+2,sp)
1381  0329 1b03          	add	a,(OFST+0,sp)
1382  032b 2401          	jrnc	L25
1383  032d 5c            	incw	x
1384  032e               L25:
1385  032e 02            	rlwa	x,a
1386  032f f6            	ld	a,(x)
1387  0330 a13a          	cp	a,#58
1388  0332 2410          	jruge	L125
1390  0334 7b04          	ld	a,(OFST+1,sp)
1391  0336 97            	ld	xl,a
1392  0337 7b05          	ld	a,(OFST+2,sp)
1393  0339 1b03          	add	a,(OFST+0,sp)
1394  033b 2401          	jrnc	L45
1395  033d 5c            	incw	x
1396  033e               L45:
1397  033e 02            	rlwa	x,a
1398  033f f6            	ld	a,(x)
1399  0340 a130          	cp	a,#48
1400  0342 2419          	jruge	L715
1401  0344               L125:
1402                     ; 828             nop();
1405  0344 9d            nop
1408  0345               L325:
1409                     ; 824     for (j = 0; j < 20; j++)
1411  0345 0c03          	inc	(OFST+0,sp)
1415  0347 7b03          	ld	a,(OFST+0,sp)
1416  0349 a114          	cp	a,#20
1417  034b 25d7          	jrult	L115
1418                     ; 835     if (k == 15)
1420  034d 7b02          	ld	a,(OFST-1,sp)
1421  034f a10f          	cp	a,#15
1422  0351 2624          	jrne	L525
1423                     ; 837         aunIMEI[k] = '\0';
1425  0353 7b02          	ld	a,(OFST-1,sp)
1426  0355 5f            	clrw	x
1427  0356 97            	ld	xl,a
1428  0357 6f10          	clr	(_aunIMEI,x)
1429                     ; 838         return TRUE;
1431  0359 a601          	ld	a,#1
1433  035b 2024          	jra	L06
1434  035d               L715:
1435                     ; 832             aunIMEI[k++] = myArray[j];
1437  035d 7b02          	ld	a,(OFST-1,sp)
1438  035f 97            	ld	xl,a
1439  0360 0c02          	inc	(OFST-1,sp)
1441  0362 9f            	ld	a,xl
1442  0363 5f            	clrw	x
1443  0364 97            	ld	xl,a
1444  0365 89            	pushw	x
1445  0366 7b06          	ld	a,(OFST+3,sp)
1446  0368 97            	ld	xl,a
1447  0369 7b07          	ld	a,(OFST+4,sp)
1448  036b 1b05          	add	a,(OFST+2,sp)
1449  036d 2401          	jrnc	L65
1450  036f 5c            	incw	x
1451  0370               L65:
1452  0370 02            	rlwa	x,a
1453  0371 f6            	ld	a,(x)
1454  0372 85            	popw	x
1455  0373 e710          	ld	(_aunIMEI,x),a
1456  0375 20ce          	jra	L325
1457  0377               L525:
1458                     ; 842         vClearBuffer(aunIMEI, 16);
1460  0377 4b10          	push	#16
1461  0379 ae0010        	ldw	x,#_aunIMEI
1462  037c cd0242        	call	_vClearBuffer
1464  037f 84            	pop	a
1465                     ; 843         return FALSE;
1467  0380 4f            	clr	a
1469  0381               L06:
1471  0381 5b05          	addw	sp,#5
1472  0383 81            	ret
1475                     .const:	section	.text
1476  0000               L135_imei_array:
1477  0000 00            	dc.b	0
1478  0001 000000000000  	ds.b	19
1582                     ; 848 void vPrintStickerInfo(void)
1582                     ; 849 {
1583                     	switch	.text
1584  0384               _vPrintStickerInfo:
1586  0384 521a          	subw	sp,#26
1587       0000001a      OFST:	set	26
1590                     ; 850     uint8_t p = 0, i = 0;
1594                     ; 851     uint8_t NotRespondingCounter = 0;
1596  0386 0f19          	clr	(OFST-1,sp)
1598                     ; 852     uint16_t gsm_ok_timeout = 10000;
1600                     ; 853     uint8_t imei_array[20] = {0};
1602  0388 96            	ldw	x,sp
1603  0389 1c0004        	addw	x,#OFST-22
1604  038c 90ae0000      	ldw	y,#L135_imei_array
1605  0390 a614          	ld	a,#20
1606  0392 cd0000        	call	c_xymvx
1608                     ; 854     bool ModuleResponding = FALSE;
1610                     ; 855     bool myInterruptFlag = TRUE;
1612                     ; 857     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
1614  0395 4b00          	push	#0
1615  0397 ae0255        	ldw	x,#597
1616  039a cd0000        	call	_UART1_ITConfig
1618  039d 84            	pop	a
1619                     ; 858     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
1621  039e 4b00          	push	#0
1622  03a0 ae0244        	ldw	x,#580
1623  03a3 cd0000        	call	_UART1_ITConfig
1625  03a6 84            	pop	a
1626                     ; 859     delay_ms(100);
1628  03a7 ae0064        	ldw	x,#100
1629  03aa cd0000        	call	_delay_ms
1631  03ad               L106:
1632                     ; 863         ms_send_cmd(AT, strlen((const char *)AT));
1634  03ad 4b02          	push	#2
1635  03af ae002c        	ldw	x,#L706
1636  03b2 cd0000        	call	_ms_send_cmd
1638  03b5 84            	pop	a
1639                     ; 864         if (GSM_OK())
1641  03b6 cd0000        	call	_GSM_OK
1643  03b9 a30000        	cpw	x,#0
1644  03bc 2603          	jrne	L46
1645  03be cc04f5        	jp	L116
1646  03c1               L46:
1647                     ; 866             delay_ms(200);
1649  03c1 ae00c8        	ldw	x,#200
1650  03c4 cd0000        	call	_delay_ms
1652                     ; 868             getIMEI();
1654  03c7 cd0144        	call	_getIMEI
1656                     ; 869             if (bValidIMEIRecieved(aunIMEI))
1658  03ca ae0010        	ldw	x,#_aunIMEI
1659  03cd cd031d        	call	_bValidIMEIRecieved
1661  03d0 4d            	tnz	a
1662  03d1 2603          	jrne	L66
1663  03d3 cc04e9        	jp	L316
1664  03d6               L66:
1665                     ; 871                 delay_ms(100);
1667  03d6 ae0064        	ldw	x,#100
1668  03d9 cd0000        	call	_delay_ms
1670                     ; 872                 for (i = 0; i < 20; i++)
1672  03dc 0f1a          	clr	(OFST+0,sp)
1674  03de               L526:
1675                     ; 874                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1677  03de ae0040        	ldw	x,#64
1678  03e1 cd0000        	call	_UART1_GetFlagStatus
1680  03e4 4d            	tnz	a
1681  03e5 27f7          	jreq	L526
1682                     ; 876                     UART1_SendData8('*');
1684  03e7 a62a          	ld	a,#42
1685  03e9 cd0000        	call	_UART1_SendData8
1687                     ; 872                 for (i = 0; i < 20; i++)
1689  03ec 0c1a          	inc	(OFST+0,sp)
1693  03ee 7b1a          	ld	a,(OFST+0,sp)
1694  03f0 a114          	cp	a,#20
1695  03f2 25ea          	jrult	L526
1697  03f4               L336:
1698                     ; 878                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1700  03f4 ae0040        	ldw	x,#64
1701  03f7 cd0000        	call	_UART1_GetFlagStatus
1703  03fa 4d            	tnz	a
1704  03fb 27f7          	jreq	L336
1705                     ; 880                 UART1_SendData8('\n');
1707  03fd a60a          	ld	a,#10
1708  03ff cd0000        	call	_UART1_SendData8
1711  0402               L146:
1712                     ; 881                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1714  0402 ae0040        	ldw	x,#64
1715  0405 cd0000        	call	_UART1_GetFlagStatus
1717  0408 4d            	tnz	a
1718  0409 27f7          	jreq	L146
1719                     ; 883                 UART1_SendData8('I');
1721  040b a649          	ld	a,#73
1722  040d cd0000        	call	_UART1_SendData8
1725  0410               L746:
1726                     ; 884                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1728  0410 ae0040        	ldw	x,#64
1729  0413 cd0000        	call	_UART1_GetFlagStatus
1731  0416 4d            	tnz	a
1732  0417 27f7          	jreq	L746
1733                     ; 886                 UART1_SendData8('M');
1735  0419 a64d          	ld	a,#77
1736  041b cd0000        	call	_UART1_SendData8
1739  041e               L556:
1740                     ; 887                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1742  041e ae0040        	ldw	x,#64
1743  0421 cd0000        	call	_UART1_GetFlagStatus
1745  0424 4d            	tnz	a
1746  0425 27f7          	jreq	L556
1747                     ; 889                 UART1_SendData8('E');
1749  0427 a645          	ld	a,#69
1750  0429 cd0000        	call	_UART1_SendData8
1753  042c               L366:
1754                     ; 890                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1756  042c ae0040        	ldw	x,#64
1757  042f cd0000        	call	_UART1_GetFlagStatus
1759  0432 4d            	tnz	a
1760  0433 27f7          	jreq	L366
1761                     ; 892                 UART1_SendData8('I');
1763  0435 a649          	ld	a,#73
1764  0437 cd0000        	call	_UART1_SendData8
1767  043a               L176:
1768                     ; 893                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1770  043a ae0040        	ldw	x,#64
1771  043d cd0000        	call	_UART1_GetFlagStatus
1773  0440 4d            	tnz	a
1774  0441 27f7          	jreq	L176
1775                     ; 895                 UART1_SendData8(' ');
1777  0443 a620          	ld	a,#32
1778  0445 cd0000        	call	_UART1_SendData8
1781  0448               L776:
1782                     ; 896                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1784  0448 ae0040        	ldw	x,#64
1785  044b cd0000        	call	_UART1_GetFlagStatus
1787  044e 4d            	tnz	a
1788  044f 27f7          	jreq	L776
1789                     ; 898                 UART1_SendData8('i');
1791  0451 a669          	ld	a,#105
1792  0453 cd0000        	call	_UART1_SendData8
1795  0456               L507:
1796                     ; 899                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1798  0456 ae0040        	ldw	x,#64
1799  0459 cd0000        	call	_UART1_GetFlagStatus
1801  045c 4d            	tnz	a
1802  045d 27f7          	jreq	L507
1803                     ; 901                 UART1_SendData8('s');
1805  045f a673          	ld	a,#115
1806  0461 cd0000        	call	_UART1_SendData8
1809  0464               L317:
1810                     ; 902                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1812  0464 ae0040        	ldw	x,#64
1813  0467 cd0000        	call	_UART1_GetFlagStatus
1815  046a 4d            	tnz	a
1816  046b 27f7          	jreq	L317
1817                     ; 904                 UART1_SendData8('\n');
1819  046d a60a          	ld	a,#10
1820  046f cd0000        	call	_UART1_SendData8
1823  0472               L127:
1824                     ; 906                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1826  0472 ae0040        	ldw	x,#64
1827  0475 cd0000        	call	_UART1_GetFlagStatus
1829  0478 4d            	tnz	a
1830  0479 27f7          	jreq	L127
1831                     ; 908                 UART1_SendData8('\n');
1833  047b a60a          	ld	a,#10
1834  047d cd0000        	call	_UART1_SendData8
1836                     ; 909                 for (i = 0; i < 15; i++)
1838  0480 0f1a          	clr	(OFST+0,sp)
1840  0482               L537:
1841                     ; 911                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1843  0482 ae0040        	ldw	x,#64
1844  0485 cd0000        	call	_UART1_GetFlagStatus
1846  0488 4d            	tnz	a
1847  0489 27f7          	jreq	L537
1848                     ; 913                     UART1_SendData8(aunIMEI[i]);
1850  048b 7b1a          	ld	a,(OFST+0,sp)
1851  048d 5f            	clrw	x
1852  048e 97            	ld	xl,a
1853  048f e610          	ld	a,(_aunIMEI,x)
1854  0491 cd0000        	call	_UART1_SendData8
1856                     ; 909                 for (i = 0; i < 15; i++)
1858  0494 0c1a          	inc	(OFST+0,sp)
1862  0496 7b1a          	ld	a,(OFST+0,sp)
1863  0498 a10f          	cp	a,#15
1864  049a 25e6          	jrult	L537
1866  049c               L347:
1867                     ; 915                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1869  049c ae0040        	ldw	x,#64
1870  049f cd0000        	call	_UART1_GetFlagStatus
1872  04a2 4d            	tnz	a
1873  04a3 27f7          	jreq	L347
1874                     ; 918                 UART1_SendData8('\n');
1876  04a5 a60a          	ld	a,#10
1877  04a7 cd0000        	call	_UART1_SendData8
1879                     ; 919                 for (i = 0; i < 20; i++)
1881  04aa 0f1a          	clr	(OFST+0,sp)
1883  04ac               L757:
1884                     ; 921                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1886  04ac ae0040        	ldw	x,#64
1887  04af cd0000        	call	_UART1_GetFlagStatus
1889  04b2 4d            	tnz	a
1890  04b3 27f7          	jreq	L757
1891                     ; 923                     UART1_SendData8('*');
1893  04b5 a62a          	ld	a,#42
1894  04b7 cd0000        	call	_UART1_SendData8
1896                     ; 919                 for (i = 0; i < 20; i++)
1898  04ba 0c1a          	inc	(OFST+0,sp)
1902  04bc 7b1a          	ld	a,(OFST+0,sp)
1903  04be a114          	cp	a,#20
1904  04c0 25ea          	jrult	L757
1906  04c2               L567:
1907                     ; 925                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1909  04c2 ae0040        	ldw	x,#64
1910  04c5 cd0000        	call	_UART1_GetFlagStatus
1912  04c8 4d            	tnz	a
1913  04c9 27f7          	jreq	L567
1914                     ; 927                 UART1_SendData8('\r');
1916  04cb a60d          	ld	a,#13
1917  04cd cd0000        	call	_UART1_SendData8
1919                     ; 928                 delay_ms(100);
1921  04d0 ae0064        	ldw	x,#100
1922  04d3 cd0000        	call	_delay_ms
1924                     ; 930                 punGet_Client_ID();
1926  04d6 cd0000        	call	_punGet_Client_ID
1928                     ; 931                 punGet_Command_Topic();
1930  04d9 cd0000        	call	_punGet_Command_Topic
1932                     ; 932                 punGet_Event_Topic();
1934  04dc cd0000        	call	_punGet_Event_Topic
1936                     ; 934                 ModuleResponding = TRUE;
1938  04df a601          	ld	a,#1
1939  04e1 6b1a          	ld	(OFST+0,sp),a
1941                     ; 935                 IMEIRecievedOKFlag = 1;
1943  04e3 35010000      	mov	_IMEIRecievedOKFlag,#1
1945  04e7 2025          	jra	L377
1946  04e9               L316:
1947                     ; 939                 delay_ms(200);
1949  04e9 ae00c8        	ldw	x,#200
1950  04ec cd0000        	call	_delay_ms
1952                     ; 940                 ModuleResponding = FALSE;
1954  04ef 0f1a          	clr	(OFST+0,sp)
1956                     ; 941                 NotRespondingCounter++;
1958  04f1 0c19          	inc	(OFST-1,sp)
1960  04f3 2019          	jra	L377
1961  04f5               L116:
1962                     ; 947             delay_ms(200);
1964  04f5 ae00c8        	ldw	x,#200
1965  04f8 cd0000        	call	_delay_ms
1967                     ; 948             ms_send_cmd("No Response from Module", strlen((const char *)"No Response from Module"));
1969  04fb 4b17          	push	#23
1970  04fd ae0014        	ldw	x,#L577
1971  0500 cd0000        	call	_ms_send_cmd
1973  0503 84            	pop	a
1974                     ; 949             delay_ms(200);
1976  0504 ae00c8        	ldw	x,#200
1977  0507 cd0000        	call	_delay_ms
1979                     ; 950             ModuleResponding = FALSE;
1981  050a 0f1a          	clr	(OFST+0,sp)
1983                     ; 951             NotRespondingCounter++;
1985  050c 0c19          	inc	(OFST-1,sp)
1987  050e               L377:
1988                     ; 954         delay_ms(200);
1990  050e ae00c8        	ldw	x,#200
1991  0511 cd0000        	call	_delay_ms
1993                     ; 955     } while (!ModuleResponding && NotRespondingCounter < 10);
1995  0514 0d1a          	tnz	(OFST+0,sp)
1996  0516 2609          	jrne	L777
1998  0518 7b19          	ld	a,(OFST-1,sp)
1999  051a a10a          	cp	a,#10
2000  051c 2403          	jruge	L07
2001  051e cc03ad        	jp	L106
2002  0521               L07:
2003  0521               L777:
2004                     ; 957     if (NotRespondingCounter < 10)
2006  0521 7b19          	ld	a,(OFST-1,sp)
2007  0523 a10a          	cp	a,#10
2008  0525 2406          	jruge	L1001
2009                     ; 958         IMEIRecievedOKFlag = 1;
2011  0527 35010000      	mov	_IMEIRecievedOKFlag,#1
2013  052b 2002          	jra	L3001
2014  052d               L1001:
2015                     ; 960         IMEIRecievedOKFlag = 0;
2017  052d 3f00          	clr	_IMEIRecievedOKFlag
2018  052f               L3001:
2019                     ; 961     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2021  052f 4b01          	push	#1
2022  0531 ae0255        	ldw	x,#597
2023  0534 cd0000        	call	_UART1_ITConfig
2025  0537 84            	pop	a
2026                     ; 962     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2028  0538 4b01          	push	#1
2029  053a ae0244        	ldw	x,#580
2030  053d cd0000        	call	_UART1_ITConfig
2032  0540 84            	pop	a
2033                     ; 963 }
2036  0541 5b1a          	addw	sp,#26
2037  0543 81            	ret
2072                     	xdef	_bValidIMEIRecieved
2073                     	xref.b	_IMEIRecievedOKFlag
2074                     	xdef	_vPrintStickerInfo
2075                     	xdef	_vHandle_MQTT
2076                     	xdef	_enGet_TCP_Status
2077                     	xdef	_vClearBuffer
2078                     	xdef	_getIMEI
2079                     	xdef	_checkNum
2080                     	xdef	_SIMComrestart
2081                     	xref	_GSM_OK
2082                     	xdef	_SIMCom_setup
2083                     	xref	_response_buffer
2084                     	xref	_vMQTT_Subscribe
2085                     	xref	_vMQTT_Connect
2086                     	xref	_ms_send_cmd
2087                     	xref	_aunMQTT_Subscribe_Topic
2088                     	xref	_aunMQTT_ClientID
2089                     	xref	_vMevris_Send_Version
2090                     	xref	_vMevris_Send_IMEI
2091                     	xref	_punGet_Client_ID
2092                     	xref	_punGet_Command_Topic
2093                     	xref	_punGet_Event_Topic
2094                     	switch	.ubsct
2095  0000               _PASS_KEY:
2096  0000 000000000000  	ds.b	16
2097                     	xdef	_PASS_KEY
2098  0010               _aunIMEI:
2099  0010 000000000000  	ds.b	20
2100                     	xdef	_aunIMEI
2101                     	xref	_strstr
2102                     	xref.b	_checkit
2103                     	xref	_delay_ms
2104                     	xref	_UART1_GetFlagStatus
2105                     	xref	_UART1_SendData8
2106                     	xref	_UART1_ReceiveData8
2107                     	xref	_UART1_ITConfig
2108                     	xref	_GPIO_WriteLow
2109                     	xref	_GPIO_WriteHigh
2110                     	switch	.const
2111  0014               L577:
2112  0014 4e6f20526573  	dc.b	"No Response from M"
2113  0026 6f64756c6500  	dc.b	"odule",0
2114  002c               L706:
2115  002c 415400        	dc.b	"AT",0
2116  002f               L704:
2117  002f 2b514d54434f  	dc.b	"+QMTCONN:",0
2118  0039               L304:
2119  0039 41542b514d54  	dc.b	"AT+QMTCONN?",0
2120  0045               L351:
2121  0045 41542b47534e  	dc.b	"AT+GSN",0
2122  004c               L101:
2123  004c 41542b434e55  	dc.b	"AT+CNUM",0
2124  0054               L55:
2125  0054 41542b51504f  	dc.b	"AT+QPOWD=1",0
2126  005f               L34:
2127  005f 41542b434741  	dc.b	"AT+CGACT=1,1",0
2128  006c               L14:
2129  006c 41542b434744  	dc.b	"AT+CGDCONT=1,",34
2130  007a 495022        	dc.b	"IP",34
2131  007d 2c22          	dc.b	",",34
2132  007f 5a4f4e475741  	dc.b	"ZONGWAP",34,0
2133  0088               L73:
2134  0088 41542b514346  	dc.b	"AT+QCFG=",34
2135  0091 6e777363616e  	dc.b	"nwscanmode",34
2136  009c 2c302c3100    	dc.b	",0,1",0
2137  00a1               L53:
2138  00a1 41542b434741  	dc.b	"AT+CGATT=1",0
2139  00ac               L33:
2140  00ac 41542b514346  	dc.b	"AT+QCFG=",34
2141  00b5 7572632f7269  	dc.b	"urc/ri/smsincoming"
2142  00c7 222c2270756c  	dc.b	34,44,34,112,117,108
2143  00cd 736522        	dc.b	"se",34
2144  00d0 2c3132302c31  	dc.b	",120,1",0
2145  00d7               L13:
2146  00d7 41542b514346  	dc.b	"AT+QCFG=",34
2147  00e0 7572632f7269  	dc.b	"urc/ri/ring",34
2148  00ec 2c22          	dc.b	",",34
2149  00ee 6f66662200    	dc.b	"off",34,0
2150  00f3               L72:
2151  00f3 41542b514346  	dc.b	"AT+QCFG=",34
2152  00fc 7572632f7269  	dc.b	"urc/ri/other",34
2153  0109 2c22          	dc.b	",",34
2154  010b 6f66662200    	dc.b	"off",34,0
2155  0110               L52:
2156  0110 41542b515343  	dc.b	"AT+QSCLK=0",0
2157  011b               L32:
2158  011b 41542b434d47  	dc.b	"AT+CMGD=1,4",0
2159  0127               L12:
2160  0127 4154453000    	dc.b	"ATE0",0
2161                     	xref.b	c_x
2181                     	xref	c_xymvx
2182                     	end
