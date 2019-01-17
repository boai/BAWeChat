//
//  BAPrivacyManager.m
//  BAKit
//
//  Created by boai on 2017/9/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAPrivacyManager.h"
#import "BAKit_ConfigurationDefine.h"

@interface BAPrivacyManager ()
<
    CLLocationManagerDelegate,
    CBCentralManagerDelegate,
    HMHomeManagerDelegate,
    UINavigationControllerDelegate
>

/**
 定位
 */
@property (nonatomic, strong) CLLocationManager         *locationManager;

/**
 蓝牙
 */
@property (nonatomic, strong) CBCentralManager          *cMgr;

/**
 健康
 */
@property (nonatomic, strong) HKHealthStore             *healthStore;

/**
 home
 */
@property (nonatomic, strong) HMHomeManager             *homeManager;

/**
 运动
 */
@property (nonatomic, strong) CMMotionActivityManager   *cmManager;

@property (nonatomic, strong) NSOperationQueue          *motionActivityQueue;

@property (nonatomic,copy) void (^BAKit_CLCallBackBlock)(CLAuthorizationStatus state);
@property (nonatomic,copy) void (^BAKit_CBManagerStateCallBackBlock)(CBManagerState state);
@property (nonatomic,copy) void (^BAKit_HomeAccessCallBackBlock)(BOOL isHaveAccess);

@end

@implementation BAPrivacyManager
BAKit_SingletonM(BAPrivacyManager)

#pragma mark - checkAndRequestAccessForType
- (void)ba_authorizationManagerCheckAccessForType:(BAKit_PrivacyType)type
                         block:(BAKit_PrivacyResultBlock)block
{
    switch (type) {
        case BAKit_PrivacyType_LocationServices:
        {
            NSLog(@"此方法暂时不适用 定位监测，请使用 【ba_checkAndRequestPrivacyOfLocationServicesWithBlock】方法监测");
        }
            break;
        case BAKit_PrivacyType_Contacts:
        {
            [self ba_checkAndRequestPrivacyOfContactsWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_Calendars:
        {
            [self ba_checkAndRequestPrivacyOfCalendarsWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_Reminders:
        {
            [self ba_checkAndRequestPrivacyOfRemindersWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_Photos:
        {
            [self ba_checkAndRequestPrivacyOfPhotosWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_BluetoothSharing:
        {
            NSLog(@"此方法暂时不适用 蓝牙监测，请使用 【ba_checkAndRequestPrivacyOfBluetoothSharingWithBlock】方法监测");
        }
            break;
        case BAKit_PrivacyType_Microphone:
        {
            [self ba_checkAndRequestPrivacyOfMicrophoneWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_SpeechRecognition:
        {
            [self ba_checkAndRequestPrivacyOfSpeechRecognitionWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_Camera:
        {
            [self ba_checkAndRequestPrivacyOfCameraWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_Health:
        {
            [self ba_checkAndRequestPrivacyOfHealthWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_HomeKit:
        {
            NSLog(@"此方法暂时不适用 健康监测，请使用 【ba_checkAndRequestPrivacyOfHome】方法监测");
        }
            break;
        case BAKit_PrivacyType_MediaAndAppleMusic:
        {
            [self ba_checkAndRequestPrivacyOfAppleMusicWithBlock:block];
        }
            break;
        case BAKit_PrivacyType_MotionAndFitness:
        {
            [self ba_checkAndRequestPrivacyOfMotionAndFitness];
        }
            break;
        case BAKit_PrivacyType_None:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Contacts
- (void)ba_checkAndRequestPrivacyOfContactsWithBlock:(BAKit_PrivacyResultBlock)block
{
    if (BAKit_isIOS9_Or_Later)
    {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        
        switch (status) {
            case CNAuthorizationStatusNotDetermined:
                {
                    CNContactStore *contactStore = [[CNContactStore alloc] init];
                    if (contactStore == NULL)
                    {
                        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Contacts];
                    }
                    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        
                        if (error) {
                            NSLog(@"error:%@",error);
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Contacts];
                        }else{
                            if (granted) {
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Contacts];
                            }else{
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Contacts];
                            }
                        }
                    }];
                }
                break;
            case CNAuthorizationStatusRestricted:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Contacts];
            }
                break;
            case CNAuthorizationStatusDenied:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Contacts];
            }
                break;
            case CNAuthorizationStatusAuthorized:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Contacts];
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined:
            {
                __block ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
                if (addressBookRef == NULL)
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Contacts];
                }
                
                ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                    if (granted)
                    {
                        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Contacts];
                    }
                    else
                    {
                        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Contacts];
                    }
                    if (addressBookRef)
                    {
                        CFRelease(addressBookRef);
                        addressBookRef = NULL;
                    }
                });
            }
                break;
            case kABAuthorizationStatusRestricted:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Contacts];
            }
                break;
            case kABAuthorizationStatusDenied:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Contacts];
            }
                break;
            case kABAuthorizationStatusAuthorized:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Contacts];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Calendars
