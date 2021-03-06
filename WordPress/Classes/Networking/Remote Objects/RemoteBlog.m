#import "RemoteBlog.h"

@implementation RemoteBlog
- (NSString *)description
{
    NSDictionary *properties = @{
                                 @"ID": self.ID,
                                 @"title": self.title,
                                 @"url": self.url,
                                 @"xmlrpc": self.xmlrpc,
                                 @"jetpack": self.jetpack ? @"YES" : @"NO",
                                 @"icon": self.icon ? self.icon : @"",
                                 @"visible": self.visible ? @"YES" : @"NO",
                                 };
    return [NSString stringWithFormat:@"<%@: %p> (%@)", NSStringFromClass([self class]), self, properties];
}
@end