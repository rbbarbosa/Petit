declare i32 @_read(i32)
declare i32 @_write(i32)

define i32 @main() {
  call i32 @_main(i32 0)
  ret i32 0
}

define i32 @_mod(i32 %m, i32 %n) {
  %1 = add i32 %m, 0
  %2 = add i32 %m, 0
  %3 = add i32 %n, 0
  %4 = sdiv i32 %2, %3
  %5 = add i32 %n, 0
  %6 = mul i32 %4, %5
  %7 = sub i32 %1, %6
  ret i32 %7
}

define i32 @_gcd(i32 %a, i32 %b) {
  %1 = add i32 %a, 0
  %2 = add i32 %b, 0
  %3 = call i32 @_mod(i32 %1, i32 %2)
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %L1then, label %L1else
L1then:
  %5 = add i32 %b, 0
  %6 = add i32 %a, 0
  %7 = add i32 %b, 0
  %8 = call i32 @_mod(i32 %6, i32 %7)
  %9 = call i32 @_gcd(i32 %5, i32 %8)
  br label %L1end
L1else:
  %10 = add i32 %b, 0
  br label %L1end
L1end:
  %11 = phi i32 [%9, %L1then], [%10, %L1else]
  ret i32 %11
}

define i32 @_main(i32 %i) {
  %1 = add i32 366, 0
  %2 = add i32 60, 0
  %3 = call i32 @_gcd(i32 %1, i32 %2)
  %4 = call i32 @_write(i32 %3)
  ret i32 %4
}

