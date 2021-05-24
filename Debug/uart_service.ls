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
 172                     ; 45 void vSerialRecieveISR(void)
 172                     ; 46 {
 173                     	switch	.text
 174  0037               _vSerialRecieveISR:
 178                     ; 47   aunRecievedData[unRecievePtr] = UART1_ReceiveData8();
 180  0037 b600          	ld	a,_unRecievePtr
 181  0039 5f            	clrw	x
 182  003a 97            	ld	xl,a
 183  003b 89            	pushw	x
 184  003c cd0000        	call	_UART1_ReceiveData8
 186  003f 85            	popw	x
 187  0040 d70000        	ld	(_aunRecievedData,x),a
 188                     ; 48   unRecievePtr++;
 190  0043 3c00          	inc	_unRecievePtr
 191                     ; 49   if (unRecievePtr == MAX_UART_RING_BUFF_SIZE)
 193  0045 b600          	ld	a,_unRecievePtr
 194  0047 a164          	cp	a,#100
 195  0049 2602          	jrne	L37
 196                     ; 51     unRecievePtr = 0;
 198  004b 3f00          	clr	_unRecievePtr
 199  004d               L37:
 200                     ; 53 }
 203  004d 81            	ret
 288                     ; 55 void vHandleDataRecvUARTviaISR(void)
 288                     ; 56 {
 289                     	switch	.text
 290  004e               _vHandleDataRecvUARTviaISR:
 292  004e 5203          	subw	sp,#3
 293       00000003      OFST:	set	3
 296                     ; 57   uint8_t i = 0;
 298  0050 0f03          	clr	(OFST+0,sp)
 300                     ; 58   bool start = FALSE, end = FALSE;
 304                     ; 59   clearBuffer();
 306  0052 cd0000        	call	_clearBuffer
 309  0055 2022          	jra	L531
 310  0057               L331:
 311                     ; 63     response_buffer[i++] = aunRecievedData[unReadPtr++];
 313  0057 7b03          	ld	a,(OFST+0,sp)
 314  0059 97            	ld	xl,a
 315  005a 0c03          	inc	(OFST+0,sp)
 317  005c 9f            	ld	a,xl
 318  005d 5f            	clrw	x
 319  005e 97            	ld	xl,a
 320  005f b601          	ld	a,_unReadPtr
 321  0061 9097          	ld	yl,a
 322  0063 3c01          	inc	_unReadPtr
 323  0065 909f          	ld	a,yl
 324  0067 905f          	clrw	y
 325  0069 9097          	ld	yl,a
 326  006b 90d60000      	ld	a,(_aunRecievedData,y)
 327  006f e700          	ld	(_response_buffer,x),a
 328                     ; 64     if (unReadPtr == MAX_UART_RING_BUFF_SIZE)
 330  0071 b601          	ld	a,_unReadPtr
 331  0073 a164          	cp	a,#100
 332  0075 2602          	jrne	L531
 333                     ; 66       unReadPtr = 0;
 335  0077 3f01          	clr	_unReadPtr
 336  0079               L531:
 337                     ; 61   while (unReadPtr != unRecievePtr && i < 100)
 339  0079 b601          	ld	a,_unReadPtr
 340  007b b100          	cp	a,_unRecievePtr
 341  007d 2706          	jreq	L341
 343  007f 7b03          	ld	a,(OFST+0,sp)
 344  0081 a164          	cp	a,#100
 345  0083 25d2          	jrult	L331
 346  0085               L341:
 347                     ; 70   if (strstr(response_buffer, "OK"))
 349  0085 ae0019        	ldw	x,#L741
 350  0088 89            	pushw	x
 351  0089 ae0000        	ldw	x,#_response_buffer
 352  008c cd0000        	call	_strstr
 354  008f 5b02          	addw	sp,#2
 355  0091 a30000        	cpw	x,#0
 356  0094 2706          	jreq	L541
 357                     ; 71     bOkFlag = TRUE;
 359  0096 35010000      	mov	_bOkFlag,#1
 361  009a 2019          	jra	L151
 362  009c               L541:
 363                     ; 72   else if (strstr(response_buffer, "DOWNLOAD"))
 365  009c ae0010        	ldw	x,#L551
 366  009f 89            	pushw	x
 367  00a0 ae0000        	ldw	x,#_response_buffer
 368  00a3 cd0000        	call	_strstr
 370  00a6 5b02          	addw	sp,#2
 371  00a8 a30000        	cpw	x,#0
 372  00ab 2706          	jreq	L351
 373                     ; 73     bOkFlag = TRUE;
 375  00ad 35010000      	mov	_bOkFlag,#1
 377  00b1 2002          	jra	L151
 378  00b3               L351:
 379                     ; 75     bOkFlag = FALSE;
 381  00b3 3f00          	clr	_bOkFlag
 382  00b5               L151:
 383                     ; 76   if (strstr(response_buffer, "+BT"))
 385  00b5 ae000c        	ldw	x,#L361
 386  00b8 89            	pushw	x
 387  00b9 ae0000        	ldw	x,#_response_buffer
 388  00bc cd0000        	call	_strstr
 390  00bf 5b02          	addw	sp,#2
 391  00c1 a30000        	cpw	x,#0
 392  00c4 2712          	jreq	L161
 393                     ; 78         ms_send_cmd(response_buffer, strlen((const char *)response_buffer));
 395  00c6 ae0000        	ldw	x,#_response_buffer
 396  00c9 cd0000        	call	_strlen
 398  00cc 9f            	ld	a,xl
 399  00cd 88            	push	a
 400  00ce ae0000        	ldw	x,#_response_buffer
 401  00d1 cd0000        	call	_ms_send_cmd
 403  00d4 84            	pop	a
 404                     ; 79     vHandle_BT_Add_Device_Flow();
 406  00d5 cd0000        	call	_vHandle_BT_Add_Device_Flow
 408  00d8               L161:
 409                     ; 82   if (strstr(response_buffer, "+HTTPACTION"))
 411  00d8 ae0000        	ldw	x,#L761
 412  00db 89            	pushw	x
 413  00dc ae0000        	ldw	x,#_response_buffer
 414  00df cd0000        	call	_strstr
 416  00e2 5b02          	addw	sp,#2
 417  00e4 a30000        	cpw	x,#0
 418                     ; 86 }
 421  00e7 5b03          	addw	sp,#3
 422  00e9 81            	ret
 484                     	xdef	_dataLength
 485                     	xdef	_unReadPtr
 486                     	xdef	_unRecievePtr
 487                     	switch	.ubsct
 488  0000               _bOkFlag:
 489  0000 00            	ds.b	1
 490                     	xdef	_bOkFlag
 491                     	xref.b	_response_buffer
 492                     	switch	.bss
 493  0000               _aunRecievedData:
 494  0000 000000000000  	ds.b	100
 495                     	xdef	_aunRecievedData
 496                     	xref	_clearBuffer
 497                     	xdef	_vHandleDataRecvUARTviaISR
 498                     	xdef	_vSerialRecieveISR
 499                     	xdef	_ms_send_cmd
 500                     	xref	_vHandle_BT_Add_Device_Flow
 501                     	xref	_strlen
 502                     	xref	_strstr
 503                     	xref	_UART1_GetFlagStatus
 504                     	xref	_UART1_SendData8
 505                     	xref	_UART1_ReceiveData8
 506                     .const:	section	.text
 507  0000               L761:
 508  0000 2b4854545041  	dc.b	"+HTTPACTION",0
 509  000c               L361:
 510  000c 2b425400      	dc.b	"+BT",0
 511  0010               L551:
 512  0010 444f574e4c4f  	dc.b	"DOWNLOAD",0
 513  0019               L741:
 514  0019 4f4b00        	dc.b	"OK",0
 534                     	end
