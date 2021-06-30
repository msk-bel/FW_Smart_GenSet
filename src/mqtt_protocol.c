//================================= File Header =====================================
//  C Language Source file
//===================================================================================
//                  			 MODULE  INFORMATION
//===================================================================================
//  $ Source:  mqtt_protocol.c $
//
//  $ Date Last Modified: 11 May 2021  $
//
//  $ Revision:  $
//===================================================================================
//                          FILE DESCRIPTION (for DOXYGEN)
//===================================================================================
//  $ Version 1.0: $Start Date:( 07 May 2021 )  $End Date:( 12 May 2021 )
//  $ Written By    - Saqib Kamal $
//  $ Designation   - Embedded System Engineer $
//  $ Company       - BlueEast $
//
//===================================================================================
//               			DESCRIPTION OF VERSIONS
//===================================================================================
//----------------------------    $ Version - 1.0 $  ------------------------------//
//This File and its header file contains code that can act perform like an MQTT
//Stack for low-end (resource starving) micro-controllers. This MQTT Library is only
//for Client Device and can be used on top of TCP/IP Stack. It handles MQTT Packets
//formation and proper connection settings for MQTT broker. Before using this library,
// one has to establish a TCP/IP connection to Broker/Server via Wifi, GPRS, or any
//other networking protocol.
//---------------------------------------------------------------------------------//

//===================================================================================
//                       		BEGENING OF CODE
//===================================================================================
//The acutal code related h/c file portion starts from here.

//===================================================================================
//                        		INCLUDE  FILES
//===================================================================================
#include "mqtt_protocol.h"
//===================================================================================
//                               	PRAGMA
//===================================================================================

//===================================================================================
//                     	  EXTERNAL CONSTANTS & MACROS
//===================================================================================

//===================================================================================
//                			LOCAL  CONSTANTS & MACROS
//===================================================================================

//===================================================================================
//                                EXTERNAL ENUMS
//===================================================================================

//===================================================================================
//                                  LOCAL ENUMS
//===================================================================================

//===================================================================================
//                        		EXTERNAL STRUCTURES
//===================================================================================

//===================================================================================
//                        		  LOCAL STRUCTURES
//===================================================================================

//===================================================================================
//                        			EXTERNAL DATA
//===================================================================================

//===================================================================================
//                          		 LOCAL DATA
//===================================================================================

//===================================================================================
//                      		  LOCAL FUNCTIONS
//===================================================================================
uint8_t *punEncodeLength (uint32_t ulLength);
//===================================================================================
//                			 GLOBAL/EXTERNAL FUNCTIONS
//===================================================================================
uint32_t ulMQTT_Connect ( uint8_t *punBuffer, uint8_t *punClientIdentifier/*,
						bool bUserNameFlag, bool bPasswordFlag,
						bool bWillFlag, bool bWillRetainFlag,
						bool bCleanSessionFlag, enMQTT_QOS eWill_QOS,
						uint8_t *punWillTopic, uint8_t *punWillMessage,
						uint8_t *punUsername, uint8_t *punPassword*/	);
uint32_t ulMQTT_Publish ( uint8_t *punBuffer, uint8_t *punTopic, uint8_t *punMessage/*, enMQTT_CTRL_PKT_FLAGS ePublishFlags */);
uint32_t ulMQTT_Subscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, enMQTT_QOS eQOS, uint16_t udPacketIdentifier */);
uint32_t ulMQTT_UnSubscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, uint16_t udPacketIdentifier */);
uint8_t unMQTT_PingRequest ( uint8_t *punBuffer );
uint8_t unMQTT_Disconnect ( uint8_t *punBuffer );
uint32_t ulDecodedLength (uint8_t * punLength);
//uint8_t unPUBREL ( uint8_t *punBuffer , uint16_t udPacketIdentifier);
//enum MQTT_CTRL_PKT_TYPE_ENUM enGetRecievedPacketType ( uint8_t *punBuffer);
//enum CONNECT_RETURN_CODE_ENUM enCONNACK_Response ( uint8_t *punBuffer);
//uint16_t udPUBACK_Response (uint8_t *punBuffer);
//uint16_t udPUBREC_Response (uint8_t *punBuffer);
//uint16_t udPUBCOMP_Response (uint8_t *punBuffer);
//struct SUBACK_RETURN_PARAM_STRUCT   stSUBACK_Response (uint8_t *punBuffer);
//uint16_t udUNSUBACK_Response (uint8_t *punBuffer);
//bool bPINRESP_Response(uint8_t *punBuffer);
//===================================================================================
//        					LOCAL FUNCTIONS CODE SECTION
//===================================================================================
uint8_t *punEncodeLength (uint32_t ulLength)
{
    static uint8_t buffer[5] = {0,0,0,0,0};
    uint8_t i = 0;
    do
    {
        buffer[i] = (ulLength % 0x80);
        ulLength = ulLength / 0x80;
        // if there are more data to encode, set the top bit of this byte
        if (ulLength > 0)
    	{
	        buffer[i] |= 0x80;
    	}
        i++;
    }  while (ulLength > 0 && i < 4);
    buffer[i] = '\0';

    return buffer;
}


