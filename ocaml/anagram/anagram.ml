open Core.Std

module M = Char.Map

let to_map word = 
  let inc m c = M.update m c 
      ~f:(Option.value_map ~default:1 ~f:((+) 1)) in
  String.fold word ~init:M.empty ~f:inc

let anagrams base candidates = 
  let base' = String.lowercase base in 
  let base_map = to_map base' in
  List.filter candidates ~f:(fun x ->
      let w = String.lowercase x in
      w <> base' && M.equal (=) base_map (to_map w))
