//
//  City.h
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/27/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *idName;
@property(nonatomic, copy) NSString *lonName;
@property(nonatomic, copy) NSString *latName;
@property(nonatomic, copy) NSString *country;
@property NSInteger sectionNumber;

@end
