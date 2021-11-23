# Stripe Subscriptions with iOS
This example app demonstrates how to integrate Stripe subscriptions with the prebuilt payment UI

## Requirements
- Create an account with [Stripe](https://dashboard.stripe.com/register)
- Set up a server to run the backend code. Code used for this sample can be found in `server.js`
- iOS 14.0+
- Xcode 13.0+

## Setup
- Update the following values found in `Constants.swift`
  - [Stripe Publishable API Key](https://dashboard.stripe.com/apikeys)
  - URL of server `e.g. https://pickled-rural-watcher.glitch.me`
  - Price ID of the product the subscription is for `e.g. price_1Jw...` 
