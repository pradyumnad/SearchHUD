//
//  ViewController.m
//  SearchHUD-Demo
//
//  Created by Pradyumna Doddala on 31/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "ViewController.h"
#import "SearchHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SearchHUD *searchHUD = [[SearchHUD alloc] initWithSearchList:[NSArray arrayWithObjects:@"a", @"aaa", @"n", @"ban", @"nam", @"dan", @"don", nil] andDelegate:self];
    [self.view addSubview:searchHUD];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
