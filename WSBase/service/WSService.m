//
//  ASIHttpWrap.m
//  CTWeMedia
//
//  Created by wrs on 15/4/8.
//  Copyright (c) 2015年 wrs. All rights reserved.
//


#import "WSService.h"
#import "ASIFormDataRequest.h"
#import "WSUploadDownloadRequest.h"

@interface WSService () <ASIHTTPRequestDelegate>

@property (assign, nonatomic) id<ServiceDelegate> delegate;

@property (strong, nonatomic) ASIFormDataRequest *request;

@end

@implementation WSService
@synthesize request;

#pragma mark - 实例方法
#pragma mark 异步GET请求
- (void)asycnGetWithUrl:(NSString *)url tag:(int)tag delegate:(id<ServiceDelegate>)delegate
{
    [self requestWithUrl:url params:nil tag:tag sucCallBack:nil failCallBack:nil requestMethod:WSServiceRequestMethodGet requestType:WSServiceRequestTypeAsync delegate:delegate];
}

#pragma mark 异步POST请求，代理回调
- (void)asycnPostWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag delegate:(id<ServiceDelegate>)delegate
{
    [self requestWithUrl:url params:params tag:tag sucCallBack:nil failCallBack:nil requestMethod:WSServiceRequestMethodPOST requestType:WSServiceRequestTypeAsync delegate:delegate];
}

#pragma mark 异步POST请求，块回调
- (void)asyncPostWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack
{
    [self requestWithUrl:url params:params tag:tag sucCallBack:sucCallBack failCallBack:failCallBack requestMethod:WSServiceRequestMethodPOST requestType:WSServiceRequestTypeAsync delegate:nil];
}

+ (void)asyncPostBodyWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack
{
    [WSService requestWithUrl:url params:params tag:tag sucCallBack:sucCallBack failCallBack:failCallBack requestMethod:WSServiceRequestMethodPOSTBODY requestType:WSServiceRequestTypeAsync delegate:nil];
}

#pragma mark - 实例方法统一处理
- (void)requestWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack requestMethod:(WSServiceRequestMethod)requestMothod requestType:(WSServiceRequestType)requestType delegate:(id<ServiceDelegate>) delegate;
{
   ASIFormDataRequest *tempRequest = [WSService requestWithUrl:url params:params tag:tag sucCallBack:sucCallBack failCallBack:failCallBack requestMethod:requestMothod requestType:requestType delegate:delegate];
    self.request = tempRequest;
}

#pragma mark － 取消请求
- (void)cancel
{
    if (request) {
        [request cancel];
    }
}

#pragma mark - 异步静态方法
+ (void)asyncPostWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack
{
    [WSService requestWithUrl:url params:params tag:tag sucCallBack:sucCallBack failCallBack:failCallBack requestMethod:WSServiceRequestMethodPOST requestType:WSServiceRequestTypeAsync delegate:nil];
}

+ (void)asyncGetWithUrl:(NSString *)url tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack
{
    [WSService requestWithUrl:url params:nil tag:tag sucCallBack:sucCallBack failCallBack:failCallBack requestMethod:WSServiceRequestMethodGet requestType:WSServiceRequestTypeAsync delegate:nil];
}

#pragma mark - 统一处理请求
+ (ASIFormDataRequest *)requestWithUrl:(NSString *)url params:(NSDictionary *)params tag:(int)tag sucCallBack:(void (^)(id result))sucCallBack failCallBack:(void (^)(id error))failCallBack requestMethod:(WSServiceRequestMethod)requestMothod requestType:(WSServiceRequestType)requestType delegate:(id<ServiceDelegate>) delegate
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nsUrl];
    
    
    
    request.tag = tag;
    [request setTimeOutSeconds:ASIHTTPWRAP_TIMEOUT_DEFAULT];
    switch (requestMothod) {
        case WSServiceRequestMethodGet:
        {
             request.requestMethod = @"GET";
        }
            break;
        case WSServiceRequestMethodPOST:
        {
            request.requestMethod = @"POST";
            
            // 入参
            NSArray *allKeys = [params allKeys];
            for(id key in allKeys)
            {
                id value = [params valueForKey:key];
                [request setPostValue:value forKey:(NSString *)key];
            }
            [request buildPostBody];
        }
            break;
        case WSServiceRequestMethodPOSTBODY:
        {
            request.requestMethod = @"POST";
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                               options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:nil];
            NSMutableData *data = [NSMutableData dataWithData:jsonData];
            [request setPostBody:data];
        }
            break;
        default:
            break;
    }
    
    // 调试 打印请求url及入参
