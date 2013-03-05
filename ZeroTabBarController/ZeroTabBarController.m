//
//  ZeroTabBarController.m
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//





#import "ZeroTabBarController.h"
#import "ZeroTabBar.h"
#import "ZeroViewController.h"
#import "ZeroTabBarItem.h"

@interface ZeroTabBarController (){
    BOOL shouldSlide;
}
-(void)initializeTabBarAndTabBarItems;
-(void)itemSelected:(id)sender;
-(void)slideAnimation:(NSUInteger)previousIndex andCurrentIndex:(NSUInteger)currentIndex;

@end

@implementation ZeroTabBarController
@synthesize delegate;
@dynamic selectedIndex;
@synthesize viewControllers=_viewControllers;
@synthesize zeroTabBar=_zeroTabBar;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithTabBarItems:(NSArray *)viewCons{
    self = [super init];
    if (self) {
        [self setDelegate:self];
        NSMutableArray *tempViewCons = [NSMutableArray array];
        _containerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
        for (UIViewController *viewCon in viewCons) {
            
            [tempViewCons addObject:viewCon];
        }
        
        self.viewControllers = tempViewCons;
        self.view=_containerView;
        [_containerView addSubview:[[self.viewControllers objectAtIndex:0] view]];
         self.selectedIndex = 0;
        [self initializeTabBarAndTabBarItems];
    }
    return self;
}




-(void)initializeTabBarAndTabBarItems{
    
    
    self.zeroTabBar = [[ZeroTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 62, 320, 62)];

    [self.view addSubview:self.zeroTabBar];
    NSUInteger count = self.viewControllers.count;
    CGFloat itemWidth=0;
    if (count<=4) {
        itemWidth=self.view.frame.size.width/count;
    }else{
        itemWidth=self.view.frame.size.width/5;
    }
    int index = 0;
   
    
    
    for (ZeroViewController *zvc in self.viewControllers) {
        CGRect itemFrame = CGRectMake(itemWidth*index, 0, itemWidth, 62);
            
        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction:)];
        rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
        UISwipeGestureRecognizer *leftSwipte = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction:)];
        rightSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
        [zvc.view addGestureRecognizer:rightSwipe];
        [zvc.view addGestureRecognizer:leftSwipte];
        zvc.zeroTabBarItem.layer.borderWidth = 1.50f;
        zvc.zeroTabBarItem.tag = index;
        [zvc.zeroTabBarItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        zvc.zeroTabBarItem.frame = itemFrame;
        [self.zeroTabBar addSubview:zvc.zeroTabBarItem];
        
        index++;
    }
    NSLog(@"%@",self.view.subviews);
    //set blue shadow for initial;
    [[self.viewControllers objectAtIndex:self.selectedIndex] zeroTabBarItem ].imgView.layer.shadowColor=[UIColor blueColor].CGColor;

    
}
         
-(void)itemSelected:(id)sender{
        
    BOOL select = [self.delegate tabBarShouldSelect:self controller:[self.viewControllers objectAtIndex:[sender tag]]];
    if (select) {
        [self setSelectedIndex:[sender tag]];
    }
    
    
}

-(void)setSlideWithContinuosBackgroundImage:(UIImage *)background{
    NSInteger index=0;

    for (ZeroViewController *zvc in self.viewControllers) {
        CGFloat xPos=(-index)*zvc.view.frame.size.width;
        CGFloat yPos=0;
        CGFloat imWidth = zvc.view.frame.size.width*self.viewControllers.count;
        CGFloat imHeight = zvc.view.frame.size.height;
        UIImageView *bgImageVw = [[UIImageView alloc]initWithImage:background];
        bgImageVw.frame = CGRectMake(xPos, yPos, imWidth, imHeight);
        [zvc.view insertSubview:bgImageVw atIndex:0];
        index++;
    }
    shouldSlide=YES;
}






-(void)leftSwipeAction:(id)sender{
    NSInteger newIndex = self.selectedIndex+1;
    if (newIndex>self.viewControllers.count-1) {
        newIndex=self.viewControllers.count-1;
    }
    [self setSelectedIndex:newIndex];
}

-(void)rightSwipeAction:(id)sender{
    NSInteger newIndex = self.selectedIndex-1;
    if (newIndex<0) {
        newIndex=0;
    }
    [self setSelectedIndex:newIndex];

}


