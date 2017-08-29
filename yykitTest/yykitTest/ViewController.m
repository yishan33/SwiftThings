//
//  ViewController.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/13.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "ViewController.h"
#import "cardModel.h"
#import "NSObject+YYModel.h"
#import "UIView+YYAdd.h"
#import "CrownGuideModelView.h"
#import "HotGiftGuideModelView.h"
#import "GodOilGuideModelView.h"
#import "testFile.h"
#import "Masonry.h"
#import "YYKit.h"
#import "AFHTTPSessionManager.h"
#import <objc/runtime.h>
#import "SVProgressHUD.h"
#import "SmartQueueManager.h"
#import "NSObject+Description.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

static const CGFloat interval = 10;
static const CGFloat cellWidth = 30;


static NSString * const cellId = @"collectionCell";
static NSString * const headerId = @"collectionHeader";
static NSString * const footerId = @"collectionFoot";

static int taskIndex = 0;

NSString * const imageUrl1 = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3335042205,747015470&fm=26&gp=0.jpg";
NSString * const imageUrl2 = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1816908290,492075144&fm=26&gp=0.jpg";
NSString * const imageUrl3 = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2586917406,2893214293&fm=26&gp=0.jpg";
NSString * const imageUrl4 = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2947852654,2402359091&fm=26&gp=0.jpg";

typedef void (^taskEndBLock)();

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIImageView *thirdImageView;
@property (nonatomic, strong) UIImageView *forthImageView;

@property (nonatomic, strong) UICollectionViewLayout *customLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *section0Array;
@property (nonatomic, strong) NSMutableArray *section1Array;
@property (nonatomic, assign) BOOL isEditStatus;

@property (nonatomic, copy) taskEndBLock endBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self makeView];
//    [self keepImageUrls];
//    [self loadImages];
    
//    [self loadModelArray];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self loadCollectionView];
    
    [self testDescription];

}

#pragma mark - DescriptionTest 
- (void)testDescription {
    cardModel *testModel = [[cardModel alloc] init];
    testModel.name = @"lfs";
    testModel.dic = @{@"hight":@"188", @"money":@"11111"};
    testModel.array = @[testModel.dic, testModel.dic];
    testModel.phoneNumber = @"15928580431";
    testModel.testNum = 1;

    NSLog(@"lfs_test: cardModel:%@", [testModel detailDescription]);
}

#pragma mark - SmartQueueManager
- (void)testSmartQueue {
    
    UIButton *addEventButton = [UIButton new];
    [addEventButton setTitle:@"增加事件" forState:UIControlStateNormal];
    [addEventButton addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
    addEventButton.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:addEventButton];
    
    UIButton *processEventButton = [UIButton new];
    [processEventButton setTitle:@"处理事件" forState:UIControlStateNormal];
    [processEventButton addTarget:self action:@selector(processEvent:) forControlEvents:UIControlEventTouchUpInside];
    processEventButton.backgroundColor = UIColor.blueColor;
    [self.view addSubview:processEventButton];
    
    [addEventButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(60);
    }];
    
    [processEventButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(60);
    }];
    
    [SmartQueueManager addClient:self forKey:@"mainView"];
}


- (void)onReceiveSmartQueueNotify:(NSDictionary *)notify completion:(taskEndBLock)block {
    NSLog(@"--------------Receive Event");
    NSLog(@"%@", [notify objectForKey:@"taskName"]);
    _endBlock = block;
}

- (void)addEvent:(UIView *)sender {
    NSLog(@"add Event-----------");
    NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
    NSString *taskName = [NSString stringWithFormat:@"process task-%i", taskIndex];
    [event setObject:taskName forKey:@"taskName"];
    [SmartQueueManager addEvent: event forClientKey:@"mainView"];
    taskIndex += 1;
}

- (void)processEvent:(UIView *)sender {
    NSLog(@"process Event");
    if (_endBlock) {
        _endBlock();
    }
}

//NSOperation,UIStackView,单例,BundlePath,Plist

- (void)keepImageUrls {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"];
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *tempPath = NSTemporaryDirectory();
    
    NSLog(@"bundlePath: %@ \n documentsPath:%@ \n cachesPath:%@ \n tempPath:%@", bundlePath, documentsPath, cachesPath, tempPath);
}

