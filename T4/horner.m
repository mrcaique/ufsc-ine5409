function y = horner(n, a, xi)
  for ip = 1 : length(xi)
    y(ip) = a(n + 1);
    for i = n : -1 : 1
      y(ip) = a(i) + y(ip) * xi(ip);
    end
  end
end
