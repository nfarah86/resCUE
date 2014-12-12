//
//  BeanDetailViewController.m
//  BeanConnection


#import "BeanDetailViewController.h"
#import "AppDelegate.h"
#import "PTDBeanManager.h"
#import "NFHLocationManager.h"
#import "NFHWebServiceManager.h"

@interface BeanDetailViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BeanDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.beanDetailViewController = self;
    
    NSError *error = nil;
    [self.bean.beanManager connectToBean:self.bean error:&error];
    self.bean.delegate = self;
    
    NSLog(@"View did load with bean %@. Status = %d", self.bean, (int)self.bean.state);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
 
}

-(void)timerDidFire: (id)sender {
    NFHLocationManager *locationManager = [NFHLocationManager sharedLocationManager];
    
    if(locationManager.updating)
    {
    
        CLLocation *location = [locationManager lastLocation];
    
    
        [self updateInterfaceWithLocation:location];
        [[NFHWebServiceManager  sharedWebServiceManager]sendUpdateRunRequestWithLocation:location];
    
    }
}

-(void)bean:(PTDBean*)bean error:(NSError*)error
{
    NSLog(@"Bean encountered error: %@", error);
}

-(void)bean:(PTDBean*)bean serialDataReceived:(NSData*)data
{
    NSString *receivedMessage=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];

    NSLog (@"%@ this works", receivedMessage);
    
    NFHLocationManager *locationManager = [NFHLocationManager sharedLocationManager];
    NFHWebServiceManager *webServiceManager = [NFHWebServiceManager sharedWebServiceManager];
    
    
    if ([receivedMessage isEqualToString:@"L"])
    {
        [webServiceManager sendEmergencyRequest];
        
        
    }
    
    else if ([receivedMessage isEqualToString:@"S"])
    {
        if(locationManager.updating)
        {
            [locationManager stopUpdates];
            [webServiceManager endRunUpdateRequest];
        }
        else
        {
            
            [webServiceManager startRunUpdateRequest];
            [locationManager startStandardUpdates];
            locationManager.updateHandler = ^(CLLocation *location){
                [self updateInterfaceWithLocation:location];
                
            };
            
            
            
        }
        
        
    }
    else {
        self.latitude.text=@"An error occurred";
    }
}




- (void)updateInterfaceWithLocation:(CLLocation *)lastLocation {
    self.latitude.text = [NSString stringWithFormat:@"%f",lastLocation.coordinate.latitude];
    
    self.longitude.text = [NSString stringWithFormat:@"%f",lastLocation.coordinate.longitude];
}

- (IBAction)buttonPress:(id)sender {
    CLLocation *lastLocation = [NFHLocationManager sharedLocationManager].lastLocation;
    [[NFHWebServiceManager sharedWebServiceManager] sendUpdateRunRequestWithLocation:lastLocation];
    
    [self updateInterfaceWithLocation:lastLocation];
    
    
}




@end
