//
//  Box.m
//  OGLKit
//
//  Created by Andrew Carter on 4/20/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "Box.h"

#import "CC3GLMatrix.h"
#import "OGLProgram.h"


#import "boxModel.h"

@implementation Box

+ (void)bufferData {
    
    GLfloat bvertices[] = {
        -1.00000000f, -1.00000000f, 1.00000000f,
        -1.00000000f, 1.00000000f, 1.00000000f,
        1.00000000f, 1.00000000f, 1.00000000f,
        1.00000000f, -1.00000000f, 1.00000000f,
        -1.00000000f, -1.00000000f, -1.00000000f,
        -1.00000000f, 1.00000000f, -1.00000000f,
        1.00000000f, 1.00000000f, -1.00000000f,
        1.00000000f, -1.00000000f, -1.00000000f,
    };
    GLfloat bnormals[] = {
        -0.57735027f, -0.57735027f, 0.57735027f,
        -0.40824829f, 0.81649658f, 0.40824829f,
        0.66666667f, 0.33333333f, 0.66666667f,
        0.57735027f, -0.57735027f, 0.57735027f,
        -0.40824829f, -0.40824829f, -0.81649658f,
        -0.81649658f, 0.40824829f, -0.40824829f,
        0.33333333f, 0.66666667f, -0.66666667f,
        0.66666667f, -0.66666667f, -0.33333333f,
    };
    GLuint bvertexIndicies[] = {
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
    
    GLuint cubeVertexBuffer = 0;
    glGenBuffers(1, &cubeVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, cubeVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(bvertices), bvertices, GL_STATIC_DRAW);
    [self addResourceID:cubeVertexBuffer forKey:@"BoxVertexData"];
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    GLuint cubeIndexBuffer = 0;
    glGenBuffers(1, &cubeIndexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, cubeIndexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(bvertexIndicies), bvertexIndicies, GL_STATIC_DRAW);
    [self addResourceID:cubeIndexBuffer forKey:@"BoxVertexIndexData"];
    [self addResourceID:sizeof(bvertexIndicies) / sizeof(bvertexIndicies[0]) forKey:@"BoxVertexCount"];
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    GLuint cubeNormalVertexBuffer = 0;
    glGenBuffers(1, &cubeNormalVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, cubeNormalVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(bnormals), bnormals, GL_STATIC_DRAW);
    [self addResourceID:cubeNormalVertexBuffer forKey:@"BoxNormalData"];
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
}


- (void)drawWithModelViewMatrix:(CC3GLMatrix *)modelViewMatrix program:(OGLProgram *)program {
    
    GLuint positionSlot = [program attributeIndex:@"Position"];
    GLuint normalSlot = [program attributeIndex:@"Normal"];
    GLuint cubeVertexIndexAttribute = [OGLVBO resourceIDForKey:@"BoxVertexIndexData"];
    GLuint cubeVertexDataAttribute = [OGLVBO resourceIDForKey:@"BoxVertexData"];
    GLuint cubeNormalDataAttribute = [OGLVBO resourceIDForKey:@"BoxNormalData"];
    GLuint modelViewAttribute = [program uniformIndex:@"Modelview"];
    GLuint sourceColorAttribute = [program uniformIndex:@"SourceColor"];
    GLuint cubeVertexCount =[OGLVBO resourceIDForKey:@"BoxVertexCount"];
    
    [modelViewMatrix translateBy:CC3VectorMake(self.xPos, self.yPos, self.zPos) rotateBy:CC3VectorMake(self.xRot, self.yRot, self.zRot) scaleBy:CC3VectorMake(self.xScale, self.yScale, self.zScale)];
    glUniformMatrix4fv(modelViewAttribute, 1, GL_FALSE, modelViewMatrix.glMatrix);
    glUniform4fv(sourceColorAttribute, 1, [self.color mutableBytes]);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, cubeVertexIndexAttribute);
    
    glBindBuffer(GL_ARRAY_BUFFER, cubeVertexDataAttribute);
    glVertexAttribPointer(positionSlot, 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, cubeNormalDataAttribute);
    glVertexAttribPointer(normalSlot, 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    glDrawElements(GL_TRIANGLES, cubeVertexCount, GL_UNSIGNED_INT, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
}


@end
