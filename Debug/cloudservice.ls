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
 310                     ; 59 void sendDataToCloud(void)
 310                     ; 60 {
 312                     	switch	.text
 313  0000               _sendDataToCloud:
 315  0000 88            	push	a
 316       00000001      OFST:	set	1
 319                     ; 69     tempCounter++; //Added by Saqib
 321  0001 3c01          	inc	L5_tempCounter
 322                     ; 70     if (tempCounter >= 3)
 324  0003 b601          	ld	a,L5_tempCounter
 325  0005 a103          	cp	a,#3
 326  0007 2403          	jruge	L6
 327  0009 cc00c4        	jp	L751
 328  000c               L6:
 329                     ; 72         eTCP_Status = enGet_TCP_Status();
 331  000c cd0000        	call	_enGet_TCP_Status
 333  000f 6b01          	ld	(OFST+0,sp),a
 335                     ; 73         if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
 337  0011 7b01          	ld	a,(OFST+0,sp)
 338  0013 a107          	cp	a,#7
 339  0015 2703          	jreq	L01
 340  0017 cc00c0        	jp	L161
 341  001a               L01:
 343  001a 3d00          	tnz	_IMEIRecievedOKFlag
 344  001c 2603          	jrne	L21
 345  001e cc00c0        	jp	L161
 346  0021               L21:
 347                     ; 75             switch (enSendEventCounter)
 349  0021 b600          	ld	a,L3_enSendEventCounter
 351                     ; 119             default:
 351                     ; 120                 break;
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
 368                     ; 92             case eCommand_Phase1:
 368                     ; 93                 // vMevris_Send_Phase1();
 368                     ; 94                 vMevris_Send_Phase(1, Watt_Phase1, Voltage_Phase1, Ampere_Phase1);
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
 383  0055 cd02fd        	call	_vMevris_Send_Phase
 385  0058 5b0c          	addw	sp,#12
 386                     ; 95                 break;
 388  005a 2054          	jra	L561
 389  005c               L11:
 390                     ; 96             case eCommand_Phase2:
 390                     ; 97                 // vMevris_Send_Phase2();
 390                     ; 98                 vMevris_Send_Phase(2, Watt_Phase2, Voltage_Phase2, Ampere_Phase2);
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
 405  0076 cd02fd        	call	_vMevris_Send_Phase
 407  0079 5b0c          	addw	sp,#12
 408                     ; 99                 break;
 410  007b 2033          	jra	L561
 411  007d               L31:
 412                     ; 100             case eCommand_Phase3:
 412                     ; 101                 // vMevris_Send_Phase3();
 412                     ; 102                 vMevris_Send_Phase(3, Watt_Phase3, Voltage_Phase3, Ampere_Phase3);
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
 427  0097 cd02fd        	call	_vMevris_Send_Phase
 429  009a 5b0c          	addw	sp,#12
 430                     ; 103                 break;
 432  009c 2012          	jra	L561
 433  009e               L51:
 434                     ; 104             case eCommand_BatteryVolts:
 434                     ; 105                 vMevris_Send_BatteryVolt();
 436  009e cd0504        	call	_vMevris_Send_BatteryVolt
 438                     ; 106                 break;
 440  00a1 200d          	jra	L561
 441  00a3               L71:
 442                     ; 107             case eCommand_RadiatorTemp:
 442                     ; 108                 vMevris_Send_RadiatorTemp();
 444  00a3 cd05ba        	call	_vMevris_Send_RadiatorTemp
 446                     ; 109                 break;
 448  00a6 2008          	jra	L561
 449  00a8               L12:
 450                     ; 110             case eCommand_EngineTemp:
 450                     ; 111                 vMevris_Send_EngineTemp();
 452  00a8 cd0691        	call	_vMevris_Send_EngineTemp
 454                     ; 112                 break;
 456  00ab 2003          	jra	L561
 457  00ad               L32:
 458                     ; 113             case eCommand_FuelLevel:
 458                     ; 114                 vMevris_Send_FuelLevel();
 460  00ad cd075f        	call	_vMevris_Send_FuelLevel
 462                     ; 115                 break;
 464  00b0               L52:
 465                     ; 116             case eCommand_Others:
 465                     ; 117                 // Do something
 465                     ; 118                 break;
 467  00b0               L72:
 468                     ; 119             default:
 468                     ; 120                 break;
 470  00b0               L561:
 471                     ; 123             enSendEventCounter++;
 473  00b0 3c00          	inc	L3_enSendEventCounter
 474                     ; 124             if (enSendEventCounter >= eCommand_Others)
 476  00b2 b600          	ld	a,L3_enSendEventCounter
 477  00b4 a10c          	cp	a,#12
 478  00b6 2504          	jrult	L761
 479                     ; 125                 enSendEventCounter = eCommand_IMEI;
 481  00b8 35010000      	mov	L3_enSendEventCounter,#1
 482  00bc               L761:
 483                     ; 126             tempCounter = 0;
 485  00bc 3f01          	clr	L5_tempCounter
 487  00be 2004          	jra	L751
 488  00c0               L161:
 489                     ; 130             enSendEventCounter = eCommand_IMEI;
 491  00c0 35010000      	mov	L3_enSendEventCounter,#1
 492  00c4               L751:
 493                     ; 133 }
 496  00c4 84            	pop	a
 497  00c5 81            	ret
 574                     ; 336 void vHandleMevris_MQTT_Recv_Data(void)
 574                     ; 337 {
 575                     	switch	.text
 576  00c6               _vHandleMevris_MQTT_Recv_Data:
 578  00c6 5225          	subw	sp,#37
 579       00000025      OFST:	set	37
 582                     ; 340     uint8_t i = 0, j;
 584                     ; 341     uint8_t unLength = 0;
 586  00c8 0f21          	clr	(OFST-4,sp)
 588                     ; 410     ptr = strstr(response_buffer, MQTT_TOPIC_HEADER);
 590  00ca ae0223        	ldw	x,#L132
 591  00cd 89            	pushw	x
 592  00ce ae0000        	ldw	x,#_response_buffer
 593  00d1 cd0000        	call	_strstr
 595  00d4 5b02          	addw	sp,#2
 596  00d6 1f23          	ldw	(OFST-2,sp),x
 598                     ; 411     if (ptr)
 600  00d8 1e23          	ldw	x,(OFST-2,sp)
 601  00da 2602          	jrne	L62
 602  00dc 207e          	jp	L332
 603  00de               L62:
 604                     ; 413         i = 0;
 606  00de 0f25          	clr	(OFST+0,sp)
 609  00e0 2002          	jra	L142
 610  00e2               L532:
 611                     ; 415             i++;
 614  00e2 0c25          	inc	(OFST+0,sp)
 616  00e4               L142:
 617                     ; 414         while (*(ptr + i) != '{' && i < 99)
 617                     ; 415             i++;
 619  00e4 7b23          	ld	a,(OFST-2,sp)
 620  00e6 97            	ld	xl,a
 621  00e7 7b24          	ld	a,(OFST-1,sp)
 622  00e9 1b25          	add	a,(OFST+0,sp)
 623  00eb 2401          	jrnc	L61
 624  00ed 5c            	incw	x
 625  00ee               L61:
 626  00ee 02            	rlwa	x,a
 627  00ef f6            	ld	a,(x)
 628  00f0 a17b          	cp	a,#123
 629  00f2 2706          	jreq	L542
 631  00f4 7b25          	ld	a,(OFST+0,sp)
 632  00f6 a163          	cp	a,#99
 633  00f8 25e8          	jrult	L532
 634  00fa               L542:
 635                     ; 416         if (*(ptr + i) == '{')
 637  00fa 7b23          	ld	a,(OFST-2,sp)
 638  00fc 97            	ld	xl,a
 639  00fd 7b24          	ld	a,(OFST-1,sp)
 640  00ff 1b25          	add	a,(OFST+0,sp)
 641  0101 2401          	jrnc	L02
 642  0103 5c            	incw	x
 643  0104               L02:
 644  0104 02            	rlwa	x,a
 645  0105 f6            	ld	a,(x)
 646  0106 a17b          	cp	a,#123
 647  0108 2652          	jrne	L332
 648                     ; 418             vClearBuffer(localBuffer, 30);
 650  010a 4b1e          	push	#30
 651  010c 96            	ldw	x,sp
 652  010d 1c0004        	addw	x,#OFST-33
 653  0110 cd0000        	call	_vClearBuffer
 655  0113 84            	pop	a
 656                     ; 419             j = 0;
 658  0114 0f22          	clr	(OFST-3,sp)
 661  0116 2024          	jra	L552
 662  0118               L152:
 663                     ; 422                 localBuffer[j++] = *(ptr + i);
 665  0118 96            	ldw	x,sp
 666  0119 1c0003        	addw	x,#OFST-34
 667  011c 1f01          	ldw	(OFST-36,sp),x
 669  011e 7b22          	ld	a,(OFST-3,sp)
 670  0120 97            	ld	xl,a
 671  0121 0c22          	inc	(OFST-3,sp)
 673  0123 9f            	ld	a,xl
 674  0124 5f            	clrw	x
 675  0125 97            	ld	xl,a
 676  0126 72fb01        	addw	x,(OFST-36,sp)
 677  0129 89            	pushw	x
 678  012a 7b25          	ld	a,(OFST+0,sp)
 679  012c 97            	ld	xl,a
 680  012d 7b26          	ld	a,(OFST+1,sp)
 681  012f 1b27          	add	a,(OFST+2,sp)
 682  0131 2401          	jrnc	L22
 683  0133 5c            	incw	x
 684  0134               L22:
 685  0134 02            	rlwa	x,a
 686  0135 f6            	ld	a,(x)
 687  0136 85            	popw	x
 688  0137 f7            	ld	(x),a
 689                     ; 423                 unLength++;
 691  0138 0c21          	inc	(OFST-4,sp)
 693                     ; 424                 i++;
 695  013a 0c25          	inc	(OFST+0,sp)
 697  013c               L552:
 698                     ; 420             while (*(ptr + i) != '\r' && j < 29)
 700  013c 7b23          	ld	a,(OFST-2,sp)
 701  013e 97            	ld	xl,a
 702  013f 7b24          	ld	a,(OFST-1,sp)
 703  0141 1b25          	add	a,(OFST+0,sp)
 704  0143 2401          	jrnc	L42
 705  0145 5c            	incw	x
 706  0146               L42:
 707  0146 02            	rlwa	x,a
 708  0147 f6            	ld	a,(x)
 709  0148 a10d          	cp	a,#13
 710  014a 2706          	jreq	L162
 712  014c 7b22          	ld	a,(OFST-3,sp)
 713  014e a11d          	cp	a,#29
 714  0150 25c6          	jrult	L152
 715  0152               L162:
 716                     ; 426             vHandleMevrisRecievedData(localBuffer, unLength);
 718  0152 7b21          	ld	a,(OFST-4,sp)
 719  0154 88            	push	a
 720  0155 96            	ldw	x,sp
 721  0156 1c0004        	addw	x,#OFST-33
 722  0159 ad04          	call	_vHandleMevrisRecievedData
 724  015b 84            	pop	a
 725  015c               L332:
 726                     ; 430 }
 729  015c 5b25          	addw	sp,#37
 730  015e 81            	ret
 768                     ; 432 void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength)
 768                     ; 433 {
 769                     	switch	.text
 770  015f               _vHandleMevrisRecievedData:
 772  015f 89            	pushw	x
 773       00000000      OFST:	set	0
 776                     ; 436     if (strstr(Data, "\"info\"")) //Example "{"info":"imei"}"
 778  0160 ae021c        	ldw	x,#L303
 779  0163 89            	pushw	x
 780  0164 1e03          	ldw	x,(OFST+3,sp)
 781  0166 cd0000        	call	_strstr
 783  0169 5b02          	addw	sp,#2
 784  016b a30000        	cpw	x,#0
 785  016e 2713          	jreq	L103
 786                     ; 438         if (strstr(Data, "\"imei\""))
 788  0170 ae0215        	ldw	x,#L703
 789  0173 89            	pushw	x
 790  0174 1e03          	ldw	x,(OFST+3,sp)
 791  0176 cd0000        	call	_strstr
 793  0179 5b02          	addw	sp,#2
 794  017b a30000        	cpw	x,#0
 795  017e 2703          	jreq	L103
 796                     ; 440             vMevris_Send_IMEI();
 798  0180 cd0243        	call	_vMevris_Send_IMEI
 800  0183               L103:
 801                     ; 443 }
 804  0183 85            	popw	x
 805  0184 81            	ret
 834                     ; 445 uint8_t *punGet_Client_ID(void)
 834                     ; 446 {
 835                     	switch	.text
 836  0185               _punGet_Client_ID:
 840                     ; 453     vClearBuffer(aunMQTT_ClientID, 20);
 842  0185 4b14          	push	#20
 843  0187 ae0064        	ldw	x,#_aunMQTT_ClientID
 844  018a cd0000        	call	_vClearBuffer
 846  018d 84            	pop	a
 847                     ; 454     strcpy(aunMQTT_ClientID, "gen");
 849  018e ae0064        	ldw	x,#_aunMQTT_ClientID
 850  0191 90ae0211      	ldw	y,#L123
 851  0195               L43:
 852  0195 90f6          	ld	a,(y)
 853  0197 905c          	incw	y
 854  0199 f7            	ld	(x),a
 855  019a 5c            	incw	x
 856  019b 4d            	tnz	a
 857  019c 26f7          	jrne	L43
 858                     ; 455     strcat(aunMQTT_ClientID, aunIMEI);
 860  019e ae0000        	ldw	x,#_aunIMEI
 861  01a1 89            	pushw	x
 862  01a2 ae0064        	ldw	x,#_aunMQTT_ClientID
 863  01a5 cd0000        	call	_strcat
 865  01a8 85            	popw	x
 866                     ; 457     return aunMQTT_ClientID;
 868  01a9 ae0064        	ldw	x,#_aunMQTT_ClientID
 871  01ac 81            	ret
 912                     ; 460 uint8_t *punGet_Command_Topic(void)
 912                     ; 461 {
 913                     	switch	.text
 914  01ad               _punGet_Command_Topic:
 916  01ad 88            	push	a
 917       00000001      OFST:	set	1
 920                     ; 462     uint8_t i = 0;
 922                     ; 468     vClearBuffer(aunMQTT_Subscribe_Topic, 30);
 924  01ae 4b1e          	push	#30
 925  01b0 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 926  01b3 cd0000        	call	_vClearBuffer
 928  01b6 84            	pop	a
 929                     ; 469     strcpy(aunMQTT_Subscribe_Topic, MQTT_TOPIC_HEADER);
 931  01b7 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 932  01ba 90ae0223      	ldw	y,#L132
 933  01be               L04:
 934  01be 90f6          	ld	a,(y)
 935  01c0 905c          	incw	y
 936  01c2 f7            	ld	(x),a
 937  01c3 5c            	incw	x
 938  01c4 4d            	tnz	a
 939  01c5 26f7          	jrne	L04
 940                     ; 470     strcat(aunMQTT_Subscribe_Topic, "/");
 942  01c7 ae020f        	ldw	x,#L143
 943  01ca 89            	pushw	x
 944  01cb ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 945  01ce cd0000        	call	_strcat
 947  01d1 85            	popw	x
 948                     ; 471     strcat(aunMQTT_Subscribe_Topic, aunIMEI);
 950  01d2 ae0000        	ldw	x,#_aunIMEI
 951  01d5 89            	pushw	x
 952  01d6 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 953  01d9 cd0000        	call	_strcat
 955  01dc 85            	popw	x
 956                     ; 472     strcat(aunMQTT_Subscribe_Topic, "/");
 958  01dd ae020f        	ldw	x,#L143
 959  01e0 89            	pushw	x
 960  01e1 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 961  01e4 cd0000        	call	_strcat
 963  01e7 85            	popw	x
 964                     ; 473     strcat(aunMQTT_Subscribe_Topic, MQTT_INBOUND_TOPIC_FOOTER);
 966  01e8 ae0207        	ldw	x,#L343
 967  01eb 89            	pushw	x
 968  01ec ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 969  01ef cd0000        	call	_strcat
 971  01f2 85            	popw	x
 972                     ; 475     return aunMQTT_Subscribe_Topic;
 974  01f3 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 977  01f6 84            	pop	a
 978  01f7 81            	ret
1018                     ; 478 uint8_t *punGet_Event_Topic(void)
1018                     ; 479 {
1019                     	switch	.text
1020  01f8               _punGet_Event_Topic:
1022  01f8 88            	push	a
1023       00000001      OFST:	set	1
1026                     ; 480     uint8_t i = 0;
1028                     ; 486     vClearBuffer(aunMQTT_Publish_Topic, 30);
1030  01f9 4b1e          	push	#30
1031  01fb ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1032  01fe cd0000        	call	_vClearBuffer
1034  0201 84            	pop	a
1035                     ; 487     strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
1037  0202 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1038  0205 90ae0223      	ldw	y,#L132
1039  0209               L44:
1040  0209 90f6          	ld	a,(y)
1041  020b 905c          	incw	y
1042  020d f7            	ld	(x),a
1043  020e 5c            	incw	x
1044  020f 4d            	tnz	a
1045  0210 26f7          	jrne	L44
1046                     ; 488     strcat(aunMQTT_Publish_Topic, "/");
1048  0212 ae020f        	ldw	x,#L143
1049  0215 89            	pushw	x
1050  0216 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1051  0219 cd0000        	call	_strcat
1053  021c 85            	popw	x
1054                     ; 489     strcat(aunMQTT_Publish_Topic, aunIMEI);
1056  021d ae0000        	ldw	x,#_aunIMEI
1057  0220 89            	pushw	x
1058  0221 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1059  0224 cd0000        	call	_strcat
1061  0227 85            	popw	x
1062                     ; 490     strcat(aunMQTT_Publish_Topic, "/");
1064  0228 ae020f        	ldw	x,#L143
1065  022b 89            	pushw	x
1066  022c ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1067  022f cd0000        	call	_strcat
1069  0232 85            	popw	x
1070                     ; 491     strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);
1072  0233 ae0201        	ldw	x,#L363
1073  0236 89            	pushw	x
1074  0237 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1075  023a cd0000        	call	_strcat
1077  023d 85            	popw	x
1078                     ; 493     return aunMQTT_Publish_Topic;
1080  023e ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1083  0241 84            	pop	a
1084  0242 81            	ret
1087                     .const:	section	.text
1088  0000               L563_localBuffer:
1089  0000 7b22          	dc.b	"{",34
1090  0002 696d656922    	dc.b	"imei",34
1091  0007 3a22          	dc.b	":",34
1092  0009 313233343536  	dc.b	"123456789012345",34
1093  0019 7d00          	dc.b	"}",0
1094  001b 000000        	ds.b	3
1142                     ; 497 void vMevris_Send_IMEI(void)
1142                     ; 498 {
1143                     	switch	.text
1144  0243               _vMevris_Send_IMEI:
1146  0243 521f          	subw	sp,#31
1147       0000001f      OFST:	set	31
1150                     ; 499     uint8_t localBuffer[30] = "{\"imei\":\"123456789012345\"}";
1152  0245 96            	ldw	x,sp
1153  0246 1c0002        	addw	x,#OFST-29
1154  0249 90ae0000      	ldw	y,#L563_localBuffer
1155  024d a61e          	ld	a,#30
1156  024f cd0000        	call	c_xymvx
1158                     ; 500     uint8_t unSendDataLength = 0;
1160                     ; 501     vClearBuffer(localBuffer, 30);
1162  0252 4b1e          	push	#30
1163  0254 96            	ldw	x,sp
1164  0255 1c0003        	addw	x,#OFST-28
1165  0258 cd0000        	call	_vClearBuffer
1167  025b 84            	pop	a
1168                     ; 502     strcpy(localBuffer, "{\"imei\":\"");
1170  025c 96            	ldw	x,sp
1171  025d 1c0002        	addw	x,#OFST-29
1172  0260 90ae01f7      	ldw	y,#L114
1173  0264               L05:
1174  0264 90f6          	ld	a,(y)
1175  0266 905c          	incw	y
1176  0268 f7            	ld	(x),a
1177  0269 5c            	incw	x
1178  026a 4d            	tnz	a
1179  026b 26f7          	jrne	L05
1180                     ; 503     strcat(localBuffer, aunIMEI);
1182  026d ae0000        	ldw	x,#_aunIMEI
1183  0270 89            	pushw	x
1184  0271 96            	ldw	x,sp
1185  0272 1c0004        	addw	x,#OFST-27
1186  0275 cd0000        	call	_strcat
1188  0278 85            	popw	x
1189                     ; 504     strcat(localBuffer, "\"}");
1191  0279 ae01f4        	ldw	x,#L314
1192  027c 89            	pushw	x
1193  027d 96            	ldw	x,sp
1194  027e 1c0004        	addw	x,#OFST-27
1195  0281 cd0000        	call	_strcat
1197  0284 85            	popw	x
1198                     ; 513     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1200  0285 96            	ldw	x,sp
1201  0286 1c0002        	addw	x,#OFST-29
1202  0289 89            	pushw	x
1203  028a ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1204  028d cd0000        	call	_vMQTT_Publish
1206  0290 85            	popw	x
1207                     ; 515 }
1210  0291 5b1f          	addw	sp,#31
1211  0293 81            	ret
1214                     	switch	.const
1215  001e               L514_localBuffer:
1216  001e 7b22          	dc.b	"{",34
1217  0020 667722        	dc.b	"fw",34
1218  0023 3a22          	dc.b	":",34
1219  0025 322e342e3031  	dc.b	"2.4.010",34
1220  002d 2c22          	dc.b	",",34
1221  002f 687722        	dc.b	"hw",34
1222  0032 3a22          	dc.b	":",34
1223  0034 302e302e3030  	dc.b	"0.0.001",34
1224  003c 7d00          	dc.b	"}",0
1225  003e 000000        	ds.b	3
1273                     ; 550 void vMevris_Send_Version()
1273                     ; 551 {
1274                     	switch	.text
1275  0294               _vMevris_Send_Version:
1277  0294 5224          	subw	sp,#36
1278       00000024      OFST:	set	36
1281                     ; 552     uint8_t localBuffer[35] = "{\"fw\":\"2.4.010\",\"hw\":\"0.0.001\"}";
1283  0296 96            	ldw	x,sp
1284  0297 1c0002        	addw	x,#OFST-34
1285  029a 90ae001e      	ldw	y,#L514_localBuffer
1286  029e a623          	ld	a,#35
1287  02a0 cd0000        	call	c_xymvx
1289                     ; 553     uint8_t unSendDataLength = 0;
1291                     ; 554     vClearBuffer(localBuffer, 35);
1293  02a3 4b23          	push	#35
1294  02a5 96            	ldw	x,sp
1295  02a6 1c0003        	addw	x,#OFST-33
1296  02a9 cd0000        	call	_vClearBuffer
1298  02ac 84            	pop	a
1299                     ; 555     strcpy(localBuffer, "{\"fw\":\"");
1301  02ad 96            	ldw	x,sp
1302  02ae 1c0002        	addw	x,#OFST-34
1303  02b1 90ae01ec      	ldw	y,#L144
1304  02b5               L45:
1305  02b5 90f6          	ld	a,(y)
1306  02b7 905c          	incw	y
1307  02b9 f7            	ld	(x),a
1308  02ba 5c            	incw	x
1309  02bb 4d            	tnz	a
1310  02bc 26f7          	jrne	L45
1311                     ; 556     strcat(localBuffer, /*"2.4.010"*/ Firmware_Version);
1313  02be ae01e4        	ldw	x,#L344
1314  02c1 89            	pushw	x
1315  02c2 96            	ldw	x,sp
1316  02c3 1c0004        	addw	x,#OFST-32
1317  02c6 cd0000        	call	_strcat
1319  02c9 85            	popw	x
1320                     ; 557     strcat(localBuffer, "\",\"hw\":\"");
1322  02ca ae01db        	ldw	x,#L544
1323  02cd 89            	pushw	x
1324  02ce 96            	ldw	x,sp
1325  02cf 1c0004        	addw	x,#OFST-32
1326  02d2 cd0000        	call	_strcat
1328  02d5 85            	popw	x
1329                     ; 558     strcat(localBuffer, /*"0.0.001"*/ Hardware_Version);
1331  02d6 ae01d3        	ldw	x,#L744
1332  02d9 89            	pushw	x
1333  02da 96            	ldw	x,sp
1334  02db 1c0004        	addw	x,#OFST-32
1335  02de cd0000        	call	_strcat
1337  02e1 85            	popw	x
1338                     ; 559     strcat(localBuffer, "\"}");
1340  02e2 ae01f4        	ldw	x,#L314
1341  02e5 89            	pushw	x
1342  02e6 96            	ldw	x,sp
1343  02e7 1c0004        	addw	x,#OFST-32
1344  02ea cd0000        	call	_strcat
1346  02ed 85            	popw	x
1347                     ; 568     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1349  02ee 96            	ldw	x,sp
1350  02ef 1c0002        	addw	x,#OFST-34
1351  02f2 89            	pushw	x
1352  02f3 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1353  02f6 cd0000        	call	_vMQTT_Publish
1355  02f9 85            	popw	x
1356                     ; 570 }
1359  02fa 5b24          	addw	sp,#36
1360  02fc 81            	ret
1363                     	switch	.const
1364  0041               L154_localBuffer:
1365  0041 7b22          	dc.b	"{",34
1366  0043 706f77657231  	dc.b	"power1",34
1367  004a 3a22          	dc.b	":",34
1368  004c 313233343536  	dc.b	"123456890.23",34
1369  0059 2c22          	dc.b	",",34
1370  005b 766f6c746167  	dc.b	"voltage1",34
1371  0064 3a22          	dc.b	":",34
1372  0066 3132332e3536  	dc.b	"123.56",34
1373  006d 2c22          	dc.b	",",34
1374  006f 63757272656e  	dc.b	"current1",34
1375  0078 3a22          	dc.b	":",34
1376  007a 31323334352e  	dc.b	"12345.78",34
1377  0083 7d00          	dc.b	"}",0
1378  0085 000000000000  	ds.b	7
1379  008c               L354_temp1:
1380  008c 00            	dc.b	0
1381  008d 000000000000  	ds.b	11
1382  0098               L554_phase_num:
1383  0098 00            	dc.b	0
1384  0099 0000          	ds.b	2
1488                     	switch	.const
1489  009b               L26:
1490  009b 00000064      	dc.l	100
1491                     ; 572 void vMevris_Send_Phase(uint8_t phase_number, uint32_t Watt, uint32_t Voltage, uint32_t Ampere)
1491                     ; 573 {
1492                     	switch	.text
1493  02fd               _vMevris_Send_Phase:
1495  02fd 88            	push	a
1496  02fe 525b          	subw	sp,#91
1497       0000005b      OFST:	set	91
1500                     ; 574     uint8_t localBuffer[75] = "{\"power1\":\"123456890.23\",\"voltage1\":\"123.56\",\"current1\":\"12345.78\"}";
1502  0300 96            	ldw	x,sp
1503  0301 1c0011        	addw	x,#OFST-74
1504  0304 90ae0041      	ldw	y,#L154_localBuffer
1505  0308 a64b          	ld	a,#75
1506  030a cd0000        	call	c_xymvx
1508                     ; 575     uint8_t unSendDataLength = 0;
1510                     ; 576     uint8_t temp1[12] = "";
1512  030d 96            	ldw	x,sp
1513  030e 1c0005        	addw	x,#OFST-86
1514  0311 90ae008c      	ldw	y,#L354_temp1
1515  0315 a60c          	ld	a,#12
1516  0317 cd0000        	call	c_xymvx
1518                     ; 577     uint8_t phase_num[3] = "";
1520  031a 96            	ldw	x,sp
1521  031b 1c0002        	addw	x,#OFST-89
1522  031e 90ae0098      	ldw	y,#L554_phase_num
1523  0322 a603          	ld	a,#3
1524  0324 cd0000        	call	c_xymvx
1526                     ; 578     vClearBuffer(localBuffer, 55);
1528  0327 4b37          	push	#55
1529  0329 96            	ldw	x,sp
1530  032a 1c0012        	addw	x,#OFST-73
1531  032d cd0000        	call	_vClearBuffer
1533  0330 84            	pop	a
1534                     ; 579     sprintf(phase_num, "%d", (uint16_t)phase_number);
1536  0331 7b5c          	ld	a,(OFST+1,sp)
1537  0333 5f            	clrw	x
1538  0334 97            	ld	xl,a
1539  0335 89            	pushw	x
1540  0336 ae01d0        	ldw	x,#L135
1541  0339 89            	pushw	x
1542  033a 96            	ldw	x,sp
1543  033b 1c0006        	addw	x,#OFST-85
1544  033e cd0000        	call	_sprintf
1546  0341 5b04          	addw	sp,#4
1547                     ; 580     strcpy(localBuffer, "{\"power");
1549  0343 96            	ldw	x,sp
1550  0344 1c0011        	addw	x,#OFST-74
1551  0347 90ae01c8      	ldw	y,#L335
1552  034b               L06:
1553  034b 90f6          	ld	a,(y)
1554  034d 905c          	incw	y
1555  034f f7            	ld	(x),a
1556  0350 5c            	incw	x
1557  0351 4d            	tnz	a
1558  0352 26f7          	jrne	L06
1559                     ; 581     strcat(localBuffer, phase_num);
1561  0354 96            	ldw	x,sp
1562  0355 1c0002        	addw	x,#OFST-89
1563  0358 89            	pushw	x
1564  0359 96            	ldw	x,sp
1565  035a 1c0013        	addw	x,#OFST-72
1566  035d cd0000        	call	_strcat
1568  0360 85            	popw	x
1569                     ; 582     strcat(localBuffer, "\":\"");
1571  0361 ae01c4        	ldw	x,#L535
1572  0364 89            	pushw	x
1573  0365 96            	ldw	x,sp
1574  0366 1c0013        	addw	x,#OFST-72
1575  0369 cd0000        	call	_strcat
1577  036c 85            	popw	x
1578                     ; 583     sprintf(temp1, "%ld", Watt / 100);
1580  036d 96            	ldw	x,sp
1581  036e 1c005f        	addw	x,#OFST+4
1582  0371 cd0000        	call	c_ltor
1584  0374 ae009b        	ldw	x,#L26
1585  0377 cd0000        	call	c_ludv
1587  037a be02          	ldw	x,c_lreg+2
1588  037c 89            	pushw	x
1589  037d be00          	ldw	x,c_lreg
1590  037f 89            	pushw	x
1591  0380 ae01c0        	ldw	x,#L735
1592  0383 89            	pushw	x
1593  0384 96            	ldw	x,sp
1594  0385 1c000b        	addw	x,#OFST-80
1595  0388 cd0000        	call	_sprintf
1597  038b 5b06          	addw	sp,#6
1598                     ; 584     strcat(localBuffer, temp1);
1600  038d 96            	ldw	x,sp
1601  038e 1c0005        	addw	x,#OFST-86
1602  0391 89            	pushw	x
1603  0392 96            	ldw	x,sp
1604  0393 1c0013        	addw	x,#OFST-72
1605  0396 cd0000        	call	_strcat
1607  0399 85            	popw	x
1608                     ; 585     strcat(localBuffer, ".");
1610  039a ae01be        	ldw	x,#L145
1611  039d 89            	pushw	x
1612  039e 96            	ldw	x,sp
1613  039f 1c0013        	addw	x,#OFST-72
1614  03a2 cd0000        	call	_strcat
1616  03a5 85            	popw	x
1617                     ; 586     sprintf(temp1, "%ld", Watt % 100);
1619  03a6 96            	ldw	x,sp
1620  03a7 1c005f        	addw	x,#OFST+4
1621  03aa cd0000        	call	c_ltor
1623  03ad ae009b        	ldw	x,#L26
1624  03b0 cd0000        	call	c_lumd
1626  03b3 be02          	ldw	x,c_lreg+2
1627  03b5 89            	pushw	x
1628  03b6 be00          	ldw	x,c_lreg
1629  03b8 89            	pushw	x
1630  03b9 ae01c0        	ldw	x,#L735
1631  03bc 89            	pushw	x
1632  03bd 96            	ldw	x,sp
1633  03be 1c000b        	addw	x,#OFST-80
1634  03c1 cd0000        	call	_sprintf
1636  03c4 5b06          	addw	sp,#6
1637                     ; 587     strcat(localBuffer, temp1);
1639  03c6 96            	ldw	x,sp
1640  03c7 1c0005        	addw	x,#OFST-86
1641  03ca 89            	pushw	x
1642  03cb 96            	ldw	x,sp
1643  03cc 1c0013        	addw	x,#OFST-72
1644  03cf cd0000        	call	_strcat
1646  03d2 85            	popw	x
1647                     ; 589     strcat(localBuffer, "\",\"voltage");
1649  03d3 ae01b3        	ldw	x,#L345
1650  03d6 89            	pushw	x
1651  03d7 96            	ldw	x,sp
1652  03d8 1c0013        	addw	x,#OFST-72
1653  03db cd0000        	call	_strcat
1655  03de 85            	popw	x
1656                     ; 590     strcat(localBuffer, phase_num);
1658  03df 96            	ldw	x,sp
1659  03e0 1c0002        	addw	x,#OFST-89
1660  03e3 89            	pushw	x
1661  03e4 96            	ldw	x,sp
1662  03e5 1c0013        	addw	x,#OFST-72
1663  03e8 cd0000        	call	_strcat
1665  03eb 85            	popw	x
1666                     ; 591     strcat(localBuffer, "\":\"");
1668  03ec ae01c4        	ldw	x,#L535
1669  03ef 89            	pushw	x
1670  03f0 96            	ldw	x,sp
1671  03f1 1c0013        	addw	x,#OFST-72
1672  03f4 cd0000        	call	_strcat
1674  03f7 85            	popw	x
1675                     ; 592     sprintf(temp1, "%ld", Voltage / 100);
1677  03f8 96            	ldw	x,sp
1678  03f9 1c0063        	addw	x,#OFST+8
1679  03fc cd0000        	call	c_ltor
1681  03ff ae009b        	ldw	x,#L26
1682  0402 cd0000        	call	c_ludv
1684  0405 be02          	ldw	x,c_lreg+2
1685  0407 89            	pushw	x
1686  0408 be00          	ldw	x,c_lreg
1687  040a 89            	pushw	x
1688  040b ae01c0        	ldw	x,#L735
1689  040e 89            	pushw	x
1690  040f 96            	ldw	x,sp
1691  0410 1c000b        	addw	x,#OFST-80
1692  0413 cd0000        	call	_sprintf
1694  0416 5b06          	addw	sp,#6
1695                     ; 593     strcat(localBuffer, temp1);
1697  0418 96            	ldw	x,sp
1698  0419 1c0005        	addw	x,#OFST-86
1699  041c 89            	pushw	x
1700  041d 96            	ldw	x,sp
1701  041e 1c0013        	addw	x,#OFST-72
1702  0421 cd0000        	call	_strcat
1704  0424 85            	popw	x
1705                     ; 594     strcat(localBuffer, ".");
1707  0425 ae01be        	ldw	x,#L145
1708  0428 89            	pushw	x
1709  0429 96            	ldw	x,sp
1710  042a 1c0013        	addw	x,#OFST-72
1711  042d cd0000        	call	_strcat
1713  0430 85            	popw	x
1714                     ; 595     sprintf(temp1, "%ld", Voltage % 100);
1716  0431 96            	ldw	x,sp
1717  0432 1c0063        	addw	x,#OFST+8
1718  0435 cd0000        	call	c_ltor
1720  0438 ae009b        	ldw	x,#L26
1721  043b cd0000        	call	c_lumd
1723  043e be02          	ldw	x,c_lreg+2
1724  0440 89            	pushw	x
1725  0441 be00          	ldw	x,c_lreg
1726  0443 89            	pushw	x
1727  0444 ae01c0        	ldw	x,#L735
1728  0447 89            	pushw	x
1729  0448 96            	ldw	x,sp
1730  0449 1c000b        	addw	x,#OFST-80
1731  044c cd0000        	call	_sprintf
1733  044f 5b06          	addw	sp,#6
1734                     ; 596     strcat(localBuffer, temp1);
1736  0451 96            	ldw	x,sp
1737  0452 1c0005        	addw	x,#OFST-86
1738  0455 89            	pushw	x
1739  0456 96            	ldw	x,sp
1740  0457 1c0013        	addw	x,#OFST-72
1741  045a cd0000        	call	_strcat
1743  045d 85            	popw	x
1744                     ; 598     strcat(localBuffer, "\",\"current");
1746  045e ae01a8        	ldw	x,#L545
1747  0461 89            	pushw	x
1748  0462 96            	ldw	x,sp
1749  0463 1c0013        	addw	x,#OFST-72
1750  0466 cd0000        	call	_strcat
1752  0469 85            	popw	x
1753                     ; 599     strcat(localBuffer, phase_num);
1755  046a 96            	ldw	x,sp
1756  046b 1c0002        	addw	x,#OFST-89
1757  046e 89            	pushw	x
1758  046f 96            	ldw	x,sp
1759  0470 1c0013        	addw	x,#OFST-72
1760  0473 cd0000        	call	_strcat
1762  0476 85            	popw	x
1763                     ; 600     strcat(localBuffer, "\":\"");
1765  0477 ae01c4        	ldw	x,#L535
1766  047a 89            	pushw	x
1767  047b 96            	ldw	x,sp
1768  047c 1c0013        	addw	x,#OFST-72
1769  047f cd0000        	call	_strcat
1771  0482 85            	popw	x
1772                     ; 601     sprintf(temp1, "%ld", Ampere / 100);
1774  0483 96            	ldw	x,sp
1775  0484 1c0067        	addw	x,#OFST+12
1776  0487 cd0000        	call	c_ltor
1778  048a ae009b        	ldw	x,#L26
1779  048d cd0000        	call	c_ludv
1781  0490 be02          	ldw	x,c_lreg+2
1782  0492 89            	pushw	x
1783  0493 be00          	ldw	x,c_lreg
1784  0495 89            	pushw	x
1785  0496 ae01c0        	ldw	x,#L735
1786  0499 89            	pushw	x
1787  049a 96            	ldw	x,sp
1788  049b 1c000b        	addw	x,#OFST-80
1789  049e cd0000        	call	_sprintf
1791  04a1 5b06          	addw	sp,#6
1792                     ; 602     strcat(localBuffer, temp1);
1794  04a3 96            	ldw	x,sp
1795  04a4 1c0005        	addw	x,#OFST-86
1796  04a7 89            	pushw	x
1797  04a8 96            	ldw	x,sp
1798  04a9 1c0013        	addw	x,#OFST-72
1799  04ac cd0000        	call	_strcat
1801  04af 85            	popw	x
1802                     ; 603     strcat(localBuffer, ".");
1804  04b0 ae01be        	ldw	x,#L145
1805  04b3 89            	pushw	x
1806  04b4 96            	ldw	x,sp
1807  04b5 1c0013        	addw	x,#OFST-72
1808  04b8 cd0000        	call	_strcat
1810  04bb 85            	popw	x
1811                     ; 604     sprintf(temp1, "%ld", Ampere % 100);
1813  04bc 96            	ldw	x,sp
1814  04bd 1c0067        	addw	x,#OFST+12
1815  04c0 cd0000        	call	c_ltor
1817  04c3 ae009b        	ldw	x,#L26
1818  04c6 cd0000        	call	c_lumd
1820  04c9 be02          	ldw	x,c_lreg+2
1821  04cb 89            	pushw	x
1822  04cc be00          	ldw	x,c_lreg
1823  04ce 89            	pushw	x
1824  04cf ae01c0        	ldw	x,#L735
1825  04d2 89            	pushw	x
1826  04d3 96            	ldw	x,sp
1827  04d4 1c000b        	addw	x,#OFST-80
1828  04d7 cd0000        	call	_sprintf
1830  04da 5b06          	addw	sp,#6
1831                     ; 605     strcat(localBuffer, temp1);
1833  04dc 96            	ldw	x,sp
1834  04dd 1c0005        	addw	x,#OFST-86
1835  04e0 89            	pushw	x
1836  04e1 96            	ldw	x,sp
1837  04e2 1c0013        	addw	x,#OFST-72
1838  04e5 cd0000        	call	_strcat
1840  04e8 85            	popw	x
1841                     ; 606     strcat(localBuffer, "\"}");
1843  04e9 ae01f4        	ldw	x,#L314
1844  04ec 89            	pushw	x
1845  04ed 96            	ldw	x,sp
1846  04ee 1c0013        	addw	x,#OFST-72
1847  04f1 cd0000        	call	_strcat
1849  04f4 85            	popw	x
1850                     ; 616     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1852  04f5 96            	ldw	x,sp
1853  04f6 1c0011        	addw	x,#OFST-74
1854  04f9 89            	pushw	x
1855  04fa ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1856  04fd cd0000        	call	_vMQTT_Publish
1858  0500 85            	popw	x
1859                     ; 618 }
1862  0501 5b5c          	addw	sp,#92
1863  0503 81            	ret
1866                     	switch	.const
1867  009f               L745_localBuffer:
1868  009f 7b22          	dc.b	"{",34
1869  00a1 626174746572  	dc.b	"battery",34
1870  00a9 3a22          	dc.b	":",34
1871  00ab 313233343536  	dc.b	"123456.89",34
1872  00b5 7d00          	dc.b	"}",0
1873  00b7 000000000000  	ds.b	6
1874  00bd               L155_temp1:
1875  00bd 00            	dc.b	0
1876  00be 000000000000  	ds.b	9
1936                     ; 728 void vMevris_Send_BatteryVolt()
1936                     ; 729 {
1937                     	switch	.text
1938  0504               _vMevris_Send_BatteryVolt:
1940  0504 5229          	subw	sp,#41
1941       00000029      OFST:	set	41
1944                     ; 730     uint8_t localBuffer[30] = "{\"battery\":\"123456.89\"}";
1946  0506 96            	ldw	x,sp
1947  0507 1c000c        	addw	x,#OFST-29
1948  050a 90ae009f      	ldw	y,#L745_localBuffer
1949  050e a61e          	ld	a,#30
1950  0510 cd0000        	call	c_xymvx
1952                     ; 731     uint8_t unSendDataLength = 0;
1954                     ; 732     uint8_t temp1[10] = "";
1956  0513 96            	ldw	x,sp
1957  0514 1c0002        	addw	x,#OFST-39
1958  0517 90ae00bd      	ldw	y,#L155_temp1
1959  051b a60a          	ld	a,#10
1960  051d cd0000        	call	c_xymvx
1962                     ; 733     vClearBuffer(localBuffer, 30);
1964  0520 4b1e          	push	#30
1965  0522 96            	ldw	x,sp
1966  0523 1c000d        	addw	x,#OFST-28
1967  0526 cd0000        	call	_vClearBuffer
1969  0529 84            	pop	a
1970                     ; 734     strcpy(localBuffer, "{\"battery\":\"");
1972  052a 96            	ldw	x,sp
1973  052b 1c000c        	addw	x,#OFST-29
1974  052e 90ae019b      	ldw	y,#L106
1975  0532               L66:
1976  0532 90f6          	ld	a,(y)
1977  0534 905c          	incw	y
1978  0536 f7            	ld	(x),a
1979  0537 5c            	incw	x
1980  0538 4d            	tnz	a
1981  0539 26f7          	jrne	L66
1982                     ; 736     sprintf(temp1, "%ld", batVolt / 100);
1984  053b ae0000        	ldw	x,#_batVolt
1985  053e cd0000        	call	c_ltor
1987  0541 ae009b        	ldw	x,#L26
1988  0544 cd0000        	call	c_ludv
1990  0547 be02          	ldw	x,c_lreg+2
1991  0549 89            	pushw	x
1992  054a be00          	ldw	x,c_lreg
1993  054c 89            	pushw	x
1994  054d ae01c0        	ldw	x,#L735
1995  0550 89            	pushw	x
1996  0551 96            	ldw	x,sp
1997  0552 1c0008        	addw	x,#OFST-33
1998  0555 cd0000        	call	_sprintf
2000  0558 5b06          	addw	sp,#6
2001                     ; 737     strcat(localBuffer, temp1);
2003  055a 96            	ldw	x,sp
2004  055b 1c0002        	addw	x,#OFST-39
2005  055e 89            	pushw	x
2006  055f 96            	ldw	x,sp
2007  0560 1c000e        	addw	x,#OFST-27
2008  0563 cd0000        	call	_strcat
2010  0566 85            	popw	x
2011                     ; 738     strcat(localBuffer, ".");
2013  0567 ae01be        	ldw	x,#L145
2014  056a 89            	pushw	x
2015  056b 96            	ldw	x,sp
2016  056c 1c000e        	addw	x,#OFST-27
2017  056f cd0000        	call	_strcat
2019  0572 85            	popw	x
2020                     ; 739     sprintf(temp1, "%ld", batVolt % 100);
2022  0573 ae0000        	ldw	x,#_batVolt
2023  0576 cd0000        	call	c_ltor
2025  0579 ae009b        	ldw	x,#L26
2026  057c cd0000        	call	c_lumd
2028  057f be02          	ldw	x,c_lreg+2
2029  0581 89            	pushw	x
2030  0582 be00          	ldw	x,c_lreg
2031  0584 89            	pushw	x
2032  0585 ae01c0        	ldw	x,#L735
2033  0588 89            	pushw	x
2034  0589 96            	ldw	x,sp
2035  058a 1c0008        	addw	x,#OFST-33
2036  058d cd0000        	call	_sprintf
2038  0590 5b06          	addw	sp,#6
2039                     ; 740     strcat(localBuffer, temp1);
2041  0592 96            	ldw	x,sp
2042  0593 1c0002        	addw	x,#OFST-39
2043  0596 89            	pushw	x
2044  0597 96            	ldw	x,sp
2045  0598 1c000e        	addw	x,#OFST-27
2046  059b cd0000        	call	_strcat
2048  059e 85            	popw	x
2049                     ; 741     strcat(localBuffer, "\"}");
2051  059f ae01f4        	ldw	x,#L314
2052  05a2 89            	pushw	x
2053  05a3 96            	ldw	x,sp
2054  05a4 1c000e        	addw	x,#OFST-27
2055  05a7 cd0000        	call	_strcat
2057  05aa 85            	popw	x
2058                     ; 750     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
2060  05ab 96            	ldw	x,sp
2061  05ac 1c000c        	addw	x,#OFST-29
2062  05af 89            	pushw	x
2063  05b0 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2064  05b3 cd0000        	call	_vMQTT_Publish
2066  05b6 85            	popw	x
2067                     ; 752 }
2070  05b7 5b29          	addw	sp,#41
2071  05b9 81            	ret
2074                     	switch	.const
2075  00c7               L306_localBuffer:
2076  00c7 7b22          	dc.b	"{",34
2077  00c9 526164696174  	dc.b	"RadiatorTemperatur"
2078  00db 6522          	dc.b	"e",34
2079  00dd 3a22          	dc.b	":",34
2080  00df 313233343536  	dc.b	"123456.89",34
2081  00e9 7d00          	dc.b	"}",0
2082  00eb 00000000      	ds.b	4
2083  00ef               L506_temp1:
2084  00ef 00            	dc.b	0
2085  00f0 000000000000  	ds.b	14
2155                     ; 754 void vMevris_Send_RadiatorTemp()
2155                     ; 755 {
2156                     	switch	.text
2157  05ba               _vMevris_Send_RadiatorTemp:
2159  05ba 523c          	subw	sp,#60
2160       0000003c      OFST:	set	60
2163                     ; 756     uint8_t localBuffer[40] = "{\"RadiatorTemperature\":\"123456.89\"}";
2165  05bc 96            	ldw	x,sp
2166  05bd 1c0015        	addw	x,#OFST-39
2167  05c0 90ae00c7      	ldw	y,#L306_localBuffer
2168  05c4 a628          	ld	a,#40
2169  05c6 cd0000        	call	c_xymvx
2171                     ; 757     uint8_t unSendDataLength = 0;
2173                     ; 758     uint8_t temp1[15] = "";
2175  05c9 96            	ldw	x,sp
2176  05ca 1c0006        	addw	x,#OFST-54
2177  05cd 90ae00ef      	ldw	y,#L506_temp1
2178  05d1 a60f          	ld	a,#15
2179  05d3 cd0000        	call	c_xymvx
2181                     ; 759     uint32_t myVar = 0;
2183                     ; 760     vClearBuffer(localBuffer, 40);
2185  05d6 4b28          	push	#40
2186  05d8 96            	ldw	x,sp
2187  05d9 1c0016        	addw	x,#OFST-38
2188  05dc cd0000        	call	_vClearBuffer
2190  05df 84            	pop	a
2191                     ; 761     strcpy(localBuffer, "{\"RadiatorTemperature\":\"");
2193  05e0 96            	ldw	x,sp
2194  05e1 1c0015        	addw	x,#OFST-39
2195  05e4 90ae0182      	ldw	y,#L146
2196  05e8               L27:
2197  05e8 90f6          	ld	a,(y)
2198  05ea 905c          	incw	y
2199  05ec f7            	ld	(x),a
2200  05ed 5c            	incw	x
2201  05ee 4d            	tnz	a
2202  05ef 26f7          	jrne	L27
2203                     ; 762     myVar = (uint32_t)(Temperature1 * 100);
2205  05f1 ae0000        	ldw	x,#_Temperature1
2206  05f4 cd0000        	call	c_ltor
2208  05f7 ae017e        	ldw	x,#L746
2209  05fa cd0000        	call	c_fmul
2211  05fd cd0000        	call	c_ftol
2213  0600 96            	ldw	x,sp
2214  0601 1c0002        	addw	x,#OFST-58
2215  0604 cd0000        	call	c_rtol
2218                     ; 763     sprintf(temp1, "%ld", myVar / 100);
2220  0607 96            	ldw	x,sp
2221  0608 1c0002        	addw	x,#OFST-58
2222  060b cd0000        	call	c_ltor
2224  060e ae009b        	ldw	x,#L26
2225  0611 cd0000        	call	c_ludv
2227  0614 be02          	ldw	x,c_lreg+2
2228  0616 89            	pushw	x
2229  0617 be00          	ldw	x,c_lreg
2230  0619 89            	pushw	x
2231  061a ae01c0        	ldw	x,#L735
2232  061d 89            	pushw	x
2233  061e 96            	ldw	x,sp
2234  061f 1c000c        	addw	x,#OFST-48
2235  0622 cd0000        	call	_sprintf
2237  0625 5b06          	addw	sp,#6
2238                     ; 764     strcat(localBuffer, temp1);
2240  0627 96            	ldw	x,sp
2241  0628 1c0006        	addw	x,#OFST-54
2242  062b 89            	pushw	x
2243  062c 96            	ldw	x,sp
2244  062d 1c0017        	addw	x,#OFST-37
2245  0630 cd0000        	call	_strcat
2247  0633 85            	popw	x
2248                     ; 765     strcat(localBuffer, ".");
2250  0634 ae01be        	ldw	x,#L145
2251  0637 89            	pushw	x
2252  0638 96            	ldw	x,sp
2253  0639 1c0017        	addw	x,#OFST-37
2254  063c cd0000        	call	_strcat
2256  063f 85            	popw	x
2257                     ; 766     sprintf(temp1, "%ld", myVar % 100);
2259  0640 96            	ldw	x,sp
2260  0641 1c0002        	addw	x,#OFST-58
2261  0644 cd0000        	call	c_ltor
2263  0647 ae009b        	ldw	x,#L26
2264  064a cd0000        	call	c_lumd
2266  064d be02          	ldw	x,c_lreg+2
2267  064f 89            	pushw	x
2268  0650 be00          	ldw	x,c_lreg
2269  0652 89            	pushw	x
2270  0653 ae01c0        	ldw	x,#L735
2271  0656 89            	pushw	x
2272  0657 96            	ldw	x,sp
2273  0658 1c000c        	addw	x,#OFST-48
2274  065b cd0000        	call	_sprintf
2276  065e 5b06          	addw	sp,#6
2277                     ; 767     strcat(localBuffer, temp1);
2279  0660 96            	ldw	x,sp
2280  0661 1c0006        	addw	x,#OFST-54
2281  0664 89            	pushw	x
2282  0665 96            	ldw	x,sp
2283  0666 1c0017        	addw	x,#OFST-37
2284  0669 cd0000        	call	_strcat
2286  066c 85            	popw	x
2287                     ; 769     strcat(localBuffer, "\"}");
2289  066d ae01f4        	ldw	x,#L314
2290  0670 89            	pushw	x
2291  0671 96            	ldw	x,sp
2292  0672 1c0017        	addw	x,#OFST-37
2293  0675 cd0000        	call	_strcat
2295  0678 85            	popw	x
2296                     ; 770     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2298  0679 4b64          	push	#100
2299  067b ae0000        	ldw	x,#_aunPushed_Data
2300  067e cd0000        	call	_vClearBuffer
2302  0681 84            	pop	a
2303                     ; 779     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
2305  0682 96            	ldw	x,sp
2306  0683 1c0015        	addw	x,#OFST-39
2307  0686 89            	pushw	x
2308  0687 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2309  068a cd0000        	call	_vMQTT_Publish
2311  068d 85            	popw	x
2312                     ; 781 }
2315  068e 5b3c          	addw	sp,#60
2316  0690 81            	ret
2319                     	switch	.const
2320  00fe               L356_localBuffer:
2321  00fe 7b22          	dc.b	"{",34
2322  0100 456e67696e65  	dc.b	"EngineTemperature",34
2323  0112 3a22          	dc.b	":",34
2324  0114 313233343536  	dc.b	"123456.89",34
2325  011e 7d00          	dc.b	"}",0
2326  0120 000000000000  	ds.b	6
2327  0126               L556_temp1:
2328  0126 00            	dc.b	0
2329  0127 000000000000  	ds.b	14
2398                     ; 783 void vMevris_Send_EngineTemp()
2398                     ; 784 {
2399                     	switch	.text
2400  0691               _vMevris_Send_EngineTemp:
2402  0691 523c          	subw	sp,#60
2403       0000003c      OFST:	set	60
2406                     ; 785     uint8_t localBuffer[40] = "{\"EngineTemperature\":\"123456.89\"}";
2408  0693 96            	ldw	x,sp
2409  0694 1c0015        	addw	x,#OFST-39
2410  0697 90ae00fe      	ldw	y,#L356_localBuffer
2411  069b a628          	ld	a,#40
2412  069d cd0000        	call	c_xymvx
2414                     ; 786     uint8_t unSendDataLength = 0;
2416                     ; 787     uint8_t temp1[15] = "";
2418  06a0 96            	ldw	x,sp
2419  06a1 1c0006        	addw	x,#OFST-54
2420  06a4 90ae0126      	ldw	y,#L556_temp1
2421  06a8 a60f          	ld	a,#15
2422  06aa cd0000        	call	c_xymvx
2424                     ; 788     uint32_t myVar = 0;
2426                     ; 789     vClearBuffer(localBuffer, 40);
2428  06ad 4b28          	push	#40
2429  06af 96            	ldw	x,sp
2430  06b0 1c0016        	addw	x,#OFST-38
2431  06b3 cd0000        	call	_vClearBuffer
2433  06b6 84            	pop	a
2434                     ; 790     strcpy(localBuffer, "{\"EngineTemperature\":\"");
2436  06b7 96            	ldw	x,sp
2437  06b8 1c0015        	addw	x,#OFST-39
2438  06bb 90ae0167      	ldw	y,#L117
2439  06bf               L67:
2440  06bf 90f6          	ld	a,(y)
2441  06c1 905c          	incw	y
2442  06c3 f7            	ld	(x),a
2443  06c4 5c            	incw	x
2444  06c5 4d            	tnz	a
2445  06c6 26f7          	jrne	L67
2446                     ; 791     myVar = (uint32_t)(Temperature2 * 100);
2448  06c8 ae0000        	ldw	x,#_Temperature2
2449  06cb cd0000        	call	c_ltor
2451  06ce ae017e        	ldw	x,#L746
2452  06d1 cd0000        	call	c_fmul
2454  06d4 cd0000        	call	c_ftol
2456  06d7 96            	ldw	x,sp
2457  06d8 1c0002        	addw	x,#OFST-58
2458  06db cd0000        	call	c_rtol
2461                     ; 792     sprintf(temp1, "%ld", myVar / 100);
2463  06de 96            	ldw	x,sp
2464  06df 1c0002        	addw	x,#OFST-58
2465  06e2 cd0000        	call	c_ltor
2467  06e5 ae009b        	ldw	x,#L26
2468  06e8 cd0000        	call	c_ludv
2470  06eb be02          	ldw	x,c_lreg+2
2471  06ed 89            	pushw	x
2472  06ee be00          	ldw	x,c_lreg
2473  06f0 89            	pushw	x
2474  06f1 ae01c0        	ldw	x,#L735
2475  06f4 89            	pushw	x
2476  06f5 96            	ldw	x,sp
2477  06f6 1c000c        	addw	x,#OFST-48
2478  06f9 cd0000        	call	_sprintf
2480  06fc 5b06          	addw	sp,#6
2481                     ; 793     strcat(localBuffer, temp1);
2483  06fe 96            	ldw	x,sp
2484  06ff 1c0006        	addw	x,#OFST-54
2485  0702 89            	pushw	x
2486  0703 96            	ldw	x,sp
2487  0704 1c0017        	addw	x,#OFST-37
2488  0707 cd0000        	call	_strcat
2490  070a 85            	popw	x
2491                     ; 794     strcat(localBuffer, ".");
2493  070b ae01be        	ldw	x,#L145
2494  070e 89            	pushw	x
2495  070f 96            	ldw	x,sp
2496  0710 1c0017        	addw	x,#OFST-37
2497  0713 cd0000        	call	_strcat
2499  0716 85            	popw	x
2500                     ; 795     sprintf(temp1, "%ld", myVar % 100);
2502  0717 96            	ldw	x,sp
2503  0718 1c0002        	addw	x,#OFST-58
2504  071b cd0000        	call	c_ltor
2506  071e ae009b        	ldw	x,#L26
2507  0721 cd0000        	call	c_lumd
2509  0724 be02          	ldw	x,c_lreg+2
2510  0726 89            	pushw	x
2511  0727 be00          	ldw	x,c_lreg
2512  0729 89            	pushw	x
2513  072a ae01c0        	ldw	x,#L735
2514  072d 89            	pushw	x
2515  072e 96            	ldw	x,sp
2516  072f 1c000c        	addw	x,#OFST-48
2517  0732 cd0000        	call	_sprintf
2519  0735 5b06          	addw	sp,#6
2520                     ; 796     strcat(localBuffer, temp1);
2522  0737 96            	ldw	x,sp
2523  0738 1c0006        	addw	x,#OFST-54
2524  073b 89            	pushw	x
2525  073c 96            	ldw	x,sp
2526  073d 1c0017        	addw	x,#OFST-37
2527  0740 cd0000        	call	_strcat
2529  0743 85            	popw	x
2530                     ; 798     strcat(localBuffer, "\"}");
2532  0744 ae01f4        	ldw	x,#L314
2533  0747 89            	pushw	x
2534  0748 96            	ldw	x,sp
2535  0749 1c0017        	addw	x,#OFST-37
2536  074c cd0000        	call	_strcat
2538  074f 85            	popw	x
2539                     ; 807     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
2541  0750 96            	ldw	x,sp
2542  0751 1c0015        	addw	x,#OFST-39
2543  0754 89            	pushw	x
2544  0755 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2545  0758 cd0000        	call	_vMQTT_Publish
2547  075b 85            	popw	x
2548                     ; 809 }
2551  075c 5b3c          	addw	sp,#60
2552  075e 81            	ret
2555                     	switch	.const
2556  0135               L317_localBuffer:
2557  0135 7b22          	dc.b	"{",34
2558  0137 6675656c22    	dc.b	"fuel",34
2559  013c 3a22          	dc.b	":",34
2560  013e 313233343536  	dc.b	"123456.89",34
2561  0148 7d00          	dc.b	"}",0
2562  014a 000000000000  	ds.b	9
2563  0153               L517_temp1:
2564  0153 00            	dc.b	0
2565  0154 000000000000  	ds.b	9
2625                     ; 811 void vMevris_Send_FuelLevel()
2625                     ; 812 {
2626                     	switch	.text
2627  075f               _vMevris_Send_FuelLevel:
2629  075f 5229          	subw	sp,#41
2630       00000029      OFST:	set	41
2633                     ; 813     uint8_t localBuffer[30] = "{\"fuel\":\"123456.89\"}";
2635  0761 96            	ldw	x,sp
2636  0762 1c000c        	addw	x,#OFST-29
2637  0765 90ae0135      	ldw	y,#L317_localBuffer
2638  0769 a61e          	ld	a,#30
2639  076b cd0000        	call	c_xymvx
2641                     ; 814     uint8_t unSendDataLength = 0;
2643                     ; 815     uint8_t temp1[10] = "";
2645  076e 96            	ldw	x,sp
2646  076f 1c0002        	addw	x,#OFST-39
2647  0772 90ae0153      	ldw	y,#L517_temp1
2648  0776 a60a          	ld	a,#10
2649  0778 cd0000        	call	c_xymvx
2651                     ; 816     vClearBuffer(localBuffer, 30);
2653  077b 4b1e          	push	#30
2654  077d 96            	ldw	x,sp
2655  077e 1c000d        	addw	x,#OFST-28
2656  0781 cd0000        	call	_vClearBuffer
2658  0784 84            	pop	a
2659                     ; 817     strcpy(localBuffer, "{\"fuel\":\"");
2661  0785 96            	ldw	x,sp
2662  0786 1c000c        	addw	x,#OFST-29
2663  0789 90ae015d      	ldw	y,#L547
2664  078d               L201:
2665  078d 90f6          	ld	a,(y)
2666  078f 905c          	incw	y
2667  0791 f7            	ld	(x),a
2668  0792 5c            	incw	x
2669  0793 4d            	tnz	a
2670  0794 26f7          	jrne	L201
2671                     ; 818     sprintf(temp1, "%ld", Fuellevel);
2673  0796 ce0002        	ldw	x,_Fuellevel+2
2674  0799 89            	pushw	x
2675  079a ce0000        	ldw	x,_Fuellevel
2676  079d 89            	pushw	x
2677  079e ae01c0        	ldw	x,#L735
2678  07a1 89            	pushw	x
2679  07a2 96            	ldw	x,sp
2680  07a3 1c0008        	addw	x,#OFST-33
2681  07a6 cd0000        	call	_sprintf
2683  07a9 5b06          	addw	sp,#6
2684                     ; 819     strcat(localBuffer, temp1);
2686  07ab 96            	ldw	x,sp
2687  07ac 1c0002        	addw	x,#OFST-39
2688  07af 89            	pushw	x
2689  07b0 96            	ldw	x,sp
2690  07b1 1c000e        	addw	x,#OFST-27
2691  07b4 cd0000        	call	_strcat
2693  07b7 85            	popw	x
2694                     ; 820     strcat(localBuffer, "\"}");
2696  07b8 ae01f4        	ldw	x,#L314
2697  07bb 89            	pushw	x
2698  07bc 96            	ldw	x,sp
2699  07bd 1c000e        	addw	x,#OFST-27
2700  07c0 cd0000        	call	_strcat
2702  07c3 85            	popw	x
2703                     ; 829     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
2705  07c4 96            	ldw	x,sp
2706  07c5 1c000c        	addw	x,#OFST-29
2707  07c8 89            	pushw	x
2708  07c9 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2709  07cc cd0000        	call	_vMQTT_Publish
2711  07cf 85            	popw	x
2712                     ; 831 }
2715  07d0 5b29          	addw	sp,#41
2716  07d2 81            	ret
2803                     	xdef	_sendDataToCloud
2804                     	xref.b	_IMEIRecievedOKFlag
2805                     	xdef	_bCONNACK_Recieved
2806                     	xdef	_aunPushed_Data
2807                     	xdef	_vMevris_Send_Phase
2808                     	xdef	_vMevris_Send_FuelLevel
2809                     	xdef	_vMevris_Send_EngineTemp
2810                     	xdef	_vMevris_Send_RadiatorTemp
2811                     	xdef	_vMevris_Send_BatteryVolt
2812                     	xdef	_aunMQTT_Publish_Topic
2813                     	xdef	_aunMQTT_Subscribe_Topic
2814                     	xdef	_aunMQTT_ClientID
2815                     	xref	_Temperature2
2816                     	xref	_Temperature1
2817                     	xref	_Fuellevel
2818                     	xref.b	_batVolt
2819                     	xref	_Watt_Phase3
2820                     	xref	_Ampere_Phase3
2821                     	xref	_Voltage_Phase3
2822                     	xref	_Watt_Phase2
2823                     	xref	_Ampere_Phase2
2824                     	xref	_Voltage_Phase2
2825                     	xref	_Watt_Phase1
2826                     	xref	_Ampere_Phase1
2827                     	xref	_Voltage_Phase1
2828                     	xdef	_vMevris_Send_Version
2829                     	xdef	_vMevris_Send_IMEI
2830                     	xdef	_punGet_Client_ID
2831                     	xdef	_punGet_Command_Topic
2832                     	xdef	_punGet_Event_Topic
2833                     	xdef	_vHandleMevris_MQTT_Recv_Data
2834                     	xdef	_vHandleMevrisRecievedData
2835                     	xref	_enGet_TCP_Status
2836                     	xref	_vClearBuffer
2837                     	xref	_response_buffer
2838                     	xref	_vMQTT_Publish
2839                     	xref.b	_aunIMEI
2840                     	xref	_sprintf
2841                     	xref	_strstr
2842                     	xref	_strcat
2843                     	switch	.const
2844  015d               L547:
2845  015d 7b22          	dc.b	"{",34
2846  015f 6675656c22    	dc.b	"fuel",34
2847  0164 3a2200        	dc.b	":",34,0
2848  0167               L117:
2849  0167 7b22          	dc.b	"{",34
2850  0169 456e67696e65  	dc.b	"EngineTemperature",34
2851  017b 3a2200        	dc.b	":",34,0
2852  017e               L746:
2853  017e 42c80000      	dc.w	17096,0
2854  0182               L146:
2855  0182 7b22          	dc.b	"{",34
2856  0184 526164696174  	dc.b	"RadiatorTemperatur"
2857  0196 6522          	dc.b	"e",34
2858  0198 3a2200        	dc.b	":",34,0
2859  019b               L106:
2860  019b 7b22          	dc.b	"{",34
2861  019d 626174746572  	dc.b	"battery",34
2862  01a5 3a2200        	dc.b	":",34,0
2863  01a8               L545:
2864  01a8 222c22637572  	dc.b	34,44,34,99,117,114
2865  01ae 72656e7400    	dc.b	"rent",0
2866  01b3               L345:
2867  01b3 222c22766f6c  	dc.b	34,44,34,118,111,108
2868  01b9 7461676500    	dc.b	"tage",0
2869  01be               L145:
2870  01be 2e00          	dc.b	".",0
2871  01c0               L735:
2872  01c0 256c6400      	dc.b	"%ld",0
2873  01c4               L535:
2874  01c4 223a2200      	dc.b	34,58,34,0
2875  01c8               L335:
2876  01c8 7b22          	dc.b	"{",34
2877  01ca 706f77657200  	dc.b	"power",0
2878  01d0               L135:
2879  01d0 256400        	dc.b	"%d",0
2880  01d3               L744:
2881  01d3 302e302e3030  	dc.b	"0.0.001",0
2882  01db               L544:
2883  01db 222c22687722  	dc.b	34,44,34,104,119,34
2884  01e1 3a2200        	dc.b	":",34,0
2885  01e4               L344:
2886  01e4 322e342e3030  	dc.b	"2.4.001",0
2887  01ec               L144:
2888  01ec 7b22          	dc.b	"{",34
2889  01ee 667722        	dc.b	"fw",34
2890  01f1 3a2200        	dc.b	":",34,0
2891  01f4               L314:
2892  01f4 227d00        	dc.b	34,125,0
2893  01f7               L114:
2894  01f7 7b22          	dc.b	"{",34
2895  01f9 696d656922    	dc.b	"imei",34
2896  01fe 3a2200        	dc.b	":",34,0
2897  0201               L363:
2898  0201 6576656e7400  	dc.b	"event",0
2899  0207               L343:
2900  0207 636f6d6d616e  	dc.b	"command",0
2901  020f               L143:
2902  020f 2f00          	dc.b	"/",0
2903  0211               L123:
2904  0211 67656e00      	dc.b	"gen",0
2905  0215               L703:
2906  0215 22696d656922  	dc.b	34,105,109,101,105,34,0
2907  021c               L303:
2908  021c 22696e666f22  	dc.b	34,105,110,102,111,34,0
2909  0223               L132:
2910  0223 73633200      	dc.b	"sc2",0
2911                     	xref.b	c_lreg
2912                     	xref.b	c_x
2932                     	xref	c_rtol
2933                     	xref	c_ftol
2934                     	xref	c_fmul
2935                     	xref	c_lumd
2936                     	xref	c_ludv
2937                     	xref	c_ltor
2938                     	xref	c_xymvx
2939                     	end
