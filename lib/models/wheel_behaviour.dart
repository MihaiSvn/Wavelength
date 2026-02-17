class WheelBehavior {
  bool isWheelSpinnable; 
  bool isNeedleDraggable;
  bool isCoverRevealable;
  double initialCoverTurns;

  WheelBehavior({
    this.isWheelSpinnable = false,
    this.isNeedleDraggable = false,
    this.isCoverRevealable = false,
    this.initialCoverTurns = 0.0,
  });
}

final Map<String, WheelBehavior> gamePhases = {
  'psychic_spin': WheelBehavior(
    isWheelSpinnable: true,
    isNeedleDraggable: false,
    isCoverRevealable: true,
  ),
  'player_guessing': WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: true,
    isCoverRevealable: false,
  ),
  'reveal_result': WheelBehavior(
    isWheelSpinnable: false,
    isNeedleDraggable: false,
    isCoverRevealable: true,
    initialCoverTurns: 0.0,
  ),
};