//
// Created by dmitrii.aitov@philips.com on 12/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRNetworkClient.h"

@interface ADRNetworkClient () <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong, nonnull) NSURLSession *session;
@property (nonatomic, strong, nonnull) NSMutableDictionary<NSURLRequest*, ADRNetworkClientDownloadCompletionBlock> *downloadCompletions;
@property (nonatomic, strong, nonnull) NSMutableDictionary<NSURLRequest*, ADRNetworkClientProgressBlock> *progresses;

@end

@implementation ADRNetworkClient

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        _session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration delegate:self delegateQueue:NSOperationQueue.mainQueue];
        _downloadCompletions = [NSMutableDictionary dictionary];
        _progresses = [NSMutableDictionary dictionary];
    }

    return self;
}

#pragma mark - ADRNetworkClientProtocol methods
- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request completion:(ADRNetworkClientCompletionBlock)completion
{
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:completion];
    [task resume];
    return task;
}

- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request
                                data:(NSData *)data
                          completion:(ADRNetworkClientCompletionBlock)completion
{
    NSURLSessionUploadTask *task = [self.session uploadTaskWithRequest:request fromData:data completionHandler:completion];
    [task resume];
    return task;
}

- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request
                  downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)completion
{
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:completion];
    [task resume];
    return task;
}

- (NSURLSessionTask *)executeRequest:(NSURLRequest *)request
                            progress:(ADRNetworkClientProgressBlock)progress
                  downloadCompletion:(ADRNetworkClientDownloadCompletionBlock)completion
{
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request];

    self.progresses[request] = progress;
    self.downloadCompletions[request] = completion;

    [task resume];
    return task;
}

#pragma mark - NSURLSessionDownloadDelegate methods

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    ADRNetworkClientProgressBlock progressBlock = self.progresses[downloadTask.originalRequest];
    if (progressBlock)
    {
        progressBlock(1.0f);
    }

    ADRNetworkClientDownloadCompletionBlock downloadCompletionBlock = self.downloadCompletions[downloadTask.originalRequest];
    if (downloadCompletionBlock)
    {
        downloadCompletionBlock(location, nil, nil);
    }
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    ADRNetworkClientProgressBlock progressBlock = self.progresses[downloadTask.originalRequest];
    if (progressBlock)
    {
        progressBlock((float)totalBytesWritten / (float)totalBytesExpectedToWrite);
    }
}


@end
