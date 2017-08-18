//
//  WeatherService.m
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/16/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import "WeatherService.h"
#import "ViewController.h"

@implementation WeatherService

+(WeatherService*)instance
{
    static WeatherService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WeatherService alloc] init];
    });
    return sharedInstance;

}

- (void)getData:(NSString*)latitude longitude:(NSString*)longitude completetionBlock:(void(^)(Weather *weather))callback {
    NSString* url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&units=metric&appid=8ed53bfb45eb105881e8a0c24465ea20",latitude,longitude];
    NSURL *url1 = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [request setHTTPMethod:@"GET"];
    NSURLSession *sesion = [NSURLSession sharedSession];
    NSURLSessionTask *sesionTask = [sesion dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*) urlResponse;
        if ([response statusCode] == 200) {
            NSError *error = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            Weather *weather = [[Weather alloc] initWithBackendData:responseDic];
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(weather);
            });
        }
        else {
        }
    }];
    [sesionTask resume];
}

@end
