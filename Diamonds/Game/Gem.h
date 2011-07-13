//
//  Gem.h
//  Diamonds

typedef struct GridPresentationInfo
{
    CGPoint origin;
    CGSize cellSize;

    int heightInCells;
}
GridPresentationInfo;

typedef enum GemType 
{
    EmptyGem = 0,
    Diamond = 1,
    Ruby = 2,
}
GemType;

typedef enum GemState
{
    Stopped = 0,
    Falling = 1,
}
GemState;

typedef struct GridPosition
{
    int column;
    int row;
}
GridPosition;

GridPosition MakePosition(int column, int row);

@class SpriteBatch;
@class ResourceManager;
@class Grid;

@interface Gem : NSObject

@property (readonly) GemType type;
@property (readonly) GemState state;

@property (readonly) GridPosition position;
@property (readonly) float cellHeight;

- (id) initWithType: (GemType) gemType at: (GridPosition) gridPosition resources: (ResourceManager*) resources;

- (void) update: (Grid*) grid;
- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end