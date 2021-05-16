# randomizer

Randomize creation of PUBG teams built with Flutter.

## Usage

Install Flutter dependencies, build the release version and run a simple Python server

```bash
flutter build web --release
cd build/web
python3 -m http.server 8080
```

or run the app containerized

```bash
docker build -t randomizer .
docker run --name randomizer -p 8080:8080 randomizer
```