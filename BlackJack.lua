function CreateBoard()
    local i=1
    term.clear()
    paintutils.drawFilledBox(0,0,50,19,colors.green)
    paintutils.drawBox(1,1,50,19,colors.black)
    while i < 49 do
        paintutils.drawBox(i+1,18,i+4,14,colors.yellow)
        i=i+12
    end
    paintutils.drawBox(20,2,23,6,colors.yellow)
end
function PaintCard(x,y,s,r)
    paintutils.drawBox(x,y,x+1,y-2,colors.white)
    local s=string.sub(s,1,1)
    if (s=="D" or s=="H") then
        paintutils.drawPixel(x,y-2,colors.red)
        paintutils.drawPixel(x+1,y,colors.red)
        term.setTextColor(colors.black)
    elseif (s=="S" or s=="C") then
        paintutils.drawPixel(x,y-2,colors.black)
        paintutils.drawPixel(x+1,y,colors.black)
        term.setTextColor(colors.white)
    end
    term.setCursorPos(x,y-2)
    write(r)
    term.setCursorPos(x+1,y)
    if(s=="D")then
        write("\x04")
    elseif (s=="H")then
        write("\x03")
    elseif (s=="S")then
        write("\x06")
    elseif (s=="C")then
        write("\x05")
    end
end
function RenderCard(c,n,p,flip)
    local flip = flip or false
    local suit,rank = '',''
    local p1,p2,p3,p4,d=3,15,27,39,21
    local offset=17
    rank = string.sub(c,1,1)
    if (string.find(c,"Hearts")) then
        suit = "Hearts"
    end
    if (string.find(c,"Diamonds")) then
        suit = "Diamonds"
    end
    if (string.find(c,"Spades")) then
        suit = "Spades"
    end
    if (string.find(c,"Clubs")) then
        suit = "Clubs"
    end
    if (p==1) then
        term.setCursorPos(p1+(n-1),offset-(n-1))
        PaintCard(p1+(n-1),offset-(n-1),suit,rank)
    elseif (p==2)then
        term.setCursorPos(p2+(n-1),offset-(n-1))
        PaintCard(p2+(n-1),offset-(n-1),suit,rank)
    elseif (p==3)then
        term.setCursorPos(p3+(n-1),offset-(n-1))
        PaintCard(p3+(n-1),offset-(n-1),suit,rank)
    elseif (p==4)then
        term.setCursorPos(p4+(n-1),offset-(n-1))
        PaintCard(p4+(n-1),offset-(n-1),suit,rank)
    elseif (p==5)then
        if (n==1 and flip==false)then
            term.setCursorPos(21,5)
            paintutils.drawFilledBox(d,5,d+1,3,colors.gray)
        else
            term.setCursorPos(21,5)
            PaintCard(d-(n-1),5+(n-1),suit,rank)
        end
    else
        error("Invalid Player")
    end
end
function CreateDeck()
    local d={"Ace of Spades","2 of Spades","3 of Spades","4 of Spades","5 of Spades","6 of Spades","7 of Spades","8 of Spades","9 of Spades","10 of Spades","Jack of Spades","Queen of Spades","King of Spades","Ace of Hearts","2 of Hearts","3 of Hearts","4 of Hearts","5 of Hearts","6 of Hearts","7 of Hearts","8 of Hearts","9 of Hearts","10 of Hearts","Jack of Hearts","Queen of Hearts","King of Hearts","Ace of Diamonds","2 of Diamonds","3 of Diamonds","4 of Diamonds","5 of Diamonds","6 of Diamonds","7 of Diamonds","8 of Diamonds","9 of Diamonds","10 of Diamonds","Jack of Diamonds","Queen of Diamonds","King of Diamonds","Ace of Clubs","2 of Clubs","3 of Clubs","4 of Clubs","5 of Clubs","6 of Clubs","7 of Clubs","8 of Clubs","9 of Clubs","10 of Clubs","Jack of Clubs","Queen of Clubs","King of Clubs"}
    return(d)
end
function DrawCard(d)
    local c=table.remove(d,math.random(table.getn(d)))
    return c,d
end
function ScoreCard(c)
    local r=string.sub(c,1,2)
    if (r=="Ac")then
        return 11
    elseif (r=="Ja" or r=="Qu" or r=="Ki" or r=="10") then
        return 10
    else
        return string.sub(c,1,1)
    end
