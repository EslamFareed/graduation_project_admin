part of 'universities_cubit.dart';

@immutable
sealed class UniversitiesState {}

final class UniversitiesInitial extends UniversitiesState {}

class LoadingUniversitiesState extends UniversitiesState {}

class SuccessUniversitiesState extends UniversitiesState {}

class ErrorUniversitiesState extends UniversitiesState {}

class LoadingImageState extends UniversitiesState {}

class SuccessImageState extends UniversitiesState {}

class ErrorImageState extends UniversitiesState {}


class LoadingAddNewMajorState extends UniversitiesState{}
class SuccessAddNewMajorState extends UniversitiesState{}