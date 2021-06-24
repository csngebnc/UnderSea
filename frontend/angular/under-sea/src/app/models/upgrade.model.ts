import { Effect } from './effect.model';

export type Upgrade = {
    id: string;
    name: string;
    exists: boolean;
    underConstruction: boolean;
    timeRemaining?: number;
    effects: Array<Effect>;
}