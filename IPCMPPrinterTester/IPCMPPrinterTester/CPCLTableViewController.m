//
//  CPCLTableViewController.m
//  IPCMPPrinterTester
//
//  Created by Lucas Netal on 6/29/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import "CPCLTableViewController.h"

@interface CPCLTableViewController ()

@end

@implementation CPCLTableViewController
{
    IPCCPCLPrinter *cpclPrinter;
    CONNECTION_TYPE connType;
    
    NSArray *samples;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    samples = @[@"Font Type Test", @"Barcode 1D Test", @"Set Magnify Test", @"Barcode 2D Test", @"Image Test", @"Font Test", @"Concat Test", @"Multiline Test", @"Printer Status", @"Disconnect"];
    
    if (connType == CONN_BT) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusCheckReceived:) name:EADSessionDataReceivedNotification object:nil];
        [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
    }
}

- (id)initWithCPCLPrinter:(IPCCPCLPrinter *)printer withConnection:(CONNECTION_TYPE)connection {
    if (self = [super init]) {
        cpclPrinter = printer;
        connType = connection;
    }
    
    return self;
}

- (void)disconnect {
    [cpclPrinter closePort];
    
    if (connType == CONN_BT) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:EADSessionDataReceivedNotification object:nil];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Print Samples

- (void)fontTypeTest
{
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:406 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    //[cpclPrinter setMedia:CPCL_LABEL];
    
    [cpclPrinter printCPCLText:0 withFontType:0 withFontSize:0 withPrintX:1 withPrintY:1 withData:@"ABCD1234" withCount:0];
    [cpclPrinter printCPCLText:0 withFontType:1 withFontSize:0 withPrintX:1 withPrintY:20 withData:@"ABCD1234" withCount:0];
    [cpclPrinter printCPCLText:0 withFontType:2 withFontSize:0 withPrintX:1 withPrintY:70 withData:@"ABCD1234" withCount:0];
    [cpclPrinter printCPCLText:0 withFontType:4 withFontSize:0 withPrintX:1 withPrintY:100 withData:@"ABCD1234" withCount:0];
    [cpclPrinter printCPCLText:0 withFontType:5 withFontSize:0 withPrintX:1 withPrintY:150 withData:@"ABCD1234" withCount:0];
    [cpclPrinter printCPCLText:0 withFontType:6 withFontSize:0 withPrintX:1 withPrintY:200 withData:@"ABCD1234" withCount:0];
    [cpclPrinter printCPCLText:0 withFontType:7 withFontSize:0 withPrintX:1 withPrintY:250 withData:@"ABCD1234" withCount:0];
    
    [cpclPrinter printForm];
}

- (void)fontTest
{
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:406 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    //[cpclPrinter setMedia:CPCL_LABEL];
    
    [cpclPrinter setEncoding:0x8000940];
    
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:0 withFontSize:0 withPrintX:1 withPrintY:1 withData:@"FONT-0-0" withCount:0];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:0 withFontSize:1 withPrintX:1 withPrintY:50 withData:@"FONT-0-1" withCount:0];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:4 withFontSize:0 withPrintX:1 withPrintY:100 withData:@"FONT-4-0" withCount:0];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:4 withFontSize:1 withPrintX:1 withPrintY:150 withData:@"FONT-4-1" withCount:0];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:4 withFontSize:2 withPrintX:1 withPrintY:260 withData:@"4-2" withCount:0];
    
    [cpclPrinter printForm];
}

