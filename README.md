Nix package for [sigbak](https://github.com/tbvdm/sigbak)
=========================================================

```
nix run github:niols/nixpkg-sigbak --
```

Refer to the upstream repository for how to use sigbak.

The specific commit of sigbak is tracked via a flake input `sigbak`, which
currently tracks the branch `portable` of the upstream repository. It can be
updated using `nix flake update` or overridden to track another branch, tag, or
commit with:

```
nix run github:niols/nixpkg-sigbak --override-input sigbak github:tbvdm/sigbak/master --
nix run github:niols/nixpkg-sigbak --override-input sigbak github:tbvdm/sigbak/474e8c16abf0fb89575babbcd18c6136bb1cc482 --
```
