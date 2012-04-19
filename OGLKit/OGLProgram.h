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

@interface OGLProgram : NSObject {
    
    NSMutableArray *_attributes;
    NSMutableArray *_uniforms;
    GLuint _program;
    GLuint _verteixShader;
    GLuint _fragmentShader;
    
}

- (id)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader;
- (void)use;
- (void)addAttribute:(NSString *)attributeName;
- (GLuint)attributeIndex:(NSString *)attributeName;
- (GLuint)uniformIndex:(NSString *)uniformName;

@end
