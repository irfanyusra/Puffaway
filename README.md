# SE3350

**Deploying the Puffaway**

We are submitting an “apk” format of the application which can run on an android device. 
Instructions on how to run it:
1. Download the puffaway apk on your laptop from the root folder 
2. Connect your device and turn on file sharing 
3. Copy the apk to your phone's file manager
4. Run the apk on your phone from the file manager and wait for it to install
5. After it is installed, it's ready to use. Register an account and enjoy!!

Please note:

We made a backend for our app using python and flask. This was done as we wanted to do some machine learning to give custom recommendations to every user. Unfortunately, we could not deploy it without a server because it costs money. We thought about deploying it locally but then flutter would have to be installed on the device as we cannot run the backend on a phone, where the apk will run. It all has to be local. So we decided on having one recommendation if the backend is not connected, this was our back up plan just in case the server was not connected. The demonstration of the product with the backend functionality is provided in the demo. 

