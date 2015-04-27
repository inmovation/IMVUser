//
//  UIImage+FixedOrientation.h
//  MobileExam
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  由于拍照后默认的图片方向未经过处理，在android和后台可能会方向错误，可以使用这个category矫正方向
 */
@interface UIImage (FixedOrientation)

- (UIImage *)imageWithFixedOrientation;

@end
