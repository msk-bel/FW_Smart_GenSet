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
  81                     ; 322 	   ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  83  0003 4b04          	push	#4
  84  0005 ae019c        	ldw	x,#L33
  85  0008 cd0000        	call	_ms_send_cmd
  87  000b 84            	pop	a
  88                     ; 323     delay_ms(200);
  90  000c ae00c8        	ldw	x,#200
  91  000f cd0000        	call	_delay_ms
  93                     ; 324     ms_send_cmd(CHECK_REGISTRATION_STATUS_CS, strlen((const char *)CHECK_REGISTRATION_STATUS_CS));
  95  0012 4b08          	push	#8
  96  0014 ae0193        	ldw	x,#L53
  97  0017 cd0000        	call	_ms_send_cmd
  99  001a 84            	pop	a
 100                     ; 325     delay_ms(500);
 102  001b ae01f4        	ldw	x,#500
 103  001e cd0000        	call	_delay_ms
 105                     ; 326     ms_send_cmd(CHECK_REGISTRATION_STATUS_PS, strlen((const char *)CHECK_REGISTRATION_STATUS_PS));
 107  0021 4b09          	push	#9
 108  0023 ae0189        	ldw	x,#L73
 109  0026 cd0000        	call	_ms_send_cmd
 111  0029 84            	pop	a
 112                     ; 327     delay_ms(500);
 114  002a ae01f4        	ldw	x,#500
 115  002d cd0000        	call	_delay_ms
 117                     ; 328     ms_send_cmd(CHECK_REGISTRATION_STATUS_EPS, strlen((const char *)CHECK_REGISTRATION_STATUS_EPS));
 119  0030 4b09          	push	#9
 120  0032 ae017f        	ldw	x,#L14
 121  0035 cd0000        	call	_ms_send_cmd
 123  0038 84            	pop	a
 124                     ; 329     delay_ms(500);
 126  0039 ae01f4        	ldw	x,#500
 127  003c cd0000        	call	_delay_ms
 129                     ; 330     ms_send_cmd(MQTT_CLOSE_CONNECTION, strlen((const char *)MQTT_CLOSE_CONNECTION));
 131  003f 4b0d          	push	#13
 132  0041 ae0171        	ldw	x,#L34
 133  0044 cd0000        	call	_ms_send_cmd
 135  0047 84            	pop	a
 136                     ; 331     delay_ms(500);
 138  0048 ae01f4        	ldw	x,#500
 139  004b cd0000        	call	_delay_ms
 141                     ; 332     ms_send_cmd(MQTT_SET_VERSION, strlen((const char *)MQTT_SET_VERSION));
 143  004e 4b17          	push	#23
 144  0050 ae0159        	ldw	x,#L54
 145  0053 cd0000        	call	_ms_send_cmd
 147  0056 84            	pop	a
 148                     ; 333     delay_ms(200);
 150  0057 ae00c8        	ldw	x,#200
 151  005a cd0000        	call	_delay_ms
 153                     ; 334     ms_send_cmd(MQTT_SET_PDP_CONTEXT, strlen((const char *)MQTT_SET_PDP_CONTEXT));
 155  005d 4b16          	push	#22
 156  005f ae0142        	ldw	x,#L74
 157  0062 cd0000        	call	_ms_send_cmd
 159  0065 84            	pop	a
 160                     ; 335     delay_ms(200);
 162  0066 ae00c8        	ldw	x,#200
 163  0069 cd0000        	call	_delay_ms
 165                     ; 336     ms_send_cmd(MQTT_SET_TCP_PROTOCOL, strlen((const char *)MQTT_SET_TCP_PROTOCOL));
 167  006c 4b15          	push	#21
 168  006e ae012c        	ldw	x,#L15
 169  0071 cd0000        	call	_ms_send_cmd
 171  0074 84            	pop	a
 172                     ; 337     delay_ms(200);
 174  0075 ae00c8        	ldw	x,#200
 175  0078 cd0000        	call	_delay_ms
 177                     ; 338     ms_send_cmd(MQTT_SET_KEEPALIVE_TIME, strlen((const char *)MQTT_SET_KEEPALIVE_TIME));
 179  007b 4b1b          	push	#27
 180  007d ae0110        	ldw	x,#L35
 181  0080 cd0000        	call	_ms_send_cmd
 183  0083 84            	pop	a
 184                     ; 339     delay_ms(200);
 186  0084 ae00c8        	ldw	x,#200
 187  0087 cd0000        	call	_delay_ms
 189                     ; 340     ms_send_cmd(MQTT_SET_SESSION_TYPE, strlen((const char *)MQTT_SET_SESSION_TYPE));
 191  008a 4b17          	push	#23
 192  008c ae00f8        	ldw	x,#L55
 193  008f cd0000        	call	_ms_send_cmd
 195  0092 84            	pop	a
 196                     ; 341     delay_ms(200);
 198  0093 ae00c8        	ldw	x,#200
 199  0096 cd0000        	call	_delay_ms
 201                     ; 342     ms_send_cmd(MQTT_SET_URC_RESPONSE_FORMAT, strlen((const char *)MQTT_SET_URC_RESPONSE_FORMAT));
 203  0099 4b1b          	push	#27
 204  009b ae00dc        	ldw	x,#L75
 205  009e cd0000        	call	_ms_send_cmd
 207  00a1 84            	pop	a
 208                     ; 343     delay_ms(200);
 210  00a2 ae00c8        	ldw	x,#200
 211  00a5 cd0000        	call	_delay_ms
 213                     ; 344     ms_send_cmd(MQTT_SET_DATA_VIEW_MODE, strlen((const char *)MQTT_SET_DATA_VIEW_MODE));
 215  00a8 4b19          	push	#25
 216  00aa ae00c2        	ldw	x,#L16
 217  00ad cd0000        	call	_ms_send_cmd
 219  00b0 84            	pop	a
 220                     ; 345     delay_ms(200);
 222  00b1 ae00c8        	ldw	x,#200
 223  00b4 cd0000        	call	_delay_ms
 225                     ; 346     ms_send_cmd(MQTT_DISABLE_EDIT_TIMEOUT, strlen((const char *)MQTT_DISABLE_EDIT_TIMEOUT));
 227  00b7 4b1e          	push	#30
 228  00b9 ae00a3        	ldw	x,#L36
 229  00bc cd0000        	call	_ms_send_cmd
 231  00bf 84            	pop	a
 232                     ; 347     delay_ms(200);
 234  00c0 ae00c8        	ldw	x,#200
 235  00c3 cd0000        	call	_delay_ms
 237                     ; 348     ms_send_cmd(MQTT_SET_MODE_SEND_RECV, strlen((const char *)MQTT_SET_MODE_SEND_RECV));
 239  00c6 4b1c          	push	#28
 240  00c8 ae0086        	ldw	x,#L56
 241  00cb cd0000        	call	_ms_send_cmd
 243  00ce 84            	pop	a
 244                     ; 349     delay_ms(200);
 246  00cf ae00c8        	ldw	x,#200
 247  00d2 cd0000        	call	_delay_ms
 249                     ; 351     ms_send_cmd(MQTT_OPEN_CONNECTION, strlen((const char *)MQTT_OPEN_CONNECTION));
 251  00d5 4b22          	push	#34
 252  00d7 ae0063        	ldw	x,#L76
 253  00da cd0000        	call	_ms_send_cmd
 255  00dd 84            	pop	a
 256                     ; 352     delay_ms(500);	
 258  00de ae01f4        	ldw	x,#500
 259  00e1 cd0000        	call	_delay_ms
 261                     ; 354 	vClearBuffer(temp, 50);
 263  00e4 4b32          	push	#50
 264  00e6 96            	ldw	x,sp
 265  00e7 1c0002        	addw	x,#OFST-48
 266  00ea cd0000        	call	_vClearBuffer
 268  00ed 84            	pop	a
 269                     ; 355     strcpy(temp, "AT+QMTCONN=1,\"");//"AT+QMTCONN=1,\"gen867400032743266\""
 271  00ee 96            	ldw	x,sp
 272  00ef 1c0001        	addw	x,#OFST-49
 273  00f2 90ae0054      	ldw	y,#L17
 274  00f6               L6:
 275  00f6 90f6          	ld	a,(y)
 276  00f8 905c          	incw	y
 277  00fa f7            	ld	(x),a
 278  00fb 5c            	incw	x
 279  00fc 4d            	tnz	a
 280  00fd 26f7          	jrne	L6
 281                     ; 356 	strcat(temp,punClientIdentifier);
 283  00ff 1e33          	ldw	x,(OFST+1,sp)
 284  0101 89            	pushw	x
 285  0102 96            	ldw	x,sp
 286  0103 1c0003        	addw	x,#OFST-47
 287  0106 cd0000        	call	_strcat
 289  0109 85            	popw	x
 290                     ; 357 	strcat(temp,"\"");
 292  010a ae0052        	ldw	x,#L37
 293  010d 89            	pushw	x
 294  010e 96            	ldw	x,sp
 295  010f 1c0003        	addw	x,#OFST-47
 296  0112 cd0000        	call	_strcat
 298  0115 85            	popw	x
 299                     ; 358     ms_send_cmd(temp, strlen((const char *)temp));
 301  0116 96            	ldw	x,sp
 302  0117 1c0001        	addw	x,#OFST-49
 303  011a cd0000        	call	_strlen
 305  011d 9f            	ld	a,xl
 306  011e 88            	push	a
 307  011f 96            	ldw	x,sp
 308  0120 1c0002        	addw	x,#OFST-48
 309  0123 cd0000        	call	_ms_send_cmd
 311  0126 84            	pop	a
 312                     ; 359     delay_ms(200);	
 314  0127 ae00c8        	ldw	x,#200
 315  012a cd0000        	call	_delay_ms
 317                     ; 360 }
 320  012d 5b34          	addw	sp,#52
 321  012f 81            	ret
 324                     .const:	section	.text
 325  0000               L57_temp1:
 326  0000 00            	dc.b	0
 327  0001 00000000      	ds.b	4
 406                     ; 430 void vMQTT_Publish ( uint8_t *punTopic, uint8_t *punMessage )
 406                     ; 431 {
 407                     	switch	.text
 408  0130               _vMQTT_Publish:
 410  0130 89            	pushw	x
 411  0131 526a          	subw	sp,#106
 412       0000006a      OFST:	set	106
 415                     ; 433 	uint8_t unLength = 0;
 417                     ; 434 	uint8_t temp1[5] = "";
 419  0133 96            	ldw	x,sp
 420  0134 1c0002        	addw	x,#OFST-104
 421  0137 90ae0000      	ldw	y,#L57_temp1
 422  013b a605          	ld	a,#5
 423  013d cd0000        	call	c_xymvx
 425                     ; 435 	vClearBuffer(temp, 100);
 427  0140 4b64          	push	#100
 428  0142 96            	ldw	x,sp
 429  0143 1c0008        	addw	x,#OFST-98
 430  0146 cd0000        	call	_vClearBuffer
 432  0149 84            	pop	a
 433                     ; 436     strcpy(temp, "AT+QMTPUBEX=1,0,0,0,\"");	//AT+QMTPUBEX=1,0,0,0,"sc2/867400032743266/event",14
 435  014a 96            	ldw	x,sp
 436  014b 1c0007        	addw	x,#OFST-99
 437  014e 90ae003c      	ldw	y,#L531
 438  0152               L21:
 439  0152 90f6          	ld	a,(y)
 440  0154 905c          	incw	y
 441  0156 f7            	ld	(x),a
 442  0157 5c            	incw	x
 443  0158 4d            	tnz	a
 444  0159 26f7          	jrne	L21
 445                     ; 437 	strcat(temp,punTopic);
 447  015b 1e6b          	ldw	x,(OFST+1,sp)
 448  015d 89            	pushw	x
 449  015e 96            	ldw	x,sp
 450  015f 1c0009        	addw	x,#OFST-97
 451  0162 cd0000        	call	_strcat
 453  0165 85            	popw	x
 454                     ; 438 	strcat(temp,"\",");
 456  0166 ae0039        	ldw	x,#L731
 457  0169 89            	pushw	x
 458  016a 96            	ldw	x,sp
 459  016b 1c0009        	addw	x,#OFST-97
 460  016e cd0000        	call	_strcat
 462  0171 85            	popw	x
 463                     ; 439 	unLength = strlen((const char *)punMessage);
 465  0172 1e6f          	ldw	x,(OFST+5,sp)
 466  0174 cd0000        	call	_strlen
 468  0177 01            	rrwa	x,a
 469  0178 6b01          	ld	(OFST-105,sp),a
 470  017a 02            	rlwa	x,a
 472                     ; 440 	vClearBuffer(temp1,5);
 474  017b 4b05          	push	#5
 475  017d 96            	ldw	x,sp
 476  017e 1c0003        	addw	x,#OFST-103
 477  0181 cd0000        	call	_vClearBuffer
 479  0184 84            	pop	a
 480                     ; 441     sprintf(temp1, "%d", (uint16_t)unLength);
 482  0185 7b01          	ld	a,(OFST-105,sp)
 483  0187 5f            	clrw	x
 484  0188 97            	ld	xl,a
 485  0189 89            	pushw	x
 486  018a ae0036        	ldw	x,#L141
 487  018d 89            	pushw	x
 488  018e 96            	ldw	x,sp
 489  018f 1c0006        	addw	x,#OFST-100
 490  0192 cd0000        	call	_sprintf
 492  0195 5b04          	addw	sp,#4
 493                     ; 442     strcat(temp,temp1);
 495  0197 96            	ldw	x,sp
 496  0198 1c0002        	addw	x,#OFST-104
 497  019b 89            	pushw	x
 498  019c 96            	ldw	x,sp
 499  019d 1c0009        	addw	x,#OFST-97
 500  01a0 cd0000        	call	_strcat
 502  01a3 85            	popw	x
 503                     ; 443     ms_send_cmd(temp, strlen((const char *)temp));
 505  01a4 96            	ldw	x,sp
 506  01a5 1c0007        	addw	x,#OFST-99
 507  01a8 cd0000        	call	_strlen
 509  01ab 9f            	ld	a,xl
 510  01ac 88            	push	a
 511  01ad 96            	ldw	x,sp
 512  01ae 1c0008        	addw	x,#OFST-98
 513  01b1 cd0000        	call	_ms_send_cmd
 515  01b4 84            	pop	a
 516                     ; 444 	delay_ms(10);
 518  01b5 ae000a        	ldw	x,#10
 519  01b8 cd0000        	call	_delay_ms
 521                     ; 445 	ms_send_cmd(punMessage, unLength);
 523  01bb 7b01          	ld	a,(OFST-105,sp)
 524  01bd 88            	push	a
 525  01be 1e70          	ldw	x,(OFST+6,sp)
 526  01c0 cd0000        	call	_ms_send_cmd
 528  01c3 84            	pop	a
 529                     ; 446     delay_ms(200);	
 531  01c4 ae00c8        	ldw	x,#200
 532  01c7 cd0000        	call	_delay_ms
 534                     ; 447 }
 537  01ca 5b6c          	addw	sp,#108
 538  01cc 81            	ret
 589                     ; 508 void vMQTT_Subscribe ( uint8_t *punTopic )
 589                     ; 509 {
 590                     	switch	.text
 591  01cd               _vMQTT_Subscribe:
 593  01cd 89            	pushw	x
 594  01ce 5232          	subw	sp,#50
 595       00000032      OFST:	set	50
 598                     ; 511 	vClearBuffer(temp, 50);
 600  01d0 4b32          	push	#50
 601  01d2 96            	ldw	x,sp
 602  01d3 1c0002        	addw	x,#OFST-48
 603  01d6 cd0000        	call	_vClearBuffer
 605  01d9 84            	pop	a
 606                     ; 512     strcpy(temp, "AT+QMTSUB=1,1,\"");	//AT+QMTSUB=1,1,"sc2/867400032743266/command",0
 608  01da 96            	ldw	x,sp
 609  01db 1c0001        	addw	x,#OFST-49
 610  01de 90ae0026      	ldw	y,#L561
 611  01e2               L61:
 612  01e2 90f6          	ld	a,(y)
 613  01e4 905c          	incw	y
 614  01e6 f7            	ld	(x),a
 615  01e7 5c            	incw	x
 616  01e8 4d            	tnz	a
 617  01e9 26f7          	jrne	L61
 618                     ; 513 	strcat(temp,punTopic);
 620  01eb 1e33          	ldw	x,(OFST+1,sp)
 621  01ed 89            	pushw	x
 622  01ee 96            	ldw	x,sp
 623  01ef 1c0003        	addw	x,#OFST-47
 624  01f2 cd0000        	call	_strcat
 626  01f5 85            	popw	x
 627                     ; 514 	strcat(temp,"\",0");
 629  01f6 ae0022        	ldw	x,#L761
 630  01f9 89            	pushw	x
 631  01fa 96            	ldw	x,sp
 632  01fb 1c0003        	addw	x,#OFST-47
 633  01fe cd0000        	call	_strcat
 635  0201 85            	popw	x
 636                     ; 515     ms_send_cmd(temp, strlen((const char *)temp));
 638  0202 96            	ldw	x,sp
 639  0203 1c0001        	addw	x,#OFST-49
 640  0206 cd0000        	call	_strlen
 642  0209 9f            	ld	a,xl
 643  020a 88            	push	a
 644  020b 96            	ldw	x,sp
 645  020c 1c0002        	addw	x,#OFST-48
 646  020f cd0000        	call	_ms_send_cmd
 648  0212 84            	pop	a
 649                     ; 516     delay_ms(200);	
 651  0213 ae00c8        	ldw	x,#200
 652  0216 cd0000        	call	_delay_ms
 654                     ; 517 }
 657  0219 5b34          	addw	sp,#52
 658  021b 81            	ret
 709                     ; 573 void vMQTT_UnSubscribe ( uint8_t *punTopic)
 709                     ; 574 {
 710                     	switch	.text
 711  021c               _vMQTT_UnSubscribe:
 713  021c 89            	pushw	x
 714  021d 5232          	subw	sp,#50
 715       00000032      OFST:	set	50
 718                     ; 576 	vClearBuffer(temp, 50);
 720  021f 4b32          	push	#50
 721  0221 96            	ldw	x,sp
 722  0222 1c0002        	addw	x,#OFST-48
 723  0225 cd0000        	call	_vClearBuffer
 725  0228 84            	pop	a
 726                     ; 577     strcpy(temp, "AT+QMTUNS=1,1,\"");	//AT+QMTUNS=1,1,"sc2/867400032743266/command"
 728  0229 96            	ldw	x,sp
 729  022a 1c0001        	addw	x,#OFST-49
 730  022d 90ae0012      	ldw	y,#L312
 731  0231               L22:
 732  0231 90f6          	ld	a,(y)
 733  0233 905c          	incw	y
 734  0235 f7            	ld	(x),a
 735  0236 5c            	incw	x
 736  0237 4d            	tnz	a
 737  0238 26f7          	jrne	L22
 738                     ; 578 	strcat(temp,punTopic);
 740  023a 1e33          	ldw	x,(OFST+1,sp)
 741  023c 89            	pushw	x
 742  023d 96            	ldw	x,sp
 743  023e 1c0003        	addw	x,#OFST-47
 744  0241 cd0000        	call	_strcat
 746  0244 85            	popw	x
 747                     ; 579 	strcat(temp,"\"");
 749  0245 ae0052        	ldw	x,#L37
 750  0248 89            	pushw	x
 751  0249 96            	ldw	x,sp
 752  024a 1c0003        	addw	x,#OFST-47
 753  024d cd0000        	call	_strcat
 755  0250 85            	popw	x
 756                     ; 580     ms_send_cmd(temp, strlen((const char *)temp));
 758  0251 96            	ldw	x,sp
 759  0252 1c0001        	addw	x,#OFST-49
 760  0255 cd0000        	call	_strlen
 762  0258 9f            	ld	a,xl
 763  0259 88            	push	a
 764  025a 96            	ldw	x,sp
 765  025b 1c0002        	addw	x,#OFST-48
 766  025e cd0000        	call	_ms_send_cmd
 768  0261 84            	pop	a
 769                     ; 581     delay_ms(200);
 771  0262 ae00c8        	ldw	x,#200
 772  0265 cd0000        	call	_delay_ms
 774                     ; 582 }
 777  0268 5b34          	addw	sp,#52
 778  026a 81            	ret
 804                     ; 620 void vMQTT_Disconnect ( void )
 804                     ; 621 {
 805                     	switch	.text
 806  026b               _vMQTT_Disconnect:
 810                     ; 622     ms_send_cmd(MQTT_DISCONNECT_BROKER, strlen((const char *)MQTT_DISCONNECT_BROKER));
 812  026b 4b0c          	push	#12
 813  026d ae0005        	ldw	x,#L522
 814  0270 cd0000        	call	_ms_send_cmd
 816  0273 84            	pop	a
 817                     ; 623     delay_ms(200);
 819  0274 ae00c8        	ldw	x,#200
 820  0277 cd0000        	call	_delay_ms
 822                     ; 624 }
 825  027a 81            	ret
 838                     	xdef	_vMQTT_Disconnect
 839                     	xdef	_vMQTT_UnSubscribe
 840                     	xdef	_vMQTT_Subscribe
 841                     	xdef	_vMQTT_Publish
 842                     	xdef	_vMQTT_Connect
 843                     	xref	_ms_send_cmd
 844                     	xref	_vClearBuffer
 845                     	xref	_sprintf
 846                     	xref	_strlen
 847                     	xref	_strcat
 848                     	xref	_delay_ms
 849                     	switch	.const
 850  0005               L522:
 851  0005 41542b514d54  	dc.b	"AT+QMTDISC=1",0
 852  0012               L312:
 853  0012 41542b514d54  	dc.b	"AT+QMTUNS=1,1,",34,0
 854  0022               L761:
 855  0022 222c3000      	dc.b	34,44,48,0
 856  0026               L561:
 857  0026 41542b514d54  	dc.b	"AT+QMTSUB=1,1,",34,0
 858  0036               L141:
 859  0036 256400        	dc.b	"%d",0
 860  0039               L731:
 861  0039 222c00        	dc.b	34,44,0
 862  003c               L531:
 863  003c 41542b514d54  	dc.b	"AT+QMTPUBEX=1,0,0,"
 864  004e 302c2200      	dc.b	"0,",34,0
 865  0052               L37:
 866  0052 2200          	dc.b	34,0
 867  0054               L17:
 868  0054 41542b514d54  	dc.b	"AT+QMTCONN=1,",34,0
 869  0063               L76:
 870  0063 41542b514d54  	dc.b	"AT+QMTOPEN=1,",34
 871  0071 6d7174742e6d  	dc.b	"mqtt.mevris.io",34
 872  0080 2c3338383100  	dc.b	",3881",0
 873  0086               L56:
 874  0086 41542b514d54  	dc.b	"AT+QMTCFG=",34
 875  0091 64617461666f  	dc.b	"dataformat",34
 876  009c 2c312c302c30  	dc.b	",1,0,0",0
 877  00a3               L36:
 878  00a3 41542b514d54  	dc.b	"AT+QMTCFG=",34
 879  00ae 656469742f74  	dc.b	"edit/timeout",34
 880  00bb 2c312c302c31  	dc.b	",1,0,1",0
 881  00c2               L16:
 882  00c2 41542b514d54  	dc.b	"AT+QMTCFG=",34
 883  00cd 766965772f6d  	dc.b	"view/mode",34
 884  00d7 2c312c3000    	dc.b	",1,0",0
 885  00dc               L75:
 886  00dc 41542b514d54  	dc.b	"AT+QMTCFG=",34
 887  00e7 726563762f6d  	dc.b	"recv/mode",34
 888  00f1 2c312c302c31  	dc.b	",1,0,1",0
 889  00f8               L55:
 890  00f8 41542b514d54  	dc.b	"AT+QMTCFG=",34
 891  0103 73657373696f  	dc.b	"session",34
 892  010b 2c312c3100    	dc.b	",1,1",0
 893  0110               L35:
 894  0110 41542b514d54  	dc.b	"AT+QMTCFG=",34
 895  011b 6b656570616c  	dc.b	"keepalive",34
 896  0125 2c312c313230  	dc.b	",1,120",0
 897  012c               L15:
 898  012c 41542b514d54  	dc.b	"AT+QMTCFG=",34
 899  0137 73736c22      	dc.b	"ssl",34
 900  013b 2c312c302c30  	dc.b	",1,0,0",0
 901  0142               L74:
 902  0142 41542b514d54  	dc.b	"AT+QMTCFG=",34
 903  014d 706470636964  	dc.b	"pdpcid",34
 904  0154 2c312c3100    	dc.b	",1,1",0
 905  0159               L54:
 906  0159 41542b514d54  	dc.b	"AT+QMTCFG=",34
 907  0164 76657273696f  	dc.b	"version",34
 908  016c 2c312c3400    	dc.b	",1,4",0
 909  0171               L34:
 910  0171 41542b514d54  	dc.b	"AT+QMTCLOSE=1",0
 911  017f               L14:
 912  017f 41542b434552  	dc.b	"AT+CEREG?",0
 913  0189               L73:
 914  0189 41542b434752  	dc.b	"AT+CGREG?",0
 915  0193               L53:
 916  0193 41542b435245  	dc.b	"AT+CREG?",0
 917  019c               L33:
 918  019c 4154453000    	dc.b	"ATE0",0
 919                     	xref.b	c_x
 939                     	xref	c_xymvx
 940                     	end
