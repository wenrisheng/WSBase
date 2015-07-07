//
//  TabbarViewControllerViewController.m
//  CustomTabbarViewController
//
//  Created by wrs on 15/4/7.
//  Copyright (c) 2015年 wrs. All rights reserved.
//

#import "WSTabbarViewController.h"
#import "UIViewController+FitIOSSevenTopIndex.h"
#import "WSBaseMacro.h"
#import "UIView+WSBaseUtil.h"

#define SELECTED_VIEW_CONTROLLER_TAG 98456345

@interface WSTabbarViewController () <WSTabbarItemViewDelegate>
{
    int currentIndex;
    NSMutableArray *tabbarViewArray;
}

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *tabbarView;

@end

@implementation WSTabbarViewController
@synthesize dataArray;

- (id)init
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:BASESTATICLIBRARY_BOUNDNAME withExtension:@"bundle"]];
    self = [super initWithNibName:[NSString stringWithUTF8String:object_getClassName(self)] bundle:bundle];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    currentIndex = _initIndex;
    //[_contentView updateTopConstrainToTopLayoutGuideWithViewController:self topMargin:STATUSBAR_HEIGHT];
    NSUInteger itemsCount = dataArray.count;
//    CGFloat itemCountFloat = (float)itemsCount / 1.00;
    tabbarViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < itemsCount; i++) {
        WSTabbarItemView *tabbarItemView = [WSTabbarItemView getTabbarItemView];
        tabbarItemView.delegate = self;
        tabbarItemView.tag = i;
        NSDictionary *dataDic = [dataArray objectAtIndex:i];
        tabbarItemView.imageView.image = [UIImage imageNamed:[dataDic objectForKey:TABBARITEM_IMAGE_NORMAL]];
        tabbarItemView.label.text = [dataDic objectForKey:TABBARITEM_TITLE];
        UIColor *textColor = [dataDic objectForKey:TABBARITEM_TITLE_COLOR_NORMAL];
        textColor = nil == textColor ? TABBARITEM_TITLE_COLOR_NORMAL_DEFAULT : textColor;
        tabbarItemView.label.textColor = textColor;
        [_tabbarView addSubview:tabbarItemView];
//        tabbarItemView.translatesAutoresizingMaskIntoConstraints = NO;
        
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:tabbarItemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_tabbarView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:tabbarItemView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_tabbarView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//        
//        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:tabbarItemView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tabbarView attribute:NSLayoutAttributeRight multiplier:(i / itemCountFloat) constant:0.0];
//        
//      //  NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:tabbarItemView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_tabbarView attribute:NSLayoutAttributeRight multiplier:((itemsCount - 1 - i) / itemsCount) constant:0.0];
//        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:tabbarItemView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_tabbarView attribute:NSLayoutAttributeWidth multiplier:(1 / itemCountFloat) constant:0];
//        [_tabbarView addConstraints:@[top, bottom, left, width]];
        
        [tabbarViewArray addObject:tabbarItemView];
    }
    NSInteger vcCount = dataArray.count;
    for (int i = 0; i < vcCount; i++) {
        NSDictionary *dataDic = [dataArray objectAtIndex:i];
        UIViewController *viewController = [dataDic objectForKey:TABBARITEM_VIEWCONTROLLER];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    
    [self selectedIndex:currentIndex];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect rect = self.tabbarView.bounds;
    NSInteger itemCount = tabbarViewArray.count;
    CGFloat width = rect.size.width / itemCount;
    CGFloat y = 0;
    CGFloat height = rect.size.height;
    for (int i = 0; i < itemCount; i ++) {
        UIView *itemView = [tabbarViewArray objectAtIndex:i];
        CGFloat x = i * width;
        itemView.frame = CGRectMake(x, y, width, height);
        itemView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)selectedIndex:(int)index
{
    // 移除当前视图
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    // 替换为对应新视图
    NSDictionary *dataDic = [dataArray objectAtIndex:index];
    UIViewController *viewController = [dataDic objectForKey:TABBARITEM_VIEWCONTROLLER];
    UIView *view = viewController.view;
    view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    [_contentView addSubview:view];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *metrics = @{@"top":@0,@"right":@0,@"bottom":@0,@"left":@0};
    UIView *superView = view.superview;
    NSDictionary *dic = NSDictionaryOfVariableBindings(view,superView);
    NSArray *hcon=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:metrics views:dic];
    NSArray *vcon=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:metrics views:dic];
    [superView addConstraints:hcon];
    [superView addConstraints:vcon];
    
    
    // 上一个TabbarItemView 恢复正常状态
    WSTabbarItemView *olderTabbarItemView = [tabbarViewArray objectAtIndex:currentIndex];
    NSDictionary *normalDic = [dataArray objectAtIndex:currentIndex];
    olderTabbarItemView.imageView.image = [UIImage imageNamed:[normalDic objectForKey:TABBARITEM_IMAGE_NORMAL]];
    UIColor *oldTextColor = [normalDic objectForKey:TABBARITEM_TITLE_COLOR_NORMAL];
    oldTextColor = (oldTextColor == nil ? TABBARITEM_TITLE_COLOR_NORMAL_DEFAULT : oldTextColor);
    olderTabbarItemView.label.textColor = oldTextColor;
    
    // 当前TabbarItemView 作为选中状态
    WSTabbarItemView *nweTabbarItemView = [tabbarViewArray objectAtIndex:index];
    NSDictionary *selectedDic = [dataArray objectAtIndex:index];
    nweTabbarItemView.imageView.image = [UIImage imageNamed:[selectedDic objectForKey:TABBARITEM_IMAGE_SELECTED]];
    UIColor *nweTextColor = [normalDic objectForKey:TABBARITEM_TITLE_COLOR_NORMAL];
    nweTextColor = nil == nweTextColor ? TABBARITEM_TITLE_COLOR_SELECTED_DEFAULT : nweTextColor;
    nweTabbarItemView.label.textColor = nweTextColor;
    
    currentIndex = index;
    // 回调代理事件
    if ([_delegate respondsToSelector:@selector(tabbarViewControllerDidSelectedIndex:)]) {
        [_delegate tabbarViewControllerDidSelectedIndex:currentIndex];
    }
}

#pragma mark - TabbarItemViewDelegate
- (void)clickTabbarItemView:(WSTabbarItemView *)tabbarItemView
{
    int tag = (int)tabbarItemView.tag;
    [self selectedIndex:tag];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
