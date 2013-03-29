//
//  MyScrollView.h
//  BerryPlastics
//
//  Created by Frank Braswell on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyScrollView : NSScrollView
{
    IBOutlet NSTextView *textOutlet;
}

@property (unsafe_unretained) IBOutlet NSTextView *textOutlet;
@end
