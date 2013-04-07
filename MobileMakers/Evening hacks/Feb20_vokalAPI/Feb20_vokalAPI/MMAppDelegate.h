//
//  MMAppDelegate.h
//  Feb20_vokalAPI
//
//  Created by Ross Matsuda on 2/20/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSManagedObjectModel * managedObjectModel;
    NSPersistentStoreCoordinator * persistentStoreCoordinator;
    NSManagedObjectContext * managedObjectContext;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;

-(NSArray *) allEntitiesNamed: (NSString*) entityName;

@end
