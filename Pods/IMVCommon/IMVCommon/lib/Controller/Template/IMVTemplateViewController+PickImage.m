//
//  IMVTemplateViewController+PickImage.m
//  MobileExam
//
//  Created by 陈少华 on 15/4/2.
//  Copyright (c) 2015年 inmovation. All rights reserved.
//

#import "IMVTemplateViewController+PickImage.h"
#import "UIImage+FixedOrientation.h"

#define IMImagePickerActionsheetTag 2310

@interface IMVTemplateViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@end

@implementation IMVTemplateViewController (PickImage)

- (void)pickedImageWithData:(NSData *)imgData
{
    
}

- (void)pickImageAndAllowsEditing:(BOOL)editing
{
    UIActionSheet *choosePhotoActionSheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    } else {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:@"取消"
                                                             delegate:self
                                                    cancelButtonTitle:@"从手机相册选择"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
    }
    choosePhotoActionSheet.tag = IMImagePickerActionsheetTag;
    if (editing) {
        choosePhotoActionSheet.tag = IMImagePickerActionsheetTag + 1;
    }
    
    [choosePhotoActionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)pickImageWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditting:(BOOL)allowEditing
{
    if (sourceType == UIImagePickerControllerSourceTypeCamera && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert", @"") message:NSLocalizedString(@"alertNotSupportCamera", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"alertSubmit", @"") otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = allowEditing;
    imagePickerController.sourceType = sourceType;
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == IMImagePickerActionsheetTag || actionSheet.tag == IMImagePickerActionsheetTag+1) {
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        } else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        [self pickImageWithSourceType:sourceType allowsEditting:actionSheet.tag-IMImagePickerActionsheetTag];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }];
    UIImage *fixOrientationImage;
    NSData *imgData = [[NSData alloc] init];
    if (picker.allowsEditing) {
        fixOrientationImage = [[info objectForKey:UIImagePickerControllerEditedImage] imageWithFixedOrientation];
        imgData = UIImageJPEGRepresentation(fixOrientationImage, 1.0);
    }
    else
    {
        fixOrientationImage = [[info objectForKey:UIImagePickerControllerOriginalImage] imageWithFixedOrientation];
        imgData = UIImageJPEGRepresentation(fixOrientationImage, 0.5);
    }
    [self pickedImageWithData:imgData];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
