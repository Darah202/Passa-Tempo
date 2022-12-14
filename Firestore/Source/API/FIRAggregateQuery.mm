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

#import "FIRAggregateQuery+Internal.h"

#import "FIRAggregateQuerySnapshot+Internal.h"
#import "FIRQuery+Internal.h"

#include "Firestore/core/src/api/aggregate_query.h"
#include "Firestore/core/src/api/query_core.h"
#include "Firestore/core/src/util/error_apple.h"
#include "Firestore/core/src/util/statusor.h"

@implementation FIRAggregateQuery {
  FIRQuery *_query;
  std::unique_ptr<api::AggregateQuery> _aggregation;
}

- (instancetype _Nonnull)initWithQuery:(FIRQuery *)query {
  if (self = [super init]) {
    _query = query;
    _aggregation = absl::make_unique<api::AggregateQuery>(query.apiQuery.Count());
  }
  return self;
}

- (FIRQuery *)query {
  return _query;
}

- (void)aggregationWithSource:(FIRAggregateSource)source
                   completion:(void (^)(FIRAggregateQuerySnapshot *_Nullable snapshot,
                                        NSError *_Nullable error))completion {
  _aggregation->Get([self, completion](const firebase::firestore::util::StatusOr<int64_t> &result) {
    if (result.ok()) {
      completion([[FIRAggregateQuerySnapshot alloc] initWithCount:result.ValueOrDie() Query:self],
                 nil);
    } else {
      completion(nil, MakeNSError(result.status()));
    }
  });
}

@end
