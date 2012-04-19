//
//  GameViewController.m
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "GameViewController.h"

#import "CC3GLMatrix.h"
#import "OGLProgram.h"

#import "Cube.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize simpleProgram = _simpleProgram;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        _vbos = [NSMutableArray new];
        
        Cube *cube = [Cube new];
        [cube setColorWithUIColor:[UIColor redColor]];
        [_vbos addObject:cube];
        
    }
    
    return self;
    
}

- (void)draw:(CADisplayLink *)displayLink {
    
    glClearColor(0.0f / 255.0f, 127.5f / 255.0f, 0.0f / 255.0f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    
    float h = 4.0f * self.view.frame.size.height / self.view.frame.size.width;
    
    [projection populateFromFrustumLeft:-2.0f andRight:2.0f andBottom:-h / 2.0f andTop:h / 2.0f andNear:4.0f andFar:100.0f];
    
    glUniformMatrix4fv([_simpleProgram uniformIndex:@"Projection"], 1, GL_FALSE, projection.glMatrix);

    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    CC3GLMatrix *modelViewMatrix = [CC3GLMatrix identity];
    
    [modelViewMatrix translateBy:CC3VectorMake(0.0f, 0.0f, -10.0f)];

    CC3GLMatrix *scratchMatrix = [CC3GLMatrix matrix];
    
    for (OGLVBO *vbo in _vbos) {
     
        [scratchMatrix populateFrom:modelViewMatrix];
        
        [vbo drawWithModelViewMatrix:scratchMatrix program:self.simpleProgram];
        
    }
    
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    
    [self applyAppleMSAA];
    
    [_oglView.context presentRenderbuffer:GL_RENDERBUFFER];
    
}

- (void)compileShaders {
    
    self.simpleProgram = [[OGLProgram alloc] initWithVertexShader:@"SimpleVertex" fragmentShader:@"SimpleFragment"];    
    [self.simpleProgram use];

}

- (void)bufferVertexBufferObjects {

    [Cube bufferData];
    
}

@end
