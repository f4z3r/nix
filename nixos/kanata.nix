{
  config,
  pkgs,
  ...
}: let
  tap-timeout = "220";
  hold-delay = "170";
in {
  services.kanata = {
    enable = true;
    keyboards.colemak = {
      devices = ["/dev/input/event0"];
      config = ''
        (defalias
          ;; shot toggles
          lyd (multi f24 (tap-hold-release ${tap-timeout} ${hold-delay} esc (layer-while-held down)))
          lyu (multi f24 (tap-hold-release ${tap-timeout} ${hold-delay} bspc (layer-while-held up)))
          nav (multi f24 (tap-hold-release ${tap-timeout} ${hold-delay} bspc (layer-while-held nav)))

          ;; use shorter hold delay on space as shift is more central here
          spc (tap-hold-release ${hold-delay} ${hold-delay} spc lsft)

          ;; a r s t n e i o (cannot use f24 multi for umlaut)
          a (tap-hold-release ${tap-timeout} ${hold-delay} a lsft)
          r (tap-hold-release ${tap-timeout} ${hold-delay} r lmet)
          s (tap-hold-release ${tap-timeout} ${hold-delay} s lctl)
          t (tap-hold-release ${tap-timeout} ${hold-delay} t lalt)
          o (tap-hold-release ${tap-timeout} ${hold-delay} o rsft)
          i (tap-hold-release ${tap-timeout} ${hold-delay} i lmet)
          e (tap-hold-release ${tap-timeout} ${hold-delay} e rctl)
          n (tap-hold-release ${tap-timeout} ${hold-delay} n lalt)

          ;; helpers
          arr (macro - S-.)
          dar (macro = S-.)
          not (macro S-` =)
          grt (macro S-. =)
          les (macro S-, =)

          ;; differs from piantor in
          ;; - layer keys are not one-shot
          ;; - enter is not on thumb
          ;; - layer keys are outward compared to shift and space as opposed to on the inside for
          ;;   piantor (due to large spacebar on laptop)
          ;; - arrows still work
        )
        (defsrc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]
          caps a    s    d    f    g    h    j    k    l    ;    '    \    ret
          lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rctl lft  down up   rght
        )

        (deflayer colemakdh
          S-3  q    w    f    p    b    j    l    u    y    ;    S-/  XX
          tab  @a   @r   @s   @t   g    m    @n   @e   @i   @o   '    ret  ret
          XX   XX   x    c    d    v    z    k    h    ,    .    /    del
          XX   esc  @lyd           @spc           @lyu @nav lft  down up   rght
        )

        (deflayer down
          f9   f10  f11  f12  XX   XX   XX   7    8    9    ,    XX   XX
          f5   f6   f7   f8   S--  XX   S-;  4    5    6    0    S-4  ret  ret
          XX   f1   f2   f3   f4   XX   XX   sys  1    2    3    .    del
          XX   esc  @lyd           @spc           @lyu bspc lft  down up   rght
        )

        (deflayer up
          @arr \    [    ]    S-4  S-2  XX   S-5  S-3  S-6  S-/  @grt XX
          @not S--  S-9  S-0  =    S-`  grv  S-\  S-1  S-8  +    @les ret  ret
          @dar XX   S-7  S-[  S-]  -    XX   XX   XX   XX   XX   XX   XX
          XX   esc  @lyd           @spc           @lyu bspc lft  down up   rght
        )

        (deflayer nav
          XX   brup volu pgup home XX   XX   XX   up   XX   XX   XX   XX
          XX   brdn vold pgdn end  sys  XX   lft  down rght +    XX   XX   ret
          XX   XX   pp   mute XX   XX   XX   XX   XX   XX   XX   XX   XX
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
