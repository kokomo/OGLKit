//
//  OGLVBO.m
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLVBO.h"

@interface OGLVBO ()

+ (NSMutableDictionary *)resourceIDs;

@end

@implementation OGLVBO

@synthesize xPos = _xPos;
@synthesize yPos = _yPos;
@synthesize zPos = _zPos;
@synthesize xRot = _xRot;
@synthesize yRot = _yRot;
@synthesize zRot = _zRot;
@synthesize color = _color;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.xPos = 0.0f;
        self.yPos = 0.0f;
        self.zPos = -7.0f;
        self.xRot = 0.0f;
        self.yRot = 0.0f;
        self.zRot = 0.0f;
        GLfloat color[] = {0.5f, 0.5f, 0.5f, 1.0f};
        self.color = [NSMutableData dataWithBytes:color length:sizeof(color)*sizeof(GLfloat)];
        
    }
    
    return self;
    
}

+ (void)bufferData {
    
    //meant to be used by subclass
    
}

- (void)drawWithModelViewMatrix:(CC3GLMatrix *)modelViewMatrix program:(OGLProgram *)program {
    
    //meant to be used by subclass
    
}

- (void)setColorWithArray:(GLfloat *)array {
    
    self.color = [NSMutableData dataWithBytes:array length:sizeof(array)*sizeof(GLfloat)];
    
}

- (void)setColorWithUIColor:(UIColor *)color {
    
    GLfloat red = 0.0f;
    GLfloat green = 0.0f;
    GLfloat blue = 0.0f;
    GLfloat alpha = 1.0f;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    GLfloat array[] = {red, green, blue, alpha};
    
    [self setColorWithArray:array];
    
}

+ (void)addResourceID:(GLuint)resourceID forKey:(NSString *)key {
    
    [[self resourceIDs] setObject:[NSNumber numberWithUnsignedInt:resourceID] forKey:key];
    
}

+ (GLuint)resourceIDForKey:(NSString *)key {
    
    NSNumber *resourceID = [[self resourceIDs] objectForKey:key];
    
    return [resourceID unsignedIntValue];
    
}

+ (NSMutableDictionary *)resourceIDs {
    
    static NSMutableDictionary *resourceIDs = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        resourceIDs = [NSMutableDictionary new];
    });
    
    return resourceIDs;
}

@end
