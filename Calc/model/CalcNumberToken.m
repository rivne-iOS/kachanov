//
//  CalcNumberToken.m
//  ModelForCalc
//
//  Created by Admin on 21.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "CalcNumberToken.h"


@implementation CalcNumberToken

-(instancetype)initWithNumber:(NSString*)number
{
    if(self=[super init])
    {
        _prioritetLevel = NUMBER;
        _tokenType = NUMBERTYPE;
        _myData = [number retain];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithNumber:@"0"];
}

-(void)dealloc
{
    [_myData release];
    [super dealloc];
}

@end
