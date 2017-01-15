//
//  STPAPIClient.h
//  StripeExample
//
//  Created by Jack Flintermann on 12/18/14.
//  Copyright (c) 2014 Stripe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPNullabilityMacros.h"

static NSString *const __stp_nonnull STPSDKVersion = @"4.0.3";

@class STPBankAccount, STPCard, STPToken;

/**
 *  A callback to be run with the response from the Stripe API.
 *
 *  @param token The Stripe token from the response. Will be nil if an error occurs. @see STPToken
 *  @param error The error returned from the response, or nil in one occurs. @see StripeError.h for possible values.
 */
typedef void (^STPCompletionBlock)(STPToken * __stp_nullable token, NSError * __stp_nullable error);

/**
 A top-level class that imports the rest of the Stripe SDK. This class used to contain several methods to create Stripe tokens, but those are now deprecated in
 favor of STPAPIClient.
 */
@interface Stripe : NSObject

/**
 *  Set your Stripe API key with this method. New instances of STPAPIClient will be initialized with this value. You should call this method as early as
 *  possible in your application's lifecycle, preferably in your AppDelegate.
 *
 *  @param   publishableKey Your publishable key, obtained from https://stripe.com/account/apikeys
 *  @warning Make sure not to ship your test API keys to the App Store! This will log a warning if you use your test key in a release build.
 */
+ (void)setDefaultPublishableKey:(stp_nonnull NSString *)publishableKey;

/// The current default publishable key.
+ (stp_nullable NSString *)defaultPublishableKey;
@end

/// A client for making connections to the Stripe API.
@interface STPAPIClient : NSObject

/**
 *  A shared singleton API client. Its API key will be initially equal to [Stripe defaultPublishableKey].
 */
+ (stp_nonnull instancetype)sharedClient;
- (stp_nonnull instancetype)initWithPublishableKey:(stp_nonnull NSString *)publishableKey NS_DESIGNATED_INITIALIZER;

/**
 *  @see [Stripe setDefaultPublishableKey:]
 */
@property (nonatomic, copy, stp_nullable) NSString *publishableKey;

/**
 *  The operation queue on which to run the url connection and delegate methods. Cannot be nil. @see NSURLConnection
 */
@property (nonatomic, stp_nonnull) NSOperationQueue *operationQueue;

@end

#pragma mark Bank Accounts

@interface STPAPIClient (BankAccounts)

/**
 *  Converts an STPBankAccount object into a Stripe token using the Stripe API.
 *
 *  @param bankAccount The user's bank account details. Cannot be nil. @see https://stripe.com/docs/api#create_bank_account_token
 *  @param completion  The callback to run with the returned Stripe token (and any errors that may have occurred).
 */
- (void)createTokenWithBankAccount:(stp_nonnull STPBankAccount *)bankAccount completion:(__stp_nullable STPCompletionBlock)completion;

@end

#pragma mark Credit Cards

@interface STPAPIClient (CreditCards)

/**
 *  Converts an STPCard object into a Stripe token using the Stripe API.
 *
 *  @param card        The user's card details. Cannot be nil. @see https://stripe.com/docs/api#create_card_token
 *  @param completion  The callback to run with the returned Stripe token (and any errors that may have occurred).
 */
- (void)createTokenWithCard:(stp_nonnull STPCard *)card completion:(stp_nullable STPCompletionBlock)completion;

@end

// These methods are used internally and exposed here only for the sake of writing tests more easily. You should not use them in your own application.
@interface STPAPIClient (PrivateMethods)

- (void)createTokenWithData:(stp_nonnull NSData *)data completion:(stp_nullable STPCompletionBlock)completion;

@end

#pragma mark - Deprecated Methods
// These methods are deprecated. You should instead use STPAPIClient to create tokens.
// Example: [Stripe createTokenWithCard:card completion:completion];
// becomes [[STPAPIClient sharedClient] createTokenWithCard:card completion:completion];
@interface Stripe (Deprecated)

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user. The URL
 *connection will run on the main queue. Uses the value of [Stripe defaultPublishableKey] for authentication.
 *
 *  @param card    The user's card details. @see STPCard
 *  @param handler Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated    Use STPAPIClient instead.
 */
