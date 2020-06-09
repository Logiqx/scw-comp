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



### Batch Convert SVG to PNG

Icons for Google Forms.

```
mogrify -format png -path wide -resize 1200x120 -gravity center -extent 1200x120 svg/*.svg
```



### Google Forms

```sh
for i in 222 333 444 555 333oh clock minx pyram skewb sq1
do
convert svg/$i.svg svg/$i.svg svg/$i.svg svg/$i.svg svg/$i.svg -splice 450x0+0+0 +append -chop 450x0+0+0 -resize 1200x120 -gravity center -extent 1200x120 wide/$i.png
done

for i in 666 777 333bf 444bf 555bf
do
convert svg/$i.svg svg/$i.svg svg/$i.svg -splice 1000x0+0+0 +append -chop 1000x0+0+0 -resize 1200x120 -gravity center -extent 1200x120 wide/$i.png
done

for i in 333fm 333mbf
do
convert svg/$i.svg -splice 1000x0+0+0 +append -chop 1000x0+0+0 -resize 1200x120 -gravity center -extent 1200x120 wide/$i.png
done

convert svg/222.svg svg/333.svg svg/444.svg svg/555.svg svg/666.svg svg/777.svg -splice 300x0+0+0 +append -chop 300x0+0+0 -resize 1200x120 -gravity center -extent 1200x120 wide/zzz.png
```





### Append Images

#### 3x3x3+

```
convert svg/333.svg svg/222.svg svg/333oh.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1000x628 -gravity center -extent 1200x628 png/333+.png
```

```
convert svg/333.svg svg/222.svg svg/333oh.svg svg/minx.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1000x628 -gravity center -extent 1200x628 png/333+.png
```

```
convert svg/333.svg svg/222.svg -splice 200x0+0+0 +append -chop 200x0+0+0 png/333+1.png
convert svg/333oh.svg svg/minx.svg -splice 200x0+0+0 +append -chop 200x0+0+0 png/333+2.png
convert png/333+1.png png/333+2.png -splice 0x200+0+0 -append -chop 0x200+0+0 -bordercolor white -border 100x100 -resize 1000x628 -gravity center -extent 1200x628 png/333+.png
```

#### 4x4x4+

```
convert svg/444.svg svg/555.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1100x628 -gravity center -extent 1200x628 png/444+.png
```

```
convert svg/444.svg svg/555.svg svg/666.svg svg/777.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1100x628 -gravity center -extent 1200x628 png/444+.png
```

```
convert svg/444.svg svg/555.svg svg/666.svg svg/777.svg svg/minx.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1100x628 -gravity center -extent 1200x628 png/444+.png
```

```
convert svg/444.svg svg/555.svg -splice 200x0+0+0 +append -chop 200x0+0+0 png/444+1.png
convert svg/666.svg svg/777.svg -splice 200x0+0+0 +append -chop 200x0+0+0 png/444+2.png
convert png/444+1.png png/444+2.png -splice 0x200+0+0 -append -chop 0x200+0+0 -bordercolor white -border 100x100 -resize 1000x628 -gravity center -extent 1200x628 png/444+.png
```

#### 3BLD+

```
convert svg/333bf.svg svg/444bf.svg svg/555bf.svg -splice 200x0+0+0 +append -chop 200x0+0+0 -resize 1000x628 -gravity center -extent 1200x628 png/333bf+.png
```

```
convert svg/333bf.svg -resize 1200x500 -gravity center -extent 1200x500 png/333bf+1.png
convert svg/444bf.svg svg/555bf.svg -splice 200x0+0+0 +append -chop 200x0+0+0 png/333bf+2.png
convert png/333bf+1.png png/333bf+2.png -splice 0x200+0+0 -append -chop 0x200+0+0 -bordercolor white -border 100x100 -resize 1000x628 -gravity center -extent 1200x628 png/333bf+.png
```


