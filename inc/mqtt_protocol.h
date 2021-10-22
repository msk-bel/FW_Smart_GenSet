//================================= File Header =====================================
//  C Language Header file
//===================================================================================
//                  			 MODULE  INFORMATION
//===================================================================================
//  $ Source:  mqtt_protocol.h $
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
#ifndef MQTT_PROTOCOL_H_INCLUDE
#define MQTT_PROTOCOL_H_INCLUDE
//===================================================================================
//                        		INCLUDE  FILES
//===================================================================================
/*
    Add or Remove System Libraries for C depending upon the compiler environment.
*/
#include "board.h"
#include <string.h>
#include "stm8s_delay.h"
#include "uart_service.h"
//#include <stdio.h>
//#include <stdlib.h>
//#include <stdint.h>
//#include <stdbool.h>
//===================================================================================
//                               	PRAGMA
//===================================================================================

//===================================================================================
//                     	  EXTERNAL CONSTANTS & MACROS
//===================================================================================
#ifdef MODULE_SIMCOM_SIM868
/*
    Must Select following MACROS before compiling this code. These
    following MACROS are Implementation Dependent
*/
#define KEEP_ALIVE_TIMEOUT  60	//Seconds
#define PROTOCOL_NAME       "MQTT"  //Most Brokers/Server Demand PROTOCOL_NAME as "MQTT", otherwise change it to required Name
#define PROTOCOL_LEVEL      0x04    //Most Brokers/Server Demand PROTOCOL_LEVEL as 0x04, otherwise change it to required level
#endif
//===================================================================================
//                                EXTERNAL ENUMS
//===================================================================================
#ifdef MODULE_SIMCOM_SIM868
/*
    MQTT_QOS_ENUM represent Type of QOS-Level of MQTT. However mostly QOS_0 is used,
    so this can be ignored and chooses constant value of 0 for QOS_0.
*/

typedef enum MQTT_QOS_ENUM
{
	eQOS_0		=	0,	//At most once delivery
	eQOS_1		=	1,	//t least once delivery
	eQOS_2		=	2,	//Exactly once delivery
	eQOS_Error	=	3	//Forbidden/Error
}enMQTT_QOS;


/*
    MQTT_CTRL_PKT_TYPE_ENUM represents enum data type containing constant of Control Packet
    Types which form the most significant nibble of very first Byte of Every MQTT control packet.
*/
typedef enum MQTT_CTRL_PKT_TYPE_ENUM	// 1st Byte in every Control Packet, bits 7-4.
{
	eCTRL_PKT_RESERVED		=	0,	//Forbidden/Reserved
	eCTRL_PKT_CONNECT		=	1,	//Client to Server: Client request to connect to Server
	eCTRL_PKT_CONNACK		=	2,	//Server to Client: Connect acknowledgment
	eCTRL_PKT_PUBLISH		=	3,	//Client to Server or Server to Client: Publish message
	eCTRL_PKT_PUBACK		=	4,	//Client to Server or Server to Client: Publish acknowledgment
	eCTRL_PKT_PUBREC		=	5,	//Client to Server or Server to Client: Publish received (assured delivery part 1)
	eCTRL_PKT_PUBREL		=	6,	//Client to Server or Server to Client: Publish release (assured delivery part 2)
	eCTRL_PKT_PUBCOMP		=	7,	//Client to Server or Server to Client: Publish complete (assured delivery part 3)
	eCTRL_PKT_SUBSCRIBE		=	8,	//Client to Server: Client subscribe request
	eCTRL_PKT_SUBACK		=	9,	//Server to Client: Subscribe acknowledgment
	eCTRL_PKT_UNSUBSCRIBE	=	10,	//Client to Server: Unsubscribe request
	eCTRL_PKT_UNSUBACK		=	11,	//Server to Client: Unsubscribe acknowledgment
	eCTRL_PKT_PINGREQ		=	12,	//Client to Server: PING request
	eCTRL_PKT_PINGRESP		=	13,	//Server to Client: PING response
	eCTRL_PKT_DISCONNECT	=	14,	//Client to Server: Client is disconnecting
	eCTRL_PKT_RESERVED_E    =	15	//Forbidden/Reserved
}enMQTT_CTRL_PKT_TYPE;


