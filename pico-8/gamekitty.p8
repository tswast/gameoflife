pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--gamekitty
--by tim swast

states={
 { --1: sitting
 	s={0},
 	next={1,2},--,8},
 },
 { --2: stand-up
  s={1,2,3,4},
  next={3},--6,9},
 },
 { --3: stand to walk/strut
  s={34,35},
  next={14}, --4
 },
 { --4: strut
  s={
   36,37,38,39,
   --skip 40, standing
  },
  next={5},
  xo=-1, --move left at end
 },
 { --5: strut, other foot
  s={41,42,43,44},
  next={4,6},
  xo=-1,  --move left at end
 },
 { --6: stand waggle
  s={26,4},
  next={4,6,7,9,10},
 },
 { --7: sit down
  s={57,58,59,60,61,62,63,64,65,66},
  next={1},
 },
 { --8: turn from sitting
  s={10,11,12,13,14,15,16},
  next={3},
  flipx=true,
 },
 { --9: turn from standing
  s={18,19,20,21,22,23,24,25},
  next={6},
  flipx=true,
 },
 { --10: stand to jump
  s={46,47,48,49},
  xo=-1,
  next={11},
 },
 { --11: jump, start
  s={50,51,45},
  next={12},
  xo=-1,
 },
 { --12: jump, end
  s={52,48,49},
  next={11,13},
  xo=-1,
 },
 { --13: jump to stand
  s={53,54,55},
  next={3,6,7,10},
 },
 { --14: walk
  s={84},
  next={15},
  xo=-1,
 },
 { --15: walk
  s={85,86,87,88,89,90},
  next={16},
  xo=-1,
 },
 { --15: walk 3
  s={91,92,93,94},
  next={17},
  xo=-1,
 },
 { --16: walk 4
  s={95,96,97,98},
  next={14},
  xo=-1,
 },
}

cat={
 x=64,
 state=1,
 ssi=1, --state sprite index
 flipx=false,
 frame=1,
}


