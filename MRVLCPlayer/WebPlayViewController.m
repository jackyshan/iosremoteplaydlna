//
//  WebPlayViewController.m
//  MRVLCPlayer
//
//  Created by jackyshan on 2017/7/12.
//  Copyright © 2017年 Alloc. All rights reserved.
//

#import "WebPlayViewController.h"
#import "MRVLCPlayer.h"
#import "WebPlayTableViewCell.h"
#import "TableViewController.h"

@interface WebPlayViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UITextField *urlTf;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *urlArr;

@property (nonatomic, strong) UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;


@end

@implementation WebPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _urlTf = [[UITextField alloc] init];
    _urlTf.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"hostUrl"];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    if (_souceUrl != nil) {
        _urlTf.text = _souceUrl;
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlTf.text]];
    [_webView loadRequest:request];
    _webView.delegate = self;
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSettingAction)];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reload"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadWeb)];
    self.navigationItem.rightBarButtonItems = @[right1, right2];
    
    [self.navigationController.navigationBar setBackgroundImage:[self clipWhiteBgImage] forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)clipWhiteBgImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 64), NO, [UIScreen mainScreen].scale);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 64)];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *whiteImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return whiteImg;
}

- (void)clickSettingAction {
    TableViewController *vc = [[TableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _urlTf.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"hostUrl"];
}

- (void)reloadWeb {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlTf.text]];
    [_webView loadRequest:request];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _urlArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebPlayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebPlayTableViewCell"];
    if (cell == nil) {
        cell = [WebPlayTableViewCell view];
    }
    
//    cell.textLabel.text = [_urlArr[indexPath.row] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    cell.titleLb.text = [_urlArr[indexPath.row] stringByRemovingPercentEncoding];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *url = _urlArr[indexPath.row];
    if ([url hasSuffix:@"/"]) {
        WebPlayViewController *vc = [[WebPlayViewController alloc] init];
        vc.souceUrl = url;
        NSRange range = [url rangeOfString:@"\\w+/$" options:NSRegularExpressionSearch];
        NSString *stitle = [url substringWithRange:range];
        range = [stitle rangeOfString:@"^.+[^/]" options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            stitle = [stitle substringWithRange:range];
        }
        vc.title = [stitle stringByRemovingPercentEncoding];
        [self.navigationController pushViewController:vc animated:true];
    }
    else {
        MRVLCPlayer *player = [[MRVLCPlayer alloc] init];
        
        player.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        player.center = self.view.center;
        player.mediaURL = [NSURL URLWithString:url];
        
        [player showInView:self.view.window];
    }
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //这里是js，主要目的实现对url的获取
    static  NSString * const jsGetImages =
    @"function getUrls(){\
    var objs = document.getElementsByTagName(\"a\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].href + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getUrls()"];
    
    NSArray *urls = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    NSMutableArray *murls = [NSMutableArray array];
    for (NSString *url in urls) {
        if ([url hasSuffix:@"/"]) {
            if (![url isEqualToString:_souceUrl]) {
                [murls addObject:url];
            }
        }
        else if ([url hasSuffix:@".mp4"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".avi"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".mkv"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".3gp"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".rmvb"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".wmv"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".mpg"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".flv"]) {
            [murls addObject:url];
        }
        else if ([url hasSuffix:@".swf"]) {
            [murls addObject:url];
        }
    }
    _urlArr = murls;
    [_tableView reloadData];
    
    [_loadingActivity stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
