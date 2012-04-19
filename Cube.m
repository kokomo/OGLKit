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
        1.00000000f, 3.00000000f, 0.0000000e+0f,
        0.92387953f, 3.00000000f, 0.38268343f,
        0.70710678f, 3.00000000f, 0.70710678f,
        0.38268343f, 3.00000000f, 0.92387953f,
        6.1232340e-17f, 3.00000000f, 1.00000000f,
        -0.38268343f, 3.00000000f, 0.92387953f,
        -0.70710678f, 3.00000000f, 0.70710678f,
        -0.92387953f, 3.00000000f, 0.38268343f,
        -1.00000000f, 3.00000000f, 1.2246468e-16f,
        -0.92387953f, 3.00000000f, -0.38268343f,
        -0.70710678f, 3.00000000f, -0.70710678f,
        -0.38268343f, 3.00000000f, -0.92387953f,
        -1.8369702e-16f, 3.00000000f, -1.00000000f,
        0.38268343f, 3.00000000f, -0.92387953f,
        0.70710678f, 3.00000000f, -0.70710678f,
        0.92387953f, 3.00000000f, -0.38268343f,
        1.00000000f, 1.00000000f, 0.0000000e+0f,
        0.92387953f, 1.00000000f, 0.38268343f,
        0.70710678f, 1.00000000f, 0.70710678f,
        0.38268343f, 1.00000000f, 0.92387953f,
        6.1232340e-17f, 1.00000000f, 1.00000000f,
        -0.38268343f, 1.00000000f, 0.92387953f,
        -0.70710678f, 1.00000000f, 0.70710678f,
        -0.92387953f, 1.00000000f, 0.38268343f,
        -1.00000000f, 1.00000000f, 1.2246468e-16f,
        -0.92387953f, 1.00000000f, -0.38268343f,
        -0.70710678f, 1.00000000f, -0.70710678f,
        -0.38268343f, 1.00000000f, -0.92387953f,
        -1.8369702e-16f, 1.00000000f, -1.00000000f,
        0.38268343f, 1.00000000f, -0.92387953f,
        0.70710678f, 1.00000000f, -0.70710678f,
        0.92387953f, 1.00000000f, -0.38268343f,
    };
    GLfloat normals[] = {
        -0.57735027f, -0.57735027f, 0.57735027f,
        -0.40824829f, 0.81649658f, 0.40824829f,
        0.66666667f, 0.33333333f, 0.66666667f,
        0.57735027f, -0.57735027f, 0.57735027f,
        -0.40824829f, -0.40824829f, -0.81649658f,
        -0.81649658f, 0.40824829f, -0.40824829f,
        0.33333333f, 0.66666667f, -0.66666667f,
        0.66666667f, -0.66666667f, -0.33333333f,
        0.89090915f, 0.45418155f, -1.2606070e-16f,
        0.74197792f, 0.56131259f, 0.36660189f,
        0.54520574f, 0.56131259f, 0.62263864f,
        0.26543094f, 0.56131259f, 0.78388430f,
        -5.4753327e-2f, 0.56131259f, 0.82579068f,
        -0.36660189f, 0.56131259f, 0.74197792f,
        -0.71248508f, 0.32115485f, 0.62387865f,
        -0.78388430f, 0.56131259f, 0.26543094f,
        -0.82579068f, 0.56131259f, -5.4753327e-2f,
        -0.74197792f, 0.56131259f, -0.36660189f,
        -0.54520574f, 0.56131259f, -0.62263864f,
        -0.26543094f, 0.56131259f, -0.78388430f,
        5.4753327e-2f, 0.56131259f, -0.82579068f,
        0.36660189f, 0.56131259f, -0.74197792f,
        0.71248508f, 0.32115485f, -0.62387865f,
        0.64691385f, 0.71393252f, -0.26796049f,
        0.70021451f, -0.71393252f, -9.9078040e-17f,
        0.78388430f, -0.56131259f, 0.26543094f,
        0.62263864f, -0.56131259f, 0.54520574f,
        0.36660189f, -0.56131259f, 0.74197792f,
        5.4753327e-2f, -0.56131259f, 0.82579068f,
        -0.26543094f, -0.56131259f, 0.78388430f,
        -0.62387865f, -0.32115485f, 0.71248508f,
        -0.74197792f, -0.56131259f, 0.36660189f,
        -0.82579068f, -0.56131259f, 5.4753327e-2f,
        -0.78388430f, -0.56131259f, -0.26543094f,
        -0.62263864f, -0.56131259f, -0.54520574f,
        -0.36660189f, -0.56131259f, -0.74197792f,
        -5.4753327e-2f, -0.56131259f, -0.82579068f,
        0.26543094f, -0.56131259f, -0.78388430f,
        0.62387865f, -0.32115485f, -0.71248508f,
        0.82309273f, -0.45418155f, -0.34093617f,
    };
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
        8, 20, 19, 
        8, 25, 24, 
        8, 39, 23, 
        9, 19, 18, 
        9, 25, 8, 
        9, 26, 25, 
        10, 18, 17, 
        10, 26, 9, 
        10, 27, 26, 
        11, 17, 16, 
        11, 27, 10, 
        11, 28, 27, 
        12, 16, 15, 
        12, 28, 11, 
        12, 29, 28, 
        13, 15, 14, 
        13, 29, 12, 
        13, 30, 29, 
        14, 30, 13, 
        14, 31, 30, 
        15, 31, 14, 
        15, 32, 31, 
        16, 32, 15, 
        16, 33, 32, 
        17, 33, 16, 
        17, 34, 33, 
        18, 34, 17, 
        18, 35, 34, 
        19, 35, 18, 
        19, 36, 35, 
        20, 36, 19, 
        20, 37, 36, 
        21, 23, 22, 
        21, 37, 20, 
        21, 38, 37, 
        22, 38, 21, 
        22, 39, 38, 
        23, 21, 20, 
        23, 39, 22, 
        24, 36, 37, 
        24, 39, 8, 
        25, 35, 36, 
        26, 34, 35, 
        27, 33, 34, 
        28, 32, 33, 
        29, 31, 32, 
        30, 31, 29, 
        38, 39, 37, 
    };
    GLubyte normalIndicies[] = {
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
        8, 20, 19, 
        8, 25, 24, 
        8, 39, 23, 
        9, 19, 18, 
        9, 25, 8, 
        9, 26, 25, 
        10, 18, 17, 
        10, 26, 9, 
        10, 27, 26, 
        11, 17, 16, 
        11, 27, 10, 
        11, 28, 27, 
        12, 16, 15, 
        12, 28, 11, 
        12, 29, 28, 
        13, 15, 14, 
        13, 29, 12, 
        13, 30, 29, 
        14, 30, 13, 
        14, 31, 30, 
        15, 31, 14, 
        15, 32, 31, 
        16, 32, 15, 
        16, 33, 32, 
        17, 33, 16, 
        17, 34, 33, 
        18, 34, 17, 
        18, 35, 34, 
        19, 35, 18, 
        19, 36, 35, 
        20, 36, 19, 
        20, 37, 36, 
        21, 23, 22, 
        21, 37, 20, 
        21, 38, 37, 
        22, 38, 21, 
        22, 39, 38, 
        23, 21, 20, 
        23, 39, 22, 
        24, 36, 37, 
        24, 39, 8, 
        25, 35, 36, 
        26, 34, 35, 
        27, 33, 34, 
        28, 32, 33, 
        29, 31, 32, 
        30, 31, 29, 
        38, 39, 37, 
    };


    GLuint cubeVertexBuffer;
    glGenBuffers(1, &cubeVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, cubeVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    [self addResourceID:cubeVertexBuffer forKey:@"CubeVertexData"];
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    GLuint cubeIndexBuffer;
    glGenBuffers(1, &cubeIndexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, cubeIndexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(vertexIndicies), vertexIndicies, GL_STATIC_DRAW);
    [self addResourceID:cubeIndexBuffer forKey:@"CubeVertexIndexData"];
    [self addResourceID:sizeof(vertexIndicies) / sizeof(vertexIndicies[0]) forKey:@"CubeVertexCount"];
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

    GLuint cubeNormalVertexBuffer;
    glGenBuffers(1, &cubeNormalVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, cubeNormalVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(normals), normals, GL_STATIC_DRAW);
    [self addResourceID:cubeNormalVertexBuffer forKey:@"CubeNormalData"];
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
}


