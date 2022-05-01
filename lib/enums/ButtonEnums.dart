enum ButtonEnum {
  forward,
  backward,
  left,
  right,
  center,
}

Map<ButtonEnum, String> getButtonString() {
  return {
    ButtonEnum.backward: 'backward',
    ButtonEnum.forward: 'forward',
    ButtonEnum.left: 'left',
    ButtonEnum.right: 'right',
    ButtonEnum.center: 'center',
  };
}
