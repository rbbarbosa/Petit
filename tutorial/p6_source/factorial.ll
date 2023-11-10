declare i32 @_read(i32)
declare i32 @_write(i32)

define i32 @_factorial(i32 %n) {
  %1 = alloca i32
  %2 = add i32 %n, 0
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %L1then, label %L1else
L1then:
  %4 = add i32 %n, 0
  %5 = add i32 %n, 0
  %6 = add i32 1, 0
  %7 = sub i32 %5, %6
  %8 = call i32 @_factorial(i32 %7)
  %9 = mul i32 %4, %8
  store i32 %9, i32* %1
  br label %L1end
L1else:
  %10 = add i32 1, 0
  store i32 %10, i32* %1
  br label %L1end
L1end:
  %11 = load i32, i32* %1
  ret i32 %11
}
