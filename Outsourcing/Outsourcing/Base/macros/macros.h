

#ifndef macros_h
#define macros_h

#endif

#pragma mark - 打印日志

#ifdef DEBUG
    #define LMLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define LMLog(...)
#endif

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#pragma mark - 头文件
#import "UserTools.h"




#pragma mark - 系统UI尺寸

#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height
#define kScale [UIScreen mainScreen].scale
#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kTopBarHeight 64
#define kToolBarHeight 44
#define kTabBarHeight 49
#define kiPhone4_W 320
#define kiPhone4_H 480
#define kiPhone5_W 320
#define kiPhone5_H 568
#define kiPhone6_W 375
#define kiPhone6_H 667
#define kiPhone6P_W 414
#define kiPhone6P_H 736

#pragma mark - 颜色
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]

/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size * kScale]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size * kScale]


/****网络API****/

//#define URLHOST @"http://39.106.40.182/api/app"
#define URLHOST @"http://gk.fuzhents.com/api/app"


/***常用****/
#define NEEDLOGIN @"appneedtologin"
#define aliPaySuccess @"aliPaySuccessCallBack"
#define wechatPaySuccess @"wechatPaySuccessCallBack"
#define wechatShare @"wechatShareCallBack"
#define DownloadSuccess @"downloadsuccess"
#define WIFIDOWNLOAD @"wifi_download"
#define WIFIWATCH @"wifi_see"



#define  kCurrentController                             @"viewController"
#define  OutsourceNetWork                               [EliveApplication shareStance]
//下载列表文件
#define DWDownloadingItemPlistFilename @"downloadingItems.plist"
#define DWDownloadFinishItemPlistFilename @"downloadFinishItems.plist"
//
#import "AppDelegate.h"
#define CCDownloadItems                                [CCDownloadItem sharedInstance]
#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

#define kGetImageUrl(urlhost,imageId,productionId) [NSURL URLWithString:[NSString stringWithFormat:@"%@/common/getImg/%@/%@",urlhost,imageId,productionId]]


//  检查更新
#define kAPPCheckVersion                                9999
//  登出
#define kUserLogoutNetWork                              1000
//  登录
#define kUserLoginNetWork                               1001
//  注册
#define kUserRegisterNetWork                            1002
//  发送验证码
#define kUserSendCodeNetWork                            1003


//  获取用户信息
#define kUserGetInfoNetWork                             2000
//  修改用户信息
#define kUserUpdatePassWorkNetWork                      2001
//  获取用户地址列表
#define kUserAddressNetWork                             2002
//  添加收货地址
#define kUserAddNewAddressNetWork                       2003
//  设置默认收货地址
#define kUserSetDefaultAddressNetWork                   2007
//  删除一条收货地址
#define kUserDeleteTheAddressNetWork                    2008
//  修改一条收货地址
#define kUserModificationTheAddressNetWork              2009
//  获取收货区域
#define kUserGetAddressAreaNetWork                      2004
//  获取用户优惠券信息
#define kUserGetCouponsNetWork                          2005
//  获取用户水票信息
#define kUserGetTicketListNetWork                       2006
//  获取用户通知信息
#define kUserGetMessageNetWork                          2010
//  获取用户桶个数
#define kUserGetBucketNetWork                           2011
//  退桶
#define kUserRefundBucketNetWork                        2012



//  获取轮播图信息
#define kHomePageCirclesNetWork                         3000
//  获取首页产品列表
#define kHomePageProductionListNetWork                  3001
//  获取产品详情页面数据
#define kProductionDetailNetWork                        3002
//  获取水票列表
#define kProductionTicketListNetWork                    3003
//  获取水票详情
#define kProductionTicketDetailNetWork                  3004
//  购买水票
#define kProductionTicketPayNetWork                     3005


//  提交订单
#define kSubmitOrderNetWork                             4000
//  订单详情(去结算页面)
#define kOrderDetailNetWork                             4001
//  去结算
#define kOrderClearingNetWork                           4002
//  订单详情(去付款页面)
#define kOrderDetailTwoNetWork                          4003
//  添加购物车
#define kAddShopCartNetWork                             4004
//  订单列表
#define kUserOrderListNetWork                           4005
//  获取OrderString
#define kAliPayNetWork                                  4006
//  订单列表
#define kWechatPayNetWork                               4007
//  全部使用水票支付
#define kTicketallPayNetWork                            4008
//  删除订单
#define kDeleteOrderNetWork                             4009
//  订单立即配送
#define kJustSendNetWork                                4010


//  获取购物车列表
#define kUserGetChartListNetWork                        5000
//  从购物车删除商品
#define kUserDeleteFromChartNetWork                     5001



//  更多内容
#define kSettingGetMoreNetWork                          6000
//  用户反馈
#define kUserFeedbackNetWork                            6001


