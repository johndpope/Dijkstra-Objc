//
//  Vertex.h
//  Dijkstra
//
//  Created by Julien Gomès on 07/06/2014.
//  Copyright (c) 2014 Prunelle. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Vertex : NSObject <NSCopying>{
    NSUInteger  _vertexId;
    NSString    *_name;
}

@property NSUInteger vertexId;
@property (retain) NSString *name;

@end