//===================================================================================
//   				  GLOBAL/EXTERNAL FUNCTIONS CODE SECTION
//===================================================================================
uint32_t ulMQTT_Connect ( uint8_t *punBuffer, uint8_t *punClientIdentifier/*,
						bool bUserNameFlag, bool bPasswordFlag,
						bool bWillFlag, bool bWillRetainFlag,
						bool bCleanSessionFlag, enMQTT_QOS eWill_QOS,
						uint8_t *punWillTopic, uint8_t *punWillMessage,
						uint8_t *punUsername, uint8_t *punPassword*/	)
{
	uint32_t ulTotalPacketLength	= 0;
	uint32_t ulRemainingLength	= 0;
	uint8_t i = 0, j = 0, *ptr;
	// Clear punBuffer

	// Fixed Header Byte 1: Control Packet Type and Flags
	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_CONNECT & 0xF) << 4 ) & 0xF0) | (((uint8_t)eCTRL_PKT_FLAG_CONNECT & 0xF) & 0x0F);

	// Fixed Header Byte 2: Calculate Remaining Length
	ulRemainingLength	+=	2 + strlen( ( const char* )PROTOCOL_NAME);	//Variable Header:  Protocol Name [2 bytes of length and 4 Bytes of Name i.e. "MQTT"]
	ulRemainingLength	+=	1;	//Variable Header:	Protocol Level Byte i.e. 0x04 fixed
	ulRemainingLength	+=	1;	//Variable Header:	Connect Flags
	ulRemainingLength	+=	2;	//Variable Header:	Keep Alive Time (s) Bytes i.e. 2 Bytes
	ulRemainingLength	+=	2 + strlen( ( const char* )punClientIdentifier);	//Payload: Client Identifier + 2 Byte  for Client Identifier length itself

//	if(bWillFlag)
//	{
//		ulRemainingLength	+=	2 + strlen( ( const char* )punWillTopic);	//Payload: If willFlag=1, Will Topic length + 2 Byte of Will Topic Length Itself
//		ulRemainingLength	+=	2 + strlen( ( const char* )punWillMessage);	//Payload: If willFlag=1, Will message length + 2 Bytes of Will Topic Length Itself
//	}
//	if(bUserNameFlag)
//	{
//		ulRemainingLength	+=	2 + strlen( ( const char* )punUsername);	//Payload: If Username Flag=1, User Name length + 2 Byte of User Name Length Itself
//	}
//	if(bPasswordFlag)
//	{
//		ulRemainingLength	+=	2 + strlen( ( const char* )punPassword);	//Payload: If Password Flag=1, Password length + 2 Bytes of password Length Itself
//	}

	// Fixed Header Byte 2: Remaining Length
	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
	i = strlen( ( const char* )ptr);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = *(ptr + j);
	}

    i = strlen( ( const char* )PROTOCOL_NAME);
	punBuffer[ulTotalPacketLength++] = (i >> 8) & 0xFF;	//Variable Header:  Protocol Name Length Most Significant Byte
	punBuffer[ulTotalPacketLength++] = (i >> 0) & 0xFF;	//Variable Header:  Protocol Name Length Least Significant Byte
	for (j = 0; j < i; j++)
    {
        punBuffer[ulTotalPacketLength++] = (uint8_t)PROTOCOL_NAME[j];
    }
//	punBuffer[ulTotalPacketLength++] = 'M';		//Variable Header:  Protocol Name: 1st Letter of "MQTT"
//	punBuffer[ulTotalPacketLength++] = 'Q';		//Variable Header:  Protocol Name: 2nd Letter of "MQTT"
//	punBuffer[ulTotalPacketLength++] = 'T';		//Variable Header:  Protocol Name: 3rd Letter of "MQTT"
//	punBuffer[ulTotalPacketLength++] = 'T';		//Variable Header:  Protocol Name: 4th Letter of "MQTT"

	punBuffer[ulTotalPacketLength++] = 0x04;	//Variable Header:  Protocol Level: which is fixed Level-4

