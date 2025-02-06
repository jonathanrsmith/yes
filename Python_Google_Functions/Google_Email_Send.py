import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def send_email(in_strSubject, in_strBody, in_strBodyFormat, in_strEmailTo, in_strSenderEmail, in_strSenderAppPW):

# in_strSubject is the Subject of the Email
# in_strBody is the body of the email, this can be in plain text or HTML, as selected with the BodyFormat variable
# in_strEmailTo is the comma deliminated list of email recipients 
# in_strBodyFormat is the format of the body, it can be set to 'plain' or 'html'
# in_strSenderEmail is the gmail account that the email will be sent from
# in_strSenderAppPW is the app password associated with the SenderEmail gmail account

    message = MIMEMultipart()
    message['From'] = in_strSenderEmail
    message['Subject'] = in_strSubject
    message['To'] = in_strEmailTo
    message.attach(MIMEText(in_strBody, in_strBodyFormat))

    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        server.starttls()
        server.login(in_strSenderEmail, in_strSenderAppPW)
        server.sendmail(in_strSenderEmail, in_strEmailTo, message.as_string())

    return True

#send_email("Python Email Test", "This email was sent using a Google Email App Password.", "plain", "michael.Griese@gsa.gov", "jonathan.smith@gsa.gov", "mgqe urke aasq azzz")