- (void)ba_checkAndRequestPrivacyOfCalendarsWithBlock:(BAKit_PrivacyResultBlock)block
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];

    switch (status) {
        case EKAuthorizationStatusNotDetermined:
            {
                EKEventStore *store = [[EKEventStore alloc] init];
                if (store == NULL)
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Calendars];
                }
                else
                {
                    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                        if (error)
                        {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Calendars];
                            NSLog(@"erro:%@",error);
                        }
                        if (granted)
                        {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Calendars];
                        }
                        else
                        {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Calendars];
                        }
                    }];
                }
            }
            break;
        case EKAuthorizationStatusRestricted:
        {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Calendars];
        }
            break;
        case EKAuthorizationStatusDenied:
        {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Calendars];
        }
            break;
        case EKAuthorizationStatusAuthorized:
        {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Calendars];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Reminders
- (void)ba_checkAndRequestPrivacyOfRemindersWithBlock:(BAKit_PrivacyResultBlock)block
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    if (status == EKAuthorizationStatusNotDetermined) {
        EKEventStore *store = [[EKEventStore alloc] init];
        if (store == NULL) {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Reminders];
            
        }else{
            [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Reminders];
                    
                    NSLog(@"erro:%@",error);
                }
                if (granted) {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Reminders];
                    
                }else{
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Reminders];
                }
            }];
        }
        
    } else if (status == EKAuthorizationStatusRestricted) {
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Reminders];
        
    } else if (status == EKAuthorizationStatusDenied) {
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Reminders];
        
    } else {
        // EKAuthorizationStatusAuthorized
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Reminders];
    }
}

#pragma mark - Photos
- (void)ba_checkAndRequestPrivacyOfPhotosWithBlock:(BAKit_PrivacyResultBlock)block
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        if (BAKit_isIOS8_Or_Later)
        {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];

            switch (status) {
                case PHAuthorizationStatusNotDetermined:
                {
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                        if (status == PHAuthorizationStatusNotDetermined) {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotDetermined privacyType:BAKit_PrivacyType_Photos];
                            
                        } else if (status == PHAuthorizationStatusRestricted) {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Photos];
                            
                        } else if (status == PHAuthorizationStatusDenied) {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Photos];
                            
                        } else {
                            // PHAuthorizationStatusAuthorized
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Photos];
                        }
                    }];
                }
                    break;
                case PHAuthorizationStatusRestricted:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Photos];
                }
                    break;
                case PHAuthorizationStatusDenied:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Photos];
                }
                    break;
                case PHAuthorizationStatusAuthorized:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Photos];
                }
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            // iOS7 - iOS8
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];

            switch (status) {
                case ALAuthorizationStatusNotDetermined:
                {
                    // 当某些情况下，ALAuthorizationStatus 为 ALAuthorizationStatusNotDetermined的时候，无法弹出系统首次使用的收取alertView，系统设置中也没有相册的设置，此时将无法使用，所以做以下操作，弹出系统首次使用的授权alertView
                    __block BOOL isShow = YES;
                    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
                    [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                        if (isShow) {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Photos];
                            isShow = NO;
                        }
                    } failureBlock:^(NSError *error) {
                        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Photos];
                    }];
                }
                    break;
                case ALAuthorizationStatusRestricted:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Photos];
                }
                    break;
                case ALAuthorizationStatusDenied:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Photos];
                }
                    break;
                case ALAuthorizationStatusAuthorized:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Photos];
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    else
    {
        NSLog(@"相册不可用！");
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Photos];
    }
}

