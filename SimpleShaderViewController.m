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

#import "Ship.h"
#import "Box.h"

#import "Lazer.h"

#import <CoreMotion/CoreMotion.h>

@interface SimpleShaderViewController ()

- (void)fireLazer;

@end

@implementation SimpleShaderViewController

@synthesize ADSProgram = _ADSProgram;
@synthesize camera = _camera;
@synthesize simpleProgram = _simpleProgram;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        _worldObjects = [NSMutableArray new];
        _bullets = [NSMutableArray new];
        
        _motionManager = [CMMotionManager new];
        [_motionManager startGyroUpdates];
        [_motionManager startAccelerometerUpdates];
        
        _coreMotionQueue = [NSOperationQueue new];
        
        _ship = [Ship new];
        [_ship setColorWithUIColor:[UIColor blueColor]];
        _ship.zPos = 7.0f;
        _ship.yRot = 180.0f;
        _ship.motionManager = _motionManager;
        
        _camera = [OGLCamera new];
        _camera.zPos = -15.0f;
        _camera.yPos = 0.0f;
        _camera.xRot = 90.0f;
        
        Box *box = [Box new];
        box.yPos = -1.5f;
        box.xScale = 10.0f;
        box.zScale = 10.0f;
        [box setColorWithUIColor:[UIColor brownColor]];
        [_worldObjects addObject:box];
                
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(fireLazer) userInfo:nil repeats:YES];
        
    }
    
    return self;
    
}

- (void)fireLazer {
    
    Lazer *lazer = [Lazer new];
    [lazer setColorWithUIColor:[UIColor redColor]];
    lazer.xPos = _ship.xPos;
    lazer.zPos = _ship.zPos - 3.0f;
    [_bullets addObject:lazer];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [_motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:_coreMotionQueue withHandler:^(CMDeviceMotion *motion, NSError *error) {
       
        _ship.zRot = motion.attitude.roll * 60;
        
    }];

}

- (void)draw:(CADisplayLink *)displayLink {
    
    CFTimeInterval timeDelta = displayLink.duration;
    
    glClearColor(0.0f / 255.0f, 127.5f / 255.0f, 0.0f / 255.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    
    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    
    float h = 4.0f * self.view.frame.size.height / self.view.frame.size.width;
    
    [projection populateFromFrustumLeft:-2.0f andRight:2.0f andBottom:-h / 2.0f andTop:h / 2.0f andNear:4.0f andFar:100.0f];
    
    [self.ADSProgram use];
    
    glUniformMatrix4fv([self.ADSProgram uniformIndex:@"Projection"], 1, GL_FALSE, projection.glMatrix);
    

    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    CC3GLMatrix *modelViewMatrix = [CC3GLMatrix identity];
        
    [modelViewMatrix translateBy:CC3VectorMake(self.camera.xPos, self.camera.yPos, self.camera.zPos) rotateBy:CC3VectorMake(self.camera.xRot, self.camera.yRot, self.camera.zRot) scaleBy:CC3VectorMake(1.0f, 1.0f, 1.0f)];
    
    glUniform3f([self.ADSProgram uniformIndex:@"u_LightPos"], -0.3f, -1.0f, 0.0f);
    
    CC3GLMatrix *scratchMatrix = [CC3GLMatrix matrix];
                 
    [scratchMatrix populateFrom:modelViewMatrix];
        
    [_ship updateWithTimeInterval:timeDelta];
    [_ship drawWithModelViewMatrix:scratchMatrix program:self.ADSProgram];
    
    for (OGLVBO *vbo in _worldObjects) {
        
        [scratchMatrix populateFrom:modelViewMatrix];
        
        [vbo updateWithTimeInterval:timeDelta];
        [vbo drawWithModelViewMatrix:scratchMatrix program:self.ADSProgram];
        
    }
        
    GLenum x = glGetError();
    
    while (x != GL_NO_ERROR) {
        NSLog(@"%u", x);
        x = glGetError();
    }
    
    
    [self.simpleProgram use];
    
    glUniformMatrix4fv([self.simpleProgram uniformIndex:@"Projection"], 1, GL_FALSE, projection.glMatrix);
    
    NSMutableArray *objectsToDestroy = [NSMutableArray array];
        
    for (Lazer *lazer in _bullets) {
        
        [scratchMatrix populateFrom:modelViewMatrix];
        
        [lazer updateWithTimeInterval:timeDelta];
        [lazer drawWithModelViewMatrix:scratchMatrix program:self.simpleProgram];
        
        if (lazer.shouldDestroy) {
            [objectsToDestroy addObject:lazer];
        }
        
    }
    
    [_bullets removeObjectsInArray:objectsToDestroy];
    
    [self applyAppleMSAA];
    
    [_oglView.context presentRenderbuffer:GL_RENDERBUFFER];
    
}

- (void)compileShaders {
    
    self.ADSProgram = [[OGLProgram alloc] initWithVertexShader:@"ADSVertex" fragmentShader:@"ADSFragment"];    

    GLuint positionSlot = [self.ADSProgram attributeIndex:@"Position"];
    GLuint normalSlot = [self.ADSProgram attributeIndex:@"Normal"];
    [self.ADSProgram use];
    glEnableVertexAttribArray(positionSlot);
    glEnableVertexAttribArray(normalSlot);

    self.simpleProgram = [[OGLProgram alloc] initWithVertexShader:@"SimpleVertex" fragmentShader:@"SimpleFragment"];
    [self.simpleProgram use];
    positionSlot = [self.simpleProgram attributeIndex:@"Position"];
    glEnableVertexAttribArray(positionSlot);

}

- (void)bufferVertexBufferObjects {

    [Ship bufferData];
    [Box bufferData];
}



@end
