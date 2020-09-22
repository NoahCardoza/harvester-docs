---
menu: main
title: 1 Unlocking The Harvester
---


# Unlocking The Harvester

When you recive the harvester zipfile, within in the file you'll find a `licence.key` file.
This will be a string that should look something like this `f4b038a5-110d-4f34-8e9b-afdb2090ba82`.

To access the full power of the harvester you'll have to first import the `unlock` function and
proceed as so:

```py
import harvester

err = harvester.unlock('f4b038a5-110d-4f34-8e9b-afdb2090ba82')
if err:
  raise RuntimeError(err)

from harvester import Harvester, ReCaptchaV2
```

In addition to validating the licence key, calling unlock will also
make sure you have the most recent version of the harvester avaliable.

You should call this everytime before you start using the harvester.
However, it will work without it for a couple of days until the copy
it downloads and expires.


