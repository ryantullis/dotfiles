#!/usr/bin/env python3
# Waybar module: shows how many Anki cards are still due today.
# Uses AnkiConnect while Anki is open (it locks the collection), otherwise
# reads the collection directly with the anki library.
import json
import os
import urllib.request

COLLECTION = os.path.expanduser("~/.local/share/Anki2/User 1/collection.anki2")


def counts_from_ankiconnect():
    def call(action, **params):
        req = json.dumps({"action": action, "version": 6, "params": params}).encode()
        with urllib.request.urlopen("http://127.0.0.1:8765", req, timeout=2) as r:
            return json.load(r)["result"]

    # Parent deck counts already include their subdecks. Query one deck at a
    # time: an empty hidden Default deck makes the whole request fail.
    counts = {}
    for deck in call("deckNames"):
        if "::" in deck:
            continue
        for s in (call("getDeckStats", decks=[deck]) or {}).values():
            counts[s["name"]] = (s["new_count"], s["learn_count"], s["review_count"])
    return counts


def counts_from_collection():
    from anki.collection import Collection

    col = Collection(COLLECTION)
    try:
        tree = col.sched.deck_due_tree()
        return {d.name: (d.new_count, d.learn_count, d.review_count) for d in tree.children}
    finally:
        col.close()


def main():
    try:
        counts = counts_from_ankiconnect()
    except Exception:
        try:
            counts = counts_from_collection()
        except Exception as e:
            print(json.dumps({"text": "󰘸 ?", "class": "unknown", "tooltip": f"Anki: {e}"}, ensure_ascii=False))
            return

    due = sum(sum(c) for c in counts.values())
    lines = [f"{name}: {n} new, {l} learn, {r} review" for name, (n, l, r) in counts.items() if n + l + r]
    if due:
        out = {"text": f"󰘸 {due}", "class": "pending", "tooltip": "Anki due\n" + "\n".join(lines)}
    else:
        out = {"text": "󰘸 ", "class": "done", "tooltip": "Anki: all done for today"}
    print(json.dumps(out, ensure_ascii=False))


if __name__ == "__main__":
    main()
