//
//  GameViewController.h
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLViewController.h"

@class OGLProgram;

@interface SimpleShaderViewController : OGLViewController {
    
    NSMutableArray *_vbos;
    
}

@property (nonatomic, strong) OGLProgram *simpleProgram;

@end
