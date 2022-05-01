This project was written to simulate the dynamics of the ABB arm in WPI's Washburn labs, utilized as a cocktail pouring robot. 

The links are represented as plotted lines. Running the file ABBTester.m in matlab should visualize the robot moving between waypoints. These waypoints are communicated as a state vector [X;Y;Z;Roll;Pitch;Yaw]

The waypoints are as follows --  

[800;300;202;0;0.1;0] <- the manipulated cup position, where it is picked up from
[800;300;500;0;0.1;0] <- a waypoint to move the cup above the workspace
[300;500;500;0;0.1;0] <- a waypoint for the position above the second cup, the cup to pour into
[300;500;300;0;pi;0] <- a waypoint that tilts the manipulated cup to pour liquid into 
[300;500;300;0;0.1;0] <- stop pouring from the cup
[800;300;500;0;0.1;0] <- moving the cup back to it's original position
[800;300;202;0;0.1;0] <- setting the cup down
[800; 00; 1000; 0; 0.1; 0] <- moving the robot out of the workspace, indicating a finished move



Bot = ABBBot(initialJointPositions) 	<- initializes the simulated robot with initialJointPositions
	Bot = Bot.setTarget(state) 		<- sets the target state for the robot to step towards
	hasReached = Bot.hasReached() 	<- boolean for whether the robot has reached it's end position
	Bot = Bot.runRealTime() 		<- runs the robot in real time, simulating the moves and updating the robot position based off of the system clock
	F = Bot.getLinkPoints() 		<- returns the points at the start and end of eah link for visualization


Sim = Plotter.PlotSim() 			<- initializes a visualizer, Sim, that visualizes the robot position
	Sim = Sim.plot(LinkPoints)		<- plots the robot position based off of the link positions






algorithm to send a Bot object to a target, [300; 500; 300; 0; pi; 0], and visualize it with a plotSim object "Sim"

"
	Bot = Bot.setTarget([300; 500; 300; 0; pi; 0])
	while (not(Bot.hasReached()))
    		Bot = Bot.runRealTime();
    		F = Bot.getLinkPoints();

    		Sim = Sim.plot(F)
	
	end

"