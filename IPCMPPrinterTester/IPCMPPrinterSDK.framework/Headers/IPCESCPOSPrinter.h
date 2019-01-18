//
//  IPCESCPOSPrinter.h
//  IPCMPPrinterSDK
//
//  Created by Infinite Peripherals on 6/20/18.
//  Copyright © 2018 Infinite Peripherals Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define ENABLE_POS
#define ENABLE_MSR

// Alignment
#define ALIGNMENT_LEFT      0
#define ALIGNMENT_CENTER    1
#define ALIGNMENT_RIGHT     2

// Font properties
#define FNT_DEFAULT         0
#define FNT_FONTB           1
#define FNT_BOLD            8
#define FNT_UNDERLINE       128
#define FNT_UNDERLINE2      256

// Font size
#define TXT_1HEIGHT         0
#define TXT_2HEIGHT         1
#define TXT_3HEIGHT         2
#define TXT_4HEIGHT         3
#define TXT_5HEIGHT         4
#define TXT_6HEIGHT         5
#define TXT_7HEIGHT         6
#define TXT_8HEIGHT         7

// Font size
#define TXT_1WIDTH          0
#define TXT_2WIDTH          16
#define TXT_3WIDTH          32
#define TXT_4WIDTH          48
#define TXT_5WIDTH          64
#define TXT_6WIDTH          80
#define TXT_7WIDTH          96
#define TXT_8WIDTH          112

// Barcode symbol
#define BCS_UPCA            65
#define BCS_UPCE            66
#define BCS_EAN13           67
#define BCS_JAN13           67
#define BCS_EAN8            68
#define BCS_JAN8            68
#define BCS_CODE39          69
#define BCS_ITF             70
#define BCS_CODABAR         71
#define BCS_CODE93          72
#define BCS_CODE128         73

// Barcode width (Default 3)
#define BCS_2WIDTH          2
#define BCS_3WIDTH          3
#define BCS_4WIDTH          4
#define BCS_5WIDTH          5
#define BCS_6WIDTH          6

// Barcode Text Position
#define HRI_TEXT_NONE       0
#define HRI_TEXT_ABOVE      1
#define HRI_TEXT_BELOW      2

// Bitmap image size 0 - 3
#define BITMAP_NORMAL           0
#define BITMAP_DOUBLE_WIDTH     1
#define BITMAP_DOUBLE_HEIGHT    2
#define BITMAP_QUADRUPLE        3

// QRCode Error Correction Level
#define QRCODE_EC_LEVEL_L       0
#define QRCODE_EC_LEVEL_M       1
#define QRCODE_EC_LEVEL_Q       2
#define QRCODE_EC_LEVEL_H       3

// Print direction
#define DIRECTION_LEFT_RIGHT        0
#define DIRECTION_BOTTOM_TOP        1
#define DIRECTION_RIGHT_LEFT        2
#define DIRECTION_TOP_BOTTOM        3

/** POS Printer only */
// Cashdrawer status
#define STS_CD_OPEN                 0
#define STS_CD_CLOSE                1
// Cashdrawer pin
#define CD_PIN_TWO                  0
#define CD_PIN_FIVE                 1

// Printer Status
#define STS_PRINTEROFF              128
#define STS_MSR_READ                64
#define STS_PAPEREMPTY              32
#define STS_COVEROPEN               16
#define STS_BATTERY_LOW             8
#define STS_PAPERNEAREMPTY          4
#define STS_NORMAL                  0

// MSR
#define MSR_TRACK_1                 49
#define MSR_TRACK_2                 50
#define MSR_TRACK_12                51
#define MSR_TRACK_3                 52
#define MSR_TRACK_23                54

/**
 @header    IPCESCPOSPrinter.h
 
 @author    Infinite Peripherals
 @copyright 2018 Infinite Peripherals Inc. All rights reserved.
 @version   1.0.0
 */
@interface IPCESCPOSPrinter : NSObject

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
 @brief Print text.
 
 @param data Text data to print.
 @param align Text alignment as one of the ALIGNEMENT_* constants.
 @param option Text attribute as one of the FNT_* constants.
 @param size Text size as one of the TXT_*WIDTH or TXT_*HEIGHT constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)printText:(NSString *)data withAlignment:(int)align withOption:(int)option withSize:(int)size;

/**
 @brief Print text.
 
 @param data Text data to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printString:(NSString*)data;

/**
 @brief Print text with ESC command.
 
 @param data Text data to print.
 @param length Length of data to print.
 
 @return 0 if success, -1 if failure.
 */
- (long)printData:(unsigned char *)data withLength:(int)length;

/**
 @brief Print NVBitmap image stored in printer.
 
 @param imageNumber Image number stored in printer. (1 - 255)
 @param align Alignment as one of the ALIGNEMENT_* constants.
 @param size Image size as one of the BITMAP_* constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)printNVBitmap:(int)imageNumber withAlignment:(int)align withSize:(int)size;

/**
 @brief Print bitmap image.
 
 @param filePath Path of image file.
 @param align Alignment as one of the ALIGNEMENT_* constants.
 @param size Image size as one of the BITMAP_* constants.
 @param bright Brightness of image. (1 - 10)
 
 @return 0 if success, -1 if failure.
 */
