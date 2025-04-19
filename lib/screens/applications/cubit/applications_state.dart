part of 'applications_cubit.dart';

@immutable
sealed class ApplicationsState {}

final class ApplicationsInitial extends ApplicationsState {}


class LoadingApplicationsState extends ApplicationsState{}
class SuccessApplicationsState extends ApplicationsState{}
class ErrorApplicationsState extends ApplicationsState{}