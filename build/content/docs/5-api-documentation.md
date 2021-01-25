---
menu: main
title: 5 API Documentation
---

<a name="main.Harvester"></a>
## Harvester

```python
class Harvester()
```

This is where all the magic happends. Genisis. Root. God.

Normally, you'll only need to instanciate this once within
your code.

**Arguments**:

- `host` _str, optional_ - The address you want to bind to. Defaults to '127.0.0.1'.
- `port` _int, optional_ - The port you want to listen on. Defaults to 5000.
- `do_not_track` _bool, optional_ - Disables the analytics tracking. Not recomended. Defaults to False.

<a name="main.Harvester.serveforever"></a>
#### serveforever

```python
 | serveforever() -> Thread
```

Wraps the server's serveforever method in a daemonized thread.

If you'd like do do this yourself you can call `harvester._serveforever()`

<a name="main.Harvester.shutdown"></a>
#### shutdown

```python
 | shutdown()
```

Gracefully shutsdown the server and waits for all connections to close

<a name="main.Harvester.capture"></a>
#### capture

```python
 | capture(captcha: Captcha) -> Intercepter
```

This method will use the information passed to it to
configure the server to harvest captchas on a certian
domain with the specified captcha type and sitekey.

**Arguments**:

- `captcha` _Captcha_ - An object instanciated by `ReCaptchaV2`, `ReCaptchaV3`,
  or `hCaptcha`
  

**Returns**:

- `Intercepter` - [description]
  

**Example**:

```py
captcha = ReCaptchaV3(
    url='https://recaptcha-demo.appspot.com/recaptcha-v3-request-scores.php',
    sitekey='6LdyC2cUAAAAACGuDKpXeDorzUDWXmdqeg-xy696',
    action='examples/v3scores'
)

harvester = Harvester()

intercepter = harvester.capture(captcha)
```

<a name="intercepter.Intercepter"></a>
## Intercepter

```python
class Intercepter()
```

An instance of `Intercepter` will be returned from `Harvester.capture`.

From here you'll be able to create a browser instance which will get
you one step closer to solving captchas.

This is where all the magic happends. Genisis. Root. God.

Normally, you'll only need to instanciate this once within
your code.

**Attributes**:

- `tokens` _TokenQueue_ - The queue like object that allows you
  to request tokens from the harvester windows.

<a name="intercepter.Intercepter.setup_browser"></a>
#### setup\_browser

```python
 | setup_browser(user_data_dir: str, width: int = 400, height: int = 600, browser_args: List[str] = None, extensions: List[str] = None, executable: str = None) -> Browser
```

This is the only way to instanciate a Browser instance to harvest captchas through.

After calling this method you will be able to access the browser instance via `.browser`

This method caches the browser as only one browser should be tied to
each intercepter. This may change in the future

**Arguments**:

- `user_data_dir` _str_ - This is where Chrome will store all it's data.
  It can be an empty directory. If you want to load a prevoius set of profiles,
  pass the same path the next time you call the method.
- `width` _int, optional_ - This sets the width of the browser window. Defaults to 400.
- `height` _int, optional_ - This sets the height of the browser window. Defaults to 600.
- `browser_args` _List[str], optional_ - This allows you to pass extra arguments to the
  browser process. Defaults to None.
- `extensions` _List[str], optional_ - This allows you to load any extensions you'd like
  to be loaded when starting the Chrome instance. Defaults to None.
- `executable` _str, optional_ - If for some reason Chrome is not installed in the usual
  spot or you want to use a custom binary, pass the path to binary here, or pass a
  program name that will be found in the `PATH` env variable . Defaults to None.
  

**Returns**:

- `Browser` - A browser instance that you can use to open windows to solve captchas from.

<a name="queue.TokenQueue"></a>
## TokenQueue

```python
class TokenQueue()
```

<a name="queue.TokenQueue.get"></a>
#### get

```python
 | get(timeout: float = None, poll: float = 1) -> Optional[str]
```

Contacts a harvester window to display a captcha to the user.

**Arguments**:

- `timeout` _float, optional_ - Timeout the captcha request if the
  user takes too long (seconds). Defaults to None.
- `poll` _float, optional_ - If there are no avalibe captcha harvester
  windows how often do you want check for new ones (seconds). Defaults to 1.
  

**Returns**:

- `str` - A captcha token to be submitted where ever you need it.

<a name="htypes.hCaptcha"></a>
## hCaptcha

```python
hCaptcha(url: str, sitekey: str) -> Captcha
```

Creates a Captcha instance configured to solve hCaptchas

**Arguments**:

- `url` _str_ - The full url on which the captcha is displayed.
- `sitekey` _str_ - The sitekey of the captcha.
  

**Returns**:

- `Captcha` - A Captcha instance configured with the passed arguments

<a name="htypes.ReCaptchaV2"></a>
## ReCaptchaV2

```python
ReCaptchaV2(url: str, sitekey: str) -> Captcha
```

Creates a Captcha instance configured to solve ReCaptchaV2

**Arguments**:

- `url` _str_ - The full url on which the captcha is displayed.
- `sitekey` _str_ - The sitekey of the captcha.
  

**Returns**:

- `Captcha` - A Captcha instance configured with the passed arguments

<a name="htypes.ReCaptchaV3"></a>
## ReCaptchaV3

```python
ReCaptchaV3(url: str, sitekey: str, action: str) -> Captcha
```