- (long)printBitmap:(NSString *)filePath withAlignment:(int)align withSize:(int)size withBrightness:(int)bright;

/**
 @brief Print barcode.
 
 @param data Barcode data to print.
 @param symbol Symbol type as one of the BCS_* constants.
 @param height Barcode height in Dot Units.
 @param width This value is barcode width [2 <= value <= 6]. It sets total barcode width to print.
 @param align Alignment as one of the ALIGNEMENT_* constants.
 @param textPos Printing position of barcode HRI letters as of of the HRI_* constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)printBarCode:(NSString *)data withSymbology:(int)symbol withHeight:(int)height withWidth:(int)width withAlignment:(int)align withHRI:(int)textPos;

/**
 @brief Print PDF417 barcode.
 
 @param data Barcode data to print.
 @param dataLength Length of Barcode data.
 @param columns Columns. (1 – 20)
 @param cWidth Cell Width. (2 - 6)
 @param align Alignment as one of the ALIGNEMENT_* constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)printPDF417:(NSString *)data withLength:(int)dataLength withColumns:(int)columns withCellWidth:(int)cWidth withAlignment:(int)align;

/**
 @brief Print QR Code barcode.
 
 @param data Barcode data to print.
 @param dataLength Length of Barcode data.
 @param moduleSize Module size. (1 – 20)
 @param ECLevel Error Correction Level as one of the QRCODE_EC_LEVEL_* constants.
 @param align Alignment as one of the ALIGNEMENT_* constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)printQRCode:(NSString *)data withLength:(int)dataLength withModuleSize:(int)moduleSize withECLevel:(int)ECLevel withAlignment:(int)align;

/**
 @brief Print UIImage.
 
 @param imgApp Image from app.
 @param align Alignment as one of the ALIGNEMENT_* constants.
 @param size This value is image size. It sets image size to print.
 @param bright This value is bright value.
 
 @return 0 if success, -1 if failure.
 */
- (long)printImage:(UIImage *)imgApp withAlignment:(int)align withSize:(int)size withBrightness:(int)bright;

/**
 @brief Print from web app.
 
 @param normalData Printing data from app.
 
 @return 0 if success, -1 if failure.
 */
- (long)printNormalWeb:(NSString *)normalData;

/**
 @brief Print font in iOS
 
 @param fontName Font name in iOS as a factor.
 @param bold Bold attribute as a factor.
 @param italic Italic attribute as a factor.
 @param underline Underline attribute as a factor.
 @param data Unicode which has a null-terminated string. It receives text to print as a factor.
 @param maxWidth It receives the maximum size of printing area as a factor.
 @param fontdotsize It receives size of font as a factor. [Unit : Dot]
 @param alignment Alignment as one of the ALIGNEMENT_* constants.
 @param reverse It receives reverse printing attribute as a factor.
 
 @return 0 if success, -1 if failure.
 */
- (long)printIOSFont:(NSString *)fontName withBold:(int)bold withItalic:(int)italic withUnderline:(int)underline withData:(NSString *)data withMaxWidth:(int)maxWidth withFontSize:(int)fontdotsize withAlgin:(int)alignment withReverse:(int)reverse;

/**
 @brief Print PDF file.
 
 @param filePath Path of PDF file.
 @param printPage Page number to print.
 @param pSize Printing width.
 @param align Alignment as one of the ALIGNEMENT_* constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)printPdfFile:(NSString *)filePath withPage:(int)printPage withPrintWidth:(int)pSize withAlignment:(int)align;

/**
 @brief Print PDF file.
 
 @param filePath Path of PDF file.
 @param startPage Start page number to print.
 @param endPage End page number to print.
 @param pSize Printing width.
 @param align Alignment as one of the ALIGNEMENT_* constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)printPdfFilePartial:(NSString *)filePath withStartPage:(int)startPage withEndPage:(int)endPage withPrintWidth:(int)pSize withAlignment:(int)align;

/**
 @brief This function is used for printing command file.
 
 @param filePath Path of command file.
 
 @return 0 if success, -1 if failure.
 */
- (long)printFile:(NSString *)filePath;

/**
 @brief Register Callback method that used in ASB Mode.
 
 @param object Instance to call Callback method.
 @param selector Callback method.
 
 @note Only one method(MSR, ASB callback) can be registered by using this method. For more information, refer to the sample application.
 */
- (void)registerCallback:(id)object withSelctor:(SEL)selector;

/**
 @brief Unregister Callback method that used in ASB Mode.
 */
- (void)unregisterCallback;

/**
 @brief Print and return to standard mode in page mode.
 
 @return 0 if success, -1 if failure.
 */
- (long)printPageModeData;

/**
 @brief Cancel print data in page mode.
 
 @return 0 if success, -1 if failure.
 */
- (long)clearPageModeData;

/**
 @brief Change to page mode or standard mode.
 
 @param pagemode Page mode status.
 
 @return 0 if success, -1 if failure.
 */
- (long)setPageMode:(BOOL)pagemode;