- (void)barcode1DTest
{
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:1020 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    //[cpclPrinter setMedia:CPCL_LABEL];
    
    // CODABAR
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:19 withPrintY:18 withData:@"CODABAR" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_CODABAR withNarrowBar:2 withRatio:CPCL_BCS_0RATIO withBarHeight:30 withPrintX:19 withPrintY:45 withData:@"A37859A" withCount:0];
    
    // Code 39
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:103 withData:@"CODE 39" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_39 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:130 withData:@"0123456" withCount:0];
    
    // Code 93
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:180 withData:@"CODE 93" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_93 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:210 withData:@"0123456" withCount:0];
    
    // BARCODE 128 1 1 50 150 10 HORIZ.
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:270 withData:@"CODE 128" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_128 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:300 withData:@"A37859B" withCount:0];
    
    // EAN8 + 2 digit supplement.
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:360 withData:@"EAN8 2 supplement" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_EAN82 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:390 withData:@"4015347 12" withCount:0];
    
    // EAN13 + 5 digit supplement.
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:450 withData:@"EAN13 5 supplement" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_EAN135 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:480 withData:@"123456789012 12345" withCount:0];
    
    // UPC-A + 5 digit supplement.
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:540 withData:@"UPC-A 5 supplement" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_UPCA5 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:570 withData:@"01234567890 12345" withCount:0];
    
    // UPC-E + 2 digit supplement.
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:630 withData:@"UPC-E 2 supplement" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_UPCE2 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:660 withData:@"0123456 12" withCount:0];
    
    // POSTNET.
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:720 withData:@"POSTNET" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_POSTNET withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:750 withData:@"012345678" withCount:0];
    
    // EAN13.
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:810 withData:@"EAN13" withCount:0];
    [cpclPrinter setCPCLBarcode:0 withFontSize:0 withOffset:0];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_EAN13 withNarrowBar:1 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:850 withData:@"123456789012" withCount:1];
    
    // Code 39
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:910 withData:@"No HRI" withCount:0];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:7 withFontSize:0 withPrintX:21 withPrintY:940 withData:@"CODE 39" withCount:0];
    
    // Reset HRI Character.
    [cpclPrinter resetCPCLBarcode];
    [cpclPrinter printCPCLBarcode:CPCL_0_ROTATION withBarcodeType:CPCL_BCS_39 withNarrowBar:2 withRatio:CPCL_BCS_1RATIO withBarHeight:30 withPrintX:19 withPrintY:970 withData:@"0123456" withCount:0];
    
    // Print
    [cpclPrinter printForm];
}

- (void)barcode2DTest
{
    NSString *data = @"STLKP112141";
    
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:406 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    //[cpclPrinter setMedia:CPCL_LABEL];
    
    [cpclPrinter printPDF417:CPCL_0_ROTATION withPrintX:10 withPrintY:10 withUnitWidth:2 withUnitHeight:7 withNumOfColumns:2 withSecurityLevel:1 withData:data];
    [cpclPrinter printQRCODE:CPCL_0_ROTATION withPrintX:10 withPrintY:90 withVersion:0 withECLevel:1 withModuleSize:4 withMaskNo:8 withData:data];
    [cpclPrinter printDATAMATRIX:CPCL_0_ROTATION withPrintX:200 withPrintY:90 withECCLevel:0 withCellSize:4 withData:data];
    
    [cpclPrinter printForm];
}

- (void)imageTest
{
    NSString *imgFile2 = [[NSBundle mainBundle] pathForResource:@"sample_2.jpg" ofType:nil];
    NSString *imgFile3 = [[NSBundle mainBundle] pathForResource:@"sample_3.jpg" ofType:nil];
    NSString *imgFile4 = [[NSBundle mainBundle] pathForResource:@"sample_4.jpg" ofType:nil];
    
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:406 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    //[cpclPrinter setMedia:CPCL_LABEL];
    
    [cpclPrinter printBitmap:imgFile2 withPrintX:1 withPrintY:200 withBrightness:5];
    [cpclPrinter printBitmap:imgFile3 withPrintX:100 withPrintY:10 withBrightness:5];
    [cpclPrinter printBitmap:imgFile4 withPrintX:120 withPrintY:245 withBrightness:5];
    
    [cpclPrinter printForm];
}

- (void)setMagnifyTest
{
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:406 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    [cpclPrinter setJustification:CPCL_LEFT];
    
    [cpclPrinter setMagnify:CPCL_TXT_1WIDTH withHeight:CPCL_TXT_1HEIGHT];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:0 withFontSize:0 withPrintX:1 withPrintY:1 withData:@"FONT 0-0 at SETMAG 1-1" withCount:0];
    
    [cpclPrinter setMagnify:CPCL_TXT_1WIDTH withHeight:CPCL_TXT_2HEIGHT];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:0 withFontSize:0 withPrintX:1 withPrintY:50 withData:@"FONT 0-0 at SETMAG 1-2" withCount:0];
    
    [cpclPrinter setMagnify:CPCL_TXT_2WIDTH withHeight:CPCL_TXT_1HEIGHT];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:0 withFontSize:0 withPrintX:1 withPrintY:100 withData:@"FONT 0-0 at SETMAG 2-1" withCount:0];
    
    [cpclPrinter setMagnify:CPCL_TXT_2WIDTH withHeight:CPCL_TXT_2HEIGHT];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:0 withFontSize:0 withPrintX:1 withPrintY:150 withData:@"FONT 0-0 at SETMAG 2-2" withCount:0];
    
    [cpclPrinter setMagnify:CPCL_TXT_2WIDTH withHeight:CPCL_TXT_4HEIGHT];
    [cpclPrinter printCPCLText:CPCL_0_ROTATION withFontType:0 withFontSize:0 withPrintX:1 withPrintY:200 withData:@"FONT 0-0 at SETMAG 2-4" withCount:0];
    
    [cpclPrinter resetMagnify];
    
    [cpclPrinter printForm];
}

