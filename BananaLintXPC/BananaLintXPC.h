//
//  SwiftLintXPC.h
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/22.
//  
//

#import <Foundation/Foundation.h>
#import "BananaLintXPCProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface BananaLintXPC : NSObject <BananaLintXPCProtocol>
@end
