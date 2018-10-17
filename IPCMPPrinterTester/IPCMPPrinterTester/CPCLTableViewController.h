//
//  CPCLTableViewController.h
//  IPCMPPrinterTester
//
//  Created by Lucas Netal on 6/29/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IPCMPPrinterSDK/IPCMPPrinterSDK.h>
#import "Constants.h"

@interface CPCLTableViewController : UITableViewController

- (id)initWithCPCLPrinter:(IPCCPCLPrinter *)printer withConnection:(CONNECTION_TYPE)connection;

@end

