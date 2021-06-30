   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  14                     	bsct
  15  0000               L3_buffer:
  16  0000 00            	dc.b	0
  17  0001 00            	dc.b	0
  18  0002 00            	dc.b	0
  19  0003 00            	dc.b	0
  20  0004 00            	dc.b	0
  80                     ; 107 uint8_t *punEncodeLength (uint32_t ulLength)
  80                     ; 108 {
  82                     	switch	.text
  83  0000               _punEncodeLength:
  85  0000 88            	push	a
  86       00000001      OFST:	set	1
  89                     ; 110     uint8_t i = 0;
  91  0001 0f01          	clr	(OFST+0,sp)
  93  0003               L14:
  94                     ; 113         buffer[i] = (ulLength % 0x80);
  96  0003 7b01          	ld	a,(OFST+0,sp)
  97  0005 5f            	clrw	x
  98  0006 97            	ld	xl,a
  99  0007 7b07          	ld	a,(OFST+6,sp)
 100  0009 a47f          	and	a,#127
 101  000b e700          	ld	(L3_buffer,x),a
 102                     ; 114         ulLength = ulLength / 0x80;
 104  000d 96            	ldw	x,sp
 105  000e 1c0004        	addw	x,#OFST+3
 106  0011 a607          	ld	a,#7
 107  0013 cd0000        	call	c_lgursh
 109                     ; 116         if (ulLength > 0)
 111  0016 96            	ldw	x,sp
 112  0017 1c0004        	addw	x,#OFST+3
 113  001a cd0000        	call	c_lzmp
 115  001d 270a          	jreq	L74
 116                     ; 118 	        buffer[i] |= 0x80;
 118  001f 7b01          	ld	a,(OFST+0,sp)
 119  0021 5f            	clrw	x
 120  0022 97            	ld	xl,a
 121  0023 e600          	ld	a,(L3_buffer,x)
 122  0025 aa80          	or	a,#128
 123  0027 e700          	ld	(L3_buffer,x),a
 124  0029               L74:
 125                     ; 120         i++;
 127  0029 0c01          	inc	(OFST+0,sp)
 129                     ; 121     }  while (ulLength > 0 && i < 4);
 131  002b 96            	ldw	x,sp
 132  002c 1c0004        	addw	x,#OFST+3
 133  002f cd0000        	call	c_lzmp
 135  0032 2706          	jreq	L15
 137  0034 7b01          	ld	a,(OFST+0,sp)
 138  0036 a104          	cp	a,#4
 139  0038 25c9          	jrult	L14
 140  003a               L15:
 141                     ; 122     buffer[i] = '\0';
 143  003a 7b01          	ld	a,(OFST+0,sp)
 144  003c 5f            	clrw	x
 145  003d 97            	ld	xl,a
 146  003e 6f00          	clr	(L3_buffer,x)
 147                     ; 124     return buffer;
 149  0040 ae0000        	ldw	x,#L3_buffer
 152  0043 84            	pop	a
 153  0044 81            	ret
 248                     ; 131 uint32_t ulMQTT_Connect ( uint8_t *punBuffer, uint8_t *punClientIdentifier/*,
 248                     ; 132 						bool bUserNameFlag, bool bPasswordFlag,
 248                     ; 133 						bool bWillFlag, bool bWillRetainFlag,
 248                     ; 134 						bool bCleanSessionFlag, enMQTT_QOS eWill_QOS,
 248                     ; 135 						uint8_t *punWillTopic, uint8_t *punWillMessage,
 248                     ; 136 						uint8_t *punUsername, uint8_t *punPassword*/	)
 248                     ; 137 {
 249                     	switch	.text
 250  0045               _ulMQTT_Connect:
 252  0045 89            	pushw	x
 253  0046 5210          	subw	sp,#16
 254       00000010      OFST:	set	16
 257                     ; 138 	uint32_t ulTotalPacketLength	= 0;
 259  0048 ae0000        	ldw	x,#0
 260  004b 1f0e          	ldw	(OFST-2,sp),x
 261  004d ae0000        	ldw	x,#0
 262  0050 1f0c          	ldw	(OFST-4,sp),x
 264                     ; 139 	uint32_t ulRemainingLength	= 0;
 266  0052 ae0000        	ldw	x,#0
 267  0055 1f07          	ldw	(OFST-9,sp),x
 268  0057 ae0000        	ldw	x,#0
 269  005a 1f05          	ldw	(OFST-11,sp),x
 271                     ; 140 	uint8_t i = 0, j = 0, *ptr;
 275                     ; 144 	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_CONNECT & 0xF) << 4 ) & 0xF0) | (((uint8_t)eCTRL_PKT_FLAG_CONNECT & 0xF) & 0x0F);
 277  005c 1e11          	ldw	x,(OFST+1,sp)
 278  005e cd0000        	call	c_uitolx
 280  0061 96            	ldw	x,sp
 281  0062 1c0001        	addw	x,#OFST-15
 282  0065 cd0000        	call	c_rtol
 285  0068 96            	ldw	x,sp
 286  0069 1c000c        	addw	x,#OFST-4
 287  006c cd0000        	call	c_ltor
 289  006f 96            	ldw	x,sp
 290  0070 1c000c        	addw	x,#OFST-4
 291  0073 a601          	ld	a,#1
 292  0075 cd0000        	call	c_lgadc
 295  0078 96            	ldw	x,sp
 296  0079 1c0001        	addw	x,#OFST-15
 297  007c cd0000        	call	c_ladd
 299  007f be02          	ldw	x,c_lreg+2
 300  0081 a610          	ld	a,#16
 301  0083 f7            	ld	(x),a
 302                     ; 147 	ulRemainingLength	+=	2 + strlen( ( const char* )PROTOCOL_NAME);	//Variable Header:  Protocol Name [2 bytes of length and 4 Bytes of Name i.e. "MQTT"]
 304  0084 96            	ldw	x,sp
 305  0085 1c0005        	addw	x,#OFST-11
 306  0088 a606          	ld	a,#6
 307  008a cd0000        	call	c_lgadc
 310                     ; 148 	ulRemainingLength	+=	1;	//Variable Header:	Protocol Level Byte i.e. 0x04 fixed
 312  008d 96            	ldw	x,sp
 313  008e 1c0005        	addw	x,#OFST-11
 314  0091 a601          	ld	a,#1
 315  0093 cd0000        	call	c_lgadc
 318                     ; 149 	ulRemainingLength	+=	1;	//Variable Header:	Connect Flags
 320  0096 96            	ldw	x,sp
 321  0097 1c0005        	addw	x,#OFST-11
 322  009a a601          	ld	a,#1
 323  009c cd0000        	call	c_lgadc
 326                     ; 150 	ulRemainingLength	+=	2;	//Variable Header:	Keep Alive Time (s) Bytes i.e. 2 Bytes
 328  009f 96            	ldw	x,sp
 329  00a0 1c0005        	addw	x,#OFST-11
 330  00a3 a602          	ld	a,#2
 331  00a5 cd0000        	call	c_lgadc
 334                     ; 151 	ulRemainingLength	+=	2 + strlen( ( const char* )punClientIdentifier);	//Payload: Client Identifier + 2 Byte  for Client Identifier length itself
 336  00a8 1e15          	ldw	x,(OFST+5,sp)
 337  00aa cd0000        	call	_strlen
 339  00ad 5c            	incw	x
 340  00ae 5c            	incw	x
 341  00af cd0000        	call	c_uitolx
 343  00b2 96            	ldw	x,sp
 344  00b3 1c0005        	addw	x,#OFST-11
 345  00b6 cd0000        	call	c_lgadd
 348                     ; 168 	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
 350  00b9 1e07          	ldw	x,(OFST-9,sp)
 351  00bb 89            	pushw	x
 352  00bc 1e07          	ldw	x,(OFST-9,sp)
 353  00be 89            	pushw	x
 354  00bf cd0000        	call	_punEncodeLength
 356  00c2 5b04          	addw	sp,#4
 357  00c4 1f09          	ldw	(OFST-7,sp),x
 359                     ; 169 	i = strlen( ( const char* )ptr);
 361  00c6 1e09          	ldw	x,(OFST-7,sp)
 362  00c8 cd0000        	call	_strlen
 364  00cb 01            	rrwa	x,a
 365  00cc 6b0b          	ld	(OFST-5,sp),a
 366  00ce 02            	rlwa	x,a
 368                     ; 170 	for ( j = 0; j < i; j++)
 370  00cf 0f10          	clr	(OFST+0,sp)
 373  00d1 2033          	jra	L521
 374  00d3               L121:
 375                     ; 172 		punBuffer[ulTotalPacketLength++] = *(ptr + j);
 377  00d3 1e11          	ldw	x,(OFST+1,sp)
 378  00d5 cd0000        	call	c_uitolx
 380  00d8 96            	ldw	x,sp
 381  00d9 1c0001        	addw	x,#OFST-15
 382  00dc cd0000        	call	c_rtol
 385  00df 96            	ldw	x,sp
 386  00e0 1c000c        	addw	x,#OFST-4
 387  00e3 cd0000        	call	c_ltor
 389  00e6 96            	ldw	x,sp
 390  00e7 1c000c        	addw	x,#OFST-4
 391  00ea a601          	ld	a,#1
 392  00ec cd0000        	call	c_lgadc
 395  00ef 96            	ldw	x,sp
 396  00f0 1c0001        	addw	x,#OFST-15
 397  00f3 cd0000        	call	c_ladd
 399  00f6 be02          	ldw	x,c_lreg+2
 400  00f8 7b10          	ld	a,(OFST+0,sp)
 401  00fa 905f          	clrw	y
 402  00fc 9097          	ld	yl,a
 403  00fe 72f909        	addw	y,(OFST-7,sp)
 404  0101 90f6          	ld	a,(y)
 405  0103 f7            	ld	(x),a
 406                     ; 170 	for ( j = 0; j < i; j++)
 408  0104 0c10          	inc	(OFST+0,sp)
 410  0106               L521:
 413  0106 7b10          	ld	a,(OFST+0,sp)
 414  0108 110b          	cp	a,(OFST-5,sp)
 415  010a 25c7          	jrult	L121
 416                     ; 175     i = strlen( ( const char* )PROTOCOL_NAME);
 418  010c a604          	ld	a,#4
 419  010e 6b0b          	ld	(OFST-5,sp),a
 421                     ; 176 	punBuffer[ulTotalPacketLength++] = (i >> 8) & 0xFF;	//Variable Header:  Protocol Name Length Most Significant Byte
 423  0110 1e11          	ldw	x,(OFST+1,sp)
 424  0112 cd0000        	call	c_uitolx
 426  0115 96            	ldw	x,sp
 427  0116 1c0001        	addw	x,#OFST-15
 428  0119 cd0000        	call	c_rtol
 431  011c 96            	ldw	x,sp
 432  011d 1c000c        	addw	x,#OFST-4
 433  0120 cd0000        	call	c_ltor
 435  0123 96            	ldw	x,sp
 436  0124 1c000c        	addw	x,#OFST-4
 437  0127 a601          	ld	a,#1
 438  0129 cd0000        	call	c_lgadc
 441  012c 96            	ldw	x,sp
 442  012d 1c0001        	addw	x,#OFST-15
 443  0130 cd0000        	call	c_ladd
 445  0133 be02          	ldw	x,c_lreg+2
 446  0135 7f            	clr	(x)
 447                     ; 177 	punBuffer[ulTotalPacketLength++] = (i >> 0) & 0xFF;	//Variable Header:  Protocol Name Length Least Significant Byte
 449  0136 1e11          	ldw	x,(OFST+1,sp)
 450  0138 cd0000        	call	c_uitolx
 452  013b 96            	ldw	x,sp
 453  013c 1c0001        	addw	x,#OFST-15
 454  013f cd0000        	call	c_rtol
 457  0142 96            	ldw	x,sp
 458  0143 1c000c        	addw	x,#OFST-4
 459  0146 cd0000        	call	c_ltor
 461  0149 96            	ldw	x,sp
 462  014a 1c000c        	addw	x,#OFST-4
 463  014d a601          	ld	a,#1
 464  014f cd0000        	call	c_lgadc
 467  0152 96            	ldw	x,sp
 468  0153 1c0001        	addw	x,#OFST-15
 469  0156 cd0000        	call	c_ladd
 471  0159 be02          	ldw	x,c_lreg+2
 472  015b 7b0b          	ld	a,(OFST-5,sp)
 473  015d a4ff          	and	a,#255
 474  015f f7            	ld	(x),a
 475                     ; 178 	for (j = 0; j < i; j++)
 477  0160 0f10          	clr	(OFST+0,sp)
 480  0162 2032          	jra	L531
 481  0164               L131:
 482                     ; 180         punBuffer[ulTotalPacketLength++] = (uint8_t)PROTOCOL_NAME[j];
 484  0164 1e11          	ldw	x,(OFST+1,sp)
 485  0166 cd0000        	call	c_uitolx
 487  0169 96            	ldw	x,sp
 488  016a 1c0001        	addw	x,#OFST-15
 489  016d cd0000        	call	c_rtol
 492  0170 96            	ldw	x,sp
 493  0171 1c000c        	addw	x,#OFST-4
 494  0174 cd0000        	call	c_ltor
 496  0177 96            	ldw	x,sp
 497  0178 1c000c        	addw	x,#OFST-4
 498  017b a601          	ld	a,#1
 499  017d cd0000        	call	c_lgadc
 502  0180 96            	ldw	x,sp
 503  0181 1c0001        	addw	x,#OFST-15
 504  0184 cd0000        	call	c_ladd
 506  0187 be02          	ldw	x,c_lreg+2
 507  0189 7b10          	ld	a,(OFST+0,sp)
 508  018b 905f          	clrw	y
 509  018d 9097          	ld	yl,a
 510  018f 90d60000      	ld	a,(L141,y)
 511  0193 f7            	ld	(x),a
 512                     ; 178 	for (j = 0; j < i; j++)
 514  0194 0c10          	inc	(OFST+0,sp)
 516  0196               L531:
 519  0196 7b10          	ld	a,(OFST+0,sp)
 520  0198 110b          	cp	a,(OFST-5,sp)
 521  019a 25c8          	jrult	L131
 522                     ; 187 	punBuffer[ulTotalPacketLength++] = 0x04;	//Variable Header:  Protocol Level: which is fixed Level-4
 524  019c 1e11          	ldw	x,(OFST+1,sp)
 525  019e cd0000        	call	c_uitolx
 527  01a1 96            	ldw	x,sp
 528  01a2 1c0001        	addw	x,#OFST-15
 529  01a5 cd0000        	call	c_rtol
 532  01a8 96            	ldw	x,sp
 533  01a9 1c000c        	addw	x,#OFST-4
 534  01ac cd0000        	call	c_ltor
 536  01af 96            	ldw	x,sp
 537  01b0 1c000c        	addw	x,#OFST-4
 538  01b3 a601          	ld	a,#1
 539  01b5 cd0000        	call	c_lgadc
 542  01b8 96            	ldw	x,sp
 543  01b9 1c0001        	addw	x,#OFST-15
 544  01bc cd0000        	call	c_ladd
 546  01bf be02          	ldw	x,c_lreg+2
 547  01c1 a604          	ld	a,#4
 548  01c3 f7            	ld	(x),a
 549                     ; 199 	punBuffer[ulTotalPacketLength++] = 0x02;
 551  01c4 1e11          	ldw	x,(OFST+1,sp)
 552  01c6 cd0000        	call	c_uitolx
 554  01c9 96            	ldw	x,sp
 555  01ca 1c0001        	addw	x,#OFST-15
 556  01cd cd0000        	call	c_rtol
 559  01d0 96            	ldw	x,sp
 560  01d1 1c000c        	addw	x,#OFST-4
 561  01d4 cd0000        	call	c_ltor
 563  01d7 96            	ldw	x,sp
 564  01d8 1c000c        	addw	x,#OFST-4
 565  01db a601          	ld	a,#1
 566  01dd cd0000        	call	c_lgadc
 569  01e0 96            	ldw	x,sp
 570  01e1 1c0001        	addw	x,#OFST-15
 571  01e4 cd0000        	call	c_ladd
 573  01e7 be02          	ldw	x,c_lreg+2
 574  01e9 a602          	ld	a,#2
 575  01eb f7            	ld	(x),a
 576                     ; 200 	punBuffer[ulTotalPacketLength++] = ((uint16_t)KEEP_ALIVE_TIMEOUT	>> 8)	&	0xFF;	////Variable Header:  Keep Alive Most Significant Byte
 578  01ec 1e11          	ldw	x,(OFST+1,sp)
 579  01ee cd0000        	call	c_uitolx
 581  01f1 96            	ldw	x,sp
 582  01f2 1c0001        	addw	x,#OFST-15
 583  01f5 cd0000        	call	c_rtol
 586  01f8 96            	ldw	x,sp
 587  01f9 1c000c        	addw	x,#OFST-4
 588  01fc cd0000        	call	c_ltor
 590  01ff 96            	ldw	x,sp
 591  0200 1c000c        	addw	x,#OFST-4
 592  0203 a601          	ld	a,#1
 593  0205 cd0000        	call	c_lgadc
 596  0208 96            	ldw	x,sp
 597  0209 1c0001        	addw	x,#OFST-15
 598  020c cd0000        	call	c_ladd
 600  020f be02          	ldw	x,c_lreg+2
 601  0211 7f            	clr	(x)
 602                     ; 201 	punBuffer[ulTotalPacketLength++] = ((uint16_t)KEEP_ALIVE_TIMEOUT	>> 0)	&	0xFF;	////Variable Header:  Keep Alive Least Significant Byte
 604  0212 1e11          	ldw	x,(OFST+1,sp)
 605  0214 cd0000        	call	c_uitolx
 607  0217 96            	ldw	x,sp
 608  0218 1c0001        	addw	x,#OFST-15
 609  021b cd0000        	call	c_rtol
 612  021e 96            	ldw	x,sp
 613  021f 1c000c        	addw	x,#OFST-4
 614  0222 cd0000        	call	c_ltor
 616  0225 96            	ldw	x,sp
 617  0226 1c000c        	addw	x,#OFST-4
 618  0229 a601          	ld	a,#1
 619  022b cd0000        	call	c_lgadc
 622  022e 96            	ldw	x,sp
 623  022f 1c0001        	addw	x,#OFST-15
 624  0232 cd0000        	call	c_ladd
 626  0235 be02          	ldw	x,c_lreg+2
 627  0237 a63c          	ld	a,#60
 628  0239 f7            	ld	(x),a
 629                     ; 205 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punClientIdentifier));
 631  023a 1e15          	ldw	x,(OFST+5,sp)
 632  023c cd0000        	call	_strlen
 634  023f cd0000        	call	c_uitolx
 636  0242 be02          	ldw	x,c_lreg+2
 637  0244 89            	pushw	x
 638  0245 be00          	ldw	x,c_lreg
 639  0247 89            	pushw	x
 640  0248 cd0000        	call	_punEncodeLength
 642  024b 5b04          	addw	sp,#4
 643  024d 1f09          	ldw	(OFST-7,sp),x
 645                     ; 206 	i = strlen( ( const char* )ptr);
 647  024f 1e09          	ldw	x,(OFST-7,sp)
 648  0251 cd0000        	call	_strlen
 650  0254 01            	rrwa	x,a
 651  0255 6b0b          	ld	(OFST-5,sp),a
 652  0257 02            	rlwa	x,a
 654                     ; 207 	if(i < 2)
 656  0258 7b0b          	ld	a,(OFST-5,sp)
 657  025a a102          	cp	a,#2
 658  025c 2452          	jruge	L341
 659                     ; 209 		punBuffer[ulTotalPacketLength++] = 0;
 661  025e 1e11          	ldw	x,(OFST+1,sp)
 662  0260 cd0000        	call	c_uitolx
 664  0263 96            	ldw	x,sp
 665  0264 1c0001        	addw	x,#OFST-15
 666  0267 cd0000        	call	c_rtol
 669  026a 96            	ldw	x,sp
 670  026b 1c000c        	addw	x,#OFST-4
 671  026e cd0000        	call	c_ltor
 673  0271 96            	ldw	x,sp
 674  0272 1c000c        	addw	x,#OFST-4
 675  0275 a601          	ld	a,#1
 676  0277 cd0000        	call	c_lgadc
 679  027a 96            	ldw	x,sp
 680  027b 1c0001        	addw	x,#OFST-15
 681  027e cd0000        	call	c_ladd
 683  0281 be02          	ldw	x,c_lreg+2
 684  0283 7f            	clr	(x)
 685                     ; 210 		punBuffer[ulTotalPacketLength++] = *(ptr);
 687  0284 1e11          	ldw	x,(OFST+1,sp)
 688  0286 cd0000        	call	c_uitolx
 690  0289 96            	ldw	x,sp
 691  028a 1c0001        	addw	x,#OFST-15
 692  028d cd0000        	call	c_rtol
 695  0290 96            	ldw	x,sp
 696  0291 1c000c        	addw	x,#OFST-4
 697  0294 cd0000        	call	c_ltor
 699  0297 96            	ldw	x,sp
 700  0298 1c000c        	addw	x,#OFST-4
 701  029b a601          	ld	a,#1
 702  029d cd0000        	call	c_lgadc
 705  02a0 96            	ldw	x,sp
 706  02a1 1c0001        	addw	x,#OFST-15
 707  02a4 cd0000        	call	c_ladd
 709  02a7 be02          	ldw	x,c_lreg+2
 710  02a9 1609          	ldw	y,(OFST-7,sp)
 711  02ab 90f6          	ld	a,(y)
 712  02ad f7            	ld	(x),a
 714  02ae 2055          	jra	L541
 715  02b0               L341:
 716                     ; 214 		punBuffer[ulTotalPacketLength++] = *(ptr);
 718  02b0 1e11          	ldw	x,(OFST+1,sp)
 719  02b2 cd0000        	call	c_uitolx
 721  02b5 96            	ldw	x,sp
 722  02b6 1c0001        	addw	x,#OFST-15
 723  02b9 cd0000        	call	c_rtol
 726  02bc 96            	ldw	x,sp
 727  02bd 1c000c        	addw	x,#OFST-4
 728  02c0 cd0000        	call	c_ltor
 730  02c3 96            	ldw	x,sp
 731  02c4 1c000c        	addw	x,#OFST-4
 732  02c7 a601          	ld	a,#1
 733  02c9 cd0000        	call	c_lgadc
 736  02cc 96            	ldw	x,sp
 737  02cd 1c0001        	addw	x,#OFST-15
 738  02d0 cd0000        	call	c_ladd
 740  02d3 be02          	ldw	x,c_lreg+2
 741  02d5 1609          	ldw	y,(OFST-7,sp)
 742  02d7 90f6          	ld	a,(y)
 743  02d9 f7            	ld	(x),a
 744                     ; 215 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
 746  02da 1e11          	ldw	x,(OFST+1,sp)
 747  02dc cd0000        	call	c_uitolx
 749  02df 96            	ldw	x,sp
 750  02e0 1c0001        	addw	x,#OFST-15
 751  02e3 cd0000        	call	c_rtol
 754  02e6 96            	ldw	x,sp
 755  02e7 1c000c        	addw	x,#OFST-4
 756  02ea cd0000        	call	c_ltor
 758  02ed 96            	ldw	x,sp
 759  02ee 1c000c        	addw	x,#OFST-4
 760  02f1 a601          	ld	a,#1
 761  02f3 cd0000        	call	c_lgadc
 764  02f6 96            	ldw	x,sp
 765  02f7 1c0001        	addw	x,#OFST-15
 766  02fa cd0000        	call	c_ladd
 768  02fd be02          	ldw	x,c_lreg+2
 769  02ff 1609          	ldw	y,(OFST-7,sp)
 770  0301 90e601        	ld	a,(1,y)
 771  0304 f7            	ld	(x),a
 772  0305               L541:
 773                     ; 217 	i = strlen( ( const char* )punClientIdentifier);
 775  0305 1e15          	ldw	x,(OFST+5,sp)
 776  0307 cd0000        	call	_strlen
 778  030a 01            	rrwa	x,a
 779  030b 6b0b          	ld	(OFST-5,sp),a
 780  030d 02            	rlwa	x,a
 782                     ; 218 	for ( j = 0; j < i; j++)
 784  030e 0f10          	clr	(OFST+0,sp)
 787  0310 2033          	jra	L351
 788  0312               L741:
 789                     ; 220 		punBuffer[ulTotalPacketLength++] = punClientIdentifier[j];
 791  0312 1e11          	ldw	x,(OFST+1,sp)
 792  0314 cd0000        	call	c_uitolx
 794  0317 96            	ldw	x,sp
 795  0318 1c0001        	addw	x,#OFST-15
 796  031b cd0000        	call	c_rtol
 799  031e 96            	ldw	x,sp
 800  031f 1c000c        	addw	x,#OFST-4
 801  0322 cd0000        	call	c_ltor
 803  0325 96            	ldw	x,sp
 804  0326 1c000c        	addw	x,#OFST-4
 805  0329 a601          	ld	a,#1
 806  032b cd0000        	call	c_lgadc
 809  032e 96            	ldw	x,sp
 810  032f 1c0001        	addw	x,#OFST-15
 811  0332 cd0000        	call	c_ladd
 813  0335 be02          	ldw	x,c_lreg+2
 814  0337 7b10          	ld	a,(OFST+0,sp)
 815  0339 905f          	clrw	y
 816  033b 9097          	ld	yl,a
 817  033d 72f915        	addw	y,(OFST+5,sp)
 818  0340 90f6          	ld	a,(y)
 819  0342 f7            	ld	(x),a
 820                     ; 218 	for ( j = 0; j < i; j++)
 822  0343 0c10          	inc	(OFST+0,sp)
 824  0345               L351:
 827  0345 7b10          	ld	a,(OFST+0,sp)
 828  0347 110b          	cp	a,(OFST-5,sp)
 829  0349 25c7          	jrult	L741
 830                     ; 298 	punBuffer[ulTotalPacketLength]	=	'\0';
 832  034b 1e11          	ldw	x,(OFST+1,sp)
 833  034d 72fb0e        	addw	x,(OFST-2,sp)
 834  0350 7f            	clr	(x)
 835                     ; 300 	return ulTotalPacketLength;
 837  0351 96            	ldw	x,sp
 838  0352 1c000c        	addw	x,#OFST-4
 839  0355 cd0000        	call	c_ltor
 843  0358 5b12          	addw	sp,#18
 844  035a 81            	ret
