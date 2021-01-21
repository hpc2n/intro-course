program add

      implicit none
      integer i
      real*8  x,summ

      summ=0.0d0

      open(3,file='file_pdb.txt',status='unknown')
      do i=1,129
         read(3,*) x
         summ=summ+x
      enddo
      close(3)
      
      write(6,*) summ/129.0d0

end program add