- (void)loadImages {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [_firstImageView setImageWithURL:[NSURL URLWithString:imageUrl1] placeholder:nil];
        NSLog(@"op1 is done");
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [_secondImageView setImageWithURL:[NSURL URLWithString:imageUrl2] placeholder:nil];
        NSLog(@"op2 is done");
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [_thirdImageView setImageWithURL:[NSURL URLWithString:imageUrl3] placeholder:nil];
        NSLog(@"op3 is done");
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        [_forthImageView setImageWithURL:[NSURL URLWithString:imageUrl4] placeholder:nil];
        NSLog(@"op4 is done");
    }];
    
    [op1 addDependency:op2];
    [op2 addDependency:op3];
    [op3 addDependency:op4];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    
}

- (void)makeView {
    
    UIStackView *backStackView = [[UIStackView alloc] init];
    backStackView.axis = UILayoutConstraintAxisVertical;
    backStackView.alignment = UIStackViewAlignmentCenter;
    backStackView.spacing = interval;
    [self.view addSubview:backStackView];
    
    [backStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    
    _firstImageView = [UIImageView new];
    _firstImageView.backgroundColor = UIColor.purpleColor;
    [backStackView addArrangedSubview:_firstImageView];
    
    _secondImageView = [UIImageView new];
    _secondImageView.backgroundColor = UIColor.orangeColor;
    [backStackView addArrangedSubview:_secondImageView];
    
    _thirdImageView = [UIImageView new];
    _thirdImageView.backgroundColor = UIColor.grayColor;
    [backStackView addArrangedSubview:_thirdImageView];
    
    _forthImageView = [UIImageView new];
    _forthImageView.backgroundColor = UIColor.greenColor;
    [backStackView addArrangedSubview:_forthImageView];
    
    CGFloat imageWidth = SCREEN_WIDTH - 2 * interval;
    CGFloat imageHeight = (SCREEN_HEIGHT - 20 - 3 * interval) / 4;
    
    [_firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
    }];
    
    [_secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
    }];
    
    [_thirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
    }];
    
    [_forthImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
    }];
}

- (void)loadModelArray {
    _section0Array = [[NSMutableArray alloc] init];
    _section1Array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 20; i++) {
        cardModel *card = [[cardModel alloc] init];
        card.name = @"lfs";
        card.phoneNumber = @"1234555";
        [_section0Array addObject:card];
        [_section1Array addObject:card];
    }
}

- (void)loadCollectionView {
    _customLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:_customLayout];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;


    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

//点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"lfst:target %li is be highed", (long)indexPath.row);
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (cell.backgroundColor == [UIColor greenColor] && _isEditStatus) {
        cell.backgroundColor = [UIColor purpleColor];
    } else {
        cell.backgroundColor = [UIColor greenColor];
    }
}

//选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"lfst:target %li is be selected", (long)indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isEditStatus) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor purpleColor];
    }
}

//长按某item,弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

//使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(nonnull SEL)action forItemAtIndexPath:(nonnull NSIndexPath *)indexPath withSender:(nullable id)sender {
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        return YES;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(nonnull SEL)action forItemAtIndexPath:(nonnull NSIndexPath *)indexPath withSender:(nullable id)sender {
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        [_collectionView performBatchUpdates:^{
            [_section0Array removeObjectAtIndex:indexPath.row];
            [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:nil];
    } else if ([NSStringFromSelector(action) isEqualToString:@"paste:"]) {
        NSLog(@"粘贴");
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (CGSize){cellWidth, cellWidth};
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (CGSize){SCREEN_WIDTH, 44};
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return (CGSize){SCREEN_WIDTH, 22};
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return  _section0Array.count;
    } else {
        return _section1Array.count;
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if (headerView == nil) {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        UISwitch *statusSwitch = [[UISwitch alloc] init];
        [statusSwitch addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventValueChanged];
        [headerView addSubview:statusSwitch];
        
        [statusSwitch mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.mas_equalTo(5);
            make.centerY.mas_equalTo(0);
            
        }];
        
        return headerView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if (footerView == nil) {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor grayColor];
        
        return footerView;
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    NSLog(@"lfst:move item from %li to %li", sourceIndexPath.row, destinationIndexPath.row);
}

#pragma mark - function
- (void)changeStatus:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    _isEditStatus = [switchButton isOn];
}
@end
