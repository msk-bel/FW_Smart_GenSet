   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  48                     ; 58 void SIMCom_setup(void)
  48                     ; 59 {
  50                     	switch	.text
  51  0000               _SIMCom_setup:
  55                     ; 60     delay_ms(100);
  57  0000 ae0064        	ldw	x,#100
  58  0003 cd0000        	call	_delay_ms
  60                     ; 61     SIMComrestart(); //Restart the SIMCOMM 868 module
  62  0006 cd0119        	call	_SIMComrestart
  64                     ; 62     delay_ms(10000);
  66  0009 ae2710        	ldw	x,#10000
  67  000c cd0000        	call	_delay_ms
  69                     ; 64     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  71  000f 4b04          	push	#4
  72  0011 ae01a3        	ldw	x,#L12
  73  0014 cd0000        	call	_ms_send_cmd
  75  0017 84            	pop	a
  76                     ; 65     delay_ms(20000);                                   //need to adjust the delay
  78  0018 ae4e20        	ldw	x,#20000
  79  001b cd0000        	call	_delay_ms
  81                     ; 66     delay_ms(1000);
  83  001e ae03e8        	ldw	x,#1000
  84  0021 cd0000        	call	_delay_ms
  86                     ; 67     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
  88  0024 4b04          	push	#4
  89  0026 ae01a3        	ldw	x,#L12
  90  0029 cd0000        	call	_ms_send_cmd
  92  002c 84            	pop	a
  93                     ; 68     delay_ms(200);
  95  002d ae00c8        	ldw	x,#200
  96  0030 cd0000        	call	_delay_ms
  98                     ; 69     ms_send_cmd(MS_DELETE_ALL_SMS, strlen((const char *)MS_DELETE_ALL_SMS)); /* Delete SMS */
 100  0033 4b0b          	push	#11
 101  0035 ae0197        	ldw	x,#L32
 102  0038 cd0000        	call	_ms_send_cmd
 104  003b 84            	pop	a
 105                     ; 70     delay_ms(1000);
 107  003c ae03e8        	ldw	x,#1000
 108  003f cd0000        	call	_delay_ms
 110                     ; 72     ms_send_cmd(disable_power_saving, strlen((const char *)disable_power_saving)); /* Disable power saving mode */
 112  0042 4b0a          	push	#10
 113  0044 ae018c        	ldw	x,#L52
 114  0047 cd0000        	call	_ms_send_cmd
 116  004a 84            	pop	a
 117                     ; 73     delay_ms(1000);
 119  004b ae03e8        	ldw	x,#1000
 120  004e cd0000        	call	_delay_ms
 122                     ; 75     vPrintStickerInfo(); //Added by Saqib
 124  0051 cd0498        	call	_vPrintStickerInfo
 126                     ; 76     delay_ms(1000);
 128  0054 ae03e8        	ldw	x,#1000
 129  0057 cd0000        	call	_delay_ms
 131                     ; 83     ms_send_cmd(MODULE_RI_OTHERS_OFF, strlen((const char *)MODULE_RI_OTHERS_OFF)); /* Disable power saving mode */
 133  005a 4b1c          	push	#28
 134  005c ae016f        	ldw	x,#L72
 135  005f cd0000        	call	_ms_send_cmd
 137  0062 84            	pop	a
 138                     ; 84     delay_ms(500);
 140  0063 ae01f4        	ldw	x,#500
 141  0066 cd0000        	call	_delay_ms
 143                     ; 85     ms_send_cmd(MODULE_RI_RING_OFF, strlen((const char *)MODULE_RI_RING_OFF)); /* Disable power saving mode */
 145  0069 4b1b          	push	#27
 146  006b ae0153        	ldw	x,#L13
 147  006e cd0000        	call	_ms_send_cmd
 149  0071 84            	pop	a
 150                     ; 86     delay_ms(500);
 152  0072 ae01f4        	ldw	x,#500
 153  0075 cd0000        	call	_delay_ms
 155                     ; 87     ms_send_cmd(MODULE_RI_SMS_ON, strlen((const char *)MODULE_RI_SMS_ON)); /* Disable power saving mode */
 157  0078 4b2a          	push	#42
 158  007a ae0128        	ldw	x,#L33
 159  007d cd0000        	call	_ms_send_cmd
 161  0080 84            	pop	a
 162                     ; 88     delay_ms(500);
 164  0081 ae01f4        	ldw	x,#500
 165  0084 cd0000        	call	_delay_ms
 167                     ; 97     ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
 169  0087 4b04          	push	#4
 170  0089 ae01a3        	ldw	x,#L12
 171  008c cd0000        	call	_ms_send_cmd
 173  008f 84            	pop	a
 174                     ; 98     delay_ms(1000);
 176  0090 ae03e8        	ldw	x,#1000
 177  0093 cd0000        	call	_delay_ms
 179                     ; 135     ms_send_cmd(GPRS_ATT, strlen((const char *)GPRS_ATT)); /* ATTACH TO GPRS SERVICE */
 181  0096 4b0a          	push	#10
 182  0098 ae011d        	ldw	x,#L53
 183  009b cd0000        	call	_ms_send_cmd
 185  009e 84            	pop	a
 186                     ; 136     delay_ms(1000);
 188  009f ae03e8        	ldw	x,#1000
 189  00a2 cd0000        	call	_delay_ms
 191                     ; 138     ms_send_cmd(GPRS_Con, strlen((const char *)GPRS_Con)); /* CONFIG CONNECTION AS GPRS */
 193  00a5 4b18          	push	#24
 194  00a7 ae0104        	ldw	x,#L73
 195  00aa cd0000        	call	_ms_send_cmd
 197  00ad 84            	pop	a
 198                     ; 139     delay_ms(1000);
 200  00ae ae03e8        	ldw	x,#1000
 201  00b1 cd0000        	call	_delay_ms
 203                     ; 141     ms_send_cmd(GPRS_APN, strlen((const char *)GPRS_APN)); /* SET MOBILE NETWORK APN */
 205  00b4 4b1b          	push	#27
 206  00b6 ae00e8        	ldw	x,#L14
 207  00b9 cd0000        	call	_ms_send_cmd
 209  00bc 84            	pop	a
 210                     ; 142     delay_ms(1000);
 212  00bd ae03e8        	ldw	x,#1000
 213  00c0 cd0000        	call	_delay_ms
 215                     ; 144     ms_send_cmd(GPRS_Set, strlen((const char *)GPRS_Set)); /* OPEN BEARER */
 217  00c3 4b0c          	push	#12
 218  00c5 ae00db        	ldw	x,#L34
 219  00c8 cd0000        	call	_ms_send_cmd
 221  00cb 84            	pop	a
 222                     ; 145     delay_ms(1000);
 224  00cc ae03e8        	ldw	x,#1000
 225  00cf cd0000        	call	_delay_ms
 227                     ; 150     delay_ms(1000); //Added by Saqib
 229  00d2 ae03e8        	ldw	x,#1000
 230  00d5 cd0000        	call	_delay_ms
 232                     ; 220     ms_send_cmd(GNSS_SET_OUTPUT_PORT, strlen((const char *)GNSS_SET_OUTPUT_PORT));
 234  00d8 4b1b          	push	#27
 235  00da ae00bf        	ldw	x,#L54
 236  00dd cd0000        	call	_ms_send_cmd
 238  00e0 84            	pop	a
 239                     ; 221     delay_ms(200);
 241  00e1 ae00c8        	ldw	x,#200
 242  00e4 cd0000        	call	_delay_ms
 244                     ; 222     ms_send_cmd(GNSS_GET_NMEA_VIA_CMD_OFF, strlen((const char *)GNSS_GET_NMEA_VIA_CMD_OFF));
 246  00e7 4b16          	push	#22
 247  00e9 ae00a8        	ldw	x,#L74
 248  00ec cd0000        	call	_ms_send_cmd
 250  00ef 84            	pop	a
 251                     ; 223     delay_ms(200);
 253  00f0 ae00c8        	ldw	x,#200
 254  00f3 cd0000        	call	_delay_ms
 256                     ; 224     ms_send_cmd(GNSS_SET_MODE_GPS_ONLY, strlen((const char *)GNSS_SET_MODE_GPS_ONLY));
 258  00f6 4b19          	push	#25
 259  00f8 ae008e        	ldw	x,#L15
 260  00fb cd0000        	call	_ms_send_cmd
 262  00fe 84            	pop	a
 263                     ; 225     delay_ms(200);
 265  00ff ae00c8        	ldw	x,#200
 266  0102 cd0000        	call	_delay_ms
 268                     ; 226     ms_send_cmd(GNSS_AUTO_RUN_ON, strlen((const char *)GNSS_AUTO_RUN_ON));
 270  0105 4b16          	push	#22
 271  0107 ae0077        	ldw	x,#L35
 272  010a cd0000        	call	_ms_send_cmd
 274  010d 84            	pop	a
 275                     ; 227     delay_ms(200);
 277  010e ae00c8        	ldw	x,#200
 278  0111 cd0000        	call	_delay_ms
 280                     ; 240     checkit = 1; //Recieve data through Ringer Interrupt
 282  0114 35010000      	mov	_checkit,#1
 283                     ; 241 }
 286  0118 81            	ret
 314                     ; 287 void SIMComrestart()
 314                     ; 288 {
 315                     	switch	.text
 316  0119               _SIMComrestart:
 320                     ; 289     ms_send_cmd(SIMCom_OFF, strlen((const char *)SIMCom_OFF)); /* Power down the SIMCom module */
 322  0119 4b0a          	push	#10
 323  011b ae006c        	ldw	x,#L56
 324  011e cd0000        	call	_ms_send_cmd
 326  0121 84            	pop	a
 327                     ; 290     delay_ms(1000);
 329  0122 ae03e8        	ldw	x,#1000
 330  0125 cd0000        	call	_delay_ms
 332                     ; 299     GPIO_WriteLow(PWRKEY);
 334  0128 4b20          	push	#32
 335  012a ae500a        	ldw	x,#20490
 336  012d cd0000        	call	_GPIO_WriteLow
 338  0130 84            	pop	a
 339                     ; 300     delay_ms(2000);
 341  0131 ae07d0        	ldw	x,#2000
 342  0134 cd0000        	call	_delay_ms
 344                     ; 301     delay_ms(500);
 346  0137 ae01f4        	ldw	x,#500
 347  013a cd0000        	call	_delay_ms
 349                     ; 302     GPIO_WriteHigh(PWRKEY);
 351  013d 4b20          	push	#32
 352  013f ae500a        	ldw	x,#20490
 353  0142 cd0000        	call	_GPIO_WriteHigh
 355  0145 84            	pop	a
 356                     ; 303     delay_ms(1000);
 358  0146 ae03e8        	ldw	x,#1000
 359  0149 cd0000        	call	_delay_ms
 361                     ; 305 }
 364  014c 81            	ret
 425                     ; 323 uint8_t *punGet_SIM_NUmber()
 425                     ; 324 {
 426                     	switch	.text
 427  014d               _punGet_SIM_NUmber:
 429  014d 5204          	subw	sp,#4
 430       00000004      OFST:	set	4
 433                     ; 325     uint8_t s = 0, i = 0;
 437                     ; 327     vClearBuffer(aunSIMNo, 40);
 439  014f 4b28          	push	#40
 440  0151 ae0000        	ldw	x,#_aunSIMNo
 441  0154 cd0356        	call	_vClearBuffer
 443  0157 84            	pop	a
 444                     ; 328     ms_send_cmd(check_num, strlen((const char *)check_num)); 
 446  0158 4b07          	push	#7
 447  015a ae0064        	ldw	x,#L511
 448  015d cd0000        	call	_ms_send_cmd
 450  0160 84            	pop	a
 451                     ; 329     delay_ms(200);
 453  0161 ae00c8        	ldw	x,#200
 454  0164 cd0000        	call	_delay_ms
 456                     ; 330     ret = strstr(response_buffer, "+CNUM:");
 458  0167 ae005d        	ldw	x,#L711
 459  016a 89            	pushw	x
 460  016b ae0000        	ldw	x,#_response_buffer
 461  016e cd0000        	call	_strstr
 463  0171 5b02          	addw	sp,#2
 464  0173 1f01          	ldw	(OFST-3,sp),x
 466                     ; 331     if(ret)
 468  0175 1e01          	ldw	x,(OFST-3,sp)
 469  0177 2770          	jreq	L121
 470                     ; 333         s = 0;
 472  0179 0f04          	clr	(OFST+0,sp)
 475  017b 2002          	jra	L721
 476  017d               L321:
 477                     ; 334         while(response_buffer[s] != '\"' && s < 40) s++;
 480  017d 0c04          	inc	(OFST+0,sp)
 482  017f               L721:
 485  017f 7b04          	ld	a,(OFST+0,sp)
 486  0181 5f            	clrw	x
 487  0182 97            	ld	xl,a
 488  0183 d60000        	ld	a,(_response_buffer,x)
 489  0186 a122          	cp	a,#34
 490  0188 2706          	jreq	L331
 492  018a 7b04          	ld	a,(OFST+0,sp)
 493  018c a128          	cp	a,#40
 494  018e 25ed          	jrult	L321
 495  0190               L331:
 496                     ; 335         s++;
 498  0190 0c04          	inc	(OFST+0,sp)
 501  0192 2002          	jra	L731
 502  0194               L531:
 503                     ; 336         while(response_buffer[s] != '\"' && s < 40) s++;
 505  0194 0c04          	inc	(OFST+0,sp)
 507  0196               L731:
 510  0196 7b04          	ld	a,(OFST+0,sp)
 511  0198 5f            	clrw	x
 512  0199 97            	ld	xl,a
 513  019a d60000        	ld	a,(_response_buffer,x)
 514  019d a122          	cp	a,#34
 515  019f 2706          	jreq	L341
 517  01a1 7b04          	ld	a,(OFST+0,sp)
 518  01a3 a128          	cp	a,#40
 519  01a5 25ed          	jrult	L531
 520  01a7               L341:
 521                     ; 337         s++;
 523  01a7 0c04          	inc	(OFST+0,sp)
 526  01a9 2002          	jra	L741
 527  01ab               L541:
 528                     ; 338         while(response_buffer[s] != '\"' && s < 40) s++;
 530  01ab 0c04          	inc	(OFST+0,sp)
 532  01ad               L741:
 535  01ad 7b04          	ld	a,(OFST+0,sp)
 536  01af 5f            	clrw	x
 537  01b0 97            	ld	xl,a
 538  01b1 d60000        	ld	a,(_response_buffer,x)
 539  01b4 a122          	cp	a,#34
 540  01b6 2706          	jreq	L351
 542  01b8 7b04          	ld	a,(OFST+0,sp)
 543  01ba a128          	cp	a,#40
 544  01bc 25ed          	jrult	L541
 545  01be               L351:
 546                     ; 339         s++;
 548  01be 0c04          	inc	(OFST+0,sp)
 550                     ; 340         for(i = 0; i < 13 && response_buffer[s] != '\"' ; i++, s++)
 552  01c0 0f03          	clr	(OFST-1,sp)
 555  01c2 2014          	jra	L161
 556  01c4               L551:
 557                     ; 342             aunSIMNo[i] = response_buffer[s];
 559  01c4 7b03          	ld	a,(OFST-1,sp)
 560  01c6 5f            	clrw	x
 561  01c7 97            	ld	xl,a
 562  01c8 7b04          	ld	a,(OFST+0,sp)
 563  01ca 905f          	clrw	y
 564  01cc 9097          	ld	yl,a
 565  01ce 90d60000      	ld	a,(_response_buffer,y)
 566  01d2 e700          	ld	(_aunSIMNo,x),a
 567                     ; 340         for(i = 0; i < 13 && response_buffer[s] != '\"' ; i++, s++)
 569  01d4 0c03          	inc	(OFST-1,sp)
 571  01d6 0c04          	inc	(OFST+0,sp)
 573  01d8               L161:
 576  01d8 7b03          	ld	a,(OFST-1,sp)
 577  01da a10d          	cp	a,#13
 578  01dc 240b          	jruge	L121
 580  01de 7b04          	ld	a,(OFST+0,sp)
 581  01e0 5f            	clrw	x
 582  01e1 97            	ld	xl,a
 583  01e2 d60000        	ld	a,(_response_buffer,x)
 584  01e5 a122          	cp	a,#34
 585  01e7 26db          	jrne	L551
 586  01e9               L121:
 587                     ; 345     return aunSIMNo;
 589  01e9 ae0000        	ldw	x,#_aunSIMNo
 592  01ec 5b04          	addw	sp,#4
 593  01ee 81            	ret
 645                     ; 351 uint8_t *punGetSIM_ICCID(void)
 645                     ; 352 {
 646                     	switch	.text
 647  01ef               _punGetSIM_ICCID:
 649  01ef 5203          	subw	sp,#3
 650       00000003      OFST:	set	3
 653                     ; 355     vClearBuffer(aunICCID,25);
 655  01f1 4b19          	push	#25
 656  01f3 ae000f        	ldw	x,#_aunICCID
 657  01f6 cd0356        	call	_vClearBuffer
 659  01f9 84            	pop	a
 660                     ; 356     ms_send_cmd(MODULE_GET_SIM_ICCID, strlen((const char *)MODULE_GET_SIM_ICCID)); 
 662  01fa 4b08          	push	#8
 663  01fc ae0054        	ldw	x,#L112
 664  01ff cd0000        	call	_ms_send_cmd
 666  0202 84            	pop	a
 667                     ; 357     delay_ms(200);
 669  0203 ae00c8        	ldw	x,#200
 670  0206 cd0000        	call	_delay_ms
 672                     ; 358     ptr = strstr(response_buffer, "+QCCID:");
 674  0209 ae004c        	ldw	x,#L312
 675  020c 89            	pushw	x
 676  020d ae0000        	ldw	x,#_response_buffer
 677  0210 cd0000        	call	_strstr
 679  0213 5b02          	addw	sp,#2
 680  0215 1f01          	ldw	(OFST-2,sp),x
 682                     ; 359     if(ptr)
 684  0217 1e01          	ldw	x,(OFST-2,sp)
 685  0219 2737          	jreq	L512
 686                     ; 361         s = 0;
 688                     ; 362         ptr+=8;
 690  021b 1e01          	ldw	x,(OFST-2,sp)
 691  021d 1c0008        	addw	x,#8
 692  0220 1f01          	ldw	(OFST-2,sp),x
 694                     ; 363         for(s = 0; s < 22 & *(ptr + s) != 0x0D; s++)
 696  0222 0f03          	clr	(OFST+0,sp)
 699  0224 2016          	jra	L322
 700  0226               L712:
 701                     ; 365             aunICCID[s] = *(ptr + s);
 703  0226 7b03          	ld	a,(OFST+0,sp)
 704  0228 5f            	clrw	x
 705  0229 97            	ld	xl,a
 706  022a 89            	pushw	x
 707  022b 7b03          	ld	a,(OFST+0,sp)
 708  022d 97            	ld	xl,a
 709  022e 7b04          	ld	a,(OFST+1,sp)
 710  0230 1b05          	add	a,(OFST+2,sp)
 711  0232 2401          	jrnc	L41
 712  0234 5c            	incw	x
 713  0235               L41:
 714  0235 02            	rlwa	x,a
 715  0236 f6            	ld	a,(x)
 716  0237 85            	popw	x
 717  0238 e70f          	ld	(_aunICCID,x),a
 718                     ; 363         for(s = 0; s < 22 & *(ptr + s) != 0x0D; s++)
 720  023a 0c03          	inc	(OFST+0,sp)
 722  023c               L322:
 725  023c 7b03          	ld	a,(OFST+0,sp)
 726  023e a116          	cp	a,#22
 727  0240 2410          	jruge	L512
 729  0242 7b01          	ld	a,(OFST-2,sp)
 730  0244 97            	ld	xl,a
 731  0245 7b02          	ld	a,(OFST-1,sp)
 732  0247 1b03          	add	a,(OFST+0,sp)
 733  0249 2401          	jrnc	L61
 734  024b 5c            	incw	x
 735  024c               L61:
 736  024c 02            	rlwa	x,a
 737  024d f6            	ld	a,(x)
 738  024e a10d          	cp	a,#13
 739  0250 26d4          	jrne	L712
 740  0252               L512:
 741                     ; 368     return aunICCID;
 743  0252 ae000f        	ldw	x,#_aunICCID
 746  0255 5b03          	addw	sp,#3
 747  0257 81            	ret
 816                     ; 371 void getIMEI(void)
 816                     ; 372 {
 817                     	switch	.text
 818  0258               _getIMEI:
 820  0258 521d          	subw	sp,#29
 821       0000001d      OFST:	set	29
 824                     ; 378     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 826  025a 4b00          	push	#0
 827  025c ae0255        	ldw	x,#597
 828  025f cd0000        	call	_UART1_ITConfig
 830  0262 84            	pop	a
 831                     ; 379     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
 833  0263 4b00          	push	#0
 834  0265 ae0244        	ldw	x,#580
 835  0268 cd0000        	call	_UART1_ITConfig
 837  026b 84            	pop	a
 838                     ; 381     ms_send_cmd(IMEIcmnd, strlen((const char *)IMEIcmnd)); //"AT+HTTPSSL=1"
 840  026c 4b06          	push	#6
 841  026e ae0045        	ldw	x,#L362
 842  0271 cd0000        	call	_ms_send_cmd
 844  0274 84            	pop	a
 845                     ; 384     for (i = 0; i < 25; i++)
 847  0275 0f1d          	clr	(OFST+0,sp)
 849  0277               L572:
 850                     ; 386         while ((!UART1_GetFlagStatus(UART1_FLAG_RXNE) == TRUE) && (++ulTimout != 10000))
 852  0277 ae0020        	ldw	x,#32
 853  027a cd0000        	call	_UART1_GetFlagStatus
 855  027d 4d            	tnz	a
 856  027e 260c          	jrne	L103
 858  0280 1e1a          	ldw	x,(OFST-3,sp)
 859  0282 1c0001        	addw	x,#1
 860  0285 1f1a          	ldw	(OFST-3,sp),x
 862  0287 a32710        	cpw	x,#10000
 863  028a 26eb          	jrne	L572
 864  028c               L103:
 865                     ; 388         localBuffer[i] = UART1_ReceiveData8();
 867  028c 96            	ldw	x,sp
 868  028d 1c0001        	addw	x,#OFST-28
 869  0290 9f            	ld	a,xl
 870  0291 5e            	swapw	x
 871  0292 1b1d          	add	a,(OFST+0,sp)
 872  0294 2401          	jrnc	L22
 873  0296 5c            	incw	x
 874  0297               L22:
 875  0297 02            	rlwa	x,a
 876  0298 89            	pushw	x
 877  0299 cd0000        	call	_UART1_ReceiveData8
 879  029c 85            	popw	x
 880  029d f7            	ld	(x),a
 881                     ; 389         ulTimout = 0;
 883  029e 5f            	clrw	x
 884  029f 1f1a          	ldw	(OFST-3,sp),x
 886                     ; 384     for (i = 0; i < 25; i++)
 888  02a1 0c1d          	inc	(OFST+0,sp)
 892  02a3 7b1d          	ld	a,(OFST+0,sp)
 893  02a5 a119          	cp	a,#25
 894  02a7 25ce          	jrult	L572
 895                     ; 391     localBuffer[i] = '\0';
 897  02a9 96            	ldw	x,sp
 898  02aa 1c0001        	addw	x,#OFST-28
 899  02ad 9f            	ld	a,xl
 900  02ae 5e            	swapw	x
 901  02af 1b1d          	add	a,(OFST+0,sp)
 902  02b1 2401          	jrnc	L42
 903  02b3 5c            	incw	x
 904  02b4               L42:
 905  02b4 02            	rlwa	x,a
 906  02b5 7f            	clr	(x)
 907                     ; 392     j = 0;
 909  02b6 0f1c          	clr	(OFST-1,sp)
 911                     ; 393     for (i = 2; i < 17; i++)
 913  02b8 a602          	ld	a,#2
 914  02ba 6b1d          	ld	(OFST+0,sp),a
 916  02bc               L303:
 917                     ; 395         aunIMEI[j] = localBuffer[i];
 919  02bc 7b1c          	ld	a,(OFST-1,sp)
 920  02be 5f            	clrw	x
 921  02bf 97            	ld	xl,a
 922  02c0 89            	pushw	x
 923  02c1 96            	ldw	x,sp
 924  02c2 1c0003        	addw	x,#OFST-26
 925  02c5 9f            	ld	a,xl
 926  02c6 5e            	swapw	x
 927  02c7 1b1f          	add	a,(OFST+2,sp)
 928  02c9 2401          	jrnc	L62
 929  02cb 5c            	incw	x
 930  02cc               L62:
 931  02cc 02            	rlwa	x,a
 932  02cd f6            	ld	a,(x)
 933  02ce 85            	popw	x
 934  02cf e738          	ld	(_aunIMEI,x),a
 935                     ; 396         j++;
 937  02d1 0c1c          	inc	(OFST-1,sp)
 939                     ; 393     for (i = 2; i < 17; i++)
 941  02d3 0c1d          	inc	(OFST+0,sp)
 945  02d5 7b1d          	ld	a,(OFST+0,sp)
 946  02d7 a111          	cp	a,#17
 947  02d9 25e1          	jrult	L303
 948                     ; 398     aunIMEI[j] = '\0';
 950  02db 7b1c          	ld	a,(OFST-1,sp)
 951  02dd 5f            	clrw	x
 952  02de 97            	ld	xl,a
 953  02df 6f38          	clr	(_aunIMEI,x)
 954                     ; 399     delay_ms(200);
 956  02e1 ae00c8        	ldw	x,#200
 957  02e4 cd0000        	call	_delay_ms
 959                     ; 401     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 961  02e7 4b01          	push	#1
 962  02e9 ae0255        	ldw	x,#597
 963  02ec cd0000        	call	_UART1_ITConfig
 965  02ef 84            	pop	a
 966                     ; 402     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
 968  02f0 4b01          	push	#1
 969  02f2 ae0244        	ldw	x,#580
 970  02f5 cd0000        	call	_UART1_ITConfig
 972  02f8 84            	pop	a
 973                     ; 403 }
 976  02f9 5b1d          	addw	sp,#29
 977  02fb 81            	ret
 980                     	bsct
 981  0000               L113_unMQTTCounter:
 982  0000 00            	dc.b	0
 983  0001               L313_unMQQT_PingCounter:
 984  0001 00            	dc.b	0
1144                     ; 729 void vHandle_MQTT(void)
1144                     ; 730 {
1145                     	switch	.text
1146  02fc               _vHandle_MQTT:
1148  02fc 89            	pushw	x
1149       00000002      OFST:	set	2
1152                     ; 731     uint8_t unLength = 0;
1154                     ; 736     if (IMEIRecievedOKFlag)
1156  02fd 3d00          	tnz	_IMEIRecievedOKFlag
1157  02ff 2750          	jreq	L104
1158                     ; 738         eTCP_Status = enGet_TCP_Status();
1160  0301 ad70          	call	_enGet_TCP_Status
1162  0303 6b02          	ld	(OFST+0,sp),a
1164                     ; 739         if (eTCP_Status == eTCP_STAT_CONNECT_OK)
1166  0305 7b02          	ld	a,(OFST+0,sp)
1167  0307 a107          	cp	a,#7
1168  0309 263c          	jrne	L304
1169                     ; 741             if (unMQTTCounter == 0)
1171  030b 3d00          	tnz	L113_unMQTTCounter
1172  030d 260a          	jrne	L504
1173                     ; 743                 vMQTT_Subscribe(aunMQTT_Subscribe_Topic);
1175  030f ae0000        	ldw	x,#_aunMQTT_Subscribe_Topic
1176  0312 cd0000        	call	_vMQTT_Subscribe
1178                     ; 744                 unMQTTCounter++;
1180  0315 3c00          	inc	L113_unMQTTCounter
1182  0317 203b          	jra	L524
1183  0319               L504:
1184                     ; 746             else if (unMQTTCounter == 1)
1186  0319 b600          	ld	a,L113_unMQTTCounter
1187  031b a101          	cp	a,#1
1188  031d 260d          	jrne	L114
1189                     ; 748                 delay_ms(100);
1191  031f ae0064        	ldw	x,#100
1192  0322 cd0000        	call	_delay_ms
1194                     ; 749                 vMevris_Send_IMEI();
1196  0325 cd0000        	call	_vMevris_Send_IMEI
1198                     ; 750                 unMQTTCounter++;
1200  0328 3c00          	inc	L113_unMQTTCounter
1202  032a 2028          	jra	L524
1203  032c               L114:
1204                     ; 753             else if (unMQTTCounter == 2)
1206  032c b600          	ld	a,L113_unMQTTCounter
1207  032e a102          	cp	a,#2
1208  0330 260d          	jrne	L514
1209                     ; 755                 delay_ms(100);
1211  0332 ae0064        	ldw	x,#100
1212  0335 cd0000        	call	_delay_ms
1214                     ; 756                 vMevris_Send_Version();
1216  0338 cd0000        	call	_vMevris_Send_Version
1218                     ; 757                 unMQTTCounter++;
1220  033b 3c00          	inc	L113_unMQTTCounter
1222  033d 2015          	jra	L524
1223  033f               L514:
1224                     ; 760             else if (unMQTTCounter >= 3)
1226  033f b600          	ld	a,L113_unMQTTCounter
1227  0341 a103          	cp	a,#3
1228  0343 250f          	jrult	L524
1229  0345 200d          	jra	L524
1230  0347               L304:
1231                     ; 767             vMQTT_Connect(aunMQTT_ClientID);
1233  0347 ae0000        	ldw	x,#_aunMQTT_ClientID
1234  034a cd0000        	call	_vMQTT_Connect
1236                     ; 768             unMQTTCounter = 0;
1238  034d 3f00          	clr	L113_unMQTTCounter
1239  034f 2003          	jra	L524
1240  0351               L104:
1241                     ; 773         vPrintStickerInfo();
1243  0351 cd0498        	call	_vPrintStickerInfo
1245  0354               L524:
1246                     ; 775 }
1249  0354 85            	popw	x
1250  0355 81            	ret
1303                     ; 779 void vClearBuffer(char *temp, uint8_t unLen)
1303                     ; 780 {
1304                     	switch	.text
1305  0356               _vClearBuffer:
1307  0356 89            	pushw	x
1308  0357 88            	push	a
1309       00000001      OFST:	set	1
1312                     ; 782     for (i = 0; i < unLen; i++)
1314  0358 0f01          	clr	(OFST+0,sp)
1317  035a 200e          	jra	L164
1318  035c               L554:
1319                     ; 784         *(temp + i) = '\0';
1321  035c 7b02          	ld	a,(OFST+1,sp)
1322  035e 97            	ld	xl,a
1323  035f 7b03          	ld	a,(OFST+2,sp)
1324  0361 1b01          	add	a,(OFST+0,sp)
1325  0363 2401          	jrnc	L43
1326  0365 5c            	incw	x
1327  0366               L43:
1328  0366 02            	rlwa	x,a
1329  0367 7f            	clr	(x)
1330                     ; 782     for (i = 0; i < unLen; i++)
1332  0368 0c01          	inc	(OFST+0,sp)
1334  036a               L164:
1337  036a 7b01          	ld	a,(OFST+0,sp)
1338  036c 1106          	cp	a,(OFST+5,sp)
1339  036e 25ec          	jrult	L554
1340                     ; 786 }
1343  0370 5b03          	addw	sp,#3
1344  0372 81            	ret
1404                     ; 788 enTCP_STATUS enGet_TCP_Status(void)
1404                     ; 789 {
1405                     	switch	.text
1406  0373               _enGet_TCP_Status:
1408  0373 5203          	subw	sp,#3
1409       00000003      OFST:	set	3
1412                     ; 791     uint8_t j = 0;
1414  0375 0f03          	clr	(OFST+0,sp)
1416                     ; 851     ms_send_cmd(MQTT_CHECK_STATUS, strlen((const char *)MQTT_CHECK_STATUS));
1418  0377 4b0b          	push	#11
1419  0379 ae0039        	ldw	x,#L315
1420  037c cd0000        	call	_ms_send_cmd
1422  037f 84            	pop	a
1423                     ; 852     delay_ms(1000);
1425  0380 ae03e8        	ldw	x,#1000
1426  0383 cd0000        	call	_delay_ms
1428                     ; 854     if (strstr(response_buffer, "+QMTCONN:"))
1430  0386 ae002f        	ldw	x,#L715
1431  0389 89            	pushw	x
1432  038a ae0000        	ldw	x,#_response_buffer
1433  038d cd0000        	call	_strstr
1435  0390 5b02          	addw	sp,#2
1436  0392 a30000        	cpw	x,#0
1437  0395 2603          	jrne	L25
1438  0397 cc042a        	jp	L515
1439  039a               L25:
1440                     ; 856         i = strstr(response_buffer, "+QMTCONN:");
1442  039a ae002f        	ldw	x,#L715
1443  039d 89            	pushw	x
1444  039e ae0000        	ldw	x,#_response_buffer
1445  03a1 cd0000        	call	_strstr
1447  03a4 5b02          	addw	sp,#2
1448  03a6 1f01          	ldw	(OFST-2,sp),x
1450                     ; 857         if (i)
1452  03a8 1e01          	ldw	x,(OFST-2,sp)
1453  03aa 2602          	jrne	L45
1454  03ac 2078          	jp	L125
1455  03ae               L45:
1457  03ae 2002          	jra	L525
1458  03b0               L325:
1459                     ; 860                 j++;
1461  03b0 0c03          	inc	(OFST+0,sp)
1463  03b2               L525:
1464                     ; 859             while (*(i + j) != ',' && j < 100)
1466  03b2 7b01          	ld	a,(OFST-2,sp)
1467  03b4 97            	ld	xl,a
1468  03b5 7b02          	ld	a,(OFST-1,sp)
1469  03b7 1b03          	add	a,(OFST+0,sp)
1470  03b9 2401          	jrnc	L04
1471  03bb 5c            	incw	x
1472  03bc               L04:
1473  03bc 02            	rlwa	x,a
1474  03bd f6            	ld	a,(x)
1475  03be a12c          	cp	a,#44
1476  03c0 2706          	jreq	L135
1478  03c2 7b03          	ld	a,(OFST+0,sp)
1479  03c4 a164          	cp	a,#100
1480  03c6 25e8          	jrult	L325
1481  03c8               L135:
1482                     ; 864             j++;
1484  03c8 0c03          	inc	(OFST+0,sp)
1486                     ; 866             if (*(i + j) == '1')
1488  03ca 7b01          	ld	a,(OFST-2,sp)
1489  03cc 97            	ld	xl,a
1490  03cd 7b02          	ld	a,(OFST-1,sp)
1491  03cf 1b03          	add	a,(OFST+0,sp)
1492  03d1 2401          	jrnc	L24
1493  03d3 5c            	incw	x
1494  03d4               L24:
1495  03d4 02            	rlwa	x,a
1496  03d5 f6            	ld	a,(x)
1497  03d6 a131          	cp	a,#49
1498  03d8 2606          	jrne	L335
1499                     ; 868                 eStatus = eTCP_STAT_IP_INITIAL;
1501  03da a601          	ld	a,#1
1502  03dc 6b03          	ld	(OFST+0,sp),a
1505  03de 204c          	jra	L555
1506  03e0               L335:
1507                     ; 871             else if (*(i + j) == '2')
1509  03e0 7b01          	ld	a,(OFST-2,sp)
1510  03e2 97            	ld	xl,a
1511  03e3 7b02          	ld	a,(OFST-1,sp)
1512  03e5 1b03          	add	a,(OFST+0,sp)
1513  03e7 2401          	jrnc	L44
1514  03e9 5c            	incw	x
1515  03ea               L44:
1516  03ea 02            	rlwa	x,a
1517  03eb f6            	ld	a,(x)
1518  03ec a132          	cp	a,#50
1519  03ee 2606          	jrne	L735
1520                     ; 873                 eStatus = eTCP_STAT_CONNECTING;
1522  03f0 a606          	ld	a,#6
1523  03f2 6b03          	ld	(OFST+0,sp),a
1526  03f4 2036          	jra	L555
1527  03f6               L735:
1528                     ; 876             else if (*(i + j) == '3')
1530  03f6 7b01          	ld	a,(OFST-2,sp)
1531  03f8 97            	ld	xl,a
1532  03f9 7b02          	ld	a,(OFST-1,sp)
1533  03fb 1b03          	add	a,(OFST+0,sp)
1534  03fd 2401          	jrnc	L64
1535  03ff 5c            	incw	x
1536  0400               L64:
1537  0400 02            	rlwa	x,a
1538  0401 f6            	ld	a,(x)
1539  0402 a133          	cp	a,#51
1540  0404 2606          	jrne	L345
1541                     ; 878                 eStatus = eTCP_STAT_CONNECT_OK;
1543  0406 a607          	ld	a,#7
1544  0408 6b03          	ld	(OFST+0,sp),a
1547  040a 2020          	jra	L555
1548  040c               L345:
1549                     ; 884             else if (*(i + j) == '4')
1551  040c 7b01          	ld	a,(OFST-2,sp)
1552  040e 97            	ld	xl,a
1553  040f 7b02          	ld	a,(OFST-1,sp)
1554  0411 1b03          	add	a,(OFST+0,sp)
1555  0413 2401          	jrnc	L05
1556  0415 5c            	incw	x
1557  0416               L05:
1558  0416 02            	rlwa	x,a
1559  0417 f6            	ld	a,(x)
1560  0418 a134          	cp	a,#52
1561  041a 2606          	jrne	L745
1562                     ; 886                 eStatus = eTCP_STAT_CLOSED;
1564  041c a609          	ld	a,#9
1565  041e 6b03          	ld	(OFST+0,sp),a
1568  0420 200a          	jra	L555
1569  0422               L745:
1570                     ; 890                 eStatus = eTCP_STAT_UNKNOWN;
1572  0422 0f03          	clr	(OFST+0,sp)
1574  0424 2006          	jra	L555
1575  0426               L125:
1576                     ; 895             eStatus = eTCP_STAT_UNKNOWN;
1578  0426 0f03          	clr	(OFST+0,sp)
1580  0428 2002          	jra	L555
1581  042a               L515:
1582                     ; 900         eStatus = eTCP_STAT_UNKNOWN;
1584  042a 0f03          	clr	(OFST+0,sp)
1586  042c               L555:
1587                     ; 903     return eStatus;
1589  042c 7b03          	ld	a,(OFST+0,sp)
1592  042e 5b03          	addw	sp,#3
1593  0430 81            	ret
1679                     ; 929 bool bValidIMEIRecieved(char *myArray)
1679                     ; 930 {
1680                     	switch	.text
1681  0431               _bValidIMEIRecieved:
1683  0431 89            	pushw	x
1684  0432 5203          	subw	sp,#3
1685       00000003      OFST:	set	3
1688                     ; 931     uint8_t i = 0, j = 0, k = 0;
1694  0434 0f02          	clr	(OFST-1,sp)
1696                     ; 932     for (j = 0; j < 20; j++)
1698  0436 0f03          	clr	(OFST+0,sp)
1700  0438               L126:
1701                     ; 934         if (myArray[j] > 0x39 || myArray[j] < 0x30)
1703  0438 7b04          	ld	a,(OFST+1,sp)
1704  043a 97            	ld	xl,a
1705  043b 7b05          	ld	a,(OFST+2,sp)
1706  043d 1b03          	add	a,(OFST+0,sp)
1707  043f 2401          	jrnc	L06
1708  0441 5c            	incw	x
1709  0442               L06:
1710  0442 02            	rlwa	x,a
1711  0443 f6            	ld	a,(x)
1712  0444 a13a          	cp	a,#58
1713  0446 2410          	jruge	L136
1715  0448 7b04          	ld	a,(OFST+1,sp)
1716  044a 97            	ld	xl,a
1717  044b 7b05          	ld	a,(OFST+2,sp)
1718  044d 1b03          	add	a,(OFST+0,sp)
1719  044f 2401          	jrnc	L26
1720  0451 5c            	incw	x
1721  0452               L26:
1722  0452 02            	rlwa	x,a
1723  0453 f6            	ld	a,(x)
1724  0454 a130          	cp	a,#48
1725  0456 2419          	jruge	L726
1726  0458               L136:
1727                     ; 936             nop();
1730  0458 9d            nop
1733  0459               L336:
1734                     ; 932     for (j = 0; j < 20; j++)
1736  0459 0c03          	inc	(OFST+0,sp)
1740  045b 7b03          	ld	a,(OFST+0,sp)
1741  045d a114          	cp	a,#20
1742  045f 25d7          	jrult	L126
1743                     ; 943     if (k == 15)
1745  0461 7b02          	ld	a,(OFST-1,sp)
1746  0463 a10f          	cp	a,#15
1747  0465 2624          	jrne	L536
1748                     ; 945         aunIMEI[k] = '\0';
1750  0467 7b02          	ld	a,(OFST-1,sp)
1751  0469 5f            	clrw	x
1752  046a 97            	ld	xl,a
1753  046b 6f38          	clr	(_aunIMEI,x)
1754                     ; 946         return TRUE;
1756  046d a601          	ld	a,#1
1758  046f 2024          	jra	L66
1759  0471               L726:
1760                     ; 940             aunIMEI[k++] = myArray[j];
1762  0471 7b02          	ld	a,(OFST-1,sp)
1763  0473 97            	ld	xl,a
1764  0474 0c02          	inc	(OFST-1,sp)
1766  0476 9f            	ld	a,xl
1767  0477 5f            	clrw	x
1768  0478 97            	ld	xl,a
1769  0479 89            	pushw	x
1770  047a 7b06          	ld	a,(OFST+3,sp)
1771  047c 97            	ld	xl,a
1772  047d 7b07          	ld	a,(OFST+4,sp)
1773  047f 1b05          	add	a,(OFST+2,sp)
1774  0481 2401          	jrnc	L46
1775  0483 5c            	incw	x
1776  0484               L46:
1777  0484 02            	rlwa	x,a
1778  0485 f6            	ld	a,(x)
1779  0486 85            	popw	x
1780  0487 e738          	ld	(_aunIMEI,x),a
1781  0489 20ce          	jra	L336
1782  048b               L536:
1783                     ; 950         vClearBuffer(aunIMEI, 16);
1785  048b 4b10          	push	#16
1786  048d ae0038        	ldw	x,#_aunIMEI
1787  0490 cd0356        	call	_vClearBuffer
1789  0493 84            	pop	a
1790                     ; 951         return FALSE;
1792  0494 4f            	clr	a
1794  0495               L66:
1796  0495 5b05          	addw	sp,#5
1797  0497 81            	ret
1800                     .const:	section	.text
1801  0000               L146_imei_array:
1802  0000 00            	dc.b	0
1803  0001 000000000000  	ds.b	19
1908                     ; 956 void vPrintStickerInfo(void)
1908                     ; 957 {
1909                     	switch	.text
1910  0498               _vPrintStickerInfo:
1912  0498 521a          	subw	sp,#26
1913       0000001a      OFST:	set	26
1916                     ; 958     uint8_t p = 0, i = 0;
1920                     ; 959     uint8_t NotRespondingCounter = 0;
1922  049a 0f19          	clr	(OFST-1,sp)
1924                     ; 960     uint16_t gsm_ok_timeout = 10000;
1926                     ; 961     uint8_t imei_array[20] = {0};
1928  049c 96            	ldw	x,sp
1929  049d 1c0004        	addw	x,#OFST-22
1930  04a0 90ae0000      	ldw	y,#L146_imei_array
1931  04a4 a614          	ld	a,#20
1932  04a6 cd0000        	call	c_xymvx
1934                     ; 962     bool ModuleResponding = FALSE;
1936                     ; 963     bool myInterruptFlag = TRUE;
1938                     ; 965     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
1940  04a9 4b00          	push	#0
1941  04ab ae0255        	ldw	x,#597
1942  04ae cd0000        	call	_UART1_ITConfig
1944  04b1 84            	pop	a
1945                     ; 966     UART1_ITConfig(UART1_IT_IDLE, DISABLE);
1947  04b2 4b00          	push	#0
1948  04b4 ae0244        	ldw	x,#580
1949  04b7 cd0000        	call	_UART1_ITConfig
1951  04ba 84            	pop	a
1952                     ; 967     delay_ms(100);
1954  04bb ae0064        	ldw	x,#100
1955  04be cd0000        	call	_delay_ms
1957  04c1               L117:
1958                     ; 971         ms_send_cmd(NOECHO, strlen((const char *)NOECHO)); /* No echo */
1960  04c1 4b04          	push	#4
1961  04c3 ae01a3        	ldw	x,#L12
1962  04c6 cd0000        	call	_ms_send_cmd
1964  04c9 84            	pop	a
1965                     ; 972         delay_ms(200);
1967  04ca ae00c8        	ldw	x,#200
1968  04cd cd0000        	call	_delay_ms
1970                     ; 973         ms_send_cmd(AT, strlen((const char *)AT));
1972  04d0 4b02          	push	#2
1973  04d2 ae002c        	ldw	x,#L717
1974  04d5 cd0000        	call	_ms_send_cmd
1976  04d8 84            	pop	a
1977                     ; 974         if (GSM_OK())
1979  04d9 cd0000        	call	_GSM_OK
1981  04dc a30000        	cpw	x,#0
1982  04df 2603          	jrne	L27
1983  04e1 cc0618        	jp	L127
1984  04e4               L27:
1985                     ; 976             delay_ms(200);
1987  04e4 ae00c8        	ldw	x,#200
1988  04e7 cd0000        	call	_delay_ms
1990                     ; 978             getIMEI();
1992  04ea cd0258        	call	_getIMEI
1994                     ; 979             if (bValidIMEIRecieved(aunIMEI))
1996  04ed ae0038        	ldw	x,#_aunIMEI
1997  04f0 cd0431        	call	_bValidIMEIRecieved
1999  04f3 4d            	tnz	a
2000  04f4 2603          	jrne	L47
2001  04f6 cc060c        	jp	L327
2002  04f9               L47:
2003                     ; 981                 delay_ms(100);
2005  04f9 ae0064        	ldw	x,#100
2006  04fc cd0000        	call	_delay_ms
2008                     ; 982                 for (i = 0; i < 20; i++)
2010  04ff 0f1a          	clr	(OFST+0,sp)
2012  0501               L537:
2013                     ; 984                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2015  0501 ae0040        	ldw	x,#64
2016  0504 cd0000        	call	_UART1_GetFlagStatus
2018  0507 4d            	tnz	a
2019  0508 27f7          	jreq	L537
2020                     ; 986                     UART1_SendData8('*');
2022  050a a62a          	ld	a,#42
2023  050c cd0000        	call	_UART1_SendData8
2025                     ; 982                 for (i = 0; i < 20; i++)
2027  050f 0c1a          	inc	(OFST+0,sp)
2031  0511 7b1a          	ld	a,(OFST+0,sp)
2032  0513 a114          	cp	a,#20
2033  0515 25ea          	jrult	L537
2035  0517               L347:
2036                     ; 988                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2038  0517 ae0040        	ldw	x,#64
2039  051a cd0000        	call	_UART1_GetFlagStatus
2041  051d 4d            	tnz	a
2042  051e 27f7          	jreq	L347
2043                     ; 990                 UART1_SendData8('\n');
2045  0520 a60a          	ld	a,#10
2046  0522 cd0000        	call	_UART1_SendData8
2049  0525               L157:
2050                     ; 991                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2052  0525 ae0040        	ldw	x,#64
2053  0528 cd0000        	call	_UART1_GetFlagStatus
2055  052b 4d            	tnz	a
2056  052c 27f7          	jreq	L157
2057                     ; 993                 UART1_SendData8('I');
2059  052e a649          	ld	a,#73
2060  0530 cd0000        	call	_UART1_SendData8
2063  0533               L757:
2064                     ; 994                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2066  0533 ae0040        	ldw	x,#64
2067  0536 cd0000        	call	_UART1_GetFlagStatus
2069  0539 4d            	tnz	a
2070  053a 27f7          	jreq	L757
2071                     ; 996                 UART1_SendData8('M');
2073  053c a64d          	ld	a,#77
2074  053e cd0000        	call	_UART1_SendData8
2077  0541               L567:
2078                     ; 997                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2080  0541 ae0040        	ldw	x,#64
2081  0544 cd0000        	call	_UART1_GetFlagStatus
2083  0547 4d            	tnz	a
2084  0548 27f7          	jreq	L567
2085                     ; 999                 UART1_SendData8('E');
2087  054a a645          	ld	a,#69
2088  054c cd0000        	call	_UART1_SendData8
2091  054f               L377:
2092                     ; 1000                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2094  054f ae0040        	ldw	x,#64
2095  0552 cd0000        	call	_UART1_GetFlagStatus
2097  0555 4d            	tnz	a
2098  0556 27f7          	jreq	L377
2099                     ; 1002                 UART1_SendData8('I');
2101  0558 a649          	ld	a,#73
2102  055a cd0000        	call	_UART1_SendData8
2105  055d               L1001:
2106                     ; 1003                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2108  055d ae0040        	ldw	x,#64
2109  0560 cd0000        	call	_UART1_GetFlagStatus
2111  0563 4d            	tnz	a
2112  0564 27f7          	jreq	L1001
2113                     ; 1005                 UART1_SendData8(' ');
2115  0566 a620          	ld	a,#32
2116  0568 cd0000        	call	_UART1_SendData8
2119  056b               L7001:
2120                     ; 1006                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2122  056b ae0040        	ldw	x,#64
2123  056e cd0000        	call	_UART1_GetFlagStatus
2125  0571 4d            	tnz	a
2126  0572 27f7          	jreq	L7001
2127                     ; 1008                 UART1_SendData8('i');
2129  0574 a669          	ld	a,#105
2130  0576 cd0000        	call	_UART1_SendData8
2133  0579               L5101:
2134                     ; 1009                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2136  0579 ae0040        	ldw	x,#64
2137  057c cd0000        	call	_UART1_GetFlagStatus
2139  057f 4d            	tnz	a
2140  0580 27f7          	jreq	L5101
2141                     ; 1011                 UART1_SendData8('s');
2143  0582 a673          	ld	a,#115
2144  0584 cd0000        	call	_UART1_SendData8
2147  0587               L3201:
2148                     ; 1012                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2150  0587 ae0040        	ldw	x,#64
2151  058a cd0000        	call	_UART1_GetFlagStatus
2153  058d 4d            	tnz	a
2154  058e 27f7          	jreq	L3201
2155                     ; 1014                 UART1_SendData8('\n');
2157  0590 a60a          	ld	a,#10
2158  0592 cd0000        	call	_UART1_SendData8
2161  0595               L1301:
2162                     ; 1016                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2164  0595 ae0040        	ldw	x,#64
2165  0598 cd0000        	call	_UART1_GetFlagStatus
2167  059b 4d            	tnz	a
2168  059c 27f7          	jreq	L1301
2169                     ; 1018                 UART1_SendData8('\n');
2171  059e a60a          	ld	a,#10
2172  05a0 cd0000        	call	_UART1_SendData8
2174                     ; 1019                 for (i = 0; i < 15; i++)
2176  05a3 0f1a          	clr	(OFST+0,sp)
2178  05a5               L5401:
2179                     ; 1021                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2181  05a5 ae0040        	ldw	x,#64
2182  05a8 cd0000        	call	_UART1_GetFlagStatus
2184  05ab 4d            	tnz	a
2185  05ac 27f7          	jreq	L5401
2186                     ; 1023                     UART1_SendData8(aunIMEI[i]);
2188  05ae 7b1a          	ld	a,(OFST+0,sp)
2189  05b0 5f            	clrw	x
2190  05b1 97            	ld	xl,a
2191  05b2 e638          	ld	a,(_aunIMEI,x)
2192  05b4 cd0000        	call	_UART1_SendData8
2194                     ; 1019                 for (i = 0; i < 15; i++)
2196  05b7 0c1a          	inc	(OFST+0,sp)
2200  05b9 7b1a          	ld	a,(OFST+0,sp)
2201  05bb a10f          	cp	a,#15
2202  05bd 25e6          	jrult	L5401
2204  05bf               L3501:
2205                     ; 1025                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2207  05bf ae0040        	ldw	x,#64
2208  05c2 cd0000        	call	_UART1_GetFlagStatus
2210  05c5 4d            	tnz	a
2211  05c6 27f7          	jreq	L3501
2212                     ; 1028                 UART1_SendData8('\n');
2214  05c8 a60a          	ld	a,#10
2215  05ca cd0000        	call	_UART1_SendData8
2217                     ; 1029                 for (i = 0; i < 20; i++)
2219  05cd 0f1a          	clr	(OFST+0,sp)
2221  05cf               L7601:
2222                     ; 1031                     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2224  05cf ae0040        	ldw	x,#64
2225  05d2 cd0000        	call	_UART1_GetFlagStatus
2227  05d5 4d            	tnz	a
2228  05d6 27f7          	jreq	L7601
2229                     ; 1033                     UART1_SendData8('*');
2231  05d8 a62a          	ld	a,#42
2232  05da cd0000        	call	_UART1_SendData8
2234                     ; 1029                 for (i = 0; i < 20; i++)
2236  05dd 0c1a          	inc	(OFST+0,sp)
2240  05df 7b1a          	ld	a,(OFST+0,sp)
2241  05e1 a114          	cp	a,#20
2242  05e3 25ea          	jrult	L7601
2244  05e5               L5701:
2245                     ; 1035                 while (!UART1_GetFlagStatus(UART1_FLAG_TC))
2247  05e5 ae0040        	ldw	x,#64
2248  05e8 cd0000        	call	_UART1_GetFlagStatus
2250  05eb 4d            	tnz	a
2251  05ec 27f7          	jreq	L5701
2252                     ; 1037                 UART1_SendData8('\r');
2254  05ee a60d          	ld	a,#13
2255  05f0 cd0000        	call	_UART1_SendData8
2257                     ; 1038                 delay_ms(100);
2259  05f3 ae0064        	ldw	x,#100
2260  05f6 cd0000        	call	_delay_ms
2262                     ; 1040                 punGet_Client_ID();
2264  05f9 cd0000        	call	_punGet_Client_ID
2266                     ; 1041                 punGet_Command_Topic();
2268  05fc cd0000        	call	_punGet_Command_Topic
2270                     ; 1042                 punGet_Event_Topic();
2272  05ff cd0000        	call	_punGet_Event_Topic
2274                     ; 1044                 ModuleResponding = TRUE;
2276  0602 a601          	ld	a,#1
2277  0604 6b1a          	ld	(OFST+0,sp),a
2279                     ; 1045                 IMEIRecievedOKFlag = 1;
2281  0606 35010000      	mov	_IMEIRecievedOKFlag,#1
2283  060a 2034          	jra	L3011
2284  060c               L327:
2285                     ; 1049                 delay_ms(200);
2287  060c ae00c8        	ldw	x,#200
2288  060f cd0000        	call	_delay_ms
2290                     ; 1050                 ModuleResponding = FALSE;
2292  0612 0f1a          	clr	(OFST+0,sp)
2294                     ; 1051                 NotRespondingCounter++;
2296  0614 0c19          	inc	(OFST-1,sp)
2298  0616 2028          	jra	L3011
2299  0618               L127:
2300                     ; 1057             delay_ms(200);
2302  0618 ae00c8        	ldw	x,#200
2303  061b cd0000        	call	_delay_ms
2305                     ; 1058             ms_send_cmd("No Response from Module", strlen((const char *)"No Response from Module"));
2307  061e 4b17          	push	#23
2308  0620 ae0014        	ldw	x,#L5011
2309  0623 cd0000        	call	_ms_send_cmd
2311  0626 84            	pop	a
2312                     ; 1059             delay_ms(200);
2314  0627 ae00c8        	ldw	x,#200
2315  062a cd0000        	call	_delay_ms
2317                     ; 1060             ModuleResponding = FALSE;
2319  062d 0f1a          	clr	(OFST+0,sp)
2321                     ; 1061             NotRespondingCounter++;
2323  062f 0c19          	inc	(OFST-1,sp)
2325                     ; 1062 						delay_ms(100);
2327  0631 ae0064        	ldw	x,#100
2328  0634 cd0000        	call	_delay_ms
2330                     ; 1063 						SIMComrestart(); //Restart the SIMCOMM 868 module
2332  0637 cd0119        	call	_SIMComrestart
2334                     ; 1064 						delay_ms(3000);
2336  063a ae0bb8        	ldw	x,#3000
2337  063d cd0000        	call	_delay_ms
2339  0640               L3011:
2340                     ; 1067         delay_ms(200);
2342  0640 ae00c8        	ldw	x,#200
2343  0643 cd0000        	call	_delay_ms
2345                     ; 1068     } while (!ModuleResponding && NotRespondingCounter < 10);
2347  0646 0d1a          	tnz	(OFST+0,sp)
2348  0648 2609          	jrne	L7011
2350  064a 7b19          	ld	a,(OFST-1,sp)
2351  064c a10a          	cp	a,#10
2352  064e 2403          	jruge	L67
2353  0650 cc04c1        	jp	L117
2354  0653               L67:
2355  0653               L7011:
2356                     ; 1070     if (NotRespondingCounter < 10)
2358  0653 7b19          	ld	a,(OFST-1,sp)
2359  0655 a10a          	cp	a,#10
2360  0657 2406          	jruge	L1111
2361                     ; 1071         IMEIRecievedOKFlag = 1;
2363  0659 35010000      	mov	_IMEIRecievedOKFlag,#1
2365  065d 2002          	jra	L3111
2366  065f               L1111:
2367                     ; 1073         IMEIRecievedOKFlag = 0;
2369  065f 3f00          	clr	_IMEIRecievedOKFlag
2370  0661               L3111:
2371                     ; 1074     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
2373  0661 4b01          	push	#1
2374  0663 ae0255        	ldw	x,#597
2375  0666 cd0000        	call	_UART1_ITConfig
2377  0669 84            	pop	a
2378                     ; 1075     UART1_ITConfig(UART1_IT_IDLE, ENABLE);
2380  066a 4b01          	push	#1
2381  066c ae0244        	ldw	x,#580
2382  066f cd0000        	call	_UART1_ITConfig
2384  0672 84            	pop	a
2385                     ; 1076 }
2388  0673 5b1a          	addw	sp,#26
2389  0675 81            	ret
2444                     	xdef	_bValidIMEIRecieved
2445                     	switch	.ubsct
2446  0000               _aunSIMNo:
2447  0000 000000000000  	ds.b	15
2448                     	xdef	_aunSIMNo
2449  000f               _aunICCID:
2450  000f 000000000000  	ds.b	25
2451                     	xdef	_aunICCID
2452                     	xref.b	_IMEIRecievedOKFlag
2453                     	xdef	_vPrintStickerInfo
2454                     	xdef	_punGet_SIM_NUmber
2455                     	xdef	_punGetSIM_ICCID
2456                     	xdef	_vHandle_MQTT
2457                     	xdef	_enGet_TCP_Status
2458                     	xdef	_vClearBuffer
2459                     	xdef	_getIMEI
2460                     	xdef	_SIMComrestart
2461                     	xref	_GSM_OK
2462                     	xdef	_SIMCom_setup
2463                     	xref	_response_buffer
2464                     	xref	_ms_send_cmd
2465                     	xref	_aunMQTT_Subscribe_Topic
2466                     	xref	_aunMQTT_ClientID
2467                     	xref	_vMevris_Send_Version
2468                     	xref	_vMevris_Send_IMEI
2469                     	xref	_punGet_Client_ID
2470                     	xref	_punGet_Command_Topic
2471                     	xref	_punGet_Event_Topic
2472                     	xref	_vMQTT_Subscribe
2473                     	xref	_vMQTT_Connect
2474  0028               _PASS_KEY:
2475  0028 000000000000  	ds.b	16
2476                     	xdef	_PASS_KEY
2477  0038               _aunIMEI:
2478  0038 000000000000  	ds.b	20
2479                     	xdef	_aunIMEI
2480                     	xref	_strstr
2481                     	xref.b	_checkit
2482                     	xref	_delay_ms
2483                     	xref	_UART1_GetFlagStatus
2484                     	xref	_UART1_SendData8
2485                     	xref	_UART1_ReceiveData8
2486                     	xref	_UART1_ITConfig
2487                     	xref	_GPIO_WriteLow
2488                     	xref	_GPIO_WriteHigh
2489                     	switch	.const
2490  0014               L5011:
2491  0014 4e6f20526573  	dc.b	"No Response from M"
2492  0026 6f64756c6500  	dc.b	"odule",0
2493  002c               L717:
2494  002c 415400        	dc.b	"AT",0
2495  002f               L715:
2496  002f 2b514d54434f  	dc.b	"+QMTCONN:",0
2497  0039               L315:
2498  0039 41542b514d54  	dc.b	"AT+QMTCONN?",0
2499  0045               L362:
2500  0045 41542b47534e  	dc.b	"AT+GSN",0
2501  004c               L312:
2502  004c 2b5143434944  	dc.b	"+QCCID:",0
2503  0054               L112:
2504  0054 41542b514343  	dc.b	"AT+QCCID",0
2505  005d               L711:
2506  005d 2b434e554d3a  	dc.b	"+CNUM:",0
2507  0064               L511:
2508  0064 41542b434e55  	dc.b	"AT+CNUM",0
2509  006c               L56:
2510  006c 41542b51504f  	dc.b	"AT+QPOWD=1",0
2511  0077               L35:
2512  0077 41542b514750  	dc.b	"AT+QGPSCFG=",34
2513  0083 6175746f6770  	dc.b	"autogps",34
2514  008b 2c3100        	dc.b	",1",0
2515  008e               L15:
2516  008e 41542b514750  	dc.b	"AT+QGPSCFG=",34
2517  009a 676e7373636f  	dc.b	"gnssconfig",34
2518  00a5 2c3000        	dc.b	",0",0
2519  00a8               L74:
2520  00a8 41542b514750  	dc.b	"AT+QGPSCFG=",34
2521  00b4 6e6d65617372  	dc.b	"nmeasrc",34
2522  00bc 2c3000        	dc.b	",0",0
2523  00bf               L54:
2524  00bf 41542b514750  	dc.b	"AT+QGPSCFG=",34
2525  00cb 6f7574706f72  	dc.b	"outport",34
2526  00d3 2c22          	dc.b	",",34
2527  00d5 6e6f6e652200  	dc.b	"none",34,0
2528  00db               L34:
2529  00db 41542b434741  	dc.b	"AT+CGACT=1,1",0
2530  00e8               L14:
2531  00e8 41542b434744  	dc.b	"AT+CGDCONT=1,",34
2532  00f6 495022        	dc.b	"IP",34
2533  00f9 2c22          	dc.b	",",34
2534  00fb 5a4f4e475741  	dc.b	"ZONGWAP",34,0
2535  0104               L73:
2536  0104 41542b514346  	dc.b	"AT+QCFG=",34
2537  010d 6e777363616e  	dc.b	"nwscanmode",34
2538  0118 2c302c3100    	dc.b	",0,1",0
2539  011d               L53:
2540  011d 41542b434741  	dc.b	"AT+CGATT=1",0
2541  0128               L33:
2542  0128 41542b514346  	dc.b	"AT+QCFG=",34
2543  0131 7572632f7269  	dc.b	"urc/ri/smsincoming"
2544  0143 222c2270756c  	dc.b	34,44,34,112,117,108
2545  0149 736522        	dc.b	"se",34
2546  014c 2c3132302c31  	dc.b	",120,1",0
2547  0153               L13:
2548  0153 41542b514346  	dc.b	"AT+QCFG=",34
2549  015c 7572632f7269  	dc.b	"urc/ri/ring",34
2550  0168 2c22          	dc.b	",",34
2551  016a 6f66662200    	dc.b	"off",34,0
2552  016f               L72:
2553  016f 41542b514346  	dc.b	"AT+QCFG=",34
2554  0178 7572632f7269  	dc.b	"urc/ri/other",34
2555  0185 2c22          	dc.b	",",34
2556  0187 6f66662200    	dc.b	"off",34,0
2557  018c               L52:
2558  018c 41542b515343  	dc.b	"AT+QSCLK=0",0
2559  0197               L32:
2560  0197 41542b434d47  	dc.b	"AT+CMGD=1,4",0
2561  01a3               L12:
2562  01a3 4154453000    	dc.b	"ATE0",0
2563                     	xref.b	c_x
2583                     	xref	c_xymvx
2584                     	end
