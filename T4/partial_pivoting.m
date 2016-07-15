%{
	Partial pivoting of a matrix. The entry with largest absolute
    value from the column of the matrix that is currently being 
    considered as the pivot element, partial pivoting adjusts the
    main diagonal with these pivots.
    
    Args:
        k : column to be adjusted, with largest in the top
        (according with the respective line)
        n : number of the rows
        m : matrix to be "pivoted"

    Returns:
        m : pivoted matrix
    
    See:
        https://en.wikipedia.org/wiki/Pivot_element#Partial_and_complete_pivoting	
%}
function m = partial_pivoting(m, k, n)
	[MAX, i] = max(abs(m(k : n, k)));
	i += k - 1;
	aux = m(k, :);
	m(k, :) = m(i, :);
	m(i, :) = aux;
end
