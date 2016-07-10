//
//  MKViewController.h
//  MKPageViewController
//
//  Created by MarkXiu on 16/7/9.
//  Copyright © 2016年 xsm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKViewController;

@protocol MKViewControllerDataSource <NSObject>

- (UIViewController *)MKViewController:(MKViewController *)viewController ViewControllerAtIndex:(NSInteger)index;

- (NSInteger )numbersOfChildViewControllerInMkViewController:(MKViewController *)viewController;

@end


@protocol MKViewControllerDelegate <NSObject>



@end

@interface MKViewController : UIViewController

@property (nonatomic ,weak) id <MKViewControllerDataSource> dataSource;

@property (nonatomic ,weak) id <MKViewControllerDelegate> delegate;

@property (nonatomic ,strong)NSArray *titlesArray;

@end