//	punBuffer[ulTotalPacketLength++] = (	(((	bUserNameFlag 		& 0x1 ) << 7) & 0x80)
//										|	(((	bPasswordFlag 		& 0x1 ) << 6) & 0x40)
//										|	(((	bWillRetainFlag 	& 0x1 ) << 5) & 0x20)
//										|	(((	eWill_QOS 			& 0x2 ) << 3) & 0x10)
//										|	(((	eWill_QOS 			& 0x1 ) << 3) & 0x08)
//										|	(((	bWillFlag 			& 0x1 ) << 2) & 0x04)
//										|	(((	bCleanSessionFlag 	& 0x1 ) << 1) & 0x02)
//										) & 0xFE;

	
	punBuffer[ulTotalPacketLength++] = 0x02;
	punBuffer[ulTotalPacketLength++] = ((uint16_t)KEEP_ALIVE_TIMEOUT	>> 8)	&	0xFF;	////Variable Header:  Keep Alive Most Significant Byte
	punBuffer[ulTotalPacketLength++] = ((uint16_t)KEEP_ALIVE_TIMEOUT	>> 0)	&	0xFF;	////Variable Header:  Keep Alive Least Significant Byte


	// Payload: Client Identifier
	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punClientIdentifier));
	i = strlen( ( const char* )ptr);
	if(i < 2)
	{
		punBuffer[ulTotalPacketLength++] = 0;
		punBuffer[ulTotalPacketLength++] = *(ptr);
	}
	else
	{
		punBuffer[ulTotalPacketLength++] = *(ptr);
		punBuffer[ulTotalPacketLength++] = *(ptr+1);
	}
	i = strlen( ( const char* )punClientIdentifier);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = punClientIdentifier[j];
	}

	// Payload: Will Topic and Will Message if Any
//	if(bWillFlag && punWillTopic != NULL && punWillMessage != NULL)
//	{
//		ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punWillTopic));
//		i = strlen( ( const char* )ptr);
//		if(i < 2)
//		{
//			punBuffer[ulTotalPacketLength++] = 0;
//			punBuffer[ulTotalPacketLength++] = *(ptr);
//		}
//		else
//		{
//			punBuffer[ulTotalPacketLength++] = *(ptr);
//			punBuffer[ulTotalPacketLength++] = *(ptr+1);
//		}
//		i = strlen( ( const char* )punWillTopic);
//		for ( j = 0; j < i; j++)
//		{
//			punBuffer[ulTotalPacketLength++] = punWillTopic[j];
//		}
//		i = strlen( ( const char* )punWillMessage);
//		if(i == 0)
//		{
//			punBuffer[ulTotalPacketLength++] = 0;
//		}
//		else
//		{
//			punBuffer[ulTotalPacketLength++] = ( i >> 8 ) & 0xFF;
//			punBuffer[ulTotalPacketLength++] = ( i >> 0 ) & 0xFF;
//			for ( j = 0; j < i; j++)
//			{
//				punBuffer[ulTotalPacketLength++] = punWillMessage[j];
//			}
//		}
//	}
//
//	// Payload: Username and Password if any
//	if(bUserNameFlag && punUsername != NULL)
//	{
//		ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punUsername));
//		i = strlen( ( const char* )ptr);
//		if(i < 2)
//		{
//			punBuffer[ulTotalPacketLength++] = 0;
//			punBuffer[ulTotalPacketLength++] = *(ptr);
//		}
//		else
//		{
//			punBuffer[ulTotalPacketLength++] = *(ptr);
//			punBuffer[ulTotalPacketLength++] = *(ptr+1);
//		}
//		i = strlen( ( const char* )punUsername);
//		for ( j = 0; j < i; j++)
//		{
//			punBuffer[ulTotalPacketLength++] = punUsername[j];
//		}
//	}
//	if(bPasswordFlag && punPassword != NULL)
//	{
//		i = strlen( ( const char* )punPassword);
//		if(i == 0)
//		{
//			punBuffer[ulTotalPacketLength++] = 0;
//		}
//		else
//		{
//			punBuffer[ulTotalPacketLength++] = ( i >> 8 ) & 0xFF;
//			punBuffer[ulTotalPacketLength++] = ( i >> 0 ) & 0xFF;
//			for ( j = 0; j < i; j++)
//			{
//				punBuffer[ulTotalPacketLength++] = punPassword[j];
//			}
//		}
//	}

	punBuffer[ulTotalPacketLength]	=	'\0';

	return ulTotalPacketLength;
}

