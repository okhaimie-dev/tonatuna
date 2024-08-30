import Key from "./Key";

export default function WASDKeys() {
  return (
    <div className="pointer-events-auto flex flex-col items-center gap-2">
      <Key letter="w" />
      <div className="flex flex-row gap-2">
        <Key letter="a" />
        <Key letter="s" />
        <Key letter="d" />
      </div>
    </div>
  );
}
