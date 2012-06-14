//
//  GuessMyNumberAppDelegate.h
//  GuessMyNumber
//
//  Created by Nicole LaBonte on 10/3/11.
//  Copyright 2011 Nicole LaBonte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuessMyNumberViewController;

@interface GuessMyNumberAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet GuessMyNumberViewController *viewController;

@end
