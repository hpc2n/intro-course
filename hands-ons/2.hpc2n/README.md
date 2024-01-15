# Connecting to HPC2N’s systems 

---
## 0. NOTES

This is a short test for you to do to check if you can login to HPC2N's systems.

If you have already done so in the past, this is a good time to take a short break and go and get a cup of coffee/tea/whatever. 

In order to login to HPC2N, you need an SSH client and potentially an X11 server if you want to open graphical displays (for running MATLAB, for instance).

Another option is to use ThinLinc to connect. See below. 

## 1. ThinLinc

Unless you already have a preferred setup for connecting, we strongly recommend using ThinLinc, particularly for the second half of this course since there will be exercises where you use the graphical interface (i.e. MATLAB). 

ThinLinc includes everything needed and is quick to install.

You can either connect with the stand-alone client (fully featured), which you download from here (all OS): https://www.cendio.com/thinlinc/download

Or through the Web Access Desktop: https://kebnekaise-tl.hpc2n.umu.se:300/ 

**Guide**: 

- ThinLinc (all OS): https://www.hpc2n.umu.se/documentation/guides/thinlinc

**Password**:

You get your first, temporary HPC2N password from this page: [HPC2N passwords](https://www.hpc2n.umu.se/forms/user/suprauth?action=pwreset).

The above page can also be used to reset your HPC2N password if you have forgotten it.

Note that you are authenticating through SUPR, using *that* service’s login credentials!

The HPC2N password and the SUPR password are separate! The HPC2N password and your university/department password are also separate! 

### 1.1 Exercise

- Download and install ThinLinc

## 2. Logging in to Kebnekaise

Remember, the username and password for HPC2N are separate from your SUPR credentials! 

**ThinLinc**:

- Start the ThinLinc client
- Enter the name of the server: kebnekaise-tl.hpc2n.umu.se 
- Enter your own username at HPC2N under “Username”

There are a few settings which should be changed:

- Go to “Options” -> “Security” and check that authentication method is set to password.
- Go to “Options” -> “Screen” and uncheck “Full screen mode”.
- Enter your HPC2N password here instead of waiting for it to prompt you as that will fail

You can now click “Connect”. You should just click “Continue” when you are being told that the server’s host key is not in the registry.

After a short time, the thinlinc desktop opens, running Mate. It is fairly similar to the Gnome desktop. All your files on HPC2N should now be available.

### 2.1 Exercise

- Login to HPC2N using ThinLinc

### 2.2 Exercise 

- Change your password to something that is easier to remember than the auto-generated one.

This is done using the passwd command:

```
passwd
```

Use a good password that combines letters of different case. Do not use dictionary words. Avoid using the same password that you also use in other places.

It will first ask for your current password. Type in that and press enter. Then type in the new password, enter, and repeat. You have changed the password.

### 2.3 Exercise (optional) 

- Also try connecting with the Web Access Desktop: https://kebnekaise-tl.hpc2n.umu.se:300/