---
menu: main
title: hCaptcha
weight: 3
---

# hCaptchas Example

This guide shows how to setup the harvester to collect tokens for hCaptchas.

```py
from harvester import Harvester, hCaptcha

captcha = hCaptcha(
    url='www.sotostore.com',
    sitekey='33f96e6a-38cd-421b-bb68-7806e1764460'
)

harvester = Harvester().serveforever()
intercepter = harvester.capture(captcha)
```

Next, take a look at configuring the browser and getting to the actual harvesting of the captcha tokens [here](/harvester-docs/docs/opening-the-browser)