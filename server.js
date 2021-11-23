const express = require("express");
const app = express();
const { resolve } = require("path");
const stripe = require("stripe")(process.env.secret_key); // https://stripe.com/docs/keys#obtain-api-keys

app.use(express.static("."));
app.use(express.json());

// An endpoint for creating a new Stripe customer
app.post("/subscribe", async (req, res) => {
  // Create or retrieve the Stripe Customer object associated with your user.
  let customer = await stripe.customers.create({
    email: req.body.email
  });

  // Create subscription for customer
  const subscription = await stripe.subscriptions.create({
    customer: customer.id,
    items: [{ price: req.body.priceID }],
    payment_behavior: "default_incomplete",
    expand: ["latest_invoice.payment_intent"]
  });

  // Send the client secret of payment intent to the client
  res.send({
    paymentIntent: subscription.latest_invoice.payment_intent.client_secret,
    customer: customer.id,
  });
});
