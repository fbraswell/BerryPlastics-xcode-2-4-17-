//
//  BPperl.m
//  BerryPlastics
//
//  Created by Frank Braswell on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BPperl.h"

@implementation BPperl
@synthesize myOutput;
- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDir = [paths objectAtIndex:0];
        NSString *path = [documentDir stringByAppendingPathComponent:@"runprog.pl"];
        
        NSMutableArray *someArray = [[NSMutableArray alloc] initWithObjects:path, nil];
        
        [[NSTask launchedTaskWithLaunchPath:[NSString stringWithFormat:@"/usr/bin/perl"] 
                                  arguments:someArray] waitUntilExit];
    }
    
    return self;
}


@end
