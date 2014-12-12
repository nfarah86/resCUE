//
//  GPS_LOCATION.h
//  Hackbright_Final_Project_iOS
//
//  Created by Nadine Hachouche on 11/13/14.
//  Copyright (c) 2014 nadine farah. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef void (^NFHLocationUpdateHandler)(CLLocation *);

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>


@interface NFHLocationManager: NSObject <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) CLLocation *lastLocation;
@property(nonatomic, assign) BOOL updating;
@property(nonatomic, copy) NFHLocationUpdateHandler updateHandler;

-(void)startStandardUpdates;
-(void)stopUpdates;
+ (instancetype)sharedLocationManager;



@end