/*
    MQTT_CTRL_PKT_FLAGS_ENUM represents enum data type containing constant of Control Packet
    Flags which form the least significant nibble of very first Byte of Every MQTT control packet.
*/
typedef enum MQTT_CTRL_PKT_FLAGS_ENUM	// 1st Byte in every Control Packet, bits 3-0.
{
	eCTRL_PKT_FLAG_CONNECT			=	0,
	eCTRL_PKT_FLAG_CONNACK			=	0,
	eCTRL_PKT_FLAG_PUBLISH_D0_0_R0	=	0,	// DUP = 0, QOS = 0, RETAIN = 0
	eCTRL_PKT_FLAG_PUBLISH_D0_0_R1	=	1,	// DUP = 0, QOS = 0, RETAIN = 1
	eCTRL_PKT_FLAG_PUBLISH_D0_1_R0	=	2,	// DUP = 0, QOS = 1, RETAIN = 0
	eCTRL_PKT_FLAG_PUBLISH_D0_1_R1	=	3,	// DUP = 0, QOS = 1, RETAIN = 1
	eCTRL_PKT_FLAG_PUBLISH_D1_1_R0	=	10,	// DUP = 1, QOS = 1, RETAIN = 0
	eCTRL_PKT_FLAG_PUBLISH_D1_1_R1	=	11,	// DUP = 1, QOS = 1, RETAIN = 1
	eCTRL_PKT_FLAG_PUBLISH_D0_2_R0	=	4,	// DUP = 0, QOS = 2, RETAIN = 0
	eCTRL_PKT_FLAG_PUBLISH_D0_2_R1	=	5,	// DUP = 0, QOS = 2, RETAIN = 1
	eCTRL_PKT_FLAG_PUBLISH_D1_2_R0	=	12,	// DUP = 1, QOS = 2, RETAIN = 0
	eCTRL_PKT_FLAG_PUBLISH_D1_2_R1	=	13,	// DUP = 1, QOS = 2, RETAIN = 1
	eCTRL_PKT_FLAG_PUBACK			=	0,
	eCTRL_PKT_FLAG_PUBREC			=	0,
	eCTRL_PKT_FLAG_PUBREL			=	2,
	eCTRL_PKT_FLAG_PUBCOMP			=	0,
	eCTRL_PKT_FLAG_SUBSCRIBE		=	2,
	eCTRL_PKT_FLAG_SUBACK			=	0,
	eCTRL_PKT_FLAG_UNSUBSCRIBE		=	2,
	eCTRL_PKT_FLAG_UNSUBACK			=	0,
	eCTRL_PKT_FLAG_PINGREQ			=	0,
	eCTRL_PKT_FLAG_PINGRESP			=	0,
	eCTRL_PKT_FLAG_DISCONNECT		=	0
}enMQTT_CTRL_PKT_FLAGS;

/*
    CONNECT_RETURN_CODE_ENUM consists of constant having the return codes Server/Broker sends in CONNACK Packet
    in response to CONNECT Packet earlier send by Client.
*/
typedef enum CONNECT_RETURN_CODE_ENUM
{
    eCN_ACCEPTED                    =   0x00,   //Connection accepted
    eCN_RFS_INVALID_PROT_VERSION    =   0x01,   //The Server does not support the level of the MQTT protocol requested by the Client
    eCN_RFS_INVALID_IDENTIFIER      =   0x02,   //The Client identifier is correct UTF-8 but not allowed by the Server
    eCN_RFS_SERVER_UNAVAILABLE      =   0x03,   //The Network Connection has been made but the MQTT service is unavailable
    eCN_RFS_INVALID_USERNAME_PSWD   =   0x04,   //The data in the user name or password is malformed
    eCN_RFS_NOT_AUTHORIZED          =   0x05    //The Client is not authorized to connect
}enCONNECT_RETURN_CODES;
#endif
//===================================================================================
//                        		EXTERNAL STRUCTURES
//===================================================================================
#ifdef MODULE_SIMCOM_SIM868
/*
    SUBACK_RETURN_PARAM_STRUCT contains 2 Byte wide Packet Identifier which should be same as send in the SUBSCRIBE Packet
    by Client & Return Code which is,
    -0x00 for Successful QOS_0 subscription
    -0x01 for Successful QOS_1 subscription
    -0x02 for Successful QOS_2 subscription
    -0x80 for Failure in Subscription
*/
typedef struct SUBACK_RETURN_PARAM_STRUCT
{
    uint16_t    udPacketIdentifier;
    uint8_t     unReturnCode;
}stSUBACK_RETURN_PARAM;
#endif
//===================================================================================
//                        			EXTERNAL DATA
//===================================================================================

