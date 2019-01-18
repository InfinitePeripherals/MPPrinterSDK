//
//  IPCZPLPrinter.h
//  IPCMPPrinterSDK
//
//  Created by Infinite Peripherals on 6/20/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// ZPL Status
#define STS_ZPL_NORMAL          0
#define STS_ZPL_SUCCESS         0
#define STS_ZPL_BUSY            1
#define STS_ZPL_PAPER_EMPTY     2
#define STS_ZPL_COVER_OPEN      4
#define STS_ZPL_BATTERY_LOW     8

// Rotation
extern NSString * const ZPL_ROTATION_0;
extern NSString * const ZPL_ROTATION_90;
extern NSString * const ZPL_ROTATION_180;
extern NSString * const ZPL_ROTATION_270;

// Media
extern NSString * const ZPL_SENSE_CONTINUOUS;
extern NSString * const ZPL_SENSE_GAP;
extern NSString * const ZPL_SENSE_WEB;
extern NSString * const ZPL_SENSE_BLACKMARK;

// Device Font (Bitmap)
extern NSString * const ZPL_FONT_A;
extern NSString * const ZPL_FONT_B;
extern NSString * const ZPL_FONT_C;
extern NSString * const ZPL_FONT_D;
extern NSString * const ZPL_FONT_E;
extern NSString * const ZPL_FONT_F;
extern NSString * const ZPL_FONT_G;
extern NSString * const ZPL_FONT_H;

extern NSString * const ZPL_FONT_0;
extern NSString * const ZPL_FONT_1;
extern NSString * const ZPL_FONT_2;
extern NSString * const ZPL_FONT_3;
extern NSString * const ZPL_FONT_4;
extern NSString * const ZPL_FONT_5;
extern NSString * const ZPL_FONT_6;
extern NSString * const ZPL_FONT_7;
extern NSString * const ZPL_FONT_8;
extern NSString * const ZPL_FONT_9;

extern NSString * const ZPL_FONT_P;
extern NSString * const ZPL_FONT_Q;
extern NSString * const ZPL_FONT_R;
extern NSString * const ZPL_FONT_S;
extern NSString * const ZPL_FONT_T;
extern NSString * const ZPL_FONT_U;
extern NSString * const ZPL_FONT_V;

// Barcode Types
extern NSString * const ZPL_BCS_Code11;
extern NSString * const ZPL_BCS_Interleaved_2OF5;
extern NSString * const ZPL_BCS_Code39;
extern NSString * const ZPL_BCS_Code49;
extern NSString * const ZPL_BCS_PlanetCode;
extern NSString * const ZPL_BCS_PDF417;
extern NSString * const ZPL_BCS_EAN8;
extern NSString * const ZPL_BCS_UPCE;
extern NSString * const ZPL_BCS_Code93;
extern NSString * const ZPL_BCS_CODABLOCK;
extern NSString * const ZPL_BCS_Code128;
extern NSString * const ZPL_BCS_UPSMAXICODE;
extern NSString * const ZPL_BCS_EAN13;
extern NSString * const ZPL_BCS_MicroPDF417;
extern NSString * const ZPL_BCS_Industrial_2OF5;
extern NSString * const ZPL_BCS_Standard_2OF5;
extern NSString * const ZPL_BCS_Codabar;
extern NSString * const ZPL_BCS_LOGMARS;
extern NSString * const ZPL_BCS_MSI;
extern NSString * const ZPL_BCS_Aztec;
extern NSString * const ZPL_BCS_Plessey;
extern NSString * const ZPL_BCS_QRCode;
extern NSString * const ZPL_BCS_RSS;
extern NSString * const ZPL_BCS_UPCEANEXT;
extern NSString * const ZPL_BCS_TLC39;
extern NSString * const ZPL_BCS_UPCA;
extern NSString * const ZPL_BCS_DataMatrix;
extern NSString * const ZPL_BCS_POSTNET;

// QR Code ECL
extern NSString * const ZPL_QR_ECL_H;
extern NSString * const ZPL_QR_ECL_Q;
extern NSString * const ZPL_QR_ECL_M;
extern NSString * const ZPL_QR_ECL_L;

// DataMatrix Quality
#define ZPL_DM_QUALITY_0        0
#define ZPL_DM_QUALITY_50       50
#define ZPL_DM_QUALITY_80       80
#define ZPL_DM_QUALITY_100      100
#define ZPL_DM_QUALITY_140      140
#define ZPL_DM_QUALITY_200      200

// Graphic color
extern NSString * const ZPL_LINE_COLOR_W;
extern NSString * const ZPL_LINE_COLOR_B;

// Graphic Direction of Diagonal
extern NSString * const ZPL_DIAGONAL_R;
extern NSString * const ZPL_DIAGONAL_L;

/**
 @header    IPCZPLPrinter.h
 
 @author    Infinite Peripherals
 @copyright 2018 Infinite Peripherals Inc. All rights reserved.
 @version   1.0.0
 */