end
function PrintTotal(s,p,b)
    local pl={(2),(14),(26),(38),(20)}
    local x=pl[p]
    term.setTextColor(colors.black)
    term.setBackgroundColor(colors.yellow)
    if(p~=5)then
        term.setCursorPos(x,18)
    else
        term.setCursorPos(x,2)
    end
    if (b==true) then
        write("BUST")
    else
        write("T:"..s)
    end
end
function PrintWinner(p)
    local pl={(2),(14),(26),(38),(24)}
    local x=pl[p]
    term.setTextColor(colors.black)
    term.setBackgroundColor(colors.lightBlue)
    if(p~=5)then
        term.setCursorPos(x,17)
    else
        term.setCursorPos(x,2)
    end
    write("Winner!  ")
end
function HitFold(p,b,f)
    local pl={(6),(18),(30),(42)}
    local ps={(0),(0),(0),(0)}
    local HF={(">Hit"),(">Fold")}
    term.setBackgroundColor(colors.green)
    while true do
        for i,v in pairs(HF)do
            term.setTextColor(colors.black)
            if (ps[1]==i) then
                term.setTextColor(colors.blue)
            end
            if (f[1]==true or b[1]==true) then
                term.setTextColor(colors.red)
            end
            term.setCursorPos(pl[1],16+i)
            write(v)
        end
        if(p>1)then
            for i,v in pairs(HF)do
                term.setTextColor(colors.black)
                if (ps[2]==i) then
                    term.setTextColor(colors.blue)
                end
                if (f[2]==true or b[2]==true) then
                    term.setTextColor(colors.red)
                end
                term.setCursorPos(pl[2],16+i)
                write(v)
            end
        end
        if (p>2) then
            for i,v in pairs(HF)do
                term.setTextColor(colors.black)
                if (ps[3]==i) then
                    term.setTextColor(colors.blue)
                end
                if (f[3]==true or b[3]==true) then
                    term.setTextColor(colors.red)
                end
                term.setCursorPos(pl[3],16+i)
                write(v)
            end
        end
        if(p>3)then
            for i,v in pairs(HF)do
                term.setTextColor(colors.black)
                if (ps[4]==i) then
                    term.setTextColor(colors.blue)
                end
                if (f[4]==true or b[4]==true) then
                    term.setTextColor(colors.red)
                end
                term.setCursorPos(pl[4],16+i)
                write(v)
            end
        end
        local event, side, mx, my = os.pullEvent("monitor_touch")
        --p1
        if(mx<12)then
            if(my==17)then
                if (ps[1]~=1) then
                    ps[1]=1
                elseif (b[1] or f[1]) then
                    break
                else
                    return 1,1
                end
            elseif(my==18)then
                if (ps[1]~=2) then
                    ps[1]=2
                else
                    return 1,2
                end
            end
        --p2
        elseif (mx>12 and mx<23 and p>1) then
            if(my==17)then
                if (ps[2]~=1) then
                    ps[2]=1
                elseif (b[2] or f[2]) then
                    break
                else
                    return 2,1
                end
            elseif(my==18)then
                if (ps[2]~=2) then
                    ps[2]=2
                else
                    return 2,2
                end
            end
        --p3
        elseif (mx>23 and mx<35 and p>2) then
            if(my==17)then
                if (ps[3]~=1) then
                    ps[3]=1
                elseif (b[3] or f[3]) then
                    break
                else
                    return 3,1
                end
            elseif(my==18)then
                if (ps[3]~=2) then
                    ps[3]=2
                else
                    return 3,2
                end
            end
        --p4
        elseif (mx>35 and p>3) then
            if(my==17)then
                if (ps[4]~=1) then
                    ps[4]=1
                elseif (b[4] or f[4]) then
                    break
                else
                    return 4,1
                end
            elseif(my==18)then
                if (ps[4]~=2) then
                    ps[4]=2
                else
                    return 4,2
                end
            end
        end
    end
