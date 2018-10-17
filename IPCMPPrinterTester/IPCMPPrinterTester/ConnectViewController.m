//
//  ConnectViewController.m
//  IPCMPPrinterTester
//
//  Created by Lucas Netal on 6/25/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import "ConnectViewController.h"
#import "CPCLTableViewController.h"
#import "ESCPOSTableViewController.h"
#import "ZPLTableViewController.h"
#import <IPCMPPrinterSDK/IPCMPPrinterSDK.h>
#import "Constants.h"

@interface ConnectViewController ()

@property (weak, nonatomic) IBOutlet UITextField *printerAddress;
@property (weak, nonatomic) IBOutlet UITextField *ipAddress;
@property (weak, nonatomic) IBOutlet UITextField *portNumber;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)connectBluetooth:(id)sender {
    switch ([self.segControl selectedSegmentIndex]) {
        case 0:
            [self connectCPCL:CONN_BT];
            break;
        case 1:
            [self connectESCPOS:CONN_BT];
            break;
        case 2:
            [self connectZPL:CONN_BT];
            break;
        default:
            break;
    }
}

- (IBAction)connectWIFI:(id)sender {
    switch ([self.segControl selectedSegmentIndex]) {
        case 0:
            [self connectCPCL:CONN_WIFI];
            break;
        case 1:
            [self connectESCPOS:CONN_WIFI];
            break;
        case 2:
            [self connectZPL:CONN_WIFI];
            break;
        default:
            break;
    }
}

- (void)connectCPCL:(CONNECTION_TYPE)connType {
    NSString *address = self.printerAddress.text;
    int port = 9100;
    
    if (connType == CONN_WIFI) {
        address = self.ipAddress.text;
        port = [self.portNumber.text intValue];
    }
    
    long errCode = 0;
    IPCCPCLPrinter *cpclPrinter = [[IPCCPCLPrinter alloc] init];
    
    if ((errCode = [cpclPrinter openPort:address withPortParam:port]) >= 0) {
        NSLog(@"Connection Established");
        
        CPCLTableViewController *sampleView = [[CPCLTableViewController alloc] initWithCPCLPrinter:cpclPrinter withConnection:connType];
        [self presentViewController:sampleView animated:YES completion:nil];
    }
    else if (errCode == -3) {
        NSLog(@"ERROR: Invalid device");
    }
    else {
        NSLog(@"ERROR: Connection error");
    }
}

- (void)connectESCPOS:(CONNECTION_TYPE)connType {
    NSString *address = self.printerAddress.text;
    int port = 9100;
    
    if (connType == CONN_WIFI) {
        address = self.ipAddress.text;
        port = [self.portNumber.text intValue];
    }
    
    long errCode = 0;
    IPCESCPOSPrinter *escposPrinter = [[IPCESCPOSPrinter alloc] init];
    
    if ((errCode = [escposPrinter openPort:address withPortParam:port]) >= 0) {
        NSLog(@"Connection Established");
        
        ESCPOSTableViewController *sampleView = [[ESCPOSTableViewController alloc] initWithESCPOSPrinter:escposPrinter withConnection:connType];
        [self presentViewController:sampleView animated:YES completion:nil];
    }
    else if (errCode == -3) {
        NSLog(@"ERROR: Invalid device");
    }
    else {
        NSLog(@"ERROR: Connection error");
    }
}

- (void)connectZPL:(CONNECTION_TYPE)connType {
    NSString *address = self.printerAddress.text;
    int port = 9100;
    
    if (connType == CONN_WIFI) {
        address = self.ipAddress.text;
        port = [self.portNumber.text intValue];
    }
    
    long errCode = 0;
    IPCZPLPrinter *zplPrinter = [[IPCZPLPrinter alloc] init];
    
    if ((errCode = [zplPrinter openPort:address withPortParam:port]) >= 0) {
        NSLog(@"Connection Established");
        
        ZPLTableViewController *sampleView = [[ZPLTableViewController alloc] initWithZPLPrinter:zplPrinter withConnection:connType];
        [self presentViewController:sampleView animated:YES completion:nil];
    }
    else if (errCode == -3) {
        NSLog(@"ERROR: Invalid device");
    }
    else {
        NSLog(@"ERROR: Connection error");
    }
}

@end
