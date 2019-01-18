//
//  IPCCPCLPrinter.h
//  IPCMPPrinterSDK
//
//  Created by Infinite Peripherals on 6/20/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// Printer Status
#define STS_CPCL_BATTERY_LOW    8
#define STS_CPCL_COVER_OPEN     4
#define STS_CPCL_PAPER_EMPTY    2
#define STS_CPCL_BUSY           1
#define STS_CPCL_NORMAL         0

// Unit
#define CPCL_INCH   0
#define CPCL_CENTI  1
#define CPCL_MILLI  2
#define CPCL_DOTS   3

// Justification
#define CPCL_LEFT       0
#define CPCL_CENTER     1
#define CPCL_RIGHT      2

// Text Rotation
#define CPCL_NO_ROTATION    0
#define CPCL_0_ROTATION     0
#define CPCL_90_ROTATION    1
#define CPCL_180_ROTATION   2
#define CPCL_270_ROTATION   3

// Concatenation
/** Concatenates text as horizontal. */
#define CPCL_CONCAT    0
/** Concatenates text as vertical. */
#define CPCL_VCONCAT   1

// Media Type
/**  Label with Gap. */
#define CPCL_LABEL          0
/**  Label with Black Mark. */
#define CPCL_BLACKMARK      1
/**  Continuous Label. */
#define CPCL_CONTINUOUS     2

// Ratio
#define CPCL_TXT_1WIDTH     1
#define CPCL_TXT_2WIDTH     2
#define CPCL_TXT_3WIDTH     3
#define CPCL_TXT_4WIDTH     4
#define CPCL_TXT_5WIDTH     5
#define CPCL_TXT_6WIDTH     6
#define CPCL_TXT_7WIDTH     7
#define CPCL_TXT_8WIDTH     8
#define CPCL_TXT_9WIDTH     9
#define CPCL_TXT_10WIDTH    10
#define CPCL_TXT_11WIDTH    11
#define CPCL_TXT_12WIDTH    12
#define CPCL_TXT_13WIDTH    13
#define CPCL_TXT_14WIDTH    14
#define CPCL_TXT_15WIDTH    15
#define CPCL_TXT_16WIDTH    16

// Height Ratio
#define CPCL_TXT_1HEIGHT    1
#define CPCL_TXT_2HEIGHT    2
#define CPCL_TXT_3HEIGHT    3
#define CPCL_TXT_4HEIGHT    4
#define CPCL_TXT_5HEIGHT    5
#define CPCL_TXT_6HEIGHT    6
#define CPCL_TXT_7HEIGHT    7
#define CPCL_TXT_8HEIGHT    8
#define CPCL_TXT_9HEIGHT    9
#define CPCL_TXT_10HEIGHT   10
#define CPCL_TXT_11HEIGHT   11
#define CPCL_TXT_12HEIGHT   12
#define CPCL_TXT_13HEIGHT   13
#define CPCL_TXT_14HEIGHT   14
#define CPCL_TXT_15HEIGHT   15
#define CPCL_TXT_16HEIGHT   16

// Barcode Types
extern NSString * const CPCL_BCS_39;
extern NSString * const CPCL_BCS_39C;
extern NSString * const CPCL_BCS_39F;
extern NSString * const CPCL_BCS_39FC;
extern NSString * const CPCL_BCS_93;
extern NSString * const CPCL_BCS_128;
extern NSString * const CPCL_BCS_EAN128;
extern NSString * const CPCL_BCS_CODABAR;
extern NSString * const CPCL_BCS_CODABARC;
extern NSString * const CPCL_BCS_EAN8;
extern NSString * const CPCL_BCS_EAN82;
extern NSString * const CPCL_BCS_EAN85;
extern NSString * const CPCL_BCS_EAN13;
extern NSString * const CPCL_BCS_EAN132;
extern NSString * const CPCL_BCS_EAN135;
extern NSString * const CPCL_BCS_I2OF5;
extern NSString * const CPCL_BCS_POSTNET;
extern NSString * const CPCL_BCS_UPCA;
extern NSString * const CPCL_BCS_UPCA2;
extern NSString * const CPCL_BCS_UPCA5;
extern NSString * const CPCL_BCS_UPCE;
extern NSString * const CPCL_BCS_UPCE2;
extern NSString * const CPCL_BCS_UPCE5;
extern NSString * const CPCL_BCS_MSI;
extern NSString * const CPCL_BCS_MSI1C;
extern NSString * const CPCL_BCS_MSI2C;
extern NSString * const CPCL_BCS_MSI11C;

