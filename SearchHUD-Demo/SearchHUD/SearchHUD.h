//
//  SearchHUD.h
//  SearchHUD-Demo
//
//  Created by Pradyumna Doddala on 31/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchHUDDelegate <NSObject>

- (void)didSelectRowAtIndex:(int)index;
- (void)didSelectItem:(NSString *)item;
@end

@interface SearchHUD : UIView <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

@property (nonatomic, assign) __unsafe_unretained id <SearchHUDDelegate>delegate;
@property (nonatomic, strong) NSArray *searchList;

- (id)initWithSearchList:(NSArray *)list andDelegate:(id)aDelegate;
@end
