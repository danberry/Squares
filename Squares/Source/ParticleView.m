
#import "ParticleView.h"
#import "RectangleScene.h"

@interface ParticleView()

@property (strong, nonatomic) RectangleScene *rectangleScene;

@end

@implementation ParticleView

#pragma mark Instance Overrides

- (BOOL)acceptsFirstResponder {
    return NO;
}

#pragma mark Public Methods

- (void)addRectangleScene {
    self.rectangleScene = [[RectangleScene alloc] initWithSize:self.bounds.size];
    [self presentScene:self.rectangleScene];
}

@end
