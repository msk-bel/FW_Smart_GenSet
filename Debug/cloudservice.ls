   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
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
 327  0009 cc00c4        	jp	L751
 328  000c               L6:
 329                     ; 71         eTCP_Status = enGet_TCP_Status();
 331  000c cd0000        	call	_enGet_TCP_Status
 333  000f 6b01          	ld	(OFST+0,sp),a
 335                     ; 72         if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
 337  0011 7b01          	ld	a,(OFST+0,sp)
 338  0013 a107          	cp	a,#7
 339  0015 2703          	jreq	L01
 340  0017 cc00c0        	jp	L161
 341  001a               L01:
 343  001a 3d00          	tnz	_IMEIRecievedOKFlag
 344  001c 2603          	jrne	L21
 345  001e cc00c0        	jp	L161
 346  0021               L21:
 347                     ; 74             switch (enSendEventCounter)
 349  0021 b600          	ld	a,L3_enSendEventCounter
 351                     ; 118             default:
 351                     ; 119                 break;
 352  0023 a005          	sub	a,#5
 353  0025 2714          	jreq	L7
 354  0027 4a            	dec	a
 355  0028 2732          	jreq	L11
 356  002a 4a            	dec	a
 357  002b 2750          	jreq	L31
 358  002d 4a            	dec	a
 359  002e 276e          	jreq	L51
 360  0030 4a            	dec	a
 361  0031 2770          	jreq	L71
 362  0033 4a            	dec	a
 363  0034 2772          	jreq	L12
 364  0036 4a            	dec	a
 365  0037 2774          	jreq	L32
 366  0039 2075          	jra	L561
 367  003b               L7:
 368                     ; 91             case eCommand_Phase1:
 368                     ; 92                 // vMevris_Send_Phase1();
 368                     ; 93                 vMevris_Send_Phase(1, Watt_Phase1, Voltage_Phase1, Ampere_Phase1);
 370  003b ce0002        	ldw	x,_Ampere_Phase1+2
 371  003e 89            	pushw	x
 372  003f ce0000        	ldw	x,_Ampere_Phase1
 373  0042 89            	pushw	x
 374  0043 ce0002        	ldw	x,_Voltage_Phase1+2
 375  0046 89            	pushw	x
 376  0047 ce0000        	ldw	x,_Voltage_Phase1
 377  004a 89            	pushw	x
 378  004b ce0002        	ldw	x,_Watt_Phase1+2
 379  004e 89            	pushw	x
 380  004f ce0000        	ldw	x,_Watt_Phase1
 381  0052 89            	pushw	x
 382  0053 a601          	ld	a,#1
 383  0055 cd037f        	call	_vMevris_Send_Phase
 385  0058 5b0c          	addw	sp,#12
 386                     ; 94                 break;
 388  005a 2054          	jra	L561
 389  005c               L11:
 390                     ; 95             case eCommand_Phase2:
 390                     ; 96                 // vMevris_Send_Phase2();
 390                     ; 97                 vMevris_Send_Phase(2, Watt_Phase2, Voltage_Phase2, Ampere_Phase2);
 392  005c ce0002        	ldw	x,_Ampere_Phase2+2
 393  005f 89            	pushw	x
 394  0060 ce0000        	ldw	x,_Ampere_Phase2
 395  0063 89            	pushw	x
 396  0064 ce0002        	ldw	x,_Voltage_Phase2+2
 397  0067 89            	pushw	x
 398  0068 ce0000        	ldw	x,_Voltage_Phase2
 399  006b 89            	pushw	x
 400  006c ce0002        	ldw	x,_Watt_Phase2+2
 401  006f 89            	pushw	x
 402  0070 ce0000        	ldw	x,_Watt_Phase2
 403  0073 89            	pushw	x
 404  0074 a602          	ld	a,#2
 405  0076 cd037f        	call	_vMevris_Send_Phase
 407  0079 5b0c          	addw	sp,#12
 408                     ; 98                 break;
 410  007b 2033          	jra	L561
 411  007d               L31:
 412                     ; 99             case eCommand_Phase3:
 412                     ; 100                 // vMevris_Send_Phase3();
 412                     ; 101                 vMevris_Send_Phase(3, Watt_Phase3, Voltage_Phase3, Ampere_Phase3);
 414  007d ce0002        	ldw	x,_Ampere_Phase3+2
 415  0080 89            	pushw	x
 416  0081 ce0000        	ldw	x,_Ampere_Phase3
 417  0084 89            	pushw	x
 418  0085 ce0002        	ldw	x,_Voltage_Phase3+2
 419  0088 89            	pushw	x
 420  0089 ce0000        	ldw	x,_Voltage_Phase3
 421  008c 89            	pushw	x
 422  008d ce0002        	ldw	x,_Watt_Phase3+2
 423  0090 89            	pushw	x
 424  0091 ce0000        	ldw	x,_Watt_Phase3
 425  0094 89            	pushw	x
 426  0095 a603          	ld	a,#3
 427  0097 cd037f        	call	_vMevris_Send_Phase
 429  009a 5b0c          	addw	sp,#12
 430                     ; 102                 break;
 432  009c 2012          	jra	L561
 433  009e               L51:
 434                     ; 103             case eCommand_BatteryVolts:
 434                     ; 104                 vMevris_Send_BatteryVolt();
 436  009e cd05a2        	call	_vMevris_Send_BatteryVolt
 438                     ; 105                 break;
 440  00a1 200d          	jra	L561
 441  00a3               L71:
 442                     ; 106             case eCommand_RadiatorTemp:
 442                     ; 107                 vMevris_Send_RadiatorTemp();
 444  00a3 cd0674        	call	_vMevris_Send_RadiatorTemp
 446                     ; 108                 break;
 448  00a6 2008          	jra	L561
 449  00a8               L12:
 450                     ; 109             case eCommand_EngineTemp:
 450                     ; 110                 vMevris_Send_EngineTemp();
 452  00a8 cd075e        	call	_vMevris_Send_EngineTemp
 454                     ; 111                 break;
 456  00ab 2003          	jra	L561
 457  00ad               L32:
 458                     ; 112             case eCommand_FuelLevel:
 458                     ; 113                 vMevris_Send_FuelLevel();
 460  00ad cd0848        	call	_vMevris_Send_FuelLevel
 462                     ; 114                 break;
 464  00b0               L52:
 465                     ; 115             case eCommand_Others:
 465                     ; 116                 // Do something
 465                     ; 117                 break;
 467  00b0               L72:
 468                     ; 118             default:
 468                     ; 119                 break;
 470  00b0               L561:
 471                     ; 122             enSendEventCounter++;
 473  00b0 3c00          	inc	L3_enSendEventCounter
 474                     ; 123             if (enSendEventCounter >= eCommand_Others)
 476  00b2 b600          	ld	a,L3_enSendEventCounter
 477  00b4 a10c          	cp	a,#12
 478  00b6 2504          	jrult	L761
 479                     ; 124                 enSendEventCounter = eCommand_IMEI;
 481  00b8 35010000      	mov	L3_enSendEventCounter,#1
 482  00bc               L761:
 483                     ; 125             tempCounter = 0;
 485  00bc 3f01          	clr	L5_tempCounter
 487  00be 2004          	jra	L751
 488  00c0               L161:
 489                     ; 129             enSendEventCounter = eCommand_IMEI;
 491  00c0 35010000      	mov	L3_enSendEventCounter,#1
 492  00c4               L751:
 493                     ; 132 }
 496  00c4 84            	pop	a
 497  00c5 81            	ret
 575                     ; 335 void vHandleMevris_MQTT_Recv_Data(void)
 575                     ; 336 {
 576                     	switch	.text
 577  00c6               _vHandleMevris_MQTT_Recv_Data:
 579  00c6 5225          	subw	sp,#37
 580       00000025      OFST:	set	37
 583                     ; 339     uint8_t i = 0, j;
 585                     ; 340     uint8_t unLength = 0;
 587  00c8 0f21          	clr	(OFST-4,sp)
 589                     ; 345     ptr = strstr(response_buffer, "+IPD");
 591  00ca ae0227        	ldw	x,#L132
 592  00cd 89            	pushw	x
 593  00ce ae0000        	ldw	x,#_response_buffer
 594  00d1 cd0000        	call	_strstr
 596  00d4 5b02          	addw	sp,#2
 597  00d6 1f23          	ldw	(OFST-2,sp),x
 599                     ; 346     if (ptr)
 601  00d8 1e23          	ldw	x,(OFST-2,sp)
 602  00da 2603          	jrne	L43
 603  00dc cc01a6        	jp	L332
 604  00df               L43:
 605                     ; 348         i = 0;
 607  00df 0f25          	clr	(OFST+0,sp)
 610  00e1 2002          	jra	L142
 611  00e3               L532:
 612                     ; 350             i++;
 615  00e3 0c25          	inc	(OFST+0,sp)
 617  00e5               L142:
 618                     ; 349         while (*(ptr + i) != ':')
 618                     ; 350             i++;
 620  00e5 7b23          	ld	a,(OFST-2,sp)
 621  00e7 97            	ld	xl,a
 622  00e8 7b24          	ld	a,(OFST-1,sp)
 623  00ea 1b25          	add	a,(OFST+0,sp)
 624  00ec 2401          	jrnc	L61
 625  00ee 5c            	incw	x
 626  00ef               L61:
 627  00ef 02            	rlwa	x,a
 628  00f0 f6            	ld	a,(x)
 629  00f1 a13a          	cp	a,#58
 630  00f3 26ee          	jrne	L532
 631                     ; 351         i++;
 633  00f5 0c25          	inc	(OFST+0,sp)
 635                     ; 352         if (*(ptr + i) == 0x20) // Check if CONNACK is Recieved
 637  00f7 7b23          	ld	a,(OFST-2,sp)
 638  00f9 97            	ld	xl,a
 639  00fa 7b24          	ld	a,(OFST-1,sp)
 640  00fc 1b25          	add	a,(OFST+0,sp)
 641  00fe 2401          	jrnc	L02
 642  0100 5c            	incw	x
 643  0101               L02:
 644  0101 02            	rlwa	x,a
 645  0102 f6            	ld	a,(x)
 646  0103 a120          	cp	a,#32
 647  0105 2611          	jrne	L542
 648                     ; 354             if (*(ptr + 3) == 0) // If 0x00 Then it means Successfull
 650  0107 1e23          	ldw	x,(OFST-2,sp)
 651  0109 6d03          	tnz	(3,x)
 652  010b 2703          	jreq	L63
 653  010d cc01a6        	jp	L332
 654  0110               L63:
 655                     ; 355                 bCONNACK_Recieved = TRUE;
 657  0110 35010000      	mov	_bCONNACK_Recieved,#1
 658  0114 aca601a6      	jpf	L332
 659  0118               L542:
 660                     ; 357         else if (*(ptr + i) == 0x30) //Check if Message is a PUBLISH Packet from server
 662  0118 7b23          	ld	a,(OFST-2,sp)
 663  011a 97            	ld	xl,a
 664  011b 7b24          	ld	a,(OFST-1,sp)
 665  011d 1b25          	add	a,(OFST+0,sp)
 666  011f 2401          	jrnc	L22
 667  0121 5c            	incw	x
 668  0122               L22:
 669  0122 02            	rlwa	x,a
 670  0123 f6            	ld	a,(x)
 671  0124 a130          	cp	a,#48
 672  0126 2702          	jreq	L04
 673  0128 207c          	jp	L332
 674  012a               L04:
 676  012a 2002          	jra	L752
 677  012c               L552:
 678                     ; 360                 i++;
 680  012c 0c25          	inc	(OFST+0,sp)
 682  012e               L752:
 683                     ; 359             while (*(ptr + i) != '{' && i < 99)
 685  012e 7b23          	ld	a,(OFST-2,sp)
 686  0130 97            	ld	xl,a
 687  0131 7b24          	ld	a,(OFST-1,sp)
 688  0133 1b25          	add	a,(OFST+0,sp)
 689  0135 2401          	jrnc	L42
 690  0137 5c            	incw	x
 691  0138               L42:
 692  0138 02            	rlwa	x,a
 693  0139 f6            	ld	a,(x)
 694  013a a17b          	cp	a,#123
 695  013c 2706          	jreq	L362
 697  013e 7b25          	ld	a,(OFST+0,sp)
 698  0140 a163          	cp	a,#99
 699  0142 25e8          	jrult	L552
 700  0144               L362:
 701                     ; 362             if (*(ptr + i) == '{')
 703  0144 7b23          	ld	a,(OFST-2,sp)
 704  0146 97            	ld	xl,a
 705  0147 7b24          	ld	a,(OFST-1,sp)
 706  0149 1b25          	add	a,(OFST+0,sp)
 707  014b 2401          	jrnc	L62
 708  014d 5c            	incw	x
 709  014e               L62:
 710  014e 02            	rlwa	x,a
 711  014f f6            	ld	a,(x)
 712  0150 a17b          	cp	a,#123
 713  0152 2652          	jrne	L332
 714                     ; 364                 vClearBuffer(localBuffer, 30);
 716  0154 4b1e          	push	#30
 717  0156 96            	ldw	x,sp
 718  0157 1c0004        	addw	x,#OFST-33
 719  015a cd0000        	call	_vClearBuffer
 721  015d 84            	pop	a
 722                     ; 365                 j = 0;
 724  015e 0f22          	clr	(OFST-3,sp)
 727  0160 2024          	jra	L372
 728  0162               L762:
 729                     ; 368                     localBuffer[j++] = *(ptr + i);
 731  0162 96            	ldw	x,sp
 732  0163 1c0003        	addw	x,#OFST-34
 733  0166 1f01          	ldw	(OFST-36,sp),x
 735  0168 7b22          	ld	a,(OFST-3,sp)
 736  016a 97            	ld	xl,a
 737  016b 0c22          	inc	(OFST-3,sp)
 739  016d 9f            	ld	a,xl
 740  016e 5f            	clrw	x
 741  016f 97            	ld	xl,a
 742  0170 72fb01        	addw	x,(OFST-36,sp)
 743  0173 89            	pushw	x
 744  0174 7b25          	ld	a,(OFST+0,sp)
 745  0176 97            	ld	xl,a
 746  0177 7b26          	ld	a,(OFST+1,sp)
 747  0179 1b27          	add	a,(OFST+2,sp)
 748  017b 2401          	jrnc	L03
 749  017d 5c            	incw	x
 750  017e               L03:
 751  017e 02            	rlwa	x,a
 752  017f f6            	ld	a,(x)
 753  0180 85            	popw	x
 754  0181 f7            	ld	(x),a
 755                     ; 369                     unLength++;
 757  0182 0c21          	inc	(OFST-4,sp)
 759                     ; 370                     i++;
 761  0184 0c25          	inc	(OFST+0,sp)
 763  0186               L372:
 764                     ; 366                 while (*(ptr + i) != '\r' && j < 29)
 766  0186 7b23          	ld	a,(OFST-2,sp)
 767  0188 97            	ld	xl,a
 768  0189 7b24          	ld	a,(OFST-1,sp)
 769  018b 1b25          	add	a,(OFST+0,sp)
 770  018d 2401          	jrnc	L23
 771  018f 5c            	incw	x
 772  0190               L23:
 773  0190 02            	rlwa	x,a
 774  0191 f6            	ld	a,(x)
 775  0192 a10d          	cp	a,#13
 776  0194 2706          	jreq	L772
 778  0196 7b22          	ld	a,(OFST-3,sp)
 779  0198 a11d          	cp	a,#29
 780  019a 25c6          	jrult	L762
 781  019c               L772:
 782                     ; 374                 vHandleMevrisRecievedData(localBuffer, unLength);
 784  019c 7b21          	ld	a,(OFST-4,sp)
 785  019e 88            	push	a
 786  019f 96            	ldw	x,sp
 787  01a0 1c0004        	addw	x,#OFST-33
 788  01a3 ad04          	call	_vHandleMevrisRecievedData
 790  01a5 84            	pop	a
 791  01a6               L332:
 792                     ; 378 }
 795  01a6 5b25          	addw	sp,#37
 796  01a8 81            	ret
 834                     ; 380 void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength)
 834                     ; 381 {
 835                     	switch	.text
 836  01a9               _vHandleMevrisRecievedData:
 838  01a9 89            	pushw	x
 839       00000000      OFST:	set	0
 842                     ; 393     if (strstr(Data, "\"info\"")) //Example "{"info":"imei"}"
 844  01aa ae0220        	ldw	x,#L123
 845  01ad 89            	pushw	x
 846  01ae 1e03          	ldw	x,(OFST+3,sp)
 847  01b0 cd0000        	call	_strstr
 849  01b3 5b02          	addw	sp,#2
 850  01b5 a30000        	cpw	x,#0
 851  01b8 2713          	jreq	L713
 852                     ; 395         if (strstr(Data, "\"imei\""))
 854  01ba ae0219        	ldw	x,#L523
 855  01bd 89            	pushw	x
 856  01be 1e03          	ldw	x,(OFST+3,sp)
 857  01c0 cd0000        	call	_strstr
 859  01c3 5b02          	addw	sp,#2
 860  01c5 a30000        	cpw	x,#0
 861  01c8 2703          	jreq	L713
 862                     ; 397             vMevris_Send_IMEI();
 864  01ca cd028d        	call	_vMevris_Send_IMEI
 866  01cd               L713:
 867                     ; 417 }
 870  01cd 85            	popw	x
 871  01ce 81            	ret
 900                     ; 419 uint8_t *punGet_Client_ID(void)
 900                     ; 420 {
 901                     	switch	.text
 902  01cf               _punGet_Client_ID:
 906                     ; 427     vClearBuffer(aunMQTT_ClientID, 20);
 908  01cf 4b14          	push	#20
 909  01d1 ae0064        	ldw	x,#_aunMQTT_ClientID
 910  01d4 cd0000        	call	_vClearBuffer
 912  01d7 84            	pop	a
 913                     ; 428     strcpy(aunMQTT_ClientID, "gen");
 915  01d8 ae0064        	ldw	x,#_aunMQTT_ClientID
 916  01db 90ae0215      	ldw	y,#L733
 917  01df               L64:
 918  01df 90f6          	ld	a,(y)
 919  01e1 905c          	incw	y
 920  01e3 f7            	ld	(x),a
 921  01e4 5c            	incw	x
 922  01e5 4d            	tnz	a
 923  01e6 26f7          	jrne	L64
 924                     ; 429     strcat(aunMQTT_ClientID, aunIMEI);
 926  01e8 ae0000        	ldw	x,#_aunIMEI
 927  01eb 89            	pushw	x
 928  01ec ae0064        	ldw	x,#_aunMQTT_ClientID
 929  01ef cd0000        	call	_strcat
 931  01f2 85            	popw	x
 932                     ; 431     return aunMQTT_ClientID;
 934  01f3 ae0064        	ldw	x,#_aunMQTT_ClientID
 937  01f6 81            	ret
 978                     ; 434 uint8_t *punGet_Command_Topic(void)
 978                     ; 435 {
 979                     	switch	.text
 980  01f7               _punGet_Command_Topic:
 982  01f7 88            	push	a
 983       00000001      OFST:	set	1
 986                     ; 436     uint8_t i = 0;
 988                     ; 442     vClearBuffer(aunMQTT_Subscribe_Topic, 30);
 990  01f8 4b1e          	push	#30
 991  01fa ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 992  01fd cd0000        	call	_vClearBuffer
 994  0200 84            	pop	a
 995                     ; 443     strcpy(aunMQTT_Subscribe_Topic, MQTT_TOPIC_HEADER);
 997  0201 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 998  0204 90ae0211      	ldw	y,#L753
 999  0208               L25:
1000  0208 90f6          	ld	a,(y)
1001  020a 905c          	incw	y
1002  020c f7            	ld	(x),a
1003  020d 5c            	incw	x
1004  020e 4d            	tnz	a
1005  020f 26f7          	jrne	L25
1006                     ; 444     strcat(aunMQTT_Subscribe_Topic, "/");
1008  0211 ae020f        	ldw	x,#L163
1009  0214 89            	pushw	x
1010  0215 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1011  0218 cd0000        	call	_strcat
1013  021b 85            	popw	x
1014                     ; 445     strcat(aunMQTT_Subscribe_Topic, aunIMEI);
1016  021c ae0000        	ldw	x,#_aunIMEI
1017  021f 89            	pushw	x
1018  0220 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1019  0223 cd0000        	call	_strcat
1021  0226 85            	popw	x
1022                     ; 446     strcat(aunMQTT_Subscribe_Topic, "/");
1024  0227 ae020f        	ldw	x,#L163
1025  022a 89            	pushw	x
1026  022b ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1027  022e cd0000        	call	_strcat
1029  0231 85            	popw	x
1030                     ; 447     strcat(aunMQTT_Subscribe_Topic, MQTT_INBOUND_TOPIC_FOOTER);
1032  0232 ae0207        	ldw	x,#L363
1033  0235 89            	pushw	x
1034  0236 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1035  0239 cd0000        	call	_strcat
1037  023c 85            	popw	x
1038                     ; 449     return aunMQTT_Subscribe_Topic;
1040  023d ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1043  0240 84            	pop	a
1044  0241 81            	ret
1084                     ; 452 uint8_t *punGet_Event_Topic(void)
1084                     ; 453 {
1085                     	switch	.text
1086  0242               _punGet_Event_Topic:
1088  0242 88            	push	a
1089       00000001      OFST:	set	1
1092                     ; 454     uint8_t i = 0;
1094                     ; 460     vClearBuffer(aunMQTT_Publish_Topic, 30);
1096  0243 4b1e          	push	#30
1097  0245 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1098  0248 cd0000        	call	_vClearBuffer
1100  024b 84            	pop	a
1101                     ; 461     strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
1103  024c ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1104  024f 90ae0211      	ldw	y,#L753
1105  0253               L65:
1106  0253 90f6          	ld	a,(y)
1107  0255 905c          	incw	y
1108  0257 f7            	ld	(x),a
1109  0258 5c            	incw	x
1110  0259 4d            	tnz	a
1111  025a 26f7          	jrne	L65
1112                     ; 462     strcat(aunMQTT_Publish_Topic, "/");
1114  025c ae020f        	ldw	x,#L163
1115  025f 89            	pushw	x
1116  0260 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1117  0263 cd0000        	call	_strcat
1119  0266 85            	popw	x
1120                     ; 463     strcat(aunMQTT_Publish_Topic, aunIMEI);
1122  0267 ae0000        	ldw	x,#_aunIMEI
1123  026a 89            	pushw	x
1124  026b ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1125  026e cd0000        	call	_strcat
1127  0271 85            	popw	x
1128                     ; 464     strcat(aunMQTT_Publish_Topic, "/");
1130  0272 ae020f        	ldw	x,#L163
1131  0275 89            	pushw	x
1132  0276 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1133  0279 cd0000        	call	_strcat
1135  027c 85            	popw	x
1136                     ; 465     strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);
1138  027d ae0201        	ldw	x,#L304
1139  0280 89            	pushw	x
1140  0281 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1141  0284 cd0000        	call	_strcat
1143  0287 85            	popw	x
1144                     ; 467     return aunMQTT_Publish_Topic;
1146  0288 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1149  028b 84            	pop	a
1150  028c 81            	ret
1153                     .const:	section	.text
1154  0000               L504_localBuffer:
1155  0000 7b22          	dc.b	"{",34
1156  0002 696d656922    	dc.b	"imei",34
1157  0007 3a22          	dc.b	":",34
1158  0009 313233343536  	dc.b	"123456789012345",34
1159  0019 7d00          	dc.b	"}",0
1160  001b 000000        	ds.b	3
1210                     ; 471 void vMevris_Send_IMEI(void)
1210                     ; 472 {
1211                     	switch	.text
1212  028d               _vMevris_Send_IMEI:
1214  028d 521f          	subw	sp,#31
1215       0000001f      OFST:	set	31
1218                     ; 473     uint8_t localBuffer[30] = "{\"imei\":\"123456789012345\"}";
1220  028f 96            	ldw	x,sp
1221  0290 1c0002        	addw	x,#OFST-29
1222  0293 90ae0000      	ldw	y,#L504_localBuffer
1223  0297 a61e          	ld	a,#30
1224  0299 cd0000        	call	c_xymvx
1226                     ; 474     uint8_t unSendDataLength = 0;
1228                     ; 475     vClearBuffer(localBuffer, 30);
1230  029c 4b1e          	push	#30
1231  029e 96            	ldw	x,sp
1232  029f 1c0003        	addw	x,#OFST-28
1233  02a2 cd0000        	call	_vClearBuffer
1235  02a5 84            	pop	a
1236                     ; 476     strcpy(localBuffer, "{\"imei\":\"");
1238  02a6 96            	ldw	x,sp
1239  02a7 1c0002        	addw	x,#OFST-29
1240  02aa 90ae01f7      	ldw	y,#L134
1241  02ae               L26:
1242  02ae 90f6          	ld	a,(y)
1243  02b0 905c          	incw	y
1244  02b2 f7            	ld	(x),a
1245  02b3 5c            	incw	x
1246  02b4 4d            	tnz	a
1247  02b5 26f7          	jrne	L26
1248                     ; 477     strcat(localBuffer, aunIMEI);
1250  02b7 ae0000        	ldw	x,#_aunIMEI
1251  02ba 89            	pushw	x
1252  02bb 96            	ldw	x,sp
1253  02bc 1c0004        	addw	x,#OFST-27
1254  02bf cd0000        	call	_strcat
1256  02c2 85            	popw	x
1257                     ; 478     strcat(localBuffer, "\"}");
1259  02c3 ae01f4        	ldw	x,#L334
1260  02c6 89            	pushw	x
1261  02c7 96            	ldw	x,sp
1262  02c8 1c0004        	addw	x,#OFST-27
1263  02cb cd0000        	call	_strcat
1265  02ce 85            	popw	x
1266                     ; 479     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1268  02cf 4b64          	push	#100
1269  02d1 ae0000        	ldw	x,#_aunPushed_Data
1270  02d4 cd0000        	call	_vClearBuffer
1272  02d7 84            	pop	a
1273                     ; 480     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1273                     ; 481                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
1273                     ; 482                                                localBuffer);
1275  02d8 96            	ldw	x,sp
1276  02d9 1c0002        	addw	x,#OFST-29
1277  02dc 89            	pushw	x
1278  02dd ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1279  02e0 89            	pushw	x
1280  02e1 ae0000        	ldw	x,#_aunPushed_Data
1281  02e4 cd0000        	call	_ulMQTT_Publish
1283  02e7 5b04          	addw	sp,#4
1284  02e9 b603          	ld	a,c_lreg+3
1285  02eb 6b01          	ld	(OFST-30,sp),a
1287                     ; 483     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1289  02ed 7b01          	ld	a,(OFST-30,sp)
1290  02ef 88            	push	a
1291  02f0 ae0000        	ldw	x,#_aunPushed_Data
1292  02f3 cd0000        	call	_bSendDataOverTCP
1294  02f6 84            	pop	a
1295                     ; 484 }
1298  02f7 5b1f          	addw	sp,#31
1299  02f9 81            	ret
1302                     	switch	.const
1303  001e               L534_localBuffer:
1304  001e 7b22          	dc.b	"{",34
1305  0020 667722        	dc.b	"fw",34
1306  0023 3a22          	dc.b	":",34
1307  0025 322e342e3031  	dc.b	"2.4.010",34
1308  002d 2c22          	dc.b	",",34
1309  002f 687722        	dc.b	"hw",34
1310  0032 3a22          	dc.b	":",34
1311  0034 302e302e3030  	dc.b	"0.0.001",34
1312  003c 7d00          	dc.b	"}",0
1313  003e 000000        	ds.b	3
1363                     ; 519 void vMevris_Send_Version()
1363                     ; 520 {
1364                     	switch	.text
1365  02fa               _vMevris_Send_Version:
1367  02fa 5224          	subw	sp,#36
1368       00000024      OFST:	set	36
1371                     ; 521     uint8_t localBuffer[35] = "{\"fw\":\"2.4.010\",\"hw\":\"0.0.001\"}";
1373  02fc 96            	ldw	x,sp
1374  02fd 1c0002        	addw	x,#OFST-34
1375  0300 90ae001e      	ldw	y,#L534_localBuffer
1376  0304 a623          	ld	a,#35
1377  0306 cd0000        	call	c_xymvx
1379                     ; 522     uint8_t unSendDataLength = 0;
1381                     ; 523     vClearBuffer(localBuffer, 35);
1383  0309 4b23          	push	#35
1384  030b 96            	ldw	x,sp
1385  030c 1c0003        	addw	x,#OFST-33
1386  030f cd0000        	call	_vClearBuffer
1388  0312 84            	pop	a
1389                     ; 524     strcpy(localBuffer, "{\"fw\":\"");
1391  0313 96            	ldw	x,sp
1392  0314 1c0002        	addw	x,#OFST-34
1393  0317 90ae01ec      	ldw	y,#L164
1394  031b               L66:
1395  031b 90f6          	ld	a,(y)
1396  031d 905c          	incw	y
1397  031f f7            	ld	(x),a
1398  0320 5c            	incw	x
1399  0321 4d            	tnz	a
1400  0322 26f7          	jrne	L66
1401                     ; 525     strcat(localBuffer, /*"2.4.010"*/ Firmware_Version);
1403  0324 ae01e4        	ldw	x,#L364
1404  0327 89            	pushw	x
1405  0328 96            	ldw	x,sp
1406  0329 1c0004        	addw	x,#OFST-32
1407  032c cd0000        	call	_strcat
1409  032f 85            	popw	x
1410                     ; 526     strcat(localBuffer, "\",\"hw\":\"");
1412  0330 ae01db        	ldw	x,#L564
1413  0333 89            	pushw	x
1414  0334 96            	ldw	x,sp
1415  0335 1c0004        	addw	x,#OFST-32
1416  0338 cd0000        	call	_strcat
1418  033b 85            	popw	x
1419                     ; 527     strcat(localBuffer, /*"0.0.001"*/ Hardware_Version);
1421  033c ae01d3        	ldw	x,#L764
1422  033f 89            	pushw	x
1423  0340 96            	ldw	x,sp
1424  0341 1c0004        	addw	x,#OFST-32
1425  0344 cd0000        	call	_strcat
1427  0347 85            	popw	x
1428                     ; 528     strcat(localBuffer, "\"}");
1430  0348 ae01f4        	ldw	x,#L334
1431  034b 89            	pushw	x
1432  034c 96            	ldw	x,sp
1433  034d 1c0004        	addw	x,#OFST-32
1434  0350 cd0000        	call	_strcat
1436  0353 85            	popw	x
1437                     ; 529     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1439  0354 4b64          	push	#100
1440  0356 ae0000        	ldw	x,#_aunPushed_Data
1441  0359 cd0000        	call	_vClearBuffer
1443  035c 84            	pop	a
1444                     ; 530     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1444                     ; 531                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
1444                     ; 532                                                localBuffer);
1446  035d 96            	ldw	x,sp
1447  035e 1c0002        	addw	x,#OFST-34
1448  0361 89            	pushw	x
1449  0362 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1450  0365 89            	pushw	x
1451  0366 ae0000        	ldw	x,#_aunPushed_Data
1452  0369 cd0000        	call	_ulMQTT_Publish
1454  036c 5b04          	addw	sp,#4
1455  036e b603          	ld	a,c_lreg+3
1456  0370 6b01          	ld	(OFST-35,sp),a
1458                     ; 533     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1460  0372 7b01          	ld	a,(OFST-35,sp)
1461  0374 88            	push	a
1462  0375 ae0000        	ldw	x,#_aunPushed_Data
1463  0378 cd0000        	call	_bSendDataOverTCP
1465  037b 84            	pop	a
1466                     ; 534 }
1469  037c 5b24          	addw	sp,#36
1470  037e 81            	ret
1473                     	switch	.const
1474  0041               L174_localBuffer:
1475  0041 7b22          	dc.b	"{",34
1476  0043 706f77657231  	dc.b	"power1",34
1477  004a 3a22          	dc.b	":",34
1478  004c 313233343536  	dc.b	"123456890.23",34
1479  0059 2c22          	dc.b	",",34
1480  005b 766f6c746167  	dc.b	"voltage1",34
1481  0064 3a22          	dc.b	":",34
1482  0066 3132332e3536  	dc.b	"123.56",34
1483  006d 2c22          	dc.b	",",34
1484  006f 63757272656e  	dc.b	"current1",34
1485  0078 3a22          	dc.b	":",34
1486  007a 31323334352e  	dc.b	"12345.78",34
1487  0083 7d00          	dc.b	"}",0
1488  0085 000000000000  	ds.b	7
1489  008c               L374_temp1:
1490  008c 00            	dc.b	0
1491  008d 000000000000  	ds.b	11
1492  0098               L574_phase_num:
1493  0098 00            	dc.b	0
1494  0099 0000          	ds.b	2
1600                     	switch	.const
1601  009b               L47:
1602  009b 00000064      	dc.l	100
1603                     ; 536 void vMevris_Send_Phase(uint8_t phase_number, uint32_t Watt, uint32_t Voltage, uint32_t Ampere)
1603                     ; 537 {
1604                     	switch	.text
1605  037f               _vMevris_Send_Phase:
1607  037f 88            	push	a
1608  0380 525b          	subw	sp,#91
1609       0000005b      OFST:	set	91
1612                     ; 538     uint8_t localBuffer[75] = "{\"power1\":\"123456890.23\",\"voltage1\":\"123.56\",\"current1\":\"12345.78\"}";
1614  0382 96            	ldw	x,sp
1615  0383 1c0011        	addw	x,#OFST-74
1616  0386 90ae0041      	ldw	y,#L174_localBuffer
1617  038a a64b          	ld	a,#75
1618  038c cd0000        	call	c_xymvx
1620                     ; 539     uint8_t unSendDataLength = 0;
1622                     ; 540     uint8_t temp1[12] = "";
1624  038f 96            	ldw	x,sp
1625  0390 1c0005        	addw	x,#OFST-86
1626  0393 90ae008c      	ldw	y,#L374_temp1
1627  0397 a60c          	ld	a,#12
1628  0399 cd0000        	call	c_xymvx
1630                     ; 541     uint8_t phase_num[3] = "";
1632  039c 96            	ldw	x,sp
1633  039d 1c0002        	addw	x,#OFST-89
1634  03a0 90ae0098      	ldw	y,#L574_phase_num
1635  03a4 a603          	ld	a,#3
1636  03a6 cd0000        	call	c_xymvx
1638                     ; 542     vClearBuffer(localBuffer, 55);
1640  03a9 4b37          	push	#55
1641  03ab 96            	ldw	x,sp
1642  03ac 1c0012        	addw	x,#OFST-73
1643  03af cd0000        	call	_vClearBuffer
1645  03b2 84            	pop	a
1646                     ; 543     sprintf(phase_num, "%d", (uint16_t)phase_number);
1648  03b3 7b5c          	ld	a,(OFST+1,sp)
1649  03b5 5f            	clrw	x
1650  03b6 97            	ld	xl,a
1651  03b7 89            	pushw	x
1652  03b8 ae01d0        	ldw	x,#L155
1653  03bb 89            	pushw	x
1654  03bc 96            	ldw	x,sp
1655  03bd 1c0006        	addw	x,#OFST-85
1656  03c0 cd0000        	call	_sprintf
1658  03c3 5b04          	addw	sp,#4
1659                     ; 544     strcpy(localBuffer, "{\"power");
1661  03c5 96            	ldw	x,sp
1662  03c6 1c0011        	addw	x,#OFST-74
1663  03c9 90ae01c8      	ldw	y,#L355
1664  03cd               L27:
1665  03cd 90f6          	ld	a,(y)
1666  03cf 905c          	incw	y
1667  03d1 f7            	ld	(x),a
1668  03d2 5c            	incw	x
1669  03d3 4d            	tnz	a
1670  03d4 26f7          	jrne	L27
1671                     ; 545     strcat(localBuffer, phase_num);
1673  03d6 96            	ldw	x,sp
1674  03d7 1c0002        	addw	x,#OFST-89
1675  03da 89            	pushw	x
1676  03db 96            	ldw	x,sp
1677  03dc 1c0013        	addw	x,#OFST-72
1678  03df cd0000        	call	_strcat
1680  03e2 85            	popw	x
1681                     ; 546     strcat(localBuffer, "\":\"");
1683  03e3 ae01c4        	ldw	x,#L555
1684  03e6 89            	pushw	x
1685  03e7 96            	ldw	x,sp
1686  03e8 1c0013        	addw	x,#OFST-72
1687  03eb cd0000        	call	_strcat
1689  03ee 85            	popw	x
1690                     ; 547     sprintf(temp1, "%ld", Watt / 100);
1692  03ef 96            	ldw	x,sp
1693  03f0 1c005f        	addw	x,#OFST+4
1694  03f3 cd0000        	call	c_ltor
1696  03f6 ae009b        	ldw	x,#L47
1697  03f9 cd0000        	call	c_ludv
1699  03fc be02          	ldw	x,c_lreg+2
1700  03fe 89            	pushw	x
1701  03ff be00          	ldw	x,c_lreg
1702  0401 89            	pushw	x
1703  0402 ae01c0        	ldw	x,#L755
1704  0405 89            	pushw	x
1705  0406 96            	ldw	x,sp
1706  0407 1c000b        	addw	x,#OFST-80
1707  040a cd0000        	call	_sprintf
1709  040d 5b06          	addw	sp,#6
1710                     ; 548     strcat(localBuffer, temp1);
1712  040f 96            	ldw	x,sp
1713  0410 1c0005        	addw	x,#OFST-86
1714  0413 89            	pushw	x
1715  0414 96            	ldw	x,sp
1716  0415 1c0013        	addw	x,#OFST-72
1717  0418 cd0000        	call	_strcat
1719  041b 85            	popw	x
1720                     ; 549     strcat(localBuffer, ".");
1722  041c ae01be        	ldw	x,#L165
1723  041f 89            	pushw	x
1724  0420 96            	ldw	x,sp
1725  0421 1c0013        	addw	x,#OFST-72
1726  0424 cd0000        	call	_strcat
1728  0427 85            	popw	x
1729                     ; 550     sprintf(temp1, "%ld", Watt % 100);
1731  0428 96            	ldw	x,sp
1732  0429 1c005f        	addw	x,#OFST+4
1733  042c cd0000        	call	c_ltor
1735  042f ae009b        	ldw	x,#L47
1736  0432 cd0000        	call	c_lumd
1738  0435 be02          	ldw	x,c_lreg+2
1739  0437 89            	pushw	x
1740  0438 be00          	ldw	x,c_lreg
1741  043a 89            	pushw	x
1742  043b ae01c0        	ldw	x,#L755
1743  043e 89            	pushw	x
1744  043f 96            	ldw	x,sp
1745  0440 1c000b        	addw	x,#OFST-80
1746  0443 cd0000        	call	_sprintf
1748  0446 5b06          	addw	sp,#6
1749                     ; 551     strcat(localBuffer, temp1);
1751  0448 96            	ldw	x,sp
1752  0449 1c0005        	addw	x,#OFST-86
1753  044c 89            	pushw	x
1754  044d 96            	ldw	x,sp
1755  044e 1c0013        	addw	x,#OFST-72
1756  0451 cd0000        	call	_strcat
1758  0454 85            	popw	x
1759                     ; 553     strcat(localBuffer, "\",\"voltage");
1761  0455 ae01b3        	ldw	x,#L365
1762  0458 89            	pushw	x
1763  0459 96            	ldw	x,sp
1764  045a 1c0013        	addw	x,#OFST-72
1765  045d cd0000        	call	_strcat
1767  0460 85            	popw	x
1768                     ; 554     strcat(localBuffer, phase_num);
1770  0461 96            	ldw	x,sp
1771  0462 1c0002        	addw	x,#OFST-89
1772  0465 89            	pushw	x
1773  0466 96            	ldw	x,sp
1774  0467 1c0013        	addw	x,#OFST-72
1775  046a cd0000        	call	_strcat
1777  046d 85            	popw	x
1778                     ; 555     strcat(localBuffer, "\":\"");
1780  046e ae01c4        	ldw	x,#L555
1781  0471 89            	pushw	x
1782  0472 96            	ldw	x,sp
1783  0473 1c0013        	addw	x,#OFST-72
1784  0476 cd0000        	call	_strcat
1786  0479 85            	popw	x
1787                     ; 556     sprintf(temp1, "%ld", Voltage / 100);
1789  047a 96            	ldw	x,sp
1790  047b 1c0063        	addw	x,#OFST+8
1791  047e cd0000        	call	c_ltor
1793  0481 ae009b        	ldw	x,#L47
1794  0484 cd0000        	call	c_ludv
1796  0487 be02          	ldw	x,c_lreg+2
1797  0489 89            	pushw	x
1798  048a be00          	ldw	x,c_lreg
1799  048c 89            	pushw	x
1800  048d ae01c0        	ldw	x,#L755
1801  0490 89            	pushw	x
1802  0491 96            	ldw	x,sp
1803  0492 1c000b        	addw	x,#OFST-80
1804  0495 cd0000        	call	_sprintf
1806  0498 5b06          	addw	sp,#6
1807                     ; 557     strcat(localBuffer, temp1);
1809  049a 96            	ldw	x,sp
1810  049b 1c0005        	addw	x,#OFST-86
1811  049e 89            	pushw	x
1812  049f 96            	ldw	x,sp
1813  04a0 1c0013        	addw	x,#OFST-72
1814  04a3 cd0000        	call	_strcat
1816  04a6 85            	popw	x
1817                     ; 558     strcat(localBuffer, ".");
1819  04a7 ae01be        	ldw	x,#L165
1820  04aa 89            	pushw	x
1821  04ab 96            	ldw	x,sp
1822  04ac 1c0013        	addw	x,#OFST-72
1823  04af cd0000        	call	_strcat
1825  04b2 85            	popw	x
1826                     ; 559     sprintf(temp1, "%ld", Voltage % 100);
1828  04b3 96            	ldw	x,sp
1829  04b4 1c0063        	addw	x,#OFST+8
1830  04b7 cd0000        	call	c_ltor
1832  04ba ae009b        	ldw	x,#L47
1833  04bd cd0000        	call	c_lumd
1835  04c0 be02          	ldw	x,c_lreg+2
1836  04c2 89            	pushw	x
1837  04c3 be00          	ldw	x,c_lreg
1838  04c5 89            	pushw	x
1839  04c6 ae01c0        	ldw	x,#L755
1840  04c9 89            	pushw	x
1841  04ca 96            	ldw	x,sp
1842  04cb 1c000b        	addw	x,#OFST-80
1843  04ce cd0000        	call	_sprintf
1845  04d1 5b06          	addw	sp,#6
1846                     ; 560     strcat(localBuffer, temp1);
1848  04d3 96            	ldw	x,sp
1849  04d4 1c0005        	addw	x,#OFST-86
1850  04d7 89            	pushw	x
1851  04d8 96            	ldw	x,sp
1852  04d9 1c0013        	addw	x,#OFST-72
1853  04dc cd0000        	call	_strcat
1855  04df 85            	popw	x
1856                     ; 562     strcat(localBuffer, "\",\"current");
1858  04e0 ae01a8        	ldw	x,#L565
1859  04e3 89            	pushw	x
1860  04e4 96            	ldw	x,sp
1861  04e5 1c0013        	addw	x,#OFST-72
1862  04e8 cd0000        	call	_strcat
1864  04eb 85            	popw	x
1865                     ; 563     strcat(localBuffer, phase_num);
1867  04ec 96            	ldw	x,sp
1868  04ed 1c0002        	addw	x,#OFST-89
1869  04f0 89            	pushw	x
1870  04f1 96            	ldw	x,sp
1871  04f2 1c0013        	addw	x,#OFST-72
1872  04f5 cd0000        	call	_strcat
1874  04f8 85            	popw	x
1875                     ; 564     strcat(localBuffer, "\":\"");
1877  04f9 ae01c4        	ldw	x,#L555
1878  04fc 89            	pushw	x
1879  04fd 96            	ldw	x,sp
1880  04fe 1c0013        	addw	x,#OFST-72
1881  0501 cd0000        	call	_strcat
1883  0504 85            	popw	x
1884                     ; 565     sprintf(temp1, "%ld", Ampere / 100);
1886  0505 96            	ldw	x,sp
1887  0506 1c0067        	addw	x,#OFST+12
1888  0509 cd0000        	call	c_ltor
1890  050c ae009b        	ldw	x,#L47
1891  050f cd0000        	call	c_ludv
1893  0512 be02          	ldw	x,c_lreg+2
1894  0514 89            	pushw	x
1895  0515 be00          	ldw	x,c_lreg
1896  0517 89            	pushw	x
1897  0518 ae01c0        	ldw	x,#L755
1898  051b 89            	pushw	x
1899  051c 96            	ldw	x,sp
1900  051d 1c000b        	addw	x,#OFST-80
1901  0520 cd0000        	call	_sprintf
1903  0523 5b06          	addw	sp,#6
1904                     ; 566     strcat(localBuffer, temp1);
1906  0525 96            	ldw	x,sp
1907  0526 1c0005        	addw	x,#OFST-86
1908  0529 89            	pushw	x
1909  052a 96            	ldw	x,sp
1910  052b 1c0013        	addw	x,#OFST-72
1911  052e cd0000        	call	_strcat
1913  0531 85            	popw	x
1914                     ; 567     strcat(localBuffer, ".");
1916  0532 ae01be        	ldw	x,#L165
1917  0535 89            	pushw	x
1918  0536 96            	ldw	x,sp
1919  0537 1c0013        	addw	x,#OFST-72
1920  053a cd0000        	call	_strcat
1922  053d 85            	popw	x
1923                     ; 568     sprintf(temp1, "%ld", Ampere % 100);
1925  053e 96            	ldw	x,sp
1926  053f 1c0067        	addw	x,#OFST+12
1927  0542 cd0000        	call	c_ltor
1929  0545 ae009b        	ldw	x,#L47
1930  0548 cd0000        	call	c_lumd
1932  054b be02          	ldw	x,c_lreg+2
1933  054d 89            	pushw	x
1934  054e be00          	ldw	x,c_lreg
1935  0550 89            	pushw	x
1936  0551 ae01c0        	ldw	x,#L755
1937  0554 89            	pushw	x
1938  0555 96            	ldw	x,sp
1939  0556 1c000b        	addw	x,#OFST-80
1940  0559 cd0000        	call	_sprintf
1942  055c 5b06          	addw	sp,#6
1943                     ; 569     strcat(localBuffer, temp1);
1945  055e 96            	ldw	x,sp
1946  055f 1c0005        	addw	x,#OFST-86
1947  0562 89            	pushw	x
1948  0563 96            	ldw	x,sp
1949  0564 1c0013        	addw	x,#OFST-72
1950  0567 cd0000        	call	_strcat
1952  056a 85            	popw	x
1953                     ; 570     strcat(localBuffer, "\"}");
1955  056b ae01f4        	ldw	x,#L334
1956  056e 89            	pushw	x
1957  056f 96            	ldw	x,sp
1958  0570 1c0013        	addw	x,#OFST-72
1959  0573 cd0000        	call	_strcat
1961  0576 85            	popw	x
1962                     ; 572     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1964  0577 4b64          	push	#100
1965  0579 ae0000        	ldw	x,#_aunPushed_Data
1966  057c cd0000        	call	_vClearBuffer
1968  057f 84            	pop	a
1969                     ; 573     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1969                     ; 574                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
1969                     ; 575                                                localBuffer);
1971  0580 96            	ldw	x,sp
1972  0581 1c0011        	addw	x,#OFST-74
1973  0584 89            	pushw	x
1974  0585 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1975  0588 89            	pushw	x
1976  0589 ae0000        	ldw	x,#_aunPushed_Data
1977  058c cd0000        	call	_ulMQTT_Publish
1979  058f 5b04          	addw	sp,#4
1980  0591 b603          	ld	a,c_lreg+3
1981  0593 6b01          	ld	(OFST-90,sp),a
1983                     ; 576     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1985  0595 7b01          	ld	a,(OFST-90,sp)
1986  0597 88            	push	a
1987  0598 ae0000        	ldw	x,#_aunPushed_Data
1988  059b cd0000        	call	_bSendDataOverTCP
1990  059e 84            	pop	a
1991                     ; 577 }
1994  059f 5b5c          	addw	sp,#92
1995  05a1 81            	ret
1998                     	switch	.const
1999  009f               L765_localBuffer:
2000  009f 7b22          	dc.b	"{",34
2001  00a1 626174746572  	dc.b	"battery",34
2002  00a9 3a22          	dc.b	":",34
2003  00ab 313233343536  	dc.b	"123456.89",34
2004  00b5 7d00          	dc.b	"}",0
2005  00b7 000000000000  	ds.b	6
2006  00bd               L175_temp1:
2007  00bd 00            	dc.b	0
2008  00be 000000000000  	ds.b	9
2070                     ; 687 void vMevris_Send_BatteryVolt()
2070                     ; 688 {
2071                     	switch	.text
2072  05a2               _vMevris_Send_BatteryVolt:
2074  05a2 5229          	subw	sp,#41
2075       00000029      OFST:	set	41
2078                     ; 689     uint8_t localBuffer[30] = "{\"battery\":\"123456.89\"}";
2080  05a4 96            	ldw	x,sp
2081  05a5 1c000c        	addw	x,#OFST-29
2082  05a8 90ae009f      	ldw	y,#L765_localBuffer
2083  05ac a61e          	ld	a,#30
2084  05ae cd0000        	call	c_xymvx
2086                     ; 690     uint8_t unSendDataLength = 0;
2088                     ; 691     uint8_t temp1[10] = "";
2090  05b1 96            	ldw	x,sp
2091  05b2 1c0002        	addw	x,#OFST-39
2092  05b5 90ae00bd      	ldw	y,#L175_temp1
2093  05b9 a60a          	ld	a,#10
2094  05bb cd0000        	call	c_xymvx
2096                     ; 692     vClearBuffer(localBuffer, 30);
2098  05be 4b1e          	push	#30
2099  05c0 96            	ldw	x,sp
2100  05c1 1c000d        	addw	x,#OFST-28
2101  05c4 cd0000        	call	_vClearBuffer
2103  05c7 84            	pop	a
2104                     ; 693     strcpy(localBuffer, "{\"battery\":\"");
2106  05c8 96            	ldw	x,sp
2107  05c9 1c000c        	addw	x,#OFST-29
2108  05cc 90ae019b      	ldw	y,#L126
2109  05d0               L001:
2110  05d0 90f6          	ld	a,(y)
2111  05d2 905c          	incw	y
2112  05d4 f7            	ld	(x),a
2113  05d5 5c            	incw	x
2114  05d6 4d            	tnz	a
2115  05d7 26f7          	jrne	L001
2116                     ; 695     sprintf(temp1, "%ld", batVolt / 100);
2118  05d9 ae0000        	ldw	x,#_batVolt
2119  05dc cd0000        	call	c_ltor
2121  05df ae009b        	ldw	x,#L47
2122  05e2 cd0000        	call	c_ludv
2124  05e5 be02          	ldw	x,c_lreg+2
2125  05e7 89            	pushw	x
2126  05e8 be00          	ldw	x,c_lreg
2127  05ea 89            	pushw	x
2128  05eb ae01c0        	ldw	x,#L755
2129  05ee 89            	pushw	x
2130  05ef 96            	ldw	x,sp
2131  05f0 1c0008        	addw	x,#OFST-33
2132  05f3 cd0000        	call	_sprintf
2134  05f6 5b06          	addw	sp,#6
2135                     ; 696     strcat(localBuffer, temp1);
2137  05f8 96            	ldw	x,sp
2138  05f9 1c0002        	addw	x,#OFST-39
2139  05fc 89            	pushw	x
2140  05fd 96            	ldw	x,sp
2141  05fe 1c000e        	addw	x,#OFST-27
2142  0601 cd0000        	call	_strcat
2144  0604 85            	popw	x
2145                     ; 697     strcat(localBuffer, ".");
2147  0605 ae01be        	ldw	x,#L165
2148  0608 89            	pushw	x
2149  0609 96            	ldw	x,sp
2150  060a 1c000e        	addw	x,#OFST-27
2151  060d cd0000        	call	_strcat
2153  0610 85            	popw	x
2154                     ; 698     sprintf(temp1, "%ld", batVolt % 100);
2156  0611 ae0000        	ldw	x,#_batVolt
2157  0614 cd0000        	call	c_ltor
2159  0617 ae009b        	ldw	x,#L47
2160  061a cd0000        	call	c_lumd
2162  061d be02          	ldw	x,c_lreg+2
2163  061f 89            	pushw	x
2164  0620 be00          	ldw	x,c_lreg
2165  0622 89            	pushw	x
2166  0623 ae01c0        	ldw	x,#L755
2167  0626 89            	pushw	x
2168  0627 96            	ldw	x,sp
2169  0628 1c0008        	addw	x,#OFST-33
2170  062b cd0000        	call	_sprintf
2172  062e 5b06          	addw	sp,#6
2173                     ; 699     strcat(localBuffer, temp1);
2175  0630 96            	ldw	x,sp
2176  0631 1c0002        	addw	x,#OFST-39
2177  0634 89            	pushw	x
2178  0635 96            	ldw	x,sp
2179  0636 1c000e        	addw	x,#OFST-27
2180  0639 cd0000        	call	_strcat
2182  063c 85            	popw	x
2183                     ; 700     strcat(localBuffer, "\"}");
2185  063d ae01f4        	ldw	x,#L334
2186  0640 89            	pushw	x
2187  0641 96            	ldw	x,sp
2188  0642 1c000e        	addw	x,#OFST-27
2189  0645 cd0000        	call	_strcat
2191  0648 85            	popw	x
2192                     ; 701     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2194  0649 4b64          	push	#100
2195  064b ae0000        	ldw	x,#_aunPushed_Data
2196  064e cd0000        	call	_vClearBuffer
2198  0651 84            	pop	a
2199                     ; 702     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2199                     ; 703                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2199                     ; 704                                                localBuffer);
2201  0652 96            	ldw	x,sp
2202  0653 1c000c        	addw	x,#OFST-29
2203  0656 89            	pushw	x
2204  0657 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2205  065a 89            	pushw	x
2206  065b ae0000        	ldw	x,#_aunPushed_Data
2207  065e cd0000        	call	_ulMQTT_Publish
2209  0661 5b04          	addw	sp,#4
2210  0663 b603          	ld	a,c_lreg+3
2211  0665 6b01          	ld	(OFST-40,sp),a
2213                     ; 705     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2215  0667 7b01          	ld	a,(OFST-40,sp)
2216  0669 88            	push	a
2217  066a ae0000        	ldw	x,#_aunPushed_Data
2218  066d cd0000        	call	_bSendDataOverTCP
2220  0670 84            	pop	a
2221                     ; 706 }
2224  0671 5b29          	addw	sp,#41
2225  0673 81            	ret
2228                     	switch	.const
2229  00c7               L326_localBuffer:
2230  00c7 7b22          	dc.b	"{",34
2231  00c9 526164696174  	dc.b	"RadiatorTemperatur"
2232  00db 6522          	dc.b	"e",34
2233  00dd 3a22          	dc.b	":",34
2234  00df 313233343536  	dc.b	"123456.89",34
2235  00e9 7d00          	dc.b	"}",0
2236  00eb 00000000      	ds.b	4
2237  00ef               L526_temp1:
2238  00ef 00            	dc.b	0
2239  00f0 000000000000  	ds.b	14
2310                     ; 708 void vMevris_Send_RadiatorTemp()
2310                     ; 709 {
2311                     	switch	.text
2312  0674               _vMevris_Send_RadiatorTemp:
2314  0674 523c          	subw	sp,#60
2315       0000003c      OFST:	set	60
2318                     ; 710     uint8_t localBuffer[40] = "{\"RadiatorTemperature\":\"123456.89\"}";
2320  0676 96            	ldw	x,sp
2321  0677 1c0015        	addw	x,#OFST-39
2322  067a 90ae00c7      	ldw	y,#L326_localBuffer
2323  067e a628          	ld	a,#40
2324  0680 cd0000        	call	c_xymvx
2326                     ; 711     uint8_t unSendDataLength = 0;
2328                     ; 712     uint8_t temp1[15] = "";
2330  0683 96            	ldw	x,sp
2331  0684 1c0006        	addw	x,#OFST-54
2332  0687 90ae00ef      	ldw	y,#L526_temp1
2333  068b a60f          	ld	a,#15
2334  068d cd0000        	call	c_xymvx
2336                     ; 713     uint32_t myVar = 0;
2338                     ; 714     vClearBuffer(localBuffer, 40);
2340  0690 4b28          	push	#40
2341  0692 96            	ldw	x,sp
2342  0693 1c0016        	addw	x,#OFST-38
2343  0696 cd0000        	call	_vClearBuffer
2345  0699 84            	pop	a
2346                     ; 715     strcpy(localBuffer, "{\"RadiatorTemperature\":\"");
2348  069a 96            	ldw	x,sp
2349  069b 1c0015        	addw	x,#OFST-39
2350  069e 90ae0182      	ldw	y,#L166
2351  06a2               L401:
2352  06a2 90f6          	ld	a,(y)
2353  06a4 905c          	incw	y
2354  06a6 f7            	ld	(x),a
2355  06a7 5c            	incw	x
2356  06a8 4d            	tnz	a
2357  06a9 26f7          	jrne	L401
2358                     ; 716     myVar = (uint32_t)(Temperature1 * 100);
2360  06ab ae0000        	ldw	x,#_Temperature1
2361  06ae cd0000        	call	c_ltor
2363  06b1 ae017e        	ldw	x,#L766
2364  06b4 cd0000        	call	c_fmul
2366  06b7 cd0000        	call	c_ftol
2368  06ba 96            	ldw	x,sp
2369  06bb 1c0002        	addw	x,#OFST-58
2370  06be cd0000        	call	c_rtol
2373                     ; 717     sprintf(temp1, "%ld", myVar / 100);
2375  06c1 96            	ldw	x,sp
2376  06c2 1c0002        	addw	x,#OFST-58
2377  06c5 cd0000        	call	c_ltor
2379  06c8 ae009b        	ldw	x,#L47
2380  06cb cd0000        	call	c_ludv
2382  06ce be02          	ldw	x,c_lreg+2
2383  06d0 89            	pushw	x
2384  06d1 be00          	ldw	x,c_lreg
2385  06d3 89            	pushw	x
2386  06d4 ae01c0        	ldw	x,#L755
2387  06d7 89            	pushw	x
2388  06d8 96            	ldw	x,sp
2389  06d9 1c000c        	addw	x,#OFST-48
2390  06dc cd0000        	call	_sprintf
2392  06df 5b06          	addw	sp,#6
2393                     ; 718     strcat(localBuffer, temp1);
2395  06e1 96            	ldw	x,sp
2396  06e2 1c0006        	addw	x,#OFST-54
2397  06e5 89            	pushw	x
2398  06e6 96            	ldw	x,sp
2399  06e7 1c0017        	addw	x,#OFST-37
2400  06ea cd0000        	call	_strcat
2402  06ed 85            	popw	x
2403                     ; 719     strcat(localBuffer, ".");
2405  06ee ae01be        	ldw	x,#L165
2406  06f1 89            	pushw	x
2407  06f2 96            	ldw	x,sp
2408  06f3 1c0017        	addw	x,#OFST-37
2409  06f6 cd0000        	call	_strcat
2411  06f9 85            	popw	x
2412                     ; 720     sprintf(temp1, "%ld", myVar % 100);
2414  06fa 96            	ldw	x,sp
2415  06fb 1c0002        	addw	x,#OFST-58
2416  06fe cd0000        	call	c_ltor
2418  0701 ae009b        	ldw	x,#L47
2419  0704 cd0000        	call	c_lumd
2421  0707 be02          	ldw	x,c_lreg+2
2422  0709 89            	pushw	x
2423  070a be00          	ldw	x,c_lreg
2424  070c 89            	pushw	x
2425  070d ae01c0        	ldw	x,#L755
2426  0710 89            	pushw	x
2427  0711 96            	ldw	x,sp
2428  0712 1c000c        	addw	x,#OFST-48
2429  0715 cd0000        	call	_sprintf
2431  0718 5b06          	addw	sp,#6
2432                     ; 721     strcat(localBuffer, temp1);
2434  071a 96            	ldw	x,sp
2435  071b 1c0006        	addw	x,#OFST-54
2436  071e 89            	pushw	x
2437  071f 96            	ldw	x,sp
2438  0720 1c0017        	addw	x,#OFST-37
2439  0723 cd0000        	call	_strcat
2441  0726 85            	popw	x
2442                     ; 723     strcat(localBuffer, "\"}");
2444  0727 ae01f4        	ldw	x,#L334
2445  072a 89            	pushw	x
2446  072b 96            	ldw	x,sp
2447  072c 1c0017        	addw	x,#OFST-37
2448  072f cd0000        	call	_strcat
2450  0732 85            	popw	x
2451                     ; 724     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2453  0733 4b64          	push	#100
2454  0735 ae0000        	ldw	x,#_aunPushed_Data
2455  0738 cd0000        	call	_vClearBuffer
2457  073b 84            	pop	a
2458                     ; 725     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2458                     ; 726                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2458                     ; 727                                                localBuffer);
2460  073c 96            	ldw	x,sp
2461  073d 1c0015        	addw	x,#OFST-39
2462  0740 89            	pushw	x
2463  0741 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2464  0744 89            	pushw	x
2465  0745 ae0000        	ldw	x,#_aunPushed_Data
2466  0748 cd0000        	call	_ulMQTT_Publish
2468  074b 5b04          	addw	sp,#4
2469  074d b603          	ld	a,c_lreg+3
2470  074f 6b01          	ld	(OFST-59,sp),a
2472                     ; 728     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2474  0751 7b01          	ld	a,(OFST-59,sp)
2475  0753 88            	push	a
2476  0754 ae0000        	ldw	x,#_aunPushed_Data
2477  0757 cd0000        	call	_bSendDataOverTCP
2479  075a 84            	pop	a
2480                     ; 729 }
2483  075b 5b3c          	addw	sp,#60
2484  075d 81            	ret
2487                     	switch	.const
2488  00fe               L376_localBuffer:
2489  00fe 7b22          	dc.b	"{",34
2490  0100 456e67696e65  	dc.b	"EngineTemperature",34
2491  0112 3a22          	dc.b	":",34
2492  0114 313233343536  	dc.b	"123456.89",34
2493  011e 7d00          	dc.b	"}",0
2494  0120 000000000000  	ds.b	6
2495  0126               L576_temp1:
2496  0126 00            	dc.b	0
2497  0127 000000000000  	ds.b	14
2568                     ; 731 void vMevris_Send_EngineTemp()
2568                     ; 732 {
2569                     	switch	.text
2570  075e               _vMevris_Send_EngineTemp:
2572  075e 523c          	subw	sp,#60
2573       0000003c      OFST:	set	60
2576                     ; 733     uint8_t localBuffer[40] = "{\"EngineTemperature\":\"123456.89\"}";
2578  0760 96            	ldw	x,sp
2579  0761 1c0015        	addw	x,#OFST-39
2580  0764 90ae00fe      	ldw	y,#L376_localBuffer
2581  0768 a628          	ld	a,#40
2582  076a cd0000        	call	c_xymvx
2584                     ; 734     uint8_t unSendDataLength = 0;
2586                     ; 735     uint8_t temp1[15] = "";
2588  076d 96            	ldw	x,sp
2589  076e 1c0006        	addw	x,#OFST-54
2590  0771 90ae0126      	ldw	y,#L576_temp1
2591  0775 a60f          	ld	a,#15
2592  0777 cd0000        	call	c_xymvx
2594                     ; 736     uint32_t myVar = 0;
2596                     ; 737     vClearBuffer(localBuffer, 40);
2598  077a 4b28          	push	#40
2599  077c 96            	ldw	x,sp
2600  077d 1c0016        	addw	x,#OFST-38
2601  0780 cd0000        	call	_vClearBuffer
2603  0783 84            	pop	a
2604                     ; 738     strcpy(localBuffer, "{\"EngineTemperature\":\"");
2606  0784 96            	ldw	x,sp
2607  0785 1c0015        	addw	x,#OFST-39
2608  0788 90ae0167      	ldw	y,#L137
2609  078c               L011:
2610  078c 90f6          	ld	a,(y)
2611  078e 905c          	incw	y
2612  0790 f7            	ld	(x),a
2613  0791 5c            	incw	x
2614  0792 4d            	tnz	a
2615  0793 26f7          	jrne	L011
2616                     ; 739     myVar = (uint32_t)(Temperature2 * 100);
2618  0795 ae0000        	ldw	x,#_Temperature2
2619  0798 cd0000        	call	c_ltor
2621  079b ae017e        	ldw	x,#L766
2622  079e cd0000        	call	c_fmul
2624  07a1 cd0000        	call	c_ftol
2626  07a4 96            	ldw	x,sp
2627  07a5 1c0002        	addw	x,#OFST-58
2628  07a8 cd0000        	call	c_rtol
2631                     ; 740     sprintf(temp1, "%ld", myVar / 100);
2633  07ab 96            	ldw	x,sp
2634  07ac 1c0002        	addw	x,#OFST-58
2635  07af cd0000        	call	c_ltor
2637  07b2 ae009b        	ldw	x,#L47
2638  07b5 cd0000        	call	c_ludv
2640  07b8 be02          	ldw	x,c_lreg+2
2641  07ba 89            	pushw	x
2642  07bb be00          	ldw	x,c_lreg
2643  07bd 89            	pushw	x
2644  07be ae01c0        	ldw	x,#L755
2645  07c1 89            	pushw	x
2646  07c2 96            	ldw	x,sp
2647  07c3 1c000c        	addw	x,#OFST-48
2648  07c6 cd0000        	call	_sprintf
2650  07c9 5b06          	addw	sp,#6
2651                     ; 741     strcat(localBuffer, temp1);
2653  07cb 96            	ldw	x,sp
2654  07cc 1c0006        	addw	x,#OFST-54
2655  07cf 89            	pushw	x
2656  07d0 96            	ldw	x,sp
2657  07d1 1c0017        	addw	x,#OFST-37
2658  07d4 cd0000        	call	_strcat
2660  07d7 85            	popw	x
2661                     ; 742     strcat(localBuffer, ".");
2663  07d8 ae01be        	ldw	x,#L165
2664  07db 89            	pushw	x
2665  07dc 96            	ldw	x,sp
2666  07dd 1c0017        	addw	x,#OFST-37
2667  07e0 cd0000        	call	_strcat
2669  07e3 85            	popw	x
2670                     ; 743     sprintf(temp1, "%ld", myVar % 100);
2672  07e4 96            	ldw	x,sp
2673  07e5 1c0002        	addw	x,#OFST-58
2674  07e8 cd0000        	call	c_ltor
2676  07eb ae009b        	ldw	x,#L47
2677  07ee cd0000        	call	c_lumd
2679  07f1 be02          	ldw	x,c_lreg+2
2680  07f3 89            	pushw	x
2681  07f4 be00          	ldw	x,c_lreg
2682  07f6 89            	pushw	x
2683  07f7 ae01c0        	ldw	x,#L755
2684  07fa 89            	pushw	x
2685  07fb 96            	ldw	x,sp
2686  07fc 1c000c        	addw	x,#OFST-48
2687  07ff cd0000        	call	_sprintf
2689  0802 5b06          	addw	sp,#6
2690                     ; 744     strcat(localBuffer, temp1);
2692  0804 96            	ldw	x,sp
2693  0805 1c0006        	addw	x,#OFST-54
2694  0808 89            	pushw	x
2695  0809 96            	ldw	x,sp
2696  080a 1c0017        	addw	x,#OFST-37
2697  080d cd0000        	call	_strcat
2699  0810 85            	popw	x
2700                     ; 746     strcat(localBuffer, "\"}");
2702  0811 ae01f4        	ldw	x,#L334
2703  0814 89            	pushw	x
2704  0815 96            	ldw	x,sp
2705  0816 1c0017        	addw	x,#OFST-37
2706  0819 cd0000        	call	_strcat
2708  081c 85            	popw	x
2709                     ; 747     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2711  081d 4b64          	push	#100
2712  081f ae0000        	ldw	x,#_aunPushed_Data
2713  0822 cd0000        	call	_vClearBuffer
2715  0825 84            	pop	a
2716                     ; 748     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2716                     ; 749                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2716                     ; 750                                                localBuffer);
2718  0826 96            	ldw	x,sp
2719  0827 1c0015        	addw	x,#OFST-39
2720  082a 89            	pushw	x
2721  082b ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2722  082e 89            	pushw	x
2723  082f ae0000        	ldw	x,#_aunPushed_Data
2724  0832 cd0000        	call	_ulMQTT_Publish
2726  0835 5b04          	addw	sp,#4
2727  0837 b603          	ld	a,c_lreg+3
2728  0839 6b01          	ld	(OFST-59,sp),a
2730                     ; 751     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2732  083b 7b01          	ld	a,(OFST-59,sp)
2733  083d 88            	push	a
2734  083e ae0000        	ldw	x,#_aunPushed_Data
2735  0841 cd0000        	call	_bSendDataOverTCP
2737  0844 84            	pop	a
2738                     ; 752 }
2741  0845 5b3c          	addw	sp,#60
2742  0847 81            	ret
2745                     	switch	.const
2746  0135               L337_localBuffer:
2747  0135 7b22          	dc.b	"{",34
2748  0137 6675656c22    	dc.b	"fuel",34
2749  013c 3a22          	dc.b	":",34
2750  013e 313233343536  	dc.b	"123456.89",34
2751  0148 7d00          	dc.b	"}",0
2752  014a 000000000000  	ds.b	9
2753  0153               L537_temp1:
2754  0153 00            	dc.b	0
2755  0154 000000000000  	ds.b	9
2817                     ; 754 void vMevris_Send_FuelLevel()
2817                     ; 755 {
2818                     	switch	.text
2819  0848               _vMevris_Send_FuelLevel:
2821  0848 5229          	subw	sp,#41
2822       00000029      OFST:	set	41
2825                     ; 756     uint8_t localBuffer[30] = "{\"fuel\":\"123456.89\"}";
2827  084a 96            	ldw	x,sp
2828  084b 1c000c        	addw	x,#OFST-29
2829  084e 90ae0135      	ldw	y,#L337_localBuffer
2830  0852 a61e          	ld	a,#30
2831  0854 cd0000        	call	c_xymvx
2833                     ; 757     uint8_t unSendDataLength = 0;
2835                     ; 758     uint8_t temp1[10] = "";
2837  0857 96            	ldw	x,sp
2838  0858 1c0002        	addw	x,#OFST-39
2839  085b 90ae0153      	ldw	y,#L537_temp1
2840  085f a60a          	ld	a,#10
2841  0861 cd0000        	call	c_xymvx
2843                     ; 759     vClearBuffer(localBuffer, 30);
2845  0864 4b1e          	push	#30
2846  0866 96            	ldw	x,sp
2847  0867 1c000d        	addw	x,#OFST-28
2848  086a cd0000        	call	_vClearBuffer
2850  086d 84            	pop	a
2851                     ; 760     strcpy(localBuffer, "{\"fuel\":\"");
2853  086e 96            	ldw	x,sp
2854  086f 1c000c        	addw	x,#OFST-29
2855  0872 90ae015d      	ldw	y,#L567
2856  0876               L411:
2857  0876 90f6          	ld	a,(y)
2858  0878 905c          	incw	y
2859  087a f7            	ld	(x),a
2860  087b 5c            	incw	x
2861  087c 4d            	tnz	a
2862  087d 26f7          	jrne	L411
2863                     ; 761     sprintf(temp1, "%ld", Fuellevel);
2865  087f ce0002        	ldw	x,_Fuellevel+2
2866  0882 89            	pushw	x
2867  0883 ce0000        	ldw	x,_Fuellevel
2868  0886 89            	pushw	x
2869  0887 ae01c0        	ldw	x,#L755
2870  088a 89            	pushw	x
2871  088b 96            	ldw	x,sp
2872  088c 1c0008        	addw	x,#OFST-33
2873  088f cd0000        	call	_sprintf
2875  0892 5b06          	addw	sp,#6
2876                     ; 762     strcat(localBuffer, temp1);
2878  0894 96            	ldw	x,sp
2879  0895 1c0002        	addw	x,#OFST-39
2880  0898 89            	pushw	x
2881  0899 96            	ldw	x,sp
2882  089a 1c000e        	addw	x,#OFST-27
2883  089d cd0000        	call	_strcat
2885  08a0 85            	popw	x
2886                     ; 763     strcat(localBuffer, "\"}");
2888  08a1 ae01f4        	ldw	x,#L334
2889  08a4 89            	pushw	x
2890  08a5 96            	ldw	x,sp
2891  08a6 1c000e        	addw	x,#OFST-27
2892  08a9 cd0000        	call	_strcat
2894  08ac 85            	popw	x
2895                     ; 764     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2897  08ad 4b64          	push	#100
2898  08af ae0000        	ldw	x,#_aunPushed_Data
2899  08b2 cd0000        	call	_vClearBuffer
2901  08b5 84            	pop	a
2902                     ; 765     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2902                     ; 766                                                aunMQTT_Publish_Topic/*punGet_Event_Topic()*/,
2902                     ; 767                                                localBuffer);
2904  08b6 96            	ldw	x,sp
2905  08b7 1c000c        	addw	x,#OFST-29
2906  08ba 89            	pushw	x
2907  08bb ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2908  08be 89            	pushw	x
2909  08bf ae0000        	ldw	x,#_aunPushed_Data
2910  08c2 cd0000        	call	_ulMQTT_Publish
2912  08c5 5b04          	addw	sp,#4
2913  08c7 b603          	ld	a,c_lreg+3
2914  08c9 6b01          	ld	(OFST-40,sp),a
2916                     ; 768     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2918  08cb 7b01          	ld	a,(OFST-40,sp)
2919  08cd 88            	push	a
2920  08ce ae0000        	ldw	x,#_aunPushed_Data
2921  08d1 cd0000        	call	_bSendDataOverTCP
2923  08d4 84            	pop	a
2924                     ; 769 }
2927  08d5 5b29          	addw	sp,#41
2928  08d7 81            	ret
3015                     	xdef	_sendDataToCloud
3016                     	xref.b	_IMEIRecievedOKFlag
3017                     	xdef	_bCONNACK_Recieved
3018                     	xdef	_aunPushed_Data
3019                     	xdef	_vMevris_Send_Phase
3020                     	xdef	_vMevris_Send_FuelLevel
3021                     	xdef	_vMevris_Send_EngineTemp
3022                     	xdef	_vMevris_Send_RadiatorTemp
3023                     	xdef	_vMevris_Send_BatteryVolt
3024                     	xdef	_aunMQTT_Publish_Topic
3025                     	xdef	_aunMQTT_Subscribe_Topic
3026                     	xdef	_aunMQTT_ClientID
3027                     	xref	_Temperature2
3028                     	xref	_Temperature1
3029                     	xref	_Fuellevel
3030                     	xref.b	_batVolt
3031                     	xref	_Watt_Phase3
3032                     	xref	_Ampere_Phase3
3033                     	xref	_Voltage_Phase3
3034                     	xref	_Watt_Phase2
3035                     	xref	_Ampere_Phase2
3036                     	xref	_Voltage_Phase2
3037                     	xref	_Watt_Phase1
3038                     	xref	_Ampere_Phase1
3039                     	xref	_Voltage_Phase1
3040                     	xdef	_vMevris_Send_Version
3041                     	xdef	_vMevris_Send_IMEI
3042                     	xdef	_punGet_Client_ID
3043                     	xdef	_punGet_Command_Topic
3044                     	xdef	_punGet_Event_Topic
3045                     	xdef	_vHandleMevris_MQTT_Recv_Data
3046                     	xdef	_vHandleMevrisRecievedData
3047                     	xref	_enGet_TCP_Status
3048                     	xref	_vClearBuffer
3049                     	xref	_bSendDataOverTCP
3050                     	xref	_response_buffer
3051                     	xref	_ulMQTT_Publish
3052                     	xref.b	_aunIMEI
3053                     	xref	_sprintf
3054                     	xref	_strstr
3055                     	xref	_strcat
3056                     	switch	.const
3057  015d               L567:
3058  015d 7b22          	dc.b	"{",34
3059  015f 6675656c22    	dc.b	"fuel",34
3060  0164 3a2200        	dc.b	":",34,0
3061  0167               L137:
3062  0167 7b22          	dc.b	"{",34
3063  0169 456e67696e65  	dc.b	"EngineTemperature",34
3064  017b 3a2200        	dc.b	":",34,0
3065  017e               L766:
3066  017e 42c80000      	dc.w	17096,0
3067  0182               L166:
3068  0182 7b22          	dc.b	"{",34
3069  0184 526164696174  	dc.b	"RadiatorTemperatur"
3070  0196 6522          	dc.b	"e",34
3071  0198 3a2200        	dc.b	":",34,0
3072  019b               L126:
3073  019b 7b22          	dc.b	"{",34
3074  019d 626174746572  	dc.b	"battery",34
3075  01a5 3a2200        	dc.b	":",34,0
3076  01a8               L565:
3077  01a8 222c22637572  	dc.b	34,44,34,99,117,114
3078  01ae 72656e7400    	dc.b	"rent",0
3079  01b3               L365:
3080  01b3 222c22766f6c  	dc.b	34,44,34,118,111,108
3081  01b9 7461676500    	dc.b	"tage",0
3082  01be               L165:
3083  01be 2e00          	dc.b	".",0
3084  01c0               L755:
3085  01c0 256c6400      	dc.b	"%ld",0
3086  01c4               L555:
3087  01c4 223a2200      	dc.b	34,58,34,0
3088  01c8               L355:
3089  01c8 7b22          	dc.b	"{",34
3090  01ca 706f77657200  	dc.b	"power",0
3091  01d0               L155:
3092  01d0 256400        	dc.b	"%d",0
3093  01d3               L764:
3094  01d3 302e302e3030  	dc.b	"0.0.001",0
3095  01db               L564:
3096  01db 222c22687722  	dc.b	34,44,34,104,119,34
3097  01e1 3a2200        	dc.b	":",34,0
3098  01e4               L364:
3099  01e4 322e342e3030  	dc.b	"2.4.001",0
3100  01ec               L164:
3101  01ec 7b22          	dc.b	"{",34
3102  01ee 667722        	dc.b	"fw",34
3103  01f1 3a2200        	dc.b	":",34,0
3104  01f4               L334:
3105  01f4 227d00        	dc.b	34,125,0
3106  01f7               L134:
3107  01f7 7b22          	dc.b	"{",34
3108  01f9 696d656922    	dc.b	"imei",34
3109  01fe 3a2200        	dc.b	":",34,0
3110  0201               L304:
3111  0201 6576656e7400  	dc.b	"event",0
3112  0207               L363:
3113  0207 636f6d6d616e  	dc.b	"command",0
3114  020f               L163:
3115  020f 2f00          	dc.b	"/",0
3116  0211               L753:
3117  0211 73633200      	dc.b	"sc2",0
3118  0215               L733:
3119  0215 67656e00      	dc.b	"gen",0
3120  0219               L523:
3121  0219 22696d656922  	dc.b	34,105,109,101,105,34,0
3122  0220               L123:
3123  0220 22696e666f22  	dc.b	34,105,110,102,111,34,0
3124  0227               L132:
3125  0227 2b49504400    	dc.b	"+IPD",0
3126                     	xref.b	c_lreg
3127                     	xref.b	c_x
3147                     	xref	c_rtol
3148                     	xref	c_ftol
3149                     	xref	c_fmul
3150                     	xref	c_lumd
3151                     	xref	c_ludv
3152                     	xref	c_ltor
3153                     	xref	c_xymvx
3154                     	end
