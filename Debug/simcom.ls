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
  62  0006 cd00ce        	call	_SIMComrestart
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
  86                     ; 64     ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
  88  0024 4b0b          	push	#11
  89  0026 ae011b        	ldw	x,#L32
  90  0029 cd0000        	call	_ms_send_cmd
  92  002c 84            	pop	a
  93                     ; 65     delay_ms(1000);
  95  002d ae03e8        	ldw	x,#1000
  96  0030 cd0000        	call	_delay_ms
  98                     ; 67     ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
 100  0033 4b0a          	push	#10
 101  0035 ae0110        	ldw	x,#L52
 102  0038 cd0000        	call	_ms_send_cmd
 104  003b 84            	pop	a
 105                     ; 68     delay_ms(1000);
 107  003c ae03e8        	ldw	x,#1000
 108  003f cd0000        	call	_delay_ms
 110                     ; 70     vPrintStickerInfo(); //Added by Saqib
 112  0042 cd037b        	call	_vPrintStickerInfo
 114                     ; 71     delay_ms(1000);
 116  0045 ae03e8        	ldw	x,#1000
 117  0048 cd0000        	call	_delay_ms
 119                     ; 78     ms_send_cmd(MODULE_RI_OTHERS_OFF, strlen((const char *)MODULE_RI_OTHERS_OFF)); /* Disable power saving mode */
 121  004b 4b1c          	push	#28
 122  004d ae00f3        	ldw	x,#L72
 123  0050 cd0000        	call	_ms_send_cmd
 125  0053 84            	pop	a
 126                     ; 79     delay_ms(500);
 128  0054 ae01f4        	ldw	x,#500
 129  0057 cd0000        	call	_delay_ms
 131                     ; 80     ms_send_cmd(MODULE_RI_RING_OFF, strlen((const char *)MODULE_RI_RING_OFF)); /* Disable power saving mode */
 133  005a 4b1b          	push	#27
 134  005c ae00d7        	ldw	x,#L13
 135  005f cd0000        	call	_ms_send_cmd
 137  0062 84            	pop	a
 138                     ; 81     delay_ms(500);
 140  0063 ae01f4        	ldw	x,#500
 141  0066 cd0000        	call	_delay_ms
 143                     ; 82     ms_send_cmd(MODULE_RI_SMS_ON, strlen((const char *)MODULE_RI_SMS_ON)); /* Disable power saving mode */
 145  0069 4b2a          	push	#42
 146  006b ae00ac        	ldw	x,#L33
 147  006e cd0000        	call	_ms_send_cmd
 149  0071 84            	pop	a
 150                     ; 83     delay_ms(500);
 152  0072 ae01f4        	ldw	x,#500
 153  0075 cd0000        	call	_delay_ms
 155                     ; 92     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
 157  0078 4b04          	push	#4
 158  007a ae0127        	ldw	x,#L12
 159  007d cd0000        	call	_ms_send_cmd
 161  0080 84            	pop	a
 162                     ; 93     delay_ms(1000);
 164  0081 ae03e8        	ldw	x,#1000
 165  0084 cd0000        	call	_delay_ms
 167                     ; 130     ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
 169  0087 4b0a          	push	#10
 170  0089 ae00a1        	ldw	x,#L53
 171  008c cd0000        	call	_ms_send_cmd
 173  008f 84            	pop	a
 174                     ; 131     delay_ms(1000);
 176  0090 ae03e8        	ldw	x,#1000
 177  0093 cd0000        	call	_delay_ms
 179                     ; 133     ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
 181  0096 4b18          	push	#24
 182  0098 ae0088        	ldw	x,#L73
 183  009b cd0000        	call	_ms_send_cmd
 185  009e 84            	pop	a
 186                     ; 134     delay_ms(1000);
 188  009f ae03e8        	ldw	x,#1000
 189  00a2 cd0000        	call	_delay_ms
 191                     ; 136     ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
 193  00a5 4b1b          	push	#27
 194  00a7 ae006c        	ldw	x,#L14
 195  00aa cd0000        	call	_ms_send_cmd
 197  00ad 84            	pop	a
 198                     ; 137     delay_ms(1000);
 200  00ae ae03e8        	ldw	x,#1000
 201  00b1 cd0000        	call	_delay_ms
 203                     ; 139     ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
 205  00b4 4b0c          	push	#12
 206  00b6 ae005f        	ldw	x,#L34
 207  00b9 cd0000        	call	_ms_send_cmd
 209  00bc 84            	pop	a
 210                     ; 140     delay_ms(1000);
 212  00bd ae03e8        	ldw	x,#1000
 213  00c0 cd0000        	call	_delay_ms
 215                     ; 145     delay_ms(1000); //Added by Saqib
 217  00c3 ae03e8        	ldw	x,#1000
 218  00c6 cd0000        	call	_delay_ms
 220                     ; 223     checkit = 1; //Recieve data through Ringer Interrupt
 222  00c9 35010000      	mov	_checkit,#1
 223                     ; 224 }
 226  00cd 81            	ret
 254                     ; 270 void SIMComrestart()
 254                     ; 271 {
 255                     	switch	.text
 256  00ce               _SIMComrestart:
 260                     ; 272     ms_send_cmd(SIMCom_OFF, strlen((const char *)SIMCom_OFF)); /* Power down the SIMCom module */
 262  00ce 4b0a          	push	#10
 263  00d0 ae0054        	ldw	x,#L55
 264  00d3 cd0000        	call	_ms_send_cmd
 266  00d6 84            	pop	a
 267                     ; 273     delay_ms(800);
 269  00d7 ae0320        	ldw	x,#800
 270  00da cd0000        	call	_delay_ms
 272                     ; 275     GPIO_WriteHigh(PWRKEY);
 274  00dd 4b20          	push	#32
 275  00df ae500a        	ldw	x,#20490
 276  00e2 cd0000        	call	_GPIO_WriteHigh
 278  00e5 84            	pop	a
 279                     ; 276     delay_ms(1000);
 281  00e6 ae03e8        	ldw	x,#1000
 282  00e9 cd0000        	call	_delay_ms
 284                     ; 278     GPIO_WriteLow(PWRKEY);
 286  00ec 4b20          	push	#32
 287  00ee ae500a        	ldw	x,#20490
 288  00f1 cd0000        	call	_GPIO_WriteLow
 290  00f4 84            	pop	a
 291                     ; 279     delay_ms(1000);
 293  00f5 ae03e8        	ldw	x,#1000
 294  00f8 cd0000        	call	_delay_ms
 296                     ; 280 }
 299  00fb 81            	ret
 347                     ; 282 void checkNum()
 347                     ; 283 {
 348                     	switch	.text
 349  00fc               _checkNum:
 351  00fc 5203          	subw	sp,#3
 352       00000003      OFST:	set	3
 355                     ; 284     uint16_t timeout = 0;
 357  00fe 5f            	clrw	x
 358  00ff 1f01          	ldw	(OFST-2,sp),x
 360                     ; 286     ms_send_cmd(check_num, strlen((const char *)check_num)); // SMS read
 362  0101 4b07          	push	#7
 363  0103 ae004c        	ldw	x,#L101
 364  0106 cd0000        	call	_ms_send_cmd
 366  0109 84            	pop	a
 367                     ; 288     for (s = 0; s < 75; s++)
 369  010a 0f03          	clr	(OFST+0,sp)
 371  010c               L311:
 372                     ; 290         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 374  010c ae0020        	ldw	x,#32
 375  010f cd0000        	call	_UART1_GetFlagStatus
 377  0112 4d            	tnz	a
 378  0113 260c          	jrne	L711
 380  0115 1e01          	ldw	x,(OFST-2,sp)
 381  0117 1c0001        	addw	x,#1
 382  011a 1f01          	ldw	(OFST-2,sp),x
 384  011c a32710        	cpw	x,#10000
 385  011f 26eb          	jrne	L311
 386  0121               L711:
 387                     ; 292         response_buffer[s] = UART1_ReceiveData8();
 389  0121 7b03          	ld	a,(OFST+0,sp)
 390  0123 5f            	clrw	x
 391  0124 97            	ld	xl,a
 392  0125 89            	pushw	x
 393  0126 cd0000        	call	_UART1_ReceiveData8
 395  0129 85            	popw	x
 396  012a d70000        	ld	(_response_buffer,x),a
 397                     ; 293         timeout = 0;
 399  012d 5f            	clrw	x
 400  012e 1f01          	ldw	(OFST-2,sp),x
 402                     ; 288     for (s = 0; s < 75; s++)
 404  0130 0c03          	inc	(OFST+0,sp)
 408  0132 7b03          	ld	a,(OFST+0,sp)
 409  0134 a14b          	cp	a,#75
 410  0136 25d4          	jrult	L311
 411                     ; 295 }
 414  0138 5b03          	addw	sp,#3
 415  013a 81            	ret
 484                     ; 297 void getIMEI(void)
 484                     ; 298 {
 485                     	switch	.text
 486  013b               _getIMEI:
 488  013b 521d          	subw	sp,#29
 489       0000001d      OFST:	set	29
 492                     ; 304     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 494  013d 4b00          	push	#0
 495  013f ae0255        	ldw	x,#597
 496  0142 cd0000        	call	_UART1_ITConfig
 498  0145 84            	pop	a
 499                     ; 305     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 501  0146 4b00          	push	#0
 502  0148 ae0244        	ldw	x,#580
 503  014b cd0000        	call	_UART1_ITConfig
 505  014e 84            	pop	a
 506                     ; 307     ms_send_cmd(IMEIcmnd, strlen((const char *)IMEIcmnd)); //"AT+HTTPSSL=1"
 508  014f 4b06          	push	#6
 509  0151 ae0045        	ldw	x,#L351
 510  0154 cd0000        	call	_ms_send_cmd
 512  0157 84            	pop	a
 513                     ; 310     for (i = 0; i < 25; i++)
 515  0158 0f1d          	clr	(OFST+0,sp)
 517  015a               L561:
 518                     ; 312         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++ulTimout != 10000))
 520  015a ae0020        	ldw	x,#32
 521  015d cd0000        	call	_UART1_GetFlagStatus
 523  0160 4d            	tnz	a
 524  0161 260c          	jrne	L171
 526  0163 1e1a          	ldw	x,(OFST-3,sp)
 527  0165 1c0001        	addw	x,#1
 528  0168 1f1a          	ldw	(OFST-3,sp),x
 530  016a a32710        	cpw	x,#10000
 531  016d 26eb          	jrne	L561
 532  016f               L171:
 533                     ; 314         localBuffer[i] = UART1_ReceiveData8();
 535  016f 96            	ldw	x,sp
 536  0170 1c0001        	addw	x,#OFST-28
 537  0173 9f            	ld	a,xl
 538  0174 5e            	swapw	x
 539  0175 1b1d          	add	a,(OFST+0,sp)
 540  0177 2401          	jrnc	L41
 541  0179 5c            	incw	x
 542  017a               L41:
 543  017a 02            	rlwa	x,a
 544  017b 89            	pushw	x
 545  017c cd0000        	call	_UART1_ReceiveData8
 547  017f 85            	popw	x
 548  0180 f7            	ld	(x),a
 549                     ; 315         ulTimout = 0;
 551  0181 5f            	clrw	x
 552  0182 1f1a          	ldw	(OFST-3,sp),x
 554                     ; 310     for (i = 0; i < 25; i++)
 556  0184 0c1d          	inc	(OFST+0,sp)
 560  0186 7b1d          	ld	a,(OFST+0,sp)
 561  0188 a119          	cp	a,#25
 562  018a 25ce          	jrult	L561
 563                     ; 317     localBuffer[i] = '\0';
 565  018c 96            	ldw	x,sp
 566  018d 1c0001        	addw	x,#OFST-28
 567  0190 9f            	ld	a,xl
 568  0191 5e            	swapw	x
 569  0192 1b1d          	add	a,(OFST+0,sp)
 570  0194 2401          	jrnc	L61
 571  0196 5c            	incw	x
 572  0197               L61:
 573  0197 02            	rlwa	x,a
 574  0198 7f            	clr	(x)
 575                     ; 318     j = 0;
 577  0199 0f1c          	clr	(OFST-1,sp)
 579                     ; 319     for (i = 2; i < 17; i++)
 581  019b a602          	ld	a,#2
 582  019d 6b1d          	ld	(OFST+0,sp),a
 584  019f               L371:
 585                     ; 321         aunIMEI[j] = localBuffer[i];
 587  019f 7b1c          	ld	a,(OFST-1,sp)
 588  01a1 5f            	clrw	x
 589  01a2 97            	ld	xl,a
 590  01a3 89            	pushw	x
 591  01a4 96            	ldw	x,sp
 592  01a5 1c0003        	addw	x,#OFST-26
 593  01a8 9f            	ld	a,xl
 594  01a9 5e            	swapw	x
 595  01aa 1b1f          	add	a,(OFST+2,sp)
 596  01ac 2401          	jrnc	L02
 597  01ae 5c            	incw	x
 598  01af               L02:
 599  01af 02            	rlwa	x,a
 600  01b0 f6            	ld	a,(x)
 601  01b1 85            	popw	x
 602  01b2 e710          	ld	(_aunIMEI,x),a
 603                     ; 322         j++;
 605  01b4 0c1c          	inc	(OFST-1,sp)
 607                     ; 319     for (i = 2; i < 17; i++)
 609  01b6 0c1d          	inc	(OFST+0,sp)
 613  01b8 7b1d          	ld	a,(OFST+0,sp)
 614  01ba a111          	cp	a,#17
 615  01bc 25e1          	jrult	L371
 616                     ; 324     aunIMEI[j] = '\0';
 618  01be 7b1c          	ld	a,(OFST-1,sp)
 619  01c0 5f            	clrw	x
 620  01c1 97            	ld	xl,a
 621  01c2 6f10          	clr	(_aunIMEI,x)
 622                     ; 325     delay_ms(200);
 624  01c4 ae00c8        	ldw	x,#200
 625  01c7 cd0000        	call	_delay_ms
 627                     ; 327     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 629  01ca 4b01          	push	#1
 630  01cc ae0255        	ldw	x,#597
 631  01cf cd0000        	call	_UART1_ITConfig
 633  01d2 84            	pop	a
 634                     ; 328     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
 636  01d3 4b01          	push	#1
 637  01d5 ae0244        	ldw	x,#580
 638  01d8 cd0000        	call	_UART1_ITConfig
 640  01db 84            	pop	a
 641                     ; 329 }
 644  01dc 5b1d          	addw	sp,#29
 645  01de 81            	ret
 648                     	bsct
 649  0000               L102_unMQTTCounter:
 650  0000 00            	dc.b	0
 651  0001               L302_unMQQT_PingCounter:
 652  0001 00            	dc.b	0
 812                     ; 620 void vHandle_MQTT(void)
 812                     ; 621 {
 813                     	switch	.text
 814  01df               _vHandle_MQTT:
 816  01df 89            	pushw	x
 817       00000002      OFST:	set	2
 820                     ; 622     uint8_t unLength = 0;
 822                     ; 627     if (IMEIRecievedOKFlag)
 824  01e0 3d00          	tnz	_IMEIRecievedOKFlag
 825  01e2 2750          	jreq	L172
 826                     ; 629         eTCP_Status = enGet_TCP_Status();
 828  01e4 ad70          	call	_enGet_TCP_Status
 830  01e6 6b02          	ld	(OFST+0,sp),a
 832                     ; 630         if (eTCP_Status == eTCP_STAT_CONNECT_OK)
 834  01e8 7b02          	ld	a,(OFST+0,sp)
 835  01ea a107          	cp	a,#7
 836  01ec 263c          	jrne	L372
 837                     ; 632             if (unMQTTCounter == 0)
 839  01ee 3d00          	tnz	L102_unMQTTCounter
 840  01f0 260a          	jrne	L572
 841                     ; 634                 vMQTT_Subscribe(aunMQTT_Subscribe_Topic);
 843  01f2 ae0000        	ldw	x,#_aunMQTT_Subscribe_Topic
 844  01f5 cd0000        	call	_vMQTT_Subscribe
 846                     ; 635                 unMQTTCounter++;
 848  01f8 3c00          	inc	L102_unMQTTCounter
 850  01fa 203b          	jra	L513
 851  01fc               L572:
 852                     ; 637             else if (unMQTTCounter == 1)
 854  01fc b600          	ld	a,L102_unMQTTCounter
 855  01fe a101          	cp	a,#1
 856  0200 260d          	jrne	L103
 857                     ; 639                 delay_ms(100);
 859  0202 ae0064        	ldw	x,#100
 860  0205 cd0000        	call	_delay_ms
 862                     ; 640                 vMevris_Send_IMEI();
 864  0208 cd0000        	call	_vMevris_Send_IMEI
 866                     ; 641                 unMQTTCounter++;
 868  020b 3c00          	inc	L102_unMQTTCounter
 870  020d 2028          	jra	L513
 871  020f               L103:
 872                     ; 644             else if (unMQTTCounter == 2)
 874  020f b600          	ld	a,L102_unMQTTCounter
 875  0211 a102          	cp	a,#2
 876  0213 260d          	jrne	L503
 877                     ; 646                 delay_ms(100);
 879  0215 ae0064        	ldw	x,#100
 880  0218 cd0000        	call	_delay_ms
 882                     ; 647                 vMevris_Send_Version();
 884  021b cd0000        	call	_vMevris_Send_Version
 886                     ; 648                 unMQTTCounter++;
 888  021e 3c00          	inc	L102_unMQTTCounter
 890  0220 2015          	jra	L513
 891  0222               L503:
 892                     ; 651             else if (unMQTTCounter >= 3)
 894  0222 b600          	ld	a,L102_unMQTTCounter
 895  0224 a103          	cp	a,#3
 896  0226 250f          	jrult	L513
 897  0228 200d          	jra	L513
 898  022a               L372:
 899                     ; 658             vMQTT_Connect(aunMQTT_ClientID);
 901  022a ae0000        	ldw	x,#_aunMQTT_ClientID
 902  022d cd0000        	call	_vMQTT_Connect
 904                     ; 659             unMQTTCounter = 0;
 906  0230 3f00          	clr	L102_unMQTTCounter
 907  0232 2003          	jra	L513
 908  0234               L172:
 909                     ; 664         vPrintStickerInfo();
 911  0234 cd037b        	call	_vPrintStickerInfo
 913  0237               L513:
 914                     ; 666 }
 917  0237 85            	popw	x
 918  0238 81            	ret
 971                     ; 670 void vClearBuffer(char *temp, uint8_t unLen)
 971                     ; 671 {
 972                     	switch	.text
 973  0239               _vClearBuffer:
 975  0239 89            	pushw	x
 976  023a 88            	push	a
 977       00000001      OFST:	set	1
 980                     ; 673     for (i = 0; i < unLen; i++)
 982  023b 0f01          	clr	(OFST+0,sp)
 985  023d 200e          	jra	L153
 986  023f               L543:
 987                     ; 675         *(temp + i) = '\0';
 989  023f 7b02          	ld	a,(OFST+1,sp)
 990  0241 97            	ld	xl,a
 991  0242 7b03          	ld	a,(OFST+2,sp)
 992  0244 1b01          	add	a,(OFST+0,sp)
 993  0246 2401          	jrnc	L62
 994  0248 5c            	incw	x
 995  0249               L62:
 996  0249 02            	rlwa	x,a
 997  024a 7f            	clr	(x)
 998                     ; 673     for (i = 0; i < unLen; i++)
1000  024b 0c01          	inc	(OFST+0,sp)
1002  024d               L153:
1005  024d 7b01          	ld	a,(OFST+0,sp)
1006  024f 1106          	cp	a,(OFST+5,sp)
1007  0251 25ec          	jrult	L543
1008                     ; 677 }
1011  0253 5b03          	addw	sp,#3
1012  0255 81            	ret
1072                     ; 679 enTCP_STATUS enGet_TCP_Status(void)
1072                     ; 680 {
1073                     	switch	.text
1074  0256               _enGet_TCP_Status:
1076  0256 5203          	subw	sp,#3
1077       00000003      OFST:	set	3
1080                     ; 682     uint8_t j = 0;
1082  0258 0f03          	clr	(OFST+0,sp)
1084                     ; 742     ms_send_cmd(MQTT_CHECK_STATUS, strlen((const char *)MQTT_CHECK_STATUS));
1086  025a 4b0b          	push	#11
1087  025c ae0039        	ldw	x,#L304
1088  025f cd0000        	call	_ms_send_cmd
1090  0262 84            	pop	a
1091                     ; 743     delay_ms(1000);
1093  0263 ae03e8        	ldw	x,#1000
1094  0266 cd0000        	call	_delay_ms
1096                     ; 745     if (strstr(response_buffer, "+QMTCONN:"))
1098  0269 ae002f        	ldw	x,#L704
1099  026c 89            	pushw	x
1100  026d ae0000        	ldw	x,#_response_buffer
1101  0270 cd0000        	call	_strstr
1103  0273 5b02          	addw	sp,#2
1104  0275 a30000        	cpw	x,#0
1105  0278 2603          	jrne	L44
1106  027a cc030d        	jp	L504
1107  027d               L44:
1108                     ; 747         i = strstr(response_buffer, "+QMTCONN:");
1110  027d ae002f        	ldw	x,#L704
1111  0280 89            	pushw	x
1112  0281 ae0000        	ldw	x,#_response_buffer
1113  0284 cd0000        	call	_strstr
1115  0287 5b02          	addw	sp,#2
1116  0289 1f01          	ldw	(OFST-2,sp),x
1118                     ; 748         if (i)
1120  028b 1e01          	ldw	x,(OFST-2,sp)
1121  028d 2602          	jrne	L64
1122  028f 2078          	jp	L114
1123  0291               L64:
1125  0291 2002          	jra	L514
1126  0293               L314:
1127                     ; 751                 j++;
1129  0293 0c03          	inc	(OFST+0,sp)
1131  0295               L514:
1132                     ; 750             while (*(i + j) != ',' && j < 100)
1134  0295 7b01          	ld	a,(OFST-2,sp)
1135  0297 97            	ld	xl,a
1136  0298 7b02          	ld	a,(OFST-1,sp)
1137  029a 1b03          	add	a,(OFST+0,sp)
1138  029c 2401          	jrnc	L23
1139  029e 5c            	incw	x
1140  029f               L23:
1141  029f 02            	rlwa	x,a
1142  02a0 f6            	ld	a,(x)
1143  02a1 a12c          	cp	a,#44
1144  02a3 2706          	jreq	L124
1146  02a5 7b03          	ld	a,(OFST+0,sp)
1147  02a7 a164          	cp	a,#100
1148  02a9 25e8          	jrult	L314
1149  02ab               L124:
1150                     ; 755             j++;
1152  02ab 0c03          	inc	(OFST+0,sp)
1154                     ; 757             if (*(i + j) == 1)
1156  02ad 7b01          	ld	a,(OFST-2,sp)
1157  02af 97            	ld	xl,a
1158  02b0 7b02          	ld	a,(OFST-1,sp)
1159  02b2 1b03          	add	a,(OFST+0,sp)
1160  02b4 2401          	jrnc	L43
1161  02b6 5c            	incw	x
1162  02b7               L43:
1163  02b7 02            	rlwa	x,a
1164  02b8 f6            	ld	a,(x)
1165  02b9 a101          	cp	a,#1
1166  02bb 2606          	jrne	L324
1167                     ; 759                 eStatus = eTCP_STAT_IP_INITIAL;
1169  02bd a601          	ld	a,#1
1170  02bf 6b03          	ld	(OFST+0,sp),a
1173  02c1 204c          	jra	L544
1174  02c3               L324:
1175                     ; 762             else if (*(i + j) == 2)
1177  02c3 7b01          	ld	a,(OFST-2,sp)
1178  02c5 97            	ld	xl,a
1179  02c6 7b02          	ld	a,(OFST-1,sp)
1180  02c8 1b03          	add	a,(OFST+0,sp)
1181  02ca 2401          	jrnc	L63
1182  02cc 5c            	incw	x
1183  02cd               L63:
1184  02cd 02            	rlwa	x,a
1185  02ce f6            	ld	a,(x)
1186  02cf a102          	cp	a,#2
1187  02d1 2606          	jrne	L724
1188                     ; 764                 eStatus = eTCP_STAT_CONNECTING;
1190  02d3 a606          	ld	a,#6
1191  02d5 6b03          	ld	(OFST+0,sp),a
1194  02d7 2036          	jra	L544
1195  02d9               L724:
1196                     ; 767             else if (*(i + j) == 3)
1198  02d9 7b01          	ld	a,(OFST-2,sp)
1199  02db 97            	ld	xl,a
1200  02dc 7b02          	ld	a,(OFST-1,sp)
1201  02de 1b03          	add	a,(OFST+0,sp)
1202  02e0 2401          	jrnc	L04
1203  02e2 5c            	incw	x
1204  02e3               L04:
1205  02e3 02            	rlwa	x,a
1206  02e4 f6            	ld	a,(x)
1207  02e5 a103          	cp	a,#3
1208  02e7 2606          	jrne	L334
1209                     ; 769                 eStatus = eTCP_STAT_CONNECT_OK;
1211  02e9 a607          	ld	a,#7
1212  02eb 6b03          	ld	(OFST+0,sp),a
1215  02ed 2020          	jra	L544
1216  02ef               L334:
1217                     ; 775             else if (*(i + j) == 4)
1219  02ef 7b01          	ld	a,(OFST-2,sp)
1220  02f1 97            	ld	xl,a
1221  02f2 7b02          	ld	a,(OFST-1,sp)
1222  02f4 1b03          	add	a,(OFST+0,sp)
1223  02f6 2401          	jrnc	L24
1224  02f8 5c            	incw	x
1225  02f9               L24:
1226  02f9 02            	rlwa	x,a
1227  02fa f6            	ld	a,(x)
1228  02fb a104          	cp	a,#4
1229  02fd 2606          	jrne	L734
1230                     ; 777                 eStatus = eTCP_STAT_CLOSED;
1232  02ff a609          	ld	a,#9
1233  0301 6b03          	ld	(OFST+0,sp),a
1236  0303 200a          	jra	L544
1237  0305               L734:
1238                     ; 781                 eStatus = eTCP_STAT_UNKNOWN;
1240  0305 0f03          	clr	(OFST+0,sp)
1242  0307 2006          	jra	L544
1243  0309               L114:
1244                     ; 786             eStatus = eTCP_STAT_UNKNOWN;
1246  0309 0f03          	clr	(OFST+0,sp)
1248  030b 2002          	jra	L544
1249  030d               L504:
1250                     ; 791         eStatus = eTCP_STAT_UNKNOWN;
1252  030d 0f03          	clr	(OFST+0,sp)
1254  030f               L544:
1255                     ; 794     return eStatus;
1257  030f 7b03          	ld	a,(OFST+0,sp)
1260  0311 5b03          	addw	sp,#3
1261  0313 81            	ret
1347                     ; 820 bool bValidIMEIRecieved(char *myArray)
1347                     ; 821 {
1348                     	switch	.text
1349  0314               _bValidIMEIRecieved:
1351  0314 89            	pushw	x
1352  0315 5203          	subw	sp,#3
1353       00000003      OFST:	set	3
1356                     ; 822     uint8_t i = 0, j = 0, k = 0;
1362  0317 0f02          	clr	(OFST-1,sp)
1364                     ; 823     for (j = 0; j < 20; j++)
1366  0319 0f03          	clr	(OFST+0,sp)
1368  031b               L115:
1369                     ; 825         if (myArray[j] > 0x39 || myArray[j] < 0x30)
1371  031b 7b04          	ld	a,(OFST+1,sp)
1372  031d 97            	ld	xl,a
1373  031e 7b05          	ld	a,(OFST+2,sp)
1374  0320 1b03          	add	a,(OFST+0,sp)
1375  0322 2401          	jrnc	L25
1376  0324 5c            	incw	x
1377  0325               L25:
1378  0325 02            	rlwa	x,a
1379  0326 f6            	ld	a,(x)
1380  0327 a13a          	cp	a,#58
1381  0329 2410          	jruge	L125
1383  032b 7b04          	ld	a,(OFST+1,sp)
1384  032d 97            	ld	xl,a
1385  032e 7b05          	ld	a,(OFST+2,sp)
1386  0330 1b03          	add	a,(OFST+0,sp)
1387  0332 2401          	jrnc	L45
1388  0334 5c            	incw	x
1389  0335               L45:
1390  0335 02            	rlwa	x,a
1391  0336 f6            	ld	a,(x)
1392  0337 a130          	cp	a,#48
1393  0339 2419          	jruge	L715
1394  033b               L125:
1395                     ; 827             nop();
1398  033b 9d            nop
1401  033c               L325:
1402                     ; 823     for (j = 0; j < 20; j++)
1404  033c 0c03          	inc	(OFST+0,sp)
1408  033e 7b03          	ld	a,(OFST+0,sp)
1409  0340 a114          	cp	a,#20
1410  0342 25d7          	jrult	L115
1411                     ; 834     if (k == 15)
1413  0344 7b02          	ld	a,(OFST-1,sp)
1414  0346 a10f          	cp	a,#15
1415  0348 2624          	jrne	L525
1416                     ; 836         aunIMEI[k] = '\0';
1418  034a 7b02          	ld	a,(OFST-1,sp)
1419  034c 5f            	clrw	x
1420  034d 97            	ld	xl,a
1421  034e 6f10          	clr	(_aunIMEI,x)
1422                     ; 837         return TRUE;
1424  0350 a601          	ld	a,#1
1426  0352 2024          	jra	L06
1427  0354               L715:
1428                     ; 831             aunIMEI[k++] = myArray[j];
1430  0354 7b02          	ld	a,(OFST-1,sp)
1431  0356 97            	ld	xl,a
1432  0357 0c02          	inc	(OFST-1,sp)
1434  0359 9f            	ld	a,xl
1435  035a 5f            	clrw	x
1436  035b 97            	ld	xl,a
1437  035c 89            	pushw	x
1438  035d 7b06          	ld	a,(OFST+3,sp)
1439  035f 97            	ld	xl,a
1440  0360 7b07          	ld	a,(OFST+4,sp)
1441  0362 1b05          	add	a,(OFST+2,sp)
1442  0364 2401          	jrnc	L65
1443  0366 5c            	incw	x
1444  0367               L65:
1445  0367 02            	rlwa	x,a
1446  0368 f6            	ld	a,(x)
1447  0369 85            	popw	x
1448  036a e710          	ld	(_aunIMEI,x),a
1449  036c 20ce          	jra	L325
1450  036e               L525:
1451                     ; 841         vClearBuffer(aunIMEI, 16);
1453  036e 4b10          	push	#16
1454  0370 ae0010        	ldw	x,#_aunIMEI
1455  0373 cd0239        	call	_vClearBuffer
1457  0376 84            	pop	a
1458                     ; 842         return FALSE;
1460  0377 4f            	clr	a
1462  0378               L06:
1464  0378 5b05          	addw	sp,#5
1465  037a 81            	ret
1468                     .const:	section	.text
1469  0000               L135_imei_array:
1470  0000 00            	dc.b	0
1471  0001 000000000000  	ds.b	19
1575                     ; 847 void vPrintStickerInfo(void)
1575                     ; 848 {
1576                     	switch	.text
1577  037b               _vPrintStickerInfo:
1579  037b 521a          	subw	sp,#26
1580       0000001a      OFST:	set	26
1583                     ; 849     uint8_t p = 0, i = 0;
1587                     ; 850     uint8_t NotRespondingCounter = 0;
1589  037d 0f19          	clr	(OFST-1,sp)
1591                     ; 851     uint16_t gsm_ok_timeout = 10000;
1593                     ; 852     uint8_t imei_array[20] = {0};
1595  037f 96            	ldw	x,sp
1596  0380 1c0004        	addw	x,#OFST-22
1597  0383 90ae0000      	ldw	y,#L135_imei_array
1598  0387 a614          	ld	a,#20
1599  0389 cd0000        	call	c_xymvx
1601                     ; 853     bool ModuleResponding = FALSE;
1603                     ; 854     bool myInterruptFlag = TRUE;
1605                     ; 856     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
1607  038c 4b00          	push	#0
1608  038e ae0255        	ldw	x,#597
1609  0391 cd0000        	call	_UART1_ITConfig
1611  0394 84            	pop	a
1612                     ; 857     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
1614  0395 4b00          	push	#0
1615  0397 ae0244        	ldw	x,#580
1616  039a cd0000        	call	_UART1_ITConfig
1618  039d 84            	pop	a
1619                     ; 858     delay_ms(100);
1621  039e ae0064        	ldw	x,#100
1622  03a1 cd0000        	call	_delay_ms
1624  03a4               L106:
1625                     ; 862         ms_send_cmd(AT, strlen((const char *)AT));
1627  03a4 4b02          	push	#2
1628  03a6 ae002c        	ldw	x,#L706
1629  03a9 cd0000        	call	_ms_send_cmd
1631  03ac 84            	pop	a
1632                     ; 863         if (GSM_OK())
1634  03ad cd0000        	call	_GSM_OK
1636  03b0 a30000        	cpw	x,#0
1637  03b3 2603          	jrne	L46
1638  03b5 cc04ec        	jp	L116
1639  03b8               L46:
1640                     ; 865             delay_ms(200);
1642  03b8 ae00c8        	ldw	x,#200
1643  03bb cd0000        	call	_delay_ms
1645                     ; 867             getIMEI();
1647  03be cd013b        	call	_getIMEI
1649                     ; 868             if (bValidIMEIRecieved(aunIMEI))
1651  03c1 ae0010        	ldw	x,#_aunIMEI
1652  03c4 cd0314        	call	_bValidIMEIRecieved
1654  03c7 4d            	tnz	a
1655  03c8 2603          	jrne	L66
1656  03ca cc04e0        	jp	L316
1657  03cd               L66:
1658                     ; 870                 delay_ms(100);
1660  03cd ae0064        	ldw	x,#100
1661  03d0 cd0000        	call	_delay_ms
1663                     ; 871                 for (i = 0; i < 20; i++)
1665  03d3 0f1a          	clr	(OFST+0,sp)
1667  03d5               L526:
1668                     ; 873                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1670  03d5 ae0040        	ldw	x,#64
1671  03d8 cd0000        	call	_UART1_GetFlagStatus
1673  03db 4d            	tnz	a
1674  03dc 27f7          	jreq	L526
1675                     ; 875                     UART1_SendData8('*');
1677  03de a62a          	ld	a,#42
1678  03e0 cd0000        	call	_UART1_SendData8
1680                     ; 871                 for (i = 0; i < 20; i++)
1682  03e3 0c1a          	inc	(OFST+0,sp)
1686  03e5 7b1a          	ld	a,(OFST+0,sp)
1687  03e7 a114          	cp	a,#20
1688  03e9 25ea          	jrult	L526
1690  03eb               L336:
1691                     ; 877                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1693  03eb ae0040        	ldw	x,#64
1694  03ee cd0000        	call	_UART1_GetFlagStatus
1696  03f1 4d            	tnz	a
1697  03f2 27f7          	jreq	L336
1698                     ; 879                 UART1_SendData8('\n');
1700  03f4 a60a          	ld	a,#10
1701  03f6 cd0000        	call	_UART1_SendData8
1704  03f9               L146:
1705                     ; 880                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1707  03f9 ae0040        	ldw	x,#64
1708  03fc cd0000        	call	_UART1_GetFlagStatus
1710  03ff 4d            	tnz	a
1711  0400 27f7          	jreq	L146
1712                     ; 882                 UART1_SendData8('I');
1714  0402 a649          	ld	a,#73
1715  0404 cd0000        	call	_UART1_SendData8
1718  0407               L746:
1719                     ; 883                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1721  0407 ae0040        	ldw	x,#64
1722  040a cd0000        	call	_UART1_GetFlagStatus
1724  040d 4d            	tnz	a
1725  040e 27f7          	jreq	L746
1726                     ; 885                 UART1_SendData8('M');
1728  0410 a64d          	ld	a,#77
1729  0412 cd0000        	call	_UART1_SendData8
1732  0415               L556:
1733                     ; 886                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1735  0415 ae0040        	ldw	x,#64
1736  0418 cd0000        	call	_UART1_GetFlagStatus
1738  041b 4d            	tnz	a
1739  041c 27f7          	jreq	L556
1740                     ; 888                 UART1_SendData8('E');
1742  041e a645          	ld	a,#69
1743  0420 cd0000        	call	_UART1_SendData8
1746  0423               L366:
1747                     ; 889                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1749  0423 ae0040        	ldw	x,#64
1750  0426 cd0000        	call	_UART1_GetFlagStatus
1752  0429 4d            	tnz	a
1753  042a 27f7          	jreq	L366
1754                     ; 891                 UART1_SendData8('I');
1756  042c a649          	ld	a,#73
1757  042e cd0000        	call	_UART1_SendData8
1760  0431               L176:
1761                     ; 892                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1763  0431 ae0040        	ldw	x,#64
1764  0434 cd0000        	call	_UART1_GetFlagStatus
1766  0437 4d            	tnz	a
1767  0438 27f7          	jreq	L176
1768                     ; 894                 UART1_SendData8(' ');
1770  043a a620          	ld	a,#32
1771  043c cd0000        	call	_UART1_SendData8
1774  043f               L776:
1775                     ; 895                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1777  043f ae0040        	ldw	x,#64
1778  0442 cd0000        	call	_UART1_GetFlagStatus
1780  0445 4d            	tnz	a
1781  0446 27f7          	jreq	L776
1782                     ; 897                 UART1_SendData8('i');
1784  0448 a669          	ld	a,#105
1785  044a cd0000        	call	_UART1_SendData8
1788  044d               L507:
1789                     ; 898                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1791  044d ae0040        	ldw	x,#64
1792  0450 cd0000        	call	_UART1_GetFlagStatus
1794  0453 4d            	tnz	a
1795  0454 27f7          	jreq	L507
1796                     ; 900                 UART1_SendData8('s');
1798  0456 a673          	ld	a,#115
1799  0458 cd0000        	call	_UART1_SendData8
1802  045b               L317:
1803                     ; 901                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1805  045b ae0040        	ldw	x,#64
1806  045e cd0000        	call	_UART1_GetFlagStatus
1808  0461 4d            	tnz	a
1809  0462 27f7          	jreq	L317
1810                     ; 903                 UART1_SendData8('\n');
1812  0464 a60a          	ld	a,#10
1813  0466 cd0000        	call	_UART1_SendData8
1816  0469               L127:
1817                     ; 905                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1819  0469 ae0040        	ldw	x,#64
1820  046c cd0000        	call	_UART1_GetFlagStatus
1822  046f 4d            	tnz	a
1823  0470 27f7          	jreq	L127
1824                     ; 907                 UART1_SendData8('\n');
1826  0472 a60a          	ld	a,#10
1827  0474 cd0000        	call	_UART1_SendData8
1829                     ; 908                 for (i = 0; i < 15; i++)
1831  0477 0f1a          	clr	(OFST+0,sp)
1833  0479               L537:
1834                     ; 910                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1836  0479 ae0040        	ldw	x,#64
1837  047c cd0000        	call	_UART1_GetFlagStatus
1839  047f 4d            	tnz	a
1840  0480 27f7          	jreq	L537
1841                     ; 912                     UART1_SendData8(aunIMEI[i]);
1843  0482 7b1a          	ld	a,(OFST+0,sp)
1844  0484 5f            	clrw	x
1845  0485 97            	ld	xl,a
1846  0486 e610          	ld	a,(_aunIMEI,x)
1847  0488 cd0000        	call	_UART1_SendData8
1849                     ; 908                 for (i = 0; i < 15; i++)
1851  048b 0c1a          	inc	(OFST+0,sp)
1855  048d 7b1a          	ld	a,(OFST+0,sp)
1856  048f a10f          	cp	a,#15
1857  0491 25e6          	jrult	L537
1859  0493               L347:
1860                     ; 914                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1862  0493 ae0040        	ldw	x,#64
1863  0496 cd0000        	call	_UART1_GetFlagStatus
1865  0499 4d            	tnz	a
1866  049a 27f7          	jreq	L347
1867                     ; 917                 UART1_SendData8('\n');
1869  049c a60a          	ld	a,#10
1870  049e cd0000        	call	_UART1_SendData8
1872                     ; 918                 for (i = 0; i < 20; i++)
1874  04a1 0f1a          	clr	(OFST+0,sp)
1876  04a3               L757:
1877                     ; 920                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1879  04a3 ae0040        	ldw	x,#64
1880  04a6 cd0000        	call	_UART1_GetFlagStatus
1882  04a9 4d            	tnz	a
1883  04aa 27f7          	jreq	L757
1884                     ; 922                     UART1_SendData8('*');
1886  04ac a62a          	ld	a,#42
1887  04ae cd0000        	call	_UART1_SendData8
1889                     ; 918                 for (i = 0; i < 20; i++)
1891  04b1 0c1a          	inc	(OFST+0,sp)
1895  04b3 7b1a          	ld	a,(OFST+0,sp)
1896  04b5 a114          	cp	a,#20
1897  04b7 25ea          	jrult	L757
1899  04b9               L567:
1900                     ; 924                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
1902  04b9 ae0040        	ldw	x,#64
1903  04bc cd0000        	call	_UART1_GetFlagStatus
1905  04bf 4d            	tnz	a
1906  04c0 27f7          	jreq	L567
1907                     ; 926                 UART1_SendData8('\r');
1909  04c2 a60d          	ld	a,#13
1910  04c4 cd0000        	call	_UART1_SendData8
1912                     ; 927                 delay_ms(100);
1914  04c7 ae0064        	ldw	x,#100
1915  04ca cd0000        	call	_delay_ms
1917                     ; 929                 punGet_Client_ID();
1919  04cd cd0000        	call	_punGet_Client_ID
1921                     ; 930                 punGet_Command_Topic();
1923  04d0 cd0000        	call	_punGet_Command_Topic
1925                     ; 931                 punGet_Event_Topic();
1927  04d3 cd0000        	call	_punGet_Event_Topic
1929                     ; 933                 ModuleResponding = TRUE;
1931  04d6 a601          	ld	a,#1
1932  04d8 6b1a          	ld	(OFST+0,sp),a
1934                     ; 934                 IMEIRecievedOKFlag = 1;
1936  04da 35010000      	mov	_IMEIRecievedOKFlag,#1
1938  04de 2025          	jra	L377
1939  04e0               L316:
1940                     ; 938                 delay_ms(200);
1942  04e0 ae00c8        	ldw	x,#200
1943  04e3 cd0000        	call	_delay_ms
1945                     ; 939                 ModuleResponding = FALSE;
1947  04e6 0f1a          	clr	(OFST+0,sp)
1949                     ; 940                 NotRespondingCounter++;
1951  04e8 0c19          	inc	(OFST-1,sp)
1953  04ea 2019          	jra	L377
1954  04ec               L116:
1955                     ; 946             delay_ms(200);
1957  04ec ae00c8        	ldw	x,#200
1958  04ef cd0000        	call	_delay_ms
1960                     ; 947             ms_send_cmd("No Response from Module", strlen((const char *)"No Response from Module"));
1962  04f2 4b17          	push	#23
1963  04f4 ae0014        	ldw	x,#L577
1964  04f7 cd0000        	call	_ms_send_cmd
1966  04fa 84            	pop	a
1967                     ; 948             delay_ms(200);
1969  04fb ae00c8        	ldw	x,#200
1970  04fe cd0000        	call	_delay_ms
1972                     ; 949             ModuleResponding = FALSE;
1974  0501 0f1a          	clr	(OFST+0,sp)
1976                     ; 950             NotRespondingCounter++;
1978  0503 0c19          	inc	(OFST-1,sp)
1980  0505               L377:
1981                     ; 953         delay_ms(200);
1983  0505 ae00c8        	ldw	x,#200
1984  0508 cd0000        	call	_delay_ms
1986                     ; 954     } while (!ModuleResponding && NotRespondingCounter < 10);
1988  050b 0d1a          	tnz	(OFST+0,sp)
1989  050d 2609          	jrne	L777
1991  050f 7b19          	ld	a,(OFST-1,sp)
1992  0511 a10a          	cp	a,#10
1993  0513 2403          	jruge	L07
1994  0515 cc03a4        	jp	L106
1995  0518               L07:
1996  0518               L777:
1997                     ; 956     if (NotRespondingCounter < 10)
1999  0518 7b19          	ld	a,(OFST-1,sp)
2000  051a a10a          	cp	a,#10
2001  051c 2406          	jruge	L1001
2002                     ; 957         IMEIRecievedOKFlag = 1;
2004  051e 35010000      	mov	_IMEIRecievedOKFlag,#1
2006  0522 2002          	jra	L3001
2007  0524               L1001:
2008                     ; 959         IMEIRecievedOKFlag = 0;
2010  0524 3f00          	clr	_IMEIRecievedOKFlag
2011  0526               L3001:
2012                     ; 960     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2014  0526 4b01          	push	#1
2015  0528 ae0255        	ldw	x,#597
2016  052b cd0000        	call	_UART1_ITConfig
2018  052e 84            	pop	a
2019                     ; 961     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2021  052f 4b01          	push	#1
2022  0531 ae0244        	ldw	x,#580
2023  0534 cd0000        	call	_UART1_ITConfig
2025  0537 84            	pop	a
2026                     ; 962 }
2029  0538 5b1a          	addw	sp,#26
2030  053a 81            	ret
2065                     	xdef	_bValidIMEIRecieved
2066                     	xref.b	_IMEIRecievedOKFlag
2067                     	xdef	_vPrintStickerInfo
2068                     	xdef	_vHandle_MQTT
2069                     	xdef	_enGet_TCP_Status
2070                     	xdef	_vClearBuffer
2071                     	xdef	_getIMEI
2072                     	xdef	_checkNum
2073                     	xdef	_SIMComrestart
2074                     	xref	_GSM_OK
2075                     	xdef	_SIMCom_setup
2076                     	xref	_response_buffer
2077                     	xref	_vMQTT_Subscribe
2078                     	xref	_vMQTT_Connect
2079                     	xref	_ms_send_cmd
2080                     	xref	_aunMQTT_Subscribe_Topic
2081                     	xref	_aunMQTT_ClientID
2082                     	xref	_vMevris_Send_Version
2083                     	xref	_vMevris_Send_IMEI
2084                     	xref	_punGet_Client_ID
2085                     	xref	_punGet_Command_Topic
2086                     	xref	_punGet_Event_Topic
2087                     	switch	.ubsct
2088  0000               _PASS_KEY:
2089  0000 000000000000  	ds.b	16
2090                     	xdef	_PASS_KEY
2091  0010               _aunIMEI:
2092  0010 000000000000  	ds.b	20
2093                     	xdef	_aunIMEI
2094                     	xref	_strstr
2095                     	xref.b	_checkit
2096                     	xref	_delay_ms
2097                     	xref	_UART1_GetFlagStatus
2098                     	xref	_UART1_SendData8
2099                     	xref	_UART1_ReceiveData8
2100                     	xref	_UART1_ITConfig
2101                     	xref	_GPIO_WriteLow
2102                     	xref	_GPIO_WriteHigh
2103                     	switch	.const
2104  0014               L577:
2105  0014 4e6f20526573  	dc.b	"No Response from M"
2106  0026 6f64756c6500  	dc.b	"odule",0
2107  002c               L706:
2108  002c 415400        	dc.b	"AT",0
2109  002f               L704:
2110  002f 2b514d54434f  	dc.b	"+QMTCONN:",0
2111  0039               L304:
2112  0039 41542b514d54  	dc.b	"AT+QMTCONN?",0
2113  0045               L351:
2114  0045 41542b47534e  	dc.b	"AT+GSN",0
2115  004c               L101:
2116  004c 41542b434e55  	dc.b	"AT+CNUM",0
2117  0054               L55:
2118  0054 41542b51504f  	dc.b	"AT+QPOWD=1",0
2119  005f               L34:
2120  005f 41542b434741  	dc.b	"AT+CGACT=1,1",0
2121  006c               L14:
2122  006c 41542b434744  	dc.b	"AT+CGDCONT=1,",34
2123  007a 495022        	dc.b	"IP",34
2124  007d 2c22          	dc.b	",",34
2125  007f 5a4f4e475741  	dc.b	"ZONGWAP",34,0
2126  0088               L73:
2127  0088 41542b514346  	dc.b	"AT+QCFG=",34
2128  0091 6e777363616e  	dc.b	"nwscanmode",34
2129  009c 2c302c3100    	dc.b	",0,1",0
2130  00a1               L53:
2131  00a1 41542b434741  	dc.b	"AT+CGATT=1",0
2132  00ac               L33:
2133  00ac 41542b514346  	dc.b	"AT+QCFG=",34
2134  00b5 7572632f7269  	dc.b	"urc/ri/smsincoming"
2135  00c7 222c2270756c  	dc.b	34,44,34,112,117,108
2136  00cd 736522        	dc.b	"se",34
2137  00d0 2c3132302c31  	dc.b	",120,1",0
2138  00d7               L13:
2139  00d7 41542b514346  	dc.b	"AT+QCFG=",34
2140  00e0 7572632f7269  	dc.b	"urc/ri/ring",34
2141  00ec 2c22          	dc.b	",",34
2142  00ee 6f66662200    	dc.b	"off",34,0
2143  00f3               L72:
2144  00f3 41542b514346  	dc.b	"AT+QCFG=",34
2145  00fc 7572632f7269  	dc.b	"urc/ri/other",34
2146  0109 2c22          	dc.b	",",34
2147  010b 6f66662200    	dc.b	"off",34,0
2148  0110               L52:
2149  0110 41542b515343  	dc.b	"AT+QSCLK=0",0
2150  011b               L32:
2151  011b 41542b434d47  	dc.b	"AT+CMGD=1,4",0
2152  0127               L12:
2153  0127 4154453000    	dc.b	"ATE0",0
2154                     	xref.b	c_x
2174                     	xref	c_xymvx
2175                     	end
