//
//  Lazer.m
//  OGLKit
//
//  Created by Andrew Carter on 5/9/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "Lazer.h"

#import "OGLProgram.h"
#import "CC3GLMatrix.h"

@implementation Lazer

@synthesize shouldDestroy = _shouldDestroy;

- (id)init {
    
    if (self = [super init]) {
    
        self.xScale = 0.1f;
        self.zScale = 1.0f;
        self.yScale = 0.1f;
        
    }
    
    return self;
    
}

- (void)updateWithTimeInterval:(CFTimeInterval)delta {
    
    self.zPos -= 40 * delta;
    
    if (self.zPos < -45) {
        
        self.shouldDestroy = YES;
        
    }
    
}

- (void)drawWithModelViewMatrix:(CC3GLMatrix *)modelViewMatrix program:(OGLProgram *)program {
 
    GLuint positionSlot = [program attributeIndex:@"Position"];
    GLuint cubeVertexIndexAttribute = [OGLVBO resourceIDForKey:@"BoxVertexIndexData"];
    GLuint cubeVertexDataAttribute = [OGLVBO resourceIDForKey:@"BoxVertexData"];
    GLuint modelViewAttribute = [program uniformIndex:@"Modelview"];
    GLuint sourceColorAttribute = [program uniformIndex:@"SourceColor"];
    GLuint cubeVertexCount =[OGLVBO resourceIDForKey:@"BoxVertexCount"];
    
    [modelViewMatrix translateBy:CC3VectorMake(self.xPos, self.yPos, self.zPos) rotateBy:CC3VectorMake(self.xRot, self.yRot, self.zRot) scaleBy:CC3VectorMake(self.xScale, self.yScale, self.zScale)];
    glUniformMatrix4fv(modelViewAttribute, 1, GL_FALSE, modelViewMatrix.glMatrix);
    glUniform4fv(sourceColorAttribute, 1, [self.color mutableBytes]);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, cubeVertexIndexAttribute);
    
    glBindBuffer(GL_ARRAY_BUFFER, cubeVertexDataAttribute);
    glVertexAttribPointer(positionSlot, 3, GL_FLOAT, GL_FALSE, 0, 0);
    
    glDrawElements(GL_TRIANGLES, cubeVertexCount, GL_UNSIGNED_INT, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
}

@end
