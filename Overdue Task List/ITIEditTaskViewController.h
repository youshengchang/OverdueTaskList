//
//  ITIEditTaskViewController.h
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITITaskObject.h"

@protocol ITIEditViewControllerDelegate <NSObject>
-(void)didEdit;

@end

@interface ITIEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic)id <ITIEditViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
@property (strong, nonatomic) ITITaskObject *task;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskTextView;
@property (strong, nonatomic) IBOutlet UISwitch *taskStatusWitch;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)taskStatusSwitchValueChanged:(UISwitch *)sender;

- (IBAction)didEndOnExit:(UITextField *)sender;
@end
