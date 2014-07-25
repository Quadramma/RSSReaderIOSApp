

#import <UIKit/UIKit.h>


@interface APPDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *_imageView;
@property (strong, nonatomic) IBOutlet UILabel *_titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *_subtitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *_sourcebtn;

- (IBAction)_sourcebtnTouchUpInside:(id)sender;

- (void) setItem:(NSObject*)feedItem;
@end
