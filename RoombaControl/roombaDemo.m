function roombaDemo(DemoNum);
% roombaDemo(DemoNum)
% Starts built-in Demos
% -1: Aborts the current demo
% 0: Attempts to cover entire room with a combination of different behaviors
% 1: Attempts to cover entire room unless Create sees a signal from home
% base, it uses that signal to dock with the home base and recharge.
% 2: Covers an area around its starting position by spiraling outward than
% inward
% 3: Searches for a wall, once a wall is found, create drives along the
% wall, around the circumference of the room
% 4: Drives in a figure 8 pattern
% 5: Drives foreward when pushed from behind. If Create his an obstacle
% while driving, it drives away from the obstacle
% 6: Drives towards an iRobot Virtual Wall
% 7: Drives into multiple virtual walls by bumping into one, turning around
% and bumping into the next virtual wall.
% 8: Plays the notes of Pachelbel's Cannon in sequence when cliff sensors
% are activated.
% 9: Plays a note of a chord for each of its cliff sensors, chord for each
% bumper.

roombaSendMessage([sprintf('\x88') DemoNum])

