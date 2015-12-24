//
//  CalcToken.h
//  ModelForCalc
//
//  Created by Admin on 22.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

//levels
typedef enum : NSUInteger {
    NUMBER=0,     // 0
    PLUSMINUS=1,  // 1
    MULTDIV=2,    // 2
    BRACKETS=3    // 3
} PrioritetLevel;

//types
typedef enum : NSUInteger {
    NUMBERTYPE,
    ZNAKTYPE,
    BRACKETTYPE,
} TokenType;

@interface CalcToken : NSObject
{
@protected
    PrioritetLevel _prioritetLevel; // шоу интуїцiя! :)
    TokenType _tokenType;
    NSString *_myData;
}


@property(nonatomic, readonly, retain)NSString *myData;  // number or symbol
@property(nonatomic, readonly)PrioritetLevel prioritetLevel; //iniT!!!!!
@property(nonatomic, readonly)TokenType tokenType; //init!!!!!

-(BOOL)addToken:(CalcToken*)newToken;
-(void)getResultOfTokenAtIndex:(NSUInteger)index;
-(PrioritetLevel)getMaxPrioritetLevel;
-(NSUInteger)getIndexMaxPrioritetLevel;
@end
