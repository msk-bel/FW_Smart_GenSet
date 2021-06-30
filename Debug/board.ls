   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  51                     ; 50 void systemInit(void)
  51                     ; 51 {
  53                     	switch	.text
  54  0000               _systemInit:
  58                     ; 52 	clockSetup();
  60  0000 ad25          	call	_clockSetup
  62                     ; 53 	EEPROMSetup();
  64  0002 cd0226        	call	_EEPROMSetup
  66                     ; 54 	getCalibration();
  68  0005 cd022a        	call	_getCalibration
  70                     ; 55 	gpioSetup();
  72  0008 cd008e        	call	_gpioSetup
  74                     ; 56 	timer2Setup();
  76  000b cd015a        	call	_timer2Setup
  78                     ; 57 	timer1Setup();
  80  000e cd019b        	call	_timer1Setup
  82                     ; 58 	ADCSetup();
  84  0011 cd02c1        	call	_ADCSetup
  86                     ; 59 	UARTSetup(uartBaudRate, MEVRIS_UART_PARITY_NONE);
  88  0014 4b00          	push	#0
  89  0016 ae2580        	ldw	x,#9600
  90  0019 89            	pushw	x
  91  001a ae0000        	ldw	x,#0
  92  001d 89            	pushw	x
  93  001e cd02e1        	call	_UARTSetup
  95  0021 5b05          	addw	sp,#5
  96                     ; 60 	EXTI_setup();
  98  0023 cd020e        	call	_EXTI_setup
 100                     ; 62 }
 103  0026 81            	ret
 136                     ; 78 void clockSetup(void)
 136                     ; 79 {
 137                     	switch	.text
 138  0027               _clockSetup:
 142                     ; 80 	CLK_DeInit();
 144  0027 cd0000        	call	_CLK_DeInit
 146                     ; 81 	CLK_HSECmd(DISABLE); /* Disable High Speed External clock signal */
 148  002a 4f            	clr	a
 149  002b cd0000        	call	_CLK_HSECmd
 151                     ; 82 	CLK_LSICmd(DISABLE); /* Disable Low Speed Internal clock signal */
 153  002e 4f            	clr	a
 154  002f cd0000        	call	_CLK_LSICmd
 156                     ; 83 	CLK_HSICmd(ENABLE);	 /* Enable high speed internal clock signal  */
 158  0032 a601          	ld	a,#1
 159  0034 cd0000        	call	_CLK_HSICmd
 162  0037               L33:
 163                     ; 85 	while (CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE)
 165  0037 ae0102        	ldw	x,#258
 166  003a cd0000        	call	_CLK_GetFlagStatus
 168  003d 4d            	tnz	a
 169  003e 27f7          	jreq	L33
 170                     ; 90 	CLK_ClockSwitchCmd(ENABLE);
 172  0040 a601          	ld	a,#1
 173  0042 cd0000        	call	_CLK_ClockSwitchCmd
 175                     ; 91 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 177  0045 4f            	clr	a
 178  0046 cd0000        	call	_CLK_HSIPrescalerConfig
 180                     ; 92 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 182  0049 a680          	ld	a,#128
 183  004b cd0000        	call	_CLK_SYSCLKConfig
 185                     ; 93 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE); /* Select HSI as master clock source */
 187  004e 4b01          	push	#1
 188  0050 4b00          	push	#0
 189  0052 ae01e1        	ldw	x,#481
 190  0055 cd0000        	call	_CLK_ClockSwitchConfig
 192  0058 85            	popw	x
 193                     ; 94 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 195  0059 ae0100        	ldw	x,#256
 196  005c cd0000        	call	_CLK_PeripheralClockConfig
 198                     ; 95 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 200  005f 5f            	clrw	x
 201  0060 cd0000        	call	_CLK_PeripheralClockConfig
 203                     ; 96 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, ENABLE);
 205  0063 ae1301        	ldw	x,#4865
 206  0066 cd0000        	call	_CLK_PeripheralClockConfig
 208                     ; 97 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 210  0069 ae1200        	ldw	x,#4608
 211  006c cd0000        	call	_CLK_PeripheralClockConfig
 213                     ; 98 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3, DISABLE);
 215  006f ae0600        	ldw	x,#1536
 216  0072 cd0000        	call	_CLK_PeripheralClockConfig
 218                     ; 99 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 220  0075 ae0400        	ldw	x,#1024
 221  0078 cd0000        	call	_CLK_PeripheralClockConfig
 223                     ; 100 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 225  007b ae0201        	ldw	x,#513
 226  007e cd0000        	call	_CLK_PeripheralClockConfig
 228                     ; 101 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);
 230  0081 ae0701        	ldw	x,#1793
 231  0084 cd0000        	call	_CLK_PeripheralClockConfig
 233                     ; 102 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 235  0087 ae0501        	ldw	x,#1281
 236  008a cd0000        	call	_CLK_PeripheralClockConfig
 238                     ; 103 }
 241  008d 81            	ret
 267                     ; 125 void gpioSetup(void)
 267                     ; 126 {
 268                     	switch	.text
 269  008e               _gpioSetup:
 273                     ; 127 	GPIO_DeInit(GPIOD);											   // Deinitialize Port D
 275  008e ae500f        	ldw	x,#20495
 276  0091 cd0000        	call	_GPIO_DeInit
 278                     ; 128 	GPIO_DeInit(GPIOC);											   // Deinitialize Port C
 280  0094 ae500a        	ldw	x,#20490
 281  0097 cd0000        	call	_GPIO_DeInit
 283                     ; 129 	GPIO_DeInit(GPIOA);											   // Deinitialize Port A
 285  009a ae5000        	ldw	x,#20480
 286  009d cd0000        	call	_GPIO_DeInit
 288                     ; 130 	GPIO_Init(txPin, GPIO_MODE_OUT_PP_HIGH_FAST);				   // Tx pin MAX232
 290  00a0 4bf0          	push	#240
 291  00a2 4b20          	push	#32
 292  00a4 ae500f        	ldw	x,#20495
 293  00a7 cd0000        	call	_GPIO_Init
 295  00aa 85            	popw	x
 296                     ; 131 	GPIO_Init(rxPin, GPIO_MODE_IN_PU_NO_IT);					   // Rx pin MAX232
 298  00ab 4b40          	push	#64
 299  00ad 4b40          	push	#64
 300  00af ae500f        	ldw	x,#20495
 301  00b2 cd0000        	call	_GPIO_Init
 303  00b5 85            	popw	x
 304                     ; 132 	GPIO_Init(PWRKEY, GPIO_MODE_OUT_PP_LOW_FAST);				   // SIMCom module power pin
 306  00b6 4be0          	push	#224
 307  00b8 4b20          	push	#32
 308  00ba ae500a        	ldw	x,#20490
 309  00bd cd0000        	call	_GPIO_Init
 311  00c0 85            	popw	x
 312                     ; 133 	GPIO_Init(currentVoltSelectionPin, GPIO_MODE_OUT_PP_LOW_FAST); // current and volt selection pin in PUSH-PULL Mode
 314  00c1 4be0          	push	#224
 315  00c3 4b04          	push	#4
 316  00c5 ae500f        	ldw	x,#20495
 317  00c8 cd0000        	call	_GPIO_Init
 319  00cb 85            	popw	x
 320                     ; 134 	GPIO_WriteHigh(currentVoltSelectionPin);					   // initially select voltage 1=Voltage & 0=Current
 322  00cc 4b04          	push	#4
 323  00ce ae500f        	ldw	x,#20495
 324  00d1 cd0000        	call	_GPIO_WriteHigh
 326  00d4 84            	pop	a
 327                     ; 135 	GPIO_Init(currentVoltFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 1 pin
 329  00d5 4b40          	push	#64
 330  00d7 4b04          	push	#4
 331  00d9 ae500a        	ldw	x,#20490
 332  00dc cd0000        	call	_GPIO_Init
 334  00df 85            	popw	x
 335                     ; 136 	GPIO_Init(currentVoltFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 2 pin
 337  00e0 4b40          	push	#64
 338  00e2 4b80          	push	#128
 339  00e4 ae500f        	ldw	x,#20495
 340  00e7 cd0000        	call	_GPIO_Init
 342  00ea 85            	popw	x
 343                     ; 137 	GPIO_Init(currentVoltFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);	   // current and voltage frequency phase 3 pin
 345  00eb 4b40          	push	#64
 346  00ed 4b08          	push	#8
 347  00ef ae500f        	ldw	x,#20495
 348  00f2 cd0000        	call	_GPIO_Init
 350  00f5 85            	popw	x
 351                     ; 138 	GPIO_Init(powerFrequency1Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 1 pin
 353  00f6 4b40          	push	#64
 354  00f8 4b02          	push	#2
 355  00fa ae500a        	ldw	x,#20490
 356  00fd cd0000        	call	_GPIO_Init
 358  0100 85            	popw	x
 359                     ; 139 	GPIO_Init(powerFrequency2Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 2 pin
 361  0101 4b40          	push	#64
 362  0103 4b08          	push	#8
 363  0105 ae500a        	ldw	x,#20490
 364  0108 cd0000        	call	_GPIO_Init
 366  010b 85            	popw	x
 367                     ; 140 	GPIO_Init(powerFrequency3Pin, GPIO_MODE_IN_PU_NO_IT);		   //power frequency phase 3 pin
 369  010c 4b40          	push	#64
 370  010e 4b10          	push	#16
 371  0110 ae500f        	ldw	x,#20495
 372  0113 cd0000        	call	_GPIO_Init
 374  0116 85            	popw	x
 375                     ; 141 	GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 377  0117 4be0          	push	#224
 378  0119 4b04          	push	#4
 379  011b ae5000        	ldw	x,#20480
 380  011e cd0000        	call	_GPIO_Init
 382  0121 85            	popw	x
 383                     ; 142 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);	   //Ring Indicator interrupt
 385  0122 4be0          	push	#224
 386  0124 4b02          	push	#2
 387  0126 ae5000        	ldw	x,#20480
 388  0129 cd0000        	call	_GPIO_Init
 390  012c 85            	popw	x
 391                     ; 143 	GPIO_Init(RingIndicatorPin, GPIO_MODE_IN_FL_IT);			   //Ring Indicator interrupt
 393  012d 4b20          	push	#32
 394  012f 4b01          	push	#1
 395  0131 ae500f        	ldw	x,#20495
 396  0134 cd0000        	call	_GPIO_Init
 398  0137 85            	popw	x
 399                     ; 144 	GPIO_Init(BatteryVoltagePin, GPIO_MODE_IN_FL_NO_IT);		   //Battery Voltage read pin
 401  0138 4b00          	push	#0
 402  013a 4b40          	push	#64
 403  013c ae5005        	ldw	x,#20485
 404  013f cd0000        	call	_GPIO_Init
 406  0142 85            	popw	x
 407                     ; 145 	GPIO_Init(Temp1Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 1 read pin
 409  0143 4b00          	push	#0
 410  0145 4b04          	push	#4
 411  0147 ae5005        	ldw	x,#20485
 412  014a cd0000        	call	_GPIO_Init
 414  014d 85            	popw	x
 415                     ; 146 	GPIO_Init(Temp2Pin, GPIO_MODE_IN_FL_NO_IT);					   //Temperature 2 read pin
 417  014e 4b00          	push	#0
 418  0150 4b02          	push	#2
 419  0152 ae5005        	ldw	x,#20485
 420  0155 cd0000        	call	_GPIO_Init
 422  0158 85            	popw	x
 423                     ; 147 }
 426  0159 81            	ret
 455                     ; 167 void timer2Setup(void)
 455                     ; 168 {
 456                     	switch	.text
 457  015a               _timer2Setup:
 461                     ; 169 	TIM2_DeInit();																							/* Deinitialize Timer 2 */
 463  015a cd0000        	call	_TIM2_DeInit
 465                     ; 170 	TIM2_TimeBaseInit(timer2Prescaler, timer2MaxCount);														/* Timer2 : time base generation */
 467  015d aeffff        	ldw	x,#65535
 468  0160 89            	pushw	x
 469  0161 a603          	ld	a,#3
 470  0163 cd0000        	call	_TIM2_TimeBaseInit
 472  0166 85            	popw	x
 473                     ; 171 	TIM2_ICInit(TIM2_CHANNEL_1, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 475  0167 4b00          	push	#0
 476  0169 4b00          	push	#0
 477  016b 4b01          	push	#1
 478  016d ae0044        	ldw	x,#68
 479  0170 cd0000        	call	_TIM2_ICInit
 481  0173 5b03          	addw	sp,#3
 482                     ; 172 	TIM2_ICInit(TIM2_CHANNEL_2, TIM2_ICPOLARITY_FALLING, TIM2_ICSELECTION_DIRECTTI, TIM2_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 484  0175 4b00          	push	#0
 485  0177 4b00          	push	#0
 486  0179 4b01          	push	#1
 487  017b ae0144        	ldw	x,#324
 488  017e cd0000        	call	_TIM2_ICInit
 490  0181 5b03          	addw	sp,#3
 491                     ; 173 	TIM2_CCxCmd(TIM2_CHANNEL_1, ENABLE);																	/* Enable Timer 2 Capture Compare Channel 1 */
 493  0183 ae0001        	ldw	x,#1
 494  0186 cd0000        	call	_TIM2_CCxCmd
 496                     ; 174 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);																	/* Timer 2 overflow interrupt enable */
 498  0189 ae0101        	ldw	x,#257
 499  018c cd0000        	call	_TIM2_ITConfig
 501                     ; 175 	TIM2_ITConfig(TIM2_IT_CC1, ENABLE);																		/* Timer 1 input capture channel 3 interrupt enable */
 503  018f ae0201        	ldw	x,#513
 504  0192 cd0000        	call	_TIM2_ITConfig
 506                     ; 176 	TIM2_Cmd(ENABLE);
 508  0195 a601          	ld	a,#1
 509  0197 cd0000        	call	_TIM2_Cmd
 511                     ; 177 }
 514  019a 81            	ret
 542                     ; 202 void timer1Setup(void)
 542                     ; 203 {
 543                     	switch	.text
 544  019b               _timer1Setup:
 548                     ; 204 	TIM1_DeInit();																							/* Deinitialize Timer 1 */
 550  019b cd0000        	call	_TIM1_DeInit
 552                     ; 205 	TIM1_TimeBaseInit(timer1Prescaler, TIM1_COUNTERMODE_UP, timer1MaxCount, timer1Repeat);					/* Timer1 : time base generation */
 554  019e 4b00          	push	#0
 555  01a0 aeffff        	ldw	x,#65535
 556  01a3 89            	pushw	x
 557  01a4 4b00          	push	#0
 558  01a6 ae0007        	ldw	x,#7
 559  01a9 cd0000        	call	_TIM1_TimeBaseInit
 561  01ac 5b04          	addw	sp,#4
 562                     ; 206 	TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 564  01ae 4b00          	push	#0
 565  01b0 4b00          	push	#0
 566  01b2 4b01          	push	#1
 567  01b4 ae0001        	ldw	x,#1
 568  01b7 cd0000        	call	_TIM1_ICInit
 570  01ba 5b03          	addw	sp,#3
 571                     ; 207 	TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 1 */
 573  01bc 4b00          	push	#0
 574  01be 4b00          	push	#0
 575  01c0 4b01          	push	#1
 576  01c2 ae0101        	ldw	x,#257
 577  01c5 cd0000        	call	_TIM1_ICInit
 579  01c8 5b03          	addw	sp,#3
 580                     ; 208 	TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 2 */
 582  01ca 4b00          	push	#0
 583  01cc 4b00          	push	#0
 584  01ce 4b01          	push	#1
 585  01d0 ae0201        	ldw	x,#513
 586  01d3 cd0000        	call	_TIM1_ICInit
 588  01d6 5b03          	addw	sp,#3
 589                     ; 209 	TIM1_ICInit(TIM1_CHANNEL_4, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00); /* Initialize Input Capture Channel 3 */
 591  01d8 4b00          	push	#0
 592  01da 4b00          	push	#0
 593  01dc 4b01          	push	#1
 594  01de ae0301        	ldw	x,#769
 595  01e1 cd0000        	call	_TIM1_ICInit
 597  01e4 5b03          	addw	sp,#3
 598                     ; 210 	TIM1_CCxCmd(TIM1_CHANNEL_1, ENABLE);																	/* Enable Timer 1 Capture Compare Channel 1 */
 600  01e6 ae0001        	ldw	x,#1
 601  01e9 cd0000        	call	_TIM1_CCxCmd
 603                     ; 211 	TIM1_CCxCmd(TIM1_CHANNEL_3, ENABLE);																	/* Enable Timer 1 Capture Compare Channel 2 */
 605  01ec ae0201        	ldw	x,#513
 606  01ef cd0000        	call	_TIM1_CCxCmd
 608                     ; 216 	TIM1_Cmd(ENABLE); /* Enable Timer 1 */
 610  01f2 a601          	ld	a,#1
 611  01f4 cd0000        	call	_TIM1_Cmd
 613                     ; 217 }
 616  01f7 81            	ret
 644                     ; 226 void IWDG_Config(void)
 644                     ; 227 {
 645                     	switch	.text
 646  01f8               _IWDG_Config:
 650                     ; 228 	IWDG_Enable();
 652  01f8 cd0000        	call	_IWDG_Enable
 654                     ; 230 	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
 656  01fb a655          	ld	a,#85
 657  01fd cd0000        	call	_IWDG_WriteAccessCmd
 659                     ; 231 	IWDG_SetPrescaler(IWDG_Prescaler_256);
 661  0200 a606          	ld	a,#6
 662  0202 cd0000        	call	_IWDG_SetPrescaler
 664                     ; 232 	IWDG_SetReload(0xFF);
 666  0205 a6ff          	ld	a,#255
 667  0207 cd0000        	call	_IWDG_SetReload
 669                     ; 233 	IWDG_ReloadCounter();
 671  020a cd0000        	call	_IWDG_ReloadCounter
 673                     ; 234 }
 676  020d 81            	ret
 705                     ; 243 void EXTI_setup(void)
 705                     ; 244 {
 706                     	switch	.text
 707  020e               _EXTI_setup:
 711                     ; 245 	ITC_DeInit();
 713  020e cd0000        	call	_ITC_DeInit
 715                     ; 246 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_0);
 717  0211 ae0602        	ldw	x,#1538
 718  0214 cd0000        	call	_ITC_SetSoftwarePriority
 720                     ; 247 	EXTI_DeInit();
 722  0217 cd0000        	call	_EXTI_DeInit
 724                     ; 248 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 726  021a ae0302        	ldw	x,#770
 727  021d cd0000        	call	_EXTI_SetExtIntSensitivity
 729                     ; 249 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);
 731  0220 4f            	clr	a
 732  0221 cd0000        	call	_EXTI_SetTLISensitivity
 734                     ; 250 	enableInterrupts();
 737  0224 9a            rim
 739                     ; 251 }
 743  0225 81            	ret
 767                     ; 260 void EEPROMSetup(void)
 767                     ; 261 {
 768                     	switch	.text
 769  0226               _EEPROMSetup:
 773                     ; 262 	FLASH_DeInit();
 775  0226 cd0000        	call	_FLASH_DeInit
 777                     ; 263 }
 780  0229 81            	ret
 814                     ; 265 void getCalibration()
 814                     ; 266 {
 815                     	switch	.text
 816  022a               _getCalibration:
 820                     ; 267 	checkByte = FLASH_ReadByte(CheckByte);
 822  022a ae4009        	ldw	x,#16393
 823  022d 89            	pushw	x
 824  022e ae0000        	ldw	x,#0
 825  0231 89            	pushw	x
 826  0232 cd0000        	call	_FLASH_ReadByte
 828  0235 5b04          	addw	sp,#4
 829  0237 b709          	ld	_checkByte,a
 830                     ; 268 	voltageCalibrationFactor1 = FLASH_ReadByte(V1CabFab);
 832  0239 ae4000        	ldw	x,#16384
 833  023c 89            	pushw	x
 834  023d ae0000        	ldw	x,#0
 835  0240 89            	pushw	x
 836  0241 cd0000        	call	_FLASH_ReadByte
 838  0244 5b04          	addw	sp,#4
 839  0246 b708          	ld	_voltageCalibrationFactor1,a
 840                     ; 269 	voltageCalibrationFactor2 = FLASH_ReadByte(V2CabFab);
 842  0248 ae4001        	ldw	x,#16385
 843  024b 89            	pushw	x
 844  024c ae0000        	ldw	x,#0
 845  024f 89            	pushw	x
 846  0250 cd0000        	call	_FLASH_ReadByte
 848  0253 5b04          	addw	sp,#4
 849  0255 b707          	ld	_voltageCalibrationFactor2,a
 850                     ; 270 	voltageCalibrationFactor3 = FLASH_ReadByte(V3CabFab);
 852  0257 ae4002        	ldw	x,#16386
 853  025a 89            	pushw	x
 854  025b ae0000        	ldw	x,#0
 855  025e 89            	pushw	x
 856  025f cd0000        	call	_FLASH_ReadByte
 858  0262 5b04          	addw	sp,#4
 859  0264 b706          	ld	_voltageCalibrationFactor3,a
 860                     ; 271 	currentCalibrationFactor1 = FLASH_ReadByte(I1CabFab);
 862  0266 ae4003        	ldw	x,#16387
 863  0269 89            	pushw	x
 864  026a ae0000        	ldw	x,#0
 865  026d 89            	pushw	x
 866  026e cd0000        	call	_FLASH_ReadByte
 868  0271 5b04          	addw	sp,#4
 869  0273 b705          	ld	_currentCalibrationFactor1,a
 870                     ; 272 	currentCalibrationFactor2 = FLASH_ReadByte(I2CabFab);
 872  0275 ae4004        	ldw	x,#16388
 873  0278 89            	pushw	x
 874  0279 ae0000        	ldw	x,#0
 875  027c 89            	pushw	x
 876  027d cd0000        	call	_FLASH_ReadByte
 878  0280 5b04          	addw	sp,#4
 879  0282 b704          	ld	_currentCalibrationFactor2,a
 880                     ; 273 	currentCalibrationFactor3 = FLASH_ReadByte(I3CabFab);
 882  0284 ae4005        	ldw	x,#16389
 883  0287 89            	pushw	x
 884  0288 ae0000        	ldw	x,#0
 885  028b 89            	pushw	x
 886  028c cd0000        	call	_FLASH_ReadByte
 888  028f 5b04          	addw	sp,#4
 889  0291 b703          	ld	_currentCalibrationFactor3,a
 890                     ; 274 	powerCalibrationFactor1 = FLASH_ReadByte(P1CabFab);
 892  0293 ae4006        	ldw	x,#16390
 893  0296 89            	pushw	x
 894  0297 ae0000        	ldw	x,#0
 895  029a 89            	pushw	x
 896  029b cd0000        	call	_FLASH_ReadByte
 898  029e 5b04          	addw	sp,#4
 899  02a0 b702          	ld	_powerCalibrationFactor1,a
 900                     ; 275 	powerCalibrationFactor3 = FLASH_ReadByte(P3CabFab);
 902  02a2 ae4008        	ldw	x,#16392
 903  02a5 89            	pushw	x
 904  02a6 ae0000        	ldw	x,#0
 905  02a9 89            	pushw	x
 906  02aa cd0000        	call	_FLASH_ReadByte
 908  02ad 5b04          	addw	sp,#4
 909  02af b700          	ld	_powerCalibrationFactor3,a
 910                     ; 276 	powerCalibrationFactor2 = FLASH_ReadByte(P2CabFab);
 912  02b1 ae4007        	ldw	x,#16391
 913  02b4 89            	pushw	x
 914  02b5 ae0000        	ldw	x,#0
 915  02b8 89            	pushw	x
 916  02b9 cd0000        	call	_FLASH_ReadByte
 918  02bc 5b04          	addw	sp,#4
 919  02be b701          	ld	_powerCalibrationFactor2,a
 920                     ; 277 }
 923  02c0 81            	ret
 950                     ; 286 void ADCSetup(void)
 950                     ; 287 {
 951                     	switch	.text
 952  02c1               _ADCSetup:
 956                     ; 288 	ADC2_DeInit();
 958  02c1 cd0000        	call	_ADC2_DeInit
 960                     ; 289 	ADC2_Init(ADC2_CONVERSIONMODE_SINGLE, ADC2_CHANNEL_0, ADC2_PRESSEL_FCPU_D8, ADC2_EXTTRIG_GPIO, DISABLE, ADC2_ALIGN_RIGHT, ADC2_SCHMITTTRIG_CHANNEL0, DISABLE);
 962  02c4 4b00          	push	#0
 963  02c6 4b00          	push	#0
 964  02c8 4b08          	push	#8
 965  02ca 4b00          	push	#0
 966  02cc 4b01          	push	#1
 967  02ce 4b40          	push	#64
 968  02d0 5f            	clrw	x
 969  02d1 cd0000        	call	_ADC2_Init
 971  02d4 5b06          	addw	sp,#6
 972                     ; 290 	ADC2_SchmittTriggerConfig(ADC2_SCHMITTTRIG_ALL, DISABLE);
 974  02d6 ae1f00        	ldw	x,#7936
 975  02d9 cd0000        	call	_ADC2_SchmittTriggerConfig
 977                     ; 291 	ADC2_ITConfig(DISABLE);
 979  02dc 4f            	clr	a
 980  02dd cd0000        	call	_ADC2_ITConfig
 982                     ; 292 }
 985  02e0 81            	ret
1063                     ; 307 void UARTSetup(uint32_t baudRate, UARTCONFIG config)
1063                     ; 308 {
1064                     	switch	.text
1065  02e1               _UARTSetup:
1067       00000000      OFST:	set	0
1070                     ; 309 	UART1_DeInit();
1072  02e1 cd0000        	call	_UART1_DeInit
1074                     ; 311 	switch (config)
1076  02e4 0d07          	tnz	(OFST+7,sp)
1077  02e6 2617          	jrne	L141
1080  02e8               L731:
1081                     ; 313 	case MEVRIS_UART_PARITY_NONE:
1081                     ; 314 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1081                     ; 315 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1083  02e8 4b0c          	push	#12
1084  02ea 4b80          	push	#128
1085  02ec 4b00          	push	#0
1086  02ee 4b00          	push	#0
1087  02f0 4b00          	push	#0
1088  02f2 1e0a          	ldw	x,(OFST+10,sp)
1089  02f4 89            	pushw	x
1090  02f5 1e0a          	ldw	x,(OFST+10,sp)
1091  02f7 89            	pushw	x
1092  02f8 cd0000        	call	_UART1_Init
1094  02fb 5b09          	addw	sp,#9
1095                     ; 316 		break;
1097  02fd 2015          	jra	L102
1098  02ff               L141:
1099                     ; 317 	default:
1099                     ; 318 		UART1_Init((uint32_t)baudRate, UART1_WORDLENGTH_8D, UART1_STOPBITS_1,
1099                     ; 319 				   UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE); //parity none
1101  02ff 4b0c          	push	#12
1102  0301 4b80          	push	#128
1103  0303 4b00          	push	#0
1104  0305 4b00          	push	#0
1105  0307 4b00          	push	#0
1106  0309 1e0a          	ldw	x,(OFST+10,sp)
1107  030b 89            	pushw	x
1108  030c 1e0a          	ldw	x,(OFST+10,sp)
1109  030e 89            	pushw	x
1110  030f cd0000        	call	_UART1_Init
1112  0312 5b09          	addw	sp,#9
1113                     ; 320 		break;
1114  0314               L102:
1115                     ; 323 	UART1_ITConfig(UART1_IT_RXNE, ENABLE);
1117  0314 4b01          	push	#1
1118  0316 ae0255        	ldw	x,#597
1119  0319 cd0000        	call	_UART1_ITConfig
1121  031c 84            	pop	a
1122                     ; 324 	UART1_ITConfig(UART1_IT_IDLE, ENABLE);
1124  031d 4b01          	push	#1
1125  031f ae0244        	ldw	x,#580
1126  0322 cd0000        	call	_UART1_ITConfig
1128  0325 84            	pop	a
1129                     ; 325 	UART1_Cmd(ENABLE);
1131  0326 a601          	ld	a,#1
1132  0328 cd0000        	call	_UART1_Cmd
1134                     ; 326 }
1137  032b 81            	ret
1251                     	xdef	_IWDG_Config
1252                     	switch	.ubsct
1253  0000               _powerCalibrationFactor3:
1254  0000 00            	ds.b	1
1255                     	xdef	_powerCalibrationFactor3
1256  0001               _powerCalibrationFactor2:
1257  0001 00            	ds.b	1
1258                     	xdef	_powerCalibrationFactor2
1259  0002               _powerCalibrationFactor1:
1260  0002 00            	ds.b	1
1261                     	xdef	_powerCalibrationFactor1
1262  0003               _currentCalibrationFactor3:
1263  0003 00            	ds.b	1
1264                     	xdef	_currentCalibrationFactor3
1265  0004               _currentCalibrationFactor2:
1266  0004 00            	ds.b	1
1267                     	xdef	_currentCalibrationFactor2
1268  0005               _currentCalibrationFactor1:
1269  0005 00            	ds.b	1
1270                     	xdef	_currentCalibrationFactor1
1271  0006               _voltageCalibrationFactor3:
1272  0006 00            	ds.b	1
1273                     	xdef	_voltageCalibrationFactor3
1274  0007               _voltageCalibrationFactor2:
1275  0007 00            	ds.b	1
1276                     	xdef	_voltageCalibrationFactor2
1277  0008               _voltageCalibrationFactor1:
1278  0008 00            	ds.b	1
1279                     	xdef	_voltageCalibrationFactor1
1280  0009               _checkByte:
1281  0009 00            	ds.b	1
1282                     	xdef	_checkByte
1283                     	xdef	_UARTSetup
1284                     	xdef	_ADCSetup
1285                     	xdef	_getCalibration
1286                     	xdef	_EXTI_setup
1287                     	xdef	_systemInit
1288                     	xdef	_EEPROMSetup
1289                     	xdef	_timer1Setup
1290                     	xdef	_timer2Setup
1291                     	xdef	_gpioSetup
1292                     	xdef	_clockSetup
1293                     	xref	_FLASH_ReadByte
1294                     	xref	_FLASH_DeInit
1295                     	xref	_ITC_SetSoftwarePriority
1296                     	xref	_ITC_DeInit
1297                     	xref	_EXTI_SetTLISensitivity
1298                     	xref	_EXTI_SetExtIntSensitivity
1299                     	xref	_EXTI_DeInit
1300                     	xref	_UART1_ITConfig
1301                     	xref	_UART1_Cmd
1302                     	xref	_UART1_Init
1303                     	xref	_UART1_DeInit
1304                     	xref	_TIM2_CCxCmd
1305                     	xref	_TIM2_ITConfig
1306                     	xref	_TIM2_Cmd
1307                     	xref	_TIM2_ICInit
1308                     	xref	_TIM2_TimeBaseInit
1309                     	xref	_TIM2_DeInit
1310                     	xref	_TIM1_CCxCmd
1311                     	xref	_TIM1_Cmd
1312                     	xref	_TIM1_ICInit
1313                     	xref	_TIM1_TimeBaseInit
1314                     	xref	_TIM1_DeInit
1315                     	xref	_IWDG_Enable
1316                     	xref	_IWDG_ReloadCounter
1317                     	xref	_IWDG_SetReload
1318                     	xref	_IWDG_SetPrescaler
1319                     	xref	_IWDG_WriteAccessCmd
1320                     	xref	_GPIO_WriteHigh
1321                     	xref	_GPIO_Init
1322                     	xref	_GPIO_DeInit
1323                     	xref	_CLK_GetFlagStatus
1324                     	xref	_CLK_SYSCLKConfig
1325                     	xref	_CLK_HSIPrescalerConfig
1326                     	xref	_CLK_ClockSwitchConfig
1327                     	xref	_CLK_PeripheralClockConfig
1328                     	xref	_CLK_ClockSwitchCmd
1329                     	xref	_CLK_LSICmd
1330                     	xref	_CLK_HSICmd
1331                     	xref	_CLK_HSECmd
1332                     	xref	_CLK_DeInit
1333                     	xref	_ADC2_SchmittTriggerConfig
1334                     	xref	_ADC2_ITConfig
1335                     	xref	_ADC2_Init
1336                     	xref	_ADC2_DeInit
1356                     	end
