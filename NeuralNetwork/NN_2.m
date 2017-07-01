function NN_2(in_set,out_set,H_nodes,Learn_Rate,iteration_time)
in_set = transpose(in_set);
%axons(1) = axons count in_set->H_node, axons(1) =  H_node->out_set
axons = [ size(in_set,1)*H_nodes  H_nodes*size(out_set,2) ];
w = 2 * rand( 1, sum(axons) ,'double')- 1;
dE_Hnet(size(out_set,1))=zeros;
dE_Onet=zeros;
Onet =zeros;
Out = zeros;
    for N = 1:iteration_time
        for i = 1:size(out_set,1)
            %forward pp
            I = in_set(:,i);
            W1 = transpose(reshape(w(1:axons(1)),size(in_set,1),H_nodes));
            hnet = W1*I;  
            Oh  = sigmf(hnet,[1 0]); 
            Onet = w(axons(1)+1:sum(axons))*Oh; %a constant
            Out = sigmf(Onet,[1 0]); %a constant
            %backward pp
            dE_Onet = (Out-out_set(i))*Out*(1-Out);
            for h_o = 1:H_nodes
                w(h_o+axons(1)) = w(h_o+axons(1)) - dE_Onet*Oh(h_o)*Learn_Rate;
            end
            for i_o = 1:H_nodes
                dE_Hnet(i_o) = (w(i_o+axons(1))*dE_Onet)*Oh(i_o)*(1-Oh(i_o));
                for in = 1:size(in_set,1)
                    tar_w = in+(i_o-1)*2;  
                    w(tar_w) = w(tar_w) - dE_Hnet(i_o)*I(in)*Learn_Rate;
                end
            end
            
        end
    end
  W1 = transpose(reshape(w(1:axons(1)),size(in_set,1),H_nodes));
    for i = 1:size(in_set,2)
        I = in_set(:,i);
        hnet = W1*I;  
        Oh  = sigmf(hnet,[1 0]);
        Onet = w(axons(1)+1:sum(axons))*Oh; %a constant
        Out = sigmf(Onet,[1 0]); %a constant
        disp(Out);    
    end
end