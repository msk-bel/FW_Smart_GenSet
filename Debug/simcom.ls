   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  48                     ; 50 void SIMCom_setup(void)
  48                     ; 51 {
  50                     	switch	.text
  51  0000               _SIMCom_setup:
  55                     ; 52 	delay_ms(100);
  57  0000 ae0064        	ldw	x,#100
  58  0003 cd0000        	call	_delay_ms
  60                     ; 53 	SIMComrestart(); //Restart the SICOM 868 module 
  62  0006 cd0174        	call	_SIMComrestart
  64                     ; 54 	delay_ms(10000);
  66  0009 ae2710        	ldw	x,#10000
  67  000c cd0000        	call	_delay_ms
  69                     ; 56 	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  71  000f 4b04          	push	#4
  72  0011 ae018a        	ldw	x,#L12
  73  0014 cd0000        	call	_ms_send_cmd
  75  0017 84            	pop	a
  76                     ; 57 	delay_ms(20000); //need to adjust the delay
  78  0018 ae4e20        	ldw	x,#20000
  79  001b cd0000        	call	_delay_ms
  81                     ; 58 	delay_ms(1000);
  83  001e ae03e8        	ldw	x,#1000
  84  0021 cd0000        	call	_delay_ms
  86                     ; 60 	ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
  88  0024 4b0b          	push	#11
  89  0026 ae017e        	ldw	x,#L32
  90  0029 cd0000        	call	_ms_send_cmd
  92  002c 84            	pop	a
  93                     ; 61 	delay_ms(1000);
  95  002d ae03e8        	ldw	x,#1000
  96  0030 cd0000        	call	_delay_ms
  98                     ; 63 	ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
 100  0033 4b0a          	push	#10
 101  0035 ae0173        	ldw	x,#L52
 102  0038 cd0000        	call	_ms_send_cmd
 104  003b 84            	pop	a
 105                     ; 64 	delay_ms(1000);
 107  003c ae03e8        	ldw	x,#1000
 108  003f cd0000        	call	_delay_ms
 110                     ; 66 	ms_send_cmd(GPS_ON, strlen((const char *)GPS_ON));
 112  0042 4b0c          	push	#12
 113  0044 ae0166        	ldw	x,#L72
 114  0047 cd0000        	call	_ms_send_cmd
 116  004a 84            	pop	a
 117                     ; 67 	delay_ms(1000);
 119  004b ae03e8        	ldw	x,#1000
 120  004e cd0000        	call	_delay_ms
 122                     ; 69 	ms_send_cmd(rmc, strlen((const char *)rmc));
 124  0051 4b0e          	push	#14
 125  0053 ae0157        	ldw	x,#L13
 126  0056 cd0000        	call	_ms_send_cmd
 128  0059 84            	pop	a
 129                     ; 70 	delay_ms(1000);
 131  005a ae03e8        	ldw	x,#1000
 132  005d cd0000        	call	_delay_ms
 134                     ; 72 	ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
 136  0060 4b04          	push	#4
 137  0062 ae018a        	ldw	x,#L12
 138  0065 cd0000        	call	_ms_send_cmd
 140  0068 84            	pop	a
 141                     ; 73 	delay_ms(1000);
 143  0069 ae03e8        	ldw	x,#1000
 144  006c cd0000        	call	_delay_ms
 146                     ; 75 	ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
 148  006f 4b0a          	push	#10
 149  0071 ae014c        	ldw	x,#L33
 150  0074 cd0000        	call	_ms_send_cmd
 152  0077 84            	pop	a
 153                     ; 76 	delay_ms(1000);
 155  0078 ae03e8        	ldw	x,#1000
 156  007b cd0000        	call	_delay_ms
 158                     ; 78 	ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
 160  007e 4b1d          	push	#29
 161  0080 ae012e        	ldw	x,#L53
 162  0083 cd0000        	call	_ms_send_cmd
 164  0086 84            	pop	a
 165                     ; 79 	delay_ms(1000);
 167  0087 ae03e8        	ldw	x,#1000
 168  008a cd0000        	call	_delay_ms
 170                     ; 81 	ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
 172  008d 4b1c          	push	#28
 173  008f ae0111        	ldw	x,#L73
 174  0092 cd0000        	call	_ms_send_cmd
 176  0095 84            	pop	a
 177                     ; 82 	delay_ms(1000);
 179  0096 ae03e8        	ldw	x,#1000
 180  0099 cd0000        	call	_delay_ms
 182                     ; 84 	ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
 184  009c 4b0c          	push	#12
 185  009e ae0104        	ldw	x,#L14
 186  00a1 cd0000        	call	_ms_send_cmd
 188  00a4 84            	pop	a
 189                     ; 85 	delay_ms(1000);
 191  00a5 ae03e8        	ldw	x,#1000
 192  00a8 cd0000        	call	_delay_ms
 194                     ; 87 	ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
 196  00ab 4b0a          	push	#10
 197  00ad ae00f9        	ldw	x,#L34
 198  00b0 cd0000        	call	_ms_send_cmd
 200  00b3 84            	pop	a
 201                     ; 88 	delay_ms(1000);
 203  00b4 ae03e8        	ldw	x,#1000
 204  00b7 cd0000        	call	_delay_ms
 206                     ; 90     ms_send_cmd(TCP_SET_CONN_SINGLE, strlen((const char *)TCP_SET_CONN_SINGLE)); /* OPEN BEARER */
 208  00ba 4b0b          	push	#11
 209  00bc ae00ed        	ldw	x,#L54
 210  00bf cd0000        	call	_ms_send_cmd
 212  00c2 84            	pop	a
 213                     ; 91 	delay_ms(1000);
 215  00c3 ae03e8        	ldw	x,#1000
 216  00c6 cd0000        	call	_delay_ms
 218                     ; 93 	ms_send_cmd(TCP_MODE_TRANSPARENT_OFF, strlen((const char *)TCP_MODE_TRANSPARENT_OFF)); /* OPEN BEARER */
 220  00c9 4b0c          	push	#12
 221  00cb ae00e0        	ldw	x,#L74
 222  00ce cd0000        	call	_ms_send_cmd
 224  00d1 84            	pop	a
 225                     ; 94 	delay_ms(1000);
 227  00d2 ae03e8        	ldw	x,#1000
 228  00d5 cd0000        	call	_delay_ms
 230                     ; 96     ms_send_cmd(TCP_MODE_RESPONSE_NORMAL, strlen((const char *)TCP_MODE_RESPONSE_NORMAL)); /* OPEN BEARER */
 232  00d8 4b0d          	push	#13
 233  00da ae00d2        	ldw	x,#L15
 234  00dd cd0000        	call	_ms_send_cmd
 236  00e0 84            	pop	a
 237                     ; 97 	delay_ms(1000);
 239  00e1 ae03e8        	ldw	x,#1000
 240  00e4 cd0000        	call	_delay_ms
 242                     ; 99     ms_send_cmd(TCP_MODE_SEND_PROMPT_ECHO, strlen((const char *)TCP_MODE_SEND_PROMPT_ECHO)); /* OPEN BEARER */
 244  00e7 4b0c          	push	#12
 245  00e9 ae00c5        	ldw	x,#L35
 246  00ec cd0000        	call	_ms_send_cmd
 248  00ef 84            	pop	a
 249                     ; 100 	delay_ms(1000);
 251  00f0 ae03e8        	ldw	x,#1000
 252  00f3 cd0000        	call	_delay_ms
 254                     ; 102     ms_send_cmd(TCP_MODE_REMOTE_IP_PORT_ON, strlen((const char *)TCP_MODE_REMOTE_IP_PORT_ON)); /* OPEN BEARER */
 256  00f6 4b0c          	push	#12
 257  00f8 ae00b8        	ldw	x,#L55
 258  00fb cd0000        	call	_ms_send_cmd
 260  00fe 84            	pop	a
 261                     ; 103 	delay_ms(1000);
 263  00ff ae03e8        	ldw	x,#1000
 264  0102 cd0000        	call	_delay_ms
 266                     ; 105     ms_send_cmd(TCP_MODE_HEADER_ON_RECV_ON, strlen((const char *)TCP_MODE_HEADER_ON_RECV_ON)); /* OPEN BEARER */
 268  0105 4b0c          	push	#12
 269  0107 ae00ab        	ldw	x,#L75
 270  010a cd0000        	call	_ms_send_cmd
 272  010d 84            	pop	a
 273                     ; 106 	delay_ms(1000);
 275  010e ae03e8        	ldw	x,#1000
 276  0111 cd0000        	call	_delay_ms
 278                     ; 108     ms_send_cmd(TCP_SAVE_CONTEXT, strlen((const char *)TCP_SAVE_CONTEXT)); /* OPEN BEARER */
 280  0114 4b0b          	push	#11
 281  0116 ae009f        	ldw	x,#L16
 282  0119 cd0000        	call	_ms_send_cmd
 284  011c 84            	pop	a
 285                     ; 109 	delay_ms(1000);
 287  011d ae03e8        	ldw	x,#1000
 288  0120 cd0000        	call	_delay_ms
 290                     ; 111     ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
 292  0123 4b11          	push	#17
 293  0125 ae008d        	ldw	x,#L36
 294  0128 cd0000        	call	_ms_send_cmd
 296  012b 84            	pop	a
 297                     ; 112 	delay_ms(1000);
 299  012c ae03e8        	ldw	x,#1000
 300  012f cd0000        	call	_delay_ms
 302                     ; 114     ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
 304  0132 4b08          	push	#8
 305  0134 ae0084        	ldw	x,#L56
 306  0137 cd0000        	call	_ms_send_cmd
 308  013a 84            	pop	a
 309                     ; 115 	delay_ms(1000);
 311  013b ae03e8        	ldw	x,#1000
 312  013e cd0000        	call	_delay_ms
 314                     ; 117 	ms_send_cmd(BT_TURN_ON, strlen((const char *)BT_TURN_ON));
 316  0141 4b0c          	push	#12
 317  0143 ae0077        	ldw	x,#L76
 318  0146 cd0000        	call	_ms_send_cmd
 320  0149 84            	pop	a
 321                     ; 118 	delay_ms(5000);
 323  014a ae1388        	ldw	x,#5000
 324  014d cd0000        	call	_delay_ms
 326                     ; 120 	ms_send_cmd(BT_SET_NAME, strlen((const char *)BT_SET_NAME));
 328  0150 4b1a          	push	#26
 329  0152 ae005c        	ldw	x,#L17
 330  0155 cd0000        	call	_ms_send_cmd
 332  0158 84            	pop	a
 333                     ; 121 	delay_ms(3000);
 335  0159 ae0bb8        	ldw	x,#3000
 336  015c cd0000        	call	_delay_ms
 338                     ; 123 	ms_send_cmd(BT_SET_PIN, strlen((const char *)BT_SET_PIN));
 340  015f 4b13          	push	#19
 341  0161 ae0048        	ldw	x,#L37
 342  0164 cd0000        	call	_ms_send_cmd
 344  0167 84            	pop	a
 345                     ; 124 	delay_ms(3000);
 347  0168 ae0bb8        	ldw	x,#3000
 348  016b cd0000        	call	_delay_ms
 350                     ; 126 	getIMEI();
 352  016e ad70          	call	_getIMEI
 354                     ; 127 	passkeyGenerator();
 356  0170 cd0284        	call	_passkeyGenerator
 358                     ; 128 }
 361  0173 81            	ret
 389                     ; 174 void SIMComrestart()
 389                     ; 175 {
 390                     	switch	.text
 391  0174               _SIMComrestart:
 395                     ; 176 	ms_send_cmd(SIMCom_OFF, strlen((const char *)SIMCom_OFF)); /* Power down the SIMCom module */
 397  0174 4b0a          	push	#10
 398  0176 ae003d        	ldw	x,#L501
 399  0179 cd0000        	call	_ms_send_cmd
 401  017c 84            	pop	a
 402                     ; 177 	delay_ms(800);
 404  017d ae0320        	ldw	x,#800
 405  0180 cd0000        	call	_delay_ms
 407                     ; 179 	GPIO_WriteHigh(PWRKEY);
 409  0183 4b20          	push	#32
 410  0185 ae500a        	ldw	x,#20490
 411  0188 cd0000        	call	_GPIO_WriteHigh
 413  018b 84            	pop	a
 414                     ; 180 	delay_ms(1000);
 416  018c ae03e8        	ldw	x,#1000
 417  018f cd0000        	call	_delay_ms
 419                     ; 182 	GPIO_WriteLow(PWRKEY);
 421  0192 4b20          	push	#32
 422  0194 ae500a        	ldw	x,#20490
 423  0197 cd0000        	call	_GPIO_WriteLow
 425  019a 84            	pop	a
 426                     ; 183 	delay_ms(1000);
 428  019b ae03e8        	ldw	x,#1000
 429  019e cd0000        	call	_delay_ms
 431                     ; 184 }
 434  01a1 81            	ret
 482                     ; 186 void checkNum()
 482                     ; 187 {
 483                     	switch	.text
 484  01a2               _checkNum:
 486  01a2 5203          	subw	sp,#3
 487       00000003      OFST:	set	3
 490                     ; 188 	uint16_t timeout = 0;
 492  01a4 5f            	clrw	x
 493  01a5 1f01          	ldw	(OFST-2,sp),x
 495                     ; 190 	ms_send_cmd(check_num, strlen((const char *)check_num)); // SMS read
 497  01a7 4b07          	push	#7
 498  01a9 ae0035        	ldw	x,#L131
 499  01ac cd0000        	call	_ms_send_cmd
 501  01af 84            	pop	a
 502                     ; 192 	for (s = 0; s < 75; s++)
 504  01b0 0f03          	clr	(OFST+0,sp)
 506  01b2               L341:
 507                     ; 194 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 509  01b2 ae0020        	ldw	x,#32
 510  01b5 cd0000        	call	_UART1_GetFlagStatus
 512  01b8 4d            	tnz	a
 513  01b9 260c          	jrne	L741
 515  01bb 1e01          	ldw	x,(OFST-2,sp)
 516  01bd 1c0001        	addw	x,#1
 517  01c0 1f01          	ldw	(OFST-2,sp),x
 519  01c2 a32710        	cpw	x,#10000
 520  01c5 26eb          	jrne	L341
 521  01c7               L741:
 522                     ; 196 		response_buffer[s] = UART1_ReceiveData8();
 524  01c7 7b03          	ld	a,(OFST+0,sp)
 525  01c9 5f            	clrw	x
 526  01ca 97            	ld	xl,a
 527  01cb 89            	pushw	x
 528  01cc cd0000        	call	_UART1_ReceiveData8
 530  01cf 85            	popw	x
 531  01d0 e700          	ld	(_response_buffer,x),a
 532                     ; 197 		timeout = 0;
 534  01d2 5f            	clrw	x
 535  01d3 1f01          	ldw	(OFST-2,sp),x
 537                     ; 192 	for (s = 0; s < 75; s++)
 539  01d5 0c03          	inc	(OFST+0,sp)
 543  01d7 7b03          	ld	a,(OFST+0,sp)
 544  01d9 a14b          	cp	a,#75
 545  01db 25d5          	jrult	L341
 546                     ; 199 }
 549  01dd 5b03          	addw	sp,#3
 550  01df 81            	ret
 619                     ; 201 void getIMEI(void)
 619                     ; 202 {
 620                     	switch	.text
 621  01e0               _getIMEI:
 623  01e0 521d          	subw	sp,#29
 624       0000001d      OFST:	set	29
 627                     ; 208 	UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 629  01e2 4b00          	push	#0
 630  01e4 ae0255        	ldw	x,#597
 631  01e7 cd0000        	call	_UART1_ITConfig
 633  01ea 84            	pop	a
 634                     ; 209 	UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 636  01eb 4b00          	push	#0
 637  01ed ae0244        	ldw	x,#580
 638  01f0 cd0000        	call	_UART1_ITConfig
 640  01f3 84            	pop	a
 641                     ; 211 	ms_send_cmd(IMEIcmnd, strlen((const char *)IMEIcmnd)); //"AT+HTTPSSL=1"
 643  01f4 4b06          	push	#6
 644  01f6 ae002e        	ldw	x,#L302
 645  01f9 cd0000        	call	_ms_send_cmd
 647  01fc 84            	pop	a
 648                     ; 214 	for (i = 0; i < 25; i++)
 650  01fd 0f1d          	clr	(OFST+0,sp)
 652  01ff               L512:
 653                     ; 216 		while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++ulTimout != 10000))
 655  01ff ae0020        	ldw	x,#32
 656  0202 cd0000        	call	_UART1_GetFlagStatus
 658  0205 4d            	tnz	a
 659  0206 260c          	jrne	L122
 661  0208 1e1a          	ldw	x,(OFST-3,sp)
 662  020a 1c0001        	addw	x,#1
 663  020d 1f1a          	ldw	(OFST-3,sp),x
 665  020f a32710        	cpw	x,#10000
 666  0212 26eb          	jrne	L512
 667  0214               L122:
 668                     ; 218 		localBuffer[i] = UART1_ReceiveData8();
 670  0214 96            	ldw	x,sp
 671  0215 1c0001        	addw	x,#OFST-28
 672  0218 9f            	ld	a,xl
 673  0219 5e            	swapw	x
 674  021a 1b1d          	add	a,(OFST+0,sp)
 675  021c 2401          	jrnc	L41
 676  021e 5c            	incw	x
 677  021f               L41:
 678  021f 02            	rlwa	x,a
 679  0220 89            	pushw	x
 680  0221 cd0000        	call	_UART1_ReceiveData8
 682  0224 85            	popw	x
 683  0225 f7            	ld	(x),a
 684                     ; 219 		ulTimout = 0;
 686  0226 5f            	clrw	x
 687  0227 1f1a          	ldw	(OFST-3,sp),x
 689                     ; 214 	for (i = 0; i < 25; i++)
 691  0229 0c1d          	inc	(OFST+0,sp)
 695  022b 7b1d          	ld	a,(OFST+0,sp)
 696  022d a119          	cp	a,#25
 697  022f 25ce          	jrult	L512
 698                     ; 221 	localBuffer[i] = '\0';
 700  0231 96            	ldw	x,sp
 701  0232 1c0001        	addw	x,#OFST-28
 702  0235 9f            	ld	a,xl
 703  0236 5e            	swapw	x
 704  0237 1b1d          	add	a,(OFST+0,sp)
 705  0239 2401          	jrnc	L61
 706  023b 5c            	incw	x
 707  023c               L61:
 708  023c 02            	rlwa	x,a
 709  023d 7f            	clr	(x)
 710                     ; 222 	j = 0;
 712  023e 0f1c          	clr	(OFST-1,sp)
 714                     ; 223 	for (i = 2; i < 17; i++)
 716  0240 a602          	ld	a,#2
 717  0242 6b1d          	ld	(OFST+0,sp),a
 719  0244               L322:
 720                     ; 225 		aunIMEI[j] = localBuffer[i];
 722  0244 7b1c          	ld	a,(OFST-1,sp)
 723  0246 5f            	clrw	x
 724  0247 97            	ld	xl,a
 725  0248 89            	pushw	x
 726  0249 96            	ldw	x,sp
 727  024a 1c0003        	addw	x,#OFST-26
 728  024d 9f            	ld	a,xl
 729  024e 5e            	swapw	x
 730  024f 1b1f          	add	a,(OFST+2,sp)
 731  0251 2401          	jrnc	L02
 732  0253 5c            	incw	x
 733  0254               L02:
 734  0254 02            	rlwa	x,a
 735  0255 f6            	ld	a,(x)
 736  0256 85            	popw	x
 737  0257 e710          	ld	(_aunIMEI,x),a
 738                     ; 226 		j++;
 740  0259 0c1c          	inc	(OFST-1,sp)
 742                     ; 223 	for (i = 2; i < 17; i++)
 744  025b 0c1d          	inc	(OFST+0,sp)
 748  025d 7b1d          	ld	a,(OFST+0,sp)
 749  025f a111          	cp	a,#17
 750  0261 25e1          	jrult	L322
 751                     ; 228 	aunIMEI[j] = '\0';
 753  0263 7b1c          	ld	a,(OFST-1,sp)
 754  0265 5f            	clrw	x
 755  0266 97            	ld	xl,a
 756  0267 6f10          	clr	(_aunIMEI,x)
 757                     ; 229 	delay_ms(200);
 759  0269 ae00c8        	ldw	x,#200
 760  026c cd0000        	call	_delay_ms
 762                     ; 231 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 764  026f 4b01          	push	#1
 765  0271 ae0255        	ldw	x,#597
 766  0274 cd0000        	call	_UART1_ITConfig
 768  0277 84            	pop	a
 769                     ; 232 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
 771  0278 4b01          	push	#1
 772  027a ae0244        	ldw	x,#580
 773  027d cd0000        	call	_UART1_ITConfig
 775  0280 84            	pop	a
 776                     ; 233 }
 779  0281 5b1d          	addw	sp,#29
 780  0283 81            	ret
 783                     .const:	section	.text
 784  0000               L132_temp:
 785  0000 00            	dc.b	0
 786  0001 00            	dc.b	0
 787  0002 00            	dc.b	0
 788  0003 00            	dc.b	0
 789  0004 00            	dc.b	0
 790  0005 00            	dc.b	0
 791  0006 00            	dc.b	0
 792  0007 00            	dc.b	0
 793  0008 00            	dc.b	0
 794  0009 00            	dc.b	0
 795  000a 00            	dc.b	0
 796  000b 00            	dc.b	0
 797  000c 00            	dc.b	0
 798  000d 00            	dc.b	0
 799  000e 00            	dc.b	0
 800  000f 00            	ds.b	1
 857                     ; 235 void passkeyGenerator()
 857                     ; 236 {
 858                     	switch	.text
 859  0284               _passkeyGenerator:
 861  0284 5227          	subw	sp,#39
 862       00000027      OFST:	set	39
 865                     ; 237 	uint8_t temp[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 867  0286 96            	ldw	x,sp
 868  0287 1c0016        	addw	x,#OFST-17
 869  028a 90ae0000      	ldw	y,#L132_temp
 870  028e a610          	ld	a,#16
 871  0290 cd0000        	call	c_xymvx
 873                     ; 238 	uint8_t i = 0;
 875                     ; 239 	uint8_t checksum = 0;
 877  0293 0f26          	clr	(OFST-1,sp)
 879                     ; 241 	for (i = 0; i < 15; i++)
 881  0295 0f27          	clr	(OFST+0,sp)
 883  0297               L162:
 884                     ; 243 		checksum ^= aunIMEI[i];
 886  0297 7b27          	ld	a,(OFST+0,sp)
 887  0299 5f            	clrw	x
 888  029a 97            	ld	xl,a
 889  029b 7b26          	ld	a,(OFST-1,sp)
 890  029d e810          	xor	a,	(_aunIMEI,x)
 891  029f 6b26          	ld	(OFST-1,sp),a
 893                     ; 241 	for (i = 0; i < 15; i++)
 895  02a1 0c27          	inc	(OFST+0,sp)
 899  02a3 7b27          	ld	a,(OFST+0,sp)
 900  02a5 a10f          	cp	a,#15
 901  02a7 25ee          	jrult	L162
 902                     ; 245 	for (i = 0; i < 15; i++)
 904  02a9 0f27          	clr	(OFST+0,sp)
 906  02ab               L762:
 908  02ab 7b27          	ld	a,(OFST+0,sp)
 909  02ad 5f            	clrw	x
 910  02ae 97            	ld	xl,a
 911  02af 1c000c        	addw	x,#12
 912  02b2 a60f          	ld	a,#15
 913  02b4 cd0000        	call	c_smodx
 915  02b7 e610          	ld	a,(_aunIMEI,x)
 916  02b9 6b13          	ld	(OFST-20,sp),a
 918  02bb 7b27          	ld	a,(OFST+0,sp)
 919  02bd 5f            	clrw	x
 920  02be 97            	ld	xl,a
 921  02bf 1c000d        	addw	x,#13
 922  02c2 a60f          	ld	a,#15
 923  02c4 cd0000        	call	c_smodx
 925  02c7 e610          	ld	a,(_aunIMEI,x)
 926  02c9 5f            	clrw	x
 927  02ca 1b13          	add	a,(OFST-20,sp)
 928  02cc 2401          	jrnc	L42
 929  02ce 5c            	incw	x
 930  02cf               L42:
 931  02cf 02            	rlwa	x,a
 932  02d0 1f11          	ldw	(OFST-22,sp),x
 933  02d2 01            	rrwa	x,a
 935  02d3 7b27          	ld	a,(OFST+0,sp)
 936  02d5 5f            	clrw	x
 937  02d6 97            	ld	xl,a
 938  02d7 1c000a        	addw	x,#10
 939  02da a60f          	ld	a,#15
 940  02dc cd0000        	call	c_smodx
 942  02df e610          	ld	a,(_aunIMEI,x)
 943  02e1 6b10          	ld	(OFST-23,sp),a
 945  02e3 7b27          	ld	a,(OFST+0,sp)
 946  02e5 5f            	clrw	x
 947  02e6 97            	ld	xl,a
 948  02e7 1c000b        	addw	x,#11
 949  02ea a60f          	ld	a,#15
 950  02ec cd0000        	call	c_smodx
 952  02ef e610          	ld	a,(_aunIMEI,x)
 953  02f1 5f            	clrw	x
 954  02f2 1b10          	add	a,(OFST-23,sp)
 955  02f4 2401          	jrnc	L62
 956  02f6 5c            	incw	x
 957  02f7               L62:
 958  02f7 02            	rlwa	x,a
 959  02f8 1f0e          	ldw	(OFST-25,sp),x
 960  02fa 01            	rrwa	x,a
 962  02fb 7b27          	ld	a,(OFST+0,sp)
 963  02fd 5f            	clrw	x
 964  02fe 97            	ld	xl,a
 965  02ff 1c0008        	addw	x,#8
 966  0302 a60f          	ld	a,#15
 967  0304 cd0000        	call	c_smodx
 969  0307 e610          	ld	a,(_aunIMEI,x)
 970  0309 6b0d          	ld	(OFST-26,sp),a
 972  030b 7b27          	ld	a,(OFST+0,sp)
 973  030d 5f            	clrw	x
 974  030e 97            	ld	xl,a
 975  030f 1c0009        	addw	x,#9
 976  0312 a60f          	ld	a,#15
 977  0314 cd0000        	call	c_smodx
 979  0317 e610          	ld	a,(_aunIMEI,x)
 980  0319 5f            	clrw	x
 981  031a 1b0d          	add	a,(OFST-26,sp)
 982  031c 2401          	jrnc	L03
 983  031e 5c            	incw	x
 984  031f               L03:
 985  031f 02            	rlwa	x,a
 986  0320 1f0b          	ldw	(OFST-28,sp),x
 987  0322 01            	rrwa	x,a
 989  0323 7b27          	ld	a,(OFST+0,sp)
 990  0325 5f            	clrw	x
 991  0326 97            	ld	xl,a
 992  0327 1c0006        	addw	x,#6
 993  032a a60f          	ld	a,#15
 994  032c cd0000        	call	c_smodx
 996  032f e610          	ld	a,(_aunIMEI,x)
 997  0331 6b0a          	ld	(OFST-29,sp),a
 999  0333 7b27          	ld	a,(OFST+0,sp)
1000  0335 5f            	clrw	x
1001  0336 97            	ld	xl,a
1002  0337 1c0007        	addw	x,#7
1003  033a a60f          	ld	a,#15
1004  033c cd0000        	call	c_smodx
1006  033f e610          	ld	a,(_aunIMEI,x)
1007  0341 5f            	clrw	x
1008  0342 1b0a          	add	a,(OFST-29,sp)
1009  0344 2401          	jrnc	L23
1010  0346 5c            	incw	x
1011  0347               L23:
1012  0347 02            	rlwa	x,a
1013  0348 1f08          	ldw	(OFST-31,sp),x
1014  034a 01            	rrwa	x,a
1016  034b 7b27          	ld	a,(OFST+0,sp)
1017  034d 5f            	clrw	x
1018  034e 97            	ld	xl,a
1019  034f 1c0004        	addw	x,#4
1020  0352 a60f          	ld	a,#15
1021  0354 cd0000        	call	c_smodx
1023  0357 e610          	ld	a,(_aunIMEI,x)
1024  0359 6b07          	ld	(OFST-32,sp),a
1026  035b 7b27          	ld	a,(OFST+0,sp)
1027  035d 5f            	clrw	x
1028  035e 97            	ld	xl,a
1029  035f 1c0005        	addw	x,#5
1030  0362 a60f          	ld	a,#15
1031  0364 cd0000        	call	c_smodx
1033  0367 e610          	ld	a,(_aunIMEI,x)
1034  0369 5f            	clrw	x
1035  036a 1b07          	add	a,(OFST-32,sp)
1036  036c 2401          	jrnc	L43
1037  036e 5c            	incw	x
1038  036f               L43:
1039  036f 02            	rlwa	x,a
1040  0370 1f05          	ldw	(OFST-34,sp),x
1041  0372 01            	rrwa	x,a
1043  0373 7b27          	ld	a,(OFST+0,sp)
1044  0375 5f            	clrw	x
1045  0376 97            	ld	xl,a
1046  0377 5c            	incw	x
1047  0378 5c            	incw	x
1048  0379 a60f          	ld	a,#15
1049  037b cd0000        	call	c_smodx
1051  037e e610          	ld	a,(_aunIMEI,x)
1052  0380 6b04          	ld	(OFST-35,sp),a
1054  0382 7b27          	ld	a,(OFST+0,sp)
1055  0384 5f            	clrw	x
1056  0385 97            	ld	xl,a
1057  0386 1c0003        	addw	x,#3
1058  0389 a60f          	ld	a,#15
1059  038b cd0000        	call	c_smodx
1061  038e e610          	ld	a,(_aunIMEI,x)
1062  0390 5f            	clrw	x
1063  0391 1b04          	add	a,(OFST-35,sp)
1064  0393 2401          	jrnc	L63
1065  0395 5c            	incw	x
1066  0396               L63:
1067  0396 02            	rlwa	x,a
1068  0397 1f02          	ldw	(OFST-37,sp),x
1069  0399 01            	rrwa	x,a
1071  039a 7b27          	ld	a,(OFST+0,sp)
1072  039c 5f            	clrw	x
1073  039d 97            	ld	xl,a
1074  039e e610          	ld	a,(_aunIMEI,x)
1075  03a0 6b01          	ld	(OFST-38,sp),a
1077  03a2 7b27          	ld	a,(OFST+0,sp)
1078  03a4 5f            	clrw	x
1079  03a5 97            	ld	xl,a
1080  03a6 5c            	incw	x
1081  03a7 a60f          	ld	a,#15
1082  03a9 cd0000        	call	c_smodx
1084  03ac e610          	ld	a,(_aunIMEI,x)
1085  03ae 5f            	clrw	x
1086  03af 1b01          	add	a,(OFST-38,sp)
1087  03b1 2401          	jrnc	L04
1088  03b3 5c            	incw	x
1089  03b4               L04:
1090  03b4 1803          	xor	a,(OFST-36,sp)
1091  03b6 41            	exg	a,xl
1092  03b7 1802          	xor	a,(OFST-37,sp)
1093  03b9 41            	exg	a,xl
1094  03ba 1806          	xor	a,(OFST-33,sp)
1095  03bc 41            	exg	a,xl
1096  03bd 1805          	xor	a,(OFST-34,sp)
1097  03bf 41            	exg	a,xl
1098  03c0 1809          	xor	a,(OFST-30,sp)
1099  03c2 41            	exg	a,xl
1100  03c3 1808          	xor	a,(OFST-31,sp)
1101  03c5 41            	exg	a,xl
1102  03c6 180c          	xor	a,(OFST-27,sp)
1103  03c8 41            	exg	a,xl
1104  03c9 180b          	xor	a,(OFST-28,sp)
1105  03cb 41            	exg	a,xl
1106  03cc 180f          	xor	a,(OFST-24,sp)
1107  03ce 41            	exg	a,xl
1108  03cf 180e          	xor	a,(OFST-25,sp)
1109  03d1 41            	exg	a,xl
1110  03d2 1812          	xor	a,(OFST-21,sp)
1111  03d4 41            	exg	a,xl
1112  03d5 1811          	xor	a,(OFST-22,sp)
1113  03d7 41            	exg	a,xl
1114  03d8 02            	rlwa	x,a
1115  03d9 1f14          	ldw	(OFST-19,sp),x
1116  03db 01            	rrwa	x,a
1118                     ; 247 		temp[i] = ((aunIMEI[i] + aunIMEI[(i + 1) % 15])
1118                     ; 248                    ^ (aunIMEI[(i + 2) % 15] + aunIMEI[(i + 3) % 15])
1118                     ; 249                    ^ (aunIMEI[(i + 4) % 15] + aunIMEI[(i + 5) % 15])
1118                     ; 250                    ^ (aunIMEI[(i + 6) % 15] + aunIMEI[(i + 7) % 15])
1118                     ; 251                    ^ (aunIMEI[(i + 8) % 15] + aunIMEI[(i + 9) % 15])
1118                     ; 252                    ^ (aunIMEI[(i + 10) % 15] + aunIMEI[(i + 11) % 15])
1118                     ; 253                    ^ (aunIMEI[(i + 12) % 15] + aunIMEI[(i + 13) % 15])
1118                     ; 254                    ^ (aunIMEI[(i + 14) % 15] + checksum)) % 10;
1119  03dc 96            	ldw	x,sp
1120  03dd 1c0016        	addw	x,#OFST-17
1121  03e0 9f            	ld	a,xl
1122  03e1 5e            	swapw	x
1123  03e2 1b27          	add	a,(OFST+0,sp)
1124  03e4 2401          	jrnc	L24
1125  03e6 5c            	incw	x
1126  03e7               L24:
1127  03e7 02            	rlwa	x,a
1128  03e8 89            	pushw	x
1129  03e9 7b29          	ld	a,(OFST+2,sp)
1130  03eb 5f            	clrw	x
1131  03ec 97            	ld	xl,a
1132  03ed 1c000e        	addw	x,#14
1133  03f0 a60f          	ld	a,#15
1134  03f2 cd0000        	call	c_smodx
1136  03f5 e610          	ld	a,(_aunIMEI,x)
1137  03f7 5f            	clrw	x
1138  03f8 1b28          	add	a,(OFST+1,sp)
1139  03fa 2401          	jrnc	L44
1140  03fc 5c            	incw	x
1141  03fd               L44:
1142  03fd 02            	rlwa	x,a
1143  03fe 1f14          	ldw	(OFST-19,sp),x
1144  0400 01            	rrwa	x,a
1146  0401 1e16          	ldw	x,(OFST-17,sp)
1147  0403 01            	rrwa	x,a
1148  0404 1815          	xor	a,(OFST-18,sp)
1149  0406 01            	rrwa	x,a
1150  0407 1814          	xor	a,(OFST-19,sp)
1151  0409 01            	rrwa	x,a
1152  040a a60a          	ld	a,#10
1153  040c cd0000        	call	c_smodx
1155  040f 9085          	popw	y
1156  0411 01            	rrwa	x,a
1157  0412 90f7          	ld	(y),a
1158  0414 02            	rlwa	x,a
1159                     ; 245 	for (i = 0; i < 15; i++)
1161  0415 0c27          	inc	(OFST+0,sp)
1165  0417 7b27          	ld	a,(OFST+0,sp)
1166  0419 a10f          	cp	a,#15
1167  041b 2403          	jruge	L05
1168  041d cc02ab        	jp	L762
1169  0420               L05:
1170                     ; 257 	for (i = 0; i < 15; i++)
1172  0420 0f27          	clr	(OFST+0,sp)
1174  0422               L572:
1175                     ; 259 		PASS_KEY[i] = getValue(temp[i], i);
1177  0422 7b27          	ld	a,(OFST+0,sp)
1178  0424 5f            	clrw	x
1179  0425 97            	ld	xl,a
1180  0426 89            	pushw	x
1181  0427 7b29          	ld	a,(OFST+2,sp)
1182  0429 97            	ld	xl,a
1183  042a 89            	pushw	x
1184  042b 96            	ldw	x,sp
1185  042c 1c001a        	addw	x,#OFST-13
1186  042f 9f            	ld	a,xl
1187  0430 5e            	swapw	x
1188  0431 1b2b          	add	a,(OFST+4,sp)
1189  0433 2401          	jrnc	L64
1190  0435 5c            	incw	x
1191  0436               L64:
1192  0436 02            	rlwa	x,a
1193  0437 f6            	ld	a,(x)
1194  0438 85            	popw	x
1195  0439 95            	ld	xh,a
1196  043a ad2f          	call	_getValue
1198  043c 85            	popw	x
1199  043d e700          	ld	(_PASS_KEY,x),a
1200                     ; 257 	for (i = 0; i < 15; i++)
1202  043f 0c27          	inc	(OFST+0,sp)
1206  0441 7b27          	ld	a,(OFST+0,sp)
1207  0443 a10f          	cp	a,#15
1208  0445 25db          	jrult	L572
1209                     ; 261 	PASS_KEY[i] = '\0';
1211  0447 7b27          	ld	a,(OFST+0,sp)
1212  0449 5f            	clrw	x
1213  044a 97            	ld	xl,a
1214  044b 6f00          	clr	(_PASS_KEY,x)
1215                     ; 262 	delay_ms(200);
1217  044d ae00c8        	ldw	x,#200
1218  0450 cd0000        	call	_delay_ms
1220                     ; 263 	ms_send_cmd(PASS_KEY, strlen((const char *)PASS_KEY));
1222  0453 ae0000        	ldw	x,#_PASS_KEY
1223  0456 cd0000        	call	_strlen
1225  0459 9f            	ld	a,xl
1226  045a 88            	push	a
1227  045b ae0000        	ldw	x,#_PASS_KEY
1228  045e cd0000        	call	_ms_send_cmd
1230  0461 84            	pop	a
1231                     ; 264 	delay_ms(200);
1233  0462 ae00c8        	ldw	x,#200
1234  0465 cd0000        	call	_delay_ms
1236                     ; 265 }
1239  0468 5b27          	addw	sp,#39
1240  046a 81            	ret
1292                     	switch	.const
1293  0010               L65:
1294  0010 047d          	dc.w	L303
1295  0012 0497          	dc.w	L503
1296  0014 04a1          	dc.w	L703
1297  0016 04bb          	dc.w	L113
1298  0018 0503          	dc.w	L313
1299  001a 050d          	dc.w	L513
1300  001c 0517          	dc.w	L713
1301  001e 0531          	dc.w	L123
1302  0020 053b          	dc.w	L323
1303  0022 0545          	dc.w	L523
1304  0024 054f          	dc.w	L723
1305  0026 0587          	dc.w	L133
1306  0028 05b1          	dc.w	L333
1307  002a 05b9          	dc.w	L533
1308  002c 05c1          	dc.w	L733
1309                     ; 267 uint8_t getValue(uint8_t key, uint8_t pos)
1309                     ; 268 {
1310                     	switch	.text
1311  046b               _getValue:
1313  046b 89            	pushw	x
1314  046c 88            	push	a
1315       00000001      OFST:	set	1
1318                     ; 271 	switch (pos)
1320  046d 9f            	ld	a,xl
1322                     ; 363             break;
1323  046e a10f          	cp	a,#15
1324  0470 2407          	jruge	L45
1325  0472 5f            	clrw	x
1326  0473 97            	ld	xl,a
1327  0474 58            	sllw	x
1328  0475 de0010        	ldw	x,(L65,x)
1329  0478 fc            	jp	(x)
1330  0479               L45:
1331  0479 ac2d062d      	jpf	L143
1332  047d               L303:
1333                     ; 273         case 0:
1333                     ; 274             if (key < 5)
1335  047d 7b02          	ld	a,(OFST+1,sp)
1336  047f a105          	cp	a,#5
1337  0481 240a          	jruge	L573
1338                     ; 275                 temp = key + 0x56;	// Ascii char from 0x56 to 0x5A
1340  0483 7b02          	ld	a,(OFST+1,sp)
1341  0485 ab56          	add	a,#86
1342  0487 6b01          	ld	(OFST+0,sp),a
1345  0489 ac330633      	jpf	L373
1346  048d               L573:
1347                     ; 277                 temp = key + 0x71;	// Ascii char from 0x76 to 0x7A
1349  048d 7b02          	ld	a,(OFST+1,sp)
1350  048f ab71          	add	a,#113
1351  0491 6b01          	ld	(OFST+0,sp),a
1353  0493 ac330633      	jpf	L373
1354  0497               L503:
1355                     ; 279         case 1:
1355                     ; 280             temp = key + 0x30;	// Ascii char 0x30 to 0x39
1357  0497 7b02          	ld	a,(OFST+1,sp)
1358  0499 ab30          	add	a,#48
1359  049b 6b01          	ld	(OFST+0,sp),a
1361                     ; 281             break;
1363  049d ac330633      	jpf	L373
1364  04a1               L703:
1365                     ; 282         case 2:
1365                     ; 283             if (key < 5)
1367  04a1 7b02          	ld	a,(OFST+1,sp)
1368  04a3 a105          	cp	a,#5
1369  04a5 240a          	jruge	L104
1370                     ; 284                 temp = key + 0x35;	// Ascii char from 0x35 to 0x39
1372  04a7 7b02          	ld	a,(OFST+1,sp)
1373  04a9 ab35          	add	a,#53
1374  04ab 6b01          	ld	(OFST+0,sp),a
1377  04ad ac330633      	jpf	L373
1378  04b1               L104:
1379                     ; 286                 temp = key + 0x3C;	// Ascii char from 0x41 to 0x45
1381  04b1 7b02          	ld	a,(OFST+1,sp)
1382  04b3 ab3c          	add	a,#60
1383  04b5 6b01          	ld	(OFST+0,sp),a
1385  04b7 ac330633      	jpf	L373
1386  04bb               L113:
1387                     ; 288         case 3:
1387                     ; 289             if (key < 1)
1389  04bb 0d02          	tnz	(OFST+1,sp)
1390  04bd 260a          	jrne	L504
1391                     ; 290                 temp = key + 0x21;	// Ascii char 0x21
1393  04bf 7b02          	ld	a,(OFST+1,sp)
1394  04c1 ab21          	add	a,#33
1395  04c3 6b01          	ld	(OFST+0,sp),a
1398  04c5 ac330633      	jpf	L373
1399  04c9               L504:
1400                     ; 291             else if (key < 5)
1402  04c9 7b02          	ld	a,(OFST+1,sp)
1403  04cb a105          	cp	a,#5
1404  04cd 240a          	jruge	L114
1405                     ; 292                 temp = key + 0x22;	// Ascii char from 0x23 to 0x26
1407  04cf 7b02          	ld	a,(OFST+1,sp)
1408  04d1 ab22          	add	a,#34
1409  04d3 6b01          	ld	(OFST+0,sp),a
1412  04d5 ac330633      	jpf	L373
1413  04d9               L114:
1414                     ; 293             else if (key < 7)
1416  04d9 7b02          	ld	a,(OFST+1,sp)
1417  04db a107          	cp	a,#7
1418  04dd 240a          	jruge	L514
1419                     ; 294                 temp = key + 0x29;	// Ascii char 0x2F
1421  04df 7b02          	ld	a,(OFST+1,sp)
1422  04e1 ab29          	add	a,#41
1423  04e3 6b01          	ld	(OFST+0,sp),a
1426  04e5 ac330633      	jpf	L373
1427  04e9               L514:
1428                     ; 295             else if (key < 8)
1430  04e9 7b02          	ld	a,(OFST+1,sp)
1431  04eb a108          	cp	a,#8
1432  04ed 240a          	jruge	L124
1433                     ; 296                 temp = key + 0x55;	// Ascii char 0x5C
1435  04ef 7b02          	ld	a,(OFST+1,sp)
1436  04f1 ab55          	add	a,#85
1437  04f3 6b01          	ld	(OFST+0,sp),a
1440  04f5 ac330633      	jpf	L373
1441  04f9               L124:
1442                     ; 298                 temp = key + 0x22;	// Ascii char 0x2A to 0x2B
1444  04f9 7b02          	ld	a,(OFST+1,sp)
1445  04fb ab22          	add	a,#34
1446  04fd 6b01          	ld	(OFST+0,sp),a
1448  04ff ac330633      	jpf	L373
1449  0503               L313:
1450                     ; 300         case 4:
1450                     ; 301             temp = key + 0x41;	// Ascii char 0x41 to 0x4A
1452  0503 7b02          	ld	a,(OFST+1,sp)
1453  0505 ab41          	add	a,#65
1454  0507 6b01          	ld	(OFST+0,sp),a
1456                     ; 302             break;
1458  0509 ac330633      	jpf	L373
1459  050d               L513:
1460                     ; 303         case 5:
1460                     ; 304             temp = key + 0x61;	// Ascii char 0x61 to 0x6A
1462  050d 7b02          	ld	a,(OFST+1,sp)
1463  050f ab61          	add	a,#97
1464  0511 6b01          	ld	(OFST+0,sp),a
1466                     ; 305             break;
1468  0513 ac330633      	jpf	L373
1469  0517               L713:
1470                     ; 306         case 6:
1470                     ; 307             if (key < 7)
1472  0517 7b02          	ld	a,(OFST+1,sp)
1473  0519 a107          	cp	a,#7
1474  051b 240a          	jruge	L524
1475                     ; 308                 temp = key + 0x3A;	// Ascii char 0x3A to 0x40
1477  051d 7b02          	ld	a,(OFST+1,sp)
1478  051f ab3a          	add	a,#58
1479  0521 6b01          	ld	(OFST+0,sp),a
1482  0523 ac330633      	jpf	L373
1483  0527               L524:
1484                     ; 310                 temp = key + 0x71;	// Ascii char 0x78 to 0x7A
1486  0527 7b02          	ld	a,(OFST+1,sp)
1487  0529 ab71          	add	a,#113
1488  052b 6b01          	ld	(OFST+0,sp),a
1490  052d ac330633      	jpf	L373
1491  0531               L123:
1492                     ; 312         case 7:
1492                     ; 313             temp = key + 0x30;	// Ascii char 0x30 to 0x39
1494  0531 7b02          	ld	a,(OFST+1,sp)
1495  0533 ab30          	add	a,#48
1496  0535 6b01          	ld	(OFST+0,sp),a
1498                     ; 314             break;
1500  0537 ac330633      	jpf	L373
1501  053b               L323:
1502                     ; 315         case 8:
1502                     ; 316             temp = key + 0x6B;	// Ascii char 0x6B to 0x74
1504  053b 7b02          	ld	a,(OFST+1,sp)
1505  053d ab6b          	add	a,#107
1506  053f 6b01          	ld	(OFST+0,sp),a
1508                     ; 317             break;
1510  0541 ac330633      	jpf	L373
1511  0545               L523:
1512                     ; 318         case 9:
1512                     ; 319             temp = key + 0x4B;	// Ascii char 0x4B to 0x54
1514  0545 7b02          	ld	a,(OFST+1,sp)
1515  0547 ab4b          	add	a,#75
1516  0549 6b01          	ld	(OFST+0,sp),a
1518                     ; 320             break;
1520  054b ac330633      	jpf	L373
1521  054f               L723:
1522                     ; 321         case 10:
1522                     ; 322             if (key < 1)
1524  054f 0d02          	tnz	(OFST+1,sp)
1525  0551 260a          	jrne	L134
1526                     ; 323                 temp = key + 0x2D;	// Ascii char 0x2D
1528  0553 7b02          	ld	a,(OFST+1,sp)
1529  0555 ab2d          	add	a,#45
1530  0557 6b01          	ld	(OFST+0,sp),a
1533  0559 ac330633      	jpf	L373
1534  055d               L134:
1535                     ; 324             else if (key < 3)
1537  055d 7b02          	ld	a,(OFST+1,sp)
1538  055f a103          	cp	a,#3
1539  0561 240a          	jruge	L534
1540                     ; 325                 temp = key + 0x22;	// Ascii char 0x23 to 0x24
1542  0563 7b02          	ld	a,(OFST+1,sp)
1543  0565 ab22          	add	a,#34
1544  0567 6b01          	ld	(OFST+0,sp),a
1547  0569 ac330633      	jpf	L373
1548  056d               L534:
1549                     ; 326             else if (key < 5)
1551  056d 7b02          	ld	a,(OFST+1,sp)
1552  056f a105          	cp	a,#5
1553  0571 240a          	jruge	L144
1554                     ; 327                 temp = key + 0x27;	// Ascii char 0x2A to 0x2B
1556  0573 7b02          	ld	a,(OFST+1,sp)
1557  0575 ab27          	add	a,#39
1558  0577 6b01          	ld	(OFST+0,sp),a
1561  0579 ac330633      	jpf	L373
1562  057d               L144:
1563                     ; 329                 temp = key + 0x2B;	// Ascii char 0x30 to 0x34
1565  057d 7b02          	ld	a,(OFST+1,sp)
1566  057f ab2b          	add	a,#43
1567  0581 6b01          	ld	(OFST+0,sp),a
1569  0583 ac330633      	jpf	L373
1570  0587               L133:
1571                     ; 331         case 11:
1571                     ; 332             if (key < 4)
1573  0587 7b02          	ld	a,(OFST+1,sp)
1574  0589 a104          	cp	a,#4
1575  058b 240a          	jruge	L544
1576                     ; 333                 temp = key + 0x35;	// Ascii char 0x35 to 0x39
1578  058d 7b02          	ld	a,(OFST+1,sp)
1579  058f ab35          	add	a,#53
1580  0591 6b01          	ld	(OFST+0,sp),a
1583  0593 ac330633      	jpf	L373
1584  0597               L544:
1585                     ; 334             else if (key < 7)
1587  0597 7b02          	ld	a,(OFST+1,sp)
1588  0599 a107          	cp	a,#7
1589  059b 240a          	jruge	L154
1590                     ; 335                 temp = key + 0x50;	// Ascii char 0x54 to 0x56
1592  059d 7b02          	ld	a,(OFST+1,sp)
1593  059f ab50          	add	a,#80
1594  05a1 6b01          	ld	(OFST+0,sp),a
1597  05a3 ac330633      	jpf	L373
1598  05a7               L154:
1599                     ; 337                 temp = key + 0x70;	// Ascii char 0x74 to 0x76
1601  05a7 7b02          	ld	a,(OFST+1,sp)
1602  05a9 ab70          	add	a,#112
1603  05ab 6b01          	ld	(OFST+0,sp),a
1605  05ad ac330633      	jpf	L373
1606  05b1               L333:
1607                     ; 339         case 12:
1607                     ; 340             temp = key + 0x35;	//Ascii char 0x35 to 0x3E
1609  05b1 7b02          	ld	a,(OFST+1,sp)
1610  05b3 ab35          	add	a,#53
1611  05b5 6b01          	ld	(OFST+0,sp),a
1613                     ; 341             break;
1615  05b7 207a          	jra	L373
1616  05b9               L533:
1617                     ; 342         case 13:
1617                     ; 343             temp = key + 0x3F;	// Ascii char 0x3F to 0x48
1619  05b9 7b02          	ld	a,(OFST+1,sp)
1620  05bb ab3f          	add	a,#63
1621  05bd 6b01          	ld	(OFST+0,sp),a
1623                     ; 344             break;
1625  05bf 2072          	jra	L373
1626  05c1               L733:
1627                     ; 345         case 14:
1627                     ; 346             if (key == 0)
1629  05c1 0d02          	tnz	(OFST+1,sp)
1630  05c3 2608          	jrne	L554
1631                     ; 347                 temp = key + 0x21;	// Ascii char 0x21
1633  05c5 7b02          	ld	a,(OFST+1,sp)
1634  05c7 ab21          	add	a,#33
1635  05c9 6b01          	ld	(OFST+0,sp),a
1638  05cb 2066          	jra	L373
1639  05cd               L554:
1640                     ; 348             else if (key == 1 || key == 2)
1642  05cd 7b02          	ld	a,(OFST+1,sp)
1643  05cf a101          	cp	a,#1
1644  05d1 2706          	jreq	L364
1646  05d3 7b02          	ld	a,(OFST+1,sp)
1647  05d5 a102          	cp	a,#2
1648  05d7 2608          	jrne	L164
1649  05d9               L364:
1650                     ; 349                 temp = key + 0x22;	// Ascii char 0x23 to 0x24
1652  05d9 7b02          	ld	a,(OFST+1,sp)
1653  05db ab22          	add	a,#34
1654  05dd 6b01          	ld	(OFST+0,sp),a
1657  05df 2052          	jra	L373
1658  05e1               L164:
1659                     ; 350             else if (key == 3)
1661  05e1 7b02          	ld	a,(OFST+1,sp)
1662  05e3 a103          	cp	a,#3
1663  05e5 2608          	jrne	L764
1664                     ; 351                 temp = key + 0x27;	// Ascii char 0x2A
1666  05e7 7b02          	ld	a,(OFST+1,sp)
1667  05e9 ab27          	add	a,#39
1668  05eb 6b01          	ld	(OFST+0,sp),a
1671  05ed 2044          	jra	L373
1672  05ef               L764:
1673                     ; 352             else if (key == 4 || key == 5)
1675  05ef 7b02          	ld	a,(OFST+1,sp)
1676  05f1 a104          	cp	a,#4
1677  05f3 2706          	jreq	L574
1679  05f5 7b02          	ld	a,(OFST+1,sp)
1680  05f7 a105          	cp	a,#5
1681  05f9 2608          	jrne	L374
1682  05fb               L574:
1683                     ; 353                 temp = key + 0x36;	// Ascii char 0x3A to 0x3B
1685  05fb 7b02          	ld	a,(OFST+1,sp)
1686  05fd ab36          	add	a,#54
1687  05ff 6b01          	ld	(OFST+0,sp),a
1690  0601 2030          	jra	L373
1691  0603               L374:
1692                     ; 354             else if (key == 6 || key == 7)
1694  0603 7b02          	ld	a,(OFST+1,sp)
1695  0605 a106          	cp	a,#6
1696  0607 2706          	jreq	L305
1698  0609 7b02          	ld	a,(OFST+1,sp)
1699  060b a107          	cp	a,#7
1700  060d 2608          	jrne	L105
1701  060f               L305:
1702                     ; 355                 temp = key + 0x39;	// Ascii char 0x3F to 0x40
1704  060f 7b02          	ld	a,(OFST+1,sp)
1705  0611 ab39          	add	a,#57
1706  0613 6b01          	ld	(OFST+0,sp),a
1709  0615 201c          	jra	L373
1710  0617               L105:
1711                     ; 356             else if (key == 8)
1713  0617 7b02          	ld	a,(OFST+1,sp)
1714  0619 a108          	cp	a,#8
1715  061b 2608          	jrne	L705
1716                     ; 357                 temp = key + 0x27;	// Ascii char 0x2F
1718  061d 7b02          	ld	a,(OFST+1,sp)
1719  061f ab27          	add	a,#39
1720  0621 6b01          	ld	(OFST+0,sp),a
1723  0623 200e          	jra	L373
1724  0625               L705:
1725                     ; 359                 temp = key + 0x53;	// Ascii char 0x5C
1727  0625 7b02          	ld	a,(OFST+1,sp)
1728  0627 ab53          	add	a,#83
1729  0629 6b01          	ld	(OFST+0,sp),a
1731  062b 2006          	jra	L373
1732  062d               L143:
1733                     ; 361         default:
1733                     ; 362             temp = key + 70;
1735  062d 7b02          	ld	a,(OFST+1,sp)
1736  062f ab46          	add	a,#70
1737  0631 6b01          	ld	(OFST+0,sp),a
1739                     ; 363             break;
1741  0633               L373:
1742                     ; 365     return temp;
1744  0633 7b01          	ld	a,(OFST+0,sp)
1747  0635 5b03          	addw	sp,#3
1748  0637 81            	ret
1783                     	xdef	_getValue
1784                     	xdef	_passkeyGenerator
1785                     	xdef	_getIMEI
1786                     	xdef	_checkNum
1787                     	xdef	_SIMComrestart
1788                     	xdef	_SIMCom_setup
1789                     	xref.b	_response_buffer
1790                     	xref	_ms_send_cmd
1791                     	switch	.ubsct
1792  0000               _PASS_KEY:
1793  0000 000000000000  	ds.b	16
1794                     	xdef	_PASS_KEY
1795  0010               _aunIMEI:
1796  0010 000000000000  	ds.b	20
1797                     	xdef	_aunIMEI
1798                     	xref	_strlen
1799                     	xref	_delay_ms
1800                     	xref	_UART1_GetFlagStatus
1801                     	xref	_UART1_ReceiveData8
1802                     	xref	_UART1_ITConfig
1803                     	xref	_GPIO_WriteLow
1804                     	xref	_GPIO_WriteHigh
1805                     	switch	.const
1806  002e               L302:
1807  002e 41542b47534e  	dc.b	"AT+GSN",0
1808  0035               L131:
1809  0035 41542b434e55  	dc.b	"AT+CNUM",0
1810  003d               L501:
1811  003d 41542b43504f  	dc.b	"AT+CPOWD=0",0
1812  0048               L37:
1813  0048 41542b425450  	dc.b	"AT+BTPAIRCFG=1,123"
1814  005a 3400          	dc.b	"4",0
1815  005c               L17:
1816  005c 41542b425448  	dc.b	"AT+BTHOST=GENERATO"
1817  006e 522d35353535  	dc.b	"R-555555",0
1818  0077               L76:
1819  0077 41542b425450  	dc.b	"AT+BTPOWER=1",0
1820  0084               L56:
1821  0084 41542b434949  	dc.b	"AT+CIICR",0
1822  008d               L36:
1823  008d 41542b435354  	dc.b	"AT+CSTT=",34
1824  0096 7a6f6e677761  	dc.b	"zongwap",34,0
1825  009f               L16:
1826  009f 41542b434950  	dc.b	"AT+CIPSCONT",0
1827  00ab               L75:
1828  00ab 41542b434950  	dc.b	"AT+CIPHEAD=1",0
1829  00b8               L55:
1830  00b8 41542b434950  	dc.b	"AT+CIPSRIP=1",0
1831  00c5               L35:
1832  00c5 41542b434950  	dc.b	"AT+CIPSPRT=1",0
1833  00d2               L15:
1834  00d2 41542b434950  	dc.b	"AT+CIPQSEND=0",0
1835  00e0               L74:
1836  00e0 41542b434950  	dc.b	"AT+CIPMODE=0",0
1837  00ed               L54:
1838  00ed 41542b434950  	dc.b	"AT+CIPMUX=0",0
1839  00f9               L34:
1840  00f9 41542b434950  	dc.b	"AT+CIPSHUT",0
1841  0104               L14:
1842  0104 41542b534150  	dc.b	"AT+SAPBR=1,1",0
1843  0111               L73:
1844  0111 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
1845  011f 41504e22      	dc.b	"APN",34
1846  0123 2c22          	dc.b	",",34
1847  0125 7a6f6e677761  	dc.b	"zongwap",34,0
1848  012e               L53:
1849  012e 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
1850  013c 434f4e545950  	dc.b	"CONTYPE",34
1851  0144 2c22          	dc.b	",",34
1852  0146 475052532200  	dc.b	"GPRS",34,0
1853  014c               L33:
1854  014c 41542b434741  	dc.b	"AT+CGATT=1",0
1855  0157               L13:
1856  0157 41542b43474e  	dc.b	"AT+CGNSSEQ=RMC",0
1857  0166               L72:
1858  0166 41542b43474e  	dc.b	"AT+CGNSPWR=1",0
1859  0173               L52:
1860  0173 41542b435343  	dc.b	"AT+CSCLK=0",0
1861  017e               L32:
1862  017e 41542b434d47  	dc.b	"AT+CMGD=1,4",0
1863  018a               L12:
1864  018a 4154453000    	dc.b	"ATE0",0
1865                     	xref.b	c_x
1885                     	xref	c_smody
1886                     	xref	c_smodx
1887                     	xref	c_xymvx
1888                     	end