function _update()
 --decrease frame rate by 3x
 if cat.frame<3 then
  cat.frame+=1
  return
 end
 cat.frame=1
 
 if cat.x<-8 then
  cat.x=127+7
 end
 if cat.x>127+8 then
  cat.x=-7
 end
 
 cat.ssi=cat.ssi+1
	local state=states[cat.state]
 if cat.ssi>#state.s then
 	cat.ssi=1
 	cat.state=state.next[
 	 flr(rnd(#state.next))+1]

		local xdir=1
		if cat.flipx then
		 xdir=-1
		end
 	if state.flipx then
 	 cat.flipx = not cat.flipx
 	end

 	--init new state
 	local state=states[cat.state]
 	cat.x+=xdir*(state.xo or 0)
 end
end


function _draw()
 local state=states[cat.state]
 local si=state.s[cat.ssi]
	cls(7)
	rectfill(0, 119, 127, 127, 15)
	spr(
	 si, cat.x, 111,
	 1, 1, cat.flipx)
	--shadow
	--rect(cat.x+2, 120, cat.x+8, 120, 4)
end
__gfx__
05050000050500000505000050500000505005005050005005050050050500500505000005050000050500000050500000505001000505010001050500100505
01510000015100000151000015100050151005501510005501510055015100550151000001510000015100000015100000151011000151010001115100110151
0555d0000555d00005555d00555d0055555d005055555d0505555d0505555d0505555d010555d0000555d0000055500000555010000555110000155500010555
00555d0000555d00005555d105555d0505555550055555d5005555d5005555d5005555d100555d0000555d000055d5d100555510005555100001555000155550
005555d0005555d000555551055555550555555005555555005555550055555500555551005555d0005555d00055555100555510005555100005555000555550
00555550005555500055555501555550055555500155555000555550005155500055555100555550005555500055555100555550000555100005555000555550
00515551005d55510055055500d501500505015000d5015000550150005d01500050515500515551005d55510051d555000d55500001d5100001555000555d50
00d1dd5500d11d5500dd1d50000d1d500d0d01d0000d01d000dd01d000d001d00000d1d000d1dd5500d11d5500d01d5000011d1000011d1000011dd0005110d0
00100505000000005050050005050100050501000050510000505100000150500001050500010505505000505050005050500005505005005050050050500500
00100151000000001510055001510110015101100015110000151100001115100011015100110151151000501510000515100055151005001510055015100550
0110d55500000000555d005005550010055500100055510000555100001055500010d5550010d555555d0050555d0055555d0050555d0150555d0050555d0050
05555550000000000555555000555510005555100055550000555500005555000155555001555550055555500555555005555550055555500555555005555550
05555550000000000555555000555550005555500055550000555500005555000155555001555550055555500555555005555550055555500555555005555550
05555555000000000555555000555550005555500055510000555100005555000155555001555550055555500555555005555550015555500555555005555550
0511050d0000000000d50150005051500050d15000515100000d510000515d00005105500051055d0505015005d001500505015000d501500505015005050150
05100d0000000000000d01d000d0d15000d0015000d1d1000001d10000510d0000510dd000510d000d0d01d00d0001d00d0d01d0000d01d00d0d01d00d0d01d0
50500050505000055050050000050050000500500005005000050050005005005050005000050050000500500005005000500500000500050505005000000005
15100005151000551510055005150055051500550515005505150055515005501510005005150055051500550515005551500550051500d50151005550500005
555d0055555d0050555d00500555d0050555d0050555d0050555d005555d0050555d00500555d0050555d0050555d005555d00500555d55505555d05151d55d5
05555550055555500555555000555555005555550055555500555555055555500555555000555555005555550055555505555550005555550d5555d555555555
05555550055555500555555000555555005555550055555500555555055555500555555000555555005555550055555505555550005555550555555505555555
05555550055555500155555000555555005555550055555500555550055555500555555000555555005555550055555005555550005555500155555015555555
05d001500505015000d5015000150015001d001500d0001d005000d0051005100505051000510051005000510050015001500150001d51d500d50150d0d00150
0d0001d00d0d01d0000d01d0001d001d0010001d001000100d1000100d100d100d0d0d1000d000d100d000d001d000d001d001d000000000000d01d00000001d
00000005000000000000000000000000005000050000000000500000005000505050050050500050050500500505005005050000050500000505000005050000
00500d55005000050005000500050005515000d50050dd0551500005515000501510055015100055015100550151005501510000015100000151000001510000
515d5555515d55d50515d5d50515d5d5555d5555515d555555555d55555d0050555d005055555d0505555d0505555d0505555d010555d0000555d0000555d000
555555555555555505555555055555550555555555555555055555500555555005555550055555d5005555d5005555d5005555d100555d0000555d0000555d00
05555550055555500055555500555555055555500555555005555550055555500555555005555555005555550055555500555551005555500055555005555550
055555500555555000555555015555501555555005555550055555500555555005555550015555500055555000515550005555510055555105555551d5555551
15501d001550155001551550010d01501d501d0015501550150d5550015001500505015000d5015000550150005d015000505155005055510d01555100015551
d5000000d501d5000d51d5000000001d000000001d01d5001d001d0001d001d00d0d01d0000d01d000dd01d000d001d000d0d1d000d0d1d50011d1550011d155
05050000050500000505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01510000015100000151000005050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0555d0000555d0000555d00001510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555d0000555d0000555d000555dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555550005555500055555000555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555551005555510055555105555551000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00d15551000d55510051555105155555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0011d1550011d15500d1d1d50d1d11d5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
50500050505000050505005000050050000500050050000500500005005000050050000500500050005000050050000500500005005000050050000500050005
15100005151000550151005505150055051500055150000551500005515000055150005551500050515000555150000551500005515000055150005505150005
555d0055555d00500555d0050555d0050555d055555d0055555d0055555d0055555d0050555d0550555d0050555d0055555d0055555d0055555d00500555d055
05555550055555500055555500555555005555550555555505555555055555550555555005555550055555500555555505555555055555550555555000555555
05555550055555500055555500555555005555550555555505555555055555550555555005555550055555500555555505555555055555550555555000555555
05555550055555500015555500555555005555550555555505555555055555550555555005555550055555500555115505555115055555150555555000555555
05d0015005050150000d501500150005001500050150000505100015051000150510015005100115051001550511001501550015015500150150015000150015
0d0001d00d0d01d00000d01d001d000d00d5000d0d50001dd510011d0d11011d0d11110d0d10110d0d00110d015d001d110d001d110d00d501d0d510001d0d51
00500005005000050050005000500500505005000505005000000005000000050000000000000000000000000000000000000000000000000000000000000000
5150000551500005515000505150055015100550015100555050000500500d550000000000000000000000000000000000000000000000000000000000000000
555d0055555d0055555d0550555d0050555d005005555d05151d55d5515d55500000000000000000000000000000000000000000000000000000000000000000
05555555055555550555555005555550055555500d5555d555555555555555550000000000000000000000000000000000000000000000000000000000000000
05555555055555550555555005555550055555500555555505555555055555550000000000000000000000000000000000000000000000000000000000000000
05555555015555550555555005555550055555500155555015555555055555500000000000000000000000000000000000000000000000000000000000000000
015000d5015000d501500150015001500505015000d50150d0d0015015501d000000000000000000000000000000000000000000000000000000000000000000
0d500d510d100d5101d001d001d001d00d0d01d0000d01d00000001d1d0000000000000000000000000000000000000000000000000000000000000000000000
