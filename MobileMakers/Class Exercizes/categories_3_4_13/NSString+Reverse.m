//
//  NSString+Reverse.m
//  categories_3_4_13
//
//  Created by Ross Matsuda on 3/4/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "NSString+Reverse.h"

@implementation NSString (Reverse)

-(NSString*) reverse: (NSString*) stringToReverse
{                       //You can just call "self" instead of using stringToReverse to make this less code
    NSLog(@"This is a successful call of the reverse method");
    
        //make a mutable array
    NSMutableArray *textArray=[[NSMutableArray alloc] init];
        //'dis one holds your reversed string.
    NSString *reverseString=@"";

        //get all the characters from the string, put 'em in the temp array
        //Starting at index 0.
    for(int i=0 ; i<stringToReverse.length ; i++)
    {
        [textArray addObject:[NSString stringWithFormat:@"%c",[stringToReverse characterAtIndex:i]]];
    }
        
        //Reverse the objects' order. This permanently changes temp
    textArray = [NSMutableArray arrayWithArray:[[textArray reverseObjectEnumerator] allObjects]];
        //Toss all the letters back out now that the order is reversed.
    for(int i=0 ; i<textArray.count ; i++)
    {
        reverseString=[NSString stringWithFormat:@"%@%@", reverseString, [textArray objectAtIndex:i]];
    }

    return reverseString;
}

@end
