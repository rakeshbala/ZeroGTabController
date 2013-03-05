//
//  ViewController.m
//  ZeroTabBarController
//
//  Created by Rakesh on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ZeroTabBarController.h"
#import "ZeroViewController.h"
#import "ZeroTabBarItem.h"
@implementation ViewController
@synthesize openButton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    openButton.layer.cornerRadius = 20.0f;
    openButton.layer.shadowRadius = 5.0f;
    openButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    openButton.layer.shadowOffset = CGSizeMake(3, 0);
    openButton.layer.shadowOpacity = 0.8;
    openButton.layer.borderColor = [UIColor blackColor].CGColor;
    openButton.layer.borderWidth = 2.0f;
    openButton.backgroundColor = [UIColor colorWithRed:.2 green:.3 blue:.8 alpha:0.9];
    openButton.titleLabel.textColor = [UIColor whiteColor];
}



- (void)viewDidUnload
{
    [self setOpenButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)openTab:(id)sender {
    ZeroViewController *zVCon1 = [[ZeroViewController alloc] initWithNibName:@"ZeroViewController" bundle:nil];
    ZeroViewController *zVCon2 = [[ZeroViewController alloc] initWithNibName:@"ZeroViewController" bundle:nil];
    ZeroViewController *zVCon3 = [[ZeroViewController alloc] initWithNibName:@"ZeroViewController" bundle:nil];
    zVCon3.zeroTabBarItem.image=[UIImage imageNamed:@"happy.png"];
    zVCon2.zeroTabBarItem.image=[UIImage imageNamed:@"heart.png"];
    zVCon1.zeroTabBarItem.image=[UIImage imageNamed:@"sad.png"];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:zVCon1,zVCon2,zVCon3, nil];
    ZeroTabBarController *zeroTabCon = [[ZeroTabBarController alloc] initWithTabBarItems:arr];
    [zeroTabCon setSlideWithContinuosBackgroundImage:[UIImage imageNamed:@"Beach.jpg"]];
    [self presentModalViewController:zeroTabCon animated:YES];
}
@end