// Barcode Ratio
/** Set up the barcode ratio as 1.5 : 1. */
#define CPCL_BCS_0RATIO     0
/** Set up the barcode ratio as 2.0 : 1. */
#define CPCL_BCS_1RATIO     1
/** Set up the barcode ratio as 2.5 : 1. */
#define CPCL_BCS_2RATIO     2
/** Set up the barcode ratio as 3.0 : 1. */
#define CPCL_BCS_3RATIO     3
/** Set up the barcode ratio as 3.5 : 1. */
#define CPCL_BCS_4RATIO     4
/** Set up the barcode ratio as 2.0 : 1. */
#define CPCL_BCS_20RATIO    20
/** Set up the barcode ratio as 2.1 : 1. */
#define CPCL_BCS_21RATIO    21
/** Set up the barcode ratio as 2.2 : 1. */
#define CPCL_BCS_22RATIO    22
/** Set up the barcode ratio as 2.3 : 1. */
#define CPCL_BCS_23RATIO    23
/** Set up the barcode ratio as 2.4 : 1. */
#define CPCL_BCS_24RATIO    24
/** Set up the barcode ratio as 2.5 : 1. */
#define CPCL_BCS_25RATIO    25
/** Set up the barcode ratio as 2.6 : 1. */
#define CPCL_BCS_26RATIO    26
/** Set up the barcode ratio as 2.7 : 1. */
#define CPCL_BCS_27RATIO    27
/** Set up the barcode ratio as 2.8 : 1. */
#define CPCL_BCS_28RATIO    28
/** Set up the barcode ratio as 2.9 : 1. */
#define CPCL_BCS_29RATIO    29
/** Set up the barcode ratio as 3.0 : 1. */
#define CPCL_BCS_30RATIO    30

// Pattern
/** Filled (Black/default value). */
#define CPCL_DEFAULT_PATTERN    100
/** Prints pattern as a horizontal line. */
#define CPCL_HORIZON_PATTERN    101
/** Prints pattern as a vertical line. */
#define CPCL_VERTICAL_PATTERN   102
/** Prints diagonal pattern to the right. */
#define CPCL_RDIAGON_PATTERN    103
/** Prints diagonal pattern to the left. */
#define CPCL_LDIAGON_PATTERN    104
/** Prints pattern as a square. */
#define CPCL_SQUARE_PATTERN     105
/** Prints pattern as a diagonal line to right and left. */
#define CPCL_CROSS_PATTERN      106

// Tone
/** Set up as default. */
#define CPCL_CONT_DEFAULT       0
/** Print as middle brightness. */
#define CPCL_CONT_MEDIUM        1
/** Print as dark. */
#define CPCL_CONT_DARK          2
/** Print as very dark. */
#define CPCL_CONT_VERY_DARK     3

// 2D Barcode
extern NSString * const CPCL_BCS_PDF417;
extern NSString * const CPCL_BCS_MAXICODE;
extern NSString * const CPCL_BCS_QRCODE;
extern NSString * const CPCL_BCS_DATAMATRIX;
extern NSString * const CPCL_BCS_RSS14;
extern NSString * const CPCL_BCS_RSS14STACK;
extern NSString * const CPCL_BCS_RSS14STACK_OMNI;
extern NSString * const CPCL_BCS_RSS_LTD;
extern NSString * const CPCL_BCS_RSS_EXP;
extern NSString * const CPCL_BCS_RSS_EXPSTACK;

// Text Font
#define CPCL_FONT_0     0
#define CPCL_FONT_1     1
#define CPCL_FONT_2     2
#define CPCL_FONT_4     4
#define CPCL_FONT_5     5
#define CPCL_FONT_6     6
#define CPCL_FONT_7     7

// Country Command Parameters
extern NSString * const CPCL_COUNTRY_USA;
extern NSString * const CPCL_COUNTRY_GERMANY;
extern NSString * const CPCL_COUNTRY_FRANCE;
extern NSString * const CPCL_COUNTRY_SWEDEN;
extern NSString * const CPCL_COUNTRY_SPAIN;
extern NSString * const CPCL_COUNTRY_NORWAY;
extern NSString * const CPCL_COUNTRY_ITALY;
extern NSString * const CPCL_COUNTRY_UK;
extern NSString * const CPCL_COUNTRY_CP850;
extern NSString * const CPCL_COUNTRY_LATIN9;

/**
 @header    IPCCPCLPrinter.h
 
 @author    Infinite Peripherals
 @copyright 2018 Infinite Peripherals Inc. All rights reserved.
 @version   1.0.0
 */
