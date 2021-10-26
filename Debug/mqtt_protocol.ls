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
  81                     ; 322     ms_send_cmd(CHECK_REGISTRATION_STATUS_CS, strlen((const char *)CHECK_REGISTRATION_STATUS_CS));
  83  0003 4b08          	push	#8
  84  0005 ae0193        	ldw	x,#L33
  85  0008 cd0000        	call	_ms_send_cmd
  87  000b 84            	pop	a
  88                     ; 323     delay_ms(500);
  90  000c ae01f4        	ldw	x,#500
  91  000f cd0000        	call	_delay_ms
  93                     ; 324     ms_send_cmd(CHECK_REGISTRATION_STATUS_PS, strlen((const char *)CHECK_REGISTRATION_STATUS_PS));
  95  0012 4b09          	push	#9
  96  0014 ae0189        	ldw	x,#L53
  97  0017 cd0000        	call	_ms_send_cmd
  99  001a 84            	pop	a
 100                     ; 325     delay_ms(500);
 102  001b ae01f4        	ldw	x,#500
 103  001e cd0000        	call	_delay_ms
 105                     ; 326     ms_send_cmd(CHECK_REGISTRATION_STATUS_EPS, strlen((const char *)CHECK_REGISTRATION_STATUS_EPS));
 107  0021 4b09          	push	#9
 108  0023 ae017f        	ldw	x,#L73
 109  0026 cd0000        	call	_ms_send_cmd
 111  0029 84            	pop	a
 112                     ; 327     delay_ms(500);
 114  002a ae01f4        	ldw	x,#500
 115  002d cd0000        	call	_delay_ms
 117                     ; 328     ms_send_cmd(MQTT_CLOSE_CONNECTION, strlen((const char *)MQTT_CLOSE_CONNECTION));
 119  0030 4b0d          	push	#13
 120  0032 ae0171        	ldw	x,#L14
 121  0035 cd0000        	call	_ms_send_cmd
 123  0038 84            	pop	a
 124                     ; 329     delay_ms(500);
 126  0039 ae01f4        	ldw	x,#500
 127  003c cd0000        	call	_delay_ms
 129                     ; 330     ms_send_cmd(MQTT_SET_VERSION, strlen((const char *)MQTT_SET_VERSION));
 131  003f 4b17          	push	#23
 132  0041 ae0159        	ldw	x,#L34
 133  0044 cd0000        	call	_ms_send_cmd
 135  0047 84            	pop	a
 136                     ; 331     delay_ms(200);
 138  0048 ae00c8        	ldw	x,#200
 139  004b cd0000        	call	_delay_ms
 141                     ; 332     ms_send_cmd(MQTT_SET_PDP_CONTEXT, strlen((const char *)MQTT_SET_PDP_CONTEXT));
 143  004e 4b16          	push	#22
 144  0050 ae0142        	ldw	x,#L54
 145  0053 cd0000        	call	_ms_send_cmd
 147  0056 84            	pop	a
 148                     ; 333     delay_ms(200);
 150  0057 ae00c8        	ldw	x,#200
 151  005a cd0000        	call	_delay_ms
 153                     ; 334     ms_send_cmd(MQTT_SET_TCP_PROTOCOL, strlen((const char *)MQTT_SET_TCP_PROTOCOL));
 155  005d 4b15          	push	#21
 156  005f ae012c        	ldw	x,#L74
 157  0062 cd0000        	call	_ms_send_cmd
 159  0065 84            	pop	a
 160                     ; 335     delay_ms(200);
 162  0066 ae00c8        	ldw	x,#200
 163  0069 cd0000        	call	_delay_ms
 165                     ; 336     ms_send_cmd(MQTT_SET_KEEPALIVE_TIME, strlen((const char *)MQTT_SET_KEEPALIVE_TIME));
 167  006c 4b1b          	push	#27
 168  006e ae0110        	ldw	x,#L15
 169  0071 cd0000        	call	_ms_send_cmd
 171  0074 84            	pop	a
 172                     ; 337     delay_ms(200);
 174  0075 ae00c8        	ldw	x,#200
 175  0078 cd0000        	call	_delay_ms
 177                     ; 338     ms_send_cmd(MQTT_SET_SESSION_TYPE, strlen((const char *)MQTT_SET_SESSION_TYPE));
 179  007b 4b17          	push	#23
 180  007d ae00f8        	ldw	x,#L35
 181  0080 cd0000        	call	_ms_send_cmd
 183  0083 84            	pop	a
 184                     ; 339     delay_ms(200);
 186  0084 ae00c8        	ldw	x,#200
 187  0087 cd0000        	call	_delay_ms
 189                     ; 340     ms_send_cmd(MQTT_SET_URC_RESPONSE_FORMAT, strlen((const char *)MQTT_SET_URC_RESPONSE_FORMAT));
 191  008a 4b1b          	push	#27
 192  008c ae00dc        	ldw	x,#L55
 193  008f cd0000        	call	_ms_send_cmd
 195  0092 84            	pop	a
 196                     ; 341     delay_ms(200);
 198  0093 ae00c8        	ldw	x,#200
 199  0096 cd0000        	call	_delay_ms
 201                     ; 342     ms_send_cmd(MQTT_SET_DATA_VIEW_MODE, strlen((const char *)MQTT_SET_DATA_VIEW_MODE));
 203  0099 4b19          	push	#25
 204  009b ae00c2        	ldw	x,#L75
 205  009e cd0000        	call	_ms_send_cmd
 207  00a1 84            	pop	a
 208                     ; 343     delay_ms(200);
 210  00a2 ae00c8        	ldw	x,#200
 211  00a5 cd0000        	call	_delay_ms
 213                     ; 344     ms_send_cmd(MQTT_DISABLE_EDIT_TIMEOUT, strlen((const char *)MQTT_DISABLE_EDIT_TIMEOUT));
 215  00a8 4b1e          	push	#30
 216  00aa ae00a3        	ldw	x,#L16
 217  00ad cd0000        	call	_ms_send_cmd
 219  00b0 84            	pop	a
 220                     ; 345     delay_ms(200);
 222  00b1 ae00c8        	ldw	x,#200
 223  00b4 cd0000        	call	_delay_ms
 225                     ; 346     ms_send_cmd(MQTT_SET_MODE_SEND_RECV, strlen((const char *)MQTT_SET_MODE_SEND_RECV));
 227  00b7 4b1c          	push	#28
 228  00b9 ae0086        	ldw	x,#L36
 229  00bc cd0000        	call	_ms_send_cmd
 231  00bf 84            	pop	a
 232                     ; 347     delay_ms(200);
 234  00c0 ae00c8        	ldw	x,#200
 235  00c3 cd0000        	call	_delay_ms
 237                     ; 349     ms_send_cmd(MQTT_OPEN_CONNECTION, strlen((const char *)MQTT_OPEN_CONNECTION));
 239  00c6 4b22          	push	#34
 240  00c8 ae0063        	ldw	x,#L56
 241  00cb cd0000        	call	_ms_send_cmd
 243  00ce 84            	pop	a
 244                     ; 350     delay_ms(500);	
 246  00cf ae01f4        	ldw	x,#500
 247  00d2 cd0000        	call	_delay_ms
 249                     ; 352 	vClearBuffer(temp, 50);
 251  00d5 4b32          	push	#50
 252  00d7 96            	ldw	x,sp
 253  00d8 1c0002        	addw	x,#OFST-48
 254  00db cd0000        	call	_vClearBuffer
 256  00de 84            	pop	a
 257                     ; 353     strcpy(temp, "AT+QMTCONN=1,\"");//"AT+QMTCONN=1,\"gen867400032743266\""
 259  00df 96            	ldw	x,sp
 260  00e0 1c0001        	addw	x,#OFST-49
 261  00e3 90ae0054      	ldw	y,#L76
 262  00e7               L6:
 263  00e7 90f6          	ld	a,(y)
 264  00e9 905c          	incw	y
 265  00eb f7            	ld	(x),a
 266  00ec 5c            	incw	x
 267  00ed 4d            	tnz	a
 268  00ee 26f7          	jrne	L6
 269                     ; 354 	strcat(temp,punClientIdentifier);
 271  00f0 1e33          	ldw	x,(OFST+1,sp)
 272  00f2 89            	pushw	x
 273  00f3 96            	ldw	x,sp
 274  00f4 1c0003        	addw	x,#OFST-47
 275  00f7 cd0000        	call	_strcat
 277  00fa 85            	popw	x
 278                     ; 355 	strcat(temp,"\"");
 280  00fb ae0052        	ldw	x,#L17
 281  00fe 89            	pushw	x
 282  00ff 96            	ldw	x,sp
 283  0100 1c0003        	addw	x,#OFST-47
 284  0103 cd0000        	call	_strcat
 286  0106 85            	popw	x
 287                     ; 356     ms_send_cmd(temp, strlen((const char *)temp));
 289  0107 96            	ldw	x,sp
 290  0108 1c0001        	addw	x,#OFST-49
 291  010b cd0000        	call	_strlen
 293  010e 9f            	ld	a,xl
 294  010f 88            	push	a
 295  0110 96            	ldw	x,sp
 296  0111 1c0002        	addw	x,#OFST-48
 297  0114 cd0000        	call	_ms_send_cmd
 299  0117 84            	pop	a
 300                     ; 357     delay_ms(200);	
 302  0118 ae00c8        	ldw	x,#200
 303  011b cd0000        	call	_delay_ms
 305                     ; 358 }
 308  011e 5b34          	addw	sp,#52
 309  0120 81            	ret
 312                     .const:	section	.text
 313  0000               L37_temp1:
 314  0000 00            	dc.b	0
 315  0001 00000000      	ds.b	4
 394                     ; 428 void vMQTT_Publish ( uint8_t *punTopic, uint8_t *punMessage )
 394                     ; 429 {
 395                     	switch	.text
 396  0121               _vMQTT_Publish:
 398  0121 89            	pushw	x
 399  0122 526a          	subw	sp,#106
 400       0000006a      OFST:	set	106
 403                     ; 431 	uint8_t unLength = 0;
 405                     ; 432 	uint8_t temp1[5] = "";
 407  0124 96            	ldw	x,sp
 408  0125 1c0002        	addw	x,#OFST-104
 409  0128 90ae0000      	ldw	y,#L37_temp1
 410  012c a605          	ld	a,#5
 411  012e cd0000        	call	c_xymvx
 413                     ; 433 	vClearBuffer(temp, 100);
 415  0131 4b64          	push	#100
 416  0133 96            	ldw	x,sp
 417  0134 1c0008        	addw	x,#OFST-98
 418  0137 cd0000        	call	_vClearBuffer
 420  013a 84            	pop	a
 421                     ; 434     strcpy(temp, "AT+QMTPUBEX=1,0,0,0,\"");	//AT+QMTPUBEX=1,0,0,0,"sc2/867400032743266/event",14
 423  013b 96            	ldw	x,sp
 424  013c 1c0007        	addw	x,#OFST-99
 425  013f 90ae003c      	ldw	y,#L331
 426  0143               L21:
 427  0143 90f6          	ld	a,(y)
 428  0145 905c          	incw	y
 429  0147 f7            	ld	(x),a
 430  0148 5c            	incw	x
 431  0149 4d            	tnz	a
 432  014a 26f7          	jrne	L21
 433                     ; 435 	strcat(temp,punTopic);
 435  014c 1e6b          	ldw	x,(OFST+1,sp)
 436  014e 89            	pushw	x
 437  014f 96            	ldw	x,sp
 438  0150 1c0009        	addw	x,#OFST-97
 439  0153 cd0000        	call	_strcat
 441  0156 85            	popw	x
 442                     ; 436 	strcat(temp,"\",");
 444  0157 ae0039        	ldw	x,#L531
 445  015a 89            	pushw	x
 446  015b 96            	ldw	x,sp
 447  015c 1c0009        	addw	x,#OFST-97
 448  015f cd0000        	call	_strcat
 450  0162 85            	popw	x
 451                     ; 437 	unLength = strlen((const char *)punMessage);
 453  0163 1e6f          	ldw	x,(OFST+5,sp)
 454  0165 cd0000        	call	_strlen
 456  0168 01            	rrwa	x,a
 457  0169 6b01          	ld	(OFST-105,sp),a
 458  016b 02            	rlwa	x,a
 460                     ; 438 	vClearBuffer(temp1,5);
 462  016c 4b05          	push	#5
 463  016e 96            	ldw	x,sp
 464  016f 1c0003        	addw	x,#OFST-103
 465  0172 cd0000        	call	_vClearBuffer
 467  0175 84            	pop	a
 468                     ; 439     sprintf(temp1, "%d", (uint16_t)unLength);
 470  0176 7b01          	ld	a,(OFST-105,sp)
 471  0178 5f            	clrw	x
 472  0179 97            	ld	xl,a
 473  017a 89            	pushw	x
 474  017b ae0036        	ldw	x,#L731
 475  017e 89            	pushw	x
 476  017f 96            	ldw	x,sp
 477  0180 1c0006        	addw	x,#OFST-100
 478  0183 cd0000        	call	_sprintf
 480  0186 5b04          	addw	sp,#4
 481                     ; 440     strcat(temp,temp1);
 483  0188 96            	ldw	x,sp
 484  0189 1c0002        	addw	x,#OFST-104
 485  018c 89            	pushw	x
 486  018d 96            	ldw	x,sp
 487  018e 1c0009        	addw	x,#OFST-97
 488  0191 cd0000        	call	_strcat
 490  0194 85            	popw	x
 491                     ; 441     ms_send_cmd(temp, strlen((const char *)temp));
 493  0195 96            	ldw	x,sp
 494  0196 1c0007        	addw	x,#OFST-99
 495  0199 cd0000        	call	_strlen
 497  019c 9f            	ld	a,xl
 498  019d 88            	push	a
 499  019e 96            	ldw	x,sp
 500  019f 1c0008        	addw	x,#OFST-98
 501  01a2 cd0000        	call	_ms_send_cmd
 503  01a5 84            	pop	a
 504                     ; 442 	delay_ms(10);
 506  01a6 ae000a        	ldw	x,#10
 507  01a9 cd0000        	call	_delay_ms
 509                     ; 443 	ms_send_cmd(punMessage, unLength);
 511  01ac 7b01          	ld	a,(OFST-105,sp)
 512  01ae 88            	push	a
 513  01af 1e70          	ldw	x,(OFST+6,sp)
 514  01b1 cd0000        	call	_ms_send_cmd
 516  01b4 84            	pop	a
 517                     ; 444     delay_ms(200);	
 519  01b5 ae00c8        	ldw	x,#200
 520  01b8 cd0000        	call	_delay_ms
 522                     ; 445 }
 525  01bb 5b6c          	addw	sp,#108
 526  01bd 81            	ret
 577                     ; 506 void vMQTT_Subscribe ( uint8_t *punTopic )
 577                     ; 507 {
 578                     	switch	.text
 579  01be               _vMQTT_Subscribe:
 581  01be 89            	pushw	x
 582  01bf 5232          	subw	sp,#50
 583       00000032      OFST:	set	50
 586                     ; 509 	vClearBuffer(temp, 50);
 588  01c1 4b32          	push	#50
 589  01c3 96            	ldw	x,sp
 590  01c4 1c0002        	addw	x,#OFST-48
 591  01c7 cd0000        	call	_vClearBuffer
 593  01ca 84            	pop	a
 594                     ; 510     strcpy(temp, "AT+QMTSUB=1,1,\"");	//AT+QMTSUB=1,1,"sc2/867400032743266/command",0
 596  01cb 96            	ldw	x,sp
 597  01cc 1c0001        	addw	x,#OFST-49
 598  01cf 90ae0026      	ldw	y,#L361
 599  01d3               L61:
 600  01d3 90f6          	ld	a,(y)
 601  01d5 905c          	incw	y
 602  01d7 f7            	ld	(x),a
 603  01d8 5c            	incw	x
 604  01d9 4d            	tnz	a
 605  01da 26f7          	jrne	L61
 606                     ; 511 	strcat(temp,punTopic);
 608  01dc 1e33          	ldw	x,(OFST+1,sp)
 609  01de 89            	pushw	x
 610  01df 96            	ldw	x,sp
 611  01e0 1c0003        	addw	x,#OFST-47
 612  01e3 cd0000        	call	_strcat
 614  01e6 85            	popw	x
 615                     ; 512 	strcat(temp,"\",0");
 617  01e7 ae0022        	ldw	x,#L561
 618  01ea 89            	pushw	x
 619  01eb 96            	ldw	x,sp
 620  01ec 1c0003        	addw	x,#OFST-47
 621  01ef cd0000        	call	_strcat
 623  01f2 85            	popw	x
 624                     ; 513     ms_send_cmd(temp, strlen((const char *)temp));
 626  01f3 96            	ldw	x,sp
 627  01f4 1c0001        	addw	x,#OFST-49
 628  01f7 cd0000        	call	_strlen
 630  01fa 9f            	ld	a,xl
 631  01fb 88            	push	a
 632  01fc 96            	ldw	x,sp
 633  01fd 1c0002        	addw	x,#OFST-48
 634  0200 cd0000        	call	_ms_send_cmd
 636  0203 84            	pop	a
 637                     ; 514     delay_ms(200);	
 639  0204 ae00c8        	ldw	x,#200
 640  0207 cd0000        	call	_delay_ms
 642                     ; 515 }
 645  020a 5b34          	addw	sp,#52
 646  020c 81            	ret
 697                     ; 571 void vMQTT_UnSubscribe ( uint8_t *punTopic)
 697                     ; 572 {
 698                     	switch	.text
 699  020d               _vMQTT_UnSubscribe:
 701  020d 89            	pushw	x
 702  020e 5232          	subw	sp,#50
 703       00000032      OFST:	set	50
 706                     ; 574 	vClearBuffer(temp, 50);
 708  0210 4b32          	push	#50
 709  0212 96            	ldw	x,sp
 710  0213 1c0002        	addw	x,#OFST-48
 711  0216 cd0000        	call	_vClearBuffer
 713  0219 84            	pop	a
 714                     ; 575     strcpy(temp, "AT+QMTUNS=1,1,\"");	//AT+QMTUNS=1,1,"sc2/867400032743266/command"
 716  021a 96            	ldw	x,sp
 717  021b 1c0001        	addw	x,#OFST-49
 718  021e 90ae0012      	ldw	y,#L112
 719  0222               L22:
 720  0222 90f6          	ld	a,(y)
 721  0224 905c          	incw	y
 722  0226 f7            	ld	(x),a
 723  0227 5c            	incw	x
 724  0228 4d            	tnz	a
 725  0229 26f7          	jrne	L22
 726                     ; 576 	strcat(temp,punTopic);
 728  022b 1e33          	ldw	x,(OFST+1,sp)
 729  022d 89            	pushw	x
 730  022e 96            	ldw	x,sp
 731  022f 1c0003        	addw	x,#OFST-47
 732  0232 cd0000        	call	_strcat
 734  0235 85            	popw	x
 735                     ; 577 	strcat(temp,"\"");
 737  0236 ae0052        	ldw	x,#L17
 738  0239 89            	pushw	x
 739  023a 96            	ldw	x,sp
 740  023b 1c0003        	addw	x,#OFST-47
 741  023e cd0000        	call	_strcat
 743  0241 85            	popw	x
 744                     ; 578     ms_send_cmd(temp, strlen((const char *)temp));
 746  0242 96            	ldw	x,sp
 747  0243 1c0001        	addw	x,#OFST-49
 748  0246 cd0000        	call	_strlen
 750  0249 9f            	ld	a,xl
 751  024a 88            	push	a
 752  024b 96            	ldw	x,sp
 753  024c 1c0002        	addw	x,#OFST-48
 754  024f cd0000        	call	_ms_send_cmd
 756  0252 84            	pop	a
 757                     ; 579     delay_ms(200);
 759  0253 ae00c8        	ldw	x,#200
 760  0256 cd0000        	call	_delay_ms
 762                     ; 580 }
 765  0259 5b34          	addw	sp,#52
 766  025b 81            	ret
 792                     ; 618 void vMQTT_Disconnect ( void )
 792                     ; 619 {
 793                     	switch	.text
 794  025c               _vMQTT_Disconnect:
 798                     ; 620     ms_send_cmd(MQTT_DISCONNECT_BROKER, strlen((const char *)MQTT_DISCONNECT_BROKER));
 800  025c 4b0c          	push	#12
 801  025e ae0005        	ldw	x,#L322
 802  0261 cd0000        	call	_ms_send_cmd
 804  0264 84            	pop	a
 805                     ; 621     delay_ms(200);
 807  0265 ae00c8        	ldw	x,#200
 808  0268 cd0000        	call	_delay_ms
 810                     ; 622 }
 813  026b 81            	ret
 826                     	xdef	_vMQTT_Disconnect
 827                     	xdef	_vMQTT_UnSubscribe
 828                     	xdef	_vMQTT_Subscribe
 829                     	xdef	_vMQTT_Publish
 830                     	xdef	_vMQTT_Connect
 831                     	xref	_ms_send_cmd
 832                     	xref	_vClearBuffer
 833                     	xref	_sprintf
 834                     	xref	_strlen
 835                     	xref	_strcat
 836                     	xref	_delay_ms
 837                     	switch	.const
 838  0005               L322:
 839  0005 41542b514d54  	dc.b	"AT+QMTDISC=1",0
 840  0012               L112:
 841  0012 41542b514d54  	dc.b	"AT+QMTUNS=1,1,",34,0
 842  0022               L561:
 843  0022 222c3000      	dc.b	34,44,48,0
 844  0026               L361:
 845  0026 41542b514d54  	dc.b	"AT+QMTSUB=1,1,",34,0
 846  0036               L731:
 847  0036 256400        	dc.b	"%d",0
 848  0039               L531:
 849  0039 222c00        	dc.b	34,44,0
 850  003c               L331:
 851  003c 41542b514d54  	dc.b	"AT+QMTPUBEX=1,0,0,"
 852  004e 302c2200      	dc.b	"0,",34,0
 853  0052               L17:
 854  0052 2200          	dc.b	34,0
 855  0054               L76:
 856  0054 41542b514d54  	dc.b	"AT+QMTCONN=1,",34,0
 857  0063               L56:
 858  0063 41542b514d54  	dc.b	"AT+QMTOPEN=1,",34
 859  0071 6d7174742e6d  	dc.b	"mqtt.mevris.io",34
 860  0080 2c3338383100  	dc.b	",3881",0
 861  0086               L36:
 862  0086 41542b514d54  	dc.b	"AT+QMTCFG=",34
 863  0091 64617461666f  	dc.b	"dataformat",34
 864  009c 2c312c302c30  	dc.b	",1,0,0",0
 865  00a3               L16:
 866  00a3 41542b514d54  	dc.b	"AT+QMTCFG=",34
 867  00ae 656469742f74  	dc.b	"edit/timeout",34
 868  00bb 2c312c302c31  	dc.b	",1,0,1",0
 869  00c2               L75:
 870  00c2 41542b514d54  	dc.b	"AT+QMTCFG=",34
 871  00cd 766965772f6d  	dc.b	"view/mode",34
 872  00d7 2c312c3000    	dc.b	",1,0",0
 873  00dc               L55:
 874  00dc 41542b514d54  	dc.b	"AT+QMTCFG=",34
 875  00e7 726563762f6d  	dc.b	"recv/mode",34
 876  00f1 2c312c302c31  	dc.b	",1,0,1",0
 877  00f8               L35:
 878  00f8 41542b514d54  	dc.b	"AT+QMTCFG=",34
 879  0103 73657373696f  	dc.b	"session",34
 880  010b 2c312c3100    	dc.b	",1,1",0
 881  0110               L15:
 882  0110 41542b514d54  	dc.b	"AT+QMTCFG=",34
 883  011b 6b656570616c  	dc.b	"keepalive",34
 884  0125 2c312c313230  	dc.b	",1,120",0
 885  012c               L74:
 886  012c 41542b514d54  	dc.b	"AT+QMTCFG=",34
 887  0137 73736c22      	dc.b	"ssl",34
 888  013b 2c312c302c30  	dc.b	",1,0,0",0
 889  0142               L54:
 890  0142 41542b514d54  	dc.b	"AT+QMTCFG=",34
 891  014d 706470636964  	dc.b	"pdpcid",34
 892  0154 2c312c3100    	dc.b	",1,1",0
 893  0159               L34:
 894  0159 41542b514d54  	dc.b	"AT+QMTCFG=",34
 895  0164 76657273696f  	dc.b	"version",34
 896  016c 2c312c3400    	dc.b	",1,4",0
 897  0171               L14:
 898  0171 41542b514d54  	dc.b	"AT+QMTCLOSE=1",0
 899  017f               L73:
 900  017f 41542b434552  	dc.b	"AT+CEREG?",0
 901  0189               L53:
 902  0189 41542b434752  	dc.b	"AT+CGREG?",0
 903  0193               L33:
 904  0193 41542b435245  	dc.b	"AT+CREG?",0
 905                     	xref.b	c_x
 925                     	xref	c_xymvx
 926                     	end
