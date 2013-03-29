//
//  BPAppDelegate.h
//  BerryPlastics
//
//  Created by Frank Braswell on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BPperl.h"
#import "IGConfigurableDropZone.h"
@interface BPAppDelegate : NSObject <NSApplicationDelegate>
{
//    IBOutlet NSTextView *textOutlet;
    IBOutlet NSView *myView;
      IBOutlet IGConfigurableDropZone *myDropZone;
    
}
@property (weak) IBOutlet NSTextField *myTextField;

@property (assign) IBOutlet NSWindow *window;
//@property (unsafe_unretained) IBOutlet NSTextView *textOutlet;
@property (unsafe_unretained) IBOutlet NSTextView *myTextView;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet NSView *myView;
@property (nonatomic, strong) BPperl *bpPerl;

@property (nonatomic, strong) NSString *convertTable;
@property (nonatomic, strong) NSString *parameterChart;
@property (nonatomic, strong) NSString *ratios;

// - (void)mouseDown:(NSEvent *)theEvent;
// - (BOOL)performDragOperation:(id <NSDraggingInfo>)sender;
- (IBAction)saveAction:(id)sender;

@end
