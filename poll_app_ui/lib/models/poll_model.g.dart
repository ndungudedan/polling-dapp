// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PollModel _$$_PollModelFromJson(Map<String, dynamic> json) => _$_PollModel(
      title: json['title'] as String? ?? '',
      banner: json['banner'] as String? ?? '',
      description: json['description'] as String? ?? '',
      totalVotes: json['totalVotes'] as int? ?? 0,
      expiresAt: json['expiresAt'] as int? ?? 0,
      candidates: (json['candidates'] as List<dynamic>?)
              ?.map(
                  (e) => PollCandidateModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_PollModelToJson(_$_PollModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'banner': instance.banner,
      'description': instance.description,
      'totalVotes': instance.totalVotes,
      'expiresAt': instance.expiresAt,
      'candidates': instance.candidates,
    };

_$_PollCandidateModel _$$_PollCandidateModelFromJson(
        Map<String, dynamic> json) =>
    _$_PollCandidateModel(
      title: json['title'] as String? ?? '',
      banner: json['banner'] as String? ?? '',
      description: json['description'] as String? ?? '',
      totalVotes: json['totalVotes'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PollCandidateModelToJson(
        _$_PollCandidateModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'banner': instance.banner,
      'description': instance.description,
      'totalVotes': instance.totalVotes,
    };

_$_MyVote _$$_MyVoteFromJson(Map<String, dynamic> json) => _$_MyVote(
      pollIndex: json['pollIndex'] as int? ?? 0,
      candidateIndex: json['candidateIndex'] as int? ?? 0,
    );

Map<String, dynamic> _$$_MyVoteToJson(_$_MyVote instance) => <String, dynamic>{
      'pollIndex': instance.pollIndex,
      'candidateIndex': instance.candidateIndex,
    };
