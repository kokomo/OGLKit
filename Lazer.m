//
//  Lazer.m
//  OGLKit
//
//  Created by Andrew Carter on 5/9/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "Lazer.h"

@implementation Lazer

@synthesize shouldDestroy = _shouldDestroy;

- (id)init {
    
    if (self = [super init]) {
    
        self.xScale = 0.1f;
        self.zScale = 1.0f;
        self.yScale = 0.1f;
        
    }
    
    return self;
    
}

- (void)updateWithTimeInterval:(CFTimeInterval)delta {
    
    self.zPos -= 40 * delta;
    
    if (self.zPos < -15) {
        
        self.shouldDestroy = YES;
        
    }
    
}

@end
