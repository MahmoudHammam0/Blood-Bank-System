#!/usr/bin/python3
"Email rejection function"
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


def send_rejection_email(recipient_email, subject, content):
    "send a rejection email in case of donation rejection"
    sender = "Mahmoudhammam235@gmail.com"
    password = "mhok xyzs xwam yfnx"

    message = MIMEMultipart()
    message['From'] = sender
    message['To'] = recipient_email
    message['Subject'] = subject

    message.attach(MIMEText(content, 'plain'))

    try:
        with smtplib.SMTP('smtp.gmail.com', 587) as server:
            server.starttls()
            server.login(sender, password)
            server.send_message(message)
        print("Rejection Email Sent Successfully")
    except Exception:
        print("Rejection Email Sending Failure")