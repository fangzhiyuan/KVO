//
//  ViewController.m
//  KVO
//
//  Created by 威盛电气 on 16/8/16.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "ViewController.h"


typedef enum {
    ComeOngrayColor = 0,
    ComeOnblueColor = 1,
    ComeOnorangeColor= 2
}cyhEnum;



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSString *changeValue;
@property(nonatomic,strong)UITextField *KVO_Tf;
@property(nonatomic,strong)UIButton *KVO_Bt;
@property (nonatomic , strong)ViewController * myKVO;
@end

@implementation ViewController
{
    NSTimer *timer;
    cyhEnum colorstate;
    NSString *kvoStart;
    NSString *kvoValue;
    NSString *kvoStop;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableview];
    
    [self KVO_example];
    
    self.KVO_Tf = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 50.0f, (self.view.frame.size.width - 20), 30.0f)];
    [self.KVO_Tf setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    
    self.KVO_Tf.placeholder = @"password"; //默认显示的字
    
//    self.KVO_Tf.secureTextEntry = YES; //密码
    
    self.KVO_Tf.autocorrectionType = UITextAutocorrectionTypeNo;
    self.KVO_Tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.KVO_Tf.returnKeyType = UIReturnKeyDone;
    self.KVO_Tf.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    
    self.KVO_Tf.delegate = self;
    [self.view addSubview:self.KVO_Tf];
    
    
    self.KVO_Bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.KVO_Bt setTitle:@"KVO" forState:UIControlStateNormal];
    self.KVO_Bt.frame = CGRectMake(100, 120, 100, 30);
    [self.view addSubview:self.KVO_Bt];
    
}

-(void)KVO_example
{
    self.myKVO = [ViewController new];
    [self.myKVO addObserver:self forKeyPath:@"kvoStart" options:NSKeyValueObservingOptionNew context:nil];
    [self.myKVO addObserver:self forKeyPath:@"kvoValue" options:NSKeyValueObservingOptionNew context:nil];
    [self.myKVO addObserver:self forKeyPath:@"kvoStop" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (object == self.myKVO) {
        
        if ([keyPath isEqualToString:@"kvoStart"]) {
            
            self.changeValue = @"是的,KVO开始了";
            [self ENUM_colorchange:ComeOngrayColor];
            [self.tableView reloadData];
        }
        if ([keyPath isEqualToString:@"kvoValue"]) {
            
            self.changeValue = @"是的,KVO监听值得改变，所以要改变";
            [self ENUM_colorchange:ComeOnblueColor];
            [self.tableView reloadData];
        }
        if ([keyPath isEqualToString:@"kvoStop"]) {
            
            self.changeValue = @"是的,KVO监听到要停止";
            [self ENUM_colorchange:ComeOnorangeColor];
            [self.tableView reloadData];
        }
        
    }
    

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.KVO_Tf resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.KVO_Tf.text isEqualToString:@"1"]) {
        [self.myKVO  setValue:nil forKey:@"kvoStart"];
    }
    else if([self.KVO_Tf.text isEqualToString:@"2"])
    {
        [self.myKVO  setValue:nil forKey:@"kvoValue"];
    }
    else if ([self.KVO_Tf.text isEqualToString:@"3"])
    {
        [self.myKVO  setValue:nil forKey:@"kvoStop"];
    }

}


- (void)ENUM_colorchange:(cyhEnum)colorstatus
{
    switch (colorstatus) {
        case ComeOngrayColor:
        {
            self.tableView.backgroundColor = [UIColor grayColor];
        }
            break;
        case ComeOnblueColor:
        {
            self.tableView.backgroundColor = [UIColor blueColor];
        }
            break;
        case ComeOnorangeColor:
        {
            self.tableView.backgroundColor = [UIColor orangeColor];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark 下面是tableview的注册，过，pass

- (void)createTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 200) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.changeValue;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
















































