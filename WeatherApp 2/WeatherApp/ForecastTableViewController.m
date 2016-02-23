//
//  ForecastTableViewController.m
//  WeatherApp
//
//  Created by projas on 2/14/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ForecastTableViewController.h"
#import "ForecastViewCell.h"
#import "ApiManager.h"
#import "WeatherManager.h"

@interface ForecastTableViewController ()

@property (nonatomic,strong) ApiManager *apiManager;
@property (nonatomic,strong) NSArray <Weather *> *listForecast;
@property (nonatomic,strong) WeatherManager *weatherManager;

@end

@implementation ForecastTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set back button arrow color
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.apiManager = [[ApiManager alloc] init];
    self.weatherManager = [[WeatherManager alloc] init];
    [self getForecast];
    
}

- (void) getForecast{
    [self.apiManager
     getDailyForecastWithCoordinates:self.coordinates
                          useCelcius:self.useCelcius
               withCompletionHandler:^(NSArray *listForecast) {
       
        self.listForecast = listForecast;
        [self.tableView reloadData];
       
    }onFailure:^(NSError *error){
       //[self showErrorMessage:error.description];
       NSLog(@"Error getting location: %@",error.description);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listForecast count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayCell" forIndexPath:indexPath];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    Weather *weather = self.listForecast[indexPath.row];
    NSString *dayName = [dateFormatter stringFromDate:weather.date];
    
    
    cell.dayLabel.text = (indexPath.row == 0) ? @"Today" : [NSString stringWithFormat:@"%@",dayName];
    cell.minTemperatureLabel.text = [NSString stringWithFormat:@"%@°",weather.minTemperature];
    cell.maxTemperatureLabel.text = [NSString stringWithFormat:@"%@°",weather.maxTemperature];

    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.902 green:0.969 blue:1 alpha:1]; /*#e6f7ff*/
    }else{
        cell.backgroundColor = [UIColor colorWithRed:0.6 green:0.867 blue:1 alpha:1]; /*#99ddff*/
    }
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //First this deselects the row after it was tapped. That makes it fade from the gray highlight color back to the regular white.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
