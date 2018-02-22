
//
//  NewAddressViewController.m
//  Outsourcing
//
//  Created by 李文华 on 2017/8/21.
//  Copyright © 2017年 李文华. All rights reserved.
//

#import "NewAddressViewController.h"
#import "Masonry.h"

#import "EliveApplication.h"
#import "MBProgressHUDManager.h"


@interface NewAddressViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic ,strong)UITextField *rName;

@property(nonatomic ,strong)UITextField *rPhone;

@property(nonatomic ,strong)UITextField *rArea;

@property(nonatomic ,strong)UITextField *rDetailAddress;

@property(nonatomic ,strong)UIPickerView *areaPicker;

@property(nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation NewAddressViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 17);
    [btn setImage:[UIImage imageNamed:@"naviBack"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(foreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 35, 21);
    btn2.titleLabel.font = kFont(7);
    [btn2 setTitle:@"保存" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIColorFromRGBA(0xFA6650, 1.0) forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [self.navigationItem setRightBarButtonItem:rightItem];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xF7F7F7, 1.0);
    
    [self loadConfigUI];
    
    [self.view addSubview:self.areaPicker];
    // Do any additional setup after loading the view.
}

- (void)loadConfigUI{
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view1 addSubview:self.rName];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view2 addSubview:self.rPhone];
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view3 addSubview:self.rArea];
    
    UIImageView *moreImage = [UIImageView new];
    moreImage.image = [UIImage imageNamed:@"more"];
    [view3 addSubview:moreImage];
    
    UIView *view4 = [UIView new];
    view4.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
    [view4 addSubview:self.rDetailAddress];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(self.view).offset(@(kTopBarHeight + 10));
        
    }];
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(view1.mas_bottom).offset(10);
        
    }];
    
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(view2.mas_bottom).offset(10);
        
    }];
    
    [view4 makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        
        make.size.equalTo(CGSizeMake(kWidth, 30 *kScale));
        
        make.top.equalTo(view3.mas_bottom).offset(10);
        
    }];
    
    [self.rName makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view1);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view1).offset(15*kScale);
        
    }];
    
    [self.rPhone makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view2);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view2).offset(15*kScale);
        
    }];
    
    [self.rArea makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view3);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale - 10 *kScale, 30 * kScale));
        
        make.left.equalTo(view3).offset(15*kScale);
        
    }];
    
    [moreImage makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view3);
        
        make.size.equalTo(CGSizeMake(5*kScale, 10 * kScale));
        
        make.right.equalTo(view3).offset(-15*kScale);
        
        
    }];
    
    [self.rDetailAddress makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view4);
        
        make.size.equalTo(CGSizeMake(kWidth - 15*kScale, 30 * kScale));
        
        make.left.equalTo(view4).offset(15*kScale);
        
    }];

}

#pragma mark ------Setter && Getter

-(UITextField *)rName{
    
    if (!_rName) {
        
        _rName = [UITextField new];
        
        _rName.delegate = self;
        
        _rName.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _rName.font = kFont(7);
        NSString *str = @"";
        if (self.addressDict && [self.addressDict[@"strReceiptusername"] length] > 1) {
            
            str = self.addressDict[@"strReceiptusername"];
        }else{
            
            str = @"收货人姓名";
        }
        _rName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
    }
    return _rName;
}

-(UITextField *)rPhone{
    
    if (!_rPhone) {
        
        _rPhone = [UITextField new];
        
        _rPhone.delegate = self;
        
        _rPhone.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _rPhone.font = kFont(7);
        
        NSString *str = @"";
        if (self.addressDict && [self.addressDict[@"strReceiptmobile"] length] > 1) {
            
            str = self.addressDict[@"strReceiptmobile"];
        }else{
            
            str = @"收货人联系方式";
        }
        _rPhone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
    }
    return _rPhone;
}

-(UITextField *)rArea{
    
    if (!_rArea) {
        
        _rArea = [UITextField new];
        
        _rArea.delegate = self;
        
        _rArea.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _rArea.font = kFont(7);
        
        NSString *str = @"";
        if (self.addressDict && [self.addressDict[@"strLocation"] length] > 1) {
            
            str = self.addressDict[@"strLocation"];
        }else{
        
            str = @"收货区/县";
        }
        _rArea.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
    }
    return _rArea;
}

-(UITextField *)rDetailAddress{
    
    if (!_rDetailAddress) {
        
        _rDetailAddress = [UITextField new];
        
        _rDetailAddress.delegate = self;
        
        _rDetailAddress.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1.0);
        
        _rDetailAddress.font = kFont(7);
        
        NSString *str = @"";
        if (self.addressDict && [self.addressDict[@"strDetailaddress"] length] > 1) {
            
            str = self.addressDict[@"strDetailaddress"];
        }else{
            
            str = @"详细地址";
        }
        _rDetailAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(0x8F9095, 1.0)}];
    }
    return _rDetailAddress;
}

