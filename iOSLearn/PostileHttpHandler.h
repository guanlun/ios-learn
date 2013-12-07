//
//  PostileHttpHandler.h
//  iOSLearn
//
//  Created by Guanlun Zhao on 12/7/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostileHttpHandler : NSObject

+ (NSDictionary *)sendRequestToURL:(NSString *)url WithData:(NSDictionary *)data;

@end
