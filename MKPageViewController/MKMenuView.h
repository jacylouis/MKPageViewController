//
//  MKMenuView.h
//  MKPageViewController
//
//  Created by MarkXiu on 16/7/9.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKMenuView;

@protocol MKMenuViewDelegate <NSObject>
@optional;
- (void)menuView:(MKMenuView *)menuView didClickTitlesAtIndex:(NSInteger) index;

@end

@protocol MKMenuViewDataSource <NSObject>
@required;
- (NSString *)menuView:(MKMenuView *)menuView titleAtIndex:(NSInteger)index;

- (NSInteger)numbersOfTitlesInMenuView:(MKMenuView *)menuView;

@end
@interface MKMenuView : UIView

@property (nonatomic ,weak) id <MKMenuViewDelegate> delegate;

@property (nonatomic ,weak) id <MKMenuViewDataSource> dataSource;

- (void)selectTitleAtIndex:(NSInteger)index;
@end
