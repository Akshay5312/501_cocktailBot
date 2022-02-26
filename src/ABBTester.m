Bot = ABBBot([0;0;0;0;0;0]);
Bot = Bot.setTarget([500; 200; 0; 0; 0; 0])

Sim = plotter.PlotSim();

    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)
    pause(0.050);

while (true)
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F);
    pause(0.050);
end