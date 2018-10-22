//
//  JCCheckBox.h
//  JCCheckBox
//
//  Created by Juncheng Han on 10/22/18.
//  Copyright © 2018 Jason H. All rights reserved.
//
#ifndef _JCCHECKBOX_H
#define _JCCHECKBOX_H

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JCCheckBoxStyle) {
    JCCheckBoxStyleOval,
    JCCheckBoxStyleSquare
};

typedef void(^CheckedCompletion)(void);
typedef void(^UncheckedCompletion)(void);

@interface JCCheckBox : UIControl

+ (instancetype)checkBox;

@property (strong, nonatomic) UIColor *outerColor;
@property (strong, nonatomic) UIColor *innerColor;
@property (strong, nonatomic) UIColor *alartColor;
@property (assign, nonatomic) JCCheckBoxStyle checkBoxStyle;
@property (copy, nonatomic) CheckedCompletion checkedCompletion;
@property (copy, nonatomic) UncheckedCompletion uncheckedCompletion;

@property (assign, nonatomic, readonly) BOOL isChecked;


- (void)showAlert;

@end

NS_ASSUME_NONNULL_END

#endif
