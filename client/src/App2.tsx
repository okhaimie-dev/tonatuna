import ActionKeys from "./components/ActionKeys";
import BaitCard from "./components/BaitCard";
import FishCard from "./components/FishCard";
import PlayCard from "./components/PlayCard";
import WASDKeys from "./components/WASDKeys";

export default function App2() {
  return (
    <div className="absolute left-0 top-0 flex flex-col h-full w-full pointer-events-none">
      <div className="flex flex-col items-center justify-between h-full p-4">
        <div className="flex flex-row w-full justify-between">
          <BaitCard />
          <FishCard />
        </div>
        <PlayCard />
        <div className="flex flex-row w-full justify-between items-end">
          <WASDKeys />
          <ActionKeys />
        </div>
      </div>
    </div>
  );
}
