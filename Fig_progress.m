%% Progress
figure2 = figure;
set(gcf, 'unit', 'inch', 'position', [3 5 14 3.5]);
p = 0;
h = 0.25; w=0.004;
for i =[1 2 3 5 30]

    filename = sprintf('./results/space_plot/r.4d3r1itr%dsurf.mat',i);
    load(filename);

    % set(gca,'unit', 'inch', 'position', [p*2.8 + 0.5, 0.2 2.4 1])
    subplot('position', [p*(0.15 + 0.25/6) + 0.25/6, 0.01 0.15 0.42])  
    mesh(zz2)
    view(0, -90)
    rectangle("LineWidth",2, "Position",[85 85 130 130], "EdgeColor", [1 1 1])
    axis off
    subplot('position', [p*(0.15 + 0.25/6) + 0.25/6, 0.51 0.15 0.42]) 
    mesh(zz2)
    rectangle("LineWidth",2, "Position",[85 85 130 130], "EdgeColor", [1 1 1])    
    colormap('jet'); 
    t = sprintf('Iteration %d',i);
    text(150, 300, 1, t,'FontName','Times New Roman', 'FontSize',16, 'Interpreter','latex')
    % title(t,'FontName','Times New Roman', 'FontSize',16, 'Interpreter','latex')
    axis off
    p = p + 1;
end

