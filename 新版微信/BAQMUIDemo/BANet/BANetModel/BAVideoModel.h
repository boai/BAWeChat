//
//  BAVideoModel.h
//  BABaseProject
//
//  Created by apple on 16/1/13.
//  strongright © 2016年 博爱之家. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Videosidlist,Videolist;
@interface BAVideoModel : NSObject

//http://c.m.163.com/nc/video/home/1-10.html



@property (nonatomic, strong) NSString  *videoHomeSid;

@property (nonatomic, strong) NSArray<Videosidlist *> *videoSidList;

@property (nonatomic, strong) NSArray<Videolist *> *videoList;

@end

@interface Videosidlist : NSObject

@property (nonatomic, strong  ) NSString   *sid;

@property (nonatomic, strong  ) NSString   *title;

@property (nonatomic, strong  ) NSString   *imgsrc;

@end

@interface Videolist : NSObject

@property (nonatomic, strong  ) NSString   *desc;

@property (nonatomic, strong  ) NSString   *replyid;

@property (nonatomic, strong  ) NSString   *mp4_url;

@property (nonatomic, assign) NSInteger   playCount;

@property (nonatomic, strong  ) NSString   *replyBoard;

@property (nonatomic, strong  ) NSString   *vid;

@property (nonatomic, assign) NSInteger   length;

@property (nonatomic, strong  ) NSString   *title;

@property (nonatomic, strong  ) NSString   *m3u8Hd_url;

@property (nonatomic, strong  ) NSString   *ptime;

@property (nonatomic, strong  ) NSString   *cover;

@property (nonatomic, strong  ) NSString   *videosource;

@property (nonatomic, strong  ) NSString   *mp4Hd_url;

@property (nonatomic, assign) NSInteger   playersize;

@property (nonatomic, assign) NSInteger   replyCount;

@property (nonatomic, strong  ) NSString   *m3u8_url;

@end

