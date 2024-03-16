sfx(0)
screen=0
t,f=true,false
lvl={0,{
		{t="200",s=4,f=.95,e=1,n="fox bay"},
		{t="150",s=6,f=.9,e=2,n="port howard"},
		{t="100",s=8,f=.9,e=1,n="goose green"},
		{t="050",s=8,f=.8,e=2,n="raf mount pleasant"},
		{t="",s=10,f=.8,e=2,n="stanley"}
	}
}
p={64,105,f,{}}
e={}
a={16,f}
l={5," "}
k=0
s={}

function uplvl()
	lvl[1]+=1
	if lvl[1]<6 then
		for x=1,lvl[2][lvl[1]].e do
			add(e,{4,6,t,{},0,0,{4,8,10},8,lvl[2][lvl[1]].s,lvl[2][lvl[1]].f,16,f})
		end
		a={16,f}
		p[4]={}
	else
    a={1,f}
		p[4]={}
	end
end

function collide(x1,y1,w1,h1,x2,y2,w2,h2)
	return (x1<x2+w2 and x1+w1>x2 and y1<y2+h2 and h1+y1>y2)
end

for i=1,40 do add(s,{rnd(127),rnd(127)}) end
function _update()
	if screen==10 then
		if(btnp(🅾️))screen=1;uplvl();sfx(-1);sfx(1)
	end
	if screen==0 then
		if(btnp(❎))screen=1;uplvl();sfx(-1);sfx(1)
		if(btnp(🅾️))screen=2
	elseif screen==2 then
		if(btnp(❎))screen=0
	elseif screen==1 then
    if lvl[1]<6 then
      l[2]=""
      if(l[1]<0)run();sfx(-1);sfx(0)
      if(lvl[1]!=6)if(#e==0)screen=10;sfx(-1);sfx(2)
      for i=1,l[1]do l[2]=l[2].."♥" end
      --p
      if(btn(⬅️))p[1]-=8;p[3]=t
      if(btn(➡️))p[1]+=8;p[3]=f
      if(btnp(❎)and a[1]>0and a[2]==f)add(p[4],{p[1]+4,p[2]-4});a[1]-=1
      if(p[1]>123)p[1]=-2
      if(p[1]<-2)p[1]=123
      if(a[1]<1)a[2]=t
      if(a[2]==t)a[1]+=.5
      if(a[1]==16)a[2]=f
      --e
      for x in all(e)do
        for i=1,#x[4] do
          if(collide(x[4][i][1]+1,x[4][i][2],6,6,p[1],p[2],16,16))l[1]-=1;deli(x[4],i);break
          if(x[4][i][2]>128)deli(x[4],i);break
          x[4][i]={x[4][i][1],x[4][i][2]+8}
        end
        x[6]+=1
        if(x[6]>x[7][flr(rnd(3)+1)])x[5]=flr(rnd(3));x[6]=0
        if(rnd(1)>x[10] and x[11]>0 and x[12]==f and flr(time()%4)==0)add(x[4],{x[1]+4,x[2]+16});x[11]-=1
        if(x[5]==0)x[1]-=x[9];x[3]=t
        if(x[5]==1)x[1]+=x[9];x[3]=f
        if(x[1]>123)x[1]=-2
        if(x[1]<-2)x[1]=123
        if(x[11]<1)x[12]=t
        if(x[12]==t)x[11]+=.5
        if(x[11]==16)x[12]=f
      end
      --pb
      for x in all(e) do
        for i=1,#p[4] do
          if(collide(p[4][i][1]+1,p[4][i][2],6,6,x[1],x[2],16,16))then
            x[8]-=1
            deli(p[4],i)
            if(x[8]==0)k+=1;del(e,x)
            break
          end
          if(p[4][i][2]<0)then
            deli(p[4],i);break
          end
          p[4][i]={p[4][i][1],p[4][i][2]-8}
        end
      end
    end
    if lvl[1]==6 then
      if(btnp(❎) and a[1]>0)add(p[4],{p[1]+4,p[2]-4});a[1]-=1
      if(btn(⬅️))p[1]-=8;p[3]=t
      if(btn(➡️))p[1]+=8;p[3]=f
      if(btnp(❎)and a[1]>0and a[2]==f)add(p[4],{p[1]+4,p[2]-4});a[1]-=1
      if(p[1]>123)p[1]=-2
      if(p[1]<-2)p[1]=123
      if #p[4]==1 then
        p[4][1]={p[4][1][1],p[4][1][2]-8}
        if(p[4][1][2]<0)run();sfx(-1);sfx(0)
        if(collide(p[4][1][1]+1,p[4][1][2],6,6,60,24,7,7))p[4][1][2]=99999;screen=500
      end
    end
  end
end

function _draw()
 cls(0)
  if screen==500 then
   sspr(0,32,66,96,0,0,66,96)
 		print("finally!\nyou've done\nit.\n\nyou're now\nthe great\nfield marshal.",70,4,7)
 		print("hit the <3rd button> or <esc>\nand reset cart to restart.",4,100,7)
  end
	if screen==10 then
		print("you are at the yellow spot",4,68,1)
		print("we've captured:\n "..lvl[2][lvl[1]].n,4,80,7)
		print("hit 🅾️ (or z) to continue.",4,120,6)
		if lvl[1]!=5 then
		 print("next stop:\n "..lvl[2][lvl[1]+1].n,4,100,7)
		else
			print("reaching the glorious:\n humanity destruction unit.",4,100,7)
		end
		if lvl[1]==1 then
			sspr(0,16,32,16,0,0,128,64)
		elseif lvl[1]==2 then
			sspr(32,16,32,16,0,0,128,64)
		elseif lvl[1]==3 then
			sspr(64,16,32,16,0,0,128,64)
		elseif lvl[1]==4 then
			sspr(96,16,32,16,0,0,128,64)
		elseif lvl[1]==5 then
			sspr(96,0,32,16,0,0,128,64)
		end
	end
 if screen==0 then
 	sspr(48,0,24,8,0,0,72,24)
 	sspr(72,0,24,8,0,28,72,24)
 	sspr(8,0,16,16,76,4,48,48)
 	print("press 🅾️ (or z) for story!",4,110,7)
 	print("press ❎ (or x) to start off!",4,120,7)
 elseif screen==2 then
		print("press ❎ to go back\n\napr 2, 2032\nthe city of stanley is seized\nby the dystopic anti-human\nleague (dahl), as a royal guard\nstationed at fox bay, your\nmission is to liberate the\ncity. crossing through port\nhoward, raf mount pleasant,\nand goose green, reach\nstanley, and\nconfront the humanity\ndestruction unit (hdu), a\nticking time bomb,\nnow malfunctioning. using\nyour skills, defuse it, saving\nhumanity.",4,4,7)
		print("made with ♥ in ◆pico-8",4,120,7)
 elseif screen==1 then
	 for i=1,#s do pset(s[i][1],s[i][2],6)end
	 if lvl[1]==5 then
		 print(lvl[2][lvl[1]].t.."just at stanley",34,60,1)
	 elseif lvl[1]<5 then
		 print(lvl[2][lvl[1]].t.."m to stanley",34,60,1)
	 end
		for i=1,#p[4] do
			spr(3,p[4][i][1],p[4][i][2])
		end
		if lvl[1]<6 then
			for x in all(e) do
				for i=1,#x[4] do
					spr(19,x[4][i][1],x[4][i][2],1,1)
				end
			end
		end
		spr(1,p[1],p[2],2,2,p[3])
		if lvl[1]<6 then
			for x in all(e)do
				spr(4,x[1],x[2],2,2,x[3],t)
				rectfill(x[1],x[2]+20,x[1]+x[8]*2,x[2]+22,8)
			end
		end
		if #e==1 then
			rectfill(0,0,e[1][11]*8,4,8)
		elseif #e==2 then
			rectfill(0,0,e[1][11]*4,4,8)
			rectfill(64,0,64+e[2][11]*4,4,8)
		end
		rectfill(0,122,a[1]*8,127,12)
		print(l[2],2,8,7)
		if lvl[1]==6 then
			spr(22,60,24)
			print("one shot,\n all done,\n  or all gone.",36,52,1)
		end
		rect(0,0,127,127,7)
	end
end
