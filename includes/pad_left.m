function [padded] = pad_left(str, min_chars, pad_char)
% -- [padded] = pad_left(str, min_chars, pad_char)
%
%     Padds string `str` with character `pad_char` to be at least `min_chars`
%     characters long.

    if is_octave() ~= 0
        str_length = length(str);
        to_add = min_chars - str_length;
        padded = cstrcat(cstrcat(repmat(pad_char, 1, to_add)), str);
    else
        padded = pad(str, min_chars, 'left', pad_char);
    end
end
