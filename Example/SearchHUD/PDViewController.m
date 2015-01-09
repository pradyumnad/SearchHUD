//
//  PDViewController.m
//  SearchHUD
//
//  Created by Pablo Carrillo on 12/12/2014.
//  Copyright (c) 2014 Pablo Carrillo. All rights reserved.
//

#import "PDViewController.h"
#import "View+MASAdditions.h"

@interface PDViewController ()
@property(nonatomic, strong) NSArray *items;
@property(weak, nonatomic) IBOutlet UILabel *countryLabel;
@property(weak, nonatomic) IBOutlet UITextView *loremIpsum;
@property(weak, nonatomic) IBOutlet UIButton *showListButton;

@end

@implementation PDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _countryLabel.text = @"Tap on Show List";

    _items = @[@"Brazil", @"China",
            @"France", @"Germany",
            @"India", @"Japan",
            @"Nigeria", @"Russia",
            @"United States", @"United Kingdom"];
    self.view.backgroundColor = [UIColor redColor];
    [self addMasConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addMasConstraints {

    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
    }];
    [self.showListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.countryLabel);
        make.top.equalTo(self.countryLabel.mas_bottom).offset(30);
    }];
    [self.loremIpsum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(10);
        make.top.equalTo(self.showListButton.mas_bottom).offset(50);
    }];
}

#pragma mark -
#pragma mark Actions

- (IBAction)showList:(id)sender {
    PDSearchHUD *searchHUD = [[PDSearchHUD alloc] initWithSearchList:self.items andDelegate:self];
    [searchHUD setDismissWhenRowSelected:YES];
    [searchHUD setSearchType:PDSearchTypeContains];
    //Uncomment the following line to pre fill the search bar with some text, like the last selection
    //searchHUD.searchBar.text = @"India";
    [searchHUD addToSuperView:self.view withInsets:PDSEARCHHUD_DEFAULT_INSETS];
}

#pragma mark -
#pragma mark SearchHUD

- (void)didSelectRowAtIndex:(NSUInteger)index {
    NSLog(@"Index of Tapped item : %lu", (unsigned long) index);
    _countryLabel.text = (self.items)[index];
}

- (void)didSelectItem:(NSString *)item {
    NSLog(@"Selected Item %@", item);
    _countryLabel.text = item;
}

@end