-(UIPickerView *)areaPicker{

    if (!_areaPicker) {
        
        _areaPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kHeight-kHeight/4, kWidth, kHeight/4)];
        
        _areaPicker.hidden = YES;
        
        _areaPicker.delegate = self;
        
        _areaPicker.dataSource = self;
        
    }

    return _areaPicker;
}

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark ----------Target

- (void)saveAddress{

    if (self.addressDict) {
        
        [self requestExchangeAddress];
    }else{
    
        [self requestAddNewAddress];
    }
}

- (void)areaEditChanged:(UITextField *)sender{

    NSLog(@"ddddddddd");
}


- (void)foreAction{
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark NetWorks

- (void)getUserArea{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;

    [OutsourceNetWork onHttpCode:kUserGetAddressAreaNetWork WithParameters:parameters];
    
}

- (void)requestAddNewAddress{
    
    BOOL pass = [self checkInput];
    
    if (pass) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        parameters[kCurrentController] = self;
        parameters[@"lUserid"] = [UserTools getUserId];
        parameters[@"strReceiptusername"] = self.rName.text;
        parameters[@"strReceiptmobile"] = self.rPhone.text;
        parameters[@"strLocation"] = self.rArea.text;
        parameters[@"strDetailaddress"] = self.rDetailAddress.text;
        
        [OutsourceNetWork onHttpCode:kUserAddNewAddressNetWork WithParameters:parameters];
 
    }
}

- (void)requestExchangeAddress{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[kCurrentController] = self;
    parameters[@"lId"] = self.addressDict[@"lId"];
    parameters[@"strReceiptusername"] = self.rName.text.length > 1 ? self.rName.text : nil;
    parameters[@"strReceiptmobile"] = self.rPhone.text.length > 1 ? self.rPhone.text : nil;
    parameters[@"strLocation"] = self.rArea.text.length > 1 ? self.rArea.text : nil;
    parameters[@"strDetailaddress"] = self.rDetailAddress.text.length > 1 ? self.rDetailAddress.text : nil;

    [OutsourceNetWork onHttpCode:kUserModificationTheAddressNetWork WithParameters:parameters];
    
}

- (void)getAddressArea:(id)responseObj{

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        self.dataSource = responseObj[@"result"];
        self.areaPicker.hidden = NO;
        [self.areaPicker reloadAllComponents];
    }
}

- (void)addNewAddressResult:(id)responseObj{
    
    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"地址添加成功" afterDelay:1.0f];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }

}

- (void)setupAddressResult:(id)responseObj{

    if ([responseObj[@"resCode"] isEqualToString:@"0"]) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:@"地址修改成功" afterDelay:1.0f];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
        [MBProgressHUDManager showTextHUDAddedTo:self.view WithText:responseObj[@"result"] afterDelay:1.0f];
    }

}



- (BOOL)checkInput{

    if (self.rName.text.length <= 0) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请填写收货人姓名" afterDelay:1.0f];
        
        return NO;
    }
    
    if (self.rPhone.text.length <= 0) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请填写收货人联系方式" afterDelay:1.0f];
        
        return NO;
    }
    
    if (self.rArea.text.length <= 0) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请填选择收货人区域" afterDelay:1.0f];
        
        return NO;
    }
    
    if (self.rDetailAddress.text.length <= 0) {
        
        [MBProgressHUDManager showTextHUDAddedTo:self.navigationController.view WithText:@"请填写具体收货地址" afterDelay:1.0f];
        
        return NO;
    }
    return YES;
}

#pragma mark ------UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    //返回一个BOOL值，指定是否循序文本字段开始编辑

    if (textField == self.rArea) {
        
        if (self.areaPicker.hidden == YES) {
            
            [self getUserArea];
            
        }else{
        
            self.areaPicker.hidden = YES;
        }

        [self.view endEditing:YES];
        return NO;
    }

    if (self.areaPicker.hidden == NO) {
        
        self.areaPicker.hidden = YES;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string
{
    //禁止输入空格
    if (textField != self.rDetailAddress && [string isEqual: @" "]) return NO;
    
    return YES;
}

#pragma mark ------UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    return self.dataSource.count;
}

// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return [self.dataSource objectAtIndex:row];
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    // 使用一个UIAlertView来显示用户选中的列表项
    
    self.rArea.text = [self.dataSource objectAtIndex:row];
    NSLog(@"%@",[self.dataSource objectAtIndex:row]);
    
}


@end
