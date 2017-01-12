function OneError = Metric_OneError(Outputs, test_target)
%Computing the one error
%Outputs: the predicted outputs of the classifier, the output of the ith instance for the jth class is stored in Outputs(j,i)
%test_target: the actual labels of the test instances, if the ith instance belong to the jth class, test_target(j,i)=1, otherwise test_target(j,i)=-1
  
    [num_class, num_instance] = size(Outputs);
    temp_Outputs = [];
    temp_test_target = [];
    for i = 1:num_instance
        temp = test_target(:,i);   %��i�����������ı��������1-(-1)����
        if((sum(temp)~=num_class)&(sum(temp)~=-num_class))  %��ȫΪ1�����߲�ȫΪ-1
            temp_Outputs = [temp_Outputs,Outputs(:,i)];
            temp_test_target = [temp_test_target,temp];
        end
    end
    Outputs = temp_Outputs;    %������ȫΪ1��ȫΪ-1�Ĳ�������ȥ��
    test_target = temp_test_target;     
    [num_class, num_instance] = size(Outputs);
    
    Label = cell(num_instance,1);      %ÿ�������������еı�ǩ����
    not_Label = cell(num_instance,1);  %ÿ���������������еı�ǩ����
    Label_size = zeros(1,num_instance);  %ÿ�������������еı�ǩ��
    for i = 1:num_instance
        temp = test_target(:,i);
        Label_size(1,i) = sum(temp==ones(num_class,1));
        for j = 1:num_class
            if(temp(j)==1)
                Label{i,1} = [Label{i,1},j];
            else
                not_Label{i,1} = [not_Label{i,1},j];
            end
        end
    end
    
    oneerr = 0;
    for i = 1:num_instance
        indicator = 0;
        temp = Outputs(:,i);
        [maximum,index] = max(temp);
        for j = 1:num_class
            if(temp(j)==maximum)
                if(ismember(j,Label{i,1}))  %��i����������������������Ӧ�����ǩ�ڸ������ı�ǩ������
                    indicator = 1;
                    break;
                end
            end
        end
        if(indicator==0)
            oneerr = oneerr+1;   %�ۼ� ��������������������Ӧ�����ǩ���ڸ������ı�ǩ������ ������ķ�������
        end
    end
    OneError = oneerr/num_instance;
    