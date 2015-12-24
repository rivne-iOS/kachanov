//
//  CalcOperationToken.h
//  ModelForCalc
//
//  Created by Admin on 22.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalcToken.h"

@interface CalcOperationToken : CalcToken

-(instancetype)init;
-(instancetype)initWithOperation:(NSString*)operation;


@end
