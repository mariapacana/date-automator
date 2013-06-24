User Stories

Completed:
- User can log in and log out 
- User password is encrypted with BCrypt
- Users provide dates and times when they are available
- Dates and times are saved into the database
- Users give information for crushes they want to date
- Crushes are saved into the database

Not Complete:
- Twilio messages all crushes on behalf of Date Automator, asking if they would like to date [user]
-- An 'exchange' is created, and this message is saved in the 'sent_text' attribute of the exchange
- Twilio gets messages in response to 'Would you date [user]?'
-- The previous 'exchange' is updated; now 'response_text' is modified with the crush's response
-- If the crush is not interested, 'interested?' attribute is set to false, and they are never messaged again
- Twilio messages all interested crushes with the first available date/time (loop until date is secured or we are out of date/times)
-- A new exchange is created with the message as the 'sent_text'
- Twilio gets responses from crushes
-- 'response_text' in the exchange is updated
-- Once a crush agrees on a time, 'date_scheduled?' attribute is updated and crush is not messaged again (for now)
-- If a crush (1) picks a time that is no longer available, or (2) says no to a specific time, Twilio sends a nother message

Stretch:

- User can select places where they would like to go on a date
- There is more intelligent interaction with the crushes
- User can connect to Google Calendar
- User can look through Google Contacts

SCHEMA
<?xml version="1.0" encoding="utf-8" ?>
<!-- SQL XML created by WWW SQL Designer, http://code.google.com/p/wwwsqldesigner/ -->
<!-- Active URL: http://socrates.devbootcamp.com/sql -->
<sql>
<datatypes db="mysql">
  <group label="Numeric" color="rgb(238,238,170)">
    <type label="Integer" length="0" sql="INTEGER" re="INT" quote=""/>
    <type label="Decimal" length="1" sql="DECIMAL" re="DEC" quote=""/>
    <type label="Single precision" length="0" sql="FLOAT" quote=""/>
    <type label="Double precision" length="0" sql="DOUBLE" re="DOUBLE" quote=""/>
  </group>

  <group label="Character" color="rgb(255,200,200)">
    <type label="Char" length="1" sql="CHAR" quote="'"/>
    <type label="Varchar" length="1" sql="VARCHAR" quote="'"/>
    <type label="Text" length="0" sql="MEDIUMTEXT" re="TEXT" quote="'"/>
    <type label="Binary" length="1" sql="BINARY" quote="'"/>
    <type label="Varbinary" length="1" sql="VARBINARY" quote="'"/>
    <type label="BLOB" length="0" sql="BLOB" re="BLOB" quote="'"/>
  </group>

  <group label="Date &amp; Time" color="rgb(200,255,200)">
    <type label="Date" length="0" sql="DATE" quote="'"/>
    <type label="Time" length="0" sql="TIME" quote="'"/>
    <type label="Datetime" length="0" sql="DATETIME" quote="'"/>
    <type label="Year" length="0" sql="YEAR" quote=""/>
    <type label="Timestamp" length="0" sql="TIMESTAMP" quote="'"/>
  </group>

  <group label="Miscellaneous" color="rgb(200,200,255)">
    <type label="ENUM" length="1" sql="ENUM" quote=""/>
    <type label="SET" length="1" sql="SET" quote=""/>
    <type label="Bit" length="0" sql="bit" quote=""/>
  </group>
</datatypes><table x="118" y="287" name="users">
<row name="id" null="1" autoincrement="1">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="firstname" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="lastname" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="email" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="phone" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="password_hash" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="PRIMARY" name="">
<part>id</part>
</key>
</table>
<table x="575" y="266" name="crushes">
<row name="id" null="1" autoincrement="1">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="id_users" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="users" row="id" />
</row>
<row name="firstname" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="lastname" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="phone" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="interested?" null="1" autoincrement="0">
<datatype>BINARY</datatype>
<default>NULL</default></row>
<row name="date_scheduled?" null="1" autoincrement="0">
<datatype>BINARY</datatype>
<default>NULL</default></row>
<key type="PRIMARY" name="">
<part>id</part>
</key>
</table>
<table x="345" y="416" name="freetimes">
<row name="id" null="1" autoincrement="1">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="start_time" null="1" autoincrement="0">
<datatype>DATETIME</datatype>
<default>NULL</default></row>
<row name="id_users" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="users" row="id" />
</row>
<row name="id_crushes" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="crushes" row="id" />
</row>
<key type="PRIMARY" name="">
<part>id</part>
</key>
</table>
<table x="348" y="96" name="exchanges">
<row name="id" null="1" autoincrement="1">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="id_users" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="users" row="id" />
</row>
<row name="id_crushes" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="crushes" row="id" />
</row>
<row name="request_text" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="response_text" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="type" null="1" autoincrement="0">
<datatype>ENUM</datatype>
<default>NULL</default></row>
<row name="created_at" null="1" autoincrement="0">
<datatype>TIMESTAMP</datatype>
<default>NULL</default></row>
<row name="updated_at" null="1" autoincrement="0">
<datatype>TIMESTAMP</datatype>
<default>NULL</default></row>
<key type="PRIMARY" name="">
<part>id</part>
</key>
</table>
</sql>
