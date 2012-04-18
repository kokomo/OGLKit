//
//  OGLViewController.h
//  OGLKit
//
//  Created by Andrew Carter on 4/17/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OGLView;

@interface OGLViewController : UIViewController {
    
    OGLView *_oglView;
    
    GLuint _colorRenderBuffer;
    GLuint _depthRenderBuffer;
    GLuint _viewFrameBuffer;
    
    
    //Used for Apple Multi Sample Anti Aliasing
    GLint _backingWidth;
    GLint _backingHeight;
    GLuint _msaaFrameBuffer;
    GLuint _msaaRenderBuffer;
    GLuint _msaaDepthBuffer;
    
}

- (void)draw:(CADisplayLink *)displayLink;
- (void)applyAppleMSAA;

@end
