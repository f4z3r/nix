{
  config,
  pkgs,
  ...
}: let
  tap-timeout = "150";
  home-row-hold-delay = "150";
  hold-delay = "170";
in {
  services.kanata = {
    enable = true;
    keyboards.colemak = {
      devices = ["/dev/input/event0"];
      config = ''
        (defvar
          left-hand-keys (
              w f p
            a r s t g
              c d v
          )
          right-hand-keys (
              l u y
            m n e i o
              h , .
          )
        )

        (deffakekeys
          to-base (layer-switch colemakdh)
        )

        (defalias
          ;; shot toggles
          lyd (multi f24 (tap-hold-release ${tap-timeout} ${hold-delay} esc (layer-while-held down)))
          lyu (multi f24 (tap-hold-release ${tap-timeout} ${hold-delay} bspc (layer-while-held up)))
          nav (multi f24 (tap-hold-release ${tap-timeout} ${hold-delay} bspc (layer-while-held nav)))

          ;; home row mod, in a very complex way that does what I want
          ;; See https://github.com/jtroo/kanata/blob/main/cfg_samples/home-row-mod-advanced.kbd
          ;; does not allow to press two modifiers with the same hand at once, but needs to roll
          ;; on the modifiers with some delay
          tap (multi
            (layer-switch nomods)
            (on-idle-fakekey to-base tap 20)
          )
          q (multi f24 (tap-hold-release ${tap-timeout} ${home-row-hold-delay} q lmet))
          w (multi f24 (tap-hold-release ${tap-timeout} ${home-row-hold-delay} w lsft))
          f (multi f24 (tap-hold-release ${tap-timeout} ${home-row-hold-delay} f lctl))
          p (multi f24 (tap-hold-release ${tap-timeout} ${home-row-hold-delay} p lalt))
          ; (multi f24 (tap-hold-release ${tap-timeout} ${home-row-hold-delay} ; lmet))
          y (multi f24 (tap-hold-release ${tap-timeout} ${home-row-hold-delay} y lsft))
          u (tap-hold-release ${tap-timeout} ${home-row-hold-delay} u rctl)
          l (multi f24 (tap-hold-release ${tap-timeout} ${home-row-hold-delay} l lalt))

          ;; helpers
          arr (macro - S-.)
          dar (macro = S-.)
          not (macro S-` =)
          grt (macro S-. =)
          les (macro S-, =)

          cut (multi lctl x)
          cop (multi lctl c)
          pas (multi lctl v)

          ;; differs from piantor in
          ;; - shift is not on thumb
          ;; - home row does not allow for same hand combos
          ;; - home row modifiers on the same hand need to be tapped in sequence
          ;; - layer keys are not one-shot
          ;; - enter is not on thumb
          ;; - layer keys are outward compared to space as opposed to on the inside for
          ;;   piantor (due to large spacebar on laptop)
        )

        (defsrc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]
          caps a    s    d    f    g    h    j    k    l    ;    '    \    ret
          lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rctl lft  down up   rght
        )

        (deflayer colemakdh
          S--  @q   @w   @f   @p   b    j    @l   @u   @y   @;   S-/  XX
          tab  a    r    s    t    g    m    n    e    i    o    S-'  ret  ret
          del  XX   x    c    d    v    z    k    h    ,    .    /    '
          XX   esc  @lyd           spc            @lyu @nav lft  down up   rght
        )

        (deflayer nomods
          S--  q    w    f    p    b    j    l    u    y    ;    S-/  XX
          tab  a    r    s    t    g    m    n    e    i    o    S-'  ret  ret
          del  XX   x    c    d    v    z    k    h    ,    .    /    '
          XX   esc  @lyd           spc            @lyu @nav lft  down up   rght
        )

        (deflayer down
          f7   f8   f9   f10  f11  f12  XX   7    8    9    ,    XX   XX
          @cut S-=  S--  @cop @pas S-8  S-;  4    5    6    0    S-4  ret  ret
          XX   f1   f2   f3   f4   f5   f6   -    1    2    3    .    del
          XX   esc  @lyd           spc            @lyu bspc lft  down up   rght
        )

        (deflayer up
          @arr \    [    ]    S-4  S-2  XX   S-5  S-3  S-6  S-/  @grt XX
          @not S--  S-9  S-0  =    S-`  grv  S-\  S-1  S-8  +    @les ret  ret
          @dar XX   S-7  S-[  S-]  -    XX   XX   XX   XX   XX   XX   XX
          XX   esc  @lyd           spc            @lyu bspc lft  down up   rght
        )

        (deflayer nav
          XX   brup volu pgup home XX   XX   XX   up   XX   XX   XX   XX
          XX   brdn vold pgdn end  sys  XX   lft  down rght +    XX   XX   ret
          XX   XX   pp   mute XX   XX   XX   XX   XX   XX   XX   XX   XX
          XX   esc  @lyd           spc            @lyu bspc lft  down up   rght
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
