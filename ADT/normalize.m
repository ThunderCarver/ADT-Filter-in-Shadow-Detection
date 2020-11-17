function normalizedfeaturevector=normalize(featurevector)
    fmax=max(featurevector);
    fmin=min(featurevector);
    normalizedfeaturevector=(featurevector-fmin)./(fmax-fmin);
end