@interface IPCZPLPrinter : NSObject

/**
 @brief Connect to a printer.
 
 @param portName IP Address or “bluetooth” if using Bluetooth.
 @param port Port Number. (Default = 9100)
 
 @return 0 if connection established, -1 or -2 if connection failed, -3 if invalid device.
 */
- (long)openPort:(NSString *)portName withPortParam:(int)port;

/**
 @brief Disconnect from printer.
 
 @return 0 if success, -1 if failure.
 */
- (long)closePort;

/**
 @brief Set international character set.
 
 @param internationalFont International character set.
 
 @return 0 if success, -1 if failure.
 */
- (long)setInternationalFont:(int)internationalFont;

/**
 @brief Define the start of page.
 
 @return 0 if success, -1 if failure.
 */
- (long)startPage;

/**
 @brief Define the end of page.
 
 @param quantity Number of pages.
 
 @return 0 if success, -1 if failure.
 */
- (long)endPage:(int)quantity;

/**
 @brief Set print speed.
 
 @param speed Print speed. (2 - 12)
 
 @return 0 if success, -1 if failure.
 */
- (long)setSpeed:(int)speed;

/**
 @brief Set print contrast.
 
 @param darkness Density of printer. (0 - 30)
 
 @return 0 if success, -1 if failure.
 */
- (long)setDarkness:(int)darkness;

/**
 @brief Define the paper form.
 
 @param orientation Orientation as one of the ZPL_ROTATION_* constants.
 @param mTrack Type of print media as one of the ZPL_SENSE_* constants.
 @param width Page width. (Unit: dot)
 @param height Page height. (Unit: dot)
 
 @return 0 if success, -1 if failure.
 */
- (long)setupPrinter:(NSString *)orientation withmTrack:(NSString *)mTrack withWidth:(int)width withHeight:(int)height;

- (long)printTextFormat:(NSString *)deviceFont withOrientation:(NSString *)orientation withWidth:(int)width withHeight:(int)height withPrintX:(int)printX withPrintY:(int)printY withData:(NSString *)data withFormat:(NSString *)format withIncrement:(NSString *)increment;

/**
 @brief Print text.
 
 @param deviceFont Device font in printer as one of the ZPL_FONT_* constants.
 @param orientation Orientation as one of the ZPL_ROTATION_* constants.
 @param width Page width. (Unit: dot)
 @param height Page height. (Unit: dot)
 @param printX X-coordinate of text to print.
 @param printY Y-coordinate of text to print.
 @param data Data of string to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printText:(NSString *)deviceFont withOrientation:(NSString *)orientation withWidth:(int)width withHeight:(int)height withPrintX:(int)printX withPrintY:(int)printY withData:(NSString *)data;

/**
 @brief Set barcode properties.
 
 @param moduleWidth Module width. (1 - 10 Dots)
 @param ratio Wide bar to narrow bar width ratio. (2.0 - 3.0 in 0.1 increments)
 @param barHeight Barcode height (10 ~ Dots)
 
 @return 0 if success, -1 if failure.
 */
- (long)setBarcodeField:(int)moduleWidth withRatio:(NSString *)ratio withBarHeight:(int)barHeight;

/**
 @brief Print barcode.
 
 @param barcodeType Type of barcode as one of the ZPL_BCS_* constants.
 @param barcodeProp Set the barcode properties. See the setBarcodeField() function.
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param data Data of barcode to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printBarcode:(NSString *)barcodeType withBarcodeProp:(NSString *)barcodeProp withPrintX:(int)printX withPrintY:(int)printY withData:(NSString *)data;

/**
 @brief Print image.
 
 @param filePath Path to image file.
 @param printX X-coordinate of image to print.
 @param printY Y-coordinate of image to print.
 @param bright Brightness of image. (0 - 10)
 
 @return 0 if success, -1 if failure.
 */
- (long)printImage:(NSString *)filePath withPrintX:(int)printX withPrintY:(int)printY withBrightness:(int)bright;

/**
 @brief Draw diagonal line.
 
 @param printX X-coordinate of line to print.
 @param printY Y-coordinate of line to print.
 @param width Line width. (Unit: dot)
 @param height Line height. (Unit: dot)
 @param thickness Line thickness. (0 - 32000)
 @param lineColor Line color. (B = Black, W = White)
 @param direction Direction of line. (R = Right-Upper, L = Left-Upper)
 
 @return 0 if success, -1 if failure.
 */
- (long)printDiagonalLine:(int)printX withPrintY:(int)printY withWidth:(int)width withHeight:(int)height withThickness:(int)thickness withLineColor:(NSString *)lineColor withDirection:(NSString *)direction;

/**
 @brief Draw circle.
 
 @param printX X-coordinate of circle to print.
 @param printY Y-coordinate of circle to print.
 @param diameter Diamater of circle.
 @param thickness Circle thickness. (0 - 32000)
 @param lineColor Circle color. (B = Black, W = White)
 
 @return 0 if success, -1 if failure.
 */
