% Диапазоны для фаз
phi1 = linspace(0, 2*pi, 100); % Угол для A1
phi2 = linspace(0, 2*pi, 100); % Угол для A2
phi3 = linspace(0, 2*pi, 100); % Угол для A3

% Создаем сетку для phi1 и phi2
[Phi1, Phi2] = meshgrid(phi1, phi2);

% Инициализация видеозаписи
writerObj = VideoWriter('phase_animation_phi3.avi');
writerObj.FrameRate = 30; % Частота кадров
open(writerObj);



% Основной цикл по phi3
for k = 1:length(phi3)
    % Текущее значение phi3
    current_phi3 = phi3(k);
    
    % Инициализация матрицы для хранения боковых максимумов
    max_side_lobe = zeros(size(Phi1));
    
    % Вычисление бокового максимума для каждой комбинации phi1 и phi2
    for i = 1:numel(Phi1)
        % Построение эрмитовой матрицы
        H = [0 100*exp(1i*Phi1(i)) 0 0; conj(100*exp(1i*Phi1(i))) 0 0.001*exp(1i*Phi2(i)) 0; 0 conj(0.001*exp(1i*Phi2(i))) 0 100*exp(1i*current_phi3); 0 0 conj(100*exp(1i*current_phi3)) 0];

        % Вычисляем собственные вектора
        [eigen_vectors, N, W]=eig(H);

    
        % Вычисляем АКФ
        AKF = 0;
        for i_AKF=1:n
            [AKF(1:2*n-1,i_AKF),lagsAKF] = xcorr(eigen_vectors(1:n,i_AKF));
        end
        
        % Выбираем самый крупный боковой пик АКФ
        sorted_AKF = sort(AKF, 'descend');
        sorted_AKF_eig = sort(sorted_AKF(2,:), 'descend');
        max_side_lobe(i) = sorted_AKF_eig(1);


    end

    fprintf('Обработка phi3 = %.2f (шаг %d из %d)\n', current_phi3, k, length(phi3));

    fig = figure('Visible', 'off'); % Фигура не отображается на экране
    
    % Построение тепловой карты для текущего phi3
    set(fig, 'Position', [0, 0, 1920, 1080]);
    surf(phi1, phi2, abs(max_side_lobe), 'MeshStyle','column','LineWidth',0.1,'EdgeAlpha',0.2);
    xlabel('\phi_1');
    ylabel('\phi_2');
    title(['Зависимость бокового максимума при \phi_3 = ', num2str(current_phi3)]);
    colorbar;
    axis xy;
    
    % Захват кадра и добавление его в видео
    frame = getframe(fig);
    writeVideo(writerObj, frame);
    
    % Очистка графика для следующего кадра
    clf;
end

% Закрытие видеозаписи
close(writerObj);
disp('Анимация сохранена в файл phase_animation.avi');