--[[
    Author: GG3L (@GGӡL)
    Script: Book
    Description: This script adds the possibility to create a book that can be opened.
    
    Permission is granted to use this script in custom rooms for Escape Simulator, provided that:
    - Credit is given to the author.
    - Neither this header nor the code is modified.

    Unauthorized distribution or modification is prohibited.
    All rights reserved by the author.
]]
if callType==LuaCallType.Init then a=book[1]["\103\97\109\101\79\98\106\101\99\116"]["\70\105\110\100"]('MainCamera')b=book[1]["\103\97\109\101\79\98\106\101\99\116"]["\70\105\110\100\71\97\109\101\79\98\106\101\99\116\87\105\116\104\84\97\103"]('MainCamera')c=false if a~=b then c=true end d=85 e=.024 f=1 g={}h={}i={}j={}k={}l={}m={}n={}o={}p={}q={}r={}s={}t={}u={}v={}w={}x={}for y,z in pairs(book)do g[y]=z["\116\114\97\110\115\102\111\114\109"]["\71\101\116\67\104\105\108\100"](0)["\116\114\97\110\115\102\111\114\109"]["\70\105\110\100"]('Spine')h[y]=z["\116\114\97\110\115\102\111\114\109"]["\71\101\116\67\104\105\108\100"](0)["\116\114\97\110\115\102\111\114\109"]["\70\105\110\100"]('CoverFront')i[y]=z["\116\114\97\110\115\102\111\114\109"]["\71\101\116\67\104\105\108\100"](0)["\116\114\97\110\115\102\111\114\109"]["\70\105\110\100"]('CoverBack')j[y]=z["\116\114\97\110\115\102\111\114\109"]["\71\101\116\67\104\105\108\100"](0)["\116\114\97\110\115\102\111\114\109"]["\70\105\110\100"]('PagesFront')k[y]=z["\116\114\97\110\115\102\111\114\109"]["\71\101\116\67\104\105\108\100"](0)["\116\114\97\110\115\102\111\114\109"]["\70\105\110\100"]('PagesBack')l[y]=api["\103\101\116\69\108\101\109\101\110\116"](z)l[y]["\115\111\117\110\100\80\105\99\107\117\112"]='event:/SFX/VICTORIAN/VICTORIAN1/Book/bookPickUp'l[y]["\115\111\117\110\100\80\108\97\99\101"]='event:/SFX/VICTORIAN/VICTORIAN1/Book/bookDrop'l[y]["\115\111\117\110\100\84\104\114\111\119\79\114\68\114\111\112"]='event:/SFX/VICTORIAN/VICTORIAN1/Book/bookDrop'l[y]["\115\111\117\110\100\79\114\98\105\116"]='event:/SFX/VICTORIAN/VICTORIAN1/Book/bookOrbit'l[y]["\115\111\117\110\100\72\105\116"]='event:/SFX/VICTORIAN/VICTORIAN1/Book/bookHit'l[y]["\112\105\110\83\99\97\108\101\77\111\100\105\102\105\101\114"]=.7 l[y]["\98\111\117\110\100\115\85\112\100\97\116\101"]=3 l[y]["\103\114\111\117\110\100\69\117\108\101\114\65\110\103\108\101\115"]=api["\118\101\99\116\111\1143"](90,180,0)l[y]["\101\117\108\101\114\65\110\103\108\101\115\72\97\110\100\69\110\97\98\108\101\100"]=true z.pivot=z["\116\114\97\110\115\102\111\114\109"]z["\111\114\105\103\105\110\97\108\84\114\97\110\115\102\111\114\109"]=z["\116\114\97\110\115\102\111\114\109"]m[y]=0 n[y]=false o[y]=true p[y]=0 if not c then z["\114\101\109\111\116\101\79\110\108\121"]=false bookSwitchFront[y]["\103\97\109\101\79\98\106\101\99\116"]["\83\101\116\65\99\116\105\118\101"](false)bookSwitchBack[y]["\103\97\109\101\79\98\106\101\99\116"]["\83\101\116\65\99\116\105\118\101"](false)else bookSwitchFront[y]["\116\114\97\110\115\102\111\114\109"]["\112\97\114\101\110\116"]=h[y]bookSwitchBack[y]["\116\114\97\110\115\102\111\114\109"]["\112\97\114\101\110\116"]=i[y]bookSwitchFront[y].pivot=bookSwitchFront[y]["\116\114\97\110\115\102\111\114\109"]bookSwitchFront[y]["\111\114\105\103\105\110\97\108\84\114\97\110\115\102\111\114\109"]=bookSwitchFront[y]["\116\114\97\110\115\102\111\114\109"]bookSwitchBack[y].pivot=bookSwitchBack[y]["\116\114\97\110\115\102\111\114\109"]bookSwitchBack[y]["\111\114\105\103\105\110\97\108\84\114\97\110\115\102\111\114\109"]=bookSwitchBack[y]["\116\114\97\110\115\102\111\114\109"]end q[y]={Quaternion.identity,Quaternion.identity}r[y]={Quaternion.identity,Quaternion.identity}s[y]={Vector3.zero,Vector3.zero}t[y]={Quaternion.identity,Quaternion.identity}u[y]={Quaternion.identity,Quaternion.identity}v[y]={Vector3.zero,Vector3.zero}w[y]=0 end function A(B,C,D)return B+(C-B)*D end function E(F)if F<0.5 then return 2*F*F end return-1+(4-2*F)*F end function G(H)I=H["\103\97\109\101\79\98\106\101\99\116"]["\71\101\116\67\111\109\112\111\110\101\110\116"]('Element')J=string.match(I["\112\108\97\121\101\114\86\97\114\105\97\98\108\101\78\97\109\101"],"{(%d+)}")return tonumber(J)end end if callType==LuaCallType.SwitchDone then if api.contains(book,context)or api.contains(bookSwitchFront,context)or api.contains(bookSwitchBack,context)and context.isOn then K=G(context)if n[K]or not o[K]then return end p[K]=Time["\116\105\109\101"]o[K]=false L=d M=e if m[K]==1 then m[K]=0 L=-L M=-M l[K]["\101\117\108\101\114\65\110\103\108\101\115\84\97\114\103\101\116"]=Vector3.zero l[K]["\103\114\111\117\110\100\69\117\108\101\114\65\110\103\108\101\115"]=api["\118\101\99\116\111\1143"](90,180,0)l[K]["\101\117\108\101\114\65\110\103\108\101\115\72\97\110\100"]=api["\118\101\99\116\111\1143"](0,0,0)else m[K]=1 l[K]["\101\117\108\101\114\65\110\103\108\101\115\84\97\114\103\101\116"]=api["\118\101\99\116\111\1143"](0,90,0)l[K]["\103\114\111\117\110\100\69\117\108\101\114\65\110\103\108\101\115"]=api["\118\101\99\116\111\1143"](0,270,90)l[K]["\101\117\108\101\114\65\110\103\108\101\115\72\97\110\100"]=api["\118\101\99\116\111\1143"](0,90,0)end t[K][1]=Quaternion.Euler(h[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].x,h[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].y+L,h[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].z)q[K][1]=h[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]t[K][2]=Quaternion.Euler(i[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].x,i[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].y-L,i[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].z)q[K][2]=i[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]u[K][1]=Quaternion.Euler(j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].x,j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].y+L,j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].z)r[K][1]=j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]u[K][2]=Quaternion.Euler(k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].x,k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].y-L,k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\69\117\108\101\114\65\110\103\108\101\115"].z)r[K][2]=k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]v[K][1]=api["\118\101\99\116\111\1143"](j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"].x+M,j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"].y,j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"].z)s[K][1]=j[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"]v[K][2]=api["\118\101\99\116\111\1143"](k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"].x+M,k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"].y,k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"].z)s[K][2]=k[K]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"]api["\115\101\116\76\111\99\107\86\97\108\117\101"](bookOpen[K],1,1)w[K]=0 n[K]=true end end if callType==LuaCallType.Update then for y,z in pairs(book)do if n[y]then w[y]=w[y]+Time["\100\101\108\116\97\84\105\109\101"]F=w[y]/f F=E(F)if w[y]>f then w[y]=f n[y]=false o[y]=true end if m[y]==1 then l[y]["\122\111\111\109\83\99\97\108\101\77\111\100\105\102\105\101\114"]=A(1,1.4,F)else l[y]["\122\111\111\109\83\99\97\108\101\77\111\100\105\102\105\101\114"]=A(1.4,1,F)end h[y]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]=Quaternion.Slerp(q[y][1],t[y][1],F)i[y]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]=Quaternion.Slerp(q[y][2],t[y][2],F)j[y]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]=Quaternion.Slerp(r[y][1],u[y][1],F)k[y]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\82\111\116\97\116\105\111\110"]=Quaternion.Slerp(r[y][2],u[y][2],F)j[y]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"]=Vector3.Lerp(s[y][1],v[y][1],F)k[y]["\116\114\97\110\115\102\111\114\109"]["\108\111\99\97\108\80\111\115\105\116\105\111\110"]=Vector3.Lerp(s[y][2],v[y][2],F)end end end