//
//  ZPLTableViewController.m
//  IPCMPPrinterTester
//
//  Created by Lucas Netal on 6/28/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import "ZPLTableViewController.h"

@interface ZPLTableViewController ()

@end

@implementation ZPLTableViewController
{
    IPCZPLPrinter *zplPrinter;
    CONNECTION_TYPE connType;
    
    NSArray *samples;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    samples = @[@"Font Test", @"Geometry Test", @"Barcode 1D Test", @"Image Test", @"Barcode 2D Test", @"Printer Status", @"Disconnect"];
    
    if (connType == CONN_BT) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusCheckReceived:) name:EADSessionDataReceivedNotification object:nil];
        [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
    }
}

- (id)initWithZPLPrinter:(IPCZPLPrinter *)printer withConnection:(CONNECTION_TYPE)connection {
    if (self = [super init]) {
        zplPrinter = printer;
        connType = connection;
    }
    
    return self;
}

- (void)disconnect {
    [zplPrinter closePort];
    
    if (connType == CONN_BT) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:EADSessionDataReceivedNotification object:nil];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Print Samples

- (void)fontTest
{
    [zplPrinter setupPrinter:ZPL_ROTATION_180 withmTrack:ZPL_SENSE_CONTINUOUS withWidth:384 withHeight:480];
    [zplPrinter startPage];
    [zplPrinter setInternationalFont:0];
    
    [zplPrinter printText:ZPL_FONT_A withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:0 withData:@"FontA 0123"];
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:30 withData:@"FontB 0123"];
    [zplPrinter printText:ZPL_FONT_C withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:60 withData:@"FontC 0123"];
    [zplPrinter printText:ZPL_FONT_D withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:90 withData:@"FontD 0123"];
    [zplPrinter printText:ZPL_FONT_E withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:120 withData:@"FontE 0123"];
    [zplPrinter printText:ZPL_FONT_F withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:160 withData:@"FontF 0123"];
    [zplPrinter printText:ZPL_FONT_G withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:210 withData:@"FontG 01"];
    [zplPrinter printText:ZPL_FONT_H withOrientation:ZPL_ROTATION_0 withWidth:15 withHeight:12 withPrintX:0 withPrintY:300 withData:@"FontH 01234567"];
    
    [zplPrinter endPage:1];
}

- (void)geometyTest
{
    [zplPrinter setupPrinter:ZPL_ROTATION_180 withmTrack:ZPL_SENSE_CONTINUOUS withWidth:384 withHeight:300];
    [zplPrinter startPage];
    [zplPrinter setInternationalFont:0];
    
    [zplPrinter printCircle:40 withPrintY:40 withDiameter:70 withThickness:0 withLineColor:ZPL_LINE_COLOR_B];
    [zplPrinter printDiagonalLine:30 withPrintY:30 withWidth:100 withHeight:100 withThickness:7 withLineColor:ZPL_LINE_COLOR_B withDirection:ZPL_DIAGONAL_L];
    [zplPrinter printEllipse:10 withPrintY:10 withWidth:300 withHeight:200 withThickness:2 withLineColor:ZPL_LINE_COLOR_B];
    [zplPrinter printRectangle:120 withPrintY:10 withWidth:120 withHeight:80 withThickness:10 withLineColor:ZPL_LINE_COLOR_B withRounding:0];
    [zplPrinter printRectangle:120 withPrintY:100 withWidth:120 withHeight:80 withThickness:10 withLineColor:ZPL_LINE_COLOR_B withRounding:8];
    
    [zplPrinter endPage:1];
}

