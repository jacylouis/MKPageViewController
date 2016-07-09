//
//  MKMenuView.m
//  MKPageViewController
//
//  Created by MarkXiu on 16/7/9.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "MKMenuView.h"

static CGFloat titlesWith = 60;
static NSInteger buttonTagOffset = 1000;
@interface MKMenuView ()

@property (nonatomic ,strong) UIScrollView *titlesScrollView;

@property (nonatomic ,assign ,readonly) NSInteger titlesCount;

@property (nonatomic ,strong) UIButton *selButton;
@end

@implementation MKMenuView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self addScrollView];
    [self addTitlesView];
}

- (void)addScrollView {
    _titlesScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _titlesScrollView.showsHorizontalScrollIndicator = NO;
    _titlesScrollView.showsVerticalScrollIndicator = NO;
    _titlesScrollView.scrollsToTop = NO;
    [self addSubview:_titlesScrollView];
}

- (NSInteger)titlesCount {
    if ([self.dataSource respondsToSelector:@selector(numbersOfTitlesInMenuView:)]) {
        return [self.dataSource numbersOfTitlesInMenuView:self];
    }
    return 0;
}
- (void)addTitlesView {
    
    for (int i = 0; i < self.titlesCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = (CGRect) {titlesWith * i, 0, titlesWith, self.bounds.size.height};
        if ([self.dataSource respondsToSelector:@selector(menuView:titleAtIndex:)]) {
            NSString *string = [self.dataSource menuView:self titleAtIndex:i];
             [button setTitle:string forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i + buttonTagOffset;
        if (i == 0) {
            [self didClickButton:button];
        }
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesScrollView addSubview:button];
    }
    self.titlesScrollView.contentSize = (CGSize){titlesWith * self.titlesCount, 0};
    
}
- (void)selectTitleAtIndex:(NSInteger)index {
    NSInteger tag = index + buttonTagOffset;
    UIButton *button = [self viewWithTag:tag];
    [self didClickButton:button];
}
- (void)didClickButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(menuView:didClickTitlesAtIndex:)]) {
        self.selButton.selected = NO;
        button.selected = YES;
        [self.delegate menuView:self didClickTitlesAtIndex:button.tag - buttonTagOffset];
        self.selButton = button;
    }
}
@end
