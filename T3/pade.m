function [a b] = pade(n_pade, m_pade, mac)
    k = n_pade - m_pade;
    for i = 1 : m_pade
        for j = 1 : i
            m(i, j) = mac(k+i+j);
            m(j, i) = m(i, j);
        end
        m(i, m_pade+1) = -mac(n_pade+i+1);
    end

    aux = gauss(m_pade, m);
    b = fliplr(aux);
    b(m_pade + 1 : n_pade) = 0;

    b = [1 b];
    a(1) = mac(1);
    for i = 2 : n_pade + 1
        r = mac(i);
        for j = 1 : i - 1
            r = r + b(j+1) * mac(i-j);
        end
        a(i) = r;
    end
end

