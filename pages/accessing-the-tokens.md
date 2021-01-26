# Accessing The Tokens

This guide shows you how to request tokens after [launching a browser window](/harvester-docs/docs/opening-the-browser).

While this can be done before launching a browser, it wouldn't make much
sense since there would be no way for the user to solve the captchas.

Here is a simple example that will wait for the user to press enter before
requesting a token. After receiving it, the token it printed to the screen.

```py
intercepter = harvester.capture(captcha)
while True:
    input('> ')
    token = intercepter.tokens.get()
    print(token)
```

