//
//  CalcBracketsToken.h
//  ModelForCalc
//
//  Created by Admin on 22.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalcToken.h"

@interface CalcBracketsToken : CalcToken

@property(nonatomic, readonly, retain)CalcBracketsToken *parrentObject;
@property(nonatomic, readonly, retain)NSMutableArray *array; //inner brackets array
// -(instancetype)init; default

-(instancetype)init;
-(instancetype)initWithParrent:(CalcBracketsToken*)parrent;


@end
