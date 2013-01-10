//
//  ViewController.h
//  SearchHUD-Demo
//
//  Created by Pradyumna Doddala on 31/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDSearchHUD.h"

@interface ViewController : UIViewController <PDSearchHUDDelegate>

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
- (IBAction)showList:(id)sender;

@end
