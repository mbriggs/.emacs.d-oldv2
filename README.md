My Emacs Config
===============

>>"Emacs outshines all other editing
>>software in approximately the same way that the noonday sun does the
>>stars. It is not just bigger and brighter; it simply makes everything
>>else vanish."
_-Neal Stephenson, "In the Beginning was the Command
Line"_

>>"Show me your ~/.emacs and I will tell you who you are."
_-Bogdan Maryniuk_

>>"Emacs is like a laser guided missile. It only has to be slightly
>>mis-configured to ruin your whole day."
_-Sean McGrathi_

>>"While any text editor can save your files, only Emacs can save your
>>soul."
_-Per Abrahamseni_

>>"Lisp isn't a language, it's a building material."
_- Alan Kay_

>>"The reasonable man adapts himself to Emacs; the unreasonable one
>>persists in trying to adapt Emacs to himself. Therefore all progress
>>depends on the unreasonable man."
_- G.B. Shaw_

>> "Compared to Emacs Wizards, graphical-IDE users are the equivalent
>>of amateur musicians, pawing at their instrument with a sort of
>>desperation. An IDE has blinking lights and pretty dialogs that you
>>can't interact with properly, and gives newbies a nice comfortable
>>sense of control. But that control is extremely crude, and all serious
>>programmers prefer something that gives them more power."
_- Steve Yegge_


Philosophy
----------

New iteration of my emacs configuration. Built around a few principals
that probably don't apply to many people other then me

- I don't really like the emacs key scheme.
- I love modal editing
- I hate vim
- I love lisp, and any reason to use it
- I like my editor to do a lot of work for me, and I like hacking on
  it

Evil mode is the best vim implementation that I know about that isn't
vim. Emacs is a much better platform then vim. That is why this configuration
exists.

Also, line numbers are overrated. No linum mode.

Organization
------------

`init.el` does as little as possible. Configuration is done in `init/init-*`,
and is as modular as possible (so that when something goes wrong, you can
comment out modules).

Package management is done by `quelpa`, which will use MELPA when possible
to build emacs packages. I think it is a step up from `el-get`, and find it
to be much more stable. `quelpa` will bootstrap itself and all packages when
emacs loads.

My crazy mappings are mostly in `init-keymaps`, and are inspired by all the
different editors I have used before. Both vim and emacs use different
philosophies to have all key mappings available at all times. I prefer instead
to have the things I use frequently quickly available, even if it means not
having the things I don't use easily available in a standard location.

Dependancies
------------


    brew install ctags node checkstyle pmd drip
    sudo npm install -g jshint

set up rbenv

install [emacs pager](https://raw.githubusercontent.com/mbriggs/emacs-pager/master/emacs-pager)
script somewhere onto your path.

install peepopen. create a new applescript application with this

    on open these_items
        set this_item to item 1 of these_items
        set file_path to (the POSIX path of this_item)
        tell application "iTerm"
            do shell script "/usr/local/bin/emacsclient -n " & file_path & ""
        end tell
    end open

and dump in into /Applications


If ctags isn't pointing at the right version
--------------------------------------------

on ubuntu run

`sudo update-alternatives --config ctags`

and choose `ctags-exuberant`

on osx lion do

`sudo mv /usr/bin/ctags /usr/bin/ctags-old`
