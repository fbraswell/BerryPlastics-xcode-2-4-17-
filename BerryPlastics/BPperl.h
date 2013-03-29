//
//  BPperl.h
//  BerryPlastics
//
//  Created by Frank Braswell on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPperl : NSObject
{
    IBOutlet NSString *myOutput;
    IBOutlet NSView *myView;
//    NSString *path;
    
}
@property (nonatomic, strong) IBOutlet NSString *myOutput;
@property (nonatomic, strong) NSString *convertTable;
@property (nonatomic, strong) NSString *parameterChart;
@property (nonatomic, strong) NSString *ratios;
@property (nonatomic, strong) NSString *path;

- (void) runPerl: (NSArray *)paramArray;

@end
