//
//  ViewController.m
//  MKPageViewController
//
//  Created by MarkXiu on 16/7/9.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import "ViewController.h"
#import "MKViewController.h"
#import "CustomViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController5.h"
@interface ViewController ()<MKViewControllerDelegate ,MKViewControllerDataSource>
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) NSArray *vcArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.array = [NSArray arrayWithObjects:@"新闻",@"资讯", @"科技",@"笑话", @"头条",@"见闻",@"财经",nil];
    CustomViewController *vc1 = [[CustomViewController alloc] init];
    ViewController1 *vc2 = [[ViewController1 alloc] init];
     ViewController2 *vc3 = [[ViewController2 alloc] init];
     ViewController3 *vc4 = [[ViewController3 alloc] init];
     ViewController5 *vc5 = [[ViewController5 alloc] init];
     ViewController5 *vc6 = [[ViewController5 alloc] init];
     ViewController5 *vc7 = [[ViewController5 alloc] init];
    self.vcArray = [NSArray arrayWithObjects:vc1,vc2,vc3,vc4, vc5 ,vc6, vc7,nil];
}
- (IBAction)click:(id)sender {
    MKViewController *vc = [[MKViewController alloc] init];
    vc.delegate = self;
    vc.dataSource = self;
    vc.titlesArray = self.array;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numbersOfChildViewControllerInMkViewController:(MKViewController *)viewController {
    return self.array.count;
}

- (UIViewController *)MKViewController:(MKViewController *)viewController ViewControllerAtIndex:(NSInteger)index {
    return self.vcArray[index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
