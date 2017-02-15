//
// Created by dmitrii.aitov@philips.com on 15/02/17.
// Copyright (c) 2017 Dmitrii Aitov. All rights reserved.
//

#import "ADRFlickrPhoto.h"


@implementation ADRFlickrPhoto

- (nullable instancetype)initWithIdentifier:(NSUInteger)identifier
                                      title:(nonnull NSString *)title
                                      owner:(nonnull NSString *)owner
                                     secret:(nonnull NSString *)secret
                                     server:(NSUInteger)server
                                       farm:(NSUInteger)farm
{
    self = [super init];

    if (self)
    {
        _identifier = identifier;
        _title = title;
        _owner = owner;
        _secret = secret;
        _server = server;
        _farm = farm;
    }

    return self;
}

- (NSURL *)imageURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%lu.static.flicr.com/%lu/%lu_%@.jpg", self.farm, self.server, self.identifier, self.secret]];

}

@end