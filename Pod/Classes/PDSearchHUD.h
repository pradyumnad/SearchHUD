//
//  SearchHUD.h
//  SearchHUD-Demo
//
//  Created by Pradyumna Doddala on 31/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PDSearchTypeBeginsWith,
    PDSearchTypeContains
} PDSearchType;

@protocol PDSearchHUDDelegate <NSObject>

//Called after User taps on the List and index of the item is returned
- (void)didSelectRowAtIndex:(int)index;

//Called after User taps on the List and value is returned
- (void)didSelectItem:(NSString *)item;
@end

@interface PDSearchHUD : UIView <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@property (nonatomic, assign) __unsafe_unretained id <PDSearchHUDDelegate>delegate;
@property (nonatomic, strong) NSArray *searchList;

// Value that determines whether the HUD to dismiss after row selection
@property (nonatomic, assign) BOOL dismissWhenRowSelected;

//Used to determine the Comparision type
@property (nonatomic, assign) PDSearchType searchType;

- (id)initWithSearchList:(NSArray *)list andDelegate:(id)aDelegate;
@end
