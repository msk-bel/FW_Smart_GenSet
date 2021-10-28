   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _checkit:
  16  0000 00            	dc.b	0
  55                     ; 54 void systemInit(void)
  55                     ; 55 {
  57                     	switch	.text
  58  0000               _systemInit:
  62                     ; 56 	clockSetup();
  64  0000 ad28          	call	_clockSetup
  66                     ; 57 	EEPROMSetup();
  68  0002 cd0244        	call	_EEPROMSetup
  70                     ; 58 	getCalibration();
  72  0005 cd02bc        	call	_getCalibration
  74                     ; 60 	SetPortD7AsTim1_Ch4();
  76  0008 cd03be        	call	_SetPortD7AsTim1_Ch4
  78                     ; 62 	gpioSetup();
  80  000b cd0091        	call	_gpioSetup
  82                     ; 63 	timer2Setup();
  84  000e cd0166        	call	_timer2Setup
  86                     ; 64 	timer1Setup();
  88  0011 cd01a7        	call	_timer1Setup
  90                     ; 65 	ADCSetup();
  92  0014 cd0353        	call	_ADCSetup
  94                     ; 66 	UARTSetup(uartBaudRate, MEVRIS_UART_PARITY_NONE);
  96  0017 4b00          	push	#0
  97  0019 aec200        	ldw	x,#49664
  98  001c 89            	pushw	x
  99  001d ae0001        	ldw	x,#1
 100  0020 89            	pushw	x
 101  0021 cd0373        	call	_UARTSetup
 103  0024 5b05          	addw	sp,#5
 104                     ; 67 	EXTI_setup();
 106  0026 cd022c        	call	_EXTI_setup
 108                     ; 69 }
 111  0029 81            	ret
 144                     ; 85 void clockSetup(void)
 144                     ; 86 {
 145                     	switch	.text
 146  002a               _clockSetup:
 150                     ; 87 	CLK_DeInit();
 152  002a cd0000        	call	_CLK_DeInit
 154                     ; 88 	CLK_HSECmd(DISABLE); /* Disable High Speed External clock signal */
 156  002d 4f            	clr	a
 157  002e cd0000        	call	_CLK_HSECmd
 159                     ; 89 	CLK_LSICmd(DISABLE); /* Disable Low Speed Internal clock signal */
 161  0031 4f            	clr	a
 162  0032 cd0000        	call	_CLK_LSICmd
 164                     ; 90 	CLK_HSICmd(ENABLE);	 /* Enable high speed internal clock signal  */
 166  0035 a601          	ld	a,#1
 167  0037 cd0000        	call	_CLK_HSICmd
 170  003a               L33:
 171                     ; 92 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE)
 173  003a ae0102        	ldw	x,#258
 174  003d cd0000        	call	_CLK_GetFlagStatus
 176  0040 4d            	tnz	a
 177  0041 27f7          	jreq	L33
 178                     ; 97 	CLK_ClockSwitchCmd(ENABLE);
 180  0043 a601          	ld	a,#1
 181  0045 cd0000        	call	_CLK_ClockSwitchCmd
 183                     ; 98 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 185  0048 4f            	clr	a
 186  0049 cd0000        	call	_CLK_HSIPrescalerConfig
 188                     ; 99 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 190  004c a680          	ld	a,#128
 191  004e cd0000        	call	_CLK_SYSCLKConfig
 193                     ; 100 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE); /* Select HSI as master clock source */
 195  0051 4b01          	push	#1
 196  0053 4b00          	push	#0
 197  0055 ae01e1        	ldw	x,#481
 198  0058 cd0000        	call	_CLK_ClockSwitchConfig
 200  005b 85            	popw	x
 201                     ; 101 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 203  005c ae0100        	ldw	x,#256
 204  005f cd0000        	call	_CLK_PeripheralClockConfig
 206                     ; 102 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 208  0062 5f            	clrw	x
 209  0063 cd0000        	call	_CLK_PeripheralClockConfig
 211                     ; 103 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 213  0066 ae1301        	ldw	x,#4865
 214  0069 cd0000        	call	_CLK_PeripheralClockConfig
 216                     ; 104 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 218  006c ae1200        	ldw	x,#4608
 219  006f cd0000        	call	_CLK_PeripheralClockConfig
 221                     ; 105 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, DISABLE);
 223  0072 ae0600        	ldw	x,#1536
 224  0075 cd0000        	call	_CLK_PeripheralClockConfig
 226                     ; 106 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 228  0078 ae0400        	ldw	x,#1024
 229  007b cd0000        	call	_CLK_PeripheralClockConfig
 231                     ; 107 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 233  007e ae0201        	ldw	x,#513
 234  0081 cd0000        	call	_CLK_PeripheralClockConfig
 236                     ; 108 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 238  0084 ae0701        	ldw	x,#1793
 239  0087 cd0000        	call	_CLK_PeripheralClockConfig
 241                     ; 109 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 243  008a ae0501        	ldw	x,#1281
 244  008d cd0000        	call	_CLK_PeripheralClockConfig
 246                     ; 110 }
 249  0090 81            	ret
 275                     ; 132 void gpioSetup(void)
 275                     ; 133 {
 276                     	switch	.text
 277  0091               _gpioSetup:
 281                     ; 134 	GPIO_DeInit(GPIOD);											   // Deinitialize Port D
 283  0091 ae500f        	ldw	x,#20495
 284  0094 cd0000        	call	_GPIO_DeInit
 286                     ; 135 	GPIO_DeInit(GPIOC);											   // Deinitialize Port C
 288  0097 ae500a        	ldw	x,#20490
 289  009a cd0000        	call	_GPIO_DeInit
 291                     ; 136 	GPIO_DeInit(GPIOA);											   // Deinitialize Port A
 293  009d ae5000        	ldw	x,#20480
 294  00a0 cd0000        	call	_GPIO_DeInit
 296                     ; 137 	GPIO_Init(txPin, GPIO_MODE_OUT_PP_HIGH_FAST);				   // Tx pin MAX232
 298  00a3 4bf0          	push	#240
 299  00a5 4b20          	push	#32
 300  00a7 ae500f        	ldw	x,#20495
 301  00aa cd0000        	call	_GPIO_Init
 303  00ad 85            	popw	x
 304                     ; 138 	GPIO_Init(rxPin, GPIO_MODE_IN_PU_NO_IT);					   // Rx pin MAX232
 306  00ae 4b40          	push	#64
 307  00b0 4b40          	push	#64
 308  00b2 ae500f        	ldw	x,#20495
 309  00b5 cd0000        	call	_GPIO_Init
 311  00b8 85            	popw	x
 312                     ; 139 	GPIO_Init(PWRKEY, GPIO_MODE_OUT_PP_LOW_FAST);				   // SIMCom module power pin
 314  00b9 4be0          	push	#224
 315  00bb 4b20          	push	#32
 316  00bd ae500a        	ldw	x,#20490
 317  00c0 cd0000        	call	_GPIO_Init
 319  00c3 85            	popw	x
 320                     ; 141 	GPIO_WriteHigh(PWRKEY);
 322  00c4 4b20          	push	#32
 323  00c6 ae500a        	ldw	x,#20490
 324  00c9 cd0000        	call	_GPIO_WriteHigh
 326  00cc 84            	pop	a
 327                     ; 143 	GPIO_Init(currentVoltSelectionPin, GPIO_MODE_OUT_PP_LOW_FAST); // current and volt selection pin in PUSH-PULL Mode
 329  00cd 4be0          	push	#224
 330  00cf 4b04          	push	#4
 331  00d1 ae500f        	ldw	x,#20495
 332  00d4 cd0000        	call	_GPIO_Init
 334  00d7 85            	popw	x
 335                     ; 144 	GPIO_WriteHigh(currentVoltSelectionPin);					   // initially select voltage 1=Voltage & 0=Current
 337  00d8 4b04          	push	#4
 338  00da ae500f        	ldw	x,#20495
 339  00dd cd0000        	call	_GPIO_WriteHigh
 341  00e0 84            	pop	a
 342                     ; 145 	GPIO_Init(currentVoltFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 1 pin
 344  00e1 4b40          	push	#64
 345  00e3 4b04          	push	#4
 346  00e5 ae500a        	ldw	x,#20490
 347  00e8 cd0000        	call	_GPIO_Init
 349  00eb 85            	popw	x
 350                     ; 146 	GPIO_Init(currentVoltFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 2 pin
 352  00ec 4b40          	push	#64
 353  00ee 4b80          	push	#128
 354  00f0 ae500f        	ldw	x,#20495
 355  00f3 cd0000        	call	_GPIO_Init
 357  00f6 85            	popw	x
 358                     ; 147 	GPIO_Init(currentVoltFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 3 pin
 360  00f7 4b40          	push	#64
 361  00f9 4b08          	push	#8
 362  00fb ae500f        	ldw	x,#20495
 363  00fe cd0000        	call	_GPIO_Init
 365  0101 85            	popw	x
 366                     ; 148 	GPIO_Init(powerFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 1 pin
 368  0102 4b40          	push	#64
 369  0104 4b02          	push	#2
 370  0106 ae500a        	ldw	x,#20490
 371  0109 cd0000        	call	_GPIO_Init
 373  010c 85            	popw	x
 374                     ; 149 	GPIO_Init(powerFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 2 pin
 376  010d 4b40          	push	#64
 377  010f 4b08          	push	#8
 378  0111 ae500a        	ldw	x,#20490
 379  0114 cd0000        	call	_GPIO_Init
 381  0117 85            	popw	x
 382                     ; 150 	GPIO_Init(powerFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 3 pin
 384  0118 4b40          	push	#64
 385  011a 4b10          	push	#16
 386  011c ae500f        	ldw	x,#20495
 387  011f cd0000        	call	_GPIO_Init
 389  0122 85            	popw	x
 390                     ; 151 	GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 392  0123 4be0          	push	#224
 393  0125 4b04          	push	#4
 394  0127 ae5000        	ldw	x,#20480
 395  012a cd0000        	call	_GPIO_Init
 397  012d 85            	popw	x
 398                     ; 152 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 400  012e 4be0          	push	#224
 401  0130 4b02          	push	#2
 402  0132 ae5000        	ldw	x,#20480
 403  0135 cd0000        	call	_GPIO_Init
 405  0138 85            	popw	x
 406                     ; 153 	GPIO_Init(RingIndicatorPin, GPIO_MODE_IN_FL_IT);			   //Ring Indicator interrupt
 408  0139 4b20          	push	#32
 409  013b 4b01          	push	#1
 410  013d ae500f        	ldw	x,#20495
 411  0140 cd0000        	call	_GPIO_Init
 413  0143 85            	popw	x
 414                     ; 154 	GPIO_Init(BatteryVoltagePin, GPIO_MODE_IN_FL_NO_IT);		   //Battery Voltage read pin
 416  0144 4b00          	push	#0
 417  0146 4b40          	push	#64
 418  0148 ae5005        	ldw	x,#20485
 419  014b cd0000        	call	_GPIO_Init
 421  014e 85            	popw	x
 422                     ; 155 	GPIO_Init(Temp1Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 1 read pin
 424  014f 4b00          	push	#0
 425  0151 4b04          	push	#4
 426  0153 ae5005        	ldw	x,#20485
 427  0156 cd0000        	call	_GPIO_Init
 429  0159 85            	popw	x
 430                     ; 156 	GPIO_Init(Temp2Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 2 read pin
 432  015a 4b00          	push	#0
 433  015c 4b02          	push	#2
 434  015e ae5005        	ldw	x,#20485
 435  0161 cd0000        	call	_GPIO_Init
 437  0164 85            	popw	x
 438                     ; 157 }
 441  0165 81            	ret
 470                     ; 177 void timer2Setup(void)
 470                     ; 178 {
 471                     	switch	.text
 472  0166               _timer2Setup:
 476                     ; 179 	TIM2_DeInit();																							/* Deinitialize Timer 2 */
 478  0166 cd0000        	call	_TIM2_DeInit
 480                     ; 180 	TIM2_TimeBaseInit(timer2Prescaler, timer2MaxCount);														/* Timer2 : time base generation */
 482  0169 aeffff        	ldw	x,#65535
 483  016c 89            	pushw	x
 484  016d a603          	ld	a,#3
 485  016f cd0000        	call	_TIM2_TimeBaseInit
 487  0172 85            	popw	x
 488                     ; 181 	TIM2_ICInit(TIM2_CHANNEL_1, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 490  0173 4b00          	push	#0
 491  0175 4b00          	push	#0
 492  0177 4b01          	push	#1
 493  0179 ae0044        	ldw	x,#68
 494  017c cd0000        	call	_TIM2_ICInit
 496  017f 5b03          	addw	sp,#3
 497                     ; 182 	TIM2_ICInit(TIM2_CHANNEL_2, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 499  0181 4b00          	push	#0
 500  0183 4b00          	push	#0
 501  0185 4b01          	push	#1
 502  0187 ae0144        	ldw	x,#324
 503  018a cd0000        	call	_TIM2_ICInit
 505  018d 5b03          	addw	sp,#3
 506                     ; 183 	TIM2_CCxCmd(TIM2_CHANNEL_1, ENABLE);																	/* Enable Timer 2 Capture Compare Channel 1 */
 508  018f ae0001        	ldw	x,#1
 509  0192 cd0000        	call	_TIM2_CCxCmd
 511                     ; 184 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);																	/* Timer 2 overflow interrupt enable */
 513  0195 ae0101        	ldw	x,#257
 514  0198 cd0000        	call	_TIM2_ITConfig
 516                     ; 185 	TIM2_ITConfig(TIM2_IT_CC1, ENABLE);																		/* Timer 1 input capture channel 3 interrupt enable */
 518  019b ae0201        	ldw	x,#513
 519  019e cd0000        	call	_TIM2_ITConfig
 521                     ; 186 	TIM2_Cmd(ENABLE);
 523  01a1 a601          	ld	a,#1
 524  01a3 cd0000        	call	_TIM2_Cmd
 526                     ; 187 }
 529  01a6 81            	ret
 558                     ; 212 void timer1Setup(void)
 558                     ; 213 {
 559                     	switch	.text
 560  01a7               _timer1Setup:
 564                     ; 214 	TIM1_DeInit();																							/* Deinitialize Timer 1 */
 566  01a7 cd0000        	call	_TIM1_DeInit
 568                     ; 215 	TIM1_TimeBaseInit(timer1Prescaler, TIM1_COUNTERMODE_UP, timer1MaxCount, timer1Repeat);					/* Timer1 : time base generation */
 570  01aa 4b00          	push	#0
 571  01ac aeffff        	ldw	x,#65535
 572  01af 89            	pushw	x
 573  01b0 4b00          	push	#0
 574  01b2 ae0007        	ldw	x,#7
 575  01b5 cd0000        	call	_TIM1_TimeBaseInit
 577  01b8 5b04          	addw	sp,#4
 578                     ; 216 	TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 580  01ba 4b00          	push	#0
 581  01bc 4b00          	push	#0
 582  01be 4b01          	push	#1
 583  01c0 ae0001        	ldw	x,#1
 584  01c3 cd0000        	call	_TIM1_ICInit
 586  01c6 5b03          	addw	sp,#3
 587                     ; 217 	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 589  01c8 4b00          	push	#0
 590  01ca 4b00          	push	#0
 591  01cc 4b01          	push	#1
 592  01ce ae0101        	ldw	x,#257
 593  01d1 cd0000        	call	_TIM1_ICInit
 595  01d4 5b03          	addw	sp,#3
 596                     ; 218 	TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 598  01d6 4b00          	push	#0
 599  01d8 4b00          	push	#0
 600  01da 4b01          	push	#1
 601  01dc ae0201        	ldw	x,#513
 602  01df cd0000        	call	_TIM1_ICInit
 604  01e2 5b03          	addw	sp,#3
 605                     ; 219 	TIM1_ICInit(TIM1_CHANNEL_4, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);	/* Initialize Input Capture Channel 3 */
 607  01e4 4b00          	push	#0
 608  01e6 4b00          	push	#0
 609  01e8 4b01          	push	#1
 610  01ea ae0300        	ldw	x,#768
 611  01ed cd0000        	call	_TIM1_ICInit
 613  01f0 5b03          	addw	sp,#3
 614                     ; 220 	TIM1_CCxCmd(TIM1_CHANNEL_1, ENABLE);																	/* Enable Timer 1 Capture Compare Channel 1 */
 616  01f2 ae0001        	ldw	x,#1
 617  01f5 cd0000        	call	_TIM1_CCxCmd
 619                     ; 221 	TIM1_CCxCmd(TIM1_CHANNEL_3, ENABLE);
 621  01f8 ae0201        	ldw	x,#513
 622  01fb cd0000        	call	_TIM1_CCxCmd
 624                     ; 223 	TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE); //Uncommented by Saqib																	/* Timer 1 overflow interrupt enable */
 626  01fe ae0101        	ldw	x,#257
 627  0201 cd0000        	call	_TIM1_ITConfig
 629                     ; 224 	TIM1_ITConfig(TIM1_IT_CC1, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */
 631  0204 ae0201        	ldw	x,#513
 632  0207 cd0000        	call	_TIM1_ITConfig
 634                     ; 225 	TIM1_ITConfig(TIM1_IT_CC3, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */
 636  020a ae0801        	ldw	x,#2049
 637  020d cd0000        	call	_TIM1_ITConfig
 639                     ; 227 	TIM1_Cmd(ENABLE); /* Enable Timer 1 */
 641  0210 a601          	ld	a,#1
 642  0212 cd0000        	call	_TIM1_Cmd
 644                     ; 228 }
 647  0215 81            	ret
 675                     ; 237 void IWDG_Config(void)
 675                     ; 238 {
 676                     	switch	.text
 677  0216               _IWDG_Config:
 681                     ; 239 	IWDG_Enable();
 683  0216 cd0000        	call	_IWDG_Enable
 685                     ; 241 	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
 687  0219 a655          	ld	a,#85
 688  021b cd0000        	call	_IWDG_WriteAccessCmd
 690                     ; 242 	IWDG_SetPrescaler(IWDG_Prescaler_256);
 692  021e a606          	ld	a,#6
 693  0220 cd0000        	call	_IWDG_SetPrescaler
 695                     ; 243 	IWDG_SetReload(0xFF);
 697  0223 a6ff          	ld	a,#255
 698  0225 cd0000        	call	_IWDG_SetReload
 700                     ; 244 	IWDG_ReloadCounter();
 702  0228 cd0000        	call	_IWDG_ReloadCounter
 704                     ; 245 }
 707  022b 81            	ret
 736                     ; 254 void EXTI_setup(void)
 736                     ; 255 {
 737                     	switch	.text
 738  022c               _EXTI_setup:
 742                     ; 256 	ITC_DeInit();
 744  022c cd0000        	call	_ITC_DeInit
 746                     ; 257 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
 748  022f ae0602        	ldw	x,#1538
 749  0232 cd0000        	call	_ITC_SetSoftwarePriority
 751                     ; 258 	EXTI_DeInit();
 753  0235 cd0000        	call	_EXTI_DeInit
 755                     ; 259 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 757  0238 ae0302        	ldw	x,#770
 758  023b cd0000        	call	_EXTI_SetExtIntSensitivity
 760                     ; 260 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
 762  023e 4f            	clr	a
 763  023f cd0000        	call	_EXTI_SetTLISensitivity
 765                     ; 261 	enableInterrupts();
 768  0242 9a            rim
 770                     ; 262 }
 774  0243 81            	ret
 798                     ; 271 void EEPROMSetup(void)
 798                     ; 272 {
 799                     	switch	.text
 800  0244               _EEPROMSetup:
 804                     ; 273 	FLASH_DeInit();
 806  0244 cd0000        	call	_FLASH_DeInit
 808                     ; 274 }
 811  0247 81            	ret
 855                     ; 276 uint16_t ReadFlashWord(uint32_t address)
 855                     ; 277 {
 856                     	switch	.text
 857  0248               _ReadFlashWord:
 859  0248 89            	pushw	x
 860       00000002      OFST:	set	2
 863                     ; 278 	uint16_t result = 0;
 865                     ; 279 	result = (FLASH_ReadByte(address+1) & 0x00FF);
 867  0249 96            	ldw	x,sp
 868  024a 1c0005        	addw	x,#OFST+3
 869  024d cd0000        	call	c_ltor
 871  0250 a601          	ld	a,#1
 872  0252 cd0000        	call	c_ladc
 874  0255 be02          	ldw	x,c_lreg+2
 875  0257 89            	pushw	x
 876  0258 be00          	ldw	x,c_lreg
 877  025a 89            	pushw	x
 878  025b cd0000        	call	_FLASH_ReadByte
 880  025e 5b04          	addw	sp,#4
 881  0260 5f            	clrw	x
 882  0261 97            	ld	xl,a
 883  0262 1f01          	ldw	(OFST-1,sp),x
 885                     ; 280 	result <<= 8;
 887  0264 7b02          	ld	a,(OFST+0,sp)
 888  0266 6b01          	ld	(OFST-1,sp),a
 889  0268 0f02          	clr	(OFST+0,sp)
 891                     ; 281 	result |= (FLASH_ReadByte(address) & 0x00FF);
 893  026a 1e07          	ldw	x,(OFST+5,sp)
 894  026c 89            	pushw	x
 895  026d 1e07          	ldw	x,(OFST+5,sp)
 896  026f 89            	pushw	x
 897  0270 cd0000        	call	_FLASH_ReadByte
 899  0273 5b04          	addw	sp,#4
 900  0275 5f            	clrw	x
 901  0276 97            	ld	xl,a
 902  0277 01            	rrwa	x,a
 903  0278 1a02          	or	a,(OFST+0,sp)
 904  027a 01            	rrwa	x,a
 905  027b 1a01          	or	a,(OFST-1,sp)
 906  027d 01            	rrwa	x,a
 907  027e 1f01          	ldw	(OFST-1,sp),x
 909                     ; 282 	return result;
 911  0280 1e01          	ldw	x,(OFST-1,sp)
 914  0282 5b02          	addw	sp,#2
 915  0284 81            	ret
 961                     ; 285 void WriteFlashWord(uint16_t data, uint32_t address)
 961                     ; 286 {
 962                     	switch	.text
 963  0285               _WriteFlashWord:
 965  0285 89            	pushw	x
 966       00000000      OFST:	set	0
 969                     ; 287 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 971  0286 a6f7          	ld	a,#247
 972  0288 cd0000        	call	_FLASH_Unlock
 974                     ; 288 		FLASH_ProgramByte(address, (data & 0xFF));
 976  028b 7b02          	ld	a,(OFST+2,sp)
 977  028d a4ff          	and	a,#255
 978  028f 88            	push	a
 979  0290 1e08          	ldw	x,(OFST+8,sp)
 980  0292 89            	pushw	x
 981  0293 1e08          	ldw	x,(OFST+8,sp)
 982  0295 89            	pushw	x
 983  0296 cd0000        	call	_FLASH_ProgramByte
 985  0299 5b05          	addw	sp,#5
 986                     ; 289 		FLASH_ProgramByte(address+1, ((data >> 8) & 0xFF));
 988  029b 7b01          	ld	a,(OFST+1,sp)
 989  029d 88            	push	a
 990  029e 96            	ldw	x,sp
 991  029f 1c0006        	addw	x,#OFST+6
 992  02a2 cd0000        	call	c_ltor
 994  02a5 a601          	ld	a,#1
 995  02a7 cd0000        	call	c_ladc
 997  02aa be02          	ldw	x,c_lreg+2
 998  02ac 89            	pushw	x
 999  02ad be00          	ldw	x,c_lreg
1000  02af 89            	pushw	x
1001  02b0 cd0000        	call	_FLASH_ProgramByte
1003  02b3 5b05          	addw	sp,#5
1004                     ; 290 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1006  02b5 a6f7          	ld	a,#247
1007  02b7 cd0000        	call	_FLASH_Lock
1009                     ; 291 }
1012  02ba 85            	popw	x
1013  02bb 81            	ret
1048                     ; 293 void getCalibration()
1048                     ; 294 {
1049                     	switch	.text
1050  02bc               _getCalibration:
1054                     ; 306 	checkByte = FLASH_ReadByte(CheckByte);
1056  02bc ae4025        	ldw	x,#16421
1057  02bf 89            	pushw	x
1058  02c0 ae0000        	ldw	x,#0
1059  02c3 89            	pushw	x
1060  02c4 cd0000        	call	_FLASH_ReadByte
1062  02c7 5b04          	addw	sp,#4
1063  02c9 b712          	ld	_checkByte,a
1064                     ; 307 	voltageCalibrationFactor1 	= ReadFlashWord(V1CabFab);
1066  02cb ae4000        	ldw	x,#16384
1067  02ce 89            	pushw	x
1068  02cf ae0000        	ldw	x,#0
1069  02d2 89            	pushw	x
1070  02d3 cd0248        	call	_ReadFlashWord
1072  02d6 5b04          	addw	sp,#4
1073  02d8 bf10          	ldw	_voltageCalibrationFactor1,x
1074                     ; 308 	voltageCalibrationFactor2 	= ReadFlashWord(V2CabFab);
1076  02da ae4004        	ldw	x,#16388
1077  02dd 89            	pushw	x
1078  02de ae0000        	ldw	x,#0
1079  02e1 89            	pushw	x
1080  02e2 cd0248        	call	_ReadFlashWord
1082  02e5 5b04          	addw	sp,#4
1083  02e7 bf0e          	ldw	_voltageCalibrationFactor2,x
1084                     ; 309 	voltageCalibrationFactor3 	= ReadFlashWord(V3CabFab);
1086  02e9 ae4008        	ldw	x,#16392
1087  02ec 89            	pushw	x
1088  02ed ae0000        	ldw	x,#0
1089  02f0 89            	pushw	x
1090  02f1 cd0248        	call	_ReadFlashWord
1092  02f4 5b04          	addw	sp,#4
1093  02f6 bf0c          	ldw	_voltageCalibrationFactor3,x
1094                     ; 310 	currentCalibrationFactor1 	= ReadFlashWord(I1CabFab);	currentCalibrationFactor2 	= ReadFlashWord(I2CabFab);
1096  02f8 ae400c        	ldw	x,#16396
1097  02fb 89            	pushw	x
1098  02fc ae0000        	ldw	x,#0
1099  02ff 89            	pushw	x
1100  0300 cd0248        	call	_ReadFlashWord
1102  0303 5b04          	addw	sp,#4
1103  0305 bf0a          	ldw	_currentCalibrationFactor1,x
1106  0307 ae4010        	ldw	x,#16400
1107  030a 89            	pushw	x
1108  030b ae0000        	ldw	x,#0
1109  030e 89            	pushw	x
1110  030f cd0248        	call	_ReadFlashWord
1112  0312 5b04          	addw	sp,#4
1113  0314 bf08          	ldw	_currentCalibrationFactor2,x
1114                     ; 311 	currentCalibrationFactor3 	= ReadFlashWord(I3CabFab);
1116  0316 ae4014        	ldw	x,#16404
1117  0319 89            	pushw	x
1118  031a ae0000        	ldw	x,#0
1119  031d 89            	pushw	x
1120  031e cd0248        	call	_ReadFlashWord
1122  0321 5b04          	addw	sp,#4
1123  0323 bf06          	ldw	_currentCalibrationFactor3,x
1124                     ; 312 	powerCalibrationFactor1 	= ReadFlashWord(P1CabFab);
1126  0325 ae4018        	ldw	x,#16408
1127  0328 89            	pushw	x
1128  0329 ae0000        	ldw	x,#0
1129  032c 89            	pushw	x
1130  032d cd0248        	call	_ReadFlashWord
1132  0330 5b04          	addw	sp,#4
1133  0332 bf04          	ldw	_powerCalibrationFactor1,x
1134                     ; 313 	powerCalibrationFactor2 	= ReadFlashWord(P2CabFab);
1136  0334 ae401c        	ldw	x,#16412
1137  0337 89            	pushw	x
1138  0338 ae0000        	ldw	x,#0
1139  033b 89            	pushw	x
1140  033c cd0248        	call	_ReadFlashWord
1142  033f 5b04          	addw	sp,#4
1143  0341 bf02          	ldw	_powerCalibrationFactor2,x
1144                     ; 314 	powerCalibrationFactor3 	= ReadFlashWord(P3CabFab);
1146  0343 ae4020        	ldw	x,#16416
1147  0346 89            	pushw	x
1148  0347 ae0000        	ldw	x,#0
1149  034a 89            	pushw	x
1150  034b cd0248        	call	_ReadFlashWord
1152  034e 5b04          	addw	sp,#4
1153  0350 bf00          	ldw	_powerCalibrationFactor3,x
1154                     ; 315 }
1157  0352 81            	ret
1184                     ; 325 void ADCSetup(void)
1184                     ; 326 {
1185                     	switch	.text
1186  0353               _ADCSetup:
1190                     ; 327 	ADC2_DeInit();
1192  0353 cd0000        	call	_ADC2_DeInit
1194                     ; 328 	ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_0, ADC2_PRESSEL_FCPU_D8, ADC2_EXTTRIG_GPIO, DISABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL0, DISABLE);
1196  0356 4b00          	push	#0
1197  0358 4b00          	push	#0
1198  035a 4b08          	push	#8
1199  035c 4b00          	push	#0
1200  035e 4b01          	push	#1
1201  0360 4b40          	push	#64
1202  0362 5f            	clrw	x
1203  0363 cd0000        	call	_ADC2_Init
1205  0366 5b06          	addw	sp,#6
1206                     ; 329 	ADC2_SchmittTriggerConfig(ADC2_SCHMITTTRIG_ALL, DISABLE);
1208  0368 ae1f00        	ldw	x,#7936
1209  036b cd0000        	call	_ADC2_SchmittTriggerConfig
1211                     ; 330 	ADC2_ITConfig(DISABLE);
1213  036e 4f            	clr	a
1214  036f cd0000        	call	_ADC2_ITConfig
1216                     ; 331 }
1219  0372 81            	ret
1297                     ; 346 void UARTSetup(uint32_t baudRate, UARTCONFIG config)
1297                     ; 347 {
1298                     	switch	.text
1299  0373               _UARTSetup:
1301       00000000      OFST:	set	0
1304                     ; 348 	UART1_DeInit();
1306  0373 cd0000        	call	_UART1_DeInit
1308                     ; 350 	switch (config)
1310  0376 0d07          	tnz	(OFST+7,sp)
1311  0378 2617          	jrne	L502
1314  037a               L302:
1315                     ; 352 	case MEVRIS_UART_PARITY_NONE:
1315                     ; 353 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1315                     ; 354 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1317  037a 4b0c          	push	#12
1318  037c 4b80          	push	#128
1319  037e 4b00          	push	#0
1320  0380 4b00          	push	#0
1321  0382 4b00          	push	#0
1322  0384 1e0a          	ldw	x,(OFST+10,sp)
1323  0386 89            	pushw	x
1324  0387 1e0a          	ldw	x,(OFST+10,sp)
1325  0389 89            	pushw	x
1326  038a cd0000        	call	_UART1_Init
1328  038d 5b09          	addw	sp,#9
1329                     ; 355 		break;
1331  038f 2015          	jra	L542
1332  0391               L502:
1333                     ; 356 	default:
1333                     ; 357 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1333                     ; 358 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1335  0391 4b0c          	push	#12
1336  0393 4b80          	push	#128
1337  0395 4b00          	push	#0
1338  0397 4b00          	push	#0
1339  0399 4b00          	push	#0
1340  039b 1e0a          	ldw	x,(OFST+10,sp)
1341  039d 89            	pushw	x
1342  039e 1e0a          	ldw	x,(OFST+10,sp)
1343  03a0 89            	pushw	x
1344  03a1 cd0000        	call	_UART1_Init
1346  03a4 5b09          	addw	sp,#9
1347                     ; 359 		break;
1348  03a6               L542:
1349                     ; 362 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
1351  03a6 4b01          	push	#1
1352  03a8 ae0255        	ldw	x,#597
1353  03ab cd0000        	call	_UART1_ITConfig
1355  03ae 84            	pop	a
1356                     ; 363 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
1358  03af 4b01          	push	#1
1359  03b1 ae0244        	ldw	x,#580
1360  03b4 cd0000        	call	_UART1_ITConfig
1362  03b7 84            	pop	a
1363                     ; 364 	UART1_Cmd(ENABLE);
1365  03b8 a601          	ld	a,#1
1366  03ba cd0000        	call	_UART1_Cmd
1368                     ; 365 }
1371  03bd 81            	ret
1411                     ; 377 void SetPortD7AsTim1_Ch4(void)
1411                     ; 378 {
1412                     	switch	.text
1413  03be               _SetPortD7AsTim1_Ch4:
1415  03be 89            	pushw	x
1416       00000002      OFST:	set	2
1419                     ; 380 	OPT2_status = FLASH_ReadOptionByte(OP2_Address);
1421  03bf ae4803        	ldw	x,#18435
1422  03c2 cd0000        	call	_FLASH_ReadOptionByte
1424  03c5 1f01          	ldw	(OFST-1,sp),x
1426                     ; 381 	if ((OPT2_status & 0x1000) == 0)
1428  03c7 7b01          	ld	a,(OFST-1,sp)
1429  03c9 a510          	bcp	a,#16
1430  03cb 2622          	jrne	L762
1431                     ; 383 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1433  03cd a6f7          	ld	a,#247
1434  03cf cd0000        	call	_FLASH_Unlock
1436                     ; 384 		delay_ms(100);
1438  03d2 ae0064        	ldw	x,#100
1439  03d5 cd0000        	call	_delay_ms
1441                     ; 386 		FLASH_ProgramOptionByte(OP2_Address, (uint8_t)((uint8_t)(OPT2_status >> 8) | 0x10));
1443  03d8 7b01          	ld	a,(OFST-1,sp)
1444  03da aa10          	or	a,#16
1445  03dc 88            	push	a
1446  03dd ae4803        	ldw	x,#18435
1447  03e0 cd0000        	call	_FLASH_ProgramOptionByte
1449  03e3 84            	pop	a
1450                     ; 387 		delay_ms(100);
1452  03e4 ae0064        	ldw	x,#100
1453  03e7 cd0000        	call	_delay_ms
1455                     ; 388 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1457  03ea a6f7          	ld	a,#247
1458  03ec cd0000        	call	_FLASH_Lock
1460  03ef               L762:
1461                     ; 391 }
1464  03ef 85            	popw	x
1465  03f0 81            	ret
1609                     	xdef	_IWDG_Config
1610                     	switch	.ubsct
1611  0000               _powerCalibrationFactor3:
1612  0000 0000          	ds.b	2
1613                     	xdef	_powerCalibrationFactor3
1614  0002               _powerCalibrationFactor2:
1615  0002 0000          	ds.b	2
1616                     	xdef	_powerCalibrationFactor2
1617  0004               _powerCalibrationFactor1:
1618  0004 0000          	ds.b	2
1619                     	xdef	_powerCalibrationFactor1
1620  0006               _currentCalibrationFactor3:
1621  0006 0000          	ds.b	2
1622                     	xdef	_currentCalibrationFactor3
1623  0008               _currentCalibrationFactor2:
1624  0008 0000          	ds.b	2
1625                     	xdef	_currentCalibrationFactor2
1626  000a               _currentCalibrationFactor1:
1627  000a 0000          	ds.b	2
1628                     	xdef	_currentCalibrationFactor1
1629  000c               _voltageCalibrationFactor3:
1630  000c 0000          	ds.b	2
1631                     	xdef	_voltageCalibrationFactor3
1632  000e               _voltageCalibrationFactor2:
1633  000e 0000          	ds.b	2
1634                     	xdef	_voltageCalibrationFactor2
1635  0010               _voltageCalibrationFactor1:
1636  0010 0000          	ds.b	2
1637                     	xdef	_voltageCalibrationFactor1
1638  0012               _checkByte:
1639  0012 00            	ds.b	1
1640                     	xdef	_checkByte
1641                     	xdef	_ReadFlashWord
1642                     	xdef	_SetPortD7AsTim1_Ch4
1643                     	xdef	_checkit
1644                     	xdef	_WriteFlashWord
1645                     	xdef	_UARTSetup
1646                     	xdef	_ADCSetup
1647                     	xdef	_getCalibration
1648                     	xdef	_EXTI_setup
1649                     	xdef	_systemInit
1650                     	xdef	_EEPROMSetup
1651                     	xdef	_timer1Setup
1652                     	xdef	_timer2Setup
1653                     	xdef	_gpioSetup
1654                     	xdef	_clockSetup
1655                     	xref	_delay_ms
1656                     	xref	_FLASH_ProgramOptionByte
1657                     	xref	_FLASH_ReadOptionByte
1658                     	xref	_FLASH_ReadByte
1659                     	xref	_FLASH_ProgramByte
1660                     	xref	_FLASH_DeInit
1661                     	xref	_FLASH_Lock
1662                     	xref	_FLASH_Unlock
1663                     	xref	_ITC_SetSoftwarePriority
1664                     	xref	_ITC_DeInit
1665                     	xref	_EXTI_SetTLISensitivity
1666                     	xref	_EXTI_SetExtIntSensitivity
1667                     	xref	_EXTI_DeInit
1668                     	xref	_UART1_ITConfig
1669                     	xref	_UART1_Cmd
1670                     	xref	_UART1_Init
1671                     	xref	_UART1_DeInit
1672                     	xref	_TIM2_CCxCmd
1673                     	xref	_TIM2_ITConfig
1674                     	xref	_TIM2_Cmd
1675                     	xref	_TIM2_ICInit
1676                     	xref	_TIM2_TimeBaseInit
1677                     	xref	_TIM2_DeInit
1678                     	xref	_TIM1_CCxCmd
1679                     	xref	_TIM1_ITConfig
1680                     	xref	_TIM1_Cmd
1681                     	xref	_TIM1_ICInit
1682                     	xref	_TIM1_TimeBaseInit
1683                     	xref	_TIM1_DeInit
1684                     	xref	_IWDG_Enable
1685                     	xref	_IWDG_ReloadCounter
1686                     	xref	_IWDG_SetReload
1687                     	xref	_IWDG_SetPrescaler
1688                     	xref	_IWDG_WriteAccessCmd
1689                     	xref	_GPIO_WriteHigh
1690                     	xref	_GPIO_Init
1691                     	xref	_GPIO_DeInit
1692                     	xref	_CLK_GetFlagStatus
1693                     	xref	_CLK_SYSCLKConfig
1694                     	xref	_CLK_HSIPrescalerConfig
1695                     	xref	_CLK_ClockSwitchConfig
1696                     	xref	_CLK_PeripheralClockConfig
1697                     	xref	_CLK_ClockSwitchCmd
1698                     	xref	_CLK_LSICmd
1699                     	xref	_CLK_HSICmd
1700                     	xref	_CLK_HSECmd
1701                     	xref	_CLK_DeInit
1702                     	xref	_ADC2_SchmittTriggerConfig
1703                     	xref	_ADC2_ITConfig
1704                     	xref	_ADC2_Init
1705                     	xref	_ADC2_DeInit
1706                     	xref.b	c_lreg
1726                     	xref	c_ladc
1727                     	xref	c_ltor
1728                     	end
