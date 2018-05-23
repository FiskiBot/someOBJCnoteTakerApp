//
//  ViewController.m
//  Week5-NoteTaker
//
//  Created by Patrick Moening on 8/12/17.
//  Copyright © 2017 Patrick Moening. All rights reserved.
//

#import "ViewController.h"
#import "NoteCell.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
}




- (IBAction)saveNote:(id)sender {
    
    NSString *nothing = @"";
    if ([_noteEntry.text isEqual: nothing]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Text to save"
                                                        message:@"Enter some text to save"
                                                       delegate:self
                                              cancelButtonTitle:@"Whoopse"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *arrayOfDates = [userDefaults objectForKey:@"tableViewDates"];
        NSArray *arrayOfNotes = [userDefaults objectForKey:@"tableViewData"];
        NSMutableArray *mArrayOfDates = [[NSMutableArray alloc] init];
        NSMutableArray *mArrayOfNotes = [[NSMutableArray alloc] init];
        for (NSString *n in arrayOfNotes) {
            [mArrayOfNotes addObject:n];
            
        }
        for (NSString *n in arrayOfDates) {
            [mArrayOfDates addObject:n];
        }
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *currentDate = [NSDate date];
        _dateString = [dateFormatter stringFromDate:currentDate];
        
        [mArrayOfDates addObject:_dateString];
        [mArrayOfNotes addObject:_noteEntry.text];
        [userDefaults setObject:mArrayOfNotes forKey:@"tableViewData"];
        [userDefaults setObject:mArrayOfDates forKey:@"tableViewDates"];
        NSArray *testArray = [userDefaults objectForKey:@"tableViewData"];
        [userDefaults synchronize];
        NSLog(@"Things added to the array: %i", testArray.count);
        
        [self.tableView reloadData];
        self.noteEntry.text = @"";
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *numberOfNotes = [userDefaults objectForKey:@"tableViewData"];
    
    return numberOfNotes.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *noteArray = [userDefaults objectForKey:@"tableViewData"];
    NSArray *dateTimeArray = [userDefaults objectForKey:@"tableViewDates"];
    
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    cell.noteLbl.text = noteArray[noteArray.count - indexPath.row -1];
    cell.dateTimeLbl.text = dateTimeArray[dateTimeArray.count - indexPath.row -1];
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *arrayOfDates = [userDefaults objectForKey:@"tableViewDates"];
        NSArray *arrayOfNotes = [userDefaults objectForKey:@"tableViewData"];
        NSMutableArray *mArrayOfDates = [[NSMutableArray alloc] init];
        NSMutableArray *mArrayOfNotes = [[NSMutableArray alloc] init];
        for (NSString *n in arrayOfNotes) {
            [mArrayOfNotes addObject:n];
            
        }
        for (NSString *n in arrayOfDates) {
            [mArrayOfDates addObject:n];
        }
        [mArrayOfDates removeObjectAtIndex:mArrayOfDates.count - indexPath.row - 1];
        [mArrayOfNotes removeObjectAtIndex:mArrayOfNotes.count - indexPath.row -1];
        [userDefaults setObject:mArrayOfNotes forKey:@"tableViewData"];
        [userDefaults setObject:mArrayOfDates forKey:@"tableViewDates"];
        
        [userDefaults synchronize];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
