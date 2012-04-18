//
//  OGLView.m
//  OGLKit
//
//  Created by Andrew Carter on 4/17/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLView.h"

#import <QuartzCore/QuartzCore.h>

@implementation OGLView

@synthesize eaglLayer = _eaglLayer;
@synthesize context = _context;

- (CAEAGLLayer *)eaglLayer {
    
    return (CAEAGLLayer *)self.layer;
    
}

+ (Class)layerClass {
    
    return [CAEAGLLayer class];
    
}

@end
