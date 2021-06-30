   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	switch	.data
  15  0000               _aunPushed_Data:
  16  0000 00            	dc.b	0
  17  0001 000000000000  	ds.b	99
  18  0064               _aunMQTT_ClientID:
  19  0064 67656e313233  	dc.b	"gen123456789012345",0
  20  0077 00            	ds.b	1
  21  0078               _aunMQTT_Subscribe_Topic:
  22  0078 7363312f3132  	dc.b	"sc1/12345678901234"
  23  008a 352f636d6400  	dc.b	"5/cmd",0
  24  0090               _aunMQTT_Publish_Topic:
  25  0090 7363312f3132  	dc.b	"sc1/12345678901234"
  26  00a2 352f65767400  	dc.b	"5/evt",0
  27                     	bsct
  28  0000               _bCONNACK_Recieved:
  29  0000 00            	dc.b	0
  30                     	switch	.ubsct
  31  0000               L3_enSendEventCounter:
  32  0000 00            	ds.b	1
 258                     ; 46 void sendDataToCloud(void)
 258                     ; 47 {
 260                     	switch	.text
 261  0000               _sendDataToCloud:
 263  0000 5266          	subw	sp,#102
 264       00000066      OFST:	set	102
 267                     ; 52     stringLength = createStringToSend(informationString);
 269  0002 96            	ldw	x,sp
 270  0003 1c0001        	addw	x,#OFST-101
 271  0006 ad26          	call	_createStringToSend
 273                     ; 53     eTCP_Status = enGet_TCP_Status();
 275  0008 cd0000        	call	_enGet_TCP_Status
 277  000b 6b66          	ld	(OFST+0,sp),a
 279                     ; 54     if (eTCP_Status == eTCP_STAT_CONNECT_OK)
 281  000d 7b66          	ld	a,(OFST+0,sp)
 282  000f a107          	cp	a,#7
 283  0011 2614          	jrne	L731
 284                     ; 56         switch (enSendEventCounter)
 286  0013 3d00          	tnz	L3_enSendEventCounter
 287  0015 2602          	jrne	L341
 290  0017               L5:
 291                     ; 58         case eCommand_Reserved:
 291                     ; 59             enSendEventCounter++;
 293  0017 3c00          	inc	L3_enSendEventCounter
 294                     ; 60             break;
 296  0019               L7:
 297                     ; 61         case eCommand_IMEI:
 297                     ; 62             //vMevris_Send_sensorData();
 297                     ; 63             //            enSendEventCounter++;
 297                     ; 64             break;
 299  0019               L11:
 300                     ; 65         case eCommand_SIM_Number:
 300                     ; 66             // vMevris_Send_SIM_Number();
 300                     ; 67             //            enSendEventCounter++;
 300                     ; 68             break;
 302  0019               L31:
 303                     ; 69         case eCommand_Location:
 303                     ; 70             // vMevris_Send_Location();
 303                     ; 71             //            enSendEventCounter++;
 303                     ; 72             break;
 305  0019               L51:
 306                     ; 73         case eCommand_Bike_State:
 306                     ; 74             //  vMevris_Send_BikeState();
 306                     ; 75             //            enSendEventCounter++;
 306                     ; 76             break;
 308  0019               L71:
 309                     ; 77         default:
 309                     ; 78             break;
 311  0019               L341:
 312                     ; 81         enSendEventCounter++;
 314  0019 3c00          	inc	L3_enSendEventCounter
 315                     ; 82         if (enSendEventCounter >= eCommand_Others)
 317  001b b600          	ld	a,L3_enSendEventCounter
 318  001d a106          	cp	a,#6
 319  001f 250a          	jrult	L741
 320                     ; 83             enSendEventCounter = eCommand_IMEI;
 322  0021 35010000      	mov	L3_enSendEventCounter,#1
 323  0025 2004          	jra	L741
 324  0027               L731:
 325                     ; 87         enSendEventCounter = eCommand_IMEI;
 327  0027 35010000      	mov	L3_enSendEventCounter,#1
 328  002b               L741:
 329                     ; 89 }
 332  002b 5b66          	addw	sp,#102
 333  002d 81            	ret
 446                     ; 91 int createStringToSend(uint8_t *informationString)
 446                     ; 92 {
 447                     	switch	.text
 448  002e               _createStringToSend:
 450  002e 89            	pushw	x
 451  002f 5219          	subw	sp,#25
 452       00000019      OFST:	set	25
 455                     ; 97     uint8_t temp1Length = 0;
 457                     ; 102     sprintf(temp1, "%d", 1234);
 459  0031 ae04d2        	ldw	x,#1234
 460  0034 89            	pushw	x
 461  0035 ae0043        	ldw	x,#L722
 462  0038 89            	pushw	x
 463  0039 96            	ldw	x,sp
 464  003a 1c0006        	addw	x,#OFST-19
 465  003d cd0000        	call	_sprintf
 467  0040 5b04          	addw	sp,#4
 468                     ; 103     temp1Length = strlen(temp1);
 470  0042 96            	ldw	x,sp
 471  0043 1c0002        	addw	x,#OFST-23
 472  0046 cd0000        	call	_strlen
 474  0049 01            	rrwa	x,a
 475  004a 6b01          	ld	(OFST-24,sp),a
 476  004c 02            	rlwa	x,a
 478                     ; 104     decPlace = temp1Length - 2;
 480  004d 7b01          	ld	a,(OFST-24,sp)
 481  004f a002          	sub	a,#2
 482  0051 6b18          	ld	(OFST-1,sp),a
 484                     ; 105     temp2[decPlace] = '.';
 486  0053 96            	ldw	x,sp
 487  0054 1c0008        	addw	x,#OFST-17
 488  0057 9f            	ld	a,xl
 489  0058 5e            	swapw	x
 490  0059 1b18          	add	a,(OFST-1,sp)
 491  005b 2401          	jrnc	L01
 492  005d 5c            	incw	x
 493  005e               L01:
 494  005e 02            	rlwa	x,a
 495  005f a62e          	ld	a,#46
 496  0061 f7            	ld	(x),a
 497                     ; 106     for (w = 0; w < decPlace; w++)
 499  0062 0f19          	clr	(OFST+0,sp)
 502  0064 201e          	jra	L532
 503  0066               L132:
 504                     ; 108         temp2[w] = temp1[w];
 506  0066 96            	ldw	x,sp
 507  0067 1c0008        	addw	x,#OFST-17
 508  006a 9f            	ld	a,xl
 509  006b 5e            	swapw	x
 510  006c 1b19          	add	a,(OFST+0,sp)
 511  006e 2401          	jrnc	L21
 512  0070 5c            	incw	x
 513  0071               L21:
 514  0071 02            	rlwa	x,a
 515  0072 89            	pushw	x
 516  0073 96            	ldw	x,sp
 517  0074 1c0004        	addw	x,#OFST-21
 518  0077 9f            	ld	a,xl
 519  0078 5e            	swapw	x
 520  0079 1b1b          	add	a,(OFST+2,sp)
 521  007b 2401          	jrnc	L41
 522  007d 5c            	incw	x
 523  007e               L41:
 524  007e 02            	rlwa	x,a
 525  007f f6            	ld	a,(x)
 526  0080 85            	popw	x
 527  0081 f7            	ld	(x),a
 528                     ; 106     for (w = 0; w < decPlace; w++)
 530  0082 0c19          	inc	(OFST+0,sp)
 532  0084               L532:
 535  0084 7b19          	ld	a,(OFST+0,sp)
 536  0086 1118          	cp	a,(OFST-1,sp)
 537  0088 25dc          	jrult	L132
 538                     ; 110     f = decPlace + 1;
 540  008a 7b18          	ld	a,(OFST-1,sp)
 541  008c 4c            	inc	a
 542  008d 6b18          	ld	(OFST-1,sp),a
 544                     ; 111     for (w = f; w <= temp1Length; w++)
 546  008f 7b18          	ld	a,(OFST-1,sp)
 547  0091 6b19          	ld	(OFST+0,sp),a
 550  0093 2023          	jra	L542
 551  0095               L142:
 552                     ; 113         u = w - 1;
 554  0095 7b19          	ld	a,(OFST+0,sp)
 555  0097 4a            	dec	a
 556  0098 6b18          	ld	(OFST-1,sp),a
 558                     ; 114         temp2[w] = temp1[u];
 560  009a 96            	ldw	x,sp
 561  009b 1c0008        	addw	x,#OFST-17
 562  009e 9f            	ld	a,xl
 563  009f 5e            	swapw	x
 564  00a0 1b19          	add	a,(OFST+0,sp)
 565  00a2 2401          	jrnc	L61
 566  00a4 5c            	incw	x
 567  00a5               L61:
 568  00a5 02            	rlwa	x,a
 569  00a6 89            	pushw	x
 570  00a7 96            	ldw	x,sp
 571  00a8 1c0004        	addw	x,#OFST-21
 572  00ab 9f            	ld	a,xl
 573  00ac 5e            	swapw	x
 574  00ad 1b1a          	add	a,(OFST+1,sp)
 575  00af 2401          	jrnc	L02
 576  00b1 5c            	incw	x
 577  00b2               L02:
 578  00b2 02            	rlwa	x,a
 579  00b3 f6            	ld	a,(x)
 580  00b4 85            	popw	x
 581  00b5 f7            	ld	(x),a
 582                     ; 111     for (w = f; w <= temp1Length; w++)
 584  00b6 0c19          	inc	(OFST+0,sp)
 586  00b8               L542:
 589  00b8 7b19          	ld	a,(OFST+0,sp)
 590  00ba 1101          	cp	a,(OFST-24,sp)
 591  00bc 23d7          	jrule	L142
 592                     ; 116     temp2[w] = '\0';
 594  00be 96            	ldw	x,sp
 595  00bf 1c0008        	addw	x,#OFST-17
 596  00c2 9f            	ld	a,xl
 597  00c3 5e            	swapw	x
 598  00c4 1b19          	add	a,(OFST+0,sp)
 599  00c6 2401          	jrnc	L22
 600  00c8 5c            	incw	x
 601  00c9               L22:
 602  00c9 02            	rlwa	x,a
 603  00ca 7f            	clr	(x)
 604                     ; 118     strcpy(informationString, "{");
 606  00cb 1e1a          	ldw	x,(OFST+1,sp)
 607  00cd 90ae0041      	ldw	y,#L152
 608  00d1               L42:
 609  00d1 90f6          	ld	a,(y)
 610  00d3 905c          	incw	y
 611  00d5 f7            	ld	(x),a
 612  00d6 5c            	incw	x
 613  00d7 4d            	tnz	a
 614  00d8 26f7          	jrne	L42
 615                     ; 119     strcat(informationString, temp2);
 617  00da 96            	ldw	x,sp
 618  00db 1c0008        	addw	x,#OFST-17
 619  00de 89            	pushw	x
 620  00df 1e1c          	ldw	x,(OFST+3,sp)
 621  00e1 cd0000        	call	_strcat
 623  00e4 85            	popw	x
 624                     ; 120     strcat(informationString, ",");
 626  00e5 ae003f        	ldw	x,#L352
 627  00e8 89            	pushw	x
 628  00e9 1e1c          	ldw	x,(OFST+3,sp)
 629  00eb cd0000        	call	_strcat
 631  00ee 85            	popw	x
 632                     ; 122     sprintf(temp1, "%d", 4567);
 634  00ef ae11d7        	ldw	x,#4567
 635  00f2 89            	pushw	x
 636  00f3 ae0043        	ldw	x,#L722
 637  00f6 89            	pushw	x
 638  00f7 96            	ldw	x,sp
 639  00f8 1c0006        	addw	x,#OFST-19
 640  00fb cd0000        	call	_sprintf
 642  00fe 5b04          	addw	sp,#4
 643                     ; 123     temp1Length = strlen(temp1);
 645  0100 96            	ldw	x,sp
 646  0101 1c0002        	addw	x,#OFST-23
 647  0104 cd0000        	call	_strlen
 649  0107 01            	rrwa	x,a
 650  0108 6b01          	ld	(OFST-24,sp),a
 651  010a 02            	rlwa	x,a
 653                     ; 124     decPlace = temp1Length - 2;
 655  010b 7b01          	ld	a,(OFST-24,sp)
 656  010d a002          	sub	a,#2
 657  010f 6b18          	ld	(OFST-1,sp),a
 659                     ; 125     temp2[decPlace] = '.';
 661  0111 96            	ldw	x,sp
 662  0112 1c0008        	addw	x,#OFST-17
 663  0115 9f            	ld	a,xl
 664  0116 5e            	swapw	x
 665  0117 1b18          	add	a,(OFST-1,sp)
 666  0119 2401          	jrnc	L62
 667  011b 5c            	incw	x
 668  011c               L62:
 669  011c 02            	rlwa	x,a
 670  011d a62e          	ld	a,#46
 671  011f f7            	ld	(x),a
 672                     ; 126     for (w = 0; w < decPlace; w++)
 674  0120 0f19          	clr	(OFST+0,sp)
 677  0122 201e          	jra	L162
 678  0124               L552:
 679                     ; 128         temp2[w] = temp1[w];
 681  0124 96            	ldw	x,sp
 682  0125 1c0008        	addw	x,#OFST-17
 683  0128 9f            	ld	a,xl
 684  0129 5e            	swapw	x
 685  012a 1b19          	add	a,(OFST+0,sp)
 686  012c 2401          	jrnc	L03
 687  012e 5c            	incw	x
 688  012f               L03:
 689  012f 02            	rlwa	x,a
 690  0130 89            	pushw	x
 691  0131 96            	ldw	x,sp
 692  0132 1c0004        	addw	x,#OFST-21
 693  0135 9f            	ld	a,xl
 694  0136 5e            	swapw	x
 695  0137 1b1b          	add	a,(OFST+2,sp)
 696  0139 2401          	jrnc	L23
 697  013b 5c            	incw	x
 698  013c               L23:
 699  013c 02            	rlwa	x,a
 700  013d f6            	ld	a,(x)
 701  013e 85            	popw	x
 702  013f f7            	ld	(x),a
 703                     ; 126     for (w = 0; w < decPlace; w++)
 705  0140 0c19          	inc	(OFST+0,sp)
 707  0142               L162:
 710  0142 7b19          	ld	a,(OFST+0,sp)
 711  0144 1118          	cp	a,(OFST-1,sp)
 712  0146 25dc          	jrult	L552
 713                     ; 130     f = decPlace + 1;
 715  0148 7b18          	ld	a,(OFST-1,sp)
 716  014a 4c            	inc	a
 717  014b 6b18          	ld	(OFST-1,sp),a
 719                     ; 131     for (w = f; w <= temp1Length; w++)
 721  014d 7b18          	ld	a,(OFST-1,sp)
 722  014f 6b19          	ld	(OFST+0,sp),a
 725  0151 2023          	jra	L172
 726  0153               L562:
 727                     ; 133         u = w - 1;
 729  0153 7b19          	ld	a,(OFST+0,sp)
 730  0155 4a            	dec	a
 731  0156 6b18          	ld	(OFST-1,sp),a
 733                     ; 134         temp2[w] = temp1[u];
 735  0158 96            	ldw	x,sp
 736  0159 1c0008        	addw	x,#OFST-17
 737  015c 9f            	ld	a,xl
 738  015d 5e            	swapw	x
 739  015e 1b19          	add	a,(OFST+0,sp)
 740  0160 2401          	jrnc	L43
 741  0162 5c            	incw	x
 742  0163               L43:
 743  0163 02            	rlwa	x,a
 744  0164 89            	pushw	x
 745  0165 96            	ldw	x,sp
 746  0166 1c0004        	addw	x,#OFST-21
 747  0169 9f            	ld	a,xl
 748  016a 5e            	swapw	x
 749  016b 1b1a          	add	a,(OFST+1,sp)
 750  016d 2401          	jrnc	L63
 751  016f 5c            	incw	x
 752  0170               L63:
 753  0170 02            	rlwa	x,a
 754  0171 f6            	ld	a,(x)
 755  0172 85            	popw	x
 756  0173 f7            	ld	(x),a
 757                     ; 131     for (w = f; w <= temp1Length; w++)
 759  0174 0c19          	inc	(OFST+0,sp)
 761  0176               L172:
 764  0176 7b19          	ld	a,(OFST+0,sp)
 765  0178 1101          	cp	a,(OFST-24,sp)
 766  017a 23d7          	jrule	L562
 767                     ; 136     temp2[w] = '\0';
 769  017c 96            	ldw	x,sp
 770  017d 1c0008        	addw	x,#OFST-17
 771  0180 9f            	ld	a,xl
 772  0181 5e            	swapw	x
 773  0182 1b19          	add	a,(OFST+0,sp)
 774  0184 2401          	jrnc	L04
 775  0186 5c            	incw	x
 776  0187               L04:
 777  0187 02            	rlwa	x,a
 778  0188 7f            	clr	(x)
 779                     ; 138     strcat(informationString, temp2);
 781  0189 96            	ldw	x,sp
 782  018a 1c0008        	addw	x,#OFST-17
 783  018d 89            	pushw	x
 784  018e 1e1c          	ldw	x,(OFST+3,sp)
 785  0190 cd0000        	call	_strcat
 787  0193 85            	popw	x
 788                     ; 139     strcat(informationString, ",");
 790  0194 ae003f        	ldw	x,#L352
 791  0197 89            	pushw	x
 792  0198 1e1c          	ldw	x,(OFST+3,sp)
 793  019a cd0000        	call	_strcat
 795  019d 85            	popw	x
 796                     ; 141     sprintf(temp1, "%d", 7891);
 798  019e ae1ed3        	ldw	x,#7891
 799  01a1 89            	pushw	x
 800  01a2 ae0043        	ldw	x,#L722
 801  01a5 89            	pushw	x
 802  01a6 96            	ldw	x,sp
 803  01a7 1c0006        	addw	x,#OFST-19
 804  01aa cd0000        	call	_sprintf
 806  01ad 5b04          	addw	sp,#4
 807                     ; 142     temp1Length = strlen(temp1);
 809  01af 96            	ldw	x,sp
 810  01b0 1c0002        	addw	x,#OFST-23
 811  01b3 cd0000        	call	_strlen
 813  01b6 01            	rrwa	x,a
 814  01b7 6b01          	ld	(OFST-24,sp),a
 815  01b9 02            	rlwa	x,a
 817                     ; 143     decPlace = temp1Length - 2;
 819  01ba 7b01          	ld	a,(OFST-24,sp)
 820  01bc a002          	sub	a,#2
 821  01be 6b18          	ld	(OFST-1,sp),a
 823                     ; 144     temp2[decPlace] = '.';
 825  01c0 96            	ldw	x,sp
 826  01c1 1c0008        	addw	x,#OFST-17
 827  01c4 9f            	ld	a,xl
 828  01c5 5e            	swapw	x
 829  01c6 1b18          	add	a,(OFST-1,sp)
 830  01c8 2401          	jrnc	L24
 831  01ca 5c            	incw	x
 832  01cb               L24:
 833  01cb 02            	rlwa	x,a
 834  01cc a62e          	ld	a,#46
 835  01ce f7            	ld	(x),a
 836                     ; 145     for (w = 0; w < decPlace; w++)
 838  01cf 0f19          	clr	(OFST+0,sp)
 841  01d1 201e          	jra	L103
 842  01d3               L572:
 843                     ; 147         temp2[w] = temp1[w];
 845  01d3 96            	ldw	x,sp
 846  01d4 1c0008        	addw	x,#OFST-17
 847  01d7 9f            	ld	a,xl
 848  01d8 5e            	swapw	x
 849  01d9 1b19          	add	a,(OFST+0,sp)
 850  01db 2401          	jrnc	L44
 851  01dd 5c            	incw	x
 852  01de               L44:
 853  01de 02            	rlwa	x,a
 854  01df 89            	pushw	x
 855  01e0 96            	ldw	x,sp
 856  01e1 1c0004        	addw	x,#OFST-21
 857  01e4 9f            	ld	a,xl
 858  01e5 5e            	swapw	x
 859  01e6 1b1b          	add	a,(OFST+2,sp)
 860  01e8 2401          	jrnc	L64
 861  01ea 5c            	incw	x
 862  01eb               L64:
 863  01eb 02            	rlwa	x,a
 864  01ec f6            	ld	a,(x)
 865  01ed 85            	popw	x
 866  01ee f7            	ld	(x),a
 867                     ; 145     for (w = 0; w < decPlace; w++)
 869  01ef 0c19          	inc	(OFST+0,sp)
 871  01f1               L103:
 874  01f1 7b19          	ld	a,(OFST+0,sp)
 875  01f3 1118          	cp	a,(OFST-1,sp)
 876  01f5 25dc          	jrult	L572
 877                     ; 149     f = decPlace + 1;
 879  01f7 7b18          	ld	a,(OFST-1,sp)
 880  01f9 4c            	inc	a
 881  01fa 6b18          	ld	(OFST-1,sp),a
 883                     ; 150     for (w = f; w <= temp1Length; w++)
 885  01fc 7b18          	ld	a,(OFST-1,sp)
 886  01fe 6b19          	ld	(OFST+0,sp),a
 889  0200 2023          	jra	L113
 890  0202               L503:
 891                     ; 152         u = w - 1;
 893  0202 7b19          	ld	a,(OFST+0,sp)
 894  0204 4a            	dec	a
 895  0205 6b18          	ld	(OFST-1,sp),a
 897                     ; 153         temp2[w] = temp1[u];
 899  0207 96            	ldw	x,sp
 900  0208 1c0008        	addw	x,#OFST-17
 901  020b 9f            	ld	a,xl
 902  020c 5e            	swapw	x
 903  020d 1b19          	add	a,(OFST+0,sp)
 904  020f 2401          	jrnc	L05
 905  0211 5c            	incw	x
 906  0212               L05:
 907  0212 02            	rlwa	x,a
 908  0213 89            	pushw	x
 909  0214 96            	ldw	x,sp
 910  0215 1c0004        	addw	x,#OFST-21
 911  0218 9f            	ld	a,xl
 912  0219 5e            	swapw	x
 913  021a 1b1a          	add	a,(OFST+1,sp)
 914  021c 2401          	jrnc	L25
 915  021e 5c            	incw	x
 916  021f               L25:
 917  021f 02            	rlwa	x,a
 918  0220 f6            	ld	a,(x)
 919  0221 85            	popw	x
 920  0222 f7            	ld	(x),a
 921                     ; 150     for (w = f; w <= temp1Length; w++)
 923  0223 0c19          	inc	(OFST+0,sp)
 925  0225               L113:
 928  0225 7b19          	ld	a,(OFST+0,sp)
 929  0227 1101          	cp	a,(OFST-24,sp)
 930  0229 23d7          	jrule	L503
 931                     ; 155     temp2[w] = '\0';
 933  022b 96            	ldw	x,sp
 934  022c 1c0008        	addw	x,#OFST-17
 935  022f 9f            	ld	a,xl
 936  0230 5e            	swapw	x
 937  0231 1b19          	add	a,(OFST+0,sp)
 938  0233 2401          	jrnc	L45
 939  0235 5c            	incw	x
 940  0236               L45:
 941  0236 02            	rlwa	x,a
 942  0237 7f            	clr	(x)
 943                     ; 157     strcat(informationString, temp2);
 945  0238 96            	ldw	x,sp
 946  0239 1c0008        	addw	x,#OFST-17
 947  023c 89            	pushw	x
 948  023d 1e1c          	ldw	x,(OFST+3,sp)
 949  023f cd0000        	call	_strcat
 951  0242 85            	popw	x
 952                     ; 158     strcat(informationString, ",");
 954  0243 ae003f        	ldw	x,#L352
 955  0246 89            	pushw	x
 956  0247 1e1c          	ldw	x,(OFST+3,sp)
 957  0249 cd0000        	call	_strcat
 959  024c 85            	popw	x
 960                     ; 160     sprintf(temp1, "%d", 1234);
 962  024d ae04d2        	ldw	x,#1234
 963  0250 89            	pushw	x
 964  0251 ae0043        	ldw	x,#L722
 965  0254 89            	pushw	x
 966  0255 96            	ldw	x,sp
 967  0256 1c0006        	addw	x,#OFST-19
 968  0259 cd0000        	call	_sprintf
 970  025c 5b04          	addw	sp,#4
 971                     ; 161     temp1Length = strlen(temp1);
 973  025e 96            	ldw	x,sp
 974  025f 1c0002        	addw	x,#OFST-23
 975  0262 cd0000        	call	_strlen
 977  0265 01            	rrwa	x,a
 978  0266 6b01          	ld	(OFST-24,sp),a
 979  0268 02            	rlwa	x,a
 981                     ; 162     decPlace = temp1Length - 2;
 983  0269 7b01          	ld	a,(OFST-24,sp)
 984  026b a002          	sub	a,#2
 985  026d 6b18          	ld	(OFST-1,sp),a
 987                     ; 163     temp2[decPlace] = '.';
 989  026f 96            	ldw	x,sp
 990  0270 1c0008        	addw	x,#OFST-17
 991  0273 9f            	ld	a,xl
 992  0274 5e            	swapw	x
 993  0275 1b18          	add	a,(OFST-1,sp)
 994  0277 2401          	jrnc	L65
 995  0279 5c            	incw	x
 996  027a               L65:
 997  027a 02            	rlwa	x,a
 998  027b a62e          	ld	a,#46
 999  027d f7            	ld	(x),a
1000                     ; 164     for (w = 0; w < decPlace; w++)
1002  027e 0f19          	clr	(OFST+0,sp)
1005  0280 201e          	jra	L123
1006  0282               L513:
1007                     ; 166         temp2[w] = temp1[w];
1009  0282 96            	ldw	x,sp
1010  0283 1c0008        	addw	x,#OFST-17
1011  0286 9f            	ld	a,xl
1012  0287 5e            	swapw	x
1013  0288 1b19          	add	a,(OFST+0,sp)
1014  028a 2401          	jrnc	L06
1015  028c 5c            	incw	x
1016  028d               L06:
1017  028d 02            	rlwa	x,a
1018  028e 89            	pushw	x
1019  028f 96            	ldw	x,sp
1020  0290 1c0004        	addw	x,#OFST-21
1021  0293 9f            	ld	a,xl
1022  0294 5e            	swapw	x
1023  0295 1b1b          	add	a,(OFST+2,sp)
1024  0297 2401          	jrnc	L26
1025  0299 5c            	incw	x
1026  029a               L26:
1027  029a 02            	rlwa	x,a
1028  029b f6            	ld	a,(x)
1029  029c 85            	popw	x
1030  029d f7            	ld	(x),a
1031                     ; 164     for (w = 0; w < decPlace; w++)
1033  029e 0c19          	inc	(OFST+0,sp)
1035  02a0               L123:
1038  02a0 7b19          	ld	a,(OFST+0,sp)
1039  02a2 1118          	cp	a,(OFST-1,sp)
1040  02a4 25dc          	jrult	L513
1041                     ; 168     f = decPlace + 1;
1043  02a6 7b18          	ld	a,(OFST-1,sp)
1044  02a8 4c            	inc	a
1045  02a9 6b18          	ld	(OFST-1,sp),a
1047                     ; 169     for (w = f; w <= temp1Length; w++)
1049  02ab 7b18          	ld	a,(OFST-1,sp)
1050  02ad 6b19          	ld	(OFST+0,sp),a
1053  02af 2023          	jra	L133
1054  02b1               L523:
1055                     ; 171         u = w - 1;
1057  02b1 7b19          	ld	a,(OFST+0,sp)
1058  02b3 4a            	dec	a
1059  02b4 6b18          	ld	(OFST-1,sp),a
1061                     ; 172         temp2[w] = temp1[u];
1063  02b6 96            	ldw	x,sp
1064  02b7 1c0008        	addw	x,#OFST-17
1065  02ba 9f            	ld	a,xl
1066  02bb 5e            	swapw	x
1067  02bc 1b19          	add	a,(OFST+0,sp)
1068  02be 2401          	jrnc	L46
1069  02c0 5c            	incw	x
1070  02c1               L46:
1071  02c1 02            	rlwa	x,a
1072  02c2 89            	pushw	x
1073  02c3 96            	ldw	x,sp
1074  02c4 1c0004        	addw	x,#OFST-21
1075  02c7 9f            	ld	a,xl
1076  02c8 5e            	swapw	x
1077  02c9 1b1a          	add	a,(OFST+1,sp)
1078  02cb 2401          	jrnc	L66
1079  02cd 5c            	incw	x
1080  02ce               L66:
1081  02ce 02            	rlwa	x,a
1082  02cf f6            	ld	a,(x)
1083  02d0 85            	popw	x
1084  02d1 f7            	ld	(x),a
1085                     ; 169     for (w = f; w <= temp1Length; w++)
1087  02d2 0c19          	inc	(OFST+0,sp)
1089  02d4               L133:
1092  02d4 7b19          	ld	a,(OFST+0,sp)
1093  02d6 1101          	cp	a,(OFST-24,sp)
1094  02d8 23d7          	jrule	L523
1095                     ; 174     temp2[w] = '\0';
1097  02da 96            	ldw	x,sp
1098  02db 1c0008        	addw	x,#OFST-17
1099  02de 9f            	ld	a,xl
1100  02df 5e            	swapw	x
1101  02e0 1b19          	add	a,(OFST+0,sp)
1102  02e2 2401          	jrnc	L07
1103  02e4 5c            	incw	x
1104  02e5               L07:
1105  02e5 02            	rlwa	x,a
1106  02e6 7f            	clr	(x)
1107                     ; 176     strcat(informationString, temp2);
1109  02e7 96            	ldw	x,sp
1110  02e8 1c0008        	addw	x,#OFST-17
1111  02eb 89            	pushw	x
1112  02ec 1e1c          	ldw	x,(OFST+3,sp)
1113  02ee cd0000        	call	_strcat
1115  02f1 85            	popw	x
1116                     ; 177     strcat(informationString, ",");
1118  02f2 ae003f        	ldw	x,#L352
1119  02f5 89            	pushw	x
1120  02f6 1e1c          	ldw	x,(OFST+3,sp)
1121  02f8 cd0000        	call	_strcat
1123  02fb 85            	popw	x
1124                     ; 179     sprintf(temp1, "%d", 4657);
1126  02fc ae1231        	ldw	x,#4657
1127  02ff 89            	pushw	x
1128  0300 ae0043        	ldw	x,#L722
1129  0303 89            	pushw	x
1130  0304 96            	ldw	x,sp
1131  0305 1c0006        	addw	x,#OFST-19
1132  0308 cd0000        	call	_sprintf
1134  030b 5b04          	addw	sp,#4
1135                     ; 180     temp1Length = strlen(temp1);
1137  030d 96            	ldw	x,sp
1138  030e 1c0002        	addw	x,#OFST-23
1139  0311 cd0000        	call	_strlen
1141  0314 01            	rrwa	x,a
1142  0315 6b01          	ld	(OFST-24,sp),a
1143  0317 02            	rlwa	x,a
1145                     ; 181     decPlace = temp1Length - 2;
1147  0318 7b01          	ld	a,(OFST-24,sp)
1148  031a a002          	sub	a,#2
1149  031c 6b18          	ld	(OFST-1,sp),a
1151                     ; 182     temp2[decPlace] = '.';
1153  031e 96            	ldw	x,sp
1154  031f 1c0008        	addw	x,#OFST-17
1155  0322 9f            	ld	a,xl
1156  0323 5e            	swapw	x
1157  0324 1b18          	add	a,(OFST-1,sp)
1158  0326 2401          	jrnc	L27
1159  0328 5c            	incw	x
1160  0329               L27:
1161  0329 02            	rlwa	x,a
1162  032a a62e          	ld	a,#46
1163  032c f7            	ld	(x),a
1164                     ; 183     for (w = 0; w < decPlace; w++)
1166  032d 0f19          	clr	(OFST+0,sp)
1169  032f 201e          	jra	L143
1170  0331               L533:
1171                     ; 185         temp2[w] = temp1[w];
1173  0331 96            	ldw	x,sp
1174  0332 1c0008        	addw	x,#OFST-17
1175  0335 9f            	ld	a,xl
1176  0336 5e            	swapw	x
1177  0337 1b19          	add	a,(OFST+0,sp)
1178  0339 2401          	jrnc	L47
1179  033b 5c            	incw	x
1180  033c               L47:
1181  033c 02            	rlwa	x,a
1182  033d 89            	pushw	x
1183  033e 96            	ldw	x,sp
1184  033f 1c0004        	addw	x,#OFST-21
1185  0342 9f            	ld	a,xl
1186  0343 5e            	swapw	x
1187  0344 1b1b          	add	a,(OFST+2,sp)
1188  0346 2401          	jrnc	L67
1189  0348 5c            	incw	x
1190  0349               L67:
1191  0349 02            	rlwa	x,a
1192  034a f6            	ld	a,(x)
1193  034b 85            	popw	x
1194  034c f7            	ld	(x),a
1195                     ; 183     for (w = 0; w < decPlace; w++)
1197  034d 0c19          	inc	(OFST+0,sp)
1199  034f               L143:
1202  034f 7b19          	ld	a,(OFST+0,sp)
1203  0351 1118          	cp	a,(OFST-1,sp)
1204  0353 25dc          	jrult	L533
1205                     ; 187     f = decPlace + 1;
1207  0355 7b18          	ld	a,(OFST-1,sp)
1208  0357 4c            	inc	a
1209  0358 6b18          	ld	(OFST-1,sp),a
1211                     ; 188     for (w = f; w <= temp1Length; w++)
1213  035a 7b18          	ld	a,(OFST-1,sp)
1214  035c 6b19          	ld	(OFST+0,sp),a
1217  035e 2023          	jra	L153
1218  0360               L543:
1219                     ; 190         u = w - 1;
1221  0360 7b19          	ld	a,(OFST+0,sp)
1222  0362 4a            	dec	a
1223  0363 6b18          	ld	(OFST-1,sp),a
1225                     ; 191         temp2[w] = temp1[u];
1227  0365 96            	ldw	x,sp
1228  0366 1c0008        	addw	x,#OFST-17
1229  0369 9f            	ld	a,xl
1230  036a 5e            	swapw	x
1231  036b 1b19          	add	a,(OFST+0,sp)
1232  036d 2401          	jrnc	L001
1233  036f 5c            	incw	x
1234  0370               L001:
1235  0370 02            	rlwa	x,a
1236  0371 89            	pushw	x
1237  0372 96            	ldw	x,sp
1238  0373 1c0004        	addw	x,#OFST-21
1239  0376 9f            	ld	a,xl
1240  0377 5e            	swapw	x
1241  0378 1b1a          	add	a,(OFST+1,sp)
1242  037a 2401          	jrnc	L201
1243  037c 5c            	incw	x
1244  037d               L201:
1245  037d 02            	rlwa	x,a
1246  037e f6            	ld	a,(x)
1247  037f 85            	popw	x
1248  0380 f7            	ld	(x),a
1249                     ; 188     for (w = f; w <= temp1Length; w++)
1251  0381 0c19          	inc	(OFST+0,sp)
1253  0383               L153:
1256  0383 7b19          	ld	a,(OFST+0,sp)
1257  0385 1101          	cp	a,(OFST-24,sp)
1258  0387 23d7          	jrule	L543
1259                     ; 193     temp2[w] = '\0';
1261  0389 96            	ldw	x,sp
1262  038a 1c0008        	addw	x,#OFST-17
1263  038d 9f            	ld	a,xl
1264  038e 5e            	swapw	x
1265  038f 1b19          	add	a,(OFST+0,sp)
1266  0391 2401          	jrnc	L401
1267  0393 5c            	incw	x
1268  0394               L401:
1269  0394 02            	rlwa	x,a
1270  0395 7f            	clr	(x)
1271                     ; 195     strcat(informationString, temp2);
1273  0396 96            	ldw	x,sp
1274  0397 1c0008        	addw	x,#OFST-17
1275  039a 89            	pushw	x
1276  039b 1e1c          	ldw	x,(OFST+3,sp)
1277  039d cd0000        	call	_strcat
1279  03a0 85            	popw	x
1280                     ; 196     strcat(informationString, ",");
1282  03a1 ae003f        	ldw	x,#L352
1283  03a4 89            	pushw	x
1284  03a5 1e1c          	ldw	x,(OFST+3,sp)
1285  03a7 cd0000        	call	_strcat
1287  03aa 85            	popw	x
1288                     ; 198     sprintf(temp1, "%d", 7891);
1290  03ab ae1ed3        	ldw	x,#7891
1291  03ae 89            	pushw	x
1292  03af ae0043        	ldw	x,#L722
1293  03b2 89            	pushw	x
1294  03b3 96            	ldw	x,sp
1295  03b4 1c0006        	addw	x,#OFST-19
1296  03b7 cd0000        	call	_sprintf
1298  03ba 5b04          	addw	sp,#4
1299                     ; 199     temp1Length = strlen(temp1);
1301  03bc 96            	ldw	x,sp
1302  03bd 1c0002        	addw	x,#OFST-23
1303  03c0 cd0000        	call	_strlen
1305  03c3 01            	rrwa	x,a
1306  03c4 6b01          	ld	(OFST-24,sp),a
1307  03c6 02            	rlwa	x,a
1309                     ; 200     decPlace = temp1Length - 2;
1311  03c7 7b01          	ld	a,(OFST-24,sp)
1312  03c9 a002          	sub	a,#2
1313  03cb 6b18          	ld	(OFST-1,sp),a
1315                     ; 201     temp2[decPlace] = '.';
1317  03cd 96            	ldw	x,sp
1318  03ce 1c0008        	addw	x,#OFST-17
1319  03d1 9f            	ld	a,xl
1320  03d2 5e            	swapw	x
1321  03d3 1b18          	add	a,(OFST-1,sp)
1322  03d5 2401          	jrnc	L601
1323  03d7 5c            	incw	x
1324  03d8               L601:
1325  03d8 02            	rlwa	x,a
1326  03d9 a62e          	ld	a,#46
1327  03db f7            	ld	(x),a
1328                     ; 202     for (w = 0; w < decPlace; w++)
1330  03dc 0f19          	clr	(OFST+0,sp)
1333  03de 201e          	jra	L163
1334  03e0               L553:
1335                     ; 204         temp2[w] = temp1[w];
1337  03e0 96            	ldw	x,sp
1338  03e1 1c0008        	addw	x,#OFST-17
1339  03e4 9f            	ld	a,xl
1340  03e5 5e            	swapw	x
1341  03e6 1b19          	add	a,(OFST+0,sp)
1342  03e8 2401          	jrnc	L011
1343  03ea 5c            	incw	x
1344  03eb               L011:
1345  03eb 02            	rlwa	x,a
1346  03ec 89            	pushw	x
1347  03ed 96            	ldw	x,sp
1348  03ee 1c0004        	addw	x,#OFST-21
1349  03f1 9f            	ld	a,xl
1350  03f2 5e            	swapw	x
1351  03f3 1b1b          	add	a,(OFST+2,sp)
1352  03f5 2401          	jrnc	L211
1353  03f7 5c            	incw	x
1354  03f8               L211:
1355  03f8 02            	rlwa	x,a
1356  03f9 f6            	ld	a,(x)
1357  03fa 85            	popw	x
1358  03fb f7            	ld	(x),a
1359                     ; 202     for (w = 0; w < decPlace; w++)
1361  03fc 0c19          	inc	(OFST+0,sp)
1363  03fe               L163:
1366  03fe 7b19          	ld	a,(OFST+0,sp)
1367  0400 1118          	cp	a,(OFST-1,sp)
1368  0402 25dc          	jrult	L553
1369                     ; 206     f = decPlace + 1;
1371  0404 7b18          	ld	a,(OFST-1,sp)
1372  0406 4c            	inc	a
1373  0407 6b18          	ld	(OFST-1,sp),a
1375                     ; 207     for (w = f; w <= temp1Length; w++)
1377  0409 7b18          	ld	a,(OFST-1,sp)
1378  040b 6b19          	ld	(OFST+0,sp),a
1381  040d 2023          	jra	L173
1382  040f               L563:
1383                     ; 209         u = w - 1;
1385  040f 7b19          	ld	a,(OFST+0,sp)
1386  0411 4a            	dec	a
1387  0412 6b18          	ld	(OFST-1,sp),a
1389                     ; 210         temp2[w] = temp1[u];
1391  0414 96            	ldw	x,sp
1392  0415 1c0008        	addw	x,#OFST-17
1393  0418 9f            	ld	a,xl
1394  0419 5e            	swapw	x
1395  041a 1b19          	add	a,(OFST+0,sp)
1396  041c 2401          	jrnc	L411
1397  041e 5c            	incw	x
1398  041f               L411:
1399  041f 02            	rlwa	x,a
1400  0420 89            	pushw	x
1401  0421 96            	ldw	x,sp
1402  0422 1c0004        	addw	x,#OFST-21
1403  0425 9f            	ld	a,xl
1404  0426 5e            	swapw	x
1405  0427 1b1a          	add	a,(OFST+1,sp)
1406  0429 2401          	jrnc	L611
1407  042b 5c            	incw	x
1408  042c               L611:
1409  042c 02            	rlwa	x,a
1410  042d f6            	ld	a,(x)
1411  042e 85            	popw	x
1412  042f f7            	ld	(x),a
1413                     ; 207     for (w = f; w <= temp1Length; w++)
1415  0430 0c19          	inc	(OFST+0,sp)
1417  0432               L173:
1420  0432 7b19          	ld	a,(OFST+0,sp)
1421  0434 1101          	cp	a,(OFST-24,sp)
1422  0436 23d7          	jrule	L563
1423                     ; 212     temp2[w] = '\0';
1425  0438 96            	ldw	x,sp
1426  0439 1c0008        	addw	x,#OFST-17
1427  043c 9f            	ld	a,xl
1428  043d 5e            	swapw	x
1429  043e 1b19          	add	a,(OFST+0,sp)
1430  0440 2401          	jrnc	L021
1431  0442 5c            	incw	x
1432  0443               L021:
1433  0443 02            	rlwa	x,a
1434  0444 7f            	clr	(x)
1435                     ; 214     strcat(informationString, temp2);
1437  0445 96            	ldw	x,sp
1438  0446 1c0008        	addw	x,#OFST-17
1439  0449 89            	pushw	x
1440  044a 1e1c          	ldw	x,(OFST+3,sp)
1441  044c cd0000        	call	_strcat
1443  044f 85            	popw	x
1444                     ; 215     strcat(informationString, ",");
1446  0450 ae003f        	ldw	x,#L352
1447  0453 89            	pushw	x
1448  0454 1e1c          	ldw	x,(OFST+3,sp)
1449  0456 cd0000        	call	_strcat
1451  0459 85            	popw	x
1452                     ; 217     sprintf(temp1, "%d", 1324);
1454  045a ae052c        	ldw	x,#1324
1455  045d 89            	pushw	x
1456  045e ae0043        	ldw	x,#L722
1457  0461 89            	pushw	x
1458  0462 96            	ldw	x,sp
1459  0463 1c0006        	addw	x,#OFST-19
1460  0466 cd0000        	call	_sprintf
1462  0469 5b04          	addw	sp,#4
1463                     ; 218     temp1Length = strlen(temp1);
1465  046b 96            	ldw	x,sp
1466  046c 1c0002        	addw	x,#OFST-23
1467  046f cd0000        	call	_strlen
1469  0472 01            	rrwa	x,a
1470  0473 6b01          	ld	(OFST-24,sp),a
1471  0475 02            	rlwa	x,a
1473                     ; 219     decPlace = temp1Length - 2;
1475  0476 7b01          	ld	a,(OFST-24,sp)
1476  0478 a002          	sub	a,#2
1477  047a 6b18          	ld	(OFST-1,sp),a
1479                     ; 220     temp2[decPlace] = '.';
1481  047c 96            	ldw	x,sp
1482  047d 1c0008        	addw	x,#OFST-17
1483  0480 9f            	ld	a,xl
1484  0481 5e            	swapw	x
1485  0482 1b18          	add	a,(OFST-1,sp)
1486  0484 2401          	jrnc	L221
1487  0486 5c            	incw	x
1488  0487               L221:
1489  0487 02            	rlwa	x,a
1490  0488 a62e          	ld	a,#46
1491  048a f7            	ld	(x),a
1492                     ; 221     for (w = 0; w < decPlace; w++)
1494  048b 0f19          	clr	(OFST+0,sp)
1497  048d 201e          	jra	L104
1498  048f               L573:
1499                     ; 223         temp2[w] = temp1[w];
1501  048f 96            	ldw	x,sp
1502  0490 1c0008        	addw	x,#OFST-17
1503  0493 9f            	ld	a,xl
1504  0494 5e            	swapw	x
1505  0495 1b19          	add	a,(OFST+0,sp)
1506  0497 2401          	jrnc	L421
1507  0499 5c            	incw	x
1508  049a               L421:
1509  049a 02            	rlwa	x,a
1510  049b 89            	pushw	x
1511  049c 96            	ldw	x,sp
1512  049d 1c0004        	addw	x,#OFST-21
1513  04a0 9f            	ld	a,xl
1514  04a1 5e            	swapw	x
1515  04a2 1b1b          	add	a,(OFST+2,sp)
1516  04a4 2401          	jrnc	L621
1517  04a6 5c            	incw	x
1518  04a7               L621:
1519  04a7 02            	rlwa	x,a
1520  04a8 f6            	ld	a,(x)
1521  04a9 85            	popw	x
1522  04aa f7            	ld	(x),a
1523                     ; 221     for (w = 0; w < decPlace; w++)
1525  04ab 0c19          	inc	(OFST+0,sp)
1527  04ad               L104:
1530  04ad 7b19          	ld	a,(OFST+0,sp)
1531  04af 1118          	cp	a,(OFST-1,sp)
1532  04b1 25dc          	jrult	L573
1533                     ; 225     f = decPlace + 1;
1535  04b3 7b18          	ld	a,(OFST-1,sp)
1536  04b5 4c            	inc	a
1537  04b6 6b18          	ld	(OFST-1,sp),a
1539                     ; 226     for (w = f; w <= temp1Length; w++)
1541  04b8 7b18          	ld	a,(OFST-1,sp)
1542  04ba 6b19          	ld	(OFST+0,sp),a
1545  04bc 2023          	jra	L114
1546  04be               L504:
1547                     ; 228         u = w - 1;
1549  04be 7b19          	ld	a,(OFST+0,sp)
1550  04c0 4a            	dec	a
1551  04c1 6b18          	ld	(OFST-1,sp),a
1553                     ; 229         temp2[w] = temp1[u];
1555  04c3 96            	ldw	x,sp
1556  04c4 1c0008        	addw	x,#OFST-17
1557  04c7 9f            	ld	a,xl
1558  04c8 5e            	swapw	x
1559  04c9 1b19          	add	a,(OFST+0,sp)
1560  04cb 2401          	jrnc	L031
1561  04cd 5c            	incw	x
1562  04ce               L031:
1563  04ce 02            	rlwa	x,a
1564  04cf 89            	pushw	x
1565  04d0 96            	ldw	x,sp
1566  04d1 1c0004        	addw	x,#OFST-21
1567  04d4 9f            	ld	a,xl
1568  04d5 5e            	swapw	x
1569  04d6 1b1a          	add	a,(OFST+1,sp)
1570  04d8 2401          	jrnc	L231
1571  04da 5c            	incw	x
1572  04db               L231:
1573  04db 02            	rlwa	x,a
1574  04dc f6            	ld	a,(x)
1575  04dd 85            	popw	x
1576  04de f7            	ld	(x),a
1577                     ; 226     for (w = f; w <= temp1Length; w++)
1579  04df 0c19          	inc	(OFST+0,sp)
1581  04e1               L114:
1584  04e1 7b19          	ld	a,(OFST+0,sp)
1585  04e3 1101          	cp	a,(OFST-24,sp)
1586  04e5 23d7          	jrule	L504
1587                     ; 231     temp2[w] = '\0';
1589  04e7 96            	ldw	x,sp
1590  04e8 1c0008        	addw	x,#OFST-17
1591  04eb 9f            	ld	a,xl
1592  04ec 5e            	swapw	x
1593  04ed 1b19          	add	a,(OFST+0,sp)
1594  04ef 2401          	jrnc	L431
1595  04f1 5c            	incw	x
1596  04f2               L431:
1597  04f2 02            	rlwa	x,a
1598  04f3 7f            	clr	(x)
1599                     ; 233     strcat(informationString, temp2);
1601  04f4 96            	ldw	x,sp
1602  04f5 1c0008        	addw	x,#OFST-17
1603  04f8 89            	pushw	x
1604  04f9 1e1c          	ldw	x,(OFST+3,sp)
1605  04fb cd0000        	call	_strcat
1607  04fe 85            	popw	x
1608                     ; 234     strcat(informationString, ",");
1610  04ff ae003f        	ldw	x,#L352
1611  0502 89            	pushw	x
1612  0503 1e1c          	ldw	x,(OFST+3,sp)
1613  0505 cd0000        	call	_strcat
1615  0508 85            	popw	x
1616                     ; 236     sprintf(temp1, "%d", 4567);
1618  0509 ae11d7        	ldw	x,#4567
1619  050c 89            	pushw	x
1620  050d ae0043        	ldw	x,#L722
1621  0510 89            	pushw	x
1622  0511 96            	ldw	x,sp
1623  0512 1c0006        	addw	x,#OFST-19
1624  0515 cd0000        	call	_sprintf
1626  0518 5b04          	addw	sp,#4
1627                     ; 237     temp1Length = strlen(temp1);
1629  051a 96            	ldw	x,sp
1630  051b 1c0002        	addw	x,#OFST-23
1631  051e cd0000        	call	_strlen
1633  0521 01            	rrwa	x,a
1634  0522 6b01          	ld	(OFST-24,sp),a
1635  0524 02            	rlwa	x,a
1637                     ; 238     decPlace = temp1Length - 2;
1639  0525 7b01          	ld	a,(OFST-24,sp)
1640  0527 a002          	sub	a,#2
1641  0529 6b18          	ld	(OFST-1,sp),a
1643                     ; 239     temp2[decPlace] = '.';
1645  052b 96            	ldw	x,sp
1646  052c 1c0008        	addw	x,#OFST-17
1647  052f 9f            	ld	a,xl
1648  0530 5e            	swapw	x
1649  0531 1b18          	add	a,(OFST-1,sp)
1650  0533 2401          	jrnc	L631
1651  0535 5c            	incw	x
1652  0536               L631:
1653  0536 02            	rlwa	x,a
1654  0537 a62e          	ld	a,#46
1655  0539 f7            	ld	(x),a
1656                     ; 240     for (w = 0; w < decPlace; w++)
1658  053a 0f19          	clr	(OFST+0,sp)
1661  053c 201e          	jra	L124
1662  053e               L514:
1663                     ; 242         temp2[w] = temp1[w];
1665  053e 96            	ldw	x,sp
1666  053f 1c0008        	addw	x,#OFST-17
1667  0542 9f            	ld	a,xl
1668  0543 5e            	swapw	x
1669  0544 1b19          	add	a,(OFST+0,sp)
1670  0546 2401          	jrnc	L041
1671  0548 5c            	incw	x
1672  0549               L041:
1673  0549 02            	rlwa	x,a
1674  054a 89            	pushw	x
1675  054b 96            	ldw	x,sp
1676  054c 1c0004        	addw	x,#OFST-21
1677  054f 9f            	ld	a,xl
1678  0550 5e            	swapw	x
1679  0551 1b1b          	add	a,(OFST+2,sp)
1680  0553 2401          	jrnc	L241
1681  0555 5c            	incw	x
1682  0556               L241:
1683  0556 02            	rlwa	x,a
1684  0557 f6            	ld	a,(x)
1685  0558 85            	popw	x
1686  0559 f7            	ld	(x),a
1687                     ; 240     for (w = 0; w < decPlace; w++)
1689  055a 0c19          	inc	(OFST+0,sp)
1691  055c               L124:
1694  055c 7b19          	ld	a,(OFST+0,sp)
1695  055e 1118          	cp	a,(OFST-1,sp)
1696  0560 25dc          	jrult	L514
1697                     ; 244     f = decPlace + 1;
1699  0562 7b18          	ld	a,(OFST-1,sp)
1700  0564 4c            	inc	a
1701  0565 6b18          	ld	(OFST-1,sp),a
1703                     ; 245     for (w = f; w <= temp1Length; w++)
1705  0567 7b18          	ld	a,(OFST-1,sp)
1706  0569 6b19          	ld	(OFST+0,sp),a
1709  056b 2023          	jra	L134
1710  056d               L524:
1711                     ; 247         u = w - 1;
1713  056d 7b19          	ld	a,(OFST+0,sp)
1714  056f 4a            	dec	a
1715  0570 6b18          	ld	(OFST-1,sp),a
1717                     ; 248         temp2[w] = temp1[u];
1719  0572 96            	ldw	x,sp
1720  0573 1c0008        	addw	x,#OFST-17
1721  0576 9f            	ld	a,xl
1722  0577 5e            	swapw	x
1723  0578 1b19          	add	a,(OFST+0,sp)
1724  057a 2401          	jrnc	L441
1725  057c 5c            	incw	x
1726  057d               L441:
1727  057d 02            	rlwa	x,a
1728  057e 89            	pushw	x
1729  057f 96            	ldw	x,sp
1730  0580 1c0004        	addw	x,#OFST-21
1731  0583 9f            	ld	a,xl
1732  0584 5e            	swapw	x
1733  0585 1b1a          	add	a,(OFST+1,sp)
1734  0587 2401          	jrnc	L641
1735  0589 5c            	incw	x
1736  058a               L641:
1737  058a 02            	rlwa	x,a
1738  058b f6            	ld	a,(x)
1739  058c 85            	popw	x
1740  058d f7            	ld	(x),a
1741                     ; 245     for (w = f; w <= temp1Length; w++)
1743  058e 0c19          	inc	(OFST+0,sp)
1745  0590               L134:
1748  0590 7b19          	ld	a,(OFST+0,sp)
1749  0592 1101          	cp	a,(OFST-24,sp)
1750  0594 23d7          	jrule	L524
1751                     ; 250     temp2[w] = '\0';
1753  0596 96            	ldw	x,sp
1754  0597 1c0008        	addw	x,#OFST-17
1755  059a 9f            	ld	a,xl
1756  059b 5e            	swapw	x
1757  059c 1b19          	add	a,(OFST+0,sp)
1758  059e 2401          	jrnc	L051
1759  05a0 5c            	incw	x
1760  05a1               L051:
1761  05a1 02            	rlwa	x,a
1762  05a2 7f            	clr	(x)
1763                     ; 252     strcat(informationString, temp2);
1765  05a3 96            	ldw	x,sp
1766  05a4 1c0008        	addw	x,#OFST-17
1767  05a7 89            	pushw	x
1768  05a8 1e1c          	ldw	x,(OFST+3,sp)
1769  05aa cd0000        	call	_strcat
1771  05ad 85            	popw	x
1772                     ; 253     strcat(informationString, ",");
1774  05ae ae003f        	ldw	x,#L352
1775  05b1 89            	pushw	x
1776  05b2 1e1c          	ldw	x,(OFST+3,sp)
1777  05b4 cd0000        	call	_strcat
1779  05b7 85            	popw	x
1780                     ; 255     sprintf(temp1, "%d", 7891);
1782  05b8 ae1ed3        	ldw	x,#7891
1783  05bb 89            	pushw	x
1784  05bc ae0043        	ldw	x,#L722
1785  05bf 89            	pushw	x
1786  05c0 96            	ldw	x,sp
1787  05c1 1c0006        	addw	x,#OFST-19
1788  05c4 cd0000        	call	_sprintf
1790  05c7 5b04          	addw	sp,#4
1791                     ; 256     temp1Length = strlen(temp1);
1793  05c9 96            	ldw	x,sp
1794  05ca 1c0002        	addw	x,#OFST-23
1795  05cd cd0000        	call	_strlen
1797  05d0 01            	rrwa	x,a
1798  05d1 6b01          	ld	(OFST-24,sp),a
1799  05d3 02            	rlwa	x,a
1801                     ; 257     decPlace = temp1Length - 2;
1803  05d4 7b01          	ld	a,(OFST-24,sp)
1804  05d6 a002          	sub	a,#2
1805  05d8 6b18          	ld	(OFST-1,sp),a
1807                     ; 258     temp2[decPlace] = '.';
1809  05da 96            	ldw	x,sp
1810  05db 1c0008        	addw	x,#OFST-17
1811  05de 9f            	ld	a,xl
1812  05df 5e            	swapw	x
1813  05e0 1b18          	add	a,(OFST-1,sp)
1814  05e2 2401          	jrnc	L251
1815  05e4 5c            	incw	x
1816  05e5               L251:
1817  05e5 02            	rlwa	x,a
1818  05e6 a62e          	ld	a,#46
1819  05e8 f7            	ld	(x),a
1820                     ; 259     for (w = 0; w < decPlace; w++)
1822  05e9 0f19          	clr	(OFST+0,sp)
1825  05eb 201e          	jra	L144
1826  05ed               L534:
1827                     ; 261         temp2[w] = temp1[w];
1829  05ed 96            	ldw	x,sp
1830  05ee 1c0008        	addw	x,#OFST-17
1831  05f1 9f            	ld	a,xl
1832  05f2 5e            	swapw	x
1833  05f3 1b19          	add	a,(OFST+0,sp)
1834  05f5 2401          	jrnc	L451
1835  05f7 5c            	incw	x
1836  05f8               L451:
1837  05f8 02            	rlwa	x,a
1838  05f9 89            	pushw	x
1839  05fa 96            	ldw	x,sp
1840  05fb 1c0004        	addw	x,#OFST-21
1841  05fe 9f            	ld	a,xl
1842  05ff 5e            	swapw	x
1843  0600 1b1b          	add	a,(OFST+2,sp)
1844  0602 2401          	jrnc	L651
1845  0604 5c            	incw	x
1846  0605               L651:
1847  0605 02            	rlwa	x,a
1848  0606 f6            	ld	a,(x)
1849  0607 85            	popw	x
1850  0608 f7            	ld	(x),a
1851                     ; 259     for (w = 0; w < decPlace; w++)
1853  0609 0c19          	inc	(OFST+0,sp)
1855  060b               L144:
1858  060b 7b19          	ld	a,(OFST+0,sp)
1859  060d 1118          	cp	a,(OFST-1,sp)
1860  060f 25dc          	jrult	L534
1861                     ; 263     f = decPlace + 1;
1863  0611 7b18          	ld	a,(OFST-1,sp)
1864  0613 4c            	inc	a
1865  0614 6b18          	ld	(OFST-1,sp),a
1867                     ; 264     for (w = f; w <= temp1Length; w++)
1869  0616 7b18          	ld	a,(OFST-1,sp)
1870  0618 6b19          	ld	(OFST+0,sp),a
1873  061a 2023          	jra	L154
1874  061c               L544:
1875                     ; 266         u = w - 1;
1877  061c 7b19          	ld	a,(OFST+0,sp)
1878  061e 4a            	dec	a
1879  061f 6b18          	ld	(OFST-1,sp),a
1881                     ; 267         temp2[w] = temp1[u];
1883  0621 96            	ldw	x,sp
1884  0622 1c0008        	addw	x,#OFST-17
1885  0625 9f            	ld	a,xl
1886  0626 5e            	swapw	x
1887  0627 1b19          	add	a,(OFST+0,sp)
1888  0629 2401          	jrnc	L061
1889  062b 5c            	incw	x
1890  062c               L061:
1891  062c 02            	rlwa	x,a
1892  062d 89            	pushw	x
1893  062e 96            	ldw	x,sp
1894  062f 1c0004        	addw	x,#OFST-21
1895  0632 9f            	ld	a,xl
1896  0633 5e            	swapw	x
1897  0634 1b1a          	add	a,(OFST+1,sp)
1898  0636 2401          	jrnc	L261
1899  0638 5c            	incw	x
1900  0639               L261:
1901  0639 02            	rlwa	x,a
1902  063a f6            	ld	a,(x)
1903  063b 85            	popw	x
1904  063c f7            	ld	(x),a
1905                     ; 264     for (w = f; w <= temp1Length; w++)
1907  063d 0c19          	inc	(OFST+0,sp)
1909  063f               L154:
1912  063f 7b19          	ld	a,(OFST+0,sp)
1913  0641 1101          	cp	a,(OFST-24,sp)
1914  0643 23d7          	jrule	L544
1915                     ; 269     temp2[w] = '\0';
1917  0645 96            	ldw	x,sp
1918  0646 1c0008        	addw	x,#OFST-17
1919  0649 9f            	ld	a,xl
1920  064a 5e            	swapw	x
1921  064b 1b19          	add	a,(OFST+0,sp)
1922  064d 2401          	jrnc	L461
1923  064f 5c            	incw	x
1924  0650               L461:
1925  0650 02            	rlwa	x,a
1926  0651 7f            	clr	(x)
1927                     ; 271     strcat(informationString, temp2);
1929  0652 96            	ldw	x,sp
1930  0653 1c0008        	addw	x,#OFST-17
1931  0656 89            	pushw	x
1932  0657 1e1c          	ldw	x,(OFST+3,sp)
1933  0659 cd0000        	call	_strcat
1935  065c 85            	popw	x
1936                     ; 272     strcat(informationString, "}");
1938  065d ae003d        	ldw	x,#L554
1939  0660 89            	pushw	x
1940  0661 1e1c          	ldw	x,(OFST+3,sp)
1941  0663 cd0000        	call	_strcat
1943  0666 85            	popw	x
1944                     ; 273     stringLength = strlen(informationString);
1946  0667 1e1a          	ldw	x,(OFST+1,sp)
1947  0669 cd0000        	call	_strlen
1949  066c 01            	rrwa	x,a
1950  066d 6b01          	ld	(OFST-24,sp),a
1951  066f 02            	rlwa	x,a
1953                     ; 274     return (stringLength);
1955  0670 7b01          	ld	a,(OFST-24,sp)
1956  0672 5f            	clrw	x
1957  0673 97            	ld	xl,a
1960  0674 5b1b          	addw	sp,#27
1961  0676 81            	ret
2039                     ; 277 void vHandleMevris_MQTT_Recv_Data(void)
2039                     ; 278 {
2040                     	switch	.text
2041  0677               _vHandleMevris_MQTT_Recv_Data:
2043  0677 521b          	subw	sp,#27
2044       0000001b      OFST:	set	27
2047                     ; 281     uint8_t i = 0, j;
2049                     ; 282     uint8_t unLength = 0;
2051  0679 0f17          	clr	(OFST-4,sp)
2053                     ; 287     ptr = strstr(response_buffer, "+IPD");
2055  067b ae0038        	ldw	x,#L515
2056  067e 89            	pushw	x
2057  067f ae0000        	ldw	x,#_response_buffer
2058  0682 cd0000        	call	_strstr
2060  0685 5b02          	addw	sp,#2
2061  0687 1f19          	ldw	(OFST-2,sp),x
2063                     ; 288     if (ptr)
2065  0689 1e19          	ldw	x,(OFST-2,sp)
2066  068b 2603          	jrne	L602
2067  068d cc0757        	jp	L715
2068  0690               L602:
2069                     ; 290         i = 0;
2071  0690 0f1b          	clr	(OFST+0,sp)
2074  0692 2002          	jra	L525
2075  0694               L125:
2076                     ; 292             i++;
2079  0694 0c1b          	inc	(OFST+0,sp)
2081  0696               L525:
2082                     ; 291         while (*(ptr + i) != ':')
2082                     ; 292             i++;
2084  0696 7b19          	ld	a,(OFST-2,sp)
2085  0698 97            	ld	xl,a
2086  0699 7b1a          	ld	a,(OFST-1,sp)
2087  069b 1b1b          	add	a,(OFST+0,sp)
2088  069d 2401          	jrnc	L071
2089  069f 5c            	incw	x
2090  06a0               L071:
2091  06a0 02            	rlwa	x,a
2092  06a1 f6            	ld	a,(x)
2093  06a2 a13a          	cp	a,#58
2094  06a4 26ee          	jrne	L125
2095                     ; 293         i++;
2097  06a6 0c1b          	inc	(OFST+0,sp)
2099                     ; 294         if (*(ptr + i) == 0x20) // Check if CONNACK is Recieved
2101  06a8 7b19          	ld	a,(OFST-2,sp)
2102  06aa 97            	ld	xl,a
2103  06ab 7b1a          	ld	a,(OFST-1,sp)
2104  06ad 1b1b          	add	a,(OFST+0,sp)
2105  06af 2401          	jrnc	L271
2106  06b1 5c            	incw	x
2107  06b2               L271:
2108  06b2 02            	rlwa	x,a
2109  06b3 f6            	ld	a,(x)
2110  06b4 a120          	cp	a,#32
2111  06b6 2611          	jrne	L135
2112                     ; 296             if (*(ptr + 3) == 0) // If 0x00 Then it means Successfull
2114  06b8 1e19          	ldw	x,(OFST-2,sp)
2115  06ba 6d03          	tnz	(3,x)
2116  06bc 2703          	jreq	L012
2117  06be cc0757        	jp	L715
2118  06c1               L012:
2119                     ; 297                 bCONNACK_Recieved = TRUE;
2121  06c1 35010000      	mov	_bCONNACK_Recieved,#1
2122  06c5 ac570757      	jpf	L715
2123  06c9               L135:
2124                     ; 299         else if (*(ptr + i) == 0x30) //Check if Message is a PUBLISH Packet from server
2126  06c9 7b19          	ld	a,(OFST-2,sp)
2127  06cb 97            	ld	xl,a
2128  06cc 7b1a          	ld	a,(OFST-1,sp)
2129  06ce 1b1b          	add	a,(OFST+0,sp)
2130  06d0 2401          	jrnc	L471
2131  06d2 5c            	incw	x
2132  06d3               L471:
2133  06d3 02            	rlwa	x,a
2134  06d4 f6            	ld	a,(x)
2135  06d5 a130          	cp	a,#48
2136  06d7 2702          	jreq	L212
2137  06d9 207c          	jp	L715
2138  06db               L212:
2140  06db 2002          	jra	L345
2141  06dd               L145:
2142                     ; 302                 i++;
2144  06dd 0c1b          	inc	(OFST+0,sp)
2146  06df               L345:
2147                     ; 301             while (*(ptr + i) != '{' && i < 99)
2149  06df 7b19          	ld	a,(OFST-2,sp)
2150  06e1 97            	ld	xl,a
2151  06e2 7b1a          	ld	a,(OFST-1,sp)
2152  06e4 1b1b          	add	a,(OFST+0,sp)
2153  06e6 2401          	jrnc	L671
2154  06e8 5c            	incw	x
2155  06e9               L671:
2156  06e9 02            	rlwa	x,a
2157  06ea f6            	ld	a,(x)
2158  06eb a17b          	cp	a,#123
2159  06ed 2706          	jreq	L745
2161  06ef 7b1b          	ld	a,(OFST+0,sp)
2162  06f1 a163          	cp	a,#99
2163  06f3 25e8          	jrult	L145
2164  06f5               L745:
2165                     ; 304             if (*(ptr + i) == '{')
2167  06f5 7b19          	ld	a,(OFST-2,sp)
2168  06f7 97            	ld	xl,a
2169  06f8 7b1a          	ld	a,(OFST-1,sp)
2170  06fa 1b1b          	add	a,(OFST+0,sp)
2171  06fc 2401          	jrnc	L002
2172  06fe 5c            	incw	x
2173  06ff               L002:
2174  06ff 02            	rlwa	x,a
2175  0700 f6            	ld	a,(x)
2176  0701 a17b          	cp	a,#123
2177  0703 2652          	jrne	L715
2178                     ; 306                 vClearBuffer(localBuffer, 20);
2180  0705 4b14          	push	#20
2181  0707 96            	ldw	x,sp
2182  0708 1c0004        	addw	x,#OFST-23
2183  070b cd0000        	call	_vClearBuffer
2185  070e 84            	pop	a
2186                     ; 307                 j = 0;
2188  070f 0f18          	clr	(OFST-3,sp)
2191  0711 2024          	jra	L755
2192  0713               L355:
2193                     ; 310                     localBuffer[j++] = *(ptr + i);
2195  0713 96            	ldw	x,sp
2196  0714 1c0003        	addw	x,#OFST-24
2197  0717 1f01          	ldw	(OFST-26,sp),x
2199  0719 7b18          	ld	a,(OFST-3,sp)
2200  071b 97            	ld	xl,a
2201  071c 0c18          	inc	(OFST-3,sp)
2203  071e 9f            	ld	a,xl
2204  071f 5f            	clrw	x
2205  0720 97            	ld	xl,a
2206  0721 72fb01        	addw	x,(OFST-26,sp)
2207  0724 89            	pushw	x
2208  0725 7b1b          	ld	a,(OFST+0,sp)
2209  0727 97            	ld	xl,a
2210  0728 7b1c          	ld	a,(OFST+1,sp)
2211  072a 1b1d          	add	a,(OFST+2,sp)
2212  072c 2401          	jrnc	L202
2213  072e 5c            	incw	x
2214  072f               L202:
2215  072f 02            	rlwa	x,a
2216  0730 f6            	ld	a,(x)
2217  0731 85            	popw	x
2218  0732 f7            	ld	(x),a
2219                     ; 311                     unLength++;
2221  0733 0c17          	inc	(OFST-4,sp)
2223                     ; 312                     i++;
2225  0735 0c1b          	inc	(OFST+0,sp)
2227  0737               L755:
2228                     ; 308                 while (*(ptr + i) != '\r' && j < 19)
2230  0737 7b19          	ld	a,(OFST-2,sp)
2231  0739 97            	ld	xl,a
2232  073a 7b1a          	ld	a,(OFST-1,sp)
2233  073c 1b1b          	add	a,(OFST+0,sp)
2234  073e 2401          	jrnc	L402
2235  0740 5c            	incw	x
2236  0741               L402:
2237  0741 02            	rlwa	x,a
2238  0742 f6            	ld	a,(x)
2239  0743 a10d          	cp	a,#13
2240  0745 2706          	jreq	L365
2242  0747 7b18          	ld	a,(OFST-3,sp)
2243  0749 a113          	cp	a,#19
2244  074b 25c6          	jrult	L355
2245  074d               L365:
2246                     ; 316                 vHandleMevrisRecievedData(localBuffer, unLength);
2248  074d 7b17          	ld	a,(OFST-4,sp)
2249  074f 88            	push	a
2250  0750 96            	ldw	x,sp
2251  0751 1c0004        	addw	x,#OFST-23
2252  0754 ad04          	call	_vHandleMevrisRecievedData
2254  0756 84            	pop	a
2255  0757               L715:
2256                     ; 320 }
2259  0757 5b1b          	addw	sp,#27
2260  0759 81            	ret
2299                     ; 322 void vHandleMevrisRecievedData(uint8_t *Data, uint8_t unLength)
2299                     ; 323 {
2300                     	switch	.text
2301  075a               _vHandleMevrisRecievedData:
2305                     ; 326     if (Data[0] == '{')
2307  075a f6            	ld	a,(x)
2308  075b a17b          	cp	a,#123
2309  075d 2614          	jrne	L306
2310                     ; 333           if (Data[1]='1')
2312  075f a631          	ld	a,#49
2313  0761 e701          	ld	(1,x),a
2314  0763 6d01          	tnz	(1,x)
2315  0765 270c          	jreq	L306
2316                     ; 335                         ms_send_cmd("are you there", strlen((const char *)"are you there"));
2318  0767 4b0d          	push	#13
2319  0769 ae002a        	ldw	x,#L706
2320  076c cd0000        	call	_ms_send_cmd
2322  076f 84            	pop	a
2323                     ; 337             vMevris_Send_IMEI();
2325  0770 cd0832        	call	_vMevris_Send_IMEI
2327  0773               L306:
2328                     ; 362 }
2331  0773 81            	ret
2360                     ; 364 uint8_t *punGet_Client_ID(void)
2360                     ; 365 {
2361                     	switch	.text
2362  0774               _punGet_Client_ID:
2366                     ; 372     vClearBuffer(aunMQTT_ClientID, 20);
2368  0774 4b14          	push	#20
2369  0776 ae0064        	ldw	x,#_aunMQTT_ClientID
2370  0779 cd0000        	call	_vClearBuffer
2372  077c 84            	pop	a
2373                     ; 373     strcpy(aunMQTT_ClientID, "gen");
2375  077d ae0064        	ldw	x,#_aunMQTT_ClientID
2376  0780 90ae0026      	ldw	y,#L126
2377  0784               L022:
2378  0784 90f6          	ld	a,(y)
2379  0786 905c          	incw	y
2380  0788 f7            	ld	(x),a
2381  0789 5c            	incw	x
2382  078a 4d            	tnz	a
2383  078b 26f7          	jrne	L022
2384                     ; 374     strcat(aunMQTT_ClientID, aunIMEI);
2386  078d ae0000        	ldw	x,#_aunIMEI
2387  0790 89            	pushw	x
2388  0791 ae0064        	ldw	x,#_aunMQTT_ClientID
2389  0794 cd0000        	call	_strcat
2391  0797 85            	popw	x
2392                     ; 376     return aunMQTT_ClientID;
2394  0798 ae0064        	ldw	x,#_aunMQTT_ClientID
2397  079b 81            	ret
2438                     ; 379 uint8_t *punGet_Command_Topic(void)
2438                     ; 380 {
2439                     	switch	.text
2440  079c               _punGet_Command_Topic:
2442  079c 88            	push	a
2443       00000001      OFST:	set	1
2446                     ; 381     uint8_t i = 0;
2448                     ; 387     vClearBuffer(aunMQTT_Subscribe_Topic, 24);
2450  079d 4b18          	push	#24
2451  079f ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
2452  07a2 cd0000        	call	_vClearBuffer
2454  07a5 84            	pop	a
2455                     ; 388     strcpy(aunMQTT_Subscribe_Topic, MQTT_TOPIC_HEADER);
2457  07a6 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
2458  07a9 90ae0022      	ldw	y,#L146
2459  07ad               L422:
2460  07ad 90f6          	ld	a,(y)
2461  07af 905c          	incw	y
2462  07b1 f7            	ld	(x),a
2463  07b2 5c            	incw	x
2464  07b3 4d            	tnz	a
2465  07b4 26f7          	jrne	L422
2466                     ; 389     strcat(aunMQTT_Subscribe_Topic, "/");
2468  07b6 ae0020        	ldw	x,#L346
2469  07b9 89            	pushw	x
2470  07ba ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
2471  07bd cd0000        	call	_strcat
2473  07c0 85            	popw	x
2474                     ; 390     strcat(aunMQTT_Subscribe_Topic, aunIMEI);
2476  07c1 ae0000        	ldw	x,#_aunIMEI
2477  07c4 89            	pushw	x
2478  07c5 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
2479  07c8 cd0000        	call	_strcat
2481  07cb 85            	popw	x
2482                     ; 391     strcat(aunMQTT_Subscribe_Topic, "/");
2484  07cc ae0020        	ldw	x,#L346
2485  07cf 89            	pushw	x
2486  07d0 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
2487  07d3 cd0000        	call	_strcat
2489  07d6 85            	popw	x
2490                     ; 392     strcat(aunMQTT_Subscribe_Topic, MQTT_INBOUND_TOPIC_FOOTER);
2492  07d7 ae001c        	ldw	x,#L546
2493  07da 89            	pushw	x
2494  07db ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
2495  07de cd0000        	call	_strcat
2497  07e1 85            	popw	x
2498                     ; 393     return aunMQTT_Subscribe_Topic;
2500  07e2 ae0078        	ldw	x,#_aunMQTT_Subscribe_Topic
2503  07e5 84            	pop	a
2504  07e6 81            	ret
2544                     ; 396 uint8_t *punGet_Event_Topic(void)
2544                     ; 397 {
2545                     	switch	.text
2546  07e7               _punGet_Event_Topic:
2548  07e7 88            	push	a
2549       00000001      OFST:	set	1
2552                     ; 398     uint8_t i = 0;
2554                     ; 404     vClearBuffer(aunMQTT_Publish_Topic, 24);
2556  07e8 4b18          	push	#24
2557  07ea ae0090        	ldw	x,#_aunMQTT_Publish_Topic
2558  07ed cd0000        	call	_vClearBuffer
2560  07f0 84            	pop	a
2561                     ; 405     strcpy(aunMQTT_Publish_Topic, MQTT_TOPIC_HEADER);
2563  07f1 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
2564  07f4 90ae0022      	ldw	y,#L146
2565  07f8               L032:
2566  07f8 90f6          	ld	a,(y)
2567  07fa 905c          	incw	y
2568  07fc f7            	ld	(x),a
2569  07fd 5c            	incw	x
2570  07fe 4d            	tnz	a
2571  07ff 26f7          	jrne	L032
2572                     ; 406     strcat(aunMQTT_Publish_Topic, "/");
2574  0801 ae0020        	ldw	x,#L346
2575  0804 89            	pushw	x
2576  0805 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
2577  0808 cd0000        	call	_strcat
2579  080b 85            	popw	x
2580                     ; 407     strcat(aunMQTT_Publish_Topic, aunIMEI);
2582  080c ae0000        	ldw	x,#_aunIMEI
2583  080f 89            	pushw	x
2584  0810 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
2585  0813 cd0000        	call	_strcat
2587  0816 85            	popw	x
2588                     ; 408     strcat(aunMQTT_Publish_Topic, "/");
2590  0817 ae0020        	ldw	x,#L346
2591  081a 89            	pushw	x
2592  081b ae0090        	ldw	x,#_aunMQTT_Publish_Topic
2593  081e cd0000        	call	_strcat
2595  0821 85            	popw	x
2596                     ; 409     strcat(aunMQTT_Publish_Topic, MQTT_OUTBOUND_TOPIC_FOOTER);
2598  0822 ae0018        	ldw	x,#L566
2599  0825 89            	pushw	x
2600  0826 ae0090        	ldw	x,#_aunMQTT_Publish_Topic
2601  0829 cd0000        	call	_strcat
2603  082c 85            	popw	x
2604                     ; 411     return aunMQTT_Publish_Topic;
2606  082d ae0090        	ldw	x,#_aunMQTT_Publish_Topic
2609  0830 84            	pop	a
2610  0831 81            	ret
2613                     .const:	section	.text
2614  0000               L766_localBuffer:
2615  0000 7b312c312c31  	dc.b	"{1,1,1234567890123"
2616  0012 34357d00      	dc.b	"45}",0
2617  0016               L176_aunTemp:
2618  0016 3100          	dc.b	"1",0
2678                     ; 414 void vMevris_Send_IMEI(void)
2678                     ; 415 {
2679                     	switch	.text
2680  0832               _vMevris_Send_IMEI:
2682  0832 5219          	subw	sp,#25
2683       00000019      OFST:	set	25
2686                     ; 416     uint8_t localBuffer[22] = "{1,1,123456789012345}";
2688  0834 96            	ldw	x,sp
2689  0835 1c0004        	addw	x,#OFST-21
2690  0838 90ae0000      	ldw	y,#L766_localBuffer
2691  083c a616          	ld	a,#22
2692  083e cd0000        	call	c_xymvx
2694                     ; 417     uint8_t unSendDataLength = 0;
2696                     ; 418     uint8_t aunTemp[2] = "1";
2698  0841 c60016        	ld	a,L176_aunTemp
2699  0844 6b02          	ld	(OFST-23,sp),a
2700  0846 c60017        	ld	a,L176_aunTemp+1
2701  0849 6b03          	ld	(OFST-22,sp),a
2702                     ; 419     vClearBuffer(localBuffer, 22);
2704  084b 4b16          	push	#22
2705  084d 96            	ldw	x,sp
2706  084e 1c0005        	addw	x,#OFST-20
2707  0851 cd0000        	call	_vClearBuffer
2709  0854 84            	pop	a
2710                     ; 420     strcpy(localBuffer, "{");
2712  0855 96            	ldw	x,sp
2713  0856 1c0004        	addw	x,#OFST-21
2714  0859 90ae0041      	ldw	y,#L152
2715  085d               L432:
2716  085d 90f6          	ld	a,(y)
2717  085f 905c          	incw	y
2718  0861 f7            	ld	(x),a
2719  0862 5c            	incw	x
2720  0863 4d            	tnz	a
2721  0864 26f7          	jrne	L432
2722                     ; 421     aunTemp[0] = eCommand_IMEI;
2724  0866 a601          	ld	a,#1
2725  0868 6b02          	ld	(OFST-23,sp),a
2727                     ; 422     aunTemp[1] = '\0';
2729  086a 0f03          	clr	(OFST-22,sp)
2731                     ; 423     strcat(localBuffer, aunTemp);
2733  086c 96            	ldw	x,sp
2734  086d 1c0002        	addw	x,#OFST-23
2735  0870 89            	pushw	x
2736  0871 96            	ldw	x,sp
2737  0872 1c0006        	addw	x,#OFST-19
2738  0875 cd0000        	call	_strcat
2740  0878 85            	popw	x
2741                     ; 424     strcat(localBuffer, ",");
2743  0879 ae003f        	ldw	x,#L352
2744  087c 89            	pushw	x
2745  087d 96            	ldw	x,sp
2746  087e 1c0006        	addw	x,#OFST-19
2747  0881 cd0000        	call	_strcat
2749  0884 85            	popw	x
2750                     ; 425     aunTemp[0] = eCommand_Outbound;
2752  0885 a602          	ld	a,#2
2753  0887 6b02          	ld	(OFST-23,sp),a
2755                     ; 426     aunTemp[1] = '\0';
2757  0889 0f03          	clr	(OFST-22,sp)
2759                     ; 427     strcat(localBuffer, aunTemp);
2761  088b 96            	ldw	x,sp
2762  088c 1c0002        	addw	x,#OFST-23
2763  088f 89            	pushw	x
2764  0890 96            	ldw	x,sp
2765  0891 1c0006        	addw	x,#OFST-19
2766  0894 cd0000        	call	_strcat
2768  0897 85            	popw	x
2769                     ; 428     strcat(localBuffer, ",");
2771  0898 ae003f        	ldw	x,#L352
2772  089b 89            	pushw	x
2773  089c 96            	ldw	x,sp
2774  089d 1c0006        	addw	x,#OFST-19
2775  08a0 cd0000        	call	_strcat
2777  08a3 85            	popw	x
2778                     ; 429     strcat(localBuffer, aunIMEI);
2780  08a4 ae0000        	ldw	x,#_aunIMEI
2781  08a7 89            	pushw	x
2782  08a8 96            	ldw	x,sp
2783  08a9 1c0006        	addw	x,#OFST-19
2784  08ac cd0000        	call	_strcat
2786  08af 85            	popw	x
2787                     ; 430     strcat(localBuffer, "}");
2789  08b0 ae003d        	ldw	x,#L554
2790  08b3 89            	pushw	x
2791  08b4 96            	ldw	x,sp
2792  08b5 1c0006        	addw	x,#OFST-19
2793  08b8 cd0000        	call	_strcat
2795  08bb 85            	popw	x
2796                     ; 431     vClearBuffer(aunPushed_Data, MEVRIS_SEND_DATA_MAX_SIZE);
2798  08bc 4b64          	push	#100
2799  08be ae0000        	ldw	x,#_aunPushed_Data
2800  08c1 cd0000        	call	_vClearBuffer
2802  08c4 84            	pop	a
2803                     ; 432     unSendDataLength = (uint8_t)ulMQTT_Publish(aunPushed_Data,
2803                     ; 433                                                punGet_Event_Topic(),
2803                     ; 434                                                localBuffer /*, eCTRL_PKT_FLAG_PUBLISH_D0_0_R0 */);
2805  08c5 96            	ldw	x,sp
2806  08c6 1c0004        	addw	x,#OFST-21
2807  08c9 89            	pushw	x
2808  08ca cd07e7        	call	_punGet_Event_Topic
2810  08cd 89            	pushw	x
2811  08ce ae0000        	ldw	x,#_aunPushed_Data
2812  08d1 cd0000        	call	_ulMQTT_Publish
2814  08d4 5b04          	addw	sp,#4
2815  08d6 b603          	ld	a,c_lreg+3
2816  08d8 6b01          	ld	(OFST-24,sp),a
2818                     ; 435     bSendDataOverTCP(aunPushed_Data, unSendDataLength);
2820  08da 7b01          	ld	a,(OFST-24,sp)
2821  08dc 88            	push	a
2822  08dd ae0000        	ldw	x,#_aunPushed_Data
2823  08e0 cd0000        	call	_bSendDataOverTCP
2825  08e3 84            	pop	a
2826                     ; 436 }
2829  08e4 5b19          	addw	sp,#25
2830  08e6 81            	ret
2917                     	xdef	_sendDataToCloud
2918                     	xdef	_bCONNACK_Recieved
2919                     	xdef	_aunMQTT_Publish_Topic
2920                     	xdef	_aunMQTT_Subscribe_Topic
2921                     	xdef	_aunMQTT_ClientID
2922                     	xdef	_aunPushed_Data
2923                     	xdef	_vMevris_Send_IMEI
2924                     	xdef	_punGet_Client_ID
2925                     	xdef	_punGet_Command_Topic
2926                     	xdef	_punGet_Event_Topic
2927                     	xdef	_vHandleMevris_MQTT_Recv_Data
2928                     	xdef	_vHandleMevrisRecievedData
2929                     	xdef	_createStringToSend
2930                     	xref	_enGet_TCP_Status
2931                     	xref	_vClearBuffer
2932                     	xref	_bSendDataOverTCP
2933                     	xref	_response_buffer
2934                     	xref	_ulMQTT_Publish
2935                     	xref	_ms_send_cmd
2936                     	xref.b	_aunIMEI
2937                     	xref	_sprintf
2938                     	xref	_strlen
2939                     	xref	_strstr
2940                     	xref	_strcat
2941                     	switch	.const
2942  0018               L566:
2943  0018 65767400      	dc.b	"evt",0
2944  001c               L546:
2945  001c 636d6400      	dc.b	"cmd",0
2946  0020               L346:
2947  0020 2f00          	dc.b	"/",0
2948  0022               L146:
2949  0022 73633100      	dc.b	"sc1",0
2950  0026               L126:
2951  0026 67656e00      	dc.b	"gen",0
2952  002a               L706:
2953  002a 61726520796f  	dc.b	"are you there",0
2954  0038               L515:
2955  0038 2b49504400    	dc.b	"+IPD",0
2956  003d               L554:
2957  003d 7d00          	dc.b	"}",0
2958  003f               L352:
2959  003f 2c00          	dc.b	",",0
2960  0041               L152:
2961  0041 7b00          	dc.b	"{",0
2962  0043               L722:
2963  0043 256400        	dc.b	"%d",0
2964                     	xref.b	c_lreg
2965                     	xref.b	c_x
2985                     	xref	c_xymvx
2986                     	end