1149                     ; 303 uint32_t ulMQTT_Publish ( uint8_t *punBuffer, uint8_t *punTopic, uint8_t *punMessage/*, enMQTT_CTRL_PKT_FLAGS ePublishFlags*/ )
1149                     ; 304 {
1150                     	switch	.text
1151  035b               _ulMQTT_Publish:
1153  035b 89            	pushw	x
1154  035c 5210          	subw	sp,#16
1155       00000010      OFST:	set	16
1158                     ; 305 	uint32_t ulTotalPacketLength	= 0;
1160  035e ae0000        	ldw	x,#0
1161  0361 1f0d          	ldw	(OFST-3,sp),x
1162  0363 ae0000        	ldw	x,#0
1163  0366 1f0b          	ldw	(OFST-5,sp),x
1165                     ; 306 	uint32_t ulRemainingLength		= 0;
1167  0368 ae0000        	ldw	x,#0
1168  036b 1f07          	ldw	(OFST-9,sp),x
1169  036d ae0000        	ldw	x,#0
1170  0370 1f05          	ldw	(OFST-11,sp),x
1172                     ; 307 	uint8_t i = 0, j = 0, *ptr;
1176                     ; 309 	enum MQTT_CTRL_PKT_FLAGS_ENUM ePublishFlags = eCTRL_PKT_FLAG_PUBLISH_D0_0_R0;
1178  0372 0f0f          	clr	(OFST-1,sp)
1180                     ; 313 	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_PUBLISH & 0xF) << 4 ) & 0xF0) | (( (uint8_t)ePublishFlags & 0x0F) );
1182  0374 1e11          	ldw	x,(OFST+1,sp)
1183  0376 cd0000        	call	c_uitolx
1185  0379 96            	ldw	x,sp
1186  037a 1c0001        	addw	x,#OFST-15
1187  037d cd0000        	call	c_rtol
1190  0380 96            	ldw	x,sp
1191  0381 1c000b        	addw	x,#OFST-5
1192  0384 cd0000        	call	c_ltor
1194  0387 96            	ldw	x,sp
1195  0388 1c000b        	addw	x,#OFST-5
1196  038b a601          	ld	a,#1
1197  038d cd0000        	call	c_lgadc
1200  0390 96            	ldw	x,sp
1201  0391 1c0001        	addw	x,#OFST-15
1202  0394 cd0000        	call	c_ladd
1204  0397 be02          	ldw	x,c_lreg+2
1205  0399 a630          	ld	a,#48
1206  039b f7            	ld	(x),a
1207                     ; 316 	ulRemainingLength	+=	2;	//Variable Header: Topic Name Length size in 2 Bytes
1209  039c 96            	ldw	x,sp
1210  039d 1c0005        	addw	x,#OFST-11
1211  03a0 a602          	ld	a,#2
1212  03a2 cd0000        	call	c_lgadc
1215                     ; 317 	ulRemainingLength	+=	strlen( ( const char* )punTopic);	//Variable Header: Topic Name
1217  03a5 1e15          	ldw	x,(OFST+5,sp)
1218  03a7 cd0000        	call	_strlen
1220  03aa cd0000        	call	c_uitolx
1222  03ad 96            	ldw	x,sp
1223  03ae 1c0005        	addw	x,#OFST-11
1224  03b1 cd0000        	call	c_lgadd
1227                     ; 318 	if( (ePublishFlags & 0x06) != 0 )	// Check if QOS-1 or QOS-2 is selected
1229  03b4 7b0f          	ld	a,(OFST-1,sp)
1230  03b6 a506          	bcp	a,#6
1231  03b8 2709          	jreq	L713
1232                     ; 320 		ulRemainingLength	+=	2;	//Variable Header: Packet Identifier Length which is 2 Bytes
1234  03ba 96            	ldw	x,sp
1235  03bb 1c0005        	addw	x,#OFST-11
1236  03be a602          	ld	a,#2
1237  03c0 cd0000        	call	c_lgadc
1240  03c3               L713:
1241                     ; 322 	ulRemainingLength	+=	strlen( ( const char* )punMessage);	//Payload: Message Length in Bytes
1243  03c3 1e17          	ldw	x,(OFST+7,sp)
1244  03c5 cd0000        	call	_strlen
1246  03c8 cd0000        	call	c_uitolx
1248  03cb 96            	ldw	x,sp
1249  03cc 1c0005        	addw	x,#OFST-11
1250  03cf cd0000        	call	c_lgadd
1253                     ; 325 	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
1255  03d2 1e07          	ldw	x,(OFST-9,sp)
1256  03d4 89            	pushw	x
1257  03d5 1e07          	ldw	x,(OFST-9,sp)
1258  03d7 89            	pushw	x
1259  03d8 cd0000        	call	_punEncodeLength
1261  03db 5b04          	addw	sp,#4
1262  03dd 1f09          	ldw	(OFST-7,sp),x
1264                     ; 326 	i = strlen( ( const char* )ptr);
1266  03df 1e09          	ldw	x,(OFST-7,sp)
1267  03e1 cd0000        	call	_strlen
1269  03e4 01            	rrwa	x,a
1270  03e5 6b0f          	ld	(OFST-1,sp),a
1271  03e7 02            	rlwa	x,a
1273                     ; 327 	for ( j = 0; j < i; j++)
1275  03e8 0f10          	clr	(OFST+0,sp)
1278  03ea 2033          	jra	L523
1279  03ec               L123:
1280                     ; 329 		punBuffer[ulTotalPacketLength++] = *(ptr + j);
1282  03ec 1e11          	ldw	x,(OFST+1,sp)
1283  03ee cd0000        	call	c_uitolx
1285  03f1 96            	ldw	x,sp
1286  03f2 1c0001        	addw	x,#OFST-15
1287  03f5 cd0000        	call	c_rtol
1290  03f8 96            	ldw	x,sp
1291  03f9 1c000b        	addw	x,#OFST-5
1292  03fc cd0000        	call	c_ltor
1294  03ff 96            	ldw	x,sp
1295  0400 1c000b        	addw	x,#OFST-5
1296  0403 a601          	ld	a,#1
1297  0405 cd0000        	call	c_lgadc
1300  0408 96            	ldw	x,sp
1301  0409 1c0001        	addw	x,#OFST-15
1302  040c cd0000        	call	c_ladd
1304  040f be02          	ldw	x,c_lreg+2
1305  0411 7b10          	ld	a,(OFST+0,sp)
1306  0413 905f          	clrw	y
1307  0415 9097          	ld	yl,a
1308  0417 72f909        	addw	y,(OFST-7,sp)
1309  041a 90f6          	ld	a,(y)
1310  041c f7            	ld	(x),a
1311                     ; 327 	for ( j = 0; j < i; j++)
1313  041d 0c10          	inc	(OFST+0,sp)
1315  041f               L523:
1318  041f 7b10          	ld	a,(OFST+0,sp)
1319  0421 110f          	cp	a,(OFST-1,sp)
1320  0423 25c7          	jrult	L123
1321                     ; 332 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
1323  0425 1e15          	ldw	x,(OFST+5,sp)
1324  0427 cd0000        	call	_strlen
1326  042a cd0000        	call	c_uitolx
1328  042d be02          	ldw	x,c_lreg+2
1329  042f 89            	pushw	x
1330  0430 be00          	ldw	x,c_lreg
1331  0432 89            	pushw	x
1332  0433 cd0000        	call	_punEncodeLength
1334  0436 5b04          	addw	sp,#4
1335  0438 1f09          	ldw	(OFST-7,sp),x
1337                     ; 333 	i = strlen( ( const char* )ptr);
1339  043a 1e09          	ldw	x,(OFST-7,sp)
1340  043c cd0000        	call	_strlen
1342  043f 01            	rrwa	x,a
1343  0440 6b0f          	ld	(OFST-1,sp),a
1344  0442 02            	rlwa	x,a
1346                     ; 334 	if(i < 2)
1348  0443 7b0f          	ld	a,(OFST-1,sp)
1349  0445 a102          	cp	a,#2
1350  0447 2452          	jruge	L133
1351                     ; 336 		punBuffer[ulTotalPacketLength++] = 0;
1353  0449 1e11          	ldw	x,(OFST+1,sp)
1354  044b cd0000        	call	c_uitolx
1356  044e 96            	ldw	x,sp
1357  044f 1c0001        	addw	x,#OFST-15
1358  0452 cd0000        	call	c_rtol
1361  0455 96            	ldw	x,sp
1362  0456 1c000b        	addw	x,#OFST-5
1363  0459 cd0000        	call	c_ltor
1365  045c 96            	ldw	x,sp
1366  045d 1c000b        	addw	x,#OFST-5
1367  0460 a601          	ld	a,#1
1368  0462 cd0000        	call	c_lgadc
1371  0465 96            	ldw	x,sp
1372  0466 1c0001        	addw	x,#OFST-15
1373  0469 cd0000        	call	c_ladd
1375  046c be02          	ldw	x,c_lreg+2
1376  046e 7f            	clr	(x)
1377                     ; 337 		punBuffer[ulTotalPacketLength++] = *(ptr);
1379  046f 1e11          	ldw	x,(OFST+1,sp)
1380  0471 cd0000        	call	c_uitolx
1382  0474 96            	ldw	x,sp
1383  0475 1c0001        	addw	x,#OFST-15
1384  0478 cd0000        	call	c_rtol
1387  047b 96            	ldw	x,sp
1388  047c 1c000b        	addw	x,#OFST-5
1389  047f cd0000        	call	c_ltor
1391  0482 96            	ldw	x,sp
1392  0483 1c000b        	addw	x,#OFST-5
1393  0486 a601          	ld	a,#1
1394  0488 cd0000        	call	c_lgadc
1397  048b 96            	ldw	x,sp
1398  048c 1c0001        	addw	x,#OFST-15
1399  048f cd0000        	call	c_ladd
1401  0492 be02          	ldw	x,c_lreg+2
1402  0494 1609          	ldw	y,(OFST-7,sp)
1403  0496 90f6          	ld	a,(y)
1404  0498 f7            	ld	(x),a
1406  0499 2055          	jra	L333
1407  049b               L133:
1408                     ; 341 		punBuffer[ulTotalPacketLength++] = *(ptr);
1410  049b 1e11          	ldw	x,(OFST+1,sp)
1411  049d cd0000        	call	c_uitolx
1413  04a0 96            	ldw	x,sp
1414  04a1 1c0001        	addw	x,#OFST-15
1415  04a4 cd0000        	call	c_rtol
1418  04a7 96            	ldw	x,sp
1419  04a8 1c000b        	addw	x,#OFST-5
1420  04ab cd0000        	call	c_ltor
1422  04ae 96            	ldw	x,sp
1423  04af 1c000b        	addw	x,#OFST-5
1424  04b2 a601          	ld	a,#1
1425  04b4 cd0000        	call	c_lgadc
1428  04b7 96            	ldw	x,sp
1429  04b8 1c0001        	addw	x,#OFST-15
1430  04bb cd0000        	call	c_ladd
1432  04be be02          	ldw	x,c_lreg+2
1433  04c0 1609          	ldw	y,(OFST-7,sp)
1434  04c2 90f6          	ld	a,(y)
1435  04c4 f7            	ld	(x),a
1436                     ; 342 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
1438  04c5 1e11          	ldw	x,(OFST+1,sp)
1439  04c7 cd0000        	call	c_uitolx
1441  04ca 96            	ldw	x,sp
1442  04cb 1c0001        	addw	x,#OFST-15
1443  04ce cd0000        	call	c_rtol
1446  04d1 96            	ldw	x,sp
1447  04d2 1c000b        	addw	x,#OFST-5
1448  04d5 cd0000        	call	c_ltor
1450  04d8 96            	ldw	x,sp
1451  04d9 1c000b        	addw	x,#OFST-5
1452  04dc a601          	ld	a,#1
1453  04de cd0000        	call	c_lgadc
1456  04e1 96            	ldw	x,sp
1457  04e2 1c0001        	addw	x,#OFST-15
1458  04e5 cd0000        	call	c_ladd
1460  04e8 be02          	ldw	x,c_lreg+2
1461  04ea 1609          	ldw	y,(OFST-7,sp)
1462  04ec 90e601        	ld	a,(1,y)
1463  04ef f7            	ld	(x),a
1464  04f0               L333:
1465                     ; 344 	i = strlen( ( const char* )punTopic);
1467  04f0 1e15          	ldw	x,(OFST+5,sp)
1468  04f2 cd0000        	call	_strlen
1470  04f5 01            	rrwa	x,a
1471  04f6 6b0f          	ld	(OFST-1,sp),a
1472  04f8 02            	rlwa	x,a
1474                     ; 345 	for ( j = 0; j < i; j++)
1476  04f9 0f10          	clr	(OFST+0,sp)
1479  04fb 2033          	jra	L143
1480  04fd               L533:
1481                     ; 347 		punBuffer[ulTotalPacketLength++] = punTopic[j];
1483  04fd 1e11          	ldw	x,(OFST+1,sp)
1484  04ff cd0000        	call	c_uitolx
1486  0502 96            	ldw	x,sp
1487  0503 1c0001        	addw	x,#OFST-15
1488  0506 cd0000        	call	c_rtol
1491  0509 96            	ldw	x,sp
1492  050a 1c000b        	addw	x,#OFST-5
1493  050d cd0000        	call	c_ltor
1495  0510 96            	ldw	x,sp
1496  0511 1c000b        	addw	x,#OFST-5
1497  0514 a601          	ld	a,#1
1498  0516 cd0000        	call	c_lgadc
1501  0519 96            	ldw	x,sp
1502  051a 1c0001        	addw	x,#OFST-15
1503  051d cd0000        	call	c_ladd
1505  0520 be02          	ldw	x,c_lreg+2
1506  0522 7b10          	ld	a,(OFST+0,sp)
1507  0524 905f          	clrw	y
1508  0526 9097          	ld	yl,a
1509  0528 72f915        	addw	y,(OFST+5,sp)
1510  052b 90f6          	ld	a,(y)
1511  052d f7            	ld	(x),a
1512                     ; 345 	for ( j = 0; j < i; j++)
1514  052e 0c10          	inc	(OFST+0,sp)
1516  0530               L143:
1519  0530 7b10          	ld	a,(OFST+0,sp)
1520  0532 110f          	cp	a,(OFST-1,sp)
1521  0534 25c7          	jrult	L533
1522                     ; 357 	i = strlen( ( const char* )punMessage);
1524  0536 1e17          	ldw	x,(OFST+7,sp)
1525  0538 cd0000        	call	_strlen
1527  053b 01            	rrwa	x,a
1528  053c 6b0f          	ld	(OFST-1,sp),a
1529  053e 02            	rlwa	x,a
1531                     ; 358 	for ( j = 0; j < i; j++)
1533  053f 0f10          	clr	(OFST+0,sp)
1536  0541 2033          	jra	L153
1537  0543               L543:
1538                     ; 360 		punBuffer[ulTotalPacketLength++] = punMessage[j];
1540  0543 1e11          	ldw	x,(OFST+1,sp)
1541  0545 cd0000        	call	c_uitolx
1543  0548 96            	ldw	x,sp
1544  0549 1c0001        	addw	x,#OFST-15
1545  054c cd0000        	call	c_rtol
1548  054f 96            	ldw	x,sp
1549  0550 1c000b        	addw	x,#OFST-5
1550  0553 cd0000        	call	c_ltor
1552  0556 96            	ldw	x,sp
1553  0557 1c000b        	addw	x,#OFST-5
1554  055a a601          	ld	a,#1
1555  055c cd0000        	call	c_lgadc
1558  055f 96            	ldw	x,sp
1559  0560 1c0001        	addw	x,#OFST-15
1560  0563 cd0000        	call	c_ladd
1562  0566 be02          	ldw	x,c_lreg+2
1563  0568 7b10          	ld	a,(OFST+0,sp)
1564  056a 905f          	clrw	y
1565  056c 9097          	ld	yl,a
1566  056e 72f917        	addw	y,(OFST+7,sp)
1567  0571 90f6          	ld	a,(y)
1568  0573 f7            	ld	(x),a
1569                     ; 358 	for ( j = 0; j < i; j++)
1571  0574 0c10          	inc	(OFST+0,sp)
1573  0576               L153:
1576  0576 7b10          	ld	a,(OFST+0,sp)
1577  0578 110f          	cp	a,(OFST-1,sp)
1578  057a 25c7          	jrult	L543
1579                     ; 363 	punBuffer[ulTotalPacketLength]	=	'\0';
1581  057c 1e11          	ldw	x,(OFST+1,sp)
1582  057e 72fb0d        	addw	x,(OFST-3,sp)
1583  0581 7f            	clr	(x)
1584                     ; 365 	return ulTotalPacketLength;
1586  0582 96            	ldw	x,sp
1587  0583 1c000b        	addw	x,#OFST-5
1588  0586 cd0000        	call	c_ltor
1592  0589 5b12          	addw	sp,#18
1593  058b 81            	ret
1740                     ; 368 uint32_t ulMQTT_Subscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, enMQTT_QOS eQOS, uint16_t udPacketIdentifier*/ )
1740                     ; 369 {
1741                     	switch	.text
1742  058c               _ulMQTT_Subscribe:
1744  058c 89            	pushw	x
1745  058d 5213          	subw	sp,#19
1746       00000013      OFST:	set	19
1749                     ; 370 	uint32_t ulTotalPacketLength	= 0;
1751  058f ae0000        	ldw	x,#0
1752  0592 1f11          	ldw	(OFST-2,sp),x
1753  0594 ae0000        	ldw	x,#0
1754  0597 1f0f          	ldw	(OFST-4,sp),x
1756                     ; 371 	uint32_t ulRemainingLength		= 0;
1758  0599 ae0000        	ldw	x,#0
1759  059c 1f0a          	ldw	(OFST-9,sp),x
1760  059e ae0000        	ldw	x,#0
1761  05a1 1f08          	ldw	(OFST-11,sp),x
1763                     ; 372 	uint8_t i = 0, j = 0, *ptr;
1767                     ; 374 	uint16_t udPacketIdentifier = 1;
1769  05a3 ae0001        	ldw	x,#1
1770  05a6 1f06          	ldw	(OFST-13,sp),x
1772                     ; 375 	enum MQTT_QOS_ENUM eQOS = eQOS_0;
1774  05a8 0f05          	clr	(OFST-14,sp)
1776                     ; 377 	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_SUBSCRIBE & 0xF) << 4 ) & 0xF0) | (( (uint8_t)eCTRL_PKT_FLAG_SUBSCRIBE & 0x0F) );
1778  05aa 1e14          	ldw	x,(OFST+1,sp)
1779  05ac cd0000        	call	c_uitolx
1781  05af 96            	ldw	x,sp
1782  05b0 1c0001        	addw	x,#OFST-18
1783  05b3 cd0000        	call	c_rtol
1786  05b6 96            	ldw	x,sp
1787  05b7 1c000f        	addw	x,#OFST-4
1788  05ba cd0000        	call	c_ltor
1790  05bd 96            	ldw	x,sp
1791  05be 1c000f        	addw	x,#OFST-4
1792  05c1 a601          	ld	a,#1
1793  05c3 cd0000        	call	c_lgadc
1796  05c6 96            	ldw	x,sp
1797  05c7 1c0001        	addw	x,#OFST-18
1798  05ca cd0000        	call	c_ladd
1800  05cd be02          	ldw	x,c_lreg+2
1801  05cf a682          	ld	a,#130
1802  05d1 f7            	ld	(x),a
1803                     ; 380 	ulRemainingLength	+=	2;	//Variable Header: Packet Identifier of fixed 2 Bytes
1805  05d2 96            	ldw	x,sp
1806  05d3 1c0008        	addw	x,#OFST-11
1807  05d6 a602          	ld	a,#2
1808  05d8 cd0000        	call	c_lgadc
1811                     ; 381 	ulRemainingLength	+=	2;	//Payload: Topic Name Length which is 2 Bytes
1813  05db 96            	ldw	x,sp
1814  05dc 1c0008        	addw	x,#OFST-11
1815  05df a602          	ld	a,#2
1816  05e1 cd0000        	call	c_lgadc
1819                     ; 382 	ulRemainingLength	+=	strlen( ( const char* )punTopic);;	//Payload: Topic Name Length
1821  05e4 1e18          	ldw	x,(OFST+5,sp)
1822  05e6 cd0000        	call	_strlen
1824  05e9 cd0000        	call	c_uitolx
1826  05ec 96            	ldw	x,sp
1827  05ed 1c0008        	addw	x,#OFST-11
1828  05f0 cd0000        	call	c_lgadd
1831                     ; 383 	ulRemainingLength	+=	1;	//Payload: Requested QOS Byte
1834  05f3 96            	ldw	x,sp
1835  05f4 1c0008        	addw	x,#OFST-11
1836  05f7 a601          	ld	a,#1
1837  05f9 cd0000        	call	c_lgadc
1840                     ; 386 	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
1842  05fc 1e0a          	ldw	x,(OFST-9,sp)
1843  05fe 89            	pushw	x
1844  05ff 1e0a          	ldw	x,(OFST-9,sp)
1845  0601 89            	pushw	x
1846  0602 cd0000        	call	_punEncodeLength
1848  0605 5b04          	addw	sp,#4
1849  0607 1f0c          	ldw	(OFST-7,sp),x
1851                     ; 387 	i = strlen( ( const char* )ptr);
1853  0609 1e0c          	ldw	x,(OFST-7,sp)
1854  060b cd0000        	call	_strlen
1856  060e 01            	rrwa	x,a
1857  060f 6b0e          	ld	(OFST-5,sp),a
1858  0611 02            	rlwa	x,a
1860                     ; 388 	for ( j = 0; j < i; j++)
1862  0612 0f13          	clr	(OFST+0,sp)
1865  0614 2033          	jra	L354
1866  0616               L744:
1867                     ; 390 		punBuffer[ulTotalPacketLength++] = *(ptr + j);
1869  0616 1e14          	ldw	x,(OFST+1,sp)
1870  0618 cd0000        	call	c_uitolx
1872  061b 96            	ldw	x,sp
1873  061c 1c0001        	addw	x,#OFST-18
1874  061f cd0000        	call	c_rtol
1877  0622 96            	ldw	x,sp
1878  0623 1c000f        	addw	x,#OFST-4
1879  0626 cd0000        	call	c_ltor
1881  0629 96            	ldw	x,sp
1882  062a 1c000f        	addw	x,#OFST-4
1883  062d a601          	ld	a,#1
1884  062f cd0000        	call	c_lgadc
1887  0632 96            	ldw	x,sp
1888  0633 1c0001        	addw	x,#OFST-18
1889  0636 cd0000        	call	c_ladd
1891  0639 be02          	ldw	x,c_lreg+2
1892  063b 7b13          	ld	a,(OFST+0,sp)
1893  063d 905f          	clrw	y
1894  063f 9097          	ld	yl,a
1895  0641 72f90c        	addw	y,(OFST-7,sp)
1896  0644 90f6          	ld	a,(y)
1897  0646 f7            	ld	(x),a
1898                     ; 388 	for ( j = 0; j < i; j++)
1900  0647 0c13          	inc	(OFST+0,sp)
1902  0649               L354:
1905  0649 7b13          	ld	a,(OFST+0,sp)
1906  064b 110e          	cp	a,(OFST-5,sp)
1907  064d 25c7          	jrult	L744
1908                     ; 394 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	8 ) & 0xFF;	// Most Significant Byte
1910  064f 1e14          	ldw	x,(OFST+1,sp)
1911  0651 cd0000        	call	c_uitolx
1913  0654 96            	ldw	x,sp
1914  0655 1c0001        	addw	x,#OFST-18
1915  0658 cd0000        	call	c_rtol
1918  065b 96            	ldw	x,sp
1919  065c 1c000f        	addw	x,#OFST-4
1920  065f cd0000        	call	c_ltor
1922  0662 96            	ldw	x,sp
1923  0663 1c000f        	addw	x,#OFST-4
1924  0666 a601          	ld	a,#1
1925  0668 cd0000        	call	c_lgadc
1928  066b 96            	ldw	x,sp
1929  066c 1c0001        	addw	x,#OFST-18
1930  066f cd0000        	call	c_ladd
1932  0672 be02          	ldw	x,c_lreg+2
1933  0674 7b06          	ld	a,(OFST-13,sp)
1934  0676 f7            	ld	(x),a
1935                     ; 395 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	0 ) & 0xFF;	// Least Significant Byte
1937  0677 1e14          	ldw	x,(OFST+1,sp)
1938  0679 cd0000        	call	c_uitolx
1940  067c 96            	ldw	x,sp
1941  067d 1c0001        	addw	x,#OFST-18
1942  0680 cd0000        	call	c_rtol
1945  0683 96            	ldw	x,sp
1946  0684 1c000f        	addw	x,#OFST-4
1947  0687 cd0000        	call	c_ltor
1949  068a 96            	ldw	x,sp
1950  068b 1c000f        	addw	x,#OFST-4
1951  068e a601          	ld	a,#1
1952  0690 cd0000        	call	c_lgadc
1955  0693 96            	ldw	x,sp
1956  0694 1c0001        	addw	x,#OFST-18
1957  0697 cd0000        	call	c_ladd
1959  069a be02          	ldw	x,c_lreg+2
1960  069c 7b07          	ld	a,(OFST-12,sp)
1961  069e a4ff          	and	a,#255
1962  06a0 f7            	ld	(x),a
1963                     ; 398 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
1965  06a1 1e18          	ldw	x,(OFST+5,sp)
1966  06a3 cd0000        	call	_strlen
1968  06a6 cd0000        	call	c_uitolx
1970  06a9 be02          	ldw	x,c_lreg+2
1971  06ab 89            	pushw	x
1972  06ac be00          	ldw	x,c_lreg
1973  06ae 89            	pushw	x
1974  06af cd0000        	call	_punEncodeLength
1976  06b2 5b04          	addw	sp,#4
1977  06b4 1f0c          	ldw	(OFST-7,sp),x
1979                     ; 399 	i = strlen( ( const char* )ptr);
1981  06b6 1e0c          	ldw	x,(OFST-7,sp)
1982  06b8 cd0000        	call	_strlen
1984  06bb 01            	rrwa	x,a
1985  06bc 6b0e          	ld	(OFST-5,sp),a
1986  06be 02            	rlwa	x,a
1988                     ; 400 	if(i < 2)
1990  06bf 7b0e          	ld	a,(OFST-5,sp)
1991  06c1 a102          	cp	a,#2
1992  06c3 2452          	jruge	L754
1993                     ; 402 		punBuffer[ulTotalPacketLength++] = 0;
1995  06c5 1e14          	ldw	x,(OFST+1,sp)
1996  06c7 cd0000        	call	c_uitolx
1998  06ca 96            	ldw	x,sp
1999  06cb 1c0001        	addw	x,#OFST-18
2000  06ce cd0000        	call	c_rtol
2003  06d1 96            	ldw	x,sp
2004  06d2 1c000f        	addw	x,#OFST-4
2005  06d5 cd0000        	call	c_ltor
2007  06d8 96            	ldw	x,sp
2008  06d9 1c000f        	addw	x,#OFST-4
2009  06dc a601          	ld	a,#1
2010  06de cd0000        	call	c_lgadc
2013  06e1 96            	ldw	x,sp
2014  06e2 1c0001        	addw	x,#OFST-18
2015  06e5 cd0000        	call	c_ladd
2017  06e8 be02          	ldw	x,c_lreg+2
2018  06ea 7f            	clr	(x)
2019                     ; 403 		punBuffer[ulTotalPacketLength++] = *(ptr);
2021  06eb 1e14          	ldw	x,(OFST+1,sp)
2022  06ed cd0000        	call	c_uitolx
2024  06f0 96            	ldw	x,sp
2025  06f1 1c0001        	addw	x,#OFST-18
2026  06f4 cd0000        	call	c_rtol
2029  06f7 96            	ldw	x,sp
2030  06f8 1c000f        	addw	x,#OFST-4
2031  06fb cd0000        	call	c_ltor
2033  06fe 96            	ldw	x,sp
2034  06ff 1c000f        	addw	x,#OFST-4
2035  0702 a601          	ld	a,#1
2036  0704 cd0000        	call	c_lgadc
2039  0707 96            	ldw	x,sp
2040  0708 1c0001        	addw	x,#OFST-18
2041  070b cd0000        	call	c_ladd
2043  070e be02          	ldw	x,c_lreg+2
2044  0710 160c          	ldw	y,(OFST-7,sp)
2045  0712 90f6          	ld	a,(y)
2046  0714 f7            	ld	(x),a
2048  0715 2055          	jra	L164
2049  0717               L754:
2050                     ; 407 		punBuffer[ulTotalPacketLength++] = *(ptr);
2052  0717 1e14          	ldw	x,(OFST+1,sp)
2053  0719 cd0000        	call	c_uitolx
2055  071c 96            	ldw	x,sp
2056  071d 1c0001        	addw	x,#OFST-18
2057  0720 cd0000        	call	c_rtol
2060  0723 96            	ldw	x,sp
2061  0724 1c000f        	addw	x,#OFST-4
2062  0727 cd0000        	call	c_ltor
2064  072a 96            	ldw	x,sp
2065  072b 1c000f        	addw	x,#OFST-4
2066  072e a601          	ld	a,#1
2067  0730 cd0000        	call	c_lgadc
2070  0733 96            	ldw	x,sp
2071  0734 1c0001        	addw	x,#OFST-18
2072  0737 cd0000        	call	c_ladd
2074  073a be02          	ldw	x,c_lreg+2
2075  073c 160c          	ldw	y,(OFST-7,sp)
2076  073e 90f6          	ld	a,(y)
2077  0740 f7            	ld	(x),a
2078                     ; 408 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
2080  0741 1e14          	ldw	x,(OFST+1,sp)
2081  0743 cd0000        	call	c_uitolx
2083  0746 96            	ldw	x,sp
2084  0747 1c0001        	addw	x,#OFST-18
2085  074a cd0000        	call	c_rtol
2088  074d 96            	ldw	x,sp
2089  074e 1c000f        	addw	x,#OFST-4
2090  0751 cd0000        	call	c_ltor
2092  0754 96            	ldw	x,sp
2093  0755 1c000f        	addw	x,#OFST-4
2094  0758 a601          	ld	a,#1
2095  075a cd0000        	call	c_lgadc
2098  075d 96            	ldw	x,sp
2099  075e 1c0001        	addw	x,#OFST-18
2100  0761 cd0000        	call	c_ladd
2102  0764 be02          	ldw	x,c_lreg+2
2103  0766 160c          	ldw	y,(OFST-7,sp)
2104  0768 90e601        	ld	a,(1,y)
2105  076b f7            	ld	(x),a
2106  076c               L164:
2107                     ; 410 	i = strlen( ( const char* )punTopic);
2109  076c 1e18          	ldw	x,(OFST+5,sp)
2110  076e cd0000        	call	_strlen
2112  0771 01            	rrwa	x,a
2113  0772 6b0e          	ld	(OFST-5,sp),a
2114  0774 02            	rlwa	x,a
2116                     ; 411 	for ( j = 0; j < i; j++)
2118  0775 0f13          	clr	(OFST+0,sp)
2121  0777 2033          	jra	L764
2122  0779               L364:
2123                     ; 413 		punBuffer[ulTotalPacketLength++] = punTopic[j];
2125  0779 1e14          	ldw	x,(OFST+1,sp)
2126  077b cd0000        	call	c_uitolx
2128  077e 96            	ldw	x,sp
2129  077f 1c0001        	addw	x,#OFST-18
2130  0782 cd0000        	call	c_rtol
2133  0785 96            	ldw	x,sp
2134  0786 1c000f        	addw	x,#OFST-4
2135  0789 cd0000        	call	c_ltor
2137  078c 96            	ldw	x,sp
2138  078d 1c000f        	addw	x,#OFST-4
2139  0790 a601          	ld	a,#1
2140  0792 cd0000        	call	c_lgadc
2143  0795 96            	ldw	x,sp
2144  0796 1c0001        	addw	x,#OFST-18
2145  0799 cd0000        	call	c_ladd
2147  079c be02          	ldw	x,c_lreg+2
2148  079e 7b13          	ld	a,(OFST+0,sp)
2149  07a0 905f          	clrw	y
2150  07a2 9097          	ld	yl,a
2151  07a4 72f918        	addw	y,(OFST+5,sp)
2152  07a7 90f6          	ld	a,(y)
2153  07a9 f7            	ld	(x),a
2154                     ; 411 	for ( j = 0; j < i; j++)
2156  07aa 0c13          	inc	(OFST+0,sp)
2158  07ac               L764:
2161  07ac 7b13          	ld	a,(OFST+0,sp)
2162  07ae 110e          	cp	a,(OFST-5,sp)
2163  07b0 25c7          	jrult	L364
2164                     ; 417 	punBuffer[ulTotalPacketLength++]	=	((uint8_t)eQOS & 0x03);	//	Requested QOS, where bits[1:0] is QOS, and bits[7:2] are reserved 0
2166  07b2 1e14          	ldw	x,(OFST+1,sp)
2167  07b4 cd0000        	call	c_uitolx
2169  07b7 96            	ldw	x,sp
2170  07b8 1c0001        	addw	x,#OFST-18
2171  07bb cd0000        	call	c_rtol
2174  07be 96            	ldw	x,sp
2175  07bf 1c000f        	addw	x,#OFST-4
2176  07c2 cd0000        	call	c_ltor
2178  07c5 96            	ldw	x,sp
2179  07c6 1c000f        	addw	x,#OFST-4
2180  07c9 a601          	ld	a,#1
2181  07cb cd0000        	call	c_lgadc
2184  07ce 96            	ldw	x,sp
2185  07cf 1c0001        	addw	x,#OFST-18
2186  07d2 cd0000        	call	c_ladd
2188  07d5 be02          	ldw	x,c_lreg+2
2189  07d7 7b05          	ld	a,(OFST-14,sp)
2190  07d9 a403          	and	a,#3
2191  07db f7            	ld	(x),a
2192                     ; 419 	punBuffer[ulTotalPacketLength]	=	'\0';
2194  07dc 1e14          	ldw	x,(OFST+1,sp)
2195  07de 72fb11        	addw	x,(OFST-2,sp)
2196  07e1 7f            	clr	(x)
2197                     ; 421 	return ulTotalPacketLength;
2199  07e2 96            	ldw	x,sp
2200  07e3 1c000f        	addw	x,#OFST-4
2201  07e6 cd0000        	call	c_ltor
2205  07e9 5b15          	addw	sp,#21
2206  07eb 81            	ret
2309                     ; 424 uint32_t ulMQTT_UnSubscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, uint16_t udPacketIdentifier */)
2309                     ; 425 {
2310                     	switch	.text
2311  07ec               _ulMQTT_UnSubscribe:
2313  07ec 89            	pushw	x
2314  07ed 5212          	subw	sp,#18
2315       00000012      OFST:	set	18
2318                     ; 426 	uint32_t ulTotalPacketLength	= 0;
2320  07ef ae0000        	ldw	x,#0
2321  07f2 1f10          	ldw	(OFST-2,sp),x
2322  07f4 ae0000        	ldw	x,#0
2323  07f7 1f0e          	ldw	(OFST-4,sp),x
2325                     ; 427 	uint32_t ulRemainingLength		= 0;
2327  07f9 ae0000        	ldw	x,#0
2328  07fc 1f09          	ldw	(OFST-9,sp),x
2329  07fe ae0000        	ldw	x,#0
2330  0801 1f07          	ldw	(OFST-11,sp),x
2332                     ; 428 	uint8_t i = 0, j = 0, *ptr;
2336                     ; 430 	uint16_t udPacketIdentifier = 1;
2338  0803 ae0001        	ldw	x,#1
2339  0806 1f05          	ldw	(OFST-13,sp),x
2341                     ; 432 	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_UNSUBSCRIBE & 0xF) << 4 ) & 0xF0) | (( (uint8_t)eCTRL_PKT_FLAG_UNSUBSCRIBE & 0x0F) );
2343  0808 1e13          	ldw	x,(OFST+1,sp)
2344  080a cd0000        	call	c_uitolx
2346  080d 96            	ldw	x,sp
2347  080e 1c0001        	addw	x,#OFST-17
2348  0811 cd0000        	call	c_rtol
2351  0814 96            	ldw	x,sp
2352  0815 1c000e        	addw	x,#OFST-4
2353  0818 cd0000        	call	c_ltor
2355  081b 96            	ldw	x,sp
2356  081c 1c000e        	addw	x,#OFST-4
2357  081f a601          	ld	a,#1
2358  0821 cd0000        	call	c_lgadc
2361  0824 96            	ldw	x,sp
2362  0825 1c0001        	addw	x,#OFST-17
2363  0828 cd0000        	call	c_ladd
2365  082b be02          	ldw	x,c_lreg+2
2366  082d a6a2          	ld	a,#162
2367  082f f7            	ld	(x),a
2368                     ; 435 	ulRemainingLength	+=	2;	//Variable Header: Packet Identifier of fixed 2 Bytes
2370  0830 96            	ldw	x,sp
2371  0831 1c0007        	addw	x,#OFST-11
2372  0834 a602          	ld	a,#2
2373  0836 cd0000        	call	c_lgadc
2376                     ; 436 	ulRemainingLength	+=	2;	//Payload: Topic Name Length which is 2 Bytes
2378  0839 96            	ldw	x,sp
2379  083a 1c0007        	addw	x,#OFST-11
2380  083d a602          	ld	a,#2
2381  083f cd0000        	call	c_lgadc
2384                     ; 437 	ulRemainingLength	+=	strlen( ( const char* )punTopic);;	//Payload: Topic Name Length
2386  0842 1e17          	ldw	x,(OFST+5,sp)
2387  0844 cd0000        	call	_strlen
2389  0847 cd0000        	call	c_uitolx
2391  084a 96            	ldw	x,sp
2392  084b 1c0007        	addw	x,#OFST-11
2393  084e cd0000        	call	c_lgadd
2396                     ; 440 	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
2399  0851 1e09          	ldw	x,(OFST-9,sp)
2400  0853 89            	pushw	x
2401  0854 1e09          	ldw	x,(OFST-9,sp)
2402  0856 89            	pushw	x
2403  0857 cd0000        	call	_punEncodeLength
2405  085a 5b04          	addw	sp,#4
2406  085c 1f0b          	ldw	(OFST-7,sp),x
2408                     ; 441 	i = strlen( ( const char* )ptr);
2410  085e 1e0b          	ldw	x,(OFST-7,sp)
2411  0860 cd0000        	call	_strlen
2413  0863 01            	rrwa	x,a
2414  0864 6b0d          	ld	(OFST-5,sp),a
2415  0866 02            	rlwa	x,a
2417                     ; 442 	for ( j = 0; j < i; j++)
2419  0867 0f12          	clr	(OFST+0,sp)
2422  0869 2033          	jra	L155
2423  086b               L545:
2424                     ; 444 		punBuffer[ulTotalPacketLength++] = *(ptr + j);
2426  086b 1e13          	ldw	x,(OFST+1,sp)
2427  086d cd0000        	call	c_uitolx
2429  0870 96            	ldw	x,sp
2430  0871 1c0001        	addw	x,#OFST-17
2431  0874 cd0000        	call	c_rtol
2434  0877 96            	ldw	x,sp
2435  0878 1c000e        	addw	x,#OFST-4
2436  087b cd0000        	call	c_ltor
2438  087e 96            	ldw	x,sp
2439  087f 1c000e        	addw	x,#OFST-4
2440  0882 a601          	ld	a,#1
2441  0884 cd0000        	call	c_lgadc
2444  0887 96            	ldw	x,sp
2445  0888 1c0001        	addw	x,#OFST-17
2446  088b cd0000        	call	c_ladd
2448  088e be02          	ldw	x,c_lreg+2
2449  0890 7b12          	ld	a,(OFST+0,sp)
2450  0892 905f          	clrw	y
2451  0894 9097          	ld	yl,a
2452  0896 72f90b        	addw	y,(OFST-7,sp)
2453  0899 90f6          	ld	a,(y)
2454  089b f7            	ld	(x),a
2455                     ; 442 	for ( j = 0; j < i; j++)
2457  089c 0c12          	inc	(OFST+0,sp)
2459  089e               L155:
2462  089e 7b12          	ld	a,(OFST+0,sp)
2463  08a0 110d          	cp	a,(OFST-5,sp)
2464  08a2 25c7          	jrult	L545
2465                     ; 448 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	8 ) & 0xFF;	// Most Significant Byte
2467  08a4 1e13          	ldw	x,(OFST+1,sp)
2468  08a6 cd0000        	call	c_uitolx
2470  08a9 96            	ldw	x,sp
2471  08aa 1c0001        	addw	x,#OFST-17
2472  08ad cd0000        	call	c_rtol
2475  08b0 96            	ldw	x,sp
2476  08b1 1c000e        	addw	x,#OFST-4
2477  08b4 cd0000        	call	c_ltor
2479  08b7 96            	ldw	x,sp
2480  08b8 1c000e        	addw	x,#OFST-4
2481  08bb a601          	ld	a,#1
2482  08bd cd0000        	call	c_lgadc
2485  08c0 96            	ldw	x,sp
2486  08c1 1c0001        	addw	x,#OFST-17
2487  08c4 cd0000        	call	c_ladd
2489  08c7 be02          	ldw	x,c_lreg+2
2490  08c9 7b05          	ld	a,(OFST-13,sp)
2491  08cb f7            	ld	(x),a
2492                     ; 449 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	0 ) & 0xFF;	// Least Significant Byte
2494  08cc 1e13          	ldw	x,(OFST+1,sp)
2495  08ce cd0000        	call	c_uitolx
2497  08d1 96            	ldw	x,sp
2498  08d2 1c0001        	addw	x,#OFST-17
2499  08d5 cd0000        	call	c_rtol
2502  08d8 96            	ldw	x,sp
2503  08d9 1c000e        	addw	x,#OFST-4
2504  08dc cd0000        	call	c_ltor
2506  08df 96            	ldw	x,sp
2507  08e0 1c000e        	addw	x,#OFST-4
2508  08e3 a601          	ld	a,#1
2509  08e5 cd0000        	call	c_lgadc
2512  08e8 96            	ldw	x,sp
2513  08e9 1c0001        	addw	x,#OFST-17
2514  08ec cd0000        	call	c_ladd
2516  08ef be02          	ldw	x,c_lreg+2
2517  08f1 7b06          	ld	a,(OFST-12,sp)
2518  08f3 a4ff          	and	a,#255
2519  08f5 f7            	ld	(x),a
2520                     ; 452 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
2522  08f6 1e17          	ldw	x,(OFST+5,sp)
2523  08f8 cd0000        	call	_strlen
2525  08fb cd0000        	call	c_uitolx
2527  08fe be02          	ldw	x,c_lreg+2
2528  0900 89            	pushw	x
2529  0901 be00          	ldw	x,c_lreg
2530  0903 89            	pushw	x
2531  0904 cd0000        	call	_punEncodeLength
2533  0907 5b04          	addw	sp,#4
2534  0909 1f0b          	ldw	(OFST-7,sp),x
2536                     ; 453 	i = strlen( ( const char* )ptr);
2538  090b 1e0b          	ldw	x,(OFST-7,sp)
2539  090d cd0000        	call	_strlen
2541  0910 01            	rrwa	x,a
2542  0911 6b0d          	ld	(OFST-5,sp),a
2543  0913 02            	rlwa	x,a
2545                     ; 454 	if(i < 2)
2547  0914 7b0d          	ld	a,(OFST-5,sp)
2548  0916 a102          	cp	a,#2
2549  0918 2452          	jruge	L555
2550                     ; 456 		punBuffer[ulTotalPacketLength++] = 0;
2552  091a 1e13          	ldw	x,(OFST+1,sp)
2553  091c cd0000        	call	c_uitolx
2555  091f 96            	ldw	x,sp
2556  0920 1c0001        	addw	x,#OFST-17
2557  0923 cd0000        	call	c_rtol
2560  0926 96            	ldw	x,sp
2561  0927 1c000e        	addw	x,#OFST-4
2562  092a cd0000        	call	c_ltor
2564  092d 96            	ldw	x,sp
2565  092e 1c000e        	addw	x,#OFST-4
2566  0931 a601          	ld	a,#1
2567  0933 cd0000        	call	c_lgadc
2570  0936 96            	ldw	x,sp
2571  0937 1c0001        	addw	x,#OFST-17
2572  093a cd0000        	call	c_ladd
2574  093d be02          	ldw	x,c_lreg+2
2575  093f 7f            	clr	(x)
2576                     ; 457 		punBuffer[ulTotalPacketLength++] = *(ptr);
2578  0940 1e13          	ldw	x,(OFST+1,sp)
2579  0942 cd0000        	call	c_uitolx
2581  0945 96            	ldw	x,sp
2582  0946 1c0001        	addw	x,#OFST-17
2583  0949 cd0000        	call	c_rtol
2586  094c 96            	ldw	x,sp
2587  094d 1c000e        	addw	x,#OFST-4
2588  0950 cd0000        	call	c_ltor
2590  0953 96            	ldw	x,sp
2591  0954 1c000e        	addw	x,#OFST-4
2592  0957 a601          	ld	a,#1
2593  0959 cd0000        	call	c_lgadc
2596  095c 96            	ldw	x,sp
2597  095d 1c0001        	addw	x,#OFST-17
2598  0960 cd0000        	call	c_ladd
2600  0963 be02          	ldw	x,c_lreg+2
2601  0965 160b          	ldw	y,(OFST-7,sp)
2602  0967 90f6          	ld	a,(y)
2603  0969 f7            	ld	(x),a
2605  096a 2055          	jra	L755
2606  096c               L555:
2607                     ; 461 		punBuffer[ulTotalPacketLength++] = *(ptr);
2609  096c 1e13          	ldw	x,(OFST+1,sp)
2610  096e cd0000        	call	c_uitolx
2612  0971 96            	ldw	x,sp
2613  0972 1c0001        	addw	x,#OFST-17
2614  0975 cd0000        	call	c_rtol
2617  0978 96            	ldw	x,sp
2618  0979 1c000e        	addw	x,#OFST-4
2619  097c cd0000        	call	c_ltor
2621  097f 96            	ldw	x,sp
2622  0980 1c000e        	addw	x,#OFST-4
2623  0983 a601          	ld	a,#1
2624  0985 cd0000        	call	c_lgadc
2627  0988 96            	ldw	x,sp
2628  0989 1c0001        	addw	x,#OFST-17
2629  098c cd0000        	call	c_ladd
2631  098f be02          	ldw	x,c_lreg+2
2632  0991 160b          	ldw	y,(OFST-7,sp)
2633  0993 90f6          	ld	a,(y)
2634  0995 f7            	ld	(x),a
2635                     ; 462 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
2637  0996 1e13          	ldw	x,(OFST+1,sp)
2638  0998 cd0000        	call	c_uitolx
2640  099b 96            	ldw	x,sp
2641  099c 1c0001        	addw	x,#OFST-17
2642  099f cd0000        	call	c_rtol
2645  09a2 96            	ldw	x,sp
2646  09a3 1c000e        	addw	x,#OFST-4
2647  09a6 cd0000        	call	c_ltor
2649  09a9 96            	ldw	x,sp
2650  09aa 1c000e        	addw	x,#OFST-4
2651  09ad a601          	ld	a,#1
2652  09af cd0000        	call	c_lgadc
2655  09b2 96            	ldw	x,sp
2656  09b3 1c0001        	addw	x,#OFST-17
2657  09b6 cd0000        	call	c_ladd
2659  09b9 be02          	ldw	x,c_lreg+2
2660  09bb 160b          	ldw	y,(OFST-7,sp)
2661  09bd 90e601        	ld	a,(1,y)
2662  09c0 f7            	ld	(x),a
2663  09c1               L755:
2664                     ; 464 	i = strlen( ( const char* )punTopic);
2666  09c1 1e17          	ldw	x,(OFST+5,sp)
2667  09c3 cd0000        	call	_strlen
2669  09c6 01            	rrwa	x,a
2670  09c7 6b0d          	ld	(OFST-5,sp),a
2671  09c9 02            	rlwa	x,a
2673                     ; 465 	for ( j = 0; j < i; j++)
2675  09ca 0f12          	clr	(OFST+0,sp)
2678  09cc 2033          	jra	L565
2679  09ce               L165:
2680                     ; 467 		punBuffer[ulTotalPacketLength++] = punTopic[j];
2682  09ce 1e13          	ldw	x,(OFST+1,sp)
2683  09d0 cd0000        	call	c_uitolx
2685  09d3 96            	ldw	x,sp
2686  09d4 1c0001        	addw	x,#OFST-17
2687  09d7 cd0000        	call	c_rtol
2690  09da 96            	ldw	x,sp
2691  09db 1c000e        	addw	x,#OFST-4
2692  09de cd0000        	call	c_ltor
2694  09e1 96            	ldw	x,sp
2695  09e2 1c000e        	addw	x,#OFST-4
2696  09e5 a601          	ld	a,#1
2697  09e7 cd0000        	call	c_lgadc
2700  09ea 96            	ldw	x,sp
2701  09eb 1c0001        	addw	x,#OFST-17
2702  09ee cd0000        	call	c_ladd
2704  09f1 be02          	ldw	x,c_lreg+2
2705  09f3 7b12          	ld	a,(OFST+0,sp)
2706  09f5 905f          	clrw	y
2707  09f7 9097          	ld	yl,a
2708  09f9 72f917        	addw	y,(OFST+5,sp)
2709  09fc 90f6          	ld	a,(y)
2710  09fe f7            	ld	(x),a
2711                     ; 465 	for ( j = 0; j < i; j++)
2713  09ff 0c12          	inc	(OFST+0,sp)
2715  0a01               L565:
2718  0a01 7b12          	ld	a,(OFST+0,sp)
2719  0a03 110d          	cp	a,(OFST-5,sp)
2720  0a05 25c7          	jrult	L165
2721                     ; 470 	punBuffer[ulTotalPacketLength]	=	'\0';
2723  0a07 1e13          	ldw	x,(OFST+1,sp)
2724  0a09 72fb10        	addw	x,(OFST-2,sp)
2725  0a0c 7f            	clr	(x)
2726                     ; 472 	return ulTotalPacketLength;
2728  0a0d 96            	ldw	x,sp
2729  0a0e 1c000e        	addw	x,#OFST-4
2730  0a11 cd0000        	call	c_ltor
2734  0a14 5b14          	addw	sp,#20
2735  0a16 81            	ret
2789                     ; 475 uint8_t unMQTT_PingRequest ( uint8_t *punBuffer )
2789                     ; 476 {
2790                     	switch	.text
2791  0a17               _unMQTT_PingRequest:
2793  0a17 89            	pushw	x
2794  0a18 89            	pushw	x
2795       00000002      OFST:	set	2
2798                     ; 477 	uint8_t unTotalPacketLength	= 0;
2800  0a19 0f02          	clr	(OFST+0,sp)
2802                     ; 478 	uint8_t unRemainingLength	= 0;
2804                     ; 481 	punBuffer[unTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_PINGREQ & 0xF) << 4 ) & 0xF0) | ( ((uint8_t)eCTRL_PKT_FLAG_PINGREQ & 0x0F) );
2806  0a1b 7b02          	ld	a,(OFST+0,sp)
2807  0a1d 97            	ld	xl,a
2808  0a1e 0c02          	inc	(OFST+0,sp)
2810  0a20 9f            	ld	a,xl
2811  0a21 5f            	clrw	x
2812  0a22 97            	ld	xl,a
2813  0a23 72fb03        	addw	x,(OFST+1,sp)
2814  0a26 a6c0          	ld	a,#192
2815  0a28 f7            	ld	(x),a
2816                     ; 483 	punBuffer[unTotalPacketLength++] = unRemainingLength;
2818  0a29 7b02          	ld	a,(OFST+0,sp)
2819  0a2b 97            	ld	xl,a
2820  0a2c 0c02          	inc	(OFST+0,sp)
2822  0a2e 9f            	ld	a,xl
2823  0a2f 5f            	clrw	x
2824  0a30 97            	ld	xl,a
2825  0a31 72fb03        	addw	x,(OFST+1,sp)
2826  0a34 7f            	clr	(x)
2827                     ; 485 	punBuffer[unTotalPacketLength]	=	'\0';
2829  0a35 7b02          	ld	a,(OFST+0,sp)
2830  0a37 5f            	clrw	x
2831  0a38 97            	ld	xl,a
2832  0a39 72fb03        	addw	x,(OFST+1,sp)
2833  0a3c 7f            	clr	(x)
2834                     ; 487 	return unTotalPacketLength;
2836  0a3d 7b02          	ld	a,(OFST+0,sp)
2839  0a3f 5b04          	addw	sp,#4
2840  0a41 81            	ret
2894                     ; 490 uint8_t unMQTT_Disconnect ( uint8_t *punBuffer )
2894                     ; 491 {
2895                     	switch	.text
2896  0a42               _unMQTT_Disconnect:
2898  0a42 89            	pushw	x
2899  0a43 89            	pushw	x
2900       00000002      OFST:	set	2
2903                     ; 492 	uint8_t unTotalPacketLength	= 0;
2905  0a44 0f02          	clr	(OFST+0,sp)
2907                     ; 493 	uint8_t unRemainingLength	= 0;
2909                     ; 496 	punBuffer[unTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_DISCONNECT & 0xF) << 4 ) & 0xF0) | ( ((uint8_t)eCTRL_PKT_FLAG_DISCONNECT & 0x0F) );
2911  0a46 7b02          	ld	a,(OFST+0,sp)
2912  0a48 97            	ld	xl,a
2913  0a49 0c02          	inc	(OFST+0,sp)
2915  0a4b 9f            	ld	a,xl
2916  0a4c 5f            	clrw	x
2917  0a4d 97            	ld	xl,a
2918  0a4e 72fb03        	addw	x,(OFST+1,sp)
2919  0a51 a6e0          	ld	a,#224
2920  0a53 f7            	ld	(x),a
2921                     ; 498 	punBuffer[unTotalPacketLength++] = unRemainingLength;
2923  0a54 7b02          	ld	a,(OFST+0,sp)
2924  0a56 97            	ld	xl,a
2925  0a57 0c02          	inc	(OFST+0,sp)
2927  0a59 9f            	ld	a,xl
2928  0a5a 5f            	clrw	x
2929  0a5b 97            	ld	xl,a
2930  0a5c 72fb03        	addw	x,(OFST+1,sp)
2931  0a5f 7f            	clr	(x)
2932                     ; 500 	punBuffer[unTotalPacketLength]	=	'\0';
2934  0a60 7b02          	ld	a,(OFST+0,sp)
2935  0a62 5f            	clrw	x
2936  0a63 97            	ld	xl,a
2937  0a64 72fb03        	addw	x,(OFST+1,sp)
2938  0a67 7f            	clr	(x)
2939                     ; 502 	return unTotalPacketLength;
2941  0a68 7b02          	ld	a,(OFST+0,sp)
2944  0a6a 5b04          	addw	sp,#4
2945  0a6c 81            	ret
3007                     ; 664 uint32_t ulDecodedLength (uint8_t * punLength)
3007                     ; 665 {
3008                     	switch	.text
3009  0a6d               _ulDecodedLength:
3011  0a6d 89            	pushw	x
3012  0a6e 520d          	subw	sp,#13
3013       0000000d      OFST:	set	13
3016                     ; 666   uint32_t multiplier = 1;
3018  0a70 ae0001        	ldw	x,#1
3019  0a73 1f0b          	ldw	(OFST-2,sp),x
3020  0a75 ae0000        	ldw	x,#0
3021  0a78 1f09          	ldw	(OFST-4,sp),x
3023                     ; 667   uint32_t value = 0;
3025  0a7a ae0000        	ldw	x,#0
3026  0a7d 1f07          	ldw	(OFST-6,sp),x
3027  0a7f ae0000        	ldw	x,#0
3028  0a82 1f05          	ldw	(OFST-8,sp),x
3030                     ; 668   uint8_t  i = 0;
3032  0a84 0f0d          	clr	(OFST+0,sp)
3034  0a86               L776:
3035                     ; 672         value += (punLength[i] & 0x7F) * multiplier;
3037  0a86 7b0d          	ld	a,(OFST+0,sp)
3038  0a88 5f            	clrw	x
3039  0a89 97            	ld	xl,a
3040  0a8a 72fb0e        	addw	x,(OFST+1,sp)
3041  0a8d f6            	ld	a,(x)
3042  0a8e a47f          	and	a,#127
3043  0a90 b703          	ld	c_lreg+3,a
3044  0a92 3f02          	clr	c_lreg+2
3045  0a94 3f01          	clr	c_lreg+1
3046  0a96 3f00          	clr	c_lreg
3047  0a98 96            	ldw	x,sp
3048  0a99 1c0001        	addw	x,#OFST-12
3049  0a9c cd0000        	call	c_rtol
3052  0a9f 96            	ldw	x,sp
3053  0aa0 1c0009        	addw	x,#OFST-4
3054  0aa3 cd0000        	call	c_ltor
3056  0aa6 96            	ldw	x,sp
3057  0aa7 1c0001        	addw	x,#OFST-12
3058  0aaa cd0000        	call	c_lmul
3060  0aad 96            	ldw	x,sp
3061  0aae 1c0005        	addw	x,#OFST-8
3062  0ab1 cd0000        	call	c_lgadd
3065                     ; 673 	    multiplier *= 0x80;
3067  0ab4 96            	ldw	x,sp
3068  0ab5 1c0009        	addw	x,#OFST-4
3069  0ab8 a607          	ld	a,#7
3070  0aba cd0000        	call	c_lglsh
3073                     ; 674 	    if (multiplier > (0x80 * 0x80 * 0x80))
3075  0abd 96            	ldw	x,sp
3076  0abe 1c0009        	addw	x,#OFST-4
3077  0ac1 cd0000        	call	c_lzmp
3079  0ac4 2709          	jreq	L107
3080                     ; 676 	        return value;
3082  0ac6 96            	ldw	x,sp
3083  0ac7 1c0005        	addw	x,#OFST-8
3084  0aca cd0000        	call	c_ltor
3087  0acd 201d          	jra	L42
3088  0acf               L107:
3089                     ; 678 	} while ((punLength[i++] & 0x80) != 0 && i < 4);
3091  0acf 7b0d          	ld	a,(OFST+0,sp)
3092  0ad1 97            	ld	xl,a
3093  0ad2 0c0d          	inc	(OFST+0,sp)
3095  0ad4 9f            	ld	a,xl
3096  0ad5 5f            	clrw	x
3097  0ad6 97            	ld	xl,a
3098  0ad7 72fb0e        	addw	x,(OFST+1,sp)
3099  0ada f6            	ld	a,(x)
3100  0adb a580          	bcp	a,#128
3101  0add 2706          	jreq	L707
3103  0adf 7b0d          	ld	a,(OFST+0,sp)
3104  0ae1 a104          	cp	a,#4
3105  0ae3 25a1          	jrult	L776
3106  0ae5               L707:
3107                     ; 680     return value;
3109  0ae5 96            	ldw	x,sp
3110  0ae6 1c0005        	addw	x,#OFST-8
3111  0ae9 cd0000        	call	c_ltor
3114  0aec               L42:
3116  0aec 5b0f          	addw	sp,#15
3117  0aee 81            	ret
3130                     	xdef	_unMQTT_Disconnect
3131                     	xdef	_unMQTT_PingRequest
3132                     	xdef	_ulMQTT_UnSubscribe
3133                     	xdef	_ulMQTT_Subscribe
3134                     	xdef	_ulMQTT_Publish
3135                     	xdef	_ulMQTT_Connect
3136                     	xdef	_ulDecodedLength
3137                     	xdef	_punEncodeLength
3138                     	xref	_strlen
3139                     .const:	section	.text
3140  0000               L141:
3141  0000 4d51545400    	dc.b	"MQTT",0
3142                     	xref.b	c_lreg
3143                     	xref.b	c_x
3163                     	xref	c_lglsh
3164                     	xref	c_lmul
3165                     	xref	c_lgadd
3166                     	xref	c_ladd
3167                     	xref	c_rtol
3168                     	xref	c_uitolx
3169                     	xref	c_lgadc
3170                     	xref	c_ltor
3171                     	xref	c_lzmp
3172                     	xref	c_lgursh
3173                     	end
