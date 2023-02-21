#!/usr/bin/env zsh

SUBJECTSDIR=$HOME/Universitat/4t_Semestre

op=$(for i in $(ls -dX $SUBJECTSDIR/*/); do echo ${${i%%/}/*\//}; done | fuzzel --dmenu -t ebdbb2ff -b 282828dd -m d65d0eff -s 665c54ff -S ebdbb2ff -C d65d0eff -x 8 --width 15 --lines 5)

if [[ -n $op ]];
then
        ln -vfns $SUBJECTSDIR/$op $HOME/Current
        thunar $HOME/Current
fi
