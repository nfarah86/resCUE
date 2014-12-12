//
//  NFHLogInViewController.m
//  Hackbright_Final_Project_iOS
//
//  Created by Nadine Hachouche on 11/24/14.
//  Copyright (c) 2014 nadine farah. All rights reserved.
//

#import "NFHLogInViewController.h"

@implementation NFHLogInViewController

- (IBAction)logIn:(id)sender {
    // to store credentials from the login screen:

    [[NSUserDefaults standardUserDefaults] setValue:@"nadine" forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults] setValue:@"nadine" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setValue:@"nadine@gmail.com" forKey:@"email"];

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}





@end
