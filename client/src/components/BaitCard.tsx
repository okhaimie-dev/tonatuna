export default function BaitCard() {
  // TODO(okhai): Replace with bait count from player state
  const baitCount = 10;

  return (
    <div className="flex flex-row bg-white border-4 p-1">
      {Array.from({ length: baitCount }).map((_, index) => (
        <img
          src="/weedle.png"
          alt="Weedle"
          id={`${index}`}
          className="-mx-2 -mt-4 w-12"
        />
      ))}
    </div>
  );
}
