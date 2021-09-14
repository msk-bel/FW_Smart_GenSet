   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  49                     ; 54 void SIMCom_setup(void)
  49                     ; 55 {
  51                     	switch	.text
  52  0000               _SIMCom_setup:
  56                     ; 56     delay_ms(100);
  58  0000 ae0064        	ldw	x,#100
  59  0003 cd0000        	call	_delay_ms
  61                     ; 57     SIMComrestart(); //Restart the SIMCOMM 868 module
  63  0006 cd019a        	call	_SIMComrestart
  65                     ; 58     delay_ms(10000);
  67  0009 ae2710        	ldw	x,#10000
  68  000c cd0000        	call	_delay_ms
  70                     ; 60     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  72  000f 4b04          	push	#4
  73  0011 ae0249        	ldw	x,#L12
  74  0014 cd0000        	call	_ms_send_cmd
  76  0017 84            	pop	a
  77                     ; 61     delay_ms(20000);                                   //need to adjust the delay
  79  0018 ae4e20        	ldw	x,#20000
  80  001b cd0000        	call	_delay_ms
  82                     ; 62     delay_ms(1000);
  84  001e ae03e8        	ldw	x,#1000
  85  0021 cd0000        	call	_delay_ms
  87                     ; 64     ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
  89  0024 4b0b          	push	#11
  90  0026 ae023d        	ldw	x,#L32
  91  0029 cd0000        	call	_ms_send_cmd
  93  002c 84            	pop	a
  94                     ; 65     delay_ms(1000);
  96  002d ae03e8        	ldw	x,#1000
  97  0030 cd0000        	call	_delay_ms
  99                     ; 67     ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
 101  0033 4b0a          	push	#10
 102  0035 ae0232        	ldw	x,#L52
 103  0038 cd0000        	call	_ms_send_cmd
 105  003b 84            	pop	a
 106                     ; 68     delay_ms(1000);
 108  003c ae03e8        	ldw	x,#1000
 109  003f cd0000        	call	_delay_ms
 111                     ; 70     vPrintStickerInfo(); //Added by Saqib
 113  0042 cd06da        	call	_vPrintStickerInfo
 115                     ; 71     delay_ms(1000);
 117  0045 ae03e8        	ldw	x,#1000
 118  0048 cd0000        	call	_delay_ms
 120                     ; 73     ms_send_cmd("AT+CFGRI=0", strlen((const char *)"AT+CFGRI=0")); /* Disable power saving mode */
 122  004b 4b0a          	push	#10
 123  004d ae0227        	ldw	x,#L72
 124  0050 cd0000        	call	_ms_send_cmd
 126  0053 84            	pop	a
 127                     ; 74     delay_ms(1000);
 129  0054 ae03e8        	ldw	x,#1000
 130  0057 cd0000        	call	_delay_ms
 132                     ; 76     ms_send_cmd(GPS_ON, strlen((const char *)GPS_ON));
 134  005a 4b0c          	push	#12
 135  005c ae021a        	ldw	x,#L13
 136  005f cd0000        	call	_ms_send_cmd
 138  0062 84            	pop	a
 139                     ; 77     delay_ms(1000);
 141  0063 ae03e8        	ldw	x,#1000
 142  0066 cd0000        	call	_delay_ms
 144                     ; 79     ms_send_cmd(rmc, strlen((const char *)rmc));
 146  0069 4b0e          	push	#14
 147  006b ae020b        	ldw	x,#L33
 148  006e cd0000        	call	_ms_send_cmd
 150  0071 84            	pop	a
 151                     ; 80     delay_ms(1000);
 153  0072 ae03e8        	ldw	x,#1000
 154  0075 cd0000        	call	_delay_ms
 156                     ; 82     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
 158  0078 4b04          	push	#4
 159  007a ae0249        	ldw	x,#L12
 160  007d cd0000        	call	_ms_send_cmd
 162  0080 84            	pop	a
 163                     ; 83     delay_ms(1000);
 165  0081 ae03e8        	ldw	x,#1000
 166  0084 cd0000        	call	_delay_ms
 168                     ; 85     ms_send_cmd("AT+CMEE=2", strlen((const char *)"AT+CMEE=2")); /* No echo */
 170  0087 4b09          	push	#9
 171  0089 ae0201        	ldw	x,#L53
 172  008c cd0000        	call	_ms_send_cmd
 174  008f 84            	pop	a
 175                     ; 86     delay_ms(1000);
 177  0090 ae03e8        	ldw	x,#1000
 178  0093 cd0000        	call	_delay_ms
 180                     ; 88     ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
 182  0096 4b0a          	push	#10
 183  0098 ae01f6        	ldw	x,#L73
 184  009b cd0000        	call	_ms_send_cmd
 186  009e 84            	pop	a
 187                     ; 89     delay_ms(1000);
 189  009f ae03e8        	ldw	x,#1000
 190  00a2 cd0000        	call	_delay_ms
 192                     ; 91     ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
 194  00a5 4b1d          	push	#29
 195  00a7 ae01d8        	ldw	x,#L14
 196  00aa cd0000        	call	_ms_send_cmd
 198  00ad 84            	pop	a
 199                     ; 92     delay_ms(1000);
 201  00ae ae03e8        	ldw	x,#1000
 202  00b1 cd0000        	call	_delay_ms
 204                     ; 94     ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
 206  00b4 4b1c          	push	#28
 207  00b6 ae01bb        	ldw	x,#L34
 208  00b9 cd0000        	call	_ms_send_cmd
 210  00bc 84            	pop	a
 211                     ; 95     delay_ms(1000);
 213  00bd ae03e8        	ldw	x,#1000
 214  00c0 cd0000        	call	_delay_ms
 216                     ; 97     ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
 218  00c3 4b0c          	push	#12
 219  00c5 ae01ae        	ldw	x,#L54
 220  00c8 cd0000        	call	_ms_send_cmd
 222  00cb 84            	pop	a
 223                     ; 98     delay_ms(1000);
 225  00cc ae03e8        	ldw	x,#1000
 226  00cf cd0000        	call	_delay_ms
 228                     ; 103     delay_ms(1000); //Added by Saqib
 230  00d2 ae03e8        	ldw	x,#1000
 231  00d5 cd0000        	call	_delay_ms
 233                     ; 105     ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
 235  00d8 4b0a          	push	#10
 236  00da ae01a3        	ldw	x,#L74
 237  00dd cd0000        	call	_ms_send_cmd
 239  00e0 84            	pop	a
 240                     ; 106     delay_ms(1000);
 242  00e1 ae03e8        	ldw	x,#1000
 243  00e4 cd0000        	call	_delay_ms
 245                     ; 108     ms_send_cmd(TCP_SINGLE_CONN_MODE, strlen((const char *)TCP_SINGLE_CONN_MODE)); /* OPEN BEARER */
 247  00e7 4b0b          	push	#11
 248  00e9 ae0197        	ldw	x,#L15
 249  00ec cd0000        	call	_ms_send_cmd
 251  00ef 84            	pop	a
 252                     ; 109     delay_ms(1000);
 254  00f0 ae03e8        	ldw	x,#1000
 255  00f3 cd0000        	call	_delay_ms
 257                     ; 111     ms_send_cmd(TCP_NON_TRANSPARENT_MODE, strlen((const char *)TCP_NON_TRANSPARENT_MODE)); /* OPEN BEARER */
 259  00f6 4b0c          	push	#12
 260  00f8 ae018a        	ldw	x,#L35
 261  00fb cd0000        	call	_ms_send_cmd
 263  00fe 84            	pop	a
 264                     ; 112     delay_ms(1000);
 266  00ff ae03e8        	ldw	x,#1000
 267  0102 cd0000        	call	_delay_ms
 269                     ; 114     ms_send_cmd(TCP_MODE_RESPONSE_NORMAL, strlen((const char *)TCP_MODE_RESPONSE_NORMAL)); /* OPEN BEARER */
 271  0105 4b0d          	push	#13
 272  0107 ae017c        	ldw	x,#L55
 273  010a cd0000        	call	_ms_send_cmd
 275  010d 84            	pop	a
 276                     ; 115     delay_ms(1000);
 278  010e ae03e8        	ldw	x,#1000
 279  0111 cd0000        	call	_delay_ms
 281                     ; 117     ms_send_cmd(TCP_MODE_SEND_PROMPT_ECHO, strlen((const char *)TCP_MODE_SEND_PROMPT_ECHO)); /* OPEN BEARER */
 283  0114 4b0c          	push	#12
 284  0116 ae016f        	ldw	x,#L75
 285  0119 cd0000        	call	_ms_send_cmd
 287  011c 84            	pop	a
 288                     ; 118     delay_ms(1000);
 290  011d ae03e8        	ldw	x,#1000
 291  0120 cd0000        	call	_delay_ms
 293                     ; 120     ms_send_cmd(TCP_MODE_REMOTE_IP_PORT_ON, strlen((const char *)TCP_MODE_REMOTE_IP_PORT_ON)); /* OPEN BEARER */
 295  0123 4b0c          	push	#12
 296  0125 ae0162        	ldw	x,#L16
 297  0128 cd0000        	call	_ms_send_cmd
 299  012b 84            	pop	a
 300                     ; 121     delay_ms(1000);
 302  012c ae03e8        	ldw	x,#1000
 303  012f cd0000        	call	_delay_ms
 305                     ; 123     ms_send_cmd(TCP_MODE_HEADER_ON_RECV_ON, strlen((const char *)TCP_MODE_HEADER_ON_RECV_ON)); /* OPEN BEARER */
 307  0132 4b0c          	push	#12
 308  0134 ae0155        	ldw	x,#L36
 309  0137 cd0000        	call	_ms_send_cmd
 311  013a 84            	pop	a
 312                     ; 124     delay_ms(1000);
 314  013b ae03e8        	ldw	x,#1000
 315  013e cd0000        	call	_delay_ms
 317                     ; 126     ms_send_cmd(TCP_SAVE_CONTEXT, strlen((const char *)TCP_SAVE_CONTEXT)); /* OPEN BEARER */
 319  0141 4b0b          	push	#11
 320  0143 ae0149        	ldw	x,#L56
 321  0146 cd0000        	call	_ms_send_cmd
 323  0149 84            	pop	a
 324                     ; 127     delay_ms(1000);
 326  014a ae03e8        	ldw	x,#1000
 327  014d cd0000        	call	_delay_ms
 329                     ; 129     ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
 331  0150 4b11          	push	#17
 332  0152 ae0137        	ldw	x,#L76
 333  0155 cd0000        	call	_ms_send_cmd
 335  0158 84            	pop	a
 336                     ; 130     delay_ms(1000);
 338  0159 ae03e8        	ldw	x,#1000
 339  015c cd0000        	call	_delay_ms
 341                     ; 132     ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
 343  015f 4b08          	push	#8
 344  0161 ae012e        	ldw	x,#L17
 345  0164 cd0000        	call	_ms_send_cmd
 347  0167 84            	pop	a
 348                     ; 133     delay_ms(1000);
 350  0168 ae03e8        	ldw	x,#1000
 351  016b cd0000        	call	_delay_ms
 353                     ; 135     ms_send_cmd("AT+CIFSR", strlen((const char *)"AT+CIFSR")); /* OPEN BEARER */
 355  016e 4b08          	push	#8
 356  0170 ae0125        	ldw	x,#L37
 357  0173 cd0000        	call	_ms_send_cmd
 359  0176 84            	pop	a
 360                     ; 136     delay_ms(1000);
 362  0177 ae03e8        	ldw	x,#1000
 363  017a cd0000        	call	_delay_ms
 365                     ; 138     ms_send_cmd(startTCP_CMD, strlen((const char *)startTCP_CMD)); /* OPEN BEARER */
 367  017d 4b29          	push	#41
 368  017f ae00fb        	ldw	x,#L57
 369  0182 cd0000        	call	_ms_send_cmd
 371  0185 84            	pop	a
 372                     ; 139     delay_ms(1000);
 374  0186 ae03e8        	ldw	x,#1000
 375  0189 cd0000        	call	_delay_ms
 377                     ; 141     enGet_TCP_Status();
 379  018c cd050b        	call	_enGet_TCP_Status
 381                     ; 142     delay_ms(500);
 383  018f ae01f4        	ldw	x,#500
 384  0192 cd0000        	call	_delay_ms
 386                     ; 152     checkit = 1; //Recieve data through Ringer Interrupt
 388  0195 35010000      	mov	_checkit,#1
 389                     ; 153 }
 392  0199 81            	ret
 420                     ; 199 void SIMComrestart()
 420                     ; 200 {
 421                     	switch	.text
 422  019a               _SIMComrestart:
 426                     ; 201     ms_send_cmd(SIMCom_OFF, strlen((const char *)SIMCom_OFF)); /* Power down the SIMCom module */
 428  019a 4b0a          	push	#10
 429  019c ae00f0        	ldw	x,#L701
 430  019f cd0000        	call	_ms_send_cmd
 432  01a2 84            	pop	a
 433                     ; 202     delay_ms(800);
 435  01a3 ae0320        	ldw	x,#800
 436  01a6 cd0000        	call	_delay_ms
 438                     ; 204     GPIO_WriteHigh(PWRKEY);
 440  01a9 4b20          	push	#32
 441  01ab ae500a        	ldw	x,#20490
 442  01ae cd0000        	call	_GPIO_WriteHigh
 444  01b1 84            	pop	a
 445                     ; 205     delay_ms(1000);
 447  01b2 ae03e8        	ldw	x,#1000
 448  01b5 cd0000        	call	_delay_ms
 450                     ; 207     GPIO_WriteLow(PWRKEY);
 452  01b8 4b20          	push	#32
 453  01ba ae500a        	ldw	x,#20490
 454  01bd cd0000        	call	_GPIO_WriteLow
 456  01c0 84            	pop	a
 457                     ; 208     delay_ms(1000);
 459  01c1 ae03e8        	ldw	x,#1000
 460  01c4 cd0000        	call	_delay_ms
 462                     ; 209 }
 465  01c7 81            	ret
 513                     ; 211 void checkNum()
 513                     ; 212 {
 514                     	switch	.text
 515  01c8               _checkNum:
 517  01c8 5203          	subw	sp,#3
 518       00000003      OFST:	set	3
 521                     ; 213     uint16_t timeout = 0;
 523  01ca 5f            	clrw	x
 524  01cb 1f01          	ldw	(OFST-2,sp),x
 526                     ; 215     ms_send_cmd(check_num, strlen((const char *)check_num)); // SMS read
 528  01cd 4b07          	push	#7
 529  01cf ae00e8        	ldw	x,#L331
 530  01d2 cd0000        	call	_ms_send_cmd
 532  01d5 84            	pop	a
 533                     ; 217     for (s = 0; s < 75; s++)
 535  01d6 0f03          	clr	(OFST+0,sp)
 537  01d8               L541:
 538                     ; 219         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++timeout != 10000))
 540  01d8 ae0020        	ldw	x,#32
 541  01db cd0000        	call	_UART1_GetFlagStatus
 543  01de 4d            	tnz	a
 544  01df 260c          	jrne	L151
 546  01e1 1e01          	ldw	x,(OFST-2,sp)
 547  01e3 1c0001        	addw	x,#1
 548  01e6 1f01          	ldw	(OFST-2,sp),x
 550  01e8 a32710        	cpw	x,#10000
 551  01eb 26eb          	jrne	L541
 552  01ed               L151:
 553                     ; 221         response_buffer[s] = UART1_ReceiveData8();
 555  01ed 7b03          	ld	a,(OFST+0,sp)
 556  01ef 5f            	clrw	x
 557  01f0 97            	ld	xl,a
 558  01f1 89            	pushw	x
 559  01f2 cd0000        	call	_UART1_ReceiveData8
 561  01f5 85            	popw	x
 562  01f6 d70000        	ld	(_response_buffer,x),a
 563                     ; 222         timeout = 0;
 565  01f9 5f            	clrw	x
 566  01fa 1f01          	ldw	(OFST-2,sp),x
 568                     ; 217     for (s = 0; s < 75; s++)
 570  01fc 0c03          	inc	(OFST+0,sp)
 574  01fe 7b03          	ld	a,(OFST+0,sp)
 575  0200 a14b          	cp	a,#75
 576  0202 25d4          	jrult	L541
 577                     ; 224 }
 580  0204 5b03          	addw	sp,#3
 581  0206 81            	ret
 650                     ; 226 void getIMEI(void)
 650                     ; 227 {
 651                     	switch	.text
 652  0207               _getIMEI:
 654  0207 521d          	subw	sp,#29
 655       0000001d      OFST:	set	29
 658                     ; 233     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 660  0209 4b00          	push	#0
 661  020b ae0255        	ldw	x,#597
 662  020e cd0000        	call	_UART1_ITConfig
 664  0211 84            	pop	a
 665                     ; 234     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 667  0212 4b00          	push	#0
 668  0214 ae0244        	ldw	x,#580
 669  0217 cd0000        	call	_UART1_ITConfig
 671  021a 84            	pop	a
 672                     ; 236     ms_send_cmd(IMEIcmnd, strlen((const char *)IMEIcmnd)); //"AT+HTTPSSL=1"
 674  021b 4b06          	push	#6
 675  021d ae00e1        	ldw	x,#L502
 676  0220 cd0000        	call	_ms_send_cmd
 678  0223 84            	pop	a
 679                     ; 239     for (i = 0; i < 25; i++)
 681  0224 0f1d          	clr	(OFST+0,sp)
 683  0226               L712:
 684                     ; 241         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++ulTimout != 10000))
 686  0226 ae0020        	ldw	x,#32
 687  0229 cd0000        	call	_UART1_GetFlagStatus
 689  022c 4d            	tnz	a
 690  022d 260c          	jrne	L322
 692  022f 1e1a          	ldw	x,(OFST-3,sp)
 693  0231 1c0001        	addw	x,#1
 694  0234 1f1a          	ldw	(OFST-3,sp),x
 696  0236 a32710        	cpw	x,#10000
 697  0239 26eb          	jrne	L712
 698  023b               L322:
 699                     ; 243         localBuffer[i] = UART1_ReceiveData8();
 701  023b 96            	ldw	x,sp
 702  023c 1c0001        	addw	x,#OFST-28
 703  023f 9f            	ld	a,xl
 704  0240 5e            	swapw	x
 705  0241 1b1d          	add	a,(OFST+0,sp)
 706  0243 2401          	jrnc	L41
 707  0245 5c            	incw	x
 708  0246               L41:
 709  0246 02            	rlwa	x,a
 710  0247 89            	pushw	x
 711  0248 cd0000        	call	_UART1_ReceiveData8
 713  024b 85            	popw	x
 714  024c f7            	ld	(x),a
 715                     ; 244         ulTimout = 0;
 717  024d 5f            	clrw	x
 718  024e 1f1a          	ldw	(OFST-3,sp),x
 720                     ; 239     for (i = 0; i < 25; i++)
 722  0250 0c1d          	inc	(OFST+0,sp)
 726  0252 7b1d          	ld	a,(OFST+0,sp)
 727  0254 a119          	cp	a,#25
 728  0256 25ce          	jrult	L712
 729                     ; 246     localBuffer[i] = '\0';
 731  0258 96            	ldw	x,sp
 732  0259 1c0001        	addw	x,#OFST-28
 733  025c 9f            	ld	a,xl
 734  025d 5e            	swapw	x
 735  025e 1b1d          	add	a,(OFST+0,sp)
 736  0260 2401          	jrnc	L61
 737  0262 5c            	incw	x
 738  0263               L61:
 739  0263 02            	rlwa	x,a
 740  0264 7f            	clr	(x)
 741                     ; 247     j = 0;
 743  0265 0f1c          	clr	(OFST-1,sp)
 745                     ; 248     for (i = 2; i < 17; i++)
 747  0267 a602          	ld	a,#2
 748  0269 6b1d          	ld	(OFST+0,sp),a
 750  026b               L522:
 751                     ; 250         aunIMEI[j] = localBuffer[i];
 753  026b 7b1c          	ld	a,(OFST-1,sp)
 754  026d 5f            	clrw	x
 755  026e 97            	ld	xl,a
 756  026f 89            	pushw	x
 757  0270 96            	ldw	x,sp
 758  0271 1c0003        	addw	x,#OFST-26
 759  0274 9f            	ld	a,xl
 760  0275 5e            	swapw	x
 761  0276 1b1f          	add	a,(OFST+2,sp)
 762  0278 2401          	jrnc	L02
 763  027a 5c            	incw	x
 764  027b               L02:
 765  027b 02            	rlwa	x,a
 766  027c f6            	ld	a,(x)
 767  027d 85            	popw	x
 768  027e e710          	ld	(_aunIMEI,x),a
 769                     ; 251         j++;
 771  0280 0c1c          	inc	(OFST-1,sp)
 773                     ; 248     for (i = 2; i < 17; i++)
 775  0282 0c1d          	inc	(OFST+0,sp)
 779  0284 7b1d          	ld	a,(OFST+0,sp)
 780  0286 a111          	cp	a,#17
 781  0288 25e1          	jrult	L522
 782                     ; 253     aunIMEI[j] = '\0';
 784  028a 7b1c          	ld	a,(OFST-1,sp)
 785  028c 5f            	clrw	x
 786  028d 97            	ld	xl,a
 787  028e 6f10          	clr	(_aunIMEI,x)
 788                     ; 254     delay_ms(200);
 790  0290 ae00c8        	ldw	x,#200
 791  0293 cd0000        	call	_delay_ms
 793                     ; 256     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 795  0296 4b01          	push	#1
 796  0298 ae0255        	ldw	x,#597
 797  029b cd0000        	call	_UART1_ITConfig
 799  029e 84            	pop	a
 800                     ; 257     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
 802  029f 4b01          	push	#1
 803  02a1 ae0244        	ldw	x,#580
 804  02a4 cd0000        	call	_UART1_ITConfig
 806  02a7 84            	pop	a
 807                     ; 258 }
 810  02a8 5b1d          	addw	sp,#29
 811  02aa 81            	ret
 814                     	bsct
 815  0000               L332_unMQTTCounter:
 816  0000 00            	dc.b	0
 817  0001               L532_unMQQT_PingCounter:
 818  0001 00            	dc.b	0
 983                     ; 414 void vHandle_MQTT(void)
 983                     ; 415 {
 984                     	switch	.text
 985  02ab               _vHandle_MQTT:
 987  02ab 88            	push	a
 988       00000001      OFST:	set	1
 991                     ; 416     uint8_t unLength = 0;
 993                     ; 420     eTCP_Status = enGet_TCP_Status();
 995  02ac cd050b        	call	_enGet_TCP_Status
 997  02af 6b01          	ld	(OFST+0,sp),a
 999                     ; 422     if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
1001  02b1 7b01          	ld	a,(OFST+0,sp)
1002  02b3 a107          	cp	a,#7
1003  02b5 2703          	jreq	L42
1004  02b7 cc036a        	jp	L323
1005  02ba               L42:
1007  02ba 3d00          	tnz	_IMEIRecievedOKFlag
1008  02bc 2603          	jrne	L62
1009  02be cc036a        	jp	L323
1010  02c1               L62:
1011                     ; 424         if (unMQTTCounter == 0 /*&& !bCONNACK_Recieved*/)
1013  02c1 3d00          	tnz	L332_unMQTTCounter
1014  02c3 262e          	jrne	L523
1015                     ; 426             vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1017  02c5 4b64          	push	#100
1018  02c7 ae0000        	ldw	x,#_aunPushed_Data
1019  02ca cd04ee        	call	_vClearBuffer
1021  02cd 84            	pop	a
1022                     ; 427             unLength = (uint8_t)ulMQTT_Connect(aunPushed_Data, aunMQTT_ClientID/*punGet_Client_ID()*/ /*, FALSE, FALSE, FALSE, FALSE, TRUE, eQOS_0, NULL, NULL, NULL, NULL*/);
1024  02ce ae0000        	ldw	x,#_aunMQTT_ClientID
1025  02d1 89            	pushw	x
1026  02d2 ae0000        	ldw	x,#_aunPushed_Data
1027  02d5 cd0000        	call	_ulMQTT_Connect
1029  02d8 85            	popw	x
1030  02d9 b603          	ld	a,c_lreg+3
1031  02db 6b01          	ld	(OFST+0,sp),a
1033                     ; 428             if (bSendDataOverTCP(aunPushed_Data, unLength))
1035  02dd 7b01          	ld	a,(OFST+0,sp)
1036  02df 88            	push	a
1037  02e0 ae0000        	ldw	x,#_aunPushed_Data
1038  02e3 cd042b        	call	_bSendDataOverTCP
1040  02e6 5b01          	addw	sp,#1
1041  02e8 4d            	tnz	a
1042  02e9 2702          	jreq	L723
1043                     ; 429                 unMQTTCounter++;
1045  02eb 3c00          	inc	L332_unMQTTCounter
1046  02ed               L723:
1047                     ; 430             unMQQT_PingCounter = 0;
1049  02ed 3f01          	clr	L532_unMQQT_PingCounter
1051  02ef ac830383      	jpf	L553
1052  02f3               L523:
1053                     ; 432         else if (unMQTTCounter == 1)
1055  02f3 b600          	ld	a,L332_unMQTTCounter
1056  02f5 a101          	cp	a,#1
1057  02f7 262c          	jrne	L333
1058                     ; 434             vClearBuffer(aunPushed_Data, MEVRIS_RECV_DATA_MAX_SIZE);
1060  02f9 4b46          	push	#70
1061  02fb ae0000        	ldw	x,#_aunPushed_Data
1062  02fe cd04ee        	call	_vClearBuffer
1064  0301 84            	pop	a
1065                     ; 435             unLength = (uint8_t)ulMQTT_Subscribe(aunPushed_Data, aunMQTT_Subscribe_Topic/*punGet_Command_Topic()*/ /*, eQOS_0, 1*/);
1067  0302 ae0000        	ldw	x,#_aunMQTT_Subscribe_Topic
1068  0305 89            	pushw	x
1069  0306 ae0000        	ldw	x,#_aunPushed_Data
1070  0309 cd0000        	call	_ulMQTT_Subscribe
1072  030c 85            	popw	x
1073  030d b603          	ld	a,c_lreg+3
1074  030f 6b01          	ld	(OFST+0,sp),a
1076                     ; 436             if (bSendDataOverTCP(aunPushed_Data, unLength))
1078  0311 7b01          	ld	a,(OFST+0,sp)
1079  0313 88            	push	a
1080  0314 ae0000        	ldw	x,#_aunPushed_Data
1081  0317 cd042b        	call	_bSendDataOverTCP
1083  031a 5b01          	addw	sp,#1
1084  031c 4d            	tnz	a
1085  031d 2702          	jreq	L533
1086                     ; 437                 unMQTTCounter++;
1088  031f 3c00          	inc	L332_unMQTTCounter
1089  0321               L533:
1090                     ; 438             unMQQT_PingCounter = 0;
1092  0321 3f01          	clr	L532_unMQQT_PingCounter
1094  0323 205e          	jra	L553
1095  0325               L333:
1096                     ; 440         else if (unMQTTCounter == 2)
1098  0325 b600          	ld	a,L332_unMQTTCounter
1099  0327 a102          	cp	a,#2
1100  0329 260f          	jrne	L143
1101                     ; 442             delay_ms(100);
1103  032b ae0064        	ldw	x,#100
1104  032e cd0000        	call	_delay_ms
1106                     ; 443             vMevris_Send_IMEI();
1108  0331 cd0000        	call	_vMevris_Send_IMEI
1110                     ; 444             unMQTTCounter++;
1112  0334 3c00          	inc	L332_unMQTTCounter
1113                     ; 445             unMQQT_PingCounter = 0;
1115  0336 3f01          	clr	L532_unMQQT_PingCounter
1117  0338 2049          	jra	L553
1118  033a               L143:
1119                     ; 447         else if (unMQTTCounter == 3)
1121  033a b600          	ld	a,L332_unMQTTCounter
1122  033c a103          	cp	a,#3
1123  033e 260f          	jrne	L543
1124                     ; 449             delay_ms(100);
1126  0340 ae0064        	ldw	x,#100
1127  0343 cd0000        	call	_delay_ms
1129                     ; 450             vMevris_Send_Version();
1131  0346 cd0000        	call	_vMevris_Send_Version
1133                     ; 451             unMQTTCounter++;
1135  0349 3c00          	inc	L332_unMQTTCounter
1136                     ; 452             unMQQT_PingCounter = 0;
1138  034b 3f01          	clr	L532_unMQQT_PingCounter
1140  034d 2034          	jra	L553
1141  034f               L543:
1142                     ; 454         else if (unMQTTCounter == 4)
1144  034f b600          	ld	a,L332_unMQTTCounter
1145  0351 a104          	cp	a,#4
1146  0353 262e          	jrne	L553
1147                     ; 456             unMQQT_PingCounter++;
1149  0355 3c01          	inc	L532_unMQQT_PingCounter
1150                     ; 457             if (unMQQT_PingCounter >> 5)
1152  0357 b601          	ld	a,L532_unMQQT_PingCounter
1153  0359 4e            	swap	a
1154  035a 44            	srl	a
1155  035b a407          	and	a,#7
1156  035d 5f            	clrw	x
1157  035e 97            	ld	xl,a
1158  035f a30000        	cpw	x,#0
1159  0362 271f          	jreq	L553
1160                     ; 459                 vSend_MQTT_Ping();
1162  0364 ad26          	call	_vSend_MQTT_Ping
1164                     ; 460                 unMQQT_PingCounter = 0;
1166  0366 3f01          	clr	L532_unMQQT_PingCounter
1167  0368 2019          	jra	L553
1168  036a               L323:
1169                     ; 464     else if (eTCP_Status == eTCP_STAT_CONNECTING)
1171  036a 7b01          	ld	a,(OFST+0,sp)
1172  036c a106          	cp	a,#6
1173  036e 260c          	jrne	L753
1174                     ; 466         delay_ms(200);
1176  0370 ae00c8        	ldw	x,#200
1177  0373 cd0000        	call	_delay_ms
1179                     ; 467         unMQTTCounter = 0;
1181  0376 3f00          	clr	L332_unMQTTCounter
1182                     ; 468         unMQQT_PingCounter = 0;
1184  0378 3f01          	clr	L532_unMQQT_PingCounter
1186  037a 2007          	jra	L553
1187  037c               L753:
1188                     ; 472         vTCP_Reconnect();
1190  037c cd0627        	call	_vTCP_Reconnect
1192                     ; 473         unMQQT_PingCounter = 0;
1194  037f 3f01          	clr	L532_unMQQT_PingCounter
1195                     ; 474         unMQTTCounter = 0;
1197  0381 3f00          	clr	L332_unMQTTCounter
1198  0383               L553:
1199                     ; 476     if (IMEIRecievedOKFlag == 0)
1201  0383 3d00          	tnz	_IMEIRecievedOKFlag
1202  0385 2603          	jrne	L363
1203                     ; 478         vPrintStickerInfo();
1205  0387 cd06da        	call	_vPrintStickerInfo
1207  038a               L363:
1208                     ; 480 }
1211  038a 84            	pop	a
1212  038b 81            	ret
1250                     ; 482 void vSend_MQTT_Ping(void)
1250                     ; 483 {
1251                     	switch	.text
1252  038c               _vSend_MQTT_Ping:
1254  038c 88            	push	a
1255       00000001      OFST:	set	1
1258                     ; 484     uint8_t unLength = 0;
1260                     ; 485     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1262  038d 4b64          	push	#100
1263  038f ae0000        	ldw	x,#_aunPushed_Data
1264  0392 cd04ee        	call	_vClearBuffer
1266  0395 84            	pop	a
1267                     ; 488         unLength = (uint8_t)unMQTT_PingRequest(aunPushed_Data);
1269  0396 ae0000        	ldw	x,#_aunPushed_Data
1270  0399 cd0000        	call	_unMQTT_PingRequest
1272  039c 6b01          	ld	(OFST+0,sp),a
1274                     ; 489         bSendDataOverTCP(aunPushed_Data, unLength);
1276  039e 7b01          	ld	a,(OFST+0,sp)
1277  03a0 88            	push	a
1278  03a1 ae0000        	ldw	x,#_aunPushed_Data
1279  03a4 cd042b        	call	_bSendDataOverTCP
1281  03a7 84            	pop	a
1282                     ; 491 }
1285  03a8 84            	pop	a
1286  03a9 81            	ret
1328                     ; 493 void vInit_MQTT(void)
1328                     ; 494 {
1329                     	switch	.text
1330  03aa               _vInit_MQTT:
1332  03aa 88            	push	a
1333       00000001      OFST:	set	1
1336                     ; 495     uint8_t unLength = 0;
1338                     ; 497     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1340  03ab 4b64          	push	#100
1341  03ad ae0000        	ldw	x,#_aunPushed_Data
1342  03b0 cd04ee        	call	_vClearBuffer
1344  03b3 84            	pop	a
1345                     ; 498     unLength = (uint8_t)ulMQTT_Connect(aunPushed_Data, punGet_Client_ID() /*, FALSE, FALSE, FALSE, FALSE, TRUE, eQOS_0, NULL, NULL, NULL, NULL*/);
1347  03b4 cd0000        	call	_punGet_Client_ID
1349  03b7 89            	pushw	x
1350  03b8 ae0000        	ldw	x,#_aunPushed_Data
1351  03bb cd0000        	call	_ulMQTT_Connect
1353  03be 85            	popw	x
1354  03bf b603          	ld	a,c_lreg+3
1355  03c1 6b01          	ld	(OFST+0,sp),a
1357                     ; 499     bSendDataOverTCP(aunPushed_Data, unLength);
1359  03c3 7b01          	ld	a,(OFST+0,sp)
1360  03c5 88            	push	a
1361  03c6 ae0000        	ldw	x,#_aunPushed_Data
1362  03c9 ad60          	call	_bSendDataOverTCP
1364  03cb 84            	pop	a
1365                     ; 500     delay_ms(1000);
1367  03cc ae03e8        	ldw	x,#1000
1368  03cf cd0000        	call	_delay_ms
1370                     ; 501     delay_ms(1000);
1372  03d2 ae03e8        	ldw	x,#1000
1373  03d5 cd0000        	call	_delay_ms
1375                     ; 502     delay_ms(1000);
1377  03d8 ae03e8        	ldw	x,#1000
1378  03db cd0000        	call	_delay_ms
1380                     ; 503     delay_ms(1000);
1382  03de ae03e8        	ldw	x,#1000
1383  03e1 cd0000        	call	_delay_ms
1385                     ; 504     delay_ms(1000);
1387  03e4 ae03e8        	ldw	x,#1000
1388  03e7 cd0000        	call	_delay_ms
1390                     ; 505     vClearBuffer(aunPushed_Data, MEVRIS_RECV_DATA_MAX_SIZE);
1392  03ea 4b46          	push	#70
1393  03ec ae0000        	ldw	x,#_aunPushed_Data
1394  03ef cd04ee        	call	_vClearBuffer
1396  03f2 84            	pop	a
1397                     ; 506     unLength = (uint8_t)ulMQTT_Subscribe(aunPushed_Data, punGet_Command_Topic() /*, eQOS_0, 1*/);
1399  03f3 cd0000        	call	_punGet_Command_Topic
1401  03f6 89            	pushw	x
1402  03f7 ae0000        	ldw	x,#_aunPushed_Data
1403  03fa cd0000        	call	_ulMQTT_Subscribe
1405  03fd 85            	popw	x
1406  03fe b603          	ld	a,c_lreg+3
1407  0400 6b01          	ld	(OFST+0,sp),a
1409                     ; 507     bSendDataOverTCP(aunPushed_Data, unLength);
1411  0402 7b01          	ld	a,(OFST+0,sp)
1412  0404 88            	push	a
1413  0405 ae0000        	ldw	x,#_aunPushed_Data
1414  0408 ad21          	call	_bSendDataOverTCP
1416  040a 84            	pop	a
1417                     ; 508     delay_ms(1000);
1419  040b ae03e8        	ldw	x,#1000
1420  040e cd0000        	call	_delay_ms
1422                     ; 509     delay_ms(1000);
1424  0411 ae03e8        	ldw	x,#1000
1425  0414 cd0000        	call	_delay_ms
1427                     ; 510     delay_ms(1000);
1429  0417 ae03e8        	ldw	x,#1000
1430  041a cd0000        	call	_delay_ms
1432                     ; 511     delay_ms(1000);
1434  041d ae03e8        	ldw	x,#1000
1435  0420 cd0000        	call	_delay_ms
1437                     ; 512     delay_ms(1000);
1439  0423 ae03e8        	ldw	x,#1000
1440  0426 cd0000        	call	_delay_ms
1442                     ; 513 }
1445  0429 84            	pop	a
1446  042a 81            	ret
1449                     .const:	section	.text
1450  0000               L124_tempData:
1451  0000 00            	dc.b	0
1452  0001 000000000000  	ds.b	14
1453  000f               L324_temp1:
1454  000f 00            	dc.b	0
1455  0010 00000000      	ds.b	4
1557                     ; 516 bool bSendDataOverTCP(uint8_t *Data, uint8_t unLength)
1557                     ; 517 {
1558                     	switch	.text
1559  042b               _bSendDataOverTCP:
1561  042b 89            	pushw	x
1562  042c 5215          	subw	sp,#21
1563       00000015      OFST:	set	21
1566                     ; 518     uint8_t timeout = 0;
1568  042e 0f01          	clr	(OFST-20,sp)
1570                     ; 519     uint8_t tempData[15] = "";
1572  0430 96            	ldw	x,sp
1573  0431 1c0007        	addw	x,#OFST-14
1574  0434 90ae0000      	ldw	y,#L124_tempData
1575  0438 a60f          	ld	a,#15
1576  043a cd0000        	call	c_xymvx
1578                     ; 520     uint8_t temp1[5] = "";
1580  043d 96            	ldw	x,sp
1581  043e 1c0002        	addw	x,#OFST-19
1582  0441 90ae000f      	ldw	y,#L324_temp1
1583  0445 a605          	ld	a,#5
1584  0447 cd0000        	call	c_xymvx
1586                     ; 521     vClearBuffer(tempData, 15);
1588  044a 4b0f          	push	#15
1589  044c 96            	ldw	x,sp
1590  044d 1c0008        	addw	x,#OFST-13
1591  0450 cd04ee        	call	_vClearBuffer
1593  0453 84            	pop	a
1594                     ; 522     strcpy(tempData, "AT+CIPSEND=");
1596  0454 96            	ldw	x,sp
1597  0455 1c0007        	addw	x,#OFST-14
1598  0458 90ae00d5      	ldw	y,#L374
1599  045c               L63:
1600  045c 90f6          	ld	a,(y)
1601  045e 905c          	incw	y
1602  0460 f7            	ld	(x),a
1603  0461 5c            	incw	x
1604  0462 4d            	tnz	a
1605  0463 26f7          	jrne	L63
1606                     ; 523     vClearBuffer(temp1,5);
1608  0465 4b05          	push	#5
1609  0467 96            	ldw	x,sp
1610  0468 1c0003        	addw	x,#OFST-18
1611  046b cd04ee        	call	_vClearBuffer
1613  046e 84            	pop	a
1614                     ; 524     sprintf(temp1, "%d", (uint16_t)unLength);
1616  046f 7b1a          	ld	a,(OFST+5,sp)
1617  0471 5f            	clrw	x
1618  0472 97            	ld	xl,a
1619  0473 89            	pushw	x
1620  0474 ae00d2        	ldw	x,#L574
1621  0477 89            	pushw	x
1622  0478 96            	ldw	x,sp
1623  0479 1c0006        	addw	x,#OFST-15
1624  047c cd0000        	call	_sprintf
1626  047f 5b04          	addw	sp,#4
1627                     ; 525     strcat(tempData,temp1);
1629  0481 96            	ldw	x,sp
1630  0482 1c0002        	addw	x,#OFST-19
1631  0485 89            	pushw	x
1632  0486 96            	ldw	x,sp
1633  0487 1c0009        	addw	x,#OFST-12
1634  048a cd0000        	call	_strcat
1636  048d 85            	popw	x
1637                     ; 527     ms_send_cmd(tempData, strlen((const char *)tempData));
1639  048e 96            	ldw	x,sp
1640  048f 1c0007        	addw	x,#OFST-14
1641  0492 cd0000        	call	_strlen
1643  0495 9f            	ld	a,xl
1644  0496 88            	push	a
1645  0497 96            	ldw	x,sp
1646  0498 1c0008        	addw	x,#OFST-13
1647  049b cd0000        	call	_ms_send_cmd
1649  049e 84            	pop	a
1650                     ; 528     delay_ms(100);
1652  049f ae0064        	ldw	x,#100
1653  04a2 cd0000        	call	_delay_ms
1655                     ; 529     ms_send_cmd_TCP(Data, unLength);
1657  04a5 7b1a          	ld	a,(OFST+5,sp)
1658  04a7 88            	push	a
1659  04a8 1e17          	ldw	x,(OFST+2,sp)
1660  04aa cd0000        	call	_ms_send_cmd_TCP
1662  04ad 84            	pop	a
1663                     ; 530     delay_ms(200);
1665  04ae ae00c8        	ldw	x,#200
1666  04b1 cd0000        	call	_delay_ms
1669  04b4 2006          	jra	L105
1670  04b6               L774:
1671                     ; 533         delay_ms(100);
1673  04b6 ae0064        	ldw	x,#100
1674  04b9 cd0000        	call	_delay_ms
1676  04bc               L105:
1677                     ; 532     while (!strstr(response_buffer, "SEND") && (++timeout != 100))
1679  04bc ae00cd        	ldw	x,#L705
1680  04bf 89            	pushw	x
1681  04c0 ae0000        	ldw	x,#_response_buffer
1682  04c3 cd0000        	call	_strstr
1684  04c6 5b02          	addw	sp,#2
1685  04c8 a30000        	cpw	x,#0
1686  04cb 2608          	jrne	L505
1688  04cd 0c01          	inc	(OFST-20,sp)
1690  04cf 7b01          	ld	a,(OFST-20,sp)
1691  04d1 a164          	cp	a,#100
1692  04d3 26e1          	jrne	L774
1693  04d5               L505:
1694                     ; 534     if (strstr(response_buffer, "SEND OK"))
1696  04d5 ae00c5        	ldw	x,#L315
1697  04d8 89            	pushw	x
1698  04d9 ae0000        	ldw	x,#_response_buffer
1699  04dc cd0000        	call	_strstr
1701  04df 5b02          	addw	sp,#2
1702  04e1 a30000        	cpw	x,#0
1703  04e4 2704          	jreq	L115
1704                     ; 536         return TRUE;
1706  04e6 a601          	ld	a,#1
1708  04e8 2001          	jra	L04
1709  04ea               L115:
1710                     ; 540         return FALSE;
1712  04ea 4f            	clr	a
1714  04eb               L04:
1716  04eb 5b17          	addw	sp,#23
1717  04ed 81            	ret
1770                     ; 544 void vClearBuffer(char *temp, uint8_t unLen)
1770                     ; 545 {
1771                     	switch	.text
1772  04ee               _vClearBuffer:
1774  04ee 89            	pushw	x
1775  04ef 88            	push	a
1776       00000001      OFST:	set	1
1779                     ; 547     for (i = 0; i < unLen; i++)
1781  04f0 0f01          	clr	(OFST+0,sp)
1784  04f2 200e          	jra	L155
1785  04f4               L545:
1786                     ; 549         *(temp + i) = '\0';
1788  04f4 7b02          	ld	a,(OFST+1,sp)
1789  04f6 97            	ld	xl,a
1790  04f7 7b03          	ld	a,(OFST+2,sp)
1791  04f9 1b01          	add	a,(OFST+0,sp)
1792  04fb 2401          	jrnc	L44
1793  04fd 5c            	incw	x
1794  04fe               L44:
1795  04fe 02            	rlwa	x,a
1796  04ff 7f            	clr	(x)
1797                     ; 547     for (i = 0; i < unLen; i++)
1799  0500 0c01          	inc	(OFST+0,sp)
1801  0502               L155:
1804  0502 7b01          	ld	a,(OFST+0,sp)
1805  0504 1106          	cp	a,(OFST+5,sp)
1806  0506 25ec          	jrult	L545
1807                     ; 551 }
1810  0508 5b03          	addw	sp,#3
1811  050a 81            	ret
1852                     ; 553 enTCP_STATUS enGet_TCP_Status(void)
1852                     ; 554 {
1853                     	switch	.text
1854  050b               _enGet_TCP_Status:
1856  050b 88            	push	a
1857       00000001      OFST:	set	1
1860                     ; 557     ms_send_cmd(TCP_GET_STATUS, strlen((const char *)TCP_GET_STATUS));
1862  050c 4b0c          	push	#12
1863  050e ae00b8        	ldw	x,#L375
1864  0511 cd0000        	call	_ms_send_cmd
1866  0514 84            	pop	a
1867                     ; 558     delay_ms(1000);
1869  0515 ae03e8        	ldw	x,#1000
1870  0518 cd0000        	call	_delay_ms
1872                     ; 560     if (strstr(response_buffer, "STATE:"))
1874  051b ae00b1        	ldw	x,#L775
1875  051e 89            	pushw	x
1876  051f ae0000        	ldw	x,#_response_buffer
1877  0522 cd0000        	call	_strstr
1879  0525 5b02          	addw	sp,#2
1880  0527 a30000        	cpw	x,#0
1881  052a 2603          	jrne	L05
1882  052c cc0620        	jp	L575
1883  052f               L05:
1884                     ; 562         if (strstr(response_buffer, "IP INITIAL"))
1886  052f ae00a6        	ldw	x,#L306
1887  0532 89            	pushw	x
1888  0533 ae0000        	ldw	x,#_response_buffer
1889  0536 cd0000        	call	_strstr
1891  0539 5b02          	addw	sp,#2
1892  053b a30000        	cpw	x,#0
1893  053e 2708          	jreq	L106
1894                     ; 564             eStatus = eTCP_STAT_IP_INITIAL;
1896  0540 a601          	ld	a,#1
1897  0542 6b01          	ld	(OFST+0,sp),a
1900  0544 ac220622      	jpf	L576
1901  0548               L106:
1902                     ; 566         else if (strstr(response_buffer, "IP START"))
1904  0548 ae009d        	ldw	x,#L116
1905  054b 89            	pushw	x
1906  054c ae0000        	ldw	x,#_response_buffer
1907  054f cd0000        	call	_strstr
1909  0552 5b02          	addw	sp,#2
1910  0554 a30000        	cpw	x,#0
1911  0557 2708          	jreq	L706
1912                     ; 568             eStatus = eTCP_STAT_IP_START;
1914  0559 a602          	ld	a,#2
1915  055b 6b01          	ld	(OFST+0,sp),a
1918  055d ac220622      	jpf	L576
1919  0561               L706:
1920                     ; 570         else if (strstr(response_buffer, "IP CONFIG"))
1922  0561 ae0093        	ldw	x,#L716
1923  0564 89            	pushw	x
1924  0565 ae0000        	ldw	x,#_response_buffer
1925  0568 cd0000        	call	_strstr
1927  056b 5b02          	addw	sp,#2
1928  056d a30000        	cpw	x,#0
1929  0570 2708          	jreq	L516
1930                     ; 572             eStatus = eTCP_STAT_IP_CONFIG;
1932  0572 a603          	ld	a,#3
1933  0574 6b01          	ld	(OFST+0,sp),a
1936  0576 ac220622      	jpf	L576
1937  057a               L516:
1938                     ; 574         else if (strstr(response_buffer, "IP GPRSACT"))
1940  057a ae0088        	ldw	x,#L526
1941  057d 89            	pushw	x
1942  057e ae0000        	ldw	x,#_response_buffer
1943  0581 cd0000        	call	_strstr
1945  0584 5b02          	addw	sp,#2
1946  0586 a30000        	cpw	x,#0
1947  0589 2707          	jreq	L326
1948                     ; 576             eStatus = eTCP_STAT_IP_GPRSACT;
1950  058b a604          	ld	a,#4
1951  058d 6b01          	ld	(OFST+0,sp),a
1954  058f cc0622        	jra	L576
1955  0592               L326:
1956                     ; 578         else if (strstr(response_buffer, "IP STATUS"))
1958  0592 ae007e        	ldw	x,#L336
1959  0595 89            	pushw	x
1960  0596 ae0000        	ldw	x,#_response_buffer
1961  0599 cd0000        	call	_strstr
1963  059c 5b02          	addw	sp,#2
1964  059e a30000        	cpw	x,#0
1965  05a1 2706          	jreq	L136
1966                     ; 580             eStatus = eTCP_STAT_IP_STATUS;
1968  05a3 a605          	ld	a,#5
1969  05a5 6b01          	ld	(OFST+0,sp),a
1972  05a7 2079          	jra	L576
1973  05a9               L136:
1974                     ; 582         else if (strstr(response_buffer, "TCP CONNECTING"))
1976  05a9 ae006f        	ldw	x,#L146
1977  05ac 89            	pushw	x
1978  05ad ae0000        	ldw	x,#_response_buffer
1979  05b0 cd0000        	call	_strstr
1981  05b3 5b02          	addw	sp,#2
1982  05b5 a30000        	cpw	x,#0
1983  05b8 2706          	jreq	L736
1984                     ; 584             eStatus = eTCP_STAT_CONNECTING;
1986  05ba a606          	ld	a,#6
1987  05bc 6b01          	ld	(OFST+0,sp),a
1990  05be 2062          	jra	L576
1991  05c0               L736:
1992                     ; 586         else if (strstr(response_buffer, "CONNECT OK"))
1994  05c0 ae0064        	ldw	x,#L746
1995  05c3 89            	pushw	x
1996  05c4 ae0000        	ldw	x,#_response_buffer
1997  05c7 cd0000        	call	_strstr
1999  05ca 5b02          	addw	sp,#2
2000  05cc a30000        	cpw	x,#0
2001  05cf 2706          	jreq	L546
2002                     ; 588             eStatus = eTCP_STAT_CONNECT_OK;
2004  05d1 a607          	ld	a,#7
2005  05d3 6b01          	ld	(OFST+0,sp),a
2008  05d5 204b          	jra	L576
2009  05d7               L546:
2010                     ; 590         else if (strstr(response_buffer, "TCP CLOSING"))
2012  05d7 ae0058        	ldw	x,#L556
2013  05da 89            	pushw	x
2014  05db ae0000        	ldw	x,#_response_buffer
2015  05de cd0000        	call	_strstr
2017  05e1 5b02          	addw	sp,#2
2018  05e3 a30000        	cpw	x,#0
2019  05e6 2706          	jreq	L356
2020                     ; 592             eStatus = eTCP_STAT_CLOSING;
2022  05e8 a608          	ld	a,#8
2023  05ea 6b01          	ld	(OFST+0,sp),a
2026  05ec 2034          	jra	L576
2027  05ee               L356:
2028                     ; 594         else if (strstr(response_buffer, "TCP CLOSED"))
2030  05ee ae004d        	ldw	x,#L366
2031  05f1 89            	pushw	x
2032  05f2 ae0000        	ldw	x,#_response_buffer
2033  05f5 cd0000        	call	_strstr
2035  05f8 5b02          	addw	sp,#2
2036  05fa a30000        	cpw	x,#0
2037  05fd 2706          	jreq	L166
2038                     ; 596             eStatus = eTCP_STAT_CLOSED;
2040  05ff a609          	ld	a,#9
2041  0601 6b01          	ld	(OFST+0,sp),a
2044  0603 201d          	jra	L576
2045  0605               L166:
2046                     ; 598         else if (strstr(response_buffer, "PDP DEACT"))
2048  0605 ae0043        	ldw	x,#L176
2049  0608 89            	pushw	x
2050  0609 ae0000        	ldw	x,#_response_buffer
2051  060c cd0000        	call	_strstr
2053  060f 5b02          	addw	sp,#2
2054  0611 a30000        	cpw	x,#0
2055  0614 2706          	jreq	L766
2056                     ; 600             eStatus = eTCP_STAT_PDP_DEACT;
2058  0616 a60a          	ld	a,#10
2059  0618 6b01          	ld	(OFST+0,sp),a
2062  061a 2006          	jra	L576
2063  061c               L766:
2064                     ; 604             eStatus = eTCP_STAT_UNKNOWN;
2066  061c 0f01          	clr	(OFST+0,sp)
2068  061e 2002          	jra	L576
2069  0620               L575:
2070                     ; 609         eStatus = eTCP_STAT_UNKNOWN;
2072  0620 0f01          	clr	(OFST+0,sp)
2074  0622               L576:
2075                     ; 611     return eStatus;
2077  0622 7b01          	ld	a,(OFST+0,sp)
2080  0624 5b01          	addw	sp,#1
2081  0626 81            	ret
2107                     ; 615 void vTCP_Reconnect(void)
2107                     ; 616 {
2108                     	switch	.text
2109  0627               _vTCP_Reconnect:
2113                     ; 617     ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
2115  0627 4b0a          	push	#10
2116  0629 ae01a3        	ldw	x,#L74
2117  062c cd0000        	call	_ms_send_cmd
2119  062f 84            	pop	a
2120                     ; 618     delay_ms(1000);
2122  0630 ae03e8        	ldw	x,#1000
2123  0633 cd0000        	call	_delay_ms
2125                     ; 619     ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
2127  0636 4b11          	push	#17
2128  0638 ae0137        	ldw	x,#L76
2129  063b cd0000        	call	_ms_send_cmd
2131  063e 84            	pop	a
2132                     ; 620     delay_ms(1000);
2134  063f ae03e8        	ldw	x,#1000
2135  0642 cd0000        	call	_delay_ms
2137                     ; 621     ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
2139  0645 4b08          	push	#8
2140  0647 ae012e        	ldw	x,#L17
2141  064a cd0000        	call	_ms_send_cmd
2143  064d 84            	pop	a
2144                     ; 622     delay_ms(1000);
2146  064e ae03e8        	ldw	x,#1000
2147  0651 cd0000        	call	_delay_ms
2149                     ; 623     ms_send_cmd("AT+CIFSR", strlen((const char *)"AT+CIFSR")); /* OPEN BEARER */
2151  0654 4b08          	push	#8
2152  0656 ae0125        	ldw	x,#L37
2153  0659 cd0000        	call	_ms_send_cmd
2155  065c 84            	pop	a
2156                     ; 624     delay_ms(1000);
2158  065d ae03e8        	ldw	x,#1000
2159  0660 cd0000        	call	_delay_ms
2161                     ; 625     ms_send_cmd(startTCP_CMD, strlen((const char *)startTCP_CMD)); /* OPEN BEARER */
2163  0663 4b29          	push	#41
2164  0665 ae00fb        	ldw	x,#L57
2165  0668 cd0000        	call	_ms_send_cmd
2167  066b 84            	pop	a
2168                     ; 626     delay_ms(1000);
2170  066c ae03e8        	ldw	x,#1000
2171  066f cd0000        	call	_delay_ms
2173                     ; 628 }
2176  0672 81            	ret
2242                     ; 631 bool bValidIMEIRecieved(char *myArray)
2242                     ; 632 {
2243                     	switch	.text
2244  0673               _bValidIMEIRecieved:
2246  0673 89            	pushw	x
2247  0674 5203          	subw	sp,#3
2248       00000003      OFST:	set	3
2251                     ; 633     uint8_t i = 0, j = 0, k = 0;
2257  0676 0f02          	clr	(OFST-1,sp)
2259                     ; 634     for (j = 0; j < 20; j++)
2261  0678 0f03          	clr	(OFST+0,sp)
2263  067a               L147:
2264                     ; 636         if (myArray[j] > 0x39 || myArray[j] < 0x30)
2266  067a 7b04          	ld	a,(OFST+1,sp)
2267  067c 97            	ld	xl,a
2268  067d 7b05          	ld	a,(OFST+2,sp)
2269  067f 1b03          	add	a,(OFST+0,sp)
2270  0681 2401          	jrnc	L65
2271  0683 5c            	incw	x
2272  0684               L65:
2273  0684 02            	rlwa	x,a
2274  0685 f6            	ld	a,(x)
2275  0686 a13a          	cp	a,#58
2276  0688 2410          	jruge	L157
2278  068a 7b04          	ld	a,(OFST+1,sp)
2279  068c 97            	ld	xl,a
2280  068d 7b05          	ld	a,(OFST+2,sp)
2281  068f 1b03          	add	a,(OFST+0,sp)
2282  0691 2401          	jrnc	L06
2283  0693 5c            	incw	x
2284  0694               L06:
2285  0694 02            	rlwa	x,a
2286  0695 f6            	ld	a,(x)
2287  0696 a130          	cp	a,#48
2288  0698 2419          	jruge	L747
2289  069a               L157:
2290                     ; 638             nop();
2293  069a 9d            nop
2296  069b               L357:
2297                     ; 634     for (j = 0; j < 20; j++)
2299  069b 0c03          	inc	(OFST+0,sp)
2303  069d 7b03          	ld	a,(OFST+0,sp)
2304  069f a114          	cp	a,#20
2305  06a1 25d7          	jrult	L147
2306                     ; 645     if (k == 15)
2308  06a3 7b02          	ld	a,(OFST-1,sp)
2309  06a5 a10f          	cp	a,#15
2310  06a7 2624          	jrne	L557
2311                     ; 647         aunIMEI[k] = '\0';
2313  06a9 7b02          	ld	a,(OFST-1,sp)
2314  06ab 5f            	clrw	x
2315  06ac 97            	ld	xl,a
2316  06ad 6f10          	clr	(_aunIMEI,x)
2317                     ; 648         return TRUE;
2319  06af a601          	ld	a,#1
2321  06b1 2024          	jra	L46
2322  06b3               L747:
2323                     ; 642             aunIMEI[k++] = myArray[j];
2325  06b3 7b02          	ld	a,(OFST-1,sp)
2326  06b5 97            	ld	xl,a
2327  06b6 0c02          	inc	(OFST-1,sp)
2329  06b8 9f            	ld	a,xl
2330  06b9 5f            	clrw	x
2331  06ba 97            	ld	xl,a
2332  06bb 89            	pushw	x
2333  06bc 7b06          	ld	a,(OFST+3,sp)
2334  06be 97            	ld	xl,a
2335  06bf 7b07          	ld	a,(OFST+4,sp)
2336  06c1 1b05          	add	a,(OFST+2,sp)
2337  06c3 2401          	jrnc	L26
2338  06c5 5c            	incw	x
2339  06c6               L26:
2340  06c6 02            	rlwa	x,a
2341  06c7 f6            	ld	a,(x)
2342  06c8 85            	popw	x
2343  06c9 e710          	ld	(_aunIMEI,x),a
2344  06cb 20ce          	jra	L357
2345  06cd               L557:
2346                     ; 652         vClearBuffer(aunIMEI, 16);
2348  06cd 4b10          	push	#16
2349  06cf ae0010        	ldw	x,#_aunIMEI
2350  06d2 cd04ee        	call	_vClearBuffer
2352  06d5 84            	pop	a
2353                     ; 653         return FALSE;
2355  06d6 4f            	clr	a
2357  06d7               L46:
2359  06d7 5b05          	addw	sp,#5
2360  06d9 81            	ret
2363                     	switch	.const
2364  0014               L167_imei_array:
2365  0014 00            	dc.b	0
2366  0015 000000000000  	ds.b	19
2470                     ; 658 void vPrintStickerInfo(void)
2470                     ; 659 {
2471                     	switch	.text
2472  06da               _vPrintStickerInfo:
2474  06da 521a          	subw	sp,#26
2475       0000001a      OFST:	set	26
2478                     ; 660     uint8_t p = 0, i = 0;
2482                     ; 661     uint8_t NotRespondingCounter = 0;
2484  06dc 0f19          	clr	(OFST-1,sp)
2486                     ; 662     uint16_t gsm_ok_timeout = 10000;
2488                     ; 663     uint8_t imei_array[20] = {0};
2490  06de 96            	ldw	x,sp
2491  06df 1c0004        	addw	x,#OFST-22
2492  06e2 90ae0014      	ldw	y,#L167_imei_array
2493  06e6 a614          	ld	a,#20
2494  06e8 cd0000        	call	c_xymvx
2496                     ; 664     bool ModuleResponding = FALSE;
2498                     ; 665     bool myInterruptFlag = TRUE;
2500                     ; 667     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
2502  06eb 4b00          	push	#0
2503  06ed ae0255        	ldw	x,#597
2504  06f0 cd0000        	call	_UART1_ITConfig
2506  06f3 84            	pop	a
2507                     ; 668     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
2509  06f4 4b00          	push	#0
2510  06f6 ae0244        	ldw	x,#580
2511  06f9 cd0000        	call	_UART1_ITConfig
2513  06fc 84            	pop	a
2514                     ; 669     delay_ms(100);
2516  06fd ae0064        	ldw	x,#100
2517  0700 cd0000        	call	_delay_ms
2519  0703               L1301:
2520                     ; 673         ms_send_cmd(AT, strlen((const char *)AT));
2522  0703 4b02          	push	#2
2523  0705 ae0040        	ldw	x,#L7301
2524  0708 cd0000        	call	_ms_send_cmd
2526  070b 84            	pop	a
2527                     ; 674         if (GSM_OK())
2529  070c cd0000        	call	_GSM_OK
2531  070f a30000        	cpw	x,#0
2532  0712 2603          	jrne	L07
2533  0714 cc084b        	jp	L1401
2534  0717               L07:
2535                     ; 676             delay_ms(200);
2537  0717 ae00c8        	ldw	x,#200
2538  071a cd0000        	call	_delay_ms
2540                     ; 678             getIMEI();
2542  071d cd0207        	call	_getIMEI
2544                     ; 679             if (bValidIMEIRecieved(aunIMEI))
2546  0720 ae0010        	ldw	x,#_aunIMEI
2547  0723 cd0673        	call	_bValidIMEIRecieved
2549  0726 4d            	tnz	a
2550  0727 2603          	jrne	L27
2551  0729 cc083f        	jp	L3401
2552  072c               L27:
2553                     ; 681                 delay_ms(100);
2555  072c ae0064        	ldw	x,#100
2556  072f cd0000        	call	_delay_ms
2558                     ; 682                 for (i = 0; i < 20; i++)
2560  0732 0f1a          	clr	(OFST+0,sp)
2562  0734               L5501:
2563                     ; 684                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2565  0734 ae0040        	ldw	x,#64
2566  0737 cd0000        	call	_UART1_GetFlagStatus
2568  073a 4d            	tnz	a
2569  073b 27f7          	jreq	L5501
2570                     ; 686                     UART1_SendData8('*');
2572  073d a62a          	ld	a,#42
2573  073f cd0000        	call	_UART1_SendData8
2575                     ; 682                 for (i = 0; i < 20; i++)
2577  0742 0c1a          	inc	(OFST+0,sp)
2581  0744 7b1a          	ld	a,(OFST+0,sp)
2582  0746 a114          	cp	a,#20
2583  0748 25ea          	jrult	L5501
2585  074a               L3601:
2586                     ; 688                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2588  074a ae0040        	ldw	x,#64
2589  074d cd0000        	call	_UART1_GetFlagStatus
2591  0750 4d            	tnz	a
2592  0751 27f7          	jreq	L3601
2593                     ; 690                 UART1_SendData8('\n');
2595  0753 a60a          	ld	a,#10
2596  0755 cd0000        	call	_UART1_SendData8
2599  0758               L1701:
2600                     ; 691                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2602  0758 ae0040        	ldw	x,#64
2603  075b cd0000        	call	_UART1_GetFlagStatus
2605  075e 4d            	tnz	a
2606  075f 27f7          	jreq	L1701
2607                     ; 693                 UART1_SendData8('I');
2609  0761 a649          	ld	a,#73
2610  0763 cd0000        	call	_UART1_SendData8
2613  0766               L7701:
2614                     ; 694                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2616  0766 ae0040        	ldw	x,#64
2617  0769 cd0000        	call	_UART1_GetFlagStatus
2619  076c 4d            	tnz	a
2620  076d 27f7          	jreq	L7701
2621                     ; 696                 UART1_SendData8('M');
2623  076f a64d          	ld	a,#77
2624  0771 cd0000        	call	_UART1_SendData8
2627  0774               L5011:
2628                     ; 697                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2630  0774 ae0040        	ldw	x,#64
2631  0777 cd0000        	call	_UART1_GetFlagStatus
2633  077a 4d            	tnz	a
2634  077b 27f7          	jreq	L5011
2635                     ; 699                 UART1_SendData8('E');
2637  077d a645          	ld	a,#69
2638  077f cd0000        	call	_UART1_SendData8
2641  0782               L3111:
2642                     ; 700                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2644  0782 ae0040        	ldw	x,#64
2645  0785 cd0000        	call	_UART1_GetFlagStatus
2647  0788 4d            	tnz	a
2648  0789 27f7          	jreq	L3111
2649                     ; 702                 UART1_SendData8('I');
2651  078b a649          	ld	a,#73
2652  078d cd0000        	call	_UART1_SendData8
2655  0790               L1211:
2656                     ; 703                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2658  0790 ae0040        	ldw	x,#64
2659  0793 cd0000        	call	_UART1_GetFlagStatus
2661  0796 4d            	tnz	a
2662  0797 27f7          	jreq	L1211
2663                     ; 705                 UART1_SendData8(' ');
2665  0799 a620          	ld	a,#32
2666  079b cd0000        	call	_UART1_SendData8
2669  079e               L7211:
2670                     ; 706                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2672  079e ae0040        	ldw	x,#64
2673  07a1 cd0000        	call	_UART1_GetFlagStatus
2675  07a4 4d            	tnz	a
2676  07a5 27f7          	jreq	L7211
2677                     ; 708                 UART1_SendData8('i');
2679  07a7 a669          	ld	a,#105
2680  07a9 cd0000        	call	_UART1_SendData8
2683  07ac               L5311:
2684                     ; 709                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2686  07ac ae0040        	ldw	x,#64
2687  07af cd0000        	call	_UART1_GetFlagStatus
2689  07b2 4d            	tnz	a
2690  07b3 27f7          	jreq	L5311
2691                     ; 711                 UART1_SendData8('s');
2693  07b5 a673          	ld	a,#115
2694  07b7 cd0000        	call	_UART1_SendData8
2697  07ba               L3411:
2698                     ; 712                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2700  07ba ae0040        	ldw	x,#64
2701  07bd cd0000        	call	_UART1_GetFlagStatus
2703  07c0 4d            	tnz	a
2704  07c1 27f7          	jreq	L3411
2705                     ; 714                 UART1_SendData8('\n');
2707  07c3 a60a          	ld	a,#10
2708  07c5 cd0000        	call	_UART1_SendData8
2711  07c8               L1511:
2712                     ; 716                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2714  07c8 ae0040        	ldw	x,#64
2715  07cb cd0000        	call	_UART1_GetFlagStatus
2717  07ce 4d            	tnz	a
2718  07cf 27f7          	jreq	L1511
2719                     ; 718                 UART1_SendData8('\n');
2721  07d1 a60a          	ld	a,#10
2722  07d3 cd0000        	call	_UART1_SendData8
2724                     ; 719                 for (i = 0; i < 15; i++)
2726  07d6 0f1a          	clr	(OFST+0,sp)
2728  07d8               L5611:
2729                     ; 721                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2731  07d8 ae0040        	ldw	x,#64
2732  07db cd0000        	call	_UART1_GetFlagStatus
2734  07de 4d            	tnz	a
2735  07df 27f7          	jreq	L5611
2736                     ; 723                     UART1_SendData8(aunIMEI[i]);
2738  07e1 7b1a          	ld	a,(OFST+0,sp)
2739  07e3 5f            	clrw	x
2740  07e4 97            	ld	xl,a
2741  07e5 e610          	ld	a,(_aunIMEI,x)
2742  07e7 cd0000        	call	_UART1_SendData8
2744                     ; 719                 for (i = 0; i < 15; i++)
2746  07ea 0c1a          	inc	(OFST+0,sp)
2750  07ec 7b1a          	ld	a,(OFST+0,sp)
2751  07ee a10f          	cp	a,#15
2752  07f0 25e6          	jrult	L5611
2754  07f2               L3711:
2755                     ; 725                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2757  07f2 ae0040        	ldw	x,#64
2758  07f5 cd0000        	call	_UART1_GetFlagStatus
2760  07f8 4d            	tnz	a
2761  07f9 27f7          	jreq	L3711
2762                     ; 728                 UART1_SendData8('\n');
2764  07fb a60a          	ld	a,#10
2765  07fd cd0000        	call	_UART1_SendData8
2767                     ; 729                 for (i = 0; i < 20; i++)
2769  0800 0f1a          	clr	(OFST+0,sp)
2771  0802               L7021:
2772                     ; 731                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2774  0802 ae0040        	ldw	x,#64
2775  0805 cd0000        	call	_UART1_GetFlagStatus
2777  0808 4d            	tnz	a
2778  0809 27f7          	jreq	L7021
2779                     ; 733                     UART1_SendData8('*');
2781  080b a62a          	ld	a,#42
2782  080d cd0000        	call	_UART1_SendData8
2784                     ; 729                 for (i = 0; i < 20; i++)
2786  0810 0c1a          	inc	(OFST+0,sp)
2790  0812 7b1a          	ld	a,(OFST+0,sp)
2791  0814 a114          	cp	a,#20
2792  0816 25ea          	jrult	L7021
2794  0818               L5121:
2795                     ; 735                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2797  0818 ae0040        	ldw	x,#64
2798  081b cd0000        	call	_UART1_GetFlagStatus
2800  081e 4d            	tnz	a
2801  081f 27f7          	jreq	L5121
2802                     ; 737                 UART1_SendData8('\r');
2804  0821 a60d          	ld	a,#13
2805  0823 cd0000        	call	_UART1_SendData8
2807                     ; 738                 delay_ms(100);
2809  0826 ae0064        	ldw	x,#100
2810  0829 cd0000        	call	_delay_ms
2812                     ; 740                 punGet_Client_ID();
2814  082c cd0000        	call	_punGet_Client_ID
2816                     ; 741                 punGet_Command_Topic();
2818  082f cd0000        	call	_punGet_Command_Topic
2820                     ; 742                 punGet_Event_Topic();
2822  0832 cd0000        	call	_punGet_Event_Topic
2824                     ; 744                 ModuleResponding = TRUE;
2826  0835 a601          	ld	a,#1
2827  0837 6b1a          	ld	(OFST+0,sp),a
2829                     ; 745                 IMEIRecievedOKFlag = 1;
2831  0839 35010000      	mov	_IMEIRecievedOKFlag,#1
2833  083d 2025          	jra	L3221
2834  083f               L3401:
2835                     ; 749                 delay_ms(200);
2837  083f ae00c8        	ldw	x,#200
2838  0842 cd0000        	call	_delay_ms
2840                     ; 750                 ModuleResponding = FALSE;
2842  0845 0f1a          	clr	(OFST+0,sp)
2844                     ; 751                 NotRespondingCounter++;
2846  0847 0c19          	inc	(OFST-1,sp)
2848  0849 2019          	jra	L3221
2849  084b               L1401:
2850                     ; 757             delay_ms(200);
2852  084b ae00c8        	ldw	x,#200
2853  084e cd0000        	call	_delay_ms
2855                     ; 758             ms_send_cmd("No Response from Module", strlen((const char *)"No Response from Module"));
2857  0851 4b17          	push	#23
2858  0853 ae0028        	ldw	x,#L5221
2859  0856 cd0000        	call	_ms_send_cmd
2861  0859 84            	pop	a
2862                     ; 759             delay_ms(200);
2864  085a ae00c8        	ldw	x,#200
2865  085d cd0000        	call	_delay_ms
2867                     ; 760             ModuleResponding = FALSE;
2869  0860 0f1a          	clr	(OFST+0,sp)
2871                     ; 761             NotRespondingCounter++;
2873  0862 0c19          	inc	(OFST-1,sp)
2875  0864               L3221:
2876                     ; 764         delay_ms(200);
2878  0864 ae00c8        	ldw	x,#200
2879  0867 cd0000        	call	_delay_ms
2881                     ; 765     } while (!ModuleResponding && NotRespondingCounter < 10);
2883  086a 0d1a          	tnz	(OFST+0,sp)
2884  086c 2609          	jrne	L7221
2886  086e 7b19          	ld	a,(OFST-1,sp)
2887  0870 a10a          	cp	a,#10
2888  0872 2403          	jruge	L47
2889  0874 cc0703        	jp	L1301
2890  0877               L47:
2891  0877               L7221:
2892                     ; 767     if (NotRespondingCounter < 10)
2894  0877 7b19          	ld	a,(OFST-1,sp)
2895  0879 a10a          	cp	a,#10
2896  087b 2406          	jruge	L1321
2897                     ; 768         IMEIRecievedOKFlag = 1;
2899  087d 35010000      	mov	_IMEIRecievedOKFlag,#1
2901  0881 2002          	jra	L3321
2902  0883               L1321:
2903                     ; 770         IMEIRecievedOKFlag = 0;
2905  0883 3f00          	clr	_IMEIRecievedOKFlag
2906  0885               L3321:
2907                     ; 771     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2909  0885 4b01          	push	#1
2910  0887 ae0255        	ldw	x,#597
2911  088a cd0000        	call	_UART1_ITConfig
2913  088d 84            	pop	a
2914                     ; 772     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2916  088e 4b01          	push	#1
2917  0890 ae0244        	ldw	x,#580
2918  0893 cd0000        	call	_UART1_ITConfig
2920  0896 84            	pop	a
2921                     ; 773 }
2924  0897 5b1a          	addw	sp,#26
2925  0899 81            	ret
2960                     	xdef	_bValidIMEIRecieved
2961                     	xref.b	_IMEIRecievedOKFlag
2962                     	xref	_aunPushed_Data
2963                     	xdef	_vPrintStickerInfo
2964                     	xdef	_vTCP_Reconnect
2965                     	xdef	_vSend_MQTT_Ping
2966                     	xdef	_vHandle_MQTT
2967                     	xdef	_enGet_TCP_Status
2968                     	xdef	_vClearBuffer
2969                     	xdef	_bSendDataOverTCP
2970                     	xdef	_vInit_MQTT
2971                     	xdef	_getIMEI
2972                     	xdef	_checkNum
2973                     	xdef	_SIMComrestart
2974                     	xref	_GSM_OK
2975                     	xdef	_SIMCom_setup
2976                     	xref	_response_buffer
2977                     	xref	_unMQTT_PingRequest
2978                     	xref	_ulMQTT_Subscribe
2979                     	xref	_ulMQTT_Connect
2980                     	xref	_ms_send_cmd_TCP
2981                     	xref	_ms_send_cmd
2982                     	xref	_aunMQTT_Subscribe_Topic
2983                     	xref	_aunMQTT_ClientID
2984                     	xref	_vMevris_Send_Version
2985                     	xref	_vMevris_Send_IMEI
2986                     	xref	_punGet_Client_ID
2987                     	xref	_punGet_Command_Topic
2988                     	xref	_punGet_Event_Topic
2989                     	xref	_sprintf
2990                     	switch	.ubsct
2991  0000               _PASS_KEY:
2992  0000 000000000000  	ds.b	16
2993                     	xdef	_PASS_KEY
2994  0010               _aunIMEI:
2995  0010 000000000000  	ds.b	20
2996                     	xdef	_aunIMEI
2997                     	xref	_strlen
2998                     	xref	_strstr
2999                     	xref	_strcat
3000                     	xref.b	_checkit
3001                     	xref	_delay_ms
3002                     	xref	_UART1_GetFlagStatus
3003                     	xref	_UART1_SendData8
3004                     	xref	_UART1_ReceiveData8
3005                     	xref	_UART1_ITConfig
3006                     	xref	_GPIO_WriteLow
3007                     	xref	_GPIO_WriteHigh
3008                     	switch	.const
3009  0028               L5221:
3010  0028 4e6f20526573  	dc.b	"No Response from M"
3011  003a 6f64756c6500  	dc.b	"odule",0
3012  0040               L7301:
3013  0040 415400        	dc.b	"AT",0
3014  0043               L176:
3015  0043 504450204445  	dc.b	"PDP DEACT",0
3016  004d               L366:
3017  004d 54435020434c  	dc.b	"TCP CLOSED",0
3018  0058               L556:
3019  0058 54435020434c  	dc.b	"TCP CLOSING",0
3020  0064               L746:
3021  0064 434f4e4e4543  	dc.b	"CONNECT OK",0
3022  006f               L146:
3023  006f 54435020434f  	dc.b	"TCP CONNECTING",0
3024  007e               L336:
3025  007e 495020535441  	dc.b	"IP STATUS",0
3026  0088               L526:
3027  0088 495020475052  	dc.b	"IP GPRSACT",0
3028  0093               L716:
3029  0093 495020434f4e  	dc.b	"IP CONFIG",0
3030  009d               L116:
3031  009d 495020535441  	dc.b	"IP START",0
3032  00a6               L306:
3033  00a6 495020494e49  	dc.b	"IP INITIAL",0
3034  00b1               L775:
3035  00b1 53544154453a  	dc.b	"STATE:",0
3036  00b8               L375:
3037  00b8 41542b434950  	dc.b	"AT+CIPSTATUS",0
3038  00c5               L315:
3039  00c5 53454e44204f  	dc.b	"SEND OK",0
3040  00cd               L705:
3041  00cd 53454e4400    	dc.b	"SEND",0
3042  00d2               L574:
3043  00d2 256400        	dc.b	"%d",0
3044  00d5               L374:
3045  00d5 41542b434950  	dc.b	"AT+CIPSEND=",0
3046  00e1               L502:
3047  00e1 41542b47534e  	dc.b	"AT+GSN",0
3048  00e8               L331:
3049  00e8 41542b434e55  	dc.b	"AT+CNUM",0
3050  00f0               L701:
3051  00f0 41542b43504f  	dc.b	"AT+CPOWD=0",0
3052  00fb               L57:
3053  00fb 41542b434950  	dc.b	"AT+CIPSTART=",34
3054  0108 54435022      	dc.b	"TCP",34
3055  010c 2c22          	dc.b	",",34
3056  010e 6d7174742e6d  	dc.b	"mqtt.mevris.io",34
3057  011d 2c22          	dc.b	",",34
3058  011f 333838312200  	dc.b	"3881",34,0
3059  0125               L37:
3060  0125 41542b434946  	dc.b	"AT+CIFSR",0
3061  012e               L17:
3062  012e 41542b434949  	dc.b	"AT+CIICR",0
3063  0137               L76:
3064  0137 41542b435354  	dc.b	"AT+CSTT=",34
3065  0140 7a6f6e677761  	dc.b	"zongwap",34,0
3066  0149               L56:
3067  0149 41542b434950  	dc.b	"AT+CIPSCONT",0
3068  0155               L36:
3069  0155 41542b434950  	dc.b	"AT+CIPHEAD=1",0
3070  0162               L16:
3071  0162 41542b434950  	dc.b	"AT+CIPSRIP=1",0
3072  016f               L75:
3073  016f 41542b434950  	dc.b	"AT+CIPSPRT=1",0
3074  017c               L55:
3075  017c 41542b434950  	dc.b	"AT+CIPQSEND=0",0
3076  018a               L35:
3077  018a 41542b434950  	dc.b	"AT+CIPMODE=0",0
3078  0197               L15:
3079  0197 41542b434950  	dc.b	"AT+CIPMUX=0",0
3080  01a3               L74:
3081  01a3 41542b434950  	dc.b	"AT+CIPSHUT",0
3082  01ae               L54:
3083  01ae 41542b534150  	dc.b	"AT+SAPBR=1,1",0
3084  01bb               L34:
3085  01bb 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
3086  01c9 41504e22      	dc.b	"APN",34
3087  01cd 2c22          	dc.b	",",34
3088  01cf 7a6f6e677761  	dc.b	"zongwap",34,0
3089  01d8               L14:
3090  01d8 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
3091  01e6 434f4e545950  	dc.b	"CONTYPE",34
3092  01ee 2c22          	dc.b	",",34
3093  01f0 475052532200  	dc.b	"GPRS",34,0
3094  01f6               L73:
3095  01f6 41542b434741  	dc.b	"AT+CGATT=1",0
3096  0201               L53:
3097  0201 41542b434d45  	dc.b	"AT+CMEE=2",0
3098  020b               L33:
3099  020b 41542b43474e  	dc.b	"AT+CGNSSEQ=RMC",0
3100  021a               L13:
3101  021a 41542b43474e  	dc.b	"AT+CGNSPWR=1",0
3102  0227               L72:
3103  0227 41542b434647  	dc.b	"AT+CFGRI=0",0
3104  0232               L52:
3105  0232 41542b435343  	dc.b	"AT+CSCLK=0",0
3106  023d               L32:
3107  023d 41542b434d47  	dc.b	"AT+CMGD=1,4",0
3108  0249               L12:
3109  0249 4154453000    	dc.b	"ATE0",0
3110                     	xref.b	c_lreg
3111                     	xref.b	c_x
3131                     	xref	c_xymvx
3132                     	end
