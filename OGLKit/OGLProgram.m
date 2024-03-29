//
//  OGLProgram.m
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLProgram.h"

@implementation OGLProgram

- (id)initWithVertexShader:(NSString *)vertexShader fragmentShader:(NSString *)fragmentShader {
    
    self = [super init];
    
    if (self) {
                
        _verteixShader = [self compileShader:vertexShader withType:GL_VERTEX_SHADER];
        _fragmentShader = [self compileShader:fragmentShader withType:GL_FRAGMENT_SHADER];
        
        _program = glCreateProgram();
    
        glAttachShader(_program, _verteixShader);
        glAttachShader(_program, _fragmentShader);
        glLinkProgram(_program);
        
        GLint linkSuccess;
        glGetProgramiv(_program, GL_LINK_STATUS, &linkSuccess);
        if (linkSuccess == GL_FALSE) {
            GLchar messages[256];
            glGetProgramInfoLog(_program, sizeof(messages), 0, &messages[0]);
            NSString *messageString = [NSString stringWithUTF8String:messages];
            NSLog(@"%@", messageString);
            exit(1);
        }
        
    }
    
    return self;
    
}

- (void)use {
    
    glUseProgram(_program);
    
}


- (GLuint)attributeIndex:(NSString *)attributeName {
    
    return glGetAttribLocation(_program, [attributeName UTF8String]);
    
}

- (GLuint)uniformIndex:(NSString *)uniformName {
    
    return glGetUniformLocation(_program, [uniformName UTF8String]);

}

- (GLuint)compileShader:(NSString *)shaderName withType:(GLenum)shaderType {
    
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    NSError *error = nil;
    NSString *shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    assert(!error);
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    const char *shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandle);
    
    GLint compileSuccess;
    
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    
    if (compileSuccess == GL_FALSE) {
        
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
        
    }
    
    return shaderHandle;
    
}

@end
