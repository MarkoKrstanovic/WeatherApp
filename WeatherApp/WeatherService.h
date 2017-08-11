//
//  WeatherService.h
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/16/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "ViewController.h"

@interface WeatherService : NSObject
+(WeatherService*)instance;
- (void)getData:(NSString*)latitude longitude:(NSString*)longitude completetionBlock:(void(^)(Weather *weather))callback;

@end
