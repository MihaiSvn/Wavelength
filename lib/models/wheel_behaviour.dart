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

final Map<String, WheelBehavior> gamePhases = {
  'psychic_spin': WheelBehavior(
    isWheelSpinnable: true,
    isNeedleDraggable: false,
    isNeedleVisible: false,
    isCoverRevealable: true,
  ),
  'player_guessing': WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: true,
    isNeedleVisible: true,
    isCoverRevealable: false,
  ),
  'reveal_result': WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: false,
    isNeedleVisible: true,
    isCoverRevealable: true,
    initialCoverTurns: 0.0,
  ),
};