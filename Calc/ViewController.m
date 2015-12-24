//
//  ViewController.m
//  Calc
//
//  Created by Admin on 23.12.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "CalcNumberToken.h"
#import "CalcOperationToken.h"
#import "CalcBracketsToken.h"


typedef enum : NSUInteger {
    NOBRACKET,
    OPENBRACKET,
    CLOSEBRACKET,
} BracketType;

@interface ViewController ()

@property(nonatomic,retain)CalcBracketsToken* mainToken;
@property(nonatomic, retain)NSString* buf;
@property(nonatomic)TokenType tokentypeBuf;
// @property(nonatomic)BracketType bracketTypeBuf;
@property (retain, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic) BOOL err;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainToken = [[CalcBracketsToken alloc] initWithParrent:nil];
    _buf = [@"0" retain];
    _tokentypeBuf = NUMBERTYPE;
    _err = NO;
//     _bracketTypeBuf = NOBRACKET;
}

- (IBAction)clearButton {
    [self.mainToken.array removeAllObjects];
    self.textLabel.text = @"0";
    self.tokentypeBuf = NUMBERTYPE;
    self.buf = @"0";
    self.err = NO;
}

- (IBAction)numberButton:(UIButton *)sender {
    
    if(self.err) return;
    
    if (self.tokentypeBuf == NUMBERTYPE && [self.buf isEqualToString:@"0"] && ![sender.currentTitle isEqualToString:@"."])
    {
        self.buf = sender.currentTitle;
        self.textLabel.text = sender.currentTitle;
    }
    else if (self.tokentypeBuf == NUMBERTYPE && !([self.buf containsString:@"."] && [sender.currentTitle isEqualToString:@"."]))
    {
        self.buf = [self.buf stringByAppendingString:sender.currentTitle];
        self.textLabel.text = [self.textLabel.text stringByAppendingString:sender.currentTitle];
    }
    else if (self.tokentypeBuf == ZNAKTYPE && ![sender.currentTitle isEqualToString:@"."])
    {
        if(![self.buf isEqualToString:@"("] && ![self.buf isEqualToString:@")"])
        {
            CalcToken *tempOperationToken = [[CalcOperationToken alloc] initWithOperation:self.buf];
            [self.mainToken addToken:tempOperationToken];
            [tempOperationToken release];
        }
        self.tokentypeBuf = NUMBERTYPE;
        self.buf = sender.currentTitle;
        self.textLabel.text = [self.textLabel.text stringByAppendingString:sender.currentTitle];
    }
}

- (IBAction)operationButton:(UIButton *)sender {
    
    if(self.err) return;
    
    if(self.tokentypeBuf == NUMBERTYPE)
    {
        CalcToken *tempNumberToken = [[CalcNumberToken alloc] initWithNumber:self.buf];
        [self.mainToken addToken:tempNumberToken];
        [tempNumberToken release];
        
        self.tokentypeBuf = ZNAKTYPE;
        self.buf = sender.currentTitle;
        self.textLabel.text = [self.textLabel.text stringByAppendingString:sender.currentTitle];
    }
}

- (IBAction)resultButton {

    if(self.err) return;

    if(self.tokentypeBuf == NUMBERTYPE)
    {
        CalcToken *tempNumberToken = [[CalcNumberToken alloc] initWithNumber:self.buf];
        [self.mainToken addToken:tempNumberToken];
        [tempNumberToken release];
    }
    
    
    while(self.mainToken.parrentObject !=nil)
        self.mainToken = self.mainToken.parrentObject;
    
    self.buf = [self.mainToken myData];
    self.buf = [self.buf stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0."]];
    [self.mainToken.array removeAllObjects];
    self.tokentypeBuf = NUMBERTYPE;
    self.textLabel.text = self.buf;
    if([self.buf isEqualToString:@"error"])
        self.err = YES;
}

- (IBAction)openBracketButton {
    
    if(self.err) return;

    if(self.tokentypeBuf == ZNAKTYPE)
    {
        CalcOperationToken *tempOperationToken = [[CalcOperationToken alloc] initWithOperation:self.buf];
        [self.mainToken addToken:tempOperationToken];
        [tempOperationToken release];
        
        CalcBracketsToken *tempBracketsToken = [[CalcBracketsToken alloc] initWithParrent:self.mainToken];
        [self.mainToken addToken:tempBracketsToken];
        self.mainToken = tempBracketsToken;
        [tempBracketsToken release];
        
        self.buf = @"(";
        self.tokentypeBuf = ZNAKTYPE;
        self.textLabel.text = [self.textLabel.text stringByAppendingString:@"("];
    }
    else if([self.buf isEqualToString:@"0"])
    {
        CalcBracketsToken *tempBracketsToken = [[CalcBracketsToken alloc] initWithParrent:self.mainToken];
        [self.mainToken addToken:tempBracketsToken];
        self.mainToken = tempBracketsToken;
        [tempBracketsToken release];
        
        self.buf = @"(";
        self.tokentypeBuf = ZNAKTYPE;
        self.textLabel.text = @"(";
    }
}

- (IBAction)closeBracketButton {

    if(self.err) return;

    if (self.tokentypeBuf == NUMBERTYPE && ![self.buf isEqualToString:@"0"] && self.mainToken.parrentObject != nil)
    {
        CalcNumberToken *tempNumberToken = [[CalcNumberToken alloc] initWithNumber:self.buf];
        [self.mainToken addToken:tempNumberToken];
        [tempNumberToken release];

        self.mainToken = self.mainToken.parrentObject;
        self.buf = @")";
        self.textLabel.text = [self.textLabel.text stringByAppendingString:@")"];
        self.tokentypeBuf = ZNAKTYPE;

    }
}

- (IBAction)hiButton:(UIButton *)sender {
    self.err = YES;
    self.textLabel.text = @"Hi there! :)";
}


- (void)dealloc {
    [_textLabel release];
    [_mainToken release];
    [_buf release];
    [super dealloc];
}
@end