end
function StartGame(p)
    local d = CreateDeck()
    local c,pl,ps,DealerCard,MaxPS = "",0,0,'',0
    local i,t = 0,0
    Players = {["Score"]={0,0,0,0,0},["CardCount"]={0,0,0,0,0},["Aces"]={0,0,0,0,0},["Bust"]={false,false,false,false,false},["Exact"]={false,false,false,false,false},["Fold"]={false,false,false,false,false}}
    CreateBoard()
    --Beginning Deal
    --Dealer
    while i<2 do
        c,d = DrawCard(d)
        Players["CardCount"][5]=Players["CardCount"][5]+1
        if (string.sub(c,1,1) == "A") then
            Players["Aces"][5]=Players["Aces"][5]+1
        end
        RenderCard(c,Players["CardCount"][5],5)
        Players["Score"][5]=Players["Score"][5]+ScoreCard(c)
        i=i+1
    end
    i=0
    --Player 1
    while i<2 do
        c,d = DrawCard(d)
        if i==0 then
            DealerCard=c
        end
        Players["CardCount"][1]=Players["CardCount"][1]+1
        if (string.sub(c,1,1) == "A") then
            Players["Aces"][1]=Players["Aces"][1]+1
        end
        RenderCard(c,Players["CardCount"][1],1)
        Players["Score"][1]=Players["Score"][1]+ScoreCard(c)
        i=i+1
    end
    if (Players["Score"][1]==21) then
        Players["Exact"][1]=true
        Players["Fold"][1]=true
    elseif (Players["Score"][1]>21) then
        if (Players["Aces"][1]==0) then
            Players["Bust"][1]=true
            Players["Fold"][1]=true
        else
            Players["Aces"][1]=Players["Aces"][1]-1
            Players["Score"][1]=Players["Score"][1]-10
        end
    end
    i=0
    --Player 2
    if (p>1) then
        while i<2 do
            c,d = DrawCard(d)
            Players["CardCount"][2]=Players["CardCount"][2]+1
            if (string.sub(c,1,1) == "A") then
                Players["Aces"][2]=Players["Aces"][2]+1
            end
            RenderCard(c,Players["CardCount"][2],2)
            Players["Score"][2]=Players["Score"][2]+ScoreCard(c)
            i=i+1
        end
        if (Players["Score"][2]==21) then
            Players["Exact"][2]=true
            Players["Fold"][2]=true
        elseif (Players["Score"][2]>21) then
            if (Players["Aces"][2]==0) then
                Players["Bust"][2]=true
                Players["Fold"][2]=true
            else
                Players["Aces"][2]=Players["Aces"][2]-1
                Players["Score"][2]=Players["Score"][2]-10
            end
        end
        i=0
        --Player 3
        if (p>2) then
            while i<2 do
                c,d = DrawCard(d)
                Players["CardCount"][3]=Players["CardCount"][3]+1
                if (string.sub(c,1,1) == "A") then
                    Players["Aces"][3]=Players["Aces"][3]+1
                end
                RenderCard(c,Players["CardCount"][3],3)
                Players["Score"][3]=Players["Score"][3]+ScoreCard(c)
                i=i+1
            end
            if (Players["Score"][3]==21) then
                Players["Exact"][3]=true
                Players["Fold"][3]=true
            elseif (Players["Score"][3]>21) then
                if (Players["Aces"][3]==0) then
                    Players["Bust"][3]=true
                    Players["Fold"][3]=true
                else
                    Players["Aces"][3]=Players["Aces"][3]-1
                    Players["Score"][3]=Players["Score"][3]-10
                end
            end
            i=0
            --Player 4
            if (p==4) then
                while i<2 do
                    c,d = DrawCard(d)
                    Players["CardCount"][4]=Players["CardCount"][4]+1
                    if (string.sub(c,1,1) == "A") then
                        Players["Aces"][4]=Players["Aces"][4]+1
                    end
                    RenderCard(c,Players["CardCount"][4],4)
                    Players["Score"][4]=Players["Score"][4]+ScoreCard(c)
                    i=i+1
                end
                if (Players["Score"][4]==21) then
                    Players["Exact"][4]=true
                    Players["Fold"][4]=true
                elseif (Players["Score"][4]>21) then
                    if (Players["Aces"][4]==0) then
                        Players["Bust"][4]=true
                        Players["Fold"][4]=true
                    else
                        Players["Aces"][4]=Players["Aces"][4]-1
                        Players["Score"][4]=Players["Score"][4]-10
                    end
                end
            end
        end
    end
    i=p
    while i~=0 do
        PrintTotal(Players["Score"][i],i,Players["Bust"][i])
        i=i-1
    end
    --Gameplay Loop
    while true do
        pl,ps=HitFold(p,Players["Bust"],Players["Fold"])
        --Check Player1
        if (pl==1) then
            if (ps==1) then
                c,d = DrawCard(d)
                Players["CardCount"][1]=Players["CardCount"][1]+1
                if (string.sub(c,1,1) == "A") then
                    Players["Aces"][1]=Players["Aces"][1]+1
                end
                RenderCard(c,Players["CardCount"][1],1)
                Players["Score"][1]=Players["Score"][1]+ScoreCard(c)
                if (Players["Score"][1]==21) then
                    Players["Exact"][1]=true
                    Players["Fold"][1]=true
                elseif (Players["Score"][1]>21) then
                    if (Players["Aces"][1]==0) then
                        Players["Bust"][1]=true
                        Players["Fold"][1]=true
                    else
                        Players["Aces"][1]=Players["Aces"][1]-1
                        Players["Score"][1]=Players["Score"][1]-10
                    end
                end
            else
                Players["Fold"][1]=true
            end
            PrintTotal(Players["Score"][1],1,Players["Bust"][1])
        end
        --Check Player2
        if (pl==2) then
            if (ps==1) then
                c,d = DrawCard(d)
                Players["CardCount"][2]=Players["CardCount"][2]+1
                if (string.sub(c,1,1) == "A") then
                    Players["Aces"][2]=Players["Aces"][2]+1
                end
                RenderCard(c,Players["CardCount"][2],2)
                Players["Score"][2]=Players["Score"][2]+ScoreCard(c)
                if (Players["Score"][2]==21) then
                    Players["Exact"][2]=true
                    Players["Fold"][2]=true
                elseif (Players["Score"][2]>21) then
                    if (Players["Aces"][2]==0) then
                        Players["Bust"][2]=true
                        Players["Fold"][2]=true
                    else
                        Players["Aces"][2]=Players["Aces"][2]-1
                        Players["Score"][2]=Players["Score"][2]-10
                    end
                end
            else
                Players["Fold"][2]=true
            end
            PrintTotal(Players["Score"][2],2,Players["Bust"][2])
        end
        --Check Player3
        if (pl==3) then
            if (ps==1) then
                c,d = DrawCard(d)
                Players["CardCount"][3]=Players["CardCount"][3]+1
                if (string.sub(c,1,1) == "A") then
                    Players["Aces"][3]=Players["Aces"][3]+1
                end
                RenderCard(c,Players["CardCount"][3],3)
                Players["Score"][3]=Players["Score"][3]+ScoreCard(c)
                if (Players["Score"][3]==21) then
                    Players["Exact"][3]=true
                    Players["Fold"][3]=true
                elseif (Players["Score"][3]>21) then
                    if (Players["Aces"][3]==0) then
                        Players["Bust"][3]=true
                        Players["Fold"][3]=true
                    else
                        Players["Aces"][3]=Players["Aces"][3]-1
                        Players["Score"][3]=Players["Score"][3]-10
                    end
                end
            else
                Players["Fold"][3]=true
            end
            PrintTotal(Players["Score"][3],3,Players["Bust"][3])
        end
        --Check Player4
        if (pl==4) then
            if (ps==1) then
                c,d = DrawCard(d)
                Players["CardCount"][4]=Players["CardCount"][4]+1
                if (string.sub(c,1,1) == "A") then
                    Players["Aces"][4]=Players["Aces"][4]+1
                end
                RenderCard(c,Players["CardCount"][4],4)
                Players["Score"][4]=Players["Score"][4]+ScoreCard(c)
                if (Players["Score"][4]==21) then
                    Players["Exact"][4]=true
                    Players["Fold"][4]=true
                elseif (Players["Score"][4]>21) then
                    if (Players["Aces"][4]==0) then
                        Players["Bust"][4]=true
                        Players["Fold"][4]=true
                    else
                        Players["Aces"][4]=Players["Aces"][4]-1
                        Players["Score"][4]=Players["Score"][4]-10
                    end
                end
            else
                Players["Fold"][4]=true
            end
            PrintTotal(Players["Score"][4],4,Players["Bust"][4])
        end
        t=0
        if (p>=1 and Players["Fold"][1]==true) then
            t=t+1
        end
        if (p>=2 and Players["Fold"][2]==true) then
            t=t+1
        end
        if (p>=3 and Players["Fold"][3]==true) then
            t=t+1
        end
        if (p==4 and Players["Fold"][4]==true) then
            t=t+1
        end
        --All Players either busted or folded check
        if (t==p) then
            i=1
            while i<p+1 do
                if (Players["Bust"][i]==false) then
                    if (Players["Score"][i]>MaxPS) then
                        MaxPS=Players["Score"][i]
                    end
                end
                i=i+1
            end
            RenderCard(DealerCard,1,5,true)
            PrintTotal(Players["Score"][5],5,Players["Bust"][5])
            while (Players["Score"][5]<=MaxPS) do
                c,d = DrawCard(d)
                Players["CardCount"][5]=Players["CardCount"][5]+1
                RenderCard(c,Players["CardCount"][5],5)
                Players["Score"][5]=Players["Score"][5]+ScoreCard(c)
                PrintTotal(Players["Score"][5],5)
                if (Players["Score"][5]>21) then
                    if (Players["Aces"][5]==0) then
                        Players["Bust"][5]=true
                    else
                        Players["Aces"][5]=Players["Aces"][5]-1
                        Players["Score"][5]=Players["Score"][5]-10
                    end
                end
                if (Players["Score"][5]==21) then
                    Players["Exact"][5]=true
                end
            end
            i=p
            while i~=0 do
                if (Players["Bust"][i]==false and Players["Bust"][5]==true) then
                    if (Players["Score"][i]>=MaxPS) then
                        PrintWinner(i)
                    end
                elseif (Players["Score"][5]>MaxPS and Players["Bust"][5]==false) then
                    PrintWinner(5)
                end
                i=i-1
            end
            break
        end
    end
