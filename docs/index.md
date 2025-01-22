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

    - Basic knowledge about Linux (if you need a refresher, you could take the course "Introduction to Linux" which runs the day before this course. Info and registration here: <a href="https://www.hpc2n.umu.se/events/courses/2025/spring/linux-intro" target="_blank">https://www.hpc2n.umu.se/events/courses/2025/spring/linux-intro</a>. 
        - You can find recordings from the previous version of that course here: <a href="https://www.youtube.com/playlist?list=PL6jMHLEmPVLzoudy66m5isl2LD-YY_05L" target="_blank">https://www.youtube.com/playlist?list=PL6jMHLEmPVLzoudy66m5isl2LD-YY_05L</a>
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

- We have a course project: ``hpc2n2025-014``.
- The course project has default project storage. You can find that here: ``/proj/nobackup/kebnekaise-intro``.
- You should create a subdirectory under ``/proj/nobackup/kebnekaise-intro`` for yourself to do your exercises in. Make sure it is unique - your name/username is often a good option.
- As mentioned further up on the page, you can download the material for the course. Placing it in your directory on the project storage is a good idea. You can fetch it there with <code>git clone https://github.com/hpc2n/intro-course.git</code>. 
- We have two reservations for the course (valid only during the course time). One L40s GPU (reservation ``intro-gpu``) and one AMD Zen4 CPU node (reservation ``intro-cpu``). 
- The Q/A page can be found here: <a href="https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EbF3-wvodZVMp373M4nC_bQBhfbvM798GgigXNw-AkrTDg" target="_blank">https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EbF3-wvodZVMp373M4nC_bQBhfbvM798GgigXNw-AkrTDg</a>.
- The important info page is here: <a href="https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EWkS3sShPo1IrNLfKFaxtFQBJ9G5PeauOWsSWgSgc1SiPw?e=jXjcQD" target="_blank">https://umeauniversity.sharepoint.com/:w:/s/HPC2N630/EWkS3sShPo1IrNLfKFaxtFQBJ9G5PeauOWsSWgSgc1SiPw?e=jXjcQD</a>. 
- There is an evaluation survey for the course. Please help us by filling it! It is here: <a href="https://forms.office.com/e/DKHvTKUw3y" target="_blank">https://forms.office.com/e/DKHvTKUw3y</a>. 

## Preliminary schedule


| Time | Topic | Activity | 
| ---- | ----- | -------- |
| 09:00 | Welcome+Syllabus | |
| 09:10 | Introduction to Kebnekaise and HPC2N | Lecture |
| 09:35 | Projects and accounts | Lecture |  
| 09:50 | Logging in & editors | Lecture+exercise | 
| 10:10 | COFFEE BREAK (on your own)
| 10:25 | The File System | Lecture+code along |
| 10:45 | The Module System | Lecture+code along+exercise |
| 11:10 | Compiling | Lecture+code along+exercise |
| 11:25 | The Batch System | Lecture+code along |
| 12:00 | LUNCH BREAK | |  
| 13:00 | Simple Batch scipts, examples | Lecture+exercises | 
| 13:45 | Application Examples - part 1 | Lecture+code along+exercises |
| 14:45 | COFFEE BREAK | |  
| 15:00 | Application Examples - part 2 | Lecture+code along+exercises | 
| 16:30 | Questions+Summary | | 
| 17:00 | END OF COURSE | | 

