//
//  ViewController.h
//  Week5-NoteTaker
//
//  Created by Patrick Moening on 8/12/17.
//  Copyright © 2017 Patrick Moening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (void)registerDefaults;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextView *noteEntry;
@property (weak, nonatomic) NSString *dateString;
@end

