//
//  iService.m
//  PizzaMe
//
//  Created by Md Adit Hasan on 4/4/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "iService.h"

@implementation iService


 + (void)getJsonResponse : (NSString *)urlStr success : (void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure
{
    
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString: urlStr];
    
    
    // Asynchronously Api is hit here
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
                                           
                                          
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                                           NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                        
                                           success(json);
                            
                               });
                                           
                                           
                                       }];
    
    [dataTask resume] ; // Executed First
    
}


+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    
    NSURLSession * session = [NSURLSession sharedSession];
    // Asynchronously Api is hit here
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
                                          
                                        dispatch_async(dispatch_get_main_queue(), ^{

                                          if ( !error )
                                           {
                                               UIImage *image = [[UIImage alloc] initWithData:data];
                                               completionBlock(YES,image);
                                           } else{
                                               completionBlock(NO,nil);
                                           }
                                        });
                                           
                                       }];
    
    [dataTask resume] ; // Executed First
    
 }

 + (NSDictionary *)removeNull:(NSDictionary *)dictionary {
    
    NSMutableDictionary *prunedDictionary = [NSMutableDictionary dictionary];
    for (NSString * key in [dictionary allKeys])
    {
        if (![[dictionary objectForKey:key] isKindOfClass:[NSNull class]])
            [prunedDictionary setObject:[dictionary objectForKey:key] forKey:key];
        else
            [prunedDictionary setObject:@"" forKey:key];
    }
    return prunedDictionary;
}

@end
