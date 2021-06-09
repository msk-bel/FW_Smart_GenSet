   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
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
 373  00d1 2036          	jra	L521
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
 400  00f8 89            	pushw	x
 401  00f9 7b0b          	ld	a,(OFST-5,sp)
 402  00fb 97            	ld	xl,a
 403  00fc 7b0c          	ld	a,(OFST-4,sp)
 404  00fe 1b12          	add	a,(OFST+2,sp)
 405  0100 2401          	jrnc	L01
 406  0102 5c            	incw	x
 407  0103               L01:
 408  0103 02            	rlwa	x,a
 409  0104 f6            	ld	a,(x)
 410  0105 85            	popw	x
 411  0106 f7            	ld	(x),a
 412                     ; 170 	for ( j = 0; j < i; j++)
 414  0107 0c10          	inc	(OFST+0,sp)
 416  0109               L521:
 419  0109 7b10          	ld	a,(OFST+0,sp)
 420  010b 110b          	cp	a,(OFST-5,sp)
 421  010d 25c4          	jrult	L121
 422                     ; 175     i = strlen( ( const char* )PROTOCOL_NAME);
 424  010f a604          	ld	a,#4
 425  0111 6b0b          	ld	(OFST-5,sp),a
 427                     ; 176 	punBuffer[ulTotalPacketLength++] = (i >> 8) & 0xFF;	//Variable Header:  Protocol Name Length Most Significant Byte
 429  0113 1e11          	ldw	x,(OFST+1,sp)
 430  0115 cd0000        	call	c_uitolx
 432  0118 96            	ldw	x,sp
 433  0119 1c0001        	addw	x,#OFST-15
 434  011c cd0000        	call	c_rtol
 437  011f 96            	ldw	x,sp
 438  0120 1c000c        	addw	x,#OFST-4
 439  0123 cd0000        	call	c_ltor
 441  0126 96            	ldw	x,sp
 442  0127 1c000c        	addw	x,#OFST-4
 443  012a a601          	ld	a,#1
 444  012c cd0000        	call	c_lgadc
 447  012f 96            	ldw	x,sp
 448  0130 1c0001        	addw	x,#OFST-15
 449  0133 cd0000        	call	c_ladd
 451  0136 be02          	ldw	x,c_lreg+2
 452  0138 7f            	clr	(x)
 453                     ; 177 	punBuffer[ulTotalPacketLength++] = (i >> 0) & 0xFF;	//Variable Header:  Protocol Name Length Least Significant Byte
 455  0139 1e11          	ldw	x,(OFST+1,sp)
 456  013b cd0000        	call	c_uitolx
 458  013e 96            	ldw	x,sp
 459  013f 1c0001        	addw	x,#OFST-15
 460  0142 cd0000        	call	c_rtol
 463  0145 96            	ldw	x,sp
 464  0146 1c000c        	addw	x,#OFST-4
 465  0149 cd0000        	call	c_ltor
 467  014c 96            	ldw	x,sp
 468  014d 1c000c        	addw	x,#OFST-4
 469  0150 a601          	ld	a,#1
 470  0152 cd0000        	call	c_lgadc
 473  0155 96            	ldw	x,sp
 474  0156 1c0001        	addw	x,#OFST-15
 475  0159 cd0000        	call	c_ladd
 477  015c be02          	ldw	x,c_lreg+2
 478  015e 7b0b          	ld	a,(OFST-5,sp)
 479  0160 a4ff          	and	a,#255
 480  0162 f7            	ld	(x),a
 481                     ; 178 	for (j = 0; j < i; j++)
 483  0163 0f10          	clr	(OFST+0,sp)
 486  0165 2032          	jra	L531
 487  0167               L131:
 488                     ; 180         punBuffer[ulTotalPacketLength++] = (uint8_t)PROTOCOL_NAME[j];
 490  0167 1e11          	ldw	x,(OFST+1,sp)
 491  0169 cd0000        	call	c_uitolx
 493  016c 96            	ldw	x,sp
 494  016d 1c0001        	addw	x,#OFST-15
 495  0170 cd0000        	call	c_rtol
 498  0173 96            	ldw	x,sp
 499  0174 1c000c        	addw	x,#OFST-4
 500  0177 cd0000        	call	c_ltor
 502  017a 96            	ldw	x,sp
 503  017b 1c000c        	addw	x,#OFST-4
 504  017e a601          	ld	a,#1
 505  0180 cd0000        	call	c_lgadc
 508  0183 96            	ldw	x,sp
 509  0184 1c0001        	addw	x,#OFST-15
 510  0187 cd0000        	call	c_ladd
 512  018a be02          	ldw	x,c_lreg+2
 513  018c 7b10          	ld	a,(OFST+0,sp)
 514  018e 905f          	clrw	y
 515  0190 9097          	ld	yl,a
 516  0192 90d60000      	ld	a,(L141,y)
 517  0196 f7            	ld	(x),a
 518                     ; 178 	for (j = 0; j < i; j++)
 520  0197 0c10          	inc	(OFST+0,sp)
 522  0199               L531:
 525  0199 7b10          	ld	a,(OFST+0,sp)
 526  019b 110b          	cp	a,(OFST-5,sp)
 527  019d 25c8          	jrult	L131
 528                     ; 187 	punBuffer[ulTotalPacketLength++] = 0x04;	//Variable Header:  Protocol Level: which is fixed Level-4
 530  019f 1e11          	ldw	x,(OFST+1,sp)
 531  01a1 cd0000        	call	c_uitolx
 533  01a4 96            	ldw	x,sp
 534  01a5 1c0001        	addw	x,#OFST-15
 535  01a8 cd0000        	call	c_rtol
 538  01ab 96            	ldw	x,sp
 539  01ac 1c000c        	addw	x,#OFST-4
 540  01af cd0000        	call	c_ltor
 542  01b2 96            	ldw	x,sp
 543  01b3 1c000c        	addw	x,#OFST-4
 544  01b6 a601          	ld	a,#1
 545  01b8 cd0000        	call	c_lgadc
 548  01bb 96            	ldw	x,sp
 549  01bc 1c0001        	addw	x,#OFST-15
 550  01bf cd0000        	call	c_ladd
 552  01c2 be02          	ldw	x,c_lreg+2
 553  01c4 a604          	ld	a,#4
 554  01c6 f7            	ld	(x),a
 555                     ; 199 	punBuffer[ulTotalPacketLength++] = 0x02;
 557  01c7 1e11          	ldw	x,(OFST+1,sp)
 558  01c9 cd0000        	call	c_uitolx
 560  01cc 96            	ldw	x,sp
 561  01cd 1c0001        	addw	x,#OFST-15
 562  01d0 cd0000        	call	c_rtol
 565  01d3 96            	ldw	x,sp
 566  01d4 1c000c        	addw	x,#OFST-4
 567  01d7 cd0000        	call	c_ltor
 569  01da 96            	ldw	x,sp
 570  01db 1c000c        	addw	x,#OFST-4
 571  01de a601          	ld	a,#1
 572  01e0 cd0000        	call	c_lgadc
 575  01e3 96            	ldw	x,sp
 576  01e4 1c0001        	addw	x,#OFST-15
 577  01e7 cd0000        	call	c_ladd
 579  01ea be02          	ldw	x,c_lreg+2
 580  01ec a602          	ld	a,#2
 581  01ee f7            	ld	(x),a
 582                     ; 200 	punBuffer[ulTotalPacketLength++] = ((uint16_t)KEEP_ALIVE_TIMEOUT	>> 8)	&	0xFF;	////Variable Header:  Keep Alive Most Significant Byte
 584  01ef 1e11          	ldw	x,(OFST+1,sp)
 585  01f1 cd0000        	call	c_uitolx
 587  01f4 96            	ldw	x,sp
 588  01f5 1c0001        	addw	x,#OFST-15
 589  01f8 cd0000        	call	c_rtol
 592  01fb 96            	ldw	x,sp
 593  01fc 1c000c        	addw	x,#OFST-4
 594  01ff cd0000        	call	c_ltor
 596  0202 96            	ldw	x,sp
 597  0203 1c000c        	addw	x,#OFST-4
 598  0206 a601          	ld	a,#1
 599  0208 cd0000        	call	c_lgadc
 602  020b 96            	ldw	x,sp
 603  020c 1c0001        	addw	x,#OFST-15
 604  020f cd0000        	call	c_ladd
 606  0212 be02          	ldw	x,c_lreg+2
 607  0214 7f            	clr	(x)
 608                     ; 201 	punBuffer[ulTotalPacketLength++] = ((uint16_t)KEEP_ALIVE_TIMEOUT	>> 0)	&	0xFF;	////Variable Header:  Keep Alive Least Significant Byte
 610  0215 1e11          	ldw	x,(OFST+1,sp)
 611  0217 cd0000        	call	c_uitolx
 613  021a 96            	ldw	x,sp
 614  021b 1c0001        	addw	x,#OFST-15
 615  021e cd0000        	call	c_rtol
 618  0221 96            	ldw	x,sp
 619  0222 1c000c        	addw	x,#OFST-4
 620  0225 cd0000        	call	c_ltor
 622  0228 96            	ldw	x,sp
 623  0229 1c000c        	addw	x,#OFST-4
 624  022c a601          	ld	a,#1
 625  022e cd0000        	call	c_lgadc
 628  0231 96            	ldw	x,sp
 629  0232 1c0001        	addw	x,#OFST-15
 630  0235 cd0000        	call	c_ladd
 632  0238 be02          	ldw	x,c_lreg+2
 633  023a a63c          	ld	a,#60
 634  023c f7            	ld	(x),a
 635                     ; 205 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punClientIdentifier));
 637  023d 1e15          	ldw	x,(OFST+5,sp)
 638  023f cd0000        	call	_strlen
 640  0242 cd0000        	call	c_uitolx
 642  0245 be02          	ldw	x,c_lreg+2
 643  0247 89            	pushw	x
 644  0248 be00          	ldw	x,c_lreg
 645  024a 89            	pushw	x
 646  024b cd0000        	call	_punEncodeLength
 648  024e 5b04          	addw	sp,#4
 649  0250 1f09          	ldw	(OFST-7,sp),x
 651                     ; 206 	i = strlen( ( const char* )ptr);
 653  0252 1e09          	ldw	x,(OFST-7,sp)
 654  0254 cd0000        	call	_strlen
 656  0257 01            	rrwa	x,a
 657  0258 6b0b          	ld	(OFST-5,sp),a
 658  025a 02            	rlwa	x,a
 660                     ; 207 	if(i < 2)
 662  025b 7b0b          	ld	a,(OFST-5,sp)
 663  025d a102          	cp	a,#2
 664  025f 2452          	jruge	L341
 665                     ; 209 		punBuffer[ulTotalPacketLength++] = 0;
 667  0261 1e11          	ldw	x,(OFST+1,sp)
 668  0263 cd0000        	call	c_uitolx
 670  0266 96            	ldw	x,sp
 671  0267 1c0001        	addw	x,#OFST-15
 672  026a cd0000        	call	c_rtol
 675  026d 96            	ldw	x,sp
 676  026e 1c000c        	addw	x,#OFST-4
 677  0271 cd0000        	call	c_ltor
 679  0274 96            	ldw	x,sp
 680  0275 1c000c        	addw	x,#OFST-4
 681  0278 a601          	ld	a,#1
 682  027a cd0000        	call	c_lgadc
 685  027d 96            	ldw	x,sp
 686  027e 1c0001        	addw	x,#OFST-15
 687  0281 cd0000        	call	c_ladd
 689  0284 be02          	ldw	x,c_lreg+2
 690  0286 7f            	clr	(x)
 691                     ; 210 		punBuffer[ulTotalPacketLength++] = *(ptr);
 693  0287 1e11          	ldw	x,(OFST+1,sp)
 694  0289 cd0000        	call	c_uitolx
 696  028c 96            	ldw	x,sp
 697  028d 1c0001        	addw	x,#OFST-15
 698  0290 cd0000        	call	c_rtol
 701  0293 96            	ldw	x,sp
 702  0294 1c000c        	addw	x,#OFST-4
 703  0297 cd0000        	call	c_ltor
 705  029a 96            	ldw	x,sp
 706  029b 1c000c        	addw	x,#OFST-4
 707  029e a601          	ld	a,#1
 708  02a0 cd0000        	call	c_lgadc
 711  02a3 96            	ldw	x,sp
 712  02a4 1c0001        	addw	x,#OFST-15
 713  02a7 cd0000        	call	c_ladd
 715  02aa be02          	ldw	x,c_lreg+2
 716  02ac 1609          	ldw	y,(OFST-7,sp)
 717  02ae 90f6          	ld	a,(y)
 718  02b0 f7            	ld	(x),a
 720  02b1 2055          	jra	L541
 721  02b3               L341:
 722                     ; 214 		punBuffer[ulTotalPacketLength++] = *(ptr);
 724  02b3 1e11          	ldw	x,(OFST+1,sp)
 725  02b5 cd0000        	call	c_uitolx
 727  02b8 96            	ldw	x,sp
 728  02b9 1c0001        	addw	x,#OFST-15
 729  02bc cd0000        	call	c_rtol
 732  02bf 96            	ldw	x,sp
 733  02c0 1c000c        	addw	x,#OFST-4
 734  02c3 cd0000        	call	c_ltor
 736  02c6 96            	ldw	x,sp
 737  02c7 1c000c        	addw	x,#OFST-4
 738  02ca a601          	ld	a,#1
 739  02cc cd0000        	call	c_lgadc
 742  02cf 96            	ldw	x,sp
 743  02d0 1c0001        	addw	x,#OFST-15
 744  02d3 cd0000        	call	c_ladd
 746  02d6 be02          	ldw	x,c_lreg+2
 747  02d8 1609          	ldw	y,(OFST-7,sp)
 748  02da 90f6          	ld	a,(y)
 749  02dc f7            	ld	(x),a
 750                     ; 215 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
 752  02dd 1e11          	ldw	x,(OFST+1,sp)
 753  02df cd0000        	call	c_uitolx
 755  02e2 96            	ldw	x,sp
 756  02e3 1c0001        	addw	x,#OFST-15
 757  02e6 cd0000        	call	c_rtol
 760  02e9 96            	ldw	x,sp
 761  02ea 1c000c        	addw	x,#OFST-4
 762  02ed cd0000        	call	c_ltor
 764  02f0 96            	ldw	x,sp
 765  02f1 1c000c        	addw	x,#OFST-4
 766  02f4 a601          	ld	a,#1
 767  02f6 cd0000        	call	c_lgadc
 770  02f9 96            	ldw	x,sp
 771  02fa 1c0001        	addw	x,#OFST-15
 772  02fd cd0000        	call	c_ladd
 774  0300 be02          	ldw	x,c_lreg+2
 775  0302 1609          	ldw	y,(OFST-7,sp)
 776  0304 90e601        	ld	a,(1,y)
 777  0307 f7            	ld	(x),a
 778  0308               L541:
 779                     ; 217 	i = strlen( ( const char* )punClientIdentifier);
 781  0308 1e15          	ldw	x,(OFST+5,sp)
 782  030a cd0000        	call	_strlen
 784  030d 01            	rrwa	x,a
 785  030e 6b0b          	ld	(OFST-5,sp),a
 786  0310 02            	rlwa	x,a
 788                     ; 218 	for ( j = 0; j < i; j++)
 790  0311 0f10          	clr	(OFST+0,sp)
 793  0313 2036          	jra	L351
 794  0315               L741:
 795                     ; 220 		punBuffer[ulTotalPacketLength++] = punClientIdentifier[j];
 797  0315 1e11          	ldw	x,(OFST+1,sp)
 798  0317 cd0000        	call	c_uitolx
 800  031a 96            	ldw	x,sp
 801  031b 1c0001        	addw	x,#OFST-15
 802  031e cd0000        	call	c_rtol
 805  0321 96            	ldw	x,sp
 806  0322 1c000c        	addw	x,#OFST-4
 807  0325 cd0000        	call	c_ltor
 809  0328 96            	ldw	x,sp
 810  0329 1c000c        	addw	x,#OFST-4
 811  032c a601          	ld	a,#1
 812  032e cd0000        	call	c_lgadc
 815  0331 96            	ldw	x,sp
 816  0332 1c0001        	addw	x,#OFST-15
 817  0335 cd0000        	call	c_ladd
 819  0338 be02          	ldw	x,c_lreg+2
 820  033a 89            	pushw	x
 821  033b 7b17          	ld	a,(OFST+7,sp)
 822  033d 97            	ld	xl,a
 823  033e 7b18          	ld	a,(OFST+8,sp)
 824  0340 1b12          	add	a,(OFST+2,sp)
 825  0342 2401          	jrnc	L21
 826  0344 5c            	incw	x
 827  0345               L21:
 828  0345 02            	rlwa	x,a
 829  0346 f6            	ld	a,(x)
 830  0347 85            	popw	x
 831  0348 f7            	ld	(x),a
 832                     ; 218 	for ( j = 0; j < i; j++)
 834  0349 0c10          	inc	(OFST+0,sp)
 836  034b               L351:
 839  034b 7b10          	ld	a,(OFST+0,sp)
 840  034d 110b          	cp	a,(OFST-5,sp)
 841  034f 25c4          	jrult	L741
 842                     ; 298 	punBuffer[ulTotalPacketLength]	=	'\0';
 844  0351 1e11          	ldw	x,(OFST+1,sp)
 845  0353 72fb0e        	addw	x,(OFST-2,sp)
 846  0356 7f            	clr	(x)
 847                     ; 300 	return ulTotalPacketLength;
 849  0357 96            	ldw	x,sp
 850  0358 1c000c        	addw	x,#OFST-4
 851  035b cd0000        	call	c_ltor
 855  035e 5b12          	addw	sp,#18
 856  0360 81            	ret
