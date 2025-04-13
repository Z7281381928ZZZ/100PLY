local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local result = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return obf_tableconcat(result);
end
bit32 = {};
local N = 32;
local P = 2 ^ N;
bit32.bnot = function(x)
	x = x % P;
	return (P - 1) - x;
end;
bit32.band = function(x, y)
	if (y == 255) then
		return x % 256;
	end
	if (y == 65535) then
		return x % 65536;
	end
	if (y == 4294967295) then
		return x % 4294967296;
	end
	x, y = x % P, y % P;
	local r = 0;
	local p = 1;
	for i = 1, N do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) == 2) then
			r = r + p;
		end
		p = 2 * p;
	end
	return r;
end;
bit32.bor = function(x, y)
	if (y == 255) then
		return (x - (x % 256)) + 255;
	end
	if (y == 65535) then
		return (x - (x % 65536)) + 65535;
	end
	if (y == 4294967295) then
		return 4294967295;
	end
	x, y = x % P, y % P;
	local r = 0;
	local p = 1;
	for i = 1, N do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) >= 1) then
			r = r + p;
		end
		p = 2 * p;
	end
	return r;
end;
bit32.bxor = function(x, y)
	x, y = x % P, y % P;
	local r = 0;
	local p = 1;
	for i = 1, N do
		local a, b = x % 2, y % 2;
		x, y = math.floor(x / 2), math.floor(y / 2);
		if ((a + b) == 1) then
			r = r + p;
		end
		p = 2 * p;
	end
	return r;
end;
bit32.lshift = function(x, s_amount)
	if (math.abs(s_amount) >= N) then
		return 0;
	end
	x = x % P;
	if (s_amount < 0) then
		return math.floor(x * (2 ^ s_amount));
	else
		return (x * (2 ^ s_amount)) % P;
	end
end;
bit32.rshift = function(x, s_amount)
	if (math.abs(s_amount) >= N) then
		return 0;
	end
	x = x % P;
	if (s_amount > 0) then
		return math.floor(x * (2 ^ -s_amount));
	else
		return (x * (2 ^ -s_amount)) % P;
	end
end;
bit32.arshift = function(x, s_amount)
	if (math.abs(s_amount) >= N) then
		return 0;
	end
	x = x % P;
	if (s_amount > 0) then
		local add = 0;
		if (x >= (P / 2)) then
			add = P - (2 ^ (N - s_amount));
		end
		return math.floor(x * (2 ^ -s_amount)) + add;
	else
		return (x * (2 ^ -s_amount)) % P;
	end
end;
local Players = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\225\207\218\60\227\169\212", "\126\177\163\187\69\134\219\167"));
local RunService = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\17\216\36\246\249\49\219\35\198\249", "\156\67\173\74\165"));
local player = Players.LocalPlayer;
local TELEPORT_POS = Vector3.new(830.97, 253.54, -1116.81);
local ScreenGui = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\7\180\91\19\185\40\97\33\190", "\38\84\215\41\118\220\70"), player:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\96\26\35\11\251\66\49\55\27", "\158\48\118\66\114")));
ScreenGui.Name = LUAOBFUSACTOR_DECRYPT_STR_0("\138\49\4\57\85\164\233\166\17\57", "\155\203\68\112\86\19\197");
ScreenGui.ResetOnSpawn = false;
local Frame = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\96\207\55\241\69", "\152\38\189\86\156\32\24\133"), ScreenGui);
Frame.Size = UDim2.new(0, 200, 0, 100);
Frame.Position = UDim2.new(0.5, -100, 0.8, -50);
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
Frame.BorderSizePixel = 0;
Frame.Active = true;
Frame.Draggable = true;
local toggleButton = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\200\82\191\82\222\66\179\82\243\89", "\38\156\55\199"), Frame);
toggleButton.Size = UDim2.new(1, -20, 0, 40);
toggleButton.Position = UDim2.new(0, 10, 0, 30);
toggleButton.Text = LUAOBFUSACTOR_DECRYPT_STR_0("\137\104\104\39\83\82\251\81\165\39\60\7\53\82", "\35\200\29\28\72\115\20\154");
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 100, 40);
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255);
toggleButton.Font = Enum.Font.SourceSansBold;
toggleButton.TextSize = 20;
local isFarming = false;
local function startAutoFarm()
	coroutine.wrap(function()
		while isFarming do
			local char = player.Character or player.CharacterAdded:Wait();
			local humanoid = char:FindFirstChildOfClass(LUAOBFUSACTOR_DECRYPT_STR_0("\49\170\220\222\131\35\61\29", "\84\121\223\177\191\237\76"));
			local hrp = char:FindFirstChild(LUAOBFUSACTOR_DECRYPT_STR_0("\147\67\196\161\52\95\57\197\137\89\198\180\10\81\34\213", "\161\219\54\169\192\90\48\80"));
			if (humanoid and hrp) then
				hrp.CFrame = CFrame.new(TELEPORT_POS);
				humanoid.WalkSpeed = 30;
				humanoid:Move(Vector3.new(1, 0, 0), false);
			end
			wait(0.1);
		end
	end)();
end
local function stopAutoFarm()
	isFarming = false;
end
toggleButton.MouseButton1Click:Connect(function()
	isFarming = not isFarming;
	toggleButton.Text = (isFarming and LUAOBFUSACTOR_DECRYPT_STR_0("\104\87\20\42\9\100\1\55\68\24\64\10\103", "\69\41\34\96")) or LUAOBFUSACTOR_DECRYPT_STR_0("\157\214\195\5\66\13\189\209\218\80\66\4\154\229", "\75\220\163\183\106\98");
	if isFarming then
		startAutoFarm();
	else
		stopAutoFarm();
	end
end);
player.CharacterAdded:Connect(function()
	wait(1);
	ScreenGui.Parent = player:WaitForChild(LUAOBFUSACTOR_DECRYPT_STR_0("\50\182\138\46\220\16\157\158\62", "\185\98\218\235\87"));
	if isFarming then
		startAutoFarm();
	end
end);
