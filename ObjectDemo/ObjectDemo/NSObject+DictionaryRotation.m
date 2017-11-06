//
//  NSObject+DictionaryRotation.m
//  ObjectDemo
//
//  Created by Start on 2017/11/6.
//  Copyright © 2017年 het. All rights reserved.
//

#import "NSObject+DictionaryRotation.h"

@implementation NSObject (DictionaryRotation)
-(void)rotationCreateDicToProperty:(NSDictionary *)dict
{
    NSMutableString *strM = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
       // NSLog(@"value的类型:%@",[value class]);
        NSString *propertyStr;
        if ([value isKindOfClass:NSClassFromString(@"__NSArrayI")]||[value isKindOfClass:NSClassFromString(@"__NSCFArray")]) {
            propertyStr = [NSString stringWithFormat:@"@property (nonatomic,strong) NSArray * %@;",key];
            for (NSDictionary *dictArray in value) {
                [self rotationCreateDicToProperty:dictArray];
            }
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFConstantString")]||[value isKindOfClass:NSClassFromString(@"__NSCFString")]){
            propertyStr=[NSString stringWithFormat:@"@property (nonatomic,copy) NSString * %@;",key];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSSingleEntryDictionaryI")]||[value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            propertyStr=[NSString stringWithFormat:@"@property (nonatomic,strong) NSDictionary * %@;",key];
        }else  if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            propertyStr=[NSString stringWithFormat:@"@property (nonatomic,assign) BOOL %@;",key];
        }
        else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
             if (strcmp([value objCType], @encode(float)) == 0||strcmp([value objCType], @encode(double)) == 0) {
                propertyStr=[NSString stringWithFormat:@"@property (nonatomic,assign) float %@;",key];
            } else if (strcmp([value objCType], @encode(NSUInteger)) == 0||
                      strcmp([value objCType], @encode(UInt8)) == 0  ||
                      strcmp([value objCType], @encode(UInt16)) == 0 ||
                      strcmp([value objCType], @encode(UInt32)) == 0)
            {
              propertyStr=[NSString stringWithFormat:@"@property (nonatomic,assign) int %@;",key];
            }
            else{
                propertyStr=[NSString stringWithFormat:@"@property (nonatomic,strong)NSNumber *%@;",key];
            }
        }else{
            propertyStr=[NSString stringWithFormat:@"@property (nonatomic,strong) %@ * %@;",NSStringFromClass([value class]),key];//自定的对象
        }
        [strM appendFormat:@"%@\n",propertyStr];
    }];
    NSLog(@"%@",strM);
}
@end
