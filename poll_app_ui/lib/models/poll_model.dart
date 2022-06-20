import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_model.freezed.dart';
part 'poll_model.g.dart';

@freezed
class PollModel with _$PollModel {
  const factory PollModel({
    @Default('') String title,
    @Default('') String banner,
    @Default('') String description,
    @Default(0) int totalVotes,
    @Default(0) int expiresAt,
    @Default([]) List<PollCandidateModel> candidates,
  }) = _PollModel;

  factory PollModel.fromJson(Map<String, dynamic> json) =>
      _$PollModelFromJson(json);
}

@freezed
class PollCandidateModel with _$PollCandidateModel {
  const factory PollCandidateModel({
    @Default('') String title,
        @Default('') String banner,
    @Default('') String description,
    @Default(0) int totalVotes,
  }) = _PollCandidateModel;

  factory PollCandidateModel.fromJson(Map<String, dynamic> json) =>
      _$PollCandidateModelFromJson(json);
}

@freezed
class MyVote with _$MyVote {
  const factory MyVote({
    @Default(0) int pollIndex,
    @Default(0) int candidateIndex,
  }) = _MyVote;

  factory MyVote.fromJson(Map<String, dynamic> json) =>
      _$MyVoteFromJson(json);
}
