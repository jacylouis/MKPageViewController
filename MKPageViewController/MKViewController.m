//
//  MKViewController.m
//  MKPageViewController
//
//  Created by MarkXiu on 16/7/9.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "MKViewController.h"
#import "MKMenuView.h"
@interface MKViewController () <MKMenuViewDelegate ,MKMenuViewDataSource ,UIScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView *contentScrollView;

@property (nonatomic ,assign)NSInteger childControllerCount;

@property (nonatomic ,assign)NSInteger selIndex;

@property (nonatomic ,strong)MKMenuView *titlesView;

@end

@implementation MKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易新闻";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTitlesView];
    [self addContentScrollView];
    [self addChildViewControllersAtIndex:self.selIndex];
    
}

- (void)addTitlesView {
    self.titlesView = [[MKMenuView alloc] initWithFrame:(CGRect) {0,64, self.view.bounds.size.width, 44}];
    self.titlesView.delegate = self;
    self.titlesView.dataSource = self;
    [self.view addSubview:self.titlesView];
}

- (void)addChildViewControllersAtIndex:(NSInteger )index{
    UIViewController *viewController = [self viewControllers:index];
    [self addChildViewController:viewController];
    viewController.view.frame = (CGRect) {self.contentScrollView.bounds.size.width * index, 0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height};
    [self.contentScrollView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (UIViewController *)viewControllers:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(MKViewController:ViewControllerAtIndex:)]) {
       UIViewController *viewController = [self.dataSource MKViewController:self ViewControllerAtIndex:index];
        return viewController;
    }
    return nil;
}

- (void)addContentScrollView{
    self.contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView.frame = (CGRect) {0, 64+44, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 44};
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.contentSize = (CGSize){self.view.bounds.size.width * self.childControllerCount,0 };
    [self.view addSubview:self.contentScrollView];
}
- (void)menuView:(MKMenuView *)menuView didClickTitlesAtIndex:(NSInteger)index {
    self.selIndex = index;
    [self addChildViewControllersAtIndex:self.selIndex];
    [self.contentScrollView setContentOffset:CGPointMake(self.view.bounds.size.width * index, 0) animated:YES];
}
- (NSInteger)numbersOfTitlesInMenuView:(MKMenuView *)menuView {
    return self.titlesArray.count;
}
- (NSString *)menuView:(MKMenuView *)menuView titleAtIndex:(NSInteger)index {
   
    return self.titlesArray[index];
}
- (NSInteger)childControllerCount {
    return [self.dataSource numbersOfChildViewControllerInMkViewController:self];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self.titlesView selectTitleAtIndex:index];
}
@end
