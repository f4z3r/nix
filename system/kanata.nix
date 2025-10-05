{...}: let
  tap-timeout = "150";
  home-row-hold-delay = "150";
  hold-delay = "170";
in {
  services.kanata = {
    enable = true;
    keyboards.colemak = {
      devices = ["/dev/input/event0"];
      config = ''
        (deffakekeys
          to-base (layer-switch colemakdh)
        )

        ;; enable underscore on shifted escape, using both shifts as I don't have shift on thumb on
        ;; virtual keyboard
        (defoverrides
          (lsft esc) (lsft -)
          (rsft esc) (lsft -)
        )

        (defalias
          ;; shot toggles
          lyd (tap-hold-release ${tap-timeout} ${hold-delay} esc (layer-while-held down))
          lyu (tap-hold-release ${tap-timeout} ${hold-delay} tab (layer-while-held up))
          nav (tap-hold-release ${tap-timeout} ${hold-delay} bspc (layer-while-held nav))

          ;; helpers
          hom (macro S-` spc /)
          atab (multi lalt tab)

          grt (macro S-. =)
          ctly (multi lctl y)
          les (macro S-, =)

          arr (macro - S-.)
          dar (macro = S-.)
          not (macro S-` spc =)

          cop (multi lctl c)
          pas (multi lctl v)
          all (multi lctl a)

          dquo (macro S-' spc)
          quo (macro ' spc)

          ;; home row mod, in a very complex way that does what I want
          ;; See https://github.com/jtroo/kanata/blob/main/cfg_samples/home-row-mod-advanced.kbd
          ;; does not allow to press two modifiers with the same hand at once, but needs to roll
          ;; on the modifiers with some delay
          tap (multi
            (layer-switch nomods)
            (on-idle-fakekey to-base tap 20)
          )
          q (tap-hold-release ${tap-timeout} ${home-row-hold-delay} q lmet)
          w (tap-hold-release ${tap-timeout} ${home-row-hold-delay} w lsft)
          f (tap-hold-release ${tap-timeout} ${home-row-hold-delay} f lctl)
          p (tap-hold-release ${tap-timeout} ${home-row-hold-delay} p lalt)
          ; (tap-hold-release ${tap-timeout} ${home-row-hold-delay} ; lmet)
          y (tap-hold-release ${tap-timeout} ${home-row-hold-delay} y lsft)
          u (tap-hold-release ${tap-timeout} ${home-row-hold-delay} u rctl)
          l (tap-hold-release ${tap-timeout} ${home-row-hold-delay} l lalt)

          ;; differs from piantor in
          ;; - shift is not on thumb
          ;; - home row does not allow for same hand combos
          ;; - home row modifiers on the same hand need to be tapped in sequence
          ;; - layer keys are not one-shot
          ;; - enter is not on thumb
          ;; - layer keys are outward compared to space as opposed to on the inside for
          ;;   piantor (due to large spacebar on laptop)
          ;; - tilde not on escape
        )

        (defsrc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]
          caps a    s    d    f    g    h    j    k    l    ;    '    \    ret
          lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rctl lft  down up   rght
        )

        (deflayer colemakdh
          @hom  @q    @w   @f   @p   b    j    @l   @u   @y   @;   @grt  XX
          @atab a     r    s    t    g    m    n    e    i    o    @ctly ret  ret
          lsft  lsft  x    c    d    v    z    k    h    ,    .    -     rsft
          XX   del    @lyd           spc            @lyu @nav lft  down  up   rght
        )

        (deflayer nomods
          @hom  q    w    f    p    b    j    l    u    y    ;   @grt  XX
          @atab a    r    s    t    g    m    n    e    i    o   @ctly ret  ret
          lsft  lsft x    c    d    v    z    k    h    ,    .   -     rsft
          XX   del  @lyd           spc            @lyu  @nav lft  down   up   rght
        )

        (deflayer down
          XX   f8   f9   f10  f11  f12   ,    7    8    9    .    XX   XX
          XX   f6   @all @cop @pas f7    S-'  4    5    6    S-;  XX   ret  ret
          XX   XX   f1   f2   f3   f4    f5   '    1    2    3    -    XX
          XX   del  @lyd           spc             0    bspc lft  down up   rght
        )

        (deflayer up
          @arr S-7  [    ]    S-4  grv  XX   S-`  S-\  S-/  XX   XX   XX
          @dar S-8  S-9  S-0  /    S-5  S-6  =    S-1  S-=  S-2  @grt ret  ret
          @not @not \    S-[  S-]  S-3  XX   XX   XX   XX   XX   @les XX
          XX   @quo @dquo          spc            @lyu bspc lft  down up   rght
        )

        (deflayer nav
          XX   brup volu pgup home XX   XX   XX   up   XX   XX   XX   XX
          del  brdn vold pgdn end  sys  XX   lft  down rght +    XX   XX   ret
          pp   XX   XX   mute XX   XX   XX   XX   XX   XX   XX   XX   XX
          XX   del  @lyd           spc            @lyu bspc lft  down up   rght
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
