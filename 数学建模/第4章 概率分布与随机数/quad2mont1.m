function [V0,Vm] = quad2mont1(n)
%   [V0,Vm] = quad2mont1(n),求球面 x^2+y^2+z^2 = 4 被圆柱面x^2+y^2=2*x所截得
%   的（含在圆柱面内的部分）立体的体积的理论值V0与蒙特卡洛模拟值Vm. 输入参数n是
%   随机投点的个数，可以是正整数标量或向量.
% CopyRight：xiezhh

% V0 = 32*(pi/2-2/3)/3;             % 体积的理论值
% V0 = 4*quadl(@(x)arrayfun(@(xx)quadl(@(y)sqrt(4-xx.^2-y.^2),...
%    0,sqrt(1-(1-xx).^2)),x),0,2);  % 体积的理论值（数值解）

% 调用quad2d函数（matlab2009a中出现的新函数）求体积的理论值（数值解）
V0 = 4*quad2d(@(x,y)sqrt(4-x.^2-y.^2),0,2,0,@(x)sqrt(1-(1-x).^2));
% 求体积的蒙特卡洛模拟值
for i = 1:length(n)
    x = 2*rand(n(i),1);             % 点的x坐标
    y = rand(n(i),1);               % 点的y坐标
    z = 2*rand(n(i),1);             % 点的z坐标
    % 落到区域 T 内的点的频数
    m = sum((x.^2 + y.^2 + z.^2 <= 4) & ((x-1).^2 + y.^2 <= 1));
    Vm(i) = 16*m/n(i);              % 落到所求立体内的点的频率，即概率的模拟值
end