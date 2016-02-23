//
//  ViewController.m
//  PrintJson
//
//  Created by projas on 2/2/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ViewController.h"
#import "ApiManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getJsonUsingNSURLSession{
    NSString  *weatherUrl = @"http://api.openweathermap.org/data/2.5/weather?q=London&appid=44db6a862fba0b067b1930da0d769e98";
    NSURL *url = [NSURL URLWithString:weatherUrl];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithURL:url
                   completionHandler:^(NSData *data,
                                       NSURLResponse * response,
                                       NSError *error){
                       NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                       NSLog(@"%@",stringData);
                       
                       NSError *jsonError;
                       NSDictionary *json = [NSJSONSerialization
                                             JSONObjectWithData:data
                                             options:NSJSONReadingAllowFragments
                                             error:&jsonError];
                       
                       
                       
                       if (!jsonError) {
                           NSLog(@"%@",json[@"main"][@"pressure"]);
                       }
                       
                       
                   }];
    
    
    [dataTask resume];
}

-(void) getJsonUsingAFNetworking{
}


- (IBAction)callEndpoint:(id)sender {
    ApiManager *manager = [[ApiManager alloc] init];
    
    [manager getWeatherWithCompletationHandler:^(Weather *weather) {
        NSLog(@"Weather %@",weather);
    } onFailure:^(NSError *error) {
        NSLog(@"Pedos en el ejido");
    }];
    
}

@end
