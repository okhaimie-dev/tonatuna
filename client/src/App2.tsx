import PlayCard from "./components/PlayCard";
import useRecsToPhaser from "./hooks/useRecsToPhaser";

export default function App2() {
  useRecsToPhaser();

  return (
    <div className="absolute left-0 top-0 flex flex-col h-full w-full pointer-events-none">
      <div className="flex flex-col items-center justify-center h-full">
        <PlayCard />
      </div>
    </div>
  );
}
