//
//  ZYQuickRead.h
//  ZYQuickRead
//
//  Created by 凡城软件 on 16/10/18.
//  Copyright © 2016年 lizhongyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYQuickRead : NSObject
@property (nonatomic, strong) UIImage * scanImage;
@property (nonatomic, copy) NSString * scanStr;


+(UIImage *)creatScanImageWithScanStr:(NSString *)scanStr andScanImage:(UIImage *)scanImage;


@end
