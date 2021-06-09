   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  50                     ; 51 void SIMCom_setup(void)
  50                     ; 52 {
  52                     	switch	.text
  53  0000               _SIMCom_setup:
  57                     ; 53     delay_ms(100);
  59  0000 ae0064        	ldw	x,#100
  60  0003 cd0000        	call	_delay_ms
  62                     ; 54     SIMComrestart(); //Restart the SIMCOMM 868 module
  64  0006 cd01b4        	call	_SIMComrestart
  66                     ; 55     delay_ms(10000);
  68  0009 ae2710        	ldw	x,#10000
  69  000c cd0000        	call	_delay_ms
  71                     ; 57     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  73  000f 4b04          	push	#4
  74  0011 ae0261        	ldw	x,#L12
  75  0014 cd0000        	call	_ms_send_cmd
  77  0017 84            	pop	a
  78                     ; 58     delay_ms(20000);                                   //need to adjust the delay
  80  0018 ae4e20        	ldw	x,#20000
  81  001b cd0000        	call	_delay_ms
  83                     ; 59     delay_ms(1000);
  85  001e ae03e8        	ldw	x,#1000
  86  0021 cd0000        	call	_delay_ms
  88                     ; 61     ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
  90  0024 4b0b          	push	#11
  91  0026 ae0255        	ldw	x,#L32
  92  0029 cd0000        	call	_ms_send_cmd
  94  002c 84            	pop	a
  95                     ; 62     delay_ms(1000);
  97  002d ae03e8        	ldw	x,#1000
  98  0030 cd0000        	call	_delay_ms
 100                     ; 64     ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
 102  0033 4b0a          	push	#10
 103  0035 ae024a        	ldw	x,#L52
 104  0038 cd0000        	call	_ms_send_cmd
 106  003b 84            	pop	a
 107                     ; 65     delay_ms(1000);
 109  003c ae03e8        	ldw	x,#1000
 110  003f cd0000        	call	_delay_ms
 112                     ; 67     ms_send_cmd(GPS_ON, strlen((const char *)GPS_ON));
 114  0042 4b0c          	push	#12
 115  0044 ae023d        	ldw	x,#L72
 116  0047 cd0000        	call	_ms_send_cmd
 118  004a 84            	pop	a
 119                     ; 68     delay_ms(1000);
 121  004b ae03e8        	ldw	x,#1000
 122  004e cd0000        	call	_delay_ms
 124                     ; 70     ms_send_cmd(rmc, strlen((const char *)rmc));
 126  0051 4b0e          	push	#14
 127  0053 ae022e        	ldw	x,#L13
 128  0056 cd0000        	call	_ms_send_cmd
 130  0059 84            	pop	a
 131                     ; 71     delay_ms(1000);
 133  005a ae03e8        	ldw	x,#1000
 134  005d cd0000        	call	_delay_ms
 136                     ; 73     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
 138  0060 4b04          	push	#4
 139  0062 ae0261        	ldw	x,#L12
 140  0065 cd0000        	call	_ms_send_cmd
 142  0068 84            	pop	a
 143                     ; 74     delay_ms(1000);
 145  0069 ae03e8        	ldw	x,#1000
 146  006c cd0000        	call	_delay_ms
 148                     ; 76     ms_send_cmd("AT+CMEE=2", strlen((const char *)"AT+CMEE=2")); /* No echo */
 150  006f 4b09          	push	#9
 151  0071 ae0224        	ldw	x,#L33
 152  0074 cd0000        	call	_ms_send_cmd
 154  0077 84            	pop	a
 155                     ; 77     delay_ms(1000);
 157  0078 ae03e8        	ldw	x,#1000
 158  007b cd0000        	call	_delay_ms
 160                     ; 79     ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
 162  007e 4b0a          	push	#10
 163  0080 ae0219        	ldw	x,#L53
 164  0083 cd0000        	call	_ms_send_cmd
 166  0086 84            	pop	a
 167                     ; 80     delay_ms(1000);
 169  0087 ae03e8        	ldw	x,#1000
 170  008a cd0000        	call	_delay_ms
 172                     ; 82     ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
 174  008d 4b1d          	push	#29
 175  008f ae01fb        	ldw	x,#L73
 176  0092 cd0000        	call	_ms_send_cmd
 178  0095 84            	pop	a
 179                     ; 83     delay_ms(1000);
 181  0096 ae03e8        	ldw	x,#1000
 182  0099 cd0000        	call	_delay_ms
 184                     ; 85     ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
 186  009c 4b1c          	push	#28
 187  009e ae01de        	ldw	x,#L14
 188  00a1 cd0000        	call	_ms_send_cmd
 190  00a4 84            	pop	a
 191                     ; 86     delay_ms(1000);
 193  00a5 ae03e8        	ldw	x,#1000
 194  00a8 cd0000        	call	_delay_ms
 196                     ; 88     ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
 198  00ab 4b0c          	push	#12
 199  00ad ae01d1        	ldw	x,#L34
 200  00b0 cd0000        	call	_ms_send_cmd
 202  00b3 84            	pop	a
 203                     ; 89     delay_ms(1000);
 205  00b4 ae03e8        	ldw	x,#1000
 206  00b7 cd0000        	call	_delay_ms
 208                     ; 91     ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
 210  00ba 4b0a          	push	#10
 211  00bc ae01c6        	ldw	x,#L54
 212  00bf cd0000        	call	_ms_send_cmd
 214  00c2 84            	pop	a
 215                     ; 92     delay_ms(1000);
 217  00c3 ae03e8        	ldw	x,#1000
 218  00c6 cd0000        	call	_delay_ms
 220                     ; 94     ms_send_cmd(TCP_SINGLE_CONN_MODE, strlen((const char *)TCP_SINGLE_CONN_MODE)); /* OPEN BEARER */
 222  00c9 4b0b          	push	#11
 223  00cb ae01ba        	ldw	x,#L74
 224  00ce cd0000        	call	_ms_send_cmd
 226  00d1 84            	pop	a
 227                     ; 95     delay_ms(1000);
 229  00d2 ae03e8        	ldw	x,#1000
 230  00d5 cd0000        	call	_delay_ms
 232                     ; 97     ms_send_cmd(TCP_NON_TRANSPARENT_MODE, strlen((const char *)TCP_NON_TRANSPARENT_MODE)); /* OPEN BEARER */
 234  00d8 4b0c          	push	#12
 235  00da ae01ad        	ldw	x,#L15
 236  00dd cd0000        	call	_ms_send_cmd
 238  00e0 84            	pop	a
 239                     ; 98     delay_ms(1000);
 241  00e1 ae03e8        	ldw	x,#1000
 242  00e4 cd0000        	call	_delay_ms
 244                     ; 100     ms_send_cmd(TCP_MODE_RESPONSE_NORMAL, strlen((const char *)TCP_MODE_RESPONSE_NORMAL)); /* OPEN BEARER */
 246  00e7 4b0d          	push	#13
 247  00e9 ae019f        	ldw	x,#L35
 248  00ec cd0000        	call	_ms_send_cmd
 250  00ef 84            	pop	a
 251                     ; 101     delay_ms(1000);
 253  00f0 ae03e8        	ldw	x,#1000
 254  00f3 cd0000        	call	_delay_ms
 256                     ; 103     ms_send_cmd(TCP_MODE_SEND_PROMPT_ECHO, strlen((const char *)TCP_MODE_SEND_PROMPT_ECHO)); /* OPEN BEARER */
 258  00f6 4b0c          	push	#12
 259  00f8 ae0192        	ldw	x,#L55
 260  00fb cd0000        	call	_ms_send_cmd
 262  00fe 84            	pop	a
 263                     ; 104     delay_ms(1000);
 265  00ff ae03e8        	ldw	x,#1000
 266  0102 cd0000        	call	_delay_ms
 268                     ; 106     ms_send_cmd(TCP_MODE_REMOTE_IP_PORT_ON, strlen((const char *)TCP_MODE_REMOTE_IP_PORT_ON)); /* OPEN BEARER */
 270  0105 4b0c          	push	#12
 271  0107 ae0185        	ldw	x,#L75
 272  010a cd0000        	call	_ms_send_cmd
 274  010d 84            	pop	a
 275                     ; 107     delay_ms(1000);
 277  010e ae03e8        	ldw	x,#1000
 278  0111 cd0000        	call	_delay_ms
 280                     ; 109     ms_send_cmd(TCP_MODE_HEADER_ON_RECV_ON, strlen((const char *)TCP_MODE_HEADER_ON_RECV_ON)); /* OPEN BEARER */
 282  0114 4b0c          	push	#12
 283  0116 ae0178        	ldw	x,#L16
 284  0119 cd0000        	call	_ms_send_cmd
 286  011c 84            	pop	a
 287                     ; 110     delay_ms(1000);
 289  011d ae03e8        	ldw	x,#1000
 290  0120 cd0000        	call	_delay_ms
 292                     ; 112     ms_send_cmd(TCP_SAVE_CONTEXT, strlen((const char *)TCP_SAVE_CONTEXT)); /* OPEN BEARER */
 294  0123 4b0b          	push	#11
 295  0125 ae016c        	ldw	x,#L36
 296  0128 cd0000        	call	_ms_send_cmd
 298  012b 84            	pop	a
 299                     ; 113     delay_ms(1000);
 301  012c ae03e8        	ldw	x,#1000
 302  012f cd0000        	call	_delay_ms
 304                     ; 115     ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
 306  0132 4b11          	push	#17
 307  0134 ae015a        	ldw	x,#L56
 308  0137 cd0000        	call	_ms_send_cmd
 310  013a 84            	pop	a
 311                     ; 116     delay_ms(1000);
 313  013b ae03e8        	ldw	x,#1000
 314  013e cd0000        	call	_delay_ms
 316                     ; 118     ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
 318  0141 4b08          	push	#8
 319  0143 ae0151        	ldw	x,#L76
 320  0146 cd0000        	call	_ms_send_cmd
 322  0149 84            	pop	a
 323                     ; 119     delay_ms(1000);
 325  014a ae03e8        	ldw	x,#1000
 326  014d cd0000        	call	_delay_ms
 328                     ; 121     ms_send_cmd("AT+CIFSR", strlen((const char *)"AT+CIFSR")); /* OPEN BEARER */
 330  0150 4b08          	push	#8
 331  0152 ae0148        	ldw	x,#L17
 332  0155 cd0000        	call	_ms_send_cmd
 334  0158 84            	pop	a
 335                     ; 122     delay_ms(1000);
 337  0159 ae03e8        	ldw	x,#1000
 338  015c cd0000        	call	_delay_ms
 340                     ; 124     ms_send_cmd(startTCP_CMD, strlen((const char *)startTCP_CMD)); /* OPEN BEARER */
 342  015f 4b29          	push	#41
 343  0161 ae011e        	ldw	x,#L37
 344  0164 cd0000        	call	_ms_send_cmd
 346  0167 84            	pop	a
 347                     ; 125     delay_ms(1000);
 349  0168 ae03e8        	ldw	x,#1000
 350  016b cd0000        	call	_delay_ms
 352                     ; 127     enGet_TCP_Status();
 354  016e cd0773        	call	_enGet_TCP_Status
 356                     ; 128     delay_ms(500);
 358  0171 ae01f4        	ldw	x,#500
 359  0174 cd0000        	call	_delay_ms
 361                     ; 130     getIMEI();
 363  0177 cd0221        	call	_getIMEI
 365                     ; 131     passkeyGenerator();
 367  017a cd02c5        	call	_passkeyGenerator
 369                     ; 132     delay_ms(1000);
 371  017d ae03e8        	ldw	x,#1000
 372  0180 cd0000        	call	_delay_ms
 374                     ; 134     vInit_MQTT();
 376  0183 cd0679        	call	_vInit_MQTT
 378                     ; 136     ms_send_cmd(BT_TURN_ON, strlen((const char *)BT_TURN_ON));
 380  0186 4b0c          	push	#12
 381  0188 ae0111        	ldw	x,#L57
 382  018b cd0000        	call	_ms_send_cmd
 384  018e 84            	pop	a
 385                     ; 137     delay_ms(1000);
 387  018f ae03e8        	ldw	x,#1000
 388  0192 cd0000        	call	_delay_ms
 390                     ; 139     ms_send_cmd(BT_SET_NAME, strlen((const char *)BT_SET_NAME));
 392  0195 4b1a          	push	#26
 393  0197 ae00f6        	ldw	x,#L77
 394  019a cd0000        	call	_ms_send_cmd
 396  019d 84            	pop	a
 397                     ; 140     delay_ms(3000);
 399  019e ae0bb8        	ldw	x,#3000
 400  01a1 cd0000        	call	_delay_ms
 402                     ; 142     ms_send_cmd(BT_SET_PIN, strlen((const char *)BT_SET_PIN));
 404  01a4 4b13          	push	#19
 405  01a6 ae00e2        	ldw	x,#L101
 406  01a9 cd0000        	call	_ms_send_cmd
 408  01ac 84            	pop	a
 409                     ; 143     delay_ms(3000);
 411  01ad ae0bb8        	ldw	x,#3000
 412  01b0 cd0000        	call	_delay_ms
 414                     ; 150 }
 417  01b3 81            	ret
 445                     ; 196 void SIMComrestart()
 445                     ; 197 {
 446                     	switch	.text
 447  01b4               _SIMComrestart:
 451                     ; 198     ms_send_cmd(SIMCom_OFF, strlen((const char *)SIMCom_OFF)); /* Power down the SIMCom module */
 453  01b4 4b0a          	push	#10
 454  01b6 ae00d7        	ldw	x,#L311
 455  01b9 cd0000        	call	_ms_send_cmd
 457  01bc 84            	pop	a
 458                     ; 199     delay_ms(800);
 460  01bd ae0320        	ldw	x,#800
 461  01c0 cd0000        	call	_delay_ms
 463                     ; 201     GPIO_WriteHigh(PWRKEY);
 465  01c3 4b20          	push	#32
 466  01c5 ae500a        	ldw	x,#20490
 467  01c8 cd0000        	call	_GPIO_WriteHigh
 469  01cb 84            	pop	a
 470                     ; 202     delay_ms(1000);
 472  01cc ae03e8        	ldw	x,#1000
 473  01cf cd0000        	call	_delay_ms
 475                     ; 204     GPIO_WriteLow(PWRKEY);
 477  01d2 4b20          	push	#32
 478  01d4 ae500a        	ldw	x,#20490
 479  01d7 cd0000        	call	_GPIO_WriteLow
 481  01da 84            	pop	a
 482                     ; 205     delay_ms(1000);
 484  01db ae03e8        	ldw	x,#1000
 485  01de cd0000        	call	_delay_ms
 487                     ; 206 }
 490  01e1 81            	ret
 538                     ; 208 void checkNum()
 538                     ; 209 {
 539                     	switch	.text
 540  01e2               _checkNum:
 542  01e2 5203          	subw	sp,#3
 543       00000003      OFST:	set	3
 546                     ; 210     uint16_t timeout = 0;
 548  01e4 5f            	clrw	x
 549  01e5 1f01          	ldw	(OFST-2,sp),x
 551                     ; 212     ms_send_cmd(check_num, strlen((const char *)check_num)); // SMS read
 553  01e7 4b07          	push	#7
 554  01e9 ae00cf        	ldw	x,#L731
 555  01ec cd0000        	call	_ms_send_cmd
 557  01ef 84            	pop	a
 558                     ; 214     for (s = 0; s < 75; s++)
 560  01f0 0f03          	clr	(OFST+0,sp)
 562  01f2               L151:
 563                     ; 216         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 565  01f2 ae0020        	ldw	x,#32
 566  01f5 cd0000        	call	_UART1_GetFlagStatus
 568  01f8 4d            	tnz	a
 569  01f9 260c          	jrne	L551
 571  01fb 1e01          	ldw	x,(OFST-2,sp)
 572  01fd 1c0001        	addw	x,#1
 573  0200 1f01          	ldw	(OFST-2,sp),x
 575  0202 a32710        	cpw	x,#10000
 576  0205 26eb          	jrne	L151
 577  0207               L551:
 578                     ; 218         response_buffer[s] = UART1_ReceiveData8();
 580  0207 7b03          	ld	a,(OFST+0,sp)
 581  0209 5f            	clrw	x
 582  020a 97            	ld	xl,a
 583  020b 89            	pushw	x
 584  020c cd0000        	call	_UART1_ReceiveData8
 586  020f 85            	popw	x
 587  0210 d70000        	ld	(_response_buffer,x),a
 588                     ; 219         timeout = 0;
 590  0213 5f            	clrw	x
 591  0214 1f01          	ldw	(OFST-2,sp),x
 593                     ; 214     for (s = 0; s < 75; s++)
 595  0216 0c03          	inc	(OFST+0,sp)
 599  0218 7b03          	ld	a,(OFST+0,sp)
 600  021a a14b          	cp	a,#75
 601  021c 25d4          	jrult	L151
 602                     ; 221 }
 605  021e 5b03          	addw	sp,#3
 606  0220 81            	ret
 675                     ; 223 void getIMEI(void)
 675                     ; 224 {
 676                     	switch	.text
 677  0221               _getIMEI:
 679  0221 521d          	subw	sp,#29
 680       0000001d      OFST:	set	29
 683                     ; 230     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 685  0223 4b00          	push	#0
 686  0225 ae0255        	ldw	x,#597
 687  0228 cd0000        	call	_UART1_ITConfig
 689  022b 84            	pop	a
 690                     ; 231     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 692  022c 4b00          	push	#0
 693  022e ae0244        	ldw	x,#580
 694  0231 cd0000        	call	_UART1_ITConfig
 696  0234 84            	pop	a
 697                     ; 233     ms_send_cmd(IMEIcmnd, strlen((const char *)IMEIcmnd)); //"AT+HTTPSSL=1"
 699  0235 4b06          	push	#6
 700  0237 ae00c8        	ldw	x,#L112
 701  023a cd0000        	call	_ms_send_cmd
 703  023d 84            	pop	a
 704                     ; 236     for (i = 0; i < 25; i++)
 706  023e 0f1d          	clr	(OFST+0,sp)
 708  0240               L322:
 709                     ; 238         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++ulTimout != 10000))
 711  0240 ae0020        	ldw	x,#32
 712  0243 cd0000        	call	_UART1_GetFlagStatus
 714  0246 4d            	tnz	a
 715  0247 260c          	jrne	L722
 717  0249 1e1a          	ldw	x,(OFST-3,sp)
 718  024b 1c0001        	addw	x,#1
 719  024e 1f1a          	ldw	(OFST-3,sp),x
 721  0250 a32710        	cpw	x,#10000
 722  0253 26eb          	jrne	L322
 723  0255               L722:
 724                     ; 240         localBuffer[i] = UART1_ReceiveData8();
 726  0255 96            	ldw	x,sp
 727  0256 1c0001        	addw	x,#OFST-28
 728  0259 9f            	ld	a,xl
 729  025a 5e            	swapw	x
 730  025b 1b1d          	add	a,(OFST+0,sp)
 731  025d 2401          	jrnc	L41
 732  025f 5c            	incw	x
 733  0260               L41:
 734  0260 02            	rlwa	x,a
 735  0261 89            	pushw	x
 736  0262 cd0000        	call	_UART1_ReceiveData8
 738  0265 85            	popw	x
 739  0266 f7            	ld	(x),a
 740                     ; 241         ulTimout = 0;
 742  0267 5f            	clrw	x
 743  0268 1f1a          	ldw	(OFST-3,sp),x
 745                     ; 236     for (i = 0; i < 25; i++)
 747  026a 0c1d          	inc	(OFST+0,sp)
 751  026c 7b1d          	ld	a,(OFST+0,sp)
 752  026e a119          	cp	a,#25
 753  0270 25ce          	jrult	L322
 754                     ; 243     localBuffer[i] = '\0';
 756  0272 96            	ldw	x,sp
 757  0273 1c0001        	addw	x,#OFST-28
 758  0276 9f            	ld	a,xl
 759  0277 5e            	swapw	x
 760  0278 1b1d          	add	a,(OFST+0,sp)
 761  027a 2401          	jrnc	L61
 762  027c 5c            	incw	x
 763  027d               L61:
 764  027d 02            	rlwa	x,a
 765  027e 7f            	clr	(x)
 766                     ; 244     j = 0;
 768  027f 0f1c          	clr	(OFST-1,sp)
 770                     ; 245     for (i = 2; i < 17; i++)
 772  0281 a602          	ld	a,#2
 773  0283 6b1d          	ld	(OFST+0,sp),a
 775  0285               L132:
 776                     ; 247         aunIMEI[j] = localBuffer[i];
 778  0285 7b1c          	ld	a,(OFST-1,sp)
 779  0287 5f            	clrw	x
 780  0288 97            	ld	xl,a
 781  0289 89            	pushw	x
 782  028a 96            	ldw	x,sp
 783  028b 1c0003        	addw	x,#OFST-26
 784  028e 9f            	ld	a,xl
 785  028f 5e            	swapw	x
 786  0290 1b1f          	add	a,(OFST+2,sp)
 787  0292 2401          	jrnc	L02
 788  0294 5c            	incw	x
 789  0295               L02:
 790  0295 02            	rlwa	x,a
 791  0296 f6            	ld	a,(x)
 792  0297 85            	popw	x
 793  0298 e710          	ld	(_aunIMEI,x),a
 794                     ; 248         j++;
 796  029a 0c1c          	inc	(OFST-1,sp)
 798                     ; 245     for (i = 2; i < 17; i++)
 800  029c 0c1d          	inc	(OFST+0,sp)
 804  029e 7b1d          	ld	a,(OFST+0,sp)
 805  02a0 a111          	cp	a,#17
 806  02a2 25e1          	jrult	L132
 807                     ; 250     aunIMEI[j] = '\0';
 809  02a4 7b1c          	ld	a,(OFST-1,sp)
 810  02a6 5f            	clrw	x
 811  02a7 97            	ld	xl,a
 812  02a8 6f10          	clr	(_aunIMEI,x)
 813                     ; 251     delay_ms(200);
 815  02aa ae00c8        	ldw	x,#200
 816  02ad cd0000        	call	_delay_ms
 818                     ; 253     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 820  02b0 4b01          	push	#1
 821  02b2 ae0255        	ldw	x,#597
 822  02b5 cd0000        	call	_UART1_ITConfig
 824  02b8 84            	pop	a
 825                     ; 254     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
 827  02b9 4b01          	push	#1
 828  02bb ae0244        	ldw	x,#580
 829  02be cd0000        	call	_UART1_ITConfig
 831  02c1 84            	pop	a
 832                     ; 255 }
 835  02c2 5b1d          	addw	sp,#29
 836  02c4 81            	ret
 839                     .const:	section	.text
 840  0000               L732_temp:
 841  0000 00            	dc.b	0
 842  0001 00            	dc.b	0
 843  0002 00            	dc.b	0
 844  0003 00            	dc.b	0
 845  0004 00            	dc.b	0
 846  0005 00            	dc.b	0
 847  0006 00            	dc.b	0
 848  0007 00            	dc.b	0
 849  0008 00            	dc.b	0
 850  0009 00            	dc.b	0
 851  000a 00            	dc.b	0
 852  000b 00            	dc.b	0
 853  000c 00            	dc.b	0
 854  000d 00            	dc.b	0
 855  000e 00            	dc.b	0
 856  000f 00            	ds.b	1
 913                     ; 257 void passkeyGenerator()
 913                     ; 258 {
 914                     	switch	.text
 915  02c5               _passkeyGenerator:
 917  02c5 5227          	subw	sp,#39
 918       00000027      OFST:	set	39
 921                     ; 259     uint8_t temp[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
 923  02c7 96            	ldw	x,sp
 924  02c8 1c0016        	addw	x,#OFST-17
 925  02cb 90ae0000      	ldw	y,#L732_temp
 926  02cf a610          	ld	a,#16
 927  02d1 cd0000        	call	c_xymvx
 929                     ; 260     uint8_t i = 0;
 931                     ; 261     uint8_t checksum = 0;
 933  02d4 0f26          	clr	(OFST-1,sp)
 935                     ; 263     for (i = 0; i < 15; i++)
 937  02d6 0f27          	clr	(OFST+0,sp)
 939  02d8               L762:
 940                     ; 265         checksum ^= aunIMEI[i];
 942  02d8 7b27          	ld	a,(OFST+0,sp)
 943  02da 5f            	clrw	x
 944  02db 97            	ld	xl,a
 945  02dc 7b26          	ld	a,(OFST-1,sp)
 946  02de e810          	xor	a,	(_aunIMEI,x)
 947  02e0 6b26          	ld	(OFST-1,sp),a
 949                     ; 263     for (i = 0; i < 15; i++)
 951  02e2 0c27          	inc	(OFST+0,sp)
 955  02e4 7b27          	ld	a,(OFST+0,sp)
 956  02e6 a10f          	cp	a,#15
 957  02e8 25ee          	jrult	L762
 958                     ; 267     for (i = 0; i < 15; i++)
 960  02ea 0f27          	clr	(OFST+0,sp)
 962  02ec               L572:
 964  02ec 7b27          	ld	a,(OFST+0,sp)
 965  02ee 5f            	clrw	x
 966  02ef 97            	ld	xl,a
 967  02f0 1c000c        	addw	x,#12
 968  02f3 a60f          	ld	a,#15
 969  02f5 cd0000        	call	c_smodx
 971  02f8 e610          	ld	a,(_aunIMEI,x)
 972  02fa 6b13          	ld	(OFST-20,sp),a
 974  02fc 7b27          	ld	a,(OFST+0,sp)
 975  02fe 5f            	clrw	x
 976  02ff 97            	ld	xl,a
 977  0300 1c000d        	addw	x,#13
 978  0303 a60f          	ld	a,#15
 979  0305 cd0000        	call	c_smodx
 981  0308 e610          	ld	a,(_aunIMEI,x)
 982  030a 5f            	clrw	x
 983  030b 1b13          	add	a,(OFST-20,sp)
 984  030d 2401          	jrnc	L42
 985  030f 5c            	incw	x
 986  0310               L42:
 987  0310 02            	rlwa	x,a
 988  0311 1f11          	ldw	(OFST-22,sp),x
 989  0313 01            	rrwa	x,a
 991  0314 7b27          	ld	a,(OFST+0,sp)
 992  0316 5f            	clrw	x
 993  0317 97            	ld	xl,a
 994  0318 1c000a        	addw	x,#10
 995  031b a60f          	ld	a,#15
 996  031d cd0000        	call	c_smodx
 998  0320 e610          	ld	a,(_aunIMEI,x)
 999  0322 6b10          	ld	(OFST-23,sp),a
1001  0324 7b27          	ld	a,(OFST+0,sp)
1002  0326 5f            	clrw	x
1003  0327 97            	ld	xl,a
1004  0328 1c000b        	addw	x,#11
1005  032b a60f          	ld	a,#15
1006  032d cd0000        	call	c_smodx
1008  0330 e610          	ld	a,(_aunIMEI,x)
1009  0332 5f            	clrw	x
1010  0333 1b10          	add	a,(OFST-23,sp)
1011  0335 2401          	jrnc	L62
1012  0337 5c            	incw	x
1013  0338               L62:
1014  0338 02            	rlwa	x,a
1015  0339 1f0e          	ldw	(OFST-25,sp),x
1016  033b 01            	rrwa	x,a
1018  033c 7b27          	ld	a,(OFST+0,sp)
1019  033e 5f            	clrw	x
1020  033f 97            	ld	xl,a
1021  0340 1c0008        	addw	x,#8
1022  0343 a60f          	ld	a,#15
1023  0345 cd0000        	call	c_smodx
1025  0348 e610          	ld	a,(_aunIMEI,x)
1026  034a 6b0d          	ld	(OFST-26,sp),a
1028  034c 7b27          	ld	a,(OFST+0,sp)
1029  034e 5f            	clrw	x
1030  034f 97            	ld	xl,a
1031  0350 1c0009        	addw	x,#9
1032  0353 a60f          	ld	a,#15
1033  0355 cd0000        	call	c_smodx
1035  0358 e610          	ld	a,(_aunIMEI,x)
1036  035a 5f            	clrw	x
1037  035b 1b0d          	add	a,(OFST-26,sp)
1038  035d 2401          	jrnc	L03
1039  035f 5c            	incw	x
1040  0360               L03:
1041  0360 02            	rlwa	x,a
1042  0361 1f0b          	ldw	(OFST-28,sp),x
1043  0363 01            	rrwa	x,a
1045  0364 7b27          	ld	a,(OFST+0,sp)
1046  0366 5f            	clrw	x
1047  0367 97            	ld	xl,a
1048  0368 1c0006        	addw	x,#6
1049  036b a60f          	ld	a,#15
1050  036d cd0000        	call	c_smodx
1052  0370 e610          	ld	a,(_aunIMEI,x)
1053  0372 6b0a          	ld	(OFST-29,sp),a
1055  0374 7b27          	ld	a,(OFST+0,sp)
1056  0376 5f            	clrw	x
1057  0377 97            	ld	xl,a
1058  0378 1c0007        	addw	x,#7
1059  037b a60f          	ld	a,#15
1060  037d cd0000        	call	c_smodx
1062  0380 e610          	ld	a,(_aunIMEI,x)
1063  0382 5f            	clrw	x
1064  0383 1b0a          	add	a,(OFST-29,sp)
1065  0385 2401          	jrnc	L23
1066  0387 5c            	incw	x
1067  0388               L23:
1068  0388 02            	rlwa	x,a
1069  0389 1f08          	ldw	(OFST-31,sp),x
1070  038b 01            	rrwa	x,a
1072  038c 7b27          	ld	a,(OFST+0,sp)
1073  038e 5f            	clrw	x
1074  038f 97            	ld	xl,a
1075  0390 1c0004        	addw	x,#4
1076  0393 a60f          	ld	a,#15
1077  0395 cd0000        	call	c_smodx
1079  0398 e610          	ld	a,(_aunIMEI,x)
1080  039a 6b07          	ld	(OFST-32,sp),a
1082  039c 7b27          	ld	a,(OFST+0,sp)
1083  039e 5f            	clrw	x
1084  039f 97            	ld	xl,a
1085  03a0 1c0005        	addw	x,#5
1086  03a3 a60f          	ld	a,#15
1087  03a5 cd0000        	call	c_smodx
1089  03a8 e610          	ld	a,(_aunIMEI,x)
1090  03aa 5f            	clrw	x
1091  03ab 1b07          	add	a,(OFST-32,sp)
1092  03ad 2401          	jrnc	L43
1093  03af 5c            	incw	x
1094  03b0               L43:
1095  03b0 02            	rlwa	x,a
1096  03b1 1f05          	ldw	(OFST-34,sp),x
1097  03b3 01            	rrwa	x,a
1099  03b4 7b27          	ld	a,(OFST+0,sp)
1100  03b6 5f            	clrw	x
1101  03b7 97            	ld	xl,a
1102  03b8 5c            	incw	x
1103  03b9 5c            	incw	x
1104  03ba a60f          	ld	a,#15
1105  03bc cd0000        	call	c_smodx
1107  03bf e610          	ld	a,(_aunIMEI,x)
1108  03c1 6b04          	ld	(OFST-35,sp),a
1110  03c3 7b27          	ld	a,(OFST+0,sp)
1111  03c5 5f            	clrw	x
1112  03c6 97            	ld	xl,a
1113  03c7 1c0003        	addw	x,#3
1114  03ca a60f          	ld	a,#15
1115  03cc cd0000        	call	c_smodx
1117  03cf e610          	ld	a,(_aunIMEI,x)
1118  03d1 5f            	clrw	x
1119  03d2 1b04          	add	a,(OFST-35,sp)
1120  03d4 2401          	jrnc	L63
1121  03d6 5c            	incw	x
1122  03d7               L63:
1123  03d7 02            	rlwa	x,a
1124  03d8 1f02          	ldw	(OFST-37,sp),x
1125  03da 01            	rrwa	x,a
1127  03db 7b27          	ld	a,(OFST+0,sp)
1128  03dd 5f            	clrw	x
1129  03de 97            	ld	xl,a
1130  03df e610          	ld	a,(_aunIMEI,x)
1131  03e1 6b01          	ld	(OFST-38,sp),a
1133  03e3 7b27          	ld	a,(OFST+0,sp)
1134  03e5 5f            	clrw	x
1135  03e6 97            	ld	xl,a
1136  03e7 5c            	incw	x
1137  03e8 a60f          	ld	a,#15
1138  03ea cd0000        	call	c_smodx
1140  03ed e610          	ld	a,(_aunIMEI,x)
1141  03ef 5f            	clrw	x
1142  03f0 1b01          	add	a,(OFST-38,sp)
1143  03f2 2401          	jrnc	L04
1144  03f4 5c            	incw	x
1145  03f5               L04:
1146  03f5 1803          	xor	a,(OFST-36,sp)
1147  03f7 41            	exg	a,xl
1148  03f8 1802          	xor	a,(OFST-37,sp)
1149  03fa 41            	exg	a,xl
1150  03fb 1806          	xor	a,(OFST-33,sp)
1151  03fd 41            	exg	a,xl
1152  03fe 1805          	xor	a,(OFST-34,sp)
1153  0400 41            	exg	a,xl
1154  0401 1809          	xor	a,(OFST-30,sp)
1155  0403 41            	exg	a,xl
1156  0404 1808          	xor	a,(OFST-31,sp)
1157  0406 41            	exg	a,xl
1158  0407 180c          	xor	a,(OFST-27,sp)
1159  0409 41            	exg	a,xl
1160  040a 180b          	xor	a,(OFST-28,sp)
1161  040c 41            	exg	a,xl
1162  040d 180f          	xor	a,(OFST-24,sp)
1163  040f 41            	exg	a,xl
1164  0410 180e          	xor	a,(OFST-25,sp)
1165  0412 41            	exg	a,xl
1166  0413 1812          	xor	a,(OFST-21,sp)
1167  0415 41            	exg	a,xl
1168  0416 1811          	xor	a,(OFST-22,sp)
1169  0418 41            	exg	a,xl
1170  0419 02            	rlwa	x,a
1171  041a 1f14          	ldw	(OFST-19,sp),x
1172  041c 01            	rrwa	x,a
1174                     ; 269         temp[i] = ((aunIMEI[i] + aunIMEI[(i + 1) % 15]) ^ (aunIMEI[(i + 2) % 15] + aunIMEI[(i + 3) % 15]) ^ (aunIMEI[(i + 4) % 15] + aunIMEI[(i + 5) % 15]) ^ (aunIMEI[(i + 6) % 15] + aunIMEI[(i + 7) % 15]) ^ (aunIMEI[(i + 8) % 15] + aunIMEI[(i + 9) % 15]) ^ (aunIMEI[(i + 10) % 15] + aunIMEI[(i + 11) % 15]) ^ (aunIMEI[(i + 12) % 15] + aunIMEI[(i + 13) % 15]) ^ (aunIMEI[(i + 14) % 15] + checksum)) % 10;
1175  041d 96            	ldw	x,sp
1176  041e 1c0016        	addw	x,#OFST-17
1177  0421 9f            	ld	a,xl
1178  0422 5e            	swapw	x
1179  0423 1b27          	add	a,(OFST+0,sp)
1180  0425 2401          	jrnc	L24
1181  0427 5c            	incw	x
1182  0428               L24:
1183  0428 02            	rlwa	x,a
1184  0429 89            	pushw	x
1185  042a 7b29          	ld	a,(OFST+2,sp)
1186  042c 5f            	clrw	x
1187  042d 97            	ld	xl,a
1188  042e 1c000e        	addw	x,#14
1189  0431 a60f          	ld	a,#15
1190  0433 cd0000        	call	c_smodx
1192  0436 e610          	ld	a,(_aunIMEI,x)
1193  0438 5f            	clrw	x
1194  0439 1b28          	add	a,(OFST+1,sp)
1195  043b 2401          	jrnc	L44
1196  043d 5c            	incw	x
1197  043e               L44:
1198  043e 02            	rlwa	x,a
1199  043f 1f14          	ldw	(OFST-19,sp),x
1200  0441 01            	rrwa	x,a
1202  0442 1e16          	ldw	x,(OFST-17,sp)
1203  0444 01            	rrwa	x,a
1204  0445 1815          	xor	a,(OFST-18,sp)
1205  0447 01            	rrwa	x,a
1206  0448 1814          	xor	a,(OFST-19,sp)
1207  044a 01            	rrwa	x,a
1208  044b a60a          	ld	a,#10
1209  044d cd0000        	call	c_smodx
1211  0450 9085          	popw	y
1212  0452 01            	rrwa	x,a
1213  0453 90f7          	ld	(y),a
1214  0455 02            	rlwa	x,a
1215                     ; 267     for (i = 0; i < 15; i++)
1217  0456 0c27          	inc	(OFST+0,sp)
1221  0458 7b27          	ld	a,(OFST+0,sp)
1222  045a a10f          	cp	a,#15
1223  045c 2403          	jruge	L05
1224  045e cc02ec        	jp	L572
1225  0461               L05:
1226                     ; 272     for (i = 0; i < 15; i++)
1228  0461 0f27          	clr	(OFST+0,sp)
1230  0463               L303:
1231                     ; 274         PASS_KEY[i] = getValue(temp[i], i);
1233  0463 7b27          	ld	a,(OFST+0,sp)
1234  0465 5f            	clrw	x
1235  0466 97            	ld	xl,a
1236  0467 89            	pushw	x
1237  0468 7b29          	ld	a,(OFST+2,sp)
1238  046a 97            	ld	xl,a
1239  046b 89            	pushw	x
1240  046c 96            	ldw	x,sp
1241  046d 1c001a        	addw	x,#OFST-13
1242  0470 9f            	ld	a,xl
1243  0471 5e            	swapw	x
1244  0472 1b2b          	add	a,(OFST+4,sp)
1245  0474 2401          	jrnc	L64
1246  0476 5c            	incw	x
1247  0477               L64:
1248  0477 02            	rlwa	x,a
1249  0478 f6            	ld	a,(x)
1250  0479 85            	popw	x
1251  047a 95            	ld	xh,a
1252  047b ad2f          	call	_getValue
1254  047d 85            	popw	x
1255  047e e700          	ld	(_PASS_KEY,x),a
1256                     ; 272     for (i = 0; i < 15; i++)
1258  0480 0c27          	inc	(OFST+0,sp)
1262  0482 7b27          	ld	a,(OFST+0,sp)
1263  0484 a10f          	cp	a,#15
1264  0486 25db          	jrult	L303
1265                     ; 276     PASS_KEY[i] = '\0';
1267  0488 7b27          	ld	a,(OFST+0,sp)
1268  048a 5f            	clrw	x
1269  048b 97            	ld	xl,a
1270  048c 6f00          	clr	(_PASS_KEY,x)
1271                     ; 277     delay_ms(200);
1273  048e ae00c8        	ldw	x,#200
1274  0491 cd0000        	call	_delay_ms
1276                     ; 278     ms_send_cmd(PASS_KEY, strlen((const char *)PASS_KEY));
1278  0494 ae0000        	ldw	x,#_PASS_KEY
1279  0497 cd0000        	call	_strlen
1281  049a 9f            	ld	a,xl
1282  049b 88            	push	a
1283  049c ae0000        	ldw	x,#_PASS_KEY
1284  049f cd0000        	call	_ms_send_cmd
1286  04a2 84            	pop	a
1287                     ; 279     delay_ms(200);
1289  04a3 ae00c8        	ldw	x,#200
1290  04a6 cd0000        	call	_delay_ms
1292                     ; 280 }
1295  04a9 5b27          	addw	sp,#39
1296  04ab 81            	ret
1348                     	switch	.const
1349  0010               L65:
1350  0010 04be          	dc.w	L113
1351  0012 04d8          	dc.w	L313
1352  0014 04e2          	dc.w	L513
1353  0016 04fc          	dc.w	L713
1354  0018 0544          	dc.w	L123
1355  001a 054e          	dc.w	L323
1356  001c 0558          	dc.w	L523
1357  001e 0572          	dc.w	L723
1358  0020 057c          	dc.w	L133
1359  0022 0586          	dc.w	L333
1360  0024 0590          	dc.w	L533
1361  0026 05c8          	dc.w	L733
1362  0028 05f2          	dc.w	L143
1363  002a 05fa          	dc.w	L343
1364  002c 0602          	dc.w	L543
1365                     ; 282 uint8_t getValue(uint8_t key, uint8_t pos)
1365                     ; 283 {
1366                     	switch	.text
1367  04ac               _getValue:
1369  04ac 89            	pushw	x
1370  04ad 88            	push	a
1371       00000001      OFST:	set	1
1374                     ; 286     switch (pos)
1376  04ae 9f            	ld	a,xl
1378                     ; 378         break;
1379  04af a10f          	cp	a,#15
1380  04b1 2407          	jruge	L45
1381  04b3 5f            	clrw	x
1382  04b4 97            	ld	xl,a
1383  04b5 58            	sllw	x
1384  04b6 de0010        	ldw	x,(L65,x)
1385  04b9 fc            	jp	(x)
1386  04ba               L45:
1387  04ba ac6e066e      	jpf	L743
1388  04be               L113:
1389                     ; 288     case 0:
1389                     ; 289         if (key < 5)
1391  04be 7b02          	ld	a,(OFST+1,sp)
1392  04c0 a105          	cp	a,#5
1393  04c2 240a          	jruge	L304
1394                     ; 290             temp = key + 0x56; // Ascii char from 0x56 to 0x5A
1396  04c4 7b02          	ld	a,(OFST+1,sp)
1397  04c6 ab56          	add	a,#86
1398  04c8 6b01          	ld	(OFST+0,sp),a
1401  04ca ac740674      	jpf	L104
1402  04ce               L304:
1403                     ; 292             temp = key + 0x71; // Ascii char from 0x76 to 0x7A
1405  04ce 7b02          	ld	a,(OFST+1,sp)
1406  04d0 ab71          	add	a,#113
1407  04d2 6b01          	ld	(OFST+0,sp),a
1409  04d4 ac740674      	jpf	L104
1410  04d8               L313:
1411                     ; 294     case 1:
1411                     ; 295         temp = key + 0x30; // Ascii char 0x30 to 0x39
1413  04d8 7b02          	ld	a,(OFST+1,sp)
1414  04da ab30          	add	a,#48
1415  04dc 6b01          	ld	(OFST+0,sp),a
1417                     ; 296         break;
1419  04de ac740674      	jpf	L104
1420  04e2               L513:
1421                     ; 297     case 2:
1421                     ; 298         if (key < 5)
1423  04e2 7b02          	ld	a,(OFST+1,sp)
1424  04e4 a105          	cp	a,#5
1425  04e6 240a          	jruge	L704
1426                     ; 299             temp = key + 0x35; // Ascii char from 0x35 to 0x39
1428  04e8 7b02          	ld	a,(OFST+1,sp)
1429  04ea ab35          	add	a,#53
1430  04ec 6b01          	ld	(OFST+0,sp),a
1433  04ee ac740674      	jpf	L104
1434  04f2               L704:
1435                     ; 301             temp = key + 0x3C; // Ascii char from 0x41 to 0x45
1437  04f2 7b02          	ld	a,(OFST+1,sp)
1438  04f4 ab3c          	add	a,#60
1439  04f6 6b01          	ld	(OFST+0,sp),a
1441  04f8 ac740674      	jpf	L104
1442  04fc               L713:
1443                     ; 303     case 3:
1443                     ; 304         if (key < 1)
1445  04fc 0d02          	tnz	(OFST+1,sp)
1446  04fe 260a          	jrne	L314
1447                     ; 305             temp = key + 0x21; // Ascii char 0x21
1449  0500 7b02          	ld	a,(OFST+1,sp)
1450  0502 ab21          	add	a,#33
1451  0504 6b01          	ld	(OFST+0,sp),a
1454  0506 ac740674      	jpf	L104
1455  050a               L314:
1456                     ; 306         else if (key < 5)
1458  050a 7b02          	ld	a,(OFST+1,sp)
1459  050c a105          	cp	a,#5
1460  050e 240a          	jruge	L714
1461                     ; 307             temp = key + 0x22; // Ascii char from 0x23 to 0x26
1463  0510 7b02          	ld	a,(OFST+1,sp)
1464  0512 ab22          	add	a,#34
1465  0514 6b01          	ld	(OFST+0,sp),a
1468  0516 ac740674      	jpf	L104
1469  051a               L714:
1470                     ; 308         else if (key < 7)
1472  051a 7b02          	ld	a,(OFST+1,sp)
1473  051c a107          	cp	a,#7
1474  051e 240a          	jruge	L324
1475                     ; 309             temp = key + 0x29; // Ascii char 0x2F
1477  0520 7b02          	ld	a,(OFST+1,sp)
1478  0522 ab29          	add	a,#41
1479  0524 6b01          	ld	(OFST+0,sp),a
1482  0526 ac740674      	jpf	L104
1483  052a               L324:
1484                     ; 310         else if (key < 8)
1486  052a 7b02          	ld	a,(OFST+1,sp)
1487  052c a108          	cp	a,#8
1488  052e 240a          	jruge	L724
1489                     ; 311             temp = key + 0x55; // Ascii char 0x5C
1491  0530 7b02          	ld	a,(OFST+1,sp)
1492  0532 ab55          	add	a,#85
1493  0534 6b01          	ld	(OFST+0,sp),a
1496  0536 ac740674      	jpf	L104
1497  053a               L724:
1498                     ; 313             temp = key + 0x22; // Ascii char 0x2A to 0x2B
1500  053a 7b02          	ld	a,(OFST+1,sp)
1501  053c ab22          	add	a,#34
1502  053e 6b01          	ld	(OFST+0,sp),a
1504  0540 ac740674      	jpf	L104
1505  0544               L123:
1506                     ; 315     case 4:
1506                     ; 316         temp = key + 0x41; // Ascii char 0x41 to 0x4A
1508  0544 7b02          	ld	a,(OFST+1,sp)
1509  0546 ab41          	add	a,#65
1510  0548 6b01          	ld	(OFST+0,sp),a
1512                     ; 317         break;
1514  054a ac740674      	jpf	L104
1515  054e               L323:
1516                     ; 318     case 5:
1516                     ; 319         temp = key + 0x61; // Ascii char 0x61 to 0x6A
1518  054e 7b02          	ld	a,(OFST+1,sp)
1519  0550 ab61          	add	a,#97
1520  0552 6b01          	ld	(OFST+0,sp),a
1522                     ; 320         break;
1524  0554 ac740674      	jpf	L104
1525  0558               L523:
1526                     ; 321     case 6:
1526                     ; 322         if (key < 7)
1528  0558 7b02          	ld	a,(OFST+1,sp)
1529  055a a107          	cp	a,#7
1530  055c 240a          	jruge	L334
1531                     ; 323             temp = key + 0x3A; // Ascii char 0x3A to 0x40
1533  055e 7b02          	ld	a,(OFST+1,sp)
1534  0560 ab3a          	add	a,#58
1535  0562 6b01          	ld	(OFST+0,sp),a
1538  0564 ac740674      	jpf	L104
1539  0568               L334:
1540                     ; 325             temp = key + 0x71; // Ascii char 0x78 to 0x7A
1542  0568 7b02          	ld	a,(OFST+1,sp)
1543  056a ab71          	add	a,#113
1544  056c 6b01          	ld	(OFST+0,sp),a
1546  056e ac740674      	jpf	L104
1547  0572               L723:
1548                     ; 327     case 7:
1548                     ; 328         temp = key + 0x30; // Ascii char 0x30 to 0x39
1550  0572 7b02          	ld	a,(OFST+1,sp)
1551  0574 ab30          	add	a,#48
1552  0576 6b01          	ld	(OFST+0,sp),a
1554                     ; 329         break;
1556  0578 ac740674      	jpf	L104
1557  057c               L133:
1558                     ; 330     case 8:
1558                     ; 331         temp = key + 0x6B; // Ascii char 0x6B to 0x74
1560  057c 7b02          	ld	a,(OFST+1,sp)
1561  057e ab6b          	add	a,#107
1562  0580 6b01          	ld	(OFST+0,sp),a
1564                     ; 332         break;
1566  0582 ac740674      	jpf	L104
1567  0586               L333:
1568                     ; 333     case 9:
1568                     ; 334         temp = key + 0x4B; // Ascii char 0x4B to 0x54
1570  0586 7b02          	ld	a,(OFST+1,sp)
1571  0588 ab4b          	add	a,#75
1572  058a 6b01          	ld	(OFST+0,sp),a
1574                     ; 335         break;
1576  058c ac740674      	jpf	L104
1577  0590               L533:
1578                     ; 336     case 10:
1578                     ; 337         if (key < 1)
1580  0590 0d02          	tnz	(OFST+1,sp)
1581  0592 260a          	jrne	L734
1582                     ; 338             temp = key + 0x2D; // Ascii char 0x2D
1584  0594 7b02          	ld	a,(OFST+1,sp)
1585  0596 ab2d          	add	a,#45
1586  0598 6b01          	ld	(OFST+0,sp),a
1589  059a ac740674      	jpf	L104
1590  059e               L734:
1591                     ; 339         else if (key < 3)
1593  059e 7b02          	ld	a,(OFST+1,sp)
1594  05a0 a103          	cp	a,#3
1595  05a2 240a          	jruge	L344
1596                     ; 340             temp = key + 0x22; // Ascii char 0x23 to 0x24
1598  05a4 7b02          	ld	a,(OFST+1,sp)
1599  05a6 ab22          	add	a,#34
1600  05a8 6b01          	ld	(OFST+0,sp),a
1603  05aa ac740674      	jpf	L104
1604  05ae               L344:
1605                     ; 341         else if (key < 5)
1607  05ae 7b02          	ld	a,(OFST+1,sp)
1608  05b0 a105          	cp	a,#5
1609  05b2 240a          	jruge	L744
1610                     ; 342             temp = key + 0x27; // Ascii char 0x2A to 0x2B
1612  05b4 7b02          	ld	a,(OFST+1,sp)
1613  05b6 ab27          	add	a,#39
1614  05b8 6b01          	ld	(OFST+0,sp),a
1617  05ba ac740674      	jpf	L104
1618  05be               L744:
1619                     ; 344             temp = key + 0x2B; // Ascii char 0x30 to 0x34
1621  05be 7b02          	ld	a,(OFST+1,sp)
1622  05c0 ab2b          	add	a,#43
1623  05c2 6b01          	ld	(OFST+0,sp),a
1625  05c4 ac740674      	jpf	L104
1626  05c8               L733:
1627                     ; 346     case 11:
1627                     ; 347         if (key < 4)
1629  05c8 7b02          	ld	a,(OFST+1,sp)
1630  05ca a104          	cp	a,#4
1631  05cc 240a          	jruge	L354
1632                     ; 348             temp = key + 0x35; // Ascii char 0x35 to 0x39
1634  05ce 7b02          	ld	a,(OFST+1,sp)
1635  05d0 ab35          	add	a,#53
1636  05d2 6b01          	ld	(OFST+0,sp),a
1639  05d4 ac740674      	jpf	L104
1640  05d8               L354:
1641                     ; 349         else if (key < 7)
1643  05d8 7b02          	ld	a,(OFST+1,sp)
1644  05da a107          	cp	a,#7
1645  05dc 240a          	jruge	L754
1646                     ; 350             temp = key + 0x50; // Ascii char 0x54 to 0x56
1648  05de 7b02          	ld	a,(OFST+1,sp)
1649  05e0 ab50          	add	a,#80
1650  05e2 6b01          	ld	(OFST+0,sp),a
1653  05e4 ac740674      	jpf	L104
1654  05e8               L754:
1655                     ; 352             temp = key + 0x70; // Ascii char 0x74 to 0x76
1657  05e8 7b02          	ld	a,(OFST+1,sp)
1658  05ea ab70          	add	a,#112
1659  05ec 6b01          	ld	(OFST+0,sp),a
1661  05ee ac740674      	jpf	L104
1662  05f2               L143:
1663                     ; 354     case 12:
1663                     ; 355         temp = key + 0x35; //Ascii char 0x35 to 0x3E
1665  05f2 7b02          	ld	a,(OFST+1,sp)
1666  05f4 ab35          	add	a,#53
1667  05f6 6b01          	ld	(OFST+0,sp),a
1669                     ; 356         break;
1671  05f8 207a          	jra	L104
1672  05fa               L343:
1673                     ; 357     case 13:
1673                     ; 358         temp = key + 0x3F; // Ascii char 0x3F to 0x48
1675  05fa 7b02          	ld	a,(OFST+1,sp)
1676  05fc ab3f          	add	a,#63
1677  05fe 6b01          	ld	(OFST+0,sp),a
1679                     ; 359         break;
1681  0600 2072          	jra	L104
1682  0602               L543:
1683                     ; 360     case 14:
1683                     ; 361         if (key == 0)
1685  0602 0d02          	tnz	(OFST+1,sp)
1686  0604 2608          	jrne	L364
1687                     ; 362             temp = key + 0x21; // Ascii char 0x21
1689  0606 7b02          	ld	a,(OFST+1,sp)
1690  0608 ab21          	add	a,#33
1691  060a 6b01          	ld	(OFST+0,sp),a
1694  060c 2066          	jra	L104
1695  060e               L364:
1696                     ; 363         else if (key == 1 || key == 2)
1698  060e 7b02          	ld	a,(OFST+1,sp)
1699  0610 a101          	cp	a,#1
1700  0612 2706          	jreq	L174
1702  0614 7b02          	ld	a,(OFST+1,sp)
1703  0616 a102          	cp	a,#2
1704  0618 2608          	jrne	L764
1705  061a               L174:
1706                     ; 364             temp = key + 0x22; // Ascii char 0x23 to 0x24
1708  061a 7b02          	ld	a,(OFST+1,sp)
1709  061c ab22          	add	a,#34
1710  061e 6b01          	ld	(OFST+0,sp),a
1713  0620 2052          	jra	L104
1714  0622               L764:
1715                     ; 365         else if (key == 3)
1717  0622 7b02          	ld	a,(OFST+1,sp)
1718  0624 a103          	cp	a,#3
1719  0626 2608          	jrne	L574
1720                     ; 366             temp = key + 0x27; // Ascii char 0x2A
1722  0628 7b02          	ld	a,(OFST+1,sp)
1723  062a ab27          	add	a,#39
1724  062c 6b01          	ld	(OFST+0,sp),a
1727  062e 2044          	jra	L104
1728  0630               L574:
1729                     ; 367         else if (key == 4 || key == 5)
1731  0630 7b02          	ld	a,(OFST+1,sp)
1732  0632 a104          	cp	a,#4
1733  0634 2706          	jreq	L305
1735  0636 7b02          	ld	a,(OFST+1,sp)
1736  0638 a105          	cp	a,#5
1737  063a 2608          	jrne	L105
1738  063c               L305:
1739                     ; 368             temp = key + 0x36; // Ascii char 0x3A to 0x3B
1741  063c 7b02          	ld	a,(OFST+1,sp)
1742  063e ab36          	add	a,#54
1743  0640 6b01          	ld	(OFST+0,sp),a
1746  0642 2030          	jra	L104
1747  0644               L105:
1748                     ; 369         else if (key == 6 || key == 7)
1750  0644 7b02          	ld	a,(OFST+1,sp)
1751  0646 a106          	cp	a,#6
1752  0648 2706          	jreq	L115
1754  064a 7b02          	ld	a,(OFST+1,sp)
1755  064c a107          	cp	a,#7
1756  064e 2608          	jrne	L705
1757  0650               L115:
1758                     ; 370             temp = key + 0x39; // Ascii char 0x3F to 0x40
1760  0650 7b02          	ld	a,(OFST+1,sp)
1761  0652 ab39          	add	a,#57
1762  0654 6b01          	ld	(OFST+0,sp),a
1765  0656 201c          	jra	L104
1766  0658               L705:
1767                     ; 371         else if (key == 8)
1769  0658 7b02          	ld	a,(OFST+1,sp)
1770  065a a108          	cp	a,#8
1771  065c 2608          	jrne	L515
1772                     ; 372             temp = key + 0x27; // Ascii char 0x2F
1774  065e 7b02          	ld	a,(OFST+1,sp)
1775  0660 ab27          	add	a,#39
1776  0662 6b01          	ld	(OFST+0,sp),a
1779  0664 200e          	jra	L104
1780  0666               L515:
1781                     ; 374             temp = key + 0x53; // Ascii char 0x5C
1783  0666 7b02          	ld	a,(OFST+1,sp)
1784  0668 ab53          	add	a,#83
1785  066a 6b01          	ld	(OFST+0,sp),a
1787  066c 2006          	jra	L104
1788  066e               L743:
1789                     ; 376     default:
1789                     ; 377         temp = key + 70;
1791  066e 7b02          	ld	a,(OFST+1,sp)
1792  0670 ab46          	add	a,#70
1793  0672 6b01          	ld	(OFST+0,sp),a
1795                     ; 378         break;
1797  0674               L104:
1798                     ; 380     return temp;
1800  0674 7b01          	ld	a,(OFST+0,sp)
1803  0676 5b03          	addw	sp,#3
1804  0678 81            	ret
1846                     ; 383 void vInit_MQTT(void)
1846                     ; 384 {
1847                     	switch	.text
1848  0679               _vInit_MQTT:
1850  0679 88            	push	a
1851       00000001      OFST:	set	1
1854                     ; 385     uint8_t unLength = 0;
1856                     ; 387     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1858  067a 4b64          	push	#100
1859  067c ae0000        	ldw	x,#_aunPushed_Data
1860  067f cd0756        	call	_vClearBuffer
1862  0682 84            	pop	a
1863                     ; 388     unLength = (uint8_t)ulMQTT_Connect(aunPushed_Data, punGet_Client_ID() /*, FALSE, FALSE, FALSE, FALSE, TRUE, eQOS_0, NULL, NULL, NULL, NULL*/);
1865  0683 cd0000        	call	_punGet_Client_ID
1867  0686 89            	pushw	x
1868  0687 ae0000        	ldw	x,#_aunPushed_Data
1869  068a cd0000        	call	_ulMQTT_Connect
1871  068d 85            	popw	x
1872  068e b603          	ld	a,c_lreg+3
1873  0690 6b01          	ld	(OFST+0,sp),a
1875                     ; 389     bSendDataOverTCP(aunPushed_Data, unLength);
1877  0692 7b01          	ld	a,(OFST+0,sp)
1878  0694 88            	push	a
1879  0695 ae0000        	ldw	x,#_aunPushed_Data
1880  0698 ad60          	call	_bSendDataOverTCP
1882  069a 84            	pop	a
1883                     ; 390     delay_ms(1000);
1885  069b ae03e8        	ldw	x,#1000
1886  069e cd0000        	call	_delay_ms
1888                     ; 391     delay_ms(1000);
1890  06a1 ae03e8        	ldw	x,#1000
1891  06a4 cd0000        	call	_delay_ms
1893                     ; 392     delay_ms(1000);
1895  06a7 ae03e8        	ldw	x,#1000
1896  06aa cd0000        	call	_delay_ms
1898                     ; 393     delay_ms(1000);
1900  06ad ae03e8        	ldw	x,#1000
1901  06b0 cd0000        	call	_delay_ms
1903                     ; 394     delay_ms(1000);
1905  06b3 ae03e8        	ldw	x,#1000
1906  06b6 cd0000        	call	_delay_ms
1908                     ; 395     vClearBuffer(aunPushed_Data, MEVRIS_RECV_DATA_MAX_SIZE);
1910  06b9 4b46          	push	#70
1911  06bb ae0000        	ldw	x,#_aunPushed_Data
1912  06be cd0756        	call	_vClearBuffer
1914  06c1 84            	pop	a
1915                     ; 396     unLength = (uint8_t)ulMQTT_Subscribe(aunPushed_Data, punGet_Command_Topic() /*, eQOS_0, 1*/);
1917  06c2 cd0000        	call	_punGet_Command_Topic
1919  06c5 89            	pushw	x
1920  06c6 ae0000        	ldw	x,#_aunPushed_Data
1921  06c9 cd0000        	call	_ulMQTT_Subscribe
1923  06cc 85            	popw	x
1924  06cd b603          	ld	a,c_lreg+3
1925  06cf 6b01          	ld	(OFST+0,sp),a
1927                     ; 397     bSendDataOverTCP(aunPushed_Data, unLength);
1929  06d1 7b01          	ld	a,(OFST+0,sp)
1930  06d3 88            	push	a
1931  06d4 ae0000        	ldw	x,#_aunPushed_Data
1932  06d7 ad21          	call	_bSendDataOverTCP
1934  06d9 84            	pop	a
1935                     ; 398     delay_ms(1000);
1937  06da ae03e8        	ldw	x,#1000
1938  06dd cd0000        	call	_delay_ms
1940                     ; 399     delay_ms(1000);
1942  06e0 ae03e8        	ldw	x,#1000
1943  06e3 cd0000        	call	_delay_ms
1945                     ; 400     delay_ms(1000);
1947  06e6 ae03e8        	ldw	x,#1000
1948  06e9 cd0000        	call	_delay_ms
1950                     ; 401     delay_ms(1000);
1952  06ec ae03e8        	ldw	x,#1000
1953  06ef cd0000        	call	_delay_ms
1955                     ; 402     delay_ms(1000);
1957  06f2 ae03e8        	ldw	x,#1000
1958  06f5 cd0000        	call	_delay_ms
1960                     ; 403 }
1963  06f8 84            	pop	a
1964  06f9 81            	ret
2044                     ; 405 bool bSendDataOverTCP(uint8_t *Data, uint8_t unLength)
2044                     ; 406 {
2045                     	switch	.text
2046  06fa               _bSendDataOverTCP:
2048  06fa 89            	pushw	x
2049  06fb 88            	push	a
2050       00000001      OFST:	set	1
2053                     ; 407     uint8_t timeout = 0;
2055  06fc 0f01          	clr	(OFST+0,sp)
2057                     ; 408     ms_send_cmd(TCP_SEND_VARIABLE_LENGTH, strlen((const char *)TCP_SEND_VARIABLE_LENGTH));
2059  06fe 4b0a          	push	#10
2060  0700 ae00bd        	ldw	x,#L575
2061  0703 cd0000        	call	_ms_send_cmd
2063  0706 84            	pop	a
2064                     ; 409     delay_ms(100);
2066  0707 ae0064        	ldw	x,#100
2067  070a cd0000        	call	_delay_ms
2069                     ; 410     ms_send_cmd_TCP(Data, unLength);
2071  070d 7b06          	ld	a,(OFST+5,sp)
2072  070f 88            	push	a
2073  0710 1e03          	ldw	x,(OFST+2,sp)
2074  0712 cd0000        	call	_ms_send_cmd_TCP
2076  0715 84            	pop	a
2077                     ; 411     delay_ms(200);
2079  0716 ae00c8        	ldw	x,#200
2080  0719 cd0000        	call	_delay_ms
2083  071c 2006          	jra	L106
2084  071e               L775:
2085                     ; 414         delay_ms(100);
2087  071e ae0064        	ldw	x,#100
2088  0721 cd0000        	call	_delay_ms
2090  0724               L106:
2091                     ; 413     while (!strstr(response_buffer, "SEND") && (++timeout != 100))
2093  0724 ae00b8        	ldw	x,#L706
2094  0727 89            	pushw	x
2095  0728 ae0000        	ldw	x,#_response_buffer
2096  072b cd0000        	call	_strstr
2098  072e 5b02          	addw	sp,#2
2099  0730 a30000        	cpw	x,#0
2100  0733 2608          	jrne	L506
2102  0735 0c01          	inc	(OFST+0,sp)
2104  0737 7b01          	ld	a,(OFST+0,sp)
2105  0739 a164          	cp	a,#100
2106  073b 26e1          	jrne	L775
2107  073d               L506:
2108                     ; 415     if (strstr(response_buffer, "SEND OK"))
2110  073d ae00b0        	ldw	x,#L316
2111  0740 89            	pushw	x
2112  0741 ae0000        	ldw	x,#_response_buffer
2113  0744 cd0000        	call	_strstr
2115  0747 5b02          	addw	sp,#2
2116  0749 a30000        	cpw	x,#0
2117  074c 2704          	jreq	L116
2118                     ; 417         return TRUE;
2120  074e a601          	ld	a,#1
2122  0750 2001          	jra	L46
2123  0752               L116:
2124                     ; 421         return FALSE;
2126  0752 4f            	clr	a
2128  0753               L46:
2130  0753 5b03          	addw	sp,#3
2131  0755 81            	ret
2184                     ; 425 void vClearBuffer(char *temp, uint8_t unLen)
2184                     ; 426 {
2185                     	switch	.text
2186  0756               _vClearBuffer:
2188  0756 89            	pushw	x
2189  0757 88            	push	a
2190       00000001      OFST:	set	1
2193                     ; 428     for (i = 0; i < unLen; i++)
2195  0758 0f01          	clr	(OFST+0,sp)
2198  075a 200e          	jra	L156
2199  075c               L546:
2200                     ; 430         *(temp + i) = '\0';
2202  075c 7b02          	ld	a,(OFST+1,sp)
2203  075e 97            	ld	xl,a
2204  075f 7b03          	ld	a,(OFST+2,sp)
2205  0761 1b01          	add	a,(OFST+0,sp)
2206  0763 2401          	jrnc	L07
2207  0765 5c            	incw	x
2208  0766               L07:
2209  0766 02            	rlwa	x,a
2210  0767 7f            	clr	(x)
2211                     ; 428     for (i = 0; i < unLen; i++)
2213  0768 0c01          	inc	(OFST+0,sp)
2215  076a               L156:
2218  076a 7b01          	ld	a,(OFST+0,sp)
2219  076c 1106          	cp	a,(OFST+5,sp)
2220  076e 25ec          	jrult	L546
2221                     ; 432 }
2224  0770 5b03          	addw	sp,#3
2225  0772 81            	ret
2356                     ; 434 enTCP_STATUS enGet_TCP_Status(void)
2356                     ; 435 {
2357                     	switch	.text
2358  0773               _enGet_TCP_Status:
2360  0773 88            	push	a
2361       00000001      OFST:	set	1
2364                     ; 438     ms_send_cmd(TCP_GET_STATUS, strlen((const char *)TCP_GET_STATUS));
2366  0774 4b0c          	push	#12
2367  0776 ae00a3        	ldw	x,#L527
2368  0779 cd0000        	call	_ms_send_cmd
2370  077c 84            	pop	a
2371                     ; 439     delay_ms(1000);
2373  077d ae03e8        	ldw	x,#1000
2374  0780 cd0000        	call	_delay_ms
2376                     ; 441     if (strstr(response_buffer, "STATE:"))
2378  0783 ae009c        	ldw	x,#L137
2379  0786 89            	pushw	x
2380  0787 ae0000        	ldw	x,#_response_buffer
2381  078a cd0000        	call	_strstr
2383  078d 5b02          	addw	sp,#2
2384  078f a30000        	cpw	x,#0
2385  0792 2603          	jrne	L47
2386  0794 cc0888        	jp	L727
2387  0797               L47:
2388                     ; 443         if (strstr(response_buffer, "IP INITIAL"))
2390  0797 ae0091        	ldw	x,#L537
2391  079a 89            	pushw	x
2392  079b ae0000        	ldw	x,#_response_buffer
2393  079e cd0000        	call	_strstr
2395  07a1 5b02          	addw	sp,#2
2396  07a3 a30000        	cpw	x,#0
2397  07a6 2708          	jreq	L337
2398                     ; 445             eStatus = eTCP_STAT_IP_INITIAL;
2400  07a8 a601          	ld	a,#1
2401  07aa 6b01          	ld	(OFST+0,sp),a
2404  07ac ac8a088a      	jpf	L7201
2405  07b0               L337:
2406                     ; 447         else if (strstr(response_buffer, "IP START"))
2408  07b0 ae0088        	ldw	x,#L347
2409  07b3 89            	pushw	x
2410  07b4 ae0000        	ldw	x,#_response_buffer
2411  07b7 cd0000        	call	_strstr
2413  07ba 5b02          	addw	sp,#2
2414  07bc a30000        	cpw	x,#0
2415  07bf 2708          	jreq	L147
2416                     ; 449             eStatus = eTCP_STAT_IP_START;
2418  07c1 a602          	ld	a,#2
2419  07c3 6b01          	ld	(OFST+0,sp),a
2422  07c5 ac8a088a      	jpf	L7201
2423  07c9               L147:
2424                     ; 451         else if (strstr(response_buffer, "IP CONFIG"))
2426  07c9 ae007e        	ldw	x,#L157
2427  07cc 89            	pushw	x
2428  07cd ae0000        	ldw	x,#_response_buffer
2429  07d0 cd0000        	call	_strstr
2431  07d3 5b02          	addw	sp,#2
2432  07d5 a30000        	cpw	x,#0
2433  07d8 2708          	jreq	L747
2434                     ; 453             eStatus = eTCP_STAT_IP_CONFIG;
2436  07da a603          	ld	a,#3
2437  07dc 6b01          	ld	(OFST+0,sp),a
2440  07de ac8a088a      	jpf	L7201
2441  07e2               L747:
2442                     ; 455         else if (strstr(response_buffer, "IP GPRSACT"))
2444  07e2 ae0073        	ldw	x,#L757
2445  07e5 89            	pushw	x
2446  07e6 ae0000        	ldw	x,#_response_buffer
2447  07e9 cd0000        	call	_strstr
2449  07ec 5b02          	addw	sp,#2
2450  07ee a30000        	cpw	x,#0
2451  07f1 2707          	jreq	L557
2452                     ; 457             eStatus = eTCP_STAT_IP_GPRSACT;
2454  07f3 a604          	ld	a,#4
2455  07f5 6b01          	ld	(OFST+0,sp),a
2458  07f7 cc088a        	jra	L7201
2459  07fa               L557:
2460                     ; 459         else if (strstr(response_buffer, "IP STATUS"))
2462  07fa ae0069        	ldw	x,#L567
2463  07fd 89            	pushw	x
2464  07fe ae0000        	ldw	x,#_response_buffer
2465  0801 cd0000        	call	_strstr
2467  0804 5b02          	addw	sp,#2
2468  0806 a30000        	cpw	x,#0
2469  0809 2706          	jreq	L367
2470                     ; 461             eStatus = eTCP_STAT_IP_STATUS;
2472  080b a605          	ld	a,#5
2473  080d 6b01          	ld	(OFST+0,sp),a
2476  080f 2079          	jra	L7201
2477  0811               L367:
2478                     ; 463         else if (strstr(response_buffer, "TCP CONNECTING"))
2480  0811 ae005a        	ldw	x,#L377
2481  0814 89            	pushw	x
2482  0815 ae0000        	ldw	x,#_response_buffer
2483  0818 cd0000        	call	_strstr
2485  081b 5b02          	addw	sp,#2
2486  081d a30000        	cpw	x,#0
2487  0820 2706          	jreq	L177
2488                     ; 465             eStatus = eTCP_STAT_CONNECTING;
2490  0822 a606          	ld	a,#6
2491  0824 6b01          	ld	(OFST+0,sp),a
2494  0826 2062          	jra	L7201
2495  0828               L177:
2496                     ; 467         else if (strstr(response_buffer, "CONNECT OK"))
2498  0828 ae004f        	ldw	x,#L1001
2499  082b 89            	pushw	x
2500  082c ae0000        	ldw	x,#_response_buffer
2501  082f cd0000        	call	_strstr
2503  0832 5b02          	addw	sp,#2
2504  0834 a30000        	cpw	x,#0
2505  0837 2706          	jreq	L777
2506                     ; 469             eStatus = eTCP_STAT_CONNECT_OK;
2508  0839 a607          	ld	a,#7
2509  083b 6b01          	ld	(OFST+0,sp),a
2512  083d 204b          	jra	L7201
2513  083f               L777:
2514                     ; 471         else if (strstr(response_buffer, "TCP CLOSING"))
2516  083f ae0043        	ldw	x,#L7001
2517  0842 89            	pushw	x
2518  0843 ae0000        	ldw	x,#_response_buffer
2519  0846 cd0000        	call	_strstr
2521  0849 5b02          	addw	sp,#2
2522  084b a30000        	cpw	x,#0
2523  084e 2706          	jreq	L5001
2524                     ; 473             eStatus = eTCP_STAT_CLOSING;
2526  0850 a608          	ld	a,#8
2527  0852 6b01          	ld	(OFST+0,sp),a
2530  0854 2034          	jra	L7201
2531  0856               L5001:
2532                     ; 475         else if (strstr(response_buffer, "TCP CLOSED"))
2534  0856 ae0038        	ldw	x,#L5101
2535  0859 89            	pushw	x
2536  085a ae0000        	ldw	x,#_response_buffer
2537  085d cd0000        	call	_strstr
2539  0860 5b02          	addw	sp,#2
2540  0862 a30000        	cpw	x,#0
2541  0865 2706          	jreq	L3101
2542                     ; 477             eStatus = eTCP_STAT_CLOSED;
2544  0867 a609          	ld	a,#9
2545  0869 6b01          	ld	(OFST+0,sp),a
2548  086b 201d          	jra	L7201
2549  086d               L3101:
2550                     ; 479         else if (strstr(response_buffer, "PDP DEACT"))
2552  086d ae002e        	ldw	x,#L3201
2553  0870 89            	pushw	x
2554  0871 ae0000        	ldw	x,#_response_buffer
2555  0874 cd0000        	call	_strstr
2557  0877 5b02          	addw	sp,#2
2558  0879 a30000        	cpw	x,#0
2559  087c 2706          	jreq	L1201
2560                     ; 481             eStatus = eTCP_STAT_PDP_DEACT;
2562  087e a60a          	ld	a,#10
2563  0880 6b01          	ld	(OFST+0,sp),a
2566  0882 2006          	jra	L7201
2567  0884               L1201:
2568                     ; 485             eStatus = eTCP_STAT_UNKNOWN;
2570  0884 0f01          	clr	(OFST+0,sp)
2572  0886 2002          	jra	L7201
2573  0888               L727:
2574                     ; 490         eStatus = eTCP_STAT_UNKNOWN;
2576  0888 0f01          	clr	(OFST+0,sp)
2578  088a               L7201:
2579                     ; 492     return eStatus;
2581  088a 7b01          	ld	a,(OFST+0,sp)
2584  088c 5b01          	addw	sp,#1
2585  088e 81            	ret
2620                     	xref	_aunPushed_Data
2621                     	xdef	_enGet_TCP_Status
2622                     	xdef	_vClearBuffer
2623                     	xdef	_getValue
2624                     	xdef	_bSendDataOverTCP
2625                     	xdef	_vInit_MQTT
2626                     	xdef	_passkeyGenerator
2627                     	xdef	_getIMEI
2628                     	xdef	_checkNum
2629                     	xdef	_SIMComrestart
2630                     	xdef	_SIMCom_setup
2631                     	xref	_response_buffer
2632                     	xref	_ulMQTT_Subscribe
2633                     	xref	_ulMQTT_Connect
2634                     	xref	_ms_send_cmd_TCP
2635                     	xref	_ms_send_cmd
2636                     	xref	_punGet_Client_ID
2637                     	xref	_punGet_Command_Topic
2638                     	switch	.ubsct
2639  0000               _PASS_KEY:
2640  0000 000000000000  	ds.b	16
2641                     	xdef	_PASS_KEY
2642  0010               _aunIMEI:
2643  0010 000000000000  	ds.b	20
2644                     	xdef	_aunIMEI
2645                     	xref	_strlen
2646                     	xref	_strstr
2647                     	xref	_delay_ms
2648                     	xref	_UART1_GetFlagStatus
2649                     	xref	_UART1_ReceiveData8
2650                     	xref	_UART1_ITConfig
2651                     	xref	_GPIO_WriteLow
2652                     	xref	_GPIO_WriteHigh
2653                     	switch	.const
2654  002e               L3201:
2655  002e 504450204445  	dc.b	"PDP DEACT",0
2656  0038               L5101:
2657  0038 54435020434c  	dc.b	"TCP CLOSED",0
2658  0043               L7001:
2659  0043 54435020434c  	dc.b	"TCP CLOSING",0
2660  004f               L1001:
2661  004f 434f4e4e4543  	dc.b	"CONNECT OK",0
2662  005a               L377:
2663  005a 54435020434f  	dc.b	"TCP CONNECTING",0
2664  0069               L567:
2665  0069 495020535441  	dc.b	"IP STATUS",0
2666  0073               L757:
2667  0073 495020475052  	dc.b	"IP GPRSACT",0
2668  007e               L157:
2669  007e 495020434f4e  	dc.b	"IP CONFIG",0
2670  0088               L347:
2671  0088 495020535441  	dc.b	"IP START",0
2672  0091               L537:
2673  0091 495020494e49  	dc.b	"IP INITIAL",0
2674  009c               L137:
2675  009c 53544154453a  	dc.b	"STATE:",0
2676  00a3               L527:
2677  00a3 41542b434950  	dc.b	"AT+CIPSTATUS",0
2678  00b0               L316:
2679  00b0 53454e44204f  	dc.b	"SEND OK",0
2680  00b8               L706:
2681  00b8 53454e4400    	dc.b	"SEND",0
2682  00bd               L575:
2683  00bd 41542b434950  	dc.b	"AT+CIPSEND",0
2684  00c8               L112:
2685  00c8 41542b47534e  	dc.b	"AT+GSN",0
2686  00cf               L731:
2687  00cf 41542b434e55  	dc.b	"AT+CNUM",0
2688  00d7               L311:
2689  00d7 41542b43504f  	dc.b	"AT+CPOWD=0",0
2690  00e2               L101:
2691  00e2 41542b425450  	dc.b	"AT+BTPAIRCFG=1,123"
2692  00f4 3400          	dc.b	"4",0
2693  00f6               L77:
2694  00f6 41542b425448  	dc.b	"AT+BTHOST=GENERATO"
2695  0108 522d35353535  	dc.b	"R-555555",0
2696  0111               L57:
2697  0111 41542b425450  	dc.b	"AT+BTPOWER=1",0
2698  011e               L37:
2699  011e 41542b434950  	dc.b	"AT+CIPSTART=",34
2700  012b 54435022      	dc.b	"TCP",34
2701  012f 2c22          	dc.b	",",34
2702  0131 6d7174742e6d  	dc.b	"mqtt.mevris.io",34
2703  0140 2c22          	dc.b	",",34
2704  0142 333838312200  	dc.b	"3881",34,0
2705  0148               L17:
2706  0148 41542b434946  	dc.b	"AT+CIFSR",0
2707  0151               L76:
2708  0151 41542b434949  	dc.b	"AT+CIICR",0
2709  015a               L56:
2710  015a 41542b435354  	dc.b	"AT+CSTT=",34
2711  0163 7a6f6e677761  	dc.b	"zongwap",34,0
2712  016c               L36:
2713  016c 41542b434950  	dc.b	"AT+CIPSCONT",0
2714  0178               L16:
2715  0178 41542b434950  	dc.b	"AT+CIPHEAD=1",0
2716  0185               L75:
2717  0185 41542b434950  	dc.b	"AT+CIPSRIP=1",0
2718  0192               L55:
2719  0192 41542b434950  	dc.b	"AT+CIPSPRT=1",0
2720  019f               L35:
2721  019f 41542b434950  	dc.b	"AT+CIPQSEND=0",0
2722  01ad               L15:
2723  01ad 41542b434950  	dc.b	"AT+CIPMODE=0",0
2724  01ba               L74:
2725  01ba 41542b434950  	dc.b	"AT+CIPMUX=0",0
2726  01c6               L54:
2727  01c6 41542b434950  	dc.b	"AT+CIPSHUT",0
2728  01d1               L34:
2729  01d1 41542b534150  	dc.b	"AT+SAPBR=1,1",0
2730  01de               L14:
2731  01de 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
2732  01ec 41504e22      	dc.b	"APN",34
2733  01f0 2c22          	dc.b	",",34
2734  01f2 7a6f6e677761  	dc.b	"zongwap",34,0
2735  01fb               L73:
2736  01fb 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
2737  0209 434f4e545950  	dc.b	"CONTYPE",34
2738  0211 2c22          	dc.b	",",34
2739  0213 475052532200  	dc.b	"GPRS",34,0
2740  0219               L53:
2741  0219 41542b434741  	dc.b	"AT+CGATT=1",0
2742  0224               L33:
2743  0224 41542b434d45  	dc.b	"AT+CMEE=2",0
2744  022e               L13:
2745  022e 41542b43474e  	dc.b	"AT+CGNSSEQ=RMC",0
2746  023d               L72:
2747  023d 41542b43474e  	dc.b	"AT+CGNSPWR=1",0
2748  024a               L52:
2749  024a 41542b435343  	dc.b	"AT+CSCLK=0",0
2750  0255               L32:
2751  0255 41542b434d47  	dc.b	"AT+CMGD=1,4",0
2752  0261               L12:
2753  0261 4154453000    	dc.b	"ATE0",0
2754                     	xref.b	c_lreg
2755                     	xref.b	c_x
2775                     	xref	c_smody
2776                     	xref	c_smodx
2777                     	xref	c_xymvx
2778                     	end
