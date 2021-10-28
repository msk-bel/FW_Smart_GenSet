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
 313                     ; 60 void sendDataToCloud(void)
 313                     ; 61 {
 315                     	switch	.text
 316  0000               _sendDataToCloud:
 318  0000 88            	push	a
 319       00000001      OFST:	set	1
 322                     ; 70     tempCounter++; //Added by Saqib
 324  0001 3c01          	inc	L5_tempCounter
 325                     ; 71     if (tempCounter >= 3)
 327  0003 b601          	ld	a,L5_tempCounter
 328  0005 a103          	cp	a,#3
 329  0007 2403          	jruge	L6
 330  0009 cc00ea        	jp	L561
 331  000c               L6:
 332                     ; 73         eTCP_Status = enGet_TCP_Status();
 334  000c cd0000        	call	_enGet_TCP_Status
 336  000f 6b01          	ld	(OFST+0,sp),a
 338                     ; 74         if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
 340  0011 7b01          	ld	a,(OFST+0,sp)
 341  0013 a107          	cp	a,#7
 342  0015 2703          	jreq	L01
 343  0017 cc00e6        	jp	L761
 344  001a               L01:
 346  001a 3d00          	tnz	_IMEIRecievedOKFlag
 347  001c 2603          	jrne	L21
 348  001e cc00e6        	jp	L761
 349  0021               L21:
 350                     ; 76             switch (enSendEventCounter)
 352  0021 b600          	ld	a,L3_enSendEventCounter
 354                     ; 121             default:
 354                     ; 122                 break;
 355  0023 a002          	sub	a,#2
 356  0025 272a          	jreq	L7
 357  0027 4a            	dec	a
 358  0028 272d          	jreq	L11
 359  002a 4a            	dec	a
 360  002b 272f          	jreq	L31
 361  002d 4a            	dec	a
 362  002e 2731          	jreq	L51
 363  0030 4a            	dec	a
 364  0031 274f          	jreq	L71
 365  0033 4a            	dec	a
 366  0034 276d          	jreq	L12
 367  0036 4a            	dec	a
 368  0037 2603          	jrne	L41
 369  0039 cc00c4        	jp	L32
 370  003c               L41:
 371  003c 4a            	dec	a
 372  003d 2603          	jrne	L61
 373  003f cc00c9        	jp	L52
 374  0042               L61:
 375  0042 4a            	dec	a
 376  0043 2603          	jrne	L02
 377  0045 cc00ce        	jp	L72
 378  0048               L02:
 379  0048 4a            	dec	a
 380  0049 2603          	jrne	L22
 381  004b cc00d3        	jp	L13
 382  004e               L22:
 383  004e cc00d6        	jra	L371
 384  0051               L7:
 385                     ; 84             case eCommand_SIM_Number:
 385                     ; 85                 vMevris_Send_SIM_Number();
 387  0051 cd02ba        	call	_vMevris_Send_SIM_Number
 389                     ; 86                 break;
 391  0054 cc00d6        	jra	L371
 392  0057               L11:
 393                     ; 87             case eCommand_Location:
 393                     ; 88                 vMevris_Send_Location();
 395  0057 cd0369        	call	_vMevris_Send_Location
 397                     ; 89                 break;
 399  005a 207a          	jra	L371
 400  005c               L31:
 401                     ; 90             case eCommand_Version:
 401                     ; 91                 // vMevris_Send_Version();
 401                     ; 92                 vMevris_Send_SIM_ICCID();
 403  005c cd0318        	call	_vMevris_Send_SIM_ICCID
 405                     ; 93                 break;
 407  005f 2075          	jra	L371
 408  0061               L51:
 409                     ; 94             case eCommand_Phase1:
 409                     ; 95                 // vMevris_Send_Phase1();
 409                     ; 96                 vMevris_Send_Phase(1, Watt_Phase1, Voltage_Phase1, Ampere_Phase1);
 411  0061 ce0002        	ldw	x,_Ampere_Phase1+2
 412  0064 89            	pushw	x
 413  0065 ce0000        	ldw	x,_Ampere_Phase1
 414  0068 89            	pushw	x
 415  0069 ce0002        	ldw	x,_Voltage_Phase1+2
 416  006c 89            	pushw	x
 417  006d ce0000        	ldw	x,_Voltage_Phase1
 418  0070 89            	pushw	x
 419  0071 ce0002        	ldw	x,_Watt_Phase1+2
 420  0074 89            	pushw	x
 421  0075 ce0000        	ldw	x,_Watt_Phase1
 422  0078 89            	pushw	x
 423  0079 a601          	ld	a,#1
 424  007b cd043b        	call	_vMevris_Send_Phase
 426  007e 5b0c          	addw	sp,#12
 427                     ; 97                 break;
 429  0080 2054          	jra	L371
 430  0082               L71:
 431                     ; 98             case eCommand_Phase2:
 431                     ; 99                 // vMevris_Send_Phase2();
 431                     ; 100                 vMevris_Send_Phase(2, Watt_Phase2, Voltage_Phase2, Ampere_Phase2);
 433  0082 ce0002        	ldw	x,_Ampere_Phase2+2
 434  0085 89            	pushw	x
 435  0086 ce0000        	ldw	x,_Ampere_Phase2
 436  0089 89            	pushw	x
 437  008a ce0002        	ldw	x,_Voltage_Phase2+2
 438  008d 89            	pushw	x
 439  008e ce0000        	ldw	x,_Voltage_Phase2
 440  0091 89            	pushw	x
 441  0092 ce0002        	ldw	x,_Watt_Phase2+2
 442  0095 89            	pushw	x
 443  0096 ce0000        	ldw	x,_Watt_Phase2
 444  0099 89            	pushw	x
 445  009a a602          	ld	a,#2
 446  009c cd043b        	call	_vMevris_Send_Phase
 448  009f 5b0c          	addw	sp,#12
 449                     ; 101                 break;
 451  00a1 2033          	jra	L371
 452  00a3               L12:
 453                     ; 102             case eCommand_Phase3:
 453                     ; 103                 // vMevris_Send_Phase3();
 453                     ; 104                 vMevris_Send_Phase(3, Watt_Phase3, Voltage_Phase3, Ampere_Phase3);
 455  00a3 ce0002        	ldw	x,_Ampere_Phase3+2
 456  00a6 89            	pushw	x
 457  00a7 ce0000        	ldw	x,_Ampere_Phase3
 458  00aa 89            	pushw	x
 459  00ab ce0002        	ldw	x,_Voltage_Phase3+2
 460  00ae 89            	pushw	x
 461  00af ce0000        	ldw	x,_Voltage_Phase3
 462  00b2 89            	pushw	x
 463  00b3 ce0002        	ldw	x,_Watt_Phase3+2
 464  00b6 89            	pushw	x
 465  00b7 ce0000        	ldw	x,_Watt_Phase3
 466  00ba 89            	pushw	x
 467  00bb a603          	ld	a,#3
 468  00bd cd043b        	call	_vMevris_Send_Phase
 470  00c0 5b0c          	addw	sp,#12
 471                     ; 105                 break;
 473  00c2 2012          	jra	L371
 474  00c4               L32:
 475                     ; 106             case eCommand_BatteryVolts:
 475                     ; 107                 vMevris_Send_BatteryVolt();
 477  00c4 cd0642        	call	_vMevris_Send_BatteryVolt
 479                     ; 108                 break;
 481  00c7 200d          	jra	L371
 482  00c9               L52:
 483                     ; 109             case eCommand_RadiatorTemp:
 483                     ; 110                 vMevris_Send_RadiatorTemp();
 485  00c9 cd06f8        	call	_vMevris_Send_RadiatorTemp
 487                     ; 111                 break;
 489  00cc 2008          	jra	L371
 490  00ce               L72:
 491                     ; 112             case eCommand_EngineTemp:
 491                     ; 113                 vMevris_Send_EngineTemp();
 493  00ce cd07e8        	call	_vMevris_Send_EngineTemp
 495                     ; 114                 break;
 497  00d1 2003          	jra	L371
 498  00d3               L13:
 499                     ; 115             case eCommand_FuelLevel:
 499                     ; 116                 vMevris_Send_FuelLevel();
 501  00d3 cd08cf        	call	_vMevris_Send_FuelLevel
 503                     ; 117                 break;
 505  00d6               L33:
 506                     ; 118             case eCommand_Others:
 506                     ; 119                 // Do something
 506                     ; 120                 break;
 508  00d6               L53:
 509                     ; 121             default:
 509                     ; 122                 break;
 511  00d6               L371:
 512                     ; 125             enSendEventCounter++;
 514  00d6 3c00          	inc	L3_enSendEventCounter
 515                     ; 126             if (enSendEventCounter >= eCommand_Others)
 517  00d8 b600          	ld	a,L3_enSendEventCounter
 518  00da a10c          	cp	a,#12
 519  00dc 2504          	jrult	L571
 520                     ; 127                 enSendEventCounter = eCommand_IMEI;
 522  00de 35010000      	mov	L3_enSendEventCounter,#1
 523  00e2               L571:
 524                     ; 128             tempCounter = 0;
 526  00e2 3f01          	clr	L5_tempCounter
 528  00e4 2004          	jra	L561
 529  00e6               L761:
 530                     ; 132             enSendEventCounter = eCommand_IMEI;
 532  00e6 35010000      	mov	L3_enSendEventCounter,#1
 533  00ea               L561:
 534                     ; 135 }
 537  00ea 84            	pop	a
 538  00eb 81            	ret
 615                     ; 338 void vHandleMevris_MQTT_Recv_Data(void)
 615                     ; 339 {
 616                     	switch	.text
 617  00ec               _vHandleMevris_MQTT_Recv_Data:
 619  00ec 5225          	subw	sp,#37
 620       00000025      OFST:	set	37
 623                     ; 342     uint8_t i = 0, j;
 625                     ; 343     uint8_t unLength = 0;
 627  00ee 0f21          	clr	(OFST-4,sp)
 629                     ; 412     ptr = strstr(response_buffer, MQTT_TOPIC_HEADER);
 631  00f0 ae02e0        	ldw	x,#L732
 632  00f3 89            	pushw	x
 633  00f4 ae0000        	ldw	x,#_response_buffer
 634  00f7 cd0000        	call	_strstr
 636  00fa 5b02          	addw	sp,#2
 637  00fc 1f23          	ldw	(OFST-2,sp),x
 639                     ; 413     if (ptr)
 641  00fe 1e23          	ldw	x,(OFST-2,sp)
 642  0100 2602          	jrne	L63
 643  0102 207e          	jp	L142
 644  0104               L63:
 645                     ; 415         i = 0;
 647  0104 0f25          	clr	(OFST+0,sp)
 650  0106 2002          	jra	L742
 651  0108               L342:
 652                     ; 417             i++;
 655  0108 0c25          	inc	(OFST+0,sp)
 657  010a               L742:
 658                     ; 416         while (*(ptr + i) != '{' && i < 99)
 658                     ; 417             i++;
 660  010a 7b23          	ld	a,(OFST-2,sp)
 661  010c 97            	ld	xl,a
 662  010d 7b24          	ld	a,(OFST-1,sp)
 663  010f 1b25          	add	a,(OFST+0,sp)
 664  0111 2401          	jrnc	L62
 665  0113 5c            	incw	x
 666  0114               L62:
 667  0114 02            	rlwa	x,a
 668  0115 f6            	ld	a,(x)
 669  0116 a17b          	cp	a,#123
 670  0118 2706          	jreq	L352
 672  011a 7b25          	ld	a,(OFST+0,sp)
 673  011c a163          	cp	a,#99
 674  011e 25e8          	jrult	L342
 675  0120               L352:
 676                     ; 418         if (*(ptr + i) == '{')
 678  0120 7b23          	ld	a,(OFST-2,sp)
 679  0122 97            	ld	xl,a
 680  0123 7b24          	ld	a,(OFST-1,sp)
 681  0125 1b25          	add	a,(OFST+0,sp)
 682  0127 2401          	jrnc	L03
 683  0129 5c            	incw	x
 684  012a               L03:
 685  012a 02            	rlwa	x,a
 686  012b f6            	ld	a,(x)
 687  012c a17b          	cp	a,#123
 688  012e 2652          	jrne	L142
 689                     ; 420             vClearBuffer(localBuffer, 30);
 691  0130 4b1e          	push	#30
 692  0132 96            	ldw	x,sp
 693  0133 1c0004        	addw	x,#OFST-33
 694  0136 cd0000        	call	_vClearBuffer
 696  0139 84            	pop	a
 697                     ; 421             j = 0;
 699  013a 0f22          	clr	(OFST-3,sp)
 702  013c 2024          	jra	L362
 703  013e               L752:
 704                     ; 424                 localBuffer[j++] = *(ptr + i);
 706  013e 96            	ldw	x,sp
 707  013f 1c0003        	addw	x,#OFST-34
 708  0142 1f01          	ldw	(OFST-36,sp),x
 710  0144 7b22          	ld	a,(OFST-3,sp)
 711  0146 97            	ld	xl,a
 712  0147 0c22          	inc	(OFST-3,sp)
 714  0149 9f            	ld	a,xl
 715  014a 5f            	clrw	x
 716  014b 97            	ld	xl,a
 717  014c 72fb01        	addw	x,(OFST-36,sp)
 718  014f 89            	pushw	x
 719  0150 7b25          	ld	a,(OFST+0,sp)
 720  0152 97            	ld	xl,a
 721  0153 7b26          	ld	a,(OFST+1,sp)
 722  0155 1b27          	add	a,(OFST+2,sp)
 723  0157 2401          	jrnc	L23
 724  0159 5c            	incw	x
 725  015a               L23:
 726  015a 02            	rlwa	x,a
 727  015b f6            	ld	a,(x)
 728  015c 85            	popw	x
 729  015d f7            	ld	(x),a
 730                     ; 425                 unLength++;
 732  015e 0c21          	inc	(OFST-4,sp)
 734                     ; 426                 i++;
 736  0160 0c25          	inc	(OFST+0,sp)
 738  0162               L362:
 739                     ; 422             while (*(ptr + i) != '\r' && j < 29)
 741  0162 7b23          	ld	a,(OFST-2,sp)
 742  0164 97            	ld	xl,a
 743  0165 7b24          	ld	a,(OFST-1,sp)
 744  0167 1b25          	add	a,(OFST+0,sp)
 745  0169 2401          	jrnc	L43
 746  016b 5c            	incw	x
 747  016c               L43:
 748  016c 02            	rlwa	x,a
 749  016d f6            	ld	a,(x)
 750  016e a10d          	cp	a,#13
 751  0170 2706          	jreq	L762
 753  0172 7b22          	ld	a,(OFST-3,sp)
 754  0174 a11d          	cp	a,#29
 755  0176 25c6          	jrult	L752
 756  0178               L762:
 757                     ; 428             vHandleMevrisRecievedData(localBuffer, unLength);
 759  0178 7b21          	ld	a,(OFST-4,sp)
 760  017a 88            	push	a
 761  017b 96            	ldw	x,sp
 762  017c 1c0004        	addw	x,#OFST-33
 763  017f ad04          	call	_vHandleMevrisRecievedData
 765  0181 84            	pop	a
 766  0182               L142:
 767                     ; 432 }
 770  0182 5b25          	addw	sp,#37
 771  0184 81            	ret
 809                     ; 434 void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength)
 809                     ; 435 {
 810                     	switch	.text
 811  0185               _vHandleMevrisRecievedData:
 813  0185 89            	pushw	x
 814       00000000      OFST:	set	0
 817                     ; 438     if (strstr(Data, "\"info\"")) //Example "{"info":"imei"}"
 819  0186 ae02d9        	ldw	x,#L113
 820  0189 89            	pushw	x
 821  018a 1e03          	ldw	x,(OFST+3,sp)
 822  018c cd0000        	call	_strstr
 824  018f 5b02          	addw	sp,#2
 825  0191 a30000        	cpw	x,#0
 826  0194 2713          	jreq	L703
 827                     ; 440         if (strstr(Data, "\"imei\""))
 829  0196 ae02d2        	ldw	x,#L513
 830  0199 89            	pushw	x
 831  019a 1e03          	ldw	x,(OFST+3,sp)
 832  019c cd0000        	call	_strstr
 834  019f 5b02          	addw	sp,#2
 835  01a1 a30000        	cpw	x,#0
 836  01a4 2703          	jreq	L703
 837                     ; 442             vMevris_Send_IMEI();
 839  01a6 cd0269        	call	_vMevris_Send_IMEI
 841  01a9               L703:
 842                     ; 445 }
 845  01a9 85            	popw	x
 846  01aa 81            	ret
 875                     ; 447 uint8_t *punGet_Client_ID(void)
 875                     ; 448 {
 876                     	switch	.text
 877  01ab               _punGet_Client_ID:
 881                     ; 455     vClearBuffer(aunMQTT_ClientID, 20);
 883  01ab 4b14          	push	#20
 884  01ad ae0064        	ldw	x,#_aunMQTT_ClientID
 885  01b0 cd0000        	call	_vClearBuffer
 887  01b3 84            	pop	a
 888                     ; 456     strcpy(aunMQTT_ClientID, "gen");
 890  01b4 ae0064        	ldw	x,#_aunMQTT_ClientID
 891  01b7 90ae02ce      	ldw	y,#L723
 892  01bb               L44:
 893  01bb 90f6          	ld	a,(y)
 894  01bd 905c          	incw	y
 895  01bf f7            	ld	(x),a
 896  01c0 5c            	incw	x
 897  01c1 4d            	tnz	a
 898  01c2 26f7          	jrne	L44
 899                     ; 457     strcat(aunMQTT_ClientID, aunIMEI);
 901  01c4 ae0000        	ldw	x,#_aunIMEI
 902  01c7 89            	pushw	x
 903  01c8 ae0064        	ldw	x,#_aunMQTT_ClientID
 904  01cb cd0000        	call	_strcat
 906  01ce 85            	popw	x
 907                     ; 459     return aunMQTT_ClientID;
 909  01cf ae0064        	ldw	x,#_aunMQTT_ClientID
 912  01d2 81            	ret
 953                     ; 462 uint8_t *punGet_Command_Topic(void)
 953                     ; 463 {
 954                     	switch	.text
 955  01d3               _punGet_Command_Topic:
 957  01d3 88            	push	a
 958       00000001      OFST:	set	1
 961                     ; 464     uint8_t i = 0;
 963                     ; 470     vClearBuffer(aunMQTT_Subscribe_Topic, 30);
 965  01d4 4b1e          	push	#30
 966  01d6 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 967  01d9 cd0000        	call	_vClearBuffer
 969  01dc 84            	pop	a
 970                     ; 471     strcpy(aunMQTT_Subscribe_Topic, MQTT_TOPIC_HEADER);
 972  01dd ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 973  01e0 90ae02e0      	ldw	y,#L732
 974  01e4               L05:
 975  01e4 90f6          	ld	a,(y)
 976  01e6 905c          	incw	y
 977  01e8 f7            	ld	(x),a
 978  01e9 5c            	incw	x
 979  01ea 4d            	tnz	a
 980  01eb 26f7          	jrne	L05
 981                     ; 472     strcat(aunMQTT_Subscribe_Topic, "/");
 983  01ed ae02cc        	ldw	x,#L743
 984  01f0 89            	pushw	x
 985  01f1 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 986  01f4 cd0000        	call	_strcat
 988  01f7 85            	popw	x
 989                     ; 473     strcat(aunMQTT_Subscribe_Topic, aunIMEI);
 991  01f8 ae0000        	ldw	x,#_aunIMEI
 992  01fb 89            	pushw	x
 993  01fc ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 994  01ff cd0000        	call	_strcat
 996  0202 85            	popw	x
 997                     ; 474     strcat(aunMQTT_Subscribe_Topic, "/");
 999  0203 ae02cc        	ldw	x,#L743
1000  0206 89            	pushw	x
1001  0207 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1002  020a cd0000        	call	_strcat
1004  020d 85            	popw	x
1005                     ; 475     strcat(aunMQTT_Subscribe_Topic, MQTT_INBOUND_TOPIC_FOOTER);
1007  020e ae02c4        	ldw	x,#L153
1008  0211 89            	pushw	x
1009  0212 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1010  0215 cd0000        	call	_strcat
1012  0218 85            	popw	x
1013                     ; 477     return aunMQTT_Subscribe_Topic;
1015  0219 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1018  021c 84            	pop	a
1019  021d 81            	ret
1059                     ; 480 uint8_t *punGet_Event_Topic(void)
1059                     ; 481 {
1060                     	switch	.text
1061  021e               _punGet_Event_Topic:
1063  021e 88            	push	a
1064       00000001      OFST:	set	1
1067                     ; 482     uint8_t i = 0;
1069                     ; 488     vClearBuffer(aunMQTT_Publish_Topic, 30);
1071  021f 4b1e          	push	#30
1072  0221 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1073  0224 cd0000        	call	_vClearBuffer
1075  0227 84            	pop	a
1076                     ; 489     strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
1078  0228 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1079  022b 90ae02e0      	ldw	y,#L732
1080  022f               L45:
1081  022f 90f6          	ld	a,(y)
1082  0231 905c          	incw	y
1083  0233 f7            	ld	(x),a
1084  0234 5c            	incw	x
1085  0235 4d            	tnz	a
1086  0236 26f7          	jrne	L45
1087                     ; 490     strcat(aunMQTT_Publish_Topic, "/");
1089  0238 ae02cc        	ldw	x,#L743
1090  023b 89            	pushw	x
1091  023c ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1092  023f cd0000        	call	_strcat
1094  0242 85            	popw	x
1095                     ; 491     strcat(aunMQTT_Publish_Topic, aunIMEI);
1097  0243 ae0000        	ldw	x,#_aunIMEI
1098  0246 89            	pushw	x
1099  0247 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1100  024a cd0000        	call	_strcat
1102  024d 85            	popw	x
1103                     ; 492     strcat(aunMQTT_Publish_Topic, "/");
1105  024e ae02cc        	ldw	x,#L743
1106  0251 89            	pushw	x
1107  0252 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1108  0255 cd0000        	call	_strcat
1110  0258 85            	popw	x
1111                     ; 493     strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);
1113  0259 ae02be        	ldw	x,#L173
1114  025c 89            	pushw	x
1115  025d ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1116  0260 cd0000        	call	_strcat
1118  0263 85            	popw	x
1119                     ; 495     return aunMQTT_Publish_Topic;
1121  0264 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1124  0267 84            	pop	a
1125  0268 81            	ret
1128                     .const:	section	.text
1129  0000               L373_localBuffer:
1130  0000 7b22          	dc.b	"{",34
1131  0002 696d656922    	dc.b	"imei",34
1132  0007 3a22          	dc.b	":",34
1133  0009 313233343536  	dc.b	"123456789012345",34
1134  0019 7d00          	dc.b	"}",0
1135  001b 000000        	ds.b	3
1183                     ; 499 void vMevris_Send_IMEI(void)
1183                     ; 500 {
1184                     	switch	.text
1185  0269               _vMevris_Send_IMEI:
1187  0269 521f          	subw	sp,#31
1188       0000001f      OFST:	set	31
1191                     ; 501     uint8_t localBuffer[30] = "{\"imei\":\"123456789012345\"}";
1193  026b 96            	ldw	x,sp
1194  026c 1c0002        	addw	x,#OFST-29
1195  026f 90ae0000      	ldw	y,#L373_localBuffer
1196  0273 a61e          	ld	a,#30
1197  0275 cd0000        	call	c_xymvx
1199                     ; 502     uint8_t unSendDataLength = 0;
1201                     ; 503     vClearBuffer(localBuffer, 30);
1203  0278 4b1e          	push	#30
1204  027a 96            	ldw	x,sp
1205  027b 1c0003        	addw	x,#OFST-28
1206  027e cd0000        	call	_vClearBuffer
1208  0281 84            	pop	a
1209                     ; 504     strcpy(localBuffer, "{\"imei\":\"");
1211  0282 96            	ldw	x,sp
1212  0283 1c0002        	addw	x,#OFST-29
1213  0286 90ae02b4      	ldw	y,#L714
1214  028a               L06:
1215  028a 90f6          	ld	a,(y)
1216  028c 905c          	incw	y
1217  028e f7            	ld	(x),a
1218  028f 5c            	incw	x
1219  0290 4d            	tnz	a
1220  0291 26f7          	jrne	L06
1221                     ; 505     strcat(localBuffer, aunIMEI);
1223  0293 ae0000        	ldw	x,#_aunIMEI
1224  0296 89            	pushw	x
1225  0297 96            	ldw	x,sp
1226  0298 1c0004        	addw	x,#OFST-27
1227  029b cd0000        	call	_strcat
1229  029e 85            	popw	x
1230                     ; 506     strcat(localBuffer, "\"}");
1232  029f ae02b1        	ldw	x,#L124
1233  02a2 89            	pushw	x
1234  02a3 96            	ldw	x,sp
1235  02a4 1c0004        	addw	x,#OFST-27
1236  02a7 cd0000        	call	_strcat
1238  02aa 85            	popw	x
1239                     ; 515     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1241  02ab 96            	ldw	x,sp
1242  02ac 1c0002        	addw	x,#OFST-29
1243  02af 89            	pushw	x
1244  02b0 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1245  02b3 cd0000        	call	_vMQTT_Publish
1247  02b6 85            	popw	x
1248                     ; 517 }
1251  02b7 5b1f          	addw	sp,#31
1252  02b9 81            	ret
1255                     	switch	.const
1256  001e               L324_localBuffer:
1257  001e 7b22          	dc.b	"{",34
1258  0020 53494d22      	dc.b	"SIM",34
1259  0024 3a22          	dc.b	":",34
1260  0026 2b3932333331  	dc.b	"+923316821907",34
1261  0034 7d00          	dc.b	"}",0
1262  0036 000000000000  	ds.b	6
1263  003c               L524_aunTemp:
1264  003c 2b3932333331  	dc.b	"+923316821907",0
1323                     ; 519 void vMevris_Send_SIM_Number()
1323                     ; 520 {
1324                     	switch	.text
1325  02ba               _vMevris_Send_SIM_Number:
1327  02ba 522d          	subw	sp,#45
1328       0000002d      OFST:	set	45
1331                     ; 521     uint8_t localBuffer[30] = "{\"SIM\":\"+923316821907\"}";
1333  02bc 96            	ldw	x,sp
1334  02bd 1c0010        	addw	x,#OFST-29
1335  02c0 90ae001e      	ldw	y,#L324_localBuffer
1336  02c4 a61e          	ld	a,#30
1337  02c6 cd0000        	call	c_xymvx
1339                     ; 522     uint8_t unSendDataLength = 0;
1341                     ; 523     uint8_t aunTemp[14] = "+923316821907";
1343  02c9 96            	ldw	x,sp
1344  02ca 1c0002        	addw	x,#OFST-43
1345  02cd 90ae003c      	ldw	y,#L524_aunTemp
1346  02d1 a60e          	ld	a,#14
1347  02d3 cd0000        	call	c_xymvx
1349                     ; 524     vClearBuffer(localBuffer, 30);
1351  02d6 4b1e          	push	#30
1352  02d8 96            	ldw	x,sp
1353  02d9 1c0011        	addw	x,#OFST-28
1354  02dc cd0000        	call	_vClearBuffer
1356  02df 84            	pop	a
1357                     ; 525     strcpy(localBuffer, "{\"SIM\":\"");
1359  02e0 96            	ldw	x,sp
1360  02e1 1c0010        	addw	x,#OFST-29
1361  02e4 90ae02a8      	ldw	y,#L554
1362  02e8               L46:
1363  02e8 90f6          	ld	a,(y)
1364  02ea 905c          	incw	y
1365  02ec f7            	ld	(x),a
1366  02ed 5c            	incw	x
1367  02ee 4d            	tnz	a
1368  02ef 26f7          	jrne	L46
1369                     ; 526     strcat(localBuffer, punGet_SIM_NUmber()); //Concatenate SIM number
1371  02f1 cd0000        	call	_punGet_SIM_NUmber
1373  02f4 89            	pushw	x
1374  02f5 96            	ldw	x,sp
1375  02f6 1c0012        	addw	x,#OFST-27
1376  02f9 cd0000        	call	_strcat
1378  02fc 85            	popw	x
1379                     ; 527     strcat(localBuffer, "\"}");
1381  02fd ae02b1        	ldw	x,#L124
1382  0300 89            	pushw	x
1383  0301 96            	ldw	x,sp
1384  0302 1c0012        	addw	x,#OFST-27
1385  0305 cd0000        	call	_strcat
1387  0308 85            	popw	x
1388                     ; 536     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1390  0309 96            	ldw	x,sp
1391  030a 1c0010        	addw	x,#OFST-29
1392  030d 89            	pushw	x
1393  030e ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1394  0311 cd0000        	call	_vMQTT_Publish
1396  0314 85            	popw	x
1397                     ; 538 }
1400  0315 5b2d          	addw	sp,#45
1401  0317 81            	ret
1404                     	switch	.const
1405  004a               L754_localBuffer:
1406  004a 7b22          	dc.b	"{",34
1407  004c 554943434944  	dc.b	"UICCID",34
1408  0053 3a22          	dc.b	":",34
1409  0055 313233343536  	dc.b	"123456789012345678"
1410  0067 3930313222    	dc.b	"9012",34
1411  006c 7d00          	dc.b	"}",0
1412  006e 000000000000  	ds.b	14
1461                     ; 540 void vMevris_Send_SIM_ICCID()
1461                     ; 541 {
1462                     	switch	.text
1463  0318               _vMevris_Send_SIM_ICCID:
1465  0318 5233          	subw	sp,#51
1466       00000033      OFST:	set	51
1469                     ; 542     uint8_t localBuffer[50] = "{\"UICCID\":\"1234567890123456789012\"}";
1471  031a 96            	ldw	x,sp
1472  031b 1c0002        	addw	x,#OFST-49
1473  031e 90ae004a      	ldw	y,#L754_localBuffer
1474  0322 a632          	ld	a,#50
1475  0324 cd0000        	call	c_xymvx
1477                     ; 543     uint8_t unSendDataLength = 0;
1479                     ; 544     vClearBuffer(localBuffer, 50);
1481  0327 4b32          	push	#50
1482  0329 96            	ldw	x,sp
1483  032a 1c0003        	addw	x,#OFST-48
1484  032d cd0000        	call	_vClearBuffer
1486  0330 84            	pop	a
1487                     ; 545     strcpy(localBuffer, "{\"UICCID\":\"");
1489  0331 96            	ldw	x,sp
1490  0332 1c0002        	addw	x,#OFST-49
1491  0335 90ae029c      	ldw	y,#L305
1492  0339               L07:
1493  0339 90f6          	ld	a,(y)
1494  033b 905c          	incw	y
1495  033d f7            	ld	(x),a
1496  033e 5c            	incw	x
1497  033f 4d            	tnz	a
1498  0340 26f7          	jrne	L07
1499                     ; 546     strcat(localBuffer, punGetSIM_ICCID());
1501  0342 cd0000        	call	_punGetSIM_ICCID
1503  0345 89            	pushw	x
1504  0346 96            	ldw	x,sp
1505  0347 1c0004        	addw	x,#OFST-47
1506  034a cd0000        	call	_strcat
1508  034d 85            	popw	x
1509                     ; 547     strcat(localBuffer, "\"}");
1511  034e ae02b1        	ldw	x,#L124
1512  0351 89            	pushw	x
1513  0352 96            	ldw	x,sp
1514  0353 1c0004        	addw	x,#OFST-47
1515  0356 cd0000        	call	_strcat
1517  0359 85            	popw	x
1518                     ; 556     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1520  035a 96            	ldw	x,sp
1521  035b 1c0002        	addw	x,#OFST-49
1522  035e 89            	pushw	x
1523  035f ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1524  0362 cd0000        	call	_vMQTT_Publish
1526  0365 85            	popw	x
1527                     ; 558 }
1530  0366 5b33          	addw	sp,#51
1531  0368 81            	ret
1534                     	switch	.const
1535  007c               L505_localBuffer:
1536  007c 7b22          	dc.b	"{",34
1537  007e 4c617422      	dc.b	"Lat",34
1538  0082 3a22          	dc.b	":",34
1539  0084 313233343536  	dc.b	"12345678901",34
1540  0090 2c22          	dc.b	",",34
1541  0092 4c6f6e6722    	dc.b	"Long",34
1542  0097 3a22          	dc.b	":",34
1543  0099 313233343536  	dc.b	"123456789012",34
1544  00a6 7d00          	dc.b	"}",0
1545  00a8 000000000000  	ds.b	6
1595                     ; 560 void vMevris_Send_Location()
1595                     ; 561 {
1596                     	switch	.text
1597  0369               _vMevris_Send_Location:
1599  0369 5233          	subw	sp,#51
1600       00000033      OFST:	set	51
1603                     ; 562     uint8_t localBuffer[50] = "{\"Lat\":\"12345678901\",\"Long\":\"123456789012\"}";
1605  036b 96            	ldw	x,sp
1606  036c 1c0002        	addw	x,#OFST-49
1607  036f 90ae007c      	ldw	y,#L505_localBuffer
1608  0373 a632          	ld	a,#50
1609  0375 cd0000        	call	c_xymvx
1611                     ; 563     uint8_t unSendDataLength = 0;
1613                     ; 564     vClearBuffer(localBuffer, 50);
1615  0378 4b32          	push	#50
1616  037a 96            	ldw	x,sp
1617  037b 1c0003        	addw	x,#OFST-48
1618  037e cd0000        	call	_vClearBuffer
1620  0381 84            	pop	a
1621                     ; 565     strcpy(localBuffer, "{\"Lat\":\"");
1623  0382 96            	ldw	x,sp
1624  0383 1c0002        	addw	x,#OFST-49
1625  0386 90ae0293      	ldw	y,#L135
1626  038a               L47:
1627  038a 90f6          	ld	a,(y)
1628  038c 905c          	incw	y
1629  038e f7            	ld	(x),a
1630  038f 5c            	incw	x
1631  0390 4d            	tnz	a
1632  0391 26f7          	jrne	L47
1633                     ; 566     strcat(localBuffer, getGPS_Latitude());
1635  0393 cd0000        	call	_getGPS_Latitude
1637  0396 89            	pushw	x
1638  0397 96            	ldw	x,sp
1639  0398 1c0004        	addw	x,#OFST-47
1640  039b cd0000        	call	_strcat
1642  039e 85            	popw	x
1643                     ; 567     strcat(localBuffer, "\",\"Long\":\"");
1645  039f ae0288        	ldw	x,#L335
1646  03a2 89            	pushw	x
1647  03a3 96            	ldw	x,sp
1648  03a4 1c0004        	addw	x,#OFST-47
1649  03a7 cd0000        	call	_strcat
1651  03aa 85            	popw	x
1652                     ; 568     strcat(localBuffer, getGPS_Longitude());
1654  03ab cd0000        	call	_getGPS_Longitude
1656  03ae 89            	pushw	x
1657  03af 96            	ldw	x,sp
1658  03b0 1c0004        	addw	x,#OFST-47
1659  03b3 cd0000        	call	_strcat
1661  03b6 85            	popw	x
1662                     ; 569     strcat(localBuffer, "\"}");
1664  03b7 ae02b1        	ldw	x,#L124
1665  03ba 89            	pushw	x
1666  03bb 96            	ldw	x,sp
1667  03bc 1c0004        	addw	x,#OFST-47
1668  03bf cd0000        	call	_strcat
1670  03c2 85            	popw	x
1671                     ; 578     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1673  03c3 96            	ldw	x,sp
1674  03c4 1c0002        	addw	x,#OFST-49
1675  03c7 89            	pushw	x
1676  03c8 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1677  03cb cd0000        	call	_vMQTT_Publish
1679  03ce 85            	popw	x
1680                     ; 580 }
1683  03cf 5b33          	addw	sp,#51
1684  03d1 81            	ret
1687                     	switch	.const
1688  00ae               L535_localBuffer:
1689  00ae 7b22          	dc.b	"{",34
1690  00b0 667722        	dc.b	"fw",34
1691  00b3 3a22          	dc.b	":",34
1692  00b5 322e342e3031  	dc.b	"2.4.010",34
1693  00bd 2c22          	dc.b	",",34
1694  00bf 687722        	dc.b	"hw",34
1695  00c2 3a22          	dc.b	":",34
1696  00c4 302e302e3030  	dc.b	"0.0.001",34
1697  00cc 7d00          	dc.b	"}",0
1698  00ce 000000        	ds.b	3
1746                     ; 583 void vMevris_Send_Version()
1746                     ; 584 {
1747                     	switch	.text
1748  03d2               _vMevris_Send_Version:
1750  03d2 5224          	subw	sp,#36
1751       00000024      OFST:	set	36
1754                     ; 585     uint8_t localBuffer[35] = "{\"fw\":\"2.4.010\",\"hw\":\"0.0.001\"}";
1756  03d4 96            	ldw	x,sp
1757  03d5 1c0002        	addw	x,#OFST-34
1758  03d8 90ae00ae      	ldw	y,#L535_localBuffer
1759  03dc a623          	ld	a,#35
1760  03de cd0000        	call	c_xymvx
1762                     ; 586     uint8_t unSendDataLength = 0;
1764                     ; 587     vClearBuffer(localBuffer, 35);
1766  03e1 4b23          	push	#35
1767  03e3 96            	ldw	x,sp
1768  03e4 1c0003        	addw	x,#OFST-33
1769  03e7 cd0000        	call	_vClearBuffer
1771  03ea 84            	pop	a
1772                     ; 588     strcpy(localBuffer, "{\"fw\":\"");
1774  03eb 96            	ldw	x,sp
1775  03ec 1c0002        	addw	x,#OFST-34
1776  03ef 90ae0280      	ldw	y,#L165
1777  03f3               L001:
1778  03f3 90f6          	ld	a,(y)
1779  03f5 905c          	incw	y
1780  03f7 f7            	ld	(x),a
1781  03f8 5c            	incw	x
1782  03f9 4d            	tnz	a
1783  03fa 26f7          	jrne	L001
1784                     ; 589     strcat(localBuffer, /*"2.4.010"*/ Firmware_Version);
1786  03fc ae0278        	ldw	x,#L365
1787  03ff 89            	pushw	x
1788  0400 96            	ldw	x,sp
1789  0401 1c0004        	addw	x,#OFST-32
1790  0404 cd0000        	call	_strcat
1792  0407 85            	popw	x
1793                     ; 590     strcat(localBuffer, "\",\"hw\":\"");
1795  0408 ae026f        	ldw	x,#L565
1796  040b 89            	pushw	x
1797  040c 96            	ldw	x,sp
1798  040d 1c0004        	addw	x,#OFST-32
1799  0410 cd0000        	call	_strcat
1801  0413 85            	popw	x
1802                     ; 591     strcat(localBuffer, /*"0.0.001"*/ Hardware_Version);
1804  0414 ae0267        	ldw	x,#L765
1805  0417 89            	pushw	x
1806  0418 96            	ldw	x,sp
1807  0419 1c0004        	addw	x,#OFST-32
1808  041c cd0000        	call	_strcat
1810  041f 85            	popw	x
1811                     ; 592     strcat(localBuffer, "\"}");
1813  0420 ae02b1        	ldw	x,#L124
1814  0423 89            	pushw	x
1815  0424 96            	ldw	x,sp
1816  0425 1c0004        	addw	x,#OFST-32
1817  0428 cd0000        	call	_strcat
1819  042b 85            	popw	x
1820                     ; 601     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
1822  042c 96            	ldw	x,sp
1823  042d 1c0002        	addw	x,#OFST-34
1824  0430 89            	pushw	x
1825  0431 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
1826  0434 cd0000        	call	_vMQTT_Publish
1828  0437 85            	popw	x
1829                     ; 603 }
1832  0438 5b24          	addw	sp,#36
1833  043a 81            	ret
1836                     	switch	.const
1837  00d1               L175_localBuffer:
1838  00d1 7b22          	dc.b	"{",34
1839  00d3 706f77657231  	dc.b	"power1",34
1840  00da 3a22          	dc.b	":",34
1841  00dc 313233343536  	dc.b	"123456890.23",34
1842  00e9 2c22          	dc.b	",",34
1843  00eb 766f6c746167  	dc.b	"voltage1",34
1844  00f4 3a22          	dc.b	":",34
1845  00f6 3132332e3536  	dc.b	"123.56",34
1846  00fd 2c22          	dc.b	",",34
1847  00ff 63757272656e  	dc.b	"current1",34
1848  0108 3a22          	dc.b	":",34
1849  010a 31323334352e  	dc.b	"12345.78",34
1850  0113 7d00          	dc.b	"}",0
1851  0115 000000000000  	ds.b	7
1852  011c               L375_temp1:
1853  011c 00            	dc.b	0
1854  011d 000000000000  	ds.b	11
1855  0128               L575_phase_num:
1856  0128 00            	dc.b	0
1857  0129 0000          	ds.b	2
1961                     	switch	.const
1962  012b               L601:
1963  012b 00000064      	dc.l	100
1964                     ; 605 void vMevris_Send_Phase(uint8_t phase_number, uint32_t Watt, uint32_t Voltage, uint32_t Ampere)
1964                     ; 606 {
1965                     	switch	.text
1966  043b               _vMevris_Send_Phase:
1968  043b 88            	push	a
1969  043c 525b          	subw	sp,#91
1970       0000005b      OFST:	set	91
1973                     ; 607     uint8_t localBuffer[75] = "{\"power1\":\"123456890.23\",\"voltage1\":\"123.56\",\"current1\":\"12345.78\"}";
1975  043e 96            	ldw	x,sp
1976  043f 1c0011        	addw	x,#OFST-74
1977  0442 90ae00d1      	ldw	y,#L175_localBuffer
1978  0446 a64b          	ld	a,#75
1979  0448 cd0000        	call	c_xymvx
1981                     ; 608     uint8_t unSendDataLength = 0;
1983                     ; 609     uint8_t temp1[12] = "";
1985  044b 96            	ldw	x,sp
1986  044c 1c0005        	addw	x,#OFST-86
1987  044f 90ae011c      	ldw	y,#L375_temp1
1988  0453 a60c          	ld	a,#12
1989  0455 cd0000        	call	c_xymvx
1991                     ; 610     uint8_t phase_num[3] = "";
1993  0458 96            	ldw	x,sp
1994  0459 1c0002        	addw	x,#OFST-89
1995  045c 90ae0128      	ldw	y,#L575_phase_num
1996  0460 a603          	ld	a,#3
1997  0462 cd0000        	call	c_xymvx
1999                     ; 611     vClearBuffer(localBuffer, 55);
2001  0465 4b37          	push	#55
2002  0467 96            	ldw	x,sp
2003  0468 1c0012        	addw	x,#OFST-73
2004  046b cd0000        	call	_vClearBuffer
2006  046e 84            	pop	a
2007                     ; 612     sprintf(phase_num, "%d", (uint16_t)phase_number);
2009  046f 7b5c          	ld	a,(OFST+1,sp)
2010  0471 5f            	clrw	x
2011  0472 97            	ld	xl,a
2012  0473 89            	pushw	x
2013  0474 ae0264        	ldw	x,#L156
2014  0477 89            	pushw	x
2015  0478 96            	ldw	x,sp
2016  0479 1c0006        	addw	x,#OFST-85
2017  047c cd0000        	call	_sprintf
2019  047f 5b04          	addw	sp,#4
2020                     ; 613     strcpy(localBuffer, "{\"power");
2022  0481 96            	ldw	x,sp
2023  0482 1c0011        	addw	x,#OFST-74
2024  0485 90ae025c      	ldw	y,#L356
2025  0489               L401:
2026  0489 90f6          	ld	a,(y)
2027  048b 905c          	incw	y
2028  048d f7            	ld	(x),a
2029  048e 5c            	incw	x
2030  048f 4d            	tnz	a
2031  0490 26f7          	jrne	L401
2032                     ; 614     strcat(localBuffer, phase_num);
2034  0492 96            	ldw	x,sp
2035  0493 1c0002        	addw	x,#OFST-89
2036  0496 89            	pushw	x
2037  0497 96            	ldw	x,sp
2038  0498 1c0013        	addw	x,#OFST-72
2039  049b cd0000        	call	_strcat
2041  049e 85            	popw	x
2042                     ; 615     strcat(localBuffer, "\":\"");
2044  049f ae0258        	ldw	x,#L556
2045  04a2 89            	pushw	x
2046  04a3 96            	ldw	x,sp
2047  04a4 1c0013        	addw	x,#OFST-72
2048  04a7 cd0000        	call	_strcat
2050  04aa 85            	popw	x
2051                     ; 616     sprintf(temp1, "%ld", Watt / 100);
2053  04ab 96            	ldw	x,sp
2054  04ac 1c005f        	addw	x,#OFST+4
2055  04af cd0000        	call	c_ltor
2057  04b2 ae012b        	ldw	x,#L601
2058  04b5 cd0000        	call	c_ludv
2060  04b8 be02          	ldw	x,c_lreg+2
2061  04ba 89            	pushw	x
2062  04bb be00          	ldw	x,c_lreg
2063  04bd 89            	pushw	x
2064  04be ae0254        	ldw	x,#L756
2065  04c1 89            	pushw	x
2066  04c2 96            	ldw	x,sp
2067  04c3 1c000b        	addw	x,#OFST-80
2068  04c6 cd0000        	call	_sprintf
2070  04c9 5b06          	addw	sp,#6
2071                     ; 617     strcat(localBuffer, temp1);
2073  04cb 96            	ldw	x,sp
2074  04cc 1c0005        	addw	x,#OFST-86
2075  04cf 89            	pushw	x
2076  04d0 96            	ldw	x,sp
2077  04d1 1c0013        	addw	x,#OFST-72
2078  04d4 cd0000        	call	_strcat
2080  04d7 85            	popw	x
2081                     ; 618     strcat(localBuffer, ".");
2083  04d8 ae0252        	ldw	x,#L166
2084  04db 89            	pushw	x
2085  04dc 96            	ldw	x,sp
2086  04dd 1c0013        	addw	x,#OFST-72
2087  04e0 cd0000        	call	_strcat
2089  04e3 85            	popw	x
2090                     ; 619     sprintf(temp1, "%ld", Watt % 100);
2092  04e4 96            	ldw	x,sp
2093  04e5 1c005f        	addw	x,#OFST+4
2094  04e8 cd0000        	call	c_ltor
2096  04eb ae012b        	ldw	x,#L601
2097  04ee cd0000        	call	c_lumd
2099  04f1 be02          	ldw	x,c_lreg+2
2100  04f3 89            	pushw	x
2101  04f4 be00          	ldw	x,c_lreg
2102  04f6 89            	pushw	x
2103  04f7 ae0254        	ldw	x,#L756
2104  04fa 89            	pushw	x
2105  04fb 96            	ldw	x,sp
2106  04fc 1c000b        	addw	x,#OFST-80
2107  04ff cd0000        	call	_sprintf
2109  0502 5b06          	addw	sp,#6
2110                     ; 620     strcat(localBuffer, temp1);
2112  0504 96            	ldw	x,sp
2113  0505 1c0005        	addw	x,#OFST-86
2114  0508 89            	pushw	x
2115  0509 96            	ldw	x,sp
2116  050a 1c0013        	addw	x,#OFST-72
2117  050d cd0000        	call	_strcat
2119  0510 85            	popw	x
2120                     ; 622     strcat(localBuffer, "\",\"voltage");
2122  0511 ae0247        	ldw	x,#L366
2123  0514 89            	pushw	x
2124  0515 96            	ldw	x,sp
2125  0516 1c0013        	addw	x,#OFST-72
2126  0519 cd0000        	call	_strcat
2128  051c 85            	popw	x
2129                     ; 623     strcat(localBuffer, phase_num);
2131  051d 96            	ldw	x,sp
2132  051e 1c0002        	addw	x,#OFST-89
2133  0521 89            	pushw	x
2134  0522 96            	ldw	x,sp
2135  0523 1c0013        	addw	x,#OFST-72
2136  0526 cd0000        	call	_strcat
2138  0529 85            	popw	x
2139                     ; 624     strcat(localBuffer, "\":\"");
2141  052a ae0258        	ldw	x,#L556
2142  052d 89            	pushw	x
2143  052e 96            	ldw	x,sp
2144  052f 1c0013        	addw	x,#OFST-72
2145  0532 cd0000        	call	_strcat
2147  0535 85            	popw	x
2148                     ; 625     sprintf(temp1, "%ld", Voltage / 100);
2150  0536 96            	ldw	x,sp
2151  0537 1c0063        	addw	x,#OFST+8
2152  053a cd0000        	call	c_ltor
2154  053d ae012b        	ldw	x,#L601
2155  0540 cd0000        	call	c_ludv
2157  0543 be02          	ldw	x,c_lreg+2
2158  0545 89            	pushw	x
2159  0546 be00          	ldw	x,c_lreg
2160  0548 89            	pushw	x
2161  0549 ae0254        	ldw	x,#L756
2162  054c 89            	pushw	x
2163  054d 96            	ldw	x,sp
2164  054e 1c000b        	addw	x,#OFST-80
2165  0551 cd0000        	call	_sprintf
2167  0554 5b06          	addw	sp,#6
2168                     ; 626     strcat(localBuffer, temp1);
2170  0556 96            	ldw	x,sp
2171  0557 1c0005        	addw	x,#OFST-86
2172  055a 89            	pushw	x
2173  055b 96            	ldw	x,sp
2174  055c 1c0013        	addw	x,#OFST-72
2175  055f cd0000        	call	_strcat
2177  0562 85            	popw	x
2178                     ; 627     strcat(localBuffer, ".");
2180  0563 ae0252        	ldw	x,#L166
2181  0566 89            	pushw	x
2182  0567 96            	ldw	x,sp
2183  0568 1c0013        	addw	x,#OFST-72
2184  056b cd0000        	call	_strcat
2186  056e 85            	popw	x
2187                     ; 628     sprintf(temp1, "%ld", Voltage % 100);
2189  056f 96            	ldw	x,sp
2190  0570 1c0063        	addw	x,#OFST+8
2191  0573 cd0000        	call	c_ltor
2193  0576 ae012b        	ldw	x,#L601
2194  0579 cd0000        	call	c_lumd
2196  057c be02          	ldw	x,c_lreg+2
2197  057e 89            	pushw	x
2198  057f be00          	ldw	x,c_lreg
2199  0581 89            	pushw	x
2200  0582 ae0254        	ldw	x,#L756
2201  0585 89            	pushw	x
2202  0586 96            	ldw	x,sp
2203  0587 1c000b        	addw	x,#OFST-80
2204  058a cd0000        	call	_sprintf
2206  058d 5b06          	addw	sp,#6
2207                     ; 629     strcat(localBuffer, temp1);
2209  058f 96            	ldw	x,sp
2210  0590 1c0005        	addw	x,#OFST-86
2211  0593 89            	pushw	x
2212  0594 96            	ldw	x,sp
2213  0595 1c0013        	addw	x,#OFST-72
2214  0598 cd0000        	call	_strcat
2216  059b 85            	popw	x
2217                     ; 631     strcat(localBuffer, "\",\"current");
2219  059c ae023c        	ldw	x,#L566
2220  059f 89            	pushw	x
2221  05a0 96            	ldw	x,sp
2222  05a1 1c0013        	addw	x,#OFST-72
2223  05a4 cd0000        	call	_strcat
2225  05a7 85            	popw	x
2226                     ; 632     strcat(localBuffer, phase_num);
2228  05a8 96            	ldw	x,sp
2229  05a9 1c0002        	addw	x,#OFST-89
2230  05ac 89            	pushw	x
2231  05ad 96            	ldw	x,sp
2232  05ae 1c0013        	addw	x,#OFST-72
2233  05b1 cd0000        	call	_strcat
2235  05b4 85            	popw	x
2236                     ; 633     strcat(localBuffer, "\":\"");
2238  05b5 ae0258        	ldw	x,#L556
2239  05b8 89            	pushw	x
2240  05b9 96            	ldw	x,sp
2241  05ba 1c0013        	addw	x,#OFST-72
2242  05bd cd0000        	call	_strcat
2244  05c0 85            	popw	x
2245                     ; 634     sprintf(temp1, "%ld", Ampere / 100);
2247  05c1 96            	ldw	x,sp
2248  05c2 1c0067        	addw	x,#OFST+12
2249  05c5 cd0000        	call	c_ltor
2251  05c8 ae012b        	ldw	x,#L601
2252  05cb cd0000        	call	c_ludv
2254  05ce be02          	ldw	x,c_lreg+2
2255  05d0 89            	pushw	x
2256  05d1 be00          	ldw	x,c_lreg
2257  05d3 89            	pushw	x
2258  05d4 ae0254        	ldw	x,#L756
2259  05d7 89            	pushw	x
2260  05d8 96            	ldw	x,sp
2261  05d9 1c000b        	addw	x,#OFST-80
2262  05dc cd0000        	call	_sprintf
2264  05df 5b06          	addw	sp,#6
2265                     ; 635     strcat(localBuffer, temp1);
2267  05e1 96            	ldw	x,sp
2268  05e2 1c0005        	addw	x,#OFST-86
2269  05e5 89            	pushw	x
2270  05e6 96            	ldw	x,sp
2271  05e7 1c0013        	addw	x,#OFST-72
2272  05ea cd0000        	call	_strcat
2274  05ed 85            	popw	x
2275                     ; 636     strcat(localBuffer, ".");
2277  05ee ae0252        	ldw	x,#L166
2278  05f1 89            	pushw	x
2279  05f2 96            	ldw	x,sp
2280  05f3 1c0013        	addw	x,#OFST-72
2281  05f6 cd0000        	call	_strcat
2283  05f9 85            	popw	x
2284                     ; 637     sprintf(temp1, "%ld", Ampere % 100);
2286  05fa 96            	ldw	x,sp
2287  05fb 1c0067        	addw	x,#OFST+12
2288  05fe cd0000        	call	c_ltor
2290  0601 ae012b        	ldw	x,#L601
2291  0604 cd0000        	call	c_lumd
2293  0607 be02          	ldw	x,c_lreg+2
2294  0609 89            	pushw	x
2295  060a be00          	ldw	x,c_lreg
2296  060c 89            	pushw	x
2297  060d ae0254        	ldw	x,#L756
2298  0610 89            	pushw	x
2299  0611 96            	ldw	x,sp
2300  0612 1c000b        	addw	x,#OFST-80
2301  0615 cd0000        	call	_sprintf
2303  0618 5b06          	addw	sp,#6
2304                     ; 638     strcat(localBuffer, temp1);
2306  061a 96            	ldw	x,sp
2307  061b 1c0005        	addw	x,#OFST-86
2308  061e 89            	pushw	x
2309  061f 96            	ldw	x,sp
2310  0620 1c0013        	addw	x,#OFST-72
2311  0623 cd0000        	call	_strcat
2313  0626 85            	popw	x
2314                     ; 639     strcat(localBuffer, "\"}");
2316  0627 ae02b1        	ldw	x,#L124
2317  062a 89            	pushw	x
2318  062b 96            	ldw	x,sp
2319  062c 1c0013        	addw	x,#OFST-72
2320  062f cd0000        	call	_strcat
2322  0632 85            	popw	x
2323                     ; 649     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
2325  0633 96            	ldw	x,sp
2326  0634 1c0011        	addw	x,#OFST-74
2327  0637 89            	pushw	x
2328  0638 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2329  063b cd0000        	call	_vMQTT_Publish
2331  063e 85            	popw	x
2332                     ; 651 }
2335  063f 5b5c          	addw	sp,#92
2336  0641 81            	ret
2339                     	switch	.const
2340  012f               L766_localBuffer:
2341  012f 7b22          	dc.b	"{",34
2342  0131 626174746572  	dc.b	"battery",34
2343  0139 3a22          	dc.b	":",34
2344  013b 313233343536  	dc.b	"123456.89",34
2345  0145 7d00          	dc.b	"}",0
2346  0147 000000000000  	ds.b	6
2347  014d               L176_temp1:
2348  014d 00            	dc.b	0
2349  014e 000000000000  	ds.b	9
2409                     ; 761 void vMevris_Send_BatteryVolt()
2409                     ; 762 {
2410                     	switch	.text
2411  0642               _vMevris_Send_BatteryVolt:
2413  0642 5229          	subw	sp,#41
2414       00000029      OFST:	set	41
2417                     ; 763     uint8_t localBuffer[30] = "{\"battery\":\"123456.89\"}";
2419  0644 96            	ldw	x,sp
2420  0645 1c000c        	addw	x,#OFST-29
2421  0648 90ae012f      	ldw	y,#L766_localBuffer
2422  064c a61e          	ld	a,#30
2423  064e cd0000        	call	c_xymvx
2425                     ; 764     uint8_t unSendDataLength = 0;
2427                     ; 765     uint8_t temp1[10] = "";
2429  0651 96            	ldw	x,sp
2430  0652 1c0002        	addw	x,#OFST-39
2431  0655 90ae014d      	ldw	y,#L176_temp1
2432  0659 a60a          	ld	a,#10
2433  065b cd0000        	call	c_xymvx
2435                     ; 766     vClearBuffer(localBuffer, 30);
2437  065e 4b1e          	push	#30
2438  0660 96            	ldw	x,sp
2439  0661 1c000d        	addw	x,#OFST-28
2440  0664 cd0000        	call	_vClearBuffer
2442  0667 84            	pop	a
2443                     ; 767     strcpy(localBuffer, "{\"battery\":\"");
2445  0668 96            	ldw	x,sp
2446  0669 1c000c        	addw	x,#OFST-29
2447  066c 90ae022f      	ldw	y,#L127
2448  0670               L211:
2449  0670 90f6          	ld	a,(y)
2450  0672 905c          	incw	y
2451  0674 f7            	ld	(x),a
2452  0675 5c            	incw	x
2453  0676 4d            	tnz	a
2454  0677 26f7          	jrne	L211
2455                     ; 769     sprintf(temp1, "%ld", batVolt / 100);
2457  0679 ae0000        	ldw	x,#_batVolt
2458  067c cd0000        	call	c_ltor
2460  067f ae012b        	ldw	x,#L601
2461  0682 cd0000        	call	c_ludv
2463  0685 be02          	ldw	x,c_lreg+2
2464  0687 89            	pushw	x
2465  0688 be00          	ldw	x,c_lreg
2466  068a 89            	pushw	x
2467  068b ae0254        	ldw	x,#L756
2468  068e 89            	pushw	x
2469  068f 96            	ldw	x,sp
2470  0690 1c0008        	addw	x,#OFST-33
2471  0693 cd0000        	call	_sprintf
2473  0696 5b06          	addw	sp,#6
2474                     ; 770     strcat(localBuffer, temp1);
2476  0698 96            	ldw	x,sp
2477  0699 1c0002        	addw	x,#OFST-39
2478  069c 89            	pushw	x
2479  069d 96            	ldw	x,sp
2480  069e 1c000e        	addw	x,#OFST-27
2481  06a1 cd0000        	call	_strcat
2483  06a4 85            	popw	x
2484                     ; 771     strcat(localBuffer, ".");
2486  06a5 ae0252        	ldw	x,#L166
2487  06a8 89            	pushw	x
2488  06a9 96            	ldw	x,sp
2489  06aa 1c000e        	addw	x,#OFST-27
2490  06ad cd0000        	call	_strcat
2492  06b0 85            	popw	x
2493                     ; 772     sprintf(temp1, "%ld", batVolt % 100);
2495  06b1 ae0000        	ldw	x,#_batVolt
2496  06b4 cd0000        	call	c_ltor
2498  06b7 ae012b        	ldw	x,#L601
2499  06ba cd0000        	call	c_lumd
2501  06bd be02          	ldw	x,c_lreg+2
2502  06bf 89            	pushw	x
2503  06c0 be00          	ldw	x,c_lreg
2504  06c2 89            	pushw	x
2505  06c3 ae0254        	ldw	x,#L756
2506  06c6 89            	pushw	x
2507  06c7 96            	ldw	x,sp
2508  06c8 1c0008        	addw	x,#OFST-33
2509  06cb cd0000        	call	_sprintf
2511  06ce 5b06          	addw	sp,#6
2512                     ; 773     strcat(localBuffer, temp1);
2514  06d0 96            	ldw	x,sp
2515  06d1 1c0002        	addw	x,#OFST-39
2516  06d4 89            	pushw	x
2517  06d5 96            	ldw	x,sp
2518  06d6 1c000e        	addw	x,#OFST-27
2519  06d9 cd0000        	call	_strcat
2521  06dc 85            	popw	x
2522                     ; 774     strcat(localBuffer, "\"}");
2524  06dd ae02b1        	ldw	x,#L124
2525  06e0 89            	pushw	x
2526  06e1 96            	ldw	x,sp
2527  06e2 1c000e        	addw	x,#OFST-27
2528  06e5 cd0000        	call	_strcat
2530  06e8 85            	popw	x
2531                     ; 783     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
2533  06e9 96            	ldw	x,sp
2534  06ea 1c000c        	addw	x,#OFST-29
2535  06ed 89            	pushw	x
2536  06ee ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2537  06f1 cd0000        	call	_vMQTT_Publish
2539  06f4 85            	popw	x
2540                     ; 785 }
2543  06f5 5b29          	addw	sp,#41
2544  06f7 81            	ret
2547                     	switch	.const
2548  0157               L327_localBuffer:
2549  0157 7b22          	dc.b	"{",34
2550  0159 526164696174  	dc.b	"RadiatorTemperatur"
2551  016b 6522          	dc.b	"e",34
2552  016d 3a22          	dc.b	":",34
2553  016f 313233343536  	dc.b	"123456.89",34
2554  0179 7d00          	dc.b	"}",0
2555  017b 00000000      	ds.b	4
2556  017f               L527_temp1:
2557  017f 00            	dc.b	0
2558  0180 000000000000  	ds.b	14
2628                     	switch	.const
2629  018e               L021:
2630  018e 000186a1      	dc.l	100001
2631                     ; 787 void vMevris_Send_RadiatorTemp()
2631                     ; 788 {
2632                     	switch	.text
2633  06f8               _vMevris_Send_RadiatorTemp:
2635  06f8 523c          	subw	sp,#60
2636       0000003c      OFST:	set	60
2639                     ; 789     uint8_t localBuffer[40] = "{\"RadiatorTemperature\":\"123456.89\"}";
2641  06fa 96            	ldw	x,sp
2642  06fb 1c0015        	addw	x,#OFST-39
2643  06fe 90ae0157      	ldw	y,#L327_localBuffer
2644  0702 a628          	ld	a,#40
2645  0704 cd0000        	call	c_xymvx
2647                     ; 790     uint8_t unSendDataLength = 0;
2649                     ; 791     uint8_t temp1[15] = "";
2651  0707 96            	ldw	x,sp
2652  0708 1c0002        	addw	x,#OFST-58
2653  070b 90ae017f      	ldw	y,#L527_temp1
2654  070f a60f          	ld	a,#15
2655  0711 cd0000        	call	c_xymvx
2657                     ; 792     uint32_t myVar = 0;
2659                     ; 793     vClearBuffer(localBuffer, 40);
2661  0714 4b28          	push	#40
2662  0716 96            	ldw	x,sp
2663  0717 1c0016        	addw	x,#OFST-38
2664  071a cd0000        	call	_vClearBuffer
2666  071d 84            	pop	a
2667                     ; 794     strcpy(localBuffer, "{\"RadiatorTemperature\":\"");
2669  071e 96            	ldw	x,sp
2670  071f 1c0015        	addw	x,#OFST-39
2671  0722 90ae0216      	ldw	y,#L167
2672  0726               L611:
2673  0726 90f6          	ld	a,(y)
2674  0728 905c          	incw	y
2675  072a f7            	ld	(x),a
2676  072b 5c            	incw	x
2677  072c 4d            	tnz	a
2678  072d 26f7          	jrne	L611
2679                     ; 795     myVar = (uint32_t)(Temperature1 * 100);
2681  072f ae0000        	ldw	x,#_Temperature1
2682  0732 cd0000        	call	c_ltor
2684  0735 ae0212        	ldw	x,#L767
2685  0738 cd0000        	call	c_fmul
2687  073b cd0000        	call	c_ftol
2689  073e 96            	ldw	x,sp
2690  073f 1c0011        	addw	x,#OFST-43
2691  0742 cd0000        	call	c_rtol
2694                     ; 796     if (myVar > 100000)
2696  0745 96            	ldw	x,sp
2697  0746 1c0011        	addw	x,#OFST-43
2698  0749 cd0000        	call	c_ltor
2700  074c ae018e        	ldw	x,#L021
2701  074f cd0000        	call	c_lcmp
2703  0752 250a          	jrult	L377
2704                     ; 797         myVar = 0;
2706  0754 ae0000        	ldw	x,#0
2707  0757 1f13          	ldw	(OFST-41,sp),x
2708  0759 ae0000        	ldw	x,#0
2709  075c 1f11          	ldw	(OFST-43,sp),x
2711  075e               L377:
2712                     ; 798     sprintf(temp1, "%ld", myVar / 100);
2714  075e 96            	ldw	x,sp
2715  075f 1c0011        	addw	x,#OFST-43
2716  0762 cd0000        	call	c_ltor
2718  0765 ae012b        	ldw	x,#L601
2719  0768 cd0000        	call	c_ludv
2721  076b be02          	ldw	x,c_lreg+2
2722  076d 89            	pushw	x
2723  076e be00          	ldw	x,c_lreg
2724  0770 89            	pushw	x
2725  0771 ae0254        	ldw	x,#L756
2726  0774 89            	pushw	x
2727  0775 96            	ldw	x,sp
2728  0776 1c0008        	addw	x,#OFST-52
2729  0779 cd0000        	call	_sprintf
2731  077c 5b06          	addw	sp,#6
2732                     ; 799     strcat(localBuffer, temp1);
2734  077e 96            	ldw	x,sp
2735  077f 1c0002        	addw	x,#OFST-58
2736  0782 89            	pushw	x
2737  0783 96            	ldw	x,sp
2738  0784 1c0017        	addw	x,#OFST-37
2739  0787 cd0000        	call	_strcat
2741  078a 85            	popw	x
2742                     ; 800     strcat(localBuffer, ".");
2744  078b ae0252        	ldw	x,#L166
2745  078e 89            	pushw	x
2746  078f 96            	ldw	x,sp
2747  0790 1c0017        	addw	x,#OFST-37
2748  0793 cd0000        	call	_strcat
2750  0796 85            	popw	x
2751                     ; 801     sprintf(temp1, "%ld", myVar % 100);
2753  0797 96            	ldw	x,sp
2754  0798 1c0011        	addw	x,#OFST-43
2755  079b cd0000        	call	c_ltor
2757  079e ae012b        	ldw	x,#L601
2758  07a1 cd0000        	call	c_lumd
2760  07a4 be02          	ldw	x,c_lreg+2
2761  07a6 89            	pushw	x
2762  07a7 be00          	ldw	x,c_lreg
2763  07a9 89            	pushw	x
2764  07aa ae0254        	ldw	x,#L756
2765  07ad 89            	pushw	x
2766  07ae 96            	ldw	x,sp
2767  07af 1c0008        	addw	x,#OFST-52
2768  07b2 cd0000        	call	_sprintf
2770  07b5 5b06          	addw	sp,#6
2771                     ; 802     strcat(localBuffer, temp1);
2773  07b7 96            	ldw	x,sp
2774  07b8 1c0002        	addw	x,#OFST-58
2775  07bb 89            	pushw	x
2776  07bc 96            	ldw	x,sp
2777  07bd 1c0017        	addw	x,#OFST-37
2778  07c0 cd0000        	call	_strcat
2780  07c3 85            	popw	x
2781                     ; 804     strcat(localBuffer, "\"}");
2783  07c4 ae02b1        	ldw	x,#L124
2784  07c7 89            	pushw	x
2785  07c8 96            	ldw	x,sp
2786  07c9 1c0017        	addw	x,#OFST-37
2787  07cc cd0000        	call	_strcat
2789  07cf 85            	popw	x
2790                     ; 805     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2792  07d0 4b64          	push	#100
2793  07d2 ae0000        	ldw	x,#_aunPushed_Data
2794  07d5 cd0000        	call	_vClearBuffer
2796  07d8 84            	pop	a
2797                     ; 814     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
2799  07d9 96            	ldw	x,sp
2800  07da 1c0015        	addw	x,#OFST-39
2801  07dd 89            	pushw	x
2802  07de ae0096        	ldw	x,#_aunMQTT_Publish_Topic
2803  07e1 cd0000        	call	_vMQTT_Publish
2805  07e4 85            	popw	x
2806                     ; 816 }
2809  07e5 5b3c          	addw	sp,#60
2810  07e7 81            	ret
2813                     	switch	.const
2814  0192               L577_localBuffer:
2815  0192 7b22          	dc.b	"{",34
2816  0194 456e67696e65  	dc.b	"EngineTemperature",34
2817  01a6 3a22          	dc.b	":",34
2818  01a8 313233343536  	dc.b	"123456.89",34
2819  01b2 7d00          	dc.b	"}",0
2820  01b4 000000000000  	ds.b	6
2821  01ba               L777_temp1:
2822  01ba 00            	dc.b	0
2823  01bb 000000000000  	ds.b	14
2892                     ; 818 void vMevris_Send_EngineTemp()
2892                     ; 819 {
2893                     	switch	.text
2894  07e8               _vMevris_Send_EngineTemp:
2896  07e8 523c          	subw	sp,#60
2897       0000003c      OFST:	set	60
2900                     ; 820     uint8_t localBuffer[40] = "{\"EngineTemperature\":\"123456.89\"}";
2902  07ea 96            	ldw	x,sp
2903  07eb 1c0015        	addw	x,#OFST-39
2904  07ee 90ae0192      	ldw	y,#L577_localBuffer
2905  07f2 a628          	ld	a,#40
2906  07f4 cd0000        	call	c_xymvx
2908                     ; 821     uint8_t unSendDataLength = 0;
2910                     ; 822     uint8_t temp1[15] = "";
2912  07f7 96            	ldw	x,sp
2913  07f8 1c0002        	addw	x,#OFST-58
2914  07fb 90ae01ba      	ldw	y,#L777_temp1
2915  07ff a60f          	ld	a,#15
2916  0801 cd0000        	call	c_xymvx
2918                     ; 823     uint32_t myVar = 0;
2920                     ; 824     vClearBuffer(localBuffer, 40);
2922  0804 4b28          	push	#40
2923  0806 96            	ldw	x,sp
2924  0807 1c0016        	addw	x,#OFST-38
2925  080a cd0000        	call	_vClearBuffer
2927  080d 84            	pop	a
2928                     ; 825     strcpy(localBuffer, "{\"EngineTemperature\":\"");
2930  080e 96            	ldw	x,sp
2931  080f 1c0015        	addw	x,#OFST-39
2932  0812 90ae01fb      	ldw	y,#L3301
2933  0816               L421:
2934  0816 90f6          	ld	a,(y)
2935  0818 905c          	incw	y
2936  081a f7            	ld	(x),a
2937  081b 5c            	incw	x
2938  081c 4d            	tnz	a
2939  081d 26f7          	jrne	L421
2940                     ; 826     myVar = (uint32_t)(Temperature2 * 100);
2942  081f ae0000        	ldw	x,#_Temperature2
2943  0822 cd0000        	call	c_ltor
2945  0825 ae0212        	ldw	x,#L767
2946  0828 cd0000        	call	c_fmul
2948  082b cd0000        	call	c_ftol
2950  082e 96            	ldw	x,sp
2951  082f 1c0011        	addw	x,#OFST-43
2952  0832 cd0000        	call	c_rtol
2955                     ; 827     if (myVar > 100000)
2957  0835 96            	ldw	x,sp
2958  0836 1c0011        	addw	x,#OFST-43
2959  0839 cd0000        	call	c_ltor
2961  083c ae018e        	ldw	x,#L021
2962  083f cd0000        	call	c_lcmp
2964  0842 250a          	jrult	L5301
2965                     ; 828         myVar = 0;
2967  0844 ae0000        	ldw	x,#0
2968  0847 1f13          	ldw	(OFST-41,sp),x
2969  0849 ae0000        	ldw	x,#0
2970  084c 1f11          	ldw	(OFST-43,sp),x
2972  084e               L5301:
2973                     ; 829     sprintf(temp1, "%ld", myVar / 100);
2975  084e 96            	ldw	x,sp
2976  084f 1c0011        	addw	x,#OFST-43
2977  0852 cd0000        	call	c_ltor
2979  0855 ae012b        	ldw	x,#L601
2980  0858 cd0000        	call	c_ludv
2982  085b be02          	ldw	x,c_lreg+2
2983  085d 89            	pushw	x
2984  085e be00          	ldw	x,c_lreg
2985  0860 89            	pushw	x
2986  0861 ae0254        	ldw	x,#L756
2987  0864 89            	pushw	x
2988  0865 96            	ldw	x,sp
2989  0866 1c0008        	addw	x,#OFST-52
2990  0869 cd0000        	call	_sprintf
2992  086c 5b06          	addw	sp,#6
2993                     ; 830     strcat(localBuffer, temp1);
2995  086e 96            	ldw	x,sp
2996  086f 1c0002        	addw	x,#OFST-58
2997  0872 89            	pushw	x
2998  0873 96            	ldw	x,sp
2999  0874 1c0017        	addw	x,#OFST-37
3000  0877 cd0000        	call	_strcat
3002  087a 85            	popw	x
3003                     ; 831     strcat(localBuffer, ".");
3005  087b ae0252        	ldw	x,#L166
3006  087e 89            	pushw	x
3007  087f 96            	ldw	x,sp
3008  0880 1c0017        	addw	x,#OFST-37
3009  0883 cd0000        	call	_strcat
3011  0886 85            	popw	x
3012                     ; 832     sprintf(temp1, "%ld", myVar % 100);
3014  0887 96            	ldw	x,sp
3015  0888 1c0011        	addw	x,#OFST-43
3016  088b cd0000        	call	c_ltor
3018  088e ae012b        	ldw	x,#L601
3019  0891 cd0000        	call	c_lumd
3021  0894 be02          	ldw	x,c_lreg+2
3022  0896 89            	pushw	x
3023  0897 be00          	ldw	x,c_lreg
3024  0899 89            	pushw	x
3025  089a ae0254        	ldw	x,#L756
3026  089d 89            	pushw	x
3027  089e 96            	ldw	x,sp
3028  089f 1c0008        	addw	x,#OFST-52
3029  08a2 cd0000        	call	_sprintf
3031  08a5 5b06          	addw	sp,#6
3032                     ; 833     strcat(localBuffer, temp1);
3034  08a7 96            	ldw	x,sp
3035  08a8 1c0002        	addw	x,#OFST-58
3036  08ab 89            	pushw	x
3037  08ac 96            	ldw	x,sp
3038  08ad 1c0017        	addw	x,#OFST-37
3039  08b0 cd0000        	call	_strcat
3041  08b3 85            	popw	x
3042                     ; 835     strcat(localBuffer, "\"}");
3044  08b4 ae02b1        	ldw	x,#L124
3045  08b7 89            	pushw	x
3046  08b8 96            	ldw	x,sp
3047  08b9 1c0017        	addw	x,#OFST-37
3048  08bc cd0000        	call	_strcat
3050  08bf 85            	popw	x
3051                     ; 844     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
3053  08c0 96            	ldw	x,sp
3054  08c1 1c0015        	addw	x,#OFST-39
3055  08c4 89            	pushw	x
3056  08c5 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
3057  08c8 cd0000        	call	_vMQTT_Publish
3059  08cb 85            	popw	x
3060                     ; 846 }
3063  08cc 5b3c          	addw	sp,#60
3064  08ce 81            	ret
3067                     	switch	.const
3068  01c9               L7301_localBuffer:
3069  01c9 7b22          	dc.b	"{",34
3070  01cb 6675656c22    	dc.b	"fuel",34
3071  01d0 3a22          	dc.b	":",34
3072  01d2 313233343536  	dc.b	"123456.89",34
3073  01dc 7d00          	dc.b	"}",0
3074  01de 000000000000  	ds.b	9
3075  01e7               L1401_temp1:
3076  01e7 00            	dc.b	0
3077  01e8 000000000000  	ds.b	9
3137                     ; 848 void vMevris_Send_FuelLevel()
3137                     ; 849 {
3138                     	switch	.text
3139  08cf               _vMevris_Send_FuelLevel:
3141  08cf 5229          	subw	sp,#41
3142       00000029      OFST:	set	41
3145                     ; 850     uint8_t localBuffer[30] = "{\"fuel\":\"123456.89\"}";
3147  08d1 96            	ldw	x,sp
3148  08d2 1c000c        	addw	x,#OFST-29
3149  08d5 90ae01c9      	ldw	y,#L7301_localBuffer
3150  08d9 a61e          	ld	a,#30
3151  08db cd0000        	call	c_xymvx
3153                     ; 851     uint8_t unSendDataLength = 0;
3155                     ; 852     uint8_t temp1[10] = "";
3157  08de 96            	ldw	x,sp
3158  08df 1c0002        	addw	x,#OFST-39
3159  08e2 90ae01e7      	ldw	y,#L1401_temp1
3160  08e6 a60a          	ld	a,#10
3161  08e8 cd0000        	call	c_xymvx
3163                     ; 853     vClearBuffer(localBuffer, 30);
3165  08eb 4b1e          	push	#30
3166  08ed 96            	ldw	x,sp
3167  08ee 1c000d        	addw	x,#OFST-28
3168  08f1 cd0000        	call	_vClearBuffer
3170  08f4 84            	pop	a
3171                     ; 854     strcpy(localBuffer, "{\"fuel\":\"");
3173  08f5 96            	ldw	x,sp
3174  08f6 1c000c        	addw	x,#OFST-29
3175  08f9 90ae01f1      	ldw	y,#L1701
3176  08fd               L031:
3177  08fd 90f6          	ld	a,(y)
3178  08ff 905c          	incw	y
3179  0901 f7            	ld	(x),a
3180  0902 5c            	incw	x
3181  0903 4d            	tnz	a
3182  0904 26f7          	jrne	L031
3183                     ; 855     sprintf(temp1, "%ld", Fuellevel);
3185  0906 ce0002        	ldw	x,_Fuellevel+2
3186  0909 89            	pushw	x
3187  090a ce0000        	ldw	x,_Fuellevel
3188  090d 89            	pushw	x
3189  090e ae0254        	ldw	x,#L756
3190  0911 89            	pushw	x
3191  0912 96            	ldw	x,sp
3192  0913 1c0008        	addw	x,#OFST-33
3193  0916 cd0000        	call	_sprintf
3195  0919 5b06          	addw	sp,#6
3196                     ; 856     strcat(localBuffer, temp1);
3198  091b 96            	ldw	x,sp
3199  091c 1c0002        	addw	x,#OFST-39
3200  091f 89            	pushw	x
3201  0920 96            	ldw	x,sp
3202  0921 1c000e        	addw	x,#OFST-27
3203  0924 cd0000        	call	_strcat
3205  0927 85            	popw	x
3206                     ; 857     strcat(localBuffer, "\"}");
3208  0928 ae02b1        	ldw	x,#L124
3209  092b 89            	pushw	x
3210  092c 96            	ldw	x,sp
3211  092d 1c000e        	addw	x,#OFST-27
3212  0930 cd0000        	call	_strcat
3214  0933 85            	popw	x
3215                     ; 866     vMQTT_Publish(aunMQTT_Publish_Topic, localBuffer);
3217  0934 96            	ldw	x,sp
3218  0935 1c000c        	addw	x,#OFST-29
3219  0938 89            	pushw	x
3220  0939 ae0096        	ldw	x,#_aunMQTT_Publish_Topic
3221  093c cd0000        	call	_vMQTT_Publish
3223  093f 85            	popw	x
3224                     ; 868 }
3227  0940 5b29          	addw	sp,#41
3228  0942 81            	ret
3315                     	xdef	_sendDataToCloud
3316                     	xref.b	_IMEIRecievedOKFlag
3317                     	xdef	_bCONNACK_Recieved
3318                     	xdef	_aunPushed_Data
3319                     	xdef	_vMevris_Send_Phase
3320                     	xdef	_vMevris_Send_FuelLevel
3321                     	xdef	_vMevris_Send_EngineTemp
3322                     	xdef	_vMevris_Send_RadiatorTemp
3323                     	xdef	_vMevris_Send_BatteryVolt
3324                     	xdef	_vMevris_Send_SIM_ICCID
3325                     	xdef	_vMevris_Send_Location
3326                     	xdef	_vMevris_Send_SIM_Number
3327                     	xdef	_aunMQTT_Publish_Topic
3328                     	xdef	_aunMQTT_Subscribe_Topic
3329                     	xdef	_aunMQTT_ClientID
3330                     	xref	_Temperature2
3331                     	xref	_Temperature1
3332                     	xref	_Fuellevel
3333                     	xref.b	_batVolt
3334                     	xref	_Watt_Phase3
3335                     	xref	_Ampere_Phase3
3336                     	xref	_Voltage_Phase3
3337                     	xref	_Watt_Phase2
3338                     	xref	_Ampere_Phase2
3339                     	xref	_Voltage_Phase2
3340                     	xref	_Watt_Phase1
3341                     	xref	_Ampere_Phase1
3342                     	xref	_Voltage_Phase1
3343                     	xdef	_vMevris_Send_Version
3344                     	xdef	_vMevris_Send_IMEI
3345                     	xdef	_punGet_Client_ID
3346                     	xdef	_punGet_Command_Topic
3347                     	xdef	_punGet_Event_Topic
3348                     	xdef	_vHandleMevris_MQTT_Recv_Data
3349                     	xdef	_vHandleMevrisRecievedData
3350                     	xref	_getGPS_Longitude
3351                     	xref	_getGPS_Latitude
3352                     	xref	_punGet_SIM_NUmber
3353                     	xref	_punGetSIM_ICCID
3354                     	xref	_enGet_TCP_Status
3355                     	xref	_vClearBuffer
3356                     	xref	_response_buffer
3357                     	xref	_vMQTT_Publish
3358                     	xref.b	_aunIMEI
3359                     	xref	_sprintf
3360                     	xref	_strstr
3361                     	xref	_strcat
3362                     	switch	.const
3363  01f1               L1701:
3364  01f1 7b22          	dc.b	"{",34
3365  01f3 6675656c22    	dc.b	"fuel",34
3366  01f8 3a2200        	dc.b	":",34,0
3367  01fb               L3301:
3368  01fb 7b22          	dc.b	"{",34
3369  01fd 456e67696e65  	dc.b	"EngineTemperature",34
3370  020f 3a2200        	dc.b	":",34,0
3371  0212               L767:
3372  0212 42c80000      	dc.w	17096,0
3373  0216               L167:
3374  0216 7b22          	dc.b	"{",34
3375  0218 526164696174  	dc.b	"RadiatorTemperatur"
3376  022a 6522          	dc.b	"e",34
3377  022c 3a2200        	dc.b	":",34,0
3378  022f               L127:
3379  022f 7b22          	dc.b	"{",34
3380  0231 626174746572  	dc.b	"battery",34
3381  0239 3a2200        	dc.b	":",34,0
3382  023c               L566:
3383  023c 222c22637572  	dc.b	34,44,34,99,117,114
3384  0242 72656e7400    	dc.b	"rent",0
3385  0247               L366:
3386  0247 222c22766f6c  	dc.b	34,44,34,118,111,108
3387  024d 7461676500    	dc.b	"tage",0
3388  0252               L166:
3389  0252 2e00          	dc.b	".",0
3390  0254               L756:
3391  0254 256c6400      	dc.b	"%ld",0
3392  0258               L556:
3393  0258 223a2200      	dc.b	34,58,34,0
3394  025c               L356:
3395  025c 7b22          	dc.b	"{",34
3396  025e 706f77657200  	dc.b	"power",0
3397  0264               L156:
3398  0264 256400        	dc.b	"%d",0
3399  0267               L765:
3400  0267 302e302e3030  	dc.b	"0.0.001",0
3401  026f               L565:
3402  026f 222c22687722  	dc.b	34,44,34,104,119,34
3403  0275 3a2200        	dc.b	":",34,0
3404  0278               L365:
3405  0278 322e342e3030  	dc.b	"2.4.001",0
3406  0280               L165:
3407  0280 7b22          	dc.b	"{",34
3408  0282 667722        	dc.b	"fw",34
3409  0285 3a2200        	dc.b	":",34,0
3410  0288               L335:
3411  0288 222c224c6f6e  	dc.b	34,44,34,76,111,110
3412  028e 6722          	dc.b	"g",34
3413  0290 3a2200        	dc.b	":",34,0
3414  0293               L135:
3415  0293 7b22          	dc.b	"{",34
3416  0295 4c617422      	dc.b	"Lat",34
3417  0299 3a2200        	dc.b	":",34,0
3418  029c               L305:
3419  029c 7b22          	dc.b	"{",34
3420  029e 554943434944  	dc.b	"UICCID",34
3421  02a5 3a2200        	dc.b	":",34,0
3422  02a8               L554:
3423  02a8 7b22          	dc.b	"{",34
3424  02aa 53494d22      	dc.b	"SIM",34
3425  02ae 3a2200        	dc.b	":",34,0
3426  02b1               L124:
3427  02b1 227d00        	dc.b	34,125,0
3428  02b4               L714:
3429  02b4 7b22          	dc.b	"{",34
3430  02b6 696d656922    	dc.b	"imei",34
3431  02bb 3a2200        	dc.b	":",34,0
3432  02be               L173:
3433  02be 6576656e7400  	dc.b	"event",0
3434  02c4               L153:
3435  02c4 636f6d6d616e  	dc.b	"command",0
3436  02cc               L743:
3437  02cc 2f00          	dc.b	"/",0
3438  02ce               L723:
3439  02ce 67656e00      	dc.b	"gen",0
3440  02d2               L513:
3441  02d2 22696d656922  	dc.b	34,105,109,101,105,34,0
3442  02d9               L113:
3443  02d9 22696e666f22  	dc.b	34,105,110,102,111,34,0
3444  02e0               L732:
3445  02e0 73633200      	dc.b	"sc2",0
3446                     	xref.b	c_lreg
3447                     	xref.b	c_x
3467                     	xref	c_lcmp
3468                     	xref	c_rtol
3469                     	xref	c_ftol
3470                     	xref	c_fmul
3471                     	xref	c_lumd
3472                     	xref	c_ludv
3473                     	xref	c_ltor
3474                     	xref	c_xymvx
3475                     	end
