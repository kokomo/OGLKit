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

@property (nonatomic, readonly) CAEAGLLayer *eaglLayer;
@property (nonatomic, strong) EAGLContext *context;

@end
