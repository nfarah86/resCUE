//
//  GPS_LOCATION.m
//  Hackbright_Final_Project_iOS
//
//  Created by Nadine Hachouche on 11/13/14.
//  Copyright (c) 2014 nadine farah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFHLocationManager.h"
#import "AppDelegate.h"


@implementation NFHLocationManager



+ (instancetype) sharedLocationManager
{
    static NFHLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NFHLocationManager alloc] init];
    });
    return instance;
}

- (instancetype)init

{
    self = [super init];   // inital. self; overrid. init.
    if (self)
    {
        _locationManager = [[CLLocationManager alloc]init];
        
    }
    
    return self;
}


- (void)startStandardUpdates{
    
    if (![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"Location services are not available (or are disabled for this app).");
    }
    else
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.distanceFilter = 0;
        
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            NSLog(@"Running on iOS 8 or newer. Will request constant tracking authorization.");
            [self.locationManager requestAlwaysAuthorization];
        }
        else
        {
            NSLog(@"Running on iOS 7 or older. Will attempt to start updating location immediately.");
            [self.locationManager startMonitoringSignificantLocationChanges];
            [self.locationManager startUpdatingLocation];
        }
    }
}


-(void)stopUpdates
{
    [self.locationManager stopUpdatingLocation];
    self.updating = NO;

}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    CLLocation *location = [locations lastObject];
    self.lastLocation = location;
    if(self.updateHandler)
    {
        self.updateHandler(self.lastLocation);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error occurred when attempting to get location: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"Location services authorization status not yet determined.");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Location services authorization was denied.");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Location services authorization is restricted.");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"Location services authorization granted. Requesting location updates...");
            [self.locationManager startUpdatingLocation];
            self.updating = YES;
            
            break;
        default:
            break;
            
    }
}

@end
