function f=hungarian(c)
%SM_HUNGARIAN  hungarian method for the assignment problem.
%
%F = SM_HUNGARIAN(C), where C is a N-by-N matrix of cost,
%returns an N-by-1 vector of assignment, F.

[n_seeds,n_tmp]=size(c);

for i=1:n_seeds
    c(i,:)=c(i,:)-min(c(i,:));
end
for j=1:n_seeds
    c(:,j)=c(:,j)-min(c(:,j));
end

assign=1;
delete=2;

ttt=0;
while ttt>=0
	ttt=ttt+1;
%	f=zeros(n_seeds,1);
	
	mark=zeros(n_seeds);
	
	t=1;
	while t==1
            
		tag=1;
		while tag==1
            tag=0;
            max_unmark=0;
            
			for i=1:n_seeds
                z_v=zeros(1,n_seeds);
                zs=find(c(i,:)==0);
                n_zs=length(zs);
                for j=1:n_zs
                    z_v(zs(j))=1;
                end
                ass=find(mark(i,:)==assign);
                n_ass=length(ass);
                for j=1:n_ass
                    z_v(ass(j))=0;
                end
                del=find(mark(i,:)==delete);
                n_del=length(del);
                for j=1:n_del
                    z_v(del(j))=0;
                end
                n_unmark=n_zs-n_ass-n_del;
                if n_unmark>max_unmark
                    max_unmark=n_unmark;
                end
                if n_unmark==1
                    unmark=find(z_v==1);
                    k=unmark(1);
                    mark(i,k)=assign;
                    zcol=find(c(:,k)==0);
                    n_zcol=length(zcol);
                    for j=1:n_zcol
                        L=zcol(j);
                        if L~=i
                            mark(L,k)=delete;
                        end
                    end
                    tag=1;
                end
			end
			
			for i=1:n_seeds
                z_v=zeros(1,n_seeds);
                zs=find(c(:,i)==0);
                n_zs=length(zs);
                for j=1:n_zs
                    z_v(zs(j))=1;
                end
                ass=find(mark(:,i)==assign);
                n_ass=length(ass);
                for j=1:n_ass
                    z_v(ass(j))=0;
                end
                del=find(mark(:,i)==delete);
                n_del=length(del);
                for j=1:n_del
                    z_v(del(j))=0;
                end
                n_unmark=n_zs-n_ass-n_del;
                if n_unmark>max_unmark
                    max_unmark=n_unmark;
                end
                if n_unmark==1
                    unmark=find(z_v==1);
                    k=unmark(1);
                    mark(k,i)=assign;
                    zcol=find(c(k,:)==0);
                    n_zcol=length(zcol);
                    for j=1:n_zcol
                        L=zcol(j);
                        if L~=i
                            mark(k,L)=delete;
                        end
                    end
                    tag=1;
                end
			end
		end
		
		t=0;
		if max_unmark>=2
            for i=1:n_seeds
                for j=1:n_seeds
                    if c(i,j)==0 & mark(i,j)==0
                        mark(i,j)=assign;
                        zrow=find(c(i,:)==0);
                        n_zrow=length(zrow);
                        for k=1:n_zrow
                            L=zrow(k);
                            if L~=j
                                mark(i,L)=delete;
                            end
                        end
                        zcol=find(c(:,j)==0);
                        n_zcol=length(zcol);
                        for k=1:n_zcol
                            L=zcol(k);
                            if L~=i
                                mark(L,j)=delete;
                            end
                        end
                        t=1;
                        break;
                    end
                end
                if t==1
                    break;
                end
            end
		end
	end
	
	f=zeros(n_seeds,1);
	n_f=0;
	for i=1:n_seeds
        m=find(mark(i,:)==assign);
        if ~isempty(m)
            f(i)=m(1);
            n_f=n_f+1;
        end
	end
	
	if n_f==n_seeds
        return;
	end
	
	rows=zeros(1,n_seeds);
	cols=zeros(1,n_seeds);
	
	for i=1:n_seeds
        if isempty(find(mark(i,:)==assign))
            rows(i)=1;
        end
	end
	
	s=1;
	while s==1
        s=0;
        
		i_rows=find(rows==1);
		for j=1:n_seeds
            if cols(j)==1
                continue;
            end
            zcol=find(c(:,j)==0);
            n_zcol=length(zcol);
            for k=1:n_zcol
                if ~isempty(find(i_rows==zcol(k)))
                    cols(j)=1;
                    s=1;
                    break;
                end
            end
		end
		i_cols=find(cols==1);
		
		for i=1:n_seeds
            if rows(i)==1
                continue;
            end
            zrow=find(mark(i,:)==assign);
            n_zrow=length(zrow);
            for k=1:n_zrow
                if ~isempty(find(i_cols==zrow(k)))
                    rows(i)=1;
                    s=1;
                    break;
                end
            end
		end
	end
            
    cp=zeros(1,n_seeds);
	nk=0;
	for i=1:n_seeds
        if rows(i)==0
            continue;
        end
        nk=nk+1;
        cp(nk,:)=c(i,:);
	end
    cpp=zeros(nk,1);
	nk=0;
	for j=1:n_seeds
        if cols(j)==1
            continue;
        end
        nk=nk+1;
        cpp(:,nk)=cp(:,j);
	end
	
	mm=min(min(cpp));
	
	i_rows=find(rows==0);
	i_cols=find(cols==1);
	for i=1:n_seeds
        for j=1:n_seeds
            if isempty(find(i_rows==i)) & isempty(find(i_cols==j))
                c(i,j)=c(i,j)-mm;
            elseif ~isempty(find(i_rows==i)) & ~isempty(find(i_cols==j))
                c(i,j)=c(i,j)+mm;
            end
        end
	end
end