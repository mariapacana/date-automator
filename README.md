**MISSION:**
Date Automator takes the work out of scheduling dates! Using Twilio, the Automator will text message your crushes and confirms whether they would like to date you. It then schedules a date with them at a time when you are available.

**User Stories**

Completed:
* User can log in and log out 
* User password is encrypted with BCrypt
* Users provide dates and times when they are available
* Dates and times are saved into the database
* Users give information for crushes they want to date
* Crushes are saved into the database

Not Complete:
* Twilio messages all crushes on behalf of Date Automator, asking if they would like to date [user]
  * An 'exchange' is created, and this message is saved in the 'request_text' attribute of the exchange
* Twilio gets messages in response to 'Would you date [user]?'
  * The previous 'exchange' is updated; now 'response_text' is modified with the crush's response
  * If the crush is not interested, 'interested?' attribute is set to false, and they are never messaged again
* Twilio messages all interested crushes with the next available date/time (loop until date is secured or we are out of date/times)
  * A new exchange is created with the message as the 'request_text'
* Twilio gets responses from crushes
  * 'response_text' in the exchange is updated
  * Once a crush agrees on a time, 'date_scheduled?' attribute is updated and crush is not messaged again 
  * If a crush (1) picks a time that is no longer available, or (2) says no to a specific time, Twilio goes back to the beginning and sends the next available freetime
* User can view all of their currently scheduled dates

Stretch:

* User can select places where they would like to go on a date
* There is more intelligent interaction with the crushes
* User can connect to Google Calendar
* User can look through Google Contacts
