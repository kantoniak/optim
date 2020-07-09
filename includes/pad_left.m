function [padded] = pad_left(str, numberOfCharacters, padCharacter)
    if is_octave() ~= 0
        str_length = length(str);
        to_add = numberOfCharacters - str_length;
        padded = cstrcat(cstrcat(repmat(padCharacter, 1, to_add)), str);
    else
        padded = pad(str, numberOfCharacters, 'left', padCharacter);
    end
end
