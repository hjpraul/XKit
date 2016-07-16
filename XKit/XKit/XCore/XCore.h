//
//  Core.h
//  XKit
//
//  Created by hjpraul on 16/4/29.
//  Copyright © 2016年 hjpraul. All rights reserved.
//

#ifndef Core_h
#define Core_h

#import "XUtil.h"
// Http
#import "NSError+XHTTP.h"
#import "NSObject+XHTTP.h"
#import "NSMutableDictionary+XHTTP.h"

// Category
#import "NSDate+XComponent.h"
#import "NSDate+XFormat.h"
#import "NSObject+XJSON.h"
#import "NSNull+XSafe.h"
#import "NSString+XFormat.h"
#import "NSString+XVerify.h"
#import "NSString+XCoder.h"
#import "NSArray+XFilter.h"
#import "UIImage+XCreate.h"
#import "UIImage+XEdit.h"
#import "UIView+XBlank.h"
#import "UIView+XEdit.h"
#import "UIView+XPositioning.h"
#import "UIView+XSize.h"

// loading && toast
#import "UIViewController+XLoading.h"
#import "NSString+XToast.h"

// common widget
#import "XCommonLine.h"

// Other
#import "XDBManager.h"
#import "XRefreshTableView.h"
#import "XRefreshCollectionView.h"


#undef	RGB
#define RGB(R,G,B)          [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#undef	RGBA
#define RGBA(R,G,B,A)       [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#endif /* Core_h */
