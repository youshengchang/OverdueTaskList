//
//  ITIDetailTaskViewController.m
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "ITIDetailTaskViewController.h"

@interface ITIDetailTaskViewController ()

@end

@implementation ITIDetailTaskViewController

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
    NSLog(@"task: %@ %@ %@", self.task.title, self.task.description, self.task.date);
    
    [self updateView];
    
}

#pragma mark - helper methods

-(void)updateView
{
    self.taskTitleLabel.text = self.task.title;
    self.taskDescriptionLabel.text = self.task.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd h:mm a"];
    
    self.taskDateLabel.text = [formatter stringFromDate:self.task.date];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"toEditTaskViewControllerSegue"]){
        
        ITIEditTaskViewController *editVC = [segue destinationViewController];
       
        editVC.task = self.task;
        editVC.indexPath = self.indexpath;
        editVC.delegate = self;
    }
}


- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:sender];
}

#pragma mark implementing the ITIEditViewControllerDelegate
-(void)didEdit:(ITITaskObject *)task
{
    [self.delegate didEdit:task atIndex:self.indexpath];
    [self.navigationController popViewControllerAnimated:YES];
    self.task = task;
    [self updateView];
    
    
}
@end
