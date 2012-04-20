//
//  PhongShaderViewController.h
//  OGLKit
//
//  Created by Andrew Carter on 4/19/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLViewController.h"

@class OGLProgram;

@interface PhongShaderViewController : OGLViewController {
    
    NSMutableArray *_vbos;
    
}

@property (nonatomic, strong) OGLProgram *simpleProgram;

@end
