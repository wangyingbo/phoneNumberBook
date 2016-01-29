//
//  NormalThirdPartMacro.h
//  Kergou
//
//  Created by JiaPin on 15/9/1.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
//  此类为一些第三方配置的宏定义

#ifndef Kergou_NormalThirdPartMacro_h
#define Kergou_NormalThirdPartMacro_h

//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//


//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088201840807772"
//收款支付宝账号
#define SellerID  @"zhanghu@vipstore.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"v15tdfna9pht80dyhwlanrfapn51bxo4"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMi5oq+m3CZJflFpIhLjlsDCzVdUBPxO0c8IVV6BPi2wCaVUKCxdpZuHFKhobrcWzR+0skXwwD8NyFMLjn6xj9d5O4xyONAtW9YEmrg1cbQe7pjEYosQx8bg78R0WPyT2SF0g3UPyGxSHgmwABVDJK61+r1NAl1EouRyn1GChVBJAgMBAAECgYAjoRfol/TB8w+yAbhjo/RReQKb+rT72D3TwwXsRYK092du6lZLMcBAsCSRlB/67dgxRZDTa12kk5y4aPe9M2V1qHwgu4ao45IeOYBPRzEWEenGl9p7nY2r0VSiK5KPjoAJFJcIdJB5oIs5o4lEFTW5zHDPVGzueG2mBpX079FyEQJBAORK3eT8wlVj+v5GL1Qv5qUdqmsC9Th+GRMWcyIqD1NhVR3NJXx6jLM3YsYmHVwDHMQH0M97gEW1Hn6d55ElZr0CQQDhFj3uRiVXYoZf6AazhRIA8EdqwbkvsNYp6eCfNiRauwPNkOYm276Lc1tODGpTUZDXVHBkK3N9SWXS/xHVmB59AkEAkmagnjSpu3D+iQohV+/QDZtUqoOfFrdnBSKkewhWA7ariw0AOS+uA1BFe6T9twAX9m68rhIZVJquD6zbz+0YUQJAfuljke3LMDJFQd45qQ7mz9Cq8+6208UJfCh6lkqYxO+dfVKt8ksEbOxmFuO5L7FV0ZOyq0g0nfe8ifN3ws86oQJASuNYbRC/5MG30D1X00uvQapUI8d44XojjxwmTXvhO2JKUxCpLk4jfy3wJSnEB6/bbg23xxkzrXXaig3ffn+fxA=="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"



#endif