#ifdef DEBUG
    [WSService printRequestDataForDebug:request];
#endif
    
    __weak ASIFormDataRequest *respRequest = request;

    // 请求完成
    [request setCompletionBlock:^{
        [WSService dealCompletionBlock:respRequest sucCallBack:sucCallBack failCallBack:failCallBack delegate:delegate];
    }];
    
    // 请求失败
    [request setFailedBlock:^{
        [WSService dealFailedBlock:respRequest failCallBack:failCallBack delegate:delegate];
    }];
    
    switch (requestType) {
        case WSServiceRequestTypeAsync:
        {
            // 开始异步请求
            [request startAsynchronous];
        }
            break;
        case WSServiceRequestTypeSync:
        {
            // 开始同步请求
            [request startSynchronous];
        }
            break;
        default:
            break;
    }
    return request;
}

#pragma mark - 下载文件
+ (ASIHTTPRequest *)downLoadFileWithUrl:(NSString *)url  params:(NSDictionary *)params savePath:(NSString *)savePath tempPath:(NSString *)tempPath receivingCallBack:(void(^)(unsigned long long size, unsigned long long total, float percent, NSString *url, int tag))receivingCallBack sucCallBack:(void (^)(NSString *url, int tag))sucCallBack failCallBack:(void (^)(NSError *error, NSString *url, int tag))failCallBack tag:(int)tag
{
    ASIFormDataRequest *downloadRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [downloadRequest setShowAccurateProgress:YES];
    [downloadRequest setDownloadDestinationPath:savePath];
    [downloadRequest setTemporaryFileDownloadPath:tempPath];
    [downloadRequest setAllowResumeForFileDownloads:YES];
    [downloadRequest setShouldContinueWhenAppEntersBackground:YES];
    downloadRequest.tag = tag;

    // 入参
    NSArray *allKeys = [params allKeys];
    for(id key in allKeys)
    {
        id value = [params valueForKey:key];
        [downloadRequest setPostValue:value forKey:(NSString *)key];
    }

    [downloadRequest setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        float before = [[userDefaults objectForKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_URL, url]] floatValue];
        float cur = size + before;
        float percent = 1.0000 * cur / total;
//        float showCur = size * 1.000 / 1024 /1024 / 1024;
//        float showTotal = total * 1.0000 / 1024.0000 /1024 / 1024;
        if (receivingCallBack) {
            receivingCallBack(size, total, percent, url, tag);
        }
       // NSLog(@"下载精度:%.2f cur:%.2f total:%.2f", percent, showCur, showTotal);
        
        // 保存当前已下载量
        [userDefaults setObject:[NSNumber numberWithFloat:cur] forKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_URL, url]];
    }];
    [downloadRequest setCompletionBlock:^{
        // 下载成功后，删除保存的下载量
         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_URL, url]];
        
        // 下载成功后，删除request
        NSMutableDictionary *downloadRequestDic = [WSUploadDownloadRequest sharedWSUploadDownloadRequest].downloadRequestDic;
        [downloadRequestDic removeObjectForKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_REQUEST, url]];
        
        if (sucCallBack) {
            sucCallBack(url, tag);
        }
    }];
    __weak ASIHTTPRequest *weakRequest = downloadRequest;
    [downloadRequest setFailedBlock:^{
        // 下载失败时，删除保存的下载量
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_URL, url]];
        
        // 下载失败时，删除request
        NSMutableDictionary *downloadRequestDic = [WSUploadDownloadRequest sharedWSUploadDownloadRequest].downloadRequestDic;
        [downloadRequestDic removeObjectForKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_REQUEST, url]];
        if (failCallBack) {
            failCallBack(weakRequest.error, url, tag);
        }
    }];
    
    // 保存下载request,方便暂停下载时获得request
    WSUploadDownloadRequest *uploadDownloadRequest = [WSUploadDownloadRequest sharedWSUploadDownloadRequest];
    if (!uploadDownloadRequest.downloadRequestDic) {
        uploadDownloadRequest.downloadRequestDic = [[NSMutableDictionary alloc] init];
    }
    [uploadDownloadRequest.downloadRequestDic setObject:downloadRequest forKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_REQUEST, url]];

    [downloadRequest startAsynchronous];
    return downloadRequest;
}

