//
//  ViewController.m
//  WeatherApp
//
//  Created by projas on 2/9/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "WeatherViewController.h"
#import "ApiManager.h"
#import "WeatherManager.h"
#import "ForecastTableViewController.h"

@interface WeatherViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UISwitch *temperatureSwitch;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic,strong) ApiManager *apiManager;
@property (nonatomic,strong) WeatherManager *weatherManager;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.apiManager = [[ApiManager alloc] init];
    
    [self.locationManager startUpdatingLocation];
    self.geocoder = [[CLGeocoder alloc] init];
    self.weatherManager = [[WeatherManager alloc] init];
}


//Custom getter for locationManager
-(CLLocationManager *)locationManager{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    
    return _locationManager;
}



- (IBAction)refreshLocation:(id)sender {
     [self.locationManager startUpdatingLocation];
}

- (IBAction)convertTemperatureToAnotherDegree:(id)sender {
    //[self.locationManager startUpdatingLocation];
    self.temperatureLabel.text = [self changeTemperatureDegree];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showErrorMessage:(NSString *)errorMessage{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:errorMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [self getWeatherForLocation:nil];
    self.addressLabel.text = @"Hermosillo, Mexico";
    [self showErrorMessage:@"Failed to get your location"];
    NSLog(@"%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [self getReverseLocationFromLocation:newLocation];
    [self getWeatherForLocation:newLocation];

    // Stop Location Manager
    [self.locationManager stopUpdatingLocation];
}

-(void)getReverseLocationFromLocation:(CLLocation *)location {
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *city = placemark.locality;
            NSString *country = placemark.country;
            //Update UI
             self.addressLabel.text = [NSString stringWithFormat:@"%@, %@",city , country];
            
        }
        else{
            //[self showErrorMessage:error.description];
            NSLog(@"Error getting reverse location: %@",error.description);
        }
        
    } ];
}


- (NSString*) changeTemperatureDegree{
    NSNumber *actualTemperature = @([self.temperatureLabel.text integerValue]);
    NSNumber *convertedTemperature = ([self.temperatureSwitch isOn]) ? [self.weatherManager convertFromFarenheitToCelciusWithTemperature:actualTemperature] : [self.weatherManager convertFromCelciusToFahrenheitWithTemperature:actualTemperature];
    return [NSString stringWithFormat:@"%@°", [convertedTemperature stringValue]];
}

-(void)getWeatherForLocation:(CLLocation *)location {
    [self.apiManager getWeatherForLocation:location
                                useCelcius:[self.temperatureSwitch isOn]
                     withCompletionHandler:^(Weather *weather, Coordinates *coordinates) {
        
        self.temperatureLabel.text = (weather.temperature) ? [NSString stringWithFormat:@"%@°", weather.temperature] : @"--";
        self.latitudeLabel.text = coordinates.latitude;
        self.longitudeLabel.text = coordinates.longitude;
        
        
    }onFailure:^(NSError *error){
        //[self showErrorMessage:error.description];
        NSLog(@"Error getting location: %@",error.description);
    }];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"forecastSegue"]) {
        ForecastTableViewController *forecastViewController = segue.destinationViewController;
        forecastViewController.coordinates = self.apiManager.coordinates;
        forecastViewController.useCelcius = [self.temperatureSwitch isOn];
    }
}





@end
