//
//  NoteCell.h
//  Week5-NoteTaker
//
//  Created by Patrick Moening on 8/12/17.
//  Copyright © 2017 Patrick Moening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *noteLbl;

@end
