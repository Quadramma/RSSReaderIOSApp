

#import "APPDetailViewController.h"
#import "Feed.h"

@implementation APPDetailViewController{
    

    Feed *item;
    
}

@synthesize _imageView;
@synthesize _titleLabel;
@synthesize _subtitleLabel;
@synthesize _sourcebtn;

- (void)setItem:(NSObject *)feedItem {
    item = (Feed*)feedItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = item.title;
    _subtitleLabel.text = item.description;
    NSString * result = item.imageUrl;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:result]];
    _imageView.image = [UIImage imageWithData:imageData];

  
}


- (IBAction)_sourcebtnTouchUpInside:(id)sender {
    NSString *url = item.link;
    NSString *escaped = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
}


@end
