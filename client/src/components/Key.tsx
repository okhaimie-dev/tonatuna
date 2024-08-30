export default function Key({ letter }: { letter: string }) {
  return (
    <button
      className="flex items-center justify-center min-w-10 h-10 bg-white border-4 p-2 font-bold"
      onClick={() => {
        // trigger keypress event
        const event = new KeyboardEvent("keydown", { key: letter });
        document.dispatchEvent(event);
      }}
    >
      {letter.toUpperCase()}
    </button>
  );
}
