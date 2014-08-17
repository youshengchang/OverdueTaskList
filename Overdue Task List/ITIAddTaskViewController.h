//
//  ITIAddTaskViewController.h
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITITaskObject.h"

@protocol ITIAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(ITITaskObject *)task;


@end

@interface ITIAddTaskViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) id <ITIAddTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskTextView;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)editEndOnExit:(UITextField *)sender;

@end
