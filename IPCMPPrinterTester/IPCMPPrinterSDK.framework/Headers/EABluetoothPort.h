//
//  EABluetoothPort.h
//  IPCMPPrinterSDK
//
//  Created by Infinite Peripherals on 6/20/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ExternalAccessory/ExternalAccessory.h>

extern NSString * EADSessionDataReceivedNotification;
extern NSString * const EAAccessoryDidConnectNotification;
extern NSString * const EAAccessoryDidDisconnectNotification;

@interface EABluetoothPort : NSObject <EAAccessoryDelegate, NSStreamDelegate>
{
    EAAccessory *_accessory;
    EASession *_session;
    NSString *_protocolString;
    
    NSMutableData *_wData;
    NSMutableData *_rData;
}

+ (EABluetoothPort *)sharedController;

- (void)setupControllerForAccessory:(EAAccessory *)accessory withProtocolString:(NSString *)protocolString;
- (BOOL)openSession;
- (void)closeSession;
- (void)closeSessionWait;
- (void)closeSessionReset;
- (long)readBytesAvailable;
- (NSData *)readData:(NSUInteger)bytesToRead;
- (void)writeData:(unsigned char *)data charsToSend:(int)length;

@end
