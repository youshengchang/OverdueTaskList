//
//  ITITaskObject.m
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "ITITaskObject.h"

@implementation ITITaskObject

-(id)init
{
    self = [self initWithData:nil];
    return self;
}

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    self.title = data[TASK_TITLE];
    self.description = data[TASK_DESCRIPTION];
    self.date = data[TASK_DATE];
    self.completion = [data[TASK_COMPLETION] boolValue];
    return self;
    
}
@end