colorbar
 annotation(figure2,'textarrow',[0.184464285714286 0.141369047619048],...
    [0.497213868003342 0.574832915622389],'Color',[231 76 60]./255,'TextColor',[231 76 60]./255,...
    'String',{'Obvious Sidelobes'},...
    'LineWidth',2,...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Times New Roman', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
annotation(figure2,"arrow",[0.184464285714286 0.131369047619048],...
    [0.427213868003342 0.334832915622389],'Color',[231 76 60]./255, 'LineWidth',2)

 annotation(figure2,'textarrow',[0.811369047619048 0.854464285714286],...
    [0.497213868003342 0.574832915622389],'Color',[231 76 60]./255,'TextColor',[231 76 60]./255,...
    'String',{'Diminished Sidelobes'},...
    'LineWidth',2,...
    'FontWeight','bold',...
    'FontSize',14,...
    'FontName','Times New Roman', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
 annotation(figure2,"arrow",[0.811369047619048 0.873464285714286],...
    [0.427213868003342 0.339832915622389],'Color',[231 76 60]./255, 'LineWidth',2)


%% Retro Beamforming
clear all
figure1 = figure;
set(gcf, 'unit', 'inch', 'position', [3 7.5 7 1.5]);
filename = sprintf('./results/space_plot/r.4d3r0itr1.mat');
load(filename);
% UD logarithmic
zz = pow2db(zz);
zmax = min(min(zz));
zz = 1 - zz ./ zmax;

zz2 = pow2db(zz2);
zmax = min(min(zz2));
zz2 = 1 - zz2 ./ zmax;
subplot('position', [0.1/3 0.01 0.45 0.8])  
% annotation(figure1,'rectangle', [p*(0.18 + 0.1/6)+0.1/6 0.535-h w h],'Color',[1 1 1],'FaceColor',[1 1 1]);
contourf(xx,yy,zz2,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);
title('Power Emitted from BS','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16) 

xlim([0 3]);
axis off

subplot('position', [00.45+0.2/3 0.01 0.45 0.8])  
% annotation(figure1,'rectangle', [p*(0.18 + 0.1/6)+0.1/6 0.535-h w h],'Color',[1 1 1],'FaceColor',[1 1 1]);
contourf(xx,yy,zz,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);
colormap('parula');  
xlim([0 3.05]);
axis off
title('Power Emitted from UD','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16) 

%% RBS
clear all
figure2 = figure;
set(gcf, 'unit', 'inch', 'position', [3 7.5 7 1.5]);
filename = sprintf('./results/space_plot/r.4d3r0itr71.mat');
load(filename);
% UD logarithmic
zz = pow2db(zz);
zmax = min(min(zz));
zz = 1 - zz ./ zmax;

zz2 = pow2db(zz2);
zmax = min(min(zz2));
zz2 = 1 - zz2 ./ zmax;
subplot('position', [0.1/3 0.01 0.45 0.8])  
% annotation(figure1,'rectangle', [p*(0.18 + 0.1/6)+0.1/6 0.535-h w h],'Color',[1 1 1],'FaceColor',[1 1 1]);
contourf(xx,yy,zz2,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);
title('Power Emitted from BS','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16) 
xlim([0 3]);
axis off

subplot('position', [0.45+0.2/3 0.01 0.45 0.8])  
% annotation(figure1,'rectangle', [p*(0.18 + 0.1/6)+0.1/6 0.535-h w h],'Color',[1 1 1],'FaceColor',[1 1 1]);
contourf(xx,yy,zz,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);
colormap('parula');    
xlim([0 3]);
axis off
title('Power Emitted from UD','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16) 



%% Retro Beamforming
clear all
figure3 = figure;
set(gcf, 'unit', 'inch', 'position', [3 7.5 7 3]);
filename = sprintf('./results/space_plot/r.4d3r1itr1.mat');
load(filename);
% UD logarithmic
zz = pow2db(zz);
zmax = min(min(zz));
zz = 1 - zz ./ zmax;

zz2 = pow2db(zz2);
zmax = min(min(zz2));
zz2 = 1 - zz2 ./ zmax;
subplot('position', [0.1/3 0.01 0.45 0.98])  
% annotation(figure1,'rectangle', [p*(0.18 + 0.1/6)+0.1/6 0.535-h w h],'Color',[1 1 1],'FaceColor',[1 1 1]);
contourf(xx,yy,zz2,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);

xlim([0 3]);
axis off

subplot('position', [00.45+0.2/3 0.01 0.45 0.98])  
contourf(xx,yy,zz,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);
colormap('parula');  
xlim([0 3.05]);
axis off

%% RBS
clear all
figure4 = figure;
set(gcf, 'unit', 'inch', 'position', [3 7.5 7 3]);
filename = sprintf('./results/space_plot/r.4d3r1itr63.mat');
load(filename);
% UD logarithmic
zz = pow2db(zz);
zmax = min(min(zz));
zz = 1 - zz ./ zmax;

zz2 = pow2db(zz2);
zmax = min(min(zz2));
zz2 = 1 - zz2 ./ zmax;
subplot('position', [0.1/3 0.01 0.45 0.98])  
% annotation(figure1,'rectangle', [p*(0.18 + 0.1/6)+0.1/6 0.535-h w h],'Color',[1 1 1],'FaceColor',[1 1 1]);
contourf(xx,yy,zz2,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);
% colormap('BuYlRd5');  
xlim([0 3]);
axis off

subplot('position', [00.45+0.2/3 0.01 0.45 0.98])  
% annotation(figure1,'rectangle', [p*(0.18 + 0.1/6)+0.1/6 0.535-h w h],'Color',[1 1 1],'FaceColor',[1 1 1]);
contourf(xx,yy,zz,'LineColor','none',...
'LevelList',[0 0.00497512437810945 0.00995024875621891 0.0149253731343284 0.0199004975124378 0.0248756218905473 0.0298507462686567 0.0348258706467662 0.0398009950248756 0.0447761194029851 0.0497512437810945 0.054726368159204 0.0597014925373134 0.0646766169154229 0.0696517412935323 0.0746268656716418 0.0796019900497512 0.0845771144278607 0.0895522388059701 0.0945273631840796 0.0995024875621891 0.104477611940299 0.109452736318408 0.114427860696517 0.119402985074627 0.124378109452736 0.129353233830846 0.134328358208955 0.139303482587065 0.144278606965174 0.149253731343284 0.154228855721393 0.159203980099502 0.164179104477612 0.169154228855721 0.174129353233831 0.17910447761194 0.18407960199005 0.189054726368159 0.194029850746269 0.199004975124378 0.203980099502488 0.208955223880597 0.213930348258706 0.218905472636816 0.223880597014925 0.228855721393035 0.233830845771144 0.238805970149254 0.243781094527363 0.248756218905473 0.253731343283582 0.258706467661692 0.263681592039801 0.26865671641791 0.27363184079602 0.278606965174129 0.283582089552239 0.288557213930348 0.293532338308458 0.298507462686567 0.303482587064677 0.308457711442786 0.313432835820896 0.318407960199005 0.323383084577114 0.328358208955224 0.333333333333333 0.338308457711443 0.343283582089552 0.348258706467662 0.353233830845771 0.358208955223881 0.36318407960199 0.368159203980099 0.373134328358209 0.378109452736318 0.383084577114428 0.388059701492537 0.393034825870647 0.398009950248756 0.402985074626866 0.407960199004975 0.412935323383085 0.417910447761194 0.422885572139304 0.427860696517413 0.432835820895522 0.437810945273632 0.442786069651741 0.447761194029851 0.45273631840796 0.45771144278607 0.462686567164179 0.467661691542289 0.472636815920398 0.477611940298507 0.482587064676617 0.487562189054726 0.492537313432836 0.497512437810945 0.502487562189055 0.507462686567164 0.512437810945274 0.517412935323383 0.522388059701492 0.527363184079602 0.532338308457711 0.537313432835821 0.54228855721393 0.54726368159204 0.552238805970149 0.557213930348259 0.562189054726368 0.567164179104478 0.572139303482587 0.577114427860697 0.582089552238806 0.587064676616915 0.592039800995025 0.597014925373134 0.601990049751244 0.606965174129353 0.611940298507463 0.616915422885572 0.621890547263682 0.626865671641791 0.631840796019901 0.63681592039801 0.641791044776119 0.646766169154229 0.651741293532338 0.656716417910448 0.661691542288557 0.666666666666667 0.671641791044776 0.676616915422886 0.681592039800995 0.686567164179104 0.691542288557214 0.696517412935323 0.701492537313433 0.706467661691542 0.711442786069652 0.716417910447761 0.721393034825871 0.72636815920398 0.73134328358209 0.736318407960199 0.741293532338308 0.746268656716418 0.751243781094527 0.756218905472637 0.761194029850746 0.766169154228856 0.771144278606965 0.776119402985075 0.781094527363184 0.786069651741294 0.791044776119403 0.796019900497512 0.800995024875622 0.805970149253731 0.810945273631841 0.81592039800995 0.82089552238806 0.825870646766169 0.830845771144279 0.835820895522388 0.840796019900497 0.845771144278607 0.850746268656716 0.855721393034826 0.860696517412935 0.865671641791045 0.870646766169154 0.875621890547264 0.880597014925373 0.885572139303483 0.890547263681592 0.895522388059702 0.900497512437811 0.90547263681592 0.91044776119403 0.915422885572139 0.920398009950249 0.925373134328358 0.930348258706468 0.935323383084577 0.940298507462687 0.945273631840796 0.950248756218905 0.955223880597015 0.960199004975124 0.965174129353234 0.970149253731343 0.975124378109453 0.980099502487562 0.985074626865672 0.990049751243781 0.995024875621891]);
colormap('parula');    
xlim([0 3]);
axis off