//
//  OGLViewController.m
//  OGLKit
//
//  Created by Andrew Carter on 4/17/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLViewController.h"

#import "OGLView.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

@interface OGLViewController ()

- (void)setupLayer;
- (void)setupContext;
- (void)setupAppleMSAABuffers;
- (void)setupDisplayLink;
- (void)setupDepthBuffer;
- (void)setupRenderBuffer;
- (void)setupFrameBuffer;
- (void)setupContext;
- (void)bufferVertexBufferObjects;

@end

@implementation OGLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.wantsFullScreenLayout = YES;
        
    }
    
    return self;
    
}

#pragma mark View Lifecycle

- (void)loadView {
    
    _oglView = [[OGLView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
    
    self.view = _oglView;
    
}

- (void)viewDidLoad {
    
    [self setupLayer];
    [self setupContext];
    [self setupDepthBuffer];
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    [self setupAppleMSAABuffers];
    [self setupDisplayLink];
    [self compileShaders];
    [self bufferVertexBufferObjects];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    UIStatusBarAnimation statusBarAnimation = animated ? UIStatusBarAnimationSlide : UIStatusBarAnimationNone;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:statusBarAnimation];
    
}

#pragma mark OpenGL Setup

- (void)bufferVertexBufferObjects {
    
    NSLog(@"Subclasses of OGLViewController should implement - (void)bufferVertexBufferObjects");
    
}

- (void)compileShaders {

    NSLog(@"Subclasses of OGLViewController should implement - (void)compileShaders");
    
}

- (void)setupLayer {
    
    _oglView.eaglLayer.opaque = YES;
    
}

- (void)setupContext {
    
    _oglView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:_oglView.context];
    
}

- (void)setupDisplayLink {
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(draw:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}

- (void)setupAppleMSAABuffers {
    
    glGenFramebuffers(1, &_msaaFrameBuffer);
    glGenFramebuffers(1, &_msaaRenderBuffer);
    
    glBindFramebuffer(GL_FRAMEBUFFER, _msaaFrameBuffer);
    glBindFramebuffer(GL_RENDERBUFFER, _msaaRenderBuffer);
    
    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_RGB5_A1, _backingWidth, _backingHeight);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _msaaRenderBuffer);
    glGenRenderbuffers(1, &_msaaDepthBuffer);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _msaaDepthBuffer);
    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_DEPTH_COMPONENT16, _backingWidth, _backingHeight);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _msaaDepthBuffer);
    
}

- (void)setupDepthBuffer {
    
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.view.frame.size.width, self.view.frame.size.height);   
    
}

- (void)setupRenderBuffer {
    
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_oglView.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_oglView.eaglLayer];
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_backingHeight);
    
}

- (void)setupFrameBuffer {
    
    glGenFramebuffers(1, &_viewFrameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _viewFrameBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}

#pragma mark Instance Methods

- (void)draw:(CADisplayLink *)displayLink {

    NSLog(@"Subclasses of OGLViewController must implement - (void)draw:(CADisplayLink *)displayLink.");
    
}

- (void)applyAppleMSAA {

    GLenum attachments[] = {GL_DEPTH_ATTACHMENT};
    glDiscardFramebufferEXT(GL_READ_FRAMEBUFFER_APPLE, 1, attachments);
    glBindFramebuffer(GL_READ_FRAMEBUFFER_APPLE, _msaaFrameBuffer);   
    glBindFramebuffer(GL_DRAW_FRAMEBUFFER_APPLE, _viewFrameBuffer);

    glResolveMultisampleFramebufferAPPLE();

}

@end
