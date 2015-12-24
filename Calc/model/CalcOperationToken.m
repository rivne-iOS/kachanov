//
//  CalcOperationToken.m
//  ModelForCalc
//
//  Created by Admin on 22.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "CalcOperationToken.h"

@implementation CalcOperationToken


-(instancetype)initWithOperation:(NSString *)operation
{
    if(self = [super init])
    {
        if(  [operation containsString:@"-"] || [operation containsString:@"+"] )
        {
            _prioritetLevel = PLUSMINUS;
        }
        else if ([operation containsString:@"*"] || [operation containsString:@"/"])
        {
            _prioritetLevel = MULTDIV;
        }
        else
        {
            // exception!
        }
        _tokenType = ZNAKTYPE;
        _myData = [operation retain];
    }
    
    return self;
}

-(instancetype)init
{
    return [self initWithOperation:@"+"];
}

-(void)dealloc
{
    [_myData release];
    [super dealloc];
}

@end