Creates a Captcha instance configured to solve ReCaptchaV3

**Arguments**:

- `url` _str_ - The full url on which the captcha is displayed.
- `sitekey` _str_ - The sitekey of the captcha.
- `action` _str_ - Action parameter passed when loading the captcha via JS.
  

**Returns**:

- `Captcha` - A Captcha instance configured with the passed arguments

<a name="browser.Browser"></a>
## Browser

```python
class Browser()
```

You can instantiate a brower instance like:
```py
intercepter.setup_browser(user_data_dir="harvester-browser-data")
```

<a name="browser.Browser.get_profiles"></a>
#### get\_profiles

```python
 | get_profiles() -> List['Profile']
```

Get's all the profiles that have been created by the harvester.

NOTE: If you'd like to import profiles from any user-data-dir just
prepend `Account-` before the profiles you'd like the harvester
to recognize.

**Returns**:

- `List[Profile]` - All the profiles created by the harvester.

<a name="browser.Browser.get_profile"></a>
#### get\_profile

```python
 | get_profile(name: str) -> 'Profile'
```

Returns a profile by name.

**Arguments**:

- `name` _str_ - The name of the profile
  

**Raises**:

- `ValueError` - If the profile does not exist.
  

**Returns**:

- `Profile` - A `Profile` instance from which you can control
  the browser.

<a name="browser.Browser.profile_exists"></a>
#### profile\_exists

```python
 | profile_exists(name: str) -> bool
```

Checks to see if a profile directory exists.

**Arguments**:

- `name` _str_ - The name of the profile to look up.
  

**Returns**:

- `bool` - If the directory with the passed `name` exists.

<a name="browser.Browser.new_profile"></a>
#### new\_profile

```python
 | new_profile(name: str) -> 'Profile'
```

Creates a new directory with the profile's name and
returns a new profile instance.

**Arguments**:

- `name` _str_ - The name of the new profile.
  

**Raises**:

- `ValueError` - When the name of an existing profile has been passed.
  

**Returns**:

- `Profile` - Returns a new `Profile` instance with a name that hasn't been used.

<a name="browser.Profile"></a>
## Profile

```python
class Profile()
```

You can instantiate a profile in one of hte following ways:
```py
browser.new_profile('Foo')

browser.get_profile('Foo')

browser.get_profiles()  # [Profile(Foo)]
```

<a name="browser.Profile.set_proxy"></a>
#### set\_proxy

```python
 | @verify_browser_not_running
 | set_proxy(proxy: Proxy) -> 'Profile'
```

Makes sure all connections from this profile from
hence forth are all routed through the proxy server
specified in the `Proxy` object.

**Arguments**:

- `proxy` _Proxy_ - An object describing the proxy connection.
  

**Returns**:

- `Profile` - Useful for chaining.

<a name="browser.Profile.poll"></a>
#### poll

```python
 | poll() -> bool
```

Poll to see if the browser process is still running

**Returns**:

- `bool` - `True` if the browser process is still running,
  otherwise `False`

<a name="browser.Profile.kill"></a>
#### kill

```python
 | kill()
```

Sends `SIGKILL` to the undelying browser process if
it is still running.

<a name="browser.Profile.delete"></a>
#### delete

```python
 | @verify_browser_not_running
 | delete()
```

Removes the profile directory from the `user_data_dir` passed
when calling `setup_browser`.

<a name="browser.Profile.harvest"></a>
#### harvest

```python
 | @verify_browser_not_running
 | harvest()
```

Opens a browser window pointing to domain passed to
`harvester.capture(...)`, sepcially configured to solve
captchas.

<a name="browser.Profile.launch"></a>
#### launch

```python
 | @verify_browser_not_running
 | launch(url: str = None, app: bool = False)
```

Opens a window for the user to do anything they want, usually before calling `.harvest()`.

NOTE: This method waits for the user to close the browser process.
On macOS this means the whole process must be quit, not just
the window.

**Arguments**:

- `url` _str, optional_ - Open the browser to a specific url. Defaults to None.
- `app` _bool, optional_ - Open the browser window with the `--app=<url>` flag. Defaults to False.

<a name="browser.Profile.login_to_google"></a>
#### login\_to\_google

```python
 | @verify_browser_not_running
 | login_to_google(login_url: str = DEFAULT_LOGIN_URL)
```

Opens a window for the user to login to Google via a YouTube endpoint, usually before calling `.harvest()`

NOTE: This method waits for the user to close the browser process.
On macOS this means the whole process must be quit, not just
the window.

**Arguments**:

- `login_url` _str, optional_ - If you'd like to login via a different endpoint, pass it here. Defaults to
  [accounts.google.com](https://accounts.google.com/signin/v2/identifier?hl=en&service=youtube&continue=https%3A%2F%2Fwww.youtube.com%2Fsignin%3Ffeature%3Dsign_in_button%26hl%3Den%26app%3Ddesktop%26next%3D%252F%26action_handle_signin%3Dtrue&passive=true&uilel=3&flowName=GlifWebSignIn&flowEntry=ServiceLogin).

<a name="browser.proxy.Proxy"></a>
## Proxy

```python
@dataclass
class Proxy()
```

Create a Proxy object to be passed to `Profile.set_proxy()`.
```py
proxy = Proxy(host='127.0.0.1', port=9436)
authed_proxy = Proxy(host='127.0.0.1', port=9436, username='bar', password='foo')
```

