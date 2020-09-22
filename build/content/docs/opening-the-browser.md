---
menu: main
title: 3 Opening The Browser
---

# Opening The Browser

This guide shows you how to launch a browser instance after getting an intercepter
instance back from `harvester.capture`.

<!-- **NOTE**: This example assumes you have already unlocked the harvester. For more information
on that see [here](/docs/unlocking-the-harvester) -->

## Quick Recap

We'll be using a `ReCaptchaV2` in this example, but you are able to pass any of the
captcha configs and the browser API will work in the exact same way.

```py
from harvester import Harvester, ReCaptchaV2

captcha = ReCaptchaV2(
    url='www.supremenewyork.com',
    sitekey='6LeWwRkUAAAAAOBsau7KpuC9AV-6J8mhw4AjC3Xz'
)

harvester = Harvester().serveforever()
intercepter = harvester.capture(captcha)
```

You'll probaby recognize the code above as being pulled straight from the [ReCaptcha V2 Example](/docs/recaptcha-v2-example/)!

Now lets get to setting up the browser.

```py
browser = intercepter.setup_browser(user_data_dir='ChromeData')
```

The code above will return a new `Browser` instance. Keep in mind that calling
`setup_browser` again will return the same instance it returned the first time.
This might change in the future.

The `user_data_dir` can be a path to an existing `user-data-dir`, or it can be to
a folder than doesn't exist yet, in which case the folder will be created. Make
sure any parent folders have already been created though.


Now we'll have to get access to a `Profile` object to actually lauch a window.

## A Simple Example

```py
# check to see if any profiles exist already
if not browser.get_profiles():
    # create a new profile
    profile = browser.new_profile('Foo')
    # this will open a window which allows the user to login to google
    # it will block until the user close the browser, browser, not the window
    profile.login_to_google()
else:
    # load the profile that should exist after running the code a second time
    profile = browser.get_profile('Foo')

# this will create a window which will connect to the server
# and display captcha's to the user when they are requested
# later in in the code
profile.harvest()
```

## Loops For The Win

Using the power of the for loop, we'll initiate a couple of profiles, log them
into Google, and then open them to start harvesting ReCaptcha v2 tokens. 

```py
# check to see if any profiles exist already
existing_profiles = len(browser.get_profiles())
if existing_profiles < 6:
    for i in range(existing_profiles - 6):
        profile = browser.new_profile(f'Foo-{i}')
        profile.login_to_google()

for profile in browser.get_profiles():
    profile.harvest()
```

The code above will open at least 6 windows unless more than 6 profiles
already existed before running the code.

## Using Proxies

To setup a proxy all you need to do is:

```py
from harvester import Proxy

proxy = Proxy(
    host='127.0.0.1,
    port=9487
)
```

### Authenicated Proxies

To use authenicated proxies, all you need to do is
pass a username and password like:

```py
proxy = Proxy(
    host='127.0.0.1,
    port=9487,
    username='foo',
    password='bar'
)
```

### Setting The Proxy

To actually set a proxy in a profile, all you need to do is call
`.set_proxy`.

```py
proxy = Proxy(
    host='127.0.0.1,
    port=9487
)

if not browser.get_profiles():
    profile = browser.new_profile('Foo')
    profile.set_proxy(proxy) # from now on all requests will be proxied
    profile.login_to_google()
else:
    # set proxy is setup for chaining so you can use it like this too
    profile = browser.get_profile('Foo').set_proxy(proxy)

profile.harvest()
```

Finally, we are ready to [access the tokens](/docs/accessing-the-tokens)!