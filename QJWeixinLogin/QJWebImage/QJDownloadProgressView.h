//
//  LTShowDownloadAdvanceView.h
//  LawTea
//
//  Created by 瞿杰 on 2016/12/23.
//
//

#import <UIKit/UIKit.h>

@interface QJDownloadProgressView: UIView

// 范围 (0 ~ 1.0)
@property (nonatomic , assign) CGFloat progressScope ;

-(void)takeBgBluckViewAddToSuperView:(UIView *)superView;

@end
