//
//  OGLViewController.h
//  OGLKit
//
//  Created by Andrew Carter on 4/17/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OGLView.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

@interface OGLViewController : UIViewController {
    
    // points to self.view, which happens to be an OGLView
    OGLView *_oglView;
    
    // color, depth, and framebuffers. These will be automatically setup
    GLuint _colorRenderBuffer;
    GLuint _depthRenderBuffer;
    GLuint _viewFrameBuffer;
    
    
    // Used for Apple Multi Sample Anti Aliasing
    GLint _backingWidth;
    GLint _backingHeight;
    GLuint _msaaFrameBuffer;
    GLuint _msaaRenderBuffer;
    GLuint _msaaDepthBuffer;
    
}

// Meant to be overridden in a subclass- draw here
- (void)draw:(CADisplayLink *)displayLink;

// Call this method before calling [_oglView.context presentRenderbuffer:GL_RENDERBUFFER];
// to take advantage of the anti aliasing provided by Apple.
- (void)applyAppleMSAA;

// Called inside viewDidLoad. Buffer your OGLVBO subclasses here by calling
// bufferDataWithProgram: on them.
- (void)bufferVertexBufferObjects;

// Called inside viewDidLoad:. Create your OGLProgram objects here
- (void)compileShaders;
    
@end
