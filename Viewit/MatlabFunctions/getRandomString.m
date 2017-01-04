function [ randomString ] = getRandomString( len )

    SET = char(['a':'z' 'A':'Z' '0':'9']) ;
    NSET = length(SET) ;

    pos = randi(NSET, len, 1);
    randomString = SET(pos);

end

