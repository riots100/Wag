//
//  ViewController.m
//  Wag
//
//  Created by Bruce Johnson on 11/20/17.
//  Copyright © 2017 Proviz. All rights reserved.
//

#import "WagTableViewController.h"
#import "StackExManager.h"
#import "WagTableViewCell.h"
#import "UIView+ActivityIndicator.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface WagTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (readwrite, strong) StackExManager *stackExManager;

@end

@implementation WagTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh
                                                                                target: self
                                                                                action: @selector(getEntries)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    self.stackExManager = [[StackExManager alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getEntries
{
    UIActivityIndicatorView *activityIndicator = [self.tableView addActivityIndicator];
    [activityIndicator startAnimating];
    
    [self.stackExManager fetchEnties: 45 completionHandler: ^(BOOL success, NSError *error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
        });
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{

                UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Error"
                                                                               message: error.localizedDescription
                                                                        preferredStyle: UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle: @"OK"
                                                                 style: UIAlertActionStyleDestructive
                                                               handler: nil];
                [alert addAction: action];
                
                [self presentViewController: alert animated: YES completion: nil];
            });
            
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.stackExManager.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    WagTableViewCell *cell = (WagTableViewCell *)[tableView dequeueReusableCellWithIdentifier: WagCellIdentifier forIndexPath: indexPath];
    
    NSDictionary *entryDict = self.stackExManager.entries[indexPath.row];
    [cell updateWithDictionary: entryDict];
    
    UIActivityIndicatorView *activityIndicator = [cell.avatarImageView addActivityIndicator];
    [activityIndicator startAnimating];

    [cell.avatarImageView sd_setImageWithURL: [entryDict avatarImageURL] completed: ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
        });

        
    }];
    
    return cell;
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
}
@end
