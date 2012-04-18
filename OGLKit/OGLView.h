//
//  OGLView.h
//  OGLKit
//
//  Created by Andrew Carter on 4/17/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAEAGLLayer;

@interface OGLView : UIView

// This is really self.layer, which happens to be a CAEAGLLayer
@property (nonatomic, readonly) CAEAGLLayer *eaglLayer;

// If you set this yourself, you must use kEAGLRenderingAPIOpenGLES2
@property (nonatomic, strong) EAGLContext *context;

@end
