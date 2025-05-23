part of 'university_applications_cubit.dart';

@immutable
sealed class UniversityApplicationsState {}

final class UniversityApplicationsInitial extends UniversityApplicationsState {}


class LoadingUniversityApplicationsState extends UniversityApplicationsState{}
class SuccessUniversityApplicationsState extends UniversityApplicationsState{}
class ErrorUniversityApplicationsState extends UniversityApplicationsState{}


class LoadingChangeApplicationStatus extends UniversityApplicationsState{}
class SuccessChangeApplicationStatus extends UniversityApplicationsState{}
class ErrorChangeApplicationStatus extends UniversityApplicationsState{}