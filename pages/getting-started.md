
# Getting Started

## Where to get a copy

Right now the harvester is in active beta. To git a copy, you must fill out this [Google Form](https://docs.google.com/forms/d/e/1FAIpQLSeT7hg_lXxAb8jBX_I1MrEmV6vp4OIKoKqNB1cPdiOs2R_ybA/viewform?usp=sf_link).

It's also a good idea to send me a message on Discord (@MacHacker#7322) just in
case I forgoet to check over the form responses.

While you wait, if you plan to purchase a copy, you can fill out this [Google Form](https://docs.google.com/forms/d/e/1FAIpQLScaW7RPL0IesbE_1UmxcsbIrLzJwUBPBZklq4P_odzn5MlIEw/viewform?usp=sf_link)
to help me estimate how many users I'll have to suppoort. You can find pricing
details here.

## Licensing

Apon reciving a copy, you'll be provided with a zipfile (`<your-discord-handle>-Beta.zip`) which will differ based
on how you filled out the registration form. It'll structured something like this:

```
/package/<py-version>/<platform>/
  harvester/
  example.py
  hconfig.py
  secret.py
```

Besides the actual harvester code within `harvester/` the next most important file is
`hconfig.py`. Your example `hconfig.py` will look something like this:

```py
from hashlib import md5
from secrets import key

# Note: must be a string: 10 <= len(session) <= 100
session = md5(key).hexdigest()
```

While the `secrets.py` file is just to complete the example, the `hconfig.py` is required to start the harvester.
It can be placed in any directory where it will be able to be imported with `import hconfig`.

At the moment the only required and used value is the `session` variable decalred in the file. When the
harvester talks to my licensing server, it will send whatever value is stored in the `session` variable.
My server will check if any other harvester using that **session id** is running. If not, the server
will respond with the proper keys to activate the harvester. Otherwise it will raise an error letting
the user know another copy of the harvester is running with that **session id**.

It is recommended that you base the session off the user's license key or something unique to the user
(across multiple machines).

## Exports

These are all the classes made avalible upon successful activation:

```py
from harvester import Harvester, ReCaptchaV2, ReCaptchaV3, hCaptcha, Proxy
```

+ `Harvester` - The main class that allows you to spin up a server and launch a Chrome browser to intercept the captcha tokens.
+ `ReCaptchaV2` - A ReCaptcha V2 config NamedTuple to be passed to the Harvester class.
+ `ReCaptchaV3` - A ReCaptcha V3 config NamedTuple to be passed to the Harvester class.
+ `hCaptcha` - An hCaptcha config NamedTuple to be passed to the Harvester class.
+ `Proxy` - A proxy config NamedTuple for the browser instances.