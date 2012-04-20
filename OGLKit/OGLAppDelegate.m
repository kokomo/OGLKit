//
//  OGLAppDelegate.m
//  OGLKit
//
//  Created by Andrew Carter on 4/17/12.
//  Copyright (c) 2012 WillowTree Apps. All rights reserved.
//

#import "OGLAppDelegate.h"

#import "SimpleShaderViewController.h"
#import "PhongShaderViewController.h"
#import "GoraudShaderViewController.h"

@implementation OGLAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    SimpleShaderViewController *viewController = [[SimpleShaderViewController alloc] initWithNibName:nil bundle:nil];
//    PhongShaderViewController *viewController = [[PhongShaderViewController alloc] initWithNibName:nil bundle:nil];
//    GoraudShaderViewController *viewController = [[GoraudShaderViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
