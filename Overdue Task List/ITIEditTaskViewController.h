//
//  ITIEditTaskViewController.h
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITIEditTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end
