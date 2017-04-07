//
//  ViewController.m
//  TopImageBigger+EffectView
//
//  Created by 王夏军 on 2017/4/6.
//  Copyright © 2017年 CY. All rights reserved.
//


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height



#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;



@property(nonatomic,strong)UIImageView *topImageView;


@property(nonatomic,strong)UIVisualEffectView *effectView;

@end


static CGFloat const IMAGEVIEW_HEIGHT = 200;

static NSString *const kCellID = @"ID";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self makeUI];
}

- (void)makeUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // 显示照片
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGEVIEW_HEIGHT, 0, 0, 0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    [self.view addSubview:self.tableView];
    
    
    self.topImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, -IMAGEVIEW_HEIGHT, kScreenWidth, IMAGEVIEW_HEIGHT))];
    _topImageView.image = [UIImage imageNamed:@"小黄人2.jpeg"];
    
    
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topImageView.clipsToBounds = YES;
    
    
    [self.tableView addSubview:self.topImageView];
    
    
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = _topImageView.frame;
    _effectView = effectView;
    [self.tableView addSubview:_effectView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld++++%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY------>%f",offsetY);
    
    // 下拉超过照片的高度的时候
    
    if (offsetY < - IMAGEVIEW_HEIGHT)
    {
        CGRect frame = self.topImageView.frame;
        
        self.topImageView.frame = CGRectMake(0, offsetY, frame.size.width, -offsetY);
        
        self.effectView.frame = self.topImageView.frame;
        
        self.effectView.alpha = 1 + (offsetY + IMAGEVIEW_HEIGHT) / IMAGEVIEW_HEIGHT;
        
        
        NSLog(@"alpha----->%f",self.effectView.alpha);
    }
}

@end
