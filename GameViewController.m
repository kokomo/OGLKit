//
//  GameViewController.m
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "GameViewController.h"

#import "CC3GLMatrix.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)draw:(CADisplayLink *)displayLink {
    
    glClearColor(0.0f / 255.0f, 127.5f / 255.0f, 0.0f / 255.0f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    
    float h = 4.0f * self.view.frame.size.height / self.view.frame.size.width;
    
    [projection populateFromFrustumLeft:-2.0f andRight:2.0f andBottom:-h / 2.0f andTop:h / 2.0f andNear:4.0f andFar:100.0f];
        
    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    
    [self applyAppleMSAA];
    
    [_oglView.context presentRenderbuffer:GL_RENDERBUFFER];
    
}

@end
