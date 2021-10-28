//================================= File Header =====================================
//  C Language Source file
//===================================================================================
//                  			 MODULE  INFORMATION
//===================================================================================
//  $ Source:  gps_service.c $
//
//  $ Date Last Modified: 27 Oct 2021  $
//
//  $ Revision:  $
//===================================================================================
//                          FILE DESCRIPTION (for DOXYGEN)
//===================================================================================
//  $ Version 1.0: $Start Date:( 27 Oct 2021 )  $End Date:( 29 Oct 2021 )
//  $ Written By    - Saqib Kamal $
//  $ Designation   - Embedded System Engineer $
//  $ Company       - BlueEast $
//
//===================================================================================
//               			DESCRIPTION OF VERSIONS
//===================================================================================
//----------------------------    $ Version - 1.0 $  ------------------------------//
//Add desciption here
//---------------------------------------------------------------------------------//

//===================================================================================
//                       		BEGENING OF CODE
//===================================================================================
//The acutal code related h/c file portion starts from here.

//===================================================================================
//                        		INCLUDE  FILES
//===================================================================================
#include "gps_service.h"
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

struct GPS_COORDINATES_STRUCT
{
    uint8_t gps_latitude[11];  //e.g	31.388905
    uint8_t gps_longitude[12]; //e.g	74.149936
} stGPS_Coordinates;

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
void vTurnGPSOn(bool temp);
bool bIsGPSTurnedON(void);
//===================================================================================
//                			 GLOBAL/EXTERNAL FUNCTIONS
//===================================================================================
void gps_data(void);
uint8_t *getGPS_Latitude(void);
uint8_t *getGPS_Longitude(void);

//===================================================================================
//        					LOCAL FUNCTIONS CODE SECTION
//===================================================================================

//===================================================================================
//   				  GLOBAL/EXTERNAL FUNCTIONS CODE SECTION
//===================================================================================
bool bIsGPSTurnedON(void)
{
    ms_send_cmd(GNSS_CHECK_STATE, strlen((const char *)GNSS_CHECK_STATE));
    delay_ms(500);
    if (strstr(response_buffer, "+QGPS: 1"))
        return 1;
    else
        return 0;
}

void vTurnGPSOn(bool temp)
{
    if (temp)
    {
        ms_send_cmd(GNSS_TURN_GPS_ON, strlen((const char *)GNSS_TURN_GPS_ON));
        delay_ms(500);
        ms_send_cmd(GNSS_TURN_AGPS_ON, strlen((const char *)GNSS_TURN_AGPS_ON));
        delay_ms(500);
    }
    else
    {
        ms_send_cmd(GNSS_TURN_GPS_OFF, strlen((const char *)GNSS_TURN_GPS_OFF));
        delay_ms(500);
    }
}

void gps_data(void)
{
    char gps_buffer[100]; //total 94 characters as per datasheet, 95th for Q,96th for null
    uint8_t r = 0, x = 0, y = 0, z = 0, w = 0, p = 0, k = 0, i = 0;
    uint16_t while_timeout = 0;
    char loc[56] = "http://maps.google.com/maps?q=loc:"; // added 4 charachters
                                                         //    int occ[20];
    static uint8_t iteration = 0;

    if (iteration > 10)
    {
        ms_send_cmd(NOECHO, strlen((const char *)NOECHO));
        delay_ms(200);

        while (!bIsGPSTurnedON() && (++while_timeout != 10))
        {
            vTurnGPSOn(TRUE);
            delay_ms(1000);
        }
        for (r = 0; r < 100; r++)
        {
            gps_buffer[r] = '0';
        }

        ms_send_cmd(GNSS_GET_LOCATION, strlen((const char *)GNSS_GET_LOCATION));
        delay_ms(200);
        if (strstr(response_buffer, "+QGPSLOC:"))
        {
            for (x = 0; x < 100; x++)
            {
                gps_buffer[x] = response_buffer[x];
            }
            // Extract Data: Time , Data from buffer
            x = 0;
            while (gps_buffer[x] != ',')
                x++; //Ignore First parameter i.e Run status
            x++;
            i = 0;
            while (gps_buffer[x] != ',') // 4th Parameter:	 Latitude
            {
                if (i < 10)
                {
                    stGPS_Coordinates.gps_latitude[i] = gps_buffer[x];
                }
                x++;
                i++;
            }
            x++;
            i = 0;
            vClearBuffer(stGPS_Coordinates.gps_longitude, 11);
            while (gps_buffer[x] != ',') // 5th Parameter:	 Longitude
            {
                if (i < 11)
                {
                    stGPS_Coordinates.gps_longitude[i] = gps_buffer[x];
                }
                x++;
                i++;
            }
        }
        else
        {
            //vRefresh_IWDT();//Feed Watchdog
            vClearBuffer(stGPS_Coordinates.gps_latitude, 11);
            vClearBuffer(stGPS_Coordinates.gps_longitude, 12);
            strcpy(stGPS_Coordinates.gps_latitude, "1111111111");
            strcpy(stGPS_Coordinates.gps_longitude, "11111111111");
        }
        iteration = 0;
    }
    iteration++;
}

uint8_t *getGPS_Latitude(void)
{
    return stGPS_Coordinates.gps_latitude;
}

uint8_t *getGPS_Longitude(void)
{
    return stGPS_Coordinates.gps_longitude;
}

//===================================================================================
//                         			END OF FILE
//===================================================================================
