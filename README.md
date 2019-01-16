# Map Search via Yahoo Local Search API.
Yahoo!ローカルサーチAPIを用いた周辺検索アプリです。

## 準備
### Yahoo!ローカルサーチAPIの有効化
下記のURLを参考に、 `アプリケーションID` を取得してください。
https://developer.yahoo.co.jp/webapi/map/openlocalplatform/v1/localsearch.html

### API Keyのセット
プロジェクト配下に `ApiKey.swift` を作成し、以下のコードを記載してください。 `<アプリケーションID>` には上記で取得した値を設定してください。
```swift
let API_KEY = "<アプリケーションID>"

```

## Yahoo!ローカルサーチAPI
取得結果のサンプルは以下です。
```xml
<?xml version="1.0" encoding="utf-8"?>
<YDF xmlns="http://olp.yahooapis.jp/ydf/1.0" totalResultsReturned="10" totalResultsAvailable="488" firstResultPosition="1">
    <ResultInfo>
        <Count>10</Count>
        <Total>488</Total>
        <Start>1</Start>
        <Status>200</Status>
        <Description></Description>
        <Copyright></Copyright>
        <Latency>0.048</Latency>
    </ResultInfo>
    <Feature>
        <Id>g330031</Id>
        <Gid>KmDXiU7RD2s</Gid>
        <Name>てしごとや ふくの鳥 小伝馬町店</Name>
        <Geometry>
            <Type>point</Type>
            <Coordinates>139.77846019,35.68929796</Coordinates>
        </Geometry>
        <Category>居酒屋,食事処,ラーメン,鳥料理（鶏料理）,焼き鳥,水炊き</Category>
        <Description></Description>
        <Style/>
        <Property>
            <Uid>78f18bf24e35d1915af5a33526f27b834db067d5</Uid>
            <CassetteId>a6e27b84663abc4336dc275c6fb7f978</CassetteId>
            <Yomi>テシゴトヤフクノトリ コデンマチョウテン</Yomi>
            <Country>
                <Code>JP</Code>
                <Name>日本</Name>
            </Country>
            <Address>東京都中央区日本橋大伝馬町1-7 鉄鋼組合ビル1F</Address>
            <GovernmentCode>13102</GovernmentCode>
            <AddressMatchingLevel>6</AddressMatchingLevel>
            <Tel1>03-5643-1508</Tel1>
            <Genre>
                <Code>0110</Code>
                <Name>居酒屋、ビアホール</Name>
            </Genre>
            <Genre>
                <Code>0111001</Code>
                <Name>定食、食堂</Name>
            </Genre>
            <Genre>
                <Code>0106001</Code>
                <Name>ラーメン</Name>
            </Genre>
            <Genre>
                <Code>0101027</Code>
                <Name>鳥料理</Name>
            </Genre>
            <Genre>
                <Code>0101025</Code>
                <Name>焼き鳥</Name>
            </Genre>
            <Genre>
                <Code>0109001</Code>
                <Name>鍋料理</Name>
            </Genre>
            <Station>
                <Id>22681</Id>
                <SubId>2268101</SubId>
                <Name>小伝馬町</Name>
                <Railway>東京メトロ日比谷線</Railway>
                <Exit>3</Exit>
                <ExitId>3969</ExitId>
                <Distance>187</Distance>
                <Time>2</Time>
                <Geometry>
                    <Type>point</Type>
                    <Coordinates>139.778311,35.690479</Coordinates>
                </Geometry>
            </Station>
            <Station>
                <Id>22989</Id>
                <SubId>2298901</SubId>
                <Name>三越前</Name>
                <Railway>東京メトロ銀座線</Railway>
                <Exit>新日本橋駅5(北側)</Exit>
                <ExitId>5227</ExitId>
                <Distance>382</Distance>
                <Time>4</Time>
                <Geometry>
                    <Type>point</Type>
                    <Coordinates>139.775627,35.689184</Coordinates>
                </Geometry>
            </Station>
            <Station>
                <Id>22750</Id>
                <SubId>2275001</SubId>
                <Name>新日本橋</Name>
                <Railway>JR在来線</Railway>
                <Exit>5</Exit>
                <ExitId>4323</ExitId>
                <Distance>398</Distance>
                <Time>4</Time>
                <Geometry>
                    <Type>point</Type>
                    <Coordinates>139.775710,35.689014</Coordinates>
                </Geometry>
            </Station>
            <LeadImage>https://uds.gnst.jp/rest/img/k8gstn9j0000/s_0npq.jpg</LeadImage>
            <ParkingFlag>false</ParkingFlag>
            <CouponFlag>true</CouponFlag>
            <SmartPhoneCouponFlag>true</SmartPhoneCouponFlag>
            <Coupon>
                <Name>【土曜日宴会３大特典付き】飲み放題グレードアップ＆延長＆５００円オフ！</Name>
                <PcUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=870&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</PcUrl>
                <MobileFlag>true</MobileFlag>
                <SmartPhoneUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=869&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</SmartPhoneUrl>
                <MobileUrl>https://mobile.gnavi.co.jp/shop/g330031/coupon/</MobileUrl>
            </Coupon>
            <Coupon>
                <Name>宴会お料理×人数分　５００円ＯＦＦ</Name>
                <PcUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=870&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</PcUrl>
                <MobileFlag>true</MobileFlag>
                <SmartPhoneUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=869&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</SmartPhoneUrl>
                <MobileUrl>https://mobile.gnavi.co.jp/shop/g330031/coupon/</MobileUrl>
            </Coupon>
            <Coupon>
                <Name>宴会コース以外なら5％オフ</Name>
                <PcUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=870&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</PcUrl>
                <MobileFlag>true</MobileFlag>
                <SmartPhoneUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=869&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</SmartPhoneUrl>
                <MobileUrl>https://mobile.gnavi.co.jp/shop/g330031/coupon/</MobileUrl>
            </Coupon>
            <Coupon>
                <Name>獺祭含む日本酒＆焼酎各５種類がつくグレードUP飲み放題</Name>
                <PcUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=870&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</PcUrl>
                <MobileFlag>true</MobileFlag>
                <SmartPhoneUrl>https://gaff.gurunavi.jp/track/gc.php?ga_bid=869&amp;ga_pid=1713&amp;ga_red=https://r.gnavi.co.jp/g330031/coupon/</SmartPhoneUrl>
                <MobileUrl>https://mobile.gnavi.co.jp/shop/g330031/coupon/</MobileUrl>
            </Coupon>
            <KeepCount>1</KeepCount>
        </Property>
    </Feature>
    <Feature>
        ...(検索結果の分だけある)
    </Feature>
</YDF>
```