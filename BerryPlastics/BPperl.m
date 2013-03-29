//
//  BPperl.m
//  BerryPlastics
//
//  Created by Frank Braswell on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// #import "BPAppDelegate.h"
#import "BPperl.h"

@implementation BPperl
@synthesize myOutput;
@synthesize convertTable = _convertTable;
@synthesize parameterChart = _parameterChart;
@synthesize ratios = _ratios;
@synthesize path = _path;
//@synthesize myView = _myView;
- (id)init
{
//    NSString *dataStr;
    self = [super init];
    if (self) 
    {
        // Initialization code here.
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentDir = [paths objectAtIndex:0];
//        NSString *path = [documentDir stringByAppendingPathComponent:
//        @"Xcode Projects/BerryPlastics/runprog.pl"];
        _path = [[NSString alloc] initWithFormat:@"%@",
                          @"/Users/frankbraswell/Business Folders/Berry Plastics/test/runprog.pl"];
//                          
        // Arguments
//        _convertTable = @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE convtbl.txt";
//        _parameterChart = @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE param chart.txt";
//        _ratios = @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE ratio.txt";
//        // Arguments array
//        NSMutableArray *someArray = [[NSMutableArray alloc] initWithObjects:_path,
//                                     _convertTable, _parameterChart, _ratios,
////            @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE convtbl.txt",
////            @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE parameter chart.txt",
////            @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE ratio.txt",
//                                     nil];
        
//        [[NSTask launchedTaskWithLaunchPath:[NSString stringWithFormat:@"/usr/bin/perl"] 
//                                  arguments:someArray] waitUntilExit];
//        NSPipe *fromPipe = [NSPipe pipe];
//        NSFileHandle *reading = [fromPipe fileHandleForReading];
//        NSTask *perlTask = [[NSTask alloc] init];
//        [perlTask setLaunchPath:[NSString stringWithFormat:@"/usr/bin/perl"]];
//        [perlTask setArguments:someArray];
//        [perlTask waitUntilExit];
//        [perlTask setStandardOutput:fromPipe];
//        [perlTask launch];
//        
//        NSData *dataOut = [reading readDataToEndOfFile];
////        NSLog(@"Data Output: %@", dataOut);
//        dataStr = [[NSString alloc] initWithData:dataOut encoding:NSUTF8StringEncoding];
//        NSLog(@"String Output: %@", dataStr);
    }
//    myOutput = @"output from BPperl";
//    myOutput = dataStr;
    return self;
} // init

- (void) runPerl: (NSArray *)paramArray
{
    NSString *dataStr;
    NSLog(@"runPerl files: %@", paramArray);
    
    // Arguments
//    _convertTable = @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE convtbl.txt";
//    _parameterChart = @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE param chart.txt";
//    _ratios = @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE ratio.txt";
    if ([paramArray count] != 3) 
    {
        NSLog(@"Must have three files: Convert Table, Parameter Chart, Ratio Tables");
        myOutput = @"Must have three files: Convert Table, Parameter Chart, Ratio Tables";
        return;
    }
    _convertTable = [paramArray objectAtIndex:0];
    _parameterChart = [paramArray objectAtIndex:1];
    _ratios = [paramArray objectAtIndex:2];
    // Arguments array
    NSMutableArray *someArray = [[NSMutableArray alloc] initWithObjects:_path,
                                 _convertTable, _parameterChart, _ratios,
                                 //            @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE convtbl.txt",
                                 //            @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE parameter chart.txt",
                                 //            @"/Users/frankbraswell/Business Folders/Berry Plastics/test/H153354/BERRY AND SUB BLUE ratio.txt",
                                 nil];
//    someArray = [[NSMutableArray alloc] initWithObjects:_path, paramArray, nil];
    
    //        [[NSTask launchedTaskWithLaunchPath:[NSString stringWithFormat:@"/usr/bin/perl"] 
    //                                  arguments:someArray] waitUntilExit];
    
    
    NSPipe *fromPipe = [NSPipe pipe];
    NSFileHandle *reading = [fromPipe fileHandleForReading];
    NSTask *perlTask = [[NSTask alloc] init];
    [perlTask setLaunchPath:[NSString stringWithFormat:@"/usr/bin/perl"]];
    [perlTask setArguments:someArray];
    [perlTask waitUntilExit];
    [perlTask setStandardOutput:fromPipe];
    [perlTask launch];
    
    NSData *dataOut = [reading readDataToEndOfFile];
    //        NSLog(@"Data Output: %@", dataOut);
    dataStr = [[NSString alloc] initWithData:dataOut encoding:NSUTF8StringEncoding];
    NSLog(@"String Output: %@", dataStr);
    myOutput = dataStr;
}

@end
