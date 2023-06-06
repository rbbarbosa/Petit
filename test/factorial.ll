declare i32 @_read(i32)
declare i32 @_write(i32)

define i32 @main() {
  call i32 @_main(i32 0)
  ret i32 0
}

define i32 @_factorial(i32 %n) {
  %1 = add i32 %n, 0
  %2 = icmp ne i32 %1, 0
  br i1 %2, label %L1then, label %L1else
L1then:
  %3 = add i32 %n, 0
  %4 = add i32 %n, 0
  %5 = add i32 1, 0
  %6 = sub i32 %4, %5
  %7 = call i32 @_factorial(i32 %6)
  %8 = mul i32 %3, %7
  br label %L1end
L1else:
  %9 = add i32 1, 0
  br label %L1end
L1end:
  %10 = phi i32 [%8, %L1then], [%9, %L1else]
  ret i32 %10
}

define i32 @_main(i32 %i) {
  %1 = add i32 0, 0
  %2 = call i32 @_read(i32 %1)
  %3 = call i32 @_factorial(i32 %2)
  %4 = call i32 @_write(i32 %3)
  ret i32 %4
}

