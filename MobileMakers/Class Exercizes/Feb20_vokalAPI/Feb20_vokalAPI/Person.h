//
//  Person.h
//  Feb20_vokalAPI
//
//  Created by Ross Matsuda on 3/14/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSManagedObject *freak;
@property (nonatomic, retain) NSManagedObject *geek;

@end
