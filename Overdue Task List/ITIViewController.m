//
//  ITIViewController.m
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "ITIViewController.h"

@interface ITIViewController ()

@end

@implementation ITIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
}

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:sender];
}

#pragma mark Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"toAddTaskViewControllerSegue"]){
        NSLog(@"segue's identifier: %@", segue.identifier);
        ITIAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    
}

#pragma mark - ITIAddTaskViewControllerDelegate methods
-(void)didCancel
{
    NSLog(@"get Cancel Message");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)didAddTask:(ITITaskObject *)task
{
    NSLog(@"task's title %@ task's description: %@", task.title, task.description);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
