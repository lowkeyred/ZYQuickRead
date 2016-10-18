//
//  ViewController.m
//  ZYQuickRead
//
//  Created by 凡城软件 on 16/10/18.
//  Copyright © 2016年 lizhongyuan. All rights reserved.
//

#import "ViewController.h"
#import "ZYQuickRead.h"
//屏幕
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //二维码生成 实质:  把字符串转变为 图片
    // 需要 coreImage框架, 已经包含在了 UIKit框架里面
    [self createScanImage];
    
    //    [self logoQrCode];
}
-(void)createScanImage
{
    [UIImage imageNamed:@"123"];
    /*
     wergfwegerhuyedfgqwe4y任务的风很大个我去二楼后家违法和齐活通气会其和我熊千华网好配该金额为给我去网吧高考记事本计算器报个价吧奥斯卡的蒙古包看两千万不敢看； 好是；我去万科噶啥豆腐接口和求稳的发；情况忘记了回复；请问；了开发了客家话的弗兰克全家福客户群我尽快分类控件还是；浪费可见其；五加咖啡；拉客积分其和我；六块腹肌签发去乌克兰放假；垃圾我；垃圾睡房；李克强降温费啤酒
     */
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[ZYQuickRead creatScanImageWithScanStr:@"这是一个测试用的二维码" andScanImage:[UIImage imageNamed:@"Snip20160715_4"]]];
    imageView.frame = CGRectMake(8, 50, WIDTH-8-8, WIDTH-8-8);
    imageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:imageView];
    //    [ZYScanCode creatScanImageWithScanStr:@"这是一个测试代码" andScanImage:[UIImage imageNamed:@"123"]];
}
//MARK: 二维码中间内置图片,可以是公司logo
-(void)logoQrCode{
    
    //
    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@",filters);
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    //    字符串可以随意换成网址等
    NSData *qrImageData = [@"哈哈哈哈哈" dataUsingEncoding:NSUTF8StringEncoding];
    
    //我们可以打印,看过滤器的 输入属性.这样我们才知道给谁赋值
    NSLog(@"%@",qrImageFilter.inputKeys);
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(13, 13)];
    
    //转成 UI的 类型
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    
    //----------------给 二维码 中间增加一个 自定义图片----------------
    //开启绘图,获取图形上下文  (上下文的大小,就是二维码的大小)
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    
    
    
    //再把小图片画上去
    UIImage *sImage = [UIImage imageNamed:@"123"];
    
    
    
    
    
    CGFloat sImageW = 100;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //设置图片
    self.imageView.image = finalyImage;
}

-(UIImageView *)imageView{
    if(_imageView == nil){
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 50, WIDTH-8-8, WIDTH-8-8)];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
