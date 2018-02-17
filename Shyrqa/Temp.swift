
//FORGOT 1 BRACKET '}'

//                            if text.range(of: "by OlzhasOmar") != nil {
//
//                                let textArr = text.components(separatedBy: "by OlzhasOmar")
//                                var title = textArr[0]
//                                var lyrics = textArr[1]
//
//                                title = title.replacingOccurrences(of: "\t", with: "")
//                                title = title.replacingOccurrences(of: "\n", with: "")
//
//                                var i = 1
//                                for uni in lyrics.unicodeScalars {
//                                    let val = uni.value
//                                    if (val >= 65 && val <= 90) || (val >= 97 && val <= 122) {
//                                        break
//                                    }
//                                    i += 1
//                                }
//                                let index2 = lyrics.index(lyrics.startIndex, offsetBy: i-1)
//                                lyrics = lyrics.substring(from: index2)
//
//                                if title.range(of: "(аккорды)") != nil{
//                                    title = title.replacingOccurrences(of: "(аккорды)", with: "")
//                                }
//
//                                //TO DO: Make a loop
//                                if lyrics.range(of: "— kazchords.kz") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "— kazchords.kz", with: "")
//                                }
//
//                                if lyrics.range(of: "kazchords.kz аккорды казахстанских песен") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "kazchords.kz аккорды казахстанских песен", with: "")
//                                }
//
//                                if lyrics.range(of: "By Aset Bekenov)") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "By Aset Bekenov)", with: "")
//                                }
//
//                                //                                <small>[]</small>
//                                if lyrics.range(of: "http://kazchords.kz — аккорды и тексты казахстанских песен") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "http://kazchords.kz — аккорды и тексты казахстанских песен", with: "")
//                                }
//
//                                if lyrics.range(of: "[kazchords.kz — аккорды казахстанских песен]") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "[kazchords.kz — аккорды казахстанских песен]", with: "")
//                                }
//
//                                if lyrics.range(of: "<small>[]</small>") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "<small>[]</small>", with: "")
//                                }
//
//                                if lyrics.range(of: "[]") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "[]", with: "")
//                                }
//
//                                if lyrics.range(of: "[kazchords.kz]") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "[kazchords.kz]", with: "")
//                                }
//
//                                if lyrics.range(of: "[рахат турлыханов, аккуым, акку]") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "[рахат турлыханов, аккуым, акку]", with: "")
//                                }
//
//                                if lyrics.range(of: "[домажор, до мажор, кайдасын]") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "[домажор, до мажор, кайдасын]", with: "")
//                                }
//
//                                if lyrics.range(of: "http://a1.mynur.kz/download/a/ij/zc/uv/et/ijzcuvet/name/Array+-+%D0%9A%D0%B0%D0%B9%D0%B4%D0%B0%D1%81%D1%8B%D0%BD%28music.nur.kz%29.mp3") != nil{
//                                    lyrics = lyrics.replacingOccurrences(of: "http://a1.mynur.kz/download/a/ij/zc/uv/et/ijzcuvet/name/Array+-+%D0%9A%D0%B0%D0%B9%D0%B4%D0%B0%D1%81%D1%8B%D0%BD%28music.nur.kz%29.mp3", with: "")
//                                }

