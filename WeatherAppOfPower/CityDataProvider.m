//
//  CityDataProvider.m
//  WeatherAppOfPower
//
//  Created by Martin Berger on 6/29/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import "CityDataProvider.h"

@implementation CityDataProvider

- (void)readDataFromFile {
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"city.list" ofType:@"json"];
    NSData *cityData = [[NSData alloc] initWithContentsOfFile:fileName];
    NSError *error;
    self.cities = (NSArray*) [NSJSONSerialization JSONObjectWithData:cityData options:0 error:&error];
}

@end
