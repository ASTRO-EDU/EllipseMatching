  function s = quartic(k,tol)
%QUARTIC Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    tol = 1e-12;
end

fprintf('\nquartic()\n');

% Normalize to x^4 + a*x^3 + b*x^2 + c*x + d = 0
a = k(2)/k(1);
b = k(3)/k(1);
c = k(4)/k(1);
d = k(5)/k(1);

printf('a,b,c,d:\n %.32f\n %.32f\n %.32f\n %.32f\n',a,b,c,d);

if d == 0

    % Cubic
    z = [1, a , b, c];
    t = cubic(z, tol);


    % Result
    s = [0 t];
    disp("s from cubic1");
    disp(s)
else

    % Depressed quartic y^4 + p*y^2 + q*y + r = 0
    p = (8*b - 3*a^2)/8;
    q = (a^3 - 4*a*b + 8*c)/8;
    r = (-3*a^4 + 256*d - 64*c*a + 16*a^2*b)/256;

    printf('p,q,r:\n %.32f\n %.32f\n %.32f\n',p,q,r);

    if q ~= 0 % Standard depressed quartic

        % Cubic
        z = [1 , p*5/2 , 2*p^2 - r , p^3/2 - p*r/2 - q^2/8];
        disp("z")
        disp(z)
        t = cubic(z, tol);

        disp("t from cubic real")
        disp(real(t))
        disp("t from cubic imag")
        disp(imag(t))

        % Search a positive non zero root
        g  = p + 2*t;
        id = NaN;
        for i = 1 : length(g)
            if  g(i) > 0
                id = i;
                break;
            end
        end
        if isnan(id)
            for i = 1 : length(g)
                if g(i) ~= 0
                    id = i;
                    break;
                end
            end
        end

        % Build the roots of the quartic
        u = t(id);
        v = sqrt(g(id));

        s = -k(2)/(4*k(1)) + 0.5*[   v + sqrt(-(3*p + 2*u + 2*q/v)) , ...
                                     v - sqrt(-(3*p + 2*u + 2*q/v)) , ...
                                   - v + sqrt(-(3*p + 2*u - 2*q/v)) , ...
                                   - v - sqrt(-(3*p + 2*u - 2*q/v)) ];

    else % Biquadratic

        d = p^2-4*r;

        if d ~= 0

            zp = (-p + sqrt(d))/2;
            zm = (-p - sqrt(d))/2;

            s = [sqrt(zp) , -sqrt(zp) , sqrt(zm) , -sqrt(zm)];

        else

            z = -p/2;

            s = [sqrt(z) , -sqrt(z)];

        end

    end


end





for i = 1:length(s)

    if abs(imag(s(i))) < tol
        s(i) = real(s(i));
    end

end



end