//===================================================================================
//                			 GLOBAL/EXTERNAL FUNCTIONS
//===================================================================================
#ifdef MODULE_SIMCOM_SIM868
/*
    punEncodeLength takes max 4 bytes length as an argument and return the length in
    UTF-8 encoded formate as a pointer to a maximum 4 byte array.
*/
extern uint8_t *punEncodeLength (uint32_t ulLength);

/*
    ulDecodedLength takes 4 bytes array UTF-8 encoded length as an argument and
    return the length in 4 byte raw decoded formate.
*/
extern uint32_t ulDecodedLength (uint8_t * punLength);

/*
    ulMQTT_Connect is used to connect to MQTT broker/server after TCP/IP connection to
    broker has been established.
    Inputs:
        1-  punBuffer           ->  Buffer to store CONNECT Packet, so that it can be used outside this function
                                    Its size should be enough to store maximum possible length of CONNECT Packet.
        2-  punClientIdentifier ->  ClientID to distinguish Client on Broker. i.e. AplhaNumeric Null terminated string.
        3-  enMQTT_QOS          ->  QOS Level. Refer to eQOS_X in MQTT_QOS_ENUM
        4-  bCleanSessionFlag   ->  Session save Flag. Server/Broker saves state if set to 1, otherwise considers new connection
                                    By default it is set to 1, so broker always treat new connection as new.
        5-  punWillTopic        ->  Topic To publish LastWILL (if bWillFlag = true). i.e. Null terminated string
        6-  punWillMessage      ->  Message to publish as last will (if bWillFlag = true). i.e. Null terminated string.
        7-  punUsername         ->  username used in authentication connection (if bUserNameFlag = 1).i.e. Null terminated string.
        8-  punPassword         ->  password used in authentication connection (if bPasswordFlag = 1).i.e. Null terminated string.
        9-  bUserNameFlag       ->  If It is set, username should be passed as an argument
        10- bPasswordFlag       ->  If It is set, password should be passed as an argument
        11- bWillFlag           ->  If It is set, WILL message, topic should be passed as an argument
        12- bWillRetainFlag     ->  If It is set, Server/Broker retains LAST WILL TESTAMENT.
        NOTE:   arguments 5-12 can be ignored or passed as false/null in case of QOS_0
    Outputs:
        1-  punBuffer   -> Buffer containing the whole CONNECT Packet
        2-  ulLength    ->  Length in Bytes of CONNECT Packet
 */
extern uint32_t ulMQTT_Connect ( uint8_t *punBuffer, uint8_t *punClientIdentifier/*,
									bool bUserNameFlag, bool bPasswordFlag,
									bool bWillFlag, bool bWillRetainFlag,
									bool bCleanSessionFlag, enMQTT_QOS eWill_QOS,
									uint8_t *punWillTopic, uint8_t *punWillMessage,
									uint8_t *punUsername, uint8_t *punPassword*/	);

/*
    ulMQTT_Publish is used to publish message to specific topic on broker/server.
    Inputs:
        1-  punBuffer   ->  Buffer to store Publish Packet, so that it can be used outside this function
                            Its size should be enough to store maximum possible length of Publish Packet.
        2-  punTopic    ->  Topic to which message to be published. i.e. a null terminated string.
        3-  punMessage  ->  Message to be published on specific topic i.e. a null terminated string.
        4-  enMQTT_CTRL_PKT_FLAGS   ->  A Flag containing {Duplicate, QOS, Retain}, Refer to
                                        eCTRL_PKT_FLAG_PUBLISH_DX_X_RX Flags in MQTT_CTRL_PKT_FLAGS_ENUM.
    Outputs:
        1-  punBuffer   -> Buffer containing the whole PUBLISH Packet
        2-  ulLength    ->  Length in Bytes of PUBLISH Packet
*/
extern uint32_t ulMQTT_Publish ( uint8_t *punBuffer, uint8_t *punTopic, uint8_t *punMessage/*, enMQTT_CTRL_PKT_FLAGS ePublishFlags */);

/*
    ulMQTT_Subscribe is used to subscribe to specific topic on broker/server.
    Inputs:
        1-  punBuffer   ->  Buffer to store SUBSUCRIBE Packet, so that it can be used outside this function
                            Its size should be enough to store maximum possible length of SUBSUCRIBE Packet.
        2-  punTopic    ->  Topic to be subscribed. i.e. a null terminated string.
        4-  udPacketIdentifier   ->  2 Byte Value Containing Packer Identifier. Can be anything but should remain same
                                        for same subscribe packet.
    Outputs:
        1-  punBuffer   -> Buffer containing the whole SUBSCRIBE Packet
        2-  ulLength    ->  Length in Bytes of SUBSCRIBE Packet
*/
extern uint32_t ulMQTT_Subscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, enMQTT_QOS eQOS, uint16_t udPacketIdentifier */);

