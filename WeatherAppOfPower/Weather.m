//
//  Weather.m
//  WeatherAppOfPower
//
//  Created by Martin Berger on 6/14/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import "Weather.h"
#import "ViewController.h"


@implementation Weather

-(instancetype)initWithBackendData:(id)data;
{
    if (self = [super init])
    {
        NSDictionary *first = [data objectForKey:@"coord"];
        NSDictionary *second = [data objectForKey:@"name"];
        self.name = [NSString stringWithFormat:@"%@",second];
        NSDictionary *third = [data objectForKey:@"id"];
        self.idName = [NSString stringWithFormat:@"%@",third];
        NSDictionary *fourth = [data objectForKey:@"main"];
        NSDictionary *fourthTemp = [fourth objectForKey:@"temp"];
        self.temp = [NSString stringWithFormat:@"%@",fourthTemp];
        NSDictionary *fourthPressure = [fourth objectForKey:@"pressure"];
        self.presure = [NSString stringWithFormat:@"%@",fourthPressure];
        NSDictionary *latDic = [first objectForKey:@"lat"];
        self.lat = [NSString stringWithFormat: @"%@",latDic];
        NSDictionary *lonDic = [first objectForKey:@"lon"];
        self.lon = [NSString stringWithFormat: @"%@",lonDic];
    }
    return self;
}

@end
