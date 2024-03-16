function tablecopy(t) local t2={} for k,v in pairs(t) do if type(v) == "table" then t2[k] = tablecopy(v) else t2[k] = v end end return t2 end

cartdata(0)
maxlvl=dget(0)
if maxlvl==0 then maxlvl=1 end
scn = 0 -- 0:startup; 1:gameon; 2:gameover;
win = false
lose = false
lvl = 1
time={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
map = {
	{{0,1,0,0,0},{0,1,0,0,0},{0,1,0,0,0},{0,1,0,0,0},{0,2,0,0,0}},
	{{1,1,1,1},{1,2,1,1},{1,1,1,1},{1,1,1,1}},
	{{1,1,1,2},{1,1,1,1},{1,1,0,1},{1,1,1,1}},
	{{1,1,1,0},{1,1,1,2},{1,1,1,1},{1,1,1,1}},
	{{1,1,1,1},{2,0,0,1},{1,1,1,1},{1,1,1,1}},
	{{1,1,1,1},{1,2,1,1},{1,1,1,0},{1,1,1,0}},
	{{1,1,1,1},{1,0,0,1},{1,1,0,1},{1,1,2,1}},
	{{1,1,1,0},{1,2,1,1},{0,1,1,1},{0,1,1,1}},
	{{1,1,0,0},{1,2,1,0},{1,0,1,1},{1,1,1,1}},
	{{1,1,0,0},{1,1,1,1},{1,1,2,1},{0,0,1,1}},
	{{1,1,1,0},{1,1,1,0},{1,1,1,1},{0,0,2,1}},
	{{3,1,1},{1,2,1},{1,1,1}},
	{{1,1,1,1,1},{1,1,1,1,1},{1,1,2,1,1},{1,1,1,1,1},{3,1,1,1,1}},
	{{1,1,1,1,3},{1,1,1,1,2},{1,1,1,1,1},{1,1,1,0,1},{1,1,1,1,1}},
	{{1,1,1,1,0},{1,1,1,1,0},{2,1,1,1,1},{1,1,1,3,1},{1,1,1,1,1}},
	{{1,1,1,1,1},{1,1,1,1,1},{1,2,0,0,3},{1,1,1,1,1},{0,1,1,1,1}},
	{{1,1,1,1,1},{1,0,1,1,1},{1,1,1,1,1},{2,1,1,0,3},{1,1,1,0,0}},
	{{1,1,1,1,1},{1,1,1,3,1},{1,1,0,0,1},{1,1,1,0,1},{1,1,1,2,1}},
	{{1,1,1,1,0},{1,1,1,1,0},{1,1,2,1,1},{0,0,1,3,1},{0,0,1,1,1}},
	{{1,1,1,0,0},{1,1,1,0,0},{1,1,2,1,1},{1,3,0,0,1},{1,1,1,1,1}},
	{{1,1,1,0,0},{1,1,1,0,0},{1,1,1,1,1},{1,1,1,2,1},{0,0,0,3,1}},
	{{1,1,1,0,0},{1,3,1,1,0},{1,1,1,1,0},{1,1,1,1,1},{0,0,0,2,1}},
	{{0,5,1,3},{0,1,1,1},{0,1,1,1},{0,4,1,2}},
	{{5,1,1,1,1,1},{1,1,1,1,1,1},{1,1,1,1,1,1},{1,1,1,2,1,1},{1,1,1,1,1,1},{3,1,1,1,1,4}},
	{{5,1,1,1,4,1},{1,1,1,1,1,1},{1,1,1,1,1,2},{1,1,1,1,1,1},{1,3,1,1,0,1},{1,1,1,1,1,1}},
	{{1,1,1,1,1,0},{5,1,1,3,1,0},{1,1,1,1,1,0},{1,2,1,1,1,1},{1,1,1,1,1,1},{1,1,1,1,1,4}},
	{{5,1,1,1,1,1},{1,1,1,1,1,1},{1,1,4,1,1,1},{1,1,2,0,0,3},{1,1,1,1,1,1},{0,0,1,1,1,1}},
	{{4,1,1,1,1,1},{1,1,1,1,1,1},{1,1,0,0,1,1},{1,1,1,1,1,1},{5,2,1,1,3,1},{1,1,1,1,0,0}},
	{{4,1,1,1,1,1},{1,1,1,1,1,1},{1,1,0,0,3,1},{1,1,0,0,0,1},{1,1,1,1,1,5},{1,1,1,1,2,0}},
	{{1,1,1,1,0,0},{1,5,1,1,0,0},{1,1,4,1,0,0},{1,1,1,1,1,1},{1,1,1,1,2,1},{0,0,0,0,3,1}},
	{{1,1,1,1,1,1},{1,4,1,1,1,1},{1,1,1,1,1,1},{0,1,1,2,1,1},{0,1,1,1,3,1},{0,0,0,1,1,5}},
	{{5,1,1,1,0,0},{1,1,1,4,0,0},{1,1,1,1,0,0},{1,1,1,2,1,1},{1,1,1,0,0,1},{3,1,1,1,1,1}},
	{{1,1,1,1,0,0},{1,5,1,1,0,0},{1,1,3,1,1,0},{1,1,1,1,1,0},{1,1,1,1,1,1},{0,0,0,0,2,4}},
}
scn0_scroll=0
scn1_crownd=-12
scn1_swordb=0

function _init()
	if lvl>#map then lvl=1;scn=0;scn0_scroll=0 end
	scn1_swordb=0
	currentmap = tablecopy(map[lvl])
	if lvl>maxlvl then maxlvl=lvl end
	for ky,vy in pairs(currentmap) do for kx, vx in pairs(vy) do if vx==2 then x=kx;y=ky end end end
end
 
function _update()
	dset(0,maxlvl)
	if scn==0 then
		if btnp(2) then scn0_scroll-=8 elseif btnp(3) and (scn0_scroll+8)/8<maxlvl then scn0_scroll+=8 end
		if (scn0_scroll/8)+1>#map then scn0_scroll=(#map-1)*8 end
		if scn0_scroll<0 then scn0_scroll=0 end
		if btnp(4) or btnp(5) then lvl=(scn0_scroll/8)+1;scn=1;_init() end
	elseif scn==1 then
		if x == nil or y == nil then _init() end
		if btnp(0) and not win then currentmap[y][x]=0;x-=1
		elseif btnp(1) and not win then currentmap[y][x]=0;x+=1
		elseif btnp(2) and not win then currentmap[y][x]=0;y-=1
		elseif btnp(3) and not win then currentmap[y][x]=0;y+=1
		end
		if x>#currentmap or y>#currentmap or x<1 or y<1 then _init(); return end
		if currentmap[y][x]==0 then lose=true end
		currentmap[y][x]=2;win=true
		if map[lvl][y][x]==4 then scn1_swordb=1 end
		for ky, vy in pairs(currentmap) do for kx, vx in pairs(vy) do if vx==1 or vx==3 then win=false end if win==false and (map[lvl][y][x]==3 or (map[lvl][y][x]==5 and scn1_swordb==0)) then lose=true end end end
		if lose then lose=false; _init(); return end
		if win then scn1_crownd+=1.5 end
		if scn1_crownd==3+((x-1)*6)+((y-1)*6) then scn1_crownd=-12;win=false;lvl+=1;_init();return end
		if btnp(4) then scn=0 end
	end
end 

function _draw()
	cls()
	if scn==0 then
		sspr(88,0,32,17,4,4-scn0_scroll,112,60)
		print("choose level",38,71-scn0_scroll,7)
		rectfill(7,79,120,85,1)
		for i=1,#map do
			if i>maxlvl then print("level "..i.."/"..#map, 8, 80+(i-1)*8-scn0_scroll,5); print("locked",95,80+(i-1)*8-scn0_scroll,5)
			else print("level "..i.."/"..#map, 8, 80+(i-1)*8-scn0_scroll,7)
			end
		end
		rectfill(0,120,127,127,0)
		print("click ❎ button to play",16,120,7)
	elseif scn==1 then
		if lvl==1 then print("use arrows to move and destroy\nall pillars",4,113)
		elseif lvl==12 then print("save crown for the last pillar",4,120)
		elseif lvl==23 then print("use sword to kill enemy",4,120)
		else print("press 🅾️ or z to exit to menu",4,120)
		end
		for ky,vy in pairs(currentmap) do
			for kx, vx in pairs(vy) do
				if vx~=0 then
					sspr(8, 0, 16, 16, 56-((ky-1)*10)+((kx-1)*10), 10+((kx-1)*6)+((ky-1)*6))
					sspr(40, 0, 16, 16, 56-((ky-1)*10)+((kx-1)*10), 26+((kx-1)*6)+((ky-1)*6))
					sspr(24, 0, 16, 16, 56-((ky-1)*10)+((kx-1)*10), 42+((kx-1)*6)+((ky-1)*6))
				end
				if vx==2 then
					sspr(56,0,16,16,58-((ky-1)*10)+((kx-1)*10),3+((kx-1)*6)+((ky-1)*6))
					sspr(72,0,16,16,58-((ky-1)*10)+((kx-1)*10),scn1_crownd)
				elseif vx==3 then
					sspr(72,0,16,16,58-((ky-1)*10)+((kx-1)*10),3+((kx-1)*6)+((ky-1)*6))
				elseif vx==4 then
					sspr(8,16,16,16,58-((ky-1)*10)+((kx-1)*10),3+((kx-1)*6)+((ky-1)*6))
				elseif vx==5 then
					sspr(24,16,16,16,58-((ky-1)*10)+((kx-1)*10),3+((kx-1)*6)+((ky-1)*6))
				end
			end
		end
		print("level: "..lvl,4,4,7)
	end
end
