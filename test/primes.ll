declare i32 @_read(i32)
declare i32 @_write(i32)

define i32 @_mod(i32 %a, i32 %b) {
  %1 = add i32 %a, 0
  %2 = add i32 %a, 0
  %3 = add i32 %b, 0
  %4 = sdiv i32 %2, %3
  %5 = add i32 %b, 0
  %6 = mul i32 %4, %5
  %7 = sub i32 %1, %6
  ret i32 %7
}

define i32 @_prime(i32 %n, i32 %divisor) {
  %1 = alloca i32
  %2 = add i32 %n, 0
  %3 = add i32 1, 0
  %4 = sub i32 %2, %3
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %L1then, label %L1else
L1then:
  %6 = alloca i32
  %7 = add i32 %n, 0
  %8 = add i32 %divisor, 0
  %9 = sub i32 %7, %8
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %L6then, label %L6else
L6then:
  %11 = alloca i32
  %12 = add i32 %n, 0
  %13 = add i32 %divisor, 0
  %14 = call i32 @_mod(i32 %12, i32 %13)
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %L11then, label %L11else
L11then:
  %16 = add i32 %n, 0
  %17 = add i32 %divisor, 0
  %18 = add i32 1, 0
  %19 = add i32 %17, %18
  %20 = call i32 @_prime(i32 %16, i32 %19)
  store i32 %20, i32* %11
  br label %L11end
L11else:
  %21 = add i32 0, 0
  store i32 %21, i32* %11
  br label %L11end
L11end:
  %22 = load i32, i32* %11
  store i32 %22, i32* %6
  br label %L6end
L6else:
  %23 = add i32 1, 0
  store i32 %23, i32* %6
  br label %L6end
L6end:
  %24 = load i32, i32* %6
  store i32 %24, i32* %1
  br label %L1end
L1else:
  %25 = add i32 0, 0
  store i32 %25, i32* %1
  br label %L1end
L1end:
  %26 = load i32, i32* %1
  ret i32 %26
}

define i32 @_list(i32 %m) {
  %1 = alloca i32
  %2 = add i32 %m, 0
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %L1then, label %L1else
L1then:
  %4 = alloca i32
  %5 = add i32 %m, 0
  %6 = add i32 2, 0
  %7 = call i32 @_prime(i32 %5, i32 %6)
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %L4then, label %L4else
L4then:
  %9 = add i32 %m, 0
  %10 = add i32 1, 0
  %11 = sub i32 %9, %10
  %12 = call i32 @_list(i32 %11)
  %13 = add i32 0, 0
  %14 = add i32 %m, 0
  %15 = call i32 @_write(i32 %14)
  %16 = mul i32 %13, %15
  %17 = add i32 %12, %16
  store i32 %17, i32* %4
  br label %L4end
L4else:
  %18 = add i32 %m, 0
  %19 = add i32 1, 0
  %20 = sub i32 %18, %19
  %21 = call i32 @_list(i32 %20)
  store i32 %21, i32* %4
  br label %L4end
L4end:
  %22 = load i32, i32* %4
  store i32 %22, i32* %1
  br label %L1end
L1else:
  %23 = add i32 0, 0
  store i32 %23, i32* %1
  br label %L1end
L1end:
  %24 = load i32, i32* %1
  ret i32 %24
}

define i32 @_main(i32 %i) {
  %1 = add i32 100, 0
  %2 = call i32 @_list(i32 %1)
  ret i32 %2
}

define i32 @main() {
  call i32 @_main(i32 0)
  ret i32 0
}
