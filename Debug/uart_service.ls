   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
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
  96  0004 2016          	jra	L34
  97  0006               L15:
  98                     ; 34     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 100  0006 ae0040        	ldw	x,#64
 101  0009 cd0000        	call	_UART1_GetFlagStatus
 103  000c 4d            	tnz	a
 104  000d 27f7          	jreq	L15
 105                     ; 36     UART1_SendData8(*(cmd + i));
 107  000f 7b01          	ld	a,(OFST+0,sp)
 108  0011 5f            	clrw	x
 109  0012 97            	ld	xl,a
 110  0013 72fb02        	addw	x,(OFST+1,sp)
 111  0016 f6            	ld	a,(x)
 112  0017 cd0000        	call	_UART1_SendData8
 114                     ; 32   for (i = 0; i < length; i++)
 116  001a 0c01          	inc	(OFST+0,sp)
 118  001c               L34:
 121  001c 7b01          	ld	a,(OFST+0,sp)
 122  001e 1106          	cp	a,(OFST+5,sp)
 123  0020 25e4          	jrult	L15
 125  0022               L75:
 126                     ; 40   while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 128  0022 ae0040        	ldw	x,#64
 129  0025 cd0000        	call	_UART1_GetFlagStatus
 131  0028 4d            	tnz	a
 132  0029 27f7          	jreq	L75
 133                     ; 42   UART1_SendData8(0x0D);
 135  002b a60d          	ld	a,#13
 136  002d cd0000        	call	_UART1_SendData8
 138                     ; 43 }
 141  0030 5b03          	addw	sp,#3
 142  0032 81            	ret
 197                     ; 45 void ms_send_cmd_TCP(uint8_t *cmd, uint8_t length)
 197                     ; 46 {
 198                     	switch	.text
 199  0033               _ms_send_cmd_TCP:
 201  0033 89            	pushw	x
 202  0034 88            	push	a
 203       00000001      OFST:	set	1
 206                     ; 48   for (i = 0; i < length; i++)
 208  0035 0f01          	clr	(OFST+0,sp)
 211  0037 2016          	jra	L511
 212  0039               L321:
 213                     ; 50     while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 215  0039 ae0040        	ldw	x,#64
 216  003c cd0000        	call	_UART1_GetFlagStatus
 218  003f 4d            	tnz	a
 219  0040 27f7          	jreq	L321
 220                     ; 52     UART1_SendData8(*(cmd + i));
 222  0042 7b01          	ld	a,(OFST+0,sp)
 223  0044 5f            	clrw	x
 224  0045 97            	ld	xl,a
 225  0046 72fb02        	addw	x,(OFST+1,sp)
 226  0049 f6            	ld	a,(x)
 227  004a cd0000        	call	_UART1_SendData8
 229                     ; 48   for (i = 0; i < length; i++)
 231  004d 0c01          	inc	(OFST+0,sp)
 233  004f               L511:
 236  004f 7b01          	ld	a,(OFST+0,sp)
 237  0051 1106          	cp	a,(OFST+5,sp)
 238  0053 25e4          	jrult	L321
 240  0055               L131:
 241                     ; 56   while (!UART1_GetFlagStatus(UART1_FLAG_TC))
 243  0055 ae0040        	ldw	x,#64
 244  0058 cd0000        	call	_UART1_GetFlagStatus
 246  005b 4d            	tnz	a
 247  005c 27f7          	jreq	L131
 248                     ; 58   UART1_SendData8(0x1A);
 250  005e a61a          	ld	a,#26
 251  0060 cd0000        	call	_UART1_SendData8
 253                     ; 59 }
 256  0063 5b03          	addw	sp,#3
 257  0065 81            	ret
 283                     ; 61 void vSerialRecieveISR(void)
 283                     ; 62 {
 284                     	switch	.text
 285  0066               _vSerialRecieveISR:
 289                     ; 63   aunRecievedData[unRecievePtr] = UART1_ReceiveData8();
 291  0066 b600          	ld	a,_unRecievePtr
 292  0068 5f            	clrw	x
 293  0069 97            	ld	xl,a
 294  006a 89            	pushw	x
 295  006b cd0000        	call	_UART1_ReceiveData8
 297  006e 85            	popw	x
 298  006f d70000        	ld	(_aunRecievedData,x),a
 299                     ; 64   unRecievePtr++;
 301  0072 3c00          	inc	_unRecievePtr
 302                     ; 65   if (unRecievePtr == MAX_UART_RING_BUFF_SIZE)
 304  0074 b600          	ld	a,_unRecievePtr
 305  0076 a164          	cp	a,#100
 306  0078 2602          	jrne	L541
 307                     ; 67     unRecievePtr = 0;
 309  007a 3f00          	clr	_unRecievePtr
 310  007c               L541:
 311                     ; 69 }
 314  007c 81            	ret
 397                     ; 71 void vHandleDataRecvUARTviaISR(void)
 397                     ; 72 {
 398                     	switch	.text
 399  007d               _vHandleDataRecvUARTviaISR:
 401  007d 5203          	subw	sp,#3
 402       00000003      OFST:	set	3
 405                     ; 73   uint8_t i = 0;
 407  007f 0f03          	clr	(OFST+0,sp)
 409                     ; 74   bool start = FALSE, end = FALSE;
 413                     ; 75   clearBuffer();
 415  0081 cd0000        	call	_clearBuffer
 418  0084 2023          	jra	L702
 419  0086               L502:
 420                     ; 79     response_buffer[i++] = aunRecievedData[unReadPtr++];
 422  0086 7b03          	ld	a,(OFST+0,sp)
 423  0088 97            	ld	xl,a
 424  0089 0c03          	inc	(OFST+0,sp)
 426  008b 9f            	ld	a,xl
 427  008c 5f            	clrw	x
 428  008d 97            	ld	xl,a
 429  008e b601          	ld	a,_unReadPtr
 430  0090 9097          	ld	yl,a
 431  0092 3c01          	inc	_unReadPtr
 432  0094 909f          	ld	a,yl
 433  0096 905f          	clrw	y
 434  0098 9097          	ld	yl,a
 435  009a 90d60000      	ld	a,(_aunRecievedData,y)
 436  009e d70000        	ld	(_response_buffer,x),a
 437                     ; 80     if (unReadPtr == MAX_UART_RING_BUFF_SIZE)
 439  00a1 b601          	ld	a,_unReadPtr
 440  00a3 a164          	cp	a,#100
 441  00a5 2602          	jrne	L702
 442                     ; 82       unReadPtr = 0;
 444  00a7 3f01          	clr	_unReadPtr
 445  00a9               L702:
 446                     ; 77   while (unReadPtr != unRecievePtr && i < 100)
 448  00a9 b601          	ld	a,_unReadPtr
 449  00ab b100          	cp	a,_unRecievePtr
 450  00ad 2706          	jreq	L512
 452  00af 7b03          	ld	a,(OFST+0,sp)
 453  00b1 a164          	cp	a,#100
 454  00b3 25d1          	jrult	L502
 455  00b5               L512:
 456                     ; 86   if (strstr(response_buffer, "OK"))
 458  00b5 ae0019        	ldw	x,#L122
 459  00b8 89            	pushw	x
 460  00b9 ae0000        	ldw	x,#_response_buffer
 461  00bc cd0000        	call	_strstr
 463  00bf 5b02          	addw	sp,#2
 464  00c1 a30000        	cpw	x,#0
 465  00c4 2706          	jreq	L712
 466                     ; 87     bOkFlag = TRUE;
 468  00c6 35010000      	mov	_bOkFlag,#1
 470  00ca 2019          	jra	L322
 471  00cc               L712:
 472                     ; 88   else if (strstr(response_buffer, "DOWNLOAD"))
 474  00cc ae0010        	ldw	x,#L722
 475  00cf 89            	pushw	x
 476  00d0 ae0000        	ldw	x,#_response_buffer
 477  00d3 cd0000        	call	_strstr
 479  00d6 5b02          	addw	sp,#2
 480  00d8 a30000        	cpw	x,#0
 481  00db 2706          	jreq	L522
 482                     ; 89     bOkFlag = TRUE;
 484  00dd 35010000      	mov	_bOkFlag,#1
 486  00e1 2002          	jra	L322
 487  00e3               L522:
 488                     ; 91     bOkFlag = FALSE;
 490  00e3 3f00          	clr	_bOkFlag
 491  00e5               L322:
 492                     ; 97   if (strstr(response_buffer, "+IPD") || strstr(response_buffer, "RECV FROM:"))
 494  00e5 ae000b        	ldw	x,#L732
 495  00e8 89            	pushw	x
 496  00e9 ae0000        	ldw	x,#_response_buffer
 497  00ec cd0000        	call	_strstr
 499  00ef 5b02          	addw	sp,#2
 500  00f1 a30000        	cpw	x,#0
 501  00f4 2611          	jrne	L532
 503  00f6 ae0000        	ldw	x,#L142
 504  00f9 89            	pushw	x
 505  00fa ae0000        	ldw	x,#_response_buffer
 506  00fd cd0000        	call	_strstr
 508  0100 5b02          	addw	sp,#2
 509  0102 a30000        	cpw	x,#0
 510  0105 2703          	jreq	L332
 511  0107               L532:
 512                     ; 102     vHandleMevris_MQTT_Recv_Data();
 514  0107 cd0000        	call	_vHandleMevris_MQTT_Recv_Data
 516  010a               L332:
 517                     ; 109 }
 520  010a 5b03          	addw	sp,#3
 521  010c 81            	ret
 583                     	xdef	_dataLength
 584                     	xdef	_unReadPtr
 585                     	xdef	_unRecievePtr
 586                     	switch	.ubsct
 587  0000               _bOkFlag:
 588  0000 00            	ds.b	1
 589                     	xdef	_bOkFlag
 590                     	switch	.bss
 591  0000               _aunRecievedData:
 592  0000 000000000000  	ds.b	100
 593                     	xdef	_aunRecievedData
 594                     	xref	_clearBuffer
 595                     	xdef	_vHandleDataRecvUARTviaISR
 596                     	xdef	_vSerialRecieveISR
 597                     	xdef	_ms_send_cmd_TCP
 598                     	xdef	_ms_send_cmd
 599                     	xref	_vHandleMevris_MQTT_Recv_Data
 600                     	xref	_response_buffer
 601                     	xref	_strstr
 602                     	xref	_UART1_GetFlagStatus
 603                     	xref	_UART1_SendData8
 604                     	xref	_UART1_ReceiveData8
 605                     .const:	section	.text
 606  0000               L142:
 607  0000 524543562046  	dc.b	"RECV FROM:",0
 608  000b               L732:
 609  000b 2b49504400    	dc.b	"+IPD",0
 610  0010               L722:
 611  0010 444f574e4c4f  	dc.b	"DOWNLOAD",0
 612  0019               L122:
 613  0019 4f4b00        	dc.b	"OK",0
 633                     	end