uint32_t ulMQTT_Publish ( uint8_t *punBuffer, uint8_t *punTopic, uint8_t *punMessage/*, enMQTT_CTRL_PKT_FLAGS ePublishFlags*/ )
{
	uint32_t ulTotalPacketLength	= 0;
	uint32_t ulRemainingLength		= 0;
	uint8_t i = 0, j = 0, *ptr;
	
	enum MQTT_CTRL_PKT_FLAGS_ENUM ePublishFlags = eCTRL_PKT_FLAG_PUBLISH_D0_0_R0;
	// Clear punBuffer

	// Fixed Header Byte 1: Control Packet Type and Flags
	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_PUBLISH & 0xF) << 4 ) & 0xF0) | (( (uint8_t)ePublishFlags & 0x0F) );

	//Calculate Remaining Length
	ulRemainingLength	+=	2;	//Variable Header: Topic Name Length size in 2 Bytes
	ulRemainingLength	+=	strlen( ( const char* )punTopic);	//Variable Header: Topic Name
	if( (ePublishFlags & 0x06) != 0 )	// Check if QOS-1 or QOS-2 is selected
	{
		ulRemainingLength	+=	2;	//Variable Header: Packet Identifier Length which is 2 Bytes
	}
	ulRemainingLength	+=	strlen( ( const char* )punMessage);	//Payload: Message Length in Bytes

	// Fixed Header Byte 2: Remaining Length
	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
	i = strlen( ( const char* )ptr);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = *(ptr + j);
	}
	// Variable Header: Topic Name
	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
	i = strlen( ( const char* )ptr);
	if(i < 2)
	{
		punBuffer[ulTotalPacketLength++] = 0;
		punBuffer[ulTotalPacketLength++] = *(ptr);
	}
	else
	{
		punBuffer[ulTotalPacketLength++] = *(ptr);
		punBuffer[ulTotalPacketLength++] = *(ptr+1);
	}
	i = strlen( ( const char* )punTopic);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = punTopic[j];
	}

//	//	Variable Header: Packet Identifier if QOS-1 or QOS-2
//	if( (ePublishFlags & 0x06) != 0 )	// Check if QOS-1 or QOS-2 is selected
//	{
//		punBuffer[ulTotalPacketLength++] = 0x00;	//Packet Identifier Most Significant Byte
//		punBuffer[ulTotalPacketLength++] = 0x0A;	//Packet Identifier Least Significant Byte
//	}
	//	Payload: Message
	i = strlen( ( const char* )punMessage);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = punMessage[j];
	}

	punBuffer[ulTotalPacketLength]	=	'\0';

	return ulTotalPacketLength;
}

uint32_t ulMQTT_Subscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, enMQTT_QOS eQOS, uint16_t udPacketIdentifier*/ )
{
	uint32_t ulTotalPacketLength	= 0;
	uint32_t ulRemainingLength		= 0;
	uint8_t i = 0, j = 0, *ptr;
	
	uint16_t udPacketIdentifier = 1;
	enum MQTT_QOS_ENUM eQOS = eQOS_0;
	// Fixed Header Byte 1
	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_SUBSCRIBE & 0xF) << 4 ) & 0xF0) | (( (uint8_t)eCTRL_PKT_FLAG_SUBSCRIBE & 0x0F) );

	//Calculate Remaining Length
	ulRemainingLength	+=	2;	//Variable Header: Packet Identifier of fixed 2 Bytes
	ulRemainingLength	+=	2;	//Payload: Topic Name Length which is 2 Bytes
	ulRemainingLength	+=	strlen( ( const char* )punTopic);;	//Payload: Topic Name Length
	ulRemainingLength	+=	1;	//Payload: Requested QOS Byte

	// Fixed Header Byte 2: Remaining Length
	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
	i = strlen( ( const char* )ptr);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = *(ptr + j);
	}

	//	Variable Header: Packet Identifier
	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	8 ) & 0xFF;	// Most Significant Byte
	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	0 ) & 0xFF;	// Least Significant Byte

	//	Payload: Topic Name
	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
	i = strlen( ( const char* )ptr);
	if(i < 2)
	{
		punBuffer[ulTotalPacketLength++] = 0;
		punBuffer[ulTotalPacketLength++] = *(ptr);
	}
	else
	{
		punBuffer[ulTotalPacketLength++] = *(ptr);
		punBuffer[ulTotalPacketLength++] = *(ptr+1);
	}
	i = strlen( ( const char* )punTopic);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = punTopic[j];
	}

	//	Payload: Requested QOS
	punBuffer[ulTotalPacketLength++]	=	((uint8_t)eQOS & 0x03);	//	Requested QOS, where bits[1:0] is QOS, and bits[7:2] are reserved 0

	punBuffer[ulTotalPacketLength]	=	'\0';

	return ulTotalPacketLength;
}

