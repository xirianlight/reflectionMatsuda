//
//  Geek.h
//  Feb20_vokalAPI
//
//  Created by Ross Matsuda on 3/14/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Geek : NSManagedObject

@property (nonatomic, retain) NSSet *person;
@end

@interface Geek (CoreDataGeneratedAccessors)

- (void)addPersonObject:(Person *)value;
- (void)removePersonObject:(Person *)value;
- (void)addPerson:(NSSet *)values;
- (void)removePerson:(NSSet *)values;

@end
