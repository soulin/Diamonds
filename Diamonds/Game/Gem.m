//
//  Gem.m
//  Diamonds

#import "Gem.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"
#import "Grid.h"

@interface Gem (private)
@property (readonly) Sprite* sprite;
@end

@implementation Gem
{
    GemType type; 
        
    Sprite* sprite;
}

@synthesize type;

- (NSString*) getTextureNameFromType: (GemType) gemType
{
    if (gemType == Diamond)
        return @"diamond";
    if (gemType == Ruby)
        return @"ruby";
    if (gemType == Sapphire)
        return @"sapphire";
    
    return nil;
}

- (Texture*) getTextureFromType: (GemType) gemType resources: (ResourceManager*) resources
{
    if (gemType == EmptyGem)
        return nil;
    
    return [resources loadTexture: [self getTextureNameFromType: gemType]];
}

- (void) initSpriteForType: (GemType) gemType resources: (ResourceManager*) resources   
{
    sprite = [[Sprite alloc] initWithTexture: [self getTextureFromType: gemType resources: resources]];

    [sprite setSourceRectangle: CGRectMake(0, 0, 32, 32)];
    [sprite resizeTo: CGSizeMake(32, 32)];
}

- (id) initWithType: (GemType) gemType at: (GridCell) cell_ grid: (Grid*) grid_ resources: (ResourceManager*) resources
{
    self = [super initWithGrid: grid_ at: cell_ width: 1 height: 1];
    if (self == nil)
        return nil;
    
    type = gemType;
    
    [self initSpriteForType: gemType resources: resources];
    
    return self;
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;
{ 
    CGPoint spritePosition = info.origin;
    
    spritePosition.x += info.cellSize.width * self.cell.column; 
    spritePosition.y -= info.cellSize.height * self.cell.row - (info.cellSize.height * (info.heightInCells - 1)); 
    spritePosition.y += (-self.cellHeight) * info.cellSize.height;
    
    [sprite moveTo: spritePosition];
    [sprite drawIn: batch];
}

- (NSString*) description
{
    NSString* typeString = @"NoType";
    
    if (type == Diamond)
        typeString =  @"Diamond";
    if (type == Ruby)
        typeString =  @"Ruby";
    if (type == Sapphire)
        typeString =  @"Sapphire";
    
    return [NSString stringWithFormat: @"[%p] %@ (%d %d)", self, typeString, self.cell.column, self.cell.row]; 
}

- (Sprite*) sprite
{
    return sprite;
}

@end
