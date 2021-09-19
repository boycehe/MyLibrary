//
//  ViewController.m
//  TestCoobjc
//
//  Created by boyce on 2021/9/18.
//

#import "ViewController.h"
#import <coobjc/coobjc.h>

@interface ViewController ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,assign) coroutine_t *currentCoroutine;
@property (nonatomic,assign) coroutine_t *waitCoroutine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTestView];
    [self addLoopCoobjc];
    [self testCoobjc];
}

- (void)addTestView{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 100, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.text = [NSString stringWithFormat:@"%zd",self.number];
    label.backgroundColor = [UIColor redColor];
    self.label = label;
    [self.view addSubview:label];
    
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.currentCoroutine) {
            coroutine_resume(self.currentCoroutine);
        }
    }];
    
}

- (void)addNum{
    self.number ++;
    self.label.text = [NSString stringWithFormat:@"%zd",self.number];
}

- (void)addLoopCoobjc{
    co_launch(^{
        self.waitCoroutine = coroutine_self();
        NSLog(@"loop coobjc");
    });
}

- (void)testCoobjc{
    co_launch(^{
        self.currentCoroutine = coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"1");
        self.currentCoroutine =coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"2");
        self.currentCoroutine =coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"3");
        self.currentCoroutine =coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"4");
        self.currentCoroutine =coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"5");
        self.currentCoroutine =coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"6");
        self.currentCoroutine =coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"7");
        self.currentCoroutine =coroutine_self();
        coroutine_yield(self.currentCoroutine);
        NSLog(@"8");
        self.currentCoroutine = nil;
        
    });
    
}





@end
