//
//  BAKit_ChineseString.m
//  BAKit
//
//  Created by 博爱 on 16/4/11.
//  Copyright © 2016年 com.boaihome. All rights reserved.
//

#import "BAKit_ChineseString.h"

@implementation BAKit_ChineseString

#pragma mark - 返回排序后的tableview右边的索引indexArray
+ (NSMutableArray*)ba_chineseStringIndexArray:(NSArray*)stringArr
{
    NSMutableArray *tempArray = [self ba_chineseStringReturnSortChineseArrar:stringArr];
    NSMutableArray *A_Result=[NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((BAKit_ChineseString *)object).pinYin substringToIndex:1];
        // 不同
        if(![tempString isEqualToString:pinyin])
        {
           // BALog(@"IndexArray----->%@",pinyin);
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;
}

#pragma mark - 返回排序后的联系人数组
+ (NSMutableArray*)ba_chineseStringLetterSortArray:(NSArray*)stringArr
{
    NSMutableArray *tempArray = [self ba_chineseStringReturnSortChineseArrar:stringArr];
    NSMutableArray *LetterResult=[NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString ;
    //拼音分组
    for (NSString* object in tempArray) {

         NSString *pinyin = [((BAKit_ChineseString  *)object).pinYin substringToIndex:1];
         NSString *string = ((BAKit_ChineseString  *)object).string;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:string];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:string];
        }
    }
    return LetterResult;
}

/*! 过滤指定字符串   里面的指定字符根据自己的需要添加 */
+ (NSString*)ba_chineseStringRemoveSpecialCharacter: (NSString *)str {
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound)
    {
        return [self ba_chineseStringRemoveSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}

/*! 返回排序好的字符拼音 */
+ (NSMutableArray*)ba_chineseStringReturnSortChineseArrar:(NSArray*)stringArr
{
    // 获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringArr count];i++)
    {
        BAKit_ChineseString  *chineseString=[[BAKit_ChineseString  alloc]init];
        chineseString.string=[NSString stringWithString:[stringArr objectAtIndex:i]];
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        // 去除两端空格和回车
        chineseString.string  = [chineseString.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        //此方法存在一些问题 有些字符过滤不了
        //NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
        //chineseString.string = [chineseString.string stringByTrimmingCharactersInSet:set];
        
        
        //这里我自己写了一个递归过滤指定字符串   RemoveSpecialCharacter
        chineseString.string =[BAKit_ChineseString ba_chineseStringRemoveSpecialCharacter:chineseString.string];
       // BALog(@"string====%@",chineseString.string);
        
        
        // 判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([predicate evaluateWithObject:chineseString.string])
        {
            // 首字母大写
            chineseString.pinYin = [chineseString.string capitalizedString] ;
        }else{
            if(![chineseString.string isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseString.string.length;j++){
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin=pinYinResult;
            }else{
                chineseString.pinYin=@"";
            }
        }
        [chineseStringsArray addObject:chineseString];
    }
    // 按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];

    return chineseStringsArray;
}

//
//for(int i=0;i<[chineseStringsArray count];i++){
//    // BALog(@"chineseStringsArray====%@",((ChineseString*)[chineseStringsArray objectAtIndex:i]).pinYin);
//}
//// BALog(@"-----------------------------");
#pragma mark - 返回一组字母排序数组(中英混排)
+ (NSMutableArray*)ba_chineseStringSortArray:(NSArray*)stringArr
{
    NSMutableArray *tempArray = [self ba_chineseStringReturnSortChineseArrar:stringArr];
    
    // 把排序好的内容从ChineseString类中提取出来
    NSMutableArray *result=[NSMutableArray array];
    for(int i=0;i<[stringArr count];i++){
        [result addObject:((BAKit_ChineseString  *)[tempArray objectAtIndex:i]).string];
//        BALog(@"SortArray----->%@",((BAKit_ChineseString  *)[tempArray objectAtIndex:i]).string);
    }
    return result;
}
@end