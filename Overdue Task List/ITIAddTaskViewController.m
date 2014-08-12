//
//  ITIAddTaskViewController.m
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "ITIAddTaskViewController.h"

@interface ITIAddTaskViewController ()

@end

@implementation ITIAddTaskViewController

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
    self.taskTextView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    [self.delegate didAddTask:[self getTaskObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    NSLog(@"Cancel");
    [self.delegate didCancel];
    
}

- (IBAction)editEnded:(UITextField *)sender {
    [self resignFirstResponder];
}

- (IBAction)editEndOnExit:(UITextField *)sender {
    [self resignFirstResponder];
}
#pragma mark implementing the UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        [self.taskTextView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}


#pragma mark Helper methods
-(ITITaskObject *)getTaskObject
{
    ITITaskObject *newTask = [[ITITaskObject alloc]init];
    newTask.title = self.taskNameTextField.text;
    newTask.description = self.taskTextView.text;
    newTask.date = self.taskDatePicker.date;
    newTask.completion = NO;
    return newTask;
    
}
@end
