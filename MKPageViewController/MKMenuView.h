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
/**
 *  contentScrollView滚动调用这方法
 *
 *  @param index 传入该选中的index
 */
- (void)selectTitleAtIndex:(NSInteger)index;
/**
 *  设置标题颜色渐变 以及 大小改变
 *
 *  @param indexL 左边的index 计算tag
 *  @param indexR 右边的index 计算tag
 *  @param scaleL 左边缩放比例 / 颜色比例
 *  @param scaleR 右边缩放比例 / 颜色比例
 */
- (void)TitlesleftIndex:(NSInteger)indexL rightIndex:(NSInteger)indexR leftScale:(CGFloat)scaleL rightScale:(CGFloat)scaleR;
@end
