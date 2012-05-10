//
//  Cube.m
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "Ship.h"

#import "CC3GLMatrix.h"
#import "OGLProgram.h"

#import "shipModel.h"

#import <CoreMotion/CoreMotion.h>

@implementation Ship

@synthesize motionManager = _motionManager;

+ (void)bufferData {
    
    GLuint cubeVertexBuffer = 0;
    glGenBuffers(1, &cubeVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, cubeVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(shipVertices), shipVertices, GL_STATIC_DRAW);
    [self addResourceID:cubeVertexBuffer forKey:@"CubeVertexData"];
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    GLuint cubeIndexBuffer = 0;
    glGenBuffers(1, &cubeIndexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, cubeIndexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(shipVertexIndicies), shipVertexIndicies, GL_STATIC_DRAW);
    [self addResourceID:cubeIndexBuffer forKey:@"CubeVertexIndexData"];
    [self addResourceID:sizeof(shipVertexIndicies) / sizeof(shipVertexIndicies[0]) forKey:@"CubeVertexCount"];
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    GLuint cubeNormalVertexBuffer = 0;
    glGenBuffers(1, &cubeNormalVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, cubeNormalVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(shipNormals), shipNormals, GL_STATIC_DRAW);
    [self addResourceID:cubeNormalVertexBuffer forKey:@"CubeNormalData"];
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
}

- (void)updateWithTimeInterval:(CFTimeInterval)delta {
    
    CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;

    double roll = deviceMotion.attitude.roll;
    
    roll = roll < -1.0f ? -1.0f : roll;
    roll = roll > 1.0 ? 1.0f : roll;


    float newXPos = self.xPos + (20.0f * (fabs(roll) / 1.0f) * delta * (roll < 0.0f ? -1.0f : 1.0f));
    
    newXPos = newXPos > 6.5f ? 6.5f : newXPos;
    newXPos = newXPos < -6.5f ? -6.5f : newXPos;

    self.xPos = newXPos;
    
}

- (void)drawWithModelViewMatrix:(CC3GLMatrix *)modelViewMatrix program:(OGLProgram *)program {
    
    GLuint positionSlot = [program attributeIndex:@"Position"];
    GLuint normalSlot = [program attributeIndex:@"Normal"];
    GLuint cubeVertexIndexAttribute = [OGLVBO resourceIDForKey:@"CubeVertexIndexData"];
    GLuint cubeVertexDataAttribute = [OGLVBO resourceIDForKey:@"CubeVertexData"];
    GLuint cubeNormalDataAttribute = [OGLVBO resourceIDForKey:@"CubeNormalData"];
    GLuint modelViewAttribute = [program uniformIndex:@"Modelview"];
    GLuint sourceColorAttribute = [program uniformIndex:@"SourceColor"];
    GLuint cubeVertexCount =[OGLVBO resourceIDForKey:@"CubeVertexCount"];
    
    [modelViewMatrix translateBy:CC3VectorMake(self.xPos, self.yPos, self.zPos) rotateBy:CC3VectorMake(self.xRot, self.yRot, self.zRot) scaleBy:CC3VectorMake(1.0f, 1.0f, 1.0f)];
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