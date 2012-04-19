//
//  OGLProgram.h
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//
//
// Credit to Jeff LaMarche's GLProgram OpenGL shader wrapper class
// for inspiring this one.

#import <Foundation/Foundation.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

@interface OGLProgram : NSObject {
    
    NSMutableArray *_uniforms;
    GLuint _program;
    GLuint _verteixShader;
    GLuint _fragmentShader;
    
}

- (id)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader;
- (void)use;
- (GLuint)attributeIndex:(NSString *)attributeName;
- (GLuint)uniformIndex:(NSString *)uniformName;

@end
