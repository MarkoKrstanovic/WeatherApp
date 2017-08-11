//
//  Weather.h
//  WeatherAppOfPower
//
//  Created by Martin Berger on 6/14/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *temp;
@property (strong, nonatomic) NSString *presure;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *idName;

- (id)initWithBackendData:(id)data;
@end
