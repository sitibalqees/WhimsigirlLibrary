<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LibraryThing</title>
    <style>
        body {
            font-family: Georgia, serif;
            background-color: #fdf9f5;
            margin: 0;
            padding: 0;
            text-align: center;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            padding: 50px 20px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            position: relative;
            z-index: 1;
        }
        h1 {
            color: #4b2e2e;
            font-size: 3em;
            margin-bottom: 0;
        }
        h2 {
            color: #4b2e2e;
            font-weight: normal;
            font-size: 1.5em;
            margin-top: 0;
        }
        p {
            font-size: 1.1em;
            color: #4b2e2e;
            max-width: 500px;
            margin: 20px auto;
        }
        .buttons {
            margin-top: 30px;
        }
        .btn {
            background-color: #8b3f3f;
            color: white;
            border: none;
            padding: 15px 30px;
            font-size: 1em;
            margin: 0 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.2s;
        }
        .btn:hover {
            background-color: #a24d4d;
        }
        .or {
            display: inline-block;
            margin: 0 10px;
            font-weight: bold;
            color: #4b2e2e;
        }
        .side-image {
            position: absolute;
            left: 0;
            top: 0;
            width: 100px;
            height: auto;
            z-index: 0;
        }
        @media (max-width: 600px) {
            .container {
                padding: 30px 5px;
            }
            .side-image {
                display: none;
            }
        }
    </style>
</head>
<body>
    <img src="image/Whimsigirl Logo.jpg" class="side-image" alt="Books">
    <div class="container">
        <h1>LibraryThing</h1>
        <h2>A Home For Your Books.</h2>
        <p>LibraryThing is a free, library-quality catalog to track reading progress or your whole library.</p>
        <div class="buttons">
            <button class="btn" onclick="window.location.href='Login.jsp'">Sign In</button>
            <span class="or">or</span>
            <button class="btn" onclick="window.location.href='Register.jsp'">Register Now</button>
        </div>
    </div>
</body>
</html>