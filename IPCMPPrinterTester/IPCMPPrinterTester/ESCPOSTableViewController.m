//
//  ESCPOSTableViewController.m
//  IPCMPPrinterTester
//
//  Created by Lucas Netal on 6/29/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import "ESCPOSTableViewController.h"

@interface ESCPOSTableViewController ()

@end

@implementation ESCPOSTableViewController
{
    IPCESCPOSPrinter *escposPrinter;
    CONNECTION_TYPE connType;
    
    NSArray *samples;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    samples = @[@"Receipt 01 Test", @"Receipt 02 Test", @"Barcode 1D Test", @"Bitmap Test", @"Logo Test", @"PDF417 Test", @"QR Code Test", @"Printer Status", @"Disconnect"];
    
    if (connType == CONN_BT) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusCheckReceived:) name:EADSessionDataReceivedNotification object:nil];
        [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [escposPrinter closePort];
    
    if (connType == CONN_BT) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:EADSessionDataReceivedNotification object:nil];
    }
}

- (id)initWithESCPOSPrinter:(IPCESCPOSPrinter *)printer withConnection:(CONNECTION_TYPE)connection {
    if (self = [super init]) {
        escposPrinter = printer;
        connType = connection;
    }
    
    return self;
}

- (void)disconnect {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Print Samples

- (void)receipt01Test {
    // Command -- Font Size, Alignment
    unsigned char normalSize[3] = {0x1D,0x21,0x00};
    unsigned char dWidthSize[3] = {0x1D,0x21,0x10};
    unsigned char centerAlign[3] = {0x1B,0x61,0x01};
    unsigned char rightAlign[3] = {0x1B,0x61,0x02};
    
    // Read the reference manual enclosed the compressed file
    NSString *barcodeData = @"2132132132131";
    unsigned char barcode128[4] = {0x1D,0x6B,0x73,[barcodeData length]};
    unsigned char barcodeWidth[3] = {0x1D,0x77,0x03};
    unsigned char barcodeHeight[3] = {0x1D,0x68,0x85};
    unsigned char barcodeHRI[3] = {0x1D,0x48,0x02};
    
    
    //[escposPrinter printNVBitmap:1 withAlignment:ALIGNMENT_RIGHT withSize:BITMAP_NORMAL];
    [escposPrinter printData:dWidthSize withLength:sizeof(dWidthSize)];
    [escposPrinter printData:centerAlign withLength:sizeof(centerAlign)];
    [escposPrinter printString:@"Receipt\r\n\r\n"];
    
    [escposPrinter printData:normalSize withLength:sizeof(normalSize)];
    [escposPrinter printData:rightAlign withLength:sizeof(rightAlign)];
    [escposPrinter printString:@"TEL (123)-456-7890\r\n"];
    
    [escposPrinter printData:centerAlign withLength:sizeof(centerAlign)];
    [escposPrinter printString:@"Thank you for coming to our shop!\r\n\r\n"];
    
    [escposPrinter printString:@"Chicken                   $10.00\r\n"];
    [escposPrinter printString:@"Hamburger                 $20.00\r\n"];
    [escposPrinter printString:@"Pizza                     $30.00\r\n"];
    [escposPrinter printString:@"Lemons                    $40.00\r\n"];
    [escposPrinter printString:@"Drink                     $50.00\r\n"];
    [escposPrinter printString:@"Excluded tax             $150.00\r\n\r\n"];
    
    [escposPrinter printData:rightAlign withLength:sizeof(rightAlign)];
    [escposPrinter printString:@"Tax(5%)                    $7.50\r\n"];
    [escposPrinter printString:@"Total                    $157.50\r\n"];
    [escposPrinter printString:@"Payment                  $200.00\r\n"];
    [escposPrinter printString:@"Change                    $42.50\r\n\r\n\r\n"];
    
    [escposPrinter printData:centerAlign withLength:sizeof(centerAlign)];
    [escposPrinter printData:barcodeWidth withLength:sizeof(barcodeWidth)];
    [escposPrinter printData:barcodeHeight withLength:sizeof(barcodeHeight)];
    [escposPrinter printData:barcodeHRI withLength:sizeof(barcodeHRI)];
    [escposPrinter printData:barcode128 withLength:sizeof(barcode128)];
    [escposPrinter printString:barcodeData];
    
    // 4 Line Feed
    [escposPrinter lineFeed:4];
}

- (void)receipt02Test
{
    unsigned char centerAlign[3] = {0x1B,0x61,0x01};
    
    NSString *barcodeData = @"21321321321313321";
    
    // Pre-saved image data : 1-255
    //[escposPrinter printNVBitmap:1 withAlignment:ALIGNMENT_CENTER withSize:BITMAP_NORMAL];
    
    [escposPrinter printText:@"Receipt\r\n\r\n" withAlignment:ALIGNMENT_CENTER withOption:FNT_DEFAULT withSize:(TXT_2WIDTH|TXT_2HEIGHT)];
    [escposPrinter printText:@"TEL (123)-456-7890\r\n" withAlignment:ALIGNMENT_RIGHT withOption:FNT_FONTB withSize:TXT_1WIDTH];
    
    [escposPrinter printText:@"Thank you for coming to our shop!\r\n\r\n" withAlignment:ALIGNMENT_CENTER withOption:FNT_BOLD withSize:TXT_1WIDTH];
    
    [escposPrinter printData:centerAlign withLength:sizeof(centerAlign)];
    [escposPrinter printString:@"Chicken                   $10.00\r\n"];
    [escposPrinter printString:@"Hamburger                 $20.00\r\n"];
    [escposPrinter printString:@"Pizza                     $30.00\r\n"];
    [escposPrinter printString:@"Lemons                    $40.00\r\n"];
    [escposPrinter printString:@"Drink                     $50.00\r\n"];
    [escposPrinter printString:@"Excluded tax             $150.00\r\n\r\n"];
    
    [escposPrinter printText:@"Tax(5%)         $7.50\r\n" withAlignment:ALIGNMENT_RIGHT withOption:(FNT_FONTB|FNT_UNDERLINE) withSize:(TXT_1WIDTH)];
    [escposPrinter printText:@"Total           $157.50\r\n" withAlignment:ALIGNMENT_RIGHT withOption:(FNT_FONTB|FNT_UNDERLINE) withSize:(TXT_1WIDTH)];
    [escposPrinter printText:@"Payment         $200.00\r\n" withAlignment:ALIGNMENT_RIGHT withOption:(FNT_FONTB|FNT_UNDERLINE) withSize:(TXT_1WIDTH)];
    [escposPrinter printText:@"Change      $42.50\r\n\r\n\r\n" withAlignment:ALIGNMENT_CENTER withOption:(FNT_UNDERLINE) withSize:(TXT_1WIDTH|TXT_2HEIGHT)];
    
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_CODE128 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    
    [escposPrinter lineFeed:4];
}

- (void)barcode1DTest
{
    NSString *barcodeData = @"123456789012";
    
    [escposPrinter printString:@"UPCA\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_UPCA withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"UPCE\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_UPCE withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"EAN8\r\n"];
    [escposPrinter printBarCode:@"1234567" withSymbology:BCS_EAN8 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"EAN13\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_EAN13 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODE39\r\n"];
    [escposPrinter printBarCode:@"ABCDEFGHI" withSymbology:BCS_CODE39 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"ITF\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_ITF withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODABAR\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_CODABAR withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODE93\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_CODE93 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODE128\r\n"];
    [escposPrinter printBarCode:@"{BNo.{C4567890120" withSymbology:BCS_CODE128 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    
    [escposPrinter lineFeed:3];
}

- (void)barcode1DTestt {
    NSString *barcodeData = @"123456789012";
    NSString *code39Data = @"1234567890";
    NSString *codabarData = @"A1234567890A";
    
    [escposPrinter printString:@"UPCA\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_UPCA withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"UPCE\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_UPCE withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"EAN8\r\n"];
    [escposPrinter printBarCode:@"1234567" withSymbology:BCS_EAN8 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"EAN13\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_EAN13 withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODE39\r\n"];
    [escposPrinter printBarCode:code39Data withSymbology:BCS_CODE39 withHeight:70 withWidth:BCS_2WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"ITF\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_ITF withHeight:70 withWidth:BCS_3WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODABAR\r\n"];
    [escposPrinter printBarCode:codabarData withSymbology:BCS_CODABAR withHeight:70 withWidth:BCS_2WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODE93\r\n"];
    [escposPrinter printBarCode:barcodeData withSymbology:BCS_CODE93 withHeight:70 withWidth:BCS_2WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    [escposPrinter printString:@"CODE128\r\n"];
    [escposPrinter printBarCode:@"{BNo.{C4567890120" withSymbology:BCS_CODE128 withHeight:70 withWidth:BCS_2WIDTH withAlignment:ALIGNMENT_CENTER withHRI:HRI_TEXT_BELOW];
    
    [escposPrinter lineFeed:3];
}

- (void)bitmapTest
{
    NSString *imgfile1 = [[NSBundle mainBundle] pathForResource:@"sample_1.jpg" ofType:nil];
    NSString *imgfile2 = [[NSBundle mainBundle] pathForResource:@"sample_2.jpg" ofType:nil];
    NSString *imgfile3 = [[NSBundle mainBundle] pathForResource:@"sample_3.jpg" ofType:nil];
    NSString *imgfile4 = [[NSBundle mainBundle] pathForResource:@"sample_4.jpg" ofType:nil];
    
    [escposPrinter printBitmap:imgfile1 withAlignment:ALIGNMENT_CENTER withSize:BITMAP_NORMAL withBrightness:5];
    [escposPrinter printBitmap:imgfile2 withAlignment:ALIGNMENT_LEFT withSize:BITMAP_NORMAL withBrightness:5];
    [escposPrinter printBitmap:imgfile3 withAlignment:ALIGNMENT_RIGHT withSize:BITMAP_NORMAL withBrightness:5];
    
    [escposPrinter printBitmap:imgfile4 withAlignment:ALIGNMENT_LEFT withSize:BITMAP_QUADRUPLE withBrightness:0];
    [escposPrinter printBitmap:imgfile4 withAlignment:ALIGNMENT_LEFT withSize:BITMAP_DOUBLE_WIDTH withBrightness:10];
    
    [escposPrinter lineFeed:5];
}

- (void)logoTest
{
    // Pre-saved image data : 1-255
    [escposPrinter printNVBitmap:1 withAlignment:ALIGNMENT_CENTER withSize:BITMAP_NORMAL];
    [escposPrinter lineFeed:3];
}

- (void)pdf417Test
{
    NSString *barcodeData = @"ABCDEFGHIJKLMN";
    int length = (int)[barcodeData length];
    
    [escposPrinter printString:@"PDF417 Column=3 , Cell Width = 2\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:3 withCellWidth:2 withAlignment:ALIGNMENT_CENTER];
    [escposPrinter printString:@"PDF417 Column=4 , Cell Width = 2\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:4 withCellWidth:2 withAlignment:ALIGNMENT_CENTER];
    [escposPrinter printString:@"PDF417 Column=5 , Cell Width = 2\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:5 withCellWidth:2 withAlignment:ALIGNMENT_CENTER];
    [escposPrinter printString:@"PDF417 Column=6 , Cell Width = 2\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:6 withCellWidth:2 withAlignment:ALIGNMENT_CENTER];
    [escposPrinter printString:@"PDF417 Column=7 , Cell Width = 2\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:7 withCellWidth:2 withAlignment:ALIGNMENT_CENTER];
    [escposPrinter printString:@"PDF417 Column=8 , Cell Width = 2\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:8 withCellWidth:2 withAlignment:ALIGNMENT_CENTER];
    
    [escposPrinter printString:@"PDF417 Column=4 , Cell Width = 1\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:4 withCellWidth:1 withAlignment:ALIGNMENT_LEFT];
    [escposPrinter printString:@"PDF417 Column=4 , Cell Width = 5\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:4 withCellWidth:5 withAlignment:ALIGNMENT_CENTER];
    [escposPrinter printString:@"PDF417 Column=1 , Cell Width = 6\r\n"];
    [escposPrinter printPDF417:barcodeData withLength:length withColumns:1 withCellWidth:6 withAlignment:ALIGNMENT_RIGHT];
    
    [escposPrinter lineFeed:3];
}

- (void)qrcodeTest
{
    NSString *barcodeData = @"ABCDEFGHIJKLMN";
    int length = (int)[barcodeData length];
    
    [escposPrinter printString:@"QR Left Alignment\r\n"];
    [escposPrinter printQRCode:barcodeData withLength:length withModuleSize:3 withECLevel:0 withAlignment:ALIGNMENT_LEFT];
    [escposPrinter printString:@"QR Center Alignment\r\n"];
    [escposPrinter printQRCode:barcodeData withLength:length withModuleSize:3 withECLevel:0 withAlignment:ALIGNMENT_CENTER];
    [escposPrinter printString:@"QR Right Alignment\r\n"];
    [escposPrinter printQRCode:barcodeData withLength:length withModuleSize:3 withECLevel:0 withAlignment:ALIGNMENT_RIGHT];
    
    [escposPrinter lineFeed:3];
}

- (void)printerStatus
{
    if (connType == CONN_BT) {
        [escposPrinter printerCheck];
    } else {
        [self checkPrinterStatus];
    }
}

#pragma mark - Printer Status

- (void)checkPrinterStatus
{
    long sts = [escposPrinter printerCheck];
    NSString *result = @"";
    
    NSLog(@"Status value : %ld",sts);
    if([escposPrinter asbMode])
        return;
    
    if(sts == STS_NORMAL)
    {
        [self messageBox:@"Normal" withTitle:@"Printer Status"];
    }
    else
    {
        if((sts & STS_COVEROPEN) > 0)
        {
            result = [result stringByAppendingString:@"Cover Open\r\n"];
        }
        if((sts & STS_PAPEREMPTY) > 0)
        {
            result = [result stringByAppendingString:@"Paper Empty\r\n"];
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
    if(sts == STS_NORMAL)
    {
        [self messageBox:@"Normal" withTitle:@"Printer Status"];
    }
    else
    {
        if((sts & STS_COVEROPEN) > 0)
        {
            result = [result stringByAppendingString:@"Cover Open\r\n"];
        }
        if((sts & STS_PAPEREMPTY) > 0)
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
            [self receipt01Test];
            break;
        case 1:
            [self receipt02Test];
            break;
        case 2:
            [self barcode1DTest];
            break;
        case 3:
            [self bitmapTest];
            break;
        case 4:
            [self logoTest];
            break;
        case 5:
            [self pdf417Test];
            break;
        case 6:
            [self qrcodeTest];
            break;
        case 7:
            [self checkPrinterStatus];
            break;
        case 8:
            [self disconnect];
            break;
        default:
            break;
    }
}

@end
