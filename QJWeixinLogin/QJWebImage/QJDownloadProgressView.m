//
//  QJDownloadProgressView.m
//  LawTea
//
//  Created by 瞿杰 on 2016/12/23.
//
//

#import "QJDownloadProgressView.h"
#import "CommentHeader.h"

@interface QJDownloadProgressView ()

@property (nonatomic , strong) UILabel * propressLabel ;

@property (nonatomic , strong) UIView * bgGrayView ;

@end

#define QJColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define kBorderWidth 4
#define kStrokeColor [UIColor whiteColor] 
#define kCircleColor QJColorA(210, 210, 210, 1.0)

@implementation QJDownloadProgressView


-(instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.propressLabel];
    }
    return self ;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.propressLabel.frame = self.bounds ;
    
    self.bgGrayView.frame = self.bounds ;
}

-(void)takeBgBluckViewAddToSuperView:(UIView *)superView
{
    [superView addSubview:self.bgGrayView];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self drawBgCircle];
    
    [self drawPause];
}

-(void)drawBgCircle
{
    // 1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // 2.画图
    CGFloat tmp = self.frame.size.width / 2.0 - 3 ;
    if (tmp > 20) {
        tmp = 20 ;
    }
    else{
        self.propressLabel.font = [UIFont systemFontOfSize:11];
    }
    
    if (tmp <= 15) {
        self.propressLabel.hidden = YES ;
    }
    else{
        self.propressLabel.hidden = NO ;
    }
    
    CGFloat radius =  tmp - kBorderWidth;
    CGFloat circleX = self.frame.size.width / 2.0 ;
    CGFloat circleY = self.frame.size.height / 2.0 ;
    
    // 设置线宽
    CGContextSetLineWidth(context, kBorderWidth);
    // 设置颜色
    [kCircleColor set];
    
    // 画圆
    CGContextAddArc(context, circleX, circleY, radius, 0 , M_PI * 2.0 , 1);
    
    // 3.渲染
    CGContextDrawPath(context, kCGPathStroke);
//    CGContextFillPath(context);
    // 恢复图形上下文的状态
    CGContextRestoreGState(context);
}


// 画进度
-(void)drawPause
{
    // 1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // 2.画图
    CGFloat tmp = self.frame.size.width / 2.0 - 3;
    if (tmp > 20) {
        tmp = 20 ;
    }
    CGFloat radius =  tmp - kBorderWidth;
    CGFloat circleX = self.frame.size.width / 2.0 ;
    CGFloat circleY = self.frame.size.height / 2.0 ;
    
    // 画狐
    CGFloat radian = M_PI * 2.0 * self.progressScope -  M_PI / 2.0 ;
    CGContextAddArc(context, circleX, circleY, radius, - M_PI / 2.0 , radian , 0);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    // 设置线宽
    CGContextSetLineWidth(context, kBorderWidth);
    
    // 设置颜色
    [kStrokeColor set];
    
    // 3.渲染
    CGContextDrawPath(context, kCGPathStroke);
    // 恢复图形上下文的状态
    CGContextRestoreGState(context);
    
    if (self.progressScope >= 1.0 ) {
        
        [UIView animateWithDuration:0.15 animations:^{
            self.alpha = 0.0 ;
            self.bgGrayView.alpha = 0.0 ;
        } completion:^(BOOL finished) {
            [self.bgGrayView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }
}


#pragma mark - getter 方法
-(UILabel *)propressLabel
{
    if (!_propressLabel) {
        _propressLabel = [[UILabel alloc] init];
        _propressLabel.textColor = kStrokeColor ;
        _propressLabel.font = [UIFont systemFontOfSize:12];
        _propressLabel.backgroundColor = [UIColor clearColor];
        _propressLabel.textAlignment = NSTextAlignmentCenter ;
    }
    return _propressLabel ;
}
-(UIView *)bgGrayView
{
    if (!_bgGrayView) {
        _bgGrayView = [[UIView alloc] init];
        _bgGrayView.backgroundColor = [UIColor blackColor];
        _bgGrayView.alpha = 0.4 ;
    }
    return _bgGrayView ;
}

-(void)setProgressScope:(CGFloat)progressScope
{
    if (progressScope < 0.0) {
        progressScope = 0.0 ;
    }
    if (progressScope > 1.0) {
        progressScope = 1.0 ;
    }
    
    self.propressLabel.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)(progressScope * 100)];
    
    _progressScope = progressScope ;
    
    [self setNeedsDisplay];
}

@end
