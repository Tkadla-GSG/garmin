using Toybox.Math as Math;
using Util;

module Engine {
	
	const COLOR_SKY = 0x55AAFF;
	const COLOR_GROUND = 0xFFAA00;
	const COLOR_GRASS = 0x55AA00;
	const COLOR_PIPE = 0x00AA00;
	const COLOR_PIPE_HIGHLIGHT = 0x55FF00;
	
	const PLAYER_SPRITE_X_2 = 17;
	const PLAYER_SPRITE_Y_2 = 12;
	const PLAYER_JUMP_SPEED = 0.0016; // px per milisecond
	
	const GRAVITY = 0.00016; // px per milisecond
	
	const PIPE_SPEED = 0.08; // px per milisecond
	const PIPE_WIDTH = 30;
	const PIPE_HIGHLIGHT_WIDTH = 5;
	const PIPE_HOLE = 47;
	const PIPE_HOLE_2 = PIPE_HOLE/2;
	
	const GROUND_THICKNESS = 10;
	const GROUND_THICKNESS_2 = GROUND_THICKNESS/2;
	
	const CLOUD_SPEED = 0.01;
	const COLOR_CLOUD = 0xFFFFFF;
	const CLOUD_SIZE = 80;
	const CLOUD_2_SIZE = 2 * CLOUD_SIZE;
	const CLOUD_3_SIZE = 3 * CLOUD_SIZE;
	const CLOUD_4_SIZE = 4 * CLOUD_SIZE;
	const CLOUD_SIZE_2 = CLOUD_SIZE/2;
	
	const PIPES_NORMAL = [40, 70, 95];
	const PIPES_NARROW = [20, 60];
	
	const PLAYER_X_NORMAL = 55;
	const PLAYER_X_NARROW = 20;
	
	const SPEED_MULTIPLIER = 1.2;
		
	function getPipeVariant(pipes) {
		return pipes[Util.getRandom(0, pipes.size() - 1)];
	}
}
