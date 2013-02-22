//
//  ZeroTabBarItem.h
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZeroTabBarItem : UIControl{
    UIImage *_image;
    UILabel *_title;
    UIImage *_selectedImage;
    CGSize initialSize;
    
}

@property (strong ,nonatomic) UIImage *image;
@property (readonly,strong) IBOutlet UIImageView  *imgView;
@property (strong,nonatomic) IBOutlet UILabel  *title;
@property (strong ,nonatomic) UIImage *selectedImage;
@property (nonatomic) CGSize initialSize;

-(id)initWithImage:(UIImage *)img andTitle:(NSString *)title;

@end
