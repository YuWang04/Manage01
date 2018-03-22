//
//  ViewController.m
//  网格视图
//
//  Created by xtjsb on 2018/3/22.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "DrawController.h"
static NSString *cellid = @"cellid";
static NSString *ReuseIdentifier = @"ReuseIdentifier";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 20;
    flow.minimumInteritemSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.headerReferenceSize = CGSizeMake(0, 50);
    flow.itemSize = CGSizeMake(200, 300);
    //滚动方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //cell注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellid];
    //头部View注册
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReuseIdentifier];
    [self.view addSubview:collectionView];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    if(indexPath.section == 0&&indexPath.row == 1){
    UIImageView *view = [[UIImageView alloc]initWithFrame:cell.bounds];
    UIImage *iamge = [UIImage imageNamed:[NSString stringWithFormat:@"p1.jpg"]];
    view.image = iamge;
    [cell addSubview:view];
    }
    return cell;
    
}
//头部尾部View
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader){
        //从缓冲池中获取header
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
        if(indexPath.section == 0){
        UILabel *label = [[UILabel alloc]initWithFrame:reusableView.bounds];
        label.text = @"这是头部视图";
        [reusableView addSubview:label];
        label.backgroundColor = [UIColor yellowColor];
        }
        reusableView.backgroundColor = [UIColor yellowColor];
        return reusableView;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0&&indexPath.row == 0){
        DrawController *drawVC = [[DrawController alloc]init];
        [self.navigationController pushViewController:drawVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//以下是UICollectionViewDelegateFlowLayout代理，其代理的优先级大于属性
//设置内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
//设置item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 210);
}

@end
