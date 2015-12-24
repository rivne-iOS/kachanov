//
//  CalcNumberToken.h
//  ModelForCalc
//
//  Created by Admin on 21.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalcToken.h"

@interface CalcNumberToken : CalcToken

-(instancetype)init;
-(instancetype)initWithNumber:(NSString*)number;

@end
