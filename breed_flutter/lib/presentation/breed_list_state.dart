import 'package:breed_flutter/domain/breed.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 2. Declare this:
part 'breed_list_state.freezed.dart';

// 3. Annotate the class with @freezed
@freezed
// 4. Declare the class as abstract and add `with _$ClassName`
abstract class BreedListState with _$BreedListState {
  // 5. Create a `const factory` constructor for each valid state
  const factory BreedListState.loaded(List<Breed> breedList) = _Loaded;
  const factory BreedListState.error(String errorText) = _Error;
  const factory BreedListState.loading() = _Loading;
}
