//
//  ViewController.m
//  ObjectDemo
//
//  Created by Start on 2017/11/6.
//  Copyright © 2017年 het. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+DictionaryRotation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *dictonary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"PropertyList" ofType:@"plist"]];
    [NSObject rotationCreateDicToProperty:dictonary];
    
    /*
     1.NSInvocation 用来包装方法和对应的对象。它可以存储方法的名称,对应的对象,对应的参数
     2.NSMethodSignature签名:再创建NSMethodSignature的时候,必须传递一个签名对象。签名对象的作用用于获取参数的个数和方法的返回值。
     3.创建签名对象的时候不是使用NSMethodSignature这个类创建,而是方法属于谁就用谁来创建。
     4.invocation中的方法必须和签名中的方法一致
     5.需要给给定的方法传递值
     6.调用NSInvocation对象的invoke方法
     */
    //创建签名对象的时候不是使用NSMethodSignature这个类创建,而是方法属于谁就用谁来创建。
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(sendMessageWithNum:withContent:)];
    //创建NSInvocation对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    //invocation中的方法必须和签名中的方法一致
    invocation.selector = @selector(sendMessageWithNum:withContent:);
    //参数:需要给指定方法传递值 参数1是一个需要接收一个指针。也就是传递值的时候需要传递地址。 参数2需要给指定方法的第几个参数传值。
    NSString *num = @"123";
    [invocation setArgument:&num atIndex:2];
    NSString *contentStr = @"内容";
    [invocation setArgument:&contentStr atIndex:3];
    //调用NSInvocation对象的invoke方法
    //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
    [invocation invoke];
    
}

-(void)sendMessageWithNum:(NSString *)number withContent:(NSString *)content
{
    NSLog(@"number: %@ content: %@",number,content);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
