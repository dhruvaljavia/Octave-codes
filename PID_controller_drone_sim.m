1;
function u = getInput(ht,ht_old)
  global ctr=0;
  global E=0;
  global e_old=0;
  global Kp=0.8;
  global Ki=0.01;
  global Kd=10;
  
  ctr = ctr+1;
  
  e = ht - ht_old;
  E = E + e;
  if(ctr==1)
    e_old = e;
  endif
  del_e = e - e_old;
  u = Kp*e + Ki*E + Kd*del_e;
  e_old = e;
endfunction

function draw_drone(i)
      hold on;
      clf;
      set(gca, "xlim",[-50,50],"ylim",[-10,100]);
      rectangle('Position',[-4,-2+i,8,4],"FaceColor",[0,0,0]);
      rectangle('Position',[-6,-1+i,2,2],"FaceColor",[0,0,1]);
      rectangle('Position',[4,-1+i,2,2],"FaceColor",[0,0,1]);
      rectangle('Position',[-1,-1+i,2,2],"FaceColor",[0,0,1]);
      drawnow;
      hold off;
endfunction

function fly_drone(ref_ht)
  global g=9.81; 
  global del_t=0.1;
  
  ht=0;
  v=0;
  draw_drone(0);
  u = getInput(ref_ht,ht);
  
  while(1)
    a = u - g;
    v = v + a*del_t;
    ht = ht + v*del_t + 0.5*a*del_t*del_t;
    draw_drone(ht);
    u = getInput(ref_ht,ht);
  endwhile
endfunction

  
function drone_sim()
  fly_drone(60);
endfunction