- (void)drawWithModelViewMatrix:(CC3GLMatrix *)modelViewMatrix program:(OGLProgram *)program {
    
    [modelViewMatrix translateBy:CC3VectorMake(self.xPos, self.yPos, self.zPos) rotateBy:CC3VectorMake(self.xRot, self.yRot, self.zRot) scaleBy:CC3VectorMake(1.0f, 1.0f, 1.0f)];
    glUniformMatrix4fv([program uniformIndex:@"Modelview"], 1, GL_FALSE, modelViewMatrix.glMatrix);
    glUniform4fv([program uniformIndex:@"SourceColor"], 1, [self.color mutableBytes]);
        
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeVertexIndexData"]);
    
    glBindBuffer(GL_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeVertexData"]);
    glVertexAttribPointer([program attributeIndex:@"Position"], 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeNormalData"]);
    glVertexAttribPointer([program attributeIndex:@"Normal"], 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    
    glDrawElements(GL_TRIANGLES, [OGLVBO resourceIDForKey:@"CubeVertexCount"], GL_UNSIGNED_BYTE, 0);

    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
/*
    glEnableVertexAttribArray([program attributeIndex:@"Normal"]);

    glBindBuffer(GL_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeNormalData"]);
    
    glVertexAttribPointer([program attributeIndex:@"Normal"], 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeVertexData"]);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [OGLVBO resourceIDForKey:@"CubeVertexIndexData"]);
    

    

    glUniform4fv([program uniformIndex:@"SourceColor"], 1, [self.color mutableBytes]);
    
    
  */  

}

@end