@interface IPCCPCLPrinter : NSObject

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
 @brief Define a form.
 
 @param horizonOffset Horizontal offset of form.
 @param resolX Horizontal resolution of form.
 @param resolY Vertical resolution of form.
 @param labelHeight Label height.
 @param quantity Label quantity. (Max <= 1024)
 
 @return 0 if success, -1 if failure.
 */
- (long)setForm:(int)horizonOffset withResX:(int)resolX withResY:(int)resolY withLabelHeight:(int)labelHeight withQuantity:(int)quantity;

/**
 @brief Print form.
 
 @return 0 if success, -1 if failure.
 */
- (long)printForm;

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

/**
 @brief Set measure.
 
 @param measure Measure type as one of the CPCL_* constants. (Ex: CPCL_INCH)
 
 @return 0 if success, -1 if failure.
 */
- (long)setMeasure:(int)measure;

/**
 @brief Set justification of fields.
 
 @param justify Justification as one of the CPCL_* constants. (Ex: CPCL_LEFT)
 
 @return 0 if success, -1 if failure.
 */
- (long)setJustification:(int)justify;

/**
 @brief Print text to form at the specified location.
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param fontType Font type of text to print.
 @param fontSize Font size of the text to print.
 @param printX X-coordinate of text to print.
 @param printY Y-coordinate of text to print.
 @param data Unicode which has a null-terminated string. It receives text to print.
 @param count Count function of text to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printCPCLText:(int)rotation withFontType:(int)fontType withFontSize:(int)fontSize withPrintX:(int)printX withPrintY:(int)printY withData:(NSString *)data withCount:(int)count;

/**
 @brief Define the start of text concatenation and print position.
 
 @param contcatMode Concatenation method of text as one of the CPCL_* constants. (Ex: CPCL_CONCAT)
 @param printX X-coordinate of text to print.
 @param printY Y-coordinate of text to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)setConcat:(int)contcatMode withPrintX:(int)printX withPrintY:(int)printY;

/**
 @brief Define font to concatenate.
 
 @param fontType Font type of text to print.
 @param fontSize Font size of text to print.
 @param offset Unit value of starting point.
 @param data Unicode which has a null-terminated string. It receives text to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)concatText:(int)fontType withFontSize:(int)fontSize withOffset:(int)offset withData:(NSString *)data;

/**
 @brief Cancel text concatenation.
 
 @return 0 if success, -1 if failure.
 */
- (long)resetConcat;

/**
 @brief Define multi-line print with same line length and font.
 
 @param lineHeight Line height value of text to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)setMultiLine:(int)lineHeight;

/**
 @brief Print text defined with setMultiLine().
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param fontType Font type of text to print.
 @param fontSize Font size of text to print.
 @param printX X-coordinate of text to print.
 @param printY Y-coordinate of text to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)multiLineText:(int)rotation withFontType:(int)fontType withFontSize:(int)fontSize withPrintX:(int)printX withPrintY:(int)printY;

/**
 @brief Print text defined with setMultiLine().
 
 @param data Unicode which has a null-terminated string. It receives text to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)multiLineData:(NSString *)data;

/**
 @brief Cancel defined multi-print from setMultiLine().
 
 @return 0 if success, -1 if failure.
 */
- (long)resetMultiLine;

/**
 @brief Set the magnification of text.
 
 @param width Text width ratio as one of the CPCL_TXT_* constants. (Ex: CPCL_TXT_1WIDTH)
 @param height Text height ratio as one of the CPCL_TXT_* constants. (Ex: CPCL_TXT_1HEIGHT)
 
 @return 0 if success, -1 if failure.
 */
- (long)setMagnify:(int)width withHeight:(int)height;

/**
 @brief Cancel defined magnification from setMagnify().
 
 @return 0 if success, -1 if failure.
 */
- (long)resetMagnify;

