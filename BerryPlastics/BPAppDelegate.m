//
//  BPAppDelegate.m
//  BerryPlastics
//
//  Created by Frank Braswell on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BPAppDelegate.h"


@implementation BPAppDelegate
@synthesize convertTable = _convertTable;
@synthesize parameterChart = _parameterChart;
@synthesize ratios = _ratios;
@synthesize myView = _myView;
@synthesize myTextField = _myTextField;
@synthesize window = _window;
// @synthesize textOutlet = _textOutlet;
@synthesize myTextView = _myTextView;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize bpPerl = _bpPerl;

- (void) theDropAction:(NSArray*)theFiles
{
//    NSLog(@"%@", theFiles);
    [myDropZone fadeOut];
    [_bpPerl runPerl: theFiles];
    if (_bpPerl.myOutput) {
        [self.myTextView setString:_bpPerl.myOutput];
    }
}

- (void) theDragEnteredAction
{
    [myDropZone fadeIn];
    [myDropZone setBackgroundImage:[NSImage imageNamed:@"IGDZBackground_Active.png"]];
}

- (void) theDragExitedAction
{
    [myDropZone setBackgroundImage:[NSImage imageNamed:@"IGDZBackground_Idle.png"]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    [myDropZone setDropAction:@selector(theDropAction:) target:self];
    [myDropZone setDragEnteredAction:@selector(theDragEnteredAction) target:self];
    [myDropZone setDragExitedAction:@selector(theDragExitedAction) target:self];
    
    [myDropZone setBackgroundImage:[NSImage imageNamed:@"IGDZBackground_Idle.png"]];
//    _myOutput = @"Hi there";
//    _textOutlet.textContainer.key = _myOutput;
//    [_textOutlet setString:_myOutput];
//          [self.myTextView setString:@"Perl Output Stream\n"];
//    BPperl *bpPerl = [[BPperl alloc] init];
    _bpPerl = [[BPperl alloc] init];
//    NSLog(@"BPperl output: %@", bpPerl);
//    [self.myTextField setStringValue:bpPerl.myOutput];
//    [self.myTextView setString:_bpPerl.myOutput];
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.systemsofmerritt.BerryPlastics" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"com.systemsofmerritt.BerryPlastics"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel) {
        return __managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BerryPlastics" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator) {
        return __persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![[properties objectForKey:NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"BerryPlastics.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    __persistentStoreCoordinator = coordinator;
    
    return __persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) 
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    __managedObjectContext = [[NSManagedObjectContext alloc] init];
    [__managedObjectContext setPersistentStoreCoordinator:coordinator];

    return __managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!__managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

//    - (void)mouseDown:(NSEvent *)theEvent
//    {
//        NSImage *dragImage;
//        NSPoint dragPosition;
//        
//        // Write data to the pasteboard
//        NSArray *fileList = [NSArray arrayWithObjects:_convertTable, _parameterChart, _ratios, nil];
//        NSPasteboard *pboard = [NSPasteboard pasteboardWithName:NSDragPboard];
//        [pboard declareTypes:[NSArray arrayWithObject:NSFilenamesPboardType]
//                       owner:nil];
//        [pboard setPropertyList:fileList forType:NSFilenamesPboardType];
//        
//        // Start the drag operation
//        dragImage = [[NSWorkspace sharedWorkspace] iconForFile:_convertTable];
//        dragPosition = [self.myView convertPoint:[theEvent locationInWindow]
//                                        fromView:nil];
//        dragPosition.x -= 16;
//        dragPosition.y -= 16;
//        [self.myView dragImage:dragImage
//                            at:dragPosition
//                        offset:NSZeroSize
//                         event:theEvent
//                    pasteboard:pboard
//                        source:self
//                     slideBack:YES];
//        NSLog(@"Drag Position: %@", dragPosition);
//    } // mouseDown
//
//    - (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
//    {
//        NSPasteboard *pboard = [sender draggingPasteboard];
//        
//        if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
//            NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
//            int numberOfFiles = [files count];
//            // Perform operation using the list of files
//            NSLog(@"%@ files dropped: %@", numberOfFiles, files);
//        }
//        return YES;
//    }
//

@end
