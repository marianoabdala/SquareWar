//
//  NSMutableArray-Shuffling.m
//  Jumbled Words
//
//  Created by Mariano Abdala on 8/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray-Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
	NSUInteger count = [self count];
	
	srand(time(NULL));
	
    for (NSUInteger i = 0; i < count; ++i)
	{
        int nElements = count - i;
        int n = (rand() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
