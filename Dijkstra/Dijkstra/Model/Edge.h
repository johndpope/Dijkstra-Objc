//
//  Edge.h
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface Edge : NSObject {
    Vertex  *_source;
    Vertex  *_destination;
    NSArray  *_distances;
}

@property (retain) Vertex *source;
@property (retain) Vertex *destination;
@property (retain) NSArray *distances;

@end
