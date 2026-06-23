# Lottery System — FPGA Random Number Generator

> ⚠️ **本科课程作业 / Undergraduate Coursework**
> 这是我本科时期完成的课程作业，使用 Verilog 在 FPGA 上实现的随机数生成（抽奖）系统，仅供学习与存档之用。
> This is a coursework project I wrote during my undergraduate studies — a random number generator ("lottery") system implemented in Verilog on an FPGA. It is kept here for learning and archival purposes only.

---

## 中文

一个基于 FPGA 的硬件随机数生成器。通过按键触发一个高速自由计数的下标计数器，并在用户按下按键的瞬间采样其值，从而得到一个 0~57 范围内的伪随机数，结果以两位七段数码管显示。每抽取一个号码后可用范围会递减（不放回抽取），抽完后点亮 LED 提示复位。

### 大致流程
1. **按键同步与去抖** — `Synchronizer` + `Single_Pulser` 将异步按键转为单周期脉冲。
2. **状态控制** — `Controller` 作为状态机，在「就绪 / 生成 / 显示」之间切换。
3. **随机数生成** — `Index_Generator` 高速循环计数，按键瞬间采样得到随机下标，再经 `Index_Deliver` 取出。
4. **进制转换与显示** — `HexToBin` 拆分为十位/个位，`Seven_Segment_Decoder` 驱动数码管。
5. **计时与计数** — `Timer` 控制每次显示时长，`Counter` 统计已抽次数。

### 运行
在 Quartus（或同类 FPGA 工具）中以 `Lottery System Template/Lottery_System_Template.v` 为顶层模块，编译并烧录到开发板，分配 `clock`、`Key_V`、`Key_W` 及七段数码管引脚即可。

---

## English

A hardware random number generator built on an FPGA. A high-speed free-running index counter is sampled at the instant a key is pressed, yielding a pseudo-random number in the range 0–57 shown on two seven-segment displays. The available range shrinks after each draw (drawing without replacement); once exhausted, an LED signals that a reset is required.

### Rough Flow
1. **Key sync & debounce** — `Synchronizer` + `Single_Pulser` turn asynchronous key presses into single-cycle pulses.
2. **State control** — `Controller` is an FSM cycling through *idle / generate / display*.
3. **Number generation** — `Index_Generator` counts rapidly; its value is sampled on a key press and fetched via `Index_Deliver`.
4. **Conversion & display** — `HexToBin` splits the value into tens/ones, and `Seven_Segment_Decoder` drives the displays.
5. **Timing & counting** — `Timer` sets the display duration; `Counter` tracks the number of draws.

### Running
In Quartus (or an equivalent FPGA toolchain), set `Lottery System Template/Lottery_System_Template.v` as the top-level module, compile, and program the board — assigning the `clock`, `Key_V`, `Key_W`, and seven-segment pins.

---

## Modules
`Lottery_System_Template` · `Controller` · `Index_Controller` · `Index_Generator` · `Index_Deliver` · `Random_Number_Generator` · `HexToBin` · `Seven_Segment_Decoder` · `Synchronizer` · `Single_Pulser` · `Timer` · `Counter`
