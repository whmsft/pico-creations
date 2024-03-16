cartdata(0)
sfx(0)
p={x=55,y=55,s=1,v=0}
f={x=10,y=-4}
b={}
dt={1,0}
mode=0
hi=dget(0)
score=0

function collide(x1,y1,w1,h1,x2,y2,w2,h2)
	return (x1<x2+w2 and x1+w1>x2 and y1<y2+h2 and h1+y1>y2)
end

function _update()
	if mode==1 then
		p.s=flr((time()/0.25)%2+1)
		if(btn(⬅️))p.s=3;p.x-=8
		if(btn(➡️))p.s=4;p.x+=8
		if(btnp(⬆️))p.v=12;p.y-=2
		if(btnp(⬇️))p.v=-8
		if(p.x<2)p.x=2
		if(p.x>118)p.x=118
		if(p.y<110)p.y-=p.v;p.v-=2
		if(p.y>110)p.v=0;p.y=110
		if(p.y<=0)p.y=0;p.v=-4
		f.x-=4
		if(f.x<-16)f.x=150
		if flr(time()%2)==1then f.y-=0.5else f.y+=0.5end
		if(time()-dt[2]>dt[1])add(b,{x=f.x+8,y=f.y,s=0});dt[1]=rnd(0.25);dt[2]=time()
		for i=1,#b do
			if i<=#b then 
				b[i].y+=4
				if b[i].y<20 then
					b[i].x-=4;b[i].s=1
				elseif b[i].y<64 then
					b[i].x-=2;b[i].s=1
				else
					b[i].s=0
				end
				if(b[i].y>110)deli(b,i);score+=1
				if collide(b[i].x+1,b[i].y,6,8,p.x,p.y,8,8) then
					b={}
					mode=0
					dt={1,0}
					p={x=55,y=55,s=1,v=0}
					if(hi<score)hi=score;dset(0,hi)
					score=0
				end
			end
		end
	else
		if(btnp(❎)or btnp(🅾️))mode=1
	end
end
function _draw()
	if mode==1 then
		cls()
		for i=1,#b do
			spr(5+b[i].s,b[i].x,b[i].y)
		end
		print("bombs avoided:"..score,2,121,7)
		spr(p.s,p.x,p.y)
		sspr(7*8,0,16,8,f.x,f.y,32,16)
		line(0,119,127,119,7)
		rect(0,0,127,127,7)
	else
		cls()
		print("press ❎ or 🅾️ to start",1,1,7)
		sspr(8,8,48,48,9,9)
		sspr(8*flr(time()/0.25%2+1),0,8,8,53,33,32,32)
		print("highscore: "..hi,40,68,7)
	end
end
