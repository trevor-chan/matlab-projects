

function rp = rotxz(x,y,z)
    %Define vectors
    r = [0;0;1];
    n = [x; y; z];
    % Normalize n
    n = n/norm(n);
    
    %Calculate the angle theta between n and z-axis
    theta = -acos(n(3));
    %Calculate the angle phi between n_xy and x-axis
    % We want phi to have 2*pi range
    if x < 0
        if y > 0
            phi = atan(-n(1)/n(2));
        else
            phi = atan(n(2)/n(1))+pi/2;
        end
    else
        if y >= 0
            phi = -atan(n(1)/n(2));
        else
            phi = atan(-n(1)/n(2))+pi;
        end
    end
    %Define rotation matrices
    Mz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0;0 0 1];
    Mx = [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)];
    
    %Calculate rotated vector 
    rp = Mz*Mx*r;
    
    %Plot the original and rotated vectors
    figure(1)
    plot3([0 r(1)],[0 r(2)],[0 r(3)],'b','LineWidth',2);
    hold on;
    plot3([0 rp(1)],[0 rp(2)],[0 rp(3)],'r','Linewidth',4);
    plot3([0 n(1)],[0 n(2)],[0 n(3)],'k--','Linewidth',2);
    xlim([-1 1]);
    ylim([-1 1]);
    zlim([-1 1]);
    grid on;
    xlabel('X','Fontsize',15);
    ylabel('Y','Fontsize',15);
    zlabel('Z','Fontsize',15);
    legend({'Before rotation','After rotation','n vector'},'FontSize',15);
end