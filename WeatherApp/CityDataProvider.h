//
//  CityDataProvider.h
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/29/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDataProvider : NSObject
- (void)readDataFromFile;
@property NSArray *cities;
@end
