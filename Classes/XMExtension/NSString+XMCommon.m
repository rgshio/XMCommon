//
//  NSString+XMCommon.m
//  XMCommon
//
//  Created by rgshio on 15/6/24.
//  Copyright (c) 2015年 rgshio. All rights reserved.
//

#import "NSString+XMCommon.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (XMCommon)

- (NSString *)encodestr {
    NSString *str = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    
    return str;
}

- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *mobile = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString *chinaMobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString *chinaUnicom = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString *chinaTelecom = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    NSPredicate *cmPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
    NSPredicate *cuPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaUnicom];
    NSPredicate *ctPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaTelecom];
    if ([mobilePredicate evaluateWithObject:self]
        || [cmPredicate evaluateWithObject:self]
        || [cuPredicate evaluateWithObject:self]
        || [ctPredicate evaluateWithObject:self]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isValidPersonID {
    // 判断位数
    if (self.length != 15 && self.length != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString *sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01", strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *paperId = [carid UTF8String];
    // 检验长度
    if(18 != strlen(paperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(paperId[i]) && !(('X' == paperId[i] || 'x' == paperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (paperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != paperId[17] ) {
        return NO;
    }
    return YES;
}

- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)encryptDESWithKey:(NSString *)key {
    return [self operation:kCCEncrypt algorithm:kCCAlgorithmDES key:key];
}

- (NSString *)decryptDESWithKey:(NSString *)key {
    return [self operation:kCCDecrypt algorithm:kCCAlgorithmDES key:key];
}

- (NSString *)encryptAESWithKey:(NSString *)key {
    return [self operation:kCCEncrypt algorithm:kCCAlgorithmAES128 key:key];
}

- (NSString *)decryptAESWithKey:(NSString *)key {
    return [self operation:kCCDecrypt algorithm:kCCAlgorithmAES128 key:key];
}

#pragma mark - 
/**
 *  判断是否在地区码内
 *
 *  @param code 地区码
 */
- (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"北京" forKey:@"11"];
    [dict setObject:@"天津" forKey:@"12"];
    [dict setObject:@"河北" forKey:@"13"];
    [dict setObject:@"山西" forKey:@"14"];
    [dict setObject:@"内蒙古" forKey:@"15"];
    [dict setObject:@"辽宁" forKey:@"21"];
    [dict setObject:@"吉林" forKey:@"22"];
    [dict setObject:@"黑龙江" forKey:@"23"];
    [dict setObject:@"上海" forKey:@"31"];
    [dict setObject:@"江苏" forKey:@"32"];
    [dict setObject:@"浙江" forKey:@"33"];
    [dict setObject:@"安徽" forKey:@"34"];
    [dict setObject:@"福建" forKey:@"35"];
    [dict setObject:@"江西" forKey:@"36"];
    [dict setObject:@"山东" forKey:@"37"];
    [dict setObject:@"河南" forKey:@"41"];
    [dict setObject:@"湖北" forKey:@"42"];
    [dict setObject:@"湖南" forKey:@"43"];
    [dict setObject:@"广东" forKey:@"44"];
    [dict setObject:@"广西" forKey:@"45"];
    [dict setObject:@"海南" forKey:@"46"];
    [dict setObject:@"重庆" forKey:@"50"];
    [dict setObject:@"四川" forKey:@"51"];
    [dict setObject:@"贵州" forKey:@"52"];
    [dict setObject:@"云南" forKey:@"53"];
    [dict setObject:@"西藏" forKey:@"54"];
    [dict setObject:@"陕西" forKey:@"61"];
    [dict setObject:@"甘肃" forKey:@"62"];
    [dict setObject:@"青海" forKey:@"63"];
    [dict setObject:@"宁夏" forKey:@"64"];
    [dict setObject:@"新疆" forKey:@"65"];
    [dict setObject:@"台湾" forKey:@"71"];
    [dict setObject:@"香港" forKey:@"81"];
    [dict setObject:@"澳门" forKey:@"82"];
    [dict setObject:@"国外" forKey:@"91"];
    
    if ([dict objectForKey:code] == nil || [[dict objectForKey:code] isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}

/**
 *  获取指定范围的字符串
 *
 *  @param str 字符串
 *  @param begin 字符串的开始小标
 *  @param end 字符串的结束下标
 */
- (NSString *)substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger)end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}

/**
 *  DES/AES 加密/解密
 *
 *  @param operation 加密或解密
 *  @param algorithm 加密或解密标准
 */
- (NSString *)operation:(CCOperation)operation algorithm:(CCAlgorithm)algorithm key:(NSString *)key {
    
    size_t blocksize;
    size_t keysize;
    
    switch (algorithm) {
        case kCCAlgorithmDES:
            blocksize = kCCBlockSizeDES;
            keysize = kCCKeySizeDES;
            break;
        case kCCAlgorithmAES128:
            blocksize = kCCBlockSizeAES128;
            keysize = kCCKeySizeAES128;
            break;
            
        default:
            return nil;
            break;
    }
    
    return [self operation:operation algorithm:algorithm blocksize:blocksize keysize:keysize key:key];
}

/**
 *  DES/AES 加密/解密
 *
 *  @param operation 加密或解密
 *  @param algorithm 加密或解密标准
 *  @param blocksize 块大小
 *  @param keysize   密钥的大小
 *  @param key       加密或解密的key
 */
- (NSString *)operation:(CCOperation)operation algorithm:(CCAlgorithm)algorithm blocksize:(size_t)blocksize keysize:(size_t)keysize key:(NSString *)key {
    
    NSData *operationData;
    if (operation == kCCDecrypt) {//传递过来的是decrypt 解密
        //解密 base64
        operationData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    }else {//传递过来的是encrypt 加密
        //加密 utf8
        operationData = [self dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    size_t dataInLength = [operationData length];//size_t是操作符sizeof返回的结果类型
    const void *dataIn = (const void *)[operationData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0;
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + blocksize) & ~(blocksize - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首1个字节的值设为值0
    
    const void *vkey = (const void *) [key UTF8String];
    
    //CCCrypt函数加密/解密
    //kCCOptionPKCS7Padding| kCCOptionECBMode
    ccStatus = CCCrypt(operation,//加密/解密
                       algorithm,//加密根据哪个标准（des，3des，aes...）
                       kCCOptionPKCS7Padding | kCCOptionECBMode,//选项分组密码算法(des:对每块分组加一次密;3DES:对每块分组加三个不同的密)
                       vkey,//密钥:加密和解密的密钥必须一致
                       keysize,//密钥的大小
                       NULL,//可选的初始矢量
                       dataIn,//数据的存储单元
                       dataInLength,//数据的大小
                       (void *)dataOut,//用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];

    NSString *result = nil;
    if (operation == kCCDecrypt) {//kCCDecrypt解密
        //得到解密出来的data数据，改变为utf-8的字符串
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else {//kCCEncrypt加密（加密过程中，把加好密的数据转成base64的）
        //编码base64
        result = [data base64EncodedStringWithOptions:0];
    }
    
    return result;
}

@end
