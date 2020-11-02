part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TagInputChanged extends TagEvent {
  const TagInputChanged(this.tagInputData);

  final String tagInputData;

  @override
  // TODO: implement props
  List<Object> get props => [tagInputData];
}

class TagSuggestionSelected extends TagEvent {
  const TagSuggestionSelected(this.tagSuggestion);

  final TagSuggestion tagSuggestion;

  @override
  // TODO: implement props
  List<Object> get props => [tagSuggestion];
}
