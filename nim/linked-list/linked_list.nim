type
  LinkedList*[T] = object ## A doubly linked list.
    head: Node[T]
    count: int

  Node[T] = ref object
    prev: Node[T]
    next: Node[T]
    data: T

proc len*[T](list: LinkedList[T]): int =
  ## Returns the number of nodes in `list`.
  list.count

proc push*[T](list: var LinkedList[T], val: T) =
  ## Appends a node with the given `val` to `list`.
  if list.head == nil:
    list.head = Node[T](data: val)
  else:
    var node = list.head
    while node.next != nil:
      node = node.next

    node.next = Node[T](prev: node, data: val)

  list.count += 1

proc pop*[T](list: var LinkedList[T]): T =
  ## Removes the final node of `list` and returns its value.
  var node = list.head
  while node.next != nil:
    node = node.next

  if node.prev == nil:
    list.head = nil
  else:
    node.prev.next = nil

  list.count -= 1
  node.data

proc shift*[T](list: var LinkedList[T]): T =
  ## Removes the first node of `list` and returns its value.
  var val = list.head.data
  list.head = list.head.next
  if list.head != nil:
    list.head.prev = nil

  list.count -= 1
  val

proc unshift*[T](list: var LinkedList[T], val: T) =
  ## Prepends a node with the given `val` to `list`.
  var new = Node[T](next: list.head, data: val)
  if list.head != nil:
    list.head.prev = new

  list.count += 1
  list.head = new

proc delete*[T](list: var LinkedList[T], val: T) =
  ## Removes a node with value `val` from `list`.
  var node = list.head

  while node != nil:
    if node.data == val:
      if node.next == nil:
        discard list.pop
      elif node.prev == nil:
        discard list.shift
      else:
        node.prev.next = node.next
        node.next.prev = node.prev
        list.count -= 1

      return
    else:
      node = node.next
