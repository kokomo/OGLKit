//
//  GameViewController.h
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLViewController.h"

@class OGLProgram;
@class OGLCamera;

@interface SimpleShaderViewController : OGLViewController {
    
    NSMutableArray *_vbos;
    OGLCamera *_camera;
    
}

@property (nonatomic, strong) OGLProgram *simpleProgram;
@property (nonatomic, strong) OGLCamera *camera;

@end
