### Individually Convert SVG to PNG

```
convert -resize 1200x628 -gravity center -extent 1200x628 svg/333.svg png/333.png
convert -resize 1200x628 -gravity center -extent 1200x628 svg/333oh.svg png/333oh.png
convert -resize 1200x628 -gravity center -extent 1200x628 svg/333bf.svg png/333bf.png
convert -resize 1200x628 -gravity center -extent 1200x628 svg/333fm.svg png/333fm.png
```



### Batch Convert SVG to PNG

```
mogrify -format png -path png -resize 900x471 -gravity center -extent 1200x628 svg/*.svg
```



### Append Images

```
convert svg/333.svg svg/222.svg svg/333oh.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1000x628 -gravity center -extent 1200x628 png/1.png
```

```
convert svg/444.svg svg/555.svg svg/666.svg svg/777.svg svg/minx.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1100x628 -gravity center -extent 1200x628 png/2.png
```

```
convert svg/333bf.svg svg/444bf.svg svg/555bf.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1000x628 -gravity center -extent 1200x628 png/3.png
```