+ (void)createTokenWithCard:(stp_nonnull STPCard *)card completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user. The URL
 *connection will run on the main queue.
 *
 *  @param card           The user's card details. @see STPCard
 *  @param publishableKey The API key to use to authenticate with Stripe. Get this at https://stripe.com/account/apikeys .
 *  @param handler        Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated           Use STPAPIClient instead.
 */
+ (void)createTokenWithCard:(stp_nonnull STPCard *)card publishableKey:(stp_nonnull NSString *)publishableKey completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user.
 *
 *  @param card    The user's card details. @see STPCard
 *  @param queue   The operation queue on which to run the URL connection. @see NSURLConnection
 *  @param handler Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated    Use STPAPIClient instead.
 */
+ (void)createTokenWithCard:(stp_nonnull STPCard *)card operationQueue:(stp_nonnull NSOperationQueue *)queue completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user.
 *
 *  @param card           The user's card details. @see STPCard
 *  @param publishableKey The API key to use to authenticate with Stripe. Get this at https://stripe.com/account/apikeys .
 *  @param queue          The operation queue on which to run the URL connection. @see NSURLConnection
 *  @param handler        Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated           Use STPAPIClient instead.
 */
+ (void)createTokenWithCard:(stp_nonnull STPCard *)card
             publishableKey:(stp_nonnull NSString *)publishableKey
             operationQueue:(stp_nonnull NSOperationQueue *)queue
                 completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user. The URL
 *connection will run on the main queue. Uses the value of [Stripe defaultPublishableKey] for authentication.
 *
 *  @param bankAccount The user's bank account details. @see STPBankAccount
 *  @param handler     Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated        Use STPAPIClient instead.
 */
+ (void)createTokenWithBankAccount:(stp_nonnull STPBankAccount *)bankAccount completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user. The URL
 *connection will run on the main queue. Uses the value of [Stripe defaultPublishableKey] for authentication.
 *
 *  @param bankAccount    The user's bank account details. @see STPBankAccount
 *  @param publishableKey The API key to use to authenticate with Stripe. Get this at https://stripe.com/account/apikeys .
 *  @param handler        Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated           Use STPAPIClient instead.
 */
+ (void)createTokenWithBankAccount:(stp_nonnull STPBankAccount *)bankAccount
                    publishableKey:(stp_nonnull NSString *)publishableKey
                        completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user. The URL
 *connection will run on the main queue. Uses the value of [Stripe defaultPublishableKey] for authentication.
 *
 *  @param bankAccount The user's bank account details. @see STPBankAccount
 *  @param queue       The operation queue on which to run the URL connection. @see NSURLConnection
 *  @param handler     Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated        Use STPAPIClient instead.
 */
+ (void)createTokenWithBankAccount:(stp_nonnull STPBankAccount *)bankAccount
                    operationQueue:(stp_nonnull NSOperationQueue *)queue
                        completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

/**
 *  Securely convert your user's credit card details into a Stripe token, which you can then safely store on your server and use to charge the user. The URL
 *connection will run on the main queue. Uses the value of [Stripe defaultPublishableKey] for authentication.
 *
 *  @param bankAccount    The user's bank account details. @see STPBankAccount
 *  @param publishableKey The API key to use to authenticate with Stripe. Get this at https://stripe.com/account/apikeys .
 *  @param queue          The operation queue on which to run the URL connection. @see NSURLConnection
 *  @param handler        Code to run when the user's card has been turned into a Stripe token.
 *  @deprecated           Use STPAPIClient instead.
 */
+ (void)createTokenWithBankAccount:(stp_nonnull STPBankAccount *)bankAccount
                    publishableKey:(stp_nonnull NSString *)publishableKey
                    operationQueue:(stp_nonnull NSOperationQueue *)queue
                        completion:(stp_nullable STPCompletionBlock)handler __attribute__((deprecated));

@end
