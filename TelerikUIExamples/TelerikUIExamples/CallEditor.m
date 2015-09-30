//
//  CallEditor.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "CallEditor.h"

@implementation CallEditor

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _actionButton = [[UIButton alloc] init];
        [_actionButton setTitle:@"Call" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor colorWithRed:0.780 green:0.2 blue:0.223 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:_actionButton];
        [self.gridLayout addArrangedView:_actionButton];
        TKGridLayoutCellDefinition *btnDef = [self.gridLayout definitionForView:_actionButton];
        btnDef.row = @0;
        btnDef.column = @3;
        [self.gridLayout setWidth:[_actionButton sizeThatFits:CGSizeZero].width forColumn:3];
    }
    return self;
}
@end
