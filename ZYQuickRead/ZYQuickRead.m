//
//  ZYQuickRead.m
//  ZYQuickRead
//
//  Created by 凡城软件 on 16/10/18.
//  Copyright © 2016年 lizhongyuan. All rights reserved.
//

#import "ZYQuickRead.h"

@implementation ZYQuickRead
+(UIImage *)creatScanImageWithScanStr:(NSString *)scanStr andScanImage:(UIImage *)scanImage
{
    //
    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@",filters);
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    //    字符串可以随意换成网址等
    NSData *qrImageData = [scanStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //我们可以打印,看过滤器的 输入属性.这样我们才知道给谁赋值
    NSLog(@"%@",qrImageFilter.inputKeys);
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(16, 16)];
    
    //转成 UI的 类型
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    
    //----------------给 二维码 中间增加一个 自定义图片----------------
    //开启绘图,获取图形上下文  (上下文的大小,就是二维码的大小)
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    //    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height) blendMode:kCGBlendModePlusDarker alpha:0.5];
    //kCGBlendModeClear
    
    //关闭图形上下文
    //    UIGraphicsEndImageContext();
    //再把小图片画上去
    UIImage *sImage = scanImage;//[UIImage imageNamed:@"123"];
    
    
    CGFloat sImageW = 100;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    
    
    
    //    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect=CGRectMake(sImageX, sImgaeY, sImageW, sImageH);
    CGContextAddEllipseInRect(ctx, rect);
    //设置属性
    [[UIColor purpleColor]set];
    //加图片
    //绘制
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
    //    UIImageView * smallImage = [[UIImageView alloc]initWithImage:sImage];
    //    smallImage.frame = CGRectMake(sImageX, sImgaeY, sImageW, sImageH);
    //设置圆角
    //    smallImage.layer.cornerRadius = smallImage.frame.size.width / 2;
    //将多余的部分切掉ß®
    //    smallImage.layer.masksToBounds = YES;
    //    [smallImage drawRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    
    
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return finalyImage;
}
#pragma mark 绘制椭圆
-(void)drawEllipse:(CGContextRef)context{
    //添加对象,绘制椭圆（圆形）的过程也是先创建一个矩形
    CGRect rect=CGRectMake(50, 50, 200.0, 200.0);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    [[UIColor purpleColor]set];
    //绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
