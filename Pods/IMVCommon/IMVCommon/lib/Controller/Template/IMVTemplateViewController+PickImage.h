//
//  IMVTemplateViewController+PickImage.h
//  MobileExam
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVTemplateViewController.h"

@interface IMVTemplateViewController (PickImage)

/**
 *  从底部弹出actionController让用户选择是拍照还是照片
 *
 *  @param editing 是否可编辑，一般情况设置NO，选择头像时可以设置为YES
 */
- (void)pickImageAndAllowsEditing:(BOOL)editing;

/**
 *  获取图片
 *
 *  @param sourceType   获取图片方式
 *  @param allowEditing 是否可编辑
 */
- (void)pickImageWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditting:(BOOL)allowEditing;

/**
 *  当获取完图片后会调用该方法，可以在子类中重写该方法
 *
 *  @param imgData 图片数据
 */
- (void)pickedImageWithData:(NSData *)imgData;

@end
