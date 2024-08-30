import Key from "./Key";

export default function ActionKeys() {
  return (
    <div className="pointer-events-auto flex flex-row gap-2">
      <Key letter="f" />
      <Key letter="enter" />
    </div>
  );
}
