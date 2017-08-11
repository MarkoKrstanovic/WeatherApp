//
//  RootTableViewController.m
//  WeatherAppOfPower
//
//  Created by Marko Krstanovic on 6/19/17.
//  Copyright © 2017 heavydebugging.inc. All rights reserved.
//

#import "CityViewController.h"
#import "City.h"
#import "CityDataProvider.h"

@interface CityViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CityDataProvider *dataProvider;
@property (nonatomic, strong) NSArray *parsedCities;
@end

@implementation CityViewController

- (CityDataProvider*)dataProvider {
    if (_dataProvider) {
        return _dataProvider;
    }
    _dataProvider = [[CityDataProvider alloc] init];
    return _dataProvider;
}

- (void)viewDidLoad {
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    
//    NSMutableArray *index = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
//
//    CGRect searchBarFrame = self.searchController.searchBar.frame;
//    [self.tableView scrollRectToVisible:searchBarFrame animated:NO];
    
    
    [super viewDidLoad];

    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    self.cityArray = [NSMutableArray arrayWithCapacity:1];
    
    [self.dataProvider readDataFromFile];

    NSMutableArray *parsedCities = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *cityDict in self.dataProvider.cities) {
        City *aCity = [[City alloc] init];
        aCity.name = [cityDict objectForKey:@"name"];
        aCity.idName = [cityDict objectForKey:@"id"];
        NSDictionary *coord = [cityDict objectForKey:@"coord"];
        aCity.lonName = [coord objectForKey:@"lon"];
        aCity.latName = [coord objectForKey:@"lat"];
        aCity.country = [cityDict objectForKey:@"country"];
        [parsedCities addObject:aCity];
    }
    self.parsedCities = parsedCities;

    // (1)
    for (City *theCity in parsedCities) {
        NSInteger sect = [theCollation sectionForObject:theCity collationStringSelector:@selector(name)];
        theCity.sectionNumber = sect;
    }
    // (2)
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    // (3)
    for (City *theCity in parsedCities) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:theCity.sectionNumber] addObject:theCity];
    }
    // (4)
    for (NSMutableArray *sectionArray in sectionArrays) {
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray
                                            collationStringSelector:@selector(name)];
       
        [self.cityArray addObject:sortedSection];
    }
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self.name beginswith[c] %@", searchText];
    self.searchResults = [self.dataProvider.cities filteredArrayUsingPredicate:resultPredicate];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    [self filterContentForSearchText:searchString];
    [self.tableView reloadData];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[self.cityArray objectAtIndex:section] count] > 0) {
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.searchResults && _searchController.isActive){
        return 1;
    } else {
    return [self.cityArray count];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.searchResults && _searchController.isActive) {
        return [self.searchResults count];
    }
    return [[self.cityArray objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier= @"CityCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if(self.searchResults && _searchController.isActive){
        NSDictionary *searchDict = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text =[searchDict objectForKey:@"name"];
    
    } else {
        City *cityObj = [[self.cityArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.textLabel.text = cityObj.name;
    } return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewC  = [storyboard instantiateViewControllerWithIdentifier:@"weather"];
    
    if(!self.searchResults){
        NSArray *sectionArray = [self.cityArray objectAtIndex:indexPath.section];
        City *city = [sectionArray objectAtIndex:indexPath.row];
        viewC.city = city;
        [self.navigationController pushViewController:viewC animated:YES];
    } else {
        City *aCity = [[City alloc] init];
        aCity.name = [[self.searchResults objectAtIndex:indexPath.row] objectForKey:@"name"];
        aCity.idName = [[self.searchResults objectAtIndex:indexPath.row] objectForKey:@"id"];
        NSDictionary *coord = [[self.searchResults objectAtIndex:indexPath.row] objectForKey:@"coord"];
        aCity.lonName = [coord objectForKey:@"lon"];
        aCity.latName = [coord objectForKey:@"lat"];
        aCity.country = [[self.searchResults objectAtIndex:indexPath.row] objectForKey:@"country"];
        viewC.city = aCity;
        [self.navigationController pushViewController:viewC animated:YES];
        }
}
@end