- (void)concatTest
{
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:406 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    //[cpclPrinter setMedia:CPCL_LABEL];
    
    [cpclPrinter setConcat:CPCL_CONCAT withPrintX:75 withPrintY:75];
    [cpclPrinter concatText:4 withFontSize:2 withOffset:5 withData:@"$"];
    [cpclPrinter concatText:4 withFontSize:3 withOffset:0 withData:@"12"];
    [cpclPrinter concatText:4 withFontSize:2 withOffset:5 withData:@"34"];
    [cpclPrinter resetConcat];
    
    [cpclPrinter printForm];
}

- (void)multiLineTest
{
    NSString *data = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ;0123456789!@#%^&*";
    
    [cpclPrinter setForm:0 withResX:200 withResY:200 withLabelHeight:406 withQuantity:1];
    [cpclPrinter setMedia:CPCL_CONTINUOUS];
    //[cpclPrinter setMedia:CPCL_LABEL];
    
    [cpclPrinter setMultiLine:15];
    [cpclPrinter multiLineText:0 withFontType:0 withFontSize:0 withPrintX:10 withPrintY:20];
    
    for (int i = 0; i < 16; i++)
    {
        [cpclPrinter multiLineData:data];
    }
    
    [cpclPrinter resetMultiLine];
    
    [cpclPrinter printForm];
}

- (void)printerStatus
{
    if (connType == CONN_BT) {
        [cpclPrinter printerCheck];
    } else {
        [self checkPrinterStatus];
    }
}

#pragma mark - Printer Status

- (void)checkPrinterStatus
{
    long check = [cpclPrinter printerCheck];
    NSLog(@"success %ld",check);
    if(check < 0)
        return;
    else
    {
        check = [cpclPrinter status];
        NSLog(@"status %ld",check);
        if(check == STS_CPCL_NORMAL)
        {
            [self messageBox:@"Normal" withTitle:@"Printer Status"];
        }
        else
        {
            NSLog(@"Status %ld",check);
            NSString * result = @"";
            if((check & STS_CPCL_BATTERY_LOW) > 0)
                result = [result stringByAppendingFormat:@"Battery Low\n"];
            if((check & STS_CPCL_BUSY) > 0)
                result = [result stringByAppendingFormat:@"Busy\n"];
            if((check & STS_CPCL_COVER_OPEN) > 0)
                result = [result stringByAppendingFormat:@"Cover Open\n"];
            if((check & STS_CPCL_PAPER_EMPTY) > 0)
                result = [result stringByAppendingFormat:@"Paper Empty"];
            [self messageBox:result withTitle:@"Printer Status"];
        }
    }
}

- (void)statusCheckReceived:(NSNotification *)notification
{
    long bytesAvailable = 0;
    long readLength = 0;
    unsigned char buf[8] = {0,};
    
    EABluetoothPort *sessionController = (EABluetoothPort *)[notification object];
    NSString *result = [[NSString alloc] init];
    
    NSMutableData *readData = [[NSMutableData alloc] init];
    while((bytesAvailable = [sessionController readBytesAvailable]) > 0)
    {
        NSData *data = [sessionController readData:bytesAvailable];
        if(data)
        {
            [readData appendData:data];
            readLength = readLength + bytesAvailable;
        }
    }
    if(readLength > sizeof(buf))
        readLength = sizeof(buf);
    [readData getBytes:buf length:readLength];
    
    int sts = buf[readLength - 1];
    if(sts == STS_CPCL_NORMAL)
    {
        [self messageBox:@"Normal" withTitle:@"Printer Status"];
    }
    else
    {
        if((sts & STS_CPCL_COVER_OPEN) > 0)
        {
            result = [result stringByAppendingString:@"Cover Open\r\n"];
        }
        if((sts & STS_CPCL_PAPER_EMPTY) > 0)
        {
            result = [result stringByAppendingString:@"Paper Empty\r\n"];
        }
        [self messageBox:result withTitle:@"Printer Status"];
    }
}

- (void)messageBox:(NSString *)message withTitle:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          [alertController dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [samples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [samples objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self fontTypeTest];
            break;
        case 1:
            [self barcode1DTest];
            break;
        case 2:
            [self setMagnifyTest];
            break;
        case 3:
            [self barcode2DTest];
            break;
        case 4:
            [self imageTest];
            break;
        case 5:
            [self fontTest];
            break;
        case 6:
            [self concatTest];
            break;
        case 7:
            [self multiLineTest];
            break;
        case 8:
            [self printerStatus];
            break;
        case 9:
            [self disconnect];
            break;
        default:
            break;
    }
}

@end
