//
//  MKMenuView.m
//  MKPageViewController
//
//  Created by MarkXiu on 16/7/9.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "MKMenuView.h"

static CGFloat titlesWith = 80;
static NSInteger buttonTagOffset = 1000;
@interface MKMenuView ()

@property (nonatomic ,strong) UIScrollView *titlesScrollView;

@property (nonatomic ,assign ,readonly) NSInteger titlesCount;

@property (nonatomic ,strong) UIButton *selButton;
@end

@implementation MKMenuView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self _addScrollView];
    [self _addTitlesView];
}

#pragma mark - Private Methods

- (void)_addScrollView {
    _titlesScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _titlesScrollView.showsHorizontalScrollIndicator = NO;
    _titlesScrollView.showsVerticalScrollIndicator = NO;
    _titlesScrollView.scrollsToTop = NO;
    [self addSubview:_titlesScrollView];
}

- (void)_addTitlesView {
    
    for (int i = 0; i < self.titlesCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = (CGRect) {titlesWith * i, 0, titlesWith, self.bounds.size.height};
        if ([self.dataSource respondsToSelector:@selector(menuView:titleAtIndex:)]) {
            NSString *string = [self.dataSource menuView:self titleAtIndex:i];
             [button setTitle:string forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i + buttonTagOffset;
        if (i == 0) {
            [self didClickButton:button];
            button.transform = CGAffineTransformMakeScale(1.3, 1.3);
        }
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesScrollView addSubview:button];
    }
    self.titlesScrollView.contentSize = (CGSize){titlesWith * self.titlesCount, 0};
    
}

#pragma mark - Public Methods

- (void)selectTitleAtIndex:(NSInteger)index {
    NSInteger tag = index + buttonTagOffset;
    UIButton *button = [self viewWithTag:tag];
    [self didClickButton:button];
}

- (void)TitlesleftIndex:(NSInteger)indexL rightIndex:(NSInteger)indexR leftScale:(CGFloat)scaleL rightScale:(CGFloat)scaleR{
    
    NSInteger leftTag = indexL + buttonTagOffset;
    NSInteger rightTag = indexR + buttonTagOffset;
    UIButton *leftBtn = [self viewWithTag:leftTag];
    UIButton *rightBtn = [self viewWithTag:rightTag];
    leftBtn.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1);
    [leftBtn setTitleColor:[UIColor colorWithRed:scaleL green:0 blue:0 alpha:1 ]forState:UIControlStateSelected];
    [leftBtn setTitleColor:[UIColor colorWithRed:scaleL green:0 blue:0 alpha:1 ]forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:scaleR green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:scaleR green:0 blue:0 alpha:1] forState:UIControlStateSelected];
}

#pragma mark - Touch Event

- (void)didClickButton:(UIButton *)button {
    if (self.selButton == button) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(menuView:didClickTitlesAtIndex:)]) {
        self.selButton.selected = NO;
        self.selButton.transform = CGAffineTransformIdentity;
        [self.selButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.selected = YES;
        [self.delegate menuView:self didClickTitlesAtIndex:button.tag - buttonTagOffset];
        self.selButton = button;
    }
    
    CGFloat offsetX = button.center.x - self.bounds.size.width / 2;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffset = self.titlesScrollView.contentSize.width - self.titlesScrollView.bounds.size.width;
    if (offsetX > maxOffset) {
        offsetX = maxOffset;
    }
    [self.titlesScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark -GetMethod

- (NSInteger)titlesCount {
    if ([self.dataSource respondsToSelector:@selector(numbersOfTitlesInMenuView:)]) {
        return [self.dataSource numbersOfTitlesInMenuView:self];
    }
    return 0;
}
@end