/**
 @brief Print barcode to form at the specified location.
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param barcodeType Barcode type to print as one of the CPCL_BCS_* constants.
 @param NB Width of the smallest bar.
 @param ratio Barcode ratio as one of the CPCL_BCS_*RATIO constants.
 @param barHeight Height value of barcode to print.
 @param printX X-coordinate of text to print.
 @param printY Y-coordinate of text to print.
 @param data Unicode which has a null-terminated string. It receives barcode string to print.
 @param count Count function of text to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printCPCLBarcode:(int)rotation withBarcodeType:(NSString *)barcodeType withNarrowBar:(int)NB withRatio:(int)ratio withBarHeight:(int)barHeight withPrintX:(int)printX withPrintY:(int)printY withData:(NSString *)data withCount:(int)count;

/**
 @brief Print box.
 
 @param xs X-coordinate of starting point.
 @param ys Y-coordinate of starting point.
 @param xx X-coordinate of ending point.
 @param yx Y-coordinate of ending point.
 @param thickness Thickness of line to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printBox:(int)xs withYs:(int)ys withXx:(int)xx withYX:(int)yx withThickness:(int)thickness;

/**
 @brief Print line.
 
 @param xs X-coordinate of starting point.
 @param ys Y-coordinate of starting point.
 @param xx X-coordinate of ending point.
 @param yx Y-coordinate of ending point.
 @param thickness Thickness of line to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printLine:(int)xs withYs:(int)ys withXx:(int)xx withYx:(int)yx withThickness:(int)thickness;

/**
 @brief Print inverse line in special area.
 
 @param xs X-coordinate of starting point.
 @param ys Y-coordinate of starting point.
 @param xx X-coordinate of ending point.
 @param yx Y-coordinate of ending point.
 @param thickness Thickness of line to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)inverseLine:(int)xs withYs:(int)ys withXx:(int)xx withYx:(int)yx withThickness:(int)thickness;

/**
 @brief Set pattern for printing.
 
 @param patternNum Type of pattern to print as one of the CPCL_*_PATTERN constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)setPattern:(int)patternNum;

/**
 @brief Print bitmap image.
 
 @param filePath Path of image file.
 @param printX X-coordinate of image to print.
 @param printY Y-coordinate of image to print.
 @param bright Brightness of image. (1 - 10)
 
 @return 0 if success, -1 if failure.
 */
- (long)printBitmap:(NSString *)filePath withPrintX:(int)printX withPrintY:(int)printY withBrightness:(int)bright;

/**
 @brief Set contrast of entire label.
 
 @param darkness Contrast of label as one of the CPCL_CONT_* constants. (Ex: CPCL_CONT_DEFAULT)
 
 @return 0 if success, -1 if failure.
 */
- (long)setContrast:(int)darkness;

/**
 @brief Define width of form.
 
 @param pageWidth Width of form.
 
 @return 0 if success, -1 if failure.
 */
- (long)setPageWidth:(int)pageWidth;

/**
 @brief Print pcx image stored in flash file system of the printer.
 
 @param imageName Unicode which has a null-terminated string.
 @param printX X-coordinate of image to print.
 @param printY Y-coordinate of image to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printCPCLImage:(NSString *)imageName withPrintX:(int)printX withPrintY:(int)printY;

/**
 @brief Set print speed.
 
 @param speed Print speed. (0 =< speed =< 5)
 
 @return 0 if success, -1 if failure.
 */
- (long)setSpeed:(int)speed;

/**
 @brief Used instead of setContrast() for adjusting the darkness of entire label.
 
 @param tone Tone of darkness for entire label. (-99 =< tone =< 20)
 
 @return 0 if success, -1 if failure.
 */
- (long)setTone:(int)tone;

/**
 @brief Set HRI character information.
 
 @param fontNum Font type.
 @param fontSize Font size.
 @param offset Offset between barcode and text.
 
 @return 0 if success, -1 if failure.
 */
- (long)setCPCLBarcode:(int)fontNum withFontSize:(int)fontSize withOffset:(int)offset;

/**
 @brief Cancel HRI character information set by setCPCLBarcode().
 
 @return 0 if success, -1 if failure.
 */
- (long)resetCPCLBarcode;

/**
 @brief Set label media type.
 
 @param mode Label type as one of the CPCL_* constants. (Ex: CPCL_LABEL)
 
 @return 0 if success, -1 if failure.
 */
- (long)setMedia:(int)mode;

/**
 @brief Set charset.
 
 @param encoding Charset to encode. (Refer to the iOS Codepage Manual)
 */
- (void)setEncoding:(NSStringEncoding)encoding;

/**
 @brief Print PDF417 barcode.
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param unitWidth Unit width of narrowest element. (1 - 32, Default 2)
 @param unitHeight Unit height of narrowest element. (1 - 32, Default 6)
 @param column Number of columns to use. (1 - 30, Default 3)
 @param securityLevel Maximum number of errors detected and/or corrected. (0 - 8, Default 1)
 @param data Unicode which has a null-terminated string. It receives barcode string to print.
 */
