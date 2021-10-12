(** Interfacing with Flint library. *)

open FfiLib

(* Pointer to a matrix in Flint *)
(* type matrix_ptr *)

(** Pointer to a rational matrix consisting of an integer denominator
    and an integer-valued matrix.
 *)
type rational_matrix_ptr

(** Create a matrix in Flint *)
val new_matrix : zz list list -> rational_matrix_ptr

(** Dummy value to import symbol when linking; do not use. *)
val dummy : unit -> unit

(** Get the contents of a matrix *)
val zz_matrix_of_matrix : rational_matrix_ptr -> zz list list

(** Compute the row Hermite normal form of the input matrix, done in-place.
    The input matrix can have arbitrary rank.
*)
val hermitize : rational_matrix_ptr -> unit

(** Given an (m x n) matrix A in row Hermite normal form whose non-zero rows
    are the first k rows, return an (n x n) matrix whose first k rows are those
    of A, and the other (n - k) rows are standard basis vectors whose 1's are
    in columns that have no leading entries in A.
*)
val extend_hnf_to_basis : rational_matrix_ptr -> rational_matrix_ptr

(** Given an invertible matrix, construct its inverse. *)
val matrix_inverse :
  rational_matrix_ptr -> rational_matrix_ptr

(** Create the product of two matrices *)
val matrix_multiply : rational_matrix_ptr -> rational_matrix_ptr -> rational_matrix_ptr

(* Get the pointer to the matrix part of a rational matrix.

Possible problem: Ocaml may not see that the returned matrix ptr points to
something that is reached by the structure itself, and the Ocaml values holding
the two pointers are different. When the one corresponding to the pointer to the
structure is garbage-collected, the matrix is also GC'ed, and the matrix
pointer becomes dangling.

val matrix_ptr_of_rational_matrix :
  rational_matrix_ptr -> matrix_ptr
*)

(** Get the contents of a rational matrix *)
val zz_denom_matrix_of_rational_matrix : rational_matrix_ptr -> zz * zz list list
