//
//  ZeroTabBarController.h
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZeroTabBar;
@class ZeroTabBarController;
@class ZeroViewController;

@protocol ZeroTabBarDelegate
-(void)tabBarDidSelect:(ZeroTabBarController *)zeroTabCon controller:(ZeroViewController *)zVC;
-(BOOL)tabBarShouldSelect:(ZeroTabBarController *)zeroTabCon controller:(ZeroViewController *)zVC;

@end
@interface ZeroTabBarController : UIViewController<ZeroTabBarDelegate>{
    NSUInteger _selectedIndex;
    NSArray *_viewControllers;
    ZeroTabBar *_zeroTabBar;
    UIView *_containerView;
    
}
@property (weak,nonatomic) IBOutlet id<ZeroTabBarDelegate> delegate;
@property (nonatomic) NSUInteger selectedIndex;
@property (strong,nonatomic) NSArray *viewControllers;
@property (strong,nonatomic) ZeroTabBar *zeroTabBar;

-(id)initWithTabBarItems:(NSArray *)viewCons;
-(void)animateIcons:(NSUInteger)previousIndex andCurrentIndex:(NSUInteger)currentIndex;

@end