-(NSUInteger)selectedIndex{
    return _selectedIndex;
}
-(void)setSelectedIndex:(NSUInteger)selectedInd{
    NSUInteger previousIndex = _selectedIndex;
//    [self.zeroTabBar removeFromSuperview];

    if (previousIndex!=selectedInd) {
        [self animateIcons:previousIndex andCurrentIndex:selectedInd];
        if (shouldSlide) {
            [self slideAnimation:previousIndex andCurrentIndex:selectedInd];
            return;
        }
    }
    _selectedIndex = selectedInd;

    ZeroViewController *selectedViewCon = [self.viewControllers objectAtIndex:_selectedIndex];
    [self.zeroTabBar removeFromSuperview];
    [[self.view.subviews objectAtIndex:0]removeFromSuperview];
    [self.view addSubview:selectedViewCon.view];
    [self.view addSubview:self.zeroTabBar];
    [self.delegate tabBarDidSelect:self controller:selectedViewCon];
  

    
}


-(void)slideAnimation:(NSUInteger)previousIndex andCurrentIndex:(NSUInteger)currentIndex{
    
    
    ZeroViewController *previousVC = [self.viewControllers objectAtIndex:previousIndex];
    ZeroViewController *currentVC = [self.viewControllers objectAtIndex:currentIndex];
    CGFloat viewWidth =previousVC.view.frame.size.width;
    int mult = previousIndex-currentIndex;
    __block CGFloat xTrans = mult*viewWidth;
    
    previousVC.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.2 animations:^{
        
        for (UIView *vw in previousVC.view.subviews) {
            if (vw==self.zeroTabBar) {
                continue;
            }
            vw.frame = CGRectApplyAffineTransform(vw.frame, CGAffineTransformMakeTranslation(xTrans, 0));
        }
        
    } completion:^(BOOL finished) {
        _selectedIndex = currentIndex;
        [self.zeroTabBar removeFromSuperview];
        [[self.view.subviews objectAtIndex:0]removeFromSuperview];
        [self.view addSubview:currentVC.view];
        [self.view addSubview:self.zeroTabBar];
        [self.delegate tabBarDidSelect:self controller:currentVC];
        previousVC.view.userInteractionEnabled = YES;
        for (UIView *vw in previousVC.view.subviews) {
            if (vw==self.zeroTabBar) {
                continue;
            }
            vw.frame = CGRectApplyAffineTransform(vw.frame, CGAffineTransformMakeTranslation(-xTrans, 0));
        }
    }];
    
}


-(void)animateIcons:(NSUInteger)previousIndex andCurrentIndex:(NSUInteger)currentIndex{
    
    
    ZeroViewController *previousVC = [self.viewControllers objectAtIndex:previousIndex];
    ZeroViewController *currentVC = [self.viewControllers objectAtIndex:currentIndex];
    //increase size by 1.25
    CGRect imgViewFrame = currentVC.zeroTabBarItem.imgView.frame;
    CGRect tempFrame = imgViewFrame;
    CGFloat initialX = tempFrame.size.width;
    CGFloat initialY = tempFrame.size.height;
    tempFrame.size.height=initialY*1.25;
    tempFrame.size.width=initialX*1.25;
    CGFloat xdiff = (tempFrame.size.width - imgViewFrame.size.width)/2;
    CGFloat ydiff = (tempFrame.size.width - imgViewFrame.size.width)/2;
    tempFrame.origin.x = tempFrame.origin.x-xdiff;
    tempFrame.origin.y = tempFrame.origin.y-ydiff;
    
    
    
    
    
    [UIView animateWithDuration:.1 animations:^{
        currentVC.zeroTabBarItem.imgView.frame=tempFrame;
        currentVC.zeroTabBarItem.imgView.layer.shadowColor=[UIColor blueColor].CGColor;
        
        previousVC.zeroTabBarItem.imgView.layer.shadowColor=[UIColor greenColor].CGColor;

    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.1 animations:^{
            previousVC.zeroTabBarItem.imgView.frame=imgViewFrame;
            
            CGRect tempFrame2 = currentVC.zeroTabBarItem.imgView.frame;
            tempFrame2.size.height=tempFrame2.size.height*0.9;
            tempFrame2.size.width=tempFrame2.size.width*0.9;
            CGFloat xdiff = (tempFrame2.size.width - currentVC.zeroTabBarItem.imgView.frame.size.width)/2;
            CGFloat ydiff = (tempFrame2.size.height - currentVC.zeroTabBarItem.imgView.frame.size.height)/2;
            tempFrame2.origin.x = tempFrame.origin.x-xdiff;
            tempFrame2.origin.y = tempFrame.origin.y-ydiff;
            currentVC.zeroTabBarItem.imgView.frame=tempFrame2;
        } completion:^(BOOL finished) {
          

        }];
    }];
}






- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)tabBarShouldSelect:(ZeroTabBarController *)zeroTabCon controller:(ZeroViewController *)zVC{
    return TRUE;
}

-(void)tabBarDidSelect:(ZeroTabBarController *)zeroTabCon controller:(ZeroViewController *)zVC{
    return;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (ZeroViewController *zvc in self.viewControllers) {
        NSLog(@"%@",zvc.zeroTabBarItem);
    }
}
@end

