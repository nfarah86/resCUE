//
//
//  BeanDetailViewController.h

#import <UIKit/UIKit.h>
#import "PTDBean.h"

@interface BeanDetailViewController : UIViewController<PTDBeanDelegate>

@property (nonatomic, strong) PTDBean *bean;
@property (nonatomic, weak) IBOutlet UILabel *longitude;
@property (nonatomic, weak) IBOutlet UILabel *latitude;



- (IBAction)buttonPress:(id)sender;

@end
