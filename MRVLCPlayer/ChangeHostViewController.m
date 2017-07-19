//
//  ChangeHostViewController.m
//  MRVLCPlayer
//
//  Created by jackyshan on 2017/7/13.
//  Copyright © 2017年 Alloc. All rights reserved.
//

#import "ChangeHostViewController.h"

@interface ChangeHostViewController ()

@property (weak, nonatomic) IBOutlet UITextField *hostTf;

@end

@implementation ChangeHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改host";
    // Do any additional setup after loading the view from its nib.
    _hostTf.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"hostUrl"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickSettingAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:_hostTf.text forKey:@"hostUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
