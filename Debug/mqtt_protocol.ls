   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  71                     ; 319 void vMQTT_Connect ( uint8_t *punClientIdentifier )
  71                     ; 320 {   
  73                     	switch	.text
  74  0000               _vMQTT_Connect:
  76  0000 89            	pushw	x
  77  0001 5232          	subw	sp,#50
  78       00000032      OFST:	set	50
  81                     ; 322     ms_send_cmd(MQTT_CLOSE_CONNECTION, strlen((const char *)MQTT_CLOSE_CONNECTION));
  83  0003 4b0d          	push	#13
  84  0005 ae016e        	ldw	x,#L33
  85  0008 cd0000        	call	_ms_send_cmd
  87  000b 84            	pop	a
  88                     ; 323     delay_ms(500);
  90  000c ae01f4        	ldw	x,#500
  91  000f cd0000        	call	_delay_ms
  93                     ; 324     ms_send_cmd(MQTT_SET_VERSION, strlen((const char *)MQTT_SET_VERSION));
  95  0012 4b17          	push	#23
  96  0014 ae0156        	ldw	x,#L53
  97  0017 cd0000        	call	_ms_send_cmd
  99  001a 84            	pop	a
 100                     ; 325     delay_ms(200);
 102  001b ae00c8        	ldw	x,#200
 103  001e cd0000        	call	_delay_ms
 105                     ; 326     ms_send_cmd(MQTT_SET_PDP_CONTEXT, strlen((const char *)MQTT_SET_PDP_CONTEXT));
 107  0021 4b16          	push	#22
 108  0023 ae013f        	ldw	x,#L73
 109  0026 cd0000        	call	_ms_send_cmd
 111  0029 84            	pop	a
 112                     ; 327     delay_ms(200);
 114  002a ae00c8        	ldw	x,#200
 115  002d cd0000        	call	_delay_ms
 117                     ; 328     ms_send_cmd(MQTT_SET_TCP_PROTOCOL, strlen((const char *)MQTT_SET_TCP_PROTOCOL));
 119  0030 4b15          	push	#21
 120  0032 ae0129        	ldw	x,#L14
 121  0035 cd0000        	call	_ms_send_cmd
 123  0038 84            	pop	a
 124                     ; 329     delay_ms(200);
 126  0039 ae00c8        	ldw	x,#200
 127  003c cd0000        	call	_delay_ms
 129                     ; 330     ms_send_cmd(MQTT_SET_KEEPALIVE_TIME, strlen((const char *)MQTT_SET_KEEPALIVE_TIME));
 131  003f 4b1b          	push	#27
 132  0041 ae010d        	ldw	x,#L34
 133  0044 cd0000        	call	_ms_send_cmd
 135  0047 84            	pop	a
 136                     ; 331     delay_ms(200);
 138  0048 ae00c8        	ldw	x,#200
 139  004b cd0000        	call	_delay_ms
 141                     ; 332     ms_send_cmd(MQTT_SET_SESSION_TYPE, strlen((const char *)MQTT_SET_SESSION_TYPE));
 143  004e 4b17          	push	#23
 144  0050 ae00f5        	ldw	x,#L54
 145  0053 cd0000        	call	_ms_send_cmd
 147  0056 84            	pop	a
 148                     ; 333     delay_ms(200);
 150  0057 ae00c8        	ldw	x,#200
 151  005a cd0000        	call	_delay_ms
 153                     ; 334     ms_send_cmd(MQTT_SET_URC_RESPONSE_FORMAT, strlen((const char *)MQTT_SET_URC_RESPONSE_FORMAT));
 155  005d 4b1b          	push	#27
 156  005f ae00d9        	ldw	x,#L74
 157  0062 cd0000        	call	_ms_send_cmd
 159  0065 84            	pop	a
 160                     ; 335     delay_ms(200);
 162  0066 ae00c8        	ldw	x,#200
 163  0069 cd0000        	call	_delay_ms
 165                     ; 336     ms_send_cmd(MQTT_SET_DATA_VIEW_MODE, strlen((const char *)MQTT_SET_DATA_VIEW_MODE));
 167  006c 4b19          	push	#25
 168  006e ae00bf        	ldw	x,#L15
 169  0071 cd0000        	call	_ms_send_cmd
 171  0074 84            	pop	a
 172                     ; 337     delay_ms(200);
 174  0075 ae00c8        	ldw	x,#200
 175  0078 cd0000        	call	_delay_ms
 177                     ; 338     ms_send_cmd(MQTT_DISABLE_EDIT_TIMEOUT, strlen((const char *)MQTT_DISABLE_EDIT_TIMEOUT));
 179  007b 4b1e          	push	#30
 180  007d ae00a0        	ldw	x,#L35
 181  0080 cd0000        	call	_ms_send_cmd
 183  0083 84            	pop	a
 184                     ; 339     delay_ms(200);
 186  0084 ae00c8        	ldw	x,#200
 187  0087 cd0000        	call	_delay_ms
 189                     ; 340     ms_send_cmd(MQTT_SET_MODE_SEND_RECV, strlen((const char *)MQTT_SET_MODE_SEND_RECV));
 191  008a 4b1c          	push	#28
 192  008c ae0083        	ldw	x,#L55
 193  008f cd0000        	call	_ms_send_cmd
 195  0092 84            	pop	a
 196                     ; 341     delay_ms(200);
 198  0093 ae00c8        	ldw	x,#200
 199  0096 cd0000        	call	_delay_ms
 201                     ; 343     ms_send_cmd(MQTT_OPEN_CONNECTION, strlen((const char *)MQTT_OPEN_CONNECTION));
 203  0099 4b22          	push	#34
 204  009b ae0060        	ldw	x,#L75
 205  009e cd0000        	call	_ms_send_cmd
 207  00a1 84            	pop	a
 208                     ; 344     delay_ms(500);	
 210  00a2 ae01f4        	ldw	x,#500
 211  00a5 cd0000        	call	_delay_ms
 213                     ; 346 	vClearBuffer(temp, 50);
 215  00a8 4b32          	push	#50
 216  00aa 96            	ldw	x,sp
 217  00ab 1c0002        	addw	x,#OFST-48
 218  00ae cd0000        	call	_vClearBuffer
 220  00b1 84            	pop	a
 221                     ; 347     strcpy(temp, "AT+QMTCONN=1,\"");//"AT+QMTCONN=1,\"gen867400032743266\""
 223  00b2 96            	ldw	x,sp
 224  00b3 1c0001        	addw	x,#OFST-49
 225  00b6 90ae0051      	ldw	y,#L16
 226  00ba               L6:
 227  00ba 90f6          	ld	a,(y)
 228  00bc 905c          	incw	y
 229  00be f7            	ld	(x),a
 230  00bf 5c            	incw	x
 231  00c0 4d            	tnz	a
 232  00c1 26f7          	jrne	L6
 233                     ; 348 	strcat(temp,punClientIdentifier);
 235  00c3 1e33          	ldw	x,(OFST+1,sp)
 236  00c5 89            	pushw	x
 237  00c6 96            	ldw	x,sp
 238  00c7 1c0003        	addw	x,#OFST-47
 239  00ca cd0000        	call	_strcat
 241  00cd 85            	popw	x
 242                     ; 349 	strcat(temp,"\"");
 244  00ce ae004f        	ldw	x,#L36
 245  00d1 89            	pushw	x
 246  00d2 96            	ldw	x,sp
 247  00d3 1c0003        	addw	x,#OFST-47
 248  00d6 cd0000        	call	_strcat
 250  00d9 85            	popw	x
 251                     ; 350     ms_send_cmd(temp, strlen((const char *)temp));
 253  00da 96            	ldw	x,sp
 254  00db 1c0001        	addw	x,#OFST-49
 255  00de cd0000        	call	_strlen
 257  00e1 9f            	ld	a,xl
 258  00e2 88            	push	a
 259  00e3 96            	ldw	x,sp
 260  00e4 1c0002        	addw	x,#OFST-48
 261  00e7 cd0000        	call	_ms_send_cmd
 263  00ea 84            	pop	a
 264                     ; 351     delay_ms(200);	
 266  00eb ae00c8        	ldw	x,#200
 267  00ee cd0000        	call	_delay_ms
 269                     ; 352 }
 272  00f1 5b34          	addw	sp,#52
 273  00f3 81            	ret
 276                     .const:	section	.text
 277  0000               L56_temp1:
 278  0000 00            	dc.b	0
 279  0001 00000000      	ds.b	4
 358                     ; 422 void vMQTT_Publish ( uint8_t *punTopic, uint8_t *punMessage )
 358                     ; 423 {
 359                     	switch	.text
 360  00f4               _vMQTT_Publish:
 362  00f4 89            	pushw	x
 363  00f5 526a          	subw	sp,#106
 364       0000006a      OFST:	set	106
 367                     ; 425 	uint8_t unLength = 0;
 369                     ; 426 	uint8_t temp1[5] = "";
 371  00f7 96            	ldw	x,sp
 372  00f8 1c0002        	addw	x,#OFST-104
 373  00fb 90ae0000      	ldw	y,#L56_temp1
 374  00ff a605          	ld	a,#5
 375  0101 cd0000        	call	c_xymvx
 377                     ; 427 	vClearBuffer(temp, 100);
 379  0104 4b64          	push	#100
 380  0106 96            	ldw	x,sp
 381  0107 1c0008        	addw	x,#OFST-98
 382  010a cd0000        	call	_vClearBuffer
 384  010d 84            	pop	a
 385                     ; 428     strcpy(temp, "AT+QMTPUBEX=1,0,0,0,\"");	//AT+QMTPUBEX=1,0,0,0,"sc2/867400032743266/event",14
 387  010e 96            	ldw	x,sp
 388  010f 1c0007        	addw	x,#OFST-99
 389  0112 90ae0039      	ldw	y,#L521
 390  0116               L21:
 391  0116 90f6          	ld	a,(y)
 392  0118 905c          	incw	y
 393  011a f7            	ld	(x),a
 394  011b 5c            	incw	x
 395  011c 4d            	tnz	a
 396  011d 26f7          	jrne	L21
 397                     ; 429 	strcat(temp,punTopic);
 399  011f 1e6b          	ldw	x,(OFST+1,sp)
 400  0121 89            	pushw	x
 401  0122 96            	ldw	x,sp
 402  0123 1c0009        	addw	x,#OFST-97
 403  0126 cd0000        	call	_strcat
 405  0129 85            	popw	x
 406                     ; 430 	strcat(temp,"\"");
 408  012a ae004f        	ldw	x,#L36
 409  012d 89            	pushw	x
 410  012e 96            	ldw	x,sp
 411  012f 1c0009        	addw	x,#OFST-97
 412  0132 cd0000        	call	_strcat
 414  0135 85            	popw	x
 415                     ; 431 	unLength = strlen((const char *)punMessage);
 417  0136 1e6f          	ldw	x,(OFST+5,sp)
 418  0138 cd0000        	call	_strlen
 420  013b 01            	rrwa	x,a
 421  013c 6b01          	ld	(OFST-105,sp),a
 422  013e 02            	rlwa	x,a
 424                     ; 432 	vClearBuffer(temp1,5);
 426  013f 4b05          	push	#5
 427  0141 96            	ldw	x,sp
 428  0142 1c0003        	addw	x,#OFST-103
 429  0145 cd0000        	call	_vClearBuffer
 431  0148 84            	pop	a
 432                     ; 433     sprintf(temp1, "%d", (uint16_t)unLength);
 434  0149 7b01          	ld	a,(OFST-105,sp)
 435  014b 5f            	clrw	x
 436  014c 97            	ld	xl,a
 437  014d 89            	pushw	x
 438  014e ae0036        	ldw	x,#L721
 439  0151 89            	pushw	x
 440  0152 96            	ldw	x,sp
 441  0153 1c0006        	addw	x,#OFST-100
 442  0156 cd0000        	call	_sprintf
 444  0159 5b04          	addw	sp,#4
 445                     ; 434     strcat(temp,temp1);
 447  015b 96            	ldw	x,sp
 448  015c 1c0002        	addw	x,#OFST-104
 449  015f 89            	pushw	x
 450  0160 96            	ldw	x,sp
 451  0161 1c0009        	addw	x,#OFST-97
 452  0164 cd0000        	call	_strcat
 454  0167 85            	popw	x
 455                     ; 435     ms_send_cmd(temp, strlen((const char *)temp));
 457  0168 96            	ldw	x,sp
 458  0169 1c0007        	addw	x,#OFST-99
 459  016c cd0000        	call	_strlen
 461  016f 9f            	ld	a,xl
 462  0170 88            	push	a
 463  0171 96            	ldw	x,sp
 464  0172 1c0008        	addw	x,#OFST-98
 465  0175 cd0000        	call	_ms_send_cmd
 467  0178 84            	pop	a
 468                     ; 436 	delay_ms(10);
 470  0179 ae000a        	ldw	x,#10
 471  017c cd0000        	call	_delay_ms
 473                     ; 437 	ms_send_cmd(punMessage, unLength);
 475  017f 7b01          	ld	a,(OFST-105,sp)
 476  0181 88            	push	a
 477  0182 1e70          	ldw	x,(OFST+6,sp)
 478  0184 cd0000        	call	_ms_send_cmd
 480  0187 84            	pop	a
 481                     ; 438     delay_ms(200);	
 483  0188 ae00c8        	ldw	x,#200
 484  018b cd0000        	call	_delay_ms
 486                     ; 439 }
 489  018e 5b6c          	addw	sp,#108
 490  0190 81            	ret
 541                     ; 500 void vMQTT_Subscribe ( uint8_t *punTopic )
 541                     ; 501 {
 542                     	switch	.text
 543  0191               _vMQTT_Subscribe:
 545  0191 89            	pushw	x
 546  0192 5232          	subw	sp,#50
 547       00000032      OFST:	set	50
 550                     ; 503 	vClearBuffer(temp, 50);
 552  0194 4b32          	push	#50
 553  0196 96            	ldw	x,sp
 554  0197 1c0002        	addw	x,#OFST-48
 555  019a cd0000        	call	_vClearBuffer
 557  019d 84            	pop	a
 558                     ; 504     strcpy(temp, "AT+QMTSUB=1,1,\"");	//AT+QMTSUB=1,1,"sc2/867400032743266/command",0
 560  019e 96            	ldw	x,sp
 561  019f 1c0001        	addw	x,#OFST-49
 562  01a2 90ae0026      	ldw	y,#L351
 563  01a6               L61:
 564  01a6 90f6          	ld	a,(y)
 565  01a8 905c          	incw	y
 566  01aa f7            	ld	(x),a
 567  01ab 5c            	incw	x
 568  01ac 4d            	tnz	a
 569  01ad 26f7          	jrne	L61
 570                     ; 505 	strcat(temp,punTopic);
 572  01af 1e33          	ldw	x,(OFST+1,sp)
 573  01b1 89            	pushw	x
 574  01b2 96            	ldw	x,sp
 575  01b3 1c0003        	addw	x,#OFST-47
 576  01b6 cd0000        	call	_strcat
 578  01b9 85            	popw	x
 579                     ; 506 	strcat(temp,"\",0");
 581  01ba ae0022        	ldw	x,#L551
 582  01bd 89            	pushw	x
 583  01be 96            	ldw	x,sp
 584  01bf 1c0003        	addw	x,#OFST-47
 585  01c2 cd0000        	call	_strcat
 587  01c5 85            	popw	x
 588                     ; 507     ms_send_cmd(temp, strlen((const char *)temp));
 590  01c6 96            	ldw	x,sp
 591  01c7 1c0001        	addw	x,#OFST-49
 592  01ca cd0000        	call	_strlen
 594  01cd 9f            	ld	a,xl
 595  01ce 88            	push	a
 596  01cf 96            	ldw	x,sp
 597  01d0 1c0002        	addw	x,#OFST-48
 598  01d3 cd0000        	call	_ms_send_cmd
 600  01d6 84            	pop	a
 601                     ; 508     delay_ms(200);	
 603  01d7 ae00c8        	ldw	x,#200
 604  01da cd0000        	call	_delay_ms
 606                     ; 509 }
 609  01dd 5b34          	addw	sp,#52
 610  01df 81            	ret
 661                     ; 565 void vMQTT_UnSubscribe ( uint8_t *punTopic)
 661                     ; 566 {
 662                     	switch	.text
 663  01e0               _vMQTT_UnSubscribe:
 665  01e0 89            	pushw	x
 666  01e1 5232          	subw	sp,#50
 667       00000032      OFST:	set	50
 670                     ; 568 	vClearBuffer(temp, 50);
 672  01e3 4b32          	push	#50
 673  01e5 96            	ldw	x,sp
 674  01e6 1c0002        	addw	x,#OFST-48
 675  01e9 cd0000        	call	_vClearBuffer
 677  01ec 84            	pop	a
 678                     ; 569     strcpy(temp, "AT+QMTUNS=1,1,\"");	//AT+QMTUNS=1,1,"sc2/867400032743266/command"
 680  01ed 96            	ldw	x,sp
 681  01ee 1c0001        	addw	x,#OFST-49
 682  01f1 90ae0012      	ldw	y,#L102
 683  01f5               L22:
 684  01f5 90f6          	ld	a,(y)
 685  01f7 905c          	incw	y
 686  01f9 f7            	ld	(x),a
 687  01fa 5c            	incw	x
 688  01fb 4d            	tnz	a
 689  01fc 26f7          	jrne	L22
 690                     ; 570 	strcat(temp,punTopic);
 692  01fe 1e33          	ldw	x,(OFST+1,sp)
 693  0200 89            	pushw	x
 694  0201 96            	ldw	x,sp
 695  0202 1c0003        	addw	x,#OFST-47
 696  0205 cd0000        	call	_strcat
 698  0208 85            	popw	x
 699                     ; 571 	strcat(temp,"\"");
 701  0209 ae004f        	ldw	x,#L36
 702  020c 89            	pushw	x
 703  020d 96            	ldw	x,sp
 704  020e 1c0003        	addw	x,#OFST-47
 705  0211 cd0000        	call	_strcat
 707  0214 85            	popw	x
 708                     ; 572     ms_send_cmd(temp, strlen((const char *)temp));
 710  0215 96            	ldw	x,sp
 711  0216 1c0001        	addw	x,#OFST-49
 712  0219 cd0000        	call	_strlen
 714  021c 9f            	ld	a,xl
 715  021d 88            	push	a
 716  021e 96            	ldw	x,sp
 717  021f 1c0002        	addw	x,#OFST-48
 718  0222 cd0000        	call	_ms_send_cmd
 720  0225 84            	pop	a
 721                     ; 573     delay_ms(200);
 723  0226 ae00c8        	ldw	x,#200
 724  0229 cd0000        	call	_delay_ms
 726                     ; 574 }
 729  022c 5b34          	addw	sp,#52
 730  022e 81            	ret
 756                     ; 612 void vMQTT_Disconnect ( void )
 756                     ; 613 {
 757                     	switch	.text
 758  022f               _vMQTT_Disconnect:
 762                     ; 614     ms_send_cmd(MQTT_DISCONNECT_BROKER, strlen((const char *)MQTT_DISCONNECT_BROKER));
 764  022f 4b0c          	push	#12
 765  0231 ae0005        	ldw	x,#L312
 766  0234 cd0000        	call	_ms_send_cmd
 768  0237 84            	pop	a
 769                     ; 615     delay_ms(200);
 771  0238 ae00c8        	ldw	x,#200
 772  023b cd0000        	call	_delay_ms
 774                     ; 616 }
 777  023e 81            	ret
 790                     	xdef	_vMQTT_Disconnect
 791                     	xdef	_vMQTT_UnSubscribe
 792                     	xdef	_vMQTT_Subscribe
 793                     	xdef	_vMQTT_Publish
 794                     	xdef	_vMQTT_Connect
 795                     	xref	_ms_send_cmd
 796                     	xref	_vClearBuffer
 797                     	xref	_sprintf
 798                     	xref	_strlen
 799                     	xref	_strcat
 800                     	xref	_delay_ms
 801                     	switch	.const
 802  0005               L312:
 803  0005 41542b514d54  	dc.b	"AT+QMTDISC=1",0
 804  0012               L102:
 805  0012 41542b514d54  	dc.b	"AT+QMTUNS=1,1,",34,0
 806  0022               L551:
 807  0022 222c3000      	dc.b	34,44,48,0
 808  0026               L351:
 809  0026 41542b514d54  	dc.b	"AT+QMTSUB=1,1,",34,0
 810  0036               L721:
 811  0036 256400        	dc.b	"%d",0
 812  0039               L521:
 813  0039 41542b514d54  	dc.b	"AT+QMTPUBEX=1,0,0,"
 814  004b 302c2200      	dc.b	"0,",34,0
 815  004f               L36:
 816  004f 2200          	dc.b	34,0
 817  0051               L16:
 818  0051 41542b514d54  	dc.b	"AT+QMTCONN=1,",34,0
 819  0060               L75:
 820  0060 41542b514d54  	dc.b	"AT+QMTOPEN=1,",34
 821  006e 6d7174742e6d  	dc.b	"mqtt.mevris.io",34
 822  007d 2c3338383100  	dc.b	",3881",0
 823  0083               L55:
 824  0083 41542b514d54  	dc.b	"AT+QMTCFG=",34
 825  008e 64617461666f  	dc.b	"dataformat",34
 826  0099 2c312c302c30  	dc.b	",1,0,0",0
 827  00a0               L35:
 828  00a0 41542b514d54  	dc.b	"AT+QMTCFG=",34
 829  00ab 656469742f74  	dc.b	"edit/timeout",34
 830  00b8 2c312c302c31  	dc.b	",1,0,1",0
 831  00bf               L15:
 832  00bf 41542b514d54  	dc.b	"AT+QMTCFG=",34
 833  00ca 766965772f6d  	dc.b	"view/mode",34
 834  00d4 2c312c3000    	dc.b	",1,0",0
 835  00d9               L74:
 836  00d9 41542b514d54  	dc.b	"AT+QMTCFG=",34
 837  00e4 726563762f6d  	dc.b	"recv/mode",34
 838  00ee 2c312c302c31  	dc.b	",1,0,1",0
 839  00f5               L54:
 840  00f5 41542b514d54  	dc.b	"AT+QMTCFG=",34
 841  0100 73657373696f  	dc.b	"session",34
 842  0108 2c312c3100    	dc.b	",1,1",0
 843  010d               L34:
 844  010d 41542b514d54  	dc.b	"AT+QMTCFG=",34
 845  0118 6b656570616c  	dc.b	"keepalive",34
 846  0122 2c312c313230  	dc.b	",1,120",0
 847  0129               L14:
 848  0129 41542b514d54  	dc.b	"AT+QMTCFG=",34
 849  0134 73736c22      	dc.b	"ssl",34
 850  0138 2c312c302c30  	dc.b	",1,0,0",0
 851  013f               L73:
 852  013f 41542b514d54  	dc.b	"AT+QMTCFG=",34
 853  014a 706470636964  	dc.b	"pdpcid",34
 854  0151 2c312c3100    	dc.b	",1,1",0
 855  0156               L53:
 856  0156 41542b514d54  	dc.b	"AT+QMTCFG=",34
 857  0161 76657273696f  	dc.b	"version",34
 858  0169 2c312c3400    	dc.b	",1,4",0
 859  016e               L33:
 860  016e 41542b514d54  	dc.b	"AT+QMTCLOSE=1",0
 861                     	xref.b	c_x
 881                     	xref	c_xymvx
 882                     	end
