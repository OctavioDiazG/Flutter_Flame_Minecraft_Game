
class PlayerData{
  //Health
  //Hunger 
  //State idle, walking
  ComponentMotionState componentMotionState = ComponentMotionState.idle;
}

enum ComponentMotionState{
  walkingLeft, 
  jump,
  walkingRight, 
  idle,
} //compare value 

/*
currentHealdDownOption
if(currentHealdDownOption == ComponentMotionState.walkingLeft){
  movePlayerToTheLeft
}

*/