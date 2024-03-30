# Aulsメモリ参照 1.00以降対応パッチ実行ワークフロー

GitHub Workflowsを利用してパッチを当てるリポジトリです<br>
成果物は**Releases**から入手できます

## 変更について
### `04c0 74 → 7D`
`(現在のバージョン)==1.00`だったものを`(現在のバージョン)>=1.00`にするものです
```diff
 100010b3 ff d2           CALL       EDX ; exfunc->get_sys_info
 100010b5 83 c4 08        ADD        ESP,0x8
 100010b8 81 7c 24 44     CMP        dword ptr [ESP + 0x44],0x2710 ; si.build, 10000
          10 27 00 00
-100010c0 74 0a           JE         LAB_100010cc
+100010c0 7d 0a           JGE        LAB_100010cc
 100010c2 b8 02 00 00 00  MOV        EAX,0x2 ; ERRORCODE_AVIUTL_VERSION_WRONG
 100010c7 5f              POP        EDI
 100010c8 83 c4 4c        ADD        ESP,0x4c
 100010cb c3              RET
```
`04c0`は仮想アドレス上の`100010c0`であり、`JE`命令を`JGE`命令に置き換えています

### `7ff7:7ffc 2F 30 2E 39 32 00 → 7E 2F 30 2E 39 32`
プラグインフィルタ情報で確認できる内容を「Aulsメモリ参照 for 1.00~/0.92」へとするものです

`[7fe0:7fff]`(仮想アドレスでは`[100093e0:100093ff]`) はプラグイン情報を表す文字列です<br>
`7ff7`は`Aulsメモリ参照 for 1.00/0.92`の`/`の位置であり、ここに`~`すなわち`7E`を挿入しています

## ライセンス
このリポジトリのソースコードはThe Unlicenseで提供します<br>
オリジナルのファイルの権利はyu_noimage_氏 ( https://auls.client.jp )の元にあります
