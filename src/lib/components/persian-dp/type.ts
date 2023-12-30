import type { ThemeValue } from "./store";

export enum DayType {
    PrevMonth,
    CurrentMonth,
    NextMonth,
    DayName
}

export interface Day {
    value: number | string;
    type: DayType;
    date? : Date
}

export interface DPOptions{
    theme : ThemeValue
}