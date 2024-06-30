{
  config,
  pkgs,
  ...
}: {
  services.kanata = {
    enable = true;
    keyboards.colemak = {
      devices = ["/dev/input/event0"];
      config = ''
        (defalias
          ;; backspace is not mapped like on piantor setup but should work fine

          ;; alt keys
          at1 (multi lalt 1)
          at2 (multi lalt 2)

          ;; shot toggles
          osc (one-shot 2000 lctl)
          tab (tap-hold-release 140 140 tab lctl)
          lyd (tap-hold-release 140 140 esc (layer-while-held down))
          spc (tap-hold-release 140 140 spc lsft)
          lyu (multi f24 (tap-hold-release 140 140 ret (layer-while-held up)))
          att (multi f24 (tap-hold-release 140 140 esc lalt))
        )
        (defsrc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]
          caps a    s    d    f    g    h    j    k    l    ;    '    \    ret
          lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rctl lft  down up   rght
        )

        (deflayer colemakdh
          @at1 q    w    f    p    b    j    l    u    y    ;    @at2 XX
          @tab a    r    s    t    g    m    n    e    i    o    lalt ret  ret
          XX   lmet x    c    d    v    z    k    h    ,    .    /    del
          XX   @att @lyd           @spc           @lyu @osc XX   XX   XX   XX
        )

        (deflayer down
          f9   f10  f11  f12  pgup home XX   7    8    9    ,    @at2 XX
          f5   f6   f7   f8   pgdn end  ;    4    5    6    0    S-4  ret  ret
          XX   f1   f2   f3   f4   XX   XX   sys  1    2    3    .    del
          XX   @att @lyd           @spc           S-'  '    XX   XX   XX   XX
        )

        (deflayer up
          brup \    [    ]    S-4  S-2  volu S-\  S-`  S-1  S-5  @at2 XX
          brdn S--  S-9  S-0  =    grv  vold lft  down up   rght lalt ret  ret
          XX   pp   S-7  S-[  S-]  -    XX   mute S-8  +    S-3  /    del
          XX   @att @lyd           @spc           @lyu @osc XX   XX   XX   XX
        )
      '';
      extraDefCfg = ''
        process-unmapped-keys yes
        danger-enable-cmd no
        sequence-timeout 1000
        sequence-input-mode visible-backspaced
        log-layer-changes no
        linux-unicode-termination space
      '';
    };
  };
}
