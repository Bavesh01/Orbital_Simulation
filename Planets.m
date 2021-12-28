clear;
G=6.67e-11;%Universal Gravitational constant
m=2e3;%Mass of Satellite
M=5.972e24;%Mass of Earth
Mm=0.7*M;
R=6.378e6;%Radius of Earth
Rm=3.844e8;%Distance between Earth & Moon
totaltime=1e5;
timestep=1;
totalsteps=totaltime/timestep;
xp=[0];
yp=[-2*R];
zp=[0];
xv=[4e3];
yv=[0];
zv=[4e3];
s(1)=(xp(1)^2+yp(1)^2+zp(1)^2)^0.5;
s2(1)=(xp(1)^2+(yp(1)-5*R)^2+zp(1)^2)^0.5;
xa=[-(1/m)*(G*M*m/s(1)^2)*xp(1)/s(1)];
ya=[-(1/m)*(G*M*m/s(1)^2)*yp(1)/s(1)];
za=[-(1/m)*(G*M*m/s(1)^2)*zp(1)/s(1)];
x2a=[-(1/m)*(G*Mm*m/s2(1)^2)*xp(1)/s2(1)];
y2a=[-(1/m)*(G*Mm*m/s2(1)^2)*(yp(1)-5*R)/s2(1)];
z2a=[-(1/m)*(G*Mm*m/s2(1)^2)*zp(1)/s2(1)];
xTa=[0];
yTa=[0];
zTa=[0];
n=1;
xpo=[];ypo=[];zpo=[];i=0;j=0;k=0;
counter=-1;
for n=1:totalsteps
    xp=[xp,xp(n)+xv(n)*timestep];
    yp=[yp,yp(n)+yv(n)*timestep];
    zp=[zp,zp(n)+zv(n)*timestep]; 
    xv=[xv,xv(n)+(xa(n)+x2a(n)+i)*timestep]; 
    yv=[yv,yv(n)+(ya(n)+y2a(n)+j)*timestep];
    zv=[zv,zv(n)+(za(n)+z2a(n)+k)*timestep];    
    s(n+1)=sqrt(xp(n)^2+yp(n)^2+zp(n)^2);
    s2(n+1)=sqrt(xp(n)^2+(yp(n)-5*R)^2+zp(n)^2);
    xa=[xa,-(1/m)*(G*M*m/s(n)^2)*xp(n)/s(n)];
    ya=[ya,-(1/m)*(G*M*m/s(n)^2)*yp(n)/s(n)];
    za=[za,-(1/m)*(G*M*m/s(n)^2)*zp(n)/s(n)];    
    x2a=[x2a,-(1/m)*(G*Mm*m/(s2(n)^2))*xp(n)/s2(n)];
    y2a=[y2a,-(1/m)*(G*Mm*m/(s2(n)^2))*(yp(n)-5*R)/s2(n)];
    z2a=[z2a,-(1/m)*(G*Mm*m/(s2(n)^2))*zp(n)/s2(n)];

    if s(n)>Rm||s2(n)>Rm
    disp("Satellite flew away :(...")
    break;
    end
    if s(n)<R||s2(n)<R/2
    disp("Crash!")
    break;
    end
    if mod(n, 1000)==0
        disp(n/1000)
    end
end
figure;
[X,Y,Z] = sphere;
zp=xp;
comet3(xp,yp,zp);
hold on;
daspect([1,1,1]);
r = R;
X2 = X * r;
Y2 = Y * r;
Z2 = Z * r;
r=R/2;
X3 = X * r;
Y3 = Y * r;
Z3 = Z * r;
surfl(X2,Y2,Z2)
colormap(winter)
shading interp;
mars=surf(X3,Y3+5*R,Z3);
set(mars, 'FaceColor', [197/255, 166/255, 135/255]);
mars.EdgeColor = 'none';
mars.FaceLighting = 'none';
 
