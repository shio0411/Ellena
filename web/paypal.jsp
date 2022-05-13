<%-- 
    Document   : paypal
    Created on : Jan 27, 2022, 3:57:11 PM
    Author     : vankh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PayPal</title>
    </head>
    <body>
        <script src="https://www.paypal.com/sdk/js?client-id=ASaPflndRRnbf67urUh1wp_yVc7eeje-rfbVrw2MxTjksRBSrgzIJGMGC_iaZbzX-a2cDQbn3Dxejkxs&currency=USD"></script>

        <!-- Set up a container element for the button -->
        <input type="number" id="paypal_amount">
        <div id="paypal-button-container" style="width: 15%"></div>

        <script>
            paypal.Buttons({

            // Sets up the transaction when a payment button is clicked
            createOrder: function (data, actions) {
            return actions.order.create({
            purchase_units: [{
            amount: {
            value: document.getElementById('paypal_amount').value // Can reference variables or functions. Example: `value: document.getElementById('...').value`
            }
            }]
            });
            },
                    // Finalize the transaction after payer approval
                    onApprove: function (data, actions) {
                    return actions.order.capture().then(function (orderData) {
                    // Successful capture! For dev/demo purposes:
                    console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                            var transaction = orderData.purchase_units[0].payments.captures[0];
                            alert('Transaction ' + transaction.status + ': ' + transaction.id + '\n\nSee console for all available details');
                            // When ready to go live, remove the alert and show a success message within this page. For example:
                            // var element = document.getElementById('paypal-button-container');
                            // element.innerHTML = '';
                            // element.innerHTML = '<h3>Thank you for your payment!</h3>';
                            // Or go to another URL:  actions.redirect('thank_you.html');
                    });
                    },
            style: {
                layout:  'vertical',
                color:   'silver',
                shape:   'pill',
                label:   'paypal'
            }
            }).render('#paypal-button-container');

        </script>
    </body>
</html>
