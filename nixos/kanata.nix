{
  config,
  pkgs,
  ...
}: let
  hold-delay = "150";
in {
  services.kanata = {
    enable = true;
    keyboards.colemak = {
      devices = ["/dev/input/event0"];
      config = ''
        (defalias
          ;; shot toggles
          tab (tap-hold-release ${hold-delay} ${hold-delay} tab lctl)
          met (multi f24 (tap-hold-release ${hold-delay} ${hold-delay} S-. lmet))
          lyd (multi f24 (tap-hold-release ${hold-delay} ${hold-delay} esc (layer-while-held down)))
          spc (tap-hold-release ${hold-delay} ${hold-delay} spc lsft)
          lyu (multi f24 (tap-hold-release ${hold-delay} ${hold-delay} bspc (layer-while-held up)))

          ;; differs from piantor to allow alt usage as not mapped on thumbs
          qu (multi f24 (tap-hold-release ${hold-delay} ${hold-delay} ' lalt))

          ;; differs from piantor in
          ;; - layer keys are not one-shot
          ;; - enter is not on thumb
          ;; - alt is not on thumbs but pinky
          ;; - control is not on thumbs but pinky
          ;; - layer keys are outward compared to shift and space as opposed to on the inside for
          ;;   piantor (due to large spacebar on laptop)
        )
        (defsrc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]
          caps a    s    d    f    g    h    j    k    l    ;    '    \    ret
          lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rctl lft  down up   rght
        )

        (deflayer colemakdh
          S-3  q    w    f    p    b    j    l    u    y    ;    S-/  XX
          @tab a    r    s    t    g    m    n    e    i    o    @qu  ret  ret
          XX   @met x    c    d    v    z    k    h    ,    .    /    del
          XX   esc  @lyd           @spc           @lyu bspc lft  down up   rght
        )

        (deflayer down
          f9   f10  f11  f12  pgup home XX   7    8    9    ,    S-/  XX
          f5   f6   f7   f8   pgdn end  S-;  4    5    6    0    S-4  ret  ret
          XX   f1   f2   f3   f4   XX   XX   sys  1    2    3    .    del
          XX   esc  @lyd           @spc           @lyu bspc lft  down up   rght
        )

        (deflayer up
          brup \    [    ]    S-4  S-2  XX   S-\  up   S-1  S-5  volu XX
          brdn S--  S-9  S-0  =    S-`  grv  lft  down rght +    vold ret  ret
          XX   pp   S-7  S-[  S-]  -    XX   XX   S-8  S-6  XX   S-3  mute
          XX   esc  @lyd           @spc           @lyu bspc lft  down up   rght
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
