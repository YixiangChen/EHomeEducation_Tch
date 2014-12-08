//
//  Defines.h
//  EHomeEducation_Tch
//
//  Created by Yixiang Chen on 12/1/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#ifndef EHomeEducation_Tch_Defines_h
#define EHomeEducation_Tch_Defines_h


// System Version
#define SYSTEM_VERSION [UIDevice currentDevice].systemVersion.floatValue

// url

#define kURLDomain                  @"http://218.249.130.194:8080/ehomeedu/"
#define kURLRegister                @"api/teacher/teacherregister.action"
#define kURLAddOtherInfos           @"api/teacher/teacherotherinfo.action"
#define kURLUploadTeacherIcon       @"api/teacher/teachericonupload.action"
#define kURLFindOrderList           @"api/teacher/findorderlist.action"
#define kURLFindOrderDetail         @"api/teacher/findorderdetail.action"
#define kURLConfirmOrder            @"api/teacher/confirmorder.action"
#define kURLCancelOrder             @"api/teacher/cancelorder.action"
#define kURLCompleteOrder           @"api/teacher/completeorder.action"
#define kURLFindCustomerDetail      @"api/teacher/findcustomerdetail.action"
#define kURLLogin                   @"api/teacher/teacherlogin.action"
#define kURLCommentCustomer         @"api/teacher/commentcustomer.action"
#define kURLFindCustomerComments    @"api/teacher/findcustomercomments.action"

#define kURLRegisterDevice          @"api/common/devicetokenregister.action"
#define kURLDeleteOrder             @"api/common/deleteorder.action"
// storyboard identifier


// segue identifier


// Fonts
#define kYueYuanFont                @"MF YueYuan (Noncommercial)"
#define kFangZhengKaTongFont        @"FZKATJW--GB1-0"
#define kMengNaFont                 @"MYoungHKS"

// colors
#define kLightGreenForMainColor    [UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:0.8]
#define kGreenForTabbaritem        [UIColor colorWithRed:160.0 / 256.0 green:233 / 256.0 blue:150 / 256.0 alpha:1]

// network
#define kConnectionSuccess          @"success"
#define kConnectionFailure          @"failure"


// Notifications
#define kRefreshHomeScreenNotification       @"net.plazz.exklusiv_muenchen.notification.refresh_home_screen"

// consts
#define kScaleFactorX                       768.0f / 320.0f
#define kScaleFactorY                       1024.0f / 568.0f

// font sizes home screen
#define kTypFontSize                        14.0f
#define kTitleFontSize                      20.0f
#define kEventDateNameFontSize              18.0f
#define kEventDayNumberFontSize             50.0f

// font sizes news overview
#define kDateFontSize                       14.0f
#define kNewstitleFontSize                  20.0f

// enums

#endif
