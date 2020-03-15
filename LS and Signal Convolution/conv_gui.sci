

funcprot(0);

// Defining event handling for plot window

function conv_gui_event(win,x,y,ibut)
    if ibut==37
        conv_gui('move_left');
    elseif ibut==39
        conv_gui('move_right');
    end
endfunction


function []=conv_gui(varargin)

    // Defining unit step function 
    function y=u(x)
        y=sign((sign(x)+1))
    endfunction

    action='init_gui';
    
    
    if argn(2) ==1 then
        action=varargin(1);
    elseif argn(2) ==2 then
        if varargin(1)=="load_sample" then
            action="load_sample";
            n_sample= varargin(2);
        end
    end

    if action == 'init_gui' //********************************************
        h=findobj('tag','conv_gui_main_window');
        if h == [] then
            // Drawing the figure
            h=figure('Tag','conv_gui_main_window','Figure_name','Convolution of two function');
            h.event_handler="conv_gui_event";
            h.event_handler_enable="on";

            // creating axes
            subplot(3,1,1);
            ax1= gca();
            ax1.tight_limits='on';
            ax1.auto_clear='on';
            subplot(3,1,2);
            ax2= gca();
            ax2.tight_limits='on';
            ax2.auto_clear='on';
            subplot(3,1,3);
            ax3= gca();
            ax3.tight_limits='on';
            ax3.auto_clear='on';



            // Deleting menus
            delmenu(h.figure_id, gettext("&File"));
            delmenu(h.figure_id, gettext("&Edit"));
            delmenu(h.figure_id, gettext("&Tools"));
            delmenu(h.figure_id, gettext("&?"));

            // Hiding toolbar
            toolbar(h,'off');

            // adding menus

            mnu_options = uimenu(h, ...
            'Label','Options');
            mnu_options_set_fun = uimenu(mnu_options, ...
            'Label','Set Functions',...
            'Callback', 'conv_gui(''set_functions'')');
            mnu_options_illustrate=uimenu(mnu_options, ...
            'checked','off',...
            'Label','Illustratrate',...
            'Callback', 'conv_gui(''illustrate'')');
            
            mnu_samples = uimenu(h, ...
            'Label','Samples');
            mnu_samples_1 = uimenu(mnu_samples, ...
            'Label','Sample 1', ...
            'Callback', 'conv_gui(''load_sample'',1)');
            mnu_samples_2 = uimenu(mnu_samples, ...
            'Label','Sample 2', ...
            'Callback', 'conv_gui(''load_sample'',2)');
            mnu_samples_1 = uimenu(mnu_samples, ...
            'Label','Sample 3', ...
            'Callback', 'conv_gui(''load_sample'',3)');
            
            mnu_move_left = uimenu(h, ...
            'Label','Move Left <--',...
            'Enable','off',...
            'Callback','conv_gui(''move_left'')');
            mnu_move_right = uimenu(h, ...
            'Label',' --> Move Right',...
            'Enable','off',...
            'Callback','conv_gui(''move_right'')');
            mnu_about = uimenu(h, ...
            'Label','About',...
            'Callback','conv_gui(''about'')');
            
            
            
            mnu=struct('illustrate',mnu_options_illustrate,'left',mnu_move_left,'right',mnu_move_right);

            // Storing Data
            t='[-5:0.02:5]';
            f1='2*(u(t)-u(t-1))';
            f2='(u(t)-u(t-2))';
            move_step=0.1;
            t_shift=0;
            t_data=[];
            t_min=[];
            t_max=[];
            t_step=[];
            f1_data=[];
            f2_data=[];
            conv_data=[];
            init_plot=1;
            user_data = struct('t',t,'f1',f1,'f2',f2,'move_step',move_step, ...
            'ax1',[ax1],'ax2',[ax2],'ax3',[ax3],...
            't_shift',[t_shift],'t_data',[t_data],'f1_data',[f1_data],...
            'f2_data',[f2_data],'conv_data',[conv_data],'init_plot',init_plot,...
            't_min',t_min,'t_max',t_max','t_step',t_step,'mnu',mnu);

            h.userdata = user_data

            // evaluating functions
            conv_gui('eval_functions');

        else
            show_window(h);      
        end

    elseif action == 'about' //*********************************************
        messagebox(["Author: Mahmoud A. AlNaanah" ...
         "email: malnaanah@gmail.com" ...
         "Last update: 10.08.2015 (DD.MM.YYYY)" ...
         "License: GPL" ...
         "tested on scilab v 5.5.0" ...
         ], "About", "info");

    elseif action == 'illustrate' //*********************************************
        h=findobj('tag','conv_gui_main_window');

        if (h.userdata.mnu.illustrate.checked=='off') then
            h.info_message="Click on the figures and use left and right arrows (or click Move Left, Move Right from menu) to move function 2";
            h.userdata.mnu.illustrate.checked='on';
            h.userdata.mnu.left.enable='on';
            h.userdata.mnu.right.enable='on';
            h.userdata.ax1.children.children(2).visible='on';
            h.userdata.ax1.title.text="First  function (F1) (Red line), F1 x F2 (Blue line) "
            conv_gui('plot')
        else
            conv_gui('eval_functions')
        end

    elseif action == 'load_sample' //*********************************************
        h=findobj('tag','conv_gui_main_window');

        if n_sample == 1 then
            h.userdata.t='[-5:0.02:5]';
            h.userdata.f1='2*(u(t)-u(t-1))';
            h.userdata.f2='(u(t)-u(t-2))';
            conv_gui('eval_functions')
        elseif n_sample == 2 then
            h.userdata.t='[-5:0.02:5]';
            h.userdata.f1='t .* (u(t)-u(t-1))';
            h.userdata.f2='t .* (u(t)-u(t-1))';
            conv_gui('eval_functions')
        elseif n_sample == 3 then
            h.userdata.t='[-5:0.02:5]';
            h.userdata.f1='t .* (u(t+1)-u(t-1))';
            h.userdata.f2='t .* (u(t+1)-u(t-1))';
            conv_gui('eval_functions')
        end

    elseif action == 'move_right' //*********************************************
        h=findobj('tag','conv_gui_main_window');
        if h.userdata.mnu.illustrate.checked=='on' then
            h.userdata.t_shift=h.userdata.t_shift+h.userdata.move_step;
            if h.userdata.t_shift > (h.userdata.t_max -h.userdata.t_min) then
                h.userdata.t_shift=h.userdata.t_shift-h.userdata.move_step;
            else
                conv_gui('plot')
            end        
        end


    elseif action == 'move_left' //*********************************************
        h=findobj('tag','conv_gui_main_window');

        if h.userdata.mnu.illustrate.checked=='on' then
            h.userdata.t_shift=h.userdata.t_shift-h.userdata.move_step;
            if h.userdata.t_shift < (h.userdata.t_min -h.userdata.t_max) then
                h.userdata.t_shift=h.userdata.t_shift+h.userdata.move_step;
            else
                conv_gui('plot')
            end
        end

    elseif action == 'set_functions' //*********************************************
        h=findobj('tag','conv_gui_main_window');

        labels = ["t=";"f1=";"f2=";"Move step="];
        vals =  [h.userdata.t;h.userdata.f1;h.userdata.f2;string(h.userdata.move_step)]
        lst = list("str",1,"str",1,"str",1,"str",1);

        [ok,t,f1,f2,move_step]=getvalue("Use t as variable. u(t) is the unit step function. Use .*  instead of * for multiplication", labels,lst,vals);

        if ok
            h.userdata.t = t;
            h.userdata.f1 = f1;
            h.userdata.f2 = f2;
            h.userdata.move_step = evstr(move_step);
            conv_gui('eval_functions');
        end



    elseif action == 'eval_functions' //*********************************************    

        h=findobj('tag','conv_gui_main_window');
        h.info_message="Go to Options > Illustrate, to see graphical illustration of convolution";
        t=evstr(h.userdata.t);
        f1=evstr(h.userdata.f1);
        f2=evstr(h.userdata.f2);
        mov_step=h.userdata.move_step;

        h.userdata.t_min=min(t);
        h.userdata.t_max=max(t);
        h.userdata.t_step=t(2)-t(1);

        conv=convol(f1,f2)*h.userdata.t_step;
        SZ = size(t,2);
        STRT = round(abs(h.userdata.t_min/h.userdata.t_step));
        END = STRT+SZ-1;
        conv=conv(STRT:END);


        h.userdata.t_data=[];
        h.userdata.f1_data=[];
        h.userdata.f2_data=[];
        h.userdata.conv_data=[];

        h.userdata.t_data=t;
        h.userdata.f1_data=f1;
        h.userdata.f2_data=f2;
        h.userdata.conv_data=conv;
        h.userdata.init_plot=1;
        h.userdata.t_shift=0;


        h.userdata.mnu.illustrate.checked='off'
        h.userdata.mnu.left.enable='off';
        h.userdata.mnu.right.enable='off'
        h.userdata.t_shift=0;

        conv_gui('plot');
        
        h.userdata.ax1.children.children(2).visible='off';

    elseif action == 'plot' //*********************************************    

        h=findobj('tag','conv_gui_main_window');
        t=h.userdata.t_data;
        f1_data=h.userdata.f1_data;
        f2_data=h.userdata.f2_data;
        conv_data=h.userdata.conv_data;
        
        if h.userdata.init_plot then
            sca(h.userdata.ax1)
            plot(t,f1_data,t,f1_data);

            data_bounds=h.userdata.ax1.data_bounds;
            data_bounds=data_bounds .*[1,1.1;1,1.1];
            h.userdata.ax1.title.text="First Function (F1)";
            h.userdata.ax1.data_bounds=data_bounds;
            h.userdata.ax1.children.children(1).polyline_style=1;
            h.userdata.ax1.children.children(1).thickness=2;
            h.userdata.ax1.children.children(1).foreground=2;

            h.userdata.ax1.children.children(2).polyline_style=1;
            h.userdata.ax1.children.children(2).line_style=8;
            h.userdata.ax1.children.children(2).thickness=2;
            h.userdata.ax1.children.children(2).foreground=5;
            h.userdata.ax1.children.children(2).visible='off';


            sca(h.userdata.ax2)
            plot(t,f2_data);
            h.userdata.ax2.title.text="Second Function (F2)"
            data_bounds=h.userdata.ax2.data_bounds;
            data_bounds=data_bounds .*[1,1.1;1,1.1];
            h.userdata.ax2.data_bounds=data_bounds;
            h.userdata.ax2.children.children.polyline_style=1;
            h.userdata.ax2.children.children.thickness=2;
            h.userdata.ax2.children.children.foreground=3;

            sca(h.userdata.ax3)
            plot(t,conv_data);
            h.userdata.ax3.title.text="Convolution (F1*F2)"
            data_bounds=h.userdata.ax3.data_bounds;
            data_bounds=data_bounds .*[1,1.1;1,1.1];
            h.userdata.ax3.data_bounds=data_bounds;
            h.userdata.ax3.children.children.polyline_style=1;
            h.userdata.ax3.children.children.thickness=2;
            h.userdata.ax3.children.children.foreground=4;
            h.userdata.init_plot=0;
        else
            // evalute f2 **************
            f2_data=flipdim(f2_data,2);

            // trimming f2
            N=round((h.userdata.t_max+h.userdata.t_min-h.userdata.t_shift)/h.userdata.t_step);
            SZ = size(h.userdata.t_data,2);

            if N >0 then
                f2_data=[f2_data(N+1:$),zeros(1,N)];
            elseif N<0
                f2_data=[zeros(1,abs(N)),f2_data(1:$-abs(N))];
            end

            f2_data(1)=0;
            f2_data($)=0;

            h.userdata.ax2.children.children.data=[h.userdata.t_data',f2_data'];

            // updating convolution plot
            N_conv=round((h.userdata.t_shift-h.userdata.t_min)/h.userdata.t_step);

            if ((N_conv <= SZ ) & (N_conv >= 1) ) 
                conv_data(N_conv:$)=0;
            elseif N_conv < 1 then
                conv_data(1:$)=0;
            end
            
            h.userdata.ax3.children.children.data=[h.userdata.t_data',conv_data'];
            
            f1_data=f1_data .* f2_data;
            h.userdata.ax1.children.children(1).data=[h.userdata.t_data',f1_data'];
        end

    else
        conv_gui();


    end

endfunction

// calling the conv_gui() function

conv_gui();