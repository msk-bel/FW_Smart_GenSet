   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  14                     	bsct
  15  0000               _checkit:
  16  0000 00            	dc.b	0
  55                     ; 51 void systemInit(void)
  55                     ; 52 {
  57                     	switch	.text
  58  0000               _systemInit:
  62                     ; 54 	clockSetup();
  64  0000 ad28          	call	_clockSetup
  66                     ; 55 	EEPROMSetup();
  68  0002 cd023b        	call	_EEPROMSetup
  70                     ; 56 	getCalibration();
  72  0005 cd023f        	call	_getCalibration
  74                     ; 58 	SetPortD7AsTim1_Ch4();
  76  0008 cd0341        	call	_SetPortD7AsTim1_Ch4
  78                     ; 60 	gpioSetup();
  80  000b cd0091        	call	_gpioSetup
  82                     ; 61 	timer2Setup();
  84  000e cd015d        	call	_timer2Setup
  86                     ; 62 	timer1Setup();
  88  0011 cd019e        	call	_timer1Setup
  90                     ; 63 	ADCSetup();
  92  0014 cd02d6        	call	_ADCSetup
  94                     ; 64 	UARTSetup(uartBaudRate, MEVRIS_UART_PARITY_NONE);
  96  0017 4b00          	push	#0
  97  0019 ae2580        	ldw	x,#9600
  98  001c 89            	pushw	x
  99  001d ae0000        	ldw	x,#0
 100  0020 89            	pushw	x
 101  0021 cd02f6        	call	_UARTSetup
 103  0024 5b05          	addw	sp,#5
 104                     ; 65 	EXTI_setup();
 106  0026 cd0223        	call	_EXTI_setup
 108                     ; 68 }
 111  0029 81            	ret
 144                     ; 84 void clockSetup(void)
 144                     ; 85 {
 145                     	switch	.text
 146  002a               _clockSetup:
 150                     ; 86 	CLK_DeInit();
 152  002a cd0000        	call	_CLK_DeInit
 154                     ; 87 	CLK_HSECmd(DISABLE); /* Disable High Speed External clock signal */
 156  002d 4f            	clr	a
 157  002e cd0000        	call	_CLK_HSECmd
 159                     ; 88 	CLK_LSICmd(DISABLE); /* Disable Low Speed Internal clock signal */
 161  0031 4f            	clr	a
 162  0032 cd0000        	call	_CLK_LSICmd
 164                     ; 89 	CLK_HSICmd(ENABLE);	 /* Enable high speed internal clock signal  */
 166  0035 a601          	ld	a,#1
 167  0037 cd0000        	call	_CLK_HSICmd
 170  003a               L33:
 171                     ; 91 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE)
 173  003a ae0102        	ldw	x,#258
 174  003d cd0000        	call	_CLK_GetFlagStatus
 176  0040 4d            	tnz	a
 177  0041 27f7          	jreq	L33
 178                     ; 96 	CLK_ClockSwitchCmd(ENABLE);
 180  0043 a601          	ld	a,#1
 181  0045 cd0000        	call	_CLK_ClockSwitchCmd
 183                     ; 97 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 185  0048 4f            	clr	a
 186  0049 cd0000        	call	_CLK_HSIPrescalerConfig
 188                     ; 98 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 190  004c a680          	ld	a,#128
 191  004e cd0000        	call	_CLK_SYSCLKConfig
 193                     ; 99 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE); /* Select HSI as master clock source */
 195  0051 4b01          	push	#1
 196  0053 4b00          	push	#0
 197  0055 ae01e1        	ldw	x,#481
 198  0058 cd0000        	call	_CLK_ClockSwitchConfig
 200  005b 85            	popw	x
 201                     ; 100 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 203  005c ae0100        	ldw	x,#256
 204  005f cd0000        	call	_CLK_PeripheralClockConfig
 206                     ; 101 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 208  0062 5f            	clrw	x
 209  0063 cd0000        	call	_CLK_PeripheralClockConfig
 211                     ; 102 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 213  0066 ae1301        	ldw	x,#4865
 214  0069 cd0000        	call	_CLK_PeripheralClockConfig
 216                     ; 103 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 218  006c ae1200        	ldw	x,#4608
 219  006f cd0000        	call	_CLK_PeripheralClockConfig
 221                     ; 104 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, DISABLE);
 223  0072 ae0600        	ldw	x,#1536
 224  0075 cd0000        	call	_CLK_PeripheralClockConfig
 226                     ; 105 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 228  0078 ae0400        	ldw	x,#1024
 229  007b cd0000        	call	_CLK_PeripheralClockConfig
 231                     ; 106 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 233  007e ae0201        	ldw	x,#513
 234  0081 cd0000        	call	_CLK_PeripheralClockConfig
 236                     ; 107 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 238  0084 ae0701        	ldw	x,#1793
 239  0087 cd0000        	call	_CLK_PeripheralClockConfig
 241                     ; 108 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 243  008a ae0501        	ldw	x,#1281
 244  008d cd0000        	call	_CLK_PeripheralClockConfig
 246                     ; 109 }
 249  0090 81            	ret
 275                     ; 131 void gpioSetup(void)
 275                     ; 132 {
 276                     	switch	.text
 277  0091               _gpioSetup:
 281                     ; 133 	GPIO_DeInit(GPIOD);											   // Deinitialize Port D
 283  0091 ae500f        	ldw	x,#20495
 284  0094 cd0000        	call	_GPIO_DeInit
 286                     ; 134 	GPIO_DeInit(GPIOC);											   // Deinitialize Port C
 288  0097 ae500a        	ldw	x,#20490
 289  009a cd0000        	call	_GPIO_DeInit
 291                     ; 135 	GPIO_DeInit(GPIOA);											   // Deinitialize Port A
 293  009d ae5000        	ldw	x,#20480
 294  00a0 cd0000        	call	_GPIO_DeInit
 296                     ; 136 	GPIO_Init(txPin, GPIO_MODE_OUT_PP_HIGH_FAST);				   // Tx pin MAX232
 298  00a3 4bf0          	push	#240
 299  00a5 4b20          	push	#32
 300  00a7 ae500f        	ldw	x,#20495
 301  00aa cd0000        	call	_GPIO_Init
 303  00ad 85            	popw	x
 304                     ; 137 	GPIO_Init(rxPin, GPIO_MODE_IN_PU_NO_IT);					   // Rx pin MAX232
 306  00ae 4b40          	push	#64
 307  00b0 4b40          	push	#64
 308  00b2 ae500f        	ldw	x,#20495
 309  00b5 cd0000        	call	_GPIO_Init
 311  00b8 85            	popw	x
 312                     ; 138 	GPIO_Init(PWRKEY, GPIO_MODE_OUT_PP_LOW_FAST);				   // SIMCom module power pin
 314  00b9 4be0          	push	#224
 315  00bb 4b20          	push	#32
 316  00bd ae500a        	ldw	x,#20490
 317  00c0 cd0000        	call	_GPIO_Init
 319  00c3 85            	popw	x
 320                     ; 139 	GPIO_Init(currentVoltSelectionPin, GPIO_MODE_OUT_PP_LOW_FAST); // current and volt selection pin in PUSH-PULL Mode
 322  00c4 4be0          	push	#224
 323  00c6 4b04          	push	#4
 324  00c8 ae500f        	ldw	x,#20495
 325  00cb cd0000        	call	_GPIO_Init
 327  00ce 85            	popw	x
 328                     ; 140 	GPIO_WriteHigh(currentVoltSelectionPin);					   // initially select voltage 1=Voltage & 0=Current
 330  00cf 4b04          	push	#4
 331  00d1 ae500f        	ldw	x,#20495
 332  00d4 cd0000        	call	_GPIO_WriteHigh
 334  00d7 84            	pop	a
 335                     ; 141 	GPIO_Init(currentVoltFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 1 pin
 337  00d8 4b40          	push	#64
 338  00da 4b04          	push	#4
 339  00dc ae500a        	ldw	x,#20490
 340  00df cd0000        	call	_GPIO_Init
 342  00e2 85            	popw	x
 343                     ; 142 	GPIO_Init(currentVoltFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 2 pin
 345  00e3 4b40          	push	#64
 346  00e5 4b80          	push	#128
 347  00e7 ae500f        	ldw	x,#20495
 348  00ea cd0000        	call	_GPIO_Init
 350  00ed 85            	popw	x
 351                     ; 143 	GPIO_Init(currentVoltFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 3 pin
 353  00ee 4b40          	push	#64
 354  00f0 4b08          	push	#8
 355  00f2 ae500f        	ldw	x,#20495
 356  00f5 cd0000        	call	_GPIO_Init
 358  00f8 85            	popw	x
 359                     ; 144 	GPIO_Init(powerFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 1 pin
 361  00f9 4b40          	push	#64
 362  00fb 4b02          	push	#2
 363  00fd ae500a        	ldw	x,#20490
 364  0100 cd0000        	call	_GPIO_Init
 366  0103 85            	popw	x
 367                     ; 145 	GPIO_Init(powerFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 2 pin
 369  0104 4b40          	push	#64
 370  0106 4b08          	push	#8
 371  0108 ae500a        	ldw	x,#20490
 372  010b cd0000        	call	_GPIO_Init
 374  010e 85            	popw	x
 375                     ; 146 	GPIO_Init(powerFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 3 pin
 377  010f 4b40          	push	#64
 378  0111 4b10          	push	#16
 379  0113 ae500f        	ldw	x,#20495
 380  0116 cd0000        	call	_GPIO_Init
 382  0119 85            	popw	x
 383                     ; 147 	GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 385  011a 4be0          	push	#224
 386  011c 4b04          	push	#4
 387  011e ae5000        	ldw	x,#20480
 388  0121 cd0000        	call	_GPIO_Init
 390  0124 85            	popw	x
 391                     ; 148 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 393  0125 4be0          	push	#224
 394  0127 4b02          	push	#2
 395  0129 ae5000        	ldw	x,#20480
 396  012c cd0000        	call	_GPIO_Init
 398  012f 85            	popw	x
 399                     ; 149 	GPIO_Init(RingIndicatorPin, GPIO_MODE_IN_FL_IT);			   //Ring Indicator interrupt
 401  0130 4b20          	push	#32
 402  0132 4b01          	push	#1
 403  0134 ae500f        	ldw	x,#20495
 404  0137 cd0000        	call	_GPIO_Init
 406  013a 85            	popw	x
 407                     ; 150 	GPIO_Init(BatteryVoltagePin, GPIO_MODE_IN_FL_NO_IT);		   //Battery Voltage read pin
 409  013b 4b00          	push	#0
 410  013d 4b40          	push	#64
 411  013f ae5005        	ldw	x,#20485
 412  0142 cd0000        	call	_GPIO_Init
 414  0145 85            	popw	x
 415                     ; 151 	GPIO_Init(Temp1Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 1 read pin
 417  0146 4b00          	push	#0
 418  0148 4b04          	push	#4
 419  014a ae5005        	ldw	x,#20485
 420  014d cd0000        	call	_GPIO_Init
 422  0150 85            	popw	x
 423                     ; 152 	GPIO_Init(Temp2Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 2 read pin
 425  0151 4b00          	push	#0
 426  0153 4b02          	push	#2
 427  0155 ae5005        	ldw	x,#20485
 428  0158 cd0000        	call	_GPIO_Init
 430  015b 85            	popw	x
 431                     ; 153 }
 434  015c 81            	ret
 463                     ; 173 void timer2Setup(void)
 463                     ; 174 {
 464                     	switch	.text
 465  015d               _timer2Setup:
 469                     ; 175 	TIM2_DeInit();																							/* Deinitialize Timer 2 */
 471  015d cd0000        	call	_TIM2_DeInit
 473                     ; 176 	TIM2_TimeBaseInit(timer2Prescaler, timer2MaxCount);														/* Timer2 : time base generation */
 475  0160 aeffff        	ldw	x,#65535
 476  0163 89            	pushw	x
 477  0164 a603          	ld	a,#3
 478  0166 cd0000        	call	_TIM2_TimeBaseInit
 480  0169 85            	popw	x
 481                     ; 177 	TIM2_ICInit(TIM2_CHANNEL_1, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 483  016a 4b00          	push	#0
 484  016c 4b00          	push	#0
 485  016e 4b01          	push	#1
 486  0170 ae0044        	ldw	x,#68
 487  0173 cd0000        	call	_TIM2_ICInit
 489  0176 5b03          	addw	sp,#3
 490                     ; 178 	TIM2_ICInit(TIM2_CHANNEL_2, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 492  0178 4b00          	push	#0
 493  017a 4b00          	push	#0
 494  017c 4b01          	push	#1
 495  017e ae0144        	ldw	x,#324
 496  0181 cd0000        	call	_TIM2_ICInit
 498  0184 5b03          	addw	sp,#3
 499                     ; 179 	TIM2_CCxCmd(TIM2_CHANNEL_1, ENABLE);																	/* Enable Timer 2 Capture Compare Channel 1 */
 501  0186 ae0001        	ldw	x,#1
 502  0189 cd0000        	call	_TIM2_CCxCmd
 504                     ; 180 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);																	/* Timer 2 overflow interrupt enable */
 506  018c ae0101        	ldw	x,#257
 507  018f cd0000        	call	_TIM2_ITConfig
 509                     ; 181 	TIM2_ITConfig(TIM2_IT_CC1, ENABLE);																		/* Timer 1 input capture channel 3 interrupt enable */
 511  0192 ae0201        	ldw	x,#513
 512  0195 cd0000        	call	_TIM2_ITConfig
 514                     ; 182 	TIM2_Cmd(ENABLE);
 516  0198 a601          	ld	a,#1
 517  019a cd0000        	call	_TIM2_Cmd
 519                     ; 183 }
 522  019d 81            	ret
 551                     ; 208 void timer1Setup(void)
 551                     ; 209 {
 552                     	switch	.text
 553  019e               _timer1Setup:
 557                     ; 210 	TIM1_DeInit();																							/* Deinitialize Timer 1 */
 559  019e cd0000        	call	_TIM1_DeInit
 561                     ; 211 	TIM1_TimeBaseInit(timer1Prescaler, TIM1_COUNTERMODE_UP, timer1MaxCount, timer1Repeat);					/* Timer1 : time base generation */
 563  01a1 4b00          	push	#0
 564  01a3 aeffff        	ldw	x,#65535
 565  01a6 89            	pushw	x
 566  01a7 4b00          	push	#0
 567  01a9 ae0007        	ldw	x,#7
 568  01ac cd0000        	call	_TIM1_TimeBaseInit
 570  01af 5b04          	addw	sp,#4
 571                     ; 212 	TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 573  01b1 4b00          	push	#0
 574  01b3 4b00          	push	#0
 575  01b5 4b01          	push	#1
 576  01b7 ae0001        	ldw	x,#1
 577  01ba cd0000        	call	_TIM1_ICInit
 579  01bd 5b03          	addw	sp,#3
 580                     ; 213 	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 582  01bf 4b00          	push	#0
 583  01c1 4b00          	push	#0
 584  01c3 4b01          	push	#1
 585  01c5 ae0101        	ldw	x,#257
 586  01c8 cd0000        	call	_TIM1_ICInit
 588  01cb 5b03          	addw	sp,#3
 589                     ; 214 	TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 591  01cd 4b00          	push	#0
 592  01cf 4b00          	push	#0
 593  01d1 4b01          	push	#1
 594  01d3 ae0201        	ldw	x,#513
 595  01d6 cd0000        	call	_TIM1_ICInit
 597  01d9 5b03          	addw	sp,#3
 598                     ; 215 	TIM1_ICInit(TIM1_CHANNEL_4, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);	/* Initialize Input Capture Channel 3 */
 600  01db 4b00          	push	#0
 601  01dd 4b00          	push	#0
 602  01df 4b01          	push	#1
 603  01e1 ae0300        	ldw	x,#768
 604  01e4 cd0000        	call	_TIM1_ICInit
 606  01e7 5b03          	addw	sp,#3
 607                     ; 216 	TIM1_CCxCmd(TIM1_CHANNEL_1, ENABLE);																	/* Enable Timer 1 Capture Compare Channel 1 */
 609  01e9 ae0001        	ldw	x,#1
 610  01ec cd0000        	call	_TIM1_CCxCmd
 612                     ; 217 	TIM1_CCxCmd(TIM1_CHANNEL_3, ENABLE);
 614  01ef ae0201        	ldw	x,#513
 615  01f2 cd0000        	call	_TIM1_CCxCmd
 617                     ; 219 	TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE); //Uncommented by Saqib																	/* Timer 1 overflow interrupt enable */
 619  01f5 ae0101        	ldw	x,#257
 620  01f8 cd0000        	call	_TIM1_ITConfig
 622                     ; 220 	TIM1_ITConfig(TIM1_IT_CC1, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */
 624  01fb ae0201        	ldw	x,#513
 625  01fe cd0000        	call	_TIM1_ITConfig
 627                     ; 221 	TIM1_ITConfig(TIM1_IT_CC3, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */
 629  0201 ae0801        	ldw	x,#2049
 630  0204 cd0000        	call	_TIM1_ITConfig
 632                     ; 223 	TIM1_Cmd(ENABLE); /* Enable Timer 1 */
 634  0207 a601          	ld	a,#1
 635  0209 cd0000        	call	_TIM1_Cmd
 637                     ; 224 }
 640  020c 81            	ret
 668                     ; 233 void IWDG_Config(void)
 668                     ; 234 {
 669                     	switch	.text
 670  020d               _IWDG_Config:
 674                     ; 235 	IWDG_Enable();
 676  020d cd0000        	call	_IWDG_Enable
 678                     ; 237 	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
 680  0210 a655          	ld	a,#85
 681  0212 cd0000        	call	_IWDG_WriteAccessCmd
 683                     ; 238 	IWDG_SetPrescaler(IWDG_Prescaler_256);
 685  0215 a606          	ld	a,#6
 686  0217 cd0000        	call	_IWDG_SetPrescaler
 688                     ; 239 	IWDG_SetReload(0xFF);
 690  021a a6ff          	ld	a,#255
 691  021c cd0000        	call	_IWDG_SetReload
 693                     ; 240 	IWDG_ReloadCounter();
 695  021f cd0000        	call	_IWDG_ReloadCounter
 697                     ; 241 }
 700  0222 81            	ret
 729                     ; 250 void EXTI_setup(void)
 729                     ; 251 {
 730                     	switch	.text
 731  0223               _EXTI_setup:
 735                     ; 252 	ITC_DeInit();
 737  0223 cd0000        	call	_ITC_DeInit
 739                     ; 253 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
 741  0226 ae0602        	ldw	x,#1538
 742  0229 cd0000        	call	_ITC_SetSoftwarePriority
 744                     ; 254 	EXTI_DeInit();
 746  022c cd0000        	call	_EXTI_DeInit
 748                     ; 255 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 750  022f ae0302        	ldw	x,#770
 751  0232 cd0000        	call	_EXTI_SetExtIntSensitivity
 753                     ; 256 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
 755  0235 4f            	clr	a
 756  0236 cd0000        	call	_EXTI_SetTLISensitivity
 758                     ; 257 	enableInterrupts();
 761  0239 9a            rim
 763                     ; 258 }
 767  023a 81            	ret
 791                     ; 267 void EEPROMSetup(void)
 791                     ; 268 {
 792                     	switch	.text
 793  023b               _EEPROMSetup:
 797                     ; 269 	FLASH_DeInit();
 799  023b cd0000        	call	_FLASH_DeInit
 801                     ; 270 }
 804  023e 81            	ret
 838                     ; 272 void getCalibration()
 838                     ; 273 {
 839                     	switch	.text
 840  023f               _getCalibration:
 844                     ; 274 	checkByte = FLASH_ReadByte(CheckByte);
 846  023f ae4009        	ldw	x,#16393
 847  0242 89            	pushw	x
 848  0243 ae0000        	ldw	x,#0
 849  0246 89            	pushw	x
 850  0247 cd0000        	call	_FLASH_ReadByte
 852  024a 5b04          	addw	sp,#4
 853  024c b709          	ld	_checkByte,a
 854                     ; 275 	voltageCalibrationFactor1 = FLASH_ReadByte(V1CabFab);
 856  024e ae4000        	ldw	x,#16384
 857  0251 89            	pushw	x
 858  0252 ae0000        	ldw	x,#0
 859  0255 89            	pushw	x
 860  0256 cd0000        	call	_FLASH_ReadByte
 862  0259 5b04          	addw	sp,#4
 863  025b b708          	ld	_voltageCalibrationFactor1,a
 864                     ; 276 	voltageCalibrationFactor2 = FLASH_ReadByte(V2CabFab);
 866  025d ae4001        	ldw	x,#16385
 867  0260 89            	pushw	x
 868  0261 ae0000        	ldw	x,#0
 869  0264 89            	pushw	x
 870  0265 cd0000        	call	_FLASH_ReadByte
 872  0268 5b04          	addw	sp,#4
 873  026a b707          	ld	_voltageCalibrationFactor2,a
 874                     ; 277 	voltageCalibrationFactor3 = FLASH_ReadByte(V3CabFab);
 876  026c ae4002        	ldw	x,#16386
 877  026f 89            	pushw	x
 878  0270 ae0000        	ldw	x,#0
 879  0273 89            	pushw	x
 880  0274 cd0000        	call	_FLASH_ReadByte
 882  0277 5b04          	addw	sp,#4
 883  0279 b706          	ld	_voltageCalibrationFactor3,a
 884                     ; 278 	currentCalibrationFactor1 = FLASH_ReadByte(I1CabFab);
 886  027b ae4003        	ldw	x,#16387
 887  027e 89            	pushw	x
 888  027f ae0000        	ldw	x,#0
 889  0282 89            	pushw	x
 890  0283 cd0000        	call	_FLASH_ReadByte
 892  0286 5b04          	addw	sp,#4
 893  0288 b705          	ld	_currentCalibrationFactor1,a
 894                     ; 279 	currentCalibrationFactor2 = FLASH_ReadByte(I2CabFab);
 896  028a ae4004        	ldw	x,#16388
 897  028d 89            	pushw	x
 898  028e ae0000        	ldw	x,#0
 899  0291 89            	pushw	x
 900  0292 cd0000        	call	_FLASH_ReadByte
 902  0295 5b04          	addw	sp,#4
 903  0297 b704          	ld	_currentCalibrationFactor2,a
 904                     ; 280 	currentCalibrationFactor3 = FLASH_ReadByte(I3CabFab);
 906  0299 ae4005        	ldw	x,#16389
 907  029c 89            	pushw	x
 908  029d ae0000        	ldw	x,#0
 909  02a0 89            	pushw	x
 910  02a1 cd0000        	call	_FLASH_ReadByte
 912  02a4 5b04          	addw	sp,#4
 913  02a6 b703          	ld	_currentCalibrationFactor3,a
 914                     ; 281 	powerCalibrationFactor1 = FLASH_ReadByte(P1CabFab);
 916  02a8 ae4006        	ldw	x,#16390
 917  02ab 89            	pushw	x
 918  02ac ae0000        	ldw	x,#0
 919  02af 89            	pushw	x
 920  02b0 cd0000        	call	_FLASH_ReadByte
 922  02b3 5b04          	addw	sp,#4
 923  02b5 b702          	ld	_powerCalibrationFactor1,a
 924                     ; 282 	powerCalibrationFactor3 = FLASH_ReadByte(P3CabFab);
 926  02b7 ae4008        	ldw	x,#16392
 927  02ba 89            	pushw	x
 928  02bb ae0000        	ldw	x,#0
 929  02be 89            	pushw	x
 930  02bf cd0000        	call	_FLASH_ReadByte
 932  02c2 5b04          	addw	sp,#4
 933  02c4 b700          	ld	_powerCalibrationFactor3,a
 934                     ; 283 	powerCalibrationFactor2 = FLASH_ReadByte(P2CabFab);
 936  02c6 ae4007        	ldw	x,#16391
 937  02c9 89            	pushw	x
 938  02ca ae0000        	ldw	x,#0
 939  02cd 89            	pushw	x
 940  02ce cd0000        	call	_FLASH_ReadByte
 942  02d1 5b04          	addw	sp,#4
 943  02d3 b701          	ld	_powerCalibrationFactor2,a
 944                     ; 284 }
 947  02d5 81            	ret
 974                     ; 293 void ADCSetup(void)
 974                     ; 294 {
 975                     	switch	.text
 976  02d6               _ADCSetup:
 980                     ; 295 	ADC2_DeInit();
 982  02d6 cd0000        	call	_ADC2_DeInit
 984                     ; 296 	ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_0, ADC2_PRESSEL_FCPU_D8, ADC2_EXTTRIG_GPIO, DISABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL0, DISABLE);
 986  02d9 4b00          	push	#0
 987  02db 4b00          	push	#0
 988  02dd 4b08          	push	#8
 989  02df 4b00          	push	#0
 990  02e1 4b01          	push	#1
 991  02e3 4b40          	push	#64
 992  02e5 5f            	clrw	x
 993  02e6 cd0000        	call	_ADC2_Init
 995  02e9 5b06          	addw	sp,#6
 996                     ; 297 	ADC2_SchmittTriggerConfig(ADC2_SCHMITTTRIG_ALL, DISABLE);
 998  02eb ae1f00        	ldw	x,#7936
 999  02ee cd0000        	call	_ADC2_SchmittTriggerConfig
1001                     ; 298 	ADC2_ITConfig(DISABLE);
1003  02f1 4f            	clr	a
1004  02f2 cd0000        	call	_ADC2_ITConfig
1006                     ; 299 }
1009  02f5 81            	ret
1087                     ; 314 void UARTSetup(uint32_t baudRate, UARTCONFIG config)
1087                     ; 315 {
1088                     	switch	.text
1089  02f6               _UARTSetup:
1091       00000000      OFST:	set	0
1094                     ; 316 	UART1_DeInit();
1096  02f6 cd0000        	call	_UART1_DeInit
1098                     ; 318 	switch (config)
1100  02f9 0d07          	tnz	(OFST+7,sp)
1101  02fb 2617          	jrne	L141
1104  02fd               L731:
1105                     ; 320 	case MEVRIS_UART_PARITY_NONE:
1105                     ; 321 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1105                     ; 322 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1107  02fd 4b0c          	push	#12
1108  02ff 4b80          	push	#128
1109  0301 4b00          	push	#0
1110  0303 4b00          	push	#0
1111  0305 4b00          	push	#0
1112  0307 1e0a          	ldw	x,(OFST+10,sp)
1113  0309 89            	pushw	x
1114  030a 1e0a          	ldw	x,(OFST+10,sp)
1115  030c 89            	pushw	x
1116  030d cd0000        	call	_UART1_Init
1118  0310 5b09          	addw	sp,#9
1119                     ; 323 		break;
1121  0312 2015          	jra	L102
1122  0314               L141:
1123                     ; 324 	default:
1123                     ; 325 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1123                     ; 326 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1125  0314 4b0c          	push	#12
1126  0316 4b80          	push	#128
1127  0318 4b00          	push	#0
1128  031a 4b00          	push	#0
1129  031c 4b00          	push	#0
1130  031e 1e0a          	ldw	x,(OFST+10,sp)
1131  0320 89            	pushw	x
1132  0321 1e0a          	ldw	x,(OFST+10,sp)
1133  0323 89            	pushw	x
1134  0324 cd0000        	call	_UART1_Init
1136  0327 5b09          	addw	sp,#9
1137                     ; 327 		break;
1138  0329               L102:
1139                     ; 330 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
1141  0329 4b01          	push	#1
1142  032b ae0255        	ldw	x,#597
1143  032e cd0000        	call	_UART1_ITConfig
1145  0331 84            	pop	a
1146                     ; 331 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
1148  0332 4b01          	push	#1
1149  0334 ae0244        	ldw	x,#580
1150  0337 cd0000        	call	_UART1_ITConfig
1152  033a 84            	pop	a
1153                     ; 332 	UART1_Cmd(ENABLE);
1155  033b a601          	ld	a,#1
1156  033d cd0000        	call	_UART1_Cmd
1158                     ; 333 }
1161  0340 81            	ret
1201                     ; 345 void SetPortD7AsTim1_Ch4(void)
1201                     ; 346 {
1202                     	switch	.text
1203  0341               _SetPortD7AsTim1_Ch4:
1205  0341 89            	pushw	x
1206       00000002      OFST:	set	2
1209                     ; 348 	OPT2_status = FLASH_ReadOptionByte(OP2_Address);
1211  0342 ae4803        	ldw	x,#18435
1212  0345 cd0000        	call	_FLASH_ReadOptionByte
1214  0348 1f01          	ldw	(OFST-1,sp),x
1216                     ; 349 	if ((OPT2_status & 0x1000) == 0)
1218  034a 7b01          	ld	a,(OFST-1,sp)
1219  034c a510          	bcp	a,#16
1220  034e 2622          	jrne	L322
1221                     ; 351 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1223  0350 a6f7          	ld	a,#247
1224  0352 cd0000        	call	_FLASH_Unlock
1226                     ; 352 		delay_ms(100);
1228  0355 ae0064        	ldw	x,#100
1229  0358 cd0000        	call	_delay_ms
1231                     ; 354 		FLASH_ProgramOptionByte(OP2_Address, (uint8_t)((uint8_t)(OPT2_status >> 8) | 0x10));
1233  035b 7b01          	ld	a,(OFST-1,sp)
1234  035d aa10          	or	a,#16
1235  035f 88            	push	a
1236  0360 ae4803        	ldw	x,#18435
1237  0363 cd0000        	call	_FLASH_ProgramOptionByte
1239  0366 84            	pop	a
1240                     ; 355 		delay_ms(100);
1242  0367 ae0064        	ldw	x,#100
1243  036a cd0000        	call	_delay_ms
1245                     ; 356 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1247  036d a6f7          	ld	a,#247
1248  036f cd0000        	call	_FLASH_Lock
1250  0372               L322:
1251                     ; 359 }
1254  0372 85            	popw	x
1255  0373 81            	ret
1399                     	xdef	_IWDG_Config
1400                     	switch	.ubsct
1401  0000               _powerCalibrationFactor3:
1402  0000 00            	ds.b	1
1403                     	xdef	_powerCalibrationFactor3
1404  0001               _powerCalibrationFactor2:
1405  0001 00            	ds.b	1
1406                     	xdef	_powerCalibrationFactor2
1407  0002               _powerCalibrationFactor1:
1408  0002 00            	ds.b	1
1409                     	xdef	_powerCalibrationFactor1
1410  0003               _currentCalibrationFactor3:
1411  0003 00            	ds.b	1
1412                     	xdef	_currentCalibrationFactor3
1413  0004               _currentCalibrationFactor2:
1414  0004 00            	ds.b	1
1415                     	xdef	_currentCalibrationFactor2
1416  0005               _currentCalibrationFactor1:
1417  0005 00            	ds.b	1
1418                     	xdef	_currentCalibrationFactor1
1419  0006               _voltageCalibrationFactor3:
1420  0006 00            	ds.b	1
1421                     	xdef	_voltageCalibrationFactor3
1422  0007               _voltageCalibrationFactor2:
1423  0007 00            	ds.b	1
1424                     	xdef	_voltageCalibrationFactor2
1425  0008               _voltageCalibrationFactor1:
1426  0008 00            	ds.b	1
1427                     	xdef	_voltageCalibrationFactor1
1428  0009               _checkByte:
1429  0009 00            	ds.b	1
1430                     	xdef	_checkByte
1431                     	xdef	_SetPortD7AsTim1_Ch4
1432                     	xdef	_checkit
1433                     	xdef	_UARTSetup
1434                     	xdef	_ADCSetup
1435                     	xdef	_getCalibration
1436                     	xdef	_EXTI_setup
1437                     	xdef	_systemInit
1438                     	xdef	_EEPROMSetup
1439                     	xdef	_timer1Setup
1440                     	xdef	_timer2Setup
1441                     	xdef	_gpioSetup
1442                     	xdef	_clockSetup
1443                     	xref	_delay_ms
1444                     	xref	_FLASH_ProgramOptionByte
1445                     	xref	_FLASH_ReadOptionByte
1446                     	xref	_FLASH_ReadByte
1447                     	xref	_FLASH_DeInit
1448                     	xref	_FLASH_Lock
1449                     	xref	_FLASH_Unlock
1450                     	xref	_ITC_SetSoftwarePriority
1451                     	xref	_ITC_DeInit
1452                     	xref	_EXTI_SetTLISensitivity
1453                     	xref	_EXTI_SetExtIntSensitivity
1454                     	xref	_EXTI_DeInit
1455                     	xref	_UART1_ITConfig
1456                     	xref	_UART1_Cmd
1457                     	xref	_UART1_Init
1458                     	xref	_UART1_DeInit
1459                     	xref	_TIM2_CCxCmd
1460                     	xref	_TIM2_ITConfig
1461                     	xref	_TIM2_Cmd
1462                     	xref	_TIM2_ICInit
1463                     	xref	_TIM2_TimeBaseInit
1464                     	xref	_TIM2_DeInit
1465                     	xref	_TIM1_CCxCmd
1466                     	xref	_TIM1_ITConfig
1467                     	xref	_TIM1_Cmd
1468                     	xref	_TIM1_ICInit
1469                     	xref	_TIM1_TimeBaseInit
1470                     	xref	_TIM1_DeInit
1471                     	xref	_IWDG_Enable
1472                     	xref	_IWDG_ReloadCounter
1473                     	xref	_IWDG_SetReload
1474                     	xref	_IWDG_SetPrescaler
1475                     	xref	_IWDG_WriteAccessCmd
1476                     	xref	_GPIO_WriteHigh
1477                     	xref	_GPIO_Init
1478                     	xref	_GPIO_DeInit
1479                     	xref	_CLK_GetFlagStatus
1480                     	xref	_CLK_SYSCLKConfig
1481                     	xref	_CLK_HSIPrescalerConfig
1482                     	xref	_CLK_ClockSwitchConfig
1483                     	xref	_CLK_PeripheralClockConfig
1484                     	xref	_CLK_ClockSwitchCmd
1485                     	xref	_CLK_LSICmd
1486                     	xref	_CLK_HSICmd
1487                     	xref	_CLK_HSECmd
1488                     	xref	_CLK_DeInit
1489                     	xref	_ADC2_SchmittTriggerConfig
1490                     	xref	_ADC2_ITConfig
1491                     	xref	_ADC2_Init
1492                     	xref	_ADC2_DeInit
1512                     	end