/*
    ulMQTT_UnSubscribe is used to Un-subscribe to already subscribed topic on broker/server.
    Inputs:
        1-  punBuffer   ->  Buffer to store UNSUBSUCRIBE Packet, so that it can be used outside this function
                            Its size should be enough to store maximum possible length of UNSUBSUCRIBE Packet.
        2-  punTopic    ->  Topic to be un-subscribed. i.e. a null terminated string.
        4-  udPacketIdentifier   ->  2 Byte Value Containing Packer Identifier. should be same as used during
                                        topic subscription.
    Outputs:
        1-  punBuffer   -> Buffer containing the whole UNSUBSCRIBE Packet
        2-  ulLength    ->  Length in Bytes of UNSUBSCRIBE Packet
*/
extern uint32_t ulMQTT_UnSubscribe ( uint8_t *punBuffer, uint8_t *punTopic/*, uint16_t udPacketIdentifier*/ );

/*
    unMQTT_PingRequest is used to PING broker/server to keep the connection alive. It should be send withing
    KEEP ALIVE TIMOUT Limit if there is no other Control Packet is being sent to broker/Server.
    Inputs:
        1-  punBuffer   ->  Buffer to store PINGREQ Packet, so that it can be used outside this function
                            Its size should be enough to store maximum possible length of PINGREQ Packet.
    Outputs:
        1-  punBuffer   -> Buffer containing the whole PINGREQ Packet
        2-  ulLength    ->  Length in Bytes of PINGREQ Packet, i.e. 2
*/
extern uint8_t unMQTT_PingRequest ( uint8_t *punBuffer );

/*
    unMQTT_Disconnect is used to Disconnect client from broker/server cleanly
    Inputs:
        1-  punBuffer   ->  Buffer to store DISCONNECT Packet, so that it can be used outside this function
                            Its size should be enough to store maximum possible length of DISCONNECT Packet.
    Outputs:
        1-  punBuffer   -> Buffer containing the whole DISCONNECT Packet
        2-  ulLength    ->  Length in Bytes of DISCONNECT Packet, i.e. 2
*/
extern uint8_t unMQTT_Disconnect ( uint8_t *punBuffer );

/*
    unPUBREL (Publish Release)is Sent by Client to Server in case of QOS_2 when server responds with PUBREC Packet in response to PUBLISH Packet.
    Inputs:
        1-  punBuffer           ->  Buffer to store PUBREL Packet, so that it can be used outside this function
                                    Its size should be enough to store maximum possible length of PUBREL Packet.
        2-  udPacketIdentifier  ->  2 Byte Packet Identifier same as earlier send in PUBLISH Packet by Client and PUBREC Packet by Server
    Outputs:
        1-  punBuffer   -> Buffer containing the whole PUBREL Packet
        2-  ulLength    ->  Length in Bytes of PUBREL Packet
*/
//extern uint8_t unPUBREL ( uint8_t *punBuffer , uint16_t udPacketIdentifier);

/*
    enGetRecievedPacketType decodes Byte stream coming from Server, and return Packet Type Recieved.
    Inputs:
        1-  punBuffer                   ->  Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  MQTT_CTRL_PKT_TYPE_ENUM     -> An enum referencing to Control Packet Type recieved i.e. ranges from 0-15
*/
//extern enum MQTT_CTRL_PKT_TYPE_ENUM enGetRecievedPacketType ( uint8_t *punBuffer);

/*
    enCONNACK_Response decodes Byte stream (that is CONNACK Packet) coming from Server, and return CONNACK Return Codes.
    Inputs:
        1-  punBuffer                   ->  Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  CONNECT_RETURN_CODE_ENUM    -> An enum referencing to CONNACK Return Codes e.g. 0x00, 0x01 to 0x05
*/
//extern enum CONNECT_RETURN_CODE_ENUM enCONNACK_Response ( uint8_t *punBuffer);

/*
    udPUBACK_Response decodes Byte stream (that is PUBACK Packet in QOS-1) coming from Server, in response to PUBLISH Packet sent
    by Client in QOS-1.
    Inputs:
        1-  punBuffer             -> Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  udPacketIdentifier    -> 2 Byte Wide Packet Identifier which should be same as send by packet in response to which this
                                        packet was recieved.
*/
//extern uint16_t udPUBACK_Response (uint8_t *punBuffer);

