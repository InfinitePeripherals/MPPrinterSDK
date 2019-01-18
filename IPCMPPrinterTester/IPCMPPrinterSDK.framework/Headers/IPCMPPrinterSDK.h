/********************************************* QUICK START *********************************************
 *
 *
 * Required:
 *      - Add IPCMPPrinterSDK.framework to the Embedded Binaries section of the Project's General tab.
 *      - Add InfineaSDK.framework to the Embedded Binaries section of the Project's General tab.
 *      - Add ExternalAccessory.framework to the Linked Frameworks and Libraries section.
 *      - Add CoreLocation.framework to the Linked Frameworks and Libraries section.
 *
 * To communicate with MP Printers from Infinite Peripherals the following settings need to be in place.
 *
 * 1) Project Settings - Info.plist: Add the following custom properties.
 *                                      - Key: UISupportedExternalAccessoryProtocols
 *                                          - Value: com.mobileprinter.datapath
 *                                      - Key: NSLocationWhenInUseUsageDescription
 *                                          - Value: Any string
 *                                      - Key: NSLocationAlwaysAndWhenInUseUsageDescription
 *                                          - Value: Any string
 *
 *
 *******************************************************************************************************/


#import <UIKit/UIKit.h>

//! Project version number for IPCMPPrinterSDK.
FOUNDATION_EXPORT double IPCMPPrinterSDKVersionNumber;

//! Project version string for IPCMPPrinterSDK.
FOUNDATION_EXPORT const unsigned char IPCMPPrinterSDKVersionString[];

#import <IPCMPPrinterSDK/IPCCPCLPrinter.h>
#import <IPCMPPrinterSDK/IPCESCPOSPrinter.h>
#import <IPCMPPrinterSDK/IPCZPLPrinter.h>

#import <IPCMPPrinterSDK/EABluetoothPort.h>
#import <IPCMPPrinterSDK/POSPrinterFinder.h>
#import <IPCMPPrinterSDK/PortDirect.h>
#import <IPCMPPrinterSDK/CallbackData.h>
