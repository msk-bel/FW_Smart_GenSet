   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
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
  73  0011 ae0231        	ldw	x,#L12
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
  90  0026 ae0225        	ldw	x,#L32
  91  0029 cd0000        	call	_ms_send_cmd
  93  002c 84            	pop	a
  94                     ; 65     delay_ms(1000);
  96  002d ae03e8        	ldw	x,#1000
  97  0030 cd0000        	call	_delay_ms
  99                     ; 67     ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
 101  0033 4b0a          	push	#10
 102  0035 ae021a        	ldw	x,#L52
 103  0038 cd0000        	call	_ms_send_cmd
 105  003b 84            	pop	a
 106                     ; 68     delay_ms(1000);
 108  003c ae03e8        	ldw	x,#1000
 109  003f cd0000        	call	_delay_ms
 111                     ; 70     vPrintStickerInfo(); //Added by Saqib
 113  0042 cd0658        	call	_vPrintStickerInfo
 115                     ; 71     delay_ms(1000);
 117  0045 ae03e8        	ldw	x,#1000
 118  0048 cd0000        	call	_delay_ms
 120                     ; 73     ms_send_cmd("AT+CFGRI=0", strlen((const char *)"AT+CFGRI=0")); /* Disable power saving mode */
 122  004b 4b0a          	push	#10
 123  004d ae020f        	ldw	x,#L72
 124  0050 cd0000        	call	_ms_send_cmd
 126  0053 84            	pop	a
 127                     ; 74     delay_ms(1000);
 129  0054 ae03e8        	ldw	x,#1000
 130  0057 cd0000        	call	_delay_ms
 132                     ; 76     ms_send_cmd(GPS_ON, strlen((const char *)GPS_ON));
 134  005a 4b0c          	push	#12
 135  005c ae0202        	ldw	x,#L13
 136  005f cd0000        	call	_ms_send_cmd
 138  0062 84            	pop	a
 139                     ; 77     delay_ms(1000);
 141  0063 ae03e8        	ldw	x,#1000
 142  0066 cd0000        	call	_delay_ms
 144                     ; 79     ms_send_cmd(rmc, strlen((const char *)rmc));
 146  0069 4b0e          	push	#14
 147  006b ae01f3        	ldw	x,#L33
 148  006e cd0000        	call	_ms_send_cmd
 150  0071 84            	pop	a
 151                     ; 80     delay_ms(1000);
 153  0072 ae03e8        	ldw	x,#1000
 154  0075 cd0000        	call	_delay_ms
 156                     ; 82     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
 158  0078 4b04          	push	#4
 159  007a ae0231        	ldw	x,#L12
 160  007d cd0000        	call	_ms_send_cmd
 162  0080 84            	pop	a
 163                     ; 83     delay_ms(1000);
 165  0081 ae03e8        	ldw	x,#1000
 166  0084 cd0000        	call	_delay_ms
 168                     ; 85     ms_send_cmd("AT+CMEE=2", strlen((const char *)"AT+CMEE=2")); /* No echo */
 170  0087 4b09          	push	#9
 171  0089 ae01e9        	ldw	x,#L53
 172  008c cd0000        	call	_ms_send_cmd
 174  008f 84            	pop	a
 175                     ; 86     delay_ms(1000);
 177  0090 ae03e8        	ldw	x,#1000
 178  0093 cd0000        	call	_delay_ms
 180                     ; 88     ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
 182  0096 4b0a          	push	#10
 183  0098 ae01de        	ldw	x,#L73
 184  009b cd0000        	call	_ms_send_cmd
 186  009e 84            	pop	a
 187                     ; 89     delay_ms(1000);
 189  009f ae03e8        	ldw	x,#1000
 190  00a2 cd0000        	call	_delay_ms
 192                     ; 91     ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
 194  00a5 4b1d          	push	#29
 195  00a7 ae01c0        	ldw	x,#L14
 196  00aa cd0000        	call	_ms_send_cmd
 198  00ad 84            	pop	a
 199                     ; 92     delay_ms(1000);
 201  00ae ae03e8        	ldw	x,#1000
 202  00b1 cd0000        	call	_delay_ms
 204                     ; 94     ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
 206  00b4 4b1c          	push	#28
 207  00b6 ae01a3        	ldw	x,#L34
 208  00b9 cd0000        	call	_ms_send_cmd
 210  00bc 84            	pop	a
 211                     ; 95     delay_ms(1000);
 213  00bd ae03e8        	ldw	x,#1000
 214  00c0 cd0000        	call	_delay_ms
 216                     ; 97     ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
 218  00c3 4b0c          	push	#12
 219  00c5 ae0196        	ldw	x,#L54
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
 236  00da ae018b        	ldw	x,#L74
 237  00dd cd0000        	call	_ms_send_cmd
 239  00e0 84            	pop	a
 240                     ; 106     delay_ms(1000);
 242  00e1 ae03e8        	ldw	x,#1000
 243  00e4 cd0000        	call	_delay_ms
 245                     ; 108     ms_send_cmd(TCP_SINGLE_CONN_MODE, strlen((const char *)TCP_SINGLE_CONN_MODE)); /* OPEN BEARER */
 247  00e7 4b0b          	push	#11
 248  00e9 ae017f        	ldw	x,#L15
 249  00ec cd0000        	call	_ms_send_cmd
 251  00ef 84            	pop	a
 252                     ; 109     delay_ms(1000);
 254  00f0 ae03e8        	ldw	x,#1000
 255  00f3 cd0000        	call	_delay_ms
 257                     ; 111     ms_send_cmd(TCP_NON_TRANSPARENT_MODE, strlen((const char *)TCP_NON_TRANSPARENT_MODE)); /* OPEN BEARER */
 259  00f6 4b0c          	push	#12
 260  00f8 ae0172        	ldw	x,#L35
 261  00fb cd0000        	call	_ms_send_cmd
 263  00fe 84            	pop	a
 264                     ; 112     delay_ms(1000);
 266  00ff ae03e8        	ldw	x,#1000
 267  0102 cd0000        	call	_delay_ms
 269                     ; 114     ms_send_cmd(TCP_MODE_RESPONSE_NORMAL, strlen((const char *)TCP_MODE_RESPONSE_NORMAL)); /* OPEN BEARER */
 271  0105 4b0d          	push	#13
 272  0107 ae0164        	ldw	x,#L55
 273  010a cd0000        	call	_ms_send_cmd
 275  010d 84            	pop	a
 276                     ; 115     delay_ms(1000);
 278  010e ae03e8        	ldw	x,#1000
 279  0111 cd0000        	call	_delay_ms
 281                     ; 117     ms_send_cmd(TCP_MODE_SEND_PROMPT_ECHO, strlen((const char *)TCP_MODE_SEND_PROMPT_ECHO)); /* OPEN BEARER */
 283  0114 4b0c          	push	#12
 284  0116 ae0157        	ldw	x,#L75
 285  0119 cd0000        	call	_ms_send_cmd
 287  011c 84            	pop	a
 288                     ; 118     delay_ms(1000);
 290  011d ae03e8        	ldw	x,#1000
 291  0120 cd0000        	call	_delay_ms
 293                     ; 120     ms_send_cmd(TCP_MODE_REMOTE_IP_PORT_ON, strlen((const char *)TCP_MODE_REMOTE_IP_PORT_ON)); /* OPEN BEARER */
 295  0123 4b0c          	push	#12
 296  0125 ae014a        	ldw	x,#L16
 297  0128 cd0000        	call	_ms_send_cmd
 299  012b 84            	pop	a
 300                     ; 121     delay_ms(1000);
 302  012c ae03e8        	ldw	x,#1000
 303  012f cd0000        	call	_delay_ms
 305                     ; 123     ms_send_cmd(TCP_MODE_HEADER_ON_RECV_ON, strlen((const char *)TCP_MODE_HEADER_ON_RECV_ON)); /* OPEN BEARER */
 307  0132 4b0c          	push	#12
 308  0134 ae013d        	ldw	x,#L36
 309  0137 cd0000        	call	_ms_send_cmd
 311  013a 84            	pop	a
 312                     ; 124     delay_ms(1000);
 314  013b ae03e8        	ldw	x,#1000
 315  013e cd0000        	call	_delay_ms
 317                     ; 126     ms_send_cmd(TCP_SAVE_CONTEXT, strlen((const char *)TCP_SAVE_CONTEXT)); /* OPEN BEARER */
 319  0141 4b0b          	push	#11
 320  0143 ae0131        	ldw	x,#L56
 321  0146 cd0000        	call	_ms_send_cmd
 323  0149 84            	pop	a
 324                     ; 127     delay_ms(1000);
 326  014a ae03e8        	ldw	x,#1000
 327  014d cd0000        	call	_delay_ms
 329                     ; 129     ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
 331  0150 4b11          	push	#17
 332  0152 ae011f        	ldw	x,#L76
 333  0155 cd0000        	call	_ms_send_cmd
 335  0158 84            	pop	a
 336                     ; 130     delay_ms(1000);
 338  0159 ae03e8        	ldw	x,#1000
 339  015c cd0000        	call	_delay_ms
 341                     ; 132     ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
 343  015f 4b08          	push	#8
 344  0161 ae0116        	ldw	x,#L17
 345  0164 cd0000        	call	_ms_send_cmd
 347  0167 84            	pop	a
 348                     ; 133     delay_ms(1000);
 350  0168 ae03e8        	ldw	x,#1000
 351  016b cd0000        	call	_delay_ms
 353                     ; 135     ms_send_cmd("AT+CIFSR", strlen((const char *)"AT+CIFSR")); /* OPEN BEARER */
 355  016e 4b08          	push	#8
 356  0170 ae010d        	ldw	x,#L37
 357  0173 cd0000        	call	_ms_send_cmd
 359  0176 84            	pop	a
 360                     ; 136     delay_ms(1000);
 362  0177 ae03e8        	ldw	x,#1000
 363  017a cd0000        	call	_delay_ms
 365                     ; 138     ms_send_cmd(startTCP_CMD, strlen((const char *)startTCP_CMD)); /* OPEN BEARER */
 367  017d 4b29          	push	#41
 368  017f ae00e3        	ldw	x,#L57
 369  0182 cd0000        	call	_ms_send_cmd
 371  0185 84            	pop	a
 372                     ; 139     delay_ms(1000);
 374  0186 ae03e8        	ldw	x,#1000
 375  0189 cd0000        	call	_delay_ms
 377                     ; 141     enGet_TCP_Status();
 379  018c cd0494        	call	_enGet_TCP_Status
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
 429  019c ae00d8        	ldw	x,#L701
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
 529  01cf ae00d0        	ldw	x,#L331
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
 675  021d ae00c9        	ldw	x,#L502
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
 983                     ; 387 void vHandle_MQTT(void)
 983                     ; 388 {
 984                     	switch	.text
 985  02ab               _vHandle_MQTT:
 987  02ab 88            	push	a
 988       00000001      OFST:	set	1
 991                     ; 389     uint8_t unLength = 0;
 993                     ; 393     eTCP_Status = enGet_TCP_Status();
 995  02ac cd0494        	call	_enGet_TCP_Status
 997  02af 6b01          	ld	(OFST+0,sp),a
 999                     ; 395     if (eTCP_Status == eTCP_STAT_CONNECT_OK && IMEIRecievedOKFlag)
1001  02b1 7b01          	ld	a,(OFST+0,sp)
1002  02b3 a107          	cp	a,#7
1003  02b5 2703          	jreq	L42
1004  02b7 cc035e        	jp	L323
1005  02ba               L42:
1007  02ba 3d00          	tnz	_IMEIRecievedOKFlag
1008  02bc 2603          	jrne	L62
1009  02be cc035e        	jp	L323
1010  02c1               L62:
1011                     ; 397         if (unMQTTCounter == 0 /*&& !bCONNACK_Recieved*/)
1013  02c1 3d00          	tnz	L332_unMQTTCounter
1014  02c3 262e          	jrne	L523
1015                     ; 399             vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1017  02c5 4b64          	push	#100
1018  02c7 ae0000        	ldw	x,#_aunPushed_Data
1019  02ca cd047b        	call	_vClearBuffer
1021  02cd 84            	pop	a
1022                     ; 400             unLength = (uint8_t)ulMQTT_Connect(aunPushed_Data, punGet_Client_ID() /*, FALSE, FALSE, FALSE, FALSE, TRUE, eQOS_0, NULL, NULL, NULL, NULL*/);
1024  02ce cd0000        	call	_punGet_Client_ID
1026  02d1 89            	pushw	x
1027  02d2 ae0000        	ldw	x,#_aunPushed_Data
1028  02d5 cd0000        	call	_ulMQTT_Connect
1030  02d8 85            	popw	x
1031  02d9 b603          	ld	a,c_lreg+3
1032  02db 6b01          	ld	(OFST+0,sp),a
1034                     ; 401             if (bSendDataOverTCP(aunPushed_Data, unLength))
1036  02dd 7b01          	ld	a,(OFST+0,sp)
1037  02df 88            	push	a
1038  02e0 ae0000        	ldw	x,#_aunPushed_Data
1039  02e3 cd041f        	call	_bSendDataOverTCP
1041  02e6 5b01          	addw	sp,#1
1042  02e8 4d            	tnz	a
1043  02e9 2702          	jreq	L723
1044                     ; 402                 unMQTTCounter++;
1046  02eb 3c00          	inc	L332_unMQTTCounter
1047  02ed               L723:
1048                     ; 403             unMQQT_PingCounter = 0;
1050  02ed 3f01          	clr	L532_unMQQT_PingCounter
1052  02ef ac770377      	jpf	L553
1053  02f3               L523:
1054                     ; 405         else if (unMQTTCounter == 1)
1056  02f3 b600          	ld	a,L332_unMQTTCounter
1057  02f5 a101          	cp	a,#1
1058  02f7 262c          	jrne	L333
1059                     ; 407             vClearBuffer(aunPushed_Data, MEVRIS_RECV_DATA_MAX_SIZE);
1061  02f9 4b46          	push	#70
1062  02fb ae0000        	ldw	x,#_aunPushed_Data
1063  02fe cd047b        	call	_vClearBuffer
1065  0301 84            	pop	a
1066                     ; 408             unLength = (uint8_t)ulMQTT_Subscribe(aunPushed_Data, punGet_Command_Topic() /*, eQOS_0, 1*/);
1068  0302 cd0000        	call	_punGet_Command_Topic
1070  0305 89            	pushw	x
1071  0306 ae0000        	ldw	x,#_aunPushed_Data
1072  0309 cd0000        	call	_ulMQTT_Subscribe
1074  030c 85            	popw	x
1075  030d b603          	ld	a,c_lreg+3
1076  030f 6b01          	ld	(OFST+0,sp),a
1078                     ; 409             if (bSendDataOverTCP(aunPushed_Data, unLength))
1080  0311 7b01          	ld	a,(OFST+0,sp)
1081  0313 88            	push	a
1082  0314 ae0000        	ldw	x,#_aunPushed_Data
1083  0317 cd041f        	call	_bSendDataOverTCP
1085  031a 5b01          	addw	sp,#1
1086  031c 4d            	tnz	a
1087  031d 2702          	jreq	L533
1088                     ; 410                 unMQTTCounter++;
1090  031f 3c00          	inc	L332_unMQTTCounter
1091  0321               L533:
1092                     ; 411             unMQQT_PingCounter = 0;
1094  0321 3f01          	clr	L532_unMQQT_PingCounter
1096  0323 2052          	jra	L553
1097  0325               L333:
1098                     ; 413         else if (unMQTTCounter == 2)
1100  0325 b600          	ld	a,L332_unMQTTCounter
1101  0327 a102          	cp	a,#2
1102  0329 2609          	jrne	L143
1103                     ; 415             vMevris_Send_IMEI();
1105  032b cd0000        	call	_vMevris_Send_IMEI
1107                     ; 416             unMQTTCounter++;
1109  032e 3c00          	inc	L332_unMQTTCounter
1110                     ; 417             unMQQT_PingCounter = 0;
1112  0330 3f01          	clr	L532_unMQQT_PingCounter
1114  0332 2043          	jra	L553
1115  0334               L143:
1116                     ; 419         else if (unMQTTCounter == 3)
1118  0334 b600          	ld	a,L332_unMQTTCounter
1119  0336 a103          	cp	a,#3
1120  0338 2609          	jrne	L543
1121                     ; 421             vMevris_Send_Version();
1123  033a cd0000        	call	_vMevris_Send_Version
1125                     ; 422             unMQTTCounter++;
1127  033d 3c00          	inc	L332_unMQTTCounter
1128                     ; 423             unMQQT_PingCounter = 0;
1130  033f 3f01          	clr	L532_unMQQT_PingCounter
1132  0341 2034          	jra	L553
1133  0343               L543:
1134                     ; 425         else if (unMQTTCounter == 4)
1136  0343 b600          	ld	a,L332_unMQTTCounter
1137  0345 a104          	cp	a,#4
1138  0347 262e          	jrne	L553
1139                     ; 427             unMQQT_PingCounter++;
1141  0349 3c01          	inc	L532_unMQQT_PingCounter
1142                     ; 428             if (unMQQT_PingCounter >> 5)
1144  034b b601          	ld	a,L532_unMQQT_PingCounter
1145  034d 4e            	swap	a
1146  034e 44            	srl	a
1147  034f a407          	and	a,#7
1148  0351 5f            	clrw	x
1149  0352 97            	ld	xl,a
1150  0353 a30000        	cpw	x,#0
1151  0356 271f          	jreq	L553
1152                     ; 430                 vSend_MQTT_Ping();
1154  0358 ad26          	call	_vSend_MQTT_Ping
1156                     ; 431                 unMQQT_PingCounter = 0;
1158  035a 3f01          	clr	L532_unMQQT_PingCounter
1159  035c 2019          	jra	L553
1160  035e               L323:
1161                     ; 435     else if (eTCP_Status == eTCP_STAT_CONNECTING)
1163  035e 7b01          	ld	a,(OFST+0,sp)
1164  0360 a106          	cp	a,#6
1165  0362 260c          	jrne	L753
1166                     ; 437         delay_ms(200);
1168  0364 ae00c8        	ldw	x,#200
1169  0367 cd0000        	call	_delay_ms
1171                     ; 438         unMQTTCounter = 0;
1173  036a 3f00          	clr	L332_unMQTTCounter
1174                     ; 439         unMQQT_PingCounter = 0;
1176  036c 3f01          	clr	L532_unMQQT_PingCounter
1178  036e 2007          	jra	L553
1179  0370               L753:
1180                     ; 443         vTCP_Reconnect();
1182  0370 cd05b0        	call	_vTCP_Reconnect
1184                     ; 444         unMQQT_PingCounter = 0;
1186  0373 3f01          	clr	L532_unMQQT_PingCounter
1187                     ; 445         unMQTTCounter = 0;
1189  0375 3f00          	clr	L332_unMQTTCounter
1190  0377               L553:
1191                     ; 447     if (IMEIRecievedOKFlag == 0)
1193  0377 3d00          	tnz	_IMEIRecievedOKFlag
1194  0379 2603          	jrne	L363
1195                     ; 449         vPrintStickerInfo();
1197  037b cd0658        	call	_vPrintStickerInfo
1199  037e               L363:
1200                     ; 451 }
1203  037e 84            	pop	a
1204  037f 81            	ret
1242                     ; 453 void vSend_MQTT_Ping(void)
1242                     ; 454 {
1243                     	switch	.text
1244  0380               _vSend_MQTT_Ping:
1246  0380 88            	push	a
1247       00000001      OFST:	set	1
1250                     ; 455     uint8_t unLength = 0;
1252                     ; 456     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1254  0381 4b64          	push	#100
1255  0383 ae0000        	ldw	x,#_aunPushed_Data
1256  0386 cd047b        	call	_vClearBuffer
1258  0389 84            	pop	a
1259                     ; 459         unLength = (uint8_t)unMQTT_PingRequest(aunPushed_Data);
1261  038a ae0000        	ldw	x,#_aunPushed_Data
1262  038d cd0000        	call	_unMQTT_PingRequest
1264  0390 6b01          	ld	(OFST+0,sp),a
1266                     ; 460         bSendDataOverTCP(aunPushed_Data, unLength);
1268  0392 7b01          	ld	a,(OFST+0,sp)
1269  0394 88            	push	a
1270  0395 ae0000        	ldw	x,#_aunPushed_Data
1271  0398 cd041f        	call	_bSendDataOverTCP
1273  039b 84            	pop	a
1274                     ; 462 }
1277  039c 84            	pop	a
1278  039d 81            	ret
1320                     ; 464 void vInit_MQTT(void)
1320                     ; 465 {
1321                     	switch	.text
1322  039e               _vInit_MQTT:
1324  039e 88            	push	a
1325       00000001      OFST:	set	1
1328                     ; 466     uint8_t unLength = 0;
1330                     ; 468     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
1332  039f 4b64          	push	#100
1333  03a1 ae0000        	ldw	x,#_aunPushed_Data
1334  03a4 cd047b        	call	_vClearBuffer
1336  03a7 84            	pop	a
1337                     ; 469     unLength = (uint8_t)ulMQTT_Connect(aunPushed_Data, punGet_Client_ID() /*, FALSE, FALSE, FALSE, FALSE, TRUE, eQOS_0, NULL, NULL, NULL, NULL*/);
1339  03a8 cd0000        	call	_punGet_Client_ID
1341  03ab 89            	pushw	x
1342  03ac ae0000        	ldw	x,#_aunPushed_Data
1343  03af cd0000        	call	_ulMQTT_Connect
1345  03b2 85            	popw	x
1346  03b3 b603          	ld	a,c_lreg+3
1347  03b5 6b01          	ld	(OFST+0,sp),a
1349                     ; 470     bSendDataOverTCP(aunPushed_Data, unLength);
1351  03b7 7b01          	ld	a,(OFST+0,sp)
1352  03b9 88            	push	a
1353  03ba ae0000        	ldw	x,#_aunPushed_Data
1354  03bd ad60          	call	_bSendDataOverTCP
1356  03bf 84            	pop	a
1357                     ; 471     delay_ms(1000);
1359  03c0 ae03e8        	ldw	x,#1000
1360  03c3 cd0000        	call	_delay_ms
1362                     ; 472     delay_ms(1000);
1364  03c6 ae03e8        	ldw	x,#1000
1365  03c9 cd0000        	call	_delay_ms
1367                     ; 473     delay_ms(1000);
1369  03cc ae03e8        	ldw	x,#1000
1370  03cf cd0000        	call	_delay_ms
1372                     ; 474     delay_ms(1000);
1374  03d2 ae03e8        	ldw	x,#1000
1375  03d5 cd0000        	call	_delay_ms
1377                     ; 475     delay_ms(1000);
1379  03d8 ae03e8        	ldw	x,#1000
1380  03db cd0000        	call	_delay_ms
1382                     ; 476     vClearBuffer(aunPushed_Data, MEVRIS_RECV_DATA_MAX_SIZE);
1384  03de 4b46          	push	#70
1385  03e0 ae0000        	ldw	x,#_aunPushed_Data
1386  03e3 cd047b        	call	_vClearBuffer
1388  03e6 84            	pop	a
1389                     ; 477     unLength = (uint8_t)ulMQTT_Subscribe(aunPushed_Data, punGet_Command_Topic() /*, eQOS_0, 1*/);
1391  03e7 cd0000        	call	_punGet_Command_Topic
1393  03ea 89            	pushw	x
1394  03eb ae0000        	ldw	x,#_aunPushed_Data
1395  03ee cd0000        	call	_ulMQTT_Subscribe
1397  03f1 85            	popw	x
1398  03f2 b603          	ld	a,c_lreg+3
1399  03f4 6b01          	ld	(OFST+0,sp),a
1401                     ; 478     bSendDataOverTCP(aunPushed_Data, unLength);
1403  03f6 7b01          	ld	a,(OFST+0,sp)
1404  03f8 88            	push	a
1405  03f9 ae0000        	ldw	x,#_aunPushed_Data
1406  03fc ad21          	call	_bSendDataOverTCP
1408  03fe 84            	pop	a
1409                     ; 479     delay_ms(1000);
1411  03ff ae03e8        	ldw	x,#1000
1412  0402 cd0000        	call	_delay_ms
1414                     ; 480     delay_ms(1000);
1416  0405 ae03e8        	ldw	x,#1000
1417  0408 cd0000        	call	_delay_ms
1419                     ; 481     delay_ms(1000);
1421  040b ae03e8        	ldw	x,#1000
1422  040e cd0000        	call	_delay_ms
1424                     ; 482     delay_ms(1000);
1426  0411 ae03e8        	ldw	x,#1000
1427  0414 cd0000        	call	_delay_ms
1429                     ; 483     delay_ms(1000);
1431  0417 ae03e8        	ldw	x,#1000
1432  041a cd0000        	call	_delay_ms
1434                     ; 484 }
1437  041d 84            	pop	a
1438  041e 81            	ret
1518                     ; 486 bool bSendDataOverTCP(uint8_t *Data, uint8_t unLength)
1518                     ; 487 {
1519                     	switch	.text
1520  041f               _bSendDataOverTCP:
1522  041f 89            	pushw	x
1523  0420 88            	push	a
1524       00000001      OFST:	set	1
1527                     ; 488     uint8_t timeout = 0;
1529  0421 0f01          	clr	(OFST+0,sp)
1531                     ; 489     ms_send_cmd(TCP_SEND_VARIABLE_LENGTH, strlen((const char *)TCP_SEND_VARIABLE_LENGTH));
1533  0423 4b0a          	push	#10
1534  0425 ae00be        	ldw	x,#L754
1535  0428 cd0000        	call	_ms_send_cmd
1537  042b 84            	pop	a
1538                     ; 490     delay_ms(100);
1540  042c ae0064        	ldw	x,#100
1541  042f cd0000        	call	_delay_ms
1543                     ; 491     ms_send_cmd_TCP(Data, unLength);
1545  0432 7b06          	ld	a,(OFST+5,sp)
1546  0434 88            	push	a
1547  0435 1e03          	ldw	x,(OFST+2,sp)
1548  0437 cd0000        	call	_ms_send_cmd_TCP
1550  043a 84            	pop	a
1551                     ; 492     delay_ms(200);
1553  043b ae00c8        	ldw	x,#200
1554  043e cd0000        	call	_delay_ms
1557  0441 2006          	jra	L364
1558  0443               L164:
1559                     ; 495         delay_ms(100);
1561  0443 ae0064        	ldw	x,#100
1562  0446 cd0000        	call	_delay_ms
1564  0449               L364:
1565                     ; 494     while (!strstr(response_buffer, "SEND") && (++timeout != 100))
1567  0449 ae00b9        	ldw	x,#L174
1568  044c 89            	pushw	x
1569  044d ae0000        	ldw	x,#_response_buffer
1570  0450 cd0000        	call	_strstr
1572  0453 5b02          	addw	sp,#2
1573  0455 a30000        	cpw	x,#0
1574  0458 2608          	jrne	L764
1576  045a 0c01          	inc	(OFST+0,sp)
1578  045c 7b01          	ld	a,(OFST+0,sp)
1579  045e a164          	cp	a,#100
1580  0460 26e1          	jrne	L164
1581  0462               L764:
1582                     ; 496     if (strstr(response_buffer, "SEND OK"))
1584  0462 ae00b1        	ldw	x,#L574
1585  0465 89            	pushw	x
1586  0466 ae0000        	ldw	x,#_response_buffer
1587  0469 cd0000        	call	_strstr
1589  046c 5b02          	addw	sp,#2
1590  046e a30000        	cpw	x,#0
1591  0471 2704          	jreq	L374
1592                     ; 498         return TRUE;
1594  0473 a601          	ld	a,#1
1596  0475 2001          	jra	L63
1597  0477               L374:
1598                     ; 502         return FALSE;
1600  0477 4f            	clr	a
1602  0478               L63:
1604  0478 5b03          	addw	sp,#3
1605  047a 81            	ret
1658                     ; 506 void vClearBuffer(char *temp, uint8_t unLen)
1658                     ; 507 {
1659                     	switch	.text
1660  047b               _vClearBuffer:
1662  047b 89            	pushw	x
1663  047c 88            	push	a
1664       00000001      OFST:	set	1
1667                     ; 509     for (i = 0; i < unLen; i++)
1669  047d 0f01          	clr	(OFST+0,sp)
1672  047f 200a          	jra	L335
1673  0481               L725:
1674                     ; 511         *(temp + i) = '\0';
1676  0481 7b01          	ld	a,(OFST+0,sp)
1677  0483 5f            	clrw	x
1678  0484 97            	ld	xl,a
1679  0485 72fb02        	addw	x,(OFST+1,sp)
1680  0488 7f            	clr	(x)
1681                     ; 509     for (i = 0; i < unLen; i++)
1683  0489 0c01          	inc	(OFST+0,sp)
1685  048b               L335:
1688  048b 7b01          	ld	a,(OFST+0,sp)
1689  048d 1106          	cp	a,(OFST+5,sp)
1690  048f 25f0          	jrult	L725
1691                     ; 513 }
1694  0491 5b03          	addw	sp,#3
1695  0493 81            	ret
1736                     ; 515 enTCP_STATUS enGet_TCP_Status(void)
1736                     ; 516 {
1737                     	switch	.text
1738  0494               _enGet_TCP_Status:
1740  0494 88            	push	a
1741       00000001      OFST:	set	1
1744                     ; 519     ms_send_cmd(TCP_GET_STATUS, strlen((const char *)TCP_GET_STATUS));
1746  0495 4b0c          	push	#12
1747  0497 ae00a4        	ldw	x,#L555
1748  049a cd0000        	call	_ms_send_cmd
1750  049d 84            	pop	a
1751                     ; 520     delay_ms(1000);
1753  049e ae03e8        	ldw	x,#1000
1754  04a1 cd0000        	call	_delay_ms
1756                     ; 522     if (strstr(response_buffer, "STATE:"))
1758  04a4 ae009d        	ldw	x,#L165
1759  04a7 89            	pushw	x
1760  04a8 ae0000        	ldw	x,#_response_buffer
1761  04ab cd0000        	call	_strstr
1763  04ae 5b02          	addw	sp,#2
1764  04b0 a30000        	cpw	x,#0
1765  04b3 2603          	jrne	L44
1766  04b5 cc05a9        	jp	L755
1767  04b8               L44:
1768                     ; 524         if (strstr(response_buffer, "IP INITIAL"))
1770  04b8 ae0092        	ldw	x,#L565
1771  04bb 89            	pushw	x
1772  04bc ae0000        	ldw	x,#_response_buffer
1773  04bf cd0000        	call	_strstr
1775  04c2 5b02          	addw	sp,#2
1776  04c4 a30000        	cpw	x,#0
1777  04c7 2708          	jreq	L365
1778                     ; 526             eStatus = eTCP_STAT_IP_INITIAL;
1780  04c9 a601          	ld	a,#1
1781  04cb 6b01          	ld	(OFST+0,sp),a
1784  04cd acab05ab      	jpf	L756
1785  04d1               L365:
1786                     ; 528         else if (strstr(response_buffer, "IP START"))
1788  04d1 ae0089        	ldw	x,#L375
1789  04d4 89            	pushw	x
1790  04d5 ae0000        	ldw	x,#_response_buffer
1791  04d8 cd0000        	call	_strstr
1793  04db 5b02          	addw	sp,#2
1794  04dd a30000        	cpw	x,#0
1795  04e0 2708          	jreq	L175
1796                     ; 530             eStatus = eTCP_STAT_IP_START;
1798  04e2 a602          	ld	a,#2
1799  04e4 6b01          	ld	(OFST+0,sp),a
1802  04e6 acab05ab      	jpf	L756
1803  04ea               L175:
1804                     ; 532         else if (strstr(response_buffer, "IP CONFIG"))
1806  04ea ae007f        	ldw	x,#L106
1807  04ed 89            	pushw	x
1808  04ee ae0000        	ldw	x,#_response_buffer
1809  04f1 cd0000        	call	_strstr
1811  04f4 5b02          	addw	sp,#2
1812  04f6 a30000        	cpw	x,#0
1813  04f9 2708          	jreq	L775
1814                     ; 534             eStatus = eTCP_STAT_IP_CONFIG;
1816  04fb a603          	ld	a,#3
1817  04fd 6b01          	ld	(OFST+0,sp),a
1820  04ff acab05ab      	jpf	L756
1821  0503               L775:
1822                     ; 536         else if (strstr(response_buffer, "IP GPRSACT"))
1824  0503 ae0074        	ldw	x,#L706
1825  0506 89            	pushw	x
1826  0507 ae0000        	ldw	x,#_response_buffer
1827  050a cd0000        	call	_strstr
1829  050d 5b02          	addw	sp,#2
1830  050f a30000        	cpw	x,#0
1831  0512 2707          	jreq	L506
1832                     ; 538             eStatus = eTCP_STAT_IP_GPRSACT;
1834  0514 a604          	ld	a,#4
1835  0516 6b01          	ld	(OFST+0,sp),a
1838  0518 cc05ab        	jra	L756
1839  051b               L506:
1840                     ; 540         else if (strstr(response_buffer, "IP STATUS"))
1842  051b ae006a        	ldw	x,#L516
1843  051e 89            	pushw	x
1844  051f ae0000        	ldw	x,#_response_buffer
1845  0522 cd0000        	call	_strstr
1847  0525 5b02          	addw	sp,#2
1848  0527 a30000        	cpw	x,#0
1849  052a 2706          	jreq	L316
1850                     ; 542             eStatus = eTCP_STAT_IP_STATUS;
1852  052c a605          	ld	a,#5
1853  052e 6b01          	ld	(OFST+0,sp),a
1856  0530 2079          	jra	L756
1857  0532               L316:
1858                     ; 544         else if (strstr(response_buffer, "TCP CONNECTING"))
1860  0532 ae005b        	ldw	x,#L326
1861  0535 89            	pushw	x
1862  0536 ae0000        	ldw	x,#_response_buffer
1863  0539 cd0000        	call	_strstr
1865  053c 5b02          	addw	sp,#2
1866  053e a30000        	cpw	x,#0
1867  0541 2706          	jreq	L126
1868                     ; 546             eStatus = eTCP_STAT_CONNECTING;
1870  0543 a606          	ld	a,#6
1871  0545 6b01          	ld	(OFST+0,sp),a
1874  0547 2062          	jra	L756
1875  0549               L126:
1876                     ; 548         else if (strstr(response_buffer, "CONNECT OK"))
1878  0549 ae0050        	ldw	x,#L136
1879  054c 89            	pushw	x
1880  054d ae0000        	ldw	x,#_response_buffer
1881  0550 cd0000        	call	_strstr
1883  0553 5b02          	addw	sp,#2
1884  0555 a30000        	cpw	x,#0
1885  0558 2706          	jreq	L726
1886                     ; 550             eStatus = eTCP_STAT_CONNECT_OK;
1888  055a a607          	ld	a,#7
1889  055c 6b01          	ld	(OFST+0,sp),a
1892  055e 204b          	jra	L756
1893  0560               L726:
1894                     ; 552         else if (strstr(response_buffer, "TCP CLOSING"))
1896  0560 ae0044        	ldw	x,#L736
1897  0563 89            	pushw	x
1898  0564 ae0000        	ldw	x,#_response_buffer
1899  0567 cd0000        	call	_strstr
1901  056a 5b02          	addw	sp,#2
1902  056c a30000        	cpw	x,#0
1903  056f 2706          	jreq	L536
1904                     ; 554             eStatus = eTCP_STAT_CLOSING;
1906  0571 a608          	ld	a,#8
1907  0573 6b01          	ld	(OFST+0,sp),a
1910  0575 2034          	jra	L756
1911  0577               L536:
1912                     ; 556         else if (strstr(response_buffer, "TCP CLOSED"))
1914  0577 ae0039        	ldw	x,#L546
1915  057a 89            	pushw	x
1916  057b ae0000        	ldw	x,#_response_buffer
1917  057e cd0000        	call	_strstr
1919  0581 5b02          	addw	sp,#2
1920  0583 a30000        	cpw	x,#0
1921  0586 2706          	jreq	L346
1922                     ; 558             eStatus = eTCP_STAT_CLOSED;
1924  0588 a609          	ld	a,#9
1925  058a 6b01          	ld	(OFST+0,sp),a
1928  058c 201d          	jra	L756
1929  058e               L346:
1930                     ; 560         else if (strstr(response_buffer, "PDP DEACT"))
1932  058e ae002f        	ldw	x,#L356
1933  0591 89            	pushw	x
1934  0592 ae0000        	ldw	x,#_response_buffer
1935  0595 cd0000        	call	_strstr
1937  0598 5b02          	addw	sp,#2
1938  059a a30000        	cpw	x,#0
1939  059d 2706          	jreq	L156
1940                     ; 562             eStatus = eTCP_STAT_PDP_DEACT;
1942  059f a60a          	ld	a,#10
1943  05a1 6b01          	ld	(OFST+0,sp),a
1946  05a3 2006          	jra	L756
1947  05a5               L156:
1948                     ; 566             eStatus = eTCP_STAT_UNKNOWN;
1950  05a5 0f01          	clr	(OFST+0,sp)
1952  05a7 2002          	jra	L756
1953  05a9               L755:
1954                     ; 571         eStatus = eTCP_STAT_UNKNOWN;
1956  05a9 0f01          	clr	(OFST+0,sp)
1958  05ab               L756:
1959                     ; 573     return eStatus;
1961  05ab 7b01          	ld	a,(OFST+0,sp)
1964  05ad 5b01          	addw	sp,#1
1965  05af 81            	ret
1991                     ; 577 void vTCP_Reconnect(void)
1991                     ; 578 {
1992                     	switch	.text
1993  05b0               _vTCP_Reconnect:
1997                     ; 579     ms_send_cmd(TCP_SHUTDOWN, strlen((const char *)TCP_SHUTDOWN)); /* OPEN BEARER */
1999  05b0 4b0a          	push	#10
2000  05b2 ae018b        	ldw	x,#L74
2001  05b5 cd0000        	call	_ms_send_cmd
2003  05b8 84            	pop	a
2004                     ; 580     delay_ms(1000);
2006  05b9 ae03e8        	ldw	x,#1000
2007  05bc cd0000        	call	_delay_ms
2009                     ; 581     ms_send_cmd(TCP_SET_APN, strlen((const char *)TCP_SET_APN)); /* OPEN BEARER */
2011  05bf 4b11          	push	#17
2012  05c1 ae011f        	ldw	x,#L76
2013  05c4 cd0000        	call	_ms_send_cmd
2015  05c7 84            	pop	a
2016                     ; 582     delay_ms(1000);
2018  05c8 ae03e8        	ldw	x,#1000
2019  05cb cd0000        	call	_delay_ms
2021                     ; 583     ms_send_cmd(TCP_START_WIRELESS_CONN, strlen((const char *)TCP_START_WIRELESS_CONN)); /* OPEN BEARER */
2023  05ce 4b08          	push	#8
2024  05d0 ae0116        	ldw	x,#L17
2025  05d3 cd0000        	call	_ms_send_cmd
2027  05d6 84            	pop	a
2028                     ; 584     delay_ms(1000);
2030  05d7 ae03e8        	ldw	x,#1000
2031  05da cd0000        	call	_delay_ms
2033                     ; 585     ms_send_cmd("AT+CIFSR", strlen((const char *)"AT+CIFSR")); /* OPEN BEARER */
2035  05dd 4b08          	push	#8
2036  05df ae010d        	ldw	x,#L37
2037  05e2 cd0000        	call	_ms_send_cmd
2039  05e5 84            	pop	a
2040                     ; 586     delay_ms(1000);
2042  05e6 ae03e8        	ldw	x,#1000
2043  05e9 cd0000        	call	_delay_ms
2045                     ; 587     ms_send_cmd(startTCP_CMD, strlen((const char *)startTCP_CMD)); /* OPEN BEARER */
2047  05ec 4b29          	push	#41
2048  05ee ae00e3        	ldw	x,#L57
2049  05f1 cd0000        	call	_ms_send_cmd
2051  05f4 84            	pop	a
2052                     ; 588     delay_ms(1000);
2054  05f5 ae03e8        	ldw	x,#1000
2055  05f8 cd0000        	call	_delay_ms
2057                     ; 590 }
2060  05fb 81            	ret
2126                     ; 593 bool bValidIMEIRecieved(char *myArray)
2126                     ; 594 {
2127                     	switch	.text
2128  05fc               _bValidIMEIRecieved:
2130  05fc 89            	pushw	x
2131  05fd 5203          	subw	sp,#3
2132       00000003      OFST:	set	3
2135                     ; 595     uint8_t i = 0, j = 0, k = 0;
2141  05ff 0f02          	clr	(OFST-1,sp)
2143                     ; 596     for (j = 0; j < 20; j++)
2145  0601 0f03          	clr	(OFST+0,sp)
2147  0603               L327:
2148                     ; 598         if (myArray[j] > 0x39 || myArray[j] < 0x30)
2150  0603 7b03          	ld	a,(OFST+0,sp)
2151  0605 5f            	clrw	x
2152  0606 97            	ld	xl,a
2153  0607 72fb04        	addw	x,(OFST+1,sp)
2154  060a f6            	ld	a,(x)
2155  060b a13a          	cp	a,#58
2156  060d 240c          	jruge	L337
2158  060f 7b03          	ld	a,(OFST+0,sp)
2159  0611 5f            	clrw	x
2160  0612 97            	ld	xl,a
2161  0613 72fb04        	addw	x,(OFST+1,sp)
2162  0616 f6            	ld	a,(x)
2163  0617 a130          	cp	a,#48
2164  0619 2419          	jruge	L137
2165  061b               L337:
2166                     ; 600             nop();
2169  061b 9d            nop
2172  061c               L537:
2173                     ; 596     for (j = 0; j < 20; j++)
2175  061c 0c03          	inc	(OFST+0,sp)
2179  061e 7b03          	ld	a,(OFST+0,sp)
2180  0620 a114          	cp	a,#20
2181  0622 25df          	jrult	L327
2182                     ; 607     if (k == 15)
2184  0624 7b02          	ld	a,(OFST-1,sp)
2185  0626 a10f          	cp	a,#15
2186  0628 2621          	jrne	L737
2187                     ; 609         aunIMEI[k] = '\0';
2189  062a 7b02          	ld	a,(OFST-1,sp)
2190  062c 5f            	clrw	x
2191  062d 97            	ld	xl,a
2192  062e 6f10          	clr	(_aunIMEI,x)
2193                     ; 610         return TRUE;
2195  0630 a601          	ld	a,#1
2197  0632 2021          	jra	L25
2198  0634               L137:
2199                     ; 604             aunIMEI[k++] = myArray[j];
2201  0634 7b02          	ld	a,(OFST-1,sp)
2202  0636 97            	ld	xl,a
2203  0637 0c02          	inc	(OFST-1,sp)
2205  0639 9f            	ld	a,xl
2206  063a 5f            	clrw	x
2207  063b 97            	ld	xl,a
2208  063c 7b03          	ld	a,(OFST+0,sp)
2209  063e 905f          	clrw	y
2210  0640 9097          	ld	yl,a
2211  0642 72f904        	addw	y,(OFST+1,sp)
2212  0645 90f6          	ld	a,(y)
2213  0647 e710          	ld	(_aunIMEI,x),a
2214  0649 20d1          	jra	L537
2215  064b               L737:
2216                     ; 614         vClearBuffer(aunIMEI, 16);
2218  064b 4b10          	push	#16
2219  064d ae0010        	ldw	x,#_aunIMEI
2220  0650 cd047b        	call	_vClearBuffer
2222  0653 84            	pop	a
2223                     ; 615         return FALSE;
2225  0654 4f            	clr	a
2227  0655               L25:
2229  0655 5b05          	addw	sp,#5
2230  0657 81            	ret
2233                     .const:	section	.text
2234  0000               L347_imei_array:
2235  0000 00            	dc.b	0
2236  0001 000000000000  	ds.b	19
2337                     ; 620 void vPrintStickerInfo(void)
2337                     ; 621 {
2338                     	switch	.text
2339  0658               _vPrintStickerInfo:
2341  0658 521a          	subw	sp,#26
2342       0000001a      OFST:	set	26
2345                     ; 622     uint8_t p = 0, i = 0;
2349                     ; 623     uint8_t NotRespondingCounter = 0;
2351  065a 0f19          	clr	(OFST-1,sp)
2353                     ; 624     uint16_t gsm_ok_timeout = 10000;
2355                     ; 625     uint8_t imei_array[20] = {0};
2357  065c 96            	ldw	x,sp
2358  065d 1c0004        	addw	x,#OFST-22
2359  0660 90ae0000      	ldw	y,#L347_imei_array
2360  0664 a614          	ld	a,#20
2361  0666 cd0000        	call	c_xymvx
2363                     ; 626     bool ModuleResponding = FALSE;
2365                     ; 627     bool myInterruptFlag = TRUE;
2367                     ; 629     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
2369  0669 4b00          	push	#0
2370  066b ae0255        	ldw	x,#597
2371  066e cd0000        	call	_UART1_ITConfig
2373  0671 84            	pop	a
2374                     ; 630     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
2376  0672 4b00          	push	#0
2377  0674 ae0244        	ldw	x,#580
2378  0677 cd0000        	call	_UART1_ITConfig
2380  067a 84            	pop	a
2381                     ; 631     delay_ms(100);
2383  067b ae0064        	ldw	x,#100
2384  067e cd0000        	call	_delay_ms
2386  0681               L3101:
2387                     ; 635         ms_send_cmd(AT, strlen((const char *)AT));
2389  0681 4b02          	push	#2
2390  0683 ae002c        	ldw	x,#L1201
2391  0686 cd0000        	call	_ms_send_cmd
2393  0689 84            	pop	a
2394                     ; 636         if (GSM_OK())
2396  068a cd0000        	call	_GSM_OK
2398  068d a30000        	cpw	x,#0
2399  0690 2603          	jrne	L65
2400  0692 cc07c0        	jp	L3201
2401  0695               L65:
2402                     ; 638             delay_ms(200);
2404  0695 ae00c8        	ldw	x,#200
2405  0698 cd0000        	call	_delay_ms
2407                     ; 640             getIMEI();
2409  069b cd0207        	call	_getIMEI
2411                     ; 641             if (bValidIMEIRecieved(aunIMEI))
2413  069e ae0010        	ldw	x,#_aunIMEI
2414  06a1 cd05fc        	call	_bValidIMEIRecieved
2416  06a4 4d            	tnz	a
2417  06a5 2603          	jrne	L06
2418  06a7 cc07b4        	jp	L5201
2419  06aa               L06:
2420                     ; 643                 delay_ms(100);
2422  06aa ae0064        	ldw	x,#100
2423  06ad cd0000        	call	_delay_ms
2425                     ; 644                 for (i = 0; i < 20; i++)
2427  06b0 0f1a          	clr	(OFST+0,sp)
2429  06b2               L7301:
2430                     ; 646                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2432  06b2 ae0040        	ldw	x,#64
2433  06b5 cd0000        	call	_UART1_GetFlagStatus
2435  06b8 4d            	tnz	a
2436  06b9 27f7          	jreq	L7301
2437                     ; 648                     UART1_SendData8('*');
2439  06bb a62a          	ld	a,#42
2440  06bd cd0000        	call	_UART1_SendData8
2442                     ; 644                 for (i = 0; i < 20; i++)
2444  06c0 0c1a          	inc	(OFST+0,sp)
2448  06c2 7b1a          	ld	a,(OFST+0,sp)
2449  06c4 a114          	cp	a,#20
2450  06c6 25ea          	jrult	L7301
2452  06c8               L5401:
2453                     ; 650                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2455  06c8 ae0040        	ldw	x,#64
2456  06cb cd0000        	call	_UART1_GetFlagStatus
2458  06ce 4d            	tnz	a
2459  06cf 27f7          	jreq	L5401
2460                     ; 652                 UART1_SendData8('\n');
2462  06d1 a60a          	ld	a,#10
2463  06d3 cd0000        	call	_UART1_SendData8
2466  06d6               L3501:
2467                     ; 653                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2469  06d6 ae0040        	ldw	x,#64
2470  06d9 cd0000        	call	_UART1_GetFlagStatus
2472  06dc 4d            	tnz	a
2473  06dd 27f7          	jreq	L3501
2474                     ; 655                 UART1_SendData8('I');
2476  06df a649          	ld	a,#73
2477  06e1 cd0000        	call	_UART1_SendData8
2480  06e4               L1601:
2481                     ; 656                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2483  06e4 ae0040        	ldw	x,#64
2484  06e7 cd0000        	call	_UART1_GetFlagStatus
2486  06ea 4d            	tnz	a
2487  06eb 27f7          	jreq	L1601
2488                     ; 658                 UART1_SendData8('M');
2490  06ed a64d          	ld	a,#77
2491  06ef cd0000        	call	_UART1_SendData8
2494  06f2               L7601:
2495                     ; 659                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2497  06f2 ae0040        	ldw	x,#64
2498  06f5 cd0000        	call	_UART1_GetFlagStatus
2500  06f8 4d            	tnz	a
2501  06f9 27f7          	jreq	L7601
2502                     ; 661                 UART1_SendData8('E');
2504  06fb a645          	ld	a,#69
2505  06fd cd0000        	call	_UART1_SendData8
2508  0700               L5701:
2509                     ; 662                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2511  0700 ae0040        	ldw	x,#64
2512  0703 cd0000        	call	_UART1_GetFlagStatus
2514  0706 4d            	tnz	a
2515  0707 27f7          	jreq	L5701
2516                     ; 664                 UART1_SendData8('I');
2518  0709 a649          	ld	a,#73
2519  070b cd0000        	call	_UART1_SendData8
2522  070e               L3011:
2523                     ; 665                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2525  070e ae0040        	ldw	x,#64
2526  0711 cd0000        	call	_UART1_GetFlagStatus
2528  0714 4d            	tnz	a
2529  0715 27f7          	jreq	L3011
2530                     ; 667                 UART1_SendData8(' ');
2532  0717 a620          	ld	a,#32
2533  0719 cd0000        	call	_UART1_SendData8
2536  071c               L1111:
2537                     ; 668                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2539  071c ae0040        	ldw	x,#64
2540  071f cd0000        	call	_UART1_GetFlagStatus
2542  0722 4d            	tnz	a
2543  0723 27f7          	jreq	L1111
2544                     ; 670                 UART1_SendData8('i');
2546  0725 a669          	ld	a,#105
2547  0727 cd0000        	call	_UART1_SendData8
2550  072a               L7111:
2551                     ; 671                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2553  072a ae0040        	ldw	x,#64
2554  072d cd0000        	call	_UART1_GetFlagStatus
2556  0730 4d            	tnz	a
2557  0731 27f7          	jreq	L7111
2558                     ; 673                 UART1_SendData8('s');
2560  0733 a673          	ld	a,#115
2561  0735 cd0000        	call	_UART1_SendData8
2564  0738               L5211:
2565                     ; 674                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2567  0738 ae0040        	ldw	x,#64
2568  073b cd0000        	call	_UART1_GetFlagStatus
2570  073e 4d            	tnz	a
2571  073f 27f7          	jreq	L5211
2572                     ; 676                 UART1_SendData8('\n');
2574  0741 a60a          	ld	a,#10
2575  0743 cd0000        	call	_UART1_SendData8
2578  0746               L3311:
2579                     ; 678                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2581  0746 ae0040        	ldw	x,#64
2582  0749 cd0000        	call	_UART1_GetFlagStatus
2584  074c 4d            	tnz	a
2585  074d 27f7          	jreq	L3311
2586                     ; 680                 UART1_SendData8('\n');
2588  074f a60a          	ld	a,#10
2589  0751 cd0000        	call	_UART1_SendData8
2591                     ; 681                 for (i = 0; i < 15; i++)
2593  0754 0f1a          	clr	(OFST+0,sp)
2595  0756               L7411:
2596                     ; 683                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2598  0756 ae0040        	ldw	x,#64
2599  0759 cd0000        	call	_UART1_GetFlagStatus
2601  075c 4d            	tnz	a
2602  075d 27f7          	jreq	L7411
2603                     ; 685                     UART1_SendData8(aunIMEI[i]);
2605  075f 7b1a          	ld	a,(OFST+0,sp)
2606  0761 5f            	clrw	x
2607  0762 97            	ld	xl,a
2608  0763 e610          	ld	a,(_aunIMEI,x)
2609  0765 cd0000        	call	_UART1_SendData8
2611                     ; 681                 for (i = 0; i < 15; i++)
2613  0768 0c1a          	inc	(OFST+0,sp)
2617  076a 7b1a          	ld	a,(OFST+0,sp)
2618  076c a10f          	cp	a,#15
2619  076e 25e6          	jrult	L7411
2621  0770               L5511:
2622                     ; 687                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2624  0770 ae0040        	ldw	x,#64
2625  0773 cd0000        	call	_UART1_GetFlagStatus
2627  0776 4d            	tnz	a
2628  0777 27f7          	jreq	L5511
2629                     ; 690                 UART1_SendData8('\n');
2631  0779 a60a          	ld	a,#10
2632  077b cd0000        	call	_UART1_SendData8
2634                     ; 691                 for (i = 0; i < 20; i++)
2636  077e 0f1a          	clr	(OFST+0,sp)
2638  0780               L1711:
2639                     ; 693                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2641  0780 ae0040        	ldw	x,#64
2642  0783 cd0000        	call	_UART1_GetFlagStatus
2644  0786 4d            	tnz	a
2645  0787 27f7          	jreq	L1711
2646                     ; 695                     UART1_SendData8('*');
2648  0789 a62a          	ld	a,#42
2649  078b cd0000        	call	_UART1_SendData8
2651                     ; 691                 for (i = 0; i < 20; i++)
2653  078e 0c1a          	inc	(OFST+0,sp)
2657  0790 7b1a          	ld	a,(OFST+0,sp)
2658  0792 a114          	cp	a,#20
2659  0794 25ea          	jrult	L1711
2661  0796               L7711:
2662                     ; 697                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2664  0796 ae0040        	ldw	x,#64
2665  0799 cd0000        	call	_UART1_GetFlagStatus
2667  079c 4d            	tnz	a
2668  079d 27f7          	jreq	L7711
2669                     ; 699                 UART1_SendData8('\r');
2671  079f a60d          	ld	a,#13
2672  07a1 cd0000        	call	_UART1_SendData8
2674                     ; 700                 delay_ms(100);
2676  07a4 ae0064        	ldw	x,#100
2677  07a7 cd0000        	call	_delay_ms
2679                     ; 701                 ModuleResponding = TRUE;
2681  07aa a601          	ld	a,#1
2682  07ac 6b1a          	ld	(OFST+0,sp),a
2684                     ; 702                 IMEIRecievedOKFlag = 1;
2686  07ae 35010000      	mov	_IMEIRecievedOKFlag,#1
2688  07b2 2025          	jra	L5021
2689  07b4               L5201:
2690                     ; 706                 delay_ms(200);
2692  07b4 ae00c8        	ldw	x,#200
2693  07b7 cd0000        	call	_delay_ms
2695                     ; 707                 ModuleResponding = FALSE;
2697  07ba 0f1a          	clr	(OFST+0,sp)
2699                     ; 708                 NotRespondingCounter++;
2701  07bc 0c19          	inc	(OFST-1,sp)
2703  07be 2019          	jra	L5021
2704  07c0               L3201:
2705                     ; 714             delay_ms(200);
2707  07c0 ae00c8        	ldw	x,#200
2708  07c3 cd0000        	call	_delay_ms
2710                     ; 715             ms_send_cmd("No Response from Module", strlen((const char *)"No Response from Module"));
2712  07c6 4b17          	push	#23
2713  07c8 ae0014        	ldw	x,#L7021
2714  07cb cd0000        	call	_ms_send_cmd
2716  07ce 84            	pop	a
2717                     ; 716             delay_ms(200);
2719  07cf ae00c8        	ldw	x,#200
2720  07d2 cd0000        	call	_delay_ms
2722                     ; 717             ModuleResponding = FALSE;
2724  07d5 0f1a          	clr	(OFST+0,sp)
2726                     ; 718             NotRespondingCounter++;
2728  07d7 0c19          	inc	(OFST-1,sp)
2730  07d9               L5021:
2731                     ; 721         delay_ms(200);
2733  07d9 ae00c8        	ldw	x,#200
2734  07dc cd0000        	call	_delay_ms
2736                     ; 722     } while (!ModuleResponding && NotRespondingCounter < 10);
2738  07df 0d1a          	tnz	(OFST+0,sp)
2739  07e1 2609          	jrne	L1121
2741  07e3 7b19          	ld	a,(OFST-1,sp)
2742  07e5 a10a          	cp	a,#10
2743  07e7 2403          	jruge	L26
2744  07e9 cc0681        	jp	L3101
2745  07ec               L26:
2746  07ec               L1121:
2747                     ; 724     if (NotRespondingCounter < 10)
2749  07ec 7b19          	ld	a,(OFST-1,sp)
2750  07ee a10a          	cp	a,#10
2751  07f0 2406          	jruge	L3121
2752                     ; 725         IMEIRecievedOKFlag = 1;
2754  07f2 35010000      	mov	_IMEIRecievedOKFlag,#1
2756  07f6 2002          	jra	L5121
2757  07f8               L3121:
2758                     ; 727         IMEIRecievedOKFlag = 0;
2760  07f8 3f00          	clr	_IMEIRecievedOKFlag
2761  07fa               L5121:
2762                     ; 728     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2764  07fa 4b01          	push	#1
2765  07fc ae0255        	ldw	x,#597
2766  07ff cd0000        	call	_UART1_ITConfig
2768  0802 84            	pop	a
2769                     ; 729     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2771  0803 4b01          	push	#1
2772  0805 ae0244        	ldw	x,#580
2773  0808 cd0000        	call	_UART1_ITConfig
2775  080b 84            	pop	a
2776                     ; 730 }
2779  080c 5b1a          	addw	sp,#26
2780  080e 81            	ret
2815                     	xdef	_bValidIMEIRecieved
2816                     	xref.b	_IMEIRecievedOKFlag
2817                     	xref	_aunPushed_Data
2818                     	xdef	_vPrintStickerInfo
2819                     	xdef	_vTCP_Reconnect
2820                     	xdef	_vSend_MQTT_Ping
2821                     	xdef	_vHandle_MQTT
2822                     	xdef	_enGet_TCP_Status
2823                     	xdef	_vClearBuffer
2824                     	xdef	_bSendDataOverTCP
2825                     	xdef	_vInit_MQTT
2826                     	xdef	_getIMEI
2827                     	xdef	_checkNum
2828                     	xdef	_SIMComrestart
2829                     	xref	_GSM_OK
2830                     	xdef	_SIMCom_setup
2831                     	xref	_response_buffer
2832                     	xref	_unMQTT_PingRequest
2833                     	xref	_ulMQTT_Subscribe
2834                     	xref	_ulMQTT_Connect
2835                     	xref	_ms_send_cmd_TCP
2836                     	xref	_ms_send_cmd
2837                     	xref	_vMevris_Send_Version
2838                     	xref	_vMevris_Send_IMEI
2839                     	xref	_punGet_Client_ID
2840                     	xref	_punGet_Command_Topic
2841                     	switch	.ubsct
2842  0000               _PASS_KEY:
2843  0000 000000000000  	ds.b	16
2844                     	xdef	_PASS_KEY
2845  0010               _aunIMEI:
2846  0010 000000000000  	ds.b	20
2847                     	xdef	_aunIMEI
2848                     	xref	_strstr
2849                     	xref.b	_checkit
2850                     	xref	_delay_ms
2851                     	xref	_UART1_GetFlagStatus
2852                     	xref	_UART1_SendData8
2853                     	xref	_UART1_ReceiveData8
2854                     	xref	_UART1_ITConfig
2855                     	xref	_GPIO_WriteLow
2856                     	xref	_GPIO_WriteHigh
2857                     	switch	.const
2858  0014               L7021:
2859  0014 4e6f20526573  	dc.b	"No Response from M"
2860  0026 6f64756c6500  	dc.b	"odule",0
2861  002c               L1201:
2862  002c 415400        	dc.b	"AT",0
2863  002f               L356:
2864  002f 504450204445  	dc.b	"PDP DEACT",0
2865  0039               L546:
2866  0039 54435020434c  	dc.b	"TCP CLOSED",0
2867  0044               L736:
2868  0044 54435020434c  	dc.b	"TCP CLOSING",0
2869  0050               L136:
2870  0050 434f4e4e4543  	dc.b	"CONNECT OK",0
2871  005b               L326:
2872  005b 54435020434f  	dc.b	"TCP CONNECTING",0
2873  006a               L516:
2874  006a 495020535441  	dc.b	"IP STATUS",0
2875  0074               L706:
2876  0074 495020475052  	dc.b	"IP GPRSACT",0
2877  007f               L106:
2878  007f 495020434f4e  	dc.b	"IP CONFIG",0
2879  0089               L375:
2880  0089 495020535441  	dc.b	"IP START",0
2881  0092               L565:
2882  0092 495020494e49  	dc.b	"IP INITIAL",0
2883  009d               L165:
2884  009d 53544154453a  	dc.b	"STATE:",0
2885  00a4               L555:
2886  00a4 41542b434950  	dc.b	"AT+CIPSTATUS",0
2887  00b1               L574:
2888  00b1 53454e44204f  	dc.b	"SEND OK",0
2889  00b9               L174:
2890  00b9 53454e4400    	dc.b	"SEND",0
2891  00be               L754:
2892  00be 41542b434950  	dc.b	"AT+CIPSEND",0
2893  00c9               L502:
2894  00c9 41542b47534e  	dc.b	"AT+GSN",0
2895  00d0               L331:
2896  00d0 41542b434e55  	dc.b	"AT+CNUM",0
2897  00d8               L701:
2898  00d8 41542b43504f  	dc.b	"AT+CPOWD=0",0
2899  00e3               L57:
2900  00e3 41542b434950  	dc.b	"AT+CIPSTART=",34
2901  00f0 54435022      	dc.b	"TCP",34
2902  00f4 2c22          	dc.b	",",34
2903  00f6 6d7174742e6d  	dc.b	"mqtt.mevris.io",34
2904  0105 2c22          	dc.b	",",34
2905  0107 333838312200  	dc.b	"3881",34,0
2906  010d               L37:
2907  010d 41542b434946  	dc.b	"AT+CIFSR",0
2908  0116               L17:
2909  0116 41542b434949  	dc.b	"AT+CIICR",0
2910  011f               L76:
2911  011f 41542b435354  	dc.b	"AT+CSTT=",34
2912  0128 7a6f6e677761  	dc.b	"zongwap",34,0
2913  0131               L56:
2914  0131 41542b434950  	dc.b	"AT+CIPSCONT",0
2915  013d               L36:
2916  013d 41542b434950  	dc.b	"AT+CIPHEAD=1",0
2917  014a               L16:
2918  014a 41542b434950  	dc.b	"AT+CIPSRIP=1",0
2919  0157               L75:
2920  0157 41542b434950  	dc.b	"AT+CIPSPRT=1",0
2921  0164               L55:
2922  0164 41542b434950  	dc.b	"AT+CIPQSEND=0",0
2923  0172               L35:
2924  0172 41542b434950  	dc.b	"AT+CIPMODE=0",0
2925  017f               L15:
2926  017f 41542b434950  	dc.b	"AT+CIPMUX=0",0
2927  018b               L74:
2928  018b 41542b434950  	dc.b	"AT+CIPSHUT",0
2929  0196               L54:
2930  0196 41542b534150  	dc.b	"AT+SAPBR=1,1",0
2931  01a3               L34:
2932  01a3 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
2933  01b1 41504e22      	dc.b	"APN",34
2934  01b5 2c22          	dc.b	",",34
2935  01b7 7a6f6e677761  	dc.b	"zongwap",34,0
2936  01c0               L14:
2937  01c0 41542b534150  	dc.b	"AT+SAPBR=3,1,",34
2938  01ce 434f4e545950  	dc.b	"CONTYPE",34
2939  01d6 2c22          	dc.b	",",34
2940  01d8 475052532200  	dc.b	"GPRS",34,0
2941  01de               L73:
2942  01de 41542b434741  	dc.b	"AT+CGATT=1",0
2943  01e9               L53:
2944  01e9 41542b434d45  	dc.b	"AT+CMEE=2",0
2945  01f3               L33:
2946  01f3 41542b43474e  	dc.b	"AT+CGNSSEQ=RMC",0
2947  0202               L13:
2948  0202 41542b43474e  	dc.b	"AT+CGNSPWR=1",0
2949  020f               L72:
2950  020f 41542b434647  	dc.b	"AT+CFGRI=0",0
2951  021a               L52:
2952  021a 41542b435343  	dc.b	"AT+CSCLK=0",0
2953  0225               L32:
2954  0225 41542b434d47  	dc.b	"AT+CMGD=1,4",0
2955  0231               L12:
2956  0231 4154453000    	dc.b	"ATE0",0
2957                     	xref.b	c_lreg
2958                     	xref.b	c_x
2978                     	xref	c_xymvx
2979                     	end