#pragma mark - BluetoothSharing
- (void)ba_checkAndRequestPrivacyOfBluetoothSharingWithBlock:(BAKit_PrivacyOfBluetoothResultBlock)block
{
    self.cMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    BAKit_WeakSelf
    
    
    if (@available(iOS 10.0, *)) {
        [self setBAKit_CBManagerStateCallBackBlock:^(CBManagerState status){
            BAKit_StrongSelf
            
            switch (status) {
                case CBManagerStateResetting:
                {
                    [self ba_executeBluetoothSharingWithBlock:block CBManagerStatus:BAKit_CBManagerStatus_Resetting privacyType:BAKit_PrivacyType_BluetoothSharing];
                }
                    break;
                case CBManagerStateUnsupported:
                {
                    [self ba_executeBluetoothSharingWithBlock:block CBManagerStatus:BAKit_CBManagerStatus_Unsupported privacyType:BAKit_PrivacyType_BluetoothSharing];
                }
                    break;
                case CBManagerStateUnauthorized:
                {
                    [self ba_executeBluetoothSharingWithBlock:block CBManagerStatus:BAKit_CBManagerStatus_Unauthorized privacyType:BAKit_PrivacyType_BluetoothSharing];
                }
                    break;
                case CBManagerStatePoweredOff:
                {
                    [self ba_executeBluetoothSharingWithBlock:block CBManagerStatus:BAKit_CBManagerStatus_PoweredOff privacyType:BAKit_PrivacyType_BluetoothSharing];
                }
                    break;
                case CBManagerStatePoweredOn:
                {
                    [self ba_executeBluetoothSharingWithBlock:block CBManagerStatus:BAKit_CBManagerStatus_PoweredOn privacyType:BAKit_PrivacyType_BluetoothSharing];
                }
                    break;
                case CBManagerStateUnknown:
                {
                    [self ba_executeBluetoothSharingWithBlock:block CBManagerStatus:BAKit_CBManagerStatus_Unknown privacyType:BAKit_PrivacyType_BluetoothSharing];
                }
                    break;
                    
                default:
                    break;
            }
            
        }];
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (self.BAKit_CBManagerStateCallBackBlock)
    {
        self.BAKit_CBManagerStateCallBackBlock(central.state);
    }
}

#pragma mark - Microphone
- (void)ba_checkAndRequestPrivacyOfMicrophoneWithBlock:(BAKit_PrivacyResultBlock)block
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    BAKit_WeakSelf
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
        {
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                BAKit_StrongSelf
                if (granted)
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Microphone];
                }
                else
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Microphone];
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Microphone];
        }
            break;
        case AVAuthorizationStatusDenied:
        {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Microphone];
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Microphone];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - SpeechRecognition
- (void)ba_checkAndRequestPrivacyOfSpeechRecognitionWithBlock:(BAKit_PrivacyResultBlock)block
{
    if (BAKit_isIOS10_Or_Later)
    {
        if (@available(iOS 10.0, *)) {
            SFSpeechRecognizerAuthorizationStatus status = [SFSpeechRecognizer authorizationStatus];
            
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                {
                    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                        
                        if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotDetermined privacyType:BAKit_PrivacyType_SpeechRecognition];
                            
                        } else if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_SpeechRecognition];
                            
                        } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_SpeechRecognition];
                            
                        } else {
                            // SFSpeechRecognizerAuthorizationStatusAuthorized
                            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_SpeechRecognition];
                        }
                    }];
                }
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_SpeechRecognition];
                }
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_SpeechRecognition];
                }
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_SpeechRecognition];
                }
                    break;
                    
                default:
                    break;
            }
        } else {
            // Fallback on earlier versions
        }
    }
    else
    {
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_SpeechRecognition];
    }
}

