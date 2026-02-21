import 'package:wavelength/models/game_phases.dart';

class WheelBehavior {
  bool isWheelSpinnable; 
  bool isNeedleDraggable;
  bool isNeedleVisible;
  bool isCoverRevealable;
  double initialCoverTurns;

  WheelBehavior({
    this.isWheelSpinnable = false,
    this.isNeedleDraggable = false,
    this.isNeedleVisible = false,
    this.isCoverRevealable = false,
    this.initialCoverTurns = 0.0,
  });
}

final Map<TurnPhases, WheelBehavior> gamePhases = {
  TurnPhases.psychicSpin: WheelBehavior(
    isWheelSpinnable: true,
    isNeedleDraggable: false,
    isNeedleVisible: false,
    isCoverRevealable: true,
  ),
  TurnPhases.guesserGuess: WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: true,
    isNeedleVisible: true,
    isCoverRevealable: false,
  ),
  TurnPhases.showTurn: WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: false,
    isNeedleVisible: true,
    isCoverRevealable: true,
    initialCoverTurns: 0.0,
  ),
  TurnPhases.guesserTurn: WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: false,
    isNeedleVisible: true,
    isCoverRevealable: true,
    initialCoverTurns: 0.0,
  ),
  TurnPhases.debug: WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: true,
    isNeedleVisible: true,
    isCoverRevealable: false,
  )
};