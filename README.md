Mac OS X Kext Logging for Fun and Profit
========================================

Kernel extensions in Mac OS X ("kexts") log to the file /var/log/kernel.log
which is backed up somewhat infrequently. On my machine, I have backed up logs
dating from 6 months ago at the latest. Since my machine usage is probably very
anti-correlated with my sleeping, I decided to use kext logging to plot my
sleep schedule as a function of time.

This is sort of a response to
<http://blog.stephenwolfram.com/2012/03/the-personal-analytics-of-my-life/>
but using my own machine's tools and data without relying on external services
for data collection, analysis, and visualization.


Requirements
------------

awk, python, numpy, matplotlib


Usage
-----

At the moment, while logged in as `peter`, running

    ./generate
    ./plot.py

will put the logs in a directory `peter`, run the awk script on the logs, and
then display a 2D histogram.


Example
-------

Here's the histogram for my own logs going back to September 3, 2011:

![Peter's messed up sleep schedule](kextlog/raw/master/sample560.png)


TODO
----

*   The python log parsing script is a lot faster than the awk script,
    but there's a problem with getting the right timezone. I'll figure it
    out another time.
*   There's no persistence. I think what it should do is save your new logfiles
    every time you call `./generate` or whatever it becomes.
