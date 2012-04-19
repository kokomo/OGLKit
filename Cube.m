//
//  Cube.m
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "Cube.h"

#import "CC3GLMatrix.h"
#import "OGLProgram.h"

@implementation Cube

+ (void)bufferData {
    
     GLfloat vertices[] = {
        -1.00000000f, -1.00000000f, 1.00000000f,
        -1.00000000f, 1.00000000f, 1.00000000f,
        1.00000000f, 1.00000000f, 1.00000000f,
        1.00000000f, -1.00000000f, 1.00000000f,
        -1.00000000f, -1.00000000f, -1.00000000f,
        -1.00000000f, 1.00000000f, -1.00000000f,
        1.00000000f, 1.00000000f, -1.00000000f,
        1.00000000f, -1.00000000f, -1.00000000f,
    };

    
    GLuint cubeVertexBuffer;
    glGenBuffers(1, &cubeVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, cubeVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    [self addResourceID:cubeVertexBuffer forKey:@"CubeVertexData"];
    
    GLubyte vertexIndicies[] = {
        0, 2, 1, 
        0, 5, 4, 
        0, 7, 3, 
        1, 5, 0, 
        1, 6, 5, 
        2, 6, 1, 
        2, 7, 6, 
        3, 2, 0, 
        3, 7, 2, 
        4, 6, 7, 
        4, 7, 0, 
        5, 6, 4, 
    };
    
    GLuint cubeIndexBuffer;
    glGenBuffers(1, &cubeIndexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, cubeIndexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(vertexIndicies), vertexIndicies, GL_STATIC_DRAW);
    [self addResourceID:cubeIndexBuffer forKey:@"CubeVertexIndexData"];
    [self addResourceID:sizeof(vertexIndicies) / sizeof(vertexIndicies[0]) forKey:@"CubeVertexCount"];

}


- (void)drawWithModelViewMatrix:(CC3GLMatrix *)modelViewMatrix program:(OGLProgram *)program {

    glEnableVertexAttribArray([program attributeIndex:@"Position"]);
    
    glBindBuffer(GL_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeVertexData"]);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeVertexIndexData"]);
    
    [modelViewMatrix translateBy:CC3VectorMake(self.xPos, self.yPos, self.zPos) rotateBy:CC3VectorMake(self.xRot, self.yRot, self.zRot) scaleBy:CC3VectorMake(1.0f, 1.0f, 1.0f)];
    
    glUniformMatrix4fv([program uniformIndex:@"Modelview"], 1, GL_FALSE, modelViewMatrix.glMatrix);

    glUniform4fv([program uniformIndex:@"SourceColor"], 1, [self.color mutableBytes]);
    
    glVertexAttribPointer([program attributeIndex:@"Position"], 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    glDrawElements(GL_TRIANGLES, [OGLVBO resourceIDForKey:@"CubeVertexCount"], GL_UNSIGNED_BYTE, 0);
    
}

@end