end
function PlayerCount()
    term.setCursorPos(12,10)
    term.setBackgroundColor(colors.green)
    term.setTextColor(colors.white)
    local p={"One  ","Two  ","Three","Four "}
    local check = {}
    local FR=0
    local pc=0
    while true do
        local offset = 12
        for i,v in ipairs(p) do
            if (FR == 0) then
                check[i] = 0
            end
            if (check[i]== 1) then
                term.setCursorPos(offset,10)
                term.setTextColor(colors.red)
                write(p[i])
            else
                term.setTextColor(colors.white)
                term.setCursorPos(offset,10)
                write(p[i])
            end
            offset=offset+6
        end
        local event, side, mx, my = os.pullEvent("monitor_touch")
        if (mx<17) then
            pc=1
        elseif (mx<23) then
            pc=2
        elseif (mx<30) then
            pc=3
        elseif (mx>=31) then
            pc=4
        end
        if (check[pc] == 0) then
            check[pc] = 1
            for i,v in pairs(check) do
                if (i ~= pc) then
                    check[i] = 0
                end
            end
        elseif (check[pc]==1) then
            return pc
        end
        FR = 1
    end
end
while true do
    CreateBoard()
    term.setCursorPos(12,9)
    term.setBackgroundColor(colors.green)
    term.setTextColor(colors.white)
    write("Click anywhere to play!")
    os.pullEvent("monitor_touch")
    CreateBoard()
    term.setCursorPos(12,9)
    term.setBackgroundColor(colors.green)
    term.setTextColor(colors.white)
    write("How Many Players?")
    local p = PlayerCount()
    while true do
        StartGame(p)
        term.setCursorPos(12,9)
        term.setBackgroundColor(colors.green)
        term.setTextColor(colors.white)
        write("Want to play again?")
        local YN = 0
        while true do
            if (YN==1) then
                term.setCursorPos(13,10)
                term.setTextColor(colors.red)
                write("Yes")
            else
                term.setCursorPos(13,10)
                term.setTextColor(colors.white)
                write("Yes")
            end
            if (YN==2) then
                term.setCursorPos(25,10)
                term.setTextColor(colors.red)
                write("No")
            else
                term.setCursorPos(25,10)
                term.setTextColor(colors.white)
                write("No")
            end
            local event, side, mx, my = os.pullEvent("monitor_touch")
            if (mx<25) then
                if YN==1 then
                    break
                end
                YN=1
            else
                if YN==2 then
                    break
                end
                YN=2
            end
        end
        if (YN==1) then
            p=PlayerCount()
        elseif (YN==2) then
            break
        end
    end
end
