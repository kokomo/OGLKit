//
//  OGLCamera.h
//  OGLKit
//
//  Created by Andrew Carter on 4/20/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

@interface OGLCamera : NSObject

@property (nonatomic, assign) GLfloat xPos;
@property (nonatomic, assign) GLfloat yPos;
@property (nonatomic, assign) GLfloat zPos;
@property (nonatomic, assign) GLfloat xRot;
@property (nonatomic, assign) GLfloat yRot;
@property (nonatomic, assign) GLfloat zRot;

@end
