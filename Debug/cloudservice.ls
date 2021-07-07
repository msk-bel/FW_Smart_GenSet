   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  14                     	switch	.data
  15  0000               _aunPushed_Data:
  16  0000 00            	dc.b	0
  17  0001 000000000000  	ds.b	99
  18  0064               _aunMQTT_ClientID:
  19  0064 67656e313233  	dc.b	"gen123456789012345",0
  20  0077 00            	ds.b	1
  21  0078               _aunMQTT_Subscribe_Topic:
  22  0078 7363322f3132  	dc.b	"sc2/12345678901234"
  23  008a 352f636f6d6d  	dc.b	"5/command",0
  24  0094 0000          	ds.b	2
  25  0096               _aunMQTT_Publish_Topic:
  26  0096 7363322f3132  	dc.b	"sc2/12345678901234"
  27  00a8 352f6576656e  	dc.b	"5/event",0
  28  00b0 00000000      	ds.b	4
  29                     	bsct
  30  0000               _bCONNACK_Recieved:
  31  0000 00            	dc.b	0
  32  0001               L5_tempCounter:
  33  0001 00            	dc.b	0
  34                     	switch	.ubsct
  35  0000               L3_enSendEventCounter:
  36  0000 00            	ds.b	1
 310                     ; 58 void sendDataToCloud(void)
 310                     ; 59 {
 312                     	switch	.text
 313  0000               _sendDataToCloud:
 315  0000 88            	push	a
 316       00000001      OFST:	set	1
 319                     ; 68     tempCounter++; //Added by Saqib
 321  0001 3c01          	inc	L5_tempCounter
 322                     ; 69     if (tempCounter >= 3)
 324  0003 b601          	ld	a,L5_tempCounter
 325  0005 a103          	cp	a,#3
 326  0007 2403          	jruge	L6
 327  0009 cc00db        	jp	L171
 328  000c               L6:
 329                     ; 71         eTCP_Status = enGet_TCP_Status();
 331  000c cd0000        	call	_enGet_TCP_Status
 333  000f 6b01          	ld	(OFST+0,sp),a
 335                     ; 72         if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
 337  0011 7b01          	ld	a,(OFST+0,sp)
 338  0013 a107          	cp	a,#7
 339  0015 2703          	jreq	L01
 340  0017 cc00d7        	jp	L371
 341  001a               L01:
 343  001a 3d00          	tnz	_IMEIRecievedOKFlag
 344  001c 2603          	jrne	L21
 345  001e cc00d7        	jp	L371
 346  0021               L21:
 347                     ; 74             switch (enSendEventCounter)
 349  0021 b600          	ld	a,L3_enSendEventCounter
 351                     ; 118             default:
 351                     ; 119                 break;
 352  0023 a005          	sub	a,#5
 353  0025 272b          	jreq	L12
 354  0027 4a            	dec	a
 355  0028 2749          	jreq	L32
 356  002a 4a            	dec	a
 357  002b 2767          	jreq	L52
 358  002d 4a            	dec	a
 359  002e 2603cc00b5    	jreq	L72
 360  0033 4a            	dec	a
 361  0034 2603cc00ba    	jreq	L13
 362  0039 4a            	dec	a
 363  003a 2603cc00bf    	jreq	L33
 364  003f 4a            	dec	a
 365  0040 2603cc00c4    	jreq	L53
 366  0045 cc00c7        	jra	L771
 367  0048               L7:
 368                     ; 76             case eCommand_Reserved:
 368                     ; 77                 // enSendEventCounter++;
 368                     ; 78                 break;
 370  0048 207d          	jra	L771
 371  004a               L11:
 372                     ; 79             case eCommand_IMEI:
 372                     ; 80                 // vMevris_Send_IMEI();
 372                     ; 81                 break;
 374  004a 207b          	jra	L771
 375  004c               L31:
 376                     ; 82             case eCommand_SIM_Number:
 376                     ; 83                 // vMevris_Send_SIM_Number();
 376                     ; 84                 break;
 378  004c 2079          	jra	L771
 379  004e               L51:
 380                     ; 85             case eCommand_Location:
 380                     ; 86                 // vMevris_Send_Location();
 380                     ; 87                 break;
 382  004e 2077          	jra	L771
 383  0050               L71:
 384                     ; 88             case eCommand_Version:
 384                     ; 89                 // vMevris_Send_Version();
 384                     ; 90                 break;
 386  0050 2075          	jra	L771
 387  0052               L12:
 388                     ; 91             case eCommand_Phase1:
 388                     ; 92                 // vMevris_Send_Phase1();
 388                     ; 93                 vMevris_Send_Phase(1, Watt_Phase1, Voltage_Phase1, Ampere_Phase1);
 390  0052 ce0002        	ldw	x,_Ampere_Phase1+2
 391  0055 89            	pushw	x
 392  0056 ce0000        	ldw	x,_Ampere_Phase1
 393  0059 89            	pushw	x
 394  005a ce0002        	ldw	x,_Voltage_Phase1+2
 395  005d 89            	pushw	x
 396  005e ce0000        	ldw	x,_Voltage_Phase1
 397  0061 89            	pushw	x
 398  0062 ce0002        	ldw	x,_Watt_Phase1+2
 399  0065 89            	pushw	x
 400  0066 ce0000        	ldw	x,_Watt_Phase1
 401  0069 89            	pushw	x
 402  006a a601          	ld	a,#1
 403  006c cd0374        	call	_vMevris_Send_Phase
 405  006f 5b0c          	addw	sp,#12
 406                     ; 94                 break;
 408  0071 2054          	jra	L771
 409  0073               L32:
 410                     ; 95             case eCommand_Phase2:
 410                     ; 96                 // vMevris_Send_Phase2();
 410                     ; 97                 vMevris_Send_Phase(2, Watt_Phase2, Voltage_Phase2, Ampere_Phase2);
 412  0073 ce0002        	ldw	x,_Ampere_Phase2+2
 413  0076 89            	pushw	x
 414  0077 ce0000        	ldw	x,_Ampere_Phase2
 415  007a 89            	pushw	x
 416  007b ce0002        	ldw	x,_Voltage_Phase2+2
 417  007e 89            	pushw	x
 418  007f ce0000        	ldw	x,_Voltage_Phase2
 419  0082 89            	pushw	x
 420  0083 ce0002        	ldw	x,_Watt_Phase2+2
 421  0086 89            	pushw	x
 422  0087 ce0000        	ldw	x,_Watt_Phase2
 423  008a 89            	pushw	x
 424  008b a602          	ld	a,#2
 425  008d cd0374        	call	_vMevris_Send_Phase
 427  0090 5b0c          	addw	sp,#12
 428                     ; 98                 break;
 430  0092 2033          	jra	L771
 431  0094               L52:
 432                     ; 99             case eCommand_Phase3:
 432                     ; 100                 // vMevris_Send_Phase3();
 432                     ; 101                 vMevris_Send_Phase(3, Watt_Phase3, Voltage_Phase3, Ampere_Phase3);
 434  0094 ce0002        	ldw	x,_Ampere_Phase3+2
 435  0097 89            	pushw	x
 436  0098 ce0000        	ldw	x,_Ampere_Phase3
 437  009b 89            	pushw	x
 438  009c ce0002        	ldw	x,_Voltage_Phase3+2
 439  009f 89            	pushw	x
 440  00a0 ce0000        	ldw	x,_Voltage_Phase3
 441  00a3 89            	pushw	x
 442  00a4 ce0002        	ldw	x,_Watt_Phase3+2
 443  00a7 89            	pushw	x
 444  00a8 ce0000        	ldw	x,_Watt_Phase3
 445  00ab 89            	pushw	x
 446  00ac a603          	ld	a,#3
 447  00ae cd0374        	call	_vMevris_Send_Phase
 449  00b1 5b0c          	addw	sp,#12
 450                     ; 102                 break;
 452  00b3 2012          	jra	L771
 453  00b5               L72:
 454                     ; 103             case eCommand_BatteryVolts:
 454                     ; 104                 vMevris_Send_BatteryVolt();
 456  00b5 cd0597        	call	_vMevris_Send_BatteryVolt
 458                     ; 105                 break;
 460  00b8 200d          	jra	L771
 461  00ba               L13:
 462                     ; 106             case eCommand_RadiatorTemp:
 462                     ; 107                 vMevris_Send_RadiatorTemp();
 464  00ba cd0669        	call	_vMevris_Send_RadiatorTemp
 466                     ; 108                 break;
 468  00bd 2008          	jra	L771
 469  00bf               L33:
 470                     ; 109             case eCommand_EngineTemp:
 470                     ; 110                 vMevris_Send_EngineTemp();
 472  00bf cd0753        	call	_vMevris_Send_EngineTemp
 474                     ; 111                 break;
 476  00c2 2003          	jra	L771
 477  00c4               L53:
 478                     ; 112             case eCommand_FuelLevel:
 478                     ; 113                 vMevris_Send_FuelLevel();
 480  00c4 cd083d        	call	_vMevris_Send_FuelLevel
 482                     ; 114                 break;
 484  00c7               L73:
 485                     ; 115             case eCommand_Others:
 485                     ; 116                 // Do something
 485                     ; 117                 break;
 487  00c7               L14:
 488                     ; 118             default:
 488                     ; 119                 break;
 490  00c7               L771:
 491                     ; 122             enSendEventCounter++;
 493  00c7 3c00          	inc	L3_enSendEventCounter
 494                     ; 123             if (enSendEventCounter >= eCommand_Others)
 496  00c9 b600          	ld	a,L3_enSendEventCounter
 497  00cb a10c          	cp	a,#12
 498  00cd 2504          	jrult	L102
 499                     ; 124                 enSendEventCounter = eCommand_IMEI;
 501  00cf 35010000      	mov	L3_enSendEventCounter,#1
 502  00d3               L102:
 503                     ; 125             tempCounter = 0;
 505  00d3 3f01          	clr	L5_tempCounter
 507  00d5 2004          	jra	L171
 508  00d7               L371:
 509                     ; 129             enSendEventCounter = eCommand_IMEI;
 511  00d7 35010000      	mov	L3_enSendEventCounter,#1
 512  00db               L171:
 513                     ; 132 }
 516  00db 84            	pop	a
 517  00dc 81            	ret
 595                     ; 335 void vHandleMevris_MQTT_Recv_Data(void)
 595                     ; 336 {
 596                     	switch	.text
 597  00dd               _vHandleMevris_MQTT_Recv_Data:
 599  00dd 5225          	subw	sp,#37
 600       00000025      OFST:	set	37
 603                     ; 339     uint8_t i = 0, j;
 605                     ; 340     uint8_t unLength = 0;
 607  00df 0f21          	clr	(OFST-4,sp)
 609                     ; 345     ptr = strstr(response_buffer, "+IPD");
 611  00e1 ae0227        	ldw	x,#L342
 612  00e4 89            	pushw	x
 613  00e5 ae0000        	ldw	x,#_response_buffer
 614  00e8 cd0000        	call	_strstr
 616  00eb 5b02          	addw	sp,#2
 617  00ed 1f23          	ldw	(OFST-2,sp),x
 619                     ; 346     if (ptr)
 621  00ef 1e23          	ldw	x,(OFST-2,sp)
 622  00f1 2603          	jrne	L61
 623  00f3 cc019b        	jp	L542
 624  00f6               L61:
 625                     ; 348         i = 0;
 627  00f6 0f25          	clr	(OFST+0,sp)
 630  00f8 2002          	jra	L352
 631  00fa               L742:
 632                     ; 350             i++;
 635  00fa 0c25          	inc	(OFST+0,sp)
 637  00fc               L352:
 638                     ; 349         while (*(ptr + i) != ':')
 638                     ; 350             i++;
 640  00fc 7b25          	ld	a,(OFST+0,sp)
 641  00fe 5f            	clrw	x
 642  00ff 97            	ld	xl,a
 643  0100 72fb23        	addw	x,(OFST-2,sp)
 644  0103 f6            	ld	a,(x)
 645  0104 a13a          	cp	a,#58
 646  0106 26f2          	jrne	L742
 647                     ; 351         i++;
 649  0108 0c25          	inc	(OFST+0,sp)
 651                     ; 352         if (*(ptr + i) == 0x20) // Check if CONNACK is Recieved
 653  010a 7b25          	ld	a,(OFST+0,sp)
 654  010c 5f            	clrw	x
 655  010d 97            	ld	xl,a
 656  010e 72fb23        	addw	x,(OFST-2,sp)
 657  0111 f6            	ld	a,(x)
 658  0112 a120          	cp	a,#32
 659  0114 260c          	jrne	L752
 660                     ; 354             if (*(ptr + 3) == 0) // If 0x00 Then it means Successfull
 662  0116 1e23          	ldw	x,(OFST-2,sp)
 663  0118 6d03          	tnz	(3,x)
 664  011a 267f          	jrne	L542
 665                     ; 355                 bCONNACK_Recieved = TRUE;
 667  011c 35010000      	mov	_bCONNACK_Recieved,#1
 668  0120 2079          	jra	L542
 669  0122               L752:
 670                     ; 357         else if (*(ptr + i) == 0x30) //Check if Message is a PUBLISH Packet from server
 672  0122 7b25          	ld	a,(OFST+0,sp)
 673  0124 5f            	clrw	x
 674  0125 97            	ld	xl,a
 675  0126 72fb23        	addw	x,(OFST-2,sp)
 676  0129 f6            	ld	a,(x)
 677  012a a130          	cp	a,#48
 678  012c 266d          	jrne	L542
 680  012e 2002          	jra	L172
 681  0130               L762:
 682                     ; 360                 i++;
 684  0130 0c25          	inc	(OFST+0,sp)
 686  0132               L172:
 687                     ; 359             while (*(ptr + i) != '{' && i < 99)
 689  0132 7b25          	ld	a,(OFST+0,sp)
 690  0134 5f            	clrw	x
 691  0135 97            	ld	xl,a
 692  0136 72fb23        	addw	x,(OFST-2,sp)
 693  0139 f6            	ld	a,(x)
 694  013a a17b          	cp	a,#123
 695  013c 2706          	jreq	L572
 697  013e 7b25          	ld	a,(OFST+0,sp)
 698  0140 a163          	cp	a,#99
 699  0142 25ec          	jrult	L762
 700  0144               L572:
 701                     ; 362             if (*(ptr + i) == '{')
 703  0144 7b25          	ld	a,(OFST+0,sp)
 704  0146 5f            	clrw	x
 705  0147 97            	ld	xl,a
 706  0148 72fb23        	addw	x,(OFST-2,sp)
 707  014b f6            	ld	a,(x)
 708  014c a17b          	cp	a,#123
 709  014e 264b          	jrne	L542
 710                     ; 364                 vClearBuffer(localBuffer, 30);
 712  0150 4b1e          	push	#30
 713  0152 96            	ldw	x,sp
 714  0153 1c0004        	addw	x,#OFST-33
 715  0156 cd0000        	call	_vClearBuffer
 717  0159 84            	pop	a
 718                     ; 365                 j = 0;
 720  015a 0f22          	clr	(OFST-3,sp)
 723  015c 2021          	jra	L503
 724  015e               L103:
 725                     ; 368                     localBuffer[j++] = *(ptr + i);
 727  015e 96            	ldw	x,sp
 728  015f 1c0003        	addw	x,#OFST-34
 729  0162 1f01          	ldw	(OFST-36,sp),x
 731  0164 7b22          	ld	a,(OFST-3,sp)
 732  0166 97            	ld	xl,a
 733  0167 0c22          	inc	(OFST-3,sp)
 735  0169 9f            	ld	a,xl
 736  016a 5f            	clrw	x
 737  016b 97            	ld	xl,a
 738  016c 72fb01        	addw	x,(OFST-36,sp)
 739  016f 7b25          	ld	a,(OFST+0,sp)
 740  0171 905f          	clrw	y
 741  0173 9097          	ld	yl,a
 742  0175 72f923        	addw	y,(OFST-2,sp)
 743  0178 90f6          	ld	a,(y)
 744  017a f7            	ld	(x),a
 745                     ; 369                     unLength++;
 747  017b 0c21          	inc	(OFST-4,sp)
 749                     ; 370                     i++;
 751  017d 0c25          	inc	(OFST+0,sp)
 753  017f               L503:
 754                     ; 366                 while (*(ptr + i) != '\r' && j < 29)
 756  017f 7b25          	ld	a,(OFST+0,sp)
 757  0181 5f            	clrw	x
 758  0182 97            	ld	xl,a
 759  0183 72fb23        	addw	x,(OFST-2,sp)
 760  0186 f6            	ld	a,(x)
 761  0187 a10d          	cp	a,#13
 762  0189 2706          	jreq	L113
 764  018b 7b22          	ld	a,(OFST-3,sp)
 765  018d a11d          	cp	a,#29
 766  018f 25cd          	jrult	L103
 767  0191               L113:
 768                     ; 374                 vHandleMevrisRecievedData(localBuffer, unLength);
 770  0191 7b21          	ld	a,(OFST-4,sp)
 771  0193 88            	push	a
 772  0194 96            	ldw	x,sp
 773  0195 1c0004        	addw	x,#OFST-33
 774  0198 ad04          	call	_vHandleMevrisRecievedData
 776  019a 84            	pop	a
 777  019b               L542:
 778                     ; 378 }
 781  019b 5b25          	addw	sp,#37
 782  019d 81            	ret
 820                     ; 380 void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength)
 820                     ; 381 {
 821                     	switch	.text
 822  019e               _vHandleMevrisRecievedData:
 824  019e 89            	pushw	x
 825       00000000      OFST:	set	0
 828                     ; 393     if (strstr(Data, "\"info\"")) //Example "{"info":"imei"}"
 830  019f ae0220        	ldw	x,#L333
 831  01a2 89            	pushw	x
 832  01a3 1e03          	ldw	x,(OFST+3,sp)
 833  01a5 cd0000        	call	_strstr
 835  01a8 5b02          	addw	sp,#2
 836  01aa a30000        	cpw	x,#0
 837  01ad 2713          	jreq	L133
 838                     ; 395         if (strstr(Data, "\"imei\""))
 840  01af ae0219        	ldw	x,#L733
 841  01b2 89            	pushw	x
 842  01b3 1e03          	ldw	x,(OFST+3,sp)
 843  01b5 cd0000        	call	_strstr
 845  01b8 5b02          	addw	sp,#2
 846  01ba a30000        	cpw	x,#0
 847  01bd 2703          	jreq	L133
 848                     ; 397             vMevris_Send_IMEI();
 850  01bf cd0282        	call	_vMevris_Send_IMEI
 852  01c2               L133:
 853                     ; 417 }
 856  01c2 85            	popw	x
 857  01c3 81            	ret
 886                     ; 419 uint8_t *punGet_Client_ID(void)
 886                     ; 420 {
 887                     	switch	.text
 888  01c4               _punGet_Client_ID:
 892                     ; 427     vClearBuffer(aunMQTT_ClientID, 20);
 894  01c4 4b14          	push	#20
 895  01c6 ae0064        	ldw	x,#_aunMQTT_ClientID
 896  01c9 cd0000        	call	_vClearBuffer
 898  01cc 84            	pop	a
 899                     ; 428     strcpy(aunMQTT_ClientID, "gen");
 901  01cd ae0064        	ldw	x,#_aunMQTT_ClientID
 902  01d0 90ae0215      	ldw	y,#L153
 903  01d4               L42:
 904  01d4 90f6          	ld	a,(y)
 905  01d6 905c          	incw	y
 906  01d8 f7            	ld	(x),a
 907  01d9 5c            	incw	x
 908  01da 4d            	tnz	a
 909  01db 26f7          	jrne	L42
 910                     ; 429     strcat(aunMQTT_ClientID, aunIMEI);
 912  01dd ae0000        	ldw	x,#_aunIMEI
 913  01e0 89            	pushw	x
 914  01e1 ae0064        	ldw	x,#_aunMQTT_ClientID
 915  01e4 cd0000        	call	_strcat
 917  01e7 85            	popw	x
 918                     ; 431     return aunMQTT_ClientID;
 920  01e8 ae0064        	ldw	x,#_aunMQTT_ClientID
 923  01eb 81            	ret
 964                     ; 434 uint8_t *punGet_Command_Topic(void)
 964                     ; 435 {
 965                     	switch	.text
 966  01ec               _punGet_Command_Topic:
 968  01ec 88            	push	a
 969       00000001      OFST:	set	1
 972                     ; 436     uint8_t i = 0;
 974                     ; 442     vClearBuffer(aunMQTT_Subscribe_Topic, 30);
 976  01ed 4b1e          	push	#30
 977  01ef ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 978  01f2 cd0000        	call	_vClearBuffer
 980  01f5 84            	pop	a
 981                     ; 443     strcpy(aunMQTT_Subscribe_Topic, MQTT_TOPIC_HEADER);
 983  01f6 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 984  01f9 90ae0211      	ldw	y,#L173
 985  01fd               L03:
 986  01fd 90f6          	ld	a,(y)
 987  01ff 905c          	incw	y
 988  0201 f7            	ld	(x),a
 989  0202 5c            	incw	x
 990  0203 4d            	tnz	a
 991  0204 26f7          	jrne	L03
 992                     ; 444     strcat(aunMQTT_Subscribe_Topic, "/");
 994  0206 ae020f        	ldw	x,#L373
 995  0209 89            	pushw	x
 996  020a ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 997  020d cd0000        	call	_strcat
 999  0210 85            	popw	x
1000                     ; 445     strcat(aunMQTT_Subscribe_Topic, aunIMEI);
1002  0211 ae0000        	ldw	x,#_aunIMEI
1003  0214 89            	pushw	x
1004  0215 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1005  0218 cd0000        	call	_strcat
1007  021b 85            	popw	x
1008                     ; 446     strcat(aunMQTT_Subscribe_Topic, "/");
1010  021c ae020f        	ldw	x,#L373
1011  021f 89            	pushw	x
1012  0220 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1013  0223 cd0000        	call	_strcat
1015  0226 85            	popw	x
1016                     ; 447     strcat(aunMQTT_Subscribe_Topic, MQTT_INBOUND_TOPIC_FOOTER);
1018  0227 ae0207        	ldw	x,#L573
1019  022a 89            	pushw	x
1020  022b ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1021  022e cd0000        	call	_strcat
1023  0231 85            	popw	x
1024                     ; 449     return aunMQTT_Subscribe_Topic;
1026  0232 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1029  0235 84            	pop	a
1030  0236 81            	ret
1070                     ; 452 uint8_t *punGet_Event_Topic(void)
1070                     ; 453 {
1071                     	switch	.text
1072  0237               _punGet_Event_Topic:
1074  0237 88            	push	a
1075       00000001      OFST:	set	1
1078                     ; 454     uint8_t i = 0;
1080                     ; 460     vClearBuffer(aunMQTT_Publish_Topic, 30);
1082  0238 4b1e          	push	#30
1083  023a ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1084  023d cd0000        	call	_vClearBuffer
1086  0240 84            	pop	a
1087                     ; 461     strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
1089  0241 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1090  0244 90ae0211      	ldw	y,#L173
1091  0248               L43:
1092  0248 90f6          	ld	a,(y)
1093  024a 905c          	incw	y
1094  024c f7            	ld	(x),a
1095  024d 5c            	incw	x
1096  024e 4d            	tnz	a
1097  024f 26f7          	jrne	L43
1098                     ; 462     strcat(aunMQTT_Publish_Topic, "/");
1100  0251 ae020f        	ldw	x,#L373
1101  0254 89            	pushw	x
1102  0255 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1103  0258 cd0000        	call	_strcat
1105  025b 85            	popw	x
1106                     ; 463     strcat(aunMQTT_Publish_Topic, aunIMEI);
1108  025c ae0000        	ldw	x,#_aunIMEI
1109  025f 89            	pushw	x
1110  0260 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1111  0263 cd0000        	call	_strcat
1113  0266 85            	popw	x
1114                     ; 464     strcat(aunMQTT_Publish_Topic, "/");
1116  0267 ae020f        	ldw	x,#L373
1117  026a 89            	pushw	x
1118  026b ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1119  026e cd0000        	call	_strcat
1121  0271 85            	popw	x
1122                     ; 465     strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);
1124  0272 ae0201        	ldw	x,#L514
1125  0275 89            	pushw	x
1126  0276 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1127  0279 cd0000        	call	_strcat
1129  027c 85            	popw	x
1130                     ; 467     return aunMQTT_Publish_Topic;
1132  027d ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1135  0280 84            	pop	a
1136  0281 81            	ret
1139                     .const:	section	.text
1140  0000               L714_localBuffer:
1141  0000 7b22          	dc.b	"{",34
1142  0002 696d656922    	dc.b	"imei",34
1143  0007 3a22          	dc.b	":",34
1144  0009 313233343536  	dc.b	"123456789012345",34
1145  0019 7d00          	dc.b	"}",0
1146  001b 000000        	ds.b	3
1196                     ; 471 void vMevris_Send_IMEI(void)
1196                     ; 472 {
1197                     	switch	.text
1198  0282               _vMevris_Send_IMEI:
1200  0282 521f          	subw	sp,#31
1201       0000001f      OFST:	set	31
1204                     ; 473     uint8_t localBuffer[30] = "{\"imei\":\"123456789012345\"}";
1206  0284 96            	ldw	x,sp
1207  0285 1c0002        	addw	x,#OFST-29
1208  0288 90ae0000      	ldw	y,#L714_localBuffer
1209  028c a61e          	ld	a,#30
1210  028e cd0000        	call	c_xymvx
1212                     ; 474     uint8_t unSendDataLength = 0;
1214                     ; 475     vClearBuffer(localBuffer, 30);
1216  0291 4b1e          	push	#30
1217  0293 96            	ldw	x,sp
1218  0294 1c0003        	addw	x,#OFST-28
1219  0297 cd0000        	call	_vClearBuffer
1221  029a 84            	pop	a
1222                     ; 476     strcpy(localBuffer, "{\"imei\":\"");
1224  029b 96            	ldw	x,sp
1225  029c 1c0002        	addw	x,#OFST-29
1226  029f 90ae01f7      	ldw	y,#L344
1227  02a3               L04:
1228  02a3 90f6          	ld	a,(y)
1229  02a5 905c          	incw	y
1230  02a7 f7            	ld	(x),a
1231  02a8 5c            	incw	x
1232  02a9 4d            	tnz	a
1233  02aa 26f7          	jrne	L04
1234                     ; 477     strcat(localBuffer, aunIMEI);
1236  02ac ae0000        	ldw	x,#_aunIMEI
1237  02af 89            	pushw	x
1238  02b0 96            	ldw	x,sp
1239  02b1 1c0004        	addw	x,#OFST-27
1240  02b4 cd0000        	call	_strcat
1242  02b7 85            	popw	x
1243                     ; 478     strcat(localBuffer, "\"}");
1245  02b8 ae01f4        	ldw	x,#L544
1246  02bb 89            	pushw	x
1247  02bc 96            	ldw	x,sp
1248  02bd 1c0004        	addw	x,#OFST-27
1249  02c0 cd0000        	call	_strcat
1251  02c3 85            	popw	x
1252                     ; 479     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1254  02c4 4b64          	push	#100
1255  02c6 ae0000        	ldw	x,#_aunPushed_Data
1256  02c9 cd0000        	call	_vClearBuffer
1258  02cc 84            	pop	a
1259                     ; 480     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1259                     ; 481                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
1259                     ; 482                                                localBuffer);
1261  02cd 96            	ldw	x,sp
1262  02ce 1c0002        	addw	x,#OFST-29
1263  02d1 89            	pushw	x
1264  02d2 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1265  02d5 89            	pushw	x
1266  02d6 ae0000        	ldw	x,#_aunPushed_Data
1267  02d9 cd0000        	call	_ulMQTT_Publish
1269  02dc 5b04          	addw	sp,#4
1270  02de b603          	ld	a,c_lreg+3
1271  02e0 6b01          	ld	(OFST-30,sp),a
1273                     ; 483     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1275  02e2 7b01          	ld	a,(OFST-30,sp)
1276  02e4 88            	push	a
1277  02e5 ae0000        	ldw	x,#_aunPushed_Data
1278  02e8 cd0000        	call	_bSendDataOverTCP
1280  02eb 84            	pop	a
1281                     ; 484 }
1284  02ec 5b1f          	addw	sp,#31
1285  02ee 81            	ret
1288                     	switch	.const
1289  001e               L744_localBuffer:
1290  001e 7b22          	dc.b	"{",34
1291  0020 667722        	dc.b	"fw",34
1292  0023 3a22          	dc.b	":",34
1293  0025 322e342e3031  	dc.b	"2.4.010",34
1294  002d 2c22          	dc.b	",",34
1295  002f 687722        	dc.b	"hw",34
1296  0032 3a22          	dc.b	":",34
1297  0034 302e302e3030  	dc.b	"0.0.001",34
1298  003c 7d00          	dc.b	"}",0
1299  003e 000000        	ds.b	3
1349                     ; 519 void vMevris_Send_Version()
1349                     ; 520 {
1350                     	switch	.text
1351  02ef               _vMevris_Send_Version:
1353  02ef 5224          	subw	sp,#36
1354       00000024      OFST:	set	36
1357                     ; 521     uint8_t localBuffer[35] = "{\"fw\":\"2.4.010\",\"hw\":\"0.0.001\"}";
1359  02f1 96            	ldw	x,sp
1360  02f2 1c0002        	addw	x,#OFST-34
1361  02f5 90ae001e      	ldw	y,#L744_localBuffer
1362  02f9 a623          	ld	a,#35
1363  02fb cd0000        	call	c_xymvx
1365                     ; 522     uint8_t unSendDataLength = 0;
1367                     ; 523     vClearBuffer(localBuffer, 35);
1369  02fe 4b23          	push	#35
1370  0300 96            	ldw	x,sp
1371  0301 1c0003        	addw	x,#OFST-33
1372  0304 cd0000        	call	_vClearBuffer
1374  0307 84            	pop	a
1375                     ; 524     strcpy(localBuffer, "{\"fw\":\"");
1377  0308 96            	ldw	x,sp
1378  0309 1c0002        	addw	x,#OFST-34
1379  030c 90ae01ec      	ldw	y,#L374
1380  0310               L44:
1381  0310 90f6          	ld	a,(y)
1382  0312 905c          	incw	y
1383  0314 f7            	ld	(x),a
1384  0315 5c            	incw	x
1385  0316 4d            	tnz	a
1386  0317 26f7          	jrne	L44
1387                     ; 525     strcat(localBuffer, /*"2.4.010"*/ Firmware_Version);
1389  0319 ae01e4        	ldw	x,#L574
1390  031c 89            	pushw	x
1391  031d 96            	ldw	x,sp
1392  031e 1c0004        	addw	x,#OFST-32
1393  0321 cd0000        	call	_strcat
1395  0324 85            	popw	x
1396                     ; 526     strcat(localBuffer, "\",\"hw\":\"");
1398  0325 ae01db        	ldw	x,#L774
1399  0328 89            	pushw	x
1400  0329 96            	ldw	x,sp
1401  032a 1c0004        	addw	x,#OFST-32
1402  032d cd0000        	call	_strcat
1404  0330 85            	popw	x
1405                     ; 527     strcat(localBuffer, /*"0.0.001"*/ Hardware_Version);
1407  0331 ae01d3        	ldw	x,#L105
1408  0334 89            	pushw	x
1409  0335 96            	ldw	x,sp
1410  0336 1c0004        	addw	x,#OFST-32
1411  0339 cd0000        	call	_strcat
1413  033c 85            	popw	x
1414                     ; 528     strcat(localBuffer, "\"}");
1416  033d ae01f4        	ldw	x,#L544
1417  0340 89            	pushw	x
1418  0341 96            	ldw	x,sp
1419  0342 1c0004        	addw	x,#OFST-32
1420  0345 cd0000        	call	_strcat
1422  0348 85            	popw	x
1423                     ; 529     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1425  0349 4b64          	push	#100
1426  034b ae0000        	ldw	x,#_aunPushed_Data
1427  034e cd0000        	call	_vClearBuffer
1429  0351 84            	pop	a
1430                     ; 530     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1430                     ; 531                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
1430                     ; 532                                                localBuffer);
1432  0352 96            	ldw	x,sp
1433  0353 1c0002        	addw	x,#OFST-34
1434  0356 89            	pushw	x
1435  0357 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1436  035a 89            	pushw	x
1437  035b ae0000        	ldw	x,#_aunPushed_Data
1438  035e cd0000        	call	_ulMQTT_Publish
1440  0361 5b04          	addw	sp,#4
1441  0363 b603          	ld	a,c_lreg+3
1442  0365 6b01          	ld	(OFST-35,sp),a
1444                     ; 533     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1446  0367 7b01          	ld	a,(OFST-35,sp)
1447  0369 88            	push	a
1448  036a ae0000        	ldw	x,#_aunPushed_Data
1449  036d cd0000        	call	_bSendDataOverTCP
1451  0370 84            	pop	a
1452                     ; 534 }
1455  0371 5b24          	addw	sp,#36
1456  0373 81            	ret
1459                     	switch	.const
1460  0041               L305_localBuffer:
1461  0041 7b22          	dc.b	"{",34
1462  0043 706f77657231  	dc.b	"power1",34
1463  004a 3a22          	dc.b	":",34
1464  004c 313233343536  	dc.b	"123456890.23",34
1465  0059 2c22          	dc.b	",",34
1466  005b 766f6c746167  	dc.b	"voltage1",34
1467  0064 3a22          	dc.b	":",34
1468  0066 3132332e3536  	dc.b	"123.56",34
1469  006d 2c22          	dc.b	",",34
1470  006f 63757272656e  	dc.b	"current1",34
1471  0078 3a22          	dc.b	":",34
1472  007a 31323334352e  	dc.b	"12345.78",34
1473  0083 7d00          	dc.b	"}",0
1474  0085 000000000000  	ds.b	7
1475  008c               L505_temp1:
1476  008c 00            	dc.b	0
1477  008d 000000000000  	ds.b	11
1478  0098               L705_phase_num:
1479  0098 00            	dc.b	0
1480  0099 0000          	ds.b	2
1586                     	switch	.const
1587  009b               L25:
1588  009b 00000064      	dc.l	100
1589                     ; 536 void vMevris_Send_Phase(uint8_t phase_number, uint32_t Watt, uint32_t Voltage, uint32_t Ampere)
1589                     ; 537 {
1590                     	switch	.text
1591  0374               _vMevris_Send_Phase:
1593  0374 88            	push	a
1594  0375 525b          	subw	sp,#91
1595       0000005b      OFST:	set	91
1598                     ; 538     uint8_t localBuffer[75] = "{\"power1\":\"123456890.23\",\"voltage1\":\"123.56\",\"current1\":\"12345.78\"}";
1600  0377 96            	ldw	x,sp
1601  0378 1c0011        	addw	x,#OFST-74
1602  037b 90ae0041      	ldw	y,#L305_localBuffer
1603  037f a64b          	ld	a,#75
1604  0381 cd0000        	call	c_xymvx
1606                     ; 539     uint8_t unSendDataLength = 0;
1608                     ; 540     uint8_t temp1[12] = "";
1610  0384 96            	ldw	x,sp
1611  0385 1c0005        	addw	x,#OFST-86
1612  0388 90ae008c      	ldw	y,#L505_temp1
1613  038c a60c          	ld	a,#12
1614  038e cd0000        	call	c_xymvx
1616                     ; 541     uint8_t phase_num[3] = "";
1618  0391 96            	ldw	x,sp
1619  0392 1c0002        	addw	x,#OFST-89
1620  0395 90ae0098      	ldw	y,#L705_phase_num
1621  0399 a603          	ld	a,#3
1622  039b cd0000        	call	c_xymvx
1624                     ; 542     vClearBuffer(localBuffer, 55);
1626  039e 4b37          	push	#55
1627  03a0 96            	ldw	x,sp
1628  03a1 1c0012        	addw	x,#OFST-73
1629  03a4 cd0000        	call	_vClearBuffer
1631  03a7 84            	pop	a
1632                     ; 543     sprintf(phase_num, "%d", (uint16_t)phase_number);
1634  03a8 7b5c          	ld	a,(OFST+1,sp)
1635  03aa 5f            	clrw	x
1636  03ab 97            	ld	xl,a
1637  03ac 89            	pushw	x
1638  03ad ae01d0        	ldw	x,#L365
1639  03b0 89            	pushw	x
1640  03b1 96            	ldw	x,sp
1641  03b2 1c0006        	addw	x,#OFST-85
1642  03b5 cd0000        	call	_sprintf
1644  03b8 5b04          	addw	sp,#4
1645                     ; 544     strcpy(localBuffer, "{\"power");
1647  03ba 96            	ldw	x,sp
1648  03bb 1c0011        	addw	x,#OFST-74
1649  03be 90ae01c8      	ldw	y,#L565
1650  03c2               L05:
1651  03c2 90f6          	ld	a,(y)
1652  03c4 905c          	incw	y
1653  03c6 f7            	ld	(x),a
1654  03c7 5c            	incw	x
1655  03c8 4d            	tnz	a
1656  03c9 26f7          	jrne	L05
1657                     ; 545     strcat(localBuffer, phase_num);
1659  03cb 96            	ldw	x,sp
1660  03cc 1c0002        	addw	x,#OFST-89
1661  03cf 89            	pushw	x
1662  03d0 96            	ldw	x,sp
1663  03d1 1c0013        	addw	x,#OFST-72
1664  03d4 cd0000        	call	_strcat
1666  03d7 85            	popw	x
1667                     ; 546     strcat(localBuffer, "\":\"");
1669  03d8 ae01c4        	ldw	x,#L765
1670  03db 89            	pushw	x
1671  03dc 96            	ldw	x,sp
1672  03dd 1c0013        	addw	x,#OFST-72
1673  03e0 cd0000        	call	_strcat
1675  03e3 85            	popw	x
1676                     ; 547     sprintf(temp1, "%ld", Watt / 100);
1678  03e4 96            	ldw	x,sp
1679  03e5 1c005f        	addw	x,#OFST+4
1680  03e8 cd0000        	call	c_ltor
1682  03eb ae009b        	ldw	x,#L25
1683  03ee cd0000        	call	c_ludv
1685  03f1 be02          	ldw	x,c_lreg+2
1686  03f3 89            	pushw	x
1687  03f4 be00          	ldw	x,c_lreg
1688  03f6 89            	pushw	x
1689  03f7 ae01c0        	ldw	x,#L175
1690  03fa 89            	pushw	x
1691  03fb 96            	ldw	x,sp
1692  03fc 1c000b        	addw	x,#OFST-80
1693  03ff cd0000        	call	_sprintf
1695  0402 5b06          	addw	sp,#6
1696                     ; 548     strcat(localBuffer, temp1);
1698  0404 96            	ldw	x,sp
1699  0405 1c0005        	addw	x,#OFST-86
1700  0408 89            	pushw	x
1701  0409 96            	ldw	x,sp
1702  040a 1c0013        	addw	x,#OFST-72
1703  040d cd0000        	call	_strcat
1705  0410 85            	popw	x
1706                     ; 549     strcat(localBuffer, ".");
1708  0411 ae01be        	ldw	x,#L375
1709  0414 89            	pushw	x
1710  0415 96            	ldw	x,sp
1711  0416 1c0013        	addw	x,#OFST-72
1712  0419 cd0000        	call	_strcat
1714  041c 85            	popw	x
1715                     ; 550     sprintf(temp1, "%ld", Watt % 100);
1717  041d 96            	ldw	x,sp
1718  041e 1c005f        	addw	x,#OFST+4
1719  0421 cd0000        	call	c_ltor
1721  0424 ae009b        	ldw	x,#L25
1722  0427 cd0000        	call	c_lumd
1724  042a be02          	ldw	x,c_lreg+2
1725  042c 89            	pushw	x
1726  042d be00          	ldw	x,c_lreg
1727  042f 89            	pushw	x
1728  0430 ae01c0        	ldw	x,#L175
1729  0433 89            	pushw	x
1730  0434 96            	ldw	x,sp
1731  0435 1c000b        	addw	x,#OFST-80
1732  0438 cd0000        	call	_sprintf
1734  043b 5b06          	addw	sp,#6
1735                     ; 551     strcat(localBuffer, temp1);
1737  043d 96            	ldw	x,sp
1738  043e 1c0005        	addw	x,#OFST-86
1739  0441 89            	pushw	x
1740  0442 96            	ldw	x,sp
1741  0443 1c0013        	addw	x,#OFST-72
1742  0446 cd0000        	call	_strcat
1744  0449 85            	popw	x
1745                     ; 553     strcat(localBuffer, "\",\"voltage");
1747  044a ae01b3        	ldw	x,#L575
1748  044d 89            	pushw	x
1749  044e 96            	ldw	x,sp
1750  044f 1c0013        	addw	x,#OFST-72
1751  0452 cd0000        	call	_strcat
1753  0455 85            	popw	x
1754                     ; 554     strcat(localBuffer, phase_num);
1756  0456 96            	ldw	x,sp
1757  0457 1c0002        	addw	x,#OFST-89
1758  045a 89            	pushw	x
1759  045b 96            	ldw	x,sp
1760  045c 1c0013        	addw	x,#OFST-72
1761  045f cd0000        	call	_strcat
1763  0462 85            	popw	x
1764                     ; 555     strcat(localBuffer, "\":\"");
1766  0463 ae01c4        	ldw	x,#L765
1767  0466 89            	pushw	x
1768  0467 96            	ldw	x,sp
1769  0468 1c0013        	addw	x,#OFST-72
1770  046b cd0000        	call	_strcat
1772  046e 85            	popw	x
1773                     ; 556     sprintf(temp1, "%ld", Voltage / 100);
1775  046f 96            	ldw	x,sp
1776  0470 1c0063        	addw	x,#OFST+8
1777  0473 cd0000        	call	c_ltor
1779  0476 ae009b        	ldw	x,#L25
1780  0479 cd0000        	call	c_ludv
1782  047c be02          	ldw	x,c_lreg+2
1783  047e 89            	pushw	x
1784  047f be00          	ldw	x,c_lreg
1785  0481 89            	pushw	x
1786  0482 ae01c0        	ldw	x,#L175
1787  0485 89            	pushw	x
1788  0486 96            	ldw	x,sp
1789  0487 1c000b        	addw	x,#OFST-80
1790  048a cd0000        	call	_sprintf
1792  048d 5b06          	addw	sp,#6
1793                     ; 557     strcat(localBuffer, temp1);
1795  048f 96            	ldw	x,sp
1796  0490 1c0005        	addw	x,#OFST-86
1797  0493 89            	pushw	x
1798  0494 96            	ldw	x,sp
1799  0495 1c0013        	addw	x,#OFST-72
1800  0498 cd0000        	call	_strcat
1802  049b 85            	popw	x
1803                     ; 558     strcat(localBuffer, ".");
1805  049c ae01be        	ldw	x,#L375
1806  049f 89            	pushw	x
1807  04a0 96            	ldw	x,sp
1808  04a1 1c0013        	addw	x,#OFST-72
1809  04a4 cd0000        	call	_strcat
1811  04a7 85            	popw	x
1812                     ; 559     sprintf(temp1, "%ld", Voltage % 100);
1814  04a8 96            	ldw	x,sp
1815  04a9 1c0063        	addw	x,#OFST+8
1816  04ac cd0000        	call	c_ltor
1818  04af ae009b        	ldw	x,#L25
1819  04b2 cd0000        	call	c_lumd
1821  04b5 be02          	ldw	x,c_lreg+2
1822  04b7 89            	pushw	x
1823  04b8 be00          	ldw	x,c_lreg
1824  04ba 89            	pushw	x
1825  04bb ae01c0        	ldw	x,#L175
1826  04be 89            	pushw	x
1827  04bf 96            	ldw	x,sp
1828  04c0 1c000b        	addw	x,#OFST-80
1829  04c3 cd0000        	call	_sprintf
1831  04c6 5b06          	addw	sp,#6
1832                     ; 560     strcat(localBuffer, temp1);
1834  04c8 96            	ldw	x,sp
1835  04c9 1c0005        	addw	x,#OFST-86
1836  04cc 89            	pushw	x
1837  04cd 96            	ldw	x,sp
1838  04ce 1c0013        	addw	x,#OFST-72
1839  04d1 cd0000        	call	_strcat
1841  04d4 85            	popw	x
1842                     ; 562     strcat(localBuffer, "\",\"current");
1844  04d5 ae01a8        	ldw	x,#L775
1845  04d8 89            	pushw	x
1846  04d9 96            	ldw	x,sp
1847  04da 1c0013        	addw	x,#OFST-72
1848  04dd cd0000        	call	_strcat
1850  04e0 85            	popw	x
1851                     ; 563     strcat(localBuffer, phase_num);
1853  04e1 96            	ldw	x,sp
1854  04e2 1c0002        	addw	x,#OFST-89
1855  04e5 89            	pushw	x
1856  04e6 96            	ldw	x,sp
1857  04e7 1c0013        	addw	x,#OFST-72
1858  04ea cd0000        	call	_strcat
1860  04ed 85            	popw	x
1861                     ; 564     strcat(localBuffer, "\":\"");
1863  04ee ae01c4        	ldw	x,#L765
1864  04f1 89            	pushw	x
1865  04f2 96            	ldw	x,sp
1866  04f3 1c0013        	addw	x,#OFST-72
1867  04f6 cd0000        	call	_strcat
1869  04f9 85            	popw	x
1870                     ; 565     sprintf(temp1, "%ld", Ampere / 100);
1872  04fa 96            	ldw	x,sp
1873  04fb 1c0067        	addw	x,#OFST+12
1874  04fe cd0000        	call	c_ltor
1876  0501 ae009b        	ldw	x,#L25
1877  0504 cd0000        	call	c_ludv
1879  0507 be02          	ldw	x,c_lreg+2
1880  0509 89            	pushw	x
1881  050a be00          	ldw	x,c_lreg
1882  050c 89            	pushw	x
1883  050d ae01c0        	ldw	x,#L175
1884  0510 89            	pushw	x
1885  0511 96            	ldw	x,sp
1886  0512 1c000b        	addw	x,#OFST-80
1887  0515 cd0000        	call	_sprintf
1889  0518 5b06          	addw	sp,#6
1890                     ; 566     strcat(localBuffer, temp1);
1892  051a 96            	ldw	x,sp
1893  051b 1c0005        	addw	x,#OFST-86
1894  051e 89            	pushw	x
1895  051f 96            	ldw	x,sp
1896  0520 1c0013        	addw	x,#OFST-72
1897  0523 cd0000        	call	_strcat
1899  0526 85            	popw	x
1900                     ; 567     strcat(localBuffer, ".");
1902  0527 ae01be        	ldw	x,#L375
1903  052a 89            	pushw	x
1904  052b 96            	ldw	x,sp
1905  052c 1c0013        	addw	x,#OFST-72
1906  052f cd0000        	call	_strcat
1908  0532 85            	popw	x
1909                     ; 568     sprintf(temp1, "%ld", Ampere % 100);
1911  0533 96            	ldw	x,sp
1912  0534 1c0067        	addw	x,#OFST+12
1913  0537 cd0000        	call	c_ltor
1915  053a ae009b        	ldw	x,#L25
1916  053d cd0000        	call	c_lumd
1918  0540 be02          	ldw	x,c_lreg+2
1919  0542 89            	pushw	x
1920  0543 be00          	ldw	x,c_lreg
1921  0545 89            	pushw	x
1922  0546 ae01c0        	ldw	x,#L175
1923  0549 89            	pushw	x
1924  054a 96            	ldw	x,sp
1925  054b 1c000b        	addw	x,#OFST-80
1926  054e cd0000        	call	_sprintf
1928  0551 5b06          	addw	sp,#6
1929                     ; 569     strcat(localBuffer, temp1);
1931  0553 96            	ldw	x,sp
1932  0554 1c0005        	addw	x,#OFST-86
1933  0557 89            	pushw	x
1934  0558 96            	ldw	x,sp
1935  0559 1c0013        	addw	x,#OFST-72
1936  055c cd0000        	call	_strcat
1938  055f 85            	popw	x
1939                     ; 570     strcat(localBuffer, "\"}");
1941  0560 ae01f4        	ldw	x,#L544
1942  0563 89            	pushw	x
1943  0564 96            	ldw	x,sp
1944  0565 1c0013        	addw	x,#OFST-72
1945  0568 cd0000        	call	_strcat
1947  056b 85            	popw	x
1948                     ; 572     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1950  056c 4b64          	push	#100
1951  056e ae0000        	ldw	x,#_aunPushed_Data
1952  0571 cd0000        	call	_vClearBuffer
1954  0574 84            	pop	a
1955                     ; 573     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1955                     ; 574                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
1955                     ; 575                                                localBuffer);
1957  0575 96            	ldw	x,sp
1958  0576 1c0011        	addw	x,#OFST-74
1959  0579 89            	pushw	x
1960  057a ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1961  057d 89            	pushw	x
1962  057e ae0000        	ldw	x,#_aunPushed_Data
1963  0581 cd0000        	call	_ulMQTT_Publish
1965  0584 5b04          	addw	sp,#4
1966  0586 b603          	ld	a,c_lreg+3
1967  0588 6b01          	ld	(OFST-90,sp),a
1969                     ; 576     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1971  058a 7b01          	ld	a,(OFST-90,sp)
1972  058c 88            	push	a
1973  058d ae0000        	ldw	x,#_aunPushed_Data
1974  0590 cd0000        	call	_bSendDataOverTCP
1976  0593 84            	pop	a
1977                     ; 577 }
1980  0594 5b5c          	addw	sp,#92
1981  0596 81            	ret
1984                     	switch	.const
1985  009f               L106_localBuffer:
1986  009f 7b22          	dc.b	"{",34
1987  00a1 626174746572  	dc.b	"battery",34
1988  00a9 3a22          	dc.b	":",34
1989  00ab 313233343536  	dc.b	"123456.89",34
1990  00b5 7d00          	dc.b	"}",0
1991  00b7 000000000000  	ds.b	6
1992  00bd               L306_temp1:
1993  00bd 00            	dc.b	0
1994  00be 000000000000  	ds.b	9
2056                     ; 687 void vMevris_Send_BatteryVolt()
2056                     ; 688 {
2057                     	switch	.text
2058  0597               _vMevris_Send_BatteryVolt:
2060  0597 5229          	subw	sp,#41
2061       00000029      OFST:	set	41
2064                     ; 689     uint8_t localBuffer[30] = "{\"battery\":\"123456.89\"}";
2066  0599 96            	ldw	x,sp
2067  059a 1c000c        	addw	x,#OFST-29
2068  059d 90ae009f      	ldw	y,#L106_localBuffer
2069  05a1 a61e          	ld	a,#30
2070  05a3 cd0000        	call	c_xymvx
2072                     ; 690     uint8_t unSendDataLength = 0;
2074                     ; 691     uint8_t temp1[10] = "";
2076  05a6 96            	ldw	x,sp
2077  05a7 1c0002        	addw	x,#OFST-39
2078  05aa 90ae00bd      	ldw	y,#L306_temp1
2079  05ae a60a          	ld	a,#10
2080  05b0 cd0000        	call	c_xymvx
2082                     ; 692     vClearBuffer(localBuffer, 30);
2084  05b3 4b1e          	push	#30
2085  05b5 96            	ldw	x,sp
2086  05b6 1c000d        	addw	x,#OFST-28
2087  05b9 cd0000        	call	_vClearBuffer
2089  05bc 84            	pop	a
2090                     ; 693     strcpy(localBuffer, "{\"battery\":\"");
2092  05bd 96            	ldw	x,sp
2093  05be 1c000c        	addw	x,#OFST-29
2094  05c1 90ae019b      	ldw	y,#L336
2095  05c5               L65:
2096  05c5 90f6          	ld	a,(y)
2097  05c7 905c          	incw	y
2098  05c9 f7            	ld	(x),a
2099  05ca 5c            	incw	x
2100  05cb 4d            	tnz	a
2101  05cc 26f7          	jrne	L65
2102                     ; 695     sprintf(temp1, "%ld", batVolt / 100);
2104  05ce ae0000        	ldw	x,#_batVolt
2105  05d1 cd0000        	call	c_ltor
2107  05d4 ae009b        	ldw	x,#L25
2108  05d7 cd0000        	call	c_ludv
2110  05da be02          	ldw	x,c_lreg+2
2111  05dc 89            	pushw	x
2112  05dd be00          	ldw	x,c_lreg
2113  05df 89            	pushw	x
2114  05e0 ae01c0        	ldw	x,#L175
2115  05e3 89            	pushw	x
2116  05e4 96            	ldw	x,sp
2117  05e5 1c0008        	addw	x,#OFST-33
2118  05e8 cd0000        	call	_sprintf
2120  05eb 5b06          	addw	sp,#6
2121                     ; 696     strcat(localBuffer, temp1);
2123  05ed 96            	ldw	x,sp
2124  05ee 1c0002        	addw	x,#OFST-39
2125  05f1 89            	pushw	x
2126  05f2 96            	ldw	x,sp
2127  05f3 1c000e        	addw	x,#OFST-27
2128  05f6 cd0000        	call	_strcat
2130  05f9 85            	popw	x
2131                     ; 697     strcat(localBuffer, ".");
2133  05fa ae01be        	ldw	x,#L375
2134  05fd 89            	pushw	x
2135  05fe 96            	ldw	x,sp
2136  05ff 1c000e        	addw	x,#OFST-27
2137  0602 cd0000        	call	_strcat
2139  0605 85            	popw	x
2140                     ; 698     sprintf(temp1, "%ld", batVolt % 100);
2142  0606 ae0000        	ldw	x,#_batVolt
2143  0609 cd0000        	call	c_ltor
2145  060c ae009b        	ldw	x,#L25
2146  060f cd0000        	call	c_lumd
2148  0612 be02          	ldw	x,c_lreg+2
2149  0614 89            	pushw	x
2150  0615 be00          	ldw	x,c_lreg
2151  0617 89            	pushw	x
2152  0618 ae01c0        	ldw	x,#L175
2153  061b 89            	pushw	x
2154  061c 96            	ldw	x,sp
2155  061d 1c0008        	addw	x,#OFST-33
2156  0620 cd0000        	call	_sprintf
2158  0623 5b06          	addw	sp,#6
2159                     ; 699     strcat(localBuffer, temp1);
2161  0625 96            	ldw	x,sp
2162  0626 1c0002        	addw	x,#OFST-39
2163  0629 89            	pushw	x
2164  062a 96            	ldw	x,sp
2165  062b 1c000e        	addw	x,#OFST-27
2166  062e cd0000        	call	_strcat
2168  0631 85            	popw	x
2169                     ; 700     strcat(localBuffer, "\"}");
2171  0632 ae01f4        	ldw	x,#L544
2172  0635 89            	pushw	x
2173  0636 96            	ldw	x,sp
2174  0637 1c000e        	addw	x,#OFST-27
2175  063a cd0000        	call	_strcat
2177  063d 85            	popw	x
2178                     ; 701     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2180  063e 4b64          	push	#100
2181  0640 ae0000        	ldw	x,#_aunPushed_Data
2182  0643 cd0000        	call	_vClearBuffer
2184  0646 84            	pop	a
2185                     ; 702     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2185                     ; 703                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2185                     ; 704                                                localBuffer);
2187  0647 96            	ldw	x,sp
2188  0648 1c000c        	addw	x,#OFST-29
2189  064b 89            	pushw	x
2190  064c ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2191  064f 89            	pushw	x
2192  0650 ae0000        	ldw	x,#_aunPushed_Data
2193  0653 cd0000        	call	_ulMQTT_Publish
2195  0656 5b04          	addw	sp,#4
2196  0658 b603          	ld	a,c_lreg+3
2197  065a 6b01          	ld	(OFST-40,sp),a
2199                     ; 705     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2201  065c 7b01          	ld	a,(OFST-40,sp)
2202  065e 88            	push	a
2203  065f ae0000        	ldw	x,#_aunPushed_Data
2204  0662 cd0000        	call	_bSendDataOverTCP
2206  0665 84            	pop	a
2207                     ; 706 }
2210  0666 5b29          	addw	sp,#41
2211  0668 81            	ret
2214                     	switch	.const
2215  00c7               L536_localBuffer:
2216  00c7 7b22          	dc.b	"{",34
2217  00c9 526164696174  	dc.b	"RadiatorTemperatur"
2218  00db 6522          	dc.b	"e",34
2219  00dd 3a22          	dc.b	":",34
2220  00df 313233343536  	dc.b	"123456.89",34
2221  00e9 7d00          	dc.b	"}",0
2222  00eb 00000000      	ds.b	4
2223  00ef               L736_temp1:
2224  00ef 00            	dc.b	0
2225  00f0 000000000000  	ds.b	14
2296                     ; 708 void vMevris_Send_RadiatorTemp()
2296                     ; 709 {
2297                     	switch	.text
2298  0669               _vMevris_Send_RadiatorTemp:
2300  0669 523c          	subw	sp,#60
2301       0000003c      OFST:	set	60
2304                     ; 710     uint8_t localBuffer[40] = "{\"RadiatorTemperature\":\"123456.89\"}";
2306  066b 96            	ldw	x,sp
2307  066c 1c0015        	addw	x,#OFST-39
2308  066f 90ae00c7      	ldw	y,#L536_localBuffer
2309  0673 a628          	ld	a,#40
2310  0675 cd0000        	call	c_xymvx
2312                     ; 711     uint8_t unSendDataLength = 0;
2314                     ; 712     uint8_t temp1[15] = "";
2316  0678 96            	ldw	x,sp
2317  0679 1c0006        	addw	x,#OFST-54
2318  067c 90ae00ef      	ldw	y,#L736_temp1
2319  0680 a60f          	ld	a,#15
2320  0682 cd0000        	call	c_xymvx
2322                     ; 713     uint32_t myVar = 0;
2324                     ; 714     vClearBuffer(localBuffer, 40);
2326  0685 4b28          	push	#40
2327  0687 96            	ldw	x,sp
2328  0688 1c0016        	addw	x,#OFST-38
2329  068b cd0000        	call	_vClearBuffer
2331  068e 84            	pop	a
2332                     ; 715     strcpy(localBuffer, "{\"RadiatorTemperature\":\"");
2334  068f 96            	ldw	x,sp
2335  0690 1c0015        	addw	x,#OFST-39
2336  0693 90ae0182      	ldw	y,#L376
2337  0697               L26:
2338  0697 90f6          	ld	a,(y)
2339  0699 905c          	incw	y
2340  069b f7            	ld	(x),a
2341  069c 5c            	incw	x
2342  069d 4d            	tnz	a
2343  069e 26f7          	jrne	L26
2344                     ; 716     myVar = (uint32_t)(Temperature1 * 100);
2346  06a0 ae0000        	ldw	x,#_Temperature1
2347  06a3 cd0000        	call	c_ltor
2349  06a6 ae017e        	ldw	x,#L107
2350  06a9 cd0000        	call	c_fmul
2352  06ac cd0000        	call	c_ftol
2354  06af 96            	ldw	x,sp
2355  06b0 1c0002        	addw	x,#OFST-58
2356  06b3 cd0000        	call	c_rtol
2359                     ; 717     sprintf(temp1, "%ld", myVar / 100);
2361  06b6 96            	ldw	x,sp
2362  06b7 1c0002        	addw	x,#OFST-58
2363  06ba cd0000        	call	c_ltor
2365  06bd ae009b        	ldw	x,#L25
2366  06c0 cd0000        	call	c_ludv
2368  06c3 be02          	ldw	x,c_lreg+2
2369  06c5 89            	pushw	x
2370  06c6 be00          	ldw	x,c_lreg
2371  06c8 89            	pushw	x
2372  06c9 ae01c0        	ldw	x,#L175
2373  06cc 89            	pushw	x
2374  06cd 96            	ldw	x,sp
2375  06ce 1c000c        	addw	x,#OFST-48
2376  06d1 cd0000        	call	_sprintf
2378  06d4 5b06          	addw	sp,#6
2379                     ; 718     strcat(localBuffer, temp1);
2381  06d6 96            	ldw	x,sp
2382  06d7 1c0006        	addw	x,#OFST-54
2383  06da 89            	pushw	x
2384  06db 96            	ldw	x,sp
2385  06dc 1c0017        	addw	x,#OFST-37
2386  06df cd0000        	call	_strcat
2388  06e2 85            	popw	x
2389                     ; 719     strcat(localBuffer, ".");
2391  06e3 ae01be        	ldw	x,#L375
2392  06e6 89            	pushw	x
2393  06e7 96            	ldw	x,sp
2394  06e8 1c0017        	addw	x,#OFST-37
2395  06eb cd0000        	call	_strcat
2397  06ee 85            	popw	x
2398                     ; 720     sprintf(temp1, "%ld", myVar % 100);
2400  06ef 96            	ldw	x,sp
2401  06f0 1c0002        	addw	x,#OFST-58
2402  06f3 cd0000        	call	c_ltor
2404  06f6 ae009b        	ldw	x,#L25
2405  06f9 cd0000        	call	c_lumd
2407  06fc be02          	ldw	x,c_lreg+2
2408  06fe 89            	pushw	x
2409  06ff be00          	ldw	x,c_lreg
2410  0701 89            	pushw	x
2411  0702 ae01c0        	ldw	x,#L175
2412  0705 89            	pushw	x
2413  0706 96            	ldw	x,sp
2414  0707 1c000c        	addw	x,#OFST-48
2415  070a cd0000        	call	_sprintf
2417  070d 5b06          	addw	sp,#6
2418                     ; 721     strcat(localBuffer, temp1);
2420  070f 96            	ldw	x,sp
2421  0710 1c0006        	addw	x,#OFST-54
2422  0713 89            	pushw	x
2423  0714 96            	ldw	x,sp
2424  0715 1c0017        	addw	x,#OFST-37
2425  0718 cd0000        	call	_strcat
2427  071b 85            	popw	x
2428                     ; 723     strcat(localBuffer, "\"}");
2430  071c ae01f4        	ldw	x,#L544
2431  071f 89            	pushw	x
2432  0720 96            	ldw	x,sp
2433  0721 1c0017        	addw	x,#OFST-37
2434  0724 cd0000        	call	_strcat
2436  0727 85            	popw	x
2437                     ; 724     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2439  0728 4b64          	push	#100
2440  072a ae0000        	ldw	x,#_aunPushed_Data
2441  072d cd0000        	call	_vClearBuffer
2443  0730 84            	pop	a
2444                     ; 725     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2444                     ; 726                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2444                     ; 727                                                localBuffer);
2446  0731 96            	ldw	x,sp
2447  0732 1c0015        	addw	x,#OFST-39
2448  0735 89            	pushw	x
2449  0736 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2450  0739 89            	pushw	x
2451  073a ae0000        	ldw	x,#_aunPushed_Data
2452  073d cd0000        	call	_ulMQTT_Publish
2454  0740 5b04          	addw	sp,#4
2455  0742 b603          	ld	a,c_lreg+3
2456  0744 6b01          	ld	(OFST-59,sp),a
2458                     ; 728     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2460  0746 7b01          	ld	a,(OFST-59,sp)
2461  0748 88            	push	a
2462  0749 ae0000        	ldw	x,#_aunPushed_Data
2463  074c cd0000        	call	_bSendDataOverTCP
2465  074f 84            	pop	a
2466                     ; 729 }
2469  0750 5b3c          	addw	sp,#60
2470  0752 81            	ret
2473                     	switch	.const
2474  00fe               L507_localBuffer:
2475  00fe 7b22          	dc.b	"{",34
2476  0100 456e67696e65  	dc.b	"EngineTemperature",34
2477  0112 3a22          	dc.b	":",34
2478  0114 313233343536  	dc.b	"123456.89",34
2479  011e 7d00          	dc.b	"}",0
2480  0120 000000000000  	ds.b	6
2481  0126               L707_temp1:
2482  0126 00            	dc.b	0
2483  0127 000000000000  	ds.b	14
2554                     ; 731 void vMevris_Send_EngineTemp()
2554                     ; 732 {
2555                     	switch	.text
2556  0753               _vMevris_Send_EngineTemp:
2558  0753 523c          	subw	sp,#60
2559       0000003c      OFST:	set	60
2562                     ; 733     uint8_t localBuffer[40] = "{\"EngineTemperature\":\"123456.89\"}";
2564  0755 96            	ldw	x,sp
2565  0756 1c0015        	addw	x,#OFST-39
2566  0759 90ae00fe      	ldw	y,#L507_localBuffer
2567  075d a628          	ld	a,#40
2568  075f cd0000        	call	c_xymvx
2570                     ; 734     uint8_t unSendDataLength = 0;
2572                     ; 735     uint8_t temp1[15] = "";
2574  0762 96            	ldw	x,sp
2575  0763 1c0006        	addw	x,#OFST-54
2576  0766 90ae0126      	ldw	y,#L707_temp1
2577  076a a60f          	ld	a,#15
2578  076c cd0000        	call	c_xymvx
2580                     ; 736     uint32_t myVar = 0;
2582                     ; 737     vClearBuffer(localBuffer, 40);
2584  076f 4b28          	push	#40
2585  0771 96            	ldw	x,sp
2586  0772 1c0016        	addw	x,#OFST-38
2587  0775 cd0000        	call	_vClearBuffer
2589  0778 84            	pop	a
2590                     ; 738     strcpy(localBuffer, "{\"EngineTemperature\":\"");
2592  0779 96            	ldw	x,sp
2593  077a 1c0015        	addw	x,#OFST-39
2594  077d 90ae0167      	ldw	y,#L347
2595  0781               L66:
2596  0781 90f6          	ld	a,(y)
2597  0783 905c          	incw	y
2598  0785 f7            	ld	(x),a
2599  0786 5c            	incw	x
2600  0787 4d            	tnz	a
2601  0788 26f7          	jrne	L66
2602                     ; 739     myVar = (uint32_t)(Temperature2 * 100);
2604  078a ae0000        	ldw	x,#_Temperature2
2605  078d cd0000        	call	c_ltor
2607  0790 ae017e        	ldw	x,#L107
2608  0793 cd0000        	call	c_fmul
2610  0796 cd0000        	call	c_ftol
2612  0799 96            	ldw	x,sp
2613  079a 1c0002        	addw	x,#OFST-58
2614  079d cd0000        	call	c_rtol
2617                     ; 740     sprintf(temp1, "%ld", myVar / 100);
2619  07a0 96            	ldw	x,sp
2620  07a1 1c0002        	addw	x,#OFST-58
2621  07a4 cd0000        	call	c_ltor
2623  07a7 ae009b        	ldw	x,#L25
2624  07aa cd0000        	call	c_ludv
2626  07ad be02          	ldw	x,c_lreg+2
2627  07af 89            	pushw	x
2628  07b0 be00          	ldw	x,c_lreg
2629  07b2 89            	pushw	x
2630  07b3 ae01c0        	ldw	x,#L175
2631  07b6 89            	pushw	x
2632  07b7 96            	ldw	x,sp
2633  07b8 1c000c        	addw	x,#OFST-48
2634  07bb cd0000        	call	_sprintf
2636  07be 5b06          	addw	sp,#6
2637                     ; 741     strcat(localBuffer, temp1);
2639  07c0 96            	ldw	x,sp
2640  07c1 1c0006        	addw	x,#OFST-54
2641  07c4 89            	pushw	x
2642  07c5 96            	ldw	x,sp
2643  07c6 1c0017        	addw	x,#OFST-37
2644  07c9 cd0000        	call	_strcat
2646  07cc 85            	popw	x
2647                     ; 742     strcat(localBuffer, ".");
2649  07cd ae01be        	ldw	x,#L375
2650  07d0 89            	pushw	x
2651  07d1 96            	ldw	x,sp
2652  07d2 1c0017        	addw	x,#OFST-37
2653  07d5 cd0000        	call	_strcat
2655  07d8 85            	popw	x
2656                     ; 743     sprintf(temp1, "%ld", myVar % 100);
2658  07d9 96            	ldw	x,sp
2659  07da 1c0002        	addw	x,#OFST-58
2660  07dd cd0000        	call	c_ltor
2662  07e0 ae009b        	ldw	x,#L25
2663  07e3 cd0000        	call	c_lumd
2665  07e6 be02          	ldw	x,c_lreg+2
2666  07e8 89            	pushw	x
2667  07e9 be00          	ldw	x,c_lreg
2668  07eb 89            	pushw	x
2669  07ec ae01c0        	ldw	x,#L175
2670  07ef 89            	pushw	x
2671  07f0 96            	ldw	x,sp
2672  07f1 1c000c        	addw	x,#OFST-48
2673  07f4 cd0000        	call	_sprintf
2675  07f7 5b06          	addw	sp,#6
2676                     ; 744     strcat(localBuffer, temp1);
2678  07f9 96            	ldw	x,sp
2679  07fa 1c0006        	addw	x,#OFST-54
2680  07fd 89            	pushw	x
2681  07fe 96            	ldw	x,sp
2682  07ff 1c0017        	addw	x,#OFST-37
2683  0802 cd0000        	call	_strcat
2685  0805 85            	popw	x
2686                     ; 746     strcat(localBuffer, "\"}");
2688  0806 ae01f4        	ldw	x,#L544
2689  0809 89            	pushw	x
2690  080a 96            	ldw	x,sp
2691  080b 1c0017        	addw	x,#OFST-37
2692  080e cd0000        	call	_strcat
2694  0811 85            	popw	x
2695                     ; 747     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2697  0812 4b64          	push	#100
2698  0814 ae0000        	ldw	x,#_aunPushed_Data
2699  0817 cd0000        	call	_vClearBuffer
2701  081a 84            	pop	a
2702                     ; 748     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2702                     ; 749                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2702                     ; 750                                                localBuffer);
2704  081b 96            	ldw	x,sp
2705  081c 1c0015        	addw	x,#OFST-39
2706  081f 89            	pushw	x
2707  0820 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2708  0823 89            	pushw	x
2709  0824 ae0000        	ldw	x,#_aunPushed_Data
2710  0827 cd0000        	call	_ulMQTT_Publish
2712  082a 5b04          	addw	sp,#4
2713  082c b603          	ld	a,c_lreg+3
2714  082e 6b01          	ld	(OFST-59,sp),a
2716                     ; 751     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2718  0830 7b01          	ld	a,(OFST-59,sp)
2719  0832 88            	push	a
2720  0833 ae0000        	ldw	x,#_aunPushed_Data
2721  0836 cd0000        	call	_bSendDataOverTCP
2723  0839 84            	pop	a
2724                     ; 752 }
2727  083a 5b3c          	addw	sp,#60
2728  083c 81            	ret
2731                     	switch	.const
2732  0135               L547_localBuffer:
2733  0135 7b22          	dc.b	"{",34
2734  0137 6675656c22    	dc.b	"fuel",34
2735  013c 3a22          	dc.b	":",34
2736  013e 313233343536  	dc.b	"123456.89",34
2737  0148 7d00          	dc.b	"}",0
2738  014a 000000000000  	ds.b	9
2739  0153               L747_temp1:
2740  0153 00            	dc.b	0
2741  0154 000000000000  	ds.b	9
2803                     ; 754 void vMevris_Send_FuelLevel()
2803                     ; 755 {
2804                     	switch	.text
2805  083d               _vMevris_Send_FuelLevel:
2807  083d 5229          	subw	sp,#41
2808       00000029      OFST:	set	41
2811                     ; 756     uint8_t localBuffer[30] = "{\"fuel\":\"123456.89\"}";
2813  083f 96            	ldw	x,sp
2814  0840 1c000c        	addw	x,#OFST-29
2815  0843 90ae0135      	ldw	y,#L547_localBuffer
2816  0847 a61e          	ld	a,#30
2817  0849 cd0000        	call	c_xymvx
2819                     ; 757     uint8_t unSendDataLength = 0;
2821                     ; 758     uint8_t temp1[10] = "";
2823  084c 96            	ldw	x,sp
2824  084d 1c0002        	addw	x,#OFST-39
2825  0850 90ae0153      	ldw	y,#L747_temp1
2826  0854 a60a          	ld	a,#10
2827  0856 cd0000        	call	c_xymvx
2829                     ; 759     vClearBuffer(localBuffer, 30);
2831  0859 4b1e          	push	#30
2832  085b 96            	ldw	x,sp
2833  085c 1c000d        	addw	x,#OFST-28
2834  085f cd0000        	call	_vClearBuffer
2836  0862 84            	pop	a
2837                     ; 760     strcpy(localBuffer, "{\"fuel\":\"");
2839  0863 96            	ldw	x,sp
2840  0864 1c000c        	addw	x,#OFST-29
2841  0867 90ae015d      	ldw	y,#L777
2842  086b               L27:
2843  086b 90f6          	ld	a,(y)
2844  086d 905c          	incw	y
2845  086f f7            	ld	(x),a
2846  0870 5c            	incw	x
2847  0871 4d            	tnz	a
2848  0872 26f7          	jrne	L27
2849                     ; 761     sprintf(temp1, "%ld", Fuellevel);
2851  0874 ce0002        	ldw	x,_Fuellevel+2
2852  0877 89            	pushw	x
2853  0878 ce0000        	ldw	x,_Fuellevel
2854  087b 89            	pushw	x
2855  087c ae01c0        	ldw	x,#L175
2856  087f 89            	pushw	x
2857  0880 96            	ldw	x,sp
2858  0881 1c0008        	addw	x,#OFST-33
2859  0884 cd0000        	call	_sprintf
2861  0887 5b06          	addw	sp,#6
2862                     ; 762     strcat(localBuffer, temp1);
2864  0889 96            	ldw	x,sp
2865  088a 1c0002        	addw	x,#OFST-39
2866  088d 89            	pushw	x
2867  088e 96            	ldw	x,sp
2868  088f 1c000e        	addw	x,#OFST-27
2869  0892 cd0000        	call	_strcat
2871  0895 85            	popw	x
2872                     ; 763     strcat(localBuffer, "\"}");
2874  0896 ae01f4        	ldw	x,#L544
2875  0899 89            	pushw	x
2876  089a 96            	ldw	x,sp
2877  089b 1c000e        	addw	x,#OFST-27
2878  089e cd0000        	call	_strcat
2880  08a1 85            	popw	x
2881                     ; 764     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2883  08a2 4b64          	push	#100
2884  08a4 ae0000        	ldw	x,#_aunPushed_Data
2885  08a7 cd0000        	call	_vClearBuffer
2887  08aa 84            	pop	a
2888                     ; 765     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2888                     ; 766                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2888                     ; 767                                                localBuffer);
2890  08ab 96            	ldw	x,sp
2891  08ac 1c000c        	addw	x,#OFST-29
2892  08af 89            	pushw	x
2893  08b0 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2894  08b3 89            	pushw	x
2895  08b4 ae0000        	ldw	x,#_aunPushed_Data
2896  08b7 cd0000        	call	_ulMQTT_Publish
2898  08ba 5b04          	addw	sp,#4
2899  08bc b603          	ld	a,c_lreg+3
2900  08be 6b01          	ld	(OFST-40,sp),a
2902                     ; 768     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2904  08c0 7b01          	ld	a,(OFST-40,sp)
2905  08c2 88            	push	a
2906  08c3 ae0000        	ldw	x,#_aunPushed_Data
2907  08c6 cd0000        	call	_bSendDataOverTCP
2909  08c9 84            	pop	a
2910                     ; 769 }
2913  08ca 5b29          	addw	sp,#41
2914  08cc 81            	ret
3001                     	xdef	_sendDataToCloud
3002                     	xref.b	_IMEIRecievedOKFlag
3003                     	xdef	_bCONNACK_Recieved
3004                     	xdef	_aunPushed_Data
3005                     	xdef	_vMevris_Send_Phase
3006                     	xdef	_vMevris_Send_FuelLevel
3007                     	xdef	_vMevris_Send_EngineTemp
3008                     	xdef	_vMevris_Send_RadiatorTemp
3009                     	xdef	_vMevris_Send_BatteryVolt
3010                     	xdef	_aunMQTT_Publish_Topic
3011                     	xdef	_aunMQTT_Subscribe_Topic
3012                     	xdef	_aunMQTT_ClientID
3013                     	xref	_Temperature2
3014                     	xref	_Temperature1
3015                     	xref	_Fuellevel
3016                     	xref.b	_batVolt
3017                     	xref	_Watt_Phase3
3018                     	xref	_Ampere_Phase3
3019                     	xref	_Voltage_Phase3
3020                     	xref	_Watt_Phase2
3021                     	xref	_Ampere_Phase2
3022                     	xref	_Voltage_Phase2
3023                     	xref	_Watt_Phase1
3024                     	xref	_Ampere_Phase1
3025                     	xref	_Voltage_Phase1
3026                     	xdef	_vMevris_Send_Version
3027                     	xdef	_vMevris_Send_IMEI
3028                     	xdef	_punGet_Client_ID
3029                     	xdef	_punGet_Command_Topic
3030                     	xdef	_punGet_Event_Topic
3031                     	xdef	_vHandleMevris_MQTT_Recv_Data
3032                     	xdef	_vHandleMevrisRecievedData
3033                     	xref	_enGet_TCP_Status
3034                     	xref	_vClearBuffer
3035                     	xref	_bSendDataOverTCP
3036                     	xref	_response_buffer
3037                     	xref	_ulMQTT_Publish
3038                     	xref.b	_aunIMEI
3039                     	xref	_sprintf
3040                     	xref	_strstr
3041                     	xref	_strcat
3042                     	switch	.const
3043  015d               L777:
3044  015d 7b22          	dc.b	"{",34
3045  015f 6675656c22    	dc.b	"fuel",34
3046  0164 3a2200        	dc.b	":",34,0
3047  0167               L347:
3048  0167 7b22          	dc.b	"{",34
3049  0169 456e67696e65  	dc.b	"EngineTemperature",34
3050  017b 3a2200        	dc.b	":",34,0
3051  017e               L107:
3052  017e 42c80000      	dc.w	17096,0
3053  0182               L376:
3054  0182 7b22          	dc.b	"{",34
3055  0184 526164696174  	dc.b	"RadiatorTemperatur"
3056  0196 6522          	dc.b	"e",34
3057  0198 3a2200        	dc.b	":",34,0
3058  019b               L336:
3059  019b 7b22          	dc.b	"{",34
3060  019d 626174746572  	dc.b	"battery",34
3061  01a5 3a2200        	dc.b	":",34,0
3062  01a8               L775:
3063  01a8 222c22637572  	dc.b	34,44,34,99,117,114
3064  01ae 72656e7400    	dc.b	"rent",0
3065  01b3               L575:
3066  01b3 222c22766f6c  	dc.b	34,44,34,118,111,108
3067  01b9 7461676500    	dc.b	"tage",0
3068  01be               L375:
3069  01be 2e00          	dc.b	".",0
3070  01c0               L175:
3071  01c0 256c6400      	dc.b	"%ld",0
3072  01c4               L765:
3073  01c4 223a2200      	dc.b	34,58,34,0
3074  01c8               L565:
3075  01c8 7b22          	dc.b	"{",34
3076  01ca 706f77657200  	dc.b	"power",0
3077  01d0               L365:
3078  01d0 256400        	dc.b	"%d",0
3079  01d3               L105:
3080  01d3 302e302e3030  	dc.b	"0.0.001",0
3081  01db               L774:
3082  01db 222c22687722  	dc.b	34,44,34,104,119,34
3083  01e1 3a2200        	dc.b	":",34,0
3084  01e4               L574:
3085  01e4 322e342e3030  	dc.b	"2.4.001",0
3086  01ec               L374:
3087  01ec 7b22          	dc.b	"{",34
3088  01ee 667722        	dc.b	"fw",34
3089  01f1 3a2200        	dc.b	":",34,0
3090  01f4               L544:
3091  01f4 227d00        	dc.b	34,125,0
3092  01f7               L344:
3093  01f7 7b22          	dc.b	"{",34
3094  01f9 696d656922    	dc.b	"imei",34
3095  01fe 3a2200        	dc.b	":",34,0
3096  0201               L514:
3097  0201 6576656e7400  	dc.b	"event",0
3098  0207               L573:
3099  0207 636f6d6d616e  	dc.b	"command",0
3100  020f               L373:
3101  020f 2f00          	dc.b	"/",0
3102  0211               L173:
3103  0211 73633200      	dc.b	"sc2",0
3104  0215               L153:
3105  0215 67656e00      	dc.b	"gen",0
3106  0219               L733:
3107  0219 22696d656922  	dc.b	34,105,109,101,105,34,0
3108  0220               L333:
3109  0220 22696e666f22  	dc.b	34,105,110,102,111,34,0
3110  0227               L342:
3111  0227 2b49504400    	dc.b	"+IPD",0
3112                     	xref.b	c_lreg
3113                     	xref.b	c_x
3133                     	xref	c_rtol
3134                     	xref	c_ftol
3135                     	xref	c_fmul
3136                     	xref	c_lumd
3137                     	xref	c_ludv
3138                     	xref	c_ltor
3139                     	xref	c_xymvx
3140                     	end
