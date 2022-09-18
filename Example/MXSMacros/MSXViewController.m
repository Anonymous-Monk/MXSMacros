//
//  MSXViewController.m
//  MXSMacros
//
//  Created by Anonymous-Monk on 08/20/2019.
//  Copyright (c) 2019 Anonymous-Monk. All rights reserved.
//

#import "MSXViewController.h"
#import <MXSMacros/MXSMacros-umbrella.h>

@interface MSXViewController ()

@end

@implementation MSXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    UIWindow *window = rhKeyWindow();
    RHLog(@"isIPad:%@",isIPad()?@"是":@"否");
    RHLog(@"rhKeyWindow:%@",window);
    RHLog(@"rhScreenWidth:%f",rhScreenWidth());
    RHLog(@"rhScreenHeight:%f",rhScreenHeight());
    RHLog(@"rhStatusBarHeight:%f",rhStatusBarHeight());
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
