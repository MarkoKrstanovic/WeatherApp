//
//  ViewController.h
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/14/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "Weather.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) City *city;
@property (nonatomic, strong) Weather *weather;
@property NSDictionary *first;
@property NSDictionary *coord;
@property (strong,nonatomic) NSURLSession *sesion;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lonLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *presureLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel1;
-(void)setUIWithData;
@end

