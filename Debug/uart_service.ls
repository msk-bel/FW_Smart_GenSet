   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _unRecievePtr:
  16  0000 00            	dc.b	0
  17  0001               _unReadPtr:
  18  0001 00            	dc.b	0
  19  0002               _dataLength:
  20  0002 00            	dc.b	0
  81                     ; 29 void ms_send_cmd(uint8_t *cmd, uint8_t length)
  81                     ; 30 {
  83                     	switch	.text
  84  0000               _ms_send_cmd:
  86  0000 89            	pushw	x
  87  0001 88            	push	a
  88       00000001      OFST:	set	1
  91                     ; 32   for (i = 0; i < length; i++)
  93  0002 0f01          	clr	(OFST+0,sp)
  96  0004 201a          	jra	L34
  97  0006               L15:
  98                     ; 34     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 100  0006 ae0040        	ldw	x,#64
 101  0009 cd0000        	call	_UART1_GetFlagStatus
 103  000c 4d            	tnz	a
 104  000d 27f7          	jreq	L15
 105                     ; 36     UART1_SendData8(*(cmd + i));
 107  000f 7b02          	ld	a,(OFST+1,sp)
 108  0011 97            	ld	xl,a
 109  0012 7b03          	ld	a,(OFST+2,sp)
 110  0014 1b01          	add	a,(OFST+0,sp)
 111  0016 2401          	jrnc	L6
 112  0018 5c            	incw	x
 113  0019               L6:
 114  0019 02            	rlwa	x,a
 115  001a f6            	ld	a,(x)
 116  001b cd0000        	call	_UART1_SendData8
 118                     ; 32   for (i = 0; i < length; i++)
 120  001e 0c01          	inc	(OFST+0,sp)
 122  0020               L34:
 125  0020 7b01          	ld	a,(OFST+0,sp)
 126  0022 1106          	cp	a,(OFST+5,sp)
 127  0024 25e0          	jrult	L15
 129  0026               L75:
 130                     ; 40   while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 132  0026 ae0040        	ldw	x,#64
 133  0029 cd0000        	call	_UART1_GetFlagStatus
 135  002c 4d            	tnz	a
 136  002d 27f7          	jreq	L75
 137                     ; 42   UART1_SendData8(0x0D);
 139  002f a60d          	ld	a,#13
 140  0031 cd0000        	call	_UART1_SendData8
 142                     ; 43 }
 145  0034 5b03          	addw	sp,#3
 146  0036 81            	ret
 201                     ; 45 void ms_send_cmd_TCP(uint8_t *cmd, uint8_t length)
 201                     ; 46 {
 202                     	switch	.text
 203  0037               _ms_send_cmd_TCP:
 205  0037 89            	pushw	x
 206  0038 88            	push	a
 207       00000001      OFST:	set	1
 210                     ; 48   for (i = 0; i < length; i++)
 212  0039 0f01          	clr	(OFST+0,sp)
 215  003b 201a          	jra	L511
 216  003d               L321:
 217                     ; 50     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 219  003d ae0040        	ldw	x,#64
 220  0040 cd0000        	call	_UART1_GetFlagStatus
 222  0043 4d            	tnz	a
 223  0044 27f7          	jreq	L321
 224                     ; 52     UART1_SendData8(*(cmd + i));
 226  0046 7b02          	ld	a,(OFST+1,sp)
 227  0048 97            	ld	xl,a
 228  0049 7b03          	ld	a,(OFST+2,sp)
 229  004b 1b01          	add	a,(OFST+0,sp)
 230  004d 2401          	jrnc	L21
 231  004f 5c            	incw	x
 232  0050               L21:
 233  0050 02            	rlwa	x,a
 234  0051 f6            	ld	a,(x)
 235  0052 cd0000        	call	_UART1_SendData8
 237                     ; 48   for (i = 0; i < length; i++)
 239  0055 0c01          	inc	(OFST+0,sp)
 241  0057               L511:
 244  0057 7b01          	ld	a,(OFST+0,sp)
 245  0059 1106          	cp	a,(OFST+5,sp)
 246  005b 25e0          	jrult	L321
 248  005d               L131:
 249                     ; 56   while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 251  005d ae0040        	ldw	x,#64
 252  0060 cd0000        	call	_UART1_GetFlagStatus
 254  0063 4d            	tnz	a
 255  0064 27f7          	jreq	L131
 256                     ; 58   UART1_SendData8(0x1A);
 258  0066 a61a          	ld	a,#26
 259  0068 cd0000        	call	_UART1_SendData8
 261                     ; 59 }
 264  006b 5b03          	addw	sp,#3
 265  006d 81            	ret
 291                     ; 61 void vSerialRecieveISR(void)
 291                     ; 62 {
 292                     	switch	.text
 293  006e               _vSerialRecieveISR:
 297                     ; 63   aunRecievedData[unRecievePtr] = UART1_ReceiveData8();
 299  006e b600          	ld	a,_unRecievePtr
 300  0070 5f            	clrw	x
 301  0071 97            	ld	xl,a
 302  0072 89            	pushw	x
 303  0073 cd0000        	call	_UART1_ReceiveData8
 305  0076 85            	popw	x
 306  0077 d70000        	ld	(_aunRecievedData,x),a
 307                     ; 64   unRecievePtr++;
 309  007a 3c00          	inc	_unRecievePtr
 310                     ; 65   if (unRecievePtr == MAX_UART_RING_BUFF_SIZE)
 312  007c b600          	ld	a,_unRecievePtr
 313  007e a164          	cp	a,#100
 314  0080 2602          	jrne	L541
 315                     ; 67     unRecievePtr = 0;
 317  0082 3f00          	clr	_unRecievePtr
 318  0084               L541:
 319                     ; 69 }
 322  0084 81            	ret
 405                     ; 71 void vHandleDataRecvUARTviaISR(void)
 405                     ; 72 {
 406                     	switch	.text
 407  0085               _vHandleDataRecvUARTviaISR:
 409  0085 5203          	subw	sp,#3
 410       00000003      OFST:	set	3
 413                     ; 73   uint8_t i = 0;
 415  0087 0f03          	clr	(OFST+0,sp)
 417                     ; 74   bool start = FALSE, end = FALSE;
 421                     ; 75   clearBuffer();
 423  0089 cd0000        	call	_clearBuffer
 426  008c 2023          	jra	L702
 427  008e               L502:
 428                     ; 79     response_buffer[i++] = aunRecievedData[unReadPtr++];
 430  008e 7b03          	ld	a,(OFST+0,sp)
 431  0090 97            	ld	xl,a
 432  0091 0c03          	inc	(OFST+0,sp)
 434  0093 9f            	ld	a,xl
 435  0094 5f            	clrw	x
 436  0095 97            	ld	xl,a
 437  0096 b601          	ld	a,_unReadPtr
 438  0098 9097          	ld	yl,a
 439  009a 3c01          	inc	_unReadPtr
 440  009c 909f          	ld	a,yl
 441  009e 905f          	clrw	y
 442  00a0 9097          	ld	yl,a
 443  00a2 90d60000      	ld	a,(_aunRecievedData,y)
 444  00a6 d70000        	ld	(_response_buffer,x),a
 445                     ; 80     if (unReadPtr == MAX_UART_RING_BUFF_SIZE)
 447  00a9 b601          	ld	a,_unReadPtr
 448  00ab a164          	cp	a,#100
 449  00ad 2602          	jrne	L702
 450                     ; 82       unReadPtr = 0;
 452  00af 3f01          	clr	_unReadPtr
 453  00b1               L702:
 454                     ; 77   while (unReadPtr != unRecievePtr && i < 100)
 456  00b1 b601          	ld	a,_unReadPtr
 457  00b3 b100          	cp	a,_unRecievePtr
 458  00b5 2706          	jreq	L512
 460  00b7 7b03          	ld	a,(OFST+0,sp)
 461  00b9 a164          	cp	a,#100
 462  00bb 25d1          	jrult	L502
 463  00bd               L512:
 464                     ; 86   if (strstr(response_buffer, "OK"))
 466  00bd ae0019        	ldw	x,#L122
 467  00c0 89            	pushw	x
 468  00c1 ae0000        	ldw	x,#_response_buffer
 469  00c4 cd0000        	call	_strstr
 471  00c7 5b02          	addw	sp,#2
 472  00c9 a30000        	cpw	x,#0
 473  00cc 2706          	jreq	L712
 474                     ; 87     bOkFlag = TRUE;
 476  00ce 35010000      	mov	_bOkFlag,#1
 478  00d2 2019          	jra	L322
 479  00d4               L712:
 480                     ; 88   else if (strstr(response_buffer, "DOWNLOAD"))
 482  00d4 ae0010        	ldw	x,#L722
 483  00d7 89            	pushw	x
 484  00d8 ae0000        	ldw	x,#_response_buffer
 485  00db cd0000        	call	_strstr
 487  00de 5b02          	addw	sp,#2
 488  00e0 a30000        	cpw	x,#0
 489  00e3 2706          	jreq	L522
 490                     ; 89     bOkFlag = TRUE;
 492  00e5 35010000      	mov	_bOkFlag,#1
 494  00e9 2002          	jra	L322
 495  00eb               L522:
 496                     ; 91     bOkFlag = FALSE;
 498  00eb 3f00          	clr	_bOkFlag
 499  00ed               L322:
 500                     ; 97   if (strstr(response_buffer, "+IPD") || strstr(response_buffer, "RECV FROM:"))
 502  00ed ae000b        	ldw	x,#L732
 503  00f0 89            	pushw	x
 504  00f1 ae0000        	ldw	x,#_response_buffer
 505  00f4 cd0000        	call	_strstr
 507  00f7 5b02          	addw	sp,#2
 508  00f9 a30000        	cpw	x,#0
 509  00fc 2611          	jrne	L532
 511  00fe ae0000        	ldw	x,#L142
 512  0101 89            	pushw	x
 513  0102 ae0000        	ldw	x,#_response_buffer
 514  0105 cd0000        	call	_strstr
 516  0108 5b02          	addw	sp,#2
 517  010a a30000        	cpw	x,#0
 518  010d 2703          	jreq	L332
 519  010f               L532:
 520                     ; 102     vHandleMevris_MQTT_Recv_Data();
 522  010f cd0000        	call	_vHandleMevris_MQTT_Recv_Data
 524  0112               L332:
 525                     ; 109 }
 528  0112 5b03          	addw	sp,#3
 529  0114 81            	ret
 591                     	xdef	_dataLength
 592                     	xdef	_unReadPtr
 593                     	xdef	_unRecievePtr
 594                     	switch	.ubsct
 595  0000               _bOkFlag:
 596  0000 00            	ds.b	1
 597                     	xdef	_bOkFlag
 598                     	switch	.bss
 599  0000               _aunRecievedData:
 600  0000 000000000000  	ds.b	100
 601                     	xdef	_aunRecievedData
 602                     	xref	_clearBuffer
 603                     	xdef	_vHandleDataRecvUARTviaISR
 604                     	xdef	_vSerialRecieveISR
 605                     	xdef	_ms_send_cmd_TCP
 606                     	xdef	_ms_send_cmd
 607                     	xref	_vHandleMevris_MQTT_Recv_Data
 608                     	xref	_response_buffer
 609                     	xref	_strstr
 610                     	xref	_UART1_GetFlagStatus
 611                     	xref	_UART1_SendData8
 612                     	xref	_UART1_ReceiveData8
 613                     .const:	section	.text
 614  0000               L142:
 615  0000 524543562046  	dc.b	"RECV FROM:",0
 616  000b               L732:
 617  000b 2b49504400    	dc.b	"+IPD",0
 618  0010               L722:
 619  0010 444f574e4c4f  	dc.b	"DOWNLOAD",0
 620  0019               L122:
 621  0019 4f4b00        	dc.b	"OK",0
 641                     	end
