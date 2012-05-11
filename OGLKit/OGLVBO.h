//
//  OGLVBO.h
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

@class CC3GLMatrix;
@class OGLProgram;


@interface OGLVBO : NSObject {
    
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    
}

@property (nonatomic, assign) GLfloat xPos;
@property (nonatomic, assign) GLfloat yPos;
@property (nonatomic, assign) GLfloat zPos;
@property (nonatomic, assign) GLfloat xRot;
@property (nonatomic, assign) GLfloat yRot;
@property (nonatomic, assign) GLfloat zRot;
@property (nonatomic, assign) GLfloat xScale;
@property (nonatomic, assign) GLfloat yScale;
@property (nonatomic, assign) GLfloat zScale;

@property (nonatomic, strong) NSMutableData *color;

// Buffer VBO data in this method
+ (void)bufferData;

+ (void)loadTextures;

// Draw VBO in model view matrix with the given program
- (void)drawWithModelViewMatrix:(CC3GLMatrix *)modelViewMatrix program:(OGLProgram *)program;

// Update position / etc
- (void)update;
- (void)updateWithTimeInterval:(CFTimeInterval)delta;

// Easy methods for setting a color array
- (void)setColorWithArray:(GLfloat *)array;
- (void)setColorWithUIColor:(UIColor *)color;

+ (void)addResourceID:(GLuint)resourceID forKey:(NSString *)key;
+ (GLuint)resourceIDForKey:(NSString *)key;

+ (void)addTexture:(GLuint)texture forKey:(NSString *)key;
+ (GLuint)textureForKey:(NSString *)key;

@end
