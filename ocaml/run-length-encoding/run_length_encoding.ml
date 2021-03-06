open Core.Std

let encode s = 
  let to_string c = function 
    | 1 -> String.of_char c
    | n -> Int.to_string n ^ String.of_char c in
  s
  |> String.to_list
  |> List.group ~break:(<>)
  |> List.map ~f:(fun e -> to_string (List.hd_exn e) (List.length e))
  |> String.concat

let decode s = 
  String.fold s ~init:("", None)
    ~f:(fun (r, counter) c -> match (counter, Char.is_digit c) with
        | (None, true)
          -> (r, Some (Char.get_digit_exn c))
        | (None, false) -> (r ^ String.make 1 c, None)
        | (Some n, true) 
          -> (r, Some (n * 10 + Char.get_digit_exn c))
        | (Some n, false) -> (r ^ String.make n c, None))
  |> fst
