//
//  NFHLogInViewController.h
//  Hackbright_Final_Project_iOS
//
//  Created by Nadine Hachouche on 11/24/14.
//  Copyright (c) 2014 nadine farah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFHLogInViewController : UIViewController


@property (nonatomic) IBOutlet UITextField *user_name;
@property (nonatomic) IBOutlet UITextField *password;
@property (nonatomic) IBOutlet UITextField *email;

- (IBAction)logIn:(id)sender;


@end
