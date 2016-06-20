//
//  ViewController.m
//  05-UIImageViewDemo
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *fireView;
@property (nonatomic, strong) NSArray *images;                  //帧动画的图片
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

//懒加载images
-(NSArray *)images{
    if (_images == nil) {
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 1; i < 18; i++) {
            //取出图片名称
            NSString *imageName = [NSString stringWithFormat:@"campFire%02d.gif",i];
            //获取图片
            UIImage *image = [UIImage imageNamed:imageName];
            [imageArray addObject:image];
        }
        _images = imageArray;
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置imageView的帧动画
    _fireView.animationImages = self.images;
    //设置动画的时间
    _fireView.animationDuration = 0.1 * self.images.count;
    //设置动画是否重复
    _fireView.animationRepeatCount =1;
    //启动动画
    [_fireView startAnimating];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(snowFly) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}
//雪花飞舞
-(void)snowFly{
    //1、创建并添加雪花
    UIImage *image = [UIImage imageNamed:@"flake"];
    UIImageView *snow = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:snow];
    
    //2、设置雪花的位置和大小（随机）
    int screenW = [UIScreen mainScreen].bounds.size.width;
    int x1 = arc4random() % screenW;
    int y1 = -60;
    
    CGFloat scale = (arc4random()%100) / 100 + 1.0;
    snow.frame = CGRectMake(x1, y1, 50 * scale, 50 * scale);
    
    CGFloat duration = (arc4random()%100) / 100 + 1.0;
    //3、执行动画（飘落）（动画完成之后，要移除雪花）
    [UIView animateWithDuration:5 * duration animations:^{
        int x2 = arc4random() % screenW;
        snow.frame = CGRectMake(x2, CGRectGetHeight([UIScreen mainScreen].bounds) - 30 * duration, 30 * duration, 30 * duration);
    } completion:^(BOOL finished) {
        [snow removeFromSuperview];
    }];
    
}


-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
