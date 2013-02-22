//
//  ZeroViewController.h
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZeroTabBarItem;
@class ZeroTabBarController;

@interface ZeroViewController : UIViewController{
    ZeroTabBarItem *_zeroTabBarItem;
    ZeroTabBarController *_zeroTabBarController;
}

@property (strong,nonatomic) ZeroTabBarItem *zeroTabBarItem;
@property (strong,nonatomic) ZeroTabBarController *zeroTabBarController;

@property (weak, nonatomic) IBOutlet UILabel *dummyLabelForTEst;
@end
