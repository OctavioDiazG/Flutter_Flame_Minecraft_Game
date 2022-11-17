
class PlayerData{
  //Health
  //Hunger 
  //State idle, walking
  ComponentMotionState componentMotionState = ComponentMotionState.idle;
}

enum ComponentMotionState{
  walkingLeft, 
  walkingRight, 
  idle,
} //compare value 

/*
currentHealdDownOption
if(currentHealdDownOption == ComponentMotionState.walkingLeft){
  movePlayerToTheLeft
}

*/