uint32_t ulMQTT_UnSubscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, uint16_t udPacketIdentifier */)
{
	uint32_t ulTotalPacketLength	= 0;
	uint32_t ulRemainingLength		= 0;
	uint8_t i = 0, j = 0, *ptr;

	uint16_t udPacketIdentifier = 1;
	// Fixed Header Byte 1
	punBuffer[ulTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_UNSUBSCRIBE & 0xF) << 4 ) & 0xF0) | (( (uint8_t)eCTRL_PKT_FLAG_UNSUBSCRIBE & 0x0F) );

	//Calculate Remaining Length
	ulRemainingLength	+=	2;	//Variable Header: Packet Identifier of fixed 2 Bytes
	ulRemainingLength	+=	2;	//Payload: Topic Name Length which is 2 Bytes
	ulRemainingLength	+=	strlen( ( const char* )punTopic);;	//Payload: Topic Name Length

	// Fixed Header Byte 2: Remaining Length
	ptr = (uint8_t *)punEncodeLength(ulRemainingLength);
	i = strlen( ( const char* )ptr);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = *(ptr + j);
	}

	//	Variable Header: Packet Identifier
	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	8 ) & 0xFF;	// Most Significant Byte
	punBuffer[ulTotalPacketLength++]	=	( udPacketIdentifier	>>	0 ) & 0xFF;	// Least Significant Byte

	//	Payload: Topic Name
	ptr = (uint8_t *)punEncodeLength(strlen( ( const char* )punTopic));
	i = strlen( ( const char* )ptr);
	if(i < 2)
	{
		punBuffer[ulTotalPacketLength++] = 0;
		punBuffer[ulTotalPacketLength++] = *(ptr);
	}
	else
	{
		punBuffer[ulTotalPacketLength++] = *(ptr);
		punBuffer[ulTotalPacketLength++] = *(ptr+1);
	}
	i = strlen( ( const char* )punTopic);
	for ( j = 0; j < i; j++)
	{
		punBuffer[ulTotalPacketLength++] = punTopic[j];
	}

	punBuffer[ulTotalPacketLength]	=	'\0';

	return ulTotalPacketLength;
}

uint8_t unMQTT_PingRequest ( uint8_t *punBuffer )
{
	uint8_t unTotalPacketLength	= 0;
	uint8_t unRemainingLength	= 0;

	// Fixed Header Byte 1: Control Packet Type and Flag
	punBuffer[unTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_PINGREQ & 0xF) << 4 ) & 0xF0) | ( ((uint8_t)eCTRL_PKT_FLAG_PINGREQ & 0x0F) );
	// Fixed Header Byte 2: Remaining Length
	punBuffer[unTotalPacketLength++] = unRemainingLength;

	punBuffer[unTotalPacketLength]	=	'\0';

	return unTotalPacketLength;
}

uint8_t unMQTT_Disconnect ( uint8_t *punBuffer )
{
	uint8_t unTotalPacketLength	= 0;
	uint8_t unRemainingLength	= 0;

	// Fixed Header Byte 1: Control Packet Type and Flag
	punBuffer[unTotalPacketLength++] = ((((uint8_t)eCTRL_PKT_DISCONNECT & 0xF) << 4 ) & 0xF0) | ( ((uint8_t)eCTRL_PKT_FLAG_DISCONNECT & 0x0F) );
	// Fixed Header Byte 2: Remaining Length
	punBuffer[unTotalPacketLength++] = unRemainingLength;

	punBuffer[unTotalPacketLength]	=	'\0';

	return unTotalPacketLength;
}