#pragma mark - Camera
- (void)ba_checkAndRequestPrivacyOfCameraWithBlock:(BAKit_PrivacyResultBlock)block
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

        switch (status) {
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted)
                    {
                        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Camera];
                    }
                    else
                    {
                        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Camera];
                    }
                }];
            }
                break;
            case AVAuthorizationStatusRestricted:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_Camera];
            }
                break;
            case AVAuthorizationStatusDenied:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Camera];
            }
                break;
            case AVAuthorizationStatusAuthorized:
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Camera];
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Camera];
    }
}

#pragma mark - Health
- (void)ba_checkAndRequestPrivacyOfHealthWithBlock:(BAKit_PrivacyResultBlock)block
{
    if (BAKit_isIOS8_Or_Later)
    {
        if ([HKHealthStore isHealthDataAvailable])
        {
            if (!self.healthStore)
            {
                self.healthStore = [[HKHealthStore alloc] init];
            }
            
            // 以心率 HKQuantityTypeIdentifierHeartRate 为例子
            HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
            HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:heartRateType];

            switch (status) {
                case HKAuthorizationStatusNotDetermined:
                {
                    NSSet *typeSet = [NSSet setWithObject:heartRateType];
                    
                    [self.healthStore requestAuthorizationToShareTypes:typeSet readTypes:typeSet completion:^(BOOL success, NSError * _Nullable error) {
                        
                        // tips：这个block不止在用户点击允许或者不允许的时候响应，在弹出访问健康数据允许窗口后，只要界面发生变化（以及程序进入后台），都会响应该block。
                        // sucess 为YES代表用户响应了该界面，允许或者拒绝
                        if (success)
                        {
                            // 由于用户已经响该界面（不管是允许或者拒绝）
                            // 并且这时候应该只会有两种状态：HKAuthorizationStatusSharingAuthorized 或者 HKAuthorizationStatusSharingDenied
                            HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:heartRateType];
                            if (status == HKAuthorizationStatusNotDetermined)
                            {
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotDetermined privacyType:BAKit_PrivacyType_Health];
                            }
                            else if (status == HKAuthorizationStatusSharingAuthorized)
                            {
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Health];
                            }
                            else
                            {
                                // HKAuthorizationStatusSharingDenied
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Health];
                            }
                        }
                        else
                        {
                            if (error)
                            {
                                NSLog(@"requestHealthAuthorization: error:%@",error);
                            }
                        }
                    }];
                }
                    break;
                case HKAuthorizationStatusSharingDenied:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_Health];
                }
                    break;
                case HKAuthorizationStatusSharingAuthorized:
                {
                    [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_Health];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        else
        {
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Health];
            NSLog(@"unavailable");
            // Health data is not avaliable on all device.
        }
    }
    else
    {
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_Health];
        NSLog(@"iOS8以下不支持");
    }
}

#pragma mark - HomeKit
- (void)ba_checkAndRequestPrivacyOfHomeWithBlock:(BAKit_PrivacyOfHomeResultBlock)block
{
    if (BAKit_isIOS8_Or_Later)
    {
        if (!self.homeManager)
        {
            self.homeManager = [[HMHomeManager alloc] init];
            self.homeManager.delegate = self;
        }
        [self setBAKit_HomeAccessCallBackBlock:^(BOOL isHaveAccess){
            if (block)
            {
                block(isHaveAccess);
            }
        }];
    }
    else
    {
        NSLog(@"The home is available on ios8 or later");
    }
}

