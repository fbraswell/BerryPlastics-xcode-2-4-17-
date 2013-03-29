//
//  MyScrollView.m
//  BerryPlastics
//
//  Created by Frank Braswell on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView
@synthesize textOutlet = _textOutlet;
- (id)init
{
    self = [super init];
    if (self) {
        _textOutlet.string = @"Hello Text";
    }
    return self;
}

@end
