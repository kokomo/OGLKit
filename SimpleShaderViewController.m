//
//  GameViewController.m
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "SimpleShaderViewController.h"

#import "CC3GLMatrix.h"
#import "OGLProgram.h"

#import "OGLCamera.h"

#import "Car.h"
#import "Box.h"

@interface SimpleShaderViewController ()

@end

@implementation SimpleShaderViewController

@synthesize simpleProgram = _simpleProgram;
@synthesize camera = _camera;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        _vbos = [NSMutableArray new];

        Car *car = [Car new];
        [car setColorWithUIColor:[UIColor redColor]];
        car.yRot = 50.0f;
        [_vbos addObject:car];
        
        Box *box = [Box new];
        box.yPos = -1.5f;
        box.xScale = 10.0f;
        box.zScale = 10.0f;
        [box setColorWithUIColor:[UIColor brownColor]];
        [_vbos addObject:box];
        
        _camera = [OGLCamera new];
        _camera.zPos = -10.0f;
        _camera.yPos = -4.0f;
        _camera.yRot = 40.0f;

        
    }
    
    return self;
    
}

- (void)draw:(CADisplayLink *)displayLink {
    
    glClearColor(0.0f / 255.0f, 127.5f / 255.0f, 0.0f / 255.0f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    glEnable(GL_CULL_FACE);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    
    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    
    float h = 4.0f * self.view.frame.size.height / self.view.frame.size.width;
    
    [projection populateFromFrustumLeft:-2.0f andRight:2.0f andBottom:-h / 2.0f andTop:h / 2.0f andNear:4.0f andFar:100.0f];
    
    glUniformMatrix4fv([_simpleProgram uniformIndex:@"Projection"], 1, GL_FALSE, projection.glMatrix);

    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    CC3GLMatrix *modelViewMatrix = [CC3GLMatrix identity];
        
    [modelViewMatrix translateBy:CC3VectorMake(self.camera.xPos, self.camera.yPos, self.camera.zPos) rotateBy:CC3VectorMake(self.camera.xRot, self.camera.yRot, self.camera.zRot) scaleBy:CC3VectorMake(1.0f, 1.0f, 1.0f)];
    
    glUniform3f([_simpleProgram uniformIndex:@"u_LightPos"], 0.0f, -1.0f, 0.0f);
    
    CC3GLMatrix *scratchMatrix = [CC3GLMatrix matrix];
    
    self.camera.zPos = (sin(CACurrentMediaTime()) * 5.0f) - 7.0f;
    
    for (OGLVBO *vbo in _vbos) {
             
        [scratchMatrix populateFrom:modelViewMatrix];

        [vbo drawWithModelViewMatrix:scratchMatrix program:self.simpleProgram];
        
    }

    [self applyAppleMSAA];
    
    [_oglView.context presentRenderbuffer:GL_RENDERBUFFER];
    
}

- (void)compileShaders {
    
    self.simpleProgram = [[OGLProgram alloc] initWithVertexShader:@"SimpleVertex" fragmentShader:@"SimpleFragment"];    

    GLuint positionSlot = [self.simpleProgram attributeIndex:@"Position"];
    GLuint normalSlot = [self.simpleProgram attributeIndex:@"Normal"];
    glEnableVertexAttribArray(positionSlot);
    glEnableVertexAttribArray(normalSlot);
    [self.simpleProgram use];

}

- (void)bufferVertexBufferObjects {

    [Car bufferData];
    [Box bufferData];
}

@end