//uint8_t unPUBREL ( uint8_t *punBuffer , uint16_t udPacketIdentifier) //This Packet is sent in QOS_2 in response to PUBREC Packet recieved from Server/Broker
//{
//	uint8_t unTotalPacketLength	= 0;
//	// Fixed Header Byte 1: Control Packet Type and Flag
//	punBuffer[unTotalPacketLength++]    = ((((uint8_t)eCTRL_PKT_PUBREL & 0xF) << 4 ) & 0xF0) | ( ((uint8_t)eCTRL_PKT_FLAG_PUBREL & 0x0F) );
//	// Fixed Header Byte 2: Remaining Length
//	punBuffer[unTotalPacketLength++]    = 0x02;
//
//	punBuffer[unTotalPacketLength++]    = (udPacketIdentifier >> 8) & 0xFF; // Most Significant Byte of Packet Identifier
//
//    punBuffer[unTotalPacketLength++]    = (udPacketIdentifier >> 0) & 0xFF; // Least Significant Byte of Packet Identifier
//
//	punBuffer[unTotalPacketLength]	=	'\0';
//
//	return unTotalPacketLength;
//}

//enum MQTT_CTRL_PKT_TYPE_ENUM enGetRecievedPacketType ( uint8_t *punBuffer)
//{
//    enum MQTT_CTRL_PKT_TYPE_ENUM ePacketType;
//    uint8_t unByte1 = punBuffer[0]; // Get Byte 1 Which contains Control Packet Type [7:4]
//    unByte1 =   (unByte1 >>  4) &   0x0F;   // Remove Control Packet Flags[3:0]
//
//    switch(unByte1)
//    {
//        case    eCTRL_PKT_CONNECT:
//            ePacketType = eCTRL_PKT_CONNECT;
//            break;
//        case    eCTRL_PKT_CONNACK:
//            ePacketType = eCTRL_PKT_CONNACK;
//            break;
//        case    eCTRL_PKT_PUBLISH:
//            ePacketType = eCTRL_PKT_PUBLISH;
//            break;
//        case    eCTRL_PKT_PUBACK:
//            ePacketType = eCTRL_PKT_PUBACK;
//            break;
//        case    eCTRL_PKT_PUBREC:
//            ePacketType = eCTRL_PKT_PUBREC;
//            break;
//        case    eCTRL_PKT_PUBREL:
//            ePacketType = eCTRL_PKT_PUBREL;
//            break;
//        case    eCTRL_PKT_PUBCOMP:
//            ePacketType = eCTRL_PKT_PUBCOMP;
//            break;
//        case    eCTRL_PKT_SUBSCRIBE:
//            ePacketType = eCTRL_PKT_SUBSCRIBE;
//            break;
//        case    eCTRL_PKT_SUBACK:
//            ePacketType = eCTRL_PKT_SUBACK;
//            break;
//        case    eCTRL_PKT_UNSUBSCRIBE:
//            ePacketType = eCTRL_PKT_UNSUBSCRIBE;
//            break;
//        case    eCTRL_PKT_UNSUBACK:
//            ePacketType = eCTRL_PKT_UNSUBACK;
//            break;
//        case    eCTRL_PKT_PINGREQ:
//            ePacketType = eCTRL_PKT_PINGREQ;
//            break;
//        case    eCTRL_PKT_PINGRESP:
//            ePacketType = eCTRL_PKT_PINGRESP;
//            break;
//        case    eCTRL_PKT_DISCONNECT:
//            ePacketType = eCTRL_PKT_DISCONNECT;
//            break;
//        default:
//            ePacketType = 0;
//            break;
//    }
//
//    return ePacketType;
//}

//enum CONNECT_RETURN_CODE_ENUM enCONNACK_Response ( uint8_t *punBuffer)  //  In Response to CONNECT Packet
//{
//    enum CONNECT_RETURN_CODE_ENUM eResponse;
//    uint8_t unByte = punBuffer[3];
//    switch(unByte)
//    {
//        case    eCN_ACCEPTED:
//            eResponse = eCN_ACCEPTED;
//            break;
//        case    eCN_RFS_INVALID_PROT_VERSION:
//            eResponse = eCN_RFS_INVALID_PROT_VERSION;
//            break;
//        case    eCN_RFS_INVALID_IDENTIFIER:
//            eResponse = eCN_RFS_INVALID_IDENTIFIER;
//            break;
//        case    eCN_RFS_SERVER_UNAVAILABLE:
//            eResponse = eCN_RFS_SERVER_UNAVAILABLE;
//            break;
//        case    eCN_RFS_INVALID_USERNAME_PSWD:
//            eResponse = eCN_RFS_INVALID_USERNAME_PSWD;
//            break;
//        case    eCN_RFS_NOT_AUTHORIZED:
//            eResponse = eCN_RFS_NOT_AUTHORIZED;
//            break;
//        default:
//            eResponse = 0x06;   //Forbidden
//            break;
//    }
//    return eResponse;
//}

