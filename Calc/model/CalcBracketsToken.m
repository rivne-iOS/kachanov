//
//  CalcBracketsToken.m
//  ModelForCalc
//
//  Created by Admin on 22.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "CalcBracketsToken.h"
#import "CalcNumberToken.h" // result of operation

@implementation CalcBracketsToken

-(instancetype)initWithParrent:(CalcBracketsToken *)parrent
{
    if(self = [super init])
    {
        _array = [[NSMutableArray alloc] init];
        _myData = nil;
        _parrentObject = [parrent retain];
        _prioritetLevel = BRACKETS;
        _tokenType = BRACKETTYPE;
    }
    return self;
}

-(instancetype)init
{
    return [self initWithParrent:nil];
    
}

-(NSString*)myData
{
    NSLog(@"[self calcStr]...");
    [self calcStr];
    NSLog(@"return _myData...");
    return _myData;
}


-(void)calcStr
{
    while([self getMaxPrioritetLevel]>0)
    {
        NSUInteger maxIndex = [self getIndexMaxPrioritetLevel];
        NSLog(@"got max proritet level: %d", maxIndex);
        [self calcResultOfTokenAtIndex:maxIndex];
    }
    // якщо лнемає токена з прірітетом бильшім 0 - значіть має лішітісь тивлькі одін токен з чіслом
    _myData = [[[self.array objectAtIndex:0] myData] retain];
}

-(BOOL)addToken:(CalcToken*)newToken
{
    [self.array addObject:newToken];
    return YES;
}

-(void)calcResultOfTokenAtIndex:(NSUInteger)index
{
    if([[self.array objectAtIndex:index] tokenType] == ZNAKTYPE)
    {
        if (index==0 || index == [self.array count]-1)
            return;
        
        if([[self.array objectAtIndex:(index-1)] tokenType] != NUMBERTYPE
        || [[self.array objectAtIndex:(index+1)] tokenType] != NUMBERTYPE)
        {
            // exception!!!
            return;
        }
        
        CalcToken *first = [[self.array objectAtIndex:(index-1)] retain];
        CalcToken *second = [[self.array objectAtIndex:(index+1)] retain];
        CalcToken *operation = [[self.array objectAtIndex:index] retain];
        
        // як так немає адекватного метода для відилення диапазона!
        // [self.array removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:{index-1,3}];
        
        NSLog(@"array count: %lu", (unsigned long)[self.array count]);
        
        for(NSUInteger a=0; a<3;++a)
            [self.array removeObjectAtIndex:(index+1-a)];
        
        NSString *binaryRes = [[self binaryOperationResultWithFirstNum:first.myData
                                                            operation:operation.myData
                                                         andSecondNum:second.myData] retain];
        
        CalcNumberToken *newNumberToken = [[CalcNumberToken alloc] initWithNumber:binaryRes];
        
        [self.array insertObject:newNumberToken atIndex:index-1];
        
        [first release];
        [second release];
        [operation release];
        [binaryRes release];
        [newNumberToken release];
    } // if([self.array objectAtIndex:index] tokenType == ZNAKTYPE)
    else if([[self.array objectAtIndex:index] tokenType] == BRACKETTYPE)
    {
        NSString *numberFromBrackets = [[[self.array objectAtIndex:index] myData] retain];
        [self.array replaceObjectAtIndex:index withObject:[[CalcNumberToken alloc] initWithNumber:numberFromBrackets]];
        [numberFromBrackets release];
    }
}

-(PrioritetLevel)getMaxPrioritetLevel
{
    PrioritetLevel p=0;
    for (CalcToken *c in self.array)
    {
        if (c.prioritetLevel>p)
            p=c.prioritetLevel;
    }
    return p;
}

-(NSUInteger)getIndexMaxPrioritetLevel
{
    NSUInteger max = [self getMaxPrioritetLevel];
    for(NSUInteger a=0; a<[self.array count]; ++a)
    {
        if([[self.array objectAtIndex:a] prioritetLevel]==max)
            return a;
    }
    return 0;
}


-(NSString*)binaryOperationResultWithFirstNum:(NSString*)firstNum operation:(NSString*)operation andSecondNum:(NSString*)secondNum
{
    if ([firstNum isEqualToString:@"error"] || [secondNum isEqualToString:@"error"])
    {
        return @"error";
    }
    
    double first = [firstNum doubleValue];
    double second = [secondNum doubleValue];
    NSString *res=nil;
    
    if ([operation isEqualToString:@"+"])
    {
        res = [NSString stringWithFormat:@"%f", first+second];
    }
    else if ([operation isEqualToString:@"-"])
    {
        res = [NSString stringWithFormat:@"%f", first-second];
    }
    else if ([operation isEqualToString:@"*"])
    {
        res = [NSString stringWithFormat:@"%f", first*second];
    }
    else if ([operation isEqualToString:@"/"])
    {
        if(second == 0)
            res =  @"error";
        else
            res = [NSString stringWithFormat:@"%f", first/second];
    }
    
    return res;
}


-(void)dealloc
{
    [_parrentObject release];
    [_array release];
    [_myData release];
    [super dealloc];
}


@end