- (void)printPDF417:(int)rotation withPrintX:(int)printX withPrintY:(int)printY withUnitWidth:(int)unitWidth withUnitHeight:(int)unitHeight withNumOfColumns:(int)column withSecurityLevel:(int)securityLevel withData:(NSString *)data;

/**
 @brief Print Datamatrix barcode.
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param eccLevel ECC Level of Datamatrix. (0, 50, 80, 100, 140, 200, Default 0)
 @param cellSize Cell size. (1 - 24, Default 4)
 @param data Unicode which has a null-terminated string. It receives barcode string to print.
 */
- (void)printDATAMATRIX:(int)rotation withPrintX:(int)printX withPrintY:(int)printY withECCLevel:(int)eccLevel withCellSize:(int)cellSize withData:(NSString *)data;

/**
 @brief Print QR Code barcode.
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param version Version of QRCODE. (1 - 40)
 @param ecLevel  Error Correction Level. (0 - 3, Default 1)
 @param moduleSize Module size. (1 - 24, Default 4)
 @param maskNo Mask no. (0 - 7, If value is more than 8 it is auto selected)
 @param data Unicode which has a null-terminated string. It receives barcode string to print.
 */
- (void)printQRCODE:(int)rotation withPrintX:(int)printX withPrintY:(int)printY withVersion:(int)version withECLevel:(int)ecLevel withModuleSize:(int)moduleSize withMaskNo:(int)maskNo withData:(NSString *)data;

/**
 @brief Print GS1 barcode.
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param type Barcode type as one of the CPCL_BCS_* constants.
 @param moduleWidth Module width. (1 - 10 Dots)
 @param height Barcode Height. (10 ~ Dots)
 @param printX X-coordinate of barcode to print.
 @param printY Y-coordinate of barcode to print.
 @param data Unicode which has a null-terminated string. It receives barcode string to print.
 */
- (void)printGS1:(int)rotation withType:(NSString *)type withModuleWidth:(int)moduleWidth withHeight:(int)height withPrintX:(int)printX withPrintY:(int)printY withData:(NSString *)data;

/**
 @brief Print UIImage.
 
 @param imgApp UIImage to print.
 @param printX X-coordinate of image to print.
 @param printY Y-coordinate of image to print.
 @param bright Brightness of image to print.

 @return 0 if success, -1 if failure.
 */
- (long)printImage:(UIImage *)imgApp withPrintX:(int)printX withPrintY:(int)printY withBrightness:(int)bright;

/**
 @brief Print image from web app.
 
 @param normalData Image data to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printNormalWeb:(NSString *)normalData;

/**
 @brief Print text in iOS.
 
 @param rotation Print direction as one of the CPCL_*_ROTATION constants.
 @param printX X-coordinate of text to print.
 @param printY Y-coordinate of text to print.
 @param fontName Font name in iOS.
 @param bold Bold attribute.
 @param italic Italic attribute.
 @param underline Underline attribute.
 @param data Unicode which has a null-terminated string. It receives text to print.
 @param maxWidth Maximum width of printing area.
 @param fontdotsize Size of font. (Unit: dot)
 @param reverse Reverse attribute.
 
 @return 0 if success, -1 if font does not exist, -2 if buffer size error.
 */
- (long)printIOSFont:(int)rotation withPrintX:(int)printX withPrintY:(int)printY withFontName:(NSString *)fontName withBold:(int)bold withItalic:(int)italic withUnderline:(int)underline withData:(NSString *)data withMaxWidth:(int)maxWidth withFontSize:(int)fontdotsize withReverse:(int)reverse;

/**
 @brief Check printing results.

 @return 0 if success, -1 if failure.
 */
- (long)printFormResult;

/**
 @brief Print PDF file.
 
 @param filePath Path to PDF file.
 @param printPage Page to print.
 @param pSize Printing width.
 
 @return 0 if success, -1 if failure.
 */
- (long)printPdfFile:(NSString *)filePath withPage:(int)printPage withPrintWidth:(int)pSize;

/**
 @brief Print part of PDF file.
 
 @param filePath Path to PDF file.
 @param startPage Start page number to print.
 @param endPage End page number to print.
 @param pSize Printing width.
 
 @return 0 if success, -1 if failure.
 */
- (long)printPdfFilePartial:(NSString *)filePath withStartPage:(int)startPage withEndPage:(int)endPage withPrintWidth:(int)pSize;

/**
 @brief Print file from command line.
 
 @param filePath Path to file.
 
 @return 0 if success, -1 if failure.
 */
- (long)printFile:(NSString *)filePath;

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

// Country
- (long)setCountry:(NSString *)country;
- (long)resetCountry;

@end
