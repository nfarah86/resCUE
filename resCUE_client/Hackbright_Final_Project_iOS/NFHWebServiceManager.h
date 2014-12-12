//
//  NFHWebServiceManager.h
//  Hackbright_Final_Project_iOS
//
//  Created by Nadine Hachouche on 11/22/14.
//  Copyright (c) 2014 nadine farah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h> 

@interface NFHWebServiceManager : NSObject

+ (instancetype) sharedWebServiceManager;

- (void)sendUpdateRunRequestWithLocation:(CLLocation *)location;
-(void)sendEmergencyRequest;
-(void)startRunUpdateRequest;
-(void)endRunUpdateRequest;


@end

