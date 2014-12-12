//
//  ViewController.m
//  Hackbright_Final_Project_iOS
//
//  Created by Nadine Hachouche on 11/11/14.
//  Copyright (c) 2014 nadine farah. All rights reserved.

// NEED TO ADD THE SDK LIGHTBLUE BEAN TO THIS PROJECT!!!!!!!!!!!!!!!!!

#import "NFHBeanListViewController.h"
#import "PTDBeanManager.h"
#import "BeanDetailViewController.h"

@interface NFHBeanListViewController () <PTDBeanManagerDelegate>  
@property (nonatomic, strong) PTDBeanManager *beanManager;
@property (nonatomic, strong) NSMutableDictionary *beansForIdentifiers;
@property (nonatomic, strong) NSArray *orderedBeans;
@end




@implementation NFHBeanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beansForIdentifiers = [NSMutableDictionary dictionary];
    self.beanManager = [[PTDBeanManager alloc] initWithDelegate:self];
    [self performSelector:@selector(scanForBeans) withObject:nil afterDelay:0.5];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showLoginView:)];
}

- (void)showLoginView:(id)sender
{
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}


- (void)scanForBeans
{
    NSError *error = nil;
    [self.beanManager startScanningForBeans_error:&error];
    if (error)
    {
        NSLog(@"Error occurred while scaning for beans: %@", error);
    }
}



- (void)beanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)bean error:(NSError*)error
{   
    self.beansForIdentifiers[bean.identifier] = bean;
    [self refreshBeanList];
}



- (void)refreshBeanList
{
    
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    self.orderedBeans = [[self.beansForIdentifiers allValues] sortedArrayUsingDescriptors:@[sortByName]];
    
    
    [self.tableView reloadData];
   }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [self.orderedBeans count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"BeanCell";
    
    PTDBean *beanForRow = [self.orderedBeans objectAtIndex:indexPath.row];

    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BeanCell"];

    }
    
    cell.textLabel.text = beanForRow.name;
    cell.detailTextLabel.text = [beanForRow.identifier UUIDString];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"])
    {
        NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
        PTDBean *beanForRow = [self.orderedBeans objectAtIndex:selectedPath.row];
        BeanDetailViewController *detailVC = segue.destinationViewController;
        detailVC.bean = beanForRow;
    }
    else if ([segue.identifier isEqualToString:@"showLogin"])
    {
        
    }
}

@end













