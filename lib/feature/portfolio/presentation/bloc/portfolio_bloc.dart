import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/feature/portfolio/presentation/bloc/portfolio_event.dart';
import 'package:portfolio/feature/portfolio/presentation/bloc/portfolio_state.dart';

import '../../domain/entities/portfolio_entities.dart';
import '../../domain/usecases/get_portfolio.dart';



/// Loads the resume-backed portfolio via the [GetPortfolio] use case and
/// exposes loading/success/failure states. Depends only on the use case
/// (not the repository or data source), keeping the layer boundaries clean.
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc(this._getPortfolio) : super(const PortfolioState()) {
    on<PortfolioLoaded>(_onLoaded);
  }

  final GetPortfolio _getPortfolio;

  Future<void> _onLoaded(
      PortfolioLoaded event,
      Emitter<PortfolioState> emit,
      ) async {
    emit(state.copyWith(status: PortfolioStatus.loading));
    try {
      final Portfolio portfolio = await _getPortfolio();
      emit(
        state.copyWith(
          status: PortfolioStatus.success,
          portfolio: portfolio,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: PortfolioStatus.failure,
          errorMessage: 'Failed to load portfolio content. $error',
        ),
      );
    }
  }
}