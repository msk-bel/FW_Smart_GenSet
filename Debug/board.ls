   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _checkit:
  16  0000 00            	dc.b	0
  55                     ; 52 void systemInit(void)
  55                     ; 53 {
  57                     	switch	.text
  58  0000               _systemInit:
  62                     ; 55 	clockSetup();
  64  0000 ad28          	call	_clockSetup
  66                     ; 56 	EEPROMSetup();
  68  0002 cd023b        	call	_EEPROMSetup
  70                     ; 57 	getCalibration();
  72  0005 cd02b3        	call	_getCalibration
  74                     ; 59 	SetPortD7AsTim1_Ch4();
  76  0008 cd03b5        	call	_SetPortD7AsTim1_Ch4
  78                     ; 61 	gpioSetup();
  80  000b cd0091        	call	_gpioSetup
  82                     ; 62 	timer2Setup();
  84  000e cd015d        	call	_timer2Setup
  86                     ; 63 	timer1Setup();
  88  0011 cd019e        	call	_timer1Setup
  90                     ; 64 	ADCSetup();
  92  0014 cd034a        	call	_ADCSetup
  94                     ; 65 	UARTSetup(uartBaudRate, MEVRIS_UART_PARITY_NONE);
  96  0017 4b00          	push	#0
  97  0019 ae2580        	ldw	x,#9600
  98  001c 89            	pushw	x
  99  001d ae0000        	ldw	x,#0
 100  0020 89            	pushw	x
 101  0021 cd036a        	call	_UARTSetup
 103  0024 5b05          	addw	sp,#5
 104                     ; 66 	EXTI_setup();
 106  0026 cd0223        	call	_EXTI_setup
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
 320                     ; 140 	GPIO_Init(currentVoltSelectionPin, GPIO_MODE_OUT_PP_LOW_FAST); // current and volt selection pin in PUSH-PULL Mode
 322  00c4 4be0          	push	#224
 323  00c6 4b04          	push	#4
 324  00c8 ae500f        	ldw	x,#20495
 325  00cb cd0000        	call	_GPIO_Init
 327  00ce 85            	popw	x
 328                     ; 141 	GPIO_WriteHigh(currentVoltSelectionPin);					   // initially select voltage 1=Voltage & 0=Current
 330  00cf 4b04          	push	#4
 331  00d1 ae500f        	ldw	x,#20495
 332  00d4 cd0000        	call	_GPIO_WriteHigh
 334  00d7 84            	pop	a
 335                     ; 142 	GPIO_Init(currentVoltFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 1 pin
 337  00d8 4b40          	push	#64
 338  00da 4b04          	push	#4
 339  00dc ae500a        	ldw	x,#20490
 340  00df cd0000        	call	_GPIO_Init
 342  00e2 85            	popw	x
 343                     ; 143 	GPIO_Init(currentVoltFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 2 pin
 345  00e3 4b40          	push	#64
 346  00e5 4b80          	push	#128
 347  00e7 ae500f        	ldw	x,#20495
 348  00ea cd0000        	call	_GPIO_Init
 350  00ed 85            	popw	x
 351                     ; 144 	GPIO_Init(currentVoltFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 3 pin
 353  00ee 4b40          	push	#64
 354  00f0 4b08          	push	#8
 355  00f2 ae500f        	ldw	x,#20495
 356  00f5 cd0000        	call	_GPIO_Init
 358  00f8 85            	popw	x
 359                     ; 145 	GPIO_Init(powerFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 1 pin
 361  00f9 4b40          	push	#64
 362  00fb 4b02          	push	#2
 363  00fd ae500a        	ldw	x,#20490
 364  0100 cd0000        	call	_GPIO_Init
 366  0103 85            	popw	x
 367                     ; 146 	GPIO_Init(powerFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 2 pin
 369  0104 4b40          	push	#64
 370  0106 4b08          	push	#8
 371  0108 ae500a        	ldw	x,#20490
 372  010b cd0000        	call	_GPIO_Init
 374  010e 85            	popw	x
 375                     ; 147 	GPIO_Init(powerFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 3 pin
 377  010f 4b40          	push	#64
 378  0111 4b10          	push	#16
 379  0113 ae500f        	ldw	x,#20495
 380  0116 cd0000        	call	_GPIO_Init
 382  0119 85            	popw	x
 383                     ; 148 	GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 385  011a 4be0          	push	#224
 386  011c 4b04          	push	#4
 387  011e ae5000        	ldw	x,#20480
 388  0121 cd0000        	call	_GPIO_Init
 390  0124 85            	popw	x
 391                     ; 149 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 393  0125 4be0          	push	#224
 394  0127 4b02          	push	#2
 395  0129 ae5000        	ldw	x,#20480
 396  012c cd0000        	call	_GPIO_Init
 398  012f 85            	popw	x
 399                     ; 150 	GPIO_Init(RingIndicatorPin, GPIO_MODE_IN_FL_IT);			   //Ring Indicator interrupt
 401  0130 4b20          	push	#32
 402  0132 4b01          	push	#1
 403  0134 ae500f        	ldw	x,#20495
 404  0137 cd0000        	call	_GPIO_Init
 406  013a 85            	popw	x
 407                     ; 151 	GPIO_Init(BatteryVoltagePin, GPIO_MODE_IN_FL_NO_IT);		   //Battery Voltage read pin
 409  013b 4b00          	push	#0
 410  013d 4b40          	push	#64
 411  013f ae5005        	ldw	x,#20485
 412  0142 cd0000        	call	_GPIO_Init
 414  0145 85            	popw	x
 415                     ; 152 	GPIO_Init(Temp1Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 1 read pin
 417  0146 4b00          	push	#0
 418  0148 4b04          	push	#4
 419  014a ae5005        	ldw	x,#20485
 420  014d cd0000        	call	_GPIO_Init
 422  0150 85            	popw	x
 423                     ; 153 	GPIO_Init(Temp2Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 2 read pin
 425  0151 4b00          	push	#0
 426  0153 4b02          	push	#2
 427  0155 ae5005        	ldw	x,#20485
 428  0158 cd0000        	call	_GPIO_Init
 430  015b 85            	popw	x
 431                     ; 154 }
 434  015c 81            	ret
 463                     ; 174 void timer2Setup(void)
 463                     ; 175 {
 464                     	switch	.text
 465  015d               _timer2Setup:
 469                     ; 176 	TIM2_DeInit();																							/* Deinitialize Timer 2 */
 471  015d cd0000        	call	_TIM2_DeInit
 473                     ; 177 	TIM2_TimeBaseInit(timer2Prescaler, timer2MaxCount);														/* Timer2 : time base generation */
 475  0160 aeffff        	ldw	x,#65535
 476  0163 89            	pushw	x
 477  0164 a603          	ld	a,#3
 478  0166 cd0000        	call	_TIM2_TimeBaseInit
 480  0169 85            	popw	x
 481                     ; 178 	TIM2_ICInit(TIM2_CHANNEL_1, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 483  016a 4b00          	push	#0
 484  016c 4b00          	push	#0
 485  016e 4b01          	push	#1
 486  0170 ae0044        	ldw	x,#68
 487  0173 cd0000        	call	_TIM2_ICInit
 489  0176 5b03          	addw	sp,#3
 490                     ; 179 	TIM2_ICInit(TIM2_CHANNEL_2, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 492  0178 4b00          	push	#0
 493  017a 4b00          	push	#0
 494  017c 4b01          	push	#1
 495  017e ae0144        	ldw	x,#324
 496  0181 cd0000        	call	_TIM2_ICInit
 498  0184 5b03          	addw	sp,#3
 499                     ; 180 	TIM2_CCxCmd(TIM2_CHANNEL_1, ENABLE);																	/* Enable Timer 2 Capture Compare Channel 1 */
 501  0186 ae0001        	ldw	x,#1
 502  0189 cd0000        	call	_TIM2_CCxCmd
 504                     ; 181 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);																	/* Timer 2 overflow interrupt enable */
 506  018c ae0101        	ldw	x,#257
 507  018f cd0000        	call	_TIM2_ITConfig
 509                     ; 182 	TIM2_ITConfig(TIM2_IT_CC1, ENABLE);																		/* Timer 1 input capture channel 3 interrupt enable */
 511  0192 ae0201        	ldw	x,#513
 512  0195 cd0000        	call	_TIM2_ITConfig
 514                     ; 183 	TIM2_Cmd(ENABLE);
 516  0198 a601          	ld	a,#1
 517  019a cd0000        	call	_TIM2_Cmd
 519                     ; 184 }
 522  019d 81            	ret
 551                     ; 209 void timer1Setup(void)
 551                     ; 210 {
 552                     	switch	.text
 553  019e               _timer1Setup:
 557                     ; 211 	TIM1_DeInit();																							/* Deinitialize Timer 1 */
 559  019e cd0000        	call	_TIM1_DeInit
 561                     ; 212 	TIM1_TimeBaseInit(timer1Prescaler, TIM1_COUNTERMODE_UP, timer1MaxCount, timer1Repeat);					/* Timer1 : time base generation */
 563  01a1 4b00          	push	#0
 564  01a3 aeffff        	ldw	x,#65535
 565  01a6 89            	pushw	x
 566  01a7 4b00          	push	#0
 567  01a9 ae0007        	ldw	x,#7
 568  01ac cd0000        	call	_TIM1_TimeBaseInit
 570  01af 5b04          	addw	sp,#4
 571                     ; 213 	TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 573  01b1 4b00          	push	#0
 574  01b3 4b00          	push	#0
 575  01b5 4b01          	push	#1
 576  01b7 ae0001        	ldw	x,#1
 577  01ba cd0000        	call	_TIM1_ICInit
 579  01bd 5b03          	addw	sp,#3
 580                     ; 214 	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 582  01bf 4b00          	push	#0
 583  01c1 4b00          	push	#0
 584  01c3 4b01          	push	#1
 585  01c5 ae0101        	ldw	x,#257
 586  01c8 cd0000        	call	_TIM1_ICInit
 588  01cb 5b03          	addw	sp,#3
 589                     ; 215 	TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 591  01cd 4b00          	push	#0
 592  01cf 4b00          	push	#0
 593  01d1 4b01          	push	#1
 594  01d3 ae0201        	ldw	x,#513
 595  01d6 cd0000        	call	_TIM1_ICInit
 597  01d9 5b03          	addw	sp,#3
 598                     ; 216 	TIM1_ICInit(TIM1_CHANNEL_4, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);	/* Initialize Input Capture Channel 3 */
 600  01db 4b00          	push	#0
 601  01dd 4b00          	push	#0
 602  01df 4b01          	push	#1
 603  01e1 ae0300        	ldw	x,#768
 604  01e4 cd0000        	call	_TIM1_ICInit
 606  01e7 5b03          	addw	sp,#3
 607                     ; 217 	TIM1_CCxCmd(TIM1_CHANNEL_1, ENABLE);																	/* Enable Timer 1 Capture Compare Channel 1 */
 609  01e9 ae0001        	ldw	x,#1
 610  01ec cd0000        	call	_TIM1_CCxCmd
 612                     ; 218 	TIM1_CCxCmd(TIM1_CHANNEL_3, ENABLE);
 614  01ef ae0201        	ldw	x,#513
 615  01f2 cd0000        	call	_TIM1_CCxCmd
 617                     ; 220 	TIM1_ITConfig(TIM1_IT_UPDATE, ENABLE); //Uncommented by Saqib																	/* Timer 1 overflow interrupt enable */
 619  01f5 ae0101        	ldw	x,#257
 620  01f8 cd0000        	call	_TIM1_ITConfig
 622                     ; 221 	TIM1_ITConfig(TIM1_IT_CC1, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */
 624  01fb ae0201        	ldw	x,#513
 625  01fe cd0000        	call	_TIM1_ITConfig
 627                     ; 222 	TIM1_ITConfig(TIM1_IT_CC3, ENABLE);	   //Uncommented by Saqib																		/* Timer 1 input capture channel 3 interrupt enable */
 629  0201 ae0801        	ldw	x,#2049
 630  0204 cd0000        	call	_TIM1_ITConfig
 632                     ; 224 	TIM1_Cmd(ENABLE); /* Enable Timer 1 */
 634  0207 a601          	ld	a,#1
 635  0209 cd0000        	call	_TIM1_Cmd
 637                     ; 225 }
 640  020c 81            	ret
 668                     ; 234 void IWDG_Config(void)
 668                     ; 235 {
 669                     	switch	.text
 670  020d               _IWDG_Config:
 674                     ; 236 	IWDG_Enable();
 676  020d cd0000        	call	_IWDG_Enable
 678                     ; 238 	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
 680  0210 a655          	ld	a,#85
 681  0212 cd0000        	call	_IWDG_WriteAccessCmd
 683                     ; 239 	IWDG_SetPrescaler(IWDG_Prescaler_256);
 685  0215 a606          	ld	a,#6
 686  0217 cd0000        	call	_IWDG_SetPrescaler
 688                     ; 240 	IWDG_SetReload(0xFF);
 690  021a a6ff          	ld	a,#255
 691  021c cd0000        	call	_IWDG_SetReload
 693                     ; 241 	IWDG_ReloadCounter();
 695  021f cd0000        	call	_IWDG_ReloadCounter
 697                     ; 242 }
 700  0222 81            	ret
 729                     ; 251 void EXTI_setup(void)
 729                     ; 252 {
 730                     	switch	.text
 731  0223               _EXTI_setup:
 735                     ; 253 	ITC_DeInit();
 737  0223 cd0000        	call	_ITC_DeInit
 739                     ; 254 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
 741  0226 ae0602        	ldw	x,#1538
 742  0229 cd0000        	call	_ITC_SetSoftwarePriority
 744                     ; 255 	EXTI_DeInit();
 746  022c cd0000        	call	_EXTI_DeInit
 748                     ; 256 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 750  022f ae0302        	ldw	x,#770
 751  0232 cd0000        	call	_EXTI_SetExtIntSensitivity
 753                     ; 257 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
 755  0235 4f            	clr	a
 756  0236 cd0000        	call	_EXTI_SetTLISensitivity
 758                     ; 258 	enableInterrupts();
 761  0239 9a            rim
 763                     ; 259 }
 767  023a 81            	ret
 791                     ; 268 void EEPROMSetup(void)
 791                     ; 269 {
 792                     	switch	.text
 793  023b               _EEPROMSetup:
 797                     ; 270 	FLASH_DeInit();
 799  023b cd0000        	call	_FLASH_DeInit
 801                     ; 271 }
 804  023e 81            	ret
 848                     ; 273 uint16_t ReadFlashWord(uint32_t address)
 848                     ; 274 {
 849                     	switch	.text
 850  023f               _ReadFlashWord:
 852  023f 89            	pushw	x
 853       00000002      OFST:	set	2
 856                     ; 275 	uint16_t result = 0;
 858                     ; 276 	result = (FLASH_ReadByte(address+1) & 0x00FF);
 860  0240 96            	ldw	x,sp
 861  0241 1c0005        	addw	x,#OFST+3
 862  0244 cd0000        	call	c_ltor
 864  0247 a601          	ld	a,#1
 865  0249 cd0000        	call	c_ladc
 867  024c be02          	ldw	x,c_lreg+2
 868  024e 89            	pushw	x
 869  024f be00          	ldw	x,c_lreg
 870  0251 89            	pushw	x
 871  0252 cd0000        	call	_FLASH_ReadByte
 873  0255 5b04          	addw	sp,#4
 874  0257 5f            	clrw	x
 875  0258 97            	ld	xl,a
 876  0259 1f01          	ldw	(OFST-1,sp),x
 878                     ; 277 	result <<= 8;
 880  025b 7b02          	ld	a,(OFST+0,sp)
 881  025d 6b01          	ld	(OFST-1,sp),a
 882  025f 0f02          	clr	(OFST+0,sp)
 884                     ; 278 	result |= (FLASH_ReadByte(address) & 0x00FF);
 886  0261 1e07          	ldw	x,(OFST+5,sp)
 887  0263 89            	pushw	x
 888  0264 1e07          	ldw	x,(OFST+5,sp)
 889  0266 89            	pushw	x
 890  0267 cd0000        	call	_FLASH_ReadByte
 892  026a 5b04          	addw	sp,#4
 893  026c 5f            	clrw	x
 894  026d 97            	ld	xl,a
 895  026e 01            	rrwa	x,a
 896  026f 1a02          	or	a,(OFST+0,sp)
 897  0271 01            	rrwa	x,a
 898  0272 1a01          	or	a,(OFST-1,sp)
 899  0274 01            	rrwa	x,a
 900  0275 1f01          	ldw	(OFST-1,sp),x
 902                     ; 279 	return result;
 904  0277 1e01          	ldw	x,(OFST-1,sp)
 907  0279 5b02          	addw	sp,#2
 908  027b 81            	ret
 954                     ; 282 void WriteFlashWord(uint16_t data, uint32_t address)
 954                     ; 283 {
 955                     	switch	.text
 956  027c               _WriteFlashWord:
 958  027c 89            	pushw	x
 959       00000000      OFST:	set	0
 962                     ; 284 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
 964  027d a6f7          	ld	a,#247
 965  027f cd0000        	call	_FLASH_Unlock
 967                     ; 285 		FLASH_ProgramByte(address, (data & 0xFF));
 969  0282 7b02          	ld	a,(OFST+2,sp)
 970  0284 a4ff          	and	a,#255
 971  0286 88            	push	a
 972  0287 1e08          	ldw	x,(OFST+8,sp)
 973  0289 89            	pushw	x
 974  028a 1e08          	ldw	x,(OFST+8,sp)
 975  028c 89            	pushw	x
 976  028d cd0000        	call	_FLASH_ProgramByte
 978  0290 5b05          	addw	sp,#5
 979                     ; 286 		FLASH_ProgramByte(address+1, ((data >> 8) & 0xFF));
 981  0292 7b01          	ld	a,(OFST+1,sp)
 982  0294 88            	push	a
 983  0295 96            	ldw	x,sp
 984  0296 1c0006        	addw	x,#OFST+6
 985  0299 cd0000        	call	c_ltor
 987  029c a601          	ld	a,#1
 988  029e cd0000        	call	c_ladc
 990  02a1 be02          	ldw	x,c_lreg+2
 991  02a3 89            	pushw	x
 992  02a4 be00          	ldw	x,c_lreg
 993  02a6 89            	pushw	x
 994  02a7 cd0000        	call	_FLASH_ProgramByte
 996  02aa 5b05          	addw	sp,#5
 997                     ; 287 		FLASH_Lock(FLASH_MEMTYPE_DATA);
 999  02ac a6f7          	ld	a,#247
1000  02ae cd0000        	call	_FLASH_Lock
1002                     ; 288 }
1005  02b1 85            	popw	x
1006  02b2 81            	ret
1041                     ; 290 void getCalibration()
1041                     ; 291 {
1042                     	switch	.text
1043  02b3               _getCalibration:
1047                     ; 303 	checkByte = FLASH_ReadByte(CheckByte);
1049  02b3 ae4025        	ldw	x,#16421
1050  02b6 89            	pushw	x
1051  02b7 ae0000        	ldw	x,#0
1052  02ba 89            	pushw	x
1053  02bb cd0000        	call	_FLASH_ReadByte
1055  02be 5b04          	addw	sp,#4
1056  02c0 b712          	ld	_checkByte,a
1057                     ; 304 	voltageCalibrationFactor1 	= ReadFlashWord(V1CabFab);
1059  02c2 ae4000        	ldw	x,#16384
1060  02c5 89            	pushw	x
1061  02c6 ae0000        	ldw	x,#0
1062  02c9 89            	pushw	x
1063  02ca cd023f        	call	_ReadFlashWord
1065  02cd 5b04          	addw	sp,#4
1066  02cf bf10          	ldw	_voltageCalibrationFactor1,x
1067                     ; 305 	voltageCalibrationFactor2 	= ReadFlashWord(V2CabFab);
1069  02d1 ae4004        	ldw	x,#16388
1070  02d4 89            	pushw	x
1071  02d5 ae0000        	ldw	x,#0
1072  02d8 89            	pushw	x
1073  02d9 cd023f        	call	_ReadFlashWord
1075  02dc 5b04          	addw	sp,#4
1076  02de bf0e          	ldw	_voltageCalibrationFactor2,x
1077                     ; 306 	voltageCalibrationFactor3 	= ReadFlashWord(V3CabFab);
1079  02e0 ae4008        	ldw	x,#16392
1080  02e3 89            	pushw	x
1081  02e4 ae0000        	ldw	x,#0
1082  02e7 89            	pushw	x
1083  02e8 cd023f        	call	_ReadFlashWord
1085  02eb 5b04          	addw	sp,#4
1086  02ed bf0c          	ldw	_voltageCalibrationFactor3,x
1087                     ; 307 	currentCalibrationFactor1 	= ReadFlashWord(I1CabFab);	currentCalibrationFactor2 	= ReadFlashWord(I2CabFab);
1089  02ef ae400c        	ldw	x,#16396
1090  02f2 89            	pushw	x
1091  02f3 ae0000        	ldw	x,#0
1092  02f6 89            	pushw	x
1093  02f7 cd023f        	call	_ReadFlashWord
1095  02fa 5b04          	addw	sp,#4
1096  02fc bf0a          	ldw	_currentCalibrationFactor1,x
1099  02fe ae4010        	ldw	x,#16400
1100  0301 89            	pushw	x
1101  0302 ae0000        	ldw	x,#0
1102  0305 89            	pushw	x
1103  0306 cd023f        	call	_ReadFlashWord
1105  0309 5b04          	addw	sp,#4
1106  030b bf08          	ldw	_currentCalibrationFactor2,x
1107                     ; 308 	currentCalibrationFactor3 	= ReadFlashWord(I3CabFab);
1109  030d ae4014        	ldw	x,#16404
1110  0310 89            	pushw	x
1111  0311 ae0000        	ldw	x,#0
1112  0314 89            	pushw	x
1113  0315 cd023f        	call	_ReadFlashWord
1115  0318 5b04          	addw	sp,#4
1116  031a bf06          	ldw	_currentCalibrationFactor3,x
1117                     ; 309 	powerCalibrationFactor1 	= ReadFlashWord(P1CabFab);
1119  031c ae4018        	ldw	x,#16408
1120  031f 89            	pushw	x
1121  0320 ae0000        	ldw	x,#0
1122  0323 89            	pushw	x
1123  0324 cd023f        	call	_ReadFlashWord
1125  0327 5b04          	addw	sp,#4
1126  0329 bf04          	ldw	_powerCalibrationFactor1,x
1127                     ; 310 	powerCalibrationFactor2 	= ReadFlashWord(P2CabFab);
1129  032b ae401c        	ldw	x,#16412
1130  032e 89            	pushw	x
1131  032f ae0000        	ldw	x,#0
1132  0332 89            	pushw	x
1133  0333 cd023f        	call	_ReadFlashWord
1135  0336 5b04          	addw	sp,#4
1136  0338 bf02          	ldw	_powerCalibrationFactor2,x
1137                     ; 311 	powerCalibrationFactor3 	= ReadFlashWord(P3CabFab);
1139  033a ae4020        	ldw	x,#16416
1140  033d 89            	pushw	x
1141  033e ae0000        	ldw	x,#0
1142  0341 89            	pushw	x
1143  0342 cd023f        	call	_ReadFlashWord
1145  0345 5b04          	addw	sp,#4
1146  0347 bf00          	ldw	_powerCalibrationFactor3,x
1147                     ; 312 }
1150  0349 81            	ret
1177                     ; 322 void ADCSetup(void)
1177                     ; 323 {
1178                     	switch	.text
1179  034a               _ADCSetup:
1183                     ; 324 	ADC2_DeInit();
1185  034a cd0000        	call	_ADC2_DeInit
1187                     ; 325 	ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_0, ADC2_PRESSEL_FCPU_D8, ADC2_EXTTRIG_GPIO, DISABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL0, DISABLE);
1189  034d 4b00          	push	#0
1190  034f 4b00          	push	#0
1191  0351 4b08          	push	#8
1192  0353 4b00          	push	#0
1193  0355 4b01          	push	#1
1194  0357 4b40          	push	#64
1195  0359 5f            	clrw	x
1196  035a cd0000        	call	_ADC2_Init
1198  035d 5b06          	addw	sp,#6
1199                     ; 326 	ADC2_SchmittTriggerConfig(ADC2_SCHMITTTRIG_ALL, DISABLE);
1201  035f ae1f00        	ldw	x,#7936
1202  0362 cd0000        	call	_ADC2_SchmittTriggerConfig
1204                     ; 327 	ADC2_ITConfig(DISABLE);
1206  0365 4f            	clr	a
1207  0366 cd0000        	call	_ADC2_ITConfig
1209                     ; 328 }
1212  0369 81            	ret
1290                     ; 343 void UARTSetup(uint32_t baudRate, UARTCONFIG config)
1290                     ; 344 {
1291                     	switch	.text
1292  036a               _UARTSetup:
1294       00000000      OFST:	set	0
1297                     ; 345 	UART1_DeInit();
1299  036a cd0000        	call	_UART1_DeInit
1301                     ; 347 	switch (config)
1303  036d 0d07          	tnz	(OFST+7,sp)
1304  036f 2617          	jrne	L502
1307  0371               L302:
1308                     ; 349 	case MEVRIS_UART_PARITY_NONE:
1308                     ; 350 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1308                     ; 351 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1310  0371 4b0c          	push	#12
1311  0373 4b80          	push	#128
1312  0375 4b00          	push	#0
1313  0377 4b00          	push	#0
1314  0379 4b00          	push	#0
1315  037b 1e0a          	ldw	x,(OFST+10,sp)
1316  037d 89            	pushw	x
1317  037e 1e0a          	ldw	x,(OFST+10,sp)
1318  0380 89            	pushw	x
1319  0381 cd0000        	call	_UART1_Init
1321  0384 5b09          	addw	sp,#9
1322                     ; 352 		break;
1324  0386 2015          	jra	L542
1325  0388               L502:
1326                     ; 353 	default:
1326                     ; 354 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1326                     ; 355 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1328  0388 4b0c          	push	#12
1329  038a 4b80          	push	#128
1330  038c 4b00          	push	#0
1331  038e 4b00          	push	#0
1332  0390 4b00          	push	#0
1333  0392 1e0a          	ldw	x,(OFST+10,sp)
1334  0394 89            	pushw	x
1335  0395 1e0a          	ldw	x,(OFST+10,sp)
1336  0397 89            	pushw	x
1337  0398 cd0000        	call	_UART1_Init
1339  039b 5b09          	addw	sp,#9
1340                     ; 356 		break;
1341  039d               L542:
1342                     ; 359 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
1344  039d 4b01          	push	#1
1345  039f ae0255        	ldw	x,#597
1346  03a2 cd0000        	call	_UART1_ITConfig
1348  03a5 84            	pop	a
1349                     ; 360 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
1351  03a6 4b01          	push	#1
1352  03a8 ae0244        	ldw	x,#580
1353  03ab cd0000        	call	_UART1_ITConfig
1355  03ae 84            	pop	a
1356                     ; 361 	UART1_Cmd(ENABLE);
1358  03af a601          	ld	a,#1
1359  03b1 cd0000        	call	_UART1_Cmd
1361                     ; 362 }
1364  03b4 81            	ret
1404                     ; 374 void SetPortD7AsTim1_Ch4(void)
1404                     ; 375 {
1405                     	switch	.text
1406  03b5               _SetPortD7AsTim1_Ch4:
1408  03b5 89            	pushw	x
1409       00000002      OFST:	set	2
1412                     ; 377 	OPT2_status = FLASH_ReadOptionByte(OP2_Address);
1414  03b6 ae4803        	ldw	x,#18435
1415  03b9 cd0000        	call	_FLASH_ReadOptionByte
1417  03bc 1f01          	ldw	(OFST-1,sp),x
1419                     ; 378 	if ((OPT2_status & 0x1000) == 0)
1421  03be 7b01          	ld	a,(OFST-1,sp)
1422  03c0 a510          	bcp	a,#16
1423  03c2 2622          	jrne	L762
1424                     ; 380 		FLASH_Unlock(FLASH_MEMTYPE_DATA);
1426  03c4 a6f7          	ld	a,#247
1427  03c6 cd0000        	call	_FLASH_Unlock
1429                     ; 381 		delay_ms(100);
1431  03c9 ae0064        	ldw	x,#100
1432  03cc cd0000        	call	_delay_ms
1434                     ; 383 		FLASH_ProgramOptionByte(OP2_Address, (uint8_t)((uint8_t)(OPT2_status >> 8) | 0x10));
1436  03cf 7b01          	ld	a,(OFST-1,sp)
1437  03d1 aa10          	or	a,#16
1438  03d3 88            	push	a
1439  03d4 ae4803        	ldw	x,#18435
1440  03d7 cd0000        	call	_FLASH_ProgramOptionByte
1442  03da 84            	pop	a
1443                     ; 384 		delay_ms(100);
1445  03db ae0064        	ldw	x,#100
1446  03de cd0000        	call	_delay_ms
1448                     ; 385 		FLASH_Lock(FLASH_MEMTYPE_DATA);
1450  03e1 a6f7          	ld	a,#247
1451  03e3 cd0000        	call	_FLASH_Lock
1453  03e6               L762:
1454                     ; 388 }
1457  03e6 85            	popw	x
1458  03e7 81            	ret
1602                     	xdef	_IWDG_Config
1603                     	switch	.ubsct
1604  0000               _powerCalibrationFactor3:
1605  0000 0000          	ds.b	2
1606                     	xdef	_powerCalibrationFactor3
1607  0002               _powerCalibrationFactor2:
1608  0002 0000          	ds.b	2
1609                     	xdef	_powerCalibrationFactor2
1610  0004               _powerCalibrationFactor1:
1611  0004 0000          	ds.b	2
1612                     	xdef	_powerCalibrationFactor1
1613  0006               _currentCalibrationFactor3:
1614  0006 0000          	ds.b	2
1615                     	xdef	_currentCalibrationFactor3
1616  0008               _currentCalibrationFactor2:
1617  0008 0000          	ds.b	2
1618                     	xdef	_currentCalibrationFactor2
1619  000a               _currentCalibrationFactor1:
1620  000a 0000          	ds.b	2
1621                     	xdef	_currentCalibrationFactor1
1622  000c               _voltageCalibrationFactor3:
1623  000c 0000          	ds.b	2
1624                     	xdef	_voltageCalibrationFactor3
1625  000e               _voltageCalibrationFactor2:
1626  000e 0000          	ds.b	2
1627                     	xdef	_voltageCalibrationFactor2
1628  0010               _voltageCalibrationFactor1:
1629  0010 0000          	ds.b	2
1630                     	xdef	_voltageCalibrationFactor1
1631  0012               _checkByte:
1632  0012 00            	ds.b	1
1633                     	xdef	_checkByte
1634                     	xdef	_ReadFlashWord
1635                     	xdef	_SetPortD7AsTim1_Ch4
1636                     	xdef	_checkit
1637                     	xdef	_WriteFlashWord
1638                     	xdef	_UARTSetup
1639                     	xdef	_ADCSetup
1640                     	xdef	_getCalibration
1641                     	xdef	_EXTI_setup
1642                     	xdef	_systemInit
1643                     	xdef	_EEPROMSetup
1644                     	xdef	_timer1Setup
1645                     	xdef	_timer2Setup
1646                     	xdef	_gpioSetup
1647                     	xdef	_clockSetup
1648                     	xref	_delay_ms
1649                     	xref	_FLASH_ProgramOptionByte
1650                     	xref	_FLASH_ReadOptionByte
1651                     	xref	_FLASH_ReadByte
1652                     	xref	_FLASH_ProgramByte
1653                     	xref	_FLASH_DeInit
1654                     	xref	_FLASH_Lock
1655                     	xref	_FLASH_Unlock
1656                     	xref	_ITC_SetSoftwarePriority
1657                     	xref	_ITC_DeInit
1658                     	xref	_EXTI_SetTLISensitivity
1659                     	xref	_EXTI_SetExtIntSensitivity
1660                     	xref	_EXTI_DeInit
1661                     	xref	_UART1_ITConfig
1662                     	xref	_UART1_Cmd
1663                     	xref	_UART1_Init
1664                     	xref	_UART1_DeInit
1665                     	xref	_TIM2_CCxCmd
1666                     	xref	_TIM2_ITConfig
1667                     	xref	_TIM2_Cmd
1668                     	xref	_TIM2_ICInit
1669                     	xref	_TIM2_TimeBaseInit
1670                     	xref	_TIM2_DeInit
1671                     	xref	_TIM1_CCxCmd
1672                     	xref	_TIM1_ITConfig
1673                     	xref	_TIM1_Cmd
1674                     	xref	_TIM1_ICInit
1675                     	xref	_TIM1_TimeBaseInit
1676                     	xref	_TIM1_DeInit
1677                     	xref	_IWDG_Enable
1678                     	xref	_IWDG_ReloadCounter
1679                     	xref	_IWDG_SetReload
1680                     	xref	_IWDG_SetPrescaler
1681                     	xref	_IWDG_WriteAccessCmd
1682                     	xref	_GPIO_WriteHigh
1683                     	xref	_GPIO_Init
1684                     	xref	_GPIO_DeInit
1685                     	xref	_CLK_GetFlagStatus
1686                     	xref	_CLK_SYSCLKConfig
1687                     	xref	_CLK_HSIPrescalerConfig
1688                     	xref	_CLK_ClockSwitchConfig
1689                     	xref	_CLK_PeripheralClockConfig
1690                     	xref	_CLK_ClockSwitchCmd
1691                     	xref	_CLK_LSICmd
1692                     	xref	_CLK_HSICmd
1693                     	xref	_CLK_HSECmd
1694                     	xref	_CLK_DeInit
1695                     	xref	_ADC2_SchmittTriggerConfig
1696                     	xref	_ADC2_ITConfig
1697                     	xref	_ADC2_Init
1698                     	xref	_ADC2_DeInit
1699                     	xref.b	c_lreg
1719                     	xref	c_ladc
1720                     	xref	c_ltor
1721                     	end
