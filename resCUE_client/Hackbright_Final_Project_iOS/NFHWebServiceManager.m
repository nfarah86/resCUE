//
//  NFHWebServiceManager.m
//  Hackbright_Final_Project_iOS
//
//  Created by Nadine Hachouche on 11/22/14.
//  Copyright (c) 2014 nadine farah. All rights reserved.
//

#import "NFHWebServiceManager.h"
#import "NFHLocationManager.h"
#import "BeanDetailViewController.h"

@implementation NFHWebServiceManager

+ (instancetype) sharedWebServiceManager
{
    static NFHWebServiceManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NFHWebServiceManager alloc] init];
    });
    return instance;
}


- (void)sendRequestToURL:(NSURL *)url requestBody:(NSMutableDictionary *)data
{
    // NSURL *url = [NSURL URLWithString:http://rescue-nfh.herokuapp.com/updaterun"]; //URL refer to hostName
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration]; //SESSION CONFIG
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config]; //make the session
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    data[@"user_name"] = @("a");
    data[@"password"] = @("a");
    data[@"email"] = @("a@gmail.com");

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    //          NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error)
            NSLog(@"Error occurred during HTTP request: %@", error);
        else
        {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Request completed successfully. Response:\n%@\nData:%@", response, dataString);
        }
    }];
    
    [uploadTask resume];
}



-(void)startRunUpdateRequest;
{
    
    NSMutableDictionary * dictOfCredentials = [[NSMutableDictionary alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://rescue-nfh.herokuapp.com/start_run"]; //URL refer to hostName
    [self sendRequestToURL:url requestBody:dictOfCredentials];
    
}



-(void)endRunUpdateRequest;

{
    NSMutableDictionary * dictOfCredentials = [[NSMutableDictionary alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://rescue-nfh.herokuapp.com/end_run"]; //URL refer to hostName
    [self sendRequestToURL:url requestBody:dictOfCredentials];
}




-(void)sendEmergencyRequest;
{
    NSMutableDictionary * dictOfCredentials = [[NSMutableDictionary alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://rescue-nfh.herokuapp.com/emergency_run"]; //URL refer to hostName
    [self sendRequestToURL:url requestBody:dictOfCredentials];
}

- (void)sendUpdateRunRequestWithLocation:(CLLocation *)location

{
    
    
    // be able to get lat and long
    CLLocationCoordinate2D coordinate = [location coordinate];
    //accuracy is important
    CLLocationAccuracy accuracy = location.horizontalAccuracy;
    //my database in server has a created (timestamp)
    // invert time b/c comes out to (-)
    
    //distinguish between bad and good cordinates by setting parameters
    if(location!=nil&&accuracy>0
       &&accuracy<2000
       &&(!(coordinate.latitude==0.0&&coordinate.longitude==0.0))){
        
        
        // to get credentials:
        
        //NSString *user_name = [[NSUserDefaults standardUserDefaults: stringForKey:@"user_name"]
//        NSString *password = [[NSUserDefaults standardUserDefaults stringForKey:@"password"];
//        NSString *email = [[NSUserDefaults standardUserDefaults stringForKey:@"email"];

        
        //store array of lat and array of long in 1 dictionary.. so server can unload these number easily by refer. keys?
                           
        NSMutableDictionary * dictOfCoordinates = [[NSMutableDictionary alloc]init];
        dictOfCoordinates[@"latitude"] = @[ @(coordinate.latitude) ];
        dictOfCoordinates[@"longitude"] = @[ @(coordinate.longitude) ];

        NSLog(@"%@", dictOfCoordinates);
        
        
        
        NSURL *url = [NSURL URLWithString:@"http://rescue-nfh.herokuapp.com/update_run"]; //URL refer to hostName
        [self sendRequestToURL:url requestBody:dictOfCoordinates];
        
    }
}

@end
