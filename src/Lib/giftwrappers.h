/* file giftwrappers.h contains prototypes to the gift wrapping methods,
 * wrapped through the Ada code use_giftwrap of PHCpack */

int convex_hull_2d ( int nc_pts, char *pts, int *nc_hull, char *hull );
/*
 * DESCRIPTION :
 *   Computes the convex hull of a planar point configuration.
 *
 * REQUIRED :
 *   All coordinates of the points have integer values.
 *
 * ON ENTRY :
 *   nc_pts   number of characters in the string representation of
 *            a point configuration, as a list of tuples;
 *   pts      string representation of a Python-style list of tuples,
 *            e.g.: "[(7, 3), (-2, 1), (2, -5), (-3, -4), (-3, 7)]"
 *
 * ON RETURN :
 *   nc_hull  number of characters in the string representation of
 *            the convex hull, as a tuple of two lists of tuples;
 *   hull     string representation of two tuples, the first is a
 *            list of vertex points, the second element of the tuple
 *            is a list of inner normals. */  

int convex_hull ( int nc_pts, char *pts );
/*
 * DESCRIPTION :
 *   Computes the convex hull of a point configuration in 3-space or 4-space.
 *   The container is initialized with the list of facets.
 *
 * REQUIRED :
 *   All coordinates of the points have integer values.
 *
 * ON ENTRY :
 *   nc_pts   number of characters in the string representation of
 *            a point configuration, as a list of tuples;
 *   pts      string representation of a Python-style list of tuples. */

int number_of_facets ( int dim, int *nbr );
/*
 * DESCRIPTION :
 *   Returns the number of facets of a convex hull in the space
 *   of dimension dim.
 *
 * REQUIRED :
 *   The function convex_hull in the correct dimension has been called.
 *
 * ON ENTRY :
 *   dim      dimension of the ambient space.
 *
 * ON RETURN :
 *   nbr      number of facets of the convex hull. */

int retrieve_facet ( int dim, int fcn, int *nc_rep, char *fctrep );
/*
 * DESCRIPTION :
 *   Returns the string representation of a facet given the dimension
 *   and its facet number.
 *
 * REQUIRED :
 *   The function convex_hull in the correct dimension has been called
 *   and fcn is in the range 0..nbr-1, where number_of_facets(dim,&nbr).
 *
 * ON ENTRY :
 *   dim      dimension of the ambient space;
 *   fcn      facet number.
 *
 * ON RETURN :
 *   nc_rep   number of characters in the string representation of the facet;
 *   fctrep   string representation of the facet with number fcn, as a tuple
 *            of four elements, at respective positions in the tuple:
 *            0. the value of the support function at the facet,
 *            1. the inner normal to the facet, which jointly with item 0
 *               defines the hyperplane supporting the facet;
 *            2. indices of the points that span the facet,
 *               the index k will refer to the k-th point represented by
 *               the argument pts of the function convex_hull above,
 *               note that the index count starts at one instead of zero;
 *            3. number of adjacent facets, with the facet count starting
 *               at zero. */
