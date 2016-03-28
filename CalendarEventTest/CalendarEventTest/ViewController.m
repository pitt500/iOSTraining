//
//  ViewController.m
//  CalendarEventTest
//
//  Created by projas on 3/21/16.
//  Copyright © 2016 projas. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>

@interface ViewController ()

@property (nonatomic,strong) EKEventStore *store;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.store = [[EKEventStore alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)activeEventCalendar:(id)sender {
    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSLog(@"Go ahead fetching data from calendar");
            // Get the appropriate calendar
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            // Create the start date components
            NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
            oneDayAgoComponents.day = -1;
            NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                          toDate:[NSDate date]
                                                         options:0];
            
            // Create the end date components
            NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
            oneYearFromNowComponents.year = 1;
            NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                               toDate:[NSDate date]
                                                              options:0];
            
            // Create the predicate from the event store's instance method
            NSPredicate *predicate = [self.store predicateForEventsWithStartDate:oneDayAgo
                                                                    endDate:oneYearFromNow
                                                                  calendars:nil];
            
            // Fetch all events that match the predicate
            NSArray *events = [self.store eventsMatchingPredicate:predicate];
            
            for (EKEvent *event in events) {
                NSLog(@"%@",event);
            }
            
        }else{
            NSLog(@"You don't have access to the calendar");
        }
    }];
}


//- (void) sendNotificationToUser{
//
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    
//    // debe de activarse dentro de 5 segundos
//    notification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:1];
//    
//    // mensaje que saldrá en la alerta
//    notification.alertBody = @"Hola";
//    
//    // sonido por defecto
//    notification.soundName = UILocalNotificationDefaultSoundName;
//    
//    // título del botón
//    notification.alertAction = @"Ahora te lo cuento";
//    notification.hasAction = YES;
//    
//    // activa la notificación
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//}

- (void)setupLocalNotifications {
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // current time plus 10 secs
    NSDate *now = [NSDate date];
    NSDate *dateToFire = [now dateByAddingTimeInterval:1];
    
    NSLog(@"now time: %@", now);
    NSLog(@"fire time: %@", dateToFire);
    
    localNotification.fireDate = dateToFire;
    localNotification.alertBody = @"Time to get up!";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1; // increment
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Object 1", @"Key 1", @"Object 2", @"Key 2", nil];
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void) enableNotification{
    NSDate *alarmTime = [[NSDate date] dateByAddingTimeInterval:5.0];
    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *notifyAlarm = [[UILocalNotification alloc] init];

    notifyAlarm.fireDate = alarmTime;
    notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
    notifyAlarm.repeatInterval = 0;
    notifyAlarm.soundName = UILocalNotificationDefaultSoundName;
    notifyAlarm.alertBody = @"This is a push notification";
    
    
    UIUserNotificationType types = (UIUserNotificationType) (UIUserNotificationTypeBadge |
                                                             UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
    
    
    //UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];

    
    //[[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    
    
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = @"ACTION_ID"; // The id passed when the user selects the action
    action.title = NSLocalizedString(@"Title",nil); // The title displayed for the action
    action.activationMode = UIUserNotificationActivationModeBackground; // Choose whether the application is launched in foreground when the action is clicked
    action.destructive = NO; // If YES, then the action is red
    action.authenticationRequired = NO; // Whether the user must authenticate to execute the action
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"CATEGORY_ID"; // Identifier passed in the payload
    [category setActions:@[action] forContext:UIUserNotificationActionContextDefault]; // The context determines the number of actions presented (see documentation)

    NSSet *categories = [NSSet setWithObjects:category, nil];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [app registerUserNotificationSettings:settings];
    
//    NSDate *alarmTime = [[NSDate date] dateByAddingTimeInterval:5.0];
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    localNotification.fireDate = alarmTime;
//    localNotification.alertBody = [NSString stringWithFormat:@"Alert Fired at %@", alarmTime];
//    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    localNotification.applicationIconBadgeNumber = 1;
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    [app scheduleLocalNotification:notifyAlarm];
}




- (void)registerForNotification {
    
    
    
    UIMutableUserNotificationCategory *actionCategory;
    actionCategory = [[UIMutableUserNotificationCategory alloc] init];
    
    
    NSSet *categories = [NSSet setWithObject:actionCategory];
    UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                    UIUserNotificationTypeSound|
                                    UIUserNotificationTypeBadge);
    
    [categories setByAddingObject:@{@"aps" : @{
        @"alert"    : @"Pull down to interact.",
        @"category" : @"ACTIONABLE"
    }}];
    UIUserNotificationSettings *settings;
    settings = [UIUserNotificationSettings settingsForTypes:types
                                                 categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (IBAction)createEvent:(id)sender {
    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            EKEvent *newEvent = [EKEvent eventWithEventStore:self.store];
            newEvent.title = @"Prueba de evento";
            
            
            //NSString *dateString = @"2016-03-21T23:56:19.5288827Z";
            NSString *dateString = @"2016-04-05T23:56:19.5288827Z";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
            newEvent.startDate = [dateFormatter dateFromString:dateString];
            
            dateString = @"2016-04-05T23:56:19.5288827Z";
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
            newEvent.endDate = [dateFormatter dateFromString:dateString];
            
            //newEvent.startDate = [NSDate date];
            //newEvent.endDate = [newEvent.startDate dateByAddingTimeInterval:60*60];
            newEvent.allDay = YES;
            newEvent.calendar = [self.store defaultCalendarForNewEvents];
            
            //[newEvent addAlarm:[EKAlarm alarmWithRelativeOffset:3]];
            [newEvent addAlarm:[EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:1]]];
            
            
            [self.store saveEvent:newEvent span:EKSpanThisEvent commit:YES error:nil];
            
            //For saving
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:newEvent.eventIdentifier forKey:@"eventId"];
            [defaults synchronize];
            
            
            
            
            
            NSLog(@"The event was saved!");
            NSLog(@"Event id: %@",[defaults objectForKey:@"eventId"]);
            
        }else{
            NSLog(@"You don't have access to the calendar");
        }
    }];
    
}

- (IBAction) removeEvent:(id)sender{
    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSString *eventId = [defaults objectForKey:@"eventId"];
            
            NSLog(@"Event id: %@",eventId);
            EKEvent *eventDelete=[self.store eventWithIdentifier:eventId];
            [self.store removeEvent:eventDelete span:EKSpanThisEvent commit:YES error:nil];
            
            NSLog(@"The event was deleted!");
            
        }else{
            NSLog(@"You don't have access to the calendar");
        }
    }];
}

- (IBAction) sendPushNotification:(id)sender{
    [self enableNotification];
}


@end
