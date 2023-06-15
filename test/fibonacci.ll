declare i32 @_read(i32)
declare i32 @_write(i32)

define i32 @_fib(i32 %n) {
  %1 = alloca i32
  %2 = add i32 %n, 0
  %3 = add i32 1, 0
  %4 = sub i32 %2, %3
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %L1then, label %L1else
L1then:
  %6 = alloca i32
  %7 = add i32 %n, 0
  %8 = add i32 2, 0
  %9 = sub i32 %7, %8
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %L6then, label %L6else
L6then:
  %11 = add i32 %n, 0
  %12 = add i32 2, 0
  %13 = sub i32 %11, %12
  %14 = call i32 @_fib(i32 %13)
  %15 = add i32 %n, 0
  %16 = add i32 1, 0
  %17 = sub i32 %15, %16
  %18 = call i32 @_fib(i32 %17)
  %19 = add i32 %14, %18
  store i32 %19, i32* %6
  br label %L6end
L6else:
  %20 = add i32 1, 0
  store i32 %20, i32* %6
  br label %L6end
L6end:
  %21 = load i32, i32* %6
  store i32 %21, i32* %1
  br label %L1end
L1else:
  %22 = add i32 1, 0
  store i32 %22, i32* %1
  br label %L1end
L1end:
  %23 = load i32, i32* %1
  ret i32 %23
}

define i32 @_seq(i32 %v) {
  %1 = alloca i32
  %2 = add i32 %v, 0
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %L1then, label %L1else
L1then:
  %4 = add i32 %v, 0
  %5 = add i32 1, 0
  %6 = sub i32 %4, %5
  %7 = call i32 @_seq(i32 %6)
  %8 = add i32 %v, 0
  %9 = call i32 @_fib(i32 %8)
  %10 = call i32 @_write(i32 %9)
  %11 = add i32 0, 0
  %12 = mul i32 %10, %11
  %13 = add i32 %7, %12
  store i32 %13, i32* %1
  br label %L1end
L1else:
  %14 = add i32 0, 0
  store i32 %14, i32* %1
  br label %L1end
L1end:
  %15 = load i32, i32* %1
  ret i32 %15
}

define i32 @_main(i32 %i) {
  %1 = add i32 20, 0
  %2 = call i32 @_seq(i32 %1)
  ret i32 %2
}

define i32 @main() {
  call i32 @_main(i32 0)
  ret i32 0
}
