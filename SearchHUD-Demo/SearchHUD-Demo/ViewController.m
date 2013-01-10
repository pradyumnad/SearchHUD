//
//  ViewController.m
//  SearchHUD-Demo
//
//  Created by Pradyumna Doddala on 31/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *items;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _countryLabel.text = @"Tap on Show List";
    
    _items = [[NSArray alloc] initWithObjects:
              @"Brazil", @"China",
              @"France", @"Germany",
              @"India",  @"Japan",
              @"Nigeria", @"Russia",
              @"United States", @"United Kingdom", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions
- (IBAction)showList:(id)sender {
    PDSearchHUD *searchHUD = [[PDSearchHUD alloc] initWithSearchList:self.items andDelegate:self];
    [searchHUD setDismissWhenRowSelected:YES];
    [searchHUD setSearchType:PDSearchTypeBeginsWith];
    [self.view addSubview:searchHUD];
}

#pragma mark -
#pragma mark SearchHUD

- (void)didSelectRowAtIndex:(int)index {
    NSLog(@"Index of Tapped item : %i", index);
    _countryLabel.text = [self.items objectAtIndex:index];
}

- (void)didSelectItem:(NSString *)item {
    NSLog(@"Selected Item %@", item);
    _countryLabel.text = item;
}

- (void)viewDidUnload {
    [self setCountryLabel:nil];
    [self setItems:nil];
    [super viewDidUnload];
}
@end
