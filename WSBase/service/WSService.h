//
//  ASIHttpWrap.h
//  CTWeMedia
//
//  Created by wrs on 15/4/8.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define DOWNLOAD_REQUEST      @"DOWNLOAD_REQUEST"     // 保存下载请求key
#define DOWNLOAD_URL          @"DOWNLOAD_URL"         // 保存下载量key

#define UPLOAD_REQUEST        @"UPLOAD_REQUEST"       // 保存上传请求key
#define UPLOAD_URL            @"UPLOAD_URL"           // 保存上传量key

typedef NS_OPTIONS(NSUInteger, WSServiceRequestMethod) {
    WSServiceRequestMethodGet                 = 0,         // GET请求
    WSServiceRequestMethodPOST                = 1 << 0,    // POST请求
    WSServiceRequestMethodPOSTBODY            = 2 << 1     // POST请求，入参放到requestBody中
};

typedef NS_OPTIONS(NSUInteger, WSServiceRequestType) {
    WSServiceRequestTypeAsync                 = 0,        // 异步请求
    WSServiceRequestTypeSync                  = 1 << 0,   // 同步请求
};

#define ASIHTTPWRAP_TIMEOUT_DEFAULT           10    //默认超时,下载、上传没有设置超时

typedef void(^ServiceSucCallBack)(id result);
typedef void(^ServiceFailCallBack)(id error);

typedef void(^ReceivingCallBack)(unsigned long long size, unsigned long long total, float percent, NSString *url, int tag) ;
typedef void(^DownloadSucCallBack)(NSString *url, int tag);
typedef void(^DownloadFailCallBack)(NSError *error, NSString *url, int tag) ;

typedef void(^SendingCallBack)(unsigned long long size, unsigned long long total, float percent, NSString *url, int tag) ;
typedef void(^UploadSucCallBack)(NSString *url, int tag);
typedef void(^UploadFailCallBack)(NSError *error, NSString *url, int tag) ;

@protocol ServiceDelegate <NSObject>

- (void)requestSucess:(id)result tag:(int)tag;

- (void)requestFail:(id)error tag:(int)tag;

@end

@interface WSService : NSObject

#pragma mark - 实例方法
/**
 *  异步GET请求
 *
 *  @param url
 *  @param tag
 *  @param delegate
 */
- (void)asycnGetWithUrl:(NSString *)url tag:(int)tag delegate:(id<ServiceDelegate>)delegate;

/**
 *  异步POST请求,代理回调
 *
 *  @param url
 *  @param params
 *  @param tag
 *  @param delegate 
 */
- (void)asycnPostWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag delegate:(id<ServiceDelegate>)delegate;

/**
 *  异步POST请求，块回调
 *
 *  @param url
 *  @param params
 *  @param tag
 *  @param sucCallBack
 *  @param failCallBack
 */
- (void)asyncPostWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack;

/**
 *  异步POSTBODY请求，块回调
 *  入参放到requestBody中
 *
 *  @param url
 *  @param params
 *  @param tag
 *  @param sucCallBack
 *  @param failCallBack
 */
+ (void)asyncPostBodyWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack;

/**
 *  ASIFormDataRequest  请求
 *
 *  @param url
 *  @param params
 *  @param tag
 *  @param sucCallBack
 *  @param failCallBack
 *  @param requestMothod
 *  @param requestType
 *  @param delegate
 */
- (void)requestWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack requestMethod:(WSServiceRequestMethod)requestMothod requestType:(WSServiceRequestType)requestType delegate:(id<ServiceDelegate>)delegate;

/**
 *  取消请求
 */
- (void)cancel;

#pragma mark - 静态方法
/**
 *  异步POST请求，块回调
 *
 *  @param url
 *  @param params
 *  @param tag
 *  @param sucCallBack
 *  @param failCallBack
 */
+ (void)asyncPostWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack;


+ (void)asyncGetWithUrl:(NSString *)url tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack;

/**
 *
 *
 *  @param url
 *  @param params
 *  @param tag
 *  @param sucCallBack
 *  @param failCallBack
 *  @param requestMothod
 *  @param requestType
 *  @param delegate
 *
 *  @return 
 */
+ (ASIFormDataRequest *)requestWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack requestMethod:(WSServiceRequestMethod)requestMothod requestType:(WSServiceRequestType)requestType delegate:(id<ServiceDelegate>) delegate;

#pragma mark - 下载文件
/**
 *  下载文件，开始下载与恢复下载都调用此方法
 *
 *  @param url
 *  @param savePath  保存文件路径，如xxx/xxxx.zip
 *  @param tempPath  零时文件路径，如xxx/xxxx.zip.temp
 *  @param receivingCallBack
 *  @param sucCallBack
 *  @param failCallBack
 *  @param tag
 *
 *  @return 
 */
+ (ASIHTTPRequest *)downLoadFileWithUrl:(NSString *)url params:(NSDictionary *)params savePath:(NSString *)savePath tempPath:(NSString *)tempPath receivingCallBack:(void(^)(unsigned long long size, unsigned long long total, float percent, NSString *url, int tag))receivingCallBack sucCallBack:(void (^)(NSString *url, int tag))sucCallBack failCallBack:(void (^)(NSError *error, NSString *url, int tag))failCallBack tag:(int)tag;

#pragma mark 上传文件
/**
 *  上传文件
 *
 *  @param url
 *  @param data
 *  @param fileName
 *  @param contentType
 *  @param sendCallBack
 *  @param sucCallBack
 *  @param failCallBack
 *  @param tag          tag description
 *
 *  @return return value description
 */
+ (ASIHTTPRequest *)uploadFileWithUrl:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)data fileName:(NSString *)fileName key:(NSString *)key contentType:(NSString *)contentType sendingCallBack:(void(^)(unsigned long long size, unsigned long long total, float percent, NSString *url, int tag))sendCallBack sucCallBack:(void (^)(NSString *url, int tag))sucCallBack failCallBack:(void (^)(NSError *error, NSString *url, int tag))failCallBack tag:(int)tag;

#pragma mark 暂停下载
/**
 *  暂停下载
 *
 *  @param url
 */
+ (void)cancelDownloadWithUrl:(NSString *)url;

#pragma mark 暂停上传
/**
 *  暂停上传
 *
 *  @param url url description
 */
+ (void)cancelUploadWithUrl:(NSString *)url;

#pragma mark - ASIHTTPRequest回调处理
+ (void)dealCompletionBlock:(ASIHTTPRequest *)request sucCallBack:(void (^)(id result))sucCallBack  failCallBack:(void (^)(id result))failCallBack delegate:(id<ServiceDelegate>) delegate;

+ (void)dealFailedBlock:(ASIHTTPRequest *)request failCallBack:(void (^)(id result))failCallBack delegate:(id<ServiceDelegate>) delegate;

#pragma mark - 调试模式下信息打印
+ (void)printRequestDataForDebug:(ASIHTTPRequest *)request;
+ (void)printResponseDataForDebug:(ASIHTTPRequest *)request;
+ (void)printRequestFailDataForDebug:(ASIHTTPRequest *)request;

@end
