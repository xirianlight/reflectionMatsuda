//
//  MMMagicDataManager.m
//  singleton_exercise
//
//  Created by Ross Matsuda on 3/6/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMMagicDataManager.h"


static MMMagicDataManager *sharedInstancePointer;
@implementation MMMagicDataManager

+(id) sharedInstance
{
    if (sharedInstancePointer == nil)
    {
        sharedInstancePointer = [[MMMagicDataManager alloc] init];
    }
    return sharedInstancePointer;
}



@end
