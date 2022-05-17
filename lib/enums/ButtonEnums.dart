enum ButtonEnum {
  forward,
  backward,
  left,
  right,
  center,
}

Map<ButtonEnum, String> getButtonString() => {
      /* 
  up	Up arrow key	 
down	Down arrow key	 
right	Right arrow key	 
left
  
   */
      ButtonEnum.backward: 'down',
      ButtonEnum.forward: 'up',
      ButtonEnum.left: 'left',
      ButtonEnum.right: 'right',
      ButtonEnum.center: 'center',
    };