- (long)printCircle:(int)printX withPrintY:(int)printY withDiameter:(int)diameter withThickness:(int)thickness withLineColor:(NSString *)lineColor;

/**
 @brief Draw ellipse.
 
 @param printX X-coordinate of ellipse to print.
 @param printY Y-coordinate of ellipse to print.
 @param width Ellipse width. (Unit: dot)
 @param height Ellipse height. (Unit: dot)
 @param thickness Ellipse thickness. (2 - 4095)
 @param lineColor Ellipse color. (B = Black, W = White)
 
 @return 0 if success, -1 if failure.
 */
- (long)printEllipse:(int)printX withPrintY:(int)printY withWidth:(int)width withHeight:(int)height withThickness:(int)thickness withLineColor:(NSString *)lineColor;

/**
 @brief Draw rectangle.
 
 @param printX X-coordinate of rectangle to print.
 @param printY Y-coordinate of rectangle to print.
 @param width Rectangle width. (Unit: dot)
 @param height Rectangle height. (Unit: dot)
 @param thickness Rectangle thickness. (1 - 32000)
 @param lineColor Rectangle color. (B = Black, W = White)
 @param rounding Level of rounding. (0 - 8)
 
 @return 0 if success, -1 if failure.
 */
- (long)printRectangle:(int)printX withPrintY:(int)printY withWidth:(int)width withHeight:(int)height withThickness:(int)thickness withLineColor:(NSString *)lineColor withRounding:(int)rounding;

/**
 @brief Print PDF417 barcode.
 
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param orientation Orientation as one of the ZPL_ROTATION_* constants.
 @param cellWidth Number of data columns to encode. (1 - 30)
 @param security Security level of error detection and correction. (1 - 8)
 @param numOfRow Number of data rows to encode. (1 - 30)
 @param truncate Truncate right row indicators and stop pattern. (Y, N)
 @param data Data of barcode to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printPDF417:(int)printX withPrintY:(int)printY withOrientation:(NSString *)orientation withCellWidth:(int)cellWidth withSecurity:(int)security withNumOfRow:(int)numOfRow withTruncate:(NSString *)truncate withData:(NSString *)data;

/**
 @brief Print QR Code barcode.
 
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param orientation Orientation as one of the ZPL_ROTATION_* constants.
 @param cellWidth Dimensional height of individual symbol elements.
 @param quality Quality level. (0, 50, 80, 100, 140, 200)
 @param data Data of barcode to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printDataMatrix:(int)printX withPrintY:(int)printY withOrientation:(NSString *)orientation withCellWidth:(int)cellWidth withQuality:(int)quality withData:(NSString *)data;

/**
 @brief Print DataMatrix barcode.
 
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param orientation Orientation as one of the ZPL_ROTATION_* constants.
 @param model 1 (original), 2 (enhanced - recommended)
 @param cellWidth Magnification factor. (1 - 10)
 @param data Data of barcode to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printQRCODE:(int)printX withPrintY:(int)printY withOrientation:(NSString *)orientation withModel:(int)model withCellWidth:(int)cellWidth withData:(NSString *)data;

/**
 @brief Send ZPL command to printer directly.
 
 @param command ZPL command to send.
 
 @return 0 if success, -1 if failure.
 */
- (long)directCommand:(NSString *)command;

/**
 @brief Send ZPL command to printer directly.
 
 @param data ZPL command to send.
 
 @return 0 if success, -1 if failure.
 */
- (long)printString:(NSString *)data;

- (long)printData:(unsigned char *)data withLength:(int)length;

/**
 @brief Check printer's status.
 
 @discussion If using Wi-Fi, call the status() fuction to get the status after this function is called. If using Bluetooth, calling this function will cause an EADSessionDataReceivedNotification to occur. Please refer to the sample project for an example of how to parse this notification.
 
 @return 0 if success, -1 if failure.
 */
- (long)printerCheck;

/**
 @brief Get printer's status.
 
 @note This function does not support the Bluetooth interface.
 
 @return Printer status as one of the STS_CPCL_* constants.
 */
- (long)status;

// Bluetooth only
- (long)searchPrinter:(NSString *)portName withPortParam:(int)port;
- (long)closePortReset;

/**
 @brief Get printer's status.
 
 @note This function does not support the Bluetooth interface.
 
 @param SendBuf ZPL command to send.
 @param wLength Length of ZPL command to send.
 @param RecvBuf Buffer to read from printer.
 
 @return 0 if success, -1 if failure.
 */
- (long)getPrinterInfo:(unsigned char *)SendBuf charsToSend:(int)wLength withRecvBuf:(unsigned char *)RecvBuf;

/**
 @brief Reboot the printer.
 
 @return 0 if success, -1 if failure.
 */
- (long)resetPrinter;

@end
