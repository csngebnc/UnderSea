export type Battle = {
  target: string;
  result?: string;
  units: Array<{ count: number; name: string }>;
};
