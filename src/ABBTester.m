Bot = ABBBot([0;0;0;0;0;0]);
Bot = Bot.setTarget([500; 200; 0; 0; 0; 0])

Sim = plotter.PlotSim();
while (true)
    Bot = Bot.runRealTime();
    F = Bot.getFrames();

    Sim = Sim.plot(F);
end