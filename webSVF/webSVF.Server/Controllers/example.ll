; ModuleID = 'Controllers/example.c'
source_filename = "Controllers/example.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @bar(i32 noundef %s) #0 !dbg !10 {
entry:
  %s.addr = alloca i32, align 4
  store i32 %s, ptr %s.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %s.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, ptr %s.addr, align 4, !dbg !17
  ret i32 %0, !dbg !18
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 !dbg !19 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %p = alloca i32, align 4
  %q = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  call void @llvm.dbg.declare(metadata ptr %a, metadata !22, metadata !DIExpression()), !dbg !23
  %call = call i32 @source(), !dbg !24
  store i32 %call, ptr %a, align 4, !dbg !23
  %0 = load i32, ptr %a, align 4, !dbg !25
  %cmp = icmp sgt i32 %0, 0, !dbg !27
  br i1 %cmp, label %if.then, label %if.else, !dbg !28

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata ptr %p, metadata !29, metadata !DIExpression()), !dbg !31
  %1 = load i32, ptr %a, align 4, !dbg !32
  %call1 = call i32 @bar(i32 noundef %1), !dbg !33
  store i32 %call1, ptr %p, align 4, !dbg !31
  %2 = load i32, ptr %p, align 4, !dbg !34
  call void @sink(i32 noundef %2), !dbg !35
  br label %if.end, !dbg !36

if.else:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata ptr %q, metadata !37, metadata !DIExpression()), !dbg !39
  %3 = load i32, ptr %a, align 4, !dbg !40
  %call2 = call i32 @bar(i32 noundef %3), !dbg !41
  store i32 %call2, ptr %q, align 4, !dbg !39
  %4 = load i32, ptr %q, align 4, !dbg !42
  call void @sink(i32 noundef %4), !dbg !43
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %5 = load i32, ptr %retval, align 4, !dbg !44
  ret i32 %5, !dbg !44
}

declare i32 @source(...) #2

declare void @sink(i32 noundef) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.dbg.cu = !{!7}
!llvm.ident = !{!9}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 14, i32 4]}
!1 = !{i32 7, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 8, !"PIC Level", i32 2}
!5 = !{i32 7, !"uwtable", i32 1}
!6 = !{i32 7, !"frame-pointer", i32 1}
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !8, producer: "Apple clang version 15.0.0 (clang-1500.3.9.4)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk", sdk: "MacOSX.sdk")
!8 = !DIFile(filename: "Controllers/example.c", directory: "/Users/joshuasy/Code/codeGPT_thesis/capstone-dotnet8/webSVF/webSVF.server")
!9 = !{!"Apple clang version 15.0.0 (clang-1500.3.9.4)"}
!10 = distinct !DISubprogram(name: "bar", scope: !8, file: !8, line: 3, type: !11, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !14)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{}
!15 = !DILocalVariable(name: "s", arg: 1, scope: !10, file: !8, line: 3, type: !13)
!16 = !DILocation(line: 3, column: 13, scope: !10)
!17 = !DILocation(line: 4, column: 12, scope: !10)
!18 = !DILocation(line: 4, column: 5, scope: !10)
!19 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 6, type: !20, scopeLine: 6, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !14)
!20 = !DISubroutineType(types: !21)
!21 = !{!13}
!22 = !DILocalVariable(name: "a", scope: !19, file: !8, line: 7, type: !13)
!23 = !DILocation(line: 7, column: 9, scope: !19)
!24 = !DILocation(line: 7, column: 13, scope: !19)
!25 = !DILocation(line: 8, column: 9, scope: !26)
!26 = distinct !DILexicalBlock(scope: !19, file: !8, line: 8, column: 9)
!27 = !DILocation(line: 8, column: 11, scope: !26)
!28 = !DILocation(line: 8, column: 9, scope: !19)
!29 = !DILocalVariable(name: "p", scope: !30, file: !8, line: 9, type: !13)
!30 = distinct !DILexicalBlock(scope: !26, file: !8, line: 8, column: 15)
!31 = !DILocation(line: 9, column: 13, scope: !30)
!32 = !DILocation(line: 9, column: 21, scope: !30)
!33 = !DILocation(line: 9, column: 17, scope: !30)
!34 = !DILocation(line: 10, column: 14, scope: !30)
!35 = !DILocation(line: 10, column: 9, scope: !30)
!36 = !DILocation(line: 11, column: 5, scope: !30)
!37 = !DILocalVariable(name: "q", scope: !38, file: !8, line: 12, type: !13)
!38 = distinct !DILexicalBlock(scope: !26, file: !8, line: 11, column: 10)
!39 = !DILocation(line: 12, column: 13, scope: !38)
!40 = !DILocation(line: 12, column: 21, scope: !38)
!41 = !DILocation(line: 12, column: 17, scope: !38)
!42 = !DILocation(line: 13, column: 14, scope: !38)
!43 = !DILocation(line: 13, column: 9, scope: !38)
!44 = !DILocation(line: 15, column: 1, scope: !19)