#pragma mark - HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    if (manager.homes.count > 0)
    {
        NSLog(@"A home exists, so we have access.");
        if (self.BAKit_HomeAccessCallBackBlock)
        {
            self.BAKit_HomeAccessCallBackBlock(YES);
        }
    }
    else
    {
        __weak HMHomeManager *weakHomeManager = manager;
        [manager addHomeWithName:@"Test Home" completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
            
            if (!error)
            {
                NSLog(@"We have access for home.");
                if (self.BAKit_HomeAccessCallBackBlock)
                {
                    self.BAKit_HomeAccessCallBackBlock(YES);
                }
            }
            else
            
            {
                // tips：出现错误，错误类型参考 HMError.h
                if (error.code == HMErrorCodeHomeAccessNotAuthorized)
                {
                    // User denied permission.
                    NSLog(@"用户拒绝!!");
                }
                else
                {
                    NSLog(@"HOME_ERROR:%ld,%@",error.code, error.localizedDescription);
                }
                if (self.BAKit_HomeAccessCallBackBlock)
                {
                    self.BAKit_HomeAccessCallBackBlock(YES);
                }
            }
            
            if (home)
            {
                [weakHomeManager removeHome:home completionHandler:^(NSError * _Nullable error) {
                    // ... do something with the result of removing the home ...
                }];
            }
        }];
    }
}

