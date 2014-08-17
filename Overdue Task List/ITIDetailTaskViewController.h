//
//  ITIDetailTaskViewController.h
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITITaskObject.h"
#import "ITIEditTaskViewController.h"
@protocol ITIDetailViewControllerDelegate <NSObject>
-(void)didEdit;

@end
@interface ITIDetailTaskViewController : UIViewController <ITIEditViewControllerDelegate>
@property (weak, nonatomic) id <ITIDetailViewControllerDelegate> delegate;
@property (strong,nonatomic)    ITITaskObject *task;
@property (strong, nonatomic)   NSIndexPath *indexpath;
@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UISwitch *taskStatusSwitch;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)taskStatusSwitchValueChanged:(UISwitch *)sender;

@end
