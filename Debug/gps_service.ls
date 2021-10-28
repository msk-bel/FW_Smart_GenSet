   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  68                     ; 96 bool bIsGPSTurnedON(void)
  68                     ; 97 {
  70                     	switch	.text
  71  0000               _bIsGPSTurnedON:
  75                     ; 98     ms_send_cmd(GNSS_CHECK_STATE, strlen((const char *)GNSS_CHECK_STATE));
  77  0000 4b08          	push	#8
  78  0002 ae0094        	ldw	x,#L13
  79  0005 cd0000        	call	_ms_send_cmd
  81  0008 84            	pop	a
  82                     ; 99     delay_ms(500);
  84  0009 ae01f4        	ldw	x,#500
  85  000c cd0000        	call	_delay_ms
  87                     ; 100     if (strstr(response_buffer, "+QGPS: 1"))
  89  000f ae008b        	ldw	x,#L53
  90  0012 89            	pushw	x
  91  0013 ae0000        	ldw	x,#_response_buffer
  92  0016 cd0000        	call	_strstr
  94  0019 5b02          	addw	sp,#2
  95  001b a30000        	cpw	x,#0
  96  001e 2703          	jreq	L33
  97                     ; 101         return 1;
  99  0020 a601          	ld	a,#1
 102  0022 81            	ret
 103  0023               L33:
 104                     ; 103         return 0;
 106  0023 4f            	clr	a
 109  0024 81            	ret
 147                     ; 106 void vTurnGPSOn(bool temp)
 147                     ; 107 {
 148                     	switch	.text
 149  0025               _vTurnGPSOn:
 153                     ; 108     if (temp)
 155  0025 4d            	tnz	a
 156  0026 2720          	jreq	L75
 157                     ; 110         ms_send_cmd(GNSS_TURN_GPS_ON, strlen((const char *)GNSS_TURN_GPS_ON));
 159  0028 4b09          	push	#9
 160  002a ae0081        	ldw	x,#L16
 161  002d cd0000        	call	_ms_send_cmd
 163  0030 84            	pop	a
 164                     ; 111         delay_ms(500);
 166  0031 ae01f4        	ldw	x,#500
 167  0034 cd0000        	call	_delay_ms
 169                     ; 112         ms_send_cmd(GNSS_TURN_AGPS_ON, strlen((const char *)GNSS_TURN_AGPS_ON));
 171  0037 4b0a          	push	#10
 172  0039 ae0076        	ldw	x,#L36
 173  003c cd0000        	call	_ms_send_cmd
 175  003f 84            	pop	a
 176                     ; 113         delay_ms(500);
 178  0040 ae01f4        	ldw	x,#500
 179  0043 cd0000        	call	_delay_ms
 182  0046 200f          	jra	L56
 183  0048               L75:
 184                     ; 117         ms_send_cmd(GNSS_TURN_GPS_OFF, strlen((const char *)GNSS_TURN_GPS_OFF));
 186  0048 4b0a          	push	#10
 187  004a ae006b        	ldw	x,#L76
 188  004d cd0000        	call	_ms_send_cmd
 190  0050 84            	pop	a
 191                     ; 118         delay_ms(500);
 193  0051 ae01f4        	ldw	x,#500
 194  0054 cd0000        	call	_delay_ms
 196  0057               L56:
 197                     ; 120 }
 200  0057 81            	ret
 203                     .const:	section	.text
 204  0000               L17_loc:
 205  0000 687474703a2f  	dc.b	"http://maps.google"
 206  0012 2e636f6d2f6d  	dc.b	".com/maps?q=loc:",0
 207  0023 000000000000  	ds.b	21
 208                     	bsct
 209  0000               L37_iteration:
 210  0000 00            	dc.b	0
 353                     ; 122 void gps_data(void)
 353                     ; 123 {
 354                     	switch	.text
 355  0058               _gps_data:
 357  0058 52a5          	subw	sp,#165
 358       000000a5      OFST:	set	165
 361                     ; 125     uint8_t r = 0, x = 0, y = 0, z = 0, w = 0, p = 0, k = 0, i = 0;
 377                     ; 126     uint16_t while_timeout = 0;
 379  005a 5f            	clrw	x
 380  005b 1f3e          	ldw	(OFST-103,sp),x
 382                     ; 127     char loc[56] = "http://maps.google.com/maps?q=loc:"; // added 4 charachters
 384  005d 96            	ldw	x,sp
 385  005e 1c0006        	addw	x,#OFST-159
 386  0061 90ae0000      	ldw	y,#L17_loc
 387  0065 a638          	ld	a,#56
 388  0067 cd0000        	call	c_xymvx
 390                     ; 131     if (iteration > 10)
 392  006a b600          	ld	a,L37_iteration
 393  006c a10b          	cp	a,#11
 394  006e 2403          	jruge	L43
 395  0070 cc01bf        	jp	L761
 396  0073               L43:
 397                     ; 133         ms_send_cmd(NOECHO, strlen((const char *)NOECHO));
 399  0073 4b04          	push	#4
 400  0075 ae0066        	ldw	x,#L171
 401  0078 cd0000        	call	_ms_send_cmd
 403  007b 84            	pop	a
 404                     ; 134         delay_ms(200);
 406  007c ae00c8        	ldw	x,#200
 407  007f cd0000        	call	_delay_ms
 410  0082 200a          	jra	L571
 411  0084               L371:
 412                     ; 138             vTurnGPSOn(TRUE);
 414  0084 a601          	ld	a,#1
 415  0086 ad9d          	call	_vTurnGPSOn
 417                     ; 139             delay_ms(1000);
 419  0088 ae03e8        	ldw	x,#1000
 420  008b cd0000        	call	_delay_ms
 422  008e               L571:
 423                     ; 136         while (!bIsGPSTurnedON() && (++while_timeout != 10))
 425  008e cd0000        	call	_bIsGPSTurnedON
 427  0091 4d            	tnz	a
 428  0092 260c          	jrne	L102
 430  0094 1e3e          	ldw	x,(OFST-103,sp)
 431  0096 1c0001        	addw	x,#1
 432  0099 1f3e          	ldw	(OFST-103,sp),x
 434  009b a3000a        	cpw	x,#10
 435  009e 26e4          	jrne	L371
 436  00a0               L102:
 437                     ; 141         for (r = 0; r < 100; r++)
 439  00a0 0fa4          	clr	(OFST-1,sp)
 441  00a2               L302:
 442                     ; 143             gps_buffer[r] = '0';
 444  00a2 96            	ldw	x,sp
 445  00a3 1c0040        	addw	x,#OFST-101
 446  00a6 9f            	ld	a,xl
 447  00a7 5e            	swapw	x
 448  00a8 1ba4          	add	a,(OFST-1,sp)
 449  00aa 2401          	jrnc	L21
 450  00ac 5c            	incw	x
 451  00ad               L21:
 452  00ad 02            	rlwa	x,a
 453  00ae a630          	ld	a,#48
 454  00b0 f7            	ld	(x),a
 455                     ; 141         for (r = 0; r < 100; r++)
 457  00b1 0ca4          	inc	(OFST-1,sp)
 461  00b3 7ba4          	ld	a,(OFST-1,sp)
 462  00b5 a164          	cp	a,#100
 463  00b7 25e9          	jrult	L302
 464                     ; 146         ms_send_cmd(GNSS_GET_LOCATION, strlen((const char *)GNSS_GET_LOCATION));
 466  00b9 4b0c          	push	#12
 467  00bb ae0059        	ldw	x,#L112
 468  00be cd0000        	call	_ms_send_cmd
 470  00c1 84            	pop	a
 471                     ; 147         delay_ms(200);
 473  00c2 ae00c8        	ldw	x,#200
 474  00c5 cd0000        	call	_delay_ms
 476                     ; 148         if (strstr(response_buffer, "+QGPSLOC:"))
 478  00c8 ae004f        	ldw	x,#L512
 479  00cb 89            	pushw	x
 480  00cc ae0000        	ldw	x,#_response_buffer
 481  00cf cd0000        	call	_strstr
 483  00d2 5b02          	addw	sp,#2
 484  00d4 a30000        	cpw	x,#0
 485  00d7 2603          	jrne	L63
 486  00d9 cc018b        	jp	L312
 487  00dc               L63:
 488                     ; 150             for (x = 0; x < 100; x++)
 490  00dc 0fa5          	clr	(OFST+0,sp)
 492  00de               L712:
 493                     ; 152                 gps_buffer[x] = response_buffer[x];
 495  00de 96            	ldw	x,sp
 496  00df 1c0040        	addw	x,#OFST-101
 497  00e2 9f            	ld	a,xl
 498  00e3 5e            	swapw	x
 499  00e4 1ba5          	add	a,(OFST+0,sp)
 500  00e6 2401          	jrnc	L41
 501  00e8 5c            	incw	x
 502  00e9               L41:
 503  00e9 02            	rlwa	x,a
 504  00ea 7ba5          	ld	a,(OFST+0,sp)
 505  00ec 905f          	clrw	y
 506  00ee 9097          	ld	yl,a
 507  00f0 90d60000      	ld	a,(_response_buffer,y)
 508  00f4 f7            	ld	(x),a
 509                     ; 150             for (x = 0; x < 100; x++)
 511  00f5 0ca5          	inc	(OFST+0,sp)
 515  00f7 7ba5          	ld	a,(OFST+0,sp)
 516  00f9 a164          	cp	a,#100
 517  00fb 25e1          	jrult	L712
 518                     ; 155             x = 0;
 520  00fd 0fa5          	clr	(OFST+0,sp)
 523  00ff 2002          	jra	L132
 524  0101               L522:
 525                     ; 157                 x++; //Ignore First parameter i.e Run status
 528  0101 0ca5          	inc	(OFST+0,sp)
 530  0103               L132:
 531                     ; 156             while (gps_buffer[x] != ',')
 531                     ; 157                 x++; //Ignore First parameter i.e Run status
 533  0103 96            	ldw	x,sp
 534  0104 1c0040        	addw	x,#OFST-101
 535  0107 9f            	ld	a,xl
 536  0108 5e            	swapw	x
 537  0109 1ba5          	add	a,(OFST+0,sp)
 538  010b 2401          	jrnc	L61
 539  010d 5c            	incw	x
 540  010e               L61:
 541  010e 02            	rlwa	x,a
 542  010f f6            	ld	a,(x)
 543  0110 a12c          	cp	a,#44
 544  0112 26ed          	jrne	L522
 545                     ; 158             x++;
 547  0114 0ca5          	inc	(OFST+0,sp)
 549                     ; 159             i = 0;
 551  0116 0fa4          	clr	(OFST-1,sp)
 554  0118 201f          	jra	L142
 555  011a               L532:
 556                     ; 162                 if (i < 10)
 558  011a 7ba4          	ld	a,(OFST-1,sp)
 559  011c a10a          	cp	a,#10
 560  011e 2415          	jruge	L542
 561                     ; 164                     stGPS_Coordinates.gps_latitude[i] = gps_buffer[x];
 563  0120 7ba4          	ld	a,(OFST-1,sp)
 564  0122 5f            	clrw	x
 565  0123 97            	ld	xl,a
 566  0124 89            	pushw	x
 567  0125 96            	ldw	x,sp
 568  0126 1c0042        	addw	x,#OFST-99
 569  0129 9f            	ld	a,xl
 570  012a 5e            	swapw	x
 571  012b 1ba7          	add	a,(OFST+2,sp)
 572  012d 2401          	jrnc	L02
 573  012f 5c            	incw	x
 574  0130               L02:
 575  0130 02            	rlwa	x,a
 576  0131 f6            	ld	a,(x)
 577  0132 85            	popw	x
 578  0133 e700          	ld	(_stGPS_Coordinates,x),a
 579  0135               L542:
 580                     ; 166                 x++;
 582  0135 0ca5          	inc	(OFST+0,sp)
 584                     ; 167                 i++;
 586  0137 0ca4          	inc	(OFST-1,sp)
 588  0139               L142:
 589                     ; 160             while (gps_buffer[x] != ',') // 4th Parameter:	 Latitude
 589                     ; 161             {
 589                     ; 162                 if (i < 10)
 589                     ; 163                 {
 589                     ; 164                     stGPS_Coordinates.gps_latitude[i] = gps_buffer[x];
 589                     ; 165                 }
 589                     ; 166                 x++;
 589                     ; 167                 i++;
 591  0139 96            	ldw	x,sp
 592  013a 1c0040        	addw	x,#OFST-101
 593  013d 9f            	ld	a,xl
 594  013e 5e            	swapw	x
 595  013f 1ba5          	add	a,(OFST+0,sp)
 596  0141 2401          	jrnc	L22
 597  0143 5c            	incw	x
 598  0144               L22:
 599  0144 02            	rlwa	x,a
 600  0145 f6            	ld	a,(x)
 601  0146 a12c          	cp	a,#44
 602  0148 26d0          	jrne	L532
 603                     ; 169             x++;
 605  014a 0ca5          	inc	(OFST+0,sp)
 607                     ; 170             i = 0;
 609  014c 0fa4          	clr	(OFST-1,sp)
 611                     ; 171             vClearBuffer(stGPS_Coordinates.gps_longitude, 11);
 613  014e 4b0b          	push	#11
 614  0150 ae000b        	ldw	x,#_stGPS_Coordinates+11
 615  0153 cd0000        	call	_vClearBuffer
 617  0156 84            	pop	a
 619  0157 201f          	jra	L152
 620  0159               L742:
 621                     ; 174                 if (i < 11)
 623  0159 7ba4          	ld	a,(OFST-1,sp)
 624  015b a10b          	cp	a,#11
 625  015d 2415          	jruge	L552
 626                     ; 176                     stGPS_Coordinates.gps_longitude[i] = gps_buffer[x];
 628  015f 7ba4          	ld	a,(OFST-1,sp)
 629  0161 5f            	clrw	x
 630  0162 97            	ld	xl,a
 631  0163 89            	pushw	x
 632  0164 96            	ldw	x,sp
 633  0165 1c0042        	addw	x,#OFST-99
 634  0168 9f            	ld	a,xl
 635  0169 5e            	swapw	x
 636  016a 1ba7          	add	a,(OFST+2,sp)
 637  016c 2401          	jrnc	L42
 638  016e 5c            	incw	x
 639  016f               L42:
 640  016f 02            	rlwa	x,a
 641  0170 f6            	ld	a,(x)
 642  0171 85            	popw	x
 643  0172 e70b          	ld	(_stGPS_Coordinates+11,x),a
 644  0174               L552:
 645                     ; 178                 x++;
 647  0174 0ca5          	inc	(OFST+0,sp)
 649                     ; 179                 i++;
 651  0176 0ca4          	inc	(OFST-1,sp)
 653  0178               L152:
 654                     ; 172             while (gps_buffer[x] != ',') // 5th Parameter:	 Longitude
 656  0178 96            	ldw	x,sp
 657  0179 1c0040        	addw	x,#OFST-101
 658  017c 9f            	ld	a,xl
 659  017d 5e            	swapw	x
 660  017e 1ba5          	add	a,(OFST+0,sp)
 661  0180 2401          	jrnc	L62
 662  0182 5c            	incw	x
 663  0183               L62:
 664  0183 02            	rlwa	x,a
 665  0184 f6            	ld	a,(x)
 666  0185 a12c          	cp	a,#44
 667  0187 26d0          	jrne	L742
 669  0189 2032          	jra	L752
 670  018b               L312:
 671                     ; 185             vClearBuffer(stGPS_Coordinates.gps_latitude, 11);
 673  018b 4b0b          	push	#11
 674  018d ae0000        	ldw	x,#_stGPS_Coordinates
 675  0190 cd0000        	call	_vClearBuffer
 677  0193 84            	pop	a
 678                     ; 186             vClearBuffer(stGPS_Coordinates.gps_longitude, 12);
 680  0194 4b0c          	push	#12
 681  0196 ae000b        	ldw	x,#_stGPS_Coordinates+11
 682  0199 cd0000        	call	_vClearBuffer
 684  019c 84            	pop	a
 685                     ; 187             strcpy(stGPS_Coordinates.gps_latitude, "1111111111");
 687  019d ae0000        	ldw	x,#_stGPS_Coordinates
 688  01a0 90ae0044      	ldw	y,#L162
 689  01a4               L03:
 690  01a4 90f6          	ld	a,(y)
 691  01a6 905c          	incw	y
 692  01a8 f7            	ld	(x),a
 693  01a9 5c            	incw	x
 694  01aa 4d            	tnz	a
 695  01ab 26f7          	jrne	L03
 696                     ; 188             strcpy(stGPS_Coordinates.gps_longitude, "11111111111");
 698  01ad ae000b        	ldw	x,#_stGPS_Coordinates+11
 699  01b0 90ae0038      	ldw	y,#L362
 700  01b4               L23:
 701  01b4 90f6          	ld	a,(y)
 702  01b6 905c          	incw	y
 703  01b8 f7            	ld	(x),a
 704  01b9 5c            	incw	x
 705  01ba 4d            	tnz	a
 706  01bb 26f7          	jrne	L23
 707  01bd               L752:
 708                     ; 190         iteration = 0;
 710  01bd 3f00          	clr	L37_iteration
 711  01bf               L761:
 712                     ; 192     iteration++;
 714  01bf 3c00          	inc	L37_iteration
 715                     ; 193 }
 718  01c1 5ba5          	addw	sp,#165
 719  01c3 81            	ret
 744                     ; 195 uint8_t *getGPS_Latitude(void)
 744                     ; 196 {
 745                     	switch	.text
 746  01c4               _getGPS_Latitude:
 750                     ; 197     return stGPS_Coordinates.gps_latitude;
 752  01c4 ae0000        	ldw	x,#_stGPS_Coordinates
 755  01c7 81            	ret
 780                     ; 200 uint8_t *getGPS_Longitude(void)
 780                     ; 201 {
 781                     	switch	.text
 782  01c8               _getGPS_Longitude:
 786                     ; 202     return stGPS_Coordinates.gps_longitude;
 788  01c8 ae000b        	ldw	x,#_stGPS_Coordinates+11
 791  01cb 81            	ret
 844                     	xdef	_bIsGPSTurnedON
 845                     	xdef	_vTurnGPSOn
 846                     	xdef	_getGPS_Longitude
 847                     	xdef	_getGPS_Latitude
 848                     	xdef	_gps_data
 849                     	switch	.ubsct
 850  0000               _stGPS_Coordinates:
 851  0000 000000000000  	ds.b	23
 852                     	xdef	_stGPS_Coordinates
 853                     	xref	_ms_send_cmd
 854                     	xref	_vClearBuffer
 855                     	xref	_response_buffer
 856                     	xref	_strstr
 857                     	xref	_delay_ms
 858                     	switch	.const
 859  0038               L362:
 860  0038 313131313131  	dc.b	"11111111111",0
 861  0044               L162:
 862  0044 313131313131  	dc.b	"1111111111",0
 863  004f               L512:
 864  004f 2b514750534c  	dc.b	"+QGPSLOC:",0
 865  0059               L112:
 866  0059 41542b514750  	dc.b	"AT+QGPSLOC=2",0
 867  0066               L171:
 868  0066 4154453000    	dc.b	"ATE0",0
 869  006b               L76:
 870  006b 41542b514750  	dc.b	"AT+QGPSEND",0
 871  0076               L36:
 872  0076 41542b514147  	dc.b	"AT+QAGPS=1",0
 873  0081               L16:
 874  0081 41542b514750  	dc.b	"AT+QGPS=1",0
 875  008b               L53:
 876  008b 2b514750533a  	dc.b	"+QGPS: 1",0
 877  0094               L13:
 878  0094 41542b514750  	dc.b	"AT+QGPS?",0
 879                     	xref.b	c_x
 899                     	xref	c_xymvx
 900                     	end
