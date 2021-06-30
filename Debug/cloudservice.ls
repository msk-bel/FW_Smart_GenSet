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
  22  0078 7363312f3132  	dc.b	"sc1/12345678901234"
  23  008a 352f636d6400  	dc.b	"5/cmd",0
  24  0090               _aunMQTT_Publish_Topic:
  25  0090 7363312f3132  	dc.b	"sc1/12345678901234"
  26  00a2 352f65767400  	dc.b	"5/evt",0
  27                     	bsct
  28  0000               _bCONNACK_Recieved:
  29  0000 00            	dc.b	0
  30  0001               L5_tempCounter:
  31  0001 00            	dc.b	0
  32                     	switch	.ubsct
  33  0000               L3_enSendEventCounter:
  34  0000 00            	ds.b	1
 308                     ; 58 void sendDataToCloud(void)
 308                     ; 59 {
 310                     	switch	.text
 311  0000               _sendDataToCloud:
 313  0000 88            	push	a
 314       00000001      OFST:	set	1
 317                     ; 68     tempCounter++;  //Added by Saqib
 319  0001 3c01          	inc	L5_tempCounter
 320                     ; 69     if (tempCounter >= 3)
 322  0003 b601          	ld	a,L5_tempCounter
 323  0005 a103          	cp	a,#3
 324  0007 2403          	jruge	L6
 325  0009 cc00db        	jp	L171
 326  000c               L6:
 327                     ; 71         eTCP_Status = enGet_TCP_Status();
 329  000c cd0000        	call	_enGet_TCP_Status
 331  000f 6b01          	ld	(OFST+0,sp),a
 333                     ; 72         if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
 335  0011 7b01          	ld	a,(OFST+0,sp)
 336  0013 a107          	cp	a,#7
 337  0015 2703          	jreq	L01
 338  0017 cc00d7        	jp	L371
 339  001a               L01:
 341  001a 3d00          	tnz	_IMEIRecievedOKFlag
 342  001c 2603          	jrne	L21
 343  001e cc00d7        	jp	L371
 344  0021               L21:
 345                     ; 74             switch (enSendEventCounter)
 347  0021 b600          	ld	a,L3_enSendEventCounter
 349                     ; 118             default:
 349                     ; 119                 break;
 350  0023 a005          	sub	a,#5
 351  0025 272b          	jreq	L12
 352  0027 4a            	dec	a
 353  0028 2749          	jreq	L32
 354  002a 4a            	dec	a
 355  002b 2767          	jreq	L52
 356  002d 4a            	dec	a
 357  002e 2603cc00b5    	jreq	L72
 358  0033 4a            	dec	a
 359  0034 2603cc00ba    	jreq	L13
 360  0039 4a            	dec	a
 361  003a 2603cc00bf    	jreq	L33
 362  003f 4a            	dec	a
 363  0040 2603cc00c4    	jreq	L53
 364  0045 cc00c7        	jra	L771
 365  0048               L7:
 366                     ; 76             case eCommand_Reserved:
 366                     ; 77                 // enSendEventCounter++;
 366                     ; 78                 break;
 368  0048 207d          	jra	L771
 369  004a               L11:
 370                     ; 79             case eCommand_IMEI:
 370                     ; 80                 // vMevris_Send_IMEI();
 370                     ; 81                 break;
 372  004a 207b          	jra	L771
 373  004c               L31:
 374                     ; 82             case eCommand_SIM_Number:
 374                     ; 83                 // vMevris_Send_SIM_Number();
 374                     ; 84                 break;
 376  004c 2079          	jra	L771
 377  004e               L51:
 378                     ; 85             case eCommand_Location:
 378                     ; 86                 // vMevris_Send_Location();
 378                     ; 87                 break;
 380  004e 2077          	jra	L771
 381  0050               L71:
 382                     ; 88             case eCommand_Version:
 382                     ; 89                 // vMevris_Send_Version();
 382                     ; 90                 break;
 384  0050 2075          	jra	L771
 385  0052               L12:
 386                     ; 91             case eCommand_Phase1:
 386                     ; 92                 // vMevris_Send_Phase1();
 386                     ; 93                 vMevris_Send_Phase(1, Watt_Phase1, Voltage_Phase1, Ampere_Phase1);
 388  0052 ce0002        	ldw	x,_Ampere_Phase1+2
 389  0055 89            	pushw	x
 390  0056 ce0000        	ldw	x,_Ampere_Phase1
 391  0059 89            	pushw	x
 392  005a ce0002        	ldw	x,_Voltage_Phase1+2
 393  005d 89            	pushw	x
 394  005e ce0000        	ldw	x,_Voltage_Phase1
 395  0061 89            	pushw	x
 396  0062 ce0002        	ldw	x,_Watt_Phase1+2
 397  0065 89            	pushw	x
 398  0066 ce0000        	ldw	x,_Watt_Phase1
 399  0069 89            	pushw	x
 400  006a a601          	ld	a,#1
 401  006c cd0368        	call	_vMevris_Send_Phase
 403  006f 5b0c          	addw	sp,#12
 404                     ; 94                 break;
 406  0071 2054          	jra	L771
 407  0073               L32:
 408                     ; 95             case eCommand_Phase2:
 408                     ; 96                 // vMevris_Send_Phase2();
 408                     ; 97                 vMevris_Send_Phase(2, Watt_Phase2, Voltage_Phase2, Ampere_Phase2);
 410  0073 ce0002        	ldw	x,_Ampere_Phase2+2
 411  0076 89            	pushw	x
 412  0077 ce0000        	ldw	x,_Ampere_Phase2
 413  007a 89            	pushw	x
 414  007b ce0002        	ldw	x,_Voltage_Phase2+2
 415  007e 89            	pushw	x
 416  007f ce0000        	ldw	x,_Voltage_Phase2
 417  0082 89            	pushw	x
 418  0083 ce0002        	ldw	x,_Watt_Phase2+2
 419  0086 89            	pushw	x
 420  0087 ce0000        	ldw	x,_Watt_Phase2
 421  008a 89            	pushw	x
 422  008b a602          	ld	a,#2
 423  008d cd0368        	call	_vMevris_Send_Phase
 425  0090 5b0c          	addw	sp,#12
 426                     ; 98                 break;
 428  0092 2033          	jra	L771
 429  0094               L52:
 430                     ; 99             case eCommand_Phase3:
 430                     ; 100                 // vMevris_Send_Phase3();
 430                     ; 101                 vMevris_Send_Phase(3, Watt_Phase3, Voltage_Phase3, Ampere_Phase3);
 432  0094 ce0002        	ldw	x,_Ampere_Phase3+2
 433  0097 89            	pushw	x
 434  0098 ce0000        	ldw	x,_Ampere_Phase3
 435  009b 89            	pushw	x
 436  009c ce0002        	ldw	x,_Voltage_Phase3+2
 437  009f 89            	pushw	x
 438  00a0 ce0000        	ldw	x,_Voltage_Phase3
 439  00a3 89            	pushw	x
 440  00a4 ce0002        	ldw	x,_Watt_Phase3+2
 441  00a7 89            	pushw	x
 442  00a8 ce0000        	ldw	x,_Watt_Phase3
 443  00ab 89            	pushw	x
 444  00ac a603          	ld	a,#3
 445  00ae cd0368        	call	_vMevris_Send_Phase
 447  00b1 5b0c          	addw	sp,#12
 448                     ; 102                 break;
 450  00b3 2012          	jra	L771
 451  00b5               L72:
 452                     ; 103             case eCommand_BatteryVolts:
 452                     ; 104                 vMevris_Send_BatteryVolt();
 454  00b5 cd058b        	call	_vMevris_Send_BatteryVolt
 456                     ; 105                 break;
 458  00b8 200d          	jra	L771
 459  00ba               L13:
 460                     ; 106             case eCommand_RadiatorTemp:
 460                     ; 107                 vMevris_Send_RadiatorTemp();
 462  00ba cd065d        	call	_vMevris_Send_RadiatorTemp
 464                     ; 108                 break;
 466  00bd 2008          	jra	L771
 467  00bf               L33:
 468                     ; 109             case eCommand_EngineTemp:
 468                     ; 110                 vMevris_Send_EngineTemp();
 470  00bf cd0747        	call	_vMevris_Send_EngineTemp
 472                     ; 111                 break;
 474  00c2 2003          	jra	L771
 475  00c4               L53:
 476                     ; 112             case eCommand_FuelLevel:
 476                     ; 113                 vMevris_Send_FuelLevel();
 478  00c4 cd0831        	call	_vMevris_Send_FuelLevel
 480                     ; 114                 break;
 482  00c7               L73:
 483                     ; 115             case eCommand_Others:
 483                     ; 116                 // Do something
 483                     ; 117                 break;
 485  00c7               L14:
 486                     ; 118             default:
 486                     ; 119                 break;
 488  00c7               L771:
 489                     ; 122             enSendEventCounter++;
 491  00c7 3c00          	inc	L3_enSendEventCounter
 492                     ; 123             if (enSendEventCounter >= eCommand_Others)
 494  00c9 b600          	ld	a,L3_enSendEventCounter
 495  00cb a10c          	cp	a,#12
 496  00cd 2504          	jrult	L102
 497                     ; 124                 enSendEventCounter = eCommand_IMEI;
 499  00cf 35010000      	mov	L3_enSendEventCounter,#1
 500  00d3               L102:
 501                     ; 125             tempCounter = 0;
 503  00d3 3f01          	clr	L5_tempCounter
 505  00d5 2004          	jra	L171
 506  00d7               L371:
 507                     ; 129             enSendEventCounter = eCommand_IMEI;
 509  00d7 35010000      	mov	L3_enSendEventCounter,#1
 510  00db               L171:
 511                     ; 132 }
 514  00db 84            	pop	a
 515  00dc 81            	ret
 593                     ; 336 void vHandleMevris_MQTT_Recv_Data(void)
 593                     ; 337 {
 594                     	switch	.text
 595  00dd               _vHandleMevris_MQTT_Recv_Data:
 597  00dd 521b          	subw	sp,#27
 598       0000001b      OFST:	set	27
 601                     ; 340     uint8_t i = 0, j;
 603                     ; 341     uint8_t unLength = 0;
 605  00df 0f17          	clr	(OFST-4,sp)
 607                     ; 346     ptr = strstr(response_buffer, "+IPD");
 609  00e1 ae01d7        	ldw	x,#L342
 610  00e4 89            	pushw	x
 611  00e5 ae0000        	ldw	x,#_response_buffer
 612  00e8 cd0000        	call	_strstr
 614  00eb 5b02          	addw	sp,#2
 615  00ed 1f19          	ldw	(OFST-2,sp),x
 617                     ; 347     if (ptr)
 619  00ef 1e19          	ldw	x,(OFST-2,sp)
 620  00f1 2603          	jrne	L61
 621  00f3 cc019b        	jp	L542
 622  00f6               L61:
 623                     ; 349         i = 0;
 625  00f6 0f1b          	clr	(OFST+0,sp)
 628  00f8 2002          	jra	L352
 629  00fa               L742:
 630                     ; 351             i++;
 633  00fa 0c1b          	inc	(OFST+0,sp)
 635  00fc               L352:
 636                     ; 350         while (*(ptr + i) != ':')
 636                     ; 351             i++;
 638  00fc 7b1b          	ld	a,(OFST+0,sp)
 639  00fe 5f            	clrw	x
 640  00ff 97            	ld	xl,a
 641  0100 72fb19        	addw	x,(OFST-2,sp)
 642  0103 f6            	ld	a,(x)
 643  0104 a13a          	cp	a,#58
 644  0106 26f2          	jrne	L742
 645                     ; 352         i++;
 647  0108 0c1b          	inc	(OFST+0,sp)
 649                     ; 353         if (*(ptr + i) == 0x20) // Check if CONNACK is Recieved
 651  010a 7b1b          	ld	a,(OFST+0,sp)
 652  010c 5f            	clrw	x
 653  010d 97            	ld	xl,a
 654  010e 72fb19        	addw	x,(OFST-2,sp)
 655  0111 f6            	ld	a,(x)
 656  0112 a120          	cp	a,#32
 657  0114 260c          	jrne	L752
 658                     ; 355             if (*(ptr + 3) == 0) // If 0x00 Then it means Successfull
 660  0116 1e19          	ldw	x,(OFST-2,sp)
 661  0118 6d03          	tnz	(3,x)
 662  011a 267f          	jrne	L542
 663                     ; 356                 bCONNACK_Recieved = TRUE;
 665  011c 35010000      	mov	_bCONNACK_Recieved,#1
 666  0120 2079          	jra	L542
 667  0122               L752:
 668                     ; 358         else if (*(ptr + i) == 0x30) //Check if Message is a PUBLISH Packet from server
 670  0122 7b1b          	ld	a,(OFST+0,sp)
 671  0124 5f            	clrw	x
 672  0125 97            	ld	xl,a
 673  0126 72fb19        	addw	x,(OFST-2,sp)
 674  0129 f6            	ld	a,(x)
 675  012a a130          	cp	a,#48
 676  012c 266d          	jrne	L542
 678  012e 2002          	jra	L172
 679  0130               L762:
 680                     ; 361                 i++;
 682  0130 0c1b          	inc	(OFST+0,sp)
 684  0132               L172:
 685                     ; 360             while (*(ptr + i) != '{' && i < 99)
 687  0132 7b1b          	ld	a,(OFST+0,sp)
 688  0134 5f            	clrw	x
 689  0135 97            	ld	xl,a
 690  0136 72fb19        	addw	x,(OFST-2,sp)
 691  0139 f6            	ld	a,(x)
 692  013a a17b          	cp	a,#123
 693  013c 2706          	jreq	L572
 695  013e 7b1b          	ld	a,(OFST+0,sp)
 696  0140 a163          	cp	a,#99
 697  0142 25ec          	jrult	L762
 698  0144               L572:
 699                     ; 363             if (*(ptr + i) == '{')
 701  0144 7b1b          	ld	a,(OFST+0,sp)
 702  0146 5f            	clrw	x
 703  0147 97            	ld	xl,a
 704  0148 72fb19        	addw	x,(OFST-2,sp)
 705  014b f6            	ld	a,(x)
 706  014c a17b          	cp	a,#123
 707  014e 264b          	jrne	L542
 708                     ; 365                 vClearBuffer(localBuffer, 20);
 710  0150 4b14          	push	#20
 711  0152 96            	ldw	x,sp
 712  0153 1c0004        	addw	x,#OFST-23
 713  0156 cd0000        	call	_vClearBuffer
 715  0159 84            	pop	a
 716                     ; 366                 j = 0;
 718  015a 0f18          	clr	(OFST-3,sp)
 721  015c 2021          	jra	L503
 722  015e               L103:
 723                     ; 369                     localBuffer[j++] = *(ptr + i);
 725  015e 96            	ldw	x,sp
 726  015f 1c0003        	addw	x,#OFST-24
 727  0162 1f01          	ldw	(OFST-26,sp),x
 729  0164 7b18          	ld	a,(OFST-3,sp)
 730  0166 97            	ld	xl,a
 731  0167 0c18          	inc	(OFST-3,sp)
 733  0169 9f            	ld	a,xl
 734  016a 5f            	clrw	x
 735  016b 97            	ld	xl,a
 736  016c 72fb01        	addw	x,(OFST-26,sp)
 737  016f 7b1b          	ld	a,(OFST+0,sp)
 738  0171 905f          	clrw	y
 739  0173 9097          	ld	yl,a
 740  0175 72f919        	addw	y,(OFST-2,sp)
 741  0178 90f6          	ld	a,(y)
 742  017a f7            	ld	(x),a
 743                     ; 370                     unLength++;
 745  017b 0c17          	inc	(OFST-4,sp)
 747                     ; 371                     i++;
 749  017d 0c1b          	inc	(OFST+0,sp)
 751  017f               L503:
 752                     ; 367                 while (*(ptr + i) != '\r' && j < 19)
 754  017f 7b1b          	ld	a,(OFST+0,sp)
 755  0181 5f            	clrw	x
 756  0182 97            	ld	xl,a
 757  0183 72fb19        	addw	x,(OFST-2,sp)
 758  0186 f6            	ld	a,(x)
 759  0187 a10d          	cp	a,#13
 760  0189 2706          	jreq	L113
 762  018b 7b18          	ld	a,(OFST-3,sp)
 763  018d a113          	cp	a,#19
 764  018f 25cd          	jrult	L103
 765  0191               L113:
 766                     ; 375                 vHandleMevrisRecievedData(localBuffer, unLength);
 768  0191 7b17          	ld	a,(OFST-4,sp)
 769  0193 88            	push	a
 770  0194 96            	ldw	x,sp
 771  0195 1c0004        	addw	x,#OFST-23
 772  0198 ad04          	call	_vHandleMevrisRecievedData
 774  019a 84            	pop	a
 775  019b               L542:
 776                     ; 379 }
 779  019b 5b1b          	addw	sp,#27
 780  019d 81            	ret
 819                     ; 381 void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength)
 819                     ; 382 {
 820                     	switch	.text
 821  019e               _vHandleMevrisRecievedData:
 825                     ; 385     if (Data[0] == '{')
 827  019e f6            	ld	a,(x)
 828  019f a17b          	cp	a,#123
 829  01a1 2614          	jrne	L133
 830                     ; 392         if (Data[1] = '1')
 832  01a3 a631          	ld	a,#49
 833  01a5 e701          	ld	(1,x),a
 834  01a7 6d01          	tnz	(1,x)
 835  01a9 270c          	jreq	L133
 836                     ; 394             ms_send_cmd("are you there", strlen((const char *)"are you there"));
 838  01ab 4b0d          	push	#13
 839  01ad ae01c9        	ldw	x,#L533
 840  01b0 cd0000        	call	_ms_send_cmd
 842  01b3 84            	pop	a
 843                     ; 396             vMevris_Send_IMEI();
 845  01b4 cd0276        	call	_vMevris_Send_IMEI
 847  01b7               L133:
 848                     ; 421 }
 851  01b7 81            	ret
 880                     ; 423 uint8_t *punGet_Client_ID(void)
 880                     ; 424 {
 881                     	switch	.text
 882  01b8               _punGet_Client_ID:
 886                     ; 431     vClearBuffer(aunMQTT_ClientID, 20);
 888  01b8 4b14          	push	#20
 889  01ba ae0064        	ldw	x,#_aunMQTT_ClientID
 890  01bd cd0000        	call	_vClearBuffer
 892  01c0 84            	pop	a
 893                     ; 432     strcpy(aunMQTT_ClientID, "gen");
 895  01c1 ae0064        	ldw	x,#_aunMQTT_ClientID
 896  01c4 90ae01c5      	ldw	y,#L743
 897  01c8               L42:
 898  01c8 90f6          	ld	a,(y)
 899  01ca 905c          	incw	y
 900  01cc f7            	ld	(x),a
 901  01cd 5c            	incw	x
 902  01ce 4d            	tnz	a
 903  01cf 26f7          	jrne	L42
 904                     ; 433     strcat(aunMQTT_ClientID, aunIMEI);
 906  01d1 ae0000        	ldw	x,#_aunIMEI
 907  01d4 89            	pushw	x
 908  01d5 ae0064        	ldw	x,#_aunMQTT_ClientID
 909  01d8 cd0000        	call	_strcat
 911  01db 85            	popw	x
 912                     ; 435     return aunMQTT_ClientID;
 914  01dc ae0064        	ldw	x,#_aunMQTT_ClientID
 917  01df 81            	ret
 958                     ; 438 uint8_t *punGet_Command_Topic(void)
 958                     ; 439 {
 959                     	switch	.text
 960  01e0               _punGet_Command_Topic:
 962  01e0 88            	push	a
 963       00000001      OFST:	set	1
 966                     ; 440     uint8_t i = 0;
 968                     ; 446     vClearBuffer(aunMQTT_Subscribe_Topic, 24);
 970  01e1 4b18          	push	#24
 971  01e3 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 972  01e6 cd0000        	call	_vClearBuffer
 974  01e9 84            	pop	a
 975                     ; 447     strcpy(aunMQTT_Subscribe_Topic, MQTT_TOPIC_HEADER);
 977  01ea ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 978  01ed 90ae01c1      	ldw	y,#L763
 979  01f1               L03:
 980  01f1 90f6          	ld	a,(y)
 981  01f3 905c          	incw	y
 982  01f5 f7            	ld	(x),a
 983  01f6 5c            	incw	x
 984  01f7 4d            	tnz	a
 985  01f8 26f7          	jrne	L03
 986                     ; 448     strcat(aunMQTT_Subscribe_Topic, "/");
 988  01fa ae01bf        	ldw	x,#L173
 989  01fd 89            	pushw	x
 990  01fe ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 991  0201 cd0000        	call	_strcat
 993  0204 85            	popw	x
 994                     ; 449     strcat(aunMQTT_Subscribe_Topic, aunIMEI);
 996  0205 ae0000        	ldw	x,#_aunIMEI
 997  0208 89            	pushw	x
 998  0209 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
 999  020c cd0000        	call	_strcat
1001  020f 85            	popw	x
1002                     ; 450     strcat(aunMQTT_Subscribe_Topic, "/");
1004  0210 ae01bf        	ldw	x,#L173
1005  0213 89            	pushw	x
1006  0214 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1007  0217 cd0000        	call	_strcat
1009  021a 85            	popw	x
1010                     ; 451     strcat(aunMQTT_Subscribe_Topic, MQTT_INBOUND_TOPIC_FOOTER);
1012  021b ae01bb        	ldw	x,#L373
1013  021e 89            	pushw	x
1014  021f ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1015  0222 cd0000        	call	_strcat
1017  0225 85            	popw	x
1018                     ; 452     return aunMQTT_Subscribe_Topic;
1020  0226 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
1023  0229 84            	pop	a
1024  022a 81            	ret
1064                     ; 455 uint8_t *punGet_Event_Topic(void)
1064                     ; 456 {
1065                     	switch	.text
1066  022b               _punGet_Event_Topic:
1068  022b 88            	push	a
1069       00000001      OFST:	set	1
1072                     ; 457     uint8_t i = 0;
1074                     ; 463     vClearBuffer(aunMQTT_Publish_Topic, 24);
1076  022c 4b18          	push	#24
1077  022e ae0090        	ldw	x,#_aunMQTT_Publish_Topic
1078  0231 cd0000        	call	_vClearBuffer
1080  0234 84            	pop	a
1081                     ; 464     strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
1083  0235 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
1084  0238 90ae01c1      	ldw	y,#L763
1085  023c               L43:
1086  023c 90f6          	ld	a,(y)
1087  023e 905c          	incw	y
1088  0240 f7            	ld	(x),a
1089  0241 5c            	incw	x
1090  0242 4d            	tnz	a
1091  0243 26f7          	jrne	L43
1092                     ; 465     strcat(aunMQTT_Publish_Topic, "/");
1094  0245 ae01bf        	ldw	x,#L173
1095  0248 89            	pushw	x
1096  0249 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
1097  024c cd0000        	call	_strcat
1099  024f 85            	popw	x
1100                     ; 466     strcat(aunMQTT_Publish_Topic, aunIMEI);
1102  0250 ae0000        	ldw	x,#_aunIMEI
1103  0253 89            	pushw	x
1104  0254 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
1105  0257 cd0000        	call	_strcat
1107  025a 85            	popw	x
1108                     ; 467     strcat(aunMQTT_Publish_Topic, "/");
1110  025b ae01bf        	ldw	x,#L173
1111  025e 89            	pushw	x
1112  025f ae0090        	ldw	x,#_aunMQTT_Publish_Topic
1113  0262 cd0000        	call	_strcat
1115  0265 85            	popw	x
1116                     ; 468     strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);
1118  0266 ae01b7        	ldw	x,#L314
1119  0269 89            	pushw	x
1120  026a ae0090        	ldw	x,#_aunMQTT_Publish_Topic
1121  026d cd0000        	call	_strcat
1123  0270 85            	popw	x
1124                     ; 470     return aunMQTT_Publish_Topic;
1126  0271 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
1129  0274 84            	pop	a
1130  0275 81            	ret
1133                     .const:	section	.text
1134  0000               L514_localBuffer:
1135  0000 7b22          	dc.b	"{",34
1136  0002 494d454922    	dc.b	"IMEI",34
1137  0007 3a22          	dc.b	":",34
1138  0009 313233343536  	dc.b	"123456789012345",34
1139  0019 7d00          	dc.b	"}",0
1140  001b 000000        	ds.b	3
1190                     ; 475 void vMevris_Send_IMEI(void)
1190                     ; 476 {
1191                     	switch	.text
1192  0276               _vMevris_Send_IMEI:
1194  0276 521f          	subw	sp,#31
1195       0000001f      OFST:	set	31
1198                     ; 477     uint8_t localBuffer[30] = "{\"IMEI\":\"123456789012345\"}";
1200  0278 96            	ldw	x,sp
1201  0279 1c0002        	addw	x,#OFST-29
1202  027c 90ae0000      	ldw	y,#L514_localBuffer
1203  0280 a61e          	ld	a,#30
1204  0282 cd0000        	call	c_xymvx
1206                     ; 478     uint8_t unSendDataLength = 0;
1208                     ; 479     vClearBuffer(localBuffer, 30);
1210  0285 4b1e          	push	#30
1211  0287 96            	ldw	x,sp
1212  0288 1c0003        	addw	x,#OFST-28
1213  028b cd0000        	call	_vClearBuffer
1215  028e 84            	pop	a
1216                     ; 480     strcpy(localBuffer, "{\"IMEI\":\"");
1218  028f 96            	ldw	x,sp
1219  0290 1c0002        	addw	x,#OFST-29
1220  0293 90ae01ad      	ldw	y,#L144
1221  0297               L04:
1222  0297 90f6          	ld	a,(y)
1223  0299 905c          	incw	y
1224  029b f7            	ld	(x),a
1225  029c 5c            	incw	x
1226  029d 4d            	tnz	a
1227  029e 26f7          	jrne	L04
1228                     ; 481     strcat(localBuffer, aunIMEI);
1230  02a0 ae0000        	ldw	x,#_aunIMEI
1231  02a3 89            	pushw	x
1232  02a4 96            	ldw	x,sp
1233  02a5 1c0004        	addw	x,#OFST-27
1234  02a8 cd0000        	call	_strcat
1236  02ab 85            	popw	x
1237                     ; 482     strcat(localBuffer, "\"}");
1239  02ac ae01aa        	ldw	x,#L344
1240  02af 89            	pushw	x
1241  02b0 96            	ldw	x,sp
1242  02b1 1c0004        	addw	x,#OFST-27
1243  02b4 cd0000        	call	_strcat
1245  02b7 85            	popw	x
1246                     ; 483     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1248  02b8 4b64          	push	#100
1249  02ba ae0000        	ldw	x,#_aunPushed_Data
1250  02bd cd0000        	call	_vClearBuffer
1252  02c0 84            	pop	a
1253                     ; 484     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1253                     ; 485                                                punGet_Event_Topic(),
1253                     ; 486                                                localBuffer);
1255  02c1 96            	ldw	x,sp
1256  02c2 1c0002        	addw	x,#OFST-29
1257  02c5 89            	pushw	x
1258  02c6 cd022b        	call	_punGet_Event_Topic
1260  02c9 89            	pushw	x
1261  02ca ae0000        	ldw	x,#_aunPushed_Data
1262  02cd cd0000        	call	_ulMQTT_Publish
1264  02d0 5b04          	addw	sp,#4
1265  02d2 b603          	ld	a,c_lreg+3
1266  02d4 6b01          	ld	(OFST-30,sp),a
1268                     ; 487     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1270  02d6 7b01          	ld	a,(OFST-30,sp)
1271  02d8 88            	push	a
1272  02d9 ae0000        	ldw	x,#_aunPushed_Data
1273  02dc cd0000        	call	_bSendDataOverTCP
1275  02df 84            	pop	a
1276                     ; 488 }
1279  02e0 5b1f          	addw	sp,#31
1280  02e2 81            	ret
1283                     	switch	.const
1284  001e               L544_localBuffer:
1285  001e 7b22          	dc.b	"{",34
1286  0020 465722        	dc.b	"FW",34
1287  0023 3a22          	dc.b	":",34
1288  0025 322e342e3031  	dc.b	"2.4.010",34
1289  002d 2c22          	dc.b	",",34
1290  002f 485722        	dc.b	"HW",34
1291  0032 3a22          	dc.b	":",34
1292  0034 302e302e3030  	dc.b	"0.0.001",34
1293  003c 7d00          	dc.b	"}",0
1294  003e 000000        	ds.b	3
1344                     ; 523 void vMevris_Send_Version()
1344                     ; 524 {
1345                     	switch	.text
1346  02e3               _vMevris_Send_Version:
1348  02e3 5224          	subw	sp,#36
1349       00000024      OFST:	set	36
1352                     ; 525     uint8_t localBuffer[35] = "{\"FW\":\"2.4.010\",\"HW\":\"0.0.001\"}";
1354  02e5 96            	ldw	x,sp
1355  02e6 1c0002        	addw	x,#OFST-34
1356  02e9 90ae001e      	ldw	y,#L544_localBuffer
1357  02ed a623          	ld	a,#35
1358  02ef cd0000        	call	c_xymvx
1360                     ; 526     uint8_t unSendDataLength = 0;
1362                     ; 527     vClearBuffer(localBuffer, 35);
1364  02f2 4b23          	push	#35
1365  02f4 96            	ldw	x,sp
1366  02f5 1c0003        	addw	x,#OFST-33
1367  02f8 cd0000        	call	_vClearBuffer
1369  02fb 84            	pop	a
1370                     ; 528     strcpy(localBuffer, "{\"FW\":\"");
1372  02fc 96            	ldw	x,sp
1373  02fd 1c0002        	addw	x,#OFST-34
1374  0300 90ae01a2      	ldw	y,#L174
1375  0304               L44:
1376  0304 90f6          	ld	a,(y)
1377  0306 905c          	incw	y
1378  0308 f7            	ld	(x),a
1379  0309 5c            	incw	x
1380  030a 4d            	tnz	a
1381  030b 26f7          	jrne	L44
1382                     ; 529     strcat(localBuffer, /*"2.4.010"*/Firmware_Version);
1384  030d ae019a        	ldw	x,#L374
1385  0310 89            	pushw	x
1386  0311 96            	ldw	x,sp
1387  0312 1c0004        	addw	x,#OFST-32
1388  0315 cd0000        	call	_strcat
1390  0318 85            	popw	x
1391                     ; 530     strcat(localBuffer, "\",\"HW\":\"");
1393  0319 ae0191        	ldw	x,#L574
1394  031c 89            	pushw	x
1395  031d 96            	ldw	x,sp
1396  031e 1c0004        	addw	x,#OFST-32
1397  0321 cd0000        	call	_strcat
1399  0324 85            	popw	x
1400                     ; 531     strcat(localBuffer, /*"0.0.001"*/Hardware_Version);
1402  0325 ae0189        	ldw	x,#L774
1403  0328 89            	pushw	x
1404  0329 96            	ldw	x,sp
1405  032a 1c0004        	addw	x,#OFST-32
1406  032d cd0000        	call	_strcat
1408  0330 85            	popw	x
1409                     ; 532     strcat(localBuffer, "\"}");
1411  0331 ae01aa        	ldw	x,#L344
1412  0334 89            	pushw	x
1413  0335 96            	ldw	x,sp
1414  0336 1c0004        	addw	x,#OFST-32
1415  0339 cd0000        	call	_strcat
1417  033c 85            	popw	x
1418                     ; 533     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1420  033d 4b64          	push	#100
1421  033f ae0000        	ldw	x,#_aunPushed_Data
1422  0342 cd0000        	call	_vClearBuffer
1424  0345 84            	pop	a
1425                     ; 534     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1425                     ; 535                                                punGet_Event_Topic(),
1425                     ; 536                                                localBuffer);
1427  0346 96            	ldw	x,sp
1428  0347 1c0002        	addw	x,#OFST-34
1429  034a 89            	pushw	x
1430  034b cd022b        	call	_punGet_Event_Topic
1432  034e 89            	pushw	x
1433  034f ae0000        	ldw	x,#_aunPushed_Data
1434  0352 cd0000        	call	_ulMQTT_Publish
1436  0355 5b04          	addw	sp,#4
1437  0357 b603          	ld	a,c_lreg+3
1438  0359 6b01          	ld	(OFST-35,sp),a
1440                     ; 537     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1442  035b 7b01          	ld	a,(OFST-35,sp)
1443  035d 88            	push	a
1444  035e ae0000        	ldw	x,#_aunPushed_Data
1445  0361 cd0000        	call	_bSendDataOverTCP
1447  0364 84            	pop	a
1448                     ; 538 }
1451  0365 5b24          	addw	sp,#36
1452  0367 81            	ret
1455                     	switch	.const
1456  0041               L105_localBuffer:
1457  0041 7b22          	dc.b	"{",34
1458  0043 503122        	dc.b	"P1",34
1459  0046 3a22          	dc.b	":",34
1460  0048 313233343536  	dc.b	"123456890.23",34
1461  0055 2c22          	dc.b	",",34
1462  0057 563122        	dc.b	"V1",34
1463  005a 3a22          	dc.b	":",34
1464  005c 3132332e3536  	dc.b	"123.56",34
1465  0063 2c22          	dc.b	",",34
1466  0065 493122        	dc.b	"I1",34
1467  0068 3a22          	dc.b	":",34
1468  006a 31323334352e  	dc.b	"12345.78",34
1469  0073 7d00          	dc.b	"}",0
1470  0075 000000        	ds.b	3
1471  0078               L305_temp1:
1472  0078 00            	dc.b	0
1473  0079 000000000000  	ds.b	11
1474  0084               L505_phase_num:
1475  0084 00            	dc.b	0
1476  0085 0000          	ds.b	2
1582                     	switch	.const
1583  0087               L25:
1584  0087 00000064      	dc.l	100
1585                     ; 540 void vMevris_Send_Phase(uint8_t phase_number, uint32_t Watt, uint32_t Voltage, uint32_t Ampere)
1585                     ; 541 {
1586                     	switch	.text
1587  0368               _vMevris_Send_Phase:
1589  0368 88            	push	a
1590  0369 5247          	subw	sp,#71
1591       00000047      OFST:	set	71
1594                     ; 542     uint8_t localBuffer[55] = "{\"P1\":\"123456890.23\",\"V1\":\"123.56\",\"I1\":\"12345.78\"}";
1596  036b 96            	ldw	x,sp
1597  036c 1c0011        	addw	x,#OFST-54
1598  036f 90ae0041      	ldw	y,#L105_localBuffer
1599  0373 a637          	ld	a,#55
1600  0375 cd0000        	call	c_xymvx
1602                     ; 543     uint8_t unSendDataLength = 0;
1604                     ; 544     uint8_t temp1[12] = "";
1606  0378 96            	ldw	x,sp
1607  0379 1c0005        	addw	x,#OFST-66
1608  037c 90ae0078      	ldw	y,#L305_temp1
1609  0380 a60c          	ld	a,#12
1610  0382 cd0000        	call	c_xymvx
1612                     ; 545     uint8_t phase_num[3] = "";
1614  0385 96            	ldw	x,sp
1615  0386 1c0002        	addw	x,#OFST-69
1616  0389 90ae0084      	ldw	y,#L505_phase_num
1617  038d a603          	ld	a,#3
1618  038f cd0000        	call	c_xymvx
1620                     ; 546     vClearBuffer(localBuffer, 55);
1622  0392 4b37          	push	#55
1623  0394 96            	ldw	x,sp
1624  0395 1c0012        	addw	x,#OFST-53
1625  0398 cd0000        	call	_vClearBuffer
1627  039b 84            	pop	a
1628                     ; 547     sprintf(phase_num, "%d", (uint16_t)phase_number);
1630  039c 7b48          	ld	a,(OFST+1,sp)
1631  039e 5f            	clrw	x
1632  039f 97            	ld	xl,a
1633  03a0 89            	pushw	x
1634  03a1 ae0186        	ldw	x,#L165
1635  03a4 89            	pushw	x
1636  03a5 96            	ldw	x,sp
1637  03a6 1c0006        	addw	x,#OFST-65
1638  03a9 cd0000        	call	_sprintf
1640  03ac 5b04          	addw	sp,#4
1641                     ; 548     strcpy(localBuffer, "{\"P");
1643  03ae 96            	ldw	x,sp
1644  03af 1c0011        	addw	x,#OFST-54
1645  03b2 90ae0182      	ldw	y,#L365
1646  03b6               L05:
1647  03b6 90f6          	ld	a,(y)
1648  03b8 905c          	incw	y
1649  03ba f7            	ld	(x),a
1650  03bb 5c            	incw	x
1651  03bc 4d            	tnz	a
1652  03bd 26f7          	jrne	L05
1653                     ; 549     strcat(localBuffer, phase_num);
1655  03bf 96            	ldw	x,sp
1656  03c0 1c0002        	addw	x,#OFST-69
1657  03c3 89            	pushw	x
1658  03c4 96            	ldw	x,sp
1659  03c5 1c0013        	addw	x,#OFST-52
1660  03c8 cd0000        	call	_strcat
1662  03cb 85            	popw	x
1663                     ; 550     strcat(localBuffer, "\":\"");
1665  03cc ae017e        	ldw	x,#L565
1666  03cf 89            	pushw	x
1667  03d0 96            	ldw	x,sp
1668  03d1 1c0013        	addw	x,#OFST-52
1669  03d4 cd0000        	call	_strcat
1671  03d7 85            	popw	x
1672                     ; 551     sprintf(temp1, "%ld", Watt / 100);
1674  03d8 96            	ldw	x,sp
1675  03d9 1c004b        	addw	x,#OFST+4
1676  03dc cd0000        	call	c_ltor
1678  03df ae0087        	ldw	x,#L25
1679  03e2 cd0000        	call	c_ludv
1681  03e5 be02          	ldw	x,c_lreg+2
1682  03e7 89            	pushw	x
1683  03e8 be00          	ldw	x,c_lreg
1684  03ea 89            	pushw	x
1685  03eb ae017a        	ldw	x,#L765
1686  03ee 89            	pushw	x
1687  03ef 96            	ldw	x,sp
1688  03f0 1c000b        	addw	x,#OFST-60
1689  03f3 cd0000        	call	_sprintf
1691  03f6 5b06          	addw	sp,#6
1692                     ; 552     strcat(localBuffer, temp1);
1694  03f8 96            	ldw	x,sp
1695  03f9 1c0005        	addw	x,#OFST-66
1696  03fc 89            	pushw	x
1697  03fd 96            	ldw	x,sp
1698  03fe 1c0013        	addw	x,#OFST-52
1699  0401 cd0000        	call	_strcat
1701  0404 85            	popw	x
1702                     ; 553     strcat(localBuffer, ".");
1704  0405 ae0178        	ldw	x,#L175
1705  0408 89            	pushw	x
1706  0409 96            	ldw	x,sp
1707  040a 1c0013        	addw	x,#OFST-52
1708  040d cd0000        	call	_strcat
1710  0410 85            	popw	x
1711                     ; 554     sprintf(temp1, "%ld", Watt % 100);
1713  0411 96            	ldw	x,sp
1714  0412 1c004b        	addw	x,#OFST+4
1715  0415 cd0000        	call	c_ltor
1717  0418 ae0087        	ldw	x,#L25
1718  041b cd0000        	call	c_lumd
1720  041e be02          	ldw	x,c_lreg+2
1721  0420 89            	pushw	x
1722  0421 be00          	ldw	x,c_lreg
1723  0423 89            	pushw	x
1724  0424 ae017a        	ldw	x,#L765
1725  0427 89            	pushw	x
1726  0428 96            	ldw	x,sp
1727  0429 1c000b        	addw	x,#OFST-60
1728  042c cd0000        	call	_sprintf
1730  042f 5b06          	addw	sp,#6
1731                     ; 555     strcat(localBuffer, temp1);
1733  0431 96            	ldw	x,sp
1734  0432 1c0005        	addw	x,#OFST-66
1735  0435 89            	pushw	x
1736  0436 96            	ldw	x,sp
1737  0437 1c0013        	addw	x,#OFST-52
1738  043a cd0000        	call	_strcat
1740  043d 85            	popw	x
1741                     ; 557     strcat(localBuffer, "\",\"V");
1743  043e ae0173        	ldw	x,#L375
1744  0441 89            	pushw	x
1745  0442 96            	ldw	x,sp
1746  0443 1c0013        	addw	x,#OFST-52
1747  0446 cd0000        	call	_strcat
1749  0449 85            	popw	x
1750                     ; 558     strcat(localBuffer, phase_num);
1752  044a 96            	ldw	x,sp
1753  044b 1c0002        	addw	x,#OFST-69
1754  044e 89            	pushw	x
1755  044f 96            	ldw	x,sp
1756  0450 1c0013        	addw	x,#OFST-52
1757  0453 cd0000        	call	_strcat
1759  0456 85            	popw	x
1760                     ; 559     strcat(localBuffer, "\":\"");
1762  0457 ae017e        	ldw	x,#L565
1763  045a 89            	pushw	x
1764  045b 96            	ldw	x,sp
1765  045c 1c0013        	addw	x,#OFST-52
1766  045f cd0000        	call	_strcat
1768  0462 85            	popw	x
1769                     ; 560     sprintf(temp1, "%ld", Voltage / 100);
1771  0463 96            	ldw	x,sp
1772  0464 1c004f        	addw	x,#OFST+8
1773  0467 cd0000        	call	c_ltor
1775  046a ae0087        	ldw	x,#L25
1776  046d cd0000        	call	c_ludv
1778  0470 be02          	ldw	x,c_lreg+2
1779  0472 89            	pushw	x
1780  0473 be00          	ldw	x,c_lreg
1781  0475 89            	pushw	x
1782  0476 ae017a        	ldw	x,#L765
1783  0479 89            	pushw	x
1784  047a 96            	ldw	x,sp
1785  047b 1c000b        	addw	x,#OFST-60
1786  047e cd0000        	call	_sprintf
1788  0481 5b06          	addw	sp,#6
1789                     ; 561     strcat(localBuffer, temp1);
1791  0483 96            	ldw	x,sp
1792  0484 1c0005        	addw	x,#OFST-66
1793  0487 89            	pushw	x
1794  0488 96            	ldw	x,sp
1795  0489 1c0013        	addw	x,#OFST-52
1796  048c cd0000        	call	_strcat
1798  048f 85            	popw	x
1799                     ; 562     strcat(localBuffer, ".");
1801  0490 ae0178        	ldw	x,#L175
1802  0493 89            	pushw	x
1803  0494 96            	ldw	x,sp
1804  0495 1c0013        	addw	x,#OFST-52
1805  0498 cd0000        	call	_strcat
1807  049b 85            	popw	x
1808                     ; 563     sprintf(temp1, "%ld", Voltage % 100);
1810  049c 96            	ldw	x,sp
1811  049d 1c004f        	addw	x,#OFST+8
1812  04a0 cd0000        	call	c_ltor
1814  04a3 ae0087        	ldw	x,#L25
1815  04a6 cd0000        	call	c_lumd
1817  04a9 be02          	ldw	x,c_lreg+2
1818  04ab 89            	pushw	x
1819  04ac be00          	ldw	x,c_lreg
1820  04ae 89            	pushw	x
1821  04af ae017a        	ldw	x,#L765
1822  04b2 89            	pushw	x
1823  04b3 96            	ldw	x,sp
1824  04b4 1c000b        	addw	x,#OFST-60
1825  04b7 cd0000        	call	_sprintf
1827  04ba 5b06          	addw	sp,#6
1828                     ; 564     strcat(localBuffer, temp1);
1830  04bc 96            	ldw	x,sp
1831  04bd 1c0005        	addw	x,#OFST-66
1832  04c0 89            	pushw	x
1833  04c1 96            	ldw	x,sp
1834  04c2 1c0013        	addw	x,#OFST-52
1835  04c5 cd0000        	call	_strcat
1837  04c8 85            	popw	x
1838                     ; 566     strcat(localBuffer, "\",\"I");
1840  04c9 ae016e        	ldw	x,#L575
1841  04cc 89            	pushw	x
1842  04cd 96            	ldw	x,sp
1843  04ce 1c0013        	addw	x,#OFST-52
1844  04d1 cd0000        	call	_strcat
1846  04d4 85            	popw	x
1847                     ; 567     strcat(localBuffer, phase_num);
1849  04d5 96            	ldw	x,sp
1850  04d6 1c0002        	addw	x,#OFST-69
1851  04d9 89            	pushw	x
1852  04da 96            	ldw	x,sp
1853  04db 1c0013        	addw	x,#OFST-52
1854  04de cd0000        	call	_strcat
1856  04e1 85            	popw	x
1857                     ; 568     strcat(localBuffer, "\":\"");
1859  04e2 ae017e        	ldw	x,#L565
1860  04e5 89            	pushw	x
1861  04e6 96            	ldw	x,sp
1862  04e7 1c0013        	addw	x,#OFST-52
1863  04ea cd0000        	call	_strcat
1865  04ed 85            	popw	x
1866                     ; 569     sprintf(temp1, "%ld", Ampere / 100);
1868  04ee 96            	ldw	x,sp
1869  04ef 1c0053        	addw	x,#OFST+12
1870  04f2 cd0000        	call	c_ltor
1872  04f5 ae0087        	ldw	x,#L25
1873  04f8 cd0000        	call	c_ludv
1875  04fb be02          	ldw	x,c_lreg+2
1876  04fd 89            	pushw	x
1877  04fe be00          	ldw	x,c_lreg
1878  0500 89            	pushw	x
1879  0501 ae017a        	ldw	x,#L765
1880  0504 89            	pushw	x
1881  0505 96            	ldw	x,sp
1882  0506 1c000b        	addw	x,#OFST-60
1883  0509 cd0000        	call	_sprintf
1885  050c 5b06          	addw	sp,#6
1886                     ; 570     strcat(localBuffer, temp1);
1888  050e 96            	ldw	x,sp
1889  050f 1c0005        	addw	x,#OFST-66
1890  0512 89            	pushw	x
1891  0513 96            	ldw	x,sp
1892  0514 1c0013        	addw	x,#OFST-52
1893  0517 cd0000        	call	_strcat
1895  051a 85            	popw	x
1896                     ; 571     strcat(localBuffer, ".");
1898  051b ae0178        	ldw	x,#L175
1899  051e 89            	pushw	x
1900  051f 96            	ldw	x,sp
1901  0520 1c0013        	addw	x,#OFST-52
1902  0523 cd0000        	call	_strcat
1904  0526 85            	popw	x
1905                     ; 572     sprintf(temp1, "%ld", Ampere % 100);
1907  0527 96            	ldw	x,sp
1908  0528 1c0053        	addw	x,#OFST+12
1909  052b cd0000        	call	c_ltor
1911  052e ae0087        	ldw	x,#L25
1912  0531 cd0000        	call	c_lumd
1914  0534 be02          	ldw	x,c_lreg+2
1915  0536 89            	pushw	x
1916  0537 be00          	ldw	x,c_lreg
1917  0539 89            	pushw	x
1918  053a ae017a        	ldw	x,#L765
1919  053d 89            	pushw	x
1920  053e 96            	ldw	x,sp
1921  053f 1c000b        	addw	x,#OFST-60
1922  0542 cd0000        	call	_sprintf
1924  0545 5b06          	addw	sp,#6
1925                     ; 573     strcat(localBuffer, temp1);
1927  0547 96            	ldw	x,sp
1928  0548 1c0005        	addw	x,#OFST-66
1929  054b 89            	pushw	x
1930  054c 96            	ldw	x,sp
1931  054d 1c0013        	addw	x,#OFST-52
1932  0550 cd0000        	call	_strcat
1934  0553 85            	popw	x
1935                     ; 574     strcat(localBuffer, "\"}");
1937  0554 ae01aa        	ldw	x,#L344
1938  0557 89            	pushw	x
1939  0558 96            	ldw	x,sp
1940  0559 1c0013        	addw	x,#OFST-52
1941  055c cd0000        	call	_strcat
1943  055f 85            	popw	x
1944                     ; 576     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1946  0560 4b64          	push	#100
1947  0562 ae0000        	ldw	x,#_aunPushed_Data
1948  0565 cd0000        	call	_vClearBuffer
1950  0568 84            	pop	a
1951                     ; 577     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
1951                     ; 578                                                punGet_Event_Topic(),
1951                     ; 579                                                localBuffer);
1953  0569 96            	ldw	x,sp
1954  056a 1c0011        	addw	x,#OFST-54
1955  056d 89            	pushw	x
1956  056e cd022b        	call	_punGet_Event_Topic
1958  0571 89            	pushw	x
1959  0572 ae0000        	ldw	x,#_aunPushed_Data
1960  0575 cd0000        	call	_ulMQTT_Publish
1962  0578 5b04          	addw	sp,#4
1963  057a b603          	ld	a,c_lreg+3
1964  057c 6b01          	ld	(OFST-70,sp),a
1966                     ; 580     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
1968  057e 7b01          	ld	a,(OFST-70,sp)
1969  0580 88            	push	a
1970  0581 ae0000        	ldw	x,#_aunPushed_Data
1971  0584 cd0000        	call	_bSendDataOverTCP
1973  0587 84            	pop	a
1974                     ; 581 }
1977  0588 5b48          	addw	sp,#72
1978  058a 81            	ret
1981                     	switch	.const
1982  008b               L775_localBuffer:
1983  008b 7b22          	dc.b	"{",34
1984  008d 424154544552  	dc.b	"BATTERY",34
1985  0095 3a22          	dc.b	":",34
1986  0097 313233343536  	dc.b	"123456.89",34
1987  00a1 7d00          	dc.b	"}",0
1988  00a3 000000000000  	ds.b	6
1989  00a9               L106_temp1:
1990  00a9 00            	dc.b	0
1991  00aa 000000000000  	ds.b	9
2053                     ; 691 void vMevris_Send_BatteryVolt()
2053                     ; 692 {
2054                     	switch	.text
2055  058b               _vMevris_Send_BatteryVolt:
2057  058b 5229          	subw	sp,#41
2058       00000029      OFST:	set	41
2061                     ; 693     uint8_t localBuffer[30] = "{\"BATTERY\":\"123456.89\"}";
2063  058d 96            	ldw	x,sp
2064  058e 1c000c        	addw	x,#OFST-29
2065  0591 90ae008b      	ldw	y,#L775_localBuffer
2066  0595 a61e          	ld	a,#30
2067  0597 cd0000        	call	c_xymvx
2069                     ; 694     uint8_t unSendDataLength = 0;
2071                     ; 695     uint8_t temp1[10] = "";
2073  059a 96            	ldw	x,sp
2074  059b 1c0002        	addw	x,#OFST-39
2075  059e 90ae00a9      	ldw	y,#L106_temp1
2076  05a2 a60a          	ld	a,#10
2077  05a4 cd0000        	call	c_xymvx
2079                     ; 696     vClearBuffer(localBuffer, 30);
2081  05a7 4b1e          	push	#30
2082  05a9 96            	ldw	x,sp
2083  05aa 1c000d        	addw	x,#OFST-28
2084  05ad cd0000        	call	_vClearBuffer
2086  05b0 84            	pop	a
2087                     ; 697     strcpy(localBuffer, "{\"BATTERY\":\"");
2089  05b1 96            	ldw	x,sp
2090  05b2 1c000c        	addw	x,#OFST-29
2091  05b5 90ae0161      	ldw	y,#L136
2092  05b9               L65:
2093  05b9 90f6          	ld	a,(y)
2094  05bb 905c          	incw	y
2095  05bd f7            	ld	(x),a
2096  05be 5c            	incw	x
2097  05bf 4d            	tnz	a
2098  05c0 26f7          	jrne	L65
2099                     ; 699     sprintf(temp1, "%ld", batVolt / 100);
2101  05c2 ae0000        	ldw	x,#_batVolt
2102  05c5 cd0000        	call	c_ltor
2104  05c8 ae0087        	ldw	x,#L25
2105  05cb cd0000        	call	c_ludv
2107  05ce be02          	ldw	x,c_lreg+2
2108  05d0 89            	pushw	x
2109  05d1 be00          	ldw	x,c_lreg
2110  05d3 89            	pushw	x
2111  05d4 ae017a        	ldw	x,#L765
2112  05d7 89            	pushw	x
2113  05d8 96            	ldw	x,sp
2114  05d9 1c0008        	addw	x,#OFST-33
2115  05dc cd0000        	call	_sprintf
2117  05df 5b06          	addw	sp,#6
2118                     ; 700     strcat(localBuffer, temp1);
2120  05e1 96            	ldw	x,sp
2121  05e2 1c0002        	addw	x,#OFST-39
2122  05e5 89            	pushw	x
2123  05e6 96            	ldw	x,sp
2124  05e7 1c000e        	addw	x,#OFST-27
2125  05ea cd0000        	call	_strcat
2127  05ed 85            	popw	x
2128                     ; 701     strcat(localBuffer, ".");
2130  05ee ae0178        	ldw	x,#L175
2131  05f1 89            	pushw	x
2132  05f2 96            	ldw	x,sp
2133  05f3 1c000e        	addw	x,#OFST-27
2134  05f6 cd0000        	call	_strcat
2136  05f9 85            	popw	x
2137                     ; 702     sprintf(temp1, "%ld", batVolt % 100);
2139  05fa ae0000        	ldw	x,#_batVolt
2140  05fd cd0000        	call	c_ltor
2142  0600 ae0087        	ldw	x,#L25
2143  0603 cd0000        	call	c_lumd
2145  0606 be02          	ldw	x,c_lreg+2
2146  0608 89            	pushw	x
2147  0609 be00          	ldw	x,c_lreg
2148  060b 89            	pushw	x
2149  060c ae017a        	ldw	x,#L765
2150  060f 89            	pushw	x
2151  0610 96            	ldw	x,sp
2152  0611 1c0008        	addw	x,#OFST-33
2153  0614 cd0000        	call	_sprintf
2155  0617 5b06          	addw	sp,#6
2156                     ; 703     strcat(localBuffer, temp1);
2158  0619 96            	ldw	x,sp
2159  061a 1c0002        	addw	x,#OFST-39
2160  061d 89            	pushw	x
2161  061e 96            	ldw	x,sp
2162  061f 1c000e        	addw	x,#OFST-27
2163  0622 cd0000        	call	_strcat
2165  0625 85            	popw	x
2166                     ; 704     strcat(localBuffer, "\"}");
2168  0626 ae01aa        	ldw	x,#L344
2169  0629 89            	pushw	x
2170  062a 96            	ldw	x,sp
2171  062b 1c000e        	addw	x,#OFST-27
2172  062e cd0000        	call	_strcat
2174  0631 85            	popw	x
2175                     ; 705     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2177  0632 4b64          	push	#100
2178  0634 ae0000        	ldw	x,#_aunPushed_Data
2179  0637 cd0000        	call	_vClearBuffer
2181  063a 84            	pop	a
2182                     ; 706     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2182                     ; 707                                                punGet_Event_Topic(),
2182                     ; 708                                                localBuffer);
2184  063b 96            	ldw	x,sp
2185  063c 1c000c        	addw	x,#OFST-29
2186  063f 89            	pushw	x
2187  0640 cd022b        	call	_punGet_Event_Topic
2189  0643 89            	pushw	x
2190  0644 ae0000        	ldw	x,#_aunPushed_Data
2191  0647 cd0000        	call	_ulMQTT_Publish
2193  064a 5b04          	addw	sp,#4
2194  064c b603          	ld	a,c_lreg+3
2195  064e 6b01          	ld	(OFST-40,sp),a
2197                     ; 709     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2199  0650 7b01          	ld	a,(OFST-40,sp)
2200  0652 88            	push	a
2201  0653 ae0000        	ldw	x,#_aunPushed_Data
2202  0656 cd0000        	call	_bSendDataOverTCP
2204  0659 84            	pop	a
2205                     ; 710 }
2208  065a 5b29          	addw	sp,#41
2209  065c 81            	ret
2212                     	switch	.const
2213  00b3               L336_localBuffer:
2214  00b3 7b22          	dc.b	"{",34
2215  00b5 542d52414449  	dc.b	"T-RADIATOR",34
2216  00c0 3a22          	dc.b	":",34
2217  00c2 313233343536  	dc.b	"123456.89",34
2218  00cc 7d00          	dc.b	"}",0
2219  00ce 000000        	ds.b	3
2220  00d1               L536_temp1:
2221  00d1 00            	dc.b	0
2222  00d2 000000000000  	ds.b	14
2293                     ; 712 void vMevris_Send_RadiatorTemp()
2293                     ; 713 {
2294                     	switch	.text
2295  065d               _vMevris_Send_RadiatorTemp:
2297  065d 5232          	subw	sp,#50
2298       00000032      OFST:	set	50
2301                     ; 714     uint8_t localBuffer[30] = "{\"T-RADIATOR\":\"123456.89\"}";
2303  065f 96            	ldw	x,sp
2304  0660 1c0015        	addw	x,#OFST-29
2305  0663 90ae00b3      	ldw	y,#L336_localBuffer
2306  0667 a61e          	ld	a,#30
2307  0669 cd0000        	call	c_xymvx
2309                     ; 715     uint8_t unSendDataLength = 0;
2311                     ; 716     uint8_t temp1[15] = "";
2313  066c 96            	ldw	x,sp
2314  066d 1c0006        	addw	x,#OFST-44
2315  0670 90ae00d1      	ldw	y,#L536_temp1
2316  0674 a60f          	ld	a,#15
2317  0676 cd0000        	call	c_xymvx
2319                     ; 717     uint32_t myVar = 0;
2321                     ; 718     vClearBuffer(localBuffer, 30);
2323  0679 4b1e          	push	#30
2324  067b 96            	ldw	x,sp
2325  067c 1c0016        	addw	x,#OFST-28
2326  067f cd0000        	call	_vClearBuffer
2328  0682 84            	pop	a
2329                     ; 719     strcpy(localBuffer, "{\"T-RADIATOR\":\"");
2331  0683 96            	ldw	x,sp
2332  0684 1c0015        	addw	x,#OFST-29
2333  0687 90ae0151      	ldw	y,#L176
2334  068b               L26:
2335  068b 90f6          	ld	a,(y)
2336  068d 905c          	incw	y
2337  068f f7            	ld	(x),a
2338  0690 5c            	incw	x
2339  0691 4d            	tnz	a
2340  0692 26f7          	jrne	L26
2341                     ; 720     myVar = (uint32_t)(Temperature1 * 100);
2343  0694 ae0000        	ldw	x,#_Temperature1
2344  0697 cd0000        	call	c_ltor
2346  069a ae014d        	ldw	x,#L776
2347  069d cd0000        	call	c_fmul
2349  06a0 cd0000        	call	c_ftol
2351  06a3 96            	ldw	x,sp
2352  06a4 1c0002        	addw	x,#OFST-48
2353  06a7 cd0000        	call	c_rtol
2356                     ; 721     sprintf(temp1, "%ld", myVar / 100);
2358  06aa 96            	ldw	x,sp
2359  06ab 1c0002        	addw	x,#OFST-48
2360  06ae cd0000        	call	c_ltor
2362  06b1 ae0087        	ldw	x,#L25
2363  06b4 cd0000        	call	c_ludv
2365  06b7 be02          	ldw	x,c_lreg+2
2366  06b9 89            	pushw	x
2367  06ba be00          	ldw	x,c_lreg
2368  06bc 89            	pushw	x
2369  06bd ae017a        	ldw	x,#L765
2370  06c0 89            	pushw	x
2371  06c1 96            	ldw	x,sp
2372  06c2 1c000c        	addw	x,#OFST-38
2373  06c5 cd0000        	call	_sprintf
2375  06c8 5b06          	addw	sp,#6
2376                     ; 722     strcat(localBuffer, temp1);
2378  06ca 96            	ldw	x,sp
2379  06cb 1c0006        	addw	x,#OFST-44
2380  06ce 89            	pushw	x
2381  06cf 96            	ldw	x,sp
2382  06d0 1c0017        	addw	x,#OFST-27
2383  06d3 cd0000        	call	_strcat
2385  06d6 85            	popw	x
2386                     ; 723     strcat(localBuffer, ".");
2388  06d7 ae0178        	ldw	x,#L175
2389  06da 89            	pushw	x
2390  06db 96            	ldw	x,sp
2391  06dc 1c0017        	addw	x,#OFST-27
2392  06df cd0000        	call	_strcat
2394  06e2 85            	popw	x
2395                     ; 724     sprintf(temp1, "%ld", myVar % 100);
2397  06e3 96            	ldw	x,sp
2398  06e4 1c0002        	addw	x,#OFST-48
2399  06e7 cd0000        	call	c_ltor
2401  06ea ae0087        	ldw	x,#L25
2402  06ed cd0000        	call	c_lumd
2404  06f0 be02          	ldw	x,c_lreg+2
2405  06f2 89            	pushw	x
2406  06f3 be00          	ldw	x,c_lreg
2407  06f5 89            	pushw	x
2408  06f6 ae017a        	ldw	x,#L765
2409  06f9 89            	pushw	x
2410  06fa 96            	ldw	x,sp
2411  06fb 1c000c        	addw	x,#OFST-38
2412  06fe cd0000        	call	_sprintf
2414  0701 5b06          	addw	sp,#6
2415                     ; 725     strcat(localBuffer, temp1);
2417  0703 96            	ldw	x,sp
2418  0704 1c0006        	addw	x,#OFST-44
2419  0707 89            	pushw	x
2420  0708 96            	ldw	x,sp
2421  0709 1c0017        	addw	x,#OFST-27
2422  070c cd0000        	call	_strcat
2424  070f 85            	popw	x
2425                     ; 727     strcat(localBuffer, "\"}");
2427  0710 ae01aa        	ldw	x,#L344
2428  0713 89            	pushw	x
2429  0714 96            	ldw	x,sp
2430  0715 1c0017        	addw	x,#OFST-27
2431  0718 cd0000        	call	_strcat
2433  071b 85            	popw	x
2434                     ; 728     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2436  071c 4b64          	push	#100
2437  071e ae0000        	ldw	x,#_aunPushed_Data
2438  0721 cd0000        	call	_vClearBuffer
2440  0724 84            	pop	a
2441                     ; 729     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2441                     ; 730                                                punGet_Event_Topic(),
2441                     ; 731                                                localBuffer);
2443  0725 96            	ldw	x,sp
2444  0726 1c0015        	addw	x,#OFST-29
2445  0729 89            	pushw	x
2446  072a cd022b        	call	_punGet_Event_Topic
2448  072d 89            	pushw	x
2449  072e ae0000        	ldw	x,#_aunPushed_Data
2450  0731 cd0000        	call	_ulMQTT_Publish
2452  0734 5b04          	addw	sp,#4
2453  0736 b603          	ld	a,c_lreg+3
2454  0738 6b01          	ld	(OFST-49,sp),a
2456                     ; 732     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2458  073a 7b01          	ld	a,(OFST-49,sp)
2459  073c 88            	push	a
2460  073d ae0000        	ldw	x,#_aunPushed_Data
2461  0740 cd0000        	call	_bSendDataOverTCP
2463  0743 84            	pop	a
2464                     ; 733 }
2467  0744 5b32          	addw	sp,#50
2468  0746 81            	ret
2471                     	switch	.const
2472  00e0               L307_localBuffer:
2473  00e0 7b22          	dc.b	"{",34
2474  00e2 542d454e4749  	dc.b	"T-ENGINE",34
2475  00eb 3a22          	dc.b	":",34
2476  00ed 313233343536  	dc.b	"123456.89",34
2477  00f7 7d00          	dc.b	"}",0
2478  00f9 0000000000    	ds.b	5
2479  00fe               L507_temp1:
2480  00fe 00            	dc.b	0
2481  00ff 000000000000  	ds.b	14
2552                     ; 735 void vMevris_Send_EngineTemp()
2552                     ; 736 {
2553                     	switch	.text
2554  0747               _vMevris_Send_EngineTemp:
2556  0747 5232          	subw	sp,#50
2557       00000032      OFST:	set	50
2560                     ; 737     uint8_t localBuffer[30] = "{\"T-ENGINE\":\"123456.89\"}";
2562  0749 96            	ldw	x,sp
2563  074a 1c0015        	addw	x,#OFST-29
2564  074d 90ae00e0      	ldw	y,#L307_localBuffer
2565  0751 a61e          	ld	a,#30
2566  0753 cd0000        	call	c_xymvx
2568                     ; 738     uint8_t unSendDataLength = 0;
2570                     ; 739     uint8_t temp1[15] = "";
2572  0756 96            	ldw	x,sp
2573  0757 1c0006        	addw	x,#OFST-44
2574  075a 90ae00fe      	ldw	y,#L507_temp1
2575  075e a60f          	ld	a,#15
2576  0760 cd0000        	call	c_xymvx
2578                     ; 740     uint32_t myVar = 0;
2580                     ; 741     vClearBuffer(localBuffer, 30);
2582  0763 4b1e          	push	#30
2583  0765 96            	ldw	x,sp
2584  0766 1c0016        	addw	x,#OFST-28
2585  0769 cd0000        	call	_vClearBuffer
2587  076c 84            	pop	a
2588                     ; 742     strcpy(localBuffer, "{\"T-ENGINE\":\"");
2590  076d 96            	ldw	x,sp
2591  076e 1c0015        	addw	x,#OFST-29
2592  0771 90ae013f      	ldw	y,#L147
2593  0775               L66:
2594  0775 90f6          	ld	a,(y)
2595  0777 905c          	incw	y
2596  0779 f7            	ld	(x),a
2597  077a 5c            	incw	x
2598  077b 4d            	tnz	a
2599  077c 26f7          	jrne	L66
2600                     ; 743     myVar = (uint32_t)(Temperature2 * 100);
2602  077e ae0000        	ldw	x,#_Temperature2
2603  0781 cd0000        	call	c_ltor
2605  0784 ae014d        	ldw	x,#L776
2606  0787 cd0000        	call	c_fmul
2608  078a cd0000        	call	c_ftol
2610  078d 96            	ldw	x,sp
2611  078e 1c0002        	addw	x,#OFST-48
2612  0791 cd0000        	call	c_rtol
2615                     ; 744     sprintf(temp1, "%ld", myVar / 100);
2617  0794 96            	ldw	x,sp
2618  0795 1c0002        	addw	x,#OFST-48
2619  0798 cd0000        	call	c_ltor
2621  079b ae0087        	ldw	x,#L25
2622  079e cd0000        	call	c_ludv
2624  07a1 be02          	ldw	x,c_lreg+2
2625  07a3 89            	pushw	x
2626  07a4 be00          	ldw	x,c_lreg
2627  07a6 89            	pushw	x
2628  07a7 ae017a        	ldw	x,#L765
2629  07aa 89            	pushw	x
2630  07ab 96            	ldw	x,sp
2631  07ac 1c000c        	addw	x,#OFST-38
2632  07af cd0000        	call	_sprintf
2634  07b2 5b06          	addw	sp,#6
2635                     ; 745     strcat(localBuffer, temp1);
2637  07b4 96            	ldw	x,sp
2638  07b5 1c0006        	addw	x,#OFST-44
2639  07b8 89            	pushw	x
2640  07b9 96            	ldw	x,sp
2641  07ba 1c0017        	addw	x,#OFST-27
2642  07bd cd0000        	call	_strcat
2644  07c0 85            	popw	x
2645                     ; 746     strcat(localBuffer, ".");
2647  07c1 ae0178        	ldw	x,#L175
2648  07c4 89            	pushw	x
2649  07c5 96            	ldw	x,sp
2650  07c6 1c0017        	addw	x,#OFST-27
2651  07c9 cd0000        	call	_strcat
2653  07cc 85            	popw	x
2654                     ; 747     sprintf(temp1, "%ld", myVar % 100);
2656  07cd 96            	ldw	x,sp
2657  07ce 1c0002        	addw	x,#OFST-48
2658  07d1 cd0000        	call	c_ltor
2660  07d4 ae0087        	ldw	x,#L25
2661  07d7 cd0000        	call	c_lumd
2663  07da be02          	ldw	x,c_lreg+2
2664  07dc 89            	pushw	x
2665  07dd be00          	ldw	x,c_lreg
2666  07df 89            	pushw	x
2667  07e0 ae017a        	ldw	x,#L765
2668  07e3 89            	pushw	x
2669  07e4 96            	ldw	x,sp
2670  07e5 1c000c        	addw	x,#OFST-38
2671  07e8 cd0000        	call	_sprintf
2673  07eb 5b06          	addw	sp,#6
2674                     ; 748     strcat(localBuffer, temp1);
2676  07ed 96            	ldw	x,sp
2677  07ee 1c0006        	addw	x,#OFST-44
2678  07f1 89            	pushw	x
2679  07f2 96            	ldw	x,sp
2680  07f3 1c0017        	addw	x,#OFST-27
2681  07f6 cd0000        	call	_strcat
2683  07f9 85            	popw	x
2684                     ; 750     strcat(localBuffer, "\"}");
2686  07fa ae01aa        	ldw	x,#L344
2687  07fd 89            	pushw	x
2688  07fe 96            	ldw	x,sp
2689  07ff 1c0017        	addw	x,#OFST-27
2690  0802 cd0000        	call	_strcat
2692  0805 85            	popw	x
2693                     ; 751     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2695  0806 4b64          	push	#100
2696  0808 ae0000        	ldw	x,#_aunPushed_Data
2697  080b cd0000        	call	_vClearBuffer
2699  080e 84            	pop	a
2700                     ; 752     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2700                     ; 753                                                punGet_Event_Topic(),
2700                     ; 754                                                localBuffer);
2702  080f 96            	ldw	x,sp
2703  0810 1c0015        	addw	x,#OFST-29
2704  0813 89            	pushw	x
2705  0814 cd022b        	call	_punGet_Event_Topic
2707  0817 89            	pushw	x
2708  0818 ae0000        	ldw	x,#_aunPushed_Data
2709  081b cd0000        	call	_ulMQTT_Publish
2711  081e 5b04          	addw	sp,#4
2712  0820 b603          	ld	a,c_lreg+3
2713  0822 6b01          	ld	(OFST-49,sp),a
2715                     ; 755     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2717  0824 7b01          	ld	a,(OFST-49,sp)
2718  0826 88            	push	a
2719  0827 ae0000        	ldw	x,#_aunPushed_Data
2720  082a cd0000        	call	_bSendDataOverTCP
2722  082d 84            	pop	a
2723                     ; 756 }
2726  082e 5b32          	addw	sp,#50
2727  0830 81            	ret
2730                     	switch	.const
2731  010d               L347_localBuffer:
2732  010d 7b22          	dc.b	"{",34
2733  010f 4655454c22    	dc.b	"FUEL",34
2734  0114 3a22          	dc.b	":",34
2735  0116 313233343536  	dc.b	"123456.89",34
2736  0120 7d00          	dc.b	"}",0
2737  0122 000000000000  	ds.b	9
2738  012b               L547_temp1:
2739  012b 00            	dc.b	0
2740  012c 000000000000  	ds.b	9
2802                     ; 758 void vMevris_Send_FuelLevel()
2802                     ; 759 {
2803                     	switch	.text
2804  0831               _vMevris_Send_FuelLevel:
2806  0831 5229          	subw	sp,#41
2807       00000029      OFST:	set	41
2810                     ; 760     uint8_t localBuffer[30] = "{\"FUEL\":\"123456.89\"}";
2812  0833 96            	ldw	x,sp
2813  0834 1c000c        	addw	x,#OFST-29
2814  0837 90ae010d      	ldw	y,#L347_localBuffer
2815  083b a61e          	ld	a,#30
2816  083d cd0000        	call	c_xymvx
2818                     ; 761     uint8_t unSendDataLength = 0;
2820                     ; 762     uint8_t temp1[10] = "";
2822  0840 96            	ldw	x,sp
2823  0841 1c0002        	addw	x,#OFST-39
2824  0844 90ae012b      	ldw	y,#L547_temp1
2825  0848 a60a          	ld	a,#10
2826  084a cd0000        	call	c_xymvx
2828                     ; 763     vClearBuffer(localBuffer, 30);
2830  084d 4b1e          	push	#30
2831  084f 96            	ldw	x,sp
2832  0850 1c000d        	addw	x,#OFST-28
2833  0853 cd0000        	call	_vClearBuffer
2835  0856 84            	pop	a
2836                     ; 764     strcpy(localBuffer, "{\"FUEL\":\"");
2838  0857 96            	ldw	x,sp
2839  0858 1c000c        	addw	x,#OFST-29
2840  085b 90ae0135      	ldw	y,#L577
2841  085f               L27:
2842  085f 90f6          	ld	a,(y)
2843  0861 905c          	incw	y
2844  0863 f7            	ld	(x),a
2845  0864 5c            	incw	x
2846  0865 4d            	tnz	a
2847  0866 26f7          	jrne	L27
2848                     ; 765     sprintf(temp1, "%ld", Fuellevel);
2850  0868 ce0002        	ldw	x,_Fuellevel+2
2851  086b 89            	pushw	x
2852  086c ce0000        	ldw	x,_Fuellevel
2853  086f 89            	pushw	x
2854  0870 ae017a        	ldw	x,#L765
2855  0873 89            	pushw	x
2856  0874 96            	ldw	x,sp
2857  0875 1c0008        	addw	x,#OFST-33
2858  0878 cd0000        	call	_sprintf
2860  087b 5b06          	addw	sp,#6
2861                     ; 766     strcat(localBuffer, temp1);
2863  087d 96            	ldw	x,sp
2864  087e 1c0002        	addw	x,#OFST-39
2865  0881 89            	pushw	x
2866  0882 96            	ldw	x,sp
2867  0883 1c000e        	addw	x,#OFST-27
2868  0886 cd0000        	call	_strcat
2870  0889 85            	popw	x
2871                     ; 767     strcat(localBuffer, "\"}");
2873  088a ae01aa        	ldw	x,#L344
2874  088d 89            	pushw	x
2875  088e 96            	ldw	x,sp
2876  088f 1c000e        	addw	x,#OFST-27
2877  0892 cd0000        	call	_strcat
2879  0895 85            	popw	x
2880                     ; 768     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2882  0896 4b64          	push	#100
2883  0898 ae0000        	ldw	x,#_aunPushed_Data
2884  089b cd0000        	call	_vClearBuffer
2886  089e 84            	pop	a
2887                     ; 769     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2887                     ; 770                                                punGet_Event_Topic(),
2887                     ; 771                                                localBuffer);
2889  089f 96            	ldw	x,sp
2890  08a0 1c000c        	addw	x,#OFST-29
2891  08a3 89            	pushw	x
2892  08a4 cd022b        	call	_punGet_Event_Topic
2894  08a7 89            	pushw	x
2895  08a8 ae0000        	ldw	x,#_aunPushed_Data
2896  08ab cd0000        	call	_ulMQTT_Publish
2898  08ae 5b04          	addw	sp,#4
2899  08b0 b603          	ld	a,c_lreg+3
2900  08b2 6b01          	ld	(OFST-40,sp),a
2902                     ; 772     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2904  08b4 7b01          	ld	a,(OFST-40,sp)
2905  08b6 88            	push	a
2906  08b7 ae0000        	ldw	x,#_aunPushed_Data
2907  08ba cd0000        	call	_bSendDataOverTCP
2909  08bd 84            	pop	a
2910                     ; 773 }
2913  08be 5b29          	addw	sp,#41
2914  08c0 81            	ret
3001                     	xdef	_sendDataToCloud
3002                     	xref.b	_IMEIRecievedOKFlag
3003                     	xdef	_bCONNACK_Recieved
3004                     	xdef	_aunMQTT_Publish_Topic
3005                     	xdef	_aunMQTT_Subscribe_Topic
3006                     	xdef	_aunMQTT_ClientID
3007                     	xdef	_aunPushed_Data
3008                     	xdef	_vMevris_Send_Phase
3009                     	xdef	_vMevris_Send_FuelLevel
3010                     	xdef	_vMevris_Send_EngineTemp
3011                     	xdef	_vMevris_Send_RadiatorTemp
3012                     	xdef	_vMevris_Send_BatteryVolt
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
3038                     	xref	_ms_send_cmd
3039                     	xref.b	_aunIMEI
3040                     	xref	_sprintf
3041                     	xref	_strstr
3042                     	xref	_strcat
3043                     	switch	.const
3044  0135               L577:
3045  0135 7b22          	dc.b	"{",34
3046  0137 4655454c22    	dc.b	"FUEL",34
3047  013c 3a2200        	dc.b	":",34,0
3048  013f               L147:
3049  013f 7b22          	dc.b	"{",34
3050  0141 542d454e4749  	dc.b	"T-ENGINE",34
3051  014a 3a2200        	dc.b	":",34,0
3052  014d               L776:
3053  014d 42c80000      	dc.w	17096,0
3054  0151               L176:
3055  0151 7b22          	dc.b	"{",34
3056  0153 542d52414449  	dc.b	"T-RADIATOR",34
3057  015e 3a2200        	dc.b	":",34,0
3058  0161               L136:
3059  0161 7b22          	dc.b	"{",34
3060  0163 424154544552  	dc.b	"BATTERY",34
3061  016b 3a2200        	dc.b	":",34,0
3062  016e               L575:
3063  016e 222c224900    	dc.b	34,44,34,73,0
3064  0173               L375:
3065  0173 222c225600    	dc.b	34,44,34,86,0
3066  0178               L175:
3067  0178 2e00          	dc.b	".",0
3068  017a               L765:
3069  017a 256c6400      	dc.b	"%ld",0
3070  017e               L565:
3071  017e 223a2200      	dc.b	34,58,34,0
3072  0182               L365:
3073  0182 7b22          	dc.b	"{",34
3074  0184 5000          	dc.b	"P",0
3075  0186               L165:
3076  0186 256400        	dc.b	"%d",0
3077  0189               L774:
3078  0189 302e302e3030  	dc.b	"0.0.001",0
3079  0191               L574:
3080  0191 222c22485722  	dc.b	34,44,34,72,87,34
3081  0197 3a2200        	dc.b	":",34,0
3082  019a               L374:
3083  019a 322e342e3030  	dc.b	"2.4.001",0
3084  01a2               L174:
3085  01a2 7b22          	dc.b	"{",34
3086  01a4 465722        	dc.b	"FW",34
3087  01a7 3a2200        	dc.b	":",34,0
3088  01aa               L344:
3089  01aa 227d00        	dc.b	34,125,0
3090  01ad               L144:
3091  01ad 7b22          	dc.b	"{",34
3092  01af 494d454922    	dc.b	"IMEI",34
3093  01b4 3a2200        	dc.b	":",34,0
3094  01b7               L314:
3095  01b7 65767400      	dc.b	"evt",0
3096  01bb               L373:
3097  01bb 636d6400      	dc.b	"cmd",0
3098  01bf               L173:
3099  01bf 2f00          	dc.b	"/",0
3100  01c1               L763:
3101  01c1 73633200      	dc.b	"sc2",0
3102  01c5               L743:
3103  01c5 67656e00      	dc.b	"gen",0
3104  01c9               L533:
3105  01c9 61726520796f  	dc.b	"are you there",0
3106  01d7               L342:
3107  01d7 2b49504400    	dc.b	"+IPD",0
3108                     	xref.b	c_lreg
3109                     	xref.b	c_x
3129                     	xref	c_rtol
3130                     	xref	c_ftol
3131                     	xref	c_fmul
3132                     	xref	c_lumd
3133                     	xref	c_ludv
3134                     	xref	c_ltor
3135                     	xref	c_xymvx
3136                     	end
