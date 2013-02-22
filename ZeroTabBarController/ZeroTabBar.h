//
//  ZeroTabBar.h
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZeroTabBarItem;

@interface ZeroTabBar : UIView{
    NSArray *items;
    ZeroTabBarItem *selectedItem;
}
@property (strong,nonatomic) NSArray *items;
@property (strong,nonatomic) ZeroTabBarItem *selectedItem;
@end
