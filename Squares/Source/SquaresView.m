
#import "SquaresView.h"
#import "ParticleView.h"

@interface SquaresView()

@property (strong, nonatomic) ParticleView *particleView;

@end

@implementation SquaresView

#pragma mark Initialization

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        self.particleView = [[ParticleView alloc] initWithFrame:self.bounds];
        [self.particleView addRectangleScene];
        [self addSubview:self.particleView];
    }
    return self;
}

#pragma mark Class Methods

+ (BOOL)performGammaFade {
    return NO;
}

@end
