//
//  Dijkstra.h
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Graph.h"
#import "Vertex.h"

@interface Dijkstra : NSObject {
    Graph *_graph;
    NSMutableArray *_settledStopList;
    NSMutableArray *_unSettledStopList;
    NSMutableDictionary *_predecessors;
    NSMutableDictionary *_distanceFromVertex;
}

- (void) initWithGraph:(Graph *)graph;
- (void) execute:(Vertex *)destination;
- (NSArray *) getPath:(Vertex *)destination;

@end