- (void)barcode1DTest
{
    NSString *barcodeData = @"123456789012";
    
    [zplPrinter setupPrinter:ZPL_ROTATION_180 withmTrack:ZPL_SENSE_CONTINUOUS withWidth:384 withHeight:1600];
    [zplPrinter startPage];
    [zplPrinter setInternationalFont:0];
    
    [zplPrinter setBarcodeField:2 withRatio:@"3" withBarHeight:20];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:70 withData:@"Code11"];
    [zplPrinter printBarcode:ZPL_BCS_Code11 withBarcodeProp:NULL withPrintX:10 withPrintY:10 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:150 withData:@"Code128"];
    [zplPrinter printBarcode:ZPL_BCS_Code128 withBarcodeProp:NULL withPrintX:10 withPrintY:100 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:250 withData:@"Code39"];
    [zplPrinter printBarcode:ZPL_BCS_Code39 withBarcodeProp:NULL withPrintX:10 withPrintY:200 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:350 withData:@"Code93"];
    [zplPrinter printBarcode:ZPL_BCS_Code93 withBarcodeProp:NULL withPrintX:10 withPrintY:300 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:450 withData:@"EAN13"];
    [zplPrinter printBarcode:ZPL_BCS_EAN13 withBarcodeProp:NULL withPrintX:10 withPrintY:400 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:550 withData:@"EAN8"];
    [zplPrinter printBarcode:ZPL_BCS_EAN8 withBarcodeProp:NULL withPrintX:10 withPrintY:500 withData:@"12345"];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:650 withData:@"Industrial 2OF5"];
    [zplPrinter printBarcode:ZPL_BCS_Industrial_2OF5 withBarcodeProp:NULL withPrintX:10 withPrintY:600 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:750 withData:@"Interleaved 2OF5"];
    [zplPrinter printBarcode:ZPL_BCS_Interleaved_2OF5 withBarcodeProp:NULL withPrintX:10 withPrintY:700 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:850 withData:@"LOGMARS"];
    [zplPrinter printBarcode:ZPL_BCS_LOGMARS withBarcodeProp:NULL withPrintX:10 withPrintY:800 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:950 withData:@"MSI"];
    [zplPrinter printBarcode:ZPL_BCS_MSI withBarcodeProp:NULL withPrintX:10 withPrintY:900 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:1050 withData:@"PlanetCode"];
    [zplPrinter printBarcode:ZPL_BCS_PlanetCode withBarcodeProp:NULL withPrintX:10 withPrintY:1000 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:1150 withData:@"Plessey"];
    [zplPrinter printBarcode:ZPL_BCS_Plessey withBarcodeProp:NULL withPrintX:10 withPrintY:1100 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:1250 withData:@"POSTNET"];
    [zplPrinter printBarcode:ZPL_BCS_POSTNET withBarcodeProp:NULL withPrintX:10 withPrintY:1200 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:1350 withData:@"Standard 2OF5"];
    [zplPrinter printBarcode:ZPL_BCS_Standard_2OF5 withBarcodeProp:NULL withPrintX:10 withPrintY:1300 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:1450 withData:@"UPCA"];
    [zplPrinter printBarcode:ZPL_BCS_UPCA withBarcodeProp:NULL withPrintX:10 withPrintY:1400 withData:barcodeData];
    
    [zplPrinter printText:ZPL_FONT_B withOrientation:ZPL_ROTATION_0 withWidth:10 withHeight:10 withPrintX:0 withPrintY:1550 withData:@"UPCE"];
    [zplPrinter printBarcode:ZPL_BCS_UPCE withBarcodeProp:NULL withPrintX:10 withPrintY:1500 withData:barcodeData];
    
    [zplPrinter endPage:1];
}

- (void)imageTest
{
    [zplPrinter setupPrinter:ZPL_ROTATION_180 withmTrack:ZPL_SENSE_CONTINUOUS withWidth:384 withHeight:340];
    [zplPrinter startPage];
    [zplPrinter setInternationalFont:0];
    
    NSString *imgFile2 = [[NSBundle mainBundle] pathForResource:@"sample_2.jpg" ofType:nil];
    NSString *imgFile3 = [[NSBundle mainBundle] pathForResource:@"sample_3.jpg" ofType:nil];
    NSString *imgFile4 = [[NSBundle mainBundle] pathForResource:@"sample_4.jpg" ofType:nil];
    
    [zplPrinter printImage:imgFile2 withPrintX:1 withPrintY:200 withBrightness:5];
    [zplPrinter printImage:imgFile3 withPrintX:100 withPrintY:10 withBrightness:5];
    [zplPrinter printImage:imgFile4 withPrintX:120 withPrintY:245 withBrightness:5];
    
    [zplPrinter endPage:1];
}

