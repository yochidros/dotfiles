function fish_greeting
    if not set -q fish_greeting
      set -l line0 (printf (_ '                                                                   ') (set_color green) (set_color normal))
      set -l line1 \n(printf (_ '                        .__     .__     .___                       ') (set_color green) (set_color normal))
      set -l line2 \n(printf (_ ' ___.__.  ____    ____  |  |__  |__|  __| _/_______   ____   ______') (set_color green) (set_color normal))
      set -l line3 \n(printf (_ '<   |  | /  _ \ _/ ___\ |  |  \ |  | / __ | \_  __ \ /  _ \ /  ___/') (set_color green) (set_color normal))
      set -l line4 \n(printf (_ ' \___  |(  <_> )\  \___ |   Y  \|  |/ /_/ |  |  | \/(  <_> )\___ \ ') (set_color green) (set_color normal))
      set -l line5 \n(printf (_ ' / ____| \____/  \___  >|___|  /|__|\____ |  |__|    \____//____  >') (set_color green) (set_color normal))
      set -l line6 \n(printf (_ ' \/                  \/      \/          \/                     \/ ') (set_color green) (set_color normal))
      set -l line7 \n(printf (_ '                                                                   ') (set_color green) (set_color normal))
      set -g fish_greeting "$line0$line1$line2$line3$line4$line5$line6$line7"
    end

    if set -q fish_private_mode
        set -l line (_ "fish is running in private mode, history will not be persisted.")
        if set -q fish_greeting[1]
            set -g fish_greeting $fish_greeting\n$line
        else
            set -g fish_greeting $line
        end
    end

    # The greeting used to be skipped when fish_greeting was empty (not just undefined)
    # Keep it that way to not print superfluous newlines on old configuration
    test -n "$fish_greeting"
    and echo $fish_greeting
end