#pragma mark 上传文件
+ (ASIHTTPRequest *)uploadFileWithUrl:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)data fileName:(NSString *)fileName key:(NSString *)key contentType:(NSString *)contentType sendingCallBack:(void(^)(unsigned long long size, unsigned long long total, float percent, NSString *url, int tag))sendCallBack sucCallBack:(void (^)(NSString *url, int tag))sucCallBack failCallBack:(void (^)(NSError *error, NSString *url, int tag))failCallBack tag:(int)tag
{
    ASIFormDataRequest *uploadRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    // 入参
    NSArray *allKeys = [params allKeys];
    for(id key in allKeys)
    {
        id value = [params valueForKey:key];
        [uploadRequest setPostValue:value forKey:(NSString *)key];
    }
    [uploadRequest setShowAccurateProgress:YES];
    [uploadRequest setData:data withFileName:fileName andContentType:contentType forKey:key];
    [uploadRequest setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        float before = [[userDefaults objectForKey:[NSString stringWithFormat:@"%@%@", UPLOAD_URL, url]] floatValue];
        float cur = size + before;
        float percent = 1.0000 * cur / total;
        //        float showCur = size * 1.000 / 1024 /1024 / 1024;
        //        float showTotal = total * 1.0000 / 1024.0000 /1024 / 1024;
        if (sendCallBack) {
            sendCallBack(size, total, percent, url, tag);
        }
        // NSLog(@"下载精度:%.2f cur:%.2f total:%.2f", percent, showCur, showTotal);
        
        // 保存当前已上传量
        [userDefaults setObject:[NSNumber numberWithFloat:cur] forKey:[NSString stringWithFormat:@"%@%@", UPLOAD_URL, url]];
    }];
    [uploadRequest setShouldContinueWhenAppEntersBackground:YES];
    uploadRequest.tag = tag;
    [uploadRequest setCompletionBlock:^{
        // 上传完成时，删除当前上传量
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:[NSString stringWithFormat:@"%@%@", UPLOAD_URL, url]];
        
        // 上传完成时，删除request
        NSMutableDictionary *uploadRequestDic = [WSUploadDownloadRequest sharedWSUploadDownloadRequest].uploadRequestDic;
        [uploadRequestDic removeObjectForKey:[NSString stringWithFormat:@"%@%@", UPLOAD_URL, url]];
        
        if (sucCallBack) {
            sucCallBack(url, tag);
        }
    }];
    __weak ASIHTTPRequest *weakRequest = uploadRequest;
    [uploadRequest setFailedBlock:^{
        // 上传失败时，删除当前上传量
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:[NSString stringWithFormat:@"%@%@", UPLOAD_URL, url]];
        
        // 上传失败时，删除request
        NSMutableDictionary *uploadRequestDic = [WSUploadDownloadRequest sharedWSUploadDownloadRequest].uploadRequestDic;
        [uploadRequestDic removeObjectForKey:[NSString stringWithFormat:@"%@%@", UPLOAD_URL, url]];
        if (failCallBack) {
            failCallBack(weakRequest.error, url, tag);
        }
    }];
    
    // 保存上传request,方便暂停下载时获得request
    WSUploadDownloadRequest *uploadDownloadRequest = [WSUploadDownloadRequest sharedWSUploadDownloadRequest];
    if (!uploadDownloadRequest.uploadRequestDic) {
        uploadDownloadRequest.uploadRequestDic = [[NSMutableDictionary alloc] init];
    }
    [uploadDownloadRequest.uploadRequestDic setObject:uploadRequest forKey:[NSString stringWithFormat:@"%@%@", UPLOAD_REQUEST, url]];

    [uploadRequest startAsynchronous];
    return uploadRequest;

}

#pragma mark 暂停下载
+ (void)cancelDownloadWithUrl:(NSString *)url
{
    NSMutableDictionary *downloadRequestDic = [WSUploadDownloadRequest sharedWSUploadDownloadRequest].downloadRequestDic;
    ASIHTTPRequest *downloadRequest = [downloadRequestDic valueForKey:[NSString stringWithFormat:@"%@%@", DOWNLOAD_REQUEST, url]];
    if (downloadRequest) {
        [downloadRequest clearDelegatesAndCancel];
    }
}

