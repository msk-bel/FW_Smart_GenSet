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
 406                     ; 71 void vHandleDataRecvUARTviaISR(void)
 406                     ; 72 {
 407                     	switch	.text
 408  0085               _vHandleDataRecvUARTviaISR:
 410  0085 5203          	subw	sp,#3
 411       00000003      OFST:	set	3
 414                     ; 73   uint8_t i = 0;
 416  0087 0f03          	clr	(OFST+0,sp)
 418                     ; 74   bool start = FALSE, end = FALSE;
 422                     ; 75   clearBuffer();
 424  0089 cd0000        	call	_clearBuffer
 427  008c 2023          	jra	L702
 428  008e               L502:
 429                     ; 79     response_buffer[i++] = aunRecievedData[unReadPtr++];
 431  008e 7b03          	ld	a,(OFST+0,sp)
 432  0090 97            	ld	xl,a
 433  0091 0c03          	inc	(OFST+0,sp)
 435  0093 9f            	ld	a,xl
 436  0094 5f            	clrw	x
 437  0095 97            	ld	xl,a
 438  0096 b601          	ld	a,_unReadPtr
 439  0098 9097          	ld	yl,a
 440  009a 3c01          	inc	_unReadPtr
 441  009c 909f          	ld	a,yl
 442  009e 905f          	clrw	y
 443  00a0 9097          	ld	yl,a
 444  00a2 90d60000      	ld	a,(_aunRecievedData,y)
 445  00a6 d70000        	ld	(_response_buffer,x),a
 446                     ; 80     if (unReadPtr == MAX_UART_RING_BUFF_SIZE)
 448  00a9 b601          	ld	a,_unReadPtr
 449  00ab a164          	cp	a,#100
 450  00ad 2602          	jrne	L702
 451                     ; 82       unReadPtr = 0;
 453  00af 3f01          	clr	_unReadPtr
 454  00b1               L702:
 455                     ; 77   while (unReadPtr != unRecievePtr && i < 100)
 457  00b1 b601          	ld	a,_unReadPtr
 458  00b3 b100          	cp	a,_unRecievePtr
 459  00b5 2706          	jreq	L512
 461  00b7 7b03          	ld	a,(OFST+0,sp)
 462  00b9 a164          	cp	a,#100
 463  00bb 25d1          	jrult	L502
 464  00bd               L512:
 465                     ; 86   if (strstr(response_buffer, "OK"))
 467  00bd ae001d        	ldw	x,#L122
 468  00c0 89            	pushw	x
 469  00c1 ae0000        	ldw	x,#_response_buffer
 470  00c4 cd0000        	call	_strstr
 472  00c7 5b02          	addw	sp,#2
 473  00c9 a30000        	cpw	x,#0
 474  00cc 2706          	jreq	L712
 475                     ; 87     bOkFlag = TRUE;
 477  00ce 35010000      	mov	_bOkFlag,#1
 479  00d2 2019          	jra	L322
 480  00d4               L712:
 481                     ; 88   else if (strstr(response_buffer, "DOWNLOAD"))
 483  00d4 ae0014        	ldw	x,#L722
 484  00d7 89            	pushw	x
 485  00d8 ae0000        	ldw	x,#_response_buffer
 486  00db cd0000        	call	_strstr
 488  00de 5b02          	addw	sp,#2
 489  00e0 a30000        	cpw	x,#0
 490  00e3 2706          	jreq	L522
 491                     ; 89     bOkFlag = TRUE;
 493  00e5 35010000      	mov	_bOkFlag,#1
 495  00e9 2002          	jra	L322
 496  00eb               L522:
 497                     ; 91     bOkFlag = FALSE;
 499  00eb 3f00          	clr	_bOkFlag
 500  00ed               L322:
 501                     ; 92   if (strstr(response_buffer, "+BT"))
 503  00ed ae0010        	ldw	x,#L532
 504  00f0 89            	pushw	x
 505  00f1 ae0000        	ldw	x,#_response_buffer
 506  00f4 cd0000        	call	_strstr
 508  00f7 5b02          	addw	sp,#2
 509  00f9 a30000        	cpw	x,#0
 510  00fc 2703          	jreq	L332
 511                     ; 95     vHandle_BT_Add_Device_Flow();
 513  00fe cd0000        	call	_vHandle_BT_Add_Device_Flow
 515  0101               L332:
 516                     ; 97   if (strstr(response_buffer, "+IPD") || strstr(response_buffer, "RECV FROM:"))
 518  0101 ae000b        	ldw	x,#L342
 519  0104 89            	pushw	x
 520  0105 ae0000        	ldw	x,#_response_buffer
 521  0108 cd0000        	call	_strstr
 523  010b 5b02          	addw	sp,#2
 524  010d a30000        	cpw	x,#0
 525  0110 2611          	jrne	L142
 527  0112 ae0000        	ldw	x,#L542
 528  0115 89            	pushw	x
 529  0116 ae0000        	ldw	x,#_response_buffer
 530  0119 cd0000        	call	_strstr
 532  011c 5b02          	addw	sp,#2
 533  011e a30000        	cpw	x,#0
 534  0121 2703          	jreq	L732
 535  0123               L142:
 536                     ; 102     vHandleMevris_MQTT_Recv_Data();
 538  0123 cd0000        	call	_vHandleMevris_MQTT_Recv_Data
 540  0126               L732:
 541                     ; 104 }
 544  0126 5b03          	addw	sp,#3
 545  0128 81            	ret
 607                     	xdef	_dataLength
 608                     	xdef	_unReadPtr
 609                     	xdef	_unRecievePtr
 610                     	switch	.ubsct
 611  0000               _bOkFlag:
 612  0000 00            	ds.b	1
 613                     	xdef	_bOkFlag
 614                     	switch	.bss
 615  0000               _aunRecievedData:
 616  0000 000000000000  	ds.b	100
 617                     	xdef	_aunRecievedData
 618                     	xref	_clearBuffer
 619                     	xdef	_vHandleDataRecvUARTviaISR
 620                     	xdef	_vSerialRecieveISR
 621                     	xdef	_ms_send_cmd_TCP
 622                     	xdef	_ms_send_cmd
 623                     	xref	_vHandleMevris_MQTT_Recv_Data
 624                     	xref	_response_buffer
 625                     	xref	_vHandle_BT_Add_Device_Flow
 626                     	xref	_strstr
 627                     	xref	_UART1_GetFlagStatus
 628                     	xref	_UART1_SendData8
 629                     	xref	_UART1_ReceiveData8
 630                     .const:	section	.text
 631  0000               L542:
 632  0000 524543562046  	dc.b	"RECV FROM:",0
 633  000b               L342:
 634  000b 2b49504400    	dc.b	"+IPD",0
 635  0010               L532:
 636  0010 2b425400      	dc.b	"+BT",0
 637  0014               L722:
 638  0014 444f574e4c4f  	dc.b	"DOWNLOAD",0
 639  001d               L122:
 640  001d 4f4b00        	dc.b	"OK",0
 660                     	end
