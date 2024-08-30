export default function FishCard() {
  // TODO(okhai): Replace with fish count from player state
  const caughtCount = 10;

  return (
    <div className="flex flex-row bg-white border-4 p-1 items-center font-bold">
      <span>CAUGHT: {caughtCount}</span>
      <img
        src="/magikarp.png"
        alt="Magikarp"
        className="-mr-1 -mt-4 w-12 object-contain"
      />
    </div>
  );
}