/*
    udPUBREC_Response decodes Byte stream (that is PUBREC Packet in QOS-2) coming from Server, in response to PUBLISH Packet sent
    by Client in QOS-1.
    Inputs:
        1-  punBuffer             -> Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  udPacketIdentifier    -> 2 Byte Wide Packet Identifier which should be same as send by packet in response to which this
                                        packet was recieved.
*/
//extern uint16_t udPUBREC_Response (uint8_t *punBuffer);

/*
    udPUBCOMP_Response decodes Byte stream (that is PUBCOMP Packet in QOS-2) coming from Server, in response to PUBREL Packet sent
    by Client in QOS-1.
    Inputs:
        1-  punBuffer             -> Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  udPacketIdentifier    -> 2 Byte Wide Packet Identifier which should be same as send by packet in response to which this
                                        packet was recieved.
*/
//extern uint16_t udPUBCOMP_Response (uint8_t *punBuffer);

/*
    stSUBACK_Response decodes Byte stream (that is SUBACK Packet) coming from Server, in response to SUBSCRIBE Packet sent by Client.
    Inputs:
        1-  punBuffer                   -> Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  SUBACK_RETURN_PARAM_STRUCT  -> A struct containing 2 Byte Packet Identifier and 1 Byte Return Status Code that shows status of
                                            Subscription request.
*/
//extern struct SUBACK_RETURN_PARAM_STRUCT   stSUBACK_Response (uint8_t *punBuffer);

/*
    udUNSUBACK_Response decodes Byte stream (that is UNSUBACK Packet) coming from Server, in response to UNSUBSCRIBE Packet sent by Client.
    Inputs:
        1-  punBuffer             -> Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  udPacketIdentifier    -> 2 Byte Wide Packet Identifier which should be same as send by packet in response to which this
                                        packet was recieved.
*/
//extern uint16_t udUNSUBACK_Response (uint8_t *punBuffer);

/*
    bPINRESP_Response decodes Byte stream (that is PINGRESP Packet) coming from Server, in response to PINGREQ Packet sent by Client.
    Inputs:
        1-  punBuffer           -> Buffer that contains Recieved Packet from Server/Broker excluding all TCP/IP Headers/Footers.
    Outputs:
        1-  bIsServerAlive      -> Return true is server/Broker is alive, otherwise false.
*/
//extern bool bPINRESP_Response(uint8_t *punBuffer);
#endif
#ifdef MODULE_QUECTEL_EC200U
/*
    vMQTT_Connect is used to connect to MQTT broker/server after TCP/IP connection to
    broker has been established.
    Inputs:
        1-  punClientIdentifier ->  ClientID to distinguish Client on Broker. i.e. AplhaNumeric Null terminated string.
    Outputs:
        1-  void        ->  Nothing
 */
extern void vMQTT_Connect ( uint8_t *punClientIdentifier);

/*
    vMQTT_Publish is used to publish message to specific topic on broker/server.
    Inputs:
        1-  punTopic    ->  Topic to which message to be published. i.e. a null terminated string.
        2-  punMessage  ->  Message to be published on specific topic i.e. a null terminated string.
    Outputs:
        1-  void        ->  Nothing
*/
extern void vMQTT_Publish ( uint8_t *punTopic, uint8_t *punMessage);

/*
    vMQTT_Subscribe is used to subscribe to specific topic on broker/server.
    Inputs:
        1-  punTopic    ->  Topic to be subscribed. i.e. a null terminated string.
    Outputs:
        1-  void        ->  Nothing
*/
extern void vMQTT_Subscribe ( uint8_t *punTopic);

/*
    vMQTT_UnSubscribe is used to Un-subscribe to already subscribed topic on broker/server.
    Inputs:
        1-  punTopic    ->  Topic to be un-subscribed. i.e. a null terminated string.
    Outputs:
        1-  void        ->  Nothing
*/
extern void vMQTT_UnSubscribe ( uint8_t *punTopic );

/*
    unMQTT_Disconnect is used to Disconnect client from broker/server cleanly
    Inputs:
        1-  None   
    Outputs:
        1-  void        ->  Nothing
*/
extern void vMQTT_Disconnect ( void );
#endif


#endif
//===================================================================================
//                         			END OF FILE
//===================================================================================

