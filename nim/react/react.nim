import std/options

type
  ComputeFunc = proc(vals: seq[int]): int {.noSideEffect.}

  Callback = proc(val: int)

  Cell = ref object
    val: int
    updatedVal: int             # During an update only updatedVal will be
                                # changed. That way intermediate values will be
                                # invisible to the callbacks. Only if the end
                                # result is different, we will invoke the
                                # callbacks.
    dependencies: seq[Cell]
    dependents: seq[Cell]
    compute: Option[ComputeFunc]
    callbacks: seq[Callback]

proc update(cell: Cell)
proc commit(cell: Cell)

proc value*(cell: Cell): int =
  cell.val

proc newInputCell*(val: int): Cell =
  Cell(val: val, updatedVal: val)

proc `value=`*(cell: Cell, val: int) =
  if cell.val != val:
    cell.updatedVal = val
    cell.update()

  cell.commit()

proc newComputeCell*(dependencies: seq[Cell], compute: ComputeFunc): Cell =
  var cell = Cell(val: 0, dependencies: dependencies, compute: some(compute))
  cell.update()
  cell.commit()

  for dependency in dependencies:
    dependency.dependents.add(cell)

  cell

proc addCallback*(cell: Cell, callback: Callback) =
  cell.callbacks.add(callback)

proc removeCallback*(cell: Cell, callback: Callback) =
  let idx = cell.callbacks.find(callback)
  if idx >= 0:
    cell.callbacks.delete(idx)

proc update(cell: Cell) =
  if cell.compute.isSome:
    var args: seq[int] = @[]
    for dependency in cell.dependencies:
      args.add(dependency.updatedVal)

    cell.updatedVal = get(cell.compute)(args)

  for dependent in cell.dependents:
    dependent.update()

proc commit(cell: Cell) =
  if cell.updatedVal != cell.val:
    cell.val = cell.updatedVal
    for callback in cell.callbacks:
      callback(cell.val)

  for dependent in cell.dependents:
    dependent.commit()
