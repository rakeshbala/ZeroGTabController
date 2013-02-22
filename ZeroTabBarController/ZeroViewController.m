//
//  ZeroViewController.m
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ZeroViewController.h"
#import "ZeroTabBarItem.h"


@implementation ZeroViewController
@synthesize zeroTabBarItem=_zeroTabBarItem;
@synthesize zeroTabBarController=_zeroTabBarController;
@synthesize dummyLabelForTEst = _dummyLabelForTEst;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.zeroTabBarItem = [[ZeroTabBarItem alloc]initWithImage:Nil andTitle:@""];
        
    }
    return self;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.dummyLabelForTEst setText:[NSString stringWithFormat:@"%ld",arc4random()]];
//    self.view.backgroundColor = [UIColor colorWithWhite:1 -(arc4random() % 3)/10.0f alpha:(arc4random()%10)/10.0f];

}


- (void)viewDidUnload
{
    [self setDummyLabelForTEst:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