//uint16_t udPUBACK_Response (uint8_t *punBuffer) // In case of QOS-1, In response to PUBLISH Packet
//{
//    uint16_t udTemp = punBuffer[2];
//    udTemp  <<= 8;
//    udTemp |=  punBuffer[3];
//    return udTemp;
//}

//uint16_t udPUBREC_Response (uint8_t *punBuffer) // In case of QOS-2, In response to PUBLISH Packet
//{
//    uint16_t udTemp = punBuffer[2];
//    udTemp  <<= 8;
//    udTemp |=  punBuffer[3];
//    return udTemp;
//}



//uint16_t udPUBCOMP_Response (uint8_t *punBuffer) // In case of QOS-2, In response to PUBREL (Publish Release)Packet
//{
//    uint16_t udTemp = punBuffer[2];
//    udTemp  <<= 8;
//    udTemp |=  punBuffer[3];
//    return udTemp;
//}

//struct SUBACK_RETURN_PARAM_STRUCT   stSUBACK_Response (uint8_t *punBuffer)
//{
//    struct SUBACK_RETURN_PARAM_STRUCT   stParam;
//    stParam.udPacketIdentifier  =   punBuffer[2];   // Most Significant Byte of Packet Identifier in SUBACK Packet
//    stParam.udPacketIdentifier  <<= 8;
//    stParam.udPacketIdentifier  |=   punBuffer[3];  // Least Significant Byte of Packet Identifier in SUBACK Packet
//    stParam.unReturnCode    =   punBuffer[4];
//
//    return stParam;
//}

//uint16_t udUNSUBACK_Response (uint8_t *punBuffer) // In Response to UNSUBSCRIBE Packer sent by Client, server/Broker Responds with UNSUBACK Packet
//{
//    uint16_t udTemp = punBuffer[2];
//    udTemp  <<= 8;
//    udTemp |=  punBuffer[3];
//    return udTemp;
//}
//
//bool bPINRESP_Response(uint8_t *punBuffer)  // In response to PINREQ sent by Client, Server/Broker Responds with PINGRESP to show that it is alive as well
//{
//    if((punBuffer[0] ==  0xD0) && (punBuffer[1] ==  0x00))
//        return TRUE;
//    else
//        return FALSE;
//}

uint32_t ulDecodedLength (uint8_t * punLength)
{
  uint32_t multiplier = 1;
  uint32_t value = 0;
  uint8_t  i = 0;

  do
    {
        value += (punLength[i] & 0x7F) * multiplier;
	    multiplier *= 0x80;
	    if (multiplier > (0x80 * 0x80 * 0x80))
	    {
	        return value;
	    }
	} while ((punLength[i++] & 0x80) != 0 && i < 4);

    return value;
}
//===================================================================================
//                         			END OF FILE
//===================================================================================

/* uint8_t unGetEncodedBytesLength ( uint32_t unLength )
{
	uint32_t ulencodedByte = 0;
	uint8_t i = 0;
	do
	{
		ulencodedByte |= ((unLength % 128) << (i*8));
		unLength = unLength / 128;
		// if there are more data to encode, set the top bit of this byte
		if ( unLength > 0 )
		{
			ulencodedByte |= (128 << (i*8));
		}
	    i++;
	 }while ( unLength > 0 );

	 return i; //number of Bytes containing Length in UTF-8 formate
}
 */
/* uint32_t ulEncodedLength ( uint32_t unLength )
{
	uint32_t ulencodedBytes = 0;
	uint8_t i = 0;
	do
	{
		ulencodedBytes |= ((unLength % 128) << (i*8));
		unLength = unLength / 128;
		// if there are more data to encode, set the top bit of this byte
		if ( unLength > 0 )
		{
			ulencodedBytes |= (128 << (i*8));
		}
		else
		{
			return ulencodedBytes
		}
	    i++;
	 }while ( unLength > 0 );

} */
