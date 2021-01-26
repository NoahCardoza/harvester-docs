# ReCaptcha v3 Example

This guide shows how to setup the harvester to collect tokens for Google's ReCaptcha v3.

```py
from harvester import Harvester, ReCaptchaV3

captcha = ReCaptchaV3(
    url='https://recaptcha-demo.appspot.com/recaptcha-v3-request-scores.php',
    sitekey='6LdyC2cUAAAAACGuDKpXeDorzUDWXmdqeg-xy696',
    action='examples/v3scores'
)

harvester = Harvester().serveforever()
intercepter = harvester.capture(captcha)
```

Next, take a look at configuring the browser and getting to the actual harvesting of the captcha tokens [here](/harvester-docs/docs/opening-the-browser)