//
//  SearchHUD.m
//  SearchHUD-Demo
//
//  Created by Pradyumna Doddala on 31/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "PDSearchHUD.h"
#import "View+MASAdditions.h"

#define CELL_IDENTIFIER @"Cell"

@interface PDSearchHUD ()

@property(nonatomic, strong) NSArray *revisedList;
@property(nonatomic, weak) UIView *visualEffectView;
@property (nonatomic, weak) UIView *vibrancyView;
@property(nonatomic, weak) UIView *viewToBlur;

- (IBAction)tappedOnClose:(id)sender;
@end

@implementation PDSearchHUD

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithSearchList:(NSArray *)list andDelegate:(id)aDelegate {
    CGRect frame = [[UIScreen mainScreen] bounds];
    NSString *seachHUDBundlePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],
                                                              @"SearchHUD.bundle"];
    NSBundle *searchHUDBundle = [NSBundle bundleWithPath:seachHUDBundlePath];
    NSArray *views = [searchHUDBundle loadNibNamed:@"PDSearchHUD" owner:self options:nil];

    self = [views lastObject];
    [self setFrame:frame];
    if (self) {
        // Initialization code
        _delegate = aDelegate;
        _searchList = list;
        _revisedList = list;
        _searchType = PDSearchTypeContains;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
        _dismissWhenRowSelected = YES;
    }
    [self addEffects];
    [self addGestureToBackground];
    return self;
}

- (void)addGestureToBackground {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tappedOnClose:)];
    [self.backgroundView addGestureRecognizer:gestureRecognizer];
}

- (void)addEffects {
    self.visualEffectView = nil;
    if (NSClassFromString(@"UIVisualEffectView")) {
        _backgroundView.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [self insertSubview:visualEffectView belowSubview:self.backgroundView];
        UIView *viewToBlur = [[UIView alloc] initWithFrame:[_visualEffectView frame]];
        self.viewToBlur = viewToBlur;
        viewToBlur.backgroundColor = [UIColor clearColor];
        [visualEffectView.contentView addSubview:viewToBlur];
        self.visualEffectView = visualEffectView;
    }
}

- (void)addToSuperView:(UIView *)superview {
//    self.alpha = 0.0f;
    [superview addSubview:self];
    [self addMasonryConstraints];
//    self.alpha = 1.0f;
}

- (void)addMasonryConstraints {
    NSInteger searchBarHeight = 44;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(@0);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(20+searchBarHeight, 20, 20, 20));
    }];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tableView);
        make.bottom.equalTo(self.tableView.mas_top);
        make.height.equalTo(@(searchBarHeight));
    }];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    if (self.visualEffectView) {
        [self.visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.vibrancyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.viewToBlur mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

- (void)layoutSubviews {
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.30 animations:^{
        self.alpha = 1.0f;
    }                completion:^(BOOL finished) {

    }];
    [super layoutSubviews];
}
/*git
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.revisedList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];

    //assign cell properties
    cell.textLabel.text = (self.revisedList)[(NSUInteger) indexPath.row];

    return cell;
}

#pragma mark - Tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *selectedItem = (self.revisedList)[(NSUInteger) indexPath.row];

    if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndex:)]) {
        NSUInteger index = [self.searchList indexOfObject:selectedItem];
        [self.delegate didSelectRowAtIndex:(NSUInteger) index];
    } else {
        NSLog(@"Sorry didSelectRowAtIndex: not implemented");
    }

    if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.delegate didSelectItem:selectedItem];
    } else {
        NSLog(@"Sorry didSelectItem: not implemented");
    }

    if (_dismissWhenRowSelected) {
        [self tappedOnClose:nil];
    }
}

#pragma mark -
#pragma mark SearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        _revisedList = self.searchList;
    } else {

        NSPredicate *predicate;
        switch (self.searchType) {
            case PDSearchTypeContains:
                predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
                break;
            case PDSearchTypeBeginsWith:
                predicate = [NSPredicate predicateWithFormat:@"SELF beginsWith[cd] %@", searchText];
                break;
            default:
                break;
        }

        _revisedList = [self.searchList filteredArrayUsingPredicate:predicate];
    }

    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    [searchBar becomeFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _revisedList = self.searchList;
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Actions

- (IBAction)tappedOnClose:(id)sender {
    [UIView animateWithDuration:0.30 animations:^{
        self.alpha = 0.1f;
    }                completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