/**
 @brief Select print direction in page mode.
 
 @param direction Print direction as one of the DIRECTION_* constants.
 
 @return 0 if success, -1 if failure.
 */
- (long)setPrintDirection:(int)direction;

/**
 @brief Set printing area in page mode.
 
 @param startX Starting X position.
 @param startY Starting Y position.
 @param width Width of printing area. (Motion unit)
 @param height Height of printing area. (Motion unit)
 
 @return 0 if success, -1 if failure.
 */
- (long)setPrintingArea:(int)startX withStartY:(int)startY withWidth:(int)width withHeight:(int)height;

/**
 @brief Set horizontal and vertical motion units. (25.4mm / x {1/x Inches} , 25.4mm/y {1/y Inches})
 
 @param hUnit Horizontal motion unit.
 @param vUnit Verticle motion unit.
 
 @return 0 if success, -1 if failure.
 */
- (long)setMotionUnit:(int)hUnit withVUnit:(int)vUnit;

/**
 @brief Set absolute vertical print position in page mode. (Y axis)
 
 @param absolutePosition Starting position. (Motion unit)
 
 @return 0 if success, -1 if failure.
 */
- (long)setAbsoluteVertical:(int)absolutePosition;

/**
 @brief Set relative vertical print position in page mode. (Y axis)
 
 @param relativePosition Starting position. (Motion unit)
 
 @return 0 if success, -1 if failure.
 */
- (long)setRelativeVertical:(int)relativePosition;

/**
 @brief Enable ASB mode.
 
 @discussion If ASB mode is enabled, printer automatically transmits the status when the status changes. Callback method must be registered using registerCallback() before calling this method.
 
 @note ASB mode cannot be used simultaneously with MSR Card Read or the printCheck() method.
 
 @return 0 if success, -1 if failure.
 */
- (long)asbOn;

/**
 @brief Disable ASB mode.
 
 @return 0 if success, -1 if failure.
 */
- (long)asbOff;

/**
 @brief Returns ASB mode status.
 
 @return true if on, false if off.
 */
- (BOOL)asbMode;

/**
 @brief Set charset.
 
 @param encoding Charset to encode. (Refer to the iOS Codepage Manual)
 */
- (void)setEncoding:(NSStringEncoding)encoding;

/**
 @brief Feed line.
 
 @param lfConunt Count to line feed.
 
 @return 0 if success, -1 if failure.
 */
- (long)lineFeed:(int)lfConunt;

/**
 @brief Change MSR Status to Ready status and sets the request of MSR data transmission.
 
 @param mode One of the MSR_TRACK_* constants.
 
 @note This function cannot be used in ASB mode.
 
 @return STS_MSR_READ if success, STS_NORMAL if function fails to change the MSR mode.
 */
- (long)readMSR:(int)mode;

/**
 @brief Change MSR Status to normal status.
 
 @return 0 if success, -1 if failure.
 */
- (long)cancelMSR;

- (long)portCloseReset;

/**
 @brief Set the ICR communication.
 
 @param bBypassMode ICR communication mode. (True = enabled, False = disabled)
 
 @return LK_SUCCESS if success, LK_FAIL if failure.
 */
- (long)setBypass:(BOOL)bBypassMode;

/**
 @brief Print ICR data.
 
 @param data Data to send. Set the ICR Command. Reference to first payment command. Not include STX, ETX, LRC. Command ID + Length + command (Length = command length + 4).
 @param length Data length.
 
 @return 0 if success, -1 if failure.
 */
- (long)printIcrData:(unsigned char *)data withLength:(int)length;

/**
 @brief Cut paper.
 
 @note POS only.
 
 @return 0 if success, -1 if failure.
 */
- (long)cutPaper;

/**
 @brief Return printer status.
 
 @note Cannot be used in ASB mode.
 
 @return Status as one of the STS_* constants.
 */
- (long)printerSts;

/**
 @brief Cash drawer status.
 
 @note Cannot be used in ASB mode.
 
 @return STS_CD_OPEN if open, STS_CD_CLOSE if closed.
 */
- (long)drawerSts;

/**
 @brief Open cash drawer.
 
 @param pinNum Pin number to generate pulse as one of the CD_PIN_* constants.
 @param onTime Start time to generate pulse. (onTime * 2 ms)
 @param offTime Stop time to generate pulse. (offTime * 2 ms)
 
 @note Cannot be used in ASB mode.
 
 @return 0 if success, -1 if failure.
 */
- (long)openDrawer:(int)pinNum withPulseOnTime:(int)onTime withPulseOffTime:(int)offTime;

/**
 @brief Check printer's status.
 
 @discussion If using Wi-Fi, call the status() fuction to get the status after this function is called. If using Bluetooth, calling this function will cause an EADSessionDataReceivedNotification to occur. Please refer to the sample project for an example of how to parse this notification.
 
 @note Cannot be used in ASB mode.
 
 @return One of the STS_* constants.
 */
- (long)printerCheck;

// Bluetooth only
- (NSArray *)getConnectedPrinter;
- (long)searchPrinter:(NSString *)portName withPortParam:(int)port;
- (long)closePortReset;

@end
