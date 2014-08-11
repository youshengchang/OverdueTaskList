//
//  ITITaskObject.h
//  Overdue Task List
//
//  Created by yousheng chang on 8/10/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITITaskObject : NSObject
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *description;
@property (strong, nonatomic)NSDate *date;
@property (nonatomic)BOOL  completion;

-(id)initWithData:(NSDictionary *)data;

@end
