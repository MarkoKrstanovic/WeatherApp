//
//  RootTableViewController.h
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/19/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "City.h"

@interface CityViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UISearchDisplayDelegate>

@property NSMutableArray *city;
@property id key;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *temp;
@property (strong, nonatomic) NSString *presure;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *idName;
@property NSMutableArray *cityTemp;
@property NSMutableArray *cityArray;
@property NSArray *searchResults;
@property NSInteger sect;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong) City *city1;
- (void)filterContentForSearchText:(NSString*)searchText;
@property NSDictionary *searchDict;

@end
