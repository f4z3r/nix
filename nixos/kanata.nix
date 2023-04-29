{ config, pkgs, ... }:
{
  services.kanata = {
    enable = true;
    keyboards.colemak = {
      devices = [ "/dev/input/event0" ];
      config = ''
        (defalias
          ;; layer toggles
          lyu (one-shot 2000 (layer-while-held up))
          lyd (one-shot 2000 (layer-while-held down))
          col (layer-switch colemakdh)
        
          ;; tapped shift
          tsh (tap-hold 100 100 ' rsft)
        
          ;; one-shot control
          osc (one-shot 2000 lctl)
        )
        (defsrc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]
          caps a    s    d    f    g    h    j    k    l    ;    '    \    ret
          lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rctl lft  down up   rght
        )
        
        (deflayer colemakdh
          tab  q    w    f    p    b    j    l    u    y    ;    bspc rsft
          lctl a    r    s    t    g    m    n    e    i    o    ret  @lyu ret
          lsft lmet x    c    d    v    z    k    h    ,    .    /    @tsh
          @col lalt @lyd           spc            @lyu rctl lft  down up   rght
        )
        
        (deflayer down
          esc  blup pgup brup volu pp   brk  7    8    9    .     bspc rsft
          del  bldn pgdn brdn vold ins  home 4    5    6    0     ret  @lyu ret
          S-6  _    _    _    mute sys  end  _    1    2    3    ,     @tsh
          _    _    @col           _              @lyu @osc mute  vold volu pp
        )
        
        (deflayer up
          grv  S-1  [    ]    S-4  S-5  _    f9   f10  f11  f12  S-2   ]
          +    =    S-9  S-0  S--  S-3  _    f5   f6   f7   f8   S-\   @col ret
          S-8  _    \    S-[  S-]  -    S-7  _    f1   f2   f3   f4   S-`
          _    _    _              _              @col rctl lft  down  up   rght
        )
      '';
      extraDefCfg = ''
        process-unmapped-keys yes
        danger-enable-cmd no
        sequence-timeout 1000
        sequence-input-mode visible-backspaced
        log-layer-changes no
        linux-continue-if-no-dev-found no
        linux-unicode-termination space
      '';
    };
  };
}
