% create spectrogram function
    function [B,BA,F,T]=create_spectrogram(y,nfft,fs,w,dyn_range,logLinear_index,overlap_new)
        [B,F,T]=spectrogram(y,w,overlap_new,nfft,fs,'yaxis');
        BA=[];
        if (logLinear_index == 1)
            BA=20*log10(abs(B));
            BAM=max(BA);
            BAmax=max(BAM);
            BA(find(BA < BAmax-dyn_range))=BAmax-dyn_range;       
        end
    end