using Toybox.Math as Math;

module Engine {

	const HERO_SPEED_NORMAL = 0.16; //px per milisecond
	const HERO_SPEED_FAST = 0.32; //px per milisecond
	
	const HERO_SIZE_NORMAL = 40; //px
	const HERO_SIZE_2_NORMAL = HERO_SIZE_NORMAL/2; //px

	const HERO_SIZE_TINY = 20; //px
	const HERO_SIZE_2_TINY = HERO_SIZE_TINY/2; //px
	
	const HERO_HEIGHT = 10; //px
	const HERO_HEIGHT_2 = HERO_HEIGHT / 2;
	
	const BALL_RADIUS_NORMAL = 6; //px
	const BALL_RADIUS_TINY = 3; //px
	
	const BALL_SPEED_NORMAL = 0.16; //px per milisecond
	const BALL_SPEED_FAST = 0.32; //px per milisecond
	
	const DIRECTION_LEFT = -1;
	const DIRECTION_RIGHT = 1;
	const DIRECTION_NONE = 0;
	const DIRECTION_TOP = 1;
	const DIRECTION_DOWN = -1;
	
	const PI = Math.PI;
	const PI_4 = PI / 4;
	const PI_2 = PI / 2;
	const PI_3_4 = PI_2 + PI_4;
	const PI2 = PI * 2;
	const PI3 = PI * 3;
	
	
	function getReversedDirection(direction) {
		return -1 * direction;
	}
}
