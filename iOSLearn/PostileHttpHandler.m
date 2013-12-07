//
//  PostileHttpHandler.m
//  iOSLearn
//
//  Created by Guanlun Zhao on 12/7/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import "PostileHttpHandler.h"
#import "Classes/SBJsonParser.h"

@implementation PostileHttpHandler

+ (NSDictionary *)sendRequestToURL:(NSString *)url WithData:(NSDictionary *)data
{
    NSArray *keys = [data allKeys];
    NSMutableString *dataStr = [NSMutableString string];
    
    for (int i = 0; i < [keys count]; i++) {
        NSString *key = [keys objectAtIndex:i];
        
        NSMutableString *format = [NSMutableString string];
        
        if (i != [keys count] - 1) {
            [format appendString:@"%@=%@&"];
        } else {
            [format appendString:@"%@=%@"];
        }
        NSString *pair = [NSString stringWithFormat:format, key, [data objectForKey:key]];
        
        [dataStr appendString:pair];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    return [parser objectWithData:responseData];
}

@end
