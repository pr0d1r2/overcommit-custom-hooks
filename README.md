# overcommit-custom-hooks

This repository contains custom overcommit hooks which I use in
projects.

## Configuring

Within your project if you already not having any custom overcommit hooks
you may simply do:

```sh
git clone git@github.com:pr0d1r2/overcommit-custom-hooks.git .git-hooks
```

You may also want to add it to local ignore:

```sh
echo .git-hooks/ >> .git/info/exclude
```

Select configuration you want, add it into your `.overcommit.yml`
and run `overcommit --sign`.

### All

```yaml
PreCommit:
  EnsureNoFocusInSpecs:
    enabled: true
    include: '**/*_spec.rb'
  EnsureNoByebugInFiles:
    enabled: true
  EnsureNoBindingPryInFiles:
    enabled: true

PostCheckout:
  SpringStop:
    enabled: true

PostMerge:
  SpringStop:
    enabled: true
```

### SpringStop

```yaml
PostMerge:
  SpringStop:
    enabled: true
```

and/or:

```yaml
PostCheckout:
  SpringStop:
    enabled: true
```

### EnsureNoFocusInSpecs

```yaml
PreCommit:
  EnsureNoFocusInSpecs:
    enabled: true
    include: '**/*_spec.rb'
```

### EnsureNoByebugInFiles

```yaml
PreCommit:
  EnsureNoByebugInFiles
    enabled: true
```

### EnsureNoBindingPryInFiles

```yaml
PreCommit:
  EnsureNoBindingPryInFiles
    enabled: true
```
