//
//  JCViewController.m
//  JCCheckBox
//
//  Created by JasonHan1990 on 10/21/2018.
//  Copyright (c) 2018 JasonHan1990. All rights reserved.
//

#import "JCViewController.h"
#import "JCCheckBox.h"

@interface JCViewController ()
@property (weak, nonatomic) IBOutlet UIView *holderView_1;
@property (weak, nonatomic) IBOutlet UIView *holderView_2;

@property (strong, nonatomic) JCCheckBox *ovalCheckBox;
@property (strong, nonatomic) JCCheckBox *squareCheckBox;

@end

@implementation JCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // DEFAULT SIZE INIT
    self.ovalCheckBox = [JCCheckBox checkBox];
    // SET STYLE
    self.ovalCheckBox.checkBoxStyle = JCCheckBoxStyleOval; // square is the default
    // CHANGE COLOR
    // self.ovalCheckBox.innerColor = [UIColor greenColor];
    // self.ovalCheckBox.outerColor = [UIColor greenColor];
    // SET COMPLETION
    self.ovalCheckBox.checkedCompletion = ^{
        NSLog(@"Checked");
    };
    self.ovalCheckBox.uncheckedCompletion = ^{
        NSLog(@"Unchecked");
    };
    [self.holderView_1 addSubview:self.ovalCheckBox];
    
    
    self.squareCheckBox = [JCCheckBox checkBox];
    [self.holderView_2 addSubview:self.squareCheckBox];
}

- (IBAction)showAlert:(id)sender {
    [self.ovalCheckBox showAlert];
    [self.squareCheckBox showAlert];
}

@end
