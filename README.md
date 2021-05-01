# TJButton
*A UIButton that does more*

`UIButton` is a surprisingly powerful class, but there are some common things I've found repeating over and over again in apps that I wished were available. This class adds some of those things, namely.

- Setting a background color per-control state (`-setBackgroundColor:forState:`)
- Setting a tint color per-control state (`-setTintColor:forState:`)
- Hit target expansion (`-setHitOutsets:`)

Also, not strictly related to `UIButton`, but I also find myself adding a corner radius, stroke width/color, and using `kCACornerCurveContinuous` if available (iOS 13+). I turned this all into a handy category method on `UIView`: `-tj_applyCornerRadius:borderWidth:borderColor:`.