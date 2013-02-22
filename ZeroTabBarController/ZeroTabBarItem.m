//
//  ZeroTabBarItem.m
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ZeroTabBarItem.h"

@implementation ZeroTabBarItem
@dynamic image;
@synthesize title=_title;
@synthesize imgView;
@synthesize initialSize;
@synthesize selectedImage=_selectedImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(id)initWithImage:(UIImage *)img andTitle:(NSString *)title{
    NSArray *nibObjArray = [[NSBundle mainBundle] loadNibNamed:@"ZeroTabBarItem" owner:self options:Nil];
    
    self = [nibObjArray objectAtIndex:0];
    if (self) {
        [self setImage:img];
        [self.title setText:title];
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 3.0f;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.imgView.layer.shadowColor=[UIColor greenColor].CGColor;
        self.imgView.layer.shadowOpacity=0.9f;
        self.imgView.layer.shadowRadius= 10.0f;
    }
    return self;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    [self.imgView setImage:image];

}
-(UIImage *)image{
    return _image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//  }
@end