#pragma mark - 暂停上传
+ (void)cancelUploadWithUrl:(NSString *)url
{
    NSMutableDictionary *uploadRequestDic = [WSUploadDownloadRequest sharedWSUploadDownloadRequest].uploadRequestDic;
    ASIHTTPRequest *uploadRequest = [uploadRequestDic valueForKey:[NSString stringWithFormat:@"%@%@", UPLOAD_REQUEST, url]];
    if (uploadRequest) {
        [uploadRequest clearDelegatesAndCancel];
    }
}

#pragma mark - ASIHTTPRequest回调处理
+ (void)dealCompletionBlock:(ASIHTTPRequest *)request sucCallBack:(void (^)(id result))sucCallBack  failCallBack:(void (^)(id result))failCallBack delegate:(id<ServiceDelegate>) delegate
{
    NSData *responseData = [request responseData];
    NSError *jsonError = nil;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError];
    
    // 调试打印响应数据
#ifdef DEBUG
    [WSService printResponseDataForDebug:request];
#endif
    
    // json 解析成功
    if (!jsonError) {
        // 块回调
        if (sucCallBack) {
            sucCallBack(resultDic);
        }
        
        // 代理回调
        if ([delegate respondsToSelector:@selector(requestSucess:tag:)]) {
            [delegate requestSucess:resultDic tag:(int)request.tag];
        }
    
    // json 解析失败
    } else {
        // 请求错误回调
        if (failCallBack) {
            failCallBack(jsonError);
        }
        
        // 代理回调
        if ([delegate respondsToSelector:@selector(requestFail:tag:)]) {
            [delegate requestFail:jsonError tag:(int)request.tag];
        }
    }
   
}

+ (void)dealFailedBlock:(ASIHTTPRequest *)request failCallBack:(void (^)(id result))failCallBack delegate:(id<ServiceDelegate>) delegate
{
    // 调试 打印请求错误
#ifdef  DEBUG
    [WSService printRequestFailDataForDebug:request];
#endif
    
    // 请求错误回调
    if (failCallBack) {
        failCallBack(request.error);
    }

    // 代理回调
    if ([delegate respondsToSelector:@selector(requestFail:tag:)]) {
        [delegate requestFail:request.error tag:(int)request.tag];
    }
}

#pragma mark - 调试模式下信息打印
+ (void)printRequestDataForDebug:(ASIHTTPRequest *)request
{
    NSString *url = request.url.absoluteString;
    NSInteger tag = request.tag;
    NSString *postBody = [[NSString alloc] initWithData:[request postBody] encoding:NSUTF8StringEncoding];
    // 方便拷贝到浏览器查看响应数据
    NSLog(@"可以拷贝到浏览器查看数据，开始请求数据 URL:%@", [NSString stringWithFormat:@"%@?%@", url, postBody]);
    
    //方便本地控制台查看入参
    NSLog(@"request \n { \n  url:%@, \n  tag:%ld,\n  postbody:%@\n }", url, tag, postBody);
}

+ (void)printResponseDataForDebug:(ASIHTTPRequest *)request
{
    NSString *postBody = [[NSString alloc] initWithData:[request postBody] encoding:NSUTF8StringEncoding];
    NSString *url = request.url.absoluteString;
    NSInteger tag = request.tag;
    
   
    NSError *requestError = request.error;
    
    //请求有错误
    if (requestError) {
        NSLog(@"－－－－－请求失败－－－－－:%@", requestError);
    }
    NSData *responseData = [request responseData];
    NSError *jsonError = nil;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError];
    
    // json格式解析失败
    if (jsonError) {
        NSLog(@"JSON 解析失败:%@", jsonError);
    }
    
    // 打印json格式的响应报文，方便观看
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resultDic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // 查看对应的请求url
    NSLog(@"request \n { \n  url:%@, \n  tag:%ld,\n  postbody:%@\n } \n响应报文：\n%@", url, tag, postBody, jsonStr);
}

+ (void)printRequestFailDataForDebug:(ASIHTTPRequest *)request
{
    NSLog(@"request result Error! url:%@ \n tag:%d error:%@\n", request.url.absoluteString, (int)request.tag, request.error);
}

@end
