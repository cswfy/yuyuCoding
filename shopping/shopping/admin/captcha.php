<?php
    // Start a session.
    session_start();

    // Include the IconCaptcha classes.
    require('../src/captcha-session.class.php');
    require('../src/captcha.class.php');

    use IconCaptcha\IconCaptcha;

    // Set the IconCaptcha options.
    IconCaptcha::options([
        'iconPath' => __DIR__ . '/../assets/icons/', // required, change path according to your installation.
        //'themes' => [
        //    'black' => [
        //        'icons' => 'light', // Which icon type should be used: light or dark.
        //        'color' => [20, 20, 20], // Array contains the icon separator border color, as RGB.
        //    ]
        //],
        'messages' => [
            'wrong_icon' => 'You\'ve selected the wrong image.',
            'no_selection' => 'No image has been selected.',
            'empty_form' => 'You\'ve not submitted any form.',
            'invalid_id' => 'The captcha ID was invalid.',
            'form_token' => 'The form token was invalid.'
        ],
        'image' => [
            'availableIcons' => 180, // Number of unique icons available.
            'amount' => [
                'min' => 5, // The lowest possible is 5 icons per challenge.
                'max' => 8 // The highest possible is 8 icons per challenge.
            ],
            'rotate' => true,
            'flip' => [
                'horizontally' => true,
                'vertically' => true,
            ],
            'border' => true
        ],
        'attempts' => [
            'amount' => 5,
            'timeout' => 60 // seconds.
        ],
        'token' => true
    ]);
    
    // If the form has been submitted, validate the captcha.
    if(!empty($_POST)) {
        if(IconCaptcha::validateSubmission($_POST)) {
            // Captcha submission was valid.
        } else {
            // Captcha submission was not valid.
        }
    }
?>