1161                     ; 303 uint32_t ulMQTT_Publish ( uint8_t *punBuffer, uint8_t *punTopic, uint8_t *punMessage/*, enMQTT_CTRL_PKT_FLAGS ePublishFlags*/ )
1161                     ; 304 {
1162                     	switch	.text
1163  0361               _ulMQTT_Publish:
1165  0361 89            	pushw	x
1166  0362 5210          	subw	sp,#16
1167       00000010      OFST:	set	16
1170                     ; 305 	uint32_t ulTotalPacketLength	= 0;
1172  0364 ae0000        	ldw	x,#0
1173  0367 1f0d          	ldw	(OFST-3,sp),x
1174  0369 ae0000        	ldw	x,#0
1175  036c 1f0b          	ldw	(OFST-5,sp),x
1177                     ; 306 	uint32_t ulRemainingLength		= 0;
1179  036e ae0000        	ldw	x,#0
1180  0371 1f07          	ldw	(OFST-9,sp),x
1181  0373 ae0000        	ldw	x,#0
1182  0376 1f05          	ldw	(OFST-11,sp),x
1184                     ; 307 	uint8_t i = 0, j = 0, *ptr;
1188                     ; 309 	enum MQTT_CTRL_PKT_FLAGS_ENUM ePublishFlags = eCTRL_PKT_FLAG_PUBLISH_D0_0_R0;
1190  0378 0f0f          	clr	(OFST-1,sp)
1192                     ; 313 	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_PUBLISH & 0xF) << 4 ) & 0xF0) | (( (uint8_t)ePublishFlags & 0x0F) );
1194  037a 1e11          	ldw	x,(OFST+1,sp)
1195  037c cd0000        	call	c_uitolx
1197  037f 96            	ldw	x,sp
1198  0380 1c0001        	addw	x,#OFST-15
1199  0383 cd0000        	call	c_rtol
1202  0386 96            	ldw	x,sp
1203  0387 1c000b        	addw	x,#OFST-5
1204  038a cd0000        	call	c_ltor
1206  038d 96            	ldw	x,sp
1207  038e 1c000b        	addw	x,#OFST-5
1208  0391 a601          	ld	a,#1
1209  0393 cd0000        	call	c_lgadc
1212  0396 96            	ldw	x,sp
1213  0397 1c0001        	addw	x,#OFST-15
1214  039a cd0000        	call	c_ladd
1216  039d be02          	ldw	x,c_lreg+2
1217  039f a630          	ld	a,#48
1218  03a1 f7            	ld	(x),a
1219                     ; 316 	ulRemainingLength	+=	2;	//Variable Header: Topic Name Length size in 2 Bytes
1221  03a2 96            	ldw	x,sp
1222  03a3 1c0005        	addw	x,#OFST-11
1223  03a6 a602          	ld	a,#2
1224  03a8 cd0000        	call	c_lgadc
1227                     ; 317 	ulRemainingLength	+=	strlen( ( const char* )punTopic);	//Variable Header: Topic Name
1229  03ab 1e15          	ldw	x,(OFST+5,sp)
1230  03ad cd0000        	call	_strlen
1232  03b0 cd0000        	call	c_uitolx
1234  03b3 96            	ldw	x,sp
1235  03b4 1c0005        	addw	x,#OFST-11
1236  03b7 cd0000        	call	c_lgadd
1239                     ; 318 	if( (ePublishFlags & 0x06) != 0 )	// Check if QOS-1 or QOS-2 is selected
1241  03ba 7b0f          	ld	a,(OFST-1,sp)
1242  03bc a506          	bcp	a,#6
1243  03be 2709          	jreq	L713
1244                     ; 320 		ulRemainingLength	+=	2;	//Variable Header: Packet Identifier Length which is 2 Bytes
1246  03c0 96            	ldw	x,sp
1247  03c1 1c0005        	addw	x,#OFST-11
1248  03c4 a602          	ld	a,#2
1249  03c6 cd0000        	call	c_lgadc
1252  03c9               L713:
1253                     ; 322 	ulRemainingLength	+=	strlen( ( const char* )punMessage);	//Payload: Message Length in Bytes
1255  03c9 1e17          	ldw	x,(OFST+7,sp)
1256  03cb cd0000        	call	_strlen
1258  03ce cd0000        	call	c_uitolx
1260  03d1 96            	ldw	x,sp
1261  03d2 1c0005        	addw	x,#OFST-11
1262  03d5 cd0000        	call	c_lgadd
1265                     ; 325 	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
1267  03d8 1e07          	ldw	x,(OFST-9,sp)
1268  03da 89            	pushw	x
1269  03db 1e07          	ldw	x,(OFST-9,sp)
1270  03dd 89            	pushw	x
1271  03de cd0000        	call	_punEncodeLength
1273  03e1 5b04          	addw	sp,#4
1274  03e3 1f09          	ldw	(OFST-7,sp),x
1276                     ; 326 	i = strlen( ( const char* )ptr);
1278  03e5 1e09          	ldw	x,(OFST-7,sp)
1279  03e7 cd0000        	call	_strlen
1281  03ea 01            	rrwa	x,a
1282  03eb 6b0f          	ld	(OFST-1,sp),a
1283  03ed 02            	rlwa	x,a
1285                     ; 327 	for ( j = 0; j < i; j++)
1287  03ee 0f10          	clr	(OFST+0,sp)
1290  03f0 2036          	jra	L523
1291  03f2               L123:
1292                     ; 329 		punBuffer[ulTotalPacketLength++] = *(ptr + j);
1294  03f2 1e11          	ldw	x,(OFST+1,sp)
1295  03f4 cd0000        	call	c_uitolx
1297  03f7 96            	ldw	x,sp
1298  03f8 1c0001        	addw	x,#OFST-15
1299  03fb cd0000        	call	c_rtol
1302  03fe 96            	ldw	x,sp
1303  03ff 1c000b        	addw	x,#OFST-5
1304  0402 cd0000        	call	c_ltor
1306  0405 96            	ldw	x,sp
1307  0406 1c000b        	addw	x,#OFST-5
1308  0409 a601          	ld	a,#1
1309  040b cd0000        	call	c_lgadc
1312  040e 96            	ldw	x,sp
1313  040f 1c0001        	addw	x,#OFST-15
1314  0412 cd0000        	call	c_ladd
1316  0415 be02          	ldw	x,c_lreg+2
1317  0417 89            	pushw	x
1318  0418 7b0b          	ld	a,(OFST-5,sp)
1319  041a 97            	ld	xl,a
1320  041b 7b0c          	ld	a,(OFST-4,sp)
1321  041d 1b12          	add	a,(OFST+2,sp)
1322  041f 2401          	jrnc	L61
1323  0421 5c            	incw	x
1324  0422               L61:
1325  0422 02            	rlwa	x,a
1326  0423 f6            	ld	a,(x)
1327  0424 85            	popw	x
1328  0425 f7            	ld	(x),a
1329                     ; 327 	for ( j = 0; j < i; j++)
1331  0426 0c10          	inc	(OFST+0,sp)
1333  0428               L523:
1336  0428 7b10          	ld	a,(OFST+0,sp)
1337  042a 110f          	cp	a,(OFST-1,sp)
1338  042c 25c4          	jrult	L123
1339                     ; 332 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
1341  042e 1e15          	ldw	x,(OFST+5,sp)
1342  0430 cd0000        	call	_strlen
1344  0433 cd0000        	call	c_uitolx
1346  0436 be02          	ldw	x,c_lreg+2
1347  0438 89            	pushw	x
1348  0439 be00          	ldw	x,c_lreg
1349  043b 89            	pushw	x
1350  043c cd0000        	call	_punEncodeLength
1352  043f 5b04          	addw	sp,#4
1353  0441 1f09          	ldw	(OFST-7,sp),x
1355                     ; 333 	i = strlen( ( const char* )ptr);
1357  0443 1e09          	ldw	x,(OFST-7,sp)
1358  0445 cd0000        	call	_strlen
1360  0448 01            	rrwa	x,a
1361  0449 6b0f          	ld	(OFST-1,sp),a
1362  044b 02            	rlwa	x,a
1364                     ; 334 	if(i < 2)
1366  044c 7b0f          	ld	a,(OFST-1,sp)
1367  044e a102          	cp	a,#2
1368  0450 2452          	jruge	L133
1369                     ; 336 		punBuffer[ulTotalPacketLength++] = 0;
1371  0452 1e11          	ldw	x,(OFST+1,sp)
1372  0454 cd0000        	call	c_uitolx
1374  0457 96            	ldw	x,sp
1375  0458 1c0001        	addw	x,#OFST-15
1376  045b cd0000        	call	c_rtol
1379  045e 96            	ldw	x,sp
1380  045f 1c000b        	addw	x,#OFST-5
1381  0462 cd0000        	call	c_ltor
1383  0465 96            	ldw	x,sp
1384  0466 1c000b        	addw	x,#OFST-5
1385  0469 a601          	ld	a,#1
1386  046b cd0000        	call	c_lgadc
1389  046e 96            	ldw	x,sp
1390  046f 1c0001        	addw	x,#OFST-15
1391  0472 cd0000        	call	c_ladd
1393  0475 be02          	ldw	x,c_lreg+2
1394  0477 7f            	clr	(x)
1395                     ; 337 		punBuffer[ulTotalPacketLength++] = *(ptr);
1397  0478 1e11          	ldw	x,(OFST+1,sp)
1398  047a cd0000        	call	c_uitolx
1400  047d 96            	ldw	x,sp
1401  047e 1c0001        	addw	x,#OFST-15
1402  0481 cd0000        	call	c_rtol
1405  0484 96            	ldw	x,sp
1406  0485 1c000b        	addw	x,#OFST-5
1407  0488 cd0000        	call	c_ltor
1409  048b 96            	ldw	x,sp
1410  048c 1c000b        	addw	x,#OFST-5
1411  048f a601          	ld	a,#1
1412  0491 cd0000        	call	c_lgadc
1415  0494 96            	ldw	x,sp
1416  0495 1c0001        	addw	x,#OFST-15
1417  0498 cd0000        	call	c_ladd
1419  049b be02          	ldw	x,c_lreg+2
1420  049d 1609          	ldw	y,(OFST-7,sp)
1421  049f 90f6          	ld	a,(y)
1422  04a1 f7            	ld	(x),a
1424  04a2 2055          	jra	L333
1425  04a4               L133:
1426                     ; 341 		punBuffer[ulTotalPacketLength++] = *(ptr);
1428  04a4 1e11          	ldw	x,(OFST+1,sp)
1429  04a6 cd0000        	call	c_uitolx
1431  04a9 96            	ldw	x,sp
1432  04aa 1c0001        	addw	x,#OFST-15
1433  04ad cd0000        	call	c_rtol
1436  04b0 96            	ldw	x,sp
1437  04b1 1c000b        	addw	x,#OFST-5
1438  04b4 cd0000        	call	c_ltor
1440  04b7 96            	ldw	x,sp
1441  04b8 1c000b        	addw	x,#OFST-5
1442  04bb a601          	ld	a,#1
1443  04bd cd0000        	call	c_lgadc
1446  04c0 96            	ldw	x,sp
1447  04c1 1c0001        	addw	x,#OFST-15
1448  04c4 cd0000        	call	c_ladd
1450  04c7 be02          	ldw	x,c_lreg+2
1451  04c9 1609          	ldw	y,(OFST-7,sp)
1452  04cb 90f6          	ld	a,(y)
1453  04cd f7            	ld	(x),a
1454                     ; 342 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
1456  04ce 1e11          	ldw	x,(OFST+1,sp)
1457  04d0 cd0000        	call	c_uitolx
1459  04d3 96            	ldw	x,sp
1460  04d4 1c0001        	addw	x,#OFST-15
1461  04d7 cd0000        	call	c_rtol
1464  04da 96            	ldw	x,sp
1465  04db 1c000b        	addw	x,#OFST-5
1466  04de cd0000        	call	c_ltor
1468  04e1 96            	ldw	x,sp
1469  04e2 1c000b        	addw	x,#OFST-5
1470  04e5 a601          	ld	a,#1
1471  04e7 cd0000        	call	c_lgadc
1474  04ea 96            	ldw	x,sp
1475  04eb 1c0001        	addw	x,#OFST-15
1476  04ee cd0000        	call	c_ladd
1478  04f1 be02          	ldw	x,c_lreg+2
1479  04f3 1609          	ldw	y,(OFST-7,sp)
1480  04f5 90e601        	ld	a,(1,y)
1481  04f8 f7            	ld	(x),a
1482  04f9               L333:
1483                     ; 344 	i = strlen( ( const char* )punTopic);
1485  04f9 1e15          	ldw	x,(OFST+5,sp)
1486  04fb cd0000        	call	_strlen
1488  04fe 01            	rrwa	x,a
1489  04ff 6b0f          	ld	(OFST-1,sp),a
1490  0501 02            	rlwa	x,a
1492                     ; 345 	for ( j = 0; j < i; j++)
1494  0502 0f10          	clr	(OFST+0,sp)
1497  0504 2036          	jra	L143
1498  0506               L533:
1499                     ; 347 		punBuffer[ulTotalPacketLength++] = punTopic[j];
1501  0506 1e11          	ldw	x,(OFST+1,sp)
1502  0508 cd0000        	call	c_uitolx
1504  050b 96            	ldw	x,sp
1505  050c 1c0001        	addw	x,#OFST-15
1506  050f cd0000        	call	c_rtol
1509  0512 96            	ldw	x,sp
1510  0513 1c000b        	addw	x,#OFST-5
1511  0516 cd0000        	call	c_ltor
1513  0519 96            	ldw	x,sp
1514  051a 1c000b        	addw	x,#OFST-5
1515  051d a601          	ld	a,#1
1516  051f cd0000        	call	c_lgadc
1519  0522 96            	ldw	x,sp
1520  0523 1c0001        	addw	x,#OFST-15
1521  0526 cd0000        	call	c_ladd
1523  0529 be02          	ldw	x,c_lreg+2
1524  052b 89            	pushw	x
1525  052c 7b17          	ld	a,(OFST+7,sp)
1526  052e 97            	ld	xl,a
1527  052f 7b18          	ld	a,(OFST+8,sp)
1528  0531 1b12          	add	a,(OFST+2,sp)
1529  0533 2401          	jrnc	L02
1530  0535 5c            	incw	x
1531  0536               L02:
1532  0536 02            	rlwa	x,a
1533  0537 f6            	ld	a,(x)
1534  0538 85            	popw	x
1535  0539 f7            	ld	(x),a
1536                     ; 345 	for ( j = 0; j < i; j++)
1538  053a 0c10          	inc	(OFST+0,sp)
1540  053c               L143:
1543  053c 7b10          	ld	a,(OFST+0,sp)
1544  053e 110f          	cp	a,(OFST-1,sp)
1545  0540 25c4          	jrult	L533
1546                     ; 357 	i = strlen( ( const char* )punMessage);
1548  0542 1e17          	ldw	x,(OFST+7,sp)
1549  0544 cd0000        	call	_strlen
1551  0547 01            	rrwa	x,a
1552  0548 6b0f          	ld	(OFST-1,sp),a
1553  054a 02            	rlwa	x,a
1555                     ; 358 	for ( j = 0; j < i; j++)
1557  054b 0f10          	clr	(OFST+0,sp)
1560  054d 2036          	jra	L153
1561  054f               L543:
1562                     ; 360 		punBuffer[ulTotalPacketLength++] = punMessage[j];
1564  054f 1e11          	ldw	x,(OFST+1,sp)
1565  0551 cd0000        	call	c_uitolx
1567  0554 96            	ldw	x,sp
1568  0555 1c0001        	addw	x,#OFST-15
1569  0558 cd0000        	call	c_rtol
1572  055b 96            	ldw	x,sp
1573  055c 1c000b        	addw	x,#OFST-5
1574  055f cd0000        	call	c_ltor
1576  0562 96            	ldw	x,sp
1577  0563 1c000b        	addw	x,#OFST-5
1578  0566 a601          	ld	a,#1
1579  0568 cd0000        	call	c_lgadc
1582  056b 96            	ldw	x,sp
1583  056c 1c0001        	addw	x,#OFST-15
1584  056f cd0000        	call	c_ladd
1586  0572 be02          	ldw	x,c_lreg+2
1587  0574 89            	pushw	x
1588  0575 7b19          	ld	a,(OFST+9,sp)
1589  0577 97            	ld	xl,a
1590  0578 7b1a          	ld	a,(OFST+10,sp)
1591  057a 1b12          	add	a,(OFST+2,sp)
1592  057c 2401          	jrnc	L22
1593  057e 5c            	incw	x
1594  057f               L22:
1595  057f 02            	rlwa	x,a
1596  0580 f6            	ld	a,(x)
1597  0581 85            	popw	x
1598  0582 f7            	ld	(x),a
1599                     ; 358 	for ( j = 0; j < i; j++)
1601  0583 0c10          	inc	(OFST+0,sp)
1603  0585               L153:
1606  0585 7b10          	ld	a,(OFST+0,sp)
1607  0587 110f          	cp	a,(OFST-1,sp)
1608  0589 25c4          	jrult	L543
1609                     ; 363 	punBuffer[ulTotalPacketLength]	=	'\0';
1611  058b 1e11          	ldw	x,(OFST+1,sp)
1612  058d 72fb0d        	addw	x,(OFST-3,sp)
1613  0590 7f            	clr	(x)
1614                     ; 365 	return ulTotalPacketLength;
1616  0591 96            	ldw	x,sp
1617  0592 1c000b        	addw	x,#OFST-5
1618  0595 cd0000        	call	c_ltor
1622  0598 5b12          	addw	sp,#18
1623  059a 81            	ret
1770                     ; 368 uint32_t ulMQTT_Subscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, enMQTT_QOS eQOS, uint16_t udPacketIdentifier*/ )
1770                     ; 369 {
1771                     	switch	.text
1772  059b               _ulMQTT_Subscribe:
1774  059b 89            	pushw	x
1775  059c 5213          	subw	sp,#19
1776       00000013      OFST:	set	19
1779                     ; 370 	uint32_t ulTotalPacketLength	= 0;
1781  059e ae0000        	ldw	x,#0
1782  05a1 1f11          	ldw	(OFST-2,sp),x
1783  05a3 ae0000        	ldw	x,#0
1784  05a6 1f0f          	ldw	(OFST-4,sp),x
1786                     ; 371 	uint32_t ulRemainingLength		= 0;
1788  05a8 ae0000        	ldw	x,#0
1789  05ab 1f0a          	ldw	(OFST-9,sp),x
1790  05ad ae0000        	ldw	x,#0
1791  05b0 1f08          	ldw	(OFST-11,sp),x
1793                     ; 372 	uint8_t i = 0, j = 0, *ptr;
1797                     ; 374 	uint16_t udPacketIdentifier = 1;
1799  05b2 ae0001        	ldw	x,#1
1800  05b5 1f06          	ldw	(OFST-13,sp),x
1802                     ; 375 	enum MQTT_QOS_ENUM eQOS = eQOS_0;
1804  05b7 0f05          	clr	(OFST-14,sp)
1806                     ; 377 	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_SUBSCRIBE & 0xF) << 4 ) & 0xF0) | (( (uint8_t)eCTRL_PKT_FLAG_SUBSCRIBE & 0x0F) );
1808  05b9 1e14          	ldw	x,(OFST+1,sp)
1809  05bb cd0000        	call	c_uitolx
1811  05be 96            	ldw	x,sp
1812  05bf 1c0001        	addw	x,#OFST-18
1813  05c2 cd0000        	call	c_rtol
1816  05c5 96            	ldw	x,sp
1817  05c6 1c000f        	addw	x,#OFST-4
1818  05c9 cd0000        	call	c_ltor
1820  05cc 96            	ldw	x,sp
1821  05cd 1c000f        	addw	x,#OFST-4
1822  05d0 a601          	ld	a,#1
1823  05d2 cd0000        	call	c_lgadc
1826  05d5 96            	ldw	x,sp
1827  05d6 1c0001        	addw	x,#OFST-18
1828  05d9 cd0000        	call	c_ladd
1830  05dc be02          	ldw	x,c_lreg+2
1831  05de a682          	ld	a,#130
1832  05e0 f7            	ld	(x),a
1833                     ; 380 	ulRemainingLength	+=	2;	//Variable Header: Packet Identifier of fixed 2 Bytes
1835  05e1 96            	ldw	x,sp
1836  05e2 1c0008        	addw	x,#OFST-11
1837  05e5 a602          	ld	a,#2
1838  05e7 cd0000        	call	c_lgadc
1841                     ; 381 	ulRemainingLength	+=	2;	//Payload: Topic Name Length which is 2 Bytes
1843  05ea 96            	ldw	x,sp
1844  05eb 1c0008        	addw	x,#OFST-11
1845  05ee a602          	ld	a,#2
1846  05f0 cd0000        	call	c_lgadc
1849                     ; 382 	ulRemainingLength	+=	strlen( ( const char* )punTopic);;	//Payload: Topic Name Length
1851  05f3 1e18          	ldw	x,(OFST+5,sp)
1852  05f5 cd0000        	call	_strlen
1854  05f8 cd0000        	call	c_uitolx
1856  05fb 96            	ldw	x,sp
1857  05fc 1c0008        	addw	x,#OFST-11
1858  05ff cd0000        	call	c_lgadd
1861                     ; 383 	ulRemainingLength	+=	1;	//Payload: Requested QOS Byte
1864  0602 96            	ldw	x,sp
1865  0603 1c0008        	addw	x,#OFST-11
1866  0606 a601          	ld	a,#1
1867  0608 cd0000        	call	c_lgadc
1870                     ; 386 	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
1872  060b 1e0a          	ldw	x,(OFST-9,sp)
1873  060d 89            	pushw	x
1874  060e 1e0a          	ldw	x,(OFST-9,sp)
1875  0610 89            	pushw	x
1876  0611 cd0000        	call	_punEncodeLength
1878  0614 5b04          	addw	sp,#4
1879  0616 1f0c          	ldw	(OFST-7,sp),x
1881                     ; 387 	i = strlen( ( const char* )ptr);
1883  0618 1e0c          	ldw	x,(OFST-7,sp)
1884  061a cd0000        	call	_strlen
1886  061d 01            	rrwa	x,a
1887  061e 6b0e          	ld	(OFST-5,sp),a
1888  0620 02            	rlwa	x,a
1890                     ; 388 	for ( j = 0; j < i; j++)
1892  0621 0f13          	clr	(OFST+0,sp)
1895  0623 2036          	jra	L354
1896  0625               L744:
1897                     ; 390 		punBuffer[ulTotalPacketLength++] = *(ptr + j);
1899  0625 1e14          	ldw	x,(OFST+1,sp)
1900  0627 cd0000        	call	c_uitolx
1902  062a 96            	ldw	x,sp
1903  062b 1c0001        	addw	x,#OFST-18
1904  062e cd0000        	call	c_rtol
1907  0631 96            	ldw	x,sp
1908  0632 1c000f        	addw	x,#OFST-4
1909  0635 cd0000        	call	c_ltor
1911  0638 96            	ldw	x,sp
1912  0639 1c000f        	addw	x,#OFST-4
1913  063c a601          	ld	a,#1
1914  063e cd0000        	call	c_lgadc
1917  0641 96            	ldw	x,sp
1918  0642 1c0001        	addw	x,#OFST-18
1919  0645 cd0000        	call	c_ladd
1921  0648 be02          	ldw	x,c_lreg+2
1922  064a 89            	pushw	x
1923  064b 7b0e          	ld	a,(OFST-5,sp)
1924  064d 97            	ld	xl,a
1925  064e 7b0f          	ld	a,(OFST-4,sp)
1926  0650 1b15          	add	a,(OFST+2,sp)
1927  0652 2401          	jrnc	L62
1928  0654 5c            	incw	x
1929  0655               L62:
1930  0655 02            	rlwa	x,a
1931  0656 f6            	ld	a,(x)
1932  0657 85            	popw	x
1933  0658 f7            	ld	(x),a
1934                     ; 388 	for ( j = 0; j < i; j++)
1936  0659 0c13          	inc	(OFST+0,sp)
1938  065b               L354:
1941  065b 7b13          	ld	a,(OFST+0,sp)
1942  065d 110e          	cp	a,(OFST-5,sp)
1943  065f 25c4          	jrult	L744
1944                     ; 394 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	8 ) & 0xFF;	// Most Significant Byte
1946  0661 1e14          	ldw	x,(OFST+1,sp)
1947  0663 cd0000        	call	c_uitolx
1949  0666 96            	ldw	x,sp
1950  0667 1c0001        	addw	x,#OFST-18
1951  066a cd0000        	call	c_rtol
1954  066d 96            	ldw	x,sp
1955  066e 1c000f        	addw	x,#OFST-4
1956  0671 cd0000        	call	c_ltor
1958  0674 96            	ldw	x,sp
1959  0675 1c000f        	addw	x,#OFST-4
1960  0678 a601          	ld	a,#1
1961  067a cd0000        	call	c_lgadc
1964  067d 96            	ldw	x,sp
1965  067e 1c0001        	addw	x,#OFST-18
1966  0681 cd0000        	call	c_ladd
1968  0684 be02          	ldw	x,c_lreg+2
1969  0686 7b06          	ld	a,(OFST-13,sp)
1970  0688 f7            	ld	(x),a
1971                     ; 395 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	0 ) & 0xFF;	// Least Significant Byte
1973  0689 1e14          	ldw	x,(OFST+1,sp)
1974  068b cd0000        	call	c_uitolx
1976  068e 96            	ldw	x,sp
1977  068f 1c0001        	addw	x,#OFST-18
1978  0692 cd0000        	call	c_rtol
1981  0695 96            	ldw	x,sp
1982  0696 1c000f        	addw	x,#OFST-4
1983  0699 cd0000        	call	c_ltor
1985  069c 96            	ldw	x,sp
1986  069d 1c000f        	addw	x,#OFST-4
1987  06a0 a601          	ld	a,#1
1988  06a2 cd0000        	call	c_lgadc
1991  06a5 96            	ldw	x,sp
1992  06a6 1c0001        	addw	x,#OFST-18
1993  06a9 cd0000        	call	c_ladd
1995  06ac be02          	ldw	x,c_lreg+2
1996  06ae 7b07          	ld	a,(OFST-12,sp)
1997  06b0 a4ff          	and	a,#255
1998  06b2 f7            	ld	(x),a
1999                     ; 398 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
2001  06b3 1e18          	ldw	x,(OFST+5,sp)
2002  06b5 cd0000        	call	_strlen
2004  06b8 cd0000        	call	c_uitolx
2006  06bb be02          	ldw	x,c_lreg+2
2007  06bd 89            	pushw	x
2008  06be be00          	ldw	x,c_lreg
2009  06c0 89            	pushw	x
2010  06c1 cd0000        	call	_punEncodeLength
2012  06c4 5b04          	addw	sp,#4
2013  06c6 1f0c          	ldw	(OFST-7,sp),x
2015                     ; 399 	i = strlen( ( const char* )ptr);
2017  06c8 1e0c          	ldw	x,(OFST-7,sp)
2018  06ca cd0000        	call	_strlen
2020  06cd 01            	rrwa	x,a
2021  06ce 6b0e          	ld	(OFST-5,sp),a
2022  06d0 02            	rlwa	x,a
2024                     ; 400 	if(i < 2)
2026  06d1 7b0e          	ld	a,(OFST-5,sp)
2027  06d3 a102          	cp	a,#2
2028  06d5 2452          	jruge	L754
2029                     ; 402 		punBuffer[ulTotalPacketLength++] = 0;
2031  06d7 1e14          	ldw	x,(OFST+1,sp)
2032  06d9 cd0000        	call	c_uitolx
2034  06dc 96            	ldw	x,sp
2035  06dd 1c0001        	addw	x,#OFST-18
2036  06e0 cd0000        	call	c_rtol
2039  06e3 96            	ldw	x,sp
2040  06e4 1c000f        	addw	x,#OFST-4
2041  06e7 cd0000        	call	c_ltor
2043  06ea 96            	ldw	x,sp
2044  06eb 1c000f        	addw	x,#OFST-4
2045  06ee a601          	ld	a,#1
2046  06f0 cd0000        	call	c_lgadc
2049  06f3 96            	ldw	x,sp
2050  06f4 1c0001        	addw	x,#OFST-18
2051  06f7 cd0000        	call	c_ladd
2053  06fa be02          	ldw	x,c_lreg+2
2054  06fc 7f            	clr	(x)
2055                     ; 403 		punBuffer[ulTotalPacketLength++] = *(ptr);
2057  06fd 1e14          	ldw	x,(OFST+1,sp)
2058  06ff cd0000        	call	c_uitolx
2060  0702 96            	ldw	x,sp
2061  0703 1c0001        	addw	x,#OFST-18
2062  0706 cd0000        	call	c_rtol
2065  0709 96            	ldw	x,sp
2066  070a 1c000f        	addw	x,#OFST-4
2067  070d cd0000        	call	c_ltor
2069  0710 96            	ldw	x,sp
2070  0711 1c000f        	addw	x,#OFST-4
2071  0714 a601          	ld	a,#1
2072  0716 cd0000        	call	c_lgadc
2075  0719 96            	ldw	x,sp
2076  071a 1c0001        	addw	x,#OFST-18
2077  071d cd0000        	call	c_ladd
2079  0720 be02          	ldw	x,c_lreg+2
2080  0722 160c          	ldw	y,(OFST-7,sp)
2081  0724 90f6          	ld	a,(y)
2082  0726 f7            	ld	(x),a
2084  0727 2055          	jra	L164
2085  0729               L754:
2086                     ; 407 		punBuffer[ulTotalPacketLength++] = *(ptr);
2088  0729 1e14          	ldw	x,(OFST+1,sp)
2089  072b cd0000        	call	c_uitolx
2091  072e 96            	ldw	x,sp
2092  072f 1c0001        	addw	x,#OFST-18
2093  0732 cd0000        	call	c_rtol
2096  0735 96            	ldw	x,sp
2097  0736 1c000f        	addw	x,#OFST-4
2098  0739 cd0000        	call	c_ltor
2100  073c 96            	ldw	x,sp
2101  073d 1c000f        	addw	x,#OFST-4
2102  0740 a601          	ld	a,#1
2103  0742 cd0000        	call	c_lgadc
2106  0745 96            	ldw	x,sp
2107  0746 1c0001        	addw	x,#OFST-18
2108  0749 cd0000        	call	c_ladd
2110  074c be02          	ldw	x,c_lreg+2
2111  074e 160c          	ldw	y,(OFST-7,sp)
2112  0750 90f6          	ld	a,(y)
2113  0752 f7            	ld	(x),a
2114                     ; 408 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
2116  0753 1e14          	ldw	x,(OFST+1,sp)
2117  0755 cd0000        	call	c_uitolx
2119  0758 96            	ldw	x,sp
2120  0759 1c0001        	addw	x,#OFST-18
2121  075c cd0000        	call	c_rtol
2124  075f 96            	ldw	x,sp
2125  0760 1c000f        	addw	x,#OFST-4
2126  0763 cd0000        	call	c_ltor
2128  0766 96            	ldw	x,sp
2129  0767 1c000f        	addw	x,#OFST-4
2130  076a a601          	ld	a,#1
2131  076c cd0000        	call	c_lgadc
2134  076f 96            	ldw	x,sp
2135  0770 1c0001        	addw	x,#OFST-18
2136  0773 cd0000        	call	c_ladd
2138  0776 be02          	ldw	x,c_lreg+2
2139  0778 160c          	ldw	y,(OFST-7,sp)
2140  077a 90e601        	ld	a,(1,y)
2141  077d f7            	ld	(x),a
2142  077e               L164:
2143                     ; 410 	i = strlen( ( const char* )punTopic);
2145  077e 1e18          	ldw	x,(OFST+5,sp)
2146  0780 cd0000        	call	_strlen
2148  0783 01            	rrwa	x,a
2149  0784 6b0e          	ld	(OFST-5,sp),a
2150  0786 02            	rlwa	x,a
2152                     ; 411 	for ( j = 0; j < i; j++)
2154  0787 0f13          	clr	(OFST+0,sp)
2157  0789 2036          	jra	L764
2158  078b               L364:
2159                     ; 413 		punBuffer[ulTotalPacketLength++] = punTopic[j];
2161  078b 1e14          	ldw	x,(OFST+1,sp)
2162  078d cd0000        	call	c_uitolx
2164  0790 96            	ldw	x,sp
2165  0791 1c0001        	addw	x,#OFST-18
2166  0794 cd0000        	call	c_rtol
2169  0797 96            	ldw	x,sp
2170  0798 1c000f        	addw	x,#OFST-4
2171  079b cd0000        	call	c_ltor
2173  079e 96            	ldw	x,sp
2174  079f 1c000f        	addw	x,#OFST-4
2175  07a2 a601          	ld	a,#1
2176  07a4 cd0000        	call	c_lgadc
2179  07a7 96            	ldw	x,sp
2180  07a8 1c0001        	addw	x,#OFST-18
2181  07ab cd0000        	call	c_ladd
2183  07ae be02          	ldw	x,c_lreg+2
2184  07b0 89            	pushw	x
2185  07b1 7b1a          	ld	a,(OFST+7,sp)
2186  07b3 97            	ld	xl,a
2187  07b4 7b1b          	ld	a,(OFST+8,sp)
2188  07b6 1b15          	add	a,(OFST+2,sp)
2189  07b8 2401          	jrnc	L03
2190  07ba 5c            	incw	x
2191  07bb               L03:
2192  07bb 02            	rlwa	x,a
2193  07bc f6            	ld	a,(x)
2194  07bd 85            	popw	x
2195  07be f7            	ld	(x),a
2196                     ; 411 	for ( j = 0; j < i; j++)
2198  07bf 0c13          	inc	(OFST+0,sp)
2200  07c1               L764:
2203  07c1 7b13          	ld	a,(OFST+0,sp)
2204  07c3 110e          	cp	a,(OFST-5,sp)
2205  07c5 25c4          	jrult	L364
2206                     ; 417 	punBuffer[ulTotalPacketLength++]	=	((uint8_t)eQOS & 0x03);	//	Requested QOS, where bits[1:0] is QOS, and bits[7:2] are reserved 0
2208  07c7 1e14          	ldw	x,(OFST+1,sp)
2209  07c9 cd0000        	call	c_uitolx
2211  07cc 96            	ldw	x,sp
2212  07cd 1c0001        	addw	x,#OFST-18
2213  07d0 cd0000        	call	c_rtol
2216  07d3 96            	ldw	x,sp
2217  07d4 1c000f        	addw	x,#OFST-4
2218  07d7 cd0000        	call	c_ltor
2220  07da 96            	ldw	x,sp
2221  07db 1c000f        	addw	x,#OFST-4
2222  07de a601          	ld	a,#1
2223  07e0 cd0000        	call	c_lgadc
2226  07e3 96            	ldw	x,sp
2227  07e4 1c0001        	addw	x,#OFST-18
2228  07e7 cd0000        	call	c_ladd
2230  07ea be02          	ldw	x,c_lreg+2
2231  07ec 7b05          	ld	a,(OFST-14,sp)
2232  07ee a403          	and	a,#3
2233  07f0 f7            	ld	(x),a
2234                     ; 419 	punBuffer[ulTotalPacketLength]	=	'\0';
2236  07f1 1e14          	ldw	x,(OFST+1,sp)
2237  07f3 72fb11        	addw	x,(OFST-2,sp)
2238  07f6 7f            	clr	(x)
2239                     ; 421 	return ulTotalPacketLength;
2241  07f7 96            	ldw	x,sp
2242  07f8 1c000f        	addw	x,#OFST-4
2243  07fb cd0000        	call	c_ltor
2247  07fe 5b15          	addw	sp,#21
2248  0800 81            	ret
2351                     ; 424 uint32_t ulMQTT_UnSubscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, uint16_t udPacketIdentifier */)
2351                     ; 425 {
2352                     	switch	.text
2353  0801               _ulMQTT_UnSubscribe:
2355  0801 89            	pushw	x
2356  0802 5212          	subw	sp,#18
2357       00000012      OFST:	set	18
2360                     ; 426 	uint32_t ulTotalPacketLength	= 0;
2362  0804 ae0000        	ldw	x,#0
2363  0807 1f10          	ldw	(OFST-2,sp),x
2364  0809 ae0000        	ldw	x,#0
2365  080c 1f0e          	ldw	(OFST-4,sp),x
2367                     ; 427 	uint32_t ulRemainingLength		= 0;
2369  080e ae0000        	ldw	x,#0
2370  0811 1f09          	ldw	(OFST-9,sp),x
2371  0813 ae0000        	ldw	x,#0
2372  0816 1f07          	ldw	(OFST-11,sp),x
2374                     ; 428 	uint8_t i = 0, j = 0, *ptr;
2378                     ; 430 	uint16_t udPacketIdentifier = 1;
2380  0818 ae0001        	ldw	x,#1
2381  081b 1f05          	ldw	(OFST-13,sp),x
2383                     ; 432 	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_UNSUBSCRIBE & 0xF) << 4 ) & 0xF0) | (( (uint8_t)eCTRL_PKT_FLAG_UNSUBSCRIBE & 0x0F) );
2385  081d 1e13          	ldw	x,(OFST+1,sp)
2386  081f cd0000        	call	c_uitolx
2388  0822 96            	ldw	x,sp
2389  0823 1c0001        	addw	x,#OFST-17
2390  0826 cd0000        	call	c_rtol
2393  0829 96            	ldw	x,sp
2394  082a 1c000e        	addw	x,#OFST-4
2395  082d cd0000        	call	c_ltor
2397  0830 96            	ldw	x,sp
2398  0831 1c000e        	addw	x,#OFST-4
2399  0834 a601          	ld	a,#1
2400  0836 cd0000        	call	c_lgadc
2403  0839 96            	ldw	x,sp
2404  083a 1c0001        	addw	x,#OFST-17
2405  083d cd0000        	call	c_ladd
2407  0840 be02          	ldw	x,c_lreg+2
2408  0842 a6a2          	ld	a,#162
2409  0844 f7            	ld	(x),a
2410                     ; 435 	ulRemainingLength	+=	2;	//Variable Header: Packet Identifier of fixed 2 Bytes
2412  0845 96            	ldw	x,sp
2413  0846 1c0007        	addw	x,#OFST-11
2414  0849 a602          	ld	a,#2
2415  084b cd0000        	call	c_lgadc
2418                     ; 436 	ulRemainingLength	+=	2;	//Payload: Topic Name Length which is 2 Bytes
2420  084e 96            	ldw	x,sp
2421  084f 1c0007        	addw	x,#OFST-11
2422  0852 a602          	ld	a,#2
2423  0854 cd0000        	call	c_lgadc
2426                     ; 437 	ulRemainingLength	+=	strlen( ( const char* )punTopic);;	//Payload: Topic Name Length
2428  0857 1e17          	ldw	x,(OFST+5,sp)
2429  0859 cd0000        	call	_strlen
2431  085c cd0000        	call	c_uitolx
2433  085f 96            	ldw	x,sp
2434  0860 1c0007        	addw	x,#OFST-11
2435  0863 cd0000        	call	c_lgadd
2438                     ; 440 	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
2441  0866 1e09          	ldw	x,(OFST-9,sp)
2442  0868 89            	pushw	x
2443  0869 1e09          	ldw	x,(OFST-9,sp)
2444  086b 89            	pushw	x
2445  086c cd0000        	call	_punEncodeLength
2447  086f 5b04          	addw	sp,#4
2448  0871 1f0b          	ldw	(OFST-7,sp),x
2450                     ; 441 	i = strlen( ( const char* )ptr);
2452  0873 1e0b          	ldw	x,(OFST-7,sp)
2453  0875 cd0000        	call	_strlen
2455  0878 01            	rrwa	x,a
2456  0879 6b0d          	ld	(OFST-5,sp),a
2457  087b 02            	rlwa	x,a
2459                     ; 442 	for ( j = 0; j < i; j++)
2461  087c 0f12          	clr	(OFST+0,sp)
2464  087e 2036          	jra	L155
2465  0880               L545:
2466                     ; 444 		punBuffer[ulTotalPacketLength++] = *(ptr + j);
2468  0880 1e13          	ldw	x,(OFST+1,sp)
2469  0882 cd0000        	call	c_uitolx
2471  0885 96            	ldw	x,sp
2472  0886 1c0001        	addw	x,#OFST-17
2473  0889 cd0000        	call	c_rtol
2476  088c 96            	ldw	x,sp
2477  088d 1c000e        	addw	x,#OFST-4
2478  0890 cd0000        	call	c_ltor
2480  0893 96            	ldw	x,sp
2481  0894 1c000e        	addw	x,#OFST-4
2482  0897 a601          	ld	a,#1
2483  0899 cd0000        	call	c_lgadc
2486  089c 96            	ldw	x,sp
2487  089d 1c0001        	addw	x,#OFST-17
2488  08a0 cd0000        	call	c_ladd
2490  08a3 be02          	ldw	x,c_lreg+2
2491  08a5 89            	pushw	x
2492  08a6 7b0d          	ld	a,(OFST-5,sp)
2493  08a8 97            	ld	xl,a
2494  08a9 7b0e          	ld	a,(OFST-4,sp)
2495  08ab 1b14          	add	a,(OFST+2,sp)
2496  08ad 2401          	jrnc	L43
2497  08af 5c            	incw	x
2498  08b0               L43:
2499  08b0 02            	rlwa	x,a
2500  08b1 f6            	ld	a,(x)
2501  08b2 85            	popw	x
2502  08b3 f7            	ld	(x),a
2503                     ; 442 	for ( j = 0; j < i; j++)
2505  08b4 0c12          	inc	(OFST+0,sp)
2507  08b6               L155:
2510  08b6 7b12          	ld	a,(OFST+0,sp)
2511  08b8 110d          	cp	a,(OFST-5,sp)
2512  08ba 25c4          	jrult	L545
2513                     ; 448 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	8 ) & 0xFF;	// Most Significant Byte
2515  08bc 1e13          	ldw	x,(OFST+1,sp)
2516  08be cd0000        	call	c_uitolx
2518  08c1 96            	ldw	x,sp
2519  08c2 1c0001        	addw	x,#OFST-17
2520  08c5 cd0000        	call	c_rtol
2523  08c8 96            	ldw	x,sp
2524  08c9 1c000e        	addw	x,#OFST-4
2525  08cc cd0000        	call	c_ltor
2527  08cf 96            	ldw	x,sp
2528  08d0 1c000e        	addw	x,#OFST-4
2529  08d3 a601          	ld	a,#1
2530  08d5 cd0000        	call	c_lgadc
2533  08d8 96            	ldw	x,sp
2534  08d9 1c0001        	addw	x,#OFST-17
2535  08dc cd0000        	call	c_ladd
2537  08df be02          	ldw	x,c_lreg+2
2538  08e1 7b05          	ld	a,(OFST-13,sp)
2539  08e3 f7            	ld	(x),a
2540                     ; 449 	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	0 ) & 0xFF;	// Least Significant Byte
2542  08e4 1e13          	ldw	x,(OFST+1,sp)
2543  08e6 cd0000        	call	c_uitolx
2545  08e9 96            	ldw	x,sp
2546  08ea 1c0001        	addw	x,#OFST-17
2547  08ed cd0000        	call	c_rtol
2550  08f0 96            	ldw	x,sp
2551  08f1 1c000e        	addw	x,#OFST-4
2552  08f4 cd0000        	call	c_ltor
2554  08f7 96            	ldw	x,sp
2555  08f8 1c000e        	addw	x,#OFST-4
2556  08fb a601          	ld	a,#1
2557  08fd cd0000        	call	c_lgadc
2560  0900 96            	ldw	x,sp
2561  0901 1c0001        	addw	x,#OFST-17
2562  0904 cd0000        	call	c_ladd
2564  0907 be02          	ldw	x,c_lreg+2
2565  0909 7b06          	ld	a,(OFST-12,sp)
2566  090b a4ff          	and	a,#255
2567  090d f7            	ld	(x),a
2568                     ; 452 	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
2570  090e 1e17          	ldw	x,(OFST+5,sp)
2571  0910 cd0000        	call	_strlen
2573  0913 cd0000        	call	c_uitolx
2575  0916 be02          	ldw	x,c_lreg+2
2576  0918 89            	pushw	x
2577  0919 be00          	ldw	x,c_lreg
2578  091b 89            	pushw	x
2579  091c cd0000        	call	_punEncodeLength
2581  091f 5b04          	addw	sp,#4
2582  0921 1f0b          	ldw	(OFST-7,sp),x
2584                     ; 453 	i = strlen( ( const char* )ptr);
2586  0923 1e0b          	ldw	x,(OFST-7,sp)
2587  0925 cd0000        	call	_strlen
2589  0928 01            	rrwa	x,a
2590  0929 6b0d          	ld	(OFST-5,sp),a
2591  092b 02            	rlwa	x,a
2593                     ; 454 	if(i < 2)
2595  092c 7b0d          	ld	a,(OFST-5,sp)
2596  092e a102          	cp	a,#2
2597  0930 2452          	jruge	L555
2598                     ; 456 		punBuffer[ulTotalPacketLength++] = 0;
2600  0932 1e13          	ldw	x,(OFST+1,sp)
2601  0934 cd0000        	call	c_uitolx
2603  0937 96            	ldw	x,sp
2604  0938 1c0001        	addw	x,#OFST-17
2605  093b cd0000        	call	c_rtol
2608  093e 96            	ldw	x,sp
2609  093f 1c000e        	addw	x,#OFST-4
2610  0942 cd0000        	call	c_ltor
2612  0945 96            	ldw	x,sp
2613  0946 1c000e        	addw	x,#OFST-4
2614  0949 a601          	ld	a,#1
2615  094b cd0000        	call	c_lgadc
2618  094e 96            	ldw	x,sp
2619  094f 1c0001        	addw	x,#OFST-17
2620  0952 cd0000        	call	c_ladd
2622  0955 be02          	ldw	x,c_lreg+2
2623  0957 7f            	clr	(x)
2624                     ; 457 		punBuffer[ulTotalPacketLength++] = *(ptr);
2626  0958 1e13          	ldw	x,(OFST+1,sp)
2627  095a cd0000        	call	c_uitolx
2629  095d 96            	ldw	x,sp
2630  095e 1c0001        	addw	x,#OFST-17
2631  0961 cd0000        	call	c_rtol
2634  0964 96            	ldw	x,sp
2635  0965 1c000e        	addw	x,#OFST-4
2636  0968 cd0000        	call	c_ltor
2638  096b 96            	ldw	x,sp
2639  096c 1c000e        	addw	x,#OFST-4
2640  096f a601          	ld	a,#1
2641  0971 cd0000        	call	c_lgadc
2644  0974 96            	ldw	x,sp
2645  0975 1c0001        	addw	x,#OFST-17
2646  0978 cd0000        	call	c_ladd
2648  097b be02          	ldw	x,c_lreg+2
2649  097d 160b          	ldw	y,(OFST-7,sp)
2650  097f 90f6          	ld	a,(y)
2651  0981 f7            	ld	(x),a
2653  0982 2055          	jra	L755
2654  0984               L555:
2655                     ; 461 		punBuffer[ulTotalPacketLength++] = *(ptr);
2657  0984 1e13          	ldw	x,(OFST+1,sp)
2658  0986 cd0000        	call	c_uitolx
2660  0989 96            	ldw	x,sp
2661  098a 1c0001        	addw	x,#OFST-17
2662  098d cd0000        	call	c_rtol
2665  0990 96            	ldw	x,sp
2666  0991 1c000e        	addw	x,#OFST-4
2667  0994 cd0000        	call	c_ltor
2669  0997 96            	ldw	x,sp
2670  0998 1c000e        	addw	x,#OFST-4
2671  099b a601          	ld	a,#1
2672  099d cd0000        	call	c_lgadc
2675  09a0 96            	ldw	x,sp
2676  09a1 1c0001        	addw	x,#OFST-17
2677  09a4 cd0000        	call	c_ladd
2679  09a7 be02          	ldw	x,c_lreg+2
2680  09a9 160b          	ldw	y,(OFST-7,sp)
2681  09ab 90f6          	ld	a,(y)
2682  09ad f7            	ld	(x),a
2683                     ; 462 		punBuffer[ulTotalPacketLength++] = *(ptr+1);
2685  09ae 1e13          	ldw	x,(OFST+1,sp)
2686  09b0 cd0000        	call	c_uitolx
2688  09b3 96            	ldw	x,sp
2689  09b4 1c0001        	addw	x,#OFST-17
2690  09b7 cd0000        	call	c_rtol
2693  09ba 96            	ldw	x,sp
2694  09bb 1c000e        	addw	x,#OFST-4
2695  09be cd0000        	call	c_ltor
2697  09c1 96            	ldw	x,sp
2698  09c2 1c000e        	addw	x,#OFST-4
2699  09c5 a601          	ld	a,#1
2700  09c7 cd0000        	call	c_lgadc
2703  09ca 96            	ldw	x,sp
2704  09cb 1c0001        	addw	x,#OFST-17
2705  09ce cd0000        	call	c_ladd
2707  09d1 be02          	ldw	x,c_lreg+2
2708  09d3 160b          	ldw	y,(OFST-7,sp)
2709  09d5 90e601        	ld	a,(1,y)
2710  09d8 f7            	ld	(x),a
2711  09d9               L755:
2712                     ; 464 	i = strlen( ( const char* )punTopic);
2714  09d9 1e17          	ldw	x,(OFST+5,sp)
2715  09db cd0000        	call	_strlen
2717  09de 01            	rrwa	x,a
2718  09df 6b0d          	ld	(OFST-5,sp),a
2719  09e1 02            	rlwa	x,a
2721                     ; 465 	for ( j = 0; j < i; j++)
2723  09e2 0f12          	clr	(OFST+0,sp)
2726  09e4 2036          	jra	L565
2727  09e6               L165:
2728                     ; 467 		punBuffer[ulTotalPacketLength++] = punTopic[j];
2730  09e6 1e13          	ldw	x,(OFST+1,sp)
2731  09e8 cd0000        	call	c_uitolx
2733  09eb 96            	ldw	x,sp
2734  09ec 1c0001        	addw	x,#OFST-17
2735  09ef cd0000        	call	c_rtol
2738  09f2 96            	ldw	x,sp
2739  09f3 1c000e        	addw	x,#OFST-4
2740  09f6 cd0000        	call	c_ltor
2742  09f9 96            	ldw	x,sp
2743  09fa 1c000e        	addw	x,#OFST-4
2744  09fd a601          	ld	a,#1
2745  09ff cd0000        	call	c_lgadc
2748  0a02 96            	ldw	x,sp
2749  0a03 1c0001        	addw	x,#OFST-17
2750  0a06 cd0000        	call	c_ladd
2752  0a09 be02          	ldw	x,c_lreg+2
2753  0a0b 89            	pushw	x
2754  0a0c 7b19          	ld	a,(OFST+7,sp)
2755  0a0e 97            	ld	xl,a
2756  0a0f 7b1a          	ld	a,(OFST+8,sp)
2757  0a11 1b14          	add	a,(OFST+2,sp)
2758  0a13 2401          	jrnc	L63
2759  0a15 5c            	incw	x
2760  0a16               L63:
2761  0a16 02            	rlwa	x,a
2762  0a17 f6            	ld	a,(x)
2763  0a18 85            	popw	x
2764  0a19 f7            	ld	(x),a
2765                     ; 465 	for ( j = 0; j < i; j++)
2767  0a1a 0c12          	inc	(OFST+0,sp)
2769  0a1c               L565:
2772  0a1c 7b12          	ld	a,(OFST+0,sp)
2773  0a1e 110d          	cp	a,(OFST-5,sp)
2774  0a20 25c4          	jrult	L165
2775                     ; 470 	punBuffer[ulTotalPacketLength]	=	'\0';
2777  0a22 1e13          	ldw	x,(OFST+1,sp)
2778  0a24 72fb10        	addw	x,(OFST-2,sp)
2779  0a27 7f            	clr	(x)
2780                     ; 472 	return ulTotalPacketLength;
2782  0a28 96            	ldw	x,sp
2783  0a29 1c000e        	addw	x,#OFST-4
2784  0a2c cd0000        	call	c_ltor
2788  0a2f 5b14          	addw	sp,#20
2789  0a31 81            	ret
2843                     ; 475 uint8_t unMQTT_PingRequest ( uint8_t *punBuffer )
2843                     ; 476 {
2844                     	switch	.text
2845  0a32               _unMQTT_PingRequest:
2847  0a32 89            	pushw	x
2848  0a33 89            	pushw	x
2849       00000002      OFST:	set	2
2852                     ; 477 	uint8_t unTotalPacketLength	= 0;
2854  0a34 0f02          	clr	(OFST+0,sp)
2856                     ; 478 	uint8_t unRemainingLength	= 0;
2858                     ; 481 	punBuffer[unTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_PINGREQ & 0xF) << 4 ) & 0xF0) | ( ((uint8_t)eCTRL_PKT_FLAG_PINGREQ & 0x0F) );
2860  0a36 7b02          	ld	a,(OFST+0,sp)
2861  0a38 97            	ld	xl,a
2862  0a39 0c02          	inc	(OFST+0,sp)
2864  0a3b 9f            	ld	a,xl
2865  0a3c 5f            	clrw	x
2866  0a3d 97            	ld	xl,a
2867  0a3e 72fb03        	addw	x,(OFST+1,sp)
2868  0a41 a6c0          	ld	a,#192
2869  0a43 f7            	ld	(x),a
2870                     ; 483 	punBuffer[unTotalPacketLength++] = unRemainingLength;
2872  0a44 7b02          	ld	a,(OFST+0,sp)
2873  0a46 97            	ld	xl,a
2874  0a47 0c02          	inc	(OFST+0,sp)
2876  0a49 9f            	ld	a,xl
2877  0a4a 5f            	clrw	x
2878  0a4b 97            	ld	xl,a
2879  0a4c 72fb03        	addw	x,(OFST+1,sp)
2880  0a4f 7f            	clr	(x)
2881                     ; 485 	punBuffer[unTotalPacketLength]	=	'\0';
2883  0a50 7b03          	ld	a,(OFST+1,sp)
2884  0a52 97            	ld	xl,a
2885  0a53 7b04          	ld	a,(OFST+2,sp)
2886  0a55 1b02          	add	a,(OFST+0,sp)
2887  0a57 2401          	jrnc	L24
2888  0a59 5c            	incw	x
2889  0a5a               L24:
2890  0a5a 02            	rlwa	x,a
2891  0a5b 7f            	clr	(x)
2892                     ; 487 	return unTotalPacketLength;
2894  0a5c 7b02          	ld	a,(OFST+0,sp)
2897  0a5e 5b04          	addw	sp,#4
2898  0a60 81            	ret
2952                     ; 490 uint8_t unMQTT_Disconnect ( uint8_t *punBuffer )
2952                     ; 491 {
2953                     	switch	.text
2954  0a61               _unMQTT_Disconnect:
2956  0a61 89            	pushw	x
2957  0a62 89            	pushw	x
2958       00000002      OFST:	set	2
2961                     ; 492 	uint8_t unTotalPacketLength	= 0;
2963  0a63 0f02          	clr	(OFST+0,sp)
2965                     ; 493 	uint8_t unRemainingLength	= 0;
2967                     ; 496 	punBuffer[unTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_DISCONNECT & 0xF) << 4 ) & 0xF0) | ( ((uint8_t)eCTRL_PKT_FLAG_DISCONNECT & 0x0F) );
2969  0a65 7b02          	ld	a,(OFST+0,sp)
2970  0a67 97            	ld	xl,a
2971  0a68 0c02          	inc	(OFST+0,sp)
2973  0a6a 9f            	ld	a,xl
2974  0a6b 5f            	clrw	x
2975  0a6c 97            	ld	xl,a
2976  0a6d 72fb03        	addw	x,(OFST+1,sp)
2977  0a70 a6e0          	ld	a,#224
2978  0a72 f7            	ld	(x),a
2979                     ; 498 	punBuffer[unTotalPacketLength++] = unRemainingLength;
2981  0a73 7b02          	ld	a,(OFST+0,sp)
2982  0a75 97            	ld	xl,a
2983  0a76 0c02          	inc	(OFST+0,sp)
2985  0a78 9f            	ld	a,xl
2986  0a79 5f            	clrw	x
2987  0a7a 97            	ld	xl,a
2988  0a7b 72fb03        	addw	x,(OFST+1,sp)
2989  0a7e 7f            	clr	(x)
2990                     ; 500 	punBuffer[unTotalPacketLength]	=	'\0';
2992  0a7f 7b03          	ld	a,(OFST+1,sp)
2993  0a81 97            	ld	xl,a
2994  0a82 7b04          	ld	a,(OFST+2,sp)
2995  0a84 1b02          	add	a,(OFST+0,sp)
2996  0a86 2401          	jrnc	L64
2997  0a88 5c            	incw	x
2998  0a89               L64:
2999  0a89 02            	rlwa	x,a
3000  0a8a 7f            	clr	(x)
3001                     ; 502 	return unTotalPacketLength;
3003  0a8b 7b02          	ld	a,(OFST+0,sp)
3006  0a8d 5b04          	addw	sp,#4
3007  0a8f 81            	ret
3069                     ; 664 uint32_t ulDecodedLength (uint8_t * punLength)
3069                     ; 665 {
3070                     	switch	.text
3071  0a90               _ulDecodedLength:
3073  0a90 89            	pushw	x
3074  0a91 5209          	subw	sp,#9
3075       00000009      OFST:	set	9
3078                     ; 666   uint32_t multiplier = 1;
3080  0a93 ae0001        	ldw	x,#1
3081  0a96 1f07          	ldw	(OFST-2,sp),x
3082  0a98 ae0000        	ldw	x,#0
3083  0a9b 1f05          	ldw	(OFST-4,sp),x
3085                     ; 667   uint32_t value = 0;
3087  0a9d ae0000        	ldw	x,#0
3088  0aa0 1f03          	ldw	(OFST-6,sp),x
3089  0aa2 ae0000        	ldw	x,#0
3090  0aa5 1f01          	ldw	(OFST-8,sp),x
3092                     ; 668   uint8_t  i = 0;
3094  0aa7 0f09          	clr	(OFST+0,sp)
3096  0aa9               L776:
3097                     ; 672         value += (punLength[i] & 0x7F) * multiplier;
3099  0aa9 7b0a          	ld	a,(OFST+1,sp)
3100  0aab 97            	ld	xl,a
3101  0aac 7b0b          	ld	a,(OFST+2,sp)
3102  0aae 1b09          	add	a,(OFST+0,sp)
3103  0ab0 2401          	jrnc	L25
3104  0ab2 5c            	incw	x
3105  0ab3               L25:
3106  0ab3 02            	rlwa	x,a
3107  0ab4 f6            	ld	a,(x)
3108  0ab5 a47f          	and	a,#127
3109  0ab7 b703          	ld	c_lreg+3,a
3110  0ab9 3f02          	clr	c_lreg+2
3111  0abb 3f01          	clr	c_lreg+1
3112  0abd 3f00          	clr	c_lreg
3113  0abf 96            	ldw	x,sp
3114  0ac0 1c0005        	addw	x,#OFST-4
3115  0ac3 cd0000        	call	c_lmul
3117  0ac6 96            	ldw	x,sp
3118  0ac7 1c0001        	addw	x,#OFST-8
3119  0aca cd0000        	call	c_lgadd
3122                     ; 673 	    multiplier *= 0x80;
3124  0acd 96            	ldw	x,sp
3125  0ace 1c0005        	addw	x,#OFST-4
3126  0ad1 a607          	ld	a,#7
3127  0ad3 cd0000        	call	c_lglsh
3130                     ; 674 	    if (multiplier > (0x80 * 0x80 * 0x80))
3132  0ad6 96            	ldw	x,sp
3133  0ad7 1c0005        	addw	x,#OFST-4
3134  0ada cd0000        	call	c_lzmp
3136  0add 2709          	jreq	L107
3137                     ; 676 	        return value;
3139  0adf 96            	ldw	x,sp
3140  0ae0 1c0001        	addw	x,#OFST-8
3141  0ae3 cd0000        	call	c_ltor
3144  0ae6 201d          	jra	L45
3145  0ae8               L107:
3146                     ; 678 	} while ((punLength[i++] & 0x80) != 0 && i < 4);
3148  0ae8 7b09          	ld	a,(OFST+0,sp)
3149  0aea 97            	ld	xl,a
3150  0aeb 0c09          	inc	(OFST+0,sp)
3152  0aed 9f            	ld	a,xl
3153  0aee 5f            	clrw	x
3154  0aef 97            	ld	xl,a
3155  0af0 72fb0a        	addw	x,(OFST+1,sp)
3156  0af3 f6            	ld	a,(x)
3157  0af4 a580          	bcp	a,#128
3158  0af6 2706          	jreq	L707
3160  0af8 7b09          	ld	a,(OFST+0,sp)
3161  0afa a104          	cp	a,#4
3162  0afc 25ab          	jrult	L776
3163  0afe               L707:
3164                     ; 680     return value;
3166  0afe 96            	ldw	x,sp
3167  0aff 1c0001        	addw	x,#OFST-8
3168  0b02 cd0000        	call	c_ltor
3171  0b05               L45:
3173  0b05 5b0b          	addw	sp,#11
3174  0b07 81            	ret
3187                     	xdef	_unMQTT_Disconnect
3188                     	xdef	_unMQTT_PingRequest
3189                     	xdef	_ulMQTT_UnSubscribe
3190                     	xdef	_ulMQTT_Subscribe
3191                     	xdef	_ulMQTT_Publish
3192                     	xdef	_ulMQTT_Connect
3193                     	xdef	_ulDecodedLength
3194                     	xdef	_punEncodeLength
3195                     	xref	_strlen
3196                     .const:	section	.text
3197  0000               L141:
3198  0000 4d51545400    	dc.b	"MQTT",0
3199                     	xref.b	c_lreg
3200                     	xref.b	c_x
3220                     	xref	c_lglsh
3221                     	xref	c_lmul
3222                     	xref	c_lgadd
3223                     	xref	c_ladd
3224                     	xref	c_rtol
3225                     	xref	c_uitolx
3226                     	xref	c_lgadc
3227                     	xref	c_ltor
3228                     	xref	c_lzmp
3229                     	xref	c_lgursh
3230                     	end
