//
//  DrawView.m
//  网格视图
//
//  Created by xtjsb on 2018/3/22.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSString *string = @"郑合惠子，1994年9月16日出生于福建省福州市，中国内地影视女演员。2013年，高中毕业的郑合惠子考入了北京现代音乐学院播音主持系。2015年，郑合惠子加入万合天宜并正式开始演艺生涯";
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeMake(10, 10);
    //必须写，否则无效果
    shadow.shadowBlurRadius = 5;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor yellowColor],NSBackgroundColorAttributeName:[UIColor redColor],NSShadowAttributeName:shadow};
    [string drawInRect:rect withAttributes:dict];
    
}
-(void)drawWords:(CGRect)rect{
    //绘制图片文字
    UIImage *imge = [UIImage imageNamed:@"p1.jpg"];
    //    [imge drawInRect:rect];
    //    [imge drawInRect:CGRectMake(0, 0, 50, 50)];
    //原图
    //    [imge drawAtPoint:CGPointMake(50, 50)];
    //平铺
        [imge drawAsPatternInRect:rect];
}
//第二种方法绘制圆形矩形
-(void)draw5{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(10, 10, 50, 60);
    CGContextFillRect(ctx, rect);
    CGContextStrokePath(ctx);
}
//第二种方法绘制曲线
-(void)draw4{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddQuadCurveToPoint(ctx, 100, 100, 40, 80);
    //渲染上下文
    CGContextStrokePath(ctx);
}
-(void)draw3{
    //    第三种方法
    //    贝塞尔曲线
    //绘制圆角矩形
    CGRect rect = CGRectMake(40, 50, 50, 60);
    UIBezierPath *path  = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10];
    [path stroke];
    
    //画矩形
    CGRect rect1 = CGRectMake(10, 10, 50, 60);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:rect1];
    [[UIColor yellowColor]setFill];
    [[UIColor blueColor]setStroke];
    [bezierPath stroke];
    [bezierPath fill];
    //绘制圆
    CGRect rect2 = CGRectMake(100, 100, 50, 50);
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:rect2];
    [[UIColor redColor]set];
    [path2 stroke];
    [path2 fill];
    //画线
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint:CGPointMake(10, 10)];
    [bezierPath1 addLineToPoint:CGPointMake(40, 40)];
    bezierPath1.lineWidth = 20;
    bezierPath1.lineCapStyle = kCGLineCapButt;
    bezierPath1.lineJoinStyle = kCGLineJoinMiter;
    [[UIColor redColor]set];
    [bezierPath1 stroke];
}
-(void)draw2{
    //    第二种方法
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 100, 50);
    //设置线的宽
    CGContextSetLineWidth(ctx, 10);
    //设置接头样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //设置顶角样式
    //设置颜色
    [[UIColor redColor]setStroke];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //渲染上下文
    CGContextStrokePath(ctx);
}
-(void)draw1{
    //第一种绘图方法
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 20, 20);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    CGPathAddLineToPoint(path, NULL, 50, 100);
    //将图形放入上下文
    CGContextAddPath(ctx, path);
    //渲染上下文
    CGContextStrokePath(ctx);
    //释放路径
    CGPathRelease(path);
}

@end
