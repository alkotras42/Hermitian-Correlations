% Фиксированное число %
R1 = 100;
R2 = 0.01;
R3 = 100;

% Количество чисел внутри диапазона
count = 500;

% Диапазоны для фаз
range_a1 = linspace(0, 360, 500);
range_a3 = linspace(0, 360, 500);

% Инициализация матрицы для хранения результатов
result_AKF = zeros(count);
result_VKF = zeros(count);

% Порядок матрицы
n = 4;

% Биноминальные коэффикиенты для выбора векторов для ВКФ
combs = nchoosek(1:n, 2);

A2 = R2.*exp(1i*deg2rad(0));

% Основной цикл
for i=1:count

    A1 = R1.*exp(1i*deg2rad(range_a1(i)));

    for k=1:count
        A3 = R3.*exp(1i*deg2rad(range_a3(k)));
    
    
        % Строим эрмитову матрицу порядка n
        A = [0 A1 0 0; conj(A1) 0 A2 0; 0 conj(A2) 0 A3; 0 0 conj(A3) 0];
    
        % Вычисляем собственные вектора
        [eigen_vectors, N, W]=eig(A);

        index = (i-1) * count + k;
    
        % Вычисляем АКФ
        AKF = 0;
        for i_AKF=1:n
            [AKF(1:2*n-1,i_AKF),lagsAKF] = xcorr(eigen_vectors(1:n,i_AKF));
        end
        
        % Выбираем самый крупный боковой пик АКФ
        sorted_AKF = sort(AKF, 'descend');
        sorted_AKF_eig = sort(sorted_AKF(2,:), 'descend');
        result_AKF(i, k) = sorted_AKF_eig(1);

        % Вычисляем ВКФ
        VKF = 0;
        for i_VKF=1:n
            vec1 = eigen_vectors(1:n, combs(i_VKF, 1));
            vec2 = eigen_vectors(1:n, combs(i_VKF, 2));
            [VKF(1:2*n-1, i_VKF), lagsVKF]=xcorr(vec1, vec2);
        end
           
        % Выбираем самый крупный боковой пик ВКФ
        result_VKF(i, k) = max(abs(VKF), [],[1 2]);
    end
end



% 3D-поверхность АКФ
figure_AKF  = figure;
axes_AKF = axes('Parent',figure_AKF);
surf(range_a1, range_a3, abs(result_AKF), 'MeshStyle','column','LineWidth',0.1,'EdgeAlpha',0.2);
zlabel('Значение бокового пика','FontSize',14);
ylabel('Угол фазы коэффциента a_1','FontSize',14);
xlabel('Угол фазы коэффциента a_2','FontSize',14);
title('Зависимость бокового пика АКФ от углов фаз a_1 и a_2','FontSize',16);
grid on
set(axes_AKF, 'XLimitMethod','tight','YLimitMethod','tight');

% 3D-поверхность ВКФ
figure_VKF  = figure;
axes_VKF = axes('Parent',figure_VKF);
surf(range_a1, range_a3, abs(result_VKF), 'MeshStyle','column','LineWidth',0.1,'EdgeAlpha',0.2);
zlabel('Значение бокового пика','FontSize',14);
ylabel('Угол фазы коэффциента a_1','FontSize',14);
xlabel('Угол фазы коэффциента a_2','FontSize',14);
title('Зависимость бокового пика ВКФ от углов фаз a_1 и a_2','FontSize',16);
grid on
set(axes_VKF, 'XLimitMethod','tight','YLimitMethod','tight');