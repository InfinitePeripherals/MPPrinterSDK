//
//  ESCPOSTableViewController.h
//  IPCMPPrinterTester
//
//  Created by Lucas Netal on 6/29/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IPCMPPrinterSDK/IPCMPPrinterSDK.h>
#import "Constants.h"

@interface ESCPOSTableViewController : UITableViewController

- (id)initWithESCPOSPrinter:(IPCESCPOSPrinter *)printer withConnection:(CONNECTION_TYPE)connection;

@end

