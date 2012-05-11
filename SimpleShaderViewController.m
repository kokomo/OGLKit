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

@synthesize AProgram = _AProgram;
@synthesize camera = _camera;
@synthesize simpleProgram = _simpleProgram;
@synthesize ADSProgram = _ADSProgram;

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
        _ship.zPos = -10.0f;
        _ship.yPos = 5.0f;
        _ship.yRot = 180.0f;
        _ship.motionManager = _motionManager;
        
        _camera = [OGLCamera new];
        _camera.zPos = 0.0f;
        _camera.yPos = -10.0f;
        
        Box *box = [Box new];
        box.xScale = 10.0f;
        box.yScale = 10.0f;
        box.zPos = -40.0f;
        box.xRot = -90.0f;
        [_worldObjects addObject:box];
        
        Box *box2 = [Box new];
        box2.xScale = 10.0f;
        box2.yScale = 10.0f;
        box2.zPos = -20.0f;
        box2.xRot = -90.0f;
        [_worldObjects addObject:box2];
        
        Box *box3 = [Box new];
        box3.xScale = 10.0f;
        box3.yScale = 10.0f;
        box3.zPos = -60.0f;
        box3.xRot = -90.0f;
        [_worldObjects addObject:box3];
        
        Box *box4 = [Box new];
        box4.xScale = 10.0f;
        box4.yScale = 10.0f;
        box4.zPos = -80.0f;
        box4.xRot = -90.0f;
        [_worldObjects addObject:box4];
        
        Box *box5 = [Box new];
        box5.xScale = 10.0f;
        box5.yScale = 10.0f;
        box5.zPos = -100.0f;
        box5.xRot = -90.0f;
        [_worldObjects addObject:box5];
        
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(fireLazer) userInfo:nil repeats:YES];
        
    }
    
    return self;
    
}

- (void)fireLazer {
    
    Lazer *lazer = [Lazer new];
    [lazer setColorWithUIColor:[UIColor redColor]];
    lazer.xPos = _ship.xPos;
    lazer.yPos = 5.0f;
    lazer.zPos = _ship.zPos - 3.0f;
    [_bullets addObject:lazer];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [_motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:_coreMotionQueue withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        _ship.zRot = motion.attitude.roll * 60;
        
        float xRot = motion.attitude.pitch * (180 / M_PI);
        xRot -= 60.0f;
        xRot = xRot < -10.0f ? -10.0f : xRot;
        xRot = xRot > 50.0f ? 50.0f : xRot;
        _camera.xRot = xRot;
        
        _camera.yPos = -10 - xRot / 2.0f;
        _camera.zPos = 0.0f - xRot / 2.0f;
            
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
    
    [self.AProgram use];
    
    glUniformMatrix4fv([self.AProgram uniformIndex:@"Projection"], 1, GL_FALSE, projection.glMatrix);
    
    
    glViewport(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    CC3GLMatrix *modelViewMatrix = [CC3GLMatrix identity];
    
    [modelViewMatrix translateBy:CC3VectorMake(self.camera.xPos, self.camera.yPos, self.camera.zPos) rotateBy:CC3VectorMake(self.camera.xRot, self.camera.yRot, self.camera.zRot) scaleBy:CC3VectorMake(1.0f, 1.0f, 1.0f)];
    
    glUniform3f([self.AProgram uniformIndex:@"u_LightPos"], 0.0f, -1.0f, 0.0f);
    
    CC3GLMatrix *scratchMatrix = [CC3GLMatrix matrix];
    
    [scratchMatrix populateFrom:modelViewMatrix];
    
    for (OGLVBO *vbo in _worldObjects) {
        
        [scratchMatrix populateFrom:modelViewMatrix];
        
        [vbo update];
        [vbo drawWithModelViewMatrix:scratchMatrix program:self.AProgram];
        
    }
    
    [self.ADSProgram use];
    
    glUniformMatrix4fv([self.ADSProgram uniformIndex:@"Projection"], 1, GL_FALSE, projection.glMatrix);
    
    glUniform3f([self.ADSProgram uniformIndex:@"u_LightPos"], 0.0f, -1.0f, 0.0f);
    
    [scratchMatrix populateFrom:modelViewMatrix];
    
    [_ship updateWithTimeInterval:timeDelta];
    [_ship drawWithModelViewMatrix:scratchMatrix program:self.ADSProgram];
    
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
    
    self.AProgram = [[OGLProgram alloc] initWithVertexShader:@"AVertex" fragmentShader:@"AFragment"];    
    GLuint positionSlot = [self.AProgram attributeIndex:@"Position"];
    GLuint normalSlot = [self.AProgram attributeIndex:@"Normal"];
    GLuint textureCoordinateSlot = [self.AProgram attributeIndex:@"TexCoordIn"];
    [self.AProgram use];
    glEnableVertexAttribArray(positionSlot);
    glEnableVertexAttribArray(normalSlot);
    glEnableVertexAttribArray(textureCoordinateSlot);
    
    self.ADSProgram = [[OGLProgram alloc] initWithVertexShader:@"ADSVertex" fragmentShader:@"ADSFragment"];    
    positionSlot = [self.ADSProgram attributeIndex:@"Position"];
    normalSlot = [self.ADSProgram attributeIndex:@"Normal"];
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
    [Box loadTextures];
    
}



@end
