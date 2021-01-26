---
menu: main
title: Pricing
weight: 6
---


# Pricing

## Overview

It took a while to figure out how to farly price the harvester since it's meant to be redistributed within bots of which many of allow binding/unbinding to different machines as long as there is only one instance of the bot running at a time. Because of this, I decided not to charge by the number of unique hardware addresses, but rather session ids.

If this is an issue, I am open to discusssing other options.

## Scale

I've based the price per unique session id off this function:

```py
def calculate_invoice(unique_sessions):
    price_per_session = max(
        122.75 / (unique_sessions + 22.75)
        if unique_sessions <= 100 else
        50 / unique_sessions + .5,
        .5
    )
    return round(price_per_session * unique_sessions)
```

Here are a few common user base sizes to get a sense of how this function
preforms in the real world:

| Unique Sessions  | Price (Month)  |
|---|---|
| 1 | $5 |
| 30 | $70 |
| 50 | $84 |
| 80 | $96 |
| 100 | $100 |
| 200 | $150 |

## Payment

I'm hopping to setup something with stripe at some point, but for now I'll just be sending invoices
at the end of the month. You'll have 3 business days to pay after which I'll be forced to revoke 
access to the liceseing server until payment is recived.