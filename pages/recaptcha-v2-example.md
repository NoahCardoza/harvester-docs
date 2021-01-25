# ReCaptcha v2 Example

This guide shows how to setup the harvester to collect tokens for Google's ReCaptcha v2.

**NOTE**: This example assumes you have already unlocked the harvester. For more information
on that see [here](/docs/unlocking-the-harvester)

```py
from harvester import Harvester, ReCaptchaV2

captcha = ReCaptchaV2(
    url='www.supremenewyork.com',
    sitekey='6LeWwRkUAAAAAOBsau7KpuC9AV-6J8mhw4AjC3Xz'
)

harvester = Harvester().serveforever()
intercepter = harvester.capture(captcha)
```

Next, take a look at configuring the browser and getting to the actual harvesting of the captcha tokens [here](/docs/opening-the-browser)