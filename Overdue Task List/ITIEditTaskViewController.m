//
//  ITIEditTaskViewController.m
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "ITIEditTaskViewController.h"

@interface ITIEditTaskViewController ()

@end

@implementation ITIEditTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.taskNameTextField.text = self.task.title;
    self.taskTextView.text = self.task.description;
    self.taskDatePicker.date = self.task.date;
    /*
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, 0, 320, 80);
    datePicker.transform = CGAffineTransformMakeScale(.5, 0.5);
    [self.datePickerView addSubview:datePicker];
     */
    self.taskTextView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark implementing the UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"enter textView in EditTask");
    if([text isEqualToString:@"\n"]){
        [self.taskTextView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    
    self.task.title = self.taskNameTextField.text;
    self.task.description = self.taskTextView.text;
    self.task.date = self.taskDatePicker.date;
    [self.delegate didEdit:self.task];
}



- (IBAction)didEndOnExit:(UITextField *)sender {
    [self resignFirstResponder];
}

@end
