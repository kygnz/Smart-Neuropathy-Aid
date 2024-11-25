void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

  /* SENDING ALERTS TO PROCESSING:

  we should send alerts formatted like this (without <>):
  "ALERT|<Type>|<Message>|<Timestamp>" 
  
  when arduino detects that temperature/humidity is past a certain range,
  or if fsr sensors detect a pressure spike, the alert will be sent.

  in Processing, it takes the alert message, splits it by the bars
  and creates a class oblect of type 'Alert' using the information, then
  adds the newly created object to a list of Alerts. That way, to display the alerts 
  in processing, we only have to iterate through the list and display
  each one (alertList[i].display();)

  We can also use the type property to filter by type if we want to be fancy
  */

  Serial.println("SENSOR|Temperature|35.2");
  Serial.println("SENSOR|Pressure|120");
}
