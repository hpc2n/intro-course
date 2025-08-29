# Welcome to the course: Introduction to Kebnekaise

!!! note "This material"
   
    Here you will find the content of the workshop "Introduction to Kebnekaise". 

    You can download the markdown files for the presentation as well as the exercises from <a href="https://github.com/hpc2n/intro-course " target="_blank">https://github.com/hpc2n/intro-course</a>

    - Click the green "Code" button
         - Either copy the url for the repo under HTTPS and do <code>git clone https://github.com/hpc2n/intro-course.git</code> in a terminal window
         - OR pick "Download zip" to get a zip file with the content. 
 
    Some useful links: 

    - Documentation about Linux at HPC2N: <a href="https://docs.hpc2n.umu.se/tutorials/linuxguide/" target="_blank">https://docs.hpc2n.umu.se/tutorials/linuxguide/</a>
    - Get started guide: <a href="https://docs.hpc2n.umu.se/tutorials/quickstart/" target="_blank">https://docs.hpc2n.umu.se/tutorials/quickstart/</a>
    - Documentation pages at HPC2N: <a href="https://docs.hpc2n.umu.se/" target="_blank">https://docs.hpc2n.umu.se/</a> 

!!! note "Prerequisites"

    - Basic knowledge about Linux (if you need a refresher, you can find the recordings from the previous version of that course here: <a href="https://www.youtube.com/watch?v=AmT6NA2j3Fk&list=PL6jMHLEmPVLzLr4i8ME2A-PUtawhkilbq" target="_blank">https://www.youtube.com/watch?v=AmT6NA2j3Fk&list=PL6jMHLEmPVLzLr4i8ME2A-PUtawhkilbq</a>
        - If you want to take the "Introduction to Linux course, then it will be given again on 22 September 2025. You can find the information and registration page for that course here: <a href="https://www.hpc2n.umu.se/events/courses/2025/fall/1/intro-linux" target="_blank">https://www.hpc2n.umu.se/events/courses/2025/fall/1/intro-linux</a>
    - An account at SUPR and at HPC2N. You should have already been contacted about getting these if you did not have them already. 

!!! note "Content"
 
    - This course aims to give a brief, but comprehensive introduction to Kebnekaise.
    - You will learn about
       - HPC2N, HPC, and Kebnekaise hardware
       - How to use our systems: 
           - Projects and Accounts 
           - Logging in & editors
           - The File System
           - The Module System
           - Compiling and linking
           - The Batch System
       - Simple examples (batch system)
       - Application examples (batch system)

    - This course will consist of lectures and type-alongs, as well as a few exercises where you get to try out what you have just learned.    

**Instructors**

- Birgitte Brydsö, HPC2N
- Pedro Ojeda-May, HPC2N

## Important info

- We have a course project: ``hpc2n2025-151``.
- The course project has default project storage. You can find that here: ``/proj/nobackup/fall-courses``.
- You should create a subdirectory under ``/proj/nobackup/fall-courses`` for yourself to do your exercises in. Make sure it is unique - your name/username is often a good option.
- As mentioned further up on the page, you can download the material for the course. Placing it in your directory on the project storage is a good idea. You can fetch it there with <code>git clone https://github.com/hpc2n/intro-course.git</code>. 
- We have two reservations for the course (valid only during the course time). One L40s GPU (reservation ``intro-gpu``) and one AMD Zen4 CPU node (reservation ``intro-cpu``). 
- The Q/A page can be found here: <a href="https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EUVzB_5AT2pAlQZWKeks6PEB2CMBLNXP7vuOPWCDiwm1vg?e=GW1vYO" target="_blank">https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EUVzB_5AT2pAlQZWKeks6PEB2CMBLNXP7vuOPWCDiwm1vg?e=GW1vYO</a>
- The important info page is here: <a href="https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EQedrXAXwa1AsvZ7nG3StzUBl87szldizr82mR56ZNfIfA?e=O4GMjb" target="_blank">"https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EQedrXAXwa1AsvZ7nG3StzUBl87szldizr82mR56ZNfIfA?e=O4GMjb</a> 
- There is an evaluation survey for the course. Please help us by filling it! It is here: <a href="https://forms.office.com/e/xFLgdD9TSU" target="_blank">https://forms.office.com/e/xFLgdD9TSU</a>. 

## Preliminary schedule


| Time | Topic | Activity | 
| ---- | ----- | -------- |
| 09:00 | Welcome+Syllabus | |
| 09:10 | Introduction to Kebnekaise and HPC2N | Lecture |
| 09:35 | Projects and accounts | Lecture |  
| 09:50 | Logging in & editors (including Open OnDemand) | Lecture+exercise | 
| 10:15 | COFFEE BREAK (on your own)
| 10:30 | The File System | Lecture+code along |
| 10:45 | The Module System | Lecture+code along+exercise |
| 11:10 | Compiling | Lecture+code along |
| 11:25 | The Batch System | Lecture+code along |
| 12:00 | LUNCH BREAK | |  
| 13:00 | Simple Batch scipts, examples | Lecture+exercises | 
| 13:45 | Application Examples - part 1 | Lecture+code along+exercises |
| 14:45 | COFFEE BREAK | |  
| 15:00 | Application Examples - part 2 | Lecture+code along+exercises | 
| 16:30 | Questions+Summary | | 
| 17:00 | END OF COURSE | | 