#pragma mark - MediaAndAppleMusic
- (void)ba_checkAndRequestPrivacyOfAppleMusicWithBlock:(BAKit_PrivacyResultBlock)block
{
    if (@available(iOS 9.3, *))
    {
        SKCloudServiceAuthorizationStatus status = [SKCloudServiceController authorizationStatus];
        
        if (@available(iOS 9.3, *))
        {
            if (status == SKCloudServiceAuthorizationStatusNotDetermined)
            {
                if (@available(iOS 9.3, *))
                {
                    [SKCloudServiceController requestAuthorization:^(SKCloudServiceAuthorizationStatus status) {
                        switch (status) {
                            case SKCloudServiceAuthorizationStatusNotDetermined:
                            {
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotDetermined privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
                            }
                                break;
                            case SKCloudServiceAuthorizationStatusRestricted:
                            {
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
                            }
                                break;
                            case SKCloudServiceAuthorizationStatusDenied:
                            {
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
                            }
                                break;
                            case SKCloudServiceAuthorizationStatusAuthorized:
                            {
                                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
                            }
                                break;
                            default:
                                break;
                        }
                    }];
                }
                else
                {
                    // Fallback on earlier versions
                }
            }
            else if (status == SKCloudServiceAuthorizationStatusRestricted)
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Restricted privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
            }
            else if (status == SKCloudServiceAuthorizationStatusDenied)
            {
                [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Denied privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
            }
            
        }

        else
        {
            // SKCloudServiceAuthorizationStatusAuthorized
            [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_Authorized privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
        }
    }
    else
    {
        [self ba_executePrivacyBlock:block privacyStatus:BAKit_PrivacyStatus_NotSupport privacyType:BAKit_PrivacyType_MediaAndAppleMusic];
        NSLog(@"AppleMusic只支持iOS9.3+");
    }
}

#pragma mark - MotionAndFitness
- (void)ba_checkAndRequestPrivacyOfMotionAndFitness
{
    self.cmManager = [[CMMotionActivityManager alloc] init];
    self.motionActivityQueue = [[NSOperationQueue alloc] init];
    [self.cmManager startActivityUpdatesToQueue:self.motionActivityQueue withHandler:^(CMMotionActivity *activity) {
        
        [self.cmManager stopActivityUpdates];
        
        NSLog(@"We have access for MotionAndFitness.");
    }];
    
    NSLog(@"We don't have permission to MotionAndFitness.");
}

- (void)ba_openMessageNotificationServiceWithBlock:(BAKit_PrivacyOfMessageNotificationResultBlock)block
{
    BOOL isOpen = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    UIUserNotificationType type = setting.types;
    if (setting.types != UIUserNotificationTypeNone)
    {
        isOpen = YES;
    }
    if (block)
    {
        block(isOpen, type);
    }
#else
    
#endif
    
}

#pragma mark - LocationServices
- (void)ba_checkAndRequestPrivacyOfLocationServicesWithBlock:(BAKit_PrivacyOfLocationResultBlock)block
{
    BOOL isLocationServicesEnabled = [CLLocationManager locationServicesEnabled];
    if (!isLocationServicesEnabled)
    {
        NSLog(@"定位服务不可用，例如定位没有打开...");
        [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_NotSupport privacyType:BAKit_PrivacyType_LocationServices];
    }
    else
    {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
                {
                    self.locationManager = [[CLLocationManager alloc] init];
                    self.locationManager.delegate = self;
                    
                    // 两种定位模式
                    [self.locationManager requestWhenInUseAuthorization];
                    BAKit_WeakSelf
                    [self setBAKit_CLCallBackBlock:^(CLAuthorizationStatus state) {
                        BAKit_StrongSelf
                        if (status == kCLAuthorizationStatusNotDetermined)
                        {
                            [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_NotDetermined privacyType:BAKit_PrivacyType_LocationServices];
                        }
                        else if (status == kCLAuthorizationStatusRestricted)
                        {
                            [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_Restricted privacyType:BAKit_PrivacyType_LocationServices];
                        }
                        else if (status == kCLAuthorizationStatusDenied)
                        {
                            [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_Restricted privacyType:BAKit_PrivacyType_LocationServices];
                        }
                        else if (status == kCLAuthorizationStatusAuthorizedAlways)
                        {
                            [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_AuthorizedAlways privacyType:BAKit_PrivacyType_LocationServices];
                        }
                        else if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
                        {
                            [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_AuthorizedWhenInUse privacyType:BAKit_PrivacyType_LocationServices];
                        }
                        else
                        {
                            // kCLAuthorizationStatusAuthorized < ios8
                            [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_Authorized privacyType:BAKit_PrivacyType_LocationServices];
                        }
                    }];
                }
                break;
                
            case kCLAuthorizationStatusRestricted:
            {
                [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_Restricted privacyType:BAKit_PrivacyType_LocationServices];
            }
                break;
                
            case kCLAuthorizationStatusDenied:
            {
                [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_Restricted privacyType:BAKit_PrivacyType_LocationServices];
            }
                break;
                
            case kCLAuthorizationStatusAuthorizedAlways:
            {
                [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_AuthorizedAlways privacyType:BAKit_PrivacyType_LocationServices];
            }
                break;
                
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            {
                [self ba_executeLocationServicesWithBlock:block locationAuthorizationStatus:BAKit_LocationAuthorizationStatus_AuthorizedWhenInUse privacyType:BAKit_PrivacyType_LocationServices];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (self.BAKit_CLCallBackBlock)
    {
        self.BAKit_CLCallBackBlock(status);
    }
}

#pragma mark - PrivacyStatus 权限回调 block
- (void)ba_executePrivacyBlock:(BAKit_PrivacyResultBlock)block
                 privacyStatus:(BAKit_PrivacyStatus)privacyStatus
                   privacyType:(BAKit_PrivacyType)privacyType
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block)
        {
            block(privacyStatus, privacyType);
        }
    });
}

#pragma mark - Location Services CallBack
- (void)ba_executeLocationServicesWithBlock:(BAKit_PrivacyOfLocationResultBlock)block locationAuthorizationStatus:(BAKit_LocationAuthorizationStatus)locationAuthorizationStatus privacyType:(BAKit_PrivacyType)privacyType
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block)
        {
            block(locationAuthorizationStatus);
        }
    });
}

#pragma mark - Bluetooth Sharing CallBack
- (void)ba_executeBluetoothSharingWithBlock:(BAKit_PrivacyOfBluetoothResultBlock)block CBManagerStatus:(BAKit_CBManagerStatus)CBManagerStatus privacyType:(BAKit_PrivacyType)privacyType
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block)
        {
            block(CBManagerStatus);
        }
    });
}

@end
