//
//  CallbackData.h
//  IPCMPPrinterSDK
//
//  Created by Infinite Peripherals on 6/20/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallbackData : NSObject 
{
	int dataType;
	NSData *data;
	int dataLength;
}

@property (nonatomic) int dataType;
@property (copy, nonatomic) NSData *data;
@property (nonatomic) int dataLength;

- (id)initWithData:(NSData *)data withLength:(int)length withType:(int)type;
- (void)dealloc;

@end
