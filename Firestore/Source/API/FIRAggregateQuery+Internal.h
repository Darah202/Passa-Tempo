/*
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// TODO(b/246760853): Move FIRAggregateQuery to public headers to release it.

#import "FIRAggregateSource+Internal.h"
#import "FIRQuery.h"

@class FIRAggregateQuerySnapshot;

/**
 * An `AggregateQuery` computes some aggregation statistics from the result set of a base
 * `Query`.
 */
NS_SWIFT_NAME(AggregateQuery)
@interface FIRAggregateQuery : NSObject

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithQuery:(FIRQuery *_Nonnull)query NS_DESIGNATED_INITIALIZER;

/** The base `Query` for this aggregate query. */
@property(nonatomic, readonly) FIRQuery *_Nonnull query;

/**
 * Executes the aggregate query and reads back the results as a `FIRAggregateQuerySnapshot`.
 *
 * @param source indicates where the results should be fetched from.
 * @param completion a block to execute once the results have been successfully read.
 *     snapshot will be `nil` only if error is `non-nil`.
 */
- (void)aggregationWithSource:(FIRAggregateSource)source
                   completion:(void (^_Nonnull)(FIRAggregateQuerySnapshot *_Nullable snapshot,
                                                NSError *_Nullable error))completion
    NS_SWIFT_NAME(aggregation(source:completion:));
@end
