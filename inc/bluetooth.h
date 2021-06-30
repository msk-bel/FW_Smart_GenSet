#ifndef __BLUETOOTH_H
#define __BLUETOOTH_H

#include <string.h>
#include "uart_service.h"

void vHandle_BT_Add_Device_Flow(void);
void vSend_Data_Over_SPP(char *, uint8_t, bool);

extern uint8_t aunIMEI[20];
extern uint8_t PASS_KEY[16];

enum ADD_FLOW_STATE_ENUM
{
    AFD_Idle,              // Add Flow Device has not started yet
    AFD_BTPIN_REQ_Recv,    // Start of Add Device flow, User has send sms requesting BT PIN
    AFD_PASSKEY_REQ_Sent,  // Kit has send SMS to user asking for Private Key (to enusre user is authenticated)
    AFD_PASSKEY_Recv,      // User has sent a Pass Key through SMS
    AFD_PASSKEY_Ok,        // User Pass Key is Authentic, Kit has saved User number as owner of Kit.
    AFD_BTPIN_Sent,        // Kit upon authenticating user, sends BT PIn so that user can connect to BT of KIT
    AFD_BT_PAIR_Ok,        // User has successfully paired with Kits BT
    AFD_BT_SPP_REQ_Recv,   // User has requested (through APP over Bluetooth) to connect to Kit on SPP Mode
    AFD_BT_SPP_REQ_Accept, // Kit has accepted user request to connect to KIT via SPP mode
    AFD_BT_SPP_Connected,  // User has been connected on SPP mode via Bluetooth, Kit remeberes User profile i.e. MAC, device name etc.
    AFD_IMEI_REQ_Recv,     // User has requested for IMEI of Kit to sent it to cloud, so that cloud can register the kit
    AFD_IMEI_Sent,         // Kit has sent IMEI to User over BT
    AFD_DATA_REQ_Recv,     // User has request for additional data from kit
    AFD_DATA_Sent,         // Kit has sent the detailed data {IMEI, SIM Number, User number, User mac, user device name, Kit state etc.}
    AFD_Done               // Add flow device has been completed, disconnect and unpair user automatically but remeber its credentials
};

extern enum ADD_FLOW_STATE_ENUM enAddFlowState;

#endif