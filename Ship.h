//
//  Cube.h
//  OGLKit
//
//  Created by Andrew Carter on 4/18/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLVBO.h"

@class CMMotionManager;

@interface Ship : OGLVBO

@property (nonatomic, weak) CMMotionManager *motionManager;

@end
