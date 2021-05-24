   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  64                     ; 39 void sendDataToCloud(void)
  64                     ; 40 {
  66                     	switch	.text
  67  0000               _sendDataToCloud:
  69  0000 5265          	subw	sp,#101
  70       00000065      OFST:	set	101
  73                     ; 43     stringLength = createStringToSend(informationString);
  75  0002 96            	ldw	x,sp
  76  0003 1c0001        	addw	x,#OFST-100
  77  0006 ad03          	call	_createStringToSend
  79                     ; 44 }
  82  0008 5b65          	addw	sp,#101
  83  000a 81            	ret
 196                     ; 46 int createStringToSend(uint8_t *informationString)
 196                     ; 47 {
 197                     	switch	.text
 198  000b               _createStringToSend:
 200  000b 89            	pushw	x
 201  000c 5219          	subw	sp,#25
 202       00000019      OFST:	set	25
 205                     ; 52     uint8_t temp1Length = 0;
 207                     ; 57     sprintf(temp1, "%d", 1234);
 209  000e ae04d2        	ldw	x,#1234
 210  0011 89            	pushw	x
 211  0012 ae0006        	ldw	x,#L111
 212  0015 89            	pushw	x
 213  0016 96            	ldw	x,sp
 214  0017 1c0006        	addw	x,#OFST-19
 215  001a cd0000        	call	_sprintf
 217  001d 5b04          	addw	sp,#4
 218                     ; 58     temp1Length = strlen(temp1);
 220  001f 96            	ldw	x,sp
 221  0020 1c0002        	addw	x,#OFST-23
 222  0023 cd0000        	call	_strlen
 224  0026 01            	rrwa	x,a
 225  0027 6b01          	ld	(OFST-24,sp),a
 226  0029 02            	rlwa	x,a
 228                     ; 59     decPlace = temp1Length - 2;
 230  002a 7b01          	ld	a,(OFST-24,sp)
 231  002c a002          	sub	a,#2
 232  002e 6b18          	ld	(OFST-1,sp),a
 234                     ; 60     temp2[decPlace] = '.';
 236  0030 96            	ldw	x,sp
 237  0031 1c0008        	addw	x,#OFST-17
 238  0034 9f            	ld	a,xl
 239  0035 5e            	swapw	x
 240  0036 1b18          	add	a,(OFST-1,sp)
 241  0038 2401          	jrnc	L01
 242  003a 5c            	incw	x
 243  003b               L01:
 244  003b 02            	rlwa	x,a
 245  003c a62e          	ld	a,#46
 246  003e f7            	ld	(x),a
 247                     ; 61     for (w = 0; w < decPlace; w++)
 249  003f 0f19          	clr	(OFST+0,sp)
 252  0041 201e          	jra	L711
 253  0043               L311:
 254                     ; 63         temp2[w] = temp1[w];
 256  0043 96            	ldw	x,sp
 257  0044 1c0008        	addw	x,#OFST-17
 258  0047 9f            	ld	a,xl
 259  0048 5e            	swapw	x
 260  0049 1b19          	add	a,(OFST+0,sp)
 261  004b 2401          	jrnc	L21
 262  004d 5c            	incw	x
 263  004e               L21:
 264  004e 02            	rlwa	x,a
 265  004f 89            	pushw	x
 266  0050 96            	ldw	x,sp
 267  0051 1c0004        	addw	x,#OFST-21
 268  0054 9f            	ld	a,xl
 269  0055 5e            	swapw	x
 270  0056 1b1b          	add	a,(OFST+2,sp)
 271  0058 2401          	jrnc	L41
 272  005a 5c            	incw	x
 273  005b               L41:
 274  005b 02            	rlwa	x,a
 275  005c f6            	ld	a,(x)
 276  005d 85            	popw	x
 277  005e f7            	ld	(x),a
 278                     ; 61     for (w = 0; w < decPlace; w++)
 280  005f 0c19          	inc	(OFST+0,sp)
 282  0061               L711:
 285  0061 7b19          	ld	a,(OFST+0,sp)
 286  0063 1118          	cp	a,(OFST-1,sp)
 287  0065 25dc          	jrult	L311
 288                     ; 65     f = decPlace + 1;
 290  0067 7b18          	ld	a,(OFST-1,sp)
 291  0069 4c            	inc	a
 292  006a 6b18          	ld	(OFST-1,sp),a
 294                     ; 66     for (w = f; w <= temp1Length; w++)
 296  006c 7b18          	ld	a,(OFST-1,sp)
 297  006e 6b19          	ld	(OFST+0,sp),a
 300  0070 2023          	jra	L721
 301  0072               L321:
 302                     ; 68         u = w - 1;
 304  0072 7b19          	ld	a,(OFST+0,sp)
 305  0074 4a            	dec	a
 306  0075 6b18          	ld	(OFST-1,sp),a
 308                     ; 69         temp2[w] = temp1[u];
 310  0077 96            	ldw	x,sp
 311  0078 1c0008        	addw	x,#OFST-17
 312  007b 9f            	ld	a,xl
 313  007c 5e            	swapw	x
 314  007d 1b19          	add	a,(OFST+0,sp)
 315  007f 2401          	jrnc	L61
 316  0081 5c            	incw	x
 317  0082               L61:
 318  0082 02            	rlwa	x,a
 319  0083 89            	pushw	x
 320  0084 96            	ldw	x,sp
 321  0085 1c0004        	addw	x,#OFST-21
 322  0088 9f            	ld	a,xl
 323  0089 5e            	swapw	x
 324  008a 1b1a          	add	a,(OFST+1,sp)
 325  008c 2401          	jrnc	L02
 326  008e 5c            	incw	x
 327  008f               L02:
 328  008f 02            	rlwa	x,a
 329  0090 f6            	ld	a,(x)
 330  0091 85            	popw	x
 331  0092 f7            	ld	(x),a
 332                     ; 66     for (w = f; w <= temp1Length; w++)
 334  0093 0c19          	inc	(OFST+0,sp)
 336  0095               L721:
 339  0095 7b19          	ld	a,(OFST+0,sp)
 340  0097 1101          	cp	a,(OFST-24,sp)
 341  0099 23d7          	jrule	L321
 342                     ; 71     temp2[w] = '\0';
 344  009b 96            	ldw	x,sp
 345  009c 1c0008        	addw	x,#OFST-17
 346  009f 9f            	ld	a,xl
 347  00a0 5e            	swapw	x
 348  00a1 1b19          	add	a,(OFST+0,sp)
 349  00a3 2401          	jrnc	L22
 350  00a5 5c            	incw	x
 351  00a6               L22:
 352  00a6 02            	rlwa	x,a
 353  00a7 7f            	clr	(x)
 354                     ; 73     strcpy(informationString, "{");
 356  00a8 1e1a          	ldw	x,(OFST+1,sp)
 357  00aa 90ae0004      	ldw	y,#L331
 358  00ae               L42:
 359  00ae 90f6          	ld	a,(y)
 360  00b0 905c          	incw	y
 361  00b2 f7            	ld	(x),a
 362  00b3 5c            	incw	x
 363  00b4 4d            	tnz	a
 364  00b5 26f7          	jrne	L42
 365                     ; 74     strcat(informationString, temp2);
 367  00b7 96            	ldw	x,sp
 368  00b8 1c0008        	addw	x,#OFST-17
 369  00bb 89            	pushw	x
 370  00bc 1e1c          	ldw	x,(OFST+3,sp)
 371  00be cd0000        	call	_strcat
 373  00c1 85            	popw	x
 374                     ; 75     strcat(informationString, ",");
 376  00c2 ae0002        	ldw	x,#L531
 377  00c5 89            	pushw	x
 378  00c6 1e1c          	ldw	x,(OFST+3,sp)
 379  00c8 cd0000        	call	_strcat
 381  00cb 85            	popw	x
 382                     ; 77     sprintf(temp1, "%d", 4567);
 384  00cc ae11d7        	ldw	x,#4567
 385  00cf 89            	pushw	x
 386  00d0 ae0006        	ldw	x,#L111
 387  00d3 89            	pushw	x
 388  00d4 96            	ldw	x,sp
 389  00d5 1c0006        	addw	x,#OFST-19
 390  00d8 cd0000        	call	_sprintf
 392  00db 5b04          	addw	sp,#4
 393                     ; 78     temp1Length = strlen(temp1);
 395  00dd 96            	ldw	x,sp
 396  00de 1c0002        	addw	x,#OFST-23
 397  00e1 cd0000        	call	_strlen
 399  00e4 01            	rrwa	x,a
 400  00e5 6b01          	ld	(OFST-24,sp),a
 401  00e7 02            	rlwa	x,a
 403                     ; 79     decPlace = temp1Length - 2;
 405  00e8 7b01          	ld	a,(OFST-24,sp)
 406  00ea a002          	sub	a,#2
 407  00ec 6b18          	ld	(OFST-1,sp),a
 409                     ; 80     temp2[decPlace] = '.';
 411  00ee 96            	ldw	x,sp
 412  00ef 1c0008        	addw	x,#OFST-17
 413  00f2 9f            	ld	a,xl
 414  00f3 5e            	swapw	x
 415  00f4 1b18          	add	a,(OFST-1,sp)
 416  00f6 2401          	jrnc	L62
 417  00f8 5c            	incw	x
 418  00f9               L62:
 419  00f9 02            	rlwa	x,a
 420  00fa a62e          	ld	a,#46
 421  00fc f7            	ld	(x),a
 422                     ; 81     for (w = 0; w < decPlace; w++)
 424  00fd 0f19          	clr	(OFST+0,sp)
 427  00ff 201e          	jra	L341
 428  0101               L731:
 429                     ; 83         temp2[w] = temp1[w];
 431  0101 96            	ldw	x,sp
 432  0102 1c0008        	addw	x,#OFST-17
 433  0105 9f            	ld	a,xl
 434  0106 5e            	swapw	x
 435  0107 1b19          	add	a,(OFST+0,sp)
 436  0109 2401          	jrnc	L03
 437  010b 5c            	incw	x
 438  010c               L03:
 439  010c 02            	rlwa	x,a
 440  010d 89            	pushw	x
 441  010e 96            	ldw	x,sp
 442  010f 1c0004        	addw	x,#OFST-21
 443  0112 9f            	ld	a,xl
 444  0113 5e            	swapw	x
 445  0114 1b1b          	add	a,(OFST+2,sp)
 446  0116 2401          	jrnc	L23
 447  0118 5c            	incw	x
 448  0119               L23:
 449  0119 02            	rlwa	x,a
 450  011a f6            	ld	a,(x)
 451  011b 85            	popw	x
 452  011c f7            	ld	(x),a
 453                     ; 81     for (w = 0; w < decPlace; w++)
 455  011d 0c19          	inc	(OFST+0,sp)
 457  011f               L341:
 460  011f 7b19          	ld	a,(OFST+0,sp)
 461  0121 1118          	cp	a,(OFST-1,sp)
 462  0123 25dc          	jrult	L731
 463                     ; 85     f = decPlace + 1;
 465  0125 7b18          	ld	a,(OFST-1,sp)
 466  0127 4c            	inc	a
 467  0128 6b18          	ld	(OFST-1,sp),a
 469                     ; 86     for (w = f; w <= temp1Length; w++)
 471  012a 7b18          	ld	a,(OFST-1,sp)
 472  012c 6b19          	ld	(OFST+0,sp),a
 475  012e 2023          	jra	L351
 476  0130               L741:
 477                     ; 88         u = w - 1;
 479  0130 7b19          	ld	a,(OFST+0,sp)
 480  0132 4a            	dec	a
 481  0133 6b18          	ld	(OFST-1,sp),a
 483                     ; 89         temp2[w] = temp1[u];
 485  0135 96            	ldw	x,sp
 486  0136 1c0008        	addw	x,#OFST-17
 487  0139 9f            	ld	a,xl
 488  013a 5e            	swapw	x
 489  013b 1b19          	add	a,(OFST+0,sp)
 490  013d 2401          	jrnc	L43
 491  013f 5c            	incw	x
 492  0140               L43:
 493  0140 02            	rlwa	x,a
 494  0141 89            	pushw	x
 495  0142 96            	ldw	x,sp
 496  0143 1c0004        	addw	x,#OFST-21
 497  0146 9f            	ld	a,xl
 498  0147 5e            	swapw	x
 499  0148 1b1a          	add	a,(OFST+1,sp)
 500  014a 2401          	jrnc	L63
 501  014c 5c            	incw	x
 502  014d               L63:
 503  014d 02            	rlwa	x,a
 504  014e f6            	ld	a,(x)
 505  014f 85            	popw	x
 506  0150 f7            	ld	(x),a
 507                     ; 86     for (w = f; w <= temp1Length; w++)
 509  0151 0c19          	inc	(OFST+0,sp)
 511  0153               L351:
 514  0153 7b19          	ld	a,(OFST+0,sp)
 515  0155 1101          	cp	a,(OFST-24,sp)
 516  0157 23d7          	jrule	L741
 517                     ; 91     temp2[w] = '\0';
 519  0159 96            	ldw	x,sp
 520  015a 1c0008        	addw	x,#OFST-17
 521  015d 9f            	ld	a,xl
 522  015e 5e            	swapw	x
 523  015f 1b19          	add	a,(OFST+0,sp)
 524  0161 2401          	jrnc	L04
 525  0163 5c            	incw	x
 526  0164               L04:
 527  0164 02            	rlwa	x,a
 528  0165 7f            	clr	(x)
 529                     ; 93     strcat(informationString, temp2);
 531  0166 96            	ldw	x,sp
 532  0167 1c0008        	addw	x,#OFST-17
 533  016a 89            	pushw	x
 534  016b 1e1c          	ldw	x,(OFST+3,sp)
 535  016d cd0000        	call	_strcat
 537  0170 85            	popw	x
 538                     ; 94     strcat(informationString, ",");
 540  0171 ae0002        	ldw	x,#L531
 541  0174 89            	pushw	x
 542  0175 1e1c          	ldw	x,(OFST+3,sp)
 543  0177 cd0000        	call	_strcat
 545  017a 85            	popw	x
 546                     ; 96     sprintf(temp1, "%d", 7891);
 548  017b ae1ed3        	ldw	x,#7891
 549  017e 89            	pushw	x
 550  017f ae0006        	ldw	x,#L111
 551  0182 89            	pushw	x
 552  0183 96            	ldw	x,sp
 553  0184 1c0006        	addw	x,#OFST-19
 554  0187 cd0000        	call	_sprintf
 556  018a 5b04          	addw	sp,#4
 557                     ; 97     temp1Length = strlen(temp1);
 559  018c 96            	ldw	x,sp
 560  018d 1c0002        	addw	x,#OFST-23
 561  0190 cd0000        	call	_strlen
 563  0193 01            	rrwa	x,a
 564  0194 6b01          	ld	(OFST-24,sp),a
 565  0196 02            	rlwa	x,a
 567                     ; 98     decPlace = temp1Length - 2;
 569  0197 7b01          	ld	a,(OFST-24,sp)
 570  0199 a002          	sub	a,#2
 571  019b 6b18          	ld	(OFST-1,sp),a
 573                     ; 99     temp2[decPlace] = '.';
 575  019d 96            	ldw	x,sp
 576  019e 1c0008        	addw	x,#OFST-17
 577  01a1 9f            	ld	a,xl
 578  01a2 5e            	swapw	x
 579  01a3 1b18          	add	a,(OFST-1,sp)
 580  01a5 2401          	jrnc	L24
 581  01a7 5c            	incw	x
 582  01a8               L24:
 583  01a8 02            	rlwa	x,a
 584  01a9 a62e          	ld	a,#46
 585  01ab f7            	ld	(x),a
 586                     ; 100     for (w = 0; w < decPlace; w++)
 588  01ac 0f19          	clr	(OFST+0,sp)
 591  01ae 201e          	jra	L361
 592  01b0               L751:
 593                     ; 102         temp2[w] = temp1[w];
 595  01b0 96            	ldw	x,sp
 596  01b1 1c0008        	addw	x,#OFST-17
 597  01b4 9f            	ld	a,xl
 598  01b5 5e            	swapw	x
 599  01b6 1b19          	add	a,(OFST+0,sp)
 600  01b8 2401          	jrnc	L44
 601  01ba 5c            	incw	x
 602  01bb               L44:
 603  01bb 02            	rlwa	x,a
 604  01bc 89            	pushw	x
 605  01bd 96            	ldw	x,sp
 606  01be 1c0004        	addw	x,#OFST-21
 607  01c1 9f            	ld	a,xl
 608  01c2 5e            	swapw	x
 609  01c3 1b1b          	add	a,(OFST+2,sp)
 610  01c5 2401          	jrnc	L64
 611  01c7 5c            	incw	x
 612  01c8               L64:
 613  01c8 02            	rlwa	x,a
 614  01c9 f6            	ld	a,(x)
 615  01ca 85            	popw	x
 616  01cb f7            	ld	(x),a
 617                     ; 100     for (w = 0; w < decPlace; w++)
 619  01cc 0c19          	inc	(OFST+0,sp)
 621  01ce               L361:
 624  01ce 7b19          	ld	a,(OFST+0,sp)
 625  01d0 1118          	cp	a,(OFST-1,sp)
 626  01d2 25dc          	jrult	L751
 627                     ; 104     f = decPlace + 1;
 629  01d4 7b18          	ld	a,(OFST-1,sp)
 630  01d6 4c            	inc	a
 631  01d7 6b18          	ld	(OFST-1,sp),a
 633                     ; 105     for (w = f; w <= temp1Length; w++)
 635  01d9 7b18          	ld	a,(OFST-1,sp)
 636  01db 6b19          	ld	(OFST+0,sp),a
 639  01dd 2023          	jra	L371
 640  01df               L761:
 641                     ; 107         u = w - 1;
 643  01df 7b19          	ld	a,(OFST+0,sp)
 644  01e1 4a            	dec	a
 645  01e2 6b18          	ld	(OFST-1,sp),a
 647                     ; 108         temp2[w] = temp1[u];
 649  01e4 96            	ldw	x,sp
 650  01e5 1c0008        	addw	x,#OFST-17
 651  01e8 9f            	ld	a,xl
 652  01e9 5e            	swapw	x
 653  01ea 1b19          	add	a,(OFST+0,sp)
 654  01ec 2401          	jrnc	L05
 655  01ee 5c            	incw	x
 656  01ef               L05:
 657  01ef 02            	rlwa	x,a
 658  01f0 89            	pushw	x
 659  01f1 96            	ldw	x,sp
 660  01f2 1c0004        	addw	x,#OFST-21
 661  01f5 9f            	ld	a,xl
 662  01f6 5e            	swapw	x
 663  01f7 1b1a          	add	a,(OFST+1,sp)
 664  01f9 2401          	jrnc	L25
 665  01fb 5c            	incw	x
 666  01fc               L25:
 667  01fc 02            	rlwa	x,a
 668  01fd f6            	ld	a,(x)
 669  01fe 85            	popw	x
 670  01ff f7            	ld	(x),a
 671                     ; 105     for (w = f; w <= temp1Length; w++)
 673  0200 0c19          	inc	(OFST+0,sp)
 675  0202               L371:
 678  0202 7b19          	ld	a,(OFST+0,sp)
 679  0204 1101          	cp	a,(OFST-24,sp)
 680  0206 23d7          	jrule	L761
 681                     ; 110     temp2[w] = '\0';
 683  0208 96            	ldw	x,sp
 684  0209 1c0008        	addw	x,#OFST-17
 685  020c 9f            	ld	a,xl
 686  020d 5e            	swapw	x
 687  020e 1b19          	add	a,(OFST+0,sp)
 688  0210 2401          	jrnc	L45
 689  0212 5c            	incw	x
 690  0213               L45:
 691  0213 02            	rlwa	x,a
 692  0214 7f            	clr	(x)
 693                     ; 112     strcat(informationString, temp2);
 695  0215 96            	ldw	x,sp
 696  0216 1c0008        	addw	x,#OFST-17
 697  0219 89            	pushw	x
 698  021a 1e1c          	ldw	x,(OFST+3,sp)
 699  021c cd0000        	call	_strcat
 701  021f 85            	popw	x
 702                     ; 113     strcat(informationString, ",");
 704  0220 ae0002        	ldw	x,#L531
 705  0223 89            	pushw	x
 706  0224 1e1c          	ldw	x,(OFST+3,sp)
 707  0226 cd0000        	call	_strcat
 709  0229 85            	popw	x
 710                     ; 115     sprintf(temp1, "%d", 1234);
 712  022a ae04d2        	ldw	x,#1234
 713  022d 89            	pushw	x
 714  022e ae0006        	ldw	x,#L111
 715  0231 89            	pushw	x
 716  0232 96            	ldw	x,sp
 717  0233 1c0006        	addw	x,#OFST-19
 718  0236 cd0000        	call	_sprintf
 720  0239 5b04          	addw	sp,#4
 721                     ; 116     temp1Length = strlen(temp1);
 723  023b 96            	ldw	x,sp
 724  023c 1c0002        	addw	x,#OFST-23
 725  023f cd0000        	call	_strlen
 727  0242 01            	rrwa	x,a
 728  0243 6b01          	ld	(OFST-24,sp),a
 729  0245 02            	rlwa	x,a
 731                     ; 117     decPlace = temp1Length - 2;
 733  0246 7b01          	ld	a,(OFST-24,sp)
 734  0248 a002          	sub	a,#2
 735  024a 6b18          	ld	(OFST-1,sp),a
 737                     ; 118     temp2[decPlace] = '.';
 739  024c 96            	ldw	x,sp
 740  024d 1c0008        	addw	x,#OFST-17
 741  0250 9f            	ld	a,xl
 742  0251 5e            	swapw	x
 743  0252 1b18          	add	a,(OFST-1,sp)
 744  0254 2401          	jrnc	L65
 745  0256 5c            	incw	x
 746  0257               L65:
 747  0257 02            	rlwa	x,a
 748  0258 a62e          	ld	a,#46
 749  025a f7            	ld	(x),a
 750                     ; 119     for (w = 0; w < decPlace; w++)
 752  025b 0f19          	clr	(OFST+0,sp)
 755  025d 201e          	jra	L302
 756  025f               L771:
 757                     ; 121         temp2[w] = temp1[w];
 759  025f 96            	ldw	x,sp
 760  0260 1c0008        	addw	x,#OFST-17
 761  0263 9f            	ld	a,xl
 762  0264 5e            	swapw	x
 763  0265 1b19          	add	a,(OFST+0,sp)
 764  0267 2401          	jrnc	L06
 765  0269 5c            	incw	x
 766  026a               L06:
 767  026a 02            	rlwa	x,a
 768  026b 89            	pushw	x
 769  026c 96            	ldw	x,sp
 770  026d 1c0004        	addw	x,#OFST-21
 771  0270 9f            	ld	a,xl
 772  0271 5e            	swapw	x
 773  0272 1b1b          	add	a,(OFST+2,sp)
 774  0274 2401          	jrnc	L26
 775  0276 5c            	incw	x
 776  0277               L26:
 777  0277 02            	rlwa	x,a
 778  0278 f6            	ld	a,(x)
 779  0279 85            	popw	x
 780  027a f7            	ld	(x),a
 781                     ; 119     for (w = 0; w < decPlace; w++)
 783  027b 0c19          	inc	(OFST+0,sp)
 785  027d               L302:
 788  027d 7b19          	ld	a,(OFST+0,sp)
 789  027f 1118          	cp	a,(OFST-1,sp)
 790  0281 25dc          	jrult	L771
 791                     ; 123     f = decPlace + 1;
 793  0283 7b18          	ld	a,(OFST-1,sp)
 794  0285 4c            	inc	a
 795  0286 6b18          	ld	(OFST-1,sp),a
 797                     ; 124     for (w = f; w <= temp1Length; w++)
 799  0288 7b18          	ld	a,(OFST-1,sp)
 800  028a 6b19          	ld	(OFST+0,sp),a
 803  028c 2023          	jra	L312
 804  028e               L702:
 805                     ; 126         u = w - 1;
 807  028e 7b19          	ld	a,(OFST+0,sp)
 808  0290 4a            	dec	a
 809  0291 6b18          	ld	(OFST-1,sp),a
 811                     ; 127         temp2[w] = temp1[u];
 813  0293 96            	ldw	x,sp
 814  0294 1c0008        	addw	x,#OFST-17
 815  0297 9f            	ld	a,xl
 816  0298 5e            	swapw	x
 817  0299 1b19          	add	a,(OFST+0,sp)
 818  029b 2401          	jrnc	L46
 819  029d 5c            	incw	x
 820  029e               L46:
 821  029e 02            	rlwa	x,a
 822  029f 89            	pushw	x
 823  02a0 96            	ldw	x,sp
 824  02a1 1c0004        	addw	x,#OFST-21
 825  02a4 9f            	ld	a,xl
 826  02a5 5e            	swapw	x
 827  02a6 1b1a          	add	a,(OFST+1,sp)
 828  02a8 2401          	jrnc	L66
 829  02aa 5c            	incw	x
 830  02ab               L66:
 831  02ab 02            	rlwa	x,a
 832  02ac f6            	ld	a,(x)
 833  02ad 85            	popw	x
 834  02ae f7            	ld	(x),a
 835                     ; 124     for (w = f; w <= temp1Length; w++)
 837  02af 0c19          	inc	(OFST+0,sp)
 839  02b1               L312:
 842  02b1 7b19          	ld	a,(OFST+0,sp)
 843  02b3 1101          	cp	a,(OFST-24,sp)
 844  02b5 23d7          	jrule	L702
 845                     ; 129     temp2[w] = '\0';
 847  02b7 96            	ldw	x,sp
 848  02b8 1c0008        	addw	x,#OFST-17
 849  02bb 9f            	ld	a,xl
 850  02bc 5e            	swapw	x
 851  02bd 1b19          	add	a,(OFST+0,sp)
 852  02bf 2401          	jrnc	L07
 853  02c1 5c            	incw	x
 854  02c2               L07:
 855  02c2 02            	rlwa	x,a
 856  02c3 7f            	clr	(x)
 857                     ; 131     strcat(informationString, temp2);
 859  02c4 96            	ldw	x,sp
 860  02c5 1c0008        	addw	x,#OFST-17
 861  02c8 89            	pushw	x
 862  02c9 1e1c          	ldw	x,(OFST+3,sp)
 863  02cb cd0000        	call	_strcat
 865  02ce 85            	popw	x
 866                     ; 132     strcat(informationString, ",");
 868  02cf ae0002        	ldw	x,#L531
 869  02d2 89            	pushw	x
 870  02d3 1e1c          	ldw	x,(OFST+3,sp)
 871  02d5 cd0000        	call	_strcat
 873  02d8 85            	popw	x
 874                     ; 134     sprintf(temp1, "%d", 4657);
 876  02d9 ae1231        	ldw	x,#4657
 877  02dc 89            	pushw	x
 878  02dd ae0006        	ldw	x,#L111
 879  02e0 89            	pushw	x
 880  02e1 96            	ldw	x,sp
 881  02e2 1c0006        	addw	x,#OFST-19
 882  02e5 cd0000        	call	_sprintf
 884  02e8 5b04          	addw	sp,#4
 885                     ; 135     temp1Length = strlen(temp1);
 887  02ea 96            	ldw	x,sp
 888  02eb 1c0002        	addw	x,#OFST-23
 889  02ee cd0000        	call	_strlen
 891  02f1 01            	rrwa	x,a
 892  02f2 6b01          	ld	(OFST-24,sp),a
 893  02f4 02            	rlwa	x,a
 895                     ; 136     decPlace = temp1Length - 2;
 897  02f5 7b01          	ld	a,(OFST-24,sp)
 898  02f7 a002          	sub	a,#2
 899  02f9 6b18          	ld	(OFST-1,sp),a
 901                     ; 137     temp2[decPlace] = '.';
 903  02fb 96            	ldw	x,sp
 904  02fc 1c0008        	addw	x,#OFST-17
 905  02ff 9f            	ld	a,xl
 906  0300 5e            	swapw	x
 907  0301 1b18          	add	a,(OFST-1,sp)
 908  0303 2401          	jrnc	L27
 909  0305 5c            	incw	x
 910  0306               L27:
 911  0306 02            	rlwa	x,a
 912  0307 a62e          	ld	a,#46
 913  0309 f7            	ld	(x),a
 914                     ; 138     for (w = 0; w < decPlace; w++)
 916  030a 0f19          	clr	(OFST+0,sp)
 919  030c 201e          	jra	L322
 920  030e               L712:
 921                     ; 140         temp2[w] = temp1[w];
 923  030e 96            	ldw	x,sp
 924  030f 1c0008        	addw	x,#OFST-17
 925  0312 9f            	ld	a,xl
 926  0313 5e            	swapw	x
 927  0314 1b19          	add	a,(OFST+0,sp)
 928  0316 2401          	jrnc	L47
 929  0318 5c            	incw	x
 930  0319               L47:
 931  0319 02            	rlwa	x,a
 932  031a 89            	pushw	x
 933  031b 96            	ldw	x,sp
 934  031c 1c0004        	addw	x,#OFST-21
 935  031f 9f            	ld	a,xl
 936  0320 5e            	swapw	x
 937  0321 1b1b          	add	a,(OFST+2,sp)
 938  0323 2401          	jrnc	L67
 939  0325 5c            	incw	x
 940  0326               L67:
 941  0326 02            	rlwa	x,a
 942  0327 f6            	ld	a,(x)
 943  0328 85            	popw	x
 944  0329 f7            	ld	(x),a
 945                     ; 138     for (w = 0; w < decPlace; w++)
 947  032a 0c19          	inc	(OFST+0,sp)
 949  032c               L322:
 952  032c 7b19          	ld	a,(OFST+0,sp)
 953  032e 1118          	cp	a,(OFST-1,sp)
 954  0330 25dc          	jrult	L712
 955                     ; 142     f = decPlace + 1;
 957  0332 7b18          	ld	a,(OFST-1,sp)
 958  0334 4c            	inc	a
 959  0335 6b18          	ld	(OFST-1,sp),a
 961                     ; 143     for (w = f; w <= temp1Length; w++)
 963  0337 7b18          	ld	a,(OFST-1,sp)
 964  0339 6b19          	ld	(OFST+0,sp),a
 967  033b 2023          	jra	L332
 968  033d               L722:
 969                     ; 145         u = w - 1;
 971  033d 7b19          	ld	a,(OFST+0,sp)
 972  033f 4a            	dec	a
 973  0340 6b18          	ld	(OFST-1,sp),a
 975                     ; 146         temp2[w] = temp1[u];
 977  0342 96            	ldw	x,sp
 978  0343 1c0008        	addw	x,#OFST-17
 979  0346 9f            	ld	a,xl
 980  0347 5e            	swapw	x
 981  0348 1b19          	add	a,(OFST+0,sp)
 982  034a 2401          	jrnc	L001
 983  034c 5c            	incw	x
 984  034d               L001:
 985  034d 02            	rlwa	x,a
 986  034e 89            	pushw	x
 987  034f 96            	ldw	x,sp
 988  0350 1c0004        	addw	x,#OFST-21
 989  0353 9f            	ld	a,xl
 990  0354 5e            	swapw	x
 991  0355 1b1a          	add	a,(OFST+1,sp)
 992  0357 2401          	jrnc	L201
 993  0359 5c            	incw	x
 994  035a               L201:
 995  035a 02            	rlwa	x,a
 996  035b f6            	ld	a,(x)
 997  035c 85            	popw	x
 998  035d f7            	ld	(x),a
 999                     ; 143     for (w = f; w <= temp1Length; w++)
1001  035e 0c19          	inc	(OFST+0,sp)
1003  0360               L332:
1006  0360 7b19          	ld	a,(OFST+0,sp)
1007  0362 1101          	cp	a,(OFST-24,sp)
1008  0364 23d7          	jrule	L722
1009                     ; 148     temp2[w] = '\0';
1011  0366 96            	ldw	x,sp
1012  0367 1c0008        	addw	x,#OFST-17
1013  036a 9f            	ld	a,xl
1014  036b 5e            	swapw	x
1015  036c 1b19          	add	a,(OFST+0,sp)
1016  036e 2401          	jrnc	L401
1017  0370 5c            	incw	x
1018  0371               L401:
1019  0371 02            	rlwa	x,a
1020  0372 7f            	clr	(x)
1021                     ; 150     strcat(informationString, temp2);
1023  0373 96            	ldw	x,sp
1024  0374 1c0008        	addw	x,#OFST-17
1025  0377 89            	pushw	x
1026  0378 1e1c          	ldw	x,(OFST+3,sp)
1027  037a cd0000        	call	_strcat
1029  037d 85            	popw	x
1030                     ; 151     strcat(informationString, ",");
1032  037e ae0002        	ldw	x,#L531
1033  0381 89            	pushw	x
1034  0382 1e1c          	ldw	x,(OFST+3,sp)
1035  0384 cd0000        	call	_strcat
1037  0387 85            	popw	x
1038                     ; 153     sprintf(temp1, "%d", 7891);
1040  0388 ae1ed3        	ldw	x,#7891
1041  038b 89            	pushw	x
1042  038c ae0006        	ldw	x,#L111
1043  038f 89            	pushw	x
1044  0390 96            	ldw	x,sp
1045  0391 1c0006        	addw	x,#OFST-19
1046  0394 cd0000        	call	_sprintf
1048  0397 5b04          	addw	sp,#4
1049                     ; 154     temp1Length = strlen(temp1);
1051  0399 96            	ldw	x,sp
1052  039a 1c0002        	addw	x,#OFST-23
1053  039d cd0000        	call	_strlen
1055  03a0 01            	rrwa	x,a
1056  03a1 6b01          	ld	(OFST-24,sp),a
1057  03a3 02            	rlwa	x,a
1059                     ; 155     decPlace = temp1Length - 2;
1061  03a4 7b01          	ld	a,(OFST-24,sp)
1062  03a6 a002          	sub	a,#2
1063  03a8 6b18          	ld	(OFST-1,sp),a
1065                     ; 156     temp2[decPlace] = '.';
1067  03aa 96            	ldw	x,sp
1068  03ab 1c0008        	addw	x,#OFST-17
1069  03ae 9f            	ld	a,xl
1070  03af 5e            	swapw	x
1071  03b0 1b18          	add	a,(OFST-1,sp)
1072  03b2 2401          	jrnc	L601
1073  03b4 5c            	incw	x
1074  03b5               L601:
1075  03b5 02            	rlwa	x,a
1076  03b6 a62e          	ld	a,#46
1077  03b8 f7            	ld	(x),a
1078                     ; 157     for (w = 0; w < decPlace; w++)
1080  03b9 0f19          	clr	(OFST+0,sp)
1083  03bb 201e          	jra	L342
1084  03bd               L732:
1085                     ; 159         temp2[w] = temp1[w];
1087  03bd 96            	ldw	x,sp
1088  03be 1c0008        	addw	x,#OFST-17
1089  03c1 9f            	ld	a,xl
1090  03c2 5e            	swapw	x
1091  03c3 1b19          	add	a,(OFST+0,sp)
1092  03c5 2401          	jrnc	L011
1093  03c7 5c            	incw	x
1094  03c8               L011:
1095  03c8 02            	rlwa	x,a
1096  03c9 89            	pushw	x
1097  03ca 96            	ldw	x,sp
1098  03cb 1c0004        	addw	x,#OFST-21
1099  03ce 9f            	ld	a,xl
1100  03cf 5e            	swapw	x
1101  03d0 1b1b          	add	a,(OFST+2,sp)
1102  03d2 2401          	jrnc	L211
1103  03d4 5c            	incw	x
1104  03d5               L211:
1105  03d5 02            	rlwa	x,a
1106  03d6 f6            	ld	a,(x)
1107  03d7 85            	popw	x
1108  03d8 f7            	ld	(x),a
1109                     ; 157     for (w = 0; w < decPlace; w++)
1111  03d9 0c19          	inc	(OFST+0,sp)
1113  03db               L342:
1116  03db 7b19          	ld	a,(OFST+0,sp)
1117  03dd 1118          	cp	a,(OFST-1,sp)
1118  03df 25dc          	jrult	L732
1119                     ; 161     f = decPlace + 1;
1121  03e1 7b18          	ld	a,(OFST-1,sp)
1122  03e3 4c            	inc	a
1123  03e4 6b18          	ld	(OFST-1,sp),a
1125                     ; 162     for (w = f; w <= temp1Length; w++)
1127  03e6 7b18          	ld	a,(OFST-1,sp)
1128  03e8 6b19          	ld	(OFST+0,sp),a
1131  03ea 2023          	jra	L352
1132  03ec               L742:
1133                     ; 164         u = w - 1;
1135  03ec 7b19          	ld	a,(OFST+0,sp)
1136  03ee 4a            	dec	a
1137  03ef 6b18          	ld	(OFST-1,sp),a
1139                     ; 165         temp2[w] = temp1[u];
1141  03f1 96            	ldw	x,sp
1142  03f2 1c0008        	addw	x,#OFST-17
1143  03f5 9f            	ld	a,xl
1144  03f6 5e            	swapw	x
1145  03f7 1b19          	add	a,(OFST+0,sp)
1146  03f9 2401          	jrnc	L411
1147  03fb 5c            	incw	x
1148  03fc               L411:
1149  03fc 02            	rlwa	x,a
1150  03fd 89            	pushw	x
1151  03fe 96            	ldw	x,sp
1152  03ff 1c0004        	addw	x,#OFST-21
1153  0402 9f            	ld	a,xl
1154  0403 5e            	swapw	x
1155  0404 1b1a          	add	a,(OFST+1,sp)
1156  0406 2401          	jrnc	L611
1157  0408 5c            	incw	x
1158  0409               L611:
1159  0409 02            	rlwa	x,a
1160  040a f6            	ld	a,(x)
1161  040b 85            	popw	x
1162  040c f7            	ld	(x),a
1163                     ; 162     for (w = f; w <= temp1Length; w++)
1165  040d 0c19          	inc	(OFST+0,sp)
1167  040f               L352:
1170  040f 7b19          	ld	a,(OFST+0,sp)
1171  0411 1101          	cp	a,(OFST-24,sp)
1172  0413 23d7          	jrule	L742
1173                     ; 167     temp2[w] = '\0';
1175  0415 96            	ldw	x,sp
1176  0416 1c0008        	addw	x,#OFST-17
1177  0419 9f            	ld	a,xl
1178  041a 5e            	swapw	x
1179  041b 1b19          	add	a,(OFST+0,sp)
1180  041d 2401          	jrnc	L021
1181  041f 5c            	incw	x
1182  0420               L021:
1183  0420 02            	rlwa	x,a
1184  0421 7f            	clr	(x)
1185                     ; 169     strcat(informationString, temp2);
1187  0422 96            	ldw	x,sp
1188  0423 1c0008        	addw	x,#OFST-17
1189  0426 89            	pushw	x
1190  0427 1e1c          	ldw	x,(OFST+3,sp)
1191  0429 cd0000        	call	_strcat
1193  042c 85            	popw	x
1194                     ; 170     strcat(informationString, ",");
1196  042d ae0002        	ldw	x,#L531
1197  0430 89            	pushw	x
1198  0431 1e1c          	ldw	x,(OFST+3,sp)
1199  0433 cd0000        	call	_strcat
1201  0436 85            	popw	x
1202                     ; 172     sprintf(temp1, "%d", 1324);
1204  0437 ae052c        	ldw	x,#1324
1205  043a 89            	pushw	x
1206  043b ae0006        	ldw	x,#L111
1207  043e 89            	pushw	x
1208  043f 96            	ldw	x,sp
1209  0440 1c0006        	addw	x,#OFST-19
1210  0443 cd0000        	call	_sprintf
1212  0446 5b04          	addw	sp,#4
1213                     ; 173     temp1Length = strlen(temp1);
1215  0448 96            	ldw	x,sp
1216  0449 1c0002        	addw	x,#OFST-23
1217  044c cd0000        	call	_strlen
1219  044f 01            	rrwa	x,a
1220  0450 6b01          	ld	(OFST-24,sp),a
1221  0452 02            	rlwa	x,a
1223                     ; 174     decPlace = temp1Length - 2;
1225  0453 7b01          	ld	a,(OFST-24,sp)
1226  0455 a002          	sub	a,#2
1227  0457 6b18          	ld	(OFST-1,sp),a
1229                     ; 175     temp2[decPlace] = '.';
1231  0459 96            	ldw	x,sp
1232  045a 1c0008        	addw	x,#OFST-17
1233  045d 9f            	ld	a,xl
1234  045e 5e            	swapw	x
1235  045f 1b18          	add	a,(OFST-1,sp)
1236  0461 2401          	jrnc	L221
1237  0463 5c            	incw	x
1238  0464               L221:
1239  0464 02            	rlwa	x,a
1240  0465 a62e          	ld	a,#46
1241  0467 f7            	ld	(x),a
1242                     ; 176     for (w = 0; w < decPlace; w++)
1244  0468 0f19          	clr	(OFST+0,sp)
1247  046a 201e          	jra	L362
1248  046c               L752:
1249                     ; 178         temp2[w] = temp1[w];
1251  046c 96            	ldw	x,sp
1252  046d 1c0008        	addw	x,#OFST-17
1253  0470 9f            	ld	a,xl
1254  0471 5e            	swapw	x
1255  0472 1b19          	add	a,(OFST+0,sp)
1256  0474 2401          	jrnc	L421
1257  0476 5c            	incw	x
1258  0477               L421:
1259  0477 02            	rlwa	x,a
1260  0478 89            	pushw	x
1261  0479 96            	ldw	x,sp
1262  047a 1c0004        	addw	x,#OFST-21
1263  047d 9f            	ld	a,xl
1264  047e 5e            	swapw	x
1265  047f 1b1b          	add	a,(OFST+2,sp)
1266  0481 2401          	jrnc	L621
1267  0483 5c            	incw	x
1268  0484               L621:
1269  0484 02            	rlwa	x,a
1270  0485 f6            	ld	a,(x)
1271  0486 85            	popw	x
1272  0487 f7            	ld	(x),a
1273                     ; 176     for (w = 0; w < decPlace; w++)
1275  0488 0c19          	inc	(OFST+0,sp)
1277  048a               L362:
1280  048a 7b19          	ld	a,(OFST+0,sp)
1281  048c 1118          	cp	a,(OFST-1,sp)
1282  048e 25dc          	jrult	L752
1283                     ; 180     f = decPlace + 1;
1285  0490 7b18          	ld	a,(OFST-1,sp)
1286  0492 4c            	inc	a
1287  0493 6b18          	ld	(OFST-1,sp),a
1289                     ; 181     for (w = f; w <= temp1Length; w++)
1291  0495 7b18          	ld	a,(OFST-1,sp)
1292  0497 6b19          	ld	(OFST+0,sp),a
1295  0499 2023          	jra	L372
1296  049b               L762:
1297                     ; 183         u = w - 1;
1299  049b 7b19          	ld	a,(OFST+0,sp)
1300  049d 4a            	dec	a
1301  049e 6b18          	ld	(OFST-1,sp),a
1303                     ; 184         temp2[w] = temp1[u];
1305  04a0 96            	ldw	x,sp
1306  04a1 1c0008        	addw	x,#OFST-17
1307  04a4 9f            	ld	a,xl
1308  04a5 5e            	swapw	x
1309  04a6 1b19          	add	a,(OFST+0,sp)
1310  04a8 2401          	jrnc	L031
1311  04aa 5c            	incw	x
1312  04ab               L031:
1313  04ab 02            	rlwa	x,a
1314  04ac 89            	pushw	x
1315  04ad 96            	ldw	x,sp
1316  04ae 1c0004        	addw	x,#OFST-21
1317  04b1 9f            	ld	a,xl
1318  04b2 5e            	swapw	x
1319  04b3 1b1a          	add	a,(OFST+1,sp)
1320  04b5 2401          	jrnc	L231
1321  04b7 5c            	incw	x
1322  04b8               L231:
1323  04b8 02            	rlwa	x,a
1324  04b9 f6            	ld	a,(x)
1325  04ba 85            	popw	x
1326  04bb f7            	ld	(x),a
1327                     ; 181     for (w = f; w <= temp1Length; w++)
1329  04bc 0c19          	inc	(OFST+0,sp)
1331  04be               L372:
1334  04be 7b19          	ld	a,(OFST+0,sp)
1335  04c0 1101          	cp	a,(OFST-24,sp)
1336  04c2 23d7          	jrule	L762
1337                     ; 186     temp2[w] = '\0';
1339  04c4 96            	ldw	x,sp
1340  04c5 1c0008        	addw	x,#OFST-17
1341  04c8 9f            	ld	a,xl
1342  04c9 5e            	swapw	x
1343  04ca 1b19          	add	a,(OFST+0,sp)
1344  04cc 2401          	jrnc	L431
1345  04ce 5c            	incw	x
1346  04cf               L431:
1347  04cf 02            	rlwa	x,a
1348  04d0 7f            	clr	(x)
1349                     ; 188     strcat(informationString, temp2);
1351  04d1 96            	ldw	x,sp
1352  04d2 1c0008        	addw	x,#OFST-17
1353  04d5 89            	pushw	x
1354  04d6 1e1c          	ldw	x,(OFST+3,sp)
1355  04d8 cd0000        	call	_strcat
1357  04db 85            	popw	x
1358                     ; 189     strcat(informationString, ",");
1360  04dc ae0002        	ldw	x,#L531
1361  04df 89            	pushw	x
1362  04e0 1e1c          	ldw	x,(OFST+3,sp)
1363  04e2 cd0000        	call	_strcat
1365  04e5 85            	popw	x
1366                     ; 191     sprintf(temp1, "%d", 4567);
1368  04e6 ae11d7        	ldw	x,#4567
1369  04e9 89            	pushw	x
1370  04ea ae0006        	ldw	x,#L111
1371  04ed 89            	pushw	x
1372  04ee 96            	ldw	x,sp
1373  04ef 1c0006        	addw	x,#OFST-19
1374  04f2 cd0000        	call	_sprintf
1376  04f5 5b04          	addw	sp,#4
1377                     ; 192     temp1Length = strlen(temp1);
1379  04f7 96            	ldw	x,sp
1380  04f8 1c0002        	addw	x,#OFST-23
1381  04fb cd0000        	call	_strlen
1383  04fe 01            	rrwa	x,a
1384  04ff 6b01          	ld	(OFST-24,sp),a
1385  0501 02            	rlwa	x,a
1387                     ; 193     decPlace = temp1Length - 2;
1389  0502 7b01          	ld	a,(OFST-24,sp)
1390  0504 a002          	sub	a,#2
1391  0506 6b18          	ld	(OFST-1,sp),a
1393                     ; 194     temp2[decPlace] = '.';
1395  0508 96            	ldw	x,sp
1396  0509 1c0008        	addw	x,#OFST-17
1397  050c 9f            	ld	a,xl
1398  050d 5e            	swapw	x
1399  050e 1b18          	add	a,(OFST-1,sp)
1400  0510 2401          	jrnc	L631
1401  0512 5c            	incw	x
1402  0513               L631:
1403  0513 02            	rlwa	x,a
1404  0514 a62e          	ld	a,#46
1405  0516 f7            	ld	(x),a
1406                     ; 195     for (w = 0; w < decPlace; w++)
1408  0517 0f19          	clr	(OFST+0,sp)
1411  0519 201e          	jra	L303
1412  051b               L772:
1413                     ; 197         temp2[w] = temp1[w];
1415  051b 96            	ldw	x,sp
1416  051c 1c0008        	addw	x,#OFST-17
1417  051f 9f            	ld	a,xl
1418  0520 5e            	swapw	x
1419  0521 1b19          	add	a,(OFST+0,sp)
1420  0523 2401          	jrnc	L041
1421  0525 5c            	incw	x
1422  0526               L041:
1423  0526 02            	rlwa	x,a
1424  0527 89            	pushw	x
1425  0528 96            	ldw	x,sp
1426  0529 1c0004        	addw	x,#OFST-21
1427  052c 9f            	ld	a,xl
1428  052d 5e            	swapw	x
1429  052e 1b1b          	add	a,(OFST+2,sp)
1430  0530 2401          	jrnc	L241
1431  0532 5c            	incw	x
1432  0533               L241:
1433  0533 02            	rlwa	x,a
1434  0534 f6            	ld	a,(x)
1435  0535 85            	popw	x
1436  0536 f7            	ld	(x),a
1437                     ; 195     for (w = 0; w < decPlace; w++)
1439  0537 0c19          	inc	(OFST+0,sp)
1441  0539               L303:
1444  0539 7b19          	ld	a,(OFST+0,sp)
1445  053b 1118          	cp	a,(OFST-1,sp)
1446  053d 25dc          	jrult	L772
1447                     ; 199     f = decPlace + 1;
1449  053f 7b18          	ld	a,(OFST-1,sp)
1450  0541 4c            	inc	a
1451  0542 6b18          	ld	(OFST-1,sp),a
1453                     ; 200     for (w = f; w <= temp1Length; w++)
1455  0544 7b18          	ld	a,(OFST-1,sp)
1456  0546 6b19          	ld	(OFST+0,sp),a
1459  0548 2023          	jra	L313
1460  054a               L703:
1461                     ; 202         u = w - 1;
1463  054a 7b19          	ld	a,(OFST+0,sp)
1464  054c 4a            	dec	a
1465  054d 6b18          	ld	(OFST-1,sp),a
1467                     ; 203         temp2[w] = temp1[u];
1469  054f 96            	ldw	x,sp
1470  0550 1c0008        	addw	x,#OFST-17
1471  0553 9f            	ld	a,xl
1472  0554 5e            	swapw	x
1473  0555 1b19          	add	a,(OFST+0,sp)
1474  0557 2401          	jrnc	L441
1475  0559 5c            	incw	x
1476  055a               L441:
1477  055a 02            	rlwa	x,a
1478  055b 89            	pushw	x
1479  055c 96            	ldw	x,sp
1480  055d 1c0004        	addw	x,#OFST-21
1481  0560 9f            	ld	a,xl
1482  0561 5e            	swapw	x
1483  0562 1b1a          	add	a,(OFST+1,sp)
1484  0564 2401          	jrnc	L641
1485  0566 5c            	incw	x
1486  0567               L641:
1487  0567 02            	rlwa	x,a
1488  0568 f6            	ld	a,(x)
1489  0569 85            	popw	x
1490  056a f7            	ld	(x),a
1491                     ; 200     for (w = f; w <= temp1Length; w++)
1493  056b 0c19          	inc	(OFST+0,sp)
1495  056d               L313:
1498  056d 7b19          	ld	a,(OFST+0,sp)
1499  056f 1101          	cp	a,(OFST-24,sp)
1500  0571 23d7          	jrule	L703
1501                     ; 205     temp2[w] = '\0';
1503  0573 96            	ldw	x,sp
1504  0574 1c0008        	addw	x,#OFST-17
1505  0577 9f            	ld	a,xl
1506  0578 5e            	swapw	x
1507  0579 1b19          	add	a,(OFST+0,sp)
1508  057b 2401          	jrnc	L051
1509  057d 5c            	incw	x
1510  057e               L051:
1511  057e 02            	rlwa	x,a
1512  057f 7f            	clr	(x)
1513                     ; 207     strcat(informationString, temp2);
1515  0580 96            	ldw	x,sp
1516  0581 1c0008        	addw	x,#OFST-17
1517  0584 89            	pushw	x
1518  0585 1e1c          	ldw	x,(OFST+3,sp)
1519  0587 cd0000        	call	_strcat
1521  058a 85            	popw	x
1522                     ; 208     strcat(informationString, ",");
1524  058b ae0002        	ldw	x,#L531
1525  058e 89            	pushw	x
1526  058f 1e1c          	ldw	x,(OFST+3,sp)
1527  0591 cd0000        	call	_strcat
1529  0594 85            	popw	x
1530                     ; 210     sprintf(temp1, "%d", 7891);
1532  0595 ae1ed3        	ldw	x,#7891
1533  0598 89            	pushw	x
1534  0599 ae0006        	ldw	x,#L111
1535  059c 89            	pushw	x
1536  059d 96            	ldw	x,sp
1537  059e 1c0006        	addw	x,#OFST-19
1538  05a1 cd0000        	call	_sprintf
1540  05a4 5b04          	addw	sp,#4
1541                     ; 211     temp1Length = strlen(temp1);
1543  05a6 96            	ldw	x,sp
1544  05a7 1c0002        	addw	x,#OFST-23
1545  05aa cd0000        	call	_strlen
1547  05ad 01            	rrwa	x,a
1548  05ae 6b01          	ld	(OFST-24,sp),a
1549  05b0 02            	rlwa	x,a
1551                     ; 212     decPlace = temp1Length - 2;
1553  05b1 7b01          	ld	a,(OFST-24,sp)
1554  05b3 a002          	sub	a,#2
1555  05b5 6b18          	ld	(OFST-1,sp),a
1557                     ; 213     temp2[decPlace] = '.';
1559  05b7 96            	ldw	x,sp
1560  05b8 1c0008        	addw	x,#OFST-17
1561  05bb 9f            	ld	a,xl
1562  05bc 5e            	swapw	x
1563  05bd 1b18          	add	a,(OFST-1,sp)
1564  05bf 2401          	jrnc	L251
1565  05c1 5c            	incw	x
1566  05c2               L251:
1567  05c2 02            	rlwa	x,a
1568  05c3 a62e          	ld	a,#46
1569  05c5 f7            	ld	(x),a
1570                     ; 214     for (w = 0; w < decPlace; w++)
1572  05c6 0f19          	clr	(OFST+0,sp)
1575  05c8 201e          	jra	L323
1576  05ca               L713:
1577                     ; 216         temp2[w] = temp1[w];
1579  05ca 96            	ldw	x,sp
1580  05cb 1c0008        	addw	x,#OFST-17
1581  05ce 9f            	ld	a,xl
1582  05cf 5e            	swapw	x
1583  05d0 1b19          	add	a,(OFST+0,sp)
1584  05d2 2401          	jrnc	L451
1585  05d4 5c            	incw	x
1586  05d5               L451:
1587  05d5 02            	rlwa	x,a
1588  05d6 89            	pushw	x
1589  05d7 96            	ldw	x,sp
1590  05d8 1c0004        	addw	x,#OFST-21
1591  05db 9f            	ld	a,xl
1592  05dc 5e            	swapw	x
1593  05dd 1b1b          	add	a,(OFST+2,sp)
1594  05df 2401          	jrnc	L651
1595  05e1 5c            	incw	x
1596  05e2               L651:
1597  05e2 02            	rlwa	x,a
1598  05e3 f6            	ld	a,(x)
1599  05e4 85            	popw	x
1600  05e5 f7            	ld	(x),a
1601                     ; 214     for (w = 0; w < decPlace; w++)
1603  05e6 0c19          	inc	(OFST+0,sp)
1605  05e8               L323:
1608  05e8 7b19          	ld	a,(OFST+0,sp)
1609  05ea 1118          	cp	a,(OFST-1,sp)
1610  05ec 25dc          	jrult	L713
1611                     ; 218     f = decPlace + 1;
1613  05ee 7b18          	ld	a,(OFST-1,sp)
1614  05f0 4c            	inc	a
1615  05f1 6b18          	ld	(OFST-1,sp),a
1617                     ; 219     for (w = f; w <= temp1Length; w++)
1619  05f3 7b18          	ld	a,(OFST-1,sp)
1620  05f5 6b19          	ld	(OFST+0,sp),a
1623  05f7 2023          	jra	L333
1624  05f9               L723:
1625                     ; 221         u = w - 1;
1627  05f9 7b19          	ld	a,(OFST+0,sp)
1628  05fb 4a            	dec	a
1629  05fc 6b18          	ld	(OFST-1,sp),a
1631                     ; 222         temp2[w] = temp1[u];
1633  05fe 96            	ldw	x,sp
1634  05ff 1c0008        	addw	x,#OFST-17
1635  0602 9f            	ld	a,xl
1636  0603 5e            	swapw	x
1637  0604 1b19          	add	a,(OFST+0,sp)
1638  0606 2401          	jrnc	L061
1639  0608 5c            	incw	x
1640  0609               L061:
1641  0609 02            	rlwa	x,a
1642  060a 89            	pushw	x
1643  060b 96            	ldw	x,sp
1644  060c 1c0004        	addw	x,#OFST-21
1645  060f 9f            	ld	a,xl
1646  0610 5e            	swapw	x
1647  0611 1b1a          	add	a,(OFST+1,sp)
1648  0613 2401          	jrnc	L261
1649  0615 5c            	incw	x
1650  0616               L261:
1651  0616 02            	rlwa	x,a
1652  0617 f6            	ld	a,(x)
1653  0618 85            	popw	x
1654  0619 f7            	ld	(x),a
1655                     ; 219     for (w = f; w <= temp1Length; w++)
1657  061a 0c19          	inc	(OFST+0,sp)
1659  061c               L333:
1662  061c 7b19          	ld	a,(OFST+0,sp)
1663  061e 1101          	cp	a,(OFST-24,sp)
1664  0620 23d7          	jrule	L723
1665                     ; 224     temp2[w] = '\0';
1667  0622 96            	ldw	x,sp
1668  0623 1c0008        	addw	x,#OFST-17
1669  0626 9f            	ld	a,xl
1670  0627 5e            	swapw	x
1671  0628 1b19          	add	a,(OFST+0,sp)
1672  062a 2401          	jrnc	L461
1673  062c 5c            	incw	x
1674  062d               L461:
1675  062d 02            	rlwa	x,a
1676  062e 7f            	clr	(x)
1677                     ; 226     strcat(informationString, temp2);
1679  062f 96            	ldw	x,sp
1680  0630 1c0008        	addw	x,#OFST-17
1681  0633 89            	pushw	x
1682  0634 1e1c          	ldw	x,(OFST+3,sp)
1683  0636 cd0000        	call	_strcat
1685  0639 85            	popw	x
1686                     ; 227     strcat(informationString, "}");
1688  063a ae0000        	ldw	x,#L733
1689  063d 89            	pushw	x
1690  063e 1e1c          	ldw	x,(OFST+3,sp)
1691  0640 cd0000        	call	_strcat
1693  0643 85            	popw	x
1694                     ; 228     stringLength = strlen(informationString);
1696  0644 1e1a          	ldw	x,(OFST+1,sp)
1697  0646 cd0000        	call	_strlen
1699  0649 01            	rrwa	x,a
1700  064a 6b01          	ld	(OFST-24,sp),a
1701  064c 02            	rlwa	x,a
1703                     ; 229     return (stringLength);
1705  064d 7b01          	ld	a,(OFST-24,sp)
1706  064f 5f            	clrw	x
1707  0650 97            	ld	xl,a
1710  0651 5b1b          	addw	sp,#27
1711  0653 81            	ret
1724                     	xdef	_sendDataToCloud
1725                     	xdef	_createStringToSend
1726                     	xref	_sprintf
1727                     	xref	_strlen
1728                     	xref	_strcat
1729                     .const:	section	.text
1730  0000               L733:
1731  0000 7d00          	dc.b	"}",0
1732  0002               L531:
1733  0002 2c00          	dc.b	",",0
1734  0004               L331:
1735  0004 7b00          	dc.b	"{",0
1736  0006               L111:
1737  0006 256400        	dc.b	"%d",0
1757                     	end
