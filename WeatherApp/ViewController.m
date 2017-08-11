//
//  ViewController.m
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/14/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"
#import "WeatherService.h"
#import "City.h"
#import "CityViewController.h"

@interface ViewController ()
@property (nonatomic, strong) WeatherService *service;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.service = [[WeatherService alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    [self.service getData:self.city.latName longitude:self.city.lonName completetionBlock:^(Weather *weather) {
        self.weather = weather;
        [self setUIWithData];
    }];
}

- (void)setUIWithData {
    CityViewController *viewCont = [[CityViewController alloc]init];
    if (!viewCont.searchResults) {
        self.idLabel1.text = [NSString stringWithFormat:@"%@", self.city.idName];
        self.nameLabel.text = self.city.name;
        self.latLabel.text = [NSString stringWithFormat:@"%@", self.city.latName];
        self.lonLabel.text = [NSString stringWithFormat:@"%@", self.city.lonName];
        self.presureLabel.text = [NSString stringWithFormat:@"%@", self.weather.presure];
        self.tempLabel.text = [NSString stringWithFormat:@"%@", self.weather.temp];
    } else {
        NSLog(@"%@", viewCont.city1.name);
    }
}

@end
