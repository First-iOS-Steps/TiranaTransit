//
//  STPToken.m
//  Stripe
//
//  Created by Saikat Chakrabarti on 11/5/12.
//
//

#import "STPToken.h"
#import "STPCard.h"
#import "STPBankAccount.h"

@implementation STPToken

- (instancetype)initWithAttributeDictionary:(NSDictionary *)attributeDictionary {
    self = [super init];

    if (self) {
        _tokenId = attributeDictionary[@"id"] ?: @"";
        _livemode = [attributeDictionary[@"livemode"] boolValue];
        _created = [NSDate dateWithTimeIntervalSince1970:[attributeDictionary[@"created"] doubleValue]];

        NSDictionary *cardDictionary = attributeDictionary[@"card"];
        if (cardDictionary) {
            _card = [[STPCard alloc] initWithAttributeDictionary:cardDictionary];
        }

        NSDictionary *bankAccountDictionary = attributeDictionary[@"bank_account"];
        if (bankAccountDictionary) {
            _bankAccount = [[STPBankAccount alloc] initWithAttributeDictionary:bankAccountDictionary];
        }
    }

    return self;
}

- (NSString *)description {
    NSString *token = self.tokenId ?: @"Unknown token";
    NSString *livemode = self.livemode ? @"live mode" : @"test mode";

    return [NSString stringWithFormat:@"%@ (%@)", token, livemode];
}

- (void)postToURL:(NSURL *)url withParams:(NSMutableDictionary *)params completion:(STPCardServerResponseCallback)handler {
    NSMutableString *body = [NSMutableString stringWithFormat:@"stripeToken=%@", self.tokenId];

    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, __unused BOOL *stop) { [body appendFormat:@"&%@=%@", key, obj]; }];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:handler];
}

- (BOOL)isEqual:(id)object {
    return [self isEqualToToken:object];
}

- (NSUInteger)hash {
    return [self.tokenId hash];
}

- (BOOL)isEqualToToken:(STPToken *)object {
    if (self == object) {
        return YES;
    }

    if (!object || ![object isKindOfClass:self.class]) {
        return NO;
    }

    if ((self.card || object.card) && (![self.card isEqual:object.card])) {
        return NO;
    }

    if ((self.bankAccount || object.bankAccount) && (![self.bankAccount isEqual:object.bankAccount])) {
        return NO;
    }

    return self.livemode == object.livemode && [self.tokenId isEqualToString:object.tokenId] && [self.created isEqualToDate:object.created] &&
           [self.card isEqual:object.card] && [self.tokenId isEqualToString:object.tokenId] && [self.created isEqualToDate:object.created];
}

@end
