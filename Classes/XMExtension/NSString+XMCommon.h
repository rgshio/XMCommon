//
//  NSString+XMCommon.h
//  XMCommon
//
//  Created by rgshio on 15/6/24.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString (XMCommon)

/** 
 *  字符串中特殊字符址转义
 */
- (NSString *)encodestr;

/** 
 *  验证邮箱是否有效
 */
- (BOOL)isValidEmail;

/** 
 *  验证手机号是否有效
 */
- (BOOL)isValidPhoneNumber;

/** 
 *  验证身份证是否有效
 */
- (BOOL)isValidPersonID;

/** 
 *  判断字符是否为数字
 */
- (BOOL)isPureInt;

/** 
 *  DES加密字符串
 */
- (NSString *)encryptDESWithKey:(NSString *)key;

/** 
 *  DES解密字符串
 */
- (NSString *)decryptDESWithKey:(NSString *)key;

/** 
 *  AES加密字符串
 */
- (NSString *)encryptAESWithKey:(NSString *)key;

/** 
 *  AES解密字符串
 */
- (NSString *)decryptAESWithKey:(NSString *)key;

/**
 *  DES/AES 加密/解密
 *
 *  @param operation 加密或解密
 *  @param algorithm 加密或解密标准
 *  @param blocksize 块大小
 *  @param keysize   密钥的大小
 *  @param key       加密或解密的key
 */
- (NSString *)operation:(CCOperation)operation algorithm:(CCAlgorithm)algorithm blocksize:(size_t)blocksize keysize:(size_t)keysize key:(NSString *)key;

@end