- (void)barcode2DTest
{
    [zplPrinter setupPrinter:ZPL_ROTATION_180 withmTrack:ZPL_SENSE_CONTINUOUS withWidth:384 withHeight:400];
    [zplPrinter startPage];
    [zplPrinter setInternationalFont:0];
    
    [zplPrinter printQRCODE:10 withPrintY:220 withOrientation:ZPL_ROTATION_0 withModel:2 withCellWidth:5 withData:@"MM,AAC-42"];
    [zplPrinter printPDF417:10 withPrintY:10 withOrientation:ZPL_ROTATION_0 withCellWidth:5 withSecurity:5 withNumOfRow:23 withTruncate:@"N" withData:@"PDF417-ABDFFEWGSERSHSRGRR"];
    [zplPrinter printDataMatrix:200 withPrintY:220 withOrientation:ZPL_ROTATION_0 withCellWidth:10 withQuality:ZPL_DM_QUALITY_200 withData:@"ABDFFEWGSERSHSRGRR"];
    
    [zplPrinter endPage:1];
}

- (void)printerStatus
{
    if (connType == CONN_BT) {
        [zplPrinter printerCheck];
    } else {
        [self checkPrinterStatus];
    }
}

#pragma mark - Printer Status

- (void)checkPrinterStatus
{
    long check = [zplPrinter printerCheck];
    NSLog(@"check: %ld",check);
    
    NSString *result = [[NSString alloc] init];
    long sts = [zplPrinter status];
    
    if(sts == STS_ZPL_NORMAL)
    {
        [self messageBox:@"Normal" withTitle:@"Printer Status"];
    } else {
        if((sts & STS_ZPL_BUSY) > 0)
        {
            result = [result stringByAppendingString:@"Printer Busy\r\n"];
        }
        if((sts & STS_ZPL_COVER_OPEN) > 0)
        {
            result = [result stringByAppendingString:@"Cover Open\r\n"];
        }
        if((sts & STS_ZPL_PAPER_EMPTY) > 0)
        {
            result = [result stringByAppendingString:@"Paper Empty\r\n"];
        }
        if((sts & STS_ZPL_BATTERY_LOW) > 0)
        {
            result = [result stringByAppendingString:@"Battery Low\r\n"];
        }
        [self messageBox:result withTitle:@"Printer Status"];
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
    if(sts == STS_ZPL_NORMAL)
    {
        [self messageBox:@"Normal" withTitle:@"Printer Status"];
    }
    else
    {
        if((sts & STS_ZPL_BUSY) > 0)
        {
            result = [result stringByAppendingString:@"Printer Busy\r\n"];
        }
        if((sts & STS_ZPL_COVER_OPEN) > 0)
        {
            result = [result stringByAppendingString:@"Cover Open\r\n"];
        }
        if((sts & STS_ZPL_PAPER_EMPTY) > 0)
        {
            result = [result stringByAppendingString:@"Paper Empty\r\n"];
        }
        if((sts & STS_ZPL_BATTERY_LOW) > 0)
        {
            result = [result stringByAppendingString:@"Battery Low\r\n"];
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
            [self fontTest];
            break;
        case 1:
            [self geometyTest];
            break;
        case 2:
            [self barcode1DTest];
            break;
        case 3:
            [self imageTest];
            break;
        case 4:
            [self barcode2DTest];
            break;
        case 5:
            [self printerStatus];
            break;
        case 6:
            [self disconnect];
            break;
        default:
            break;
    }
}

@end
