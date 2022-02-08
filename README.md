# ruby-project

*GYM membership and Attendance Tracking*

user will be prompted with message like Do you want to join or already a member ?
if want to join, new member object will be created with the input params.
else attendance will be marked if membership is valid

Methods used - 

1. make_payment(plan) -> user will select a plan (monthly or annualy), which will decide the validity of membership. It will change the paid status to true.

2. is_membership_valid -> it will check if the membership is expired or still valid by calculating the number of days from the day_registered till the validity period. If expired, it will change the paid status to false

3. mark_attendance -> if it is the first day (day of registration), it will be marked as PRESENT, else the day member attended the gym will be marked as PRESENT and the days in between last_day_attended and present_day will be marked ABSENT.

4. check_attendance -> it simply shows the attendance status of the particular member.

5. is_validate_params -> it will validate the parameters (contact number and age of member).
