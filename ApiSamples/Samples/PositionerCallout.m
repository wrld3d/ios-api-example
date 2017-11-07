#import "PositionerCallout.h"

@interface PositionerCallout ()
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation PositionerCallout

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self customInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self customInit];
    }
    return self;
}

-(void)customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"PositionerCallout" owner:self options:nil];
    
    [self addSubview:self.mainView];
    
    self.mainView.frame = self.bounds;
}

-(void)setTitle:(NSString*)title
{
    [_titleLabel setText:title];
}

-(void)setDescription:(NSString*)description
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:description];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8.0f;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, description.length)];

    _descriptionLabel.attributedText = attributedString;
